Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963298;
	b=3IkHOkOnUoeep1yUf3b9jcWljXih/73syEpF1oOlnJPK5bEJEh4Pv++KSGa4FWSS0VA2
	 I1hE1KhcNZ80P7Af0gxvKBOmiZsa9+Ybrr9VGwJh7uTMLeHmbW4mvPs20rhUZDp05vm91
	 RZZRC4c5Mq7qmEAECJR4Np7fxNbCW9uXTLM6IHn7VNTVN6cO0LgoxaOWv1vWN2onj6bZi
	 eow/GCYp6Qk+GXgrWQAS3Ju+F478XRJKFPEygN67gXyK2QT6/7qVfsiwforJxzdVybo5y
	 ZgVX/WHITTvwrBkXDm0jAwURosP7Ru1nuJtZuoWaoSVGZhVR7WLDdupYSisncJq4nSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=okrriRKI5iUmexz73yDJ3a18AbZwO0cF4iXDn3kRazQ=;
	b=BQym7A1jPmPog4akPwjA1SiJ3kV0tnZrcndtR7dkoy1DSCmqC+aHcQifZodd1hyiTflC
	 v7OaCAJfyrZLdDi6zqZqneytaSLnKM1EZ3cHfqqY0txw+kaDQMxAbVIXyzYDsSoNFdLmW
	 MQEfLTf9xesOHb3efnj3EzPCdAl2IpsPOCdi8hOV0aZInmODmDjWoFBV4kcD8HFWHkcem
	 fBKFoOGNc+fY3XlUmtwGnyAsXPhME9WeMkMXJPPZqXTi/kJqMMEQo1UUb6HV57oEodHj4
	 yXFaJPOZyWscU6CsrZ+G7UsVVALDhtWPSPefbHTU48b3Zs/qeRFs7t91NpP7gLqo/rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=DnTawPg1;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FB606A89A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 00:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 872FB606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=DnTawPg1
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cddee4abc57so120282a12.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 16:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1794963297; x=1795568097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okrriRKI5iUmexz73yDJ3a18AbZwO0cF4iXDn3kRazQ=;
        b=DnTawPg1ce4RaLDbeynrZu+Qnkv80eVbkdchCGnV6bFS1DQ8ngRNCAMI5B0fzv1dh6
         C7/HHwJ9vkA2nmAghifS0SRr7MEbVixQu1MBW7LWBjC8hsv6xL20tP8uPjhBLD6VkswB
         iSMqFCJ+jm4BKT75qD7kDaWT6WHYaE0FpUz6ZEmF/BUkPRcyWHDxdy5tKufgkIvX+9tu
         jXw4Dfa9rz/LI2A5VQbgcmoDxgFet397kyu7S1SAE2lDAtmfn1O6VBvIlTqdGXJxYAkg
         tYQpgygvlmk6NaUf/10RdjG1CB8axDdgRuv8H+54vCEttkzyd1ktRzElLghu0aV4WkSy
         gHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794963297; x=1795568097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=okrriRKI5iUmexz73yDJ3a18AbZwO0cF4iXDn3kRazQ=;
        b=wp4c7Rjkl6XKFGFfOmPyLCFihYwKkg7AXf8IIIXwwFgqCPOC78acTVJQDY3bw26njS
         Is8Wt59B9Zq+k3TX7hc3G2F09zsczEhsB3jCOY0h1PhTS4CY40ECGFSxppBwNqtH2+VA
         kIjFvd5aLNh7ZcmGKJ5WvXcCz68GlpuzES7nAqcf4Pl7AFC9m1YNuJ5zPcraSd7ZE0WF
         UGmDznfDaqRyqXrew5sOS7S9LW857oEh/4aWzia4ancY0dY9vHQUFPEhTd8Ih9ZATenV
         qU8MvpK8unYTmqRHQ7PSruKjuuioFDN2L+BCblhD/vKhAlpdL7m1z0oaf49w+9VBZokd
         Yofg==
X-Forwarded-Encrypted: i=1; AL+hErH2nZ5qgnYOlvMN0lnk/OsM3F99rIcH2rL4h6skXa+b6Sx13oS5Q1qJhvl1gVEY77vkiKqvkDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fIZF8YaM5R6WEOw9HYvcQoGfjP0imvrB+LKg39fPfxGn9BLSf
	YnidkP2qONCSCM2w3cD9uQCLxByU+Pnibqc3SK6UYi7xmgeP42pbcXxjgF7Nrky2iVdXfCssuSF
	MqnC96n3SEEqTnresO7DnXlWJPIv26qd69SaW9iV5/JyLuspf4KCk
