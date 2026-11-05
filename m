Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893652;
	b=ZeeIxHv5Smq+Q81bb2wGSw3YZCOR11ESHsb4K+r+fRw1RndWoztB4EaCe1cNH3eRdurq
	 2m+LMnTyGXWbDnIMbA7XC44Rk+DNSzVqX7+A079jp3kLllFGT2s4PLihSzOIQ4WaNM4tH
	 dX9dtZVTqP0xNfwvv7S04ENeCVKkupnmUoX5cJjbXmDQLKcHYXHkWDqNuN2bH2heDqahy
	 9wqqte9OIXOf9sD/vcDc424nbVsQkt+xG+sYei7IXTzPQtahhQAJl2aN4+R1eODVgXvn/
	 aHUiaG5IBYFX94lFpCAZ5jeOdASsLY8c5l5EoWz7ygY9JWFl5LAQri6dN0JibhMhxJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cTBL0kL9rn/RzSrYapPZrxAAjfPLaHMzlaitTcNaGSM=;
	b=oEjsVJbJjA/yUmXDX88/bEI2L3KLJE9H/DhGyn27FK63qOpJNeKOBAa8AzvkIqwcCUBn
	 zAOnOn986mgoke7Jb1zWbrzTuji3R0eIldrlG+L19EOlCYnhdnC7LSaBTzJR/OmFcZm7a
	 TI0JH++iktLtSz1tLjBZ1gvxx9VyGc7Q8X3U9LRDUV7TRLbGse6grpjhHn3Z47KqOTHMF
	 A4MdF+nSvF2P1j0F2zfgHhb54Q2jot0/I56bOvgiyr7yYkGynu8GIf7TNIZYVE9WYBUYx
	 X0Cwc+5yYKfM3M4r/KOtdFIF4BL7MyW4Ud7b7+/3Zag/tdYjPWQPktscIEyanc+RnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctjk0ZzV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3E606D832
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctjk0ZzV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733461F00A02;
	Thu,  5 Nov 2026 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893652;
	bh=cTBL0kL9rn/RzSrYapPZrxAAjfPLaHMzlaitTcNaGSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctjk0ZzVkuyW51mm5/cBSKzC22xLUhNjjzONgBqZAi/DLc4FA77yuSyxPv4VvTGh0
	 5AX52hurUYfs1Xy7nESY0YTWORSMvX4xDe4oBDZjhwXIEL6OPbRvU4VkinI0FxZUqT
	 mOkdZorv6FR+qq5ATaaPjeatQb0AezBkYugrMysvPTfddRUWJ7gmuW6KSGNRFcAxgC
	 w/toNWG8us0gUH3W9pjT8GyM6rsyk2sssvNyspPNJh7T9uSsi/zi4937BWmMPKC409
	 JC3EZNdYbyTrISsEZgX6G/c9RW5RcwKkFZMuh1slQdVnHJy9M7GUn9lJKl5UC3uj+m
	 6/CYzUzBTO4zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] xfs: check for buffer overruns when examining local/remote xattr entries
Date: Thu,  5 Nov 2026 10:47:29 -0500
Message-ID: <20261105154712.2073712-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105154712.2073712-1-sashal@kernel.org>
References: <2026110427-acrobat-squeak-f5e8@gregkh>
 <20261105154712.2073712-1-sashal@kernel.org>
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

[ Upstream commit 91c41f9524906a8ebd2ae68c98a07b4bd5255ddb ]

LOLLM noticed that the xattr scrub and repair code can walk off the end
of the buffer if the xattr entry record starts so close to the end of
the buffer that there's not even space for the entry structure itself.
Strengthen the bounds checking here.

Cc: stable@vger.kernel.org # v4.15
Fixes: 13791d3b833428 ("xfs: scrub extended attribute leaf space")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c        | 12 ++++++++++++
 fs/xfs/scrub/attr_repair.c | 16 +++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index f7c00ea1af5d3..f909e2b25158a 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -306,6 +306,12 @@ xchk_xattr_local_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
+	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
 	namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 			be16_to_cpu(lentry->valuelen));
 	name_end = (char *)lentry + namesize;
@@ -335,6 +341,12 @@ xchk_xattr_remote_entry(
 	char				*name_end;
 	unsigned int			namesize;
 
+	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	if (name_end > buf_end) {
+		xchk_da_set_corrupt(ds, level);
+		return 0;
+	}
+
 	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 	name_end = (char *)rentry + namesize;
 	if (rentry->namelen == 0) {
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index c7695d4cc8e7c..ad688f9f7ce94 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -285,6 +285,7 @@ xrep_xattr_salvage_local_attr(
 	struct xfs_attr_leaf_name_local	*lentry)
 {
 	struct xchk_xattr_buf		*ab = rx->sc->buf;
+	char				*name_end;
 	unsigned char			*value;
 	unsigned int			valuelen;
 	unsigned int			namesize;
@@ -293,10 +294,14 @@ xrep_xattr_salvage_local_attr(
 	 * Decode the leaf local entry format.  If something seems wrong, we
 	 * junk the attribute.
 	 */
+	name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+	if (name_end > buf_end)
+		return 0;
 	value = &lentry->nameval[lentry->namelen];
 	valuelen = be16_to_cpu(lentry->valuelen);
 	namesize = xfs_attr_leaf_entsize_local(lentry->namelen, valuelen);
-	if ((char *)lentry + namesize > buf_end)
+	name_end = (char *)lentry + namesize;
+	if (name_end > buf_end)
 		return 0;
 	if (!xrep_xattr_want_salvage(rx, ent->flags, lentry->nameval,
 			lentry->namelen, value, valuelen))
@@ -333,8 +338,8 @@ xrep_xattr_salvage_remote_attr(
 		.attr_filter		= ent->flags & XFS_ATTR_NSP_ONDISK_MASK,
 		.namelen		= rentry->namelen,
 		.name			= rentry->name,
-		.valuelen		= be32_to_cpu(rentry->valuelen),
 	};
+	char				*name_end;
 	unsigned int			namesize;
 	int				error;
 
@@ -343,9 +348,14 @@ xrep_xattr_salvage_remote_attr(
 	 * junk the attribute.  Note that we should never find a zero-length
 	 * remote attribute value.
 	 */
+	name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+	if (name_end > buf_end)
+		return 0;
 	namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
-	if ((char *)rentry + namesize > buf_end)
+	name_end = (char *)rentry + namesize;
+	if (name_end > buf_end)
 		return 0;
+	args.valuelen = be32_to_cpu(rentry->valuelen);
 	if (args.valuelen == 0 ||
 	    !xrep_xattr_want_salvage(rx, ent->flags, rentry->name,
 			rentry->namelen, NULL, args.valuelen))
-- 
2.53.0

