Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708303;
	b=AxksdRKAjtxnspOodN4zv+HJgOPqh/kQF1I3V/eQsaIP98EY5I+33isE5yrrx2IetizU
	 gEjbkTIpkBpTd3ES1Kh3QKG2AeErqOmdCRGegeUAsUKr1l35qDyJUw27cxF+3jmUqEXOT
	 PHtS3251wMDr+1KkKuZ2of3hgNsBfMbZfCta4lYTn3WoF/skiQu9ZUwcASEON6qJitg++
	 YlPLeSMCHCZj+RKSp43YFUod8dOPJe3M3HdAPklOGfDt3QA48GeqNa7mHx4YCW51xpAUw
	 MEY2S95IauLOdcMElkEBtSRR/2YqUAaxyaa5duxcjxvHqGya7F3vxMVggQZnKnJny+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IsX6i/arkXv76D0Oz+26RxsybxuShnCTv57q518OhQs=;
	b=QXMPbpH6Ey3Q4YvJOGkqLCGA66HltbYV+iM2pO5waYiJAflTDHJNoPKuzt/NTtJkrYPC
	 bqe/eAJIteUanYi3qvm9Lg9cBcu1pHv/wU8cuw8OHSHOjwPPrdcbJ1EseoJ9DlSBlqo57
	 7k8xTDAGdDB1pJUGDycg4ZdIL8IU4l4DLU1C3HERJ1zzttlGqdYnyEhr0O4RP4WbiJUOo
	 2zgChPZ/1oMYHaNAYskA0FGOsVmUQ0s/WNL8LZBq77cW/hMr/kfhp+UhktqwmH9idcckU
	 GshFIL/ryp4mtIYISJyuQUGg3GuBEIGEF7i6dgSOmarn7K9UX4cJg3tRPPrM9vfXZSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXJeFddG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04197606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXJeFddG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F8F1F000C4;
	Sun, 15 Nov 2026 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708302;
	bh=IsX6i/arkXv76D0Oz+26RxsybxuShnCTv57q518OhQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXJeFddGGHmMAFCuPVamhkqOUDuKq3LGPUOz225duiLu139UesyS02soi/Bosbt/Z
	 mt4lSZQz3CPJkxBv8t+E9lUEsYmdZhrUO8m1tL6Gt5GrXYkYCdRPcugzBOUlW+dKQU
	 uiSPPUkRR2z3O+61fNdHPBSvsQVUXs4WiQWd8CEycUVzku07ttR3PeFfuQH7dX4g24
	 S/uAGQ0edyFro/shqNIr6rNKFQY1VFGOaYuv/yREuxplDd/hY/qnpBux0M/9m1UsD6
	 /dTIlao00wHWGp27ezIzjDoPtEMnwAq2pF/0pxT+pVqgDIsCmLxROHeHkO4+IKB+EN
	 oAz7zU2MGcrng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: cap the block count of xfs_iomap_write_direct() at one extent
Date: Sat, 14 Nov 2026 21:05:00 -0500
Message-ID: <20261115020407.852939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202734-failed-5.10-66d1ce09ebd7@kernel.org>
References: <20261109202734-failed-5.10-66d1ce09ebd7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit 66d1ce09ebd72709f8d739630c39f440445173fd ]

xfs_iomap_write_direct() reserves blocks for the whole count in an
unsigned int. For a pNFS layout the client chooses that count, and an
RW LAYOUTGET for 16 TiB wraps the reservation and shuts XFS down.

xfs_bmapi_write() maps at most XFS_MAX_BMBT_EXTLEN blocks here, so cap
the count at that. nfsd asks again for the rest. The other callers get
the same mapping as before.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Pankaj Raghav <p.raghav@samsung.com>
Fixes: 527851124d10 ("xfs: implement pNFS export operations")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Replaced XFS_MAX_BMBT_EXTLEN with the equivalent MAXEXTLEN constant in the expression and comment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_iomap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index bd5a25f4952d0..2f7cce023c0e8 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -203,6 +203,14 @@ xfs_iomap_write_direct(
 
 	ASSERT(count_fsb > 0);
 
+	/*
+	 * xfs_bmapi_write() maps at most MAXEXTLEN blocks in one
+	 * mapping, so don't reserve blocks for more. A pNFS layout range
+	 * comes from a client, and its block count may not even fit the
+	 * 32-bit reservation. The caller maps the rest with a later call.
+	 */
+	count_fsb = min_t(xfs_filblks_t, count_fsb, MAXEXTLEN);
+
 	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
 					   xfs_get_extsz_hint(ip));
 	if (unlikely(XFS_IS_REALTIME_INODE(ip))) {
-- 
2.53.0

