Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313277;
	b=qk5f7wGIDhPsJjjjbh9i0Pt92hMMu8uJ1JX7SCkmUpg56nvKfi1WJE/cpGavfBSATIMc
	 Fj7aw2bvU7v4L65gDqFzp5SHU/4GeHBCl3q9rhMQ/cUst87uFDhVagMo+AXiBFbkT9Msl
	 1Uw4+/GNSbik8llzn99zqLdyCaeTFSCNyZOnI/TCGO3la2fFpcbev5L12SMscR3Hmkp+y
	 jNic23Nt1mKnmP9tIxAIqguZZNutZQKp5Jr2Ez18XW5IOSrvM4d7U9V+T+HmkuO3FyY8G
	 SB+IfLNtsjo7RUwSRiXLlAKBfX1qdXKPYAOO8UUqKTJ7GzKiiwFWSQnGE5doc303eug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313277;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=YfBfeUB6uHAxNYItYY+wrQGXiJp9RXTvFOd3O9U7kHU=;
	b=vJo3/HOxNGRuE2yiKeTawYBgfTS5q4PRlI5QjJRsarG2CQo5XVKJl5S5NHJF+fDUjseu
	 fM4KC3JiFCx4BvTwIK7Wt0NXIU52BMJWUe9y2ME7Jjsbcj2oJUBfkikp/LPOnburIv76R
	 DpJWpPIWFW8MQtxc33pK6j5X3QLfVdbEo5tBqqn6xScvXlOno9H2L/6HM8kkXwS+9f/J2
	 1OrjLMa3PAqDpsCYWQ3iSa6nTtFpG9bUSn8vHzvR1CaXfsU9DkXogwbtMihPkr494UP86
	 2QzoRb6S4keJmmjwD13MlmHbC2JLMSt7oyelbVaEuixdSJILqD1RmMbC+Dn+Dh1bVqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=GDGI9t3A;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3A606A31C;
	Tue, 10 Nov 2026 12:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=GDGI9t3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794313273;
	bh=jKxEes0ibPRhJ7Jn7KDybYPb3O12zqLFNX/8Nqm0eUI=;
	h=From:To:Cc:Subject:Date:From;
	b=GDGI9t3AgUb0bsgYnJVSsyDMcn9uaiJioCJKtz3UrhYRXcfvSW1+EFZ1t2LrfSxcK
	 nJNl1T/XAHy416lyMOIEh1DAhiRtnepuXs1+4u+aRlH/8mo+LkQgp7uAOBl9j/0Jw6
	 0UoTz0fmakXBoAw0d9TZdEgpp8KMBCMzNDJm6CcZTtMGGk8SQGyv7SNFH5SPFX6K7U
	 W7DG9pDQv1rP9O8Ast6LNIr1bBTsJgZ9yfTUtA30KCtoDx030Y2N3DYQlnH58UR3gl
	 FG3loNT/rKd9PxN6uO7md0WlH0LceCH/WLEGu0CljZ5I2q+FcWsfh8jXw5mABJGSp9
	 1yvqV3+03K+7w==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 148971FA82;
	Tue, 10 Nov 2026 15:21:13 +0300 (MSK)
Received: from mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue, 10 Nov 2026 15:21:10 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.16.187])
	by mail.astralinux.ru (Postfix) with ESMTPA id 4jP5NQ1qjVz3f5;
	Tue, 10 Nov 2026 15:21:10 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15] platform/x86: dell-laptop: fix missing cleanups in init error path
Date: Tue, 10 Nov 2026 15:20:58 +0300
Message-ID: <20261110122100.954-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
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
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/10 10:24:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;astralinux.ru:7.1.1;patch.msgid.link:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207367 [Nov 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/10 08:49:00 #28832117
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/10 10:24:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 6e9cab2247e5b243ae2d907ce7c948a8a9c8d61a upstream.

dell_init() initializes several resources after dell_setup_rfkill(),
including the optional touchpad LED, keyboard backlight LED, battery
hook, debugfs directory and dell-laptop notifier.

If a later LED or backlight registration fails, the error path only
tears down the battery hook and rfkill resources. This leaves the
notifier, debugfs directory, keyboard backlight LED and optional
touchpad LED registered after dell_init() returns an error.

Add the missing cleanup calls before tearing down rfkill.

Fixes: 9c656b07997f ("platform/x86: dell-*: Call new led hw_changed API on kbd brightness change")
Fixes: 037accfa14b2 ("dell-laptop: Add debugfs support")
Fixes: 2d8b90be4f1c ("dell-laptop: support Synaptics/Alps touchpad led")
Fixes: 6cff8d60aa0a ("platform: x86: dell-laptop: Add support for keyboard backlight")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Link: https://patch.msgid.link/20260609081419.1995169-1-lihaoxiang@isrc.iscas.ac.cn
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[mdmitrichenko: Adjust the error-path context: battery hooks are
 absent, so there is no dell_battery_exit() call.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-72144

 drivers/platform/x86/dell/dell-laptop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 01230c95b040..a5fb143e26fe 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2274,6 +2274,11 @@ static int __init dell_init(void)
 	if (micmute_led_registered)
 		led_classdev_unregister(&micmute_led_cdev);
 fail_led:
+	dell_laptop_unregister_notifier(&dell_laptop_notifier);
+	debugfs_remove_recursive(dell_laptop_dir);
+	kbd_led_exit();
+	if (quirks && quirks->touchpad_led)
+		touchpad_led_exit();
 	dell_cleanup_rfkill();
 fail_rfkill:
 	platform_device_del(platform_device);
-- 
2.43.0

