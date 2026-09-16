Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3648FF8B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578357; cv=none; b=dziwVKMY5rn12925hPRqyFyoRg3w4U3nVmuB3A6pVAV9hc6Zyb+HQn0JD6Hd8mDZBDUjjMeAmzSX6QpjdqUKwZqdZ4U1sgtylvGAjvcmhdwVSEfRLB/KL6CFdqHlJZdk3GfXxaJQ3Mml5TItGnHpDXa6zKLxP63sj1xBGNkZjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578357; c=relaxed/simple;
	bh=smJ+btUvyMLpW0nuhiUI/rkR6uCBK8iVhTfHqjujkSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ooR5gDWW+1TpqgMX4npU9Wr7/CbADOPcRSVmeO6obpM2OUbT6eqMKOWQ12dDEUzI+i6nF251aDyxB4y6SORBDAOGeVSOKOhTi/2JDK/sRDkFrn72uFHT5UicKoFRqbI0fbUg4TKpbSNd/JmPPlUb864ATbuP6gQ0OOg0eWrkMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrCFgB6K; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrCFgB6K"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86efece610cso960296b3a.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789578346; x=1790183146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ta4GSV/f1iLNEWqw1UGps6Q7e0Yo7MBD3Lwe9oPDxDU=;
        b=ZrCFgB6KEmBBpSp9MsFkOlHWODtu47M9B3167cFSXhXdoB8fp2QoJaww1nTouIayPT
         H3ePAACLnA0yBA1dQSEQdXjKBLLpIzeZYlJ7tet0bsf7AaO1/ezUVZ7UfrXhoqCMKQ/t
         nBw+pzeCv6XD4lZhO15aB2uqO0wd6zr4Bhz9KcvEXOiOihzJZDOGW9CYzuOR+KowoRLk
         IflIMJ6LGX8e8Kq+IrfcMjM8Gr/ifAgWMQVAog+JYytBC7O43hWdmesueZOoJBXoIupF
         QxeEzNKTUyRykzzoChjPjVHM882V1jLtQz3wTmCwzIeoJffO5XlkYCYLqydilwl+f3PN
         YWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789578346; x=1790183146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ta4GSV/f1iLNEWqw1UGps6Q7e0Yo7MBD3Lwe9oPDxDU=;
        b=fa4WjYejdLVRrlre2Vi0jRan2ScQcMKsgs/uVYDJpuYpfuq1Cz9SojpP7qmnhs++R9
         XeaQU5ZXZa2wdGn2+q1ByAOVhjszzST8e1jf9SmootVjduwTD1zAR+Kr2U9VfacbLf3z
         FtZw6tMEVLfF35fpJMDNbdLaqHVqMpuLVQ1gZOk59dkrs2XsuDWlLuI27MmqSB0/muQ2
         3E7XpETXUDRIO0+1qe6/SkIqHNgnuXNyGpSE1IcuP8HzwncxFcoS1JsrLPVzd7fmHcBo
         4tgHB1CR6QurSzf15bcYhEgg0+cUgwJ6nO3b95Xo4e+VBjECFEpM6MCDYAm0hZ0ijwCs
         CJRA==
X-Forwarded-Encrypted: i=1; AKwUvBxZicB8OGB0hsADw4C5erAeKCI2/0/BOQjXsbr3nxJ6MyDE05xwrLjQwKUKk/DqmC9vkuR9SMg=@vger.kernel.org
X-Gm-Message-State: AFuF++nBbn6yCkYAexuyORMmM6D14Fupd5K0IUI+FFuPYgJUpNuGefeL
	OFaSG2GeWAt3nsxJFkeMymqAdklzfCqIaKkuJUmNSV1rz6qFw0RUlbj+
X-Gm-Gg: AYBFou3yRFs8HX8Iorp1aSEMRG3cmqkfDM6xt3gc/oC9FJ5YpH9Pq65/lXZnJZJjP9E
	vq7cZqONx1Wcl9py19elYog2zrL5Ukh8CmnNLyVXwjXsn9JuMkdcJH0p9F3rNsxt7J0MXGJRCyj
	jvt9YCjnlWQXe+7YZxlhmb4czpbfRfTEU8ljGnLzw5Lm04rojFSXWmIuTECWYTDtZPUTJvKQWf9
	aq9inDoADB01IwYcZFlSPty3V7rp0bU2lYdE3wL2EjXm0lnYXN1rkj0S93X2xvZ5c6OlG+9moDp
	PJstG4FMOZxEqhBVVdmftgUtP7lGGD1PJ6qsbpFC4dDKUrLyb9y8qFgV+qWpAvLw67fiK0QQ94l
	MxLexABQEfetQCPdxOspb10M5p9+vCk0kZT93uYXkDn7jv5niKcx2/YEfEju8YMjNoicFj4+88Y
	4v5btGv2ysDe5YQZG444LQommm6VWZ6Liw5WWXUa/KeBb9tHuj/hzUjOO/walSuvqz/FDpfyrlh
	4AF5LX04nqT44DDAEzFIzq7S0DVJ0yrxkK/Z3vvuU8=
