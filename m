Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755826;
	b=zowcQ2WUWU18UW9QnhXit6VROqSaPmMpf8UE1nyt8AiuiMRQXgJYBXn6dqrQ8os04VbH
	 3Ylb+1BgCSCg5LT7G/IGkoOVkjVMkc9YhQLlvXHzM8Ka9Cira9xcW+cD0I7rO4r/cI3Cu
	 jfTQfevB3ZIXOwia/NTx0lxn3U/uhSFNquZnCvkjddhADk7waKt+wHJZI3kIhn/rE2tUS
	 wnoCcgbUD4/WAlpEJWXJekx6D76Iq+xj2tgihysENbnQlsl2lfDJRnOwhX1P8RlgLB5dz
	 Yfc+Ge9e5LsnBEc3pgbIi71uE2B/wTI0gWrBLTun+YGVM1kELO9Y6Qi0DuvAzp4D7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755826;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KgpBrfHk3ZcXVJb3OFlcK7UTRxl4zauHGFlDn82kZWc=;
	b=XxsCRmpNSYbv+4e9haNMzsU50VDQyN6s1VSVJUGsdhaLJkmxnXhGwcJLZdtaVctl02L/
	 E6BH/gtiGfjTT0Bspg+f9/9FxypmgztoyGaaQk/qTSwC906qbgKoRgGWRCwAbDpQIojWv
	 X9gzvv0y9bnwOeISmYxu3gIJvj62CzPBZvHKf7bvX12KOmghBsOCNWfWFc+RbX5CwoZx4
	 bsR4X0rTBvhjAv/4AJSGYWrJr9mDQ1UOmfduxErmyIrtnIlnWpKD3Vo5ajuwkw7eck7SJ
	 Us+5M1cMYGTW9SJPW4wNY9/3j9/1XUHTB4LTvIPPhgJ9klYxVXSblIEO9+QdAMOlFMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MFFslLEz;
	arc=none smtp.remote-ip=95.215.58.167
Received: from mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BF606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 805BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MFFslLEz
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8wMLzGll6jVNiO5BAgyO9Sjgdz2dhskrMMCjXCL9Bh0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792755822; v=1; x=1793360622;
 b=MFFslLEzMO0GKqk0EVgs4mBCP5Qqe7TWOWNQg3GWnYwzvNa8WUQmSkRCDuMn9kX1CX4MuTDk
 ZF7GG9JwwOOKuoZDkT4h1xdQw1lh4vtv+iOUqYL3FnY+NHR5p+6EWtngOc04p8M5xHANf2zekXC
 GMBk2NcxUMlpqAdBbiJ9xvQM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 27d1656d2bb95f51;
	Fri, 23 Oct 2026 11:43:42 +0000
X-Mizu-Trace-ID: 27d1656d2bb95f51
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Matthias Tafelmeier <matthias.tafelmeier@gmx.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: reject dev_weight products that overflow int
Date: Fri, 23 Oct 2026 19:42:25 +0800
Message-ID: <20261023114228.289161-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

proc_do_dev_weight() sets the backlog NAPI weight and the qdisc quota
to dev_weight * dev_weight_rx_bias and dev_weight * dev_weight_tx_bias.
The three sysctls only have a lower bound of 1, so the products can
overflow int and end up <= 0, e.g. dev_weight=65536 and
dev_weight_rx_bias=65536 give a backlog weight of 0.

With a weight <= 0, __napi_poll() never sees work < weight. Once
process_backlog() drains the queue and completes the NAPI by itself,
__napi_poll() still asks for a repoll, so net_rx_action() keeps putting
back a NAPI that is no longer scheduled and NET_RX spins on that CPU
with nothing to do. Restoring the sysctls does not help, as napi->weight
is only refreshed by process_backlog(), which is never called again.

After 3 pings over lo on CPU 2, with CONFIG_DEBUG_NET:

  (NULL net_device): NAPI poll function process_backlog+0x0/0x1200 returned 1, exceeding its budget of 0.
  repoll requested for device (efault) process_backlog but napi is not scheduled.
  repoll requested for device (efault) process_backlog but napi is not scheduled.
  ...

and with nothing queued anymore, NET_RX keeps running on CPU 2:

  NET_RX on cpu2: +454190 in 5s, ksoftirqd/2 at ~82% CPU

Reject writes that make either product overflow int, and print the
values involved.

Fixes: 3d48b53fb2ae ("net: dev_weight: TX/RX orthogonality")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/sysctl_net_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 473c162736d6..4f3796bc8870 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -318,14 +318,23 @@ static int proc_do_dev_weight(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	static DEFINE_MUTEX(dev_weight_mutex);
-	int ret, weight;
+	int ret, weight, old, rx, tx;
 
 	mutex_lock(&dev_weight_mutex);
+	old = *(int *)table->data;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		weight = READ_ONCE(weight_p);
-		WRITE_ONCE(net_hotdata.dev_rx_weight, weight * dev_weight_rx_bias);
-		WRITE_ONCE(net_hotdata.dev_tx_weight, weight * dev_weight_tx_bias);
+		if (check_mul_overflow(weight, dev_weight_rx_bias, &rx) ||
+		    check_mul_overflow(weight, dev_weight_tx_bias, &tx)) {
+			pr_warn("dev_weight(%d) * (rx_bias(%d) or tx_bias(%d)) overflows int\n",
+				weight, dev_weight_rx_bias, dev_weight_tx_bias);
+			WRITE_ONCE(*(int *)table->data, old);
+			ret = -EINVAL;
+		} else {
+			WRITE_ONCE(net_hotdata.dev_rx_weight, rx);
+			WRITE_ONCE(net_hotdata.dev_tx_weight, tx);
+		}
 	}
 	mutex_unlock(&dev_weight_mutex);
 
-- 
2.43.0