X-Gm-Gg: AZFdTZcq+B46elrhuLhpvQZPpyr3NiN43e15lwM8VfI7w3hqGivzjrNQpOpqzgBkLI7
	OAWyTNCsy70deXOKf2643vX7LeuXqhZ47WQbSOBDzVMcXfWHpgl/d5fS+MBsm/QICMZfADrIDhv
	q8Pzu717oZTM7MbER7wP4Kqvg3aS9oMsLL+4jH7JAhWn62HzJ/PgK9gVHLdod7LVdG2yoW45aWN
	m2TkhLoXMh7LHs7b1fWdUisoK49dM3zVVxUWU5gBVuWeevmQ4vsbfSAtZ9yODLh5usio/PDpJjH
	qcoZhzEWkyufe5KUAk8hH/DrYp9R1ou8qsnkTRj/yEqY9q7K23RMlQTX5FaLMapOH951WYviEUJ
	KOm+pOuotZB7ZzgR27ZiXsLtW4fM=
X-Received: by 2002:a17:90b:39a3:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3b3d07a29camr946463a91.38.1794963296708;
        Tue, 17 Nov 2026 16:54:56 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3d4914caasm161524a91.2.2026.11.17.16.54.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 16:54:56 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Andrii Tereshchenko <opensource@andrii.net>,
	stable@vger.kernel.org
Subject: [PATCH ipsec 2/2] xfrm: iptfs: hold the dst while a packet waits on the output queue
Date: Tue, 17 Nov 2026 16:54:49 -0800
Message-ID: <45f802a2-c639-44bd-aba0-5c81e2198c9e@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <b56bbced-a8b0-4ae9-80b4-1958ea36684c@mid.andrii.net>
References: <b56bbced-a8b0-4ae9-80b4-1958ea36684c@mid.andrii.net>
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

iptfs_output_collect() queues the skb on xtfs->queue for the delay
timer without taking a reference on its dst. Locally generated TCP
attaches the socket's cached route with skb_dst_set_noref(), which is
valid only inside the RCU read-side critical section of the transmit
path. The skb outlives that section on the queue. When TCP drops the
cached route, as it does from the retransmit timer, RCU frees the dst
while the skb still points to it. iptfs_output_queued() then reads the
freed dst, first in iptfs_get_cur_pmtu() and then in xfrm_output():

  BUG: KASAN: slab-use-after-free in iptfs_delay_timer+0x2ef/0x1900
  Read of size 4 at addr ffff888100cff01c by task swapper/1/0
  CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 7.4.0-rc3 #1
  Call Trace:
   <IRQ>
   iptfs_delay_timer+0x2ef/0x1900
   __hrtimer_run_queues+0x16d/0x340
   hrtimer_run_softirq+0x136/0x210
   handle_softirqs+0x162/0x420
  Allocated by task 0:
   dst_alloc+0x4f/0x250
   xfrm_bundle_create+0x236/0x1010
   xfrm_resolve_and_create_bundle+0x13c/0x1d0
   xfrm_lookup_with_ifid+0x303/0xe20
   xfrm_lookup_route+0x1c/0xf0
   ip_route_output_flow+0x15b/0x170
   inet_sk_rebuild_header+0x4c0/0xa40
   __tcp_retransmit_skb+0xe8/0xda0
  Freed by task 0:
   dst_destroy+0xe8/0x140
   rcu_core+0x3f6/0xea0
  The buggy address belongs to the object at ffff888100cfef00
   which belongs to the cache xfrm_dst of size 296

A NULL pointer dereference in xfrm_output_resume() follows the
reports.

Take the reference with skb_dst_force() in iptfs_output_collect(),
before the skb is queued. If the dst is already being destroyed, drop
the packet and count XfrmOutError. xfrm_output_one() takes the same
reference before it calls the type output handler; with IP-TFS the skb
leaves the RCU section earlier, at the queue.

KASAN reported this while the panic fixed by the previous patch was
being reproduced, on an unmodified v7.4-rc3 and without fault
injection. In the setup described there, KASAN reported the
use-after-free in most boots of the unpatched kernel and in no boot
with the series. Kernel selftests were not run; none of them covers
IP-TFS.

The analysis and the patch were produced with an AI coding assistant
and reviewed by the submitter.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Andrii Tereshchenko <opensource@andrii.net>
---
 net/xfrm/xfrm_iptfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 95ba73013..f5260bc51 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -1914,6 +1914,20 @@ static int iptfs_output_collect(struct net *net, struct sock *sk, struct sk_buff
 			continue;
 		}
 
+		/* The skb will wait on xtfs->queue until the delay timer fires,
+		 * and iptfs_output_queued() -> xfrm_output() then dereferences
+		 * its dst. skb_dst() can be a no-ref dst (e.g. the bundle built
+		 * for a TCP retransmission) that RCU frees while the skb is
+		 * queued, so pin it before queuing; if it is already being
+		 * destroyed, drop the packet rather than queue a dangling
+		 * pointer.
+		 */
+		if (unlikely(!skb_dst_force(skb))) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+			continue;
+		}
+
 		/* Enqueue to send in tunnel */
 		ok = iptfs_enqueue(xtfs, skb);
 		if (!ok)
-- 
2.53.0

