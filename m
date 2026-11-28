Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795862029;
	b=EKIh1tbqrT/vbzpwQ2d7KZaQ8/+zqYzFKlhC8ni+paXKOBiDhWKvrkf9NdeT+m9HaDVn
	 51UHyUVq3AUK5Bl9IMgqHJsSF2ydGTu5xLmDgJ5OfE2cW2tiJsmu01uDRyHWsHCO4g5zE
	 gHUV0abXhhDQwHODx+JUIVEB/LSLZKxF4KYCZp797AHkCA94nhiyZYmdsE3dJ7t5c7AM8
	 HEH22zik6LKcf+0k/2cV+PMrq2TMcBH2aZxrRczlZ2me7SXUt7e6y+UcDAjaSPQ7FvuEz
	 h2JS7H6FMT2aHoo4NCzN3BE0RLWFv3fR2qR7SK6brjd017GW8CjfChbUHQkjaAsB4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795862029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AHvYKHq95D+qAXx/ZpNwF1YDR0GRXaHoHUy1ieoCmCI=;
	b=20aaEMkcQdZ2Uaf1Rj1+5sNoObymqV9PGqL2n52PwDmPqq1bJ5c3w44wK/Zg+cADN4wD
	 AwgWTsnm+6upuUYD1bKrVY9rXc4zlVDxix4I7QMeeohTIKcS+sfynmRFwCb1MOacdCung
	 z63wkUCgEjUpoMVTRLJ0+8mUsQCPOIbdoh8gQKS0vGGKDd2wpdsUS5ijwzxsvmD8F5C+T
	 cRh1mA7Ct72S//4JLbPtv3v9AGlWg/UIkRdH2Wt/S07ThdFfgeSbFRMfJ6bU8wEKxmEZg
	 /iBBJRP55fp4JNWv47+Fy/mVMDHDo3nlZdrpL5TAmpJIVkTMO8ZqKaTM3BW6ao3KbIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=e2W4lw6v;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9738606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9738606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=e2W4lw6v
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f1e5d7450so820493885a.2
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795862028; x=1796466828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHvYKHq95D+qAXx/ZpNwF1YDR0GRXaHoHUy1ieoCmCI=;
        b=e2W4lw6v95tCcg1Vkwlnk4Dv0h1zAJzs9oyxGnURqDy9ElwtavGEaG15l9vEoVGek9
         tAPPm4H2aoSmu4h5EJFayN9mWiWQUaSY5S7tosTA/OX68C9Kyh5CU0EtRjYuEZ15LBA+
         xjBVnY7O1oHIedrv93liO87v6oBKPrLe7iGRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795862028; x=1796466828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHvYKHq95D+qAXx/ZpNwF1YDR0GRXaHoHUy1ieoCmCI=;
        b=aMTbWzdr7IczkM+oV3zoI+RCj8xSV+z47ItMl4R4Klhetx7aCioUDmEVdj7b0qcZUR
         QeI31o7icdMmE2cblucb4pyGl40l08KHk3g53SAN6n9qcQNUoGkVo3eDFkgc6KbsdrsF
         an1v7Pt6eGeMLzq+asECkqLtxZ7BOzo9/stKWrJZBO1ovkkfbJjjUuNRZFGJjTU2rGZY
         reIcJ+VL0bfbp8RrCSQkarH2+Bs6iTBm3+bsx/8eF9XflSBXEFJLqzfJgBJLgtqrYUnd
         e9bpqUhOw+cd3OSifmAGgiSB3aAleGl840JknHRrPOtza9SQRhrf6jxvEDcu+G5Eyztm
         ybSg==
X-Forwarded-Encrypted: i=1; AL+hErFq7opVODG0rmZ/ECpAvPFRurpFLXKs57HS8SkemSJP/reQ1+Kxz45O31/J149Tp8pu2Dssx+U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9x+y0aeqjLPIMnObke/1/47MGNKLBVHImy3qiiQAXxlnOSCKLF
	pSGwslsiaNn+0it/tHZtGScFfnF7RKUGv0JHazIQJyFEjHF4Nuz1wjAHQmneuKs1Dw==
