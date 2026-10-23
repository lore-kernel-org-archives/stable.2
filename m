Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747002;
	b=blhfA2YkKJ4vAJwrQdmzc2jkDFBs2r+3085pkEKp2NZ5UPuyNKDv9T21y4tDPLXzOKZL
	 oNqSj55YCcObkNn82NVQdWY2mNo4cJftuGZgX55My51jFTI1ZSqV37ZAisR4FeckgD1dL
	 KJEOrtbpdwptTxw7KtvAD1EzqNJpQCcMiokkKzjPXDgYAdLAhBLBS6shdvLGJYgNAELa/
	 IhCU0oVmwDgJwMkDpR92pZVSXYJT99VhgBBKqoCInfo/U4nk/gUfJjkRkz3biNlnx7zri
	 T5cL3sBMx1ZSbSCR5a4En+gq/B6H5R+1E3sf0oocNXhagFsJR/bjlvDAgWfFB/VIM1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747002;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q12lwCISyZPjPr61m5RHq2Uo3Q7fFgGiNopmM/Dy4L4=;
	b=Ub0qo73SPrB+yiEA+8nfo9xFSvd2V8fNPYg0t/cFS8PNpFsmjYPWF4qKYtbAB2qL/OH5
	 dRAap7w1iIGlspxZoZaMC9FMuVFVpfoquWhKmIsv34Bu92Rj5mGzgD/Y6uNAUyRBAWAD1
	 9/Ylc0UbE8eHZm2bOalMCDwtCtPFQIJfqxwfvcxxipRyhbhmtQUYYNmTe0PeQnWfxN0Pt
	 Z12NKOMwPbTMG6t+hph7cjtefsP02JDx7gd7DEHdOdZkEqeQtCLWWi3OuI42o1SKaFP+U
	 ufSz7wyfASWBdXFUYoPa7rB2luWu6yVm6PzC2nlhQoGimFl7IXmdl8DDDk86g++ciDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DUlE0gg+;
	arc=none smtp.remote-ip=95.215.58.84
Received: from mta1.migadu.com (out-84.mta1.migadu.com [95.215.58.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BE60A260D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 09:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 438BE60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DUlE0gg+
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1KupEA37m82GidlyX3LbcgZwwrs9UufQXzhoE0mR97Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792747000; v=1; x=1793351800;
 b=DUlE0gg+48vGYSi77VhILLLl5w916XC2y+cs2xPGiBuofSNgYkeLtsOfYd+gSxFYfkxjeNN+
 2cvFn6Xb/wgnGeD996tFC/dEUvkzKTgcfL+E8IYZ9AjGUUOQzC1s8f3c8kAAfbxPyP+InVPkk2e
 ET8zT70N/fueCvNJxapYEihU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ba89e8f548b0aa4;
	Fri, 23 Oct 2026 09:16:40 +0000
X-Mizu-Trace-ID: 9ba89e8f548b0aa4
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
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joel Granados <joel.granados@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 5/5] net: restrict message_cost and message_burst to non-negative values
Date: Fri, 23 Oct 2026 17:13:31 +0800
Message-ID: <20261023091419.167088-6-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023091419.167088-1-jiayuan.chen@linux.dev>
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
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

net.core.message_cost and net.core.message_burst feed the interval and
burst of net_ratelimit_state, but neither has a lower bound:
message_burst uses plain proc_dointvec, and message_cost uses
proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.

Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
negative"), ___ratelimit() splats on such values, so the next
net_ratelimit() caller warns, e.g. a martian source log:

  Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
  WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
  RIP: 0010:___ratelimit+0x578/0x960
  Call Trace:
   <IRQ>
   net_ratelimit+0x1c/0x30
   ip_handle_martian_source+0x1bb/0x340
   ip_route_input_slow+0x1057/0x3650
   ip_route_input_noref+0x104/0x260
   arp_process+0x109b/0x2510
   arp_rcv+0x381/0x460
   __netif_receive_skb_one_core+0x173/0x1c0
   __netif_receive_skb+0x21/0x150
   process_backlog+0x37e/0x1200
   __napi_poll.constprop.0+0xa5/0x5e0
   net_rx_action+0x4c0/0xf70
   handle_softirqs+0x204/0x9b0
   __do_softirq+0x10/0x18
   do_softirq.part.0+0x49/0xd0
   </IRQ>

Negative values never meant anything here: ___ratelimit() treats them
like 0, and 0 already expresses both "no limit" (interval) and
"suppress everything" (burst).

Reject them at write time. message_burst can simply use
proc_dointvec_minmax with extra1 = 0. proc_dointvec_jiffies ignores
extra1/extra2, so give message_cost a small handler that parses into a
temporary and only stores the value if it is not negative.

Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negative")
Cc: stable@vger.kernel.org
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/sysctl_net_core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 473c162736d6..8146ed819695 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -378,6 +378,22 @@ static int proc_do_skb_defer_max(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static int proc_do_message_cost(const struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, interval = READ_ONCE(*(int *)table->data);
+	struct ctl_table tmp = *table;
+
+	tmp.data = &interval;
+	ret = proc_dointvec_jiffies(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret) {
+		if (interval < 0)
+			return -EINVAL;
+		WRITE_ONCE(*(int *)table->data, interval);
+	}
+	return ret;
+}
+
 #ifdef CONFIG_BPF_JIT
 static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int write,
 					   void *buffer, size_t *lenp,
@@ -544,14 +560,15 @@ static struct ctl_table net_core_table[] = {
 		.data		= &net_ratelimit_state.interval,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
+		.proc_handler	= proc_do_message_cost,
 	},
 	{
 		.procname	= "message_burst",
 		.data		= &net_ratelimit_state.burst,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
 	},
 #ifdef CONFIG_RPS
 	{
-- 
2.43.0

