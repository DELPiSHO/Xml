<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" omit-xml-declaration="yes"/>

<xsl:template match="/">
	<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
	<html lang="pl">
		<head>
			<meta charset="utf-8"/>
			<title>
				Hotel
			</title>
			<style>
				div {
					width: 100%;
					border-style: ridge;
				}
				.obliczenia {
					color: green;
				}
				.osoby {
					color: blue;
				}
				.pokoje {
					color: red;
				}
				img {
					float: right;
				}
			</style>
		</head>
		<body>
			<xsl:for-each select="/hotel/osoby/osoba">
				<xsl:sort select="nazwisko"/>
				<div>
					<xsl:variable name="idOsobyVar" select="id"/>
					
					<p class="osoby">Osoba nr <xsl:value-of select="$idOsobyVar"/>.
					<img>
						<xsl:attribute name="src">
							<xsl:value-of select="@zdjecie"/>
						</xsl:attribute>
						<xsl:attribute name="alt">
							<xsl:value-of select="id"/>
						</xsl:attribute>
					</img>
					</p>
					
					<span class="osoby">Imię: <xsl:value-of select="imie"/><br/></span>
					<span class="osoby">Nazwisko: <xsl:value-of select="nazwisko"/><br/></span>
					<span class="osoby">Data urodzenia: <xsl:value-of select="dataUrodzenia"/><br/></span>
					<!--
					<xsl:variable name="dataUrVar" select="dataUr"/>
					<xsl:variable name="currentDate" select="current-date()"/>
					<span class="osoby">Wiek: <xsl:value-of select="$currentDate - xs:date($dataUr)"/><br/></span>
					-->
					<span class="osoby">Pesel: <xsl:value-of select="pesel"/><br/></span>
					<xsl:variable name="emailVar" select="email"/>
					<span class="osoby">Email: <a href="mailto:{$emailVar}"><xsl:value-of select="$emailVar"/></a><br/></span>
					
					<p class="obliczenia">Łącznie <xsl:value-of select="count(/hotel/wypozyczenia/wypozyczenie[@idOsoby=$idOsobyVar])"/> wynajmów</p>
					
					<xsl:for-each select="/hotel/wypozyczenia/wypozyczenie">
						<xsl:if test="@idOsoby=$idOsobyVar">
							<xsl:variable name="nrPokojuVar" select="@nrPokoju"/>
							<span class="osoby">Pokój nr <xsl:value-of select="$nrPokojuVar"/>.<br/></span>
							
							<xsl:for-each select="/hotel/pokoje/pokoj">
									<xsl:if test="@nr=$nrPokojuVar">
										<span class="pokoje"><xsl:value-of select="rodzaj"/><br/></span>
										<span class="obliczenia">Zawiera <xsl:value-of select="count(/hotel/pokoje/pokoj[@nr=$nrPokojuVar]/wyposazenie)"/> wyposażenia:<br/></span>
										<xsl:for-each select="/hotel/pokoje/pokoj[@nr=$nrPokojuVar]/wyposazenie">
											<span class="pokoje"><xsl:value-of select="."/><br/></span>
										</xsl:for-each>
									</xsl:if>
							</xsl:for-each>
							
							<xsl:if test="dataZameldowania"><span class="osoby">Data Zameldowania: <xsl:value-of select="dataZameldowania"/><br/></span></xsl:if>
							<xsl:if test="dataWymeldowania"><span class="osoby">data Wymeldowania: <xsl:value-of select="dataWymeldowania"/><br/></span></xsl:if>
							<span class="osoby">Opłata: <xsl:value-of select="cena"/> PLN<br/><br/></span>
						</xsl:if>
					</xsl:for-each>
					<span class="obliczenia">Suma opłat: <xsl:value-of select="sum(/hotel/wypozyczenia/wypozyczenie[@idOsoby=$idOsobyVar]/cena)"/> PLN<br/><br/></span>
				</div>
			</xsl:for-each>			
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
