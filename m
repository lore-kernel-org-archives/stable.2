Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092593;
	b=UbjgmeoArfNFIvoNH727bFfrAPdDAOBfREJnM/XvOf6clQ1DDY92n7k/459+uASX1yfZ
	 wmVLZhzne8vLr9F1h1CobbH1zeyLlcpdwUUn64vV1htrPgAsNNI6FpN0aV5N8CO+mu6Qp
	 x034kNpcmpoUTbxDuWJguR28sjWPJd7xxttYtyF+95FM0la7OuXfoJWoHX/QLm9ZsDy6X
	 +r7qZ2XuLEfr/EB+h335NWe5cDn2CIUvUA3vEhQyhlV/w3p+yfM6ZgqPSsFBt3HUVpRPM
	 cz2r1IhGmIMYvYo5kpPdJndeXDc2AMrt+xPQdSH/Wr3OpiIjkyeX93ITnzKZToniDvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092593;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=hR7WX1WCsP9AdnYoN9gEf8KxLkfKxP/TDzCzXczl2kc=;
	b=e+EjKHASRKjY12/LdEYCpJ7Zvwsnu5Ro/wCUZUC3wAFosjMAN14i4WC+nJsceCYQmlME
	 HmxbkkdbJiR7dr6iQ9E/gRcBdUOVLAkdQ35AXl1GiLnQndnEnNa5/XVl+HyZO8rMKJFYP
	 m0aYb2TZFMv1Ey4dKPg9VX8dkkECldn+yTmZ4tc59OCAWQTE9IHkooH2vVfELSAWdokag
	 dMUV4XX+yds6PSji2EfdyG61khOCg8za+yWvGJqSPg4C5drvje6ojBRvOEzyqJziVTlfC
	 SdBpvYbnu6DQvgwPvktG1XuCVHmZe2YuGhZaLkB2JaKdtZRtc/pdN7l5yn7TyW7o2nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Ts3IlBtM;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABD60A2613
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17ABD60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Ts3IlBtM
DKIM2-Signature:  i=1; m=1; t=1795092590;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:fIxpmr6BIg0WwITmW6Muoma0XcIE
   fYbsEn1trCU59AukiuAYP0MkOyLYtEvdJhmThRx3a5a9WhsQBe8B5xk2wBNlnCXM8mthW1vLv2Y
   RoKnFZIkhvW+3PZcRQZoKbQTnkYqJ8qcjV3p6Dg9wyRuFV4Is+fdaEgnNFoOBd/Nu4IpGtkjGZ6
   afoS9d/V9sKI+G2vJ5exy4c0dYkisu+8Y7iGdASVOWT7d9IvqHsbPtgYvq1/UOY/0li4KwQg6FP
   m9FR0FBlf6A46a6j7p22aNiMMZovgtrsdQY4rCEZzMWzhKJIz1G4xkovU114J+w5+fNIKXo36Pk
   Jr2Wc9PX3q7NZQ==;
Message-Instance:  m=1;
 h=sha256:
   hHwjMmdkNgVjamU/nQNkQictzFO2WLtdrWHts1RWr6w=:
   KN453RR/FDkclWDzFUd3bt51CmHoyqNLKr55Yov9R1A=,
  sha512:
   YUESlGZOGBF6wSYWRSC6aQoMCCod6pJPje4NkRH9lBZiXNBzAmnzP/D3TQ+wLQ6gNhvPJVTY1CHlXZ0Jogv1QA==:
   YBJN5AQG7lJ5SggVZYND0RQzj/zHSQ/NeliXapES8/iEqbYmbdAveGjGCI9PEdX3Ph9nrmxzAQq8yM9k72OQnA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795092586; x=1795697386; i=deller@gmx.de;
	bh=hR7WX1WCsP9AdnYoN9gEf8KxLkfKxP/TDzCzXczl2kc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ts3IlBtMG8D51fZbdJ7FB1OyGBp/rUd/vudesSTGezIbc/Hf9HH0DUwAyaEh3sm7
	 fA1yyZhDojI2RYua4ijZeGtl2abUQms2fzvSVxJ7Ophb6k+UY4ZNHLlDhahw6XNaV
	 H0MuOfg/OLXYg3lRag9bp9f3o3dqJfvGG2BxbN2TXmEsMEssht2bnmvYHckVm5REh
	 NcwqR/zteaaZrjS71t9scPf5H2CELc6tmUetKyJUbalGaD+2kLqjCKXqfwuRZYt4z
	 xjNhLoutZVfF0Zz2wpu7r3SOot7HSSp6ETMGo6AlHqMvOZ2ESHuDmZTQvEmb46u6z
	 Iohf1hylkMKdKB7c7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1wVJn41CZw-00r3TE; Thu, 19
 Nov 2026 13:49:46 +0100
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Henri Roosen <henri.roosen@ginzinger.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbcon: Don't drop last logo line if logo is same size as screen
Date: Thu, 19 Nov 2026 13:49:44 +0100
Message-ID: <20261119124944.98882-1-deller@gmx.de>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6h7MH1qEm+kfMJseR8Y8Z5lMjbCc5FUKMZDobx64aD1B12q4SDh
 34y9+BZ8/DVSBYGI0hViJ+pyPRPmjiKoIEWkjs1xjHJYj/cR05b+gPL4vl+m8iyca1O4guL
 iEy0Ib/Jxv6pUFIdFzWAKHhh1NhF66PPh6IM6w0FM+jtbTckYXp7JGPGl1wsRud7Kv5Nf8k
 RedXwoltsfy1ln8qmBk/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/UxSAjySOPk=;RjAmH8zuZ1oP2FUHkdkjqeWxhng
 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
 dkmb/ShOQ==

Henri reported a regression that when a custom bootlogo is exactly as
big as the screen, a white bar with the size of the font height is
displayed at the bottom of the display.  Fix this off-by-one bug.

Fixes: 94e6a058b168 ("fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_pr=
epare_logo")
Tested-by: Henri Roosen <henri.roosen@ginzinger.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v7.3+
=2D--
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index d7890e119dc7..2809c7a6893f 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -666,7 +666,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, str=
uct fb_info *info,
 	logo_height =3D fb_prepare_logo(info, par->rotate);
 	logo_lines =3D DIV_ROUND_UP(logo_height, vc->vc_font.height);
 	logo_lines =3D min(logo_lines, rows);
-	logo_lines =3D min(logo_lines, new_rows - 1);
+	logo_lines =3D min(logo_lines, new_rows);
 	if (logo_lines <=3D 0) {
 		logo_lines =3D 0;
 		logo_shown =3D FBCON_LOGO_DONTSHOW;
=2D-=20
2.56.1

