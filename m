Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C0379ED6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789531866; cv=none; b=UWPHIN96AePTG+jHwiHz9uxLyIKJQTnUGT9gW19lxgpKATQsDKPr/SlXQpbyg+/3lhfqlFRB3TMpucXdSRsSQFfbMuK0yDqxKhTRn5uT/qvhlB1I8UlQINELwU5HSlftbpcle/JmOPueD3ohOn0UZD4HdiCg6PF5NPMtpl6ANBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789531866; c=relaxed/simple;
	bh=BG9eS0VX6qiKVgiD2TzOx/munym2UoldfB5y0hqmq+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=otHtqr5qOmSNe7ckDrMPUWuwzDz5zZQzWzSnIs7xdg+had6fKRg9gfPY8BM1r0pKEwSUnIU+jEjkm0U8dIoYqMWnRTok4/ZSjeXUNC2LFItEyZ+nvd1Nk5CoeLcb3o7bRooKg36dwsYxOYaipdZXMninhkaGUf5G9xYVqXdh0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=MFhDn59u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="MFhDn59u"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so14444695ad.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 21:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789531864; x=1790136664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nFZ79naFkHGO8T/sa7Ej6UkWwoja78MVIsc91vCgw9k=;
        b=MFhDn59uJJ3GWyBrovaJkAD7odCGpM8WUhl7YXjWeK4geIA0i6YYp/SSDfVPAdDXMC
         07EbKtQzhZlTkzs40a5aiuqCG3qC6wx5K8A51EkYepsMPJillE4ytwWNlXbXO2LtiK/D
         snlAtiEuyeF7+V94FFJ8ks3tYb6J7DeeVzkA737buGZy2TZuCQd8hrMYxXnQR05xzD+K
         vQlWV613mm+XqeRXqlMcIkpOjywNUioI3wNpYgnPejjFvsQYpqnDPKkF1sVA/SeAHzBR
         ZUcm8ynbT0eyIeHUdLFtn63D1as4nVkktdVyRKf17Ym6oFJuuQI3L0AM7Bt1Z4DLQ3HE
         plsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789531864; x=1790136664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nFZ79naFkHGO8T/sa7Ej6UkWwoja78MVIsc91vCgw9k=;
        b=vtBLKqaEXt5eCLzclg8/lDO5LQAw3r0w6A9MlmsfuhxFSYMMoV+ygA8dyhfxoXZNbL
         0MMt3Y75dP7biNtIC93UjGjl04sPmY31wzU4V4e1eNUul0pcOmAqVSNPSaN12afpD+9b
         mRNyjH7HOeDZo6Sv4FioO0/KD68LQqQxsqNu3cczn3u5wcWtms0kRba8C9YZOKEFMkNK
         DX6Ka7xGDIHWsB6p42zcvMBEMA8aVq+2lhxUc0DhjG7yiHo0cdHvhwKDzLRcnVXmm66h
         y4zK722wOnUjrRtHogOODm2SJcopiE0QEhH0jGDuU/obNQChJ/RpWVU1wMP366oueNb5
         EzmA==
X-Forwarded-Encrypted: i=1; AKwUvBy8TIHEmRmbVeG2fVhkmI0rUurquu4ndoXTKSu1rKUwi9Byf/WQ4sG0+3BOVAOsFCdP35aaHVA=@vger.kernel.org
X-Gm-Message-State: AFuF++l3DxfDHBE3LT3iJbdlWFW3oRXtE+TtKouBvKzII4UttlxoLLRE
	HV3VO0Yg0s0nqj/rGaPhsC+hNMu7ohB8F3KVTaz2TXESNpsmEnI8Wq5rwQ1sUccqFg==
