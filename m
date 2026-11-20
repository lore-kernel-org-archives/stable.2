Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183743;
	b=zVqBlUYFGnXLJ828rj/oXkNudH8n5A1KiZOhcjHLNJNcjbN0ZtJr9UqzY99nVUlsk3k5
	 YkR22KUByQudm7a6npU5p+rdUR97mJToa9qVGNvgL83Z/oc1lUDG8TAfzp5IZvrtY1pci
	 VCOf80bWPH/OHLpeAL77+SFrQfnZrLirKZlVwmjHtnHz+U0404bmgCGXOORXudCwQ/tan
	 6Mh/M54E6631urZ4nm/ectnk+rqGKJU0VCLxx8ZYJPcCFHC3lw9Ls6Vx2aFc9JUGMqHDl
	 hI4u+N6jKC6qNOFbLTTXqZy5E4IfhFEUwsG6u5KXn0ocoWdyW7z/rRlKTgWtAQVWb+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i8o5obuhKYzZzTMxbyuPWpCrvH0/smuh9G7Q1LIM9Mk=;
	b=bccFQQXfr2NZTWPxqovYam/xjt8lVMNMAAEcBhq6t0zRmvBs8uZiNjAJ1wioWWeKj/yu
	 +XBrS+D0kcN9xFdFSe6uJxkj7pFDzB5ZH0V3vsMrrLl8dCXgzm6zJZmVLHoPbFQDKIr0d
	 O6zb4aDjQXSqjAcveWUN6q10xbje/4V0UsSMjxQ0TqI5wtZFvnvqrSG0eCurnW34djRpi
	 uRHA8W/uQTkduYy3lKzY1n40QYCAPgM4sqiejROmWCFPsXmTO8IaajPEBprh/jn16CoUB
	 keNjVXt9C5F27CncJ0p9TvYcCvIxOUukmA33BpQjdeujmJvGb23LpX9Q1XnssD4hFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=yWwicMdU;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A66606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A66606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=yWwicMdU
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4d543b6b6so5246867b3.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795183741; x=1795788541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8o5obuhKYzZzTMxbyuPWpCrvH0/smuh9G7Q1LIM9Mk=;
        b=yWwicMdUeVNA1UsXEGn2NprcBEJ0rMyuPq9bmUiJOmZaie64Zg+7JQorf89VHSc064
         0IwtLEU8u4Oe577I0Vh/wDw7KMxBLh6zWHVgbCmUxy3M1g2//5UcSW3n/BbSVgoreuw+
         3pgS+MbjbqPhpcfTLG6eur4htjXBP3HNoCOHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183741; x=1795788541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8o5obuhKYzZzTMxbyuPWpCrvH0/smuh9G7Q1LIM9Mk=;
        b=bMb5a1aWamGDnciSPIrU0UBD9ILjqDlkaJm8Su5OR7ehDR6VTVjeDVKQhcaVlJVJJS
         t69OT29s+zbx9y5xqabiXFN2VgptGLA7C/GHWYtYvzuLJyK787hjm8Kc0vj5EuAXW3hz
         T2KOEJi0geBV9sv31FG8S9HZ5vTEnqDab+FG6SAZfj8Ehmq9GXRkXCP018xkLSoWEt8a
         LixH902LgGYPlqcLav596f2TQu2VwGXLBK4WVFGCY85EABCvlfCB+CM6fxVe8fX8yx2d
         ED7XOLHPscABSlitjPk2kozcum40PxZ7JaEh/CQrDiAqs6Q0CJRK+TZAkR+4qe2yF6NV
         QSuQ==
X-Forwarded-Encrypted: i=1; AL+hErH9Uztg0xRkU84t2fX7QZY+V3qlw6WrG5BS9xtvhXDOyR9honuHdSb9jJEnbr4ESjfuXw6P7jM=@vger.kernel.org
X-Gm-Message-State: APuU4Z88G1aqfqQZxV+qhxpVHBbpRpQZ14+bkBdixKY+z3omy3lKfnl+
	spAhLHjD4Z3NfDEZIB1SP6IZC1hfQZPgEZrzuiHalBGl1xzlo2gN6pWLNWO7hQYGKAF226JFTgf
	cX2Q=
