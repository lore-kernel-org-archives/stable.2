Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAAF418A3F
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559798; cv=none; b=ctRMA83SDFastG4TZoRgwszvogUoz+Uj12bvxHg8Jo+fcfCLEO8kNmu2apRc1MIxqMS0yJH/s9HizOnDAfrv3RvWHcUH99iAnO8B5BYq3d78Y8CQnKl8QPtusdec9TIF5PnRc+0wMI0/bX25EqpaDgHvc9GqOetxMIM3mW7WaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559798; c=relaxed/simple;
	bh=bnO5895J9TV7xtf0b14cBWNPgCZ0IEa2MAs3OdvOShw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DWzElyQfcRwrvhmaJwj2/EIZ7/sGH8Z8XimmZWldniD6EncvUWlE/vt5Hg3IbM8liidfwd8jgkVdXe36w/EGyKBzrBcFO4S8r2mcWe1GOO4qB1eulY1QdWsNf8O/KDk/fbeKuSu3SzwTwsAl+Vsm4lES+Ox7zMfzQCi6U8raOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNfXHEAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNfXHEAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E61F000E9;
	Mon, 20 Jul 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559797;
	bh=e/ptJx/2+EcA963JTbTE5J+BPtOPymZwq+i7Hoc0LgU=;
	h=Subject:To:Cc:From:Date;
	b=qNfXHEAzkTtJUf7FXhX34K0lftcJ6fRSdohbGzTzsXOPOiQDVhjV34mnFGkxEUZuT
	 0VdaO6qEJTMvKo71s1CooXg1D3p5aMi/oshnAQsqb0KoABpducGVTfauRA1DMcodTq
	 Gv3fjk+adHwn9G0bsywU3MAINn9+xavcT5zvazfY=
Subject: FAILED: patch "[PATCH] platform/x86: dell-laptop: fix missing cleanups in init error" failed to apply to 5.15-stable tree
To: lihaoxiang@isrc.iscas.ac.cn,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:03:00 +0200
Message-ID: <2026072000-jailhouse-only-89e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6e9cab2247e5b243ae2d907ce7c948a8a9c8d61a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072000-jailhouse-only-89e6@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

