Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCB31F991;
	Tue,  9 Jun 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992872; cv=none; b=AVk5CPxkliH9GXT5bay1ZJ/CcD4HAESdn5l2uFzebTJatio9Qsi1tqpdTdBFOsIl8ZO+eR7KbH3ruBkvqoeFN3BRzul2RGErZbMEc+TOhvDD6cvqncwwDsBjWxq3Rud0qhBKWl+hS3BSWH4itHeokdDRxnkvBUB5rppmCB/COq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992872; c=relaxed/simple;
	bh=m7wCEuFIxYSUjsVJgkGPLyoSjEZIWTcXBnthvF22tEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptI092X2xwitjf1PDeAjSMUL4OKAj4h/i+MYQA6tznHv6ekZG7PQTseu1mtl//rJwdyY94hn4evI3o74/yWOk2bgH2Di7lhhgRa2cWXD92RQi7ZyjM7DQGLIvPuU1N8K8PeHrSn9YJLaR1cMjHzATRoqTQ0/lyuP+XNyXv84bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowADX4Mddyydqr5IgFA--.8275S2;
	Tue, 09 Jun 2026 16:14:22 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: mjg59@srcf.ucam.org,
	pali@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	dvhart@infradead.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: dell-laptop: fix missing cleanups in init error path
Date: Tue,  9 Jun 2026 16:14:19 +0800
Message-Id: <20260609081419.1995169-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX4Mddyydqr5IgFA--.8275S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWUuF4Duw47ur1xXrW8WFg_yoW8Ww1kp3
	yUW395Kr43G3yDKa1DCF4I9FyrA34rC3yfJrWak3srZwn8Jr17Jry8ta43WF17JrWxC3W5
	tw4kXan0yF48XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCQ8NE2onp3SUcwAAsh

dell_init() initializes several resources after dell_setup_rfkill(),
including the optional touchpad LED, keyboard backlight LED, battery
hook, debugfs directory and dell-laptop notifier.

If a later LED or backlight registration fails, the error path only
tears down the battery hook and rfkill resources. This leaves the
notifier, debugfs directory, keyboard backlight LED and optional
touchpad LED registered after dell_init() returns an error.

Add the missing cleanup calls before tearing down rfkill.

Fixes: 9c656b07997f ("platform/x86: dell-*: Call new led hw_changed API on kbd brightness change")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
Changes in v2:
 - Fix all missing cleanups in dell_init()'s error path.
 - Add Fixes tags.
 - Modify the commit title and message.
---
 drivers/platform/x86/dell/dell-laptop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 57748c3ea24f..053f40572bf6 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2551,7 +2551,12 @@ static int __init dell_init(void)
 	if (mute_led_registered)
 		led_classdev_unregister(&mute_led_cdev);
 fail_led:
+	dell_laptop_unregister_notifier(&dell_laptop_notifier);
+	debugfs_remove_recursive(dell_laptop_dir);
 	dell_battery_exit();
+	kbd_led_exit();
+	if (quirks && quirks->touchpad_led)
+		touchpad_led_exit();
 	dell_cleanup_rfkill();
 fail_rfkill:
 	platform_device_del(platform_device);
-- 
2.25.1

