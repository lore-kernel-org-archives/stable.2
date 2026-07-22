Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010340BCC1;
	Wed, 22 Jul 2026 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.113.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695520; cv=none; b=ZVuI8uIDdhPOCMoeD+DrZ/Ja6eWXHA+vLf4/YcB8eXNJMUixj+0SIiJfswjjdSOU3Cdgb5j7PeJQNDHidfl7zFzsxdo4KrjViDWrHY3i0XRcdnH668Z9KbD5DbH8jtpvnYpfwWtKpCxrwmz24ZTulO+pZpB+w0ZWBb79ia/iZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695520; c=relaxed/simple;
	bh=VI3sLFMDSUlR1JhhWI6vW8oeTPKDhZKcXhMcS1NZXNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f835Iuv7Wo2ittp9LmexQdEfYpWbphGSlXVNrX/d+BKH4/jAy4jyd+R7x4SwDC34TdNSQ5YKj3fIlmxjNXCfDiPSb9H47UToS9qIHbaEbPaKYNMBWNkCw3H+vfycOOgxhonDSQ79F6CTHZHpXO0Pu5mdij+0mzvvKA1sL48Dx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Ia8npmvw; arc=none smtp.client-ip=217.182.113.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Ia8npmvw"
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 13C3E3E877;
	Wed, 22 Jul 2026 04:45:11 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id C3D34400E2;
	Wed, 22 Jul 2026 04:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1784695510; bh=VI3sLFMDSUlR1JhhWI6vW8oeTPKDhZKcXhMcS1NZXNA=;
	h=From:To:Cc:Subject:Date:From;
	b=Ia8npmvwIgazIuW0/7eGpRpv3dD9oFvsTnIyXhuiqav37YyTDK6sPYuGmrZ2HyLMv
	 iyY6tlFolE4pXyymA0LyzEjamZ6HJwaJ30Phb7IJiY3ndgsyVG31QmRCQZBCsjW/+S
	 NQwLnKIFM0GKHKJhOc/+ILR2kc5qBHZNPzxPf6WI=
Received: from liushuyu-la64 (unknown [117.151.12.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9E03441283;
	Wed, 22 Jul 2026 04:45:05 +0000 (UTC)
From: liushuyu@aosc.io
To: linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Yao Zi <ziyao@disroot.org>
Cc: loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Zixing Liu <liushuyu@aosc.io>,
	stable@vger.kernel.org
Subject: [PATCH] platform/loongarch: laptop: explicitly reset the bl_powered state when resuming
Date: Wed, 22 Jul 2026 12:44:50 +0800
Message-ID: <20260722044457.1333404-1-liushuyu@aosc.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: C3D34400E2
X-Spamd-Result: default: False [1.20 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.10)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	LOCAL_OUTBOUND(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[aosc.io:+];
	FROM_EQ_ENVFROM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

From: Zixing Liu <liushuyu@aosc.io>

On EAECIS NL60R with EC firmware version 1.11, resuming from S3 has a very
high chance (>= 90%) of causing the EC to lose the previous backlight
power state. When this happens, the laptop resumes normally from S3, but
the backlight remains off (when shining on the screen with a flash light,
we can see the screen contents are updating normally).

Since there is no generic way to query the EC's backlight state on
Loongson laptop platforms, assume the worst-case scenario and restart the
backlight power inside the kernel each time the system resumes.

Cc: stable@vger.kernel.org
Fixes: 53c762b47f72 ("platform/loongarch: laptop: Add backlight power control support")
Signed-off-by: Zixing Liu <liushuyu@aosc.io>
---
 drivers/platform/loongarch/loongson-laptop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 61b18ac206c9e..742a585b0647c 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -200,6 +200,7 @@ static int loongson_hotkey_resume(struct device *dev)
 
 	bd = backlight_device_get_by_type(BACKLIGHT_PLATFORM);
 	if (bd) {
+		bl_powered = false;
 		loongson_laptop_backlight_update(bd) ?
 		pr_warn("Loongson_backlight: resume brightness failed") :
 		pr_info("Loongson_backlight: resume brightness %d\n", bd->props.brightness);
-- 
2.52.0

