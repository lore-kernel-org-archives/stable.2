Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844842;
	b=HANdCAaj6tzcoZDmgVuYvCnNmsadjTMZJs1YuYa3bJbhoZcY086cU8f0DKVvCMs9OmVt
	 PXBYNMBmBSmeHJMaeeymUbi6aMM24b4wQxZYMAmVf86G72yO2dWUgEXZn2zvXzDUzB6Ci
	 fH+LAcA9DflAkneBYt62h1zBN29aQe+A9/aJhgd120H34Ee1Op9WVewXZWNGRKKuZ1CSU
	 nb0OGLR40jSf2I94PkcJQuvHS51NaU3U9PEu/DTWceXyJwKZ3ZYi1OLxS/P5MKzBkUH5w
	 ZNvzmeKTW8CotdD8wxVJ6TtJ3+GVsFcuu91N8oFktUDjF3Wgpwn/4eNtyMOhkI/i5Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HH2wcH5ax7FTuPjYtzidp901kZ7Ug9dNkhc9uw1LTNE=;
	b=JsGLKeEl6sJrz1nNBYc0E4gRb50n+DZCHdxM2YXHQlBdHr5TAZDShl/M3YrmdW9+HyEl
	 gvElDqSlC3yVSbCTDC6ccR2N1eqweWKJmzz7XkT/e3oI+wkxSqrnbfSEO4a+tRRlWZHrz
	 BjbNdHIAdudg+PhiY1yLSBoZ9XDeQMeWzevgiNXBxl6FQsVe9BmQby1jni2JbhcXffOaD
	 sBlSIrLCZgjj6FcWUi7v41KxussZdiwGuOXN9+lAQ/hFVsS0DICXDxuWxQFtcGuqPfSPK
	 zBvOH1Q9cE1bpo3YVHGJ4WfzAPlYrb/n6yOmDm2nYxZlkBUxk3J3i8y7vYgl3/zLCwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hOcQXPuB;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8647606A321
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8647606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hOcQXPuB
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so835856a91.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844841; x=1793449641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HH2wcH5ax7FTuPjYtzidp901kZ7Ug9dNkhc9uw1LTNE=;
        b=hOcQXPuBFVQktIwg7yjAxxl4bwpYGED4nJc0NeRqhQ7aWphAnGCuopcqmDSo0nxrRf
         yKTeNn6G1vt2s5QVZbc99v8NazVP9fFqvWY4CQzrhfFGiqFAdI0ATyUwv/Yb11lXCpYM
         VzHpBJ+zEKpLjLCOVl4vCzu8SAEPp/TOxLVxipQUuHi2qa/tgDdIIPyUqnqmirEcxIK2
         7UwISxcHqCFQfyO9S1AcnvmnEZGvdAsjWx6BznyJLkOz93RiL7O/h/s2ziHeLNs7Uk6O
         U5VB47cIJRa51TrhdwLUAz8m888TzakRMjMz+aHMf5uzYcM4PH4BG9OzYsmQrkOdGuBM
         rTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844841; x=1793449641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HH2wcH5ax7FTuPjYtzidp901kZ7Ug9dNkhc9uw1LTNE=;
        b=Pf+M/geChf3JJp0glZPONEiBbyT04ItLXFQk1O5c7ernaqYpa5VtcN7iVeKBQtaWoU
         jbAzcmamVK9JjW8mdXxWtWN1HF1lapUsyLwe8QsXQ7fJxjFAZZZ6q4CQ1zOac1DcHu5F
         JFmBT4cat5+VYA1AjVwpUDOza4Jzs6n5lNFjBqvhvUBXZNMyN0wkQSk8KNiSYDouhKQM
         QxuGHKD8SbYgie+FUgwnLujd379VcL6ObZBi/Qxn+wcUQPcYcr6equV8Y3iwzuU5gZkK
         wZlYJq8+HAf5aIMz6OztkqkUVqjSuHQw1UVGBr3p0gDuz/d8tBtJJgUp7/CW1bHVdj0+
         If0w==