X-Gm-Gg: AZFdTZepgD/XIVYtlihGZ4OiSHqrx8U2t8P4sX1sGXgiaitXo+vDtGom2g80KoeGosG
	mpiuknzU7XgR2R8xJIvUU2cS1ih5Qg2NdOTY7FRP6GtYQD101gxlLMLlrpXZhlrfnvw8agh7cT1
	CIB7ieakxt3TOsx8xSyUxP9vb78gxLhqqFlwZbSTbbyPHR8G95JtMAHMKXLlrx2NOMR6PLCZwKH
	R76hyp/Kbk0DLG55U9epqK4smlYpNrUW2D2O7H7hgpf6qEQZmqxpCpWXh9moUCKj0fpLNmbdIZc
	mFzvnrvZipq1pzcwNRe0SBTGDJrsTfIf1ysVLUavW0SMdri+7wmUPUM9FBp00A4CIPXI3cZTEJY
	8qoKHsV2c+Yc22UzzE/Ykdr6ZI6yzlnCsXEDQupN1LSx9PYlLmbMETX52ibuw9W9KbVERO9Ifzf
	LpfkmPmloq/B1ECIlqMQ+NFkzO0W7X5zlGu25rPKSJhB9rjaCrQgUNM4z0A1Y5tVstH0vfuaho3
	679cn++gL9VFBHO7kKyjAaDiTckjK0DX8ptUNkY4VEF3q2ClMHj9P+vVH+46S8oXxi8Ec5FlwZJ
	nO3psK1Od36g41qGQ5tpJ560xjj/Sw33Nt+kN9SfvqlxAOirPO0Of+mooOphGuUet/YvFO7CaVI
	=
X-Received: by 2002:a05:690c:9c02:b0:8b4:d584:6178 with SMTP id 00721157ae682-8b5204b2f94mr15536727b3.63.1795183741483;
        Fri, 20 Nov 2026 06:09:01 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202dd36dsm12990277b3.26.2026.11.20.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:09:00 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eyal Birger <eyal.birger@gmail.com>,
	ipsec@lists.linux.dev,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net] net: xfrm: interface: restore dst_orig on every xfrm interface
Date: Fri, 20 Nov 2026 09:08:56 -0500
Message-Id: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

Found while auditing the xfrm metadata consumers of a steered packet. One
of them is an xfrm interface, which restores the original route before the
xfrm lookup; the swap warned on the metadata dst still installed in the
skb, and only the collect_md arm restored the route at all.

The issue:
An xfrm interface takes the if_id and the underlying device either from its
configuration or, in collect_md mode, from the xfrm metadata on the skb.
When that metadata also carries the route the packet arrived through,
xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup takes
the address family from it. skb_dst_set() expects the dst slot to be empty
for a reference counted dst and warns when it is not, so the route landed
over a metadata dst that was still there; a kernel built with
CONFIG_DEBUG_NET=y panics on the first packet that takes this path when
panic_on_warn is set.

Two more defects sit in the same place. An interface with a configured
if_id never restores the route: it takes the metadata dst as it is, whose
address family is AF_UNSPEC, so the lookup finds no policy and the packet
is dropped as a link failure instead of being transformed. And the restore
moved the route out of the metadata dst, which a clone of the skb shares,
so the clone that reached the interface first left the original packet with
nothing to restore.

The same slot overwrite is in the unstable helper a tc-bpf program uses to
attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_orig
and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
every invocation of the program, so the restore cannot keep anything in it.

The Fix:
Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
dst_clone() so the metadata dst keeps its own, and empty the counted slot
with skb_dst_drop() before the route is installed. The helper allocates a
metadata dst per skb instead of a per-cpu one, so the route it records
belongs to that skb and is released with it; the per-cpu allocation is no
longer used and goes away.

Conditions to recreate the bug:
A tc-bpf program that records the route as dst_orig with
bpf_skb_set_xfrm_info() is self-contained: the overwrite is in the helper,
so the first packet that calls it panics inside bpf_skb_set_xfrm_info() on
a CONFIG_DEBUG_NET=y build with panic_on_warn=1.

