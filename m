Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890961;
	b=nNFw16h0PnKK/wn8tSF+N0uyEGFIH/l/eQvbhWo5jorqPqbjoK52bS2ShfjdjNNwfTnz
	 4ZBM6uvw8DmrVyjgc1S2hs+isJQsvc3BqKxqvJ4vZh+6mfWwFKuuWiSQ99W3f5SA1V0Na
	 0kSj0I5c4YFGjvenUa19maMgcWwJIafle1+r7WeYYREpqt1an8kz3BpH8S8XzwnzrkdpX
	 dO/jcwx18llTpEhKzbM2O0HGsgnX/TTNZxW0ShdqDRqbNBx9j8eVCWKcWR4cl/GvNaat/
	 rO5K8pgbPbcEyfPJ/dCao+oPH9mGaDma5pELBlw2oTFIsQguwv8F4PGhPlAAcRKTVaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yCDY7Xsw9OvF16aO3cQGQxXxWDkZJpm7gXsYFO/CV3M=;
	b=LaSDs+j6iQrthGRZu4xftpRbqnVGmonrZATsFHLEt70MGPueN5Vef55mXVgK3kjodgE7
	 +XIjRqWckN8CsqTW2B709YGEM7cSsyzAXy9gDuaQvko0AzMBJDc8Ikd1UhZzo3zG3LvRt
	 ELIJcRVnXMxzA6yI11loBfAsrAekU/6OGAaEQu1ybTe32VAVbji9NJPo+g9OnpyC+5+eH
	 rNL863uLSBh0qaUcyFXKBMdrnClxbefyS5ZbPLKz9Y6kQHylvkkVBDKHTNPtcsh3+/qqL
	 KQc+nxoEoMlVzo9hmwMPea2ZoHzl2F1Wk2Z7gKMGCWjEEaKTm9gVBru0jLa/v+BzhQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCUMyq7+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E40606D820
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCUMyq7+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695101F00A15;
	Thu,  5 Nov 2026 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890961;
	bh=yCDY7Xsw9OvF16aO3cQGQxXxWDkZJpm7gXsYFO/CV3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hCUMyq7++F4wAfZohML5SlgeaIg4dkOifkyQ4pdx73Yr19fINGqNzgsEjx9IGyl5M
	 HvFI9dfwcLT5MdGebHxFYQQ9FpfhxgKh/LQirfH761p3Y4HUyPZh79U496+UChWWDP
	 o0vRDkk3dktALJiBdDjtbKUn3NCT380wLp/kfz3FmHiSMfsD1lVD7g4A4S4OQbknjQ
	 Tegc1xoIs9RS6n8vaAplwmKWsaIkVLlmHHp1uiYAk4DQ+tFGEbwOm3I2WqhAs1cnUq
	 3Id2K1laz7CTD4uD6ICHe4OPtwWeaWS/vucQFJLDbMfhVEI+lpN6JS8dzXSsiYVr35
	 6i4z8POpCGbdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
Date: Thu,  5 Nov 2026 10:02:39 -0500
Message-ID: <20261105150120.1844141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-cortex-papyrus-00b5@gregkh>
References: <2026110432-cortex-papyrus-00b5@gregkh>
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
[ sashal: adapted the check to xchk_xattr_listent() using sx->sc and goto fail_xref instead of returning -ECANCELED ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 6e14c9fc726dd..de7b01cf72be7 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -133,6 +133,12 @@ xchk_xattr_listent(
 		return;
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