X-Gm-Gg: AYBFou1lzmDnPGcrT9uf4Hjcan2g7xEUn8yWx4BnKPpW1EDEGE5ImCFSZxdst8jxDo2
	OgtfQLjEpxXpt//pCrBbKH8Ou5ZiUIn8zX6mB1yxz0tZvBAP8KFl2ErCUkh8zJsOkpHWcEygz+l
	hUpu+VRmqvUX1szo91U6Sunevj9jNT3Pamcx5Jdqm9FqzMTVQKb7amsQAjx0vCtQb25JU5yZ+e4
	PfBktLWjIrPWRQGT7v82FI1rHAgnMgZd9W8jDxKZzPxAJFGKm4PClpCUJFyCKJdCvlOGTQoeVOr
	RRXXUd9MrFiWBH39G9Qnm+JjOa/AWZSiMJE8U5aiL/pxfPvbqaDikSVjkcyhEHKtcMI4RcVRrfH
	oAO55Lyg686Y1YzIJoEwvnODA7ubDnF2w7hWZih8Eg8OonvMq3CtEZlM0iqCRaS0k0HB1L5achv
	XF7E7GQngkH3L9knMr1xoHDi+I6ajf9l9TP7l01dU2bqMr/W5+C3gphBGM3RpeW4r6EJs2/O0+6
	qiSzsq4Hh97zJ31Hhdo1+ZbikISpGQ9YVZ3Bgyc5z3RWiP4
X-Received: by 2002:a17:902:e74f:b0:2d7:1858:1d96 with SMTP id d9443c01a7336-2dd764c14dfmr75730075ad.7.1789531864357;
        Tue, 15 Sep 2026 21:11:04 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af4f0bsm4138749eec.24.2026.09.15.21.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:11:03 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	co+ff13a35f73bb7891@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] bpf: lwt: clear stale IP control block after pushing an encap header
Date: Tue, 15 Sep 2026 21:11:02 -0700
Message-ID: <20260916041102.1914333-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lwt_push_ip_encap() prepends an encapsulation header and calls
skb_reset_network_header(), but leaves the IP control block describing the
inner header. Its offsets are relative to the network header, so they now
point into the encapsulated packet.

On an ingress lwt-bpf encap route a forwarded packet carrying a Record
Route option then reaches __ip_options_echo() with a stale opt->rr. It
takes the option length from the packet and copies up to 255 bytes into the
fixed-size option storage on the __icmp_send() stack. ip_forward_options()
writes at a packet-controlled offset for the same reason.

Clear the stale state once the outer header is in place, as the tunnel
encapsulators do and as seg6_local.c was taught to do in commit
f967455fb2a5 ("seg6: reset IP6CB after IPv6 decapsulation") and commit
44930446dde4 ("ipv6: seg6: clear IPv4 control block on IPIP
decapsulation").

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo (net/ipv4/ip_options.c:96)
  Write of size 255 at addr ffff8880bee08930 by task exploit/150

  Call Trace:
   <IRQ>
   __asan_memcpy (mm/kasan/shadow.c:106)
   __ip_options_echo (net/ipv4/ip_options.c:96)
   __icmp_send (net/ipv4/icmp.c:949)
   ip_forward (./include/net/icmp.h:43 net/ipv4/ip_forward.c:176)
   lwtunnel_input (net/core/lwtunnel.c:465)
   ip_rcv (net/ipv4/ip_input.c:612)
   __netif_receive_skb_one_core (net/core/dev.c:6264)
   process_backlog (net/core/dev.c:6728)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq.part.0 (kernel/softirq.c:546)
   </IRQ>
   __local_bh_enable_ip (kernel/softirq.c:473)
   __dev_queue_xmit (net/core/dev.c:4961)
   packet_sendmsg (net/packet/af_packet.c:3143)
   __sys_sendto (net/socket.c:2281)
   __x64_sys_sendto (net/socket.c:2288)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Cc: stable@vger.kernel.org
Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: <co+ff13a35f73bb7891@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/core/lwt_bpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..17be476b5717 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -649,6 +649,18 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (ingress)
 		skb_postpush_rcsum(skb, iph, len);
 	skb_reset_network_header(skb);
+	if (ipv4) {
+		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
+	} else {
+		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
+		int iif = IP6CB(skb)->iif;
+
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+		if (l3slave)
+			IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
+	}
 	if (is_udp_tunnel) {
 		size_t iph_sz = ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);
 
-- 
2.43.0

