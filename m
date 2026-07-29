Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD3472775
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322795; cv=none; b=hrgc54VcDCNOclKuhFvTGwYTUsviwKOlO0j6jfQ7VakAVhAtb5ByfqoPhjjdQtS8AKO/72kAkriXq5jpnhzYh2tZtWDx+FwrNli2DxtSwzAGuprleih1tyo+lzi/uAHFE2atRWyjm9Q2Yfo3og7YO0MoxH2fvAEX0W6qBNkhcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322795; c=relaxed/simple;
	bh=ED/8fVBH9rJOvuMr6AM4lJMNxurz0TBj0jcPjMdTyag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U7NvG6x829EQJkGokB98D+dVqNXnDLnbcfWgQ771Y8ftfij5hENFXwm8KblpXRfrI5MhpotmjdC1rIAjJFuR/NEQWy/Ax69ijdhNsx/ydmTbqAZlt/vGnu59mzfJITZzjD+pmqMBPoJ5CtwqOS6rIhg3NpFOyMnKmkVH9JDAwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHJMB0HO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHJMB0HO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA83D1F000E9;
	Wed, 29 Jul 2026 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322794;
	bh=L7JJqzSoGO2Hmz/ErrjGcuI9THja2cM+2OhI994GlX0=;
	h=Subject:To:Cc:From:Date;
	b=oHJMB0HOGYfYzKotUZK+JcQEFuC+c8OzTI0ztYaINiFmK9v1efzDHl3YXx2euRGKV
	 hZwGQYLHIV6xLRWNqRno7eN2xMaAnlaIjzCqThluuxKG/IDSfzKQ0bxRReaUA1gYjK
	 wXeUCedt9MaLFaW8VyBeNc1KJZYm/qTaCzyXC5Gs=
Subject: FAILED: patch "[PATCH] drm/xe/rtp: Generalize whitelist_apply_to_hwe" failed to apply to 7.1-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:59:35 +0200
Message-ID: <2026072935-amendable-operation-7016@gregkh>
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
git cherry-pick -x 4fe2844b0f0c7cdc45ca4c4c62ca56b7f26c514c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072935-amendable-operation-7016@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fe2844b0f0c7cdc45ca4c4c62ca56b7f26c514c Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:22 -0700
Subject: [PATCH] drm/xe/rtp: Generalize whitelist_apply_to_hwe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generalize whitelist_apply_to_hwe to construct both non-OA and OA
whitelist nonpriv registers.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-5-ashutosh.dixit@intel.com
(cherry picked from commit c3ff77d7235ccef7a0883c2fd981f70ef3aafd21)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index b5ae7d26e5ba..e9d0a0b82527 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -161,9 +161,10 @@ static const struct xe_rtp_table_sr oa_whitelist = XE_RTP_TABLE_SR(
 	},
 );
 
-static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
+static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe, struct xe_reg_sr *in,
+				  struct xe_reg_sr *out, int first_slot)
 {
-	struct xe_reg_sr *sr = &hwe->reg_whitelist;
+	struct xe_reg_sr *sr = in;
 	struct xe_reg_sr_entry *entry;
 	struct drm_printer p;
 	unsigned long reg;
@@ -172,7 +173,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 	xe_gt_dbg(hwe->gt, "Add %s whitelist to engine\n", sr->name);
 	p = xe_gt_dbg_printer(hwe->gt);
 
-	slot = 0;
+	slot = first_slot;
 	xa_for_each(&sr->xa, reg, entry) {
 		struct xe_reg_sr_entry hwe_entry = {
 			.reg = RING_FORCE_TO_NONPRIV(hwe->mmio_base, slot),
@@ -189,7 +190,7 @@ static int whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
 		}
 
 		xe_reg_whitelist_print_entry(&p, 0, reg, entry);
-		xe_reg_sr_add(&hwe->reg_sr, &hwe_entry, hwe->gt);
+		xe_reg_sr_add(out, &hwe_entry, hwe->gt);
 
 		slot++;
 	}
@@ -211,7 +212,7 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	int first_oa_slot;
 
 	xe_rtp_process_to_sr(&ctx, &register_whitelist, &hwe->reg_whitelist, false);
-	first_oa_slot = whitelist_apply_to_hwe(hwe);
+	first_oa_slot = whitelist_apply_to_hwe(hwe, &hwe->reg_whitelist, &hwe->reg_sr, 0);
 
 	xe_rtp_process_to_sr(&ctx, &oa_whitelist, &hwe->oa_whitelist, false);
 }

