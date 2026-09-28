Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540B2D8DD0
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612745; cv=none; b=reiHKDHny1AoZQswkaqKkN+MTbHfpBwOYrYH6FOZPTOLd4PHheTTWdY2RgLNVqg72XFiMEGXsamG/adV4gzzAWbfnq1BH6RrYxxVAlb0MfwyZlT7bhdDW/OwWtAqB+WjFkm5TyXFSSU/P9T+8fVfl5Gtpt4kcog9ImWkiB2CvV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612745; c=relaxed/simple;
	bh=RBpxUWeldpvkQFz0ci2d1q8aSBH8yeW6c7VrkwVHoG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fTnU3gRWKuVDb74k8gFJr6A4qVWFq4DbpeU3vVmGFc70GiatwS50Up/+ICUPuHXSOK6Ao7Vco5q2JhGlJ6CcxJtXsBS1aCIPXejoOhuQkSnAXpc9AiJJDX/DIX/KA5vI1voSOpFHMzXvzTAvI5dw5dXtjD4Cl2rjuYnGpi0I1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oprQ68Rv; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oprQ68Rv"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff23d81cso2199195ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612744; x=1791217544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zoHFbGNtVQoHjVLOP0fq+w6gtBNh9zXQIgTMyktRzcM=;
        b=oprQ68RvxFhGfjVCI9RyPnQNzoqrSmwfP0UVqH4Yf63OhB+OGcxvvznCZo+xWsZIJK
         FX+JtB56xdqi8LMlLW/8jajr93PyjDseHZRL9ZiTBdOKsI++0coxfycyfFe6VjeRjSpH
         GrgG1B5XS7TFHwsurgyZRtyzzDBXuo2LTWVwdhfkPBY1gKTRlY2g1JeC+bjBzZgQQART
         zHS1+N+2pKYv2n3FcPZzfwyV6Q4yt9W5iuBuv5HKZaFvymm7Dw/PFDP97cXnI+ke1Ct4
         lziCLbCZ7Rr1BnUNt5ETFMgHJvupsUWwpFI23oCEP7esQXa1JmNsYGJRIutxmBzq+fx8
         LoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612744; x=1791217544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zoHFbGNtVQoHjVLOP0fq+w6gtBNh9zXQIgTMyktRzcM=;
        b=UUUX2QiBaflOCd/D0XqGoEb2iicgYARGxO+7dcd8Oxoc42ETRaTQ7n0f0smzRpOrlm
         9PuLIhzAjuPk+fnPfVZTJmT1I0aLrfSxHLHSKl1yFP18q+FGB3pBBBBjUFXtC2Gs0erh
         ZQPWonUgbKIf1DYntOCNVkvCpvSkZW0U7xdTyhPD9eEmd11dpH07545AYrW9mcEfhAxG
         nBhf24nIrFJNY/Bu+mhUCtPYU+HT7QIh9PUeF8AWtv+GHLTkcF72pZZ7JIoahlsW0kPl
         GZVykO5hZMjuRTBm2nG6lwzIrjrtMDNySfpx8uPaflX3cI6OyITtTzkyiokFE8H4obZI
         QgPA==
X-Forwarded-Encrypted: i=1; AKwUvBwT/QEeY9GPMzvvBDPUGlECh7cGk/lD1rmnpCNe/qS96E5YOH+HAjFUDxh++GqZp7qh/uZMdo0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh6vED5CCIzRGQvsE/Klh2r2885rozA3yaRRx9jJ4hBsUejpEF
	OpEKiEMrrFlCJA6a/qYl2t0WoqA18+V9/tNgCuTKF8xc/c8tsdnvruRc