X-Received: by 2002:a05:6a00:ad84:b0:869:c368:3675 with SMTP id d2e1a72fcca58-87238f94fb7mr7145850b3a.17.1789578346003;
        Wed, 16 Sep 2026 10:05:46 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720172b0d9sm1608450b3a.35.2026.09.16.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:05:45 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Oskolkov <posk@google.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] bpf: clear stale IPv4 options after LWT encapsulation
Date: Thu, 17 Sep 2026 01:04:07 +0800
Message-ID: <20260916170406.1280954-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lwt_push_ip_encap() rebases the network header after prepending an IP
header, but leaves IPCB(skb)->opt describing the inner IPv4 header.  An
ingress LWT route can consequently make an ICMP error interpret an
inner-header byte as an option length and copy 255 bytes into 40 bytes of
stack storage.  The trace decoded with scripts/decode_stacktrace.sh is:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo
  Write of size 255
  Call Trace:
   <IRQ>
   __asan_memcpy (mm/kasan/shadow.c:106)
   __ip_options_echo (net/ipv4/ip_options.c:96)
   __icmp_send (net/ipv4/icmp.c:949)
   ip_forward (net/ipv4/ip_forward.c:176)
   lwtunnel_input (net/core/lwtunnel.c:465)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6264)
   process_backlog (net/core/dev.c:6728)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq.part.0 (kernel/softirq.c:546)
   </IRQ>
   <TASK>
   __local_bh_enable_ip (kernel/softirq.c:473)
   __dev_queue_xmit (net/core/dev.c:4961)
   packet_sendmsg (net/packet/af_packet.c:3143)
   __sys_sendto (net/socket.c:2281)
   __x64_sys_sendto (net/socket.c:2288)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
   </TASK>

A helper-only reset can be restored by bpf_prog_run_save_cb(), while a
program without ctx->cb[] access can clone-redirect the skb before a
return-only reset.  Track active LWT runs and their control-block family
in the BPF network context.  When the control block is not BPF scratch
space, save its original contents and reset it immediately so clones see
the new-family layout.  After the program returns, restore that snapshot
when the verdict continues through the original protocol callback, then
invalidate the stale header metadata.  Verdicts that reroute or redirect
keep the new-family layout.

Preserve the state across nested runs and retain the ingress interface and
L3-slave state when the protocol family changes.

Cc: stable@vger.kernel.org
Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- Save the incoming protocol control block for programs without ctx->cb[]
  access.
- Restore that snapshot before a verdict continues through the original
  protocol callback, then invalidate the rebased header metadata.
- Keep the eager new-family reset for clones and final reroute/redirect
  consumers.
- Add Cc: stable@vger.kernel.org.
- Correct the patch author and reporter attribution.
v1:
- https://lore.kernel.org/bpf/20260915170147.3943392-2-bestswngs@gmail.com/

 include/linux/filter.h | 10 +++++
 net/core/lwt_bpf.c     | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc730..0edd3e6ce563f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -848,6 +848,15 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_LWT_IP_ENCAP	BIT(5)
