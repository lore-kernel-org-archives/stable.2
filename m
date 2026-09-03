Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B264C9009
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447959; cv=none; b=LBj/hPtaCYE3TrGDpLDNPXDmghDkLjaypKvSkuBlKQN28+NNQZRm3IvHFak8/IEZhYDU4gbZx3XeAyP5CZgBBCj/bPMQJ8bVn4OF2MYz4NryOYq9aFufzOnDjWkIQsWfPugZUKEfOknm2AOBlmsgLtXu+Y13kWeFakLUJlY6548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447959; c=relaxed/simple;
	bh=W/hHPtbKaElM5/fntyWYpIfNlYs7u2VkpgFHIDClerU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a/zgteoQxpBdtesnJVHJUKuT7dqgPGhttnkrktXKtDydMBzPWogdGOdfKuUEmJ3fa9h2/zlV88ebHoBJ2wNgZUCfNwuR6ZW5Hfh9LTmj22ZO7RsCwlu1PeqoYMOkKPJklcX4lrIUHB2uUvCb9kTVcV+2srUdPvRUasYyJPoP1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qko9s3eR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qko9s3eR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2D1F000E9;
	Thu,  3 Sep 2026 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447958;
	bh=4M09jTLIF0bAH3a6KEB7+BAzSRTn+/Ffo/zIZB0No9s=;
	h=Subject:To:Cc:From:Date;
	b=qko9s3eRgv1z4EBNLG8FVboJpdkAzxZYMiK2AC9umwb5zwa5/TX0fza0WWq05bXAC
	 ZLm6D7KHhVEucdPV6l5CddCX1dWYzT1CV6vNdXXk8tnGme2ZkNguUEgS4xFsOEWEUM
	 LWHV+QFtgENO95pZtMVYzGmvg7TV0MjWRF86V1e4=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Validate max level for set feature" failed to apply to 6.12-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:48:11 +0200
Message-ID: <2026090311-unboxed-worrier-de27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e45d6b8472861d3bac86bb37f8556a7c5aca3266
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090311-unboxed-worrier-de27@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e45d6b8472861d3bac86bb37f8556a7c5aca3266 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 11 Aug 2026 15:15:10 -0700
Subject: [PATCH] platform/x86: ISST: Validate max level for set feature
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate the level before setting, so that it fails early instead of
failing later when checking the bit mask for allowed levels.

Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20260811221514.3905817-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index a5ab3be92afa..7be50d4167be 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -947,6 +947,9 @@ static int isst_if_set_perf_level(void __user *argp)
 	if (!power_domain_info)
 		return -EINVAL;
 
+	if (perf_level.level > power_domain_info->max_level)
+		return -EINVAL;
+
 	if (power_domain_info->write_blocked || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 

