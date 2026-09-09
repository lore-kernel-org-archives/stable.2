Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313955427EC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954621; cv=none; b=liayG9TN7GJ2RJA1NL/N6N48MsgJ41bx6DHfTngTR/CtJ7ZxKX7rQisBFUhBhijC5pzP9V65qnk1laDWZ/epjxLiqteAOGGGmetUe3LW7e0JEex50e/JbTapDY1KCDUs64ZBZ3e3NTzZp2dC5JuViKvCPvvSp0LrLyRxzyyAVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954621; c=relaxed/simple;
	bh=/QuUJ0GThg/Wk3VZ2jINVBwCv5EeQgXGXaqSmHuTTw4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bu6BPS1B2wvLkwGsU+GZysne1gFB91bzBZHWvzpQ/XrPfYQFpB7m5hfU459lvutpgORx2NUKVXptDs6GFc8q+srI8STUUAAVX98XhMNUbM/5OYvimm+S/2/X2t34HnqZI5mCPR3uLZxjAJSxPMFdozGxVhlQaLJ+2Yl2dF+YaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PODzfaS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PODzfaS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6181F00A3A;
	Wed,  9 Sep 2026 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954620;
	bh=khl0fux2MmbL079MYwhtOHLgfEEJ8besOiFdRo10Th8=;
	h=Subject:To:Cc:From:Date;
	b=PODzfaS4X3EjUkvJKMTuHDSSgXsm2xBv+UbQ37L+wNqTztVAqChxGjRY1b89EJI6P
	 naNyHVeXDn2kzRFbN4xEf3EhA+zLt2xW1BBH0r+/Y7bEIvxGx67wOGvbRmkiC0S/Jq
	 62B4fVWmLBmzYphBVkv4LAarVvOt4h23ROOUHR7s=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Ensure locking/ref counting for OA whitelists" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:42 +0200
Message-ID: <2026090942-reformist-removed-56cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 645f1a2589bd4782e25490e5ecc05b7043c36cbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090942-reformist-removed-56cc@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 645f1a2589bd4782e25490e5ecc05b7043c36cbf Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:27 -0700
Subject: [PATCH] drm/xe/rtp: Ensure locking/ref counting for OA whitelists

Since multiple OA streams might be open in parallel on a gt, ensure that
proper locking is in place. Also ensure that OA registers are whitelisted
when the first OA stream is open and de-whitelisted after the last OA
stream is closed.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-10-ashutosh.dixit@intel.com

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

