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
					width: 30%;
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
					<span class="osoby">Data urodzenia: <xsl:value-of select="dataUr"/><br/></span>
					<!--
					<xsl:variable name="dataUrVar" select="dataUr"/>
					<xsl:variable name="currentDate" select="current-date()"/>
					<span class="osoby">Wiek: <xsl:value-of select="$currentDate - xs:date($dataUr)"/><br/></span>
					-->
					<span class="osoby">Nr telefonu: <xsl:value-of select="nrTel"/><br/></span>
					<xsl:variable name="emailVar" select="email"/>
					<span class="osoby">Email: <a href="mailto:{$emailVar}"><xsl:value-of select="$emailVar"/></a><br/></span>
					
					<p class="obliczenia">Łącznie <xsl:value-of select="count(/hotel/wynajmy/wynajem[@idOsoby=$idOsobyVar])"/> wynajmów</p>
					
					<xsl:for-each select="/hotel/wynajmy/wynajem">
						<xsl:if test="@idOsoby=$idOsobyVar">
							<xsl:variable name="nrPokojuVar" select="@nrPokoju"/>
							<span class="osoby">Pokój nr <xsl:value-of select="$nrPokojuVar"/>.<br/></span>
							
							<xsl:for-each select="/hotel/pokoje/pokoj">
									<xsl:if test="@nr=$nrPokojuVar">
										<span class="pokoje"><xsl:value-of select="iluOsob"/>- osobowy<br/></span>
										<span class="obliczenia">Zawiera <xsl:value-of select="count(/hotel/pokoje/pokoj[@nr=$nrPokojuVar]/wyposazenie)"/> wyposażenia:<br/></span>
										<xsl:for-each select="/hotel/pokoje/pokoj[@nr=$nrPokojuVar]/wyposazenie">
											<span class="pokoje"><xsl:value-of select="."/><br/></span>
										</xsl:for-each>
									</xsl:if>
							</xsl:for-each>
							
							<xsl:if test="poczNajmu"><span class="osoby">Pocz. najmu: <xsl:value-of select="poczNajmu"/><br/></span></xsl:if>
							<xsl:if test="konNajmu"><span class="osoby">Kon. najmu: <xsl:value-of select="konNajmu"/><br/></span></xsl:if>
							<xsl:if test="czasNajmu"><span class="osoby">Czas najmu: <xsl:value-of select="czasNajmu"/><br/></span></xsl:if>
							<span class="osoby">Opłata: <xsl:value-of select="oplata"/> PLN<br/><br/></span>
						</xsl:if>
					</xsl:for-each>
					<span class="obliczenia">Suma opłat: <xsl:value-of select="sum(/hotel/wynajmy/wynajem[@idOsoby=$idOsobyVar]/oplata)"/> PLN<br/><br/></span>
					
				</div>
			</xsl:for-each>
			
		</body>
	</html>
</xsl:template>
</xsl:stylesheet>
