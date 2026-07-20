Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961593B47F5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559803; cv=none; b=CRnFMgCpblphqU/imeQn/2axxhl39mp6Qw8OrdrVYSwXo/d9awP85nHnvJXRKezqzDXYFVRKGJnKNzvwT9Otp4DkBpYfUHha0x0izaLZ8LwiM65CN9BsHP+xtHAfEZ7Dqpn03bQIdBIVx9bCwwxfeuuXCEU2gAUS2o7iu9ZMta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559803; c=relaxed/simple;
	bh=SsYxrFzj/hPDZlmRXM4xpZyc0grcwfp6cUh5i08z/eE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VX448KPk/jUVxRxuP3MsXXCa4IgkgkZsbzVnymQ3vEzhyF4Q6kYGNX2hrMCy5R1ACub2MZUZuID75A8ekZC+6pd3dZd2uLPQWhgg1rz2RvfkRJvjVyFOSamGTy4iXFanwQ26yeLo7nSfrOaCSy0289z31eSIj2/86Doq4vijRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IuNoQmQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IuNoQmQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035BD1F000E9;
	Mon, 20 Jul 2026 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559802;
	bh=igMrxvZt+eEj5X/E0l0HUtfMk5uJXWULtOBCyJkJ1pc=;
	h=Subject:To:Cc:From:Date;
	b=IuNoQmQjUoE/vIXZ/t9dcPdRUvlljSVZNoTwwFYI/6+IFRO3eAOUPfByAlG7WZBFW
	 AX2E9+hOMXCYIdULuqNfd3UeazEMG5I2EP+B4vXh7m3HZF2qGJnHeQnyoILJQXrVc+
	 8+Zd4Boo3e7nMzhWLXwXWvz5yu0z7+k9HoR6VzwI=
Subject: FAILED: patch "[PATCH] platform/x86: dell-laptop: fix missing cleanups in init error" failed to apply to 6.1-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:03:00 +0200
Message-ID: <2026072000-unlucky-ship-812f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 6e9cab2247e5b243ae2d907ce7c948a8a9c8d61a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072000-unlucky-ship-812f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e9cab2247e5b243ae2d907ce7c948a8a9c8d61a Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Tue, 9 Jun 2026 16:14:19 +0800
Subject: [PATCH] platform/x86: dell-laptop: fix missing cleanups in init error
 path
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index 7fc3bbb8c4a4..89e85c7f7132 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2560,7 +2560,12 @@ static int __init dell_init(void)
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

