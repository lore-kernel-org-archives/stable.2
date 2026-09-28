Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67246F48F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582938; cv=none; b=ASET75qt/Dm/jv13M6w/uSCW/Ex+wLCBfwFnzoshcEL1/sB/omiMqbFLjGY/WxZHap5ULu2iTWp/DsrtH7C/nToUNMaiH/9rYcQEfydwZu1TDBxzBlUrdptx+2ZoLuYEj/2DXf16TlrJvcyafy5swzpZIHAJSuBG1E3Alufd1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582938; c=relaxed/simple;
	bh=vM315X69MnsVM4faOz9yO771vmrJNQVid98bKYaprtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYa6rBmwsE6rzo7YU1D/HQzlbRtZuiteuzGbvZvCwaWbHHEiU86+1WtjhF5nXhpoQUjCSlmSty3DCNZUAokiS0jECwTqNcevkRnHtO5PYOZ4X5WHRA7OJz5LDBEX6YO4sg2eETnzSu5Ffe8Oxa07YgXPDdjJPwX63Ccpy9y8z1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=26LyvGS/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="26LyvGS/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9D1E61A0FD3;
	Mon, 28 Sep 2026 08:08:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C2F760504;
	Mon, 28 Sep 2026 08:08:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3DDB102F1E84;
	Mon, 28 Sep 2026 10:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582932; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ivdi7qFWGBpEbv93m/7l8gdKY5N87xaML9gAMg/uH9w=;
	b=26LyvGS//W6jRa7XSzrpcZyX4MFvBuPWL7tJjlMMb2HySmmB2TeGFu1LlwYsbV6HM5H/bk
	C/b4QVf5msOWW/alZ6CNB5OBiOuqBuSww+BxvavXnHz82w81d+cEpokFjxgMS8Kd91STjC
	zQ20LiIxmn3FtngM+Im87mdxbiHY0hzswvUkk1JT192H/tWicTEWd3aGIPrAK5210EOc2b
	j3w+/GKFOsRFXyzZjIzLQhmNpd0AqEl2RVb4rowUmk6tQx66hPIu48Ez5kwWhmaDIKNS1/
	SnB6OFBiFmRhMPW9PfA7G5iTQChyZPhk/08fe9x3KXBk76vu1tzd1vZVXv0A6A==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 28 Sep 2026 10:08:31 +0200
Subject: [PATCH 5.10.y v2 2/3] net: add skb_set_end_offset() helper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2022-49142-v2-2-227dee37e858@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790582913; l=3045;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=TJh0kqKvXNnSk/2Oqp6cn9F7BMXxwZVvboGx1QkM9ZU=;
 b=yFZQ1ZML4HTOjf2az/aneBRivtIowGgjDXxujyMxGM1j08NO9K9XXedCMefjLv+n+Znmp2jgP
 VjEIjgeCwzdD8R7wRa32WXG+jy/I75a+abki1FCFMrq3VNILM7upJ2s
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
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
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

