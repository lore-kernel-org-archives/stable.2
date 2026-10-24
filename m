Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844847;
	b=af9XsYaxUpVkVj500pCKHOqgmwwK+IptrBRFRYYwn8nQV6aifVDFWpobkyFtr/rc245D
	 daBMU8t/fPxrFPIeWUhpBHkOgARCTlu+WsW31Pd+bIM6geif7EU2PZ6D/UR5ZHGjWiSQm
	 eo5PbvBRc6JtLGn3BXIWF+eGedVTINYbnlHQ34rLxW0wAeoEY3WcO0ELuilENVyyL/K4E
	 dUt/PKbMmp13K58ZhnQkP9PhsfF0EU7/zZRUJR0jND/a+g9g0UwnjniE8ZzSrfI7T6f3y
	 I4WU5EZOXyPDlEbEZvA8Cb6aX0OjgpeGraQ78q4Vmj4gG7f3oJ6OQZogjQ4jstZmaOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hG6RZGWPZwQLVhYSZ1Kwi0ulgeReL2e2a+qlXsxX6Qk=;
	b=C2VYRscGeOHr0KcpHVIMd+Ot9n3UlV2yPGuEbcOj+2WFF6w7nrbXbEMgOc9GhHn8EhKc
	 +2eQy8sXy4DBTlM1vP6QCSjhRxoTLufm0SAA5W/hsoGuqGv8uN8aPzrVkhtvn1zfAT3e3
	 IMtRMjGAToJByhwP8p1SW48XVnX6cyqx4ofxlXu3VDt270p1LC6PQYShP0sHmJg3hTQ5L
	 lrAkOa1t0J1+bO8VLgnG47f5tO2Uo9/KlRfwWMHkQnnxWPscsdTSmgaxRgU/wHRx4CHT4
	 iZY5BjE94JFOjQCjezuzsXIpjBSzsMyw/F8V/wHBjvRapVgtFgMTOF6j/zCumUlrUQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="bGn/LZ2o";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D7606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bGn/LZ2o
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8246b13cbso14125075ad.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844847; x=1793449647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hG6RZGWPZwQLVhYSZ1Kwi0ulgeReL2e2a+qlXsxX6Qk=;
        b=bGn/LZ2oupK0j8ALos2OmRIa/CYeTdEFBqcN1ydGnf81fzVIGo5MpaDYNOmG2biSdi
         sIRPUsPc8ylh4aqAmDGQ8U/3vjjPMJxdZLYSK0mmGvB9egWnwqPSnSyOzftdTZDA4G1e
         Wu3gVAbQWf3d27UNVKzUTO1ZbRSZrmNVAm3yusLC87VF3XIpgDAGziE7Wj/Uwhbzpx+6
         4OxUyoJ+OxLKnT6KXq6Q7T7VdaJxo+9M5xrM8FLZJBtvrG/FNrKyyNOq5yN2YUocI/wk
         wCYCe+k5wKnLR1p6/8b5bQI4Z9wpeoo3Pxs9jd8kUBp7Z/uDV8CWUXwgP3Uwm26Zd3Ss
         rnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844847; x=1793449647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hG6RZGWPZwQLVhYSZ1Kwi0ulgeReL2e2a+qlXsxX6Qk=;
        b=f2H5HXh93FaXYgn80p9dqUFqHFVltVZOiss/Xk8Wuz/3QY7NKbNHVkHF+AYRsHmWBf
         qJ4k0kf6Y5dGP1W+GvCB4EkLxBcLUBqXkeRYQ2QcfXZkI8O7XoKU9EMe3J2tEsjVLwH+
         pJvR7A8JwqzV7XZhL/uB3v9VqpPmJVSqIGMya/xRToiloEmDP+8VKchAmVQMo+PBE5Ve
         BKTdOdSu9WLgq26FQyVb3tW2o5/jwll0/PyWjVJonEvQYTt+Yq26b5oJmHi+FkSOABVC
         0mUuPJIQY89/hvjRW9ozhMSoAa6Zp2otuOlSInzcQztISfMZcobnZOrwcylZRUEb0uwd
         ukew==
X-Gm-Message-State: AFq9FYLoui5EfbeU/ANwodWJjMwtfNOwPdC8rKPv1NR8CdSvQOU63Cyw
	QZ/GoMM5XLxZIVEEc/B7L+EwrjS8s/9RyjaZxumgH6biMz9riOIHLASQgx2z5zh7zZ0=
