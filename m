Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586AB42E8F0
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563966; cv=none; b=SOSTLFhYSe7oInzOQsK32ySqVL9L/s6eVlwRs4MhRwDIaQiWOhu25NdxrvK9NDk3YMIEK3oGWv0LzBIO6C77eDGikGUe+GVtb6Ea2O87KTeKPmhX9DeWdoWS1QCaxKcudVvBaBBu35spp0kTSxp5TlivnsLxNazoDetZgGM5enk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563966; c=relaxed/simple;
	bh=a2ZZMaJJX11jMm1fziyeW907sZAlJi1S3GQx6AhZjmw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TPKBoprtm0PwCZkwT/dTK3F38P5ltHyukmhcjr2zitEgxohPlkAHpYS7LbejbI04IWZH6guXlEk9C0VWZWel4PU3sqcBZNPPbngqk3vPdw9GuXxkzqLz+wOwPUK54WMt47jV9W460Quwinc1s3DU/TgrH3XgZBE4Sngo+HZ3rhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MJ1zoMoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MJ1zoMoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B271F00A3F;
	Mon, 20 Jul 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784563954;
	bh=oUNyxmNXT5U9odO3wAXW/vHPApaY9iRubunUkvKsw2I=;
	h=Subject:To:Cc:From:Date;
	b=MJ1zoMoCe4o5lCN9i7bd+SVPkl03Du9dsyHWnbSoWck8S5mgRlOsuMrPLBJa+VGfw
	 WSoHpq/JfuVqiLBoQl+YiCzk9lxK0HDLWSsOa4yrtZ2T1mKOWkkftOS2ygQV8icEdU
	 wqe8ubJfROUY5TPXxpzdcq521ytIi7o37LSQOE8U=
Subject: FAILED: patch "[PATCH] octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own" failed to apply to 6.12-stable tree
To: moonafterrain@outlook.com,danisjiang@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 18:10:17 +0200
Message-ID: <2026072017-lullaby-pancake-44fb@gregkh>
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
git cherry-pick -x 8cdcf3d2caacdee7ddd363705fb4d93b0c1a0915
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072017-lullaby-pancake-44fb@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cdcf3d2caacdee7ddd363705fb4d93b0c1a0915 Mon Sep 17 00:00:00 2001
From: Junrui Luo <moonafterrain@outlook.com>
Date: Mon, 15 Jun 2026 23:04:27 +0800
Subject: [PATCH] octeontx2-af: cn10k: restrict VF LMTLINE sharing to its own
 PF

rvu_mbox_handler_lmtst_tbl_setup() uses req->base_pcifunc as a direct
index into the LMT map table to read another function's LMTLINE
physical base address and copy it into the caller's own LMT map table
entry. The mailbox dispatcher authenticates req->hdr.pcifunc from the
IRQ source, but req->base_pcifunc is a separate payload field and is
not sanitized.

Reject the request with -EPERM when a VF caller's base_pcifunc is not a
valid function under its own PF. is_pf_func_valid() bounds the FUNC field
to the PF's configured VF count, keeping the computed index inside the
caller's own slot block.

Fixes: 893ae97214c3 ("octeontx2-af: cn10k: Support configurable LMTST regions")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB78811656934E713B77DA6CEDAFE62@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index d2163da28d18..fa4ea1258d29 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -178,6 +178,15 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	 * pcifunc (will be the one who is calling this mailbox).
 	 */
 	if (req->base_pcifunc) {
+		/* A VF is untrusted and must not redirect its LMTLINE to
+		 * another PF's region, so confine VF callers to their own PF.
+		 */
+		if (is_vf(req->hdr.pcifunc) &&
+		    (!is_pf_func_valid(rvu, req->base_pcifunc) ||
+		     rvu_get_pf(rvu->pdev, req->hdr.pcifunc) !=
+		     rvu_get_pf(rvu->pdev, req->base_pcifunc)))
+			return -EPERM;
+
 		/* Calculating the LMT table index equivalent to primary
 		 * pcifunc.
 		 */

