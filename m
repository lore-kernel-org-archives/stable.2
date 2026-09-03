Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7914C77A8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447953; cv=none; b=ahhP2kIZDHftxB+si/RHMsGhpOcvspsXBxQX0HAti3HgQfI22iAZkaDKIouMNsanSRoTD33k54Glytp+qtTA1LxLgn3nnJxGn74YHlOYwwcjTGk1rvpOM9f/sdku+JCS0lhuDqkfiXuDoGUDc1t4QmOWbBRdPQGl1GPXzJT4cVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447953; c=relaxed/simple;
	bh=nfRfE/1Uvzh29izjUndiq2AgkkH8bTOjIv5L/L22Ujk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZPMiRO++mSU+uqJOQyu5IXVZsdmjPoMTwjl5Y81ChcrLLfeK+3AfP6SN6TNv0t1JTTvP0s+AgYZC1sD/94MP4dxb/1nJAhtc+UmZY/AsZpPiax1HM/jd6Jf2A67zUid9ICR3XdVwW5IM31BwaW2qFzsx5gwoiGRAyfQRSvkOQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dmBy1KMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dmBy1KMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45331F000E9;
	Thu,  3 Sep 2026 15:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447952;
	bh=fyT5E/uMSt/3E0v0ir8JDc/jNf5FX+Zbut0m8Zkn1OA=;
	h=Subject:To:Cc:From:Date;
	b=dmBy1KMAZGpCaaLtZITIg+SrpJ2EiNTE0KppwBTr7j/VDS8W8w5Ohj58ZjPHS9Z5q
	 AT/oaOEc131fUpnbxtA4eaxNwzpaAIO57PJIWfKb1ktTCyGQMrWJNdWcwjXGXZtCaH
	 iavy9eG8CIqPEoGNup+gEarSQHqOgt1CnbZz7950=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Validate max level for set feature" failed to apply to 6.18-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:48:10 +0200
Message-ID: <2026090310-gawk-vivacious-d6f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e45d6b8472861d3bac86bb37f8556a7c5aca3266
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090310-gawk-vivacious-d6f7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

