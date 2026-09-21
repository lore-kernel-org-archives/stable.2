Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDA4ED18C
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012388; cv=none; b=bPi9EPzsfztgxxFt1jFuyYkn+x+dXenXiU/Im5FQyvf/sXRzbEWUoBhNtRfzsWFd4NIeYXw058V22MtHcO5EBzdngQddmzx5fGF3EO8/2ZxYkQT8Zy0qJyH/X7wonmBVvULxQTUpR/ESk3QkrsyS5Kdejr4gafScpqabro1MZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012388; c=relaxed/simple;
	bh=U5EKdWBIbiSJU1dP09Omb4q7Mq8wk1havQycrFwGi+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/vV9kD2Y8j1TTJnIhgXfG79pjIwhFrzBHa6YMDE7mV17Q1b0tSv44rStL7WgzVZuK3IrYDi+jOdXyxlZKHbf+KXfGMxq+v0/E/JnOUtWqKjC4q3s8INUQS0tmB0SAMewtlc8u/r/qq1/RTQ8Yb2w8xmGGEEYqmF6F75HJJQIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXTAaKPs; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXTAaKPs"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso2686587a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790012386; x=1790617186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5FIqOvJ37TsMdMZxbiL8+8z7eHOaHEabZWsoVStaOQ=;
        b=jXTAaKPs74N5povwGroOLXHnRCwicKLScjR/cOolkBqb0m1nMJUoAhXmrw/kUfxa8q
         tEj+K80ADjNfAiv/6Yu/CO9K3RsiMflhgwZyy5iw0eQmxQBlKISNecdxLJdc2Rx8yW8c
         86xKSWxWw37D0bOiMWTBqBWz+HedZZWEZBfxntJAzHmwKpMjJ10uKAXGsMxWrN5ISctA
         nWW/GxMrlv9OsBAnBqliBj6HrwDtFfU9VnaIS59SIb0soR2lseF+wap1lDdjyuqWEBWa
         Te45lDBiTH+veIaFvwaWEdI5Dr15KUqsedSC/q7laSnBcO2gs+vXnH3f72NF5SDdshgO
         t32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012386; x=1790617186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5FIqOvJ37TsMdMZxbiL8+8z7eHOaHEabZWsoVStaOQ=;
        b=Hl3YaoX5k/xeM/ON/gpLvDUWvwidO0g5+r0Bvo8BPielW9GP6ybUhUGXRsgnTYAEuk
         tkffUGEVS1K1gboEQjH+5HYr/xhJ3kG6DyxeWcBAMOGrH5fcQde90wdiHdsILwoXO2qP
         neeOOxLUYBs8yKsJldNldeo/kJbRDFjPkETcNYbfdWZA2yy/BB3TqGSIrv1BLzh2gHA5
         9itsmLhc7OHUZYs3M/5jwhSvLsuQyfaO34kclHMAfpYEgRND07SJ718kFVO99vvv11rq
         rzhJEl8dnEKGNjbRCBjHJiIQjGCcTeIdat8XgQElZ8ScGHCnot4dX+G/LjLnPrLqxqdY
         x+6A==
X-Forwarded-Encrypted: i=1; AKwUvByOXBxThrBmFDZrN5wDz/2RO1LBujm4ElxH3PAjws25wnIR9wP301JztNYNe+TvZj6CxF4Wwss=@vger.kernel.org
X-Gm-Message-State: AFuF++kym3Tzcn9GvfqvoShxJa8ODOJGbG5JLcQiDBc/h4eXro2+oD8g
	2T7Ds7x1LqGETXAk703yQAW9imqxmBfNRUqm1U1XPvjfcxsIZZHIE+8X
X-Gm-Gg: AYBFou2rOX8rXNyHwZ/DO548j7mAySXw0in0e68LMkfJdQovWswbxKXmEN8BKLbly5q
	2B6RG+aTZCNO7BAdlIX5AT9N9Q4aKIRnrplkoG2hB7INpaLhAWvMUuS1jw7JjmOLOUo8OfcaUJE
	p2LVv2NhyH/5Py284s0SzC5q4b27EXR11023k/G9u6IbOsJOno+dZH7WKIN11ga5mzbjH69T116
	l1DI/izc0z6xA1xVD6qL1Or3F7vSuPQXaHqnQ0l98ExjGYyxP/BcjNNEjJh4E+tKl5wnM0k326H
	FRwOk4n8G8Q3Zdh4gE8TLB0HFCSXoma4/ozbZKgJAWw/O4HE+1FGLiwKha4P86NzMHt7CbVB0L0
	GnIlmDrs11oTrTp/v82oSxkC6H8Mq737ybEbk41PrpMu5kr1YPdpA6EZP5fu4297oCi43+GXIUp
	ug2Cf1zviGuRYo6jip8JUVKJbfBX96SCPoBiXefSBVKDUzjRRaVlOxj8pi30pa3lGktYQGszfRu
	ctYj1N3Izgywr1beoI8HmqiAE9yUGUX
X-Received: by 2002:a05:6300:618d:b0:3dd:a196:69e4 with SMTP id adf61e73a8af0-3dda196784emr12197593637.63.1790012385816;
        Mon, 21 Sep 2026 10:39:45 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72af0955esm3986985a12.32.2026.09.21.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:39:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v4 1/2] bpf: clear stale IPv4 options after LWT encapsulation
Date: Tue, 22 Sep 2026 01:39:09 +0800
Message-ID: <20260921173910.90847-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921173910.90847-1-bestswngs@gmail.com>
References: <20260921173910.90847-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lwt_push_ip_encap() rebases the network header after prepending an IP
header, but leaves IPCB(skb)->opt describing the inner IPv4 header. An
ingress LWT route can consequently make an ICMP error use stale option
offsets when constructing its reply.

Mark completed LWT IP encapsulation in the run's BPF network context and
clear stale metadata after bpf_prog_run_save_cb() restores the protocol
control block. For same-family IPv4 encapsulation, clear only the cached
options, as the IP tunnel transmit paths do. When the family changes,
reset the destination family's control block and initialize its ingress
interface, following seg6_do_srh_encap(). Save and restore the marker
around nested LWT runs.

Cc: stable@vger.kernel.org
Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/linux/filter.h |  1 +
 net/core/lwt_bpf.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc73..195898af9528 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -848,6 +848,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_LWT_IP_ENCAP	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..88664382ca44 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -36,10 +36,30 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 #define NO_REDIRECT false
 #define CAN_REDIRECT true
 
+static void bpf_lwt_reset_cb(struct sk_buff *skb, __be16 orig_proto)
+{
+	if (skb->protocol == orig_proto) {
+		if (skb->protocol == htons(ETH_P_IP))
+			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+		return;
+	}
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = skb->skb_iif;
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = skb->skb_iif;
+	}
+}
+
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_redirect_info *ri;
+	bool lwt_ip_encap, saved_lwt_ip_encap;
+	__be16 orig_proto = skb->protocol;
 	int ret;
 
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
@@ -47,8 +67,17 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 	 */
 	local_bh_disable();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
+	saved_lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
+	lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+	if (saved_lwt_ip_encap)
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
+	if (lwt_ip_encap)
+		bpf_lwt_reset_cb(skb, orig_proto);
 
 	switch (ret) {
 	case BPF_OK:
@@ -668,6 +697,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	} else {
 		skb->protocol = htons(ETH_P_IPV6);
 	}
+	bpf_net_ctx_get_ri()->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
 
 	if (skb_is_gso(skb))
 		return handle_gso_encap(skb, ipv4, len);
-- 
2.55.0

