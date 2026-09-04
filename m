Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B924F475B
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535700; cv=none; b=PdvX4tw08xcclYWMVM90+6hJEH4aY01OK0znHFjZRsNY/v++uY3C5ChKPLJelps3hQ24ZzLtMEMY+08NLTQnNdtuCV1wAhj+KNSC1Gu8/MUxLrFJkjI23+jHt+ZAbczrusWaw75lRvmHAGHaeGCWqQKN41Vl9ZGmYTDToXwbQrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535700; c=relaxed/simple;
	bh=QHTn6kqHTIoRzBOeUJQZCBMQ2rXU6WhIuTYxP1FPn34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqRxidIWQ5cBrfMbt+sDWCuUZZL0GcPt7toqIGgGizDxPQSKUu5qeeUTT7RphRi/eBAhCQWuNnxiCdxfyA/USgYXpVGvJITJ9tFYFUmaU0jF7FWpdoBsQ3mNsh3alONleD9EGE/GgjsfJjcLF/DDc4y/EJgFwIxvhC03fDzJw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrDJOPmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrDJOPmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DC41F00A3E;
	Fri,  4 Sep 2026 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535698;
	bh=LEVX/++cD7s7mxdvPvV9R+VOUu03emkArA5O6DJzODs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CrDJOPmBW/O7mIyYy5VQI9NZ+fRuDv3702uSHe8k7w2NZenhr5NcrbK/dpfeWtk/0
	 uUNu5CJnmK+Ts3lYwfC+AjQHecwGBgBalVHhtuDUsdF7rPzFYn3TQ1ZWM0LP9Uz5lr
	 mxsNp69F71Xm2pzCws+4xZGJJAut8Im38WifoU8iNKy13fmnrGwhEJVZPS41FI90Yc
	 cUkIiMHpIHCvSkgvNa1OQjX+iG5yAnm6xMY+ymIt/wrTMAAYDbQuMdPh/1e3l5VZG7
	 cIanIjUBPL1VBd5l77omFbQwD9G6zWIRijr3MR2V3PlgL4g4G0ytGHcOdS/8insXMl
	 YZgAhGelcMO6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Sashiko <sashiko@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
Date: Fri,  4 Sep 2026 11:28:13 -0400
Message-ID: <20260904152813.899321-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904152813.899321-1-sashal@kernel.org>
References: <2026090316-sincere-breeding-8254@gregkh>
 <20260904152813.899321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit 29458e62d0829cbc99435f3e44fd560f9bbf1da7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/ras_rch.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index ed58afd18ecc9..5170cebf6637b 100644
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
-- 
2.53.0