X-Gm-Gg: AZFdTZf5cpRBkc1X497rRPqTuo2EdV8JsPhtaqLYLMyJBRlH0z2V0pjIVsGMy+UlU+0
	TLdIDHrZz+psZ9Kyl7GsqLexoW+ZqotoX53SIbEVhvZSuzNc7BC1lLA90WdR/RIACX1/m7+dYON
	e7TLFmXaqYnXehXyQd3D/4L/rST1Og7GmSZPG+GWX8GnLspm2RGKJFN7xMmEXBgJgwKxCkkWz6u
	rrapDBBANrnKSPJg8cq1wQRHDUlkwE052BRdudzD+r5l14Ncpmv2wUHz3mwTxcHiNKbz0E+Ty7R
	zfajgD0u8bkgz8jfCh9L05dHO7zw4PmAJLSRVgCHiFLrepqd8xo5iEv35NVXhcjL5HrIUmPnLA1
	poRyiMNL0c3RcBXLLLni2UigUJZB48S5kMeNN4Y9AkoKI9zPkiUonCHZofQSy8TzX0J6R7Ly5oo
	q+VG3Wn9G4nf6lb9uL+u/2blQ1SkxWTYH6wzG5FJXS0XyFby02Ad9E2SSSNuT/KW5u+tMap86Mf
	WnQdmgwfqxQDG2ION3Gt1hs94G98Dmz52a+MupWH/WTLdWbFi/rWU7vbuuKjAaYnhFdODo1PIGs
	Cmztcoxjrqlz29UoSVTOlzBbc5nif0bX77Imf//cdVIm13d4BTIhaE9SKNyaJBhwA6wkRkDg9fQ
	89KXn
X-Received: by 2002:a05:620a:3722:b0:949:472f:226e with SMTP id af79cd13be357-949bab15455mr5419372385a.71.1795862027745;
        Sat, 28 Nov 2026 02:33:47 -0800 (PST)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f5c31sm2053970085a.30.2026.11.28.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 02:33:47 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	wenxu <wenxu@ucloud.cn>,
	stable@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] net/sched: sch_frag: guard against same-CPU re-entrancy
Date: Sat, 28 Nov 2026 05:33:33 -0500
Message-Id: <QDISC-R0QC.v1.r0.20261125082538-1@mojatatu.com>
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

