Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878A4A92E8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440778; cv=none; b=pXfhY4xclTFT4Z3v9jny2Lq6cqJPcS9Qb6MzW4ZISuvSDDNPoMOS2k7TQK3TXgawb6BIxVs4efcmUAtbj6bdpKzkEwvaACuE+enJRH1tn3I7ALgqFgSUMSNmGdsw+q9JRowjuYo9CeQVmGQhN6pX+g1OeSGpUDubbLAsGo4THfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440778; c=relaxed/simple;
	bh=FEGVTMyzgtO0kmLrqqwkEBg7JXRvfbHrrGSJL8Jn7wU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jSRt7lY9275msvzS2A0NHKMNWAkk7//aEGvGq5p8EMPhEZFFsglrSv97yk8o/vruPbxidn5NtCXS4FK4u/Qkkjcl1uFt7XJWZ8g4qoci0RKJVjemtOMKR+D6xSpMQxzESbn+DIkHijDRooPxK6pPhL8LDsZl+0m1ETgT9zoPihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=keH2E/Xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="keH2E/Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D861F00A3F;
	Thu,  3 Sep 2026 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440771;
	bh=nS10n4mf5mGO1eB+zI6Vzl4Mg8v7l7VIfB0FPbD4sqA=;
	h=Subject:To:Cc:From:Date;
	b=keH2E/XvUSiKD5ZR6ZbLRc/C6rq7VZQ8F9JQmk9YshdXdLbRYc3jc9s5sL1Nxf+Xt
	 RAfu2zvr+9zsZ2ocrY+PhwbMmGV/TPmu3PdqWKbCyEhZxlQTWxOm5SngS+JC6RFjO+
	 q1MpdIVMgEsMMcO5WjPpSijrlidDSUm9rEEWPzoc=
Subject: FAILED: patch "[PATCH] cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER" failed to apply to 6.18-stable tree
To: terry.bowman@amd.com,alison.schofield@intel.com,dave.jiang@intel.com,sashiko@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 14:59:16 +0200
Message-ID: <2026090316-wildfowl-boasting-efe0@gregkh>
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
git cherry-pick -x 29458e62d0829cbc99435f3e44fd560f9bbf1da7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090316-wildfowl-boasting-efe0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

