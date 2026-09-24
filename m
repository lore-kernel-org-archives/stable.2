Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157C4BC007;
	Thu, 24 Sep 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281388; cv=none; b=p4dk55unfIIAEWOOI1Y5iaJ7lHJk9hcfaOWT5/guoFbxQNfAq78MFbBIGe905/c2urGz/NXiYefVGgLymVRs487cdKpS/TVX6zJM8B9WfT9wh3KEFVDVFux1nKHVOhfZXWWkjTnX6HyjCsAYE3oIwGdRbGwa/zLZqpDrGefrDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281388; c=relaxed/simple;
	bh=gLweIRM4XISp2baOIMY8uK/Sef3bkasI7oNMwYhty88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1213MlElyWHDwsC9UuVR+UzaxN9F+GbwGBpUAx3QWEtABW9n9mn3HFclUh4pxUWLzIH5T+i+GovaNuI8M4bWyKFZrO9Ij+sfj62sdzaT6GZW68nCHCSThl9pzISzdwg0DgprF0Jd1ZUsV9TLOMJWdVG5m1XlsK85B5xSZ/x1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D3GHXNRd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D3GHXNRd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 47DB81A1008;
	Thu, 24 Sep 2026 20:23:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11DE760738;
	Thu, 24 Sep 2026 20:23:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFB96103293D0;
	Thu, 24 Sep 2026 22:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790281382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/HvbqL5ahGM2Sx2LeH1RDjAf8iWg6s+gxtrm64+WnVk=;
	b=D3GHXNRd8FJ6F30rqTW7RbnTDznaED7JydSUvpzRM+LJZ9V74xIK7CFpoeWSsD3n4tDrSf
	Iix5iF6pEgGNfdBxnyC5GbdCnn7wSe71Kf3zMgFEQd1sipPFNF1erX2tt4vvg6/fcjYvEa
	Q+KbjwUQTrqTo4P39VPjPR98Woiy8WBpD88QWDklvvlPbG4tXVjkSuLStJo0GRnBStnoU+
	IIC39UBPHdK5PnKEy9dF8SMh+uJjPVWE/cQeJ6IOYxloi8APDuResRiffAtAldhn9eWNfU
	wEpyZQtkv6Stm+2Ou3zlK8nGIL7IEDMOYyQOZjZRBnLMy0OXphOqhJGI9nj5Ow==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Thu, 24 Sep 2026 22:22:42 +0200
Subject: [PATCH 5.10.y 1/3] net: add and use skb_unclone_keeptruesize()
 helper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-cve-2022-49142-v1-1-0bfea684c11b@bootlin.com>
References: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
In-Reply-To: <20260924-cve-2022-49142-v1-0-0bfea684c11b@bootlin.com>
To: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Marco Elver <elver@google.com>, 
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Benjamin Robin <benjamin.robin@bootlin.com>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790281368; l=3587;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=jK0qXsoO6IZNsU0KEJYVzHpwBX05PjftnX6mzwXZiX4=;
 b=E4RJxPfGlhWAb8bgWbIf4SW/TLdQ0G45zwCjkMNDw435hkZE5N802GsVJ4FtbOF0dyUBYO04m
 suoEN2EmwXwCv6omBTF5NIgDgt4Ql+n/9eO2dCgo19E49C/4t0z1NLt
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

