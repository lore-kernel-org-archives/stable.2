Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898874;
	b=d3HlVd7IC/FVd1Yguo7MDAsuxktbNL/QVgd2l+xW1qdIKWRKhd5wfrrGTXhmpm+agYUq
	 TgOqbYDaYcxUUCXwR4zOzuYDHBqn2YoAjNkuJmL4q5M18y6PQJlHtzzhPdiyg/53VZwgy
	 DYYv33hyanBX2j6ba6G5VfC23EUexrFW+47GWa0eIGy3/rJu6hXLFebsSkLgqXX7/5kDV
	 sO74DZS/K30ir9lbm2Q0q8627P+c/7kxRJwnHt109hFt3HP0BLeVWf1oT9+VppEBaWByf
	 cHNsSbT9DYaMGweKEHvw5g50yvmEEpEbituxjbdOWpD24i+TaMkW2zygxuRamHutCUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wWqfVeb4X+Jc7QLLLoMVVBIH0i9aLy8mD1P0B3TbmeE=;
	b=galOMQa10l54D7eyaNDetsuHgdlJcTJGIdEO64NUViuO6Et34T/ocEt7BXiYQv5C9X1u
	 P4hSXLqA1FGJKkaI0VDwMzQXiaZHs0OYiUdncAaE3KraOg45vBuf8Jpw0b332oCCKuhda
	 N/0WX/1Hw4sVq/NYqRulLRbow5V64aauk/f8SOcgyyYPpBWX3/EFLEhcooFPDSZjLtzsn
	 6xADq1GjDDd8zdstj8e+CohzZoZcmG3hfFV6mUHY4ib+HoL91A10v+LEFCTNU8YcWm6MQ
	 0H806nLhNxqrc/Ypw7ULzwXDNfocb+U5wclAOg/TOoOdZVpKrgVcko1xKSl0QUeYaUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j903C7P6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF79606D82B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j903C7P6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16EF1F000C1;
	Thu,  5 Nov 2026 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898874;
	bh=wWqfVeb4X+Jc7QLLLoMVVBIH0i9aLy8mD1P0B3TbmeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j903C7P6RJYuD3mrgBOGfLlB8euSSxx9NNxNNlpDHtGVB4a5aQyy40hxRZFcJ5LyH
	 j+GK6vA0FvtWuPGlC0DVGpEEPgxO9IvNpEO3zQ88EbYEb6r1Bz2RhsJsAuMtWHcY+n
	 bOhpqumGkzCQHxKTCDXAKJqPM83WW+j8K0FthXiDz8r0VIbTM6BmknCqwXkp/HOiW3
	 ZkOvgqselvSqDlfkBO2gzKOKylqmWAxPl4qjWxJuxjl9QyHCQ3QEIUhKavKuo6ncAW
	 dXe9SjrZ0VYIiHtfn/dBHd3Q5Sf14RSjw+0Rg6nisGssGbHkT8AAMSiqRTwt65pXXj
	 WONgnGGeoVrpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
Date: Thu,  5 Nov 2026 12:14:32 -0500
Message-ID: <20261105171321.2079862-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-circling-donator-d93c@gregkh>
References: <2026110433-circling-donator-d93c@gregkh>
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
index 558f44ccb13fe..e4c2acc633a5c 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -134,6 +134,12 @@ xchk_xattr_listent(
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

