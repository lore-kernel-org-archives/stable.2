Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888953;
	b=JsFHf2ewTx39qtjkcHDHbc9X6mAsEwXj0LuFmVvVW+nrCIAbZZfswqOGIXakjK8sxrx0
	 DADPN46R7dp1s8QtW9MsxQIWmJ/dsIpg4EphvpRf2feOCZY+HMvp3oLh2oyUsm9rq6Arv
	 BiaYm5BIp9aZlx+RN+ZnKtG9klQtl4KGjAXDS2z1zT3IW9xeHIk66m/2u03cj+8hBsaOI
	 4TVLcmKVevTSBE0GJjrknZ/aKu+s+HSsN0pJVNeY8dTpgOrHdI9ivUgYjLrJqhZfTizNq
	 fVjB1+/tEn+EyI2N01oU/fpFUyQKfJrnndhUraX+w297Fvn9yOCGFEpN8rDl4WSnxzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VA/+XLWRW8XE6/W+r4wDJS+O2cGKl6YY41dhet6mFCs=;
	b=RvVT1e0Sg2mNhwnoXkCLSaBUTOj4uFrRKHea6sftefgghGW6envjYmqygaWHVGO6lq0E
	 rz6/NZOMgpnS8zxBZwWPg9Yz10xjYk2zZKMktMBBKtUKg0qffh1NyfpgPG57BTLGIGcyO
	 XZCM84GskQMls7sZTKCGpkayCAVKCss0qe2Soal1eDjctIKF4nQiGTeyfTZvQwv7d2El8
	 cPzXic7VHllVwZV93aV4ObUVVtIQntevmgI3M1IIrvM/ULw3B2sVpu4Ff8/jyu4i9v/fv
	 a87eP37xlW+DwVvnQsdtEbwEDAAdVc16lmMzcmw29eDjEOWHXq9O4zPT56je+rvGeMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wcy44mYE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A8606D83A
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wcy44mYE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DFE1F00A1B;
	Thu,  5 Nov 2026 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888947;
	bh=VA/+XLWRW8XE6/W+r4wDJS+O2cGKl6YY41dhet6mFCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wcy44mYE8/Krn8I1qs6j+APo92H6gPQY99F4oDyXNXr68AFj4eW1uqEkgTHkyfDzY
	 ryj5yhwxZCRq9va5nAkw6ep98oGV2oG9Am13SvMKXT/WVeR7+5ELOv6zfxcayDe5qI
	 tvabCrR7dR5AQdGSXodogau/vUapX8qFmwzooKmU8oK6uxdHGLruuq2nBa+BsYcyAV
	 xKRPKiNtuLO13BVvhOTF85xdQCObrtYX9DsKvcpnv0CGrhunNGnnOIVyEgslJGLEdD
	 oJp1ir4xNLIymBz6IlYE1rjrOUmpS+Fm7+4rYj28Li5c3UlyA132ThSXB9I9gZsdjU
	 nxjIDMvE9lepg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
Date: Thu,  5 Nov 2026 09:29:05 -0500
Message-ID: <20261105142748.1659083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-recede-reliably-854a@gregkh>
References: <2026110432-recede-reliably-854a@gregkh>
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

[ Upstream commit fd012955641881169a9f01a00f656f6ca73842ec ]

LOLLM suggests that we shouldn't try to allocate absurdly large buffers
for xattr value checks because that will push reclaim very hard, never
succeed, and is pointless because nobody can create xattrs that large.
Since the xattr repair code ignores values larger than XATTR_SIZE_MAX,
we can flag the corruption and return early.

Cc: stable@vger.kernel.org # v5.3
Fixes: 6d6ccedd76823c ("xfs: only allocate memory for scrubbing attributes when we need it")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted the check to the void xchk_xattr_listent() callback using sx->sc and goto fail_xref ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index c785d80bbfe50..d410b4adcef8f 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -199,6 +199,12 @@ xchk_xattr_listent(
 		goto fail_xref;
 	}
 
+	/* Don't even try to handle a bizarrely large xattr. */
+	if (valuelen > XATTR_SIZE_MAX) {
+		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);
+		goto fail_xref;
+	}
+
 	/*
 	 * Try to allocate enough memory to extrat the attr value.  If that
 	 * doesn't work, we overload the seen_enough variable to convey
-- 
2.53.0

