Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904224;
	b=Vqjoh3HKAY17MJ8IDIE1953Qzra8Fus4uuH4pRFSf4EC+Q5Cghkh7ZR9ClOSDLcBbGa/
	 t1ptH58joKeBM2x+1pweZGzZR/jqnPjRjrK1TAVK586J45qb9BRRK49Ww/g1P3dg5vwsX
	 wjbeDqdg4U20xMW+IMl35DsKuGHI+5prF5ag7yMHRwiKyACyi0HS9gq2u5sBkz3E/hZ5z
	 33V8hemWnutF+rcR+yu91r1GuirsaNsrhvDrELrbEXECA+g/hUKOPmsrcqx6Gm/zJPSnL
	 2zattHs6HZqE0HWIghTsjf0zzVWCMrdkjLKL053vLBUW6dggA4fRGa+vqiJdGmTVIsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T9W0YMANf0puYlWTA/pUVM5wpwGcwTTNd7JvjuNo0oM=;
	b=1Us20jzEB+/1vVdiIvK8lweLlbhCT/DhjHF2LqZpLnpH2PhcKs7RWgF5fwls2myMUsJ/
	 oqkeiphlgKnSqykGzpiKO7Ezp991Ww+jiSoiHaM1ZUSWYJlgC7vEztValWVfx7VyKfLdf
	 66vwlNUe0n9p+V+Af+viAjxfZT2XmCynQhak6SCA7bvOvvR1cfVxyJbX/PLf8FhZXl8qG
	 Q6FyNQAldyLfzB2w+TW5Q1bUliehlfUnRPZ16nsGTeC3VqlqtI+WGlbtFkGS94yXPajRZ
	 8ha16PnZvkkIlT9ADZHsOt2Fdmxf2eoif0Ucra6koEjwcjBQXjv1I4z2Edh4FLiyKUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxMsx3cH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B566F606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxMsx3cH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B541F000C1;
	Thu,  5 Nov 2026 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904223;
	bh=T9W0YMANf0puYlWTA/pUVM5wpwGcwTTNd7JvjuNo0oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxMsx3cHwUr9aw9UIT/63uYgRtSDwjaVlWvydnP2rlu3JmDV7jDy+LUhj5OIgKWaJ
	 j5zzCc2i8HYrTpmdbfKJ/1F/bSHu8+O8WxWHEA7TZAws9HO3mtFuY2Pzp/O0A9/Gfr
	 CvlU4DXpMKu4gmS+qN7AS29pN8+H//Tot0HYt+wmwyqKL7EeBopkzdCs9wB/mpDeNX
	 qMb33fFb2ok3Z2N0c0ZL+KhZHruhJ1eos8HWJVponiymQfesoHFkUeGpqEWpW/aoyc
	 q2b8uaVVx4wxibCe7J3TeKyrVFvwsfh28c3sNhYiB9vBaheoNlln2iK2R6zpb5069r
	 j2CjVGfWWcrhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: check for buffer overruns when examining local/remote xattr entries
Date: Thu,  5 Nov 2026 13:43:41 -0500
Message-ID: <20261105184240.2288412-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110428-depose-unlatch-68ce@gregkh>
References: <2026110428-depose-unlatch-68ce@gregkh>
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
[ sashal: adapted checks from separate local and remote helpers to the combined void-returning xchk_xattr_entry() function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/attr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 6e14c9fc726dd..dba6b6bf8e3c9 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -281,6 +281,12 @@ xchk_xattr_entry(
 	/* Check the name information. */
 	if (ent->flags & XFS_ATTR_LOCAL) {
 		lentry = xfs_attr3_leaf_name_local(leaf, idx);
+		name_end = (char *)lentry + offsetof(typeof(*lentry), nameval[0]);
+		if (name_end > buf_end) {
+			xchk_da_set_corrupt(ds, level);
+			return;
+		}
+
 		namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 				be16_to_cpu(lentry->valuelen));
 		name_end = (char *)lentry + namesize;
@@ -288,6 +294,12 @@ xchk_xattr_entry(
 			xchk_da_set_corrupt(ds, level);
 	} else {
 		rentry = xfs_attr3_leaf_name_remote(leaf, idx);
+		name_end = (char *)rentry + offsetof(typeof(*rentry), name[0]);
+		if (name_end > buf_end) {
+			xchk_da_set_corrupt(ds, level);
+			return;
+		}
+
 		namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 		name_end = (char *)rentry + namesize;
 		if (rentry->namelen == 0)
-- 
2.53.0

