Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9384C0402
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447956; cv=none; b=a2C5uzw7n4yyoYVV0JPx+anl2GbdXVI8ZGtcM6zGGOfIQ0E4EJyRQOMKJLgAaiINq78gwJ6EXxQ/Uo3xnqrIh4vaPJR0LXDtK7Avk9VxCC7qKLVHa2Uk10Evvvf6v9SCsxkMdrSIy5xXH7D4uBFcsV0f8cRfdpH0E6SvF2reBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447956; c=relaxed/simple;
	bh=8zX7/tWqPv/hOkWwomQw9xFp3RFaUXYnhQVcGu8XSGA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZCf4ChZtn6MrGVEM5g+TujYCZnSOuxrn66aRQ0vrNjV0iRbGOSpYn4XZoqD8hIpEUOEfBwKyPZwdpM8iXYd5iQT08h5zBj1qfF7zNgkNVH3xu4ODyUbLwjH8Ok0q9ALeGtYsT7O96uXb/Gr7aGwvRxQ2kxoNIj8d0QmteNU348E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WnPR5YNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WnPR5YNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A571F000E9;
	Thu,  3 Sep 2026 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447955;
	bh=0WS5I8Tqa5+zZ+5hjIutDr1BG+k3bgRIjgDgH4alUCk=;
	h=Subject:To:Cc:From:Date;
	b=WnPR5YNTCaW5dFKSqPxhB/8b/9Be+9DJc71SV5AIjN78Xq/xZBkWuxw8D+M5YlZsl
	 QhxyRhGAA0a42lvqiZCgZm9MX5oOa/8L95QoGz3CxohLEbjcWXG2GLSBvLPuWaAoOT
	 4yAXzKFKSXjGlQGu+28uKBH9KEQAXKGoaffVnWIU=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Validate max level for set feature" failed to apply to 6.6-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:48:11 +0200
Message-ID: <2026090311-concept-diagram-32f7@gregkh>
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
git cherry-pick -x e45d6b8472861d3bac86bb37f8556a7c5aca3266
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090311-concept-diagram-32f7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

