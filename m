Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00E2381B16
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261243; cv=none; b=GvLRAiCMuWK5kYCvLFqg5kXdpg24F3ElaPdzymkauT2WajhUcLjnV1wufY7/iDfWBdn+rX24iHCIXcMjfjahP05Ud1ATmLn2atYv5QOsxH4ZKY47+bhuKvRb+ETO7z6h/SU0Z0vx4S3udFf2+FqpaFi50fAjcbfowraPpOhPOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261243; c=relaxed/simple;
	bh=fgXuGaYQAbGa3WhHVyJJdw4JXQq/HYrMOeQxksWnujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfX5uRtbnHzXLuGxiQ6WC5Mr1X7FKqcxyIIFafS5pWGDy2VvEOxhgBAinu6JkyMttD9qqvWNXPnexUVf7dkFwZGo2iQaE+rwFo+yT8lhMd35ftl+thMrlg7Cy9CDZWHIZavcSXhk7LtOJ6ymAuiva8NuJN9eUwZ1Sya3uyyN7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwa8/t/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwa8/t/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0721F1F000E9;
	Sun,  5 Jul 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783261241;
	bh=TUrFqaRATt5lartRZrrpZfh/0+roeK0Ai86lBFndB+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wwa8/t/wdTFOEvYlNXUddry7pEwgKfXzUNy3RPmR+jhk544X4IpwgqOzyvWE0GG3O
	 Rwug+dKbkZ0E0CMWt0Jo6Kh5COZY/PNHruUpUlf9zZAlXkvABSMa8WV1uYhz7BmvC7
	 JWNXP9ETHdNO4CANKm3/kr91LogSj0Ibhiaz7a0BAr2PGvC9mCg+jb/IqRPktztrDM
	 oH668Fyl1zWg0mrV4U6PD073oXfq0909DtvQAhz+Jc6rWothtuUeKzbiYj3PVVAane
	 JH8p7CswNwZp/RBorSyR2nHJridbCDfDsG9ZZwJxel6AtSCaJdvw9i7wOn851z4cAS
	 2Fja90hQBhfzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] NFSv4/flexfiles: reject zero filehandle version count
Date: Sun,  5 Jul 2026 10:20:39 -0400
Message-ID: <20260705142039.1791851-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070244-oversweet-untaxed-e3da@gregkh>
References: <2026070244-oversweet-untaxed-e3da@gregkh>
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
index ee103cde19cdf2..01d9922ee71297 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -454,6 +454,10 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 		if (!p)
 			goto out_err_free;
 		fh_count = be32_to_cpup(p);
+		if (fh_count == 0) {
+			rc = -EINVAL;
+			goto out_err_free;
+		}
 
 		fls->mirror_array[i]->fh_versions =
 			kcalloc(fh_count, sizeof(struct nfs_fh),
-- 
2.53.0

