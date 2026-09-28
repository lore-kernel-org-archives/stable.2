Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351246E019
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582933; cv=none; b=JyvpjTDFviXZv91nwne/Vnp9TeE2RR1JnnkD7ufhzGG6ZACi8Wqh54UMp34AqGnJY0QiUPHZF59YlgHTjTRjL7cO83B/2sidJbZgKn5snHCWPfDOgJoDDJ3jeXPF/tx8yGour/7mq2dLDh5TJNboyEkYICybfBYIzfCY6ruZOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582933; c=relaxed/simple;
	bh=UAl7vh/thK/DQ6YItOBGVjUoKxqTrVvFqAz09uBDK6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0j8/ZC/X3iwjH/7TXlUG7Jhsiq1h6+wChfP1S+JRyoOIboDtOuylidAfpAan2GFk7HHxLsTrHxUT5obHUkmqe1OwTUG5Zc6FEGlyEc1C8hOSOllgsPRaRuOiuQf+tT9mMQj4jEE+2ahwubgtMYF6n5gD+0Zd7iUyYwyPogxHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ueGy4Ydh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ueGy4Ydh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3EC3A4E41089;
	Mon, 28 Sep 2026 08:08:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11D84601BD;
	Mon, 28 Sep 2026 08:08:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20AE4102F1E57;
	Mon, 28 Sep 2026 10:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jMk4i64ZWtMQbosclFWVHyIWGyQC8Z9NTPoZsqnhOno=;
	b=ueGy4Ydh0LF4gkBrmipO6hiN3fkt0x6kOIqMx8mjpzK4YpH2KGXa8lap5t3yh4lR2Tow/y
	x6ve6GqDSlwFdJ9J8kkDlMQ7hsBwX5C0uG9x0MgJexup3p2gqMzHAyaUtAWkVehjpqV4fF
	V5cVNPptV8tw+ybALku+MFxRYGOW+u0ZFVgnXO/SNnouPlIN0YCthqEbrUBVpUHijHpf0u
	N7ahT4b+hBqGTQCVnQB0gsVa1qNlEexmBbIVKRHbdghZjD9tDt0rkw+LoBIW4E9u7+lfCO
	bHTvhG0I+g6MPI2tpiJSBDI5wo/CVeIDBjp73ucWF3CSe/FP9XMaECto1qSB5Q==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 28 Sep 2026 10:08:30 +0200
Subject: [PATCH 5.10.y v2 1/3] net: add and use skb_unclone_keeptruesize()
 helper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2022-49142-v2-1-227dee37e858@bootlin.com>
References: <20260928-cve-2022-49142-v2-0-227dee37e858@bootlin.com>
In-Reply-To: <20260928-cve-2022-49142-v2-0-227dee37e858@bootlin.com>
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Marco Elver <elver@google.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Benjamin Robin <benjamin.robin@bootlin.com>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790582913; l=3668;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=fjOe16DeBugF7mVqeuRDyyvmyrJROFBGNCYHDKNpNEI=;
 b=TarcZTPCmLTMbFrc8TbWiYlvYtGW5JiOs8Ae2sywZ834+VBwTNtFi8oJ9tsesb9KEHsT2Yyju
 J5gEkMcBVT5Asvih7qttOOzjc8QuLG2GsXfwPamSYCBjL+LZ+T0ai6L
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

commit c4777efa751d293e369aec464ce6875e957be255 upstream.

While commit 097b9146c0e2 ("net: fix up truesize of cloned
skb in skb_prepare_for_shift()") fixed immediate issues found
when KFENCE was enabled/tested, there are still similar issues,
when tcp_trim_head() hits KFENCE while the master skb
is cloned.

This happens under heavy networking TX workloads,
when the TX completion might be delayed after incoming ACK.

This patch fixes the WARNING in sk_stream_kill_queues
when sk->sk_mem_queued/sk->sk_forward_alloc are not zero.

Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20211102004555.1359210-1-eric.dumazet@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 include/linux/skbuff.h | 16 ++++++++++++++++
 net/core/skbuff.c      | 14 +-------------
 net/ipv4/tcp_output.c  |  6 +++---
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 01eb7bc4e84b..80de69bf9586 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1645,6 +1645,22 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 	return 0;
 }
 
+/* This variant of skb_unclone() makes sure skb->truesize is not changed */
+static inline int skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
+{
+	might_sleep_if(gfpflags_allow_blocking(pri));
+
+	if (skb_cloned(skb)) {
+		unsigned int save = skb->truesize;
+		int res;
+
+		res = pskb_expand_head(skb, 0, 0, pri);
+		skb->truesize = save;
+		return res;
+	}
+	return 0;
+}
+
 /**
  *	skb_header_cloned - is the header a clone
  *	@skb: buffer to check
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index faea3bf36d49..ac2fc4d1f4ea 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3388,19 +3388,7 @@ EXPORT_SYMBOL(skb_split);
  */
 static int skb_prepare_for_shift(struct sk_buff *skb)
 {
-	int ret = 0;
-
-	if (skb_cloned(skb)) {
-		/* Save and restore truesize: pskb_expand_head() may reallocate
-		 * memory where ksize(kmalloc(S)) != ksize(kmalloc(S)), but we
-		 * cannot change truesize at this point.
-		 */
-		unsigned int save_truesize = skb->truesize;
-
-		ret = pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
-		skb->truesize = save_truesize;
-	}
-	return ret;
+	return skb_unclone_keeptruesize(skb, GFP_ATOMIC);
 }
 
 /**
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e469f689cd5c..6bde4c463a89 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1560,7 +1560,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 		return -ENOMEM;
 	}
 
-	if (skb_unclone(skb, gfp))
+	if (skb_unclone_keeptruesize(skb, gfp))
 		return -ENOMEM;
 
 	/* Get a new skb... force flag on. */
@@ -1669,7 +1669,7 @@ int tcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len)
 {
 	u32 delta_truesize;
 
-	if (skb_unclone(skb, GFP_ATOMIC))
+	if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
 		return -ENOMEM;
 
 	delta_truesize = __pskb_trim_head(skb, len);
@@ -3227,7 +3227,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 				 cur_mss, GFP_ATOMIC))
 			return -ENOMEM; /* We'll try again later. */
 	} else {
-		if (skb_unclone(skb, GFP_ATOMIC))
+		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
 			return -ENOMEM;
 
 		diff = tcp_skb_pcount(skb);

-- 
2.55.0

