Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313258;
	b=wv3XoSC8YFCBviWbbWm5qhZYN9L/VJeS3MofoUvlVEO1URQSrNzH10JtkZkpK3sWVlln
	 AI9B8H1htnCtBLcqarGeHYbIozXVZucJ1Fq+ne7GB5CxLsiKrc6Dfxlmts/pbpdSQ+DWj
	 lStyqDltW7eCmjEPBdBUgX8zKgnDLOfSYEKiVuD/aKdUQmCvjzLHGRxsQ6+ezTF2zpjdN
	 pgBv4Rkde61sInwx0Ni+7mzux/z1eLWmhcATyDQnN2xSAp74E0eXsDfaSDPgkHV6o8JIg
	 7+Ax+ugzG2KCdcp74+moe9bkcZ8W9U/IINtaYSdmOOFuJGia7U4fkezAJ/EE08k5bRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313258;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=RmXcRN8vV5HSHU7wTt7Mc4ReM1tJZIkdPfvnOuaTl+8=;
	b=N8H3Uhc0TcUGaiGE14b4g78p4qNrrippAnymiR+h7za3ASTQ3PgDBuBT6ccQX7IX1cDR
	 C61RPw16Ye7XyhMzCrjUSrI28RoQ2Qip0MLZs1x2udEACZQ43VXjpc7MtMmYHw/iVhO2m
	 YKmgHGeuL74CQIjeRM1Owf/J+Ui/ra9mGVD59A6J+3e9u8lQiGPUeq5ygJkRki9CSiJnn
	 ba+3NNSZp78QTqSYjlrmw7g8NRbKjRrZfykmO7aRqVn6AEI+0y1CFdTfk2J0A3o+bcfRY
	 xA30uT80vWD49d6fQfnU+cYBA0K4IvQOSTBOQgb3reh1R7mB32jBTRceDvLDSWKb3qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=hSspNaJT;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61635606A31C;
	Tue, 10 Nov 2026 12:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61635606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=hSspNaJT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794313252;
	bh=p6aMMqjOBDO2t8uYC4/TE5CV4goPzQRJpR/7zoLhR2U=;
	h=From:To:Cc:Subject:Date:From;
	b=hSspNaJTN+gn5KDers9J1KUPeel3ohppXggAAidd8Mo3MfNVMJCK4yyo7+1hYYk7l
	 154SgM0Jd4HynMNV1tgXSIsOpUAAFYJHbnSezzvtUdns2f+PsEvb1qG4q40BDenzz1
	 LX0UnzJj91CVfBF9NLfI/AG4ptTfMwM9JfRzF56I/l9PFQ13TrF2VXTfpn8lqgt009
	 jVHPH3aEN7nNt8J01SS6KHEhy3ViKwb6eF1TqPPDPma8HKo5FENLnwk2ioEkKi9b9u
	 SfVlikBaKsBbBpTntpvQZOBM8z13jcLb4LXl1Ymx7YfN+z5/rEmM5LQU2pefNEHJLt
	 nBi7AnKaGRxmg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 387EA1FA7A;
	Tue, 10 Nov 2026 15:20:52 +0300 (MSK)
Received: from mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue, 10 Nov 2026 15:20:50 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.16.187])
	by mail.astralinux.ru (Postfix) with ESMTPA id 4jP5N14wdMz3dw;
	Tue, 10 Nov 2026 15:20:49 +0300 (MSK)
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
Subject: [PATCH 5.10] platform/x86: dell-laptop: fix missing cleanups in init error path
Date: Tue, 10 Nov 2026 15:20:25 +0300
Message-ID: <20261110122026.1163-1-mdmitrichenko@astralinux.ru>
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
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mail.astralinux.ru:7.1.1, FromAlignment: s
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
[mdmitrichenko: Apply to drivers/platform/x86/dell-laptop.c and adjust
 the error-path context, which has no battery hook.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-72144

 drivers/platform/x86/dell-laptop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index af5001ecf77f..71e58b9a6689 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -2268,6 +2268,11 @@ static int __init dell_init(void)
 fail_backlight:
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

