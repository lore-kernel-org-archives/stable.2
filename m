Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990795;
	b=O9HnguTiSi7EQekuUl8mhHbEcij/OvxX3Ei3tN3KrmYqWA5zVTkDti3pu/0tx5bRVLPP
	 hy2uyGAwpxVNmKgOYWfQkRhv4tTQVILl6wb2ZWELuJ3yrT9GiSP+3y+t/SUgbjqU59auY
	 Wn+pb9YjTrjqxo5GQI0PDf8y5LwqCIwp7UOqGdIOlZsHnDrlVf5uYIozsOYLr8pvWY4BE
	 N/rah9QtXMDXY7pBZjcK1Wcvtv0m9HETUWDSZrWSRLPjr1OcLOIgbjkTHZURscw64b7KI
	 UWSrfQ0PFisjo483OFXBVNrvPB0rNWK1hf0Mvg1vhMaLoSI94YhOkLLJF701SRxc3CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990795;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YkLjxEfejJuPL4lHxwbsC8p5SslZ5/tNoomXIlukABk=;
	b=WmFBxBOlal+V6goioyGaQr+GTZzdCA9uoHsEWA4EcspHWOl0+sg6/kqcxi4aUxUlxfAq
	 NyOhmeXG9vka/T1XPxDsKmeq6ETWiXisQRnkxz7/LUU4i9UhQi3/nJKnomf5DSgOqECPz
	 1xKO5r8oI/HIs+2Ec5W9utXJBQYY4GT+43tYXj9wQD81S+87CjJJYSbIlDI2J11PcFP6A
	 3XAVuEWP2LMfemrsUf5T5D/C0/ap5esYOlMkXF9qUzZ9tiI9dT/VxKwQB8hZuV5h6+odj
	 Uz3QKF7v6Jj+Pwoctl9c3bQ4FV9Hn0ZsVUiy++GgmLsZlaq8YPkD64nxhWjkziYoIeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFbRPSJF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28220606A8AF;
	Wed, 18 Nov 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFbRPSJF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672B1F000CF;
	Wed, 18 Nov 2026 08:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990795;
	bh=YkLjxEfejJuPL4lHxwbsC8p5SslZ5/tNoomXIlukABk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XFbRPSJFX/C69AzQPbkqVw/tMG+z4SsfmFkjidQfMzaUT0xe8Xguf6LVPNwXXQZOA
	 pl4yKwGbL4961etmhLq2EzM6JBV44sVEKbKx+9UM8VAnOvmW4F83SfyMHjZxasqmfG
	 GiKhIZe50KVtwYY4gq/ssBgCKx1mAcrKGNF6Z2LizVFZ8KZu6P4CK33PGEcFmcfK+p
	 HhP3bN47BPnVJJA01SYrXoLAs7Iq9AgsLupeYRubilFyX+ovvCAIGZJ3Zoslr4mHPm
	 NT9bXtUUK3iMkBugZzfwE2ipoe2UmJQbBOhAjsZ5//eGzEu//yAnBnNP4iDLdBW5tq
	 1yfGaEuCxTpLg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 18 Nov 2026 09:32:40 +0100
Subject: [PATCH net 3/4] net: skbuff: limit folio refcount when splicing
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
Message-Id: <20261118-skb_refcount_overflow-v1-3-5551b4954c3f@kernel.org>
References: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
In-Reply-To: <20261118-skb_refcount_overflow-v1-0-5551b4954c3f@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Song Liu <songliubraving@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Rik van Riel <riel@surriel.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Pedro Falcato <pfalcato@suse.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=david@kernel.org;
 h=from:subject:message-id; bh=Sq30vkZVXk/xrSazqlDw0jf8y1oNryrxNBcxU8XdZv8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLL+Jm37do1P+X5R0+dls19/cVWo8OU9eYM58WMZ1xt93
 fVtV5c2dpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCR7nuMDJN8wrev1035+iXw
 /6Qr8rILmL8d3be7VPVghYdIUK3ywxiGf7Zehb6Zbb877p5gL4l/pCVmNC/A6Kag+srMh0kWPOc
 E2AA=
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
index bed1c8c4c6b99..c937d74eed6ac 100644
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
2.43.0

