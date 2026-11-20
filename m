Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197272;
	b=Au/TPXIHI/JXrDJtjF7JCtpcoWP3oLtun45iBESn1e1WrcdrE6N71I1b4qwZoTUhB+N1
	 NnIshzkWi5NHHh7mzzBDZft4OM98UYBOg2W9o3fwuMHYxr+BkAuu4MQgHi9l7DQQhcPxo
	 0aV1PcZRiufTgFSgO6hXKfikw2bijO7W1qUMPCDiqffjYur1K50E1JjxEWXHZNu3Uzu8R
	 8Hx4ARHPNzM4OCEHNgU3PfzvoAzX8UPdNJU6VmKuYWTAz1StTB766SxMaxyHCwD3VK8+X
	 9Q+X4zm00riMbE5/yeXHc9MXAqs8GAl7q6XNMRaEtEWzB+40XBm045tNEht9NY20GSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197272;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=sHrVwm9Y2azO/qyG5D6lAPdfzBKPrr7WTaybCanFFQA=;
	b=r2+BWTFb3AQdYsDo6v+U6UbfjqLp1c5Xq6+Lnelqcct2PHaNWIb0RK0CBl0KMaylT8dq
	 X2E+lufiL5/ANTMFS/V/FU5K3qXYT4sQYpq41SSC/4XzLgsx8FHQR0osNy52Tii3DQzx1
	 O9msz/QB7FA46yEyuId/qi6uddgYb5oxbAFKDTO9eWp3QygoUo6iL2/fTMjXLRim39jgt
	 OrNUHM7gYKmVbXXJE/M4yZ/zZZQX9ju8Q0BLfKaUFLJjTx7c8pwxDmLOAdltT+YWtobW+
	 9qJm/rgi0zsEJ/n3nsRvkY/eQF4rVOLr1RMgvAOACakKsIoENXTOhJocna3u93gJtdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=RyOiIGoj;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC060A3825
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24AC060A3825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=RyOiIGoj
DKIM2-Signature:  i=1; m=1; t=1795197268;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:PleLYc8NUwf7y36ozlxKqupHT3Cb
   oN2CdUK7MhupcPCiBH2q2n+ksr+TrCtThqs/mvHMFJLNYny9+uEgxhwS5tXy0tLgSYKZLYpZwle
   m66Hjfd0KRoJMofteO/3dk6omspXuG3Teay2SkNk3LPXRhW8cmLfCcCGkzTffb4vfDi60Ds+49K
   UYvPjYmt7DjYRUtNgszrAXqcYpCIXkGeRvRJ3u9gE8B/4HrctkDzgWeG4Nem39w9WKC7NVzVECS
   dz/nLiMQqUB6PPLRBqtLDokhrnYLiIMN2MDQmHeTS//AxSJAiFNBgvpWVKWVpEXfoErz/P7DlBa
   FrqHseQEXp1QpA==;
Message-Instance:  m=1;
 h=sha256:
   EYQLEEDq46wAcosuHPgHvTh1urvAe7EMG7PGoiM0rpk=:
   kb8i/WGJzIOgpop7YMTG5VRycG6NnfUl/YmjrQVPuwM=,
  sha512:
   46jSujwWgPNB6xP0YCpIwhg9Hiy4NW9u/8sXTShU5OfUVEn4EI2mP3y/IdAl0LyPoKa+/PNCW17wFrxyYI0nzw==:
   B9QlnLeAEJlgeLcGds4La6YapwYA3jD6puOBUk9RPE8W+8t5b5+5sgNUW0VJ4NAUZadt7vP9WBuJBYOg+xEY0A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795197254; x=1795802054; i=deller@gmx.de;
	bh=sHrVwm9Y2azO/qyG5D6lAPdfzBKPrr7WTaybCanFFQA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RyOiIGojNFj6sTXZ7SRTpVmzkbd0aKM7t3h7N/ls9NkBFXR45dnUW/kFGYq3q2Z8
	 p5AFzzyJtljr2DMIHcma6/g4oiu6IapQt1J47P+RqffOQzncILINwjyyclzHaHfm9
	 +q/nmBNny1Opj4XplAYnAriauNkgjPk1cDBVgnrRBt3BAoSWzWqPSWkiuzdtyhkvJ
	 wFyneReLPE9OVDUTePvKCkAvrW0v+WbFuJFs69JXR0TShFGXUxm5HngYqy1mDnWDD
	 cfG/VthOvrWmS5kOcewMmHgLY5/Qar/L5rFYuhLfKslPRcFWN5VUnlHl5kAKb/txL
	 sKqY8qcpXxwOjVwutg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1xoK342CHA-00LPdW; Fri, 20
 Nov 2026 18:54:14 +0100
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Henri Roosen <henri.roosen@ginzinger.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] fbcon: Don't drop last logo line if logo is same size as screen
Date: Fri, 20 Nov 2026 18:54:13 +0100
Message-ID: <20261120175413.176249-2-deller@gmx.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120175413.176249-1-deller@gmx.de>
References: <20261120175413.176249-1-deller@gmx.de>
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
X-Provags-ID: V03:K1:uZpN/SJ9/o+U8cPP0zJjCorPn+bxWK8Psv5ciIwhdsCGzxILXKf
 rnUtqfDEgreSL0lnqCE4QWnAtsEatH+Ip1egkk74GvKxP53z1KeNS2dH/+RTC8gRdEt4lRM
 apY6tysMpuIHATQD2MgaRQ5e7XGl02CgyCLsDPQZI7cm1Knhto0I9aKybvAsKvKNZtK86vk
 ujGnk4oyyIHoX9eMnYEWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2CRPWB0ohTk=;K2cat+do9kRmwXN1QElxoox4TES
 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
 2GxBAAiRscqgYA+wpA==

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
 drivers/video/fbdev/core/fbcon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/f=
bcon.c
index d7890e119dc7..cc311dc0e2e4 100644
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
@@ -734,7 +734,9 @@ static void fbcon_prepare_logo(struct vc_data *vc, str=
uct fb_info *info,
 		pr_info("fbcon: disable boot-logo (boot-logo bigger than screen).\n");
 	} else {
 		logo_shown =3D FBCON_LOGO_DRAW;
-		vc->vc_top =3D logo_lines;
+		/* keep vc_top if logo covers whole screen */
+		if (logo_lines < vc->vc_bottom)
+			vc->vc_top =3D logo_lines;
 	}
 }
 #endif /* MODULE */
=2D-=20
2.56.1