This is a followup of commit 975b5b067f52 ("ipv6: sr: restore network
header before routing and forwarding") as reported by Sashiko. That change
fixed the negative L2 length that could reach sch_fragment(); this patch
addresses a separate pre-existing bug in the same fragment path.

The issue:
sch_fragment() holds the per-CPU local_lock_nested_bh across
ip_do_fragment()/ip6_fragment(). Their sch_frag_xmit() callback calls
data->xmit(skb), which may re-enter TC egress (cascaded act_mirred
redirect to a qdisc that calls sch_frag_xmit_hook() again on the same
CPU). Re-entering re-acquires the per-CPU bh_lock:

- on PREEMPT_RT this is a real spin_lock, so the same-CPU recursion
  self-deadlocks;
- on non-RT the inner call overwrites the shared per-CPU sch_frag_data
  (dst, cb, xmit, l2_data), so when the outer fragment loop resumes it
  uses the inner call's stale state.

With the lockdep detector built in, the recursion reports itself as:

 ============================================
 WARNING: possible recursive locking detected
 7.3.0-rc7+ #44 Not tainted
 --------------------------------------------
 python3/20084 is trying to acquire lock:
 ffff8e80bd7b44d0 (bh_lock#2){+.-.}-{3:3}, at: sch_fragment+0x288/0x560

                but task is already holding lock:
 ffff8e80bd7b44d0 (bh_lock#2){+.-.}-{3:3}, at: sch_fragment+0x288/0x560

  Possible unsafe locking scenario:

        CPU0
        ----
   lock(bh_lock#2);
   lock(bh_lock#2);

                 *** DEADLOCK ***

 Call Trace:
  <IRQ>
  sch_fragment+0x291/0x560
  sch_frag_xmit_hook+0x74/0x90
  tcf_dev_queue_xmit+0x1f/0x30
  tcf_mirred_to_dev+0x2da/0x560
  ...
  sch_frag_xmit+0x169/0x260
  ip6_fragment+0x8dc/0xa70
  sch_fragment+0x33f/0x560
  sch_frag_xmit_hook+0x74/0x90

The Fix:
Prevent same-CPU re-entrancy by recording which task owns the per-CPU
fragment state. A deeper call must not re-use the outer call's per-CPU
state, and it must not transmit the skb: sch_frag_xmit_hook() has
already determined that the skb exceeds its recorded fragment MRU. Drop
it and return an error instead.

Owner identity, not nesting depth: on PREEMPT_RT a second task that
reaches sch_fragment() on the same CPU waits for the real spin_lock and
then works on its own state, so only the task that already owns the
state is the recursive one. A depth counter would refuse that contender
too, and reporting -ELOOP for it would be wrong.

Conditions to recreate the bug:
  # Minimum privilege: CAP_NET_ADMIN in a user-owned network namespace,
  #   e.g. via `unshare -Urn`; nothing outside that namespace is required.
  # Build with CONFIG_DEBUG_LOCK_ALLOC=y for the recursive-lock splat;
  # on PREEMPT_RT the same recursion is a hard self-deadlock instead.
  ip link add vetha type veth peer name vethb
  ip link add vethc type veth peer name vethd
  ip link add vethe type veth peer name vethf
  for i in a b c d e f; do ip link set veth$i up; done

  # outer: reassemble the fragments on ingress, then redirect to vethc
  tc qdisc add dev vetha clsact
  tc filter add dev vetha ingress matchall action ct zone 1 \
      action mirred egress redirect dev vethc

  # inner: the refragmented egress re-enters sch_fragment() on the same
  # CPU while the outer call still holds the per-CPU lock
  tc qdisc add dev vethc clsact
  tc filter add dev vethc egress matchall action ct zone 2 \
      action mirred egress redirect dev vethe

  # then send a multi-fragment IPv6/UDP datagram out vethb (the zone-1
  #   ct reassembly sets cb.mru so the redirect enters sch_fragment()).

Fixes: 20d677d389e7 ("net/sched: Use nested-BH locking for sch_frag_data_storage")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260827092345.2301937-1-fouriezhang@tencent.com
Link: https://lore.kernel.org/netdev/20260827092345.2301937-1-fouriezhang@tencent.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_frag.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index 75ee52750919..980f1490b027 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -17,6 +17,7 @@ struct sch_frag_data {
 	unsigned int l2_len;
 	u8 l2_data[VLAN_ETH_HLEN];
 	int (*xmit)(struct sk_buff *skb);
+	struct task_struct *owner;
 	local_lock_t bh_lock;
 };
 
@@ -98,10 +99,19 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 
 	if (skb_protocol(skb, true) == htons(ETH_P_IP)) {
 		struct rtable sch_frag_rt = { 0 };
+		struct sch_frag_data *data;
 		unsigned long orig_dst;
 
+		data = this_cpu_ptr(&sch_frag_data_storage);
+		if (READ_ONCE(data->owner) == current) {
+			kfree_skb(skb);
+			return -ELOOP;
+		}
+
 		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
+		data = this_cpu_ptr(&sch_frag_data_storage);
 		sch_frag_prepare_frag(skb, xmit);
+		WRITE_ONCE(data->owner, current);
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		sch_frag_rt.dst.dev = skb->dev;
@@ -111,14 +121,24 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		IPCB(skb)->frag_max_size = mru;
 
 		ret = ip_do_fragment(net, skb->sk, skb, sch_frag_xmit);
+		WRITE_ONCE(data->owner, NULL);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else if (skb_protocol(skb, true) == htons(ETH_P_IPV6)) {
-		unsigned long orig_dst;
 		struct rt6_info sch_frag_rt;
+		struct sch_frag_data *data;
+		unsigned long orig_dst;
+
+		data = this_cpu_ptr(&sch_frag_data_storage);
+		if (READ_ONCE(data->owner) == current) {
+			kfree_skb(skb);
+			return -ELOOP;
+		}
 
 		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
+		data = this_cpu_ptr(&sch_frag_data_storage);
 		sch_frag_prepare_frag(skb, xmit);
+		WRITE_ONCE(data->owner, current);
 		memset(&sch_frag_rt, 0, sizeof(sch_frag_rt));
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
@@ -129,6 +149,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		IP6CB(skb)->frag_max_size = mru;
 
 		ret = ip6_fragment(net, skb->sk, skb, sch_frag_xmit);
+		WRITE_ONCE(data->owner, NULL);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else {
-- 
2.43.0

