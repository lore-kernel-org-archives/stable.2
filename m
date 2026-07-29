Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8144212B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323309; cv=none; b=HPefVZDqB7Hlhpkcp6CeIq4Glcp9KUgKSZSIQW4zGfPEsylWf0/bD0/7YL53kUojYXzJ4zSXXLqz7a4iLMV3uRvjMV5rGUF6WpdeuN7K/+7NaIzBG9YOECrpKx4+cG+q23PRLiTpm+MKxSlk/hGKbQm8fq8wreVByvG5vnoUQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323309; c=relaxed/simple;
	bh=1VwiB/50DULT2ucYn/ovGOphU7BYWBPZ49YI8IbIxJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a5tY9NwDMaSbRbeD0V1z3zT6s8enNj236uhqilemwVNZbJNTFQN2PZAs5vwPW/VXmL2KHGeBX4MoEW1NkmEx4Nyde4PL5PU78FuqMcLlowGGLhDrb8wQnlGGSMtYn6FPmvntlJ3KUgrhxv2PykQm6ar++NHxFJNMOrO4PI3Pg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wWsOicdP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wWsOicdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9E81F00A3A;
	Wed, 29 Jul 2026 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323308;
	bh=vbuuaVL3g+VcIKzKoRX8MawkYxlKgPxpE+L/LV1IKDY=;
	h=Subject:To:Cc:From:Date;
	b=wWsOicdPf0QCWKIJDxkG3ADBJ0fc/TASvkba5zERj6/PgFkJuvSXAd+Q1Zbqkg+b5
	 /uohfetnD+ZnL/ZDSga02zWy4PsOqb/++WP1XzNEZqaGckUbwt1HbUhJwt2v3PP6dz
	 iFjR7j3O6fQmKeqY16gzNjutQ69qkx70iCln2mDM=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Ensure locking/ref counting for OA whitelists" failed to apply to 7.1-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:08:15 +0200
Message-ID: <2026072915-liability-ideology-11d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x ef78e2a22f72c892fd6663f0760abd208d49a3e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072915-liability-ideology-11d9@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef78e2a22f72c892fd6663f0760abd208d49a3e2 Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:27 -0700
Subject: [PATCH] drm/xe/rtp: Ensure locking/ref counting for OA whitelists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since multiple OA streams might be open in parallel on a gt, ensure that
proper locking is in place. Also ensure that OA registers are whitelisted
when the first OA stream is open and de-whitelisted after the last OA
stream is closed.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-10-ashutosh.dixit@intel.com
(cherry picked from commit 645f1a2589bd4782e25490e5ecc05b7043c36cbf)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_oa_types.h b/drivers/gpu/drm/xe/xe_oa_types.h
index 3d9ec8490899..e876e9be92ba 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -126,6 +126,9 @@ struct xe_oa_gt {
 
 	/** @oa_unit: array of oa_units */
 	struct xe_oa_unit *oa_unit;
+
+	/** @whitelist_count: number of open streams for which oa registers are whitelisted */
+	u32 whitelist_count;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index b2e7aabd19d7..3d9e3daab01a 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -255,6 +255,10 @@ void xe_reg_whitelist_oa_regs(struct xe_gt *gt)
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 
+	lockdep_assert_held(&gt->oa.gt_lock);
+	if (gt->oa.whitelist_count++)
+		return;
+
 	for_each_hw_engine(hwe, gt, id)
 		__whitelist_oa_regs(hwe, true);
 }
@@ -270,6 +274,11 @@ void xe_reg_dewhitelist_oa_regs(struct xe_gt *gt)
 	struct xe_hw_engine *hwe;
 	enum xe_hw_engine_id id;
 
+	lockdep_assert_held(&gt->oa.gt_lock);
+	xe_assert(gt_to_xe(gt), gt->oa.whitelist_count);
+	if (--gt->oa.whitelist_count)
+		return;
+
 	for_each_hw_engine(hwe, gt, id)
 		__whitelist_oa_regs(hwe, false);
 }

