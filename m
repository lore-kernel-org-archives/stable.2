Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696193;
	b=JrzxzwM71C7QgG/ufiOXu4E7lZwBYJuplKEYDpS5qOJcjSomPU5abu3DyK/G1RhvFmZ+
	 Eaqx06J8sYOEIQQBAGcS5gztg8AUxzuKFsoISNZHQub0sGnq/Jm1vEOxm9+XA+eGqnCom
	 INulTwk+vC5WZ6zKc/S8Phd6GzRx5gx7VAWohhqivSuKO9RoPYwtsJ1CJ9kTeIMHr+GwI
	 pmamb911kN1JN+KMgg9vRxxbySn2yzk3aPMhnp2YTA6dV7ZFN33V9zh2gHdf8zLiJpOp/
	 PJ3h4GyGyUklc0zz8kSXq3i7MTEM3XB4Q+Gjl2g/K4LzHr3Y9G9R24BqNsfuvwMAMBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696193;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=RnxrMYpTCDIMktD1X0shShcdslhXt1F2LJgmog6mN8Y=;
	b=sfArUpGs4N8iLj2WZiMY5CfQj5y57pHvK3NY4HY3oit5vQmk+1yu41h8/x6WgXfdzGGG
	 InivJZt/IH4+nHpta2Y5hmNmB/OZE9TwoGHrs9A13D1QY0BaK7TYQKAK5aWUlddq0yca8
	 18vcWGkUKBYZfZtmPp/n8hVQVxmHQkDoKtyHt7CmhC87gEcjpUszNm5jJ+FcIEmCGe/6A
	 y4Biu2Xahogwn3QUZcHF7tRZ8zTiuaCSUM2JleYYN7ZolSnzJiWHH5mGyWeK5/AZw33H2
	 PTLnCUC2ZqwgR6nQWizA84E6fqfgW0ssLFuIa785S0qih5keiMZ24ktIrAgNh507p6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RDXeEFA6;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046ED606A31C;
	Thu, 26 Nov 2026 12:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 046ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RDXeEFA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Rn
	xrMYpTCDIMktD1X0shShcdslhXt1F2LJgmog6mN8Y=; b=RDXeEFA6gnyxlJGb2W
	x7BorTdGJ0wqQUtbrlO6OxWbQfeS9abcOkfjTuueIQSBgndDd7cVkNRVG8+I/VuW
	x4RYEJ4pgy3rrRzBaSBz/3s5AIgQ3p3gYqyv6ba+OC0taUQVkzWxMO7N8vmg1Pvv
	lh8RaoiClpgILxwra40HA9tJ8=
Received: from shaos.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnbxUOJghrUjpBKg--.8135S2;
	Thu, 26 Nov 2026 20:29:03 +0800 (CST)
From: shaos <shawnq1@163.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: enforce the FQ-PIE memory limit
Date: Thu, 26 Nov 2026 12:29:02 +0000
Message-Id: <20261126122902.1504968-1-shawnq1@163.com>
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
X-CM-TRANSID:_____wDnbxUOJghrUjpBKg--.8135S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWry5WF1xGr43Aw4rWF4xCrg_yoWrtFy7pF
	92vr4fKw1rAF4fJr1vyr1UX3Z3C3sIka4UGa4DZr1Skr43Kw1F9Fyxtw45GFWfuFyrWayS
	qF4qk34aqw1v9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWa0dUUUUU=
X-CM-SenderInfo: pvkd40jtr6il2tof0z/xtbCzw9pd2sIJg8bAAAA3P

Hello,

fq_pie_qdisc_enqueue() detects when the incoming skb would
exceed memory_limit, but the memory_limited branch only increments
overmemory. It then continues through PIE admission and can enqueue
the packet. The current check also adds skb->truesize to
memory_limit, which can overflow.

With a 4 KiB memory_limit, the reproducer keeps 49 packets queued,
accounts 110592 bytes in memory_usage, and reports overmemory while
dropping no packets. A 32 MiB limit control accepts the same traffic.
Drop an skb when its truesize exceeds the remaining budget, using
subtraction-based bounds checks to avoid overflow.

The test configures the qdisc and TBF parent as root in a disposable
QEMU guest (CAP_NET_ADMIN). Ordinary UDP traffic then exercises the
enqueue path. This violates the qdisc's documented memory_limit
contract; the test does not demonstrate privilege escalation.

HEAD commit:    8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
git tree:       fe970b05333fb8e41da21e9e289f652abcc7cba7
source version: Linux 7.4.0-rc4-g8d7fe9885c62
compiler:       gcc 11.4.0, GNU ld 2.38

The Gist contains the complete console output, kernel configuration,
sender source, and initramfs/QEMU helpers:
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/console-output.txt
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/kernel-config.txt
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/send_burst.c
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/guest-init.sh
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/build-initramfs.sh
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/run-qemu-test.sh
https://gist.githubusercontent.com/shaos26/903cfb53571c9271fefaadffde3469e5/raw/a417f18ab4665e1740dc06e06ebaf1c4a07613b8/verify-log.sh

Build the kernel from the HEAD commit above with kernel-config.txt.
The initramfs script requires BusyBox, iproute2, static gcc, cpio,
gzip, and QEMU. Run the same small-limit and large-limit cases:

    ./build-initramfs.sh
    KERNEL=linux/build/arch/x86/boot/bzImage \
    INITRAMFS="$PWD/initramfs-fqpie-rebuilt.cpio.gz" \
    LOG="$PWD/fqpie-small.log" \
        ./run-qemu-test.sh positive 1
    KERNEL=linux/build/arch/x86/boot/bzImage \
    INITRAMFS="$PWD/initramfs-fqpie-rebuilt.cpio.gz" \
    LOG="$PWD/fqpie-control.log" \
        ./run-qemu-test.sh control 1

The unpatched small-limit run accepts the packet burst and exceeds
the configured memory budget. The patched run drops packets once the
budget is reached and keeps memory_used at 2304 bytes, below 4096.
The large-limit control continues to accept the same traffic.

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Cc: stable@vger.kernel.org
Signed-off-by: shaos <shawnq1@163.com>
---
 net/sched/sch_fq_pie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f85..2e14467ae6585 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -134,7 +134,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
 	struct fq_pie_flow *sel_flow;
 	int ret;
-	u8 memory_limited = false;
+	bool memory_limited;
 	u8 enqueue = false;
 	u32 pkt_len;
 	u32 idx;
@@ -152,7 +152,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	sel_flow = &q->flows[idx];
 	/* Checks whether adding a new packet would exceed memory limit */
 	get_pie_cb(skb)->mem_usage = skb->truesize;
-	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
+	memory_limited = skb->truesize > q->memory_limit ||
+		q->memory_usage > q->memory_limit - skb->truesize;
 
 	/* Checks if the qdisc is full */
 	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
@@ -160,6 +161,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		goto out;
 	} else if (unlikely(memory_limited)) {
 		q->overmemory++;
+		goto out;
 	}
 
 	reason = QDISC_DROP_CONGESTED;
-- 
2.43.0

