Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AA4C9543
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447962; cv=none; b=RE1aoPNr1azvLy/e4KxYQxG18zedw47FC2ERLWBiFBPf19JX4t8TcgDwLnHHCNexdUIGf0gGCYQV3uqkP24BfBUKcWOeaZ3NFJaZK9GN1nYmxOLl2eiwIFBynY77/X9RfQtzO0UQrTb84ZV95GBOzyWp6YcWqz9wMBL7ZwfJjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447962; c=relaxed/simple;
	bh=hBMWUbF7TQBPUil9FAuDJ1UNw07bxJZUaBd+ngZMomc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vDL3SIydDjyFxfw1GNTLCe3ZTXT/aJZaBJBUvykuVVisj+qp/uPelekdzP2I6j63/QLuEE1BUCcZqwuZLEtYkqR0gBOE3BLIMsUmjTTjo5bYsebQxk/F+7rpJ5CLPgj7cF0CMpFnH4zGRHM3Q0y2SWH0gTDwAiNb4mFHQvEiqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCJ4+vkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCJ4+vkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F461F000E9;
	Thu,  3 Sep 2026 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447960;
	bh=wuXXDI2q31rfyvh5BH3OivTh1vetsbaIBQlAqcceW2Y=;
	h=Subject:To:Cc:From:Date;
	b=oCJ4+vkV9IxN8njjQnX6mFRYXMWxvIb3E8vN5yQaQE65alBwNmbRuQ11AbjoW0D4z
	 1/6u7QWspak68y3YcCqUJ3M1LraGtj0Swny86EZz+XsNCuEmVsPcQyR+DSWSAxr/RD
	 Ssb/Kr6rOifwKI3YBCalRo+XyL7WyPWrH36vRDZI=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Validate parameter for core power state" failed to apply to 6.6-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:48:21 +0200
Message-ID: <2026090321-shock-prewashed-03da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1700b4f804555467b7eff58dff7acc11d508b3a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090321-shock-prewashed-03da@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1700b4f804555467b7eff58dff7acc11d508b3a1 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 11 Aug 2026 15:15:11 -0700
Subject: [PATCH] platform/x86: ISST: Validate parameter for core power state
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow only 0 or 1 for core_power enable and priority_type parameters.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-4-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 7be50d4167be..8f63694da897 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -599,6 +599,9 @@ static bool disable_dynamic_sst_features(void)
 #define SST_CP_PRIORITY_TYPE_START	1
 #define SST_CP_PRIORITY_TYPE_WIDTH	1
 
+#define SST_CP_MAX_ENABLE		1
+#define SST_CP_MAX_PRIORITY_TYPE	1
+
 static long isst_if_core_power_state(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -618,6 +621,10 @@ static long isst_if_core_power_state(void __user *argp)
 		if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
+		if (core_power.enable > SST_CP_MAX_ENABLE ||
+		    core_power.priority_type > SST_CP_MAX_PRIORITY_TYPE)
+			return -EINVAL;
+
 		_write_cp_info("cp_enable", core_power.enable, SST_CP_CONTROL_OFFSET,
 			       SST_CP_ENABLE_START, SST_CP_ENABLE_WIDTH, SST_MUL_FACTOR_NONE)
 		_write_cp_info("cp_prio_type", core_power.priority_type, SST_CP_CONTROL_OFFSET,

