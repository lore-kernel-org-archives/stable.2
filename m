Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890932;
	b=G+1/lVWWynQj4ZkIvFI9SsVmPLBCaGD9iH1gIUesjGiXCEyehqrXEsxPSxkLpOrh+yHe
	 WtrL5RTHNyyua57TdZCQC++q/u2KA6OBG3+cZukvqrmeX371t7T8/wA3L95c2N1lsw6qk
	 8MeF5XpmlOq0yRDX2SGKzhwQ0njDvlHa/G7NczoWW3gMIXy/dRlkeHe03f8btQHjdOiVm
	 Qhoop4HL1N3WmQF12gCXJ91B2JGtz2ME1ceIPbSi/+jFKuMHihwyNp0i6mzGaEMrvVhYI
	 mtthdAswWZyWJiTIfYLVFQLpmVogJ3doOyA0xuSmNoZ3xd5qR4g0kNQp4CZI3zaMshg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M2VGFn7iOeUvIJn75BxjrPqzoBSLCwUXzT5IiJlycYw=;
	b=4gavZ7vDhR7grWdX19tNpvyv7A8m61XVpDIldv3IpLPoyeMand9kyWIt7ImomV353Lsr
	 ozoOSP7gDxJ6BN62Uy4n9J87XXduKMGubamIQR3xSjngpE8B/uIKcKk5xvrBR7plpvxaW
	 GI12b/dsuejpU5QZCu2S86diNOyC1XiZl8IW/LIKqOJfXCOBSarb1OiESXzAlSiW8yZLv
	 FvdArjlNWBi1rKd/u3T0/Jcp7/XJ5lQWZxxeSekSTdsFbAzzqSZOpgkcwLgc08hT86bUj
	 tfaFezwB29NZaGmjhyoGYJmknxDEbCf2OKfc8/NbS1v2ulrYkbuuyZMY5fMnbxXz50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLGv1PgJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C5606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLGv1PgJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676951F00919;
	Thu,  5 Nov 2026 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890932;
	bh=M2VGFn7iOeUvIJn75BxjrPqzoBSLCwUXzT5IiJlycYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLGv1PgJWiXRlrmQHB8BQQlkz/TkdwlwsPVkQNWuX45Kw5ovmSEpXntUTPuDNy22y
	 j5vaIDIrc7rCOxOxHcMV4xiJrWZbsol+AqTokvlVMdcqDkcZtznn7TxweYKjcaUrc/
	 PTe9e6cBYXoHMHTRdl9ErLUe9CDD4ZaGOxQSnzsEzLS2S/1TGEi/YuBtTAZA4pO3Of
	 yCZpIobe3uoPa6A3hzHWjyEITT2eVAL7t9ktnWzvSuPVSXhjCwCpxQ0mMrhKyADPT7
	 PYIBRltj9nOiOz5sE2uhHc+ngV14fK9eE3zyNB0b36XW6cgY10GcMBO0qaVMfRnEc5
	 wdijJX/5YkUug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: rescan the AGs if incore delalloc counter is negative
Date: Thu,  5 Nov 2026 10:02:10 -0500
Message-ID: <20261105150116.1839450-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-stoning-numbing-9457@gregkh>
References: <2026110408-stoning-numbing-9457@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 47b1e941bb55f735d82ba2649412260da78b98f8 ]

LOLLM complains that percpu_counter_sum can return a negative number but
we instead misinterpret that into a huge unsigned value and do bad
things to fdblocks.  It shouldn't do that, so let's add a retry loop and
an attempt to freeze the filesystem to (hopefully) zero out the incore
delalloc counter.  It probably won't work, but at least failing the
repair beats doing the wrong thing.

Cc: stable@vger.kernel.org # v5.2
Fixes: 75efa57d0bf5fc ("xfs: add online scrub for superblock counters")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: retained existing pag and agno declarations while omitting realtime-counter hunks because the delayed realtime counters are absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/fscounters.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 9aca5c82a3c51..e8d90b674d944 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -299,7 +299,7 @@ xchk_fscount_aggregate_agcounts(
 {
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_perag	*pag;
-	uint64_t		delayed;
+	int64_t			delayed;
 	xfs_agnumber_t		agno;
 	int			tries = 8;
 	int			error = 0;
@@ -362,6 +362,11 @@ xchk_fscount_aggregate_agcounts(
 	 * of the computation.
 	 */
 	delayed = percpu_counter_sum(&mp->m_delalloc_blks);
+	if (delayed < 0) {
+		ASSERT(delayed >= 0);
+		xchk_set_incomplete(sc);
+		return -EFSCORRUPTED;
+	}
 	fsc->fdblocks -= delayed;
 
 	trace_xchk_fscounters_calc(mp, fsc->icount, fsc->ifree, fsc->fdblocks,
-- 
2.53.0

