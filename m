Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1EF3630A0
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378028; cv=none; b=ibaoER1paVHMx+SjOaFmWkaTS0tGXNk+J3vw736kqNpIDA7Ch0ryJQ7hLxsBlXzqGWesQsVEUg0XJ8GYk8mF8WghTTHLdZaclBI0ap2vdueYOYJpU4ByBO6r+arCR8O3fm3wIVJRlSrryUHsYZIhbwijdv5k/B7nLvabM1Nq5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378028; c=relaxed/simple;
	bh=TNUssqU+6WjzJhYGg+GE3ddxY9P2DiNmni13QbBxsMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAX3eXuWMLrcFog+z4xaKd8FtmkBhx8L8XXdjIv1ivxBhhcrarf5VTY7on2Af1l5Yjbv1NUwknhGaYD6jfmjCyUHc6IFhvAzahGsKCM7pPv9DePMgP0PmfvM5f5yKXclNmdqPszxZSFZY7zuJn1HywD1+jgSen4XaJF1S+/xYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gzAro5Hs; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="gzAro5Hs"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8edda5d56a5so17416406d6.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786378026; x=1786982826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1WVUCeqwLELgUg4fs5XXfLh0aBANIvrQI7hc+E9tLXw=;
        b=gzAro5Hsy/RZgbug/CVZnbM8O6/F42LNrimntqXBbQ4Kya3P6kc8ApbonIJVfOMkkU
         LN2byDuOFWc89Ex5K9/+SP9XF6bZ33+LTLPxAyb2NBo2vtNyMkFsmiwdS1551FKmwVbY
         rDQACzEVFyxqokeYpVk2VNGl0ikyjJJ2Lxqo82dr6z7z51eGrCXMaQWpu5J2Hopyhhte
         m00q/gfzocidYv3MutAi5burPiUz1Iw0g6kz3ZVwWOgd9YKIZVbTpRqIFAUhfZC80tPk
         Z2m8RPdOLdHW+9l57pVoz7OpADbzhTNK71mMzurZHNva2WwnFHidqofwLrVFSjUe6L8a
         tbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786378026; x=1786982826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WVUCeqwLELgUg4fs5XXfLh0aBANIvrQI7hc+E9tLXw=;
        b=oDV4wvk9+X5khmBq3EWtYJzUQcN0wiIhXsc3TdkyQLQEyNAQlJns6yDggyTnNR+U6O
         OiVTIV9f9R8x9s3zTdKk7cabOowg1gWnAL14K2RZHnJEH9XhbhqBNtyJZh31Oe4ZIN0u
         cV2nrwYreJ62Hk7wm1iku7QPTSj3qfVMfYa/fUUn9BqgOzuY1YyVg3Il3zCRzI15TfxG
         X9LVnYq3FMXJL/T+d8cwVnYyTu4GsHD9/mFhPYr8B1aq1I7hWekSqFS9FR8zAB8ezMkF
         hMCbnsGeN/MOVxxxhOcOUVNIGw2wUgke67Sv4J9MSAnk3yED7tM2lqgRpw3OxXuYo3cd
         lVew==
X-Forwarded-Encrypted: i=1; AHgh+RpetKYZKWxvLUtkQ0DtKeNG8e6m2BPxulDUMMpjUM/N+vIRVxqYmNJIGvprcBLD4t/PAaz+v70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Reo8MQMkZeClVgUcZxPjUtHhIFUGJItsLi2Q8o/UdJmS3f8R
	H8SmXUlMWlgZPpx/N4bc+OnViym4T8a5WlBnJjt82s3q9hk35/v//+s3e0IjKChIvf6Oolsicsi
	KZbr5
X-Gm-Gg: AR+sD104jXDcGRI0IyUMgHIzaV6aDUqIn1YBf2xRMI6i6qDIt3MfqcDGqgTFlKzpsCs
	3J+y4VZPeDktmFu9QEEvTQDXKRkyWmmEo5iUFJJDOsBy/ahhuxctKDPucZa4JArxT541iFsO9MH
	cgaODdFTs+/6ipd88MJvpEHgj7LxYDVLi7QD1a311DjV1aBxdkESzHpjLLvI4botye0TkIYOLJh
	VV4IAUXFaIVtyCT4STRedtopUDvD7gcxfEP9LEMEt+iq+tLbYWRutR2EwdgJHyY3AMymzJc9C5v
	b6NAI73h23hmxyewybi+vVshCro9/d/ksmlu9ChJeduVRYQa8CQla5t+Hl8TNp6Hu+ZVsD0ISgV
	zFikSTPYgTEakAUpUV19CNSV0E7J+yd8um1nK8z01Jtsz+6941eHakihuRtzoYqpkz/IDHXshfa
	POieJJHat2kiUq+hagEQhWTRn1A8VkMt3SVMZApX7EuhFpj2m4eKLZ2P+93VO+TF7jCTg=
