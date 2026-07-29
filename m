Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3145A2B0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323320; cv=none; b=Ez5YGFh97K/va6v4aX3Ukz/pe7E3ivXYidden/IStdmhdBdxy7OHqemUrvlYPnFalOqzZbOJLccw4Q51gq+3RP4QftbMDuOd+hY0QxSwoCzJcQ0bIBO60/kryYRuUryoZKaEFimMkMCVB/AxCQzXBJ+WszLclsHxj3pHhwqj5g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323320; c=relaxed/simple;
	bh=umMUBVyKDrtxmWapO/zOcorJ7mYWFWceQrazhJr7Q18=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T+Q0XfpoNcpWyDM+wOqLMosUYWHL3ed7QFmDVmU1vAyh4bfVBa5yedaVafvM6kjMRns57Wid4nTcFFnaTWeD7FQlzF7Oehm0iwSjulpNI6mbaDAj/ynBmiaQLN95LC9vfJNuTKW7UaPpw4CtUoSgardEWTl4yU16T3G89BQMHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpMj7hjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpMj7hjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0123C1F000E9;
	Wed, 29 Jul 2026 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323319;
	bh=XRxgLFWmRJkRtwJrkWYTX+T3zBLgKvwFmA72VnypMx4=;
	h=Subject:To:Cc:From:Date;
	b=cpMj7hjNPNbFjKLiy6t6ApIGUVJX9q7uBQx3yZGMRJu3Xo3Bc+Wv5b33TEMP51ft2
	 X8c3WFCWTCR4MUulGJ3Nbxf8Y0O2UEZPAM2evuMZ8A+Wlc0ZlsziH5hpQ5931YEHWj
	 UONJwEE//Y7W3+38z4X7u20xMqwig6XMk/OKKi1M=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Ensure locking/ref counting for OA whitelists" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:08:15 +0200
Message-ID: <2026072915-scratch-tavern-3987@gregkh>
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
git cherry-pick -x ef78e2a22f72c892fd6663f0760abd208d49a3e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072915-scratch-tavern-3987@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