X-Gm-Message-State: AFq9FYLxqXcK5kRaItZQ/RXaZ2MaMn9vRyAddQVexBYMG5vaGkAUIvze
	FVlYJbXaYrTeSUaT6OT5Q8awcGHGK82EFoQKGwycKOJdYul+2EiRAvCp9Kyw+9NZxEQ=
X-Gm-Gg: AYBFou2NO0oMuh636NLqbyM0I6BYmNtp+ww7Co35epW1uanEDrgMLzWw57P2WiC4Tlm
	6FL0x0KgSCCgJ3qCdtdqwMFP7c58IbkL215HBNL76J0Xdb6hZAw8NrUA14ypR2Y3+XQXDvfItHR
	wDEhbPeCuQu0YTp2iF4htqxGZwF49BlXZT/zQirHTfmiJlSm6ic8wguY8b1BbZKR9qSwpDaYmuv
	naNF4CtU0LA/k3qk/xlm/Vys0fMjcfm7TaA+3C09EdZfuMt0dD2XhO1Jjz57IyJo4ijDMlYqAv2
	2ai53nTpGESl4uv2G69yOPoClZ1EtFs7XAAKOKJXj6r56bMZPGphGSWKWxiZtQ+krjsNUGqZ1IP
	V3O6d2SSxgZs0dV+kqtYfvxM9rLlGGvLCDYwt72EFaxKtsiI53tuCGiFajfnaJSRriATgWRit7T
	jDUEbN7xLMXjfadpRT3kCQ8eHQX/CIJ7gfHshizHc7XEr7nun8yNoSr74FXISyGVu4L1S3Wlp1l
	aBhx8TIKOziLVt4TcFV+GZHJZlSydidghGWYyXKMmQL/9dLANzJ8j0wlCPYGPj7d8vbx/ZtlVJG
	buqF2pzBM2FTN/3fByEtf4rt7u+GlsaebJVyqRZ0S6SFKC6LF9LtvEp3PwIeMghLKjQ2Eege5CU
	d+8HLhMTh04+qwC1xhldluzeUXCe3dITKiTu9g8eplBjg+edMtFoPoipg7SGnkK20CJU/Z8/atQ
	SpYi/cXPF4rrZRnyQRbOFxmgaFCelYxw87tIyHIHwzfCOjqA7xOikyVyhp
X-Received: by 2002:a17:90b:2cce:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3adeaf95bd5mr1642822a91.56.1792844840973;
        Sat, 24 Oct 2026 05:27:20 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb83b408sm1719432a91.0.2026.10.24.05.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:27:20 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 20:27:14 +0800
Message-ID: <20261024122714.610-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100306-reopen-gray-026f@gregkh>
References: <2026100306-reopen-gray-026f@gregkh>
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
[ Ting-Han: ipv6_gso_segment() still calls ipv6_hopopt_jumbo_remove()
  right after skb_reset_network_header() in this version; keep the new
  recursion check directly after skb_reset_network_header() as upstream
  does, before the jumbo removal. IP_TUNNEL_RECURSION_LIMIT is still 4
  in this tree because 77facb35227c ("net: increase
  IP_TUNNEL_RECURSION_LIMIT to 5") is not here, so the fifth entry is
  the one that fails until that commit is applied ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Tested on top of v6.6.160. The patch also applies cleanly on top of
the current 6.6 queue (stable-queue fa04d3db75).

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

 include/net/gso.h      | 8 ++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad51..0749230d414ec 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,18 @@ struct skb_gso_cb {
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
diff --git a/net/core/gso.c b/net/core/gso.c
index 9e1803bfc9c6c..da77dc70f6316 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c3dcdee3f2124..dd4e334a47886 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1378,6 +1378,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 84b17eeaa57cc..0cf44440c96c3 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -17,6 +17,7 @@
 #include <net/udp.h>
 #include <net/gro.h>
 #include <net/gso.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 
@@ -122,6 +123,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	err = ipv6_hopopt_jumbo_remove(skb);
 	if (err)
 		return ERR_PTR(err);

base-commit: 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
-- 
2.53.0

