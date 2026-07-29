Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650D46D2AD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322765; cv=none; b=UNupykwuaa1P5Zo05KQESAR6zq6aJ6eJ5AQm5UoPh2D2Xaba8XzGubJVvUZlQ/uSKXFrhim76Q8H8OSbIfQr62Sg19bGr2v7GTcfxGLBm5j4KR8WsUl4pInS7KHXkxePHYOrp1Sa0Isc4LKs6nRgLgH6JRXonic2iq8i3NK0yB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322765; c=relaxed/simple;
	bh=s5Pcu1+ZIA5a3a1nKPazufFlGOSIbBdDMJiDOU8CpIs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gGYTckB612Sf/2co/vuq9sapWkv5R5zbS+62RRyfS24ZHMoWs6m+0uNtytWaDomhuD1ZuJ9Ox31W7D9WTgKVfJ0oDYNptcfA2tt3ZSIbeJgcoSk07x03zC1eiur6IGlgvKCLGl5dIrEo4CoyvaVbj8Uwe85QxWKDhUIt/F7mLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J7Sw6stn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J7Sw6stn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F381F000E9;
	Wed, 29 Jul 2026 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322763;
	bh=muRPqdyyoP+HxXsQ9mwdKSQdBtsg1XkFiygWoN16hW0=;
	h=Subject:To:Cc:From:Date;
	b=J7Sw6stnRI/tVrpW7HjMC9PYi6Fq721L8XCAUsJrUFJeG9BFtRoS1JKgzuZ3sb1LS
	 RjICSvF4VCmY+sL0+mll5sYNm+dtn9QCI++3zcGMF1Adew/vEHImHb3L4BwhxNJOw2
	 fSwTt0vd+hwTYj1Bf/bmZ8D8bldwsywC/3DjtxOU=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Save OA nonpriv registers to register" failed to apply to 6.18-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:59:10 +0200
Message-ID: <2026072910-gallstone-patriot-218f@gregkh>
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
git cherry-pick -x a19a83721a28ccaddace846da70da5c53d7dd052
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072910-gallstone-patriot-218f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a19a83721a28ccaddace846da70da5c53d7dd052 Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:23 -0700
Subject: [PATCH] drm/xe/rtp: Save OA nonpriv registers to register
 save/restore lists
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 3a3c3e56db2923daaf1a5353cd6463a4cdaf4ffa)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

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

