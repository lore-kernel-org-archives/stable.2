Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893000;
	b=GrYVQYP51e6BaplItE9bVojX8ite5M6N4JlnDCOm/Kjb11Cj7CvlY0ATQYu66Pw+FMmk
	 65sOT6WKmFsBRAes8l5FWjwfihkBvtp55kSKJgW7oNvpBMnEWlRAEQ2tj4C5OVkvEdCDm
	 RfUrPknkxXAvkliR6VFQ6k5E2W4JWhkFoBn79nOP1U4i64+lpS0fsJwbssUXaTkIaVKDQ
	 75gpTsyRFwnUWyBNb9XFuofKY3niZfnQeO5T3U0/85Mo2/aaeRi/J/0Bx+K0AwMSuQyUo
	 Hvzx796JhdAOIsjPAxZhQGsvvj9ui7WKGppxnaJPMpBWva9FiozEZ+0ZuesDj3C3K6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ky4beK/+hw3wcss1LWJTT1jnjng8gAoXEtFn4/aSbAA=;
	b=tkixjQC3f70GwlRujOMEhJePCxwCF2KNl5RBS3f07NeA6zAK0c7S0ydgNinWTo6S1paO
	 rK2BlEP8yezWFw+WOO6KFpFz3cvXpM1ctsdbDq+NFTJsU6KwbOSSF31Xrk+LF8QnzOds9
	 aRq2IcQkAizsOid3bOKMM0RHBLOoZ1KolwF/SKwwjuwE2ee5TWonR6qcgNZLCA13aFewp
	 5cR2G3TSX8Kvv3g4rC5635M5uIUedKhOUqCeSqhksIYI1eJClmaKCzPsIYwHZxyXOqjar
	 G2d0qpMl5IHWYMO2EqCOzsIt0lKCEz0FfcQlnNsPOzEhMFcvbIjxfAIbk/5FeMwcGIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eD9ygtKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF38606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eD9ygtKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EFE1F000C1;
	Thu,  5 Nov 2026 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892999;
	bh=ky4beK/+hw3wcss1LWJTT1jnjng8gAoXEtFn4/aSbAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eD9ygtKeLJvTaJl2tKms9FowN73/DEF2p6RFS5kBjjzQAV2SNiOLsIP7Aky1rZ8XY
	 JlQSTrjOUiGpb5Pif7zwEfyJHki6+obPBCyk3Xd1ztRvc6kHb/Vqy9hILg1F1QKpBn
	 4O1LYdxLZihZV+qEQ9tmSj9zR4Pzu4dIHihtF0mg1bLuJNmpK/8P/BPjt7iZrW5/sS
	 9eU1ekX9YN5XzZWKwks6ljMqbyuDp41jU9hlACFgUPdWidgz+pKeLjgF/5NJssJ13H
	 cgHeZyFPL0RVH6EoQHm2KxxKOSNR/KAcJSFsNwTF5F+XmT3m3obMKm7VqLTg776g7a
	 z61V4pf0UOy5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: reject absurdly large xattr value lengths in xchk_xattr_actor
Date: Thu,  5 Nov 2026 10:36:37 -0500
Message-ID: <20261105153541.1981487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110433-lubricate-ovary-6900@gregkh>
References: <2026110433-lubricate-ovary-6900@gregkh>
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
[ sashal: adapted the check to xchk_xattr_listent(), using sx->sc and goto fail_xref instead of returning -ECANCELED ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 601e02d749881..278a13cb6a22a 100644
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

