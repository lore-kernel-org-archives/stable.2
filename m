Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B994195A1
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526696; cv=none; b=gpBjpf30yGHCAvbmzH630WPKfeUY9DIBdzHL6Af1Z8+7OKnHaFZWik0Ly2DskbrEwieFz0oGapfRr3ORktVgIkC9R6ynXpyye8qAR/9IVlWMnB3ctovBKIwMFTMBHtRCsHTAybqSJBZVEldMUY0swOXusAZNnuo5+/5JK0eQ4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526696; c=relaxed/simple;
	bh=xtHgkLDLXdIRafLNhcILYt+MkfxN1Q9AfpswHsev6oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrpuq57PYhk7JZzSYMxunSOX5ayzVj7dJrOenMV2QD3888RijnM+RPuS7QbFHp6BWrLriCWKF0jSkYriLehAc6jTC84WRK4jAxmLYStJcZOmcJFV+GYpF0IB982BfvpWgp1dd+fZGgYUTKbbXFtPQjxfjn591PS3OHzzs/mRs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgpWlP3i; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgpWlP3i"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so2645065c88.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790526693; x=1791131493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tZRjOTFhnU5GAKoWVMmwGlqCnUjTFRNgvFnEoiZqddk=;
        b=OgpWlP3iO62GKnimLzp4+kaZUGM6O21ZA6ZhcVYVamD5wmxgoZG/H8JxP3zqE3gHrB
         WQh2E8N9WxKrmctOdO4DbnhqyHUcXJ/vd/Do2gHdjV9Hp2nZTpxYREdlU/J5DrhNri0g
         ZM1b+c8T5UIqVn9bclNhLJjhXr8x0sp5RbO1doIDrFz+lFWygONV035iR3eEO6bdqpvI
         qSVeOpDkm4tBLgE+ex1XV2xrHOtNRyuAcJ5SvJLZ9uf7ZXiwe4MXtPXdRLNsoIxEg3ap
         wzLnhcJqy+Pvl5O0VP29W7oNWBQ71WrliAS+J7eakIqCPZf1RlZWJndOBnSxc3U3JjSh
         mVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790526693; x=1791131493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZRjOTFhnU5GAKoWVMmwGlqCnUjTFRNgvFnEoiZqddk=;
        b=Y8zrz3kS4N8nhsa9pLoV9r4XviD6aDvhXWOXS68xTmY+7EpuGuDvO2ofLOL0+nOvz6
         yOJ4ez6SM3DFjmwaSJcbOxkT5p3f+p8rq2hzLHYcuNb9h9q2dJcYtHSP/PWjOQ78XAwZ
         YjU/ujJrD91vuOdufwpyCLCXxRqr9mXLgc9U8J/AYcbOzBR2OCZBgRrGetg3+QRf00a6
         CBKyjOeRwHNCHXZNSxnxoGE1bsMIcLr8Yyae94sdE9m8N+b5tm8m1S5TJdU1N+Ht9u+t
         9BZKEFreoHKX21m7jIcOIYaFGEUp6Sl23wqA1BHjPAwDNbimVlaNAFuRpN1BCeqMu+gN
         oUVA==
X-Forwarded-Encrypted: i=1; AKwUvByUdMgIqUfSiAxzbXUjKAxzpTVI7+1ALdtbPxSZ9oSXkMWzFH4Dq6eWu1vyes4Saw2xuL3qTUA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsaldoQLYspJKlAYXVqwn/VutkkyyvFBAzePvFW5nQsVBwl8oe
	4Wg1n+y6aq0K/5jNTiu1aRSCQCKkEZ751tWn2sJDcibGWQo4Ii6DswyQ
