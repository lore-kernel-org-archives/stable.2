Received: from mail-ed2-f14.google.com (mail-ed2-f14.google.com [74.125.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1E3A48ED
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612683; cv=pass; b=s+4p7jUou4HXW86GUEbzcJUNXtTvXv8ETyeIvPP0y6Vf+uo8fy1Hy1lMX/1dZFtaqVAN/rIf7Ty7cA5Eawis4IRG0njhKxBraWkqg8hsYwfpFj8K941/zk9SBrU95O/4Kn28Akvb4fiDW3W1dH8lG/RV1p8m4npJXEnMhnSJpAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612683; c=relaxed/simple;
	bh=eSqYrGFdzJnTQAZ4HkkRLcqRzqG/nAsN66pSJnTFEL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTPSAbz1fcvtewBFxLLY8WEynQloEjEc0Y1PHtyk62ROyianXv8UrZ07sVwjjzbukCGb50pdoxUR/4X7EbF0P6yK5wn2WBQGgdX9FepOJlwvbVJlRWdCqajXBUIGHxicI6RIE4dzAqrufVJ9sAZSzaEk6vG1ZA/ljJH59WsSc1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNLVCl9I; arc=pass smtp.client-ip=74.125.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNLVCl9I"
Received: by mail-ed2-f14.google.com with SMTP id 4fb4d7f45d1cf-6ac681d28a5so331465a12.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612680; cv=none;
        d=google.com; s=arc-20260327;
        b=ieVRaWrOwP7Rexq2XgSu7rjEsc2U6OtQQDHY3edtryEMUjlrDweJvfs1TEbvQG2k2+
         Bm7n6Rokcq5KDgy0B5s/M8gZacVLGWUIocqSLOCX8s9NYKGzQEn7qx8U3y+AtvPZUwEv
         u/CB2njhdvQJcuS/fnschecUGcsSjKqrDo35flVeGYiSsvbx9VDYHt9aZSRlHfiHgz09
         iChMWA7LGzwstl1L//D4yjY3tcDyDqMDFg9ZqZ7whl6D1fuVmpIS1zQ31cIhTjiQEzLc
         y9XWvtA5IglWU3mkJtfFs7UaQIh14gccy5wlVMU3uvGAmbGZqe0is7nRZ7lEVRUFbsUo
         E4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8IJd7+Wspk4FLCke3Tyt0NlFtZVyCyRGc+SsVOR1gL4=;
        fh=VlG+HSSv9eAIT3xoA6RMGNZCELkoaOA2EvAPHOSVzFg=;
        b=fMSvq0qUvkAn1aXGrMkGA2OB058Yu6OEfwaYGyU+fv3MsSP4pYLAgvUTV0Q7vQOTav
         KcDinW4qwW3+aASDvTvwC23GJ6vYUTID3gA6KAAvSlEyQ2HUKKVGfVOo0j3g71iOZwmq
         f4IZtbmsHmF3GpeZdDD2bD9iK0trZnEIG8mfzc/Sj8acMElPssWe8KHTFqfs577I/Dyl
         gQTqCB0hHC8L/haAuqnHvGa8myEIqpq1/kGmp/FURTrzCa3yCS+WQYltiDSwSF/aU5jb
         S366wr70x+ivlkjUqKIQw1BcJjo0uhkH5PAZG4MJd1bGvoZrwJ86RwzRv9NHTMyXm52T
         DqbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612680; x=1791217480; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IJd7+Wspk4FLCke3Tyt0NlFtZVyCyRGc+SsVOR1gL4=;
        b=CNLVCl9IsxGTBVaWQEEjXhhHnylJbJTcAMEALjx+ENg8sF0RuameWu9nd9vrHcsbPF
         hmVa+aw7C2a/v8PQq4BL9QAXXwTNeMZxGz0FQml6ESJwXcOU6rfbdjXWjyKNzJ/M/4LX
         8gCvP2N8nv4bzmIbO7te0IeVp25SpKasKiUaUfA2oKq/QnFbvMDQStDuJ4NLfa4P13lo
         fHqEgn0iignajPzs1PwTWZ1ZIPkuq5YJkoRf1uysFnFjF5ry0uDAsi7VQOzp3/jdby39
         sJTGIW0HxtIMfCoAZ8jfZmikUFeDtrJmWrfNmKRRqQoB6/di1qYEFj3RUS98SUvUC/U3
         65vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612680; x=1791217480;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8IJd7+Wspk4FLCke3Tyt0NlFtZVyCyRGc+SsVOR1gL4=;
        b=oqkEktJsmS6CUVIKMbFH0B5hxDz81/uFEqFjYDjX9GJyT1VsyqWD9McBj3kvn/Y9Vi
         xHmuHqBmbywl5vxjkktCofWk/YQgjXT6++mjs5M2tfAic/PGX3QSB3ROnOTOAeBPDMnP
         5aTPpbT1IIxa0hSII8S8xwhZ4nHHUyOUjCCQ4+OIPqq7pT6vb0gWtcjKBSJc79Cxeznp
         Jt5nnr3wY6b+Ac9LGzwaIvv8tQ6kGKvBlYDyw3DeaOeAQKiQ1cSNZ8l4X2nMbFHr8abH
         CVUg1nLYZeGY5ZD8PMcJr8lZN7oV95sgpHlPCPeZbDoUQlqPToy9zny1benIMoiNdDGu
         T3Tw==
X-Gm-Message-State: AFq9FYL2/cfRDb8ZNNAgFM2KWdrINgWyMraOxWnbziKsmy2JPmaqqiGi
	wkIKD8U7AQcGWK1kKVIF7UKacQCN5NByUlYcWreVOO014mWdFwG28u3+j7sxgHxulquZYn+8xGv
	s1iI9PQR5UvqTJGjXb3nvdfQ2QXScQho=
X-Gm-Gg: AYBFou2CGHNdMp+1aPGuayk1rlG+qxCiFsjoEq58eCRQ6Mz3uzxfHqx3SFBQV71gMZZ
	JnFCUgH8YnjvSWSyj0yCY8ozAl0oCkKehKwZ6J7uslBmoU5VhgXWrcTKF50OMaFP1Y+AxGTllw8
	o2MXGbDAWYxopT2Cffg/JwG/uv08zvwX4nSYxQFMxAfUJ9fWPYoth/vs8H6/g9apWvX+3GJ8qyN
	7M1q+ONz2Of1wKHB6OSSq2YI5Bkc4VmMMzqT83emqTvRTwBwqKrielftOUoShZGq7/kp/3D97ed
	eDX63/b+gxepl8chOX8h3xL+LIBTYe83MyX1GempWAQvZ4bTF+c93v4aNds1/BavBlS2oOU8jFl
	QNYovaEZoTww=
X-Received: by 2002:a05:6402:4506:b0:6a1:de1:f739 with SMTP id
 4fb4d7f45d1cf-6aac8f7a055mr11516912a12.2.1790612679591; Mon, 28 Sep 2026
 09:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927064036.3691962-1-nicoyip.dev@gmail.com> <DU4P189MB3750B9BEFE0E00F5D4A4D548C68D2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DU4P189MB3750B9BEFE0E00F5D4A4D548C68D2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Tue, 29 Sep 2026 00:24:28 +0800
X-Gm-Features: AclHuK-gNX8tjcUHt-Z-K8no_wqf3W60c2bVf1kDtXI-qcYtgwbbyIsKEguwOWg
Message-ID: <CAAo+4rWuOYFoj-KKDdobdSkFY33z6tTYykbUmiA0ApTSKSDzQQ@mail.gmail.com>
Subject: Re: [PATCH net] tipc: hold a reference to nodes found by link name
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tung,

The full KASAN report I just got from 7.3-rc5 branch is attached
below, and I use the following kernel side delay instrumentation to
make the trigger stable.

diff --git a/net/tipc/node.c b/net/tipc/node.c
index bd91378b7540..eca91f0c265f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -45,9 +45,10 @@
 #include "netlink.h"
 #include "trace.h"
 #include "crypto.h"
+#include <linux/delay.h>

 #define INVALID_NODE_SIG       0x10000
-#define NODE_CLEANUP_AFTER     300000
+#define NODE_CLEANUP_AFTER     300

 /* Flags used to take different actions according to flag type
  * TIPC_NOTIFY_NODE_DOWN: notify node is down
@@ -2434,6 +2435,7 @@ int tipc_nl_node_set_link(struct sk_buff *skb,
struct genl_info *info)
        int err;
        int res = 0;
        int bearer_id;
+       int i;
        char *name;
        struct tipc_link *link;
        struct tipc_node *node;
@@ -2464,6 +2466,12 @@ int tipc_nl_node_set_link(struct sk_buff *skb,
struct genl_info *info)
        if (!node)
                return -EINVAL;

+       mdelay(2);
+       for (i = 0; i < 45; i++) {
+               schedule();
+               mdelay(1);
+       }
+
        tipc_node_read_lock(node);

        link = node->links[bearer_id].link;

In summary, the reproducer creates two TIPC nodes in separate network
namespaces connected through a veth pair and UDP bearers. Once the
TIPC link is established, the main namespace repeatedly sends
TIPC_NL_LINK_SET requests using the discovered link name.

Concurrently, the peer namespace disables its bearer. This causes the
corresponding node to lose contact and eventually be removed by
tipc_node_timeout(). A LINK_SET request can find that node through
tipc_node_find_by_name() and retain its unreferenced pointer while the
timer removes and frees it. The request then calls
tipc_node_read_lock() through the stale pointer, producing the KASAN
use-after-free.

[    4.579090] BUG: KASAN: slab-use-after-free in _raw_read_lock_bh
(./include/linux/instrumented.h:112
./include/linux/atomic/atomic-instrumented.h:141
./include/asm-generic/qrwlock.h:82
./include/linux/rwlock_api_smp.h:193 kernel/locking/spinlock.c:287)
[    4.579120] Write of size 4 at addr ffff88807e06f008 by task poc/92
[    4.579122]
[    4.579125] CPU: 0 UID: 0 PID: 92 Comm: poc Not tainted
7.3.0-rc5-dirty #29 PREEMPT(lazy)
[    4.579128] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.579129] Call Trace:
[    4.579136]  <TASK>
[    4.579139]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[    4.579152]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[    4.579173]  ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:190)
[    4.579175]  ? _raw_read_lock_bh
(./include/linux/instrumented.h:112
./include/linux/atomic/atomic-instrumented.h:141
./include/asm-generic/qrwlock.h:82
./include/linux/rwlock_api_smp.h:193 kernel/locking/spinlock.c:287)
[    4.579177]  kasan_report (mm/kasan/report.c:595)
[    4.579179]  ? _raw_read_lock_bh
(./include/linux/instrumented.h:112
./include/linux/atomic/atomic-instrumented.h:141
./include/asm-generic/qrwlock.h:82
./include/linux/rwlock_api_smp.h:193 kernel/locking/spinlock.c:287)
[    4.579181]  kasan_check_range (mm/kasan/generic.c:186
mm/kasan/generic.c:200)
[    4.579185]  _raw_read_lock_bh (./include/linux/instrumented.h:112
./include/linux/atomic/atomic-instrumented.h:141
./include/asm-generic/qrwlock.h:82
./include/linux/rwlock_api_smp.h:193 kernel/locking/spinlock.c:287)
[    4.579187]  tipc_nl_node_set_link (net/tipc/node.c:376 net/tipc/node.c:2475)
[    4.579193]  ? __pfx_tipc_nl_node_set_link (net/tipc/node.c:2388)
[    4.579195]  ? __asan_memset (mm/kasan/shadow.c:84 (discriminator 1))
[    4.579197]  ? __pfx___nla_validate_parse (lib/nlattr.c:270)
[    4.579211]  ? __nla_parse (lib/nlattr.c:732)
[    4.579212]  ? genl_family_rcv_msg_attrs_parse.isra.0
(./include/net/netlink.h:789 (discriminator 2)
net/netlink/genetlink.c:944 (discriminator 2))
[    4.579231]  ? genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
[    4.579233]  genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
[    4.579235]  ? __pfx_genl_family_rcv_msg_doit
(./include/net/netlink.h:785 (discriminator 1))
[    4.579237]  ? __pfx_cred_has_capability.isra.0
(./include/linux/list.h:457 (discriminator 4))
[    4.579248]  genl_rcv_msg (net/netlink/genetlink.c:1194
net/netlink/genetlink.c:1209)
[    4.579250]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1079)
[    4.579252]  ? __pfx_tipc_nl_node_set_link (net/tipc/node.c:2388)
[    4.579254]  netlink_rcv_skb (net/netlink/af_netlink.c:2575)
[    4.579256]  ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1079)
[    4.579258]  ? __pfx_netlink_rcv_skb (./include/linux/skbuff.h:2701)
[    4.579260]  ? __pfx___netlink_lookup (net/netlink/af_netlink.c:2909)
[    4.579262]  ? selinux_netlink_send (security/selinux/hooks.c:6404)
[    4.579264]  genl_rcv (net/netlink/genetlink.c:1218)
[    4.579267]  netlink_unicast (net/netlink/af_netlink.c:1338
net/netlink/af_netlink.c:1364)
[    4.579269]  ? __pfx_netlink_unicast (./arch/x86/include/asm/bitops.h:202)
[    4.579271]  ? __pfx_sock_has_perm
(./security/selinux/include/objsec.h:240 (discriminator 1))
[    4.579273]  netlink_sendmsg (net/netlink/af_netlink.c:1919)
[    4.579275]  ? __pfx_netlink_sendmsg (./include/net/net_namespace.h:422)
[    4.579278]  ? selinux_socket_sendmsg (security/selinux/hooks.c:5395)
[    4.579280]  ? fdget (./include/linux/rcupdate.h:882 fs/file.c:1100
fs/file.c:1200 fs/file.c:1208)
[    4.579290]  __sys_sendto (net/socket.c:800 (discriminator 1)
net/socket.c:815 (discriminator 1) net/socket.c:2281 (discriminator
1))
[    4.579301]  ? __pfx___sys_sendto (net/socket.c:2235)
[    4.579303]  ? __sys_bind (./include/linux/file.h:63
./include/linux/file.h:83 net/socket.c:1963)
[    4.579305]  ? fput (./include/linux/instrumented.h:112
./include/linux/atomic/atomic-instrumented.h:3766
./include/linux/file_ref.h:157 fs/file_table.c:588)
[    4.579310]  ? __sys_setsockopt (./include/linux/file.h:63
./include/linux/file.h:83 net/socket.c:2414)
[    4.579312]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284
net/socket.c:2284)
[    4.579314]  ? fpregs_assert_state_consistent
(./include/linux/instrumented.h:82
./include/asm-generic/bitops/instrumented-non-atomic.h:141
./include/linux/thread_info.h:133 arch/x86/kernel/fpu/core.c:912)
[    4.579325]  do_syscall_64 (arch/x86/entry/syscall_64.c:61
arch/x86/entry/syscall_64.c:84)
[    4.579330]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[    4.579334] RIP: 0033:0x422e6a
[    4.579336] Code: e0 89 7d e8 89 4d d4 e8 84 be 02 00 44 8b 55 d4
48 8b 55 d8 45 31 c9 89 c3 48 8b 75 e0 8b 7d e8 45 31 c0 b8 2c 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 df 48 89 45 e8 e8 d3 be 02 00 48
8b 45
All code
========
   0: e0 89                 loopne 0xffffffffffffff8b
   2: 7d e8                 jge    0xffffffffffffffec
   4: 89 4d d4             mov    %ecx,-0x2c(%rbp)
   7: e8 84 be 02 00       call   0x2be90
   c: 44 8b 55 d4           mov    -0x2c(%rbp),%r10d
  10: 48 8b 55 d8           mov    -0x28(%rbp),%rdx
  14: 45 31 c9             xor    %r9d,%r9d
  17: 89 c3                 mov    %eax,%ebx
  19: 48 8b 75 e0           mov    -0x20(%rbp),%rsi
  1d: 8b 7d e8             mov    -0x18(%rbp),%edi
  20: 45 31 c0             xor    %r8d,%r8d
  23: b8 2c 00 00 00       mov    $0x2c,%eax
  28: 0f 05                 syscall
  2a:* 48 3d 00 f0 ff ff     cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 36                 ja     0x68
  32: 89 df                 mov    %ebx,%edi
  34: 48 89 45 e8           mov    %rax,-0x18(%rbp)
  38: e8 d3 be 02 00       call   0x2bf10
  3d: 48                   rex.W
  3e: 8b                   .byte 0x8b
  3f: 45                   rex.RB

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff     cmp    $0xfffffffffffff000,%rax
   6: 77 36                 ja     0x3e
   8: 89 df                 mov    %ebx,%edi
   a: 48 89 45 e8           mov    %rax,-0x18(%rbp)
   e: e8 d3 be 02 00       call   0x2bee6
  13: 48                   rex.W
  14: 8b                   .byte 0x8b
  15: 45                   rex.RB
[    4.579340] RSP: 002b:00007f3ed2ca20f0 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[    4.579348] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000422e6a
[    4.579350] RDX: 0000000000000048 RSI: 00007f3ed2ca2130 RDI: 0000000000000003
[    4.579351] RBP: 00007f3ed2ca2120 R08: 0000000000000000 R09: 0000000000000000
[    4.579352] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049e630
[    4.579353] R13: 0000000000000000 R14: 000000000000000b R15: 00007ffc2b74eac0
[    4.579355]  </TASK>
[    4.579355]
[    4.579356] Allocated by task 0:
[    4.579358]  kasan_save_stack (mm/kasan/common.c:57)
[    4.579364]  kasan_save_track (mm/kasan/common.c:78)
[    4.579365]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
[    4.579367]  __kmalloc_cache_noprof (./include/linux/kasan.h:263
mm/slub.c:5563)
[    4.579371]  tipc_node_create (./include/linux/slab.h:991
./include/linux/slab.h:1312 net/tipc/node.c:539)
[    4.579372]  tipc_node_check_dest (net/tipc/node.c:1196)
[    4.579374]  tipc_disc_rcv (net/tipc/discover.c:252)
[    4.579377]  tipc_rcv (net/tipc/node.c:2137)
[    4.579378]  tipc_udp_recv (net/tipc/udp_media.c:389 (discriminator 1))
[    4.579381]  udp_queue_rcv_one_skb (net/ipv4/udp.c:2432)
[    4.579392]  udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
[    4.579394]  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207
(discriminator 4))
[    4.579399]  ip_local_deliver_finish (net/ipv4/ip_input.c:241
(discriminator 1))
[    4.579400]  ip_local_deliver (./include/linux/netfilter.h:325
./include/linux/netfilter.h:319 net/ipv4/ip_input.c:262)
[    4.579402]  ip_rcv (./include/net/dst.h:481 (discriminator 6)
net/ipv4/ip_input.c:492 (discriminator 6)
./include/linux/netfilter.h:325 (discriminator 6)
./include/linux/netfilter.h:319 (discriminator 6)
net/ipv4/ip_input.c:612 (discriminator 6))
[    4.579403]  __netif_receive_skb_one_core (net/core/dev.c:6265
(discriminator 4))
[    4.579412]  process_backlog (net/core/dev.c:6729)
[    4.579413]  __napi_poll (net/core/dev.c:7798)
[    4.579414]  net_rx_action (net/core/dev.c:7861 net/core/dev.c:8018)
[    4.579415]  handle_softirqs (kernel/softirq.c:645)
[    4.579423]  __irq_exit_rcu (kernel/softirq.c:679
kernel/softirq.c:519 kernel/softirq.c:758)
[    4.579424]  sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1062 (discriminator 35)
arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
[    4.579428]  asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:674)
[    4.579429]
[    4.579430] Freed by task 92:
[    4.579433]  kasan_save_stack (mm/kasan/common.c:57)
[    4.579434]  kasan_save_track (mm/kasan/common.c:78)
[    4.579436]  kasan_save_free_info (mm/kasan/generic.c:584)
[    4.579438]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[    4.579440]  kfree (./include/linux/kasan.h:235 mm/slub.c:2748
mm/slub.c:6508 mm/slub.c:6801)
[    4.579447]  rcu_core (kernel/rcu/tree.c:2650 kernel/rcu/tree.c:2919)
[    4.579457]  handle_softirqs (kernel/softirq.c:645)
[    4.579458]  __irq_exit_rcu (kernel/softirq.c:679
kernel/softirq.c:519 kernel/softirq.c:758)
[    4.579459]  sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1062 (discriminator 35)
arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
[    4.579461]  asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:674)
[    4.579462]
[    4.579463] Last potentially related work creation:
[    4.579464]  kasan_save_stack (mm/kasan/common.c:57)
[    4.579465]  kasan_record_aux_stack (mm/kasan/generic.c:556)
[    4.579467]  __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3181)
[    4.579469]  tipc_node_timeout (net/tipc/node.c:315
./include/linux/kref.h:65 net/tipc/node.c:320 net/tipc/node.c:814)
[    4.579470]  call_timer_fn (kernel/time/timer.c:1748)
[    4.579479]  __run_timers (kernel/time/timer.c:1799 kernel/time/timer.c:2374)
[    4.579480]  timer_expire_remote (kernel/time/timer.c:2386
kernel/time/timer.c:2378 kernel/time/timer.c:2136)
[    4.579482]  tmigr_handle_remote_up
(kernel/time/timer_migration.c:985 kernel/time/timer_migration.c:1076)
[    4.579488]  __walk_groups_from (kernel/time/timer_migration.c:564)
[    4.579490]  tmigr_handle_remote (kernel/time/timer_migration.c:581
kernel/time/timer_migration.c:1135)
[    4.579492]  run_timer_softirq (kernel/time/timer.c:2409)
[    4.579493]  handle_softirqs (kernel/softirq.c:645)
[    4.579494]  __irq_exit_rcu (kernel/softirq.c:679
kernel/softirq.c:519 kernel/softirq.c:758)
[    4.579496]  sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1062 (discriminator 35)
arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
[    4.579497]  asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:674)
[    4.579499]
[    4.579499] The buggy address belongs to the object at ffff88807e06f000
[    4.579499]  which belongs to the cache kmalloc-part-11-1k of size 1024
[    4.579501] The buggy address is located 8 bytes inside of
[    4.579501]  freed 1024-byte region [ffff88807e06f000, ffff88807e06f400)
[    4.579503]
[    4.579504] The buggy address belongs to the physical page:
[    4.579506] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x7e068
[    4.579510] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[    4.579512] flags: 0x100000000000040(head|node=0|zone=1)
[    4.579516] page_type: f5(slab)
[    4.579520] raw: 0100000000000040 ffff888001056500 dead000000000100
dead000000000122
[    4.579522] raw: 0000000000000000 0000000000100010 00000000f5000000
0000000000000000
[    4.579524] head: 0100000000000040 ffff888001056500
dead000000000100 dead000000000122
[    4.579525] head: 0000000000000000 0000000000100010
00000000f5000000 0000000000000000
[    4.579527] head: 0100000000000003 fffffffffffffe01
00000000ffffffff 00000000ffffffff
[    4.579528] head: 0000000000000000 0000000000000000
00000000ffffffff 0000000000000000
[    4.579529] page dumped because: kasan: bad access detected
[    4.579530]
[    4.579530] Memory state around the buggy address:
[    4.579531]  ffff88807e06ef00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    4.579534]  ffff88807e06ef80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    4.579535] >ffff88807e06f000: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    4.579536]                       ^
[    4.579537]  ffff88807e06f080: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    4.579538]  ffff88807e06f100: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    4.579539] ==================================================================
[    4.579550] Disabling lock debugging due to kernel taint
