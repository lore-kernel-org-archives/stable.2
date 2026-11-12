Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452051;
	b=lQY9/Yek8LbsSH1phfSjpi0C06B1lpRQnStzNJoPAEPPWx5MPGIPLY4OeGCUgTc3gHm9
	 Ujz6n54qTBNwHb6gCQU36y4qpeEdwL4P7C3+bw+/3UInLBrLVHJNRIgAe/z51BqNJyJb8
	 LFQ+HEhuKZgwHWcZ/wJ2xR9irgbEgExHtwHU3g2CxyCR0qnCMfwycBp5GaXTYAsiaUmoH
	 R3bMsQQ8nAxPsfuK6j+sN/aVJ/Jn7cBHvqbftPZRCVQfxajpt3tIqm+oALfLDVdrE4vlo
	 dAyXzqvMYMqwFMvNZF6ESp5vpqUPPs5UXVsdTTe78ZXt8o1agjM2rOt9zZ64mrw92yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jDk5FwCFtO3pcmEyaVSSkQApToWjcESyPCO/w46El9M=;
	b=B/gQXriOfX38Tk67Y7uCDgowEOEGgONqlzIAraFcHeg5PF2nAbCBT1ebpO2kv9+VO119
	 XwREgriQjhhAP+Mx65KJNzeww96/sGPyQEndgJTuMlg0bdY3fJAktY+4D3qQOdO/DUyv4
	 lv+XpfXBx+MLx+7j93pidMkHOOmWweyoqeaeXgw9u8tzlQPWAa01xV4wJps6UrXaonsHN
	 Z/xPGVx8YQSKjvk+6M+/RnCLDpgCMgkhSxWwo0WELJuO/7LoAgTSsGajRV6XSKofuNXNv
	 KKOegVGBBIQzMt3G2dMM1Lk8WccI7TJBY2LlGFv/jgDbDrveG/2VmBFnOgGa/edyhYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwEkKykF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C19606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwEkKykF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827541F00A05;
	Thu, 12 Nov 2026 02:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452051;
	bh=jDk5FwCFtO3pcmEyaVSSkQApToWjcESyPCO/w46El9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwEkKykFwAO0kxCgzW+dM91GgNDZ/G0yKm4Vcjz3y7OOm6WkMtqn98qjZh2F8DcqG
	 hsbQSICgDe8Ez3bCRW66+JhLXtlh3byHosPhHf4jeRVtFYJERKBTGL/kiogk3K9GLt
	 1Kj7qJgtLDe/cgOpvIgyzA5BlGIYs0P8TUzKjynTU3kP4JAQTjkTr1RzY8k1TybT4/
	 2N9GWLy+dwuX2RQIJgTn3At3poSmNHOp8+5DfVWciL9rNQ2qfHIRfsa1KSMO/lE5s7
	 2nLS1OK+7uuFl8opsc20Pq9yULCI/BrRL2ReOjKJ2k6E9XUaQlb+oDH1se0F7LY/X6
	 OTZTWZj59jssQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Dave Chinner <dgc@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: don't skip free extents of the longest length in a whole-AG FITRIM
Date: Wed, 11 Nov 2026 21:54:09 -0500
Message-ID: <20261112025346.1437391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201135-failed-6.6-5745f4f10a1a@kernel.org>
References: <20261109201135-failed-6.6-5745f4f10a1a@kernel.org>
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

[ Upstream commit 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99 ]

Since commit a66d636385d6 ("xfs: fix fstrim offset calculations"), the
by-length walk of an AG in FITRIM starts with
xfs_alloc_lookup_ge(cur, 0, pagf_longest) and walks down. The lookup
lands on the longest free extent with the lowest block number. The
other free extents of that length sort after it and are never
discarded.

Start every by-length batch with xfs_alloc_lookup_le() at restart_bno.

Suggested-by: Dave Chinner <dgc@kernel.org>
Link: https://lore.kernel.org/r/ZgiJWxVcVwag0fIP@dread.disaster.area
Cc: stable@vger.kernel.org
Fixes: a66d636385d6 ("xfs: fix fstrim offset calculations")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted trim cursor fields restart_bno and count to ar_startblock and ar_blockcount. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_discard.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index d5787991bb5b4..80d4a39e69008 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -175,12 +175,11 @@ xfs_trim_gather_extents(
 	cur = xfs_allocbt_init_cursor(mp, NULL, agbp, pag, XFS_BTNUM_CNT);
 
 	/*
-	 * Look up the extent length requested in the AGF and start with it.
+	 * A by-len walk starts at the last record of the longest
+	 * length (ar_startblock is NULLAGBLOCK until the first batch
+	 * ends) and then where the previous batch stopped.
 	 */
-	if (tcur->ar_startblock == NULLAGBLOCK)
-		error = xfs_alloc_lookup_ge(cur, 0, tcur->ar_blockcount, &i);
-	else
-		error = xfs_alloc_lookup_le(cur, tcur->ar_startblock,
+	error = xfs_alloc_lookup_le(cur, tcur->ar_startblock,
 				tcur->ar_blockcount, &i);
 	if (error)
 		goto out_del_cursor;
-- 
2.53.0

