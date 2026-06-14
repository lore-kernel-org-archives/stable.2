Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4DD1DF261;
	Sun, 14 Jun 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781430772; cv=none; b=QF+rGOMgxdC6rC22XQcu2o1LCgktFJ8YdgQzjTOD49mMrazrwWHVCXI69/K6VSIGio2Su2LMQVyKcNwtwVLFYrryR+7tLbHkann44026ZsCFNpa3oFwGjvmp0S2+Hwaf3ravLa3AG2YRj0ptJOwfac+3KlAGVra4rLd+0hXpPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781430772; c=relaxed/simple;
	bh=7R2oMCXF7yh/HRb0bDxpLZMyKUeXkdWi85S30PhRtdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6Yoj01LXoPGhKYPe8HNo97x++yqS45sk/+0cthHRe9lV1ZkLMd0R/+sH/mIm/63uV5nVfOgHEn7MxeFLH4XbEeIEqdLA7AbHizOWhqyI7ViibT/pWOA03PlshFLuDGSjMDjmAYTlUuFEJ9+fa5gnwgVHTYUVzEuia5dPiOOP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=I02DqksV; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="I02DqksV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=BfaiD
	FDk6S0iO2/wHu18Qvg1fwOvjyP5iFL/n/7N7JQ=; b=I02DqksVS+6/ByU2zNzw0
	jJ26tatLyebxqHbEdTdjA5YyjiS/MEUS9HDmg52wSxMsAaRlhrebpznqAvZgZRoP
	nQiiUL9P2qiPOqcj60b84strOe5nFfk0pp0Oguq2EnFn5CfNb7LLWjlVkbydSRYc
	fUiT6QoWBmoMZDKuotlyCg=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.35])
	by web3 (Coremail) with SMTP id ygQGZQC3A5HleS5qdZhtAg--.40976S2;
	Sun, 14 Jun 2026 17:52:37 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kito Xu <veritas501@foxmail.com>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] appletalk: Hold socket reference in atalk_rcv()
Date: Sun, 14 Jun 2026 17:52:24 +0800
Message-ID: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:ygQGZQC3A5HleS5qdZhtAg--.40976S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw48Jw1kurWDCF47Kr1xZrb_yoW8KF4kpF
	WrCF4jkFyUt34j9rn5Ja17Ar17CF4kKrW3G34rC342vFn8Wa4Fqr10vw4F9rZ0krZ5GFWj
	qrZ7GFWjyr1UZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjWxR3UU
	UUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQESAWot2C-jUAABsR

atalk_search_socket() walks the global atalk_sockets list while holding=0D
atalk_sockets_lock, but it returns the matching socket after dropping the=0D
lock without taking a reference.  atalk_rcv() then passes that pointer to=0D
sock_queue_rcv_skb().=0D
=0D
That leaves a race with close().  A concurrent atalk_release() can orphan=0D
the socket, remove it from atalk_sockets, and drop the final reference via=
=0D
atalk_destroy_socket(), freeing the socket before atalk_rcv() queues the=0D
incoming skb.=0D
=0D
On a KASAN-enabled kernel this can be reproduced by racing AppleTalk DDP=0D
delivery on loopback against close/rebind of the destination DGRAM socket:=
=0D
=0D
  BUG: KASAN: slab-use-after-free in selinux_socket_sock_rcv_skb()=0D
  sk_filter_trim_cap()=0D
  sock_queue_rcv_skb_reason()=0D
  atalk_rcv()=0D
  snap_rcv()=0D
  llc_rcv()=0D
=0D
Take a reference on the selected socket before dropping=0D
atalk_sockets_lock, and put it after sock_queue_rcv_skb() has finished.=0D
This keeps the socket alive for the receive path without changing socket=0D
lookup semantics.  A malformed or racing receive still drops the skb on=0D
queueing failure as before.=0D
=0D
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")=0D
Cc: stable@vger.kernel.org=0D
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>=0D
Reported-by: Ao Wang <wangao@seu.edu.cn>=0D
Reported-by: Xuewei Feng <fengxw06@126.com>=0D
Reported-by: Qi Li <qli01@tsinghua.edu.cn>=0D
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>=0D
Assisted-by: GLM:GLM-5.1=0D
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>=0D
---=0D
 net/appletalk/ddp.c | 5 ++++-=0D
 1 file changed, 4 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c=0D
index 30a6dc06291c..61ec5c569dc3 100644=0D
--- a/net/appletalk/ddp.c=0D
+++ b/net/appletalk/ddp.c=0D
@@ -131,6 +131,8 @@ static struct sock *atalk_search_socket(struct sockaddr=
_at *to,=0D
 	}=0D
 	s =3D def_socket;=0D
 found:=0D
+	if (s)=0D
+		sock_hold(s);=0D
 	read_unlock_bh(&atalk_sockets_lock);=0D
 	return s;=0D
 }=0D
@@ -1474,9 +1476,12 @@ static int atalk_rcv(struct sk_buff *skb, struct net=
_device *dev,=0D
 		goto drop;=0D
 =0D
 	/* Queue packet (standard) */=0D
-	if (sock_queue_rcv_skb(sock, skb) < 0)=0D
+	if (sock_queue_rcv_skb(sock, skb) < 0) {=0D
+		sock_put(sock);=0D
 		goto drop;=0D
+	}=0D
 =0D
+	sock_put(sock);=0D
 	return NET_RX_SUCCESS;=0D
 =0D
 drop:=0D
-- =0D
2.43.0=0D