X-Gm-Gg: AYBFou3gn1Y6akscgaUJykDR4v8f0ObVLPMyQVxUwXSbhgugowhJ8vMfz9eLFXm08Uv
	Pd+YCN9eQUpiUtdAUuBAF84IbdFeWfEfZ0d7GI+Z/ufzvWCF8pkGgyIuV5aLManUGt6UIY69kut
	j78SSNFrnM7qvBjRyCQ34blBCba3gHcBsmtANQU/EbiOO23OfVQxXo+pg1PqBsiJGSY8KR4Qju4
	GfRInZ1MlYLYw2FrD5R0xlBbWzjniF5ierEUS0dRcab6iWs/MMw+j/pzLsf/6qF+Fi9vNgB0GvG
	vNPGQTDcwAJuYPcLBsHEOWHNx7goNOX69Y5Cglw4OhbbGYyWOpaN7ijAIld5MoZL9oY/Az6CXku
	LEilBGfsZ1xotWv+h+S3BPDA/kVUi5nn/j05G8LWjZNArqowe/eBUAv/5w9sPl2pcy2goq7lxBf
	vLUZcSrwlfXx4nUfUAwqSSyVzTpShjpj2b6PMofvv0zQBF1NCiY/ENbQd180Dm4fQbD9Mk+Otd9
	ggOUGKJl6jgm7LXcBDWCIdbpaO5iudnMK9inPUzBgTl0TRkfKBJZ4NWHwkGMd0lrQVmRiw=
X-Received: by 2002:a17:903:3202:b0:2dd:190e:28b6 with SMTP id d9443c01a7336-2df7dd7b9bcmr188420695ad.2.1790612743509;
        Mon, 28 Sep 2026 09:25:43 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a4a00dsm31259622eec.1.2026.09.28.09.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:25:42 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Wei Wang <weiwan@google.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipv4: Fix device use-after-free in ip_mc_output()
Date: Tue, 29 Sep 2026 00:25:34 +0800
Message-ID: <20260928162534.2122207-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_mc_output() reads rt->dst.dev and stores it in skb->dev without RCU
protection.  dst_dev_put() can concurrently replace the destination device
and release the old device after an RCU grace period, leaving the multicast
output path with a stale skb->dev.

The stale device can be dereferenced by the post-routing path.  In
particular, a socket using IP_PMTUDISC_PROBE reaches ip_skb_dst_mtu() from
ip_finish_output() and reads the freed device's MTU.

KASAN reported:

  BUG: KASAN: slab-use-after-free in ip_skb_dst_mtu+0x634/0x740
  Read of size 4 at addr ffff88810921c038 by task poc/98
  Call Trace:
   ip_skb_dst_mtu+0x634/0x740
   __ip_finish_output.part.0+0x22/0x2c0
   ip_mc_output+0x287/0x930
   ip_send_skb+0x11d/0x150
   udp_send_skb+0x63e/0xdf0
   udp_sendmsg+0x1235/0x1da0
   __sys_sendto+0x32c/0x3a0

  Freed by task 99:
   kfree+0x131/0x3c0
   device_release+0xc8/0x240
   kobject_put+0x14d/0x280
   netdev_run_todo+0x4cb/0xc70
   rtnl_dellink+0x362/0xa90

Protect the whole multicast output path with an RCU read-side critical
section, as ip_output() already does.  Load the destination device through
skb_dst_dev_rcu() and keep it protected through the post-routing hooks and
ip_finish_output().

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Protect the whole ip_mc_output() path instead of only the MTU read.
- Load the destination device with skb_dst_dev_rcu(), matching ip_output().
- Use the commit that made dst device replacement RCU-protected as Fixes.

Link: https://lore.kernel.org/r/20260927071051.3693368-1-nicoyip.dev@gmail.com/ [v1]

 net/ipv4/ip_output.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8ee11d3..cf44597896cd 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -367,8 +367,11 @@ static int ip_mc_finish_output(struct net *net, struct sock *sk,
 int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
-	struct net_device *dev = rt->dst.dev;
+	struct net_device *dev;
+	int ret;
 
+	rcu_read_lock();
+	dev = skb_dst_dev_rcu(skb);
 	/*
 	 *	If the indicated interface is up and running, send the packet.
 	 */
@@ -406,7 +409,8 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 		if (ip_hdr(skb)->ttl == 0) {
 			kfree_skb(skb);
-			return 0;
+			ret = 0;
+			goto out;
 		}
 	}
 
@@ -418,10 +422,13 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 				ip_mc_finish_output);
 	}
 
-	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, NULL, skb->dev,
-			    ip_finish_output,
-			    !(IPCB(skb)->flags & IPSKB_REROUTED));
+	ret = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
+			   net, sk, skb, NULL, skb->dev,
+			   ip_finish_output,
+			   !(IPCB(skb)->flags & IPSKB_REROUTED));
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-- 
2.43.0
