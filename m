Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886357;
	b=5n5tF/tvSN0s4HvvlnYYxQk+q+pasB9K3KmQYQ2T99tjEUo8C14J+nZKW7CLCgsOaaTr
	 0m25+Mjg4k6wKEQbLWmYfSp16DLPLwplMLIYU5gW4nGUkIchwGpHqYSl/iKBferJQa+fQ
	 0giNtR4QJO3noFxvoozq1NNBmOAZjfvuhaNQhDwKHwEoTOfad+4XHZpLTcOBtMKU7kxlm
	 Rlv2C8Jf+Qc/qaTzzZAUUxSs3wCxSllyHQJfE/KmgpDwdMFkZb8IAtdtH6Qj99R7ey7tb
	 4bAsWZfycgK9hRy6dTvAgQFIRTPGZ/MhYfiyFJq502OJIYoc0HLWhiT5S567W9WUUkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m31w8guxqdeWGBLAc7TwZ5U7pEpYgvzCEn2vHc8Rc2g=;
	b=Mm9EMTwDQUNiep5UIB40VL26LPvfhp0p7JLdwZ0aPS2Z96aKU+kBroJKZsCPwPFGdqlO
	 EqrHHWURZ/Wa1FYJzIHLltjiscqH6q9laLQe/XYd9LqShew652rPGV0rgDXAohb8J/Gfp
	 kd/DN7RWbGEIYhIJqCBd3efL72QPN+Wh+jsnlXtN2DfA0qQkU+XB+E+D8lgFWkBcbxX8s
	 pI6j0fQir5fGPODXZkv5J4+tzpW5E37Mkoie/5EVOxxD7eyu4YsTa+3R4qXBrlBruf9pG
	 b8PftbKijEu+kN4z0THVjwrr9lfsr0Dg4QrbN0iwjtK9a9E27D3itMxP1SSLimlpaMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp8SOTgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2302A606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp8SOTgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8431F000C1;
	Thu,  5 Nov 2026 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886357;
	bh=m31w8guxqdeWGBLAc7TwZ5U7pEpYgvzCEn2vHc8Rc2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tp8SOTgwTOBHS3NVl5KLYwKIeHLGzEG2zNo3UdMrKltmHSNRChRtiJOcHZxrVhH1F
	 IQnlce3Bksw9J0LpIMucsfeAQAEAVKg8qpXLAzjRBANbyOXR5dPbgLRvQyCz3LUmVO
	 qWSMNBJh8qp9Wlfqi37UKcd7msMpfKTrixPqs/ApmQw3RXbSBzRHTXw78IPq2XpxV9
	 azyiJ2A54x/JnZP+Qbd6MHET9hlm7JE+0d4cT7v5/0SbjjS5pZUuSQbmvEvtth6f4v
	 aYmADFuYQsO/euME4j1KfD25CIiqtDxHde3iZtpDrxyNyJbJNUUf418r1WPm/rZ3t6
	 iZC1GO64VBopg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: jump out of xchk_bmap_check_rmap if fatal signals
Date: Thu,  5 Nov 2026 08:45:55 -0500
Message-ID: <20261105134509.1400113-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110430-implant-perch-2ec4@gregkh>
References: <2026110430-implant-perch-2ec4@gregkh>
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

[ Upstream commit 49d300a51442bd64b627645b7b0b1cd66e492905 ]

LOLLM observes that we never check for fatal signals inside the loop
that checks file fork mappings against the rmapbt.  This can lead to
lengthy delays in responding to a ^C, so add some bailout checks.

Cc: stable@vger.kernel.org # v4.17
Fixes: 5e777b62b0bcb6 ("xfs: bmap scrubber should do rmap xref with bmap for sparse files")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Adjusted loop context to preserve direct updates to rec instead of using a check_rec copy. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/bmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index fed56d213a3f9..5748545afb5be 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -487,6 +487,10 @@ xchk_bmap_check_rmap(
 	struct xfs_ifork		*ifp;
 	struct xfs_scrub		*sc = sbcri->sc;
 	bool				have_map;
+	int				error = 0;
+
+	if (xchk_should_terminate(sc, &error))
+		return error;
 
 	/* Is this even the right fork? */
 	if (rec->rm_owner != sc->ip->i_ino)
@@ -517,6 +521,9 @@ xchk_bmap_check_rmap(
 	 * entire rmap is covered by bmbt records.
 	 */
 	while (have_map) {
+		if (xchk_should_terminate(sc, &error))
+			return error;
+
 		if (irec.br_startoff != rec->rm_offset)
 			xchk_fblock_set_corrupt(sc, sbcri->whichfork,
 					rec->rm_offset);
-- 
2.53.0

