Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727951;
	b=vtXjJ+YSTjvhtupEh1faumIAYU0bUPYScJvYDlKhmSrz7tyMdiXlUComcxk677Z68RJ7
	 S2wuguZHMQ/ZYnKf2jqfj4VEBWwEksui/LJJMPdZPuPogA86YpsJPjcw3UsNrd5EMbUQ+
	 FAy7OeOaGEUWnlLwA3HDJdCny2ldNDdfgML+5l/8kmM7YluHQ6/NvJpjxN/OYLhOfX4Zy
	 6wDnYEIkoIchcom+oox/SF8O9IpK5HhkAVEPWw8mzGxegA3TRpIZeXjDoqgDJmKdoHHad
	 pua7kMD1osIIhM3MipaVaK2He2TAwUHRkKzqwLsPrllWyh/CMtIIongFIsoxA0ZdrVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727951;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oicFZg3PZAtEvtRcxaG/6RIrfDc601vXmAq3DDYC6X0=;
	b=UDamIMQp4kc/qYHbOPSu/ckXulcTflVfngTGtjI8hvrfpZYyMgEhrNCO5T8q7hpCFfhX
	 3aiY+8ryvjuvMPCVm079Yajw5WHEMGByTVm4SZON/aDt1FC4ilfUj2UJp0aaCCmDD/6GW
	 ILHLHqm0TEQWNdwIlAa54u3u6v16O/Z/qAEr+DJ9Xk4D63Joal+KNKWWPvSAZvtRzCdVR
	 aPV4kjcNkMjURgn9YddUlbV6/O2pB7niaK0XPzvqbTrKzZ72S0T7mSauScB2wancY7H8S
	 /uspTCChC/WtO7X2DMMYKDa5YnXcBu+wGE/UhO6gnHS+07PA8Y6/K91FzkZLW4AbCrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGQkgawf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C3606A323;
	Thu, 26 Nov 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGQkgawf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B491F00923;
	Thu, 26 Nov 2026 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727951;
	bh=oicFZg3PZAtEvtRcxaG/6RIrfDc601vXmAq3DDYC6X0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NGQkgawf7OepBD0bNaeywxqe0J2xEr/mGqcfU+Erk9Yq9kaLnkFXwcNCqaMuq5EHE
	 KnmLa6t8gTrul0F4oy/ztYqMqlTk28l55qxZGZkWU0J5NV26wfD+BxchFDC616Hp6H
	 B09YMNNZ7iInObuz83d2e17bBARsCo+Jn4auL7ve6KptHUREzWFypQB4Q1NiScRIOs
	 FE5cjiPr/Ki9n75C9Bv1vWEPtc3Z0b4doPy1fuCHeCYujS92k2TdTVFy1+JU3t57+k
	 STDrCIsS5ENo+81hY+aWEWA8W9J6Ny4yBSHTx7rtaiXAZlGMrSeOBbzBg54/YpPY6v
	 LDRr6B0oQgYrg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 26 Nov 2026 22:18:39 +0100
Subject: [PATCH net v2 3/4] net: skbuff: limit folio refcount when splicing
 pages into skbs
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-skb_refcount_overflow-v2-3-a6f600a5634a@kernel.org>
References: <20261126-skb_refcount_overflow-v2-0-a6f600a5634a@kernel.org>
In-Reply-To: <20261126-skb_refcount_overflow-v2-0-a6f600a5634a@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Rik van Riel <riel@surriel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Chuck Lever <cel@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=david@kernel.org;
 h=from:subject:message-id; bh=k5M7OtcbHAW/WJI8bXuPKFdUy5X+jLqVEyvsPvol7tc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLI5Fpl9/e0a9GRvr3OaGaPhr7TpQc1R8VtyLX4+3G90U
 +bljXnmHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExk52dGhg1XzvhcDfu24Os5
 d98HD4tCiuUuz5i3unCt7KeG45uyHvAy/BVdWXj9dH22f+9S94X2/qX/+bLiPf6vD9oZMP2kTeY
 PFV4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Various networking features use MSG_SPLICE_PAGES to add pages to skbs,
whereby skb_append_pagefrags() takes a page reference for each fragment it
adds. Pages spliced from pipes were already checked when entering the
pipe, but in-kernel users like sunrpc pass pagecache pages directly. This
allows for exceeding folio refcount limits.

This is not specific to large pagecache folios, but with them it is a
lot easier to reach the refcount limit, as page table mappings can cheaply
create many references.

Let's use try_get_page() in skb_append_pagefrags() and fail with -EFAULT.
Don't use -EMSGSIZE, as TCP would just retry with a new skb. The only
caller, skb_splice_from_iter(), handles that.

For nfsd, such a failure while sending a reply tears down the
connection. That can only happen if someone pushed the refcount of an
exported folio close to the limit, so it's not relevant in practice;
nfsd could handle that more gracefully in the future.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Acked-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 net/core/skbuff.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6da51ad8fd440..957335bcc5961 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4714,8 +4714,13 @@ int skb_append_pagefrags(struct sk_buff *skb, struct page *page,
 	if (skb_can_coalesce(skb, i, page, offset)) {
 		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], size);
 	} else if (i < max_frags) {
+		/*
+		 * Don't use -EMSGSIZE, as callers would just retry with a new
+		 * skb.
+		 */
+		if (!try_get_page(page))
+			return -EFAULT;
 		skb_zcopy_downgrade_managed(skb);
-		get_page(page);
 		skb_fill_page_desc_noacc(skb, i, page, offset, size);
 	} else {
 		return -EMSGSIZE;
@@ -7613,8 +7618,9 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * possible, copying them to fragments if not possible (such as if they're slab
  * pages).
  *
- * Returns the amount of data spliced/copied or -EMSGSIZE if there's
- * insufficient space in the buffer to transfer anything.
+ * Returns the amount of data spliced/copied, -EMSGSIZE if there's
+ * insufficient space in the buffer to transfer anything, or -EFAULT if we
+ * could not take a page reference.
  */
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize)

-- 
2.56.1

