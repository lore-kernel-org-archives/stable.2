Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B139DBFA;
	Mon, 13 Jul 2026 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930744; cv=none; b=UhBs+yXojPrALwMBBiGyA0WwQrcvlnoFpiqnMKMZx5mlKfv6zvIVxQUHEPs/v53Ioo4YNAp0aI9Zi+ZAspcv/fzY7L2O0rHt87Xiah4wD1ddB2p1SE/7onf0AV13koLrKA14cMKRuqSs5soHInBH+R4rwBidXWQpCdTf/N06vvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930744; c=relaxed/simple;
	bh=yQvdhLWJ8LZ6eGjVPDK/jPe0RYv7DHDk1LRwJrKtbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOsBRb0Pa2H5TUHD8nWdTqzswLZd3QEVWZtvxAkmXa9u24ArRUBpLXjQlB2ZCHx050Lr+N3nl00ZjK/h/SwwKXEs5pD2k5Ad8V4jkCnMR9VWjtpVEq6azWs/x/MjSFQ0hrCdIUfh+eyW9GzJeK4Wyh3q6slUhyCYJIQFb0wf6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=lGle3H04; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="lGle3H04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=yoaBk
	GIVqsBzBcPxnKJVPP9RSrjDbcCn33d5TYJXsic=; b=lGle3H04Yi/22OmGIjdlJ
	7Nx1jr0hB5dqTpSu/rDHyOUoWzxYLVqtCJzxu75RI9wKam1t5xZmlMasvlATk3Nj
	JflmUNSOzgV7t2XQimWzQ5lt1qqfc9d/PWqzq8fCXeWf6ZlGlrkA5HH7+pRCdzIF
	lVE658CK/uhqSBcGgSE6Ik=
Received: from localhost.localdomain (unknown [121.229.84.192])
	by web3 (Coremail) with SMTP id ygQGZQAHVpNln1RqkskjAw--.19778S2;
	Mon, 13 Jul 2026 16:18:46 +0800 (CST)
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
Subject: [PATCH net] tcp: initialize standalone IPv4 ACK options
Date: Mon, 13 Jul 2026 16:18:41 +0800
Message-ID: <20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQAHVpNln1RqkskjAw--.19778S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxAF1kXFyfJFy8uw1UAwb_yoW8WFWfpa
	1IkwsayFyUGry293WkAay0vr43XF4kWFyI9w4jkF9rZFn8WF1xua4Fg3WYvF90v3ykKF1S
	yFyjvr1Dt398ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0Ysj5UUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQIHAWpUE7LrhwAAs2

tcp_v4_send_ack() constructs standalone IPv4 TCP ACK replies on the stack
for SYN-RECV and TIME-WAIT paths.  It currently zeroes only the TCP
header, not the accompanying option buffer.

TCP-AO options may have actual lengths that are not 4-byte aligned, while
the transmitted TCP header length is correctly rounded up to a 4-byte
boundary.  tcp_ao_hash_hdr() writes only the MAC bytes, leaving the
TCP-AO option alignment padding in rep.opt uninitialized.  With stack
auto-initialization disabled, those padding bytes can be copied into the
network packet and sent to the peer.

Zero the whole reply structure before writing options, so the alignment
padding bytes are initialized.

Fixes: decde2586b34 ("net/tcp: Add TCP-AO sign to twsk")
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
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ec09f97..327ee96 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -922,7 +922,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	struct sock *ctl_sk;
 	u64 transmit_time;
 
-	memset(&rep.th, 0, sizeof(struct tcphdr));
+	memset(&rep, 0, sizeof(rep));
 	memset(&arg, 0, sizeof(arg));
 
 	arg.iov[0].iov_base = (unsigned char *)&rep;

--
2.47.3

