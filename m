Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10943E0226;
	Fri, 17 Jul 2026 08:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276126; cv=none; b=DIYm7Fyw0MvLzT6N73/guSiyf/QoiMQ3jyjb+nhDGCD8Ge8PbyCf0eBzTn0yOejup79DTRYwHSFWQeAfnOS96miCGXFN3haOSdjliMcPWEGw5ZkMjZb7bhJ6sSjVzk3XIqImFbMqNmBWItn7GcuEcWv4aeDVqRAYy9uT+vY0i84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276126; c=relaxed/simple;
	bh=CypDGazUdzhzDylLJH0I9K4emm8xsSLi+DX8MCGlinQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue0Inebg9Zd582DUN2TVKGgJQpQeuGwp/xBk29G5ytBs9fZUJ4pij8ROZ+JU98DLf1HfTXH02ylcKExqWzVAHmh018pXVKvPro3tmBhXRM+7AdgWDCblIe4CUDgmDPpH0pPCKyU5nTRywOcHYArfI7BPtNY3Ky8CBLGfjY/PksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SjEXlQVx; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SjEXlQVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=OVD/l1O1steeViKQdCQV2xNlE/y/HpeiSx
	bzhVMr2Kg=; b=SjEXlQVxGG1eWiTJvT72vwvhbEU45Jo4E3PF42bfFwc+MAbmO4
	vB18csN0xZS84Of0O5GffAgUui8BRx2ORKVz6BzX4ggOyGcEpi2cF90yoNndLxNa
	Z51qRYw7WCvyQ7WQU/E1HduuPLMFFsqv0BrfyXPKQHtZn6mZvbLNoOuqk=
Received: from node118.platform-default.svc.cluster.local (unknown [36.102.215.18])
	by web1 (Coremail) with SMTP id yAQGZQBnCMh45FlqWWMXAA--.33958S3;
	Fri, 17 Jul 2026 16:15:05 +0800 (CST)
From: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org,
	yyxroy22@gmail.com
Subject: [PATCH net 1/2] tcp: challenge ACK for non-exact RST in SYN-RECEIVED
Date: Fri, 17 Jul 2026 08:14:42 +0000
Message-Id: <20260717081443.809393-2-yangyx22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717081443.809393-1-yangyx22@mails.tsinghua.edu.cn>
References: <20260717081443.809393-1-yangyx22@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yAQGZQBnCMh45FlqWWMXAA--.33958S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr15Jr1fGry5uw47Zr4Dtwb_yoW7uw43pF
	WxCrWakr4DZayxuFn3A34DCwnxKws5Z34a934xX3yrAwn8Gr17CFWktr42vr1UCr4fuw4a
	qas0gr42kF1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdjb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5V
	A0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_
	Wrylc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7xRpc_SDUUUUU==
X-CM-SenderInfo: 51dqw5r0ssqzpdlo2hxwvl0wxkxdhvlgxou0/

The SYN-RECEIVED request-socket path in tcp_check_req() accepts an
in-window RST without requiring SEG.SEQ to exactly match RCV.NXT.  A
non-exact RST therefore removes the request instead of eliciting a
challenge ACK.

RFC 9293 section 3.10.7.4 applies the RFC 5961 reset check in
SYN-RECEIVED: an exact RST resets the connection, while a non-exact
in-window RST must trigger a challenge ACK and be dropped.

Apply that check before the ACK-field validation, following the RFC
sequence-number, RST, then ACK processing order.  Factor the per-netns
challenge ACK quota out of tcp_send_challenge_ack() so request sockets
can share it.  Use the request socket's send_ack() callback and its own
out-of-window ACK timestamp to send and rate-limit the response.

Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Fixes: 282f23c6ee34 ("tcp: implement RFC 5961 3.2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
---
 include/net/tcp.h        |  2 ++
 net/ipv4/tcp_input.c     | 56 ++++++++++++++++++++++++++++++----------
 net/ipv4/tcp_minisocks.c | 12 ++++++++-
 3 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d..2c5b88953 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1974,6 +1974,8 @@ static inline void tcp_fast_path_check(struct sock *sk)
 
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
+void tcp_reqsk_send_challenge_ack(struct sock *sk, struct sk_buff *skb,
+				  struct request_sock *req);
 
 static inline void tcp_mib_init(struct net *net)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 61045a888..daff93d51 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4038,24 +4038,17 @@ static void tcp_send_ack_reflect_ect(struct sock *sk, bool accecn_reflector)
 	__tcp_send_ack(sk, tp->rcv_nxt, flags);
 }
 
