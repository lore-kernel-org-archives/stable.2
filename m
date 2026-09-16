Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D74D7D56
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580450; cv=none; b=uoHzOXSR3GnoG7aLn35Z4I0n2f7O7qsUO/YSMO7k3/l/NKEgpqyXL6nEEqtxMAe2BVWb2MgbXylpUUWe9ZgCEMxgRYF6Ykn3lJGOGYX5w/W/iNwlobuSzPXDd9mqYcIMXP5M5VeioQhOMzWfc/XtVKkhGSNOh+rKbpjITxQxz54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580450; c=relaxed/simple;
	bh=fpBnMJEXMBU00ZrsxQy0zEOJ9EyonXXwD2tbZon5jqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ssqbB/u/dbTQGLOYnAGCST1bA1+TVpAYugzW4afHBEQoHFvJcJbRyi129Fkbp95zEY4ysbWEk8iefaT6V+aW/YhFevFm697zhNc6wrwRmR2/p+NeBGCjZaD15ni/LNmuXhDYbwzydzKYFrmnVrwMD9xuzktLQKZIODSjB4D7020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URl3fuQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URl3fuQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12EB1F0089A;
	Wed, 16 Sep 2026 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789580441;
	bh=j4Nij3KxbGJ0MyTJb3yPlzXjAEXGGlb6t/DpRtUy2z8=;
	h=Subject:To:Cc:From:Date;
	b=URl3fuQecfiELZUm/yzC59qiIxnD0dPMryIvJyALUD5UhzsMfc/ZFJV5ul6vi02WC
	 YjR3zhdu+8Vj2VaJ/NTx+zdq+pntuXsUWDs8mSmEtGZdizI3Cs0Ho5lFMrfNffcza1
	 9eW7vUPZMRL4KMWPY5e40bopIkhv9CEo6AOnVe2w=
Subject: FAILED: patch "[PATCH] ASoC: cs35l56: Fix race between kexec and" failed to apply to 7.2-stable tree
To: rf@opensource.cirrus.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:32:11 +0100
Message-ID: <2026091611-legged-other-642b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 883e78c9e6007c91be96e99a36c35baf41bc8ed5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091611-legged-other-642b@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 883e78c9e6007c91be96e99a36c35baf41bc8ed5 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Mon, 7 Sep 2026 10:36:45 +0100
Subject: [PATCH] ASoC: cs35l56: Fix race between kexec and
 snd_soc_register_component()

Use a reboot notifier and a mutex to prevent snd_soc_register_component()
from racing with a kexec reboot. This prevents snd_soc_register_component()
from manipulating device lists while device_shutdown() is walking them.

Commit 1d80a4792f1de ("ASoC: cs35l56: Fix probe deadlock waiting for
SoundWire enumeration") moved snd_soc_register_component() out of probe()
into a workqueue item. See the description in that commit for a
detailed explanation.

That change introduces a race between snd_soc_register_component() and
kexec. The reboot notifier and mutex prevent the shutdown race.

There is one remaining race with KEXEC_JUMP because it does not invoke
reboot notifiers or freeze freezable workqueues. But KEXEC_JUMP is
rarely used and is supported on only two architectures (x86 and SuperH).
It does not appear to be enabled by default in any distro. It is also
unlikely there will be a KEXEC_JUMP before snd_soc_register_component()
has had the opportunity to execute. Fixing this can be deferred to a
future patch.

Fixes: 1d80a4792f1de ("ASoC: cs35l56: Fix probe deadlock waiting for SoundWire enumeration")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20260907093645.27407-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 890429ab0dfb..35d210626627 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -18,9 +18,11 @@
 #include <linux/interrupt.h>
 #include <linux/math.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -37,6 +39,13 @@
 #include "wm_adsp.h"
 #include "cs35l56.h"
 
+/*
+ * snd_soc_register_component() can call component_probe() on all instances
+ * in a card, so deferred registration must be protected across all instances.
+ */
+static DEFINE_MUTEX(cs35l56_component_register_lock);
+static bool cs35l56_shutting_down;
+
 void cs35l56_mask_soundwire_interrupts(struct cs35l56_private *cs35l56)
 {
 	 /*
@@ -1957,6 +1966,11 @@ static void cs35l56_component_register_work(struct work_struct *work)
 						       component_register_work);
 	int ret;
 
+	guard(mutex)(&cs35l56_component_register_lock);
+
+	if (cs35l56_shutting_down)
+		return;
+
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(cs35l56->base.dev, pm_err);
 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm_err);
 	if (ret) {
@@ -2217,6 +2231,37 @@ EXPORT_NS_GPL_DEV_PM_OPS(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE) = {
 };
 #endif
 
+static int cs35l56_reboot_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	guard(mutex)(&cs35l56_component_register_lock);
+	cs35l56_shutting_down = true;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block cs35l56_reboot_notifier = {
+	.notifier_call = cs35l56_reboot_notify,
+};
+
+static int __init cs35l56_modinit(void)
+{
+	/*
+	 * Use reboot notifier to prevent race between shutdown and
+	 * snd_soc_register_component(). Driver shutdown() callback would
+	 * run too late, after device_shutdown() is already walking the
+	 * device list that component registration can modify.
+	 */
+	return register_reboot_notifier(&cs35l56_reboot_notifier);
+}
+module_init(cs35l56_modinit);
+
+static void __exit cs35l56_modexit(void)
+{
+	unregister_reboot_notifier(&cs35l56_reboot_notifier);
+}
+module_exit(cs35l56_modexit);
+
 MODULE_DESCRIPTION("ASoC CS35L56 driver");
 MODULE_IMPORT_NS("SND_SOC_CS35L56_SHARED");
 MODULE_IMPORT_NS("SND_SOC_CS_AMP_LIB");