X-Received: by 2002:a05:6214:85c7:10b0:90a:35f9:9694 with SMTP id 6a1803df08f44-90a35f99750mr183376416d6.31.1786378025540;
        Mon, 10 Aug 2026 09:07:05 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908a918d7f1sm74673426d6.10.2026.08.10.09.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:07:05 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: pablo@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	phil@nwl.cc,
	horms@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH nf v2] netfilter: nf_reject: initialize IPCB at inet ingress
Date: Mon, 10 Aug 2026 16:07:03 +0000
Message-ID: <20260810160703.861885-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

The inet ingress hook runs before ip_rcv_core() and ip6_rcv_core(), so
neither IPCB nor IP6CB has been initialized when nft_reject_inet passes
a packet to nf_send_unreach() or nf_send_unreach6(). skb->cb can
therefore retain metadata from an earlier protocol layer.

For IPv4, icmp_send() treats IPCB(skb)->opt as parsed IPv4 options.
Stale option offsets can make __ip_options_echo() copy an
attacker-controlled length into its 40-byte reply option buffer and
overflow the stack. On an unpatched v7.2-rc5 kernel, the IPv4
reproducer produced:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo()
  Write of size 255

For IPv6, icmpv6_send() consumes IP6CB(skb) as parsed IPv6 metadata. It
always uses iif for source selection and, when MIP6 is enabled, uses
dsthao as an extension-header offset. These fields must not be stale.

For NF_INET_INGRESS, clear the address-family-specific control block
and restore its input interface before constructing the ICMP error.
This matches the initialization normally performed by ip_rcv_core()
and ip6_rcv_core().

Fixes: 117ca1f8920c ("netfilter: nft_reject_inet: allow to use reject from inet ingress")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Initialize IP6CB in nf_send_unreach6() for inet ingress.
- Preserve the IPv6 input interface before constructing the reply dst.

v1: https://lore.kernel.org/netfilter-devel/20260804095105.715387-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has an IPv4 reproducer for this bug that triggers the
KASAN stack-out-of-bounds write in __ip_options_echo() and can share it
if needed. A separate IPv6 test reaches nf_send_unreach6() from inet
ingress and confirms that an ICMPv6 unreachable is constructed.

 net/ipv4/netfilter/nf_reject_ipv4.c | 6 ++++++
 net/ipv6/netfilter/nf_reject_ipv6.c | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 4626dc46808f..4933f65138d6 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -355,6 +355,12 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
+	/* Inet ingress runs before IPv4 initializes IPCB. */
+	if (hook == NF_INET_INGRESS) {
+		memset(IPCB(skb_in), 0, sizeof(*IPCB(skb_in)));
+		IPCB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (skb_csum_unnecessary(skb_in) ||
 	    !nf_reject_verify_csum(skb_in, dataoff, proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index ef5b7e85cffa..c36910b8a95a 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -9,6 +9,7 @@
 #include <net/ip6_fib.h>
 #include <net/ip6_checksum.h>
 #include <net/netfilter/ipv6/nf_reject.h>
+#include <net/dst_metadata.h>
 #include <linux/netfilter_ipv6.h>
 #include <linux/netfilter_bridge.h>
 
@@ -440,6 +441,14 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;
 
+	/* Inet ingress runs before IPv6 initializes IP6CB. */
+	if (hooknum == NF_INET_INGRESS) {
+		memset(IP6CB(skb_in), 0, sizeof(*IP6CB(skb_in)));
+		IP6CB(skb_in)->iif = skb_valid_dst(skb_in) ?
+				     ip6_dst_idev(skb_dst(skb_in))->dev->ifindex :
+				     skb_in->dev->ifindex;
+	}
+
 	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
 		return;
 
-- 
2.53.0