-/* RFC 5961 7 [ACK Throttling] */
-static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
+/* Consume one slot from the per-netns RFC 5961 challenge ACK quota.
+ * Returns true if a challenge ACK may be sent.
+ */
+static bool tcp_challenge_ack_allowed(struct net *net)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct net *net = sock_net(sk);
 	u32 count, now, ack_limit;
 
-	/* First check our per-socket dupack rate limit. */
-	if (__tcp_oow_rate_limited(net,
-				   LINUX_MIB_TCPACKSKIPPEDCHALLENGE,
-				   &tp->last_oow_ack_time))
-		return;
-
 	ack_limit = READ_ONCE(net->ipv4.sysctl_tcp_challenge_ack_limit);
 	if (ack_limit == INT_MAX)
-		goto send_ack;
+		return true;
 
-	/* Then check host-wide RFC 5961 rate limit. */
 	now = jiffies / HZ;
 	if (now != READ_ONCE(net->ipv4.tcp_challenge_timestamp)) {
 		u32 half = (ack_limit + 1) >> 1;
@@ -4067,12 +4060,49 @@ static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
 	count = READ_ONCE(net->ipv4.tcp_challenge_count);
 	if (count > 0) {
 		WRITE_ONCE(net->ipv4.tcp_challenge_count, count - 1);
-send_ack:
+		return true;
+	}
+	return false;
+}
+
+/* RFC 5961 7 [ACK Throttling] */
+static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct net *net = sock_net(sk);
+
+	/* First check our per-socket dupack rate limit. */
+	if (__tcp_oow_rate_limited(net,
+				   LINUX_MIB_TCPACKSKIPPEDCHALLENGE,
+				   &tp->last_oow_ack_time))
+		return;
+
+	/* Then check the per-netns RFC 5961 rate limit. */
+	if (tcp_challenge_ack_allowed(net)) {
 		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
 		tcp_send_ack_reflect_ect(sk, accecn_reflector);
 	}
 }
 
+/* Send a challenge ACK from a SYN-RECEIVED request socket. Uses
+ * __tcp_oow_rate_limited() directly so that an RST carrying payload
+ * cannot bypass the per-request rate limit.
+ */
+void tcp_reqsk_send_challenge_ack(struct sock *sk, struct sk_buff *skb,
+				  struct request_sock *req)
+{
+	struct net *net = sock_net(sk);
+
+	if (__tcp_oow_rate_limited(net, LINUX_MIB_TCPACKSKIPPEDCHALLENGE,
+				   &tcp_rsk(req)->last_oow_ack_time))
+		return;
+
+	if (tcp_challenge_ack_allowed(net)) {
+		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
+		req->rsk_ops->send_ack(sk, skb, req);
+	}
+}
+
 static void tcp_store_ts_recent(struct tcp_sock *tp)
 {
 	tp->rx_opt.ts_recent = tp->rx_opt.rcv_tsval;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ddc4b17a8..6ab3e3a0b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -833,7 +833,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	 * elsewhere and is checked directly against the child socket rather
 	 * than req because user data may have been sent out.
 	 */
-	if ((flg & TCP_FLAG_ACK) && !fastopen &&
+	if ((flg & TCP_FLAG_ACK) && !(flg & TCP_FLAG_RST) && !fastopen &&
 	    (TCP_SKB_CB(skb)->ack_seq !=
 	     tcp_rsk(req)->snt_isn + 1))
 		return sk;
@@ -872,6 +872,16 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		flg &= ~TCP_FLAG_SYN;
 	}
 
+	/* RFC 5961 section 3.2, as clarified by RFC 9293 section
+	 * 3.10.7.4, requires a challenge ACK for a non-exact
+	 * in-window RST in SYN-RECEIVED.
+	 */
+	if ((flg & TCP_FLAG_RST) &&
+	    TCP_SKB_CB(skb)->seq != tcp_rsk(req)->rcv_nxt) {
+		tcp_reqsk_send_challenge_ack(sk, skb, req);
+		return NULL;
+	}
+
 	/* RFC793: "second check the RST bit" and
 	 *	   "fourth, check the SYN bit"
 	 */
-- 
2.34.1

