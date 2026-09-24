Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2C4CCDD5;
	Thu, 24 Sep 2026 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281395; cv=none; b=rrtVvskHb/3YZi7e9Vez6EQCs1tDRQ9g+a14q4AQzZpuqfEwuFnWRzQiF8EXXc7FAhuQltILoMGifStxkoYi/LYPsM0TsSA2xA5xUzPybsRSdWMLFsSCBT76ESKkWZZG5hl51+O2t82ybQgkDAAJLyBK5SBFQINV17aTlr6m4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281395; c=relaxed/simple;
	bh=ywWgSKZ9M8JMUZyXFiqqRwjOufXQhfrVgCwbuOZqYNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7t0Em1lu0HXa2HmK3l+fatx//4glh5vy3anRRoqQD4zmAAxdxUpcHC2/p8xEbIdFNsqQlqNQlFMD4w3UZbemVSAHjBBm8t1Ly5XxbrKlX4BpGR3qzF9McmEB8PHg36HEdI5Z7zjdsS6L80JfUxtQqLeuNfNAXqA0/1fXMqoUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oREc8FRP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oREc8FRP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D34D64E41060;
	Thu, 24 Sep 2026 20:23:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A837B60738;
	Thu, 24 Sep 2026 20:23:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F03C810329519;
	Thu, 24 Sep 2026 22:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790281385; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wcu2lddx2dnUnJTYqmz8Uu/z6oGPWaTm+IedQU/c4mU=;
	b=oREc8FRPAG4UbQSzGTnwF52et3qUD5lEqneMhHlFnx1tr8v18/g0SNGnvjjXCQ3Tqh/WTn
	M80RMHVGJEAhWbCjXPkjpgSDls1oLeq0N92OoYh4NOcYz0wtQKM9AMMYMunrXjekyNG1Gy
	RSOYTDN8cHAubnyaLUDDUEf6CfmlfWE2xDEnAPuAJZCUO/nu7aMlC8giY51wQ1S5bGW7Kp
	1iLiRP43Ht7CZ0OSfyaCw72zkEU5WmrhXKp8Aoq6zXfomTYgH0P0OQaNrH4We0HNDBAP+2
	RtSTdktG4CB9OWJweXxc6jTbvk03Bze/CtTNNstmfbLcgPQGOI4VhlENTmQpxg==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Thu, 24 Sep 2026 22:22:43 +0200
Subject: [PATCH 5.10.y 2/3] net: add skb_set_end_offset() helper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-cve-2022-49142-v1-2-0bfea684c11b@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790281368; l=2964;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=XtBt+/L0qC2RUOyc8jXidZjf/LLTBNBZxO1nn7gWJBI=;
 b=DCXZMD3fodwRNyTqlsdpjlofqAKUyZLt3s4WWRf3rWW1FGFG6xX6JxkYZHSbtRB4Ysu3m8lQv
 iT5mU2qUvnaCWvzbFCI3lyJ+KlVGo90H5xp77hNSVrS+QyVxZlisv/b
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Eric Dumazet <edumazet@google.com>

commit 763087dab97547230a6807c865a6a5ae53a59247 upstream.

We have multiple places where this helper is convenient,
and plan using it in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h | 10 ++++++++++
 net/core/skbuff.c      | 19 +++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 80de69bf9586..34b6a7e3af8d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1416,6 +1416,11 @@ static inline unsigned int skb_end_offset(const struct sk_buff *skb)
 {
 	return skb->end;
 }
+
+static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
+{
+	skb->end = offset;
+}
 #else
 static inline unsigned char *skb_end_pointer(const struct sk_buff *skb)
 {
@@ -1426,6 +1431,11 @@ static inline unsigned int skb_end_offset(const struct sk_buff *skb)
 {
 	return skb->end - skb->head;
 }
+
+static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
+{
+	skb->end = skb->head + offset;
+}
 #endif
 
 /* Internal */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ac2fc4d1f4ea..8118cd4e1b31 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -278,7 +278,7 @@ static struct sk_buff *__build_skb_around(struct sk_buff *skb,
 	skb->head = data;
 	skb->data = data;
 	skb_reset_tail_pointer(skb);
-	skb->end = skb->tail + size;
+	skb_set_end_offset(skb, size);
 	skb->mac_header = (typeof(skb->mac_header))~0U;
 	skb->transport_header = (typeof(skb->transport_header))~0U;
 
@@ -1686,11 +1686,10 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->head     = data;
 	skb->head_frag = 0;
 	skb->data    += off;
+
+	skb_set_end_offset(skb, size);
 #ifdef NET_SKBUFF_DATA_USES_OFFSET
-	skb->end      = size;
 	off           = nhead;
-#else
-	skb->end      = skb->head + size;
 #endif
 	skb->tail	      += off;
 	skb_headers_offset_update(skb, nhead);
@@ -6105,11 +6104,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	skb->head = data;
 	skb->data = data;
 	skb->head_frag = 0;
-#ifdef NET_SKBUFF_DATA_USES_OFFSET
-	skb->end = size;
-#else
-	skb->end = skb->head + size;
-#endif
+	skb_set_end_offset(skb, size);
 	skb_set_tail_pointer(skb, skb_headlen(skb));
 	skb_headers_offset_update(skb, 0);
 	skb->cloned = 0;
@@ -6249,11 +6244,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	skb->head = data;
 	skb->head_frag = 0;
 	skb->data = data;
-#ifdef NET_SKBUFF_DATA_USES_OFFSET
-	skb->end = size;
-#else
-	skb->end = skb->head + size;
-#endif
+	skb_set_end_offset(skb, size);
 	skb_reset_tail_pointer(skb);
 	skb_headers_offset_update(skb, 0);
 	skb->cloned   = 0;

-- 
2.55.0

