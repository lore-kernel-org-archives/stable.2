Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F837CD41
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224457; cv=none; b=EzhhZ2Qh1zKl2BNxS1nalspQSMCNcHFFA2tldzI6QczU1RHAzvpZpv9Pneva601Jlfv3qqUqKAEVDm8Zgi4pBp7gvJkk8pq7AuKy0KyU9r28/j5kFwFiVilU+lp6yoqF6iKNkowhUNuj1xA2bU8LFc9dSy1iPXUcB/Vzbxljjf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224457; c=relaxed/simple;
	bh=g/F3IGsHVgU9yly0hqxSawfZTusY30zXLaSipXylDGI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kfCGyDsy2sm3WqpOQZ5uJZk5gh6GJOBuwzLTsWOD0I8MYhPyaUsiKsIHmQIan0Iaj5FuNXNHoIwfPNMcOOA/koZCeEmp7wb1FObZUtximnHWk4OtbFZ1PwElKmBgy0f+Vzvx03iWUVNniCX3r//IHUHfUglCuC7Uoewb+whhyXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TN03MCQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TN03MCQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B261F000E9;
	Thu, 20 Aug 2026 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224456;
	bh=IzPdIan+pvx44yfDfERL88+uXqnDYN05LUP7dZG3TaM=;
	h=Subject:To:Cc:From:Date;
	b=TN03MCQV0bHZx3I/SwWi5xXqtGHMlhgmKM0ujd7oJkSax0EYUnKVZo6+AY/mKHvVo
	 x7thPn3WSzXYpkmpG/KAiEMHcTK9rNVU1RIUkScFw9shPjP5BKD2ZUd+UV/2BgnnC6
	 dXH2b8FT/xPKjExLk1VH8aRYeK5KdZorO1qKCV6o=
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO" failed to apply to 6.12-stable tree
To: jia.yao@intel.com,gwan-gyeong.mun@intel.com,matthew.auld@intel.com,stable@vger.kernel.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:13:55 +0200
Message-ID: <2026082055-unhinge-monstrous-7eeb@gregkh>
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
git cherry-pick -x 8d5134ae4177fa4f5a9bc8e71e6656cfc2852882
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082055-unhinge-monstrous-7eeb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

