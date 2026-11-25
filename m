Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639734;
	b=MBpRIp/pe4AAg4SKO1cZOsYLDmUjmwuJsUXKo/S8utjjaLVwt88Nwl3vUQVvrRbkFAbg
	 PoRR6TuHn7lpbHfcbe0Sx46lqO+hNzDpM5LbsuBpkzs4eK+jnzw5hFwSHcUVLBId8ojhI
	 7bS8GAlcaKh2apH1ZJ2pLLOI3Nqvwy+UW8ZIUzGSCxSShhs+Ro3YrAPt6gL4moZbkM1gG
	 0YjsOb06fmJo0rLWbdYG9vgefMMXFhHINtek3mUUu5mXW0IVygbpcrgnsTddE2mKrGKSL
	 4tHFZavSNmsG9Pn9tKrLzYWQzoBslmhdqlhtgVfWHnHh+KLl7v8yYcldgVnNCTwL64g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639734;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=3V22Rka05JRyQmbkCxEbw3iRiBhwSkjd9Y5mOZPd8Rw=;
	b=1simkXi3f7Q4HgeHe9xKYvTnBtufOzjLMEpR/YjyGq9K43nglbNKyK/0AuNFQbdCWVsd
	 NjTKK6LnQ2DzEudZP+Efsf8T8w7iEjd2RerLW//7FjGycgoyjT955TLw3exIa7R16AgQ0
	 WAkmSepflIVG+7eUvHnDkJi9rh/2S3MGX4q0RorGjENXBFB3a5wr6svr8/TFHNYuBHu2u
	 OKe2hgMnuEerOY601MPUBlo7RyknOMARhLumON/gF/abwM0TYN3HDNW/EJUQZTTbP+/my
	 qMJkf6z64Ng+WhRVigi3QouKMrPIQLk7e5JB6MPFvthjUMhk280WgJr3JHSDnTrGCRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=sUmq6dl1;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B1606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B18B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=sUmq6dl1
DKIM2-Signature:  i=1; m=1; t=1795639731;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:FOjSys2FOBWTNUYqAT3JvHMxgeI5
   twF0Nj6eQb6vYw6FXVjvensoqG2urwr8KIpNGlEU5Rndafd1ODi4tbA838kCS4SFdzCf2Qd6rY+
   VW1BMZ6gCEFDFv5keUCPaPYnwz7s3K6/nFLXXpeqxPoHs3CdK7sxgoLxw8uOFkWb/mJ4Wmi0uT7
   07NHbyjq/aAFrnvEWw2Pp/qcp+j8WdBqUSigILjn+8VDTGjbbfJoON6DkxEEIlOgKAL4hNOqUQA
   BeXb0r0OlsQ1OdIS3Dzl3xzCEyaQi4/3cJKXBUitVUhd38FRuExH8o5cQ82VKFJ2+UcN0BSW0yw
   qt2pYNUu+Ngzvw==;
Message-Instance:  m=1;
 h=sha256:
   YQwV4hS63A4e+FmQAgbN9g2PUQHon6K8A0DFOBVeQ/g=:
   dQ5wJvEKqTEvtob4uUg9oPWE5et33aHIAyNbWNuyy3M=,
  sha512:
   vk1/TKZfwC2ivAtO4iDGT6S5V72wA3GR05GYbai9fxjzkgd2qErsWQ4QA5Pei312zjA2Mih1Ft3OZbjh4VeKKQ==:
   suRF90xfShImYJvXcN3/cN1vr4sKLtudx5uMuTsAfA8uLuQA8p80Sjg476Eb+NQLATx4mjw0Q8d0bOpjUPV63w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795639728; x=1796244528; i=deller@gmx.de;
	bh=3V22Rka05JRyQmbkCxEbw3iRiBhwSkjd9Y5mOZPd8Rw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sUmq6dl1qahkx2vi5iqfNhlo/zLcpgiSrks71svetIcmez83dZIdQpGUArFCOQwc
	 zLT07jHzGlynhdoKBhMHNG/WQdenNUGkU+qPO/eyt+egGM2NJwIygBJrdRRactwly
	 1Oko6AKlgNA/UVVBs3L1bc2ZfjgR4mcCtlS3qKWdwZdPnO+Fjehi6trZ34I9t5RFb
	 lZ+L59w0MDZxna3X6Kgd3BkyBIOOkO1X1cun+Lwb4F5EhymImh/R/NAkAI2mzeZgq
	 Hlz3T10Q+VWifhY4E9E42pJU4K7JAuWfLhFESIRX6uIwlESGh/eczhVw284nNJlBU
	 Q0MndxBZywqx/8XSeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1xUwsP0Cij-00H24i; Wed, 25
 Nov 2026 21:48:48 +0100
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Henri Roosen <henri.roosen@ginzinger.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] fbcon: Don't drop last logo line if logo is same size as screen
Date: Wed, 25 Nov 2026 21:48:15 +0100
Message-ID: <20261125204846.428877-1-deller@gmx.de>
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
X-Provags-ID: V03:K1:7wglXJzBxt1S24eOMLedK1Z8XZNczt3Uex5L4SvO0khL26IDGo0
 sxZfb9gjhG+i6URjYjPLwetnjHXOObODdrlGBk8J71Fx8mNKe0zPV3YX3jxhbP4/87xYi5a
 3ezSYz1OKU9gJ7YtIu39Xz5uloTYFHa/BiACcUjM/qp0YDE0+oL3ZwoNJrp3PgfPm00H4+A
 /vYCWopueyf04b5sOaOTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:unsOaRR7z94=;k5BIbfXZPGJa8Y/Y6XNh/Wb0Nim
 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