+#define BPF_RI_F_LWT_RUN	BIT(6)
+
+struct bpf_lwt_ip_encap_state {
+	int iif;
+	__be16 cb_proto;
+	bool l3slave;
+	bool cb_access;
+};
 
 struct bpf_redirect_info {
 	u64 tgt_index;
@@ -858,6 +867,7 @@ struct bpf_redirect_info {
 	enum bpf_map_type map_type;
 	struct bpf_nh_params nh;
 	u32 kern_flags;
+	struct bpf_lwt_ip_encap_state lwt_ip_encap;
 };
 
 struct bpf_net_context {
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63de..4c0461b4dccf7 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -36,19 +36,103 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 #define NO_REDIRECT false
 #define CAN_REDIRECT true
 
+static void bpf_lwt_reset_ip_cb(struct sk_buff *skb, __be16 orig_proto,
+				int iif, bool l3slave, bool use_new_proto)
+{
+	__be16 cb_proto = orig_proto;
+
+	if (use_new_proto)
+		cb_proto = skb->protocol;
+
+	if (cb_proto == htons(ETH_P_IP)) {
+		if (orig_proto == htons(ETH_P_IP)) {
+			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+		} else {
+			memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+			IPCB(skb)->iif = iif;
+			if (l3slave)
+				IPCB(skb)->flags |= IPSKB_L3SLAVE;
+		}
+	} else if (cb_proto == htons(ETH_P_IPV6)) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+		if (l3slave)
+			IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
+	} else if (orig_proto == htons(ETH_P_IP)) {
+		memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+	}
+}
+
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_lwt_ip_encap_state nested_lwt_ip_encap_state;
+	struct bpf_redirect_info *ri;
+	union {
+		struct inet_skb_parm ip4;
+		struct inet6_skb_parm ip6;
+	} saved_cb;
+	bool lwt_ip_encap, nested_lwt_ip_encap, nested_lwt_run;
+	__be16 orig_proto = skb->protocol;
+	bool use_new_proto;
+	bool l3slave = false;
+	int iif = 0;
 	int ret;
 
+	if (orig_proto == htons(ETH_P_IP)) {
+		iif = IPCB(skb)->iif;
+		l3slave = ipv4_l3mdev_skb(IPCB(skb)->flags);
+	} else if (orig_proto == htons(ETH_P_IPV6)) {
+		iif = IP6CB(skb)->iif;
+		l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
+	}
+
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
 	 * BPF prog and skb_do_redirect().
 	 */
 	local_bh_disable();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
+	nested_lwt_run = ri->kern_flags & BPF_RI_F_LWT_RUN;
+	nested_lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	if (nested_lwt_run)
+		nested_lwt_ip_encap_state = ri->lwt_ip_encap;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags |= BPF_RI_F_LWT_RUN;
+	ri->lwt_ip_encap.iif = iif;
+	ri->lwt_ip_encap.cb_proto = orig_proto;
+	ri->lwt_ip_encap.l3slave = l3slave;
+	ri->lwt_ip_encap.cb_access = lwt->prog->cb_access;
+	if (!ri->lwt_ip_encap.cb_access)
+		memcpy(&saved_cb, skb->cb, sizeof(saved_cb));
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
+	lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+
+	use_new_proto = (ret == BPF_LWT_REROUTE &&
+			 lwt->prog->type != BPF_PROG_TYPE_LWT_OUT) ||
+			(ret == BPF_REDIRECT && can_redirect);
+	if (lwt_ip_encap) {
+		__be16 cb_proto = orig_proto;
+
+		if (!ri->lwt_ip_encap.cb_access) {
+			if (use_new_proto)
+				cb_proto = ri->lwt_ip_encap.cb_proto;
+			else
+				memcpy(skb->cb, &saved_cb, sizeof(saved_cb));
+		}
+		bpf_lwt_reset_ip_cb(skb, cb_proto, iif, l3slave,
+				    use_new_proto);
+	}
+	if (nested_lwt_run)
+		ri->lwt_ip_encap = nested_lwt_ip_encap_state;
+	else
+		ri->kern_flags &= ~BPF_RI_F_LWT_RUN;
+	if (nested_lwt_ip_encap)
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
 
 	switch (ret) {
 	case BPF_OK:
@@ -604,6 +688,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
+	struct bpf_redirect_info *ri;
 	bool is_udp_tunnel;
 	struct iphdr *iph;
 	bool ipv4;
@@ -657,6 +742,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	memcpy(skb_network_header(skb), hdr, len);
 	bpf_compute_data_pointers(skb);
 	skb_clear_hash(skb);
+	ri = bpf_net_ctx_get_ri();
 
 	if (ipv4) {
 		skb->protocol = htons(ETH_P_IP);
@@ -669,6 +755,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 		skb->protocol = htons(ETH_P_IPV6);
 	}
 
+	if (ri->kern_flags & BPF_RI_F_LWT_RUN) {
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
+		if (!ri->lwt_ip_encap.cb_access) {
+			bpf_lwt_reset_ip_cb(skb, ri->lwt_ip_encap.cb_proto,
+					    ri->lwt_ip_encap.iif,
+					    ri->lwt_ip_encap.l3slave, true);
+			ri->lwt_ip_encap.cb_proto = skb->protocol;
+		}
+	}
+
 	if (skb_is_gso(skb))
 		return handle_gso_encap(skb, ipv4, len);
 
-- 
2.55.0
