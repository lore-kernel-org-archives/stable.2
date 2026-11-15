Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707601;
	b=4mjuYDvokTG4E8WAaCuuAhOj7a+NDaaeFB59ZE87seT7F3eCOrsRqsRR82fQfUiR5KDs
	 uwAG0SV5+4SdkkEhIEg6SDcEaLmkki64gG5CDy+ctWOLzbCY5fhyQWNhk8aOJHjS85ntR
	 FX9r2A+NTcv5wXGIRxRG8tb52J5D7JpHwe6DlHadhqRwLcXvr7HSTdUQ9eXUDN7DD7N9a
	 UnaW333Fa/0CzOVKu2m4qbf2ToYKeQnntYmCcJg+VR+yK+/b6v3+QmbNA+8JOu4k2I0UB
	 cg1jqWZSIpLK50nH1IflVVUY1kTd6MSLhH2rQU1ajz14fH09fT45ItzUDcTTk87bFMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707601;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cqjl+p5eTKueQYWLRz2uMzmNHeLSPT2jMNGn2HfF83A=;
	b=pkAQPkVY1wSp+vl4/lwmoX7XaEZIPkegh340Ki3UuYBch+X+y8gDwv15mF7xNRlGLyRv
	 6FxmhvZAtVHY3sNyYi3Ty0wB1cbJ59wX7CoNSaRFaeMxaehkAYMq0MtoeIKKNuxKfliH8
	 9MDJ+QhPO3/n6hpxss+or2zXxpxbf/sxQqy8taPElWcM3P+91y8tyKVFfjmLFSwuPFBko
	 myLXTCTqbmvX0eoAHLAm9HOMKVATEH35u9Zj7fpLabKib3M1ca3rWjvyFfDdbNt0S3MEw
	 F5k/kOsyFEbV71xFrUlwCNWCH14JR8iQQuH/zbLx6CcseHHv2UG4rT8ppnigRqUpOug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX4F4TPR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFB606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BX4F4TPR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADBB1F000C6;
	Sun, 15 Nov 2026 01:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707601;
	bh=Cqjl+p5eTKueQYWLRz2uMzmNHeLSPT2jMNGn2HfF83A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BX4F4TPRzxMi5enBuZbd3bilfJG8oIVKFzzQY70A/eUFYW02i2eCOT8vnnKd7M3x7
	 gyL+QghrbY/VxnH48xEiXNJtta3iswJ78o4xzctRxRNwP/+etbkGATp3oCSiNNL7tO
	 3ithB7/WxSyuYXQ7xhhAsgV3wttUMNZTKaDh7O3bk7j0BHGhhsalMG8JdTEp27S9jx
	 asDVsFN9APGMDMo+zMI+tYdYr4Sx8BUF2gXDWyGfFYUTg14Y/SkdWzTnTzc3DbYHIa
	 atuew4kWDt2lI7Sz/f6J4osD5bZA53e1jvCFdqQimOfsPwAGepX5/vbjCER+OBguJC
	 IO27WEoOmcFCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: cap the block count of xfs_iomap_write_direct() at one extent
Date: Sat, 14 Nov 2026 20:53:18 -0500
Message-ID: <20261115015155.842255-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202300-failed-5.15-66d1ce09ebd7@kernel.org>
References: <20261109202300-failed-5.15-66d1ce09ebd7@kernel.org>
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
[ sashal: Replaced XFS_MAX_BMBT_EXTLEN with the equivalent MAXEXTLEN macro in the added code and comment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_iomap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 093758440ad53..920ce54d00055 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -202,6 +202,14 @@ xfs_iomap_write_direct(
 
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