An interface with a configured if_id shows its own defect without any
other patch: it drops the packet as a link failure without consulting the
outbound policy. And a clone made after the metadata was attached consumes
the route before the original packet arrives.

Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting/getting XFRM metadata from TC-BPF")
Link: https://lore.kernel.org/netdev/DMZJS8O5A4YX.9T2P4DT0DAB7@gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/xfrm.h             |  2 --
 net/core/filter.c              |  8 --------
 net/xfrm/xfrm_interface_bpf.c  | 19 ++++++++-----------
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++++----------
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 445223a8dc6f..1866e5a3b911 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2370,8 +2370,6 @@ static inline bool xfrm6_local_dontfrag(const struct sock *sk)
 #if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
     (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
 
-extern struct metadata_dst __percpu *xfrm_bpf_md_dst;
-
 int register_xfrm_interface_bpf(void);
 
 #else
diff --git a/net/core/filter.c b/net/core/filter.c
index 946b07a17fce..a1b4f6333d1e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6334,14 +6334,6 @@ static const struct bpf_func_proto bpf_bind_proto = {
 
 #ifdef CONFIG_XFRM
 
-#if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
-    (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
-
-struct metadata_dst __percpu *xfrm_bpf_md_dst;
-EXPORT_SYMBOL_GPL(xfrm_bpf_md_dst);
-
-#endif
-
 BPF_CALL_5(bpf_skb_get_xfrm_state, struct sk_buff *, skb, u32, index,
 	   struct bpf_xfrm_state *, to, u32, size, u64, flags)
 {
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 5ea15037ebd1..7afbdbd11145 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -68,16 +68,9 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	if (unlikely(skb_metadata_dst(skb)))
 		return -EINVAL;
 
-	if (!xfrm_bpf_md_dst) {
-		struct metadata_dst __percpu *tmp;
-
-		tmp = metadata_dst_alloc_percpu(0, METADATA_XFRM, GFP_ATOMIC);
-		if (!tmp)
-			return -ENOMEM;
-		if (cmpxchg(&xfrm_bpf_md_dst, NULL, tmp))
-			metadata_dst_free_percpu(tmp);
-	}
-	md_dst = this_cpu_ptr(xfrm_bpf_md_dst);
+	md_dst = metadata_dst_alloc(0, METADATA_XFRM, GFP_ATOMIC);
+	if (unlikely(!md_dst))
+		return -ENOMEM;
 
 	info = &md_dst->u.xfrm_info;
 
@@ -86,7 +79,11 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	skb_dst_force(skb);
 	info->dst_orig = skb_dst(skb);
 
-	dst_hold((struct dst_entry *)md_dst);
+	/* The metadata dst releases dst_orig when it is freed, so the
+	 * reference the skb held is stolen rather than dropped. The dst
+	 * allocated above is handed to the skb with its single reference.
+	 */
+	skb_dstref_steal(skb);
 	skb_dst_set(skb, (struct dst_entry *)md_dst);
 	return 0;
 }
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 9835fbe63ccb..896180f8d171 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -423,6 +423,7 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
+	struct xfrm_md_info *md_info = skb_xfrm_md_info(skb);
 	struct xfrm_if *xi = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
@@ -433,25 +434,26 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	int mtu;
 
 	if (xi->p.collect_md) {
-		struct xfrm_md_info *md_info = skb_xfrm_md_info(skb);
-
 		if (unlikely(!md_info))
 			return -EINVAL;
 
 		if_id = md_info->if_id;
 		fl->flowi_oif = md_info->link;
-		if (md_info->dst_orig) {
-			struct dst_entry *tmp_dst = dst;
-
-			dst = md_info->dst_orig;
-			skb_dst_set(skb, dst);
-			md_info->dst_orig = NULL;
-			dst_release(tmp_dst);
-		}
 	} else {
 		if_id = xi->p.if_id;
 	}
 
+	/* The metadata dst carries the route the packet is still to be
+	 * transformed for, and the lookup below takes the address family from
+	 * the dst it is given. Put that route back, taking our own reference:
+	 * the metadata dst keeps its own, as a clone of this skb shares it.
+	 */
+	if (md_info && md_info->dst_orig) {
+		dst = dst_clone(md_info->dst_orig);
+		skb_dst_drop(skb);
+		skb_dst_set(skb, dst);
+	}
+
 	dst_hold(dst);
 	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, if_id);
 	if (IS_ERR(dst)) {
-- 
2.43.0

