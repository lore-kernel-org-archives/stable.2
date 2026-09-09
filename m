Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964453D0BE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954595; cv=none; b=M62jjlq67TZobfQSwE0X6affbzWn3C51YP2TyFp8ms+/Zfke6ZxbtVUrhq0azW8C+D0Fr78aBnIvl6wYJiRXwN243Om1aXJ7mmpqZ+an4C4F+kAGzVSpxF4ZTRUnuU5pG4jIqhfjjvUZazUW7NqWpdoZxenYaYgMPS9lpmXa0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954595; c=relaxed/simple;
	bh=NA5R6np4adavuiuimzbSupr5VpXkkIcS3R9iRqHGC3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pIPTCRzEy8rxwPVcapLxVALjbrXvMBUOoVOHEgE7Zz1ypR4ENevvKdcsiznyuIHiB348snJX7O/ZfT8OJYrTzrg0YQAM/2ucPmECgVxHnudB/IdlCeByLvpEd4VAQxZxxmXcxZ26gxpnA5a2990ho+HPxkAFzRrNubX5l2dy+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fk4QUW7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fk4QUW7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C91F00A3A;
	Wed,  9 Sep 2026 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954594;
	bh=QWYCYdkWsXi8L5EP2gGAF7FPuaBny+18TaPf3jDs0kk=;
	h=Subject:To:Cc:From:Date;
	b=fk4QUW7rCf5ZXuV5hHJQ6VdJ7KUAUJ7fwQ+z4Rn9D5hRl9Hh84KYuH+5lAbLFS6Xj
	 Jp3vcO/WgY7h6KVikKrH4xlA3FzsHDmhef+WTJATBUDeBnl5GweNzq7JfesropLV62
	 KCJFloGzJjns8MwOCCdK4OLRUFe2amEHoDv+sxTY=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Save OA nonpriv registers to register" failed to apply to 7.2-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:14 +0200
Message-ID: <2026090914-pointing-dispersal-c779@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 3a3c3e56db2923daaf1a5353cd6463a4cdaf4ffa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090914-pointing-dispersal-c779@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a3c3e56db2923daaf1a5353cd6463a4cdaf4ffa Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:23 -0700
Subject: [PATCH] drm/xe/rtp: Save OA nonpriv registers to register
 save/restore lists

Now we can save OA whitelisting nonpriv registers to register save/restore
lists. OA nonpriv registers are saved to both hwe->oa_sr as well as
hwe->reg_sr.

During probe, resume and gt-reset flows KMD will apply hwe->reg_sr,
ensuring OA registers are de-whitelisted after these events. For
engine-reset, hwe->reg_sr is registered with GuC and GuC will apply these
registers, ensuring OA registers are de-whitelisted after engine resets.

hwe->oa_sr is used for whitelisting or de-whitelisting OA registers during
OA operation, by toggling the 'deny' bit on oa stream open/close.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-6-ashutosh.dixit@intel.com

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index e9d0a0b82527..76ac23644a4d 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -215,6 +215,18 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, &oa_whitelist, &hwe->oa_whitelist, false);
+
+	/*
+	 * Save oa nonpriv registers to hwe->oa_sr, from which oa registers are whitelisted
+	 * or de-whitelisted, by toggling the 'deny' bit on oa stream open/close
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->oa_sr, first_oa_slot);
+
+	/*
+	 * Also save oa nonpriv registers to hwe->reg_sr, to ensure oa registers are not
+	 * whitelisted by default after probe, gt reset, resume and engine reset
+	 */
+	whitelist_apply_to_hwe(hwe, &hwe->oa_whitelist, &hwe->reg_sr, first_oa_slot);
 }
 
 /**

