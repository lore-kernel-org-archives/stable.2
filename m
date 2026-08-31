Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D523AC0FD
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181125; cv=none; b=rMuZKOTRgCBEbV9KjcN58j/fDivJcLK65UxzotHaxV56atYYynewX21HuDpHqSmEfHWH8NBlKvck6PabzpqVz/vzzmCmQtPbaMMMNVjEDAs/dcu4igowQ66hYJ9XyVgNETRL9Dxk3kOF5MzRSCDdRKJcC80yNGMc1bQ+8oll9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181125; c=relaxed/simple;
	bh=QLF3zllNQkWmxnAbei6cn+BI2G+JatGtZBifJJMY5R8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=md5tVUFjB9yl4i/P9VVQcRkFJ+ypdvNptpbaUCGXXM3cjXRydljfnHYjrv9VdW1bsgd2v65HxvaU0hK7E1imZRaDXJe5gW/mcG/UB6qNQMpee3dtACLQ/KOfWZUPsUQ95hJ7uKafnWEib5cVGXfD2eD2GQRoQOHWpxPqDcGsdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLo3PHBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLo3PHBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9046C1F000E9;
	Mon, 31 Aug 2026 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181124;
	bh=G5t/qtit3iGkjYnM+gQ/O4/sLcEDvvZ9y1Tz8aPPf6c=;
	h=Subject:To:Cc:From:Date;
	b=cLo3PHBYn4hz49gWnhiUQx+mkqJXd+ZKJewoO0yvmJT7CY+UVrAmEnX+SXy5/4cBr
	 470npi9+PfHJcB6ZO14Zyn986GZQ7rMsUz9f6n1WTga9B1QvK9RkwRyqc9Xz02tKl6
	 KscJ5xe7EqtpvXPt0019Mkkr7laI3mngt5zviuwM=
Subject: FAILED: patch "[PATCH] netfilter: nft_set_pipapo_avx2: add missing vzeroupper" failed to apply to 6.12-stable tree
To: ebiggers@kernel.org,pablo@netfilter.org,sbrivio@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:58:40 +0200
Message-ID: <2026083140-revise-helium-d7d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 55dd20f0f4b1be5c9c8a0275d8d763c86563eac2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083140-revise-helium-d7d3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55dd20f0f4b1be5c9c8a0275d8d763c86563eac2 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 15 Aug 2026 13:57:50 -0700
Subject: [PATCH] netfilter: nft_set_pipapo_avx2: add missing vzeroupper

Since pipapo_get_avx2() uses YMM registers, execute vzeroupper before
returning from it.  This is needed to avoid degrading the performance of
any later SSE code that may happen to be executed.

Fixes: 7400b063969b ("nft_set_pipapo: Introduce AVX2-based lookup implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index b3f105520a85..21f5be68c703 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1134,6 +1134,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 	struct nft_pipapo_scratch *scratch;
 	const struct nft_pipapo_field *f;
 	unsigned long *res, *fill, *map;
+	struct nft_pipapo_elem *e;
 	bool map_index;
 	int ret = 0;
 	int i;
@@ -1207,14 +1208,11 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 next_match:
 		if (ret < 0) {
 			scratch->map_index = map_index;
-			kernel_fpu_end();
-			__local_unlock_nested_bh(&scratch->bh_lock);
-			return NULL;
+			e = NULL;
+			goto out;
 		}
 
 		if (last) {
-			struct nft_pipapo_elem *e;
-
 			e = f->mt[ret].e;
 			if (unlikely(__nft_set_elem_expired(&e->ext, tstamp) ||
 				     !nft_set_elem_active(&e->ext, genmask))) {
@@ -1224,9 +1222,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 			}
 
 			scratch->map_index = map_index;
-			kernel_fpu_end();
-			__local_unlock_nested_bh(&scratch->bh_lock);
-			return e;
+			goto out;
 		}
 
 		map_index = !map_index;
@@ -1234,9 +1230,12 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 		data += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
 	}
 
+	e = NULL;
+out:
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 	__local_unlock_nested_bh(&scratch->bh_lock);
-	return NULL;
+	return e;
 }
 
 /**

