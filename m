Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AAA34D4D6;
	Fri, 24 Jul 2026 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889961; cv=none; b=LkazECV00jIcHmpF2qZbRCoVSriOS+D+SqUgSUmOLqiJG6pycDHKQTwhvyW6k1x/Bn8FAcSLNF7IFrFo0Kq/27Ndkz2hbdDpV7h10xcWOTH+oijtwneSn7xYK7Sa6S2b42H2d6+eTrLphuZ2VmMSC+ECBhH8fcHcLj390TzTAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889961; c=relaxed/simple;
	bh=BbKN3enijpNiJb9yqeYzVqq4d9JeKrBN7pN6+ZiWxnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sHfHuaKlNYP9Q5v9+QeYP1zjVOXHNA8fYqU3g5o1XvITxFyu27lKGa+Mx/1Iogo44MxjxYMSqA65P2JbJ5EZkvmhgWIMzXDbo6cR1b7aYYTuYD62/sfuBfieuEt2Pl++9kmJco1Cl0JA7mzg7iZYxEIyP0JSGTsh5YdYoytH0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=o0E66/MF; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="o0E66/MF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ZBI3x
	x/Xe3ZLrj5cJS0aDdCNt7VpxAvOVeXpnhz2+jc=; b=o0E66/MFE5sR9++ikxC9W
	+LsZj/TniaCaVPX4mDWIhT7XCslR46HbZyROcWQF+jaBT+Dsr2XuVzCdcRmkduU7
	g5mpfm3Efb0QbGTl7ZhVBV3zng9IjWEo/80Sx3ZcxADJ8F2MyqGja39XJwTfjfUv
	SBZA/eeVai5FXyBBjLH5Mg=
Received: from node118.platform-default.svc.cluster.local (unknown [36.102.215.18])
	by web3 (Coremail) with SMTP id ygQGZQCHVxY8QmNq0b8wAA--.4625S2;
	Fri, 24 Jul 2026 18:45:28 +0800 (CST)
From: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	yyxroy22@gmail.com
Subject: [PATCH net] xfrm: enforce hard byte lifetime in xfrm_input()
Date: Fri, 24 Jul 2026 10:45:17 +0000
Message-Id: <20260724104517.3852159-1-yangyx22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCHVxY8QmNq0b8wAA--.4625S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4ftr1UAw1fuFyDKw1xZrb_yoWrGF4rpF
	WakF98Kr4ku3W7CFn7tw1xZ3WrJ395Ary3CFy0kryjy3Z8ur1FgryfKa1YqF97GFZ3Za1Y
	q34SgFZ7KF4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwV
	W8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRN4SrUUUUU
	=
X-CM-SenderInfo: 51dqw5r0ssqzpdlo2hxwvl0wxkxdhvlgxou0/

xfrm_input() checks an inbound state's hard lifetime before processing
the current packet, but accounts the packet only after the transform
succeeds. The check therefore sees only the previous byte count.

If the current packet makes the new count exceed the hard byte limit,
that packet is still delivered. The state is not expired until the next
matching packet arrives. The effect is limited to the packet that crosses
the configured limit.

This affects only states configured with a finite hard byte limit. The
default XFRM_INF lifetime is unaffected. IPComp makes the issue especially
visible because decompression can increase skb->len before it is accounted.

Account the actual post-transform length, then enforce the finite hard byte
limit before delivering the packet. Use a strict comparison so a packet
that brings the count exactly to the limit remains accepted.

Saturate the byte counter at XFRM_INF - 1 because XFRM_INF is also the
unlimited-lifetime sentinel. Carry a separate saturation flag so a finite
lifetime still expires if the addition overflows or reaches the sentinel.

The transform and replay update have already completed when an overshooting
packet is dropped. Checking the compressed length before the transform
would not enforce the correct limit because IPComp can increase skb->len
during decompression.

With this change applied to net at 78f75d632f74, a local QEMU/TCG test
dropped a 136-byte packet at a hard limit of 135 and accepted the same
packet at limits of 136 and 100000. XfrmInStateExpired increased by 1, 0,
and 0, respectively. A characterization-only kprobe module seeded
curlft.bytes at U64_MAX - 100 for an unlimited lifetime; two packets were
delivered, the counter saturated at U64_MAX - 1, and XfrmInStateExpired
did not change.

This change is limited to hard byte lifetime handling in xfrm_input().
xfrm6_input_addr() and the output path use separate byte accounting and
are not changed here.

The faulty ordering predates the available Git development history, so
there is no accurate introducing commit to reference with a Fixes tag.

Cc: stable@vger.kernel.org
Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
---
 net/xfrm/xfrm_input.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337b..6846ccb39 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/overflow.h>
 #include <linux/percpu.h>
 #include <net/dst.h>
 #include <net/ip.h>
@@ -582,6 +583,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	daddr = (xfrm_address_t *)(skb_network_header(skb) +
 				   XFRM_SPI_SKB_CB(skb)->daddroff);
 	do {
+		bool saturated;
+		u64 bytes, len;
+
 		sp = skb_sec_path(skb);
 
 		if (sp->len == XFRM_MAX_DEPTH) {
@@ -689,10 +693,24 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		xfrm_replay_advance(x, seq);
 
-		x->curlft.bytes += skb->len;
+		len = skb->len;
+		saturated = check_add_overflow(x->curlft.bytes, len, &bytes);
+		if (saturated || bytes == XFRM_INF) {
+			bytes = XFRM_INF - 1;
+			saturated = true;
+		}
+		x->curlft.bytes = bytes;
 		x->curlft.packets++;
 		x->lastused = ktime_get_real_seconds();
 
+		/* IPComp may expand skb->len during the input transform. */
+		if (x->lft.hard_byte_limit != XFRM_INF &&
+		    (saturated || bytes > x->lft.hard_byte_limit)) {
+			xfrm_state_check_expire(x);
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEEXPIRED);
+			goto drop_unlock;
+		}
+
 		spin_unlock(&x->lock);
 
 		XFRM_MODE_SKB_CB(skb)->protocol = nexthdr;
-- 
2.34.1

