Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817A4A5C3D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440780; cv=none; b=JyxDBhdHEoi4IDrz5pK4j2Jk3VdG6cFGBhylpyGnTbmOs14B8SsVGfq31TKvOVXM62St2qsFrYBQZ/eGBVZ0cHRkcHlEMqhedrjHXk5jrgTX/g6/ThlQFYixICYZM7Ta1Oaw9s+4798AmmwmpACzs0tEIF8wWCBXEoQ9OIm7Ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440780; c=relaxed/simple;
	bh=3zEtUuaj3X8+2zrkZP3cXnzxmPlJ/QYWXxUdRnzcxdM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S7BpUxM5A+ineBIoMX9D5Zbu8xAtP2vg7xlei52NKk5+oGpgng9aGnKifY4ZaXF+k9pA7WpZB81VolOcmi+vRpE6TYo30eGeBKDw/xEOO8w8o2ILtKz2IuxGp55nTn4oO/+3xecAHtQ3D6rpinlrkpIpK68MyNVgJIoXl/F02Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrdva9/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrdva9/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09A01F00A3A;
	Thu,  3 Sep 2026 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440768;
	bh=pJYNpkJsbxJHE+F+HJElg86Iq08ufcDJ0O51LBrBj8A=;
	h=Subject:To:Cc:From:Date;
	b=hrdva9/g8YhKRqFFa+asa2JGA58wXNRsiPRHYaz+Y1/xpBA/a49BH/YFMq4lydrGW
	 0nyTgMm7x5hc45+7ZML5I5pECypEKILAIzPH0EXF1NVW7lpd5d2bhsJQkK2Mo+t+mI
	 +FTazDFGKqS8R6K5jDAwG8OBw+opGMKZj8qCL2TA=
Subject: FAILED: patch "[PATCH] cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER" failed to apply to 6.12-stable tree
To: terry.bowman@amd.com,alison.schofield@intel.com,dave.jiang@intel.com,sashiko@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:59:16 +0200
Message-ID: <2026090316-sincere-breeding-8254@gregkh>
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
git cherry-pick -x 29458e62d0829cbc99435f3e44fd560f9bbf1da7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090316-sincere-breeding-8254@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29458e62d0829cbc99435f3e44fd560f9bbf1da7 Mon Sep 17 00:00:00 2001
From: Terry Bowman <terry.bowman@amd.com>
Date: Mon, 3 Aug 2026 17:17:57 -0500
Subject: [PATCH] cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER
 register read

cxl_rch_get_aer_info() copies the RCH Downstream Port AER capability from
the RCRB MMIO block using a readl() loop bounded by sizeof(struct
aer_capability_regs). This struct is a software layout and its embedded
struct pcie_tlp_log is larger than the on-wire AER capability. As a
result the loop reads past the mapped AER register block.

The over-read also populates the software-only tail fields including
header_log.header_len. An out-of-range header_len passed to
pcie_print_tlp_log() can then loop past the header log buffer and cause
a second out-of-bounds read.

The read was correct when introduced, but struct pcie_tlp_log has since
grown (Header Log and TLP Prefix Log sizes, header_len and flit fields),
so sizeof(struct aer_capability_regs) no longer matches the physical AER
capability.

Bound the read to the physical AER registers, header through the 16 byte
Header Log. Zero the destination first so the software-only fields are
deterministic.

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Reported-by: Sashiko <sashiko@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20260803221810.3685703-2-terry.bowman@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b6388..8a3965edaa12 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -58,13 +58,28 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 				 struct aer_capability_regs *aer_regs)
 {
-	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
+	/*
+	 * Bound the copy to the physically-defined AER registers (header
+	 * through the 16-byte Header Log). struct aer_capability_regs is a
+	 * software layout whose embedded struct pcie_tlp_log is larger than
+	 * the on-wire AER capability; copying sizeof(*aer_regs) would
+	 * over-read the RCRB-mapped MMIO block.
+	 */
+	int read_cnt = (PCI_ERR_HEADER_LOG + 16) / sizeof(u32);
 	u32 *aer_regs_buf = (u32 *)aer_regs;
 	int n;
 
 	if (!aer_base)
 		return false;
 
+	/*
+	 * Zero the destination so the software-only tail fields
+	 * (e.g. header_log.header_len) are deterministic rather than
+	 * left as uninitialized stack, which could drive a bogus loop
+	 * length in pcie_print_tlp_log().
+	 */
+	memset(aer_regs, 0, sizeof(*aer_regs));
+
 	/* Use readl() to guarantee 32-bit accesses */
 	for (n = 0; n < read_cnt; n++)
 		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));

