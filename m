Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048544;
	b=UP5YWx2cUrufYC1BjdaJAQkQSOzAY8su9UGtBTwEQKqc68ftkxkIUH7/aGR0N3K8uX7v
	 owk62UT7LSFeNybxc5txRXpyl3FGON4QACueNQwwxb8N6PQKFQK4Sm3MagB0INtZ072J6
	 qMvg+zzFp/TwT2pu48QTDVR0lvPP0Cij4tWz+Jna4M1g29MlVgFDO5ejyooX5ryGs3eLW
	 ucr4wtkT4mdzftQQ46X3KnwJgsE3HocGPJekGJ28NXA3dv7JkeVn3ciKsBaPDk48tQCQV
	 +uE/12UEJ5ONh5BK85GaeSXD4O4i0pS5AFbNB5Th7gvY5HsU0JYYNFslwUPJsD9zDZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/nZJzZzZULdXRRn96xyosswiinKqvkEREM/RwDQjYWQ=;
	b=mxlKT+S+YZmyPiGUCsrw1GxFHYHCkD+D6JisPiVtwTJ3XIT5Jff4fY5tgi56cOkUGUXD
	 eAF3BSluggIZvUFa/FD3CEz+PaceTLYQI9eu2fbYzU/AEcDSHJQtmY38F8C4LcDnF3Bfc
	 ymT39/csLPmJ9pkGz0CkaRm4+AaaOgDhIGCasVRNZON7/S3EXDqrvA5oCY25bp2We2MLC
	 HM31JJ6JucQoghQ9byBAIN4nw+zOxnd96e0356sQHb1rb8GmfEv+mwVa+a0s4do7kG6MS
	 FKPU4EW4aHE/a9VO5lrOBFBV3DWOZm1YBi8jDuQEhdjfVJkM+sWKH4phwpnbLw9VZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJAyKQcr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJAyKQcr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701331F0089F;
	Sat,  7 Nov 2026 10:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048543;
	bh=/nZJzZzZULdXRRn96xyosswiinKqvkEREM/RwDQjYWQ=;
	h=From:To:Cc:Subject:Date;
	b=VJAyKQcrWG76W6MbpKxiuQEGAKkbeuZ4g+O9TGi77nWIU0NgAe7+n+KwrAmVFjCo8
	 y3EAIi/9LYpG9HoiiPfHg+PWGr1gsZLO7sCfydvUAV60T7oKfZbMo6W9oeT5xzVgEH
	 MlqQ5p5w1jbv9lO5SPFMzzmi3ZKaxnUQsBnnthk+zeXOFP1P6zaWpRCwcGNYrOApfs
	 wC3NHq6pxanzy9UlsGkA8MNXL8Z6pmoC4i6YEVq20rVqXmBUdxyzytxCoX7Ou+y2db
	 n2MtITmdSBg2TsoSs+i0r3Fd8NhPO9AP2S8K9aLQwopJUTGC6l9HcfVgvQgMpaYSGT
	 stfeZJ8BL75dw==
From: Sasha Levin <sashal@kernel.org>
To: francesco.orlando99@libero.it,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Input: xpad - add GameSir Nova Lite support" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:02 -0500
Message-ID: <20261107054902-failed-6.1-2e6f2e5799f3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2e6f2e5799f328ca0879dad14d7f3709c7f7496b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054902-failed-6.1-2e6f2e5799f3@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2e6f2e5799f328ca0879dad14d7f3709c7f7496b Mon Sep 17 00:00:00 2001
From: Francesco Orlando <francesco.orlando99@libero.it>
Date: Sun, 11 Oct 2026 18:58:21 +0200
Subject: [PATCH] Input: xpad - add GameSir Nova Lite support

Add vendor and product ID for GameSir Nova Lite (0x3537:0x1040) in
XInput mode to enable force feedback rumble support.

Signed-off-by: Francesco Orlando <francesco.orlando99@libero.it>
Link: https://patch.msgid.link/20261011165821.72698-1-francesco.orlando99@libero.it
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 810e52782ae89..d2eb48d98fead 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -408,6 +408,7 @@ static const struct xpad_device {
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
+	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
 	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
-- 
2.53.0




