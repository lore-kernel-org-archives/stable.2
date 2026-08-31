Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7453D8900
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181136; cv=none; b=r815ETtl0LShYtrlrMn2euEfjEoyEdvCmTyfaL+WpJHwXeAOtkBpsz3uf2p3Z8Uow0avJqto3HTShYIiPn7tu1YR36S6+JfQO+Q3BZH49yCFNBvRe3h8Ehr8Lk7f6lgul/NWFMyI0At7nGLHOu4aClA5RDU/4kksGj6irEawXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181136; c=relaxed/simple;
	bh=ThRI1qw12QTm7SUa7Qr90e/v0KBTo8aNwrI1hyNjtVc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QIvYzJYiglW6Ii726eeLLZD8Lx2uYb4ZJcerVgKfvyVPMkKEhXVFVeqdtOJGcw0Y6icl3E3wf7axJkfehtrAz8OSiToOEHiZjqqE3SLDCddeTfAhqT0UTonVRU6fI/UBDThccARRrf6lK1E4iwLIdO9L6RfXMI1AxV/Vw8PUZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tHkRmWeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tHkRmWeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B931F00A3D;
	Mon, 31 Aug 2026 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181135;
	bh=cFupyuYMQyaMqg514+KdBOz3NiE7spfmULFwLnKrZV4=;
	h=Subject:To:Cc:From:Date;
	b=tHkRmWeqmUEYRoaxbvWMCk1BMTUQd8YIUe7raKM60rXtvMSlma8slrXt86is/yYY0
	 ih5N57XuPntF4HxrmDSKWfU49nHZ2eb5M+Fiw+QrNHq26+2uaw3WBIj/d6vA4shlb7
	 sujnAB+Af+CZWhK/Sitaf1UkLm650ngsJNUEyl+s=
Subject: FAILED: patch "[PATCH] netfilter: nft_set_pipapo_avx2: add missing vzeroupper" failed to apply to 5.15-stable tree
To: ebiggers@kernel.org,pablo@netfilter.org,sbrivio@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:58:41 +0200
Message-ID: <2026083141-pasty-applied-4229@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 55dd20f0f4b1be5c9c8a0275d8d763c86563eac2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083141-pasty-applied-4229@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

