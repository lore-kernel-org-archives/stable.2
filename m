Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2342836F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530164; cv=none; b=lLPUkF07t9SRAxjMQSWWraHPUR3H8cTJlCG9lA1TMNqvLsjj/gvxFaIz2Zbc3B4OGd/FV5/bNwSZhuyNgeOcTjax+j48LD/Jmq7ZCibYRUwLBZH6qqBQNOOcMQvh2obiB6WnRudLIM+2ZVGf942hEJ26lkLjNFIXjD7MCRoIUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530164; c=relaxed/simple;
	bh=XF4LLGf+yjIRtBITqJpYSotZoh5WnwvPK1cxJI2Dvbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+7/KCt5bjLxbR9xp3emrbxgxy3Ky9sxrEapGzrAu1HU53wqsA3gJUHQIRbVnYbzNsQxI8XsTvNR/a48puP4LibbyWtnnTNDMilEgKQad/NfhhhnNL8BwZdhzLxyj44K2lRnaJ2QXRr7lDyjW+2wQ2uCxd5EzirkEjQWaa+9I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1ZP1/s2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1ZP1/s2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE481F00A3A;
	Mon, 24 Aug 2026 00:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530163;
	bh=5ocYApj1rertYkn1ZsPXGq9EmKnkPnDx5Z/gtPZ3Sjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L1ZP1/s2cBcbBF6/eAmx0GEAKimStgXKNFFaXwnc4Q+YIbj2naSn2aifD2Ew5SR5b
	 Pt3nfGO/6xWJtnIqoHQq81yoVfX0/IYS/ubiReAwL2dCmAhvoE9ljsayHuZ+xEHfzD
	 pgpk2C1twodk+IgEkl3VNgr+aCb76yz7fIMe1DXw7N8ap8mpK0KMGYL8MaTFLu3yD8
	 dkMwoIGT0r5wq+Hj0NJbPqT/6Y8l4yXl2lFqyFLzcAJGiFpe73jDVExBVIqCXYwSQG
	 /DVXNDTR+hGV5CQOHEBscNL+F7DkdrT6AzoPVq6ydvjFDDNC/Dp5UF1zKD5milMj4d
	 9ZbFVpzleIezw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] xfs: rtsummary scrub should treat rtbitmap corruption errors as an xref error
Date: Sun, 23 Aug 2026 20:09:20 -0400
Message-ID: <20260824000920.2648819-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824000920.2648819-1-sashal@kernel.org>
References: <2026082038-basis-zookeeper-14ec@gregkh>
 <20260824000920.2648819-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 8ed78104722b57df69478b0b1608a408c1036085 ]

LOLLM notes the discrepancy between the comment saying that this is an
xref error and the code, which marks a (non-xref) corruption error.
This appears to be a regression.

Cc: stable@vger.kernel.org # v6.13
Fixes: e3088ae2dcae3c ("xfs: move RT bitmap and summary information to the rtgroup")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ changed `xchk_ip_xref_set_corrupt(sc, rbmip)` to `xchk_ino_xref_set_corrupt(sc, rbmip->i_ino)` since the renamed helper is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/rtsummary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index 0bad27f443741..dbbbafe8b92d6 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -359,7 +359,7 @@ xchk_rtsummary(
 		 * EFSCORRUPTED means the rtbitmap is corrupt, which is an xref
 		 * error since we're checking the summary file.
 		 */
-		xchk_ip_set_corrupt(sc, rbmip);
+		xchk_ino_xref_set_corrupt(sc, rbmip->i_ino);
 		return 0;
 	}
 	if (error)
-- 
2.53.0