X-Gm-Gg: AYBFou1vvXGhmc6N9GRDxGCLdyOMpAeWynuZ+rrUOa6/hcsqbOIS58Vdv26flWJJ7Hn
	LyjlWgdzni64nXKmOnZXp+F6vVayMSslonFqlbmK9muD/xWVxsG2xrAWxZo9VpDTP3p218gvb2u
	KrkCynFI7iFIxvozIa8kkwVKKZfV1GmMcDMYDWajFso+vVwHa+ZYuikZSWyZw60vByibU1TWwKo
	9IPBD1ygzuchwoc1uPfoWAWpI4nIY/dfEjclA0wTXCO/fAfYDkd0ReeaBfAr2U264XOEX48KFRQ
	+TqepdwByYA5Z9K20srHB2XYwxGuvspV5zlf2VkV7bDZJiG8rs0V8/fM2gXhQ2NabhYRzXA8rK3
	MthpUYJDmhOT/Qi/tRlZgWuXjqYNYLs97C3+b8Mkg/2gnII/65w+5zMXCLoCIRxs4NawmTZTM5z
	PTNlHB8Uq/FtqiobuqT9/zg8x+EVuvLiu8kjPRaR8Hoy28iSK1zlvO4lVp2okoj0omUBSTMRf6T
	wHRlGfUDTmuWPOYBGgclGwH06+Ccoo4
X-Received: by 2002:a05:7301:2324:b0:341:49cd:6815 with SMTP id 5a478bee46e88-342709b5850mr6503247eec.18.1790526692387;
        Sun, 27 Sep 2026 09:31:32 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3416e4c2f50sm22383449eec.27.2026.09.27.09.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:31:31 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	co+1fe9b56e2c61be5e@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] net: gso: validate TCP headers before segment length checks
Date: Mon, 28 Sep 2026 00:31:16 +0800
Message-ID: <20260927163117.746432-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_gso_transport_seglen() derives the TCP header length with
tcp_hdrlen() or inner_tcp_hdrlen(). Both helpers dereference transport
header metadata without validating it first.

A TUN user can supply a TCP GSO packet without NEEDS_CSUM and with an
invalid IP header. The skb remains GSO while transport_header keeps the
unset sentinel. TBF and police can then reach the length validator and
read tcp->doff outside the skb head.

On the RX path, CONFIG_DEBUG_NET currently lets the unset marker survive
to ingress while non-debug builds still apply a temporary compatibility
reset. Validate the consumer instead of relying on that reset.

Validate TCP header ordering, linear bounds and fixed header presence
before either public GSO length check. For encapsulated TCP, validate the
inner offsets while allowing the outer and inner transport offsets to be
equal, as required by IPIP. Also validate the MAC header for the MAC
length variant.

Leave non-TCP GSO behavior unchanged. Those paths do not dereference a
TCP header, and valid FCoE skbs can have no transport header.

KASAN reports:

  BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen
  Read of size 2 by task poc/133
  skb_gso_transport_seglen (net/core/gso.c:155)
  skb_gso_validate_mac_len (net/core/gso.c:270)
  tbf_enqueue (net/sched/sch_tbf.c:260)
  dev_qdisc_enqueue (net/core/dev.c:4227)
  __dev_queue_xmit (net/core/dev.c:4884)

Cc: stable@vger.kernel.org
Fixes: 4d0820cf6a55 ("sch_tbf: handle too small burst")
Reported-by: <co+1fe9b56e2c61be5e@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/gso.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4df..7c76f721fe24e 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -240,6 +240,29 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
 	return true;
 }
 
+/* TCP segment length reads doff, so validate its header offsets first. */
+static bool skb_gso_tcp_header_valid(const struct sk_buff *skb)
+{
+	unsigned int transport = skb->transport_header;
+	unsigned int tail = skb_tail_pointer(skb) - skb->head;
+
+	if (!skb_is_gso_tcp(skb))
+		return true;
+
+	if (!skb_transport_header_was_set(skb) ||
+	    transport <= skb->network_header || transport > tail)
+		return false;
+
+	if (skb->encapsulation) {
+		transport = skb->inner_transport_header;
+		if (transport <= skb->inner_network_header ||
+		    transport < skb->transport_header || transport > tail)
+			return false;
+	}
+
+	return sizeof(struct tcphdr) <= tail - transport;
+}
+
 /**
  * skb_gso_validate_network_len - Will a split GSO skb fit into a given MTU?
  *
@@ -252,6 +275,9 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
  */
 bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
 {
+	if (unlikely(!skb_gso_tcp_header_valid(skb)))
+		return false;
+
 	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
@@ -267,7 +293,12 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
  */
 bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
 {
+	if (unlikely(!skb_gso_tcp_header_valid(skb) ||
+		     (skb_is_gso_tcp(skb) &&
+		      (!skb_mac_header_was_set(skb) ||
+		       skb->transport_header <= skb->mac_header))))
+		return false;
+
 	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
-
-- 
2.55.0