Henri reported a regression that when a custom bootlogo is exactly as
big as the screen, a white bar with the size of the font height is
displayed at the bottom of the display.

This patch fixes this off-by-one bug, but now -as sashiko-bot noticed-
since the logo covers the whole screen there is no area left in which
the text can be scrolled. To avoid accesses outside the screen memory
simply keep the text area covering the full screen (and possibly
overwriting) the full-screen logo.

Fixes: 94e6a058b168 ("fbcon: Fix KASAN slab-out-of-bounds Read in fbcon_pr=
epare_logo")
Tested-by: Henri Roosen <henri.roosen@ginzinger.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v7.3+
=2D--
 drivers/video/fbdev/core/fbcon.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index c632a3c82e16..4f51f6262eac 100644
=2D-- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -665,13 +665,15 @@ static void fbcon_prepare_logo(struct vc_data *vc, s=
truct fb_info *info,
 		erase &=3D ~0x400;
 	logo_height =3D fb_prepare_logo(info, par->rotate);
 	logo_lines =3D DIV_ROUND_UP(logo_height, vc->vc_font.height);
-	logo_lines =3D min(logo_lines, rows);
-	logo_lines =3D min(logo_lines, new_rows - 1);
+	logo_lines =3D min(logo_lines, new_rows);
 	if (logo_lines <=3D 0) {
 		logo_lines =3D 0;
 		logo_shown =3D FBCON_LOGO_DONTSHOW;
 		return;
 	}
+	if (logo_lines >=3D vc->vc_bottom)
+		goto logo_fullscreen;
+
 	q =3D (unsigned short *) (vc->vc_origin +
 				vc->vc_size_row * rows);
 	step =3D logo_lines * cols;
@@ -729,12 +731,17 @@ static void fbcon_prepare_logo(struct vc_data *vc, s=
truct fb_info *info,
 	if (logo_shown =3D=3D FBCON_LOGO_DONTSHOW)
 		return;
=20
+logo_fullscreen:
 	if (logo_lines > vc->vc_bottom) {
 		logo_shown =3D FBCON_LOGO_CANSHOW;
 		pr_info("fbcon: disable boot-logo (boot-logo bigger than screen).\n");
 	} else {
 		logo_shown =3D FBCON_LOGO_DRAW;
-		vc->vc_top =3D logo_lines;
+		/* keep vc_top if logo covers whole screen */
+		if (logo_lines < vc->vc_bottom)
+			vc->vc_top =3D logo_lines;
+		else
+			vc->vc_top =3D 0;
 	}
 }
 #endif /* MODULE */
@@ -2270,7 +2277,9 @@ static bool fbcon_switch(struct vc_data *vc)
=20
 		logo_shown =3D fg_console;
 		fb_show_logo(info, par->rotate);
-		update_region(vc,
+		/* avoid screen update on full screen sized logo */
+		if (vc->vc_top)
+			update_region(vc,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
 						 vc->vc_top) / 2);
=2D-=20
2.56.1

