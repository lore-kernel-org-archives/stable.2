Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D6353FD21
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954624; cv=none; b=oa17NPLvwD6CYCTM0KCEPj5znqK+NycCv/TKtFgOlu6WFZJU+029HfXRZZ23dpQjy0WXsjyEWvLJ/K7siXJwcpsya+RWnKGgrek4/1asAa4dpEX3CI/+XC5eoaShgelwhF0mUJQ8jI+BHeW4VKqM0tces9JX6ivvmxqZIcD2lUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954624; c=relaxed/simple;
	bh=GvgxTA5bWJoJYRIzFSD2eoHt9IZcYySffE9jX63rd4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t199eEI0RMsqVmVTNOAH0xQ2S6oQkORLPoe/wgYf7H/s9CGYhM8LJT6z03ZhqB5sDF8pcv/dA64CnlAndNFIjfU5S0GwXJ7eQwlssbbGFWZkrxsFB/QaUROm+yEgSabzRsm4CkgvRrwMdzJIfqVSJKjV2uunOneSS1bAVhp1g1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gZB93cDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gZB93cDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E99D1F00A3A;
	Wed,  9 Sep 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954622;
	bh=lVx/KndrpW33f7cFDtkOZTuWSi4PukFLCMLdyqCx2gI=;
	h=Subject:To:Cc:From:Date;
	b=gZB93cDvao+M73OL78MqQiSPPWRMoNucxbm0KfqAqyiLGyAp/oMQAvKGI0FN9aFba
	 TZpPFOdPu7MnnYIWj4+WChtNGOfDGUamXd/DVUXUJvl09nvcj2CUNJ5GHg3DQIbNro
	 HgM4/iPeXaGwuHYjH8BfMvh4HyNaeElkQbxzTZEc=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Ensure locking/ref counting for OA whitelists" failed to apply to 6.18-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:42 +0200
Message-ID: <2026090942-corrode-stranger-b759@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 645f1a2589bd4782e25490e5ecc05b7043c36cbf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090942-corrode-stranger-b759@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

