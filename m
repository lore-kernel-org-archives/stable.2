Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA636377AA7
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101321; cv=none; b=VzuAnTz+7y2Rano2d4KNCWv+wyHL+d9IDI6DtZ77F7ffGZTHT4QqAL/73snmVwwl003w5PsVRVOHIKlG8EznuBLoWG9N7bZztUimbyz9qOriSsesOtpjHzKQdGaEtxsjo6VuKs+wvwacMhF//vdhcid6vPNXcQIZnme1M/rOJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101321; c=relaxed/simple;
	bh=tI9lYQtVXoFs4EOWB31i5fl1mYFmA3uk8vyfcvDdjSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9TPg39aCmCrgyimt5hM1FWLu3F3NhUrd3oRg1e84/Ie1Nl+5iqtmuyQUJDQOjRpoRSut/zhXdd85ksx9yfkrTDXQ6IlH6xNQOOsW0E3vKhdJsGd76+f1gCfIQ2dQrEBa5g8SudxMcPpA3KOffcN7SIvbIEE17eRYutLe3s8AtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRNnSNAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRNnSNAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B491F00A3D;
	Sun, 26 Jul 2026 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785101320;
	bh=azOzsgVR6IUtdKPYJ9ptEYdneIfF1VV4ieoY9Ec+jr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRNnSNApCyiGvsis7X+A+QIFafrMDhhPR2PuA8lV+lpUszYOLXMMjIMpFzFRI4trA
	 fTEajMeDrxvebJwGgzovWZgoeDbUiD/ifp/ec/z6NEwNcOVVqx/E2O6VFDklIKMF6r
	 YP/kACx2XgYCE5hXnJAXNNLYRyKRsY9Skl4o4qTK/sX4g0AS/zie+5c0eDAKrvUzi1
	 Jsj1U/2LddTHygArWfWe0SllT7q0AHfp1mrigXqytEXR5qdRmsM0oaEJh7JilMrMMF
	 +TouB1iFhraAk4cEkAyFj6dviDqFnm3CG4f5IvkMkcaCz+CqvIuT7vsoSM6y2NsS7e
	 BbqEGsLJ/mYFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] platform/x86: dell-laptop: fix missing cleanups in init error path
Date: Sun, 26 Jul 2026 17:27:30 -0400
Message-ID: <20260726212730.4016280-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726212730.4016280-1-sashal@kernel.org>
References: <2026072059-eastcoast-eating-4897@gregkh>
 <20260726212730.4016280-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 6e9cab2247e5b243ae2d907ce7c948a8a9c8d61a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-laptop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index eedec47616b481..d151202bc99499 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2295,6 +2295,11 @@ static int __init dell_init(void)
 	if (mute_led_registered)
 		led_classdev_unregister(&mute_led_cdev);
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
2.53.0

