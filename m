Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793513806;
	b=PBWKYAOXD4tDIX6PwGEGN+f9sRnvm6Gp1b+v+ZcH57bmW2vppo58POWhzmeoQc3swtJY
	 Usu03dFj0r/J25tXOEnLtuYOHZ9dQwWR2NAdJ1O4EV3LW6M+E6c7nVlOrZlaz3nfkaSLs
	 +k3Qf9t4SZVxkGhuvvTOwx4Y3XAb8AwNr+YbUFLUl2j2leL59dODUkKv3oao/y5v+EYdI
	 LjCJd4zlKYZLW8A544KDpaxhgurO2vnMssVAKRgkIqgntmE94la9RJQtxsNrpMAtC/156
	 Of6aRa5dz1NgC2bAo0EhU+RP561W6YzDv8kMRnIKjSedAd2kFZoraIPQms4y+RuRxMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793513806;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mSF7aPql77EvpJK0U6mtu3706TZgUUeYYH541yBj7IQ=;
	b=YZdHhQ4byAdvLZkx9ZC0zWzsX1dJqBs6SNxJ5g7BzCZTd+aSrntjvlKy1sChXhwaf1CS
	 8kdwnlvjlqi7i6UfHg28qqZMiEc/OFAg4Pc5WjD8kR7+UX41Cy93jQRTUUiXZpbZRia+D
	 kdz48o6EJ2MVjhVyjO+zeCiuXQ48XF/eoTMDOdsVUKB5+Gw2u5/oy0qHsllmrCg/CCwwu
	 WbAc+arIVO4U6Pg31we5k476O8bRayTL6K9riRsXskQRvSKCZdWUFVlEUvjzB7QpfG7pB
	 jCt9qaqLOmXRJZBbL0ZfuHBwfImWAD6ljF6kZcqM87cxqtFQNs7UcQlxmw/+2EOkptQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h5sh+LSt;
	arc=none smtp.remote-ip=95.215.58.20
Received: from mta1.migadu.com (out-20.mta1.migadu.com [95.215.58.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE0606A327
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3FE0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h5sh+LSt
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VEj4AXOvyHq7dn47CDsF3SXWHUAqc4UCTqa5O+MQa+s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793513804; v=1; x=1794118604;
 b=h5sh+LStSxjWC71XmeS5IkqQAL1f7KnGA2JcxWkR5mo6njZmSZM0GC+lm31bXYBH8Kv98Zdq
 TvElL5XNLADnzX1yHVj4E8jpyXXIMoppEaJiWDnJhWnDV3+ppOveytqem6w40vclkyBv7fp4HiX
 sozklZeOGImFAWNf4hENqc/8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3c9e97b33ce8185;
	Sun, 01 Nov 2026 06:16:44 +0000
X-Mizu-Trace-ID: e3c9e97b33ce8185
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Flavio Leitner <fbl@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 5/5] net: restrict message_cost and message_burst to non-negative values
Date: Sun,  1 Nov 2026 14:12:03 +0800
Message-ID: <20261101061331.286404-6-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101061331.286404-1-jiayuan.chen@linux.dev>
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
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
burst of net_ratelimit_state, but neither rejects negative values:
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

Negative values never meant anything here: 0 already expresses both
"no limit" (interval) and "suppress everything" (burst).

Reject them at write time. message_burst can simply use
proc_dointvec_minmax with extra1 = 0. proc_dointvec_jiffies has no
minmax variant, so add proc_dointvec_jiffies_minmax(), mirroring
proc_dointvec_ms_jiffies_minmax(), and use it for message_cost with
extra1 = 0. Note that like the ms variant, extra1/extra2 are compared
against the converted jiffies value.

Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negative")
Cc: stable@vger.kernel.org
Suggested-by: Joel Granados <joel.granados@kernel.org>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/jiffies.h    |  2 ++
 kernel/time/jiffies.c      | 40 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c |  6 ++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index bbd57061802cd..de12920f8e94b 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -646,6 +646,8 @@ extern unsigned long nsecs_to_jiffies(u64 n);
 struct ctl_table;
 int proc_dointvec_jiffies(const struct ctl_table *table, int dir, void *buffer,
 			  size_t *lenp, loff_t *ppos);
+int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir,
+				 void *buffer, size_t *lenp, loff_t *ppos);
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				    void *buffer, size_t *lenp, loff_t *ppos);
 int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 9b3487d40cd6a..1e1dd9f3c48c4 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -165,6 +165,14 @@ static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
 			     sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
 }
 
+static int do_proc_int_conv_jiffies_minmax(bool *negp, ulong *u_ptr,
+					   int *k_ptr, int dir,
+					   const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
+			     sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
+}
+
 static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
 					   int *k_ptr, int dir,
 					   const struct ctl_table *tbl)
@@ -213,6 +221,13 @@ static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
 	return -ENOSYS;
 }
 
+static int do_proc_int_conv_jiffies_minmax(bool *negp, ulong *u_ptr,
+					   int *k_ptr, int dir,
+					   const struct ctl_table *tbl)
+{
+	return -ENOSYS;
+}
+
 static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
 					   int *k_ptr, int dir,
 					   const struct ctl_table *tbl)
@@ -263,6 +278,31 @@ int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
 }
 EXPORT_SYMBOL(proc_dointvec_jiffies);
 
+/**
+ * proc_dointvec_jiffies_minmax - read a vector of integers as seconds with min/max values
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ * The values read are assumed to be in seconds, and are converted into
+ * jiffies. The converted values are checked against the optional
+ * table->extra1 (min) and table->extra2 (max) bounds, in jiffies;
+ * a value outside the range is rejected with -EINVAL.
+ *
+ * Return: 0 on success.
+ */
+int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_jiffies_minmax);
+}
+EXPORT_SYMBOL(proc_dointvec_jiffies_minmax);
+
 /**
  * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ seconds
  * @table: the sysctl table
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 473c162736d69..9226b96f2e89b 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -544,14 +544,16 @@ static struct ctl_table net_core_table[] = {
 		.data		= &net_ratelimit_state.interval,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
+		.proc_handler	= proc_dointvec_jiffies_minmax,
+		.extra1		= SYSCTL_ZERO,
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

