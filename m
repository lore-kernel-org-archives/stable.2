Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AC37CD41
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224451; cv=none; b=nARTabv1kEY5az1+oRvmIJtgI7K9UQPNB6EM/Q9v5Y2BGFg7JUKQcMRmS8vY5OU6K8plikUGk3D2z21p/QWODMUJVvZLEb1xKJYYfCMie6qNYDsFZHMDOSdqNTa4Zj9vK9W/9SkvgKfBfajtQ17u4FqImw5xKX7F8ED+OnajC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224451; c=relaxed/simple;
	bh=8fZzqAmy44tyZy0K+li36fbpX1nnz/++SU5t4Q6Lb+w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gOF/ZB6lud5Dx6KaZm2A1PKL0QjMffud6omIEE8WV9j+aK5QqgnCPO36aEAr0QusiNeRky9lxfNnrReAj0ruWbHzD2ZAeaC/159oqmlSvo0v4LS4YR7ByOx9TkfllAB/n4LxJJ1iEpgmy7Jimb3Qlx/P9gg6fkr8E6ep86+WBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CybdRxtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CybdRxtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F6C1F000E9;
	Thu, 20 Aug 2026 11:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224449;
	bh=JbHfLbbRuIPyKL5eLzk4vs7XH+EErMPPJv5WaHNLlF8=;
	h=Subject:To:Cc:From:Date;
	b=CybdRxtS4eJri7Fcv7YSyd3ukPGK/sKhje7ktMpXo7VINp5JHoi9BnUmkEl75xlpc
	 Wufe/cDgbzucgKNdqsubo0T1SdZd6/01AZOUn/LyEwZAyiWdJMR2vSj06nOBSS6nxi
	 Q5kUvX7UuepfZO1J7uJLfCv7m3tm0zIL/KhEH/mE=
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO" failed to apply to 6.18-stable tree
To: jia.yao@intel.com,gwan-gyeong.mun@intel.com,matthew.auld@intel.com,stable@vger.kernel.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:13:55 +0200
Message-ID: <2026082055-unvaried-abnormal-f1b2@gregkh>
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
git cherry-pick -x 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082055-unvaried-abnormal-f1b2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882 Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Tue, 4 Aug 2026 16:50:57 +0000
Subject: [PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
(cherry picked from commit 9daa302a82590eeee7bdc68023ddad302df4b88c)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index b6d07f2e73bf..886bafd31f45 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -406,7 +406,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))

