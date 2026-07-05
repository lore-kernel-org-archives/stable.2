Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BFD23BF9F
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221117; cv=none; b=fWMcjSBfl6P+/KXeT/HGK9596+jnqoeDgCgo/BcHFS2l19VskA3dDliNXQFeNlrfPaDkkJtt4hVtCidfjhmxmSTmWs+4MmUyqTQHdOWqHuyJrQ6RCMqP7n7OqRNCLEbay3XE0vV20/N/cv2TXqwALHyeN0hs5V+umMdqB+ahnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221117; c=relaxed/simple;
	bh=YeelmSk3cumN+KTkcyriivXDUtlQbzOHOnXHV1FLjPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMTuiwHQaf96cDHe/HDmzJupg49AiPZqO+TnlnrWaikkgywFhQXoJy+vUCIe4beYpp3w5qFDCuXyt2p2+McoJbQdCvjnJXc3vyQV/SE09R0cjIHNR39OGpBEimgmtIGSbketKzyy3pmGP0Uol1QY9gTx1o+ttNkThs8DE28iFA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpTRN+uU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpTRN+uU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F61F00A3A;
	Sun,  5 Jul 2026 03:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221116;
	bh=nvIAH+RO5orIMmzXxrRsqa3DaB0LspF9ac/RiiMhay0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CpTRN+uUCAbPVm91qpxBYb6qv9Blz5ctZwpMbdebHQss50oRtxWA4Qwy3zV+8KMGB
	 hCl58UUp4kMLulEodcYZTK9hddUoWy4d+L8yLrFFqh57kLn3bIb2MXHPhu2rnLnNmC
	 xHxup8d2vUO2Wz8MtPZSQFOsizlooyYVYHaFSoHq6ksA7/j2pxV0VnyiuBI8AYR59i
	 4t7eaDnpohN8xs0SSfGs8gn+kxsvX4WHe84eGmsJM5mGjesjI6OQ2cIPuoHSwUcDh9
	 9pC2YKsojP2cTvpa/qysXtz2J909y76FFXkjv5RitximHdZ6PVrnSMH6EiWvY1+upA
	 RFFoGs7rtL4XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] NFSv4/flexfiles: reject zero filehandle version count
Date: Sat,  4 Jul 2026 23:11:50 -0400
Message-ID: <20260705031150.1600970-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705031150.1600970-1-sashal@kernel.org>
References: <2026070242-poker-barricade-3a69@gregkh>
 <20260705031150.1600970-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit 2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2 ]

ff_layout_alloc_lseg() decodes the filehandle-version array count
from the flexfiles layout body. The value is used as the count for
kzalloc_objs(), and the current code only rejects NULL.

A zero count yields ZERO_SIZE_PTR, which can be stored in
dss_info->fh_versions even though later flexfiles paths assume that at
least one filehandle version exists.

Reject fh_count == 0 before the allocation, matching the existing zero
version_count validation in the flexfiles GETDEVICEINFO parser.

A QEMU/KASAN run with a malformed flexfiles layout hit:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:ff_layout_encode_ff_layoutupdate.isra.0+0x15f/0x750
  ff_layout_encode_layoutreturn+0x683/0x970
  nfs4_xdr_enc_layoutreturn+0x278/0x3a0
  Kernel panic - not syncing: Fatal exception

The patched kernel rejects the malformed layout without KASAN/oops/panic,
and a valid fh_count=1 regression still opens, reads, and unmounts cleanly.

Cc: stable@vger.kernel.org
Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 36270f6a759ec7..7e1494cc116b29 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -493,6 +493,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (!p)
 			goto out_err_free;
 		fh_count = be32_to_cpup(p);
+		if (fh_count == 0) {
+			rc = -EINVAL;
+			goto out_err_free;
+		}
 
 		fls->mirror_array[i]->dss[dss_id].fh_versions =
 		    kcalloc(fh_count, sizeof(struct nfs_fh),
-- 
2.53.0

