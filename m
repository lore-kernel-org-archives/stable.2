Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F64194AE6;
	Sun, 12 Jul 2026 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862806; cv=none; b=QQ+xaKs9tdHwNwiYzop828Wb0p1K5Pj/69MrvG+9p0Y1nwtT8HQpIYd8FKJ1MSozBwilHQGFWyAJT2fZPZ8cV7d3fuV18cJHHWF4TCgDOPBNUVIS4aoPEUNBVQHRwcSa6LD2pnUeKNfxLWOlLCuZgCUMI6NbUCjzGfdl4/m4N7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862806; c=relaxed/simple;
	bh=EKFY5Ze13T4tZq5uV5SIjCZiwaAwQsy6opnmfRCZaBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caYuFtM5hdH5ABI/KQxqrE5+N8yZnx6XBjcIbzN6xdRLLHc5u+OmAd80ygNx27x1zPZIsiQSnkxzIiNih5QVD9h5dId47NGAtiUIIub8AMQd4np8tUBzfuqO5Y4/cYP8/TK3d+hrAA42n9R3zZlz6WcjSj7886DsrQBq3D/OsIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=WLBqXh1b; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="WLBqXh1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=wb+8y
	+c/Nz9q76vovFSpCWxPLe0gCxO7zGZ7FSXBEFY=; b=WLBqXh1bbzz0/yaGbTWFp
	D4FARq0K3VP6sg52z6BeZumhkGTyVU0r4+biVgpc0ygAcbJFMSJKNnf+YvrcTRAo
	JFqWR/NCkytzN3DxAM/HjV6Gf4qjyLrM8yDJiNylm0RqdOUviu9GOPoj7epN+9DX
	P5clKKpuJzfHXo4i0zLAl8=
Received: from localhost.localdomain (unknown [121.229.84.192])
	by web4 (Coremail) with SMTP id ywQGZQDHq5v5lVNqPrflAg--.6435S2;
	Sun, 12 Jul 2026 21:26:18 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] tcp: reject TIME_WAIT reopens when SYN queue is full
Date: Sun, 12 Jul 2026 21:25:30 +0800
Message-ID: <20260712132531.33028-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQDHq5v5lVNqPrflAg--.6435S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw17Xr47CF47CFyDCF4xCrg_yoW5Cr1UpF
	Z0krsrJrWDG3y7Ar92ya48ur1fWr4kuFy7uF4rGryUCFn8GF1xXF1Igr4aqF1jyF4vkF1F
	gFWYqrs8Wr98A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0jZX7UUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgEGAWpSwx+nOwAAs8

A valid SYN that matches a TIME_WAIT socket is redirected to the
listener with a non-zero tcp_tw_isn.  tcp_conn_request() deliberately
exempts those requests from normal SYN queue throttling.  A peer can
therefore create victim-side TIME_WAIT entries with short connections,
replay valid reopen SYNs, and withhold the final ACK to allocate
request_sock objects outside the listener's normal SYN-flood controls.

Do not send syncookies for this path: tcp_timewait_state_process()
derives tcp_tw_isn from tw_snd_nxt so that a direct reopen uses an ISN
after the prior connection's sequence space.  A syncookie ISN is a
hash-derived value and has no such ordering guarantee.

Check the selected listener's SYN queue before descheduling the
TIME_WAIT socket.  If it is full, account a request-queue drop, retain
the TIME_WAIT socket, and discard the SYN.  Once the queue has room,
the existing direct-reopen path and its TIME_WAIT ISN are unchanged.
Normal SYNs continue to use syncookies when the listener is full.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: Claude-Code:GLM-5.2-special
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
 net/ipv4/tcp_ipv4.c | 8 ++++++++
 net/ipv6/tcp_ipv6.c | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508fcc3974ae71d35dd66cba96b73d0..ddb5daede802d355b51b802b29b2e1ead3597bd2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2310,6 +2310,14 @@ int tcp_v4_rcv(struct sk_buff *skb)
 							inet_iif(skb),
 							sdif);
 		if (sk2) {
+			if (inet_csk_reqsk_queue_is_full(sk2)) {
+				drop_reason = SKB_DROP_REASON_TCP_LISTEN_OVERFLOW;
+				__NET_INC_STATS(net, LINUX_MIB_TCPREQQFULLDROP);
+				tcp_listendrop(sk2);
+				inet_twsk_put(inet_twsk(sk));
+				goto discard_it;
+			}
+
 			inet_twsk_deschedule_put(inet_twsk(sk));
 			sk = sk2;
 			tcp_v4_restore_cb(skb);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ebe161d72fbd07a13d92812b45b5a3ce2464a015..8d3ff7184d03f5dd81f9a9c20e3ebbf174efc43a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1969,6 +1969,15 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 					    sdif);
 		if (sk2) {
 			struct inet_timewait_sock *tw = inet_twsk(sk);
+
+			if (inet_csk_reqsk_queue_is_full(sk2)) {
+				drop_reason = SKB_DROP_REASON_TCP_LISTEN_OVERFLOW;
+				__NET_INC_STATS(net, LINUX_MIB_TCPREQQFULLDROP);
+				tcp_listendrop(sk2);
+				inet_twsk_put(tw);
+				goto discard_it;
+			}
+
 			inet_twsk_deschedule_put(tw);
 			sk = sk2;
 			tcp_v6_restore_cb(skb);

--
2.47.3