X-Gm-Gg: AYBFou2lYgYNIEIwk/MKB1Z3b9MCDF90c55HNkjzLHs6C+XxH8RxAYSNeeDBPcnIw2f
	YzerOu4Xnw08IZqD0k468/48oCRcp8ejnGwAUpUJOCXDz4AGGbPBuwlfzRF67b2dKmGnihVaNd8
	jvEValMedv9+1eVq1+L/HVne7P0LE+U/y2Vj4EdNrd5l0YPtUfq/b1oEhpn6GOFZF4lj+kt3+SG
	R/m4fqvnMyAZg8EhpS6fkS4QnhaBiQcQyDxhtZxSM6WV4kiP5jHhSs2x7omSFIqyBzoFEm4UIDC
	pdGjUH1h7o0NjaEu5Lr9FzTI67RuKtMWBnRHloZ+jzk6F55r3nIOgLIN69BLHyYwTmJCcYBZ3lZ
	AjSgfl6hNNZPbfVEcsdMIFTqLCCjkiLLLCHAGUjx1qacUu5SSEy8o4H1upNoY+0stRLKhdL7B1M
	mZnMXfKp1opJl2ogqT47WLk/kzfOcyjwXDBO74sQQ6ZmtNrEm50wjngC+gzQQupQTFnJIHbC3jy
	Ics5WvrzpJhDTTUC1P3kVy/dv2VylFQffLomwROkPzUYy4rMEGtJx4o//2ylJvUDh8pFNkHUbEz
	PPneNpFrHg4/NJ78Hw4MCHJKFulYJPfPx+L2UaSx7Wea8h/Nj4hO+Kz4vifB5WDIchq6TG0D2Vg
	kOZ/X+GwGO1VLYNlceqjWdFUIfdlYysim4xuroEwfzRnNV7Nu6HaDqLR0yT9PThiR6NOKp7bSrK
	0ftT+7BuEPxGgDVP6Pf2UyQU4cUQg2DCYCd9hZL7uZe3CJHcaRNjq+pTfEHDrRmaodd1hbaWgtP
	3q7yw==
X-Received: by 2002:a17:902:db0f:b0:2e8:4066:d247 with SMTP id d9443c01a7336-2ea9c697792mr15990095ad.33.1792844846713;
        Sat, 24 Oct 2026 05:27:26 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af31421sm5354715ad.7.2026.10.24.05.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:27:26 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 20:27:20 +0800
Message-ID: <20261024122720.641-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100307-cost-creamed-3c21@gregkh>
References: <2026100307-cost-creamed-3c21@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 006c8b834aed8b02bd8fb9fb05e9e7ead37d1763 ]

IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
for each nested IP header. encap_level tracks header bytes, not callback
depth, so a deep chain can exhaust the kernel stack. Making
inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
GSO/TSO later made the path reachable. The IPv6 stackable path was
introduced separately and uses the same guard.

Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
per top-level GSO operation and preserved across GRE/UDP context changes.
Use the existing IP_TUNNEL_RECURSION_LIMIT for both handlers. The first
five entries pass, and the sixth returns -EINVAL before dispatching
another GSO callback.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260924051521.32568-2-zihanx@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Ting-Han: this tree predates include/net/gso.h and net/core/gso.c, so
  the skb_gso_cb change and gso_recursion_inc_test() go into
  include/linux/skbuff.h and the reset into __skb_gso_segment() in
  net/core/dev.c. IP_TUNNEL_RECURSION_LIMIT comes from the 6.1.y
  backport of 6f1a9140ecda ("net: add xmit recursion limit to tunnel
  xmit functions") and is still 4 because 77facb35227c ("net: increase
  IP_TUNNEL_RECURSION_LIMIT to 5") is not here, so the fifth entry is
  the one that fails until that commit is applied ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Tested on top of v6.1.190 plus the whole current 6.1 queue
(stable-queue fa04d3db75, applied with quilt). It needs the queued
backport of 6f1a9140ecda ("net: add xmit recursion limit to tunnel
xmit functions") for IP_TUNNEL_RECURSION_LIMIT, which v6.1.190 and
6.1.191-rc1 do not have yet.

x86_64 defconfig + kvm_guest.config with KASAN, PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP, DEBUG_LIST and UBSAN, built with and without the
patch and booted in QEMU/KVM. The guest sends 32 MiB of TCP over a
veth pair, over one ipip tunnel, over one ip6ip6 tunnel and over ipip
in ipip, with tx-ipxip4/6-segmentation turned off on the veth pair so
that the tunnel GSO packets are segmented in software. With and
without the patch all data arrives intact, there are no drops or
kernel warnings, and kprobes show two inet_gso_segment() or
ipv6_gso_segment() calls per __skb_gso_segment() call in the tunnel
cases, so these packets reach a count of 2 in the new check. No new
W=1 or sparse warnings in the changed .c files.

Not tested: the deep nesting reproducer from the upstream report, so
the -EINVAL path itself was not exercised.

77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5") was
requested for 6.6.y and 6.1.y in
https://lore.kernel.org/stable/20261024093010.485-1-ue081723@gmail.com/
This patch does not depend on it.

Tool use: this backport was prepared with an LLM coding assistant
(Claude Code with Claude Opus 5.5), asked to backport 006c8b834aed to
the stable trees it failed to apply to and to test it. It resolved
the conflicts, wrote the note in the changelog and this text, wrote
the test scripts and the guest init, and ran the builds and QEMU tests
above. I reviewed the patch and the test results before sending.

 include/linux/skbuff.h | 8 ++++++++
 net/core/dev.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1f646364926e4..39bd362d405ff 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4960,10 +4960,18 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+static inline bool gso_recursion_inc_test(struct sk_buff *skb,
+					  unsigned int limit)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter > limit;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/dev.c b/net/core/dev.c
index 7c0d0905dd31b..8f3355f509333 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3490,6 +3490,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a09b90552cf6e..09719f0c5556d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1390,6 +1390,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 171a5c1afefea..4907f4ebf2b3d 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -16,6 +16,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <net/gro.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 
@@ -87,6 +88,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nexthdr = ipv6_has_hopopt_jumbo(skb);
 	if (nexthdr) {
 		const int hophdr_len = sizeof(struct hop_jumbo_hdr);
-- 
2.53.0

