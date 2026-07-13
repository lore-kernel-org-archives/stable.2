Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46772D47FF;
	Mon, 13 Jul 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951897; cv=none; b=mxTJoGEhjYyw2T3XPgbwPb8LueLZLzOJENnTGwp5sUlpAw3g0z2SN5A9n6TPw7CQv9RroxWZd9cW22lh9wRIK+Ya4MYYn3v3tOtGJlpbH20LyQ3w0xP/X2o7KgKcgUBYV1Zha6LQpeGtWi8mCG+BuBu/EWc4Lr5+Cg7SUhPKYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951897; c=relaxed/simple;
	bh=LJCUQYGqlLQ7Z4Fucuz+YHjQmMtKF8g1WcuQmRDu/Io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDV9df3LDX37+YD/UfQ+Jfq8agKNfRMBWB0k4UTrDeWOt9UAp9PIpJe0GUl2uJZ0QbD5qTw7ewfHCzR9pZurnU5lVrHRw7X0PJFHgA5HFjRMv7KiL3jVn9SDfk878B/JnpAZ92+rRmI7PbVeU8U+tTXLyEfajuy0B4cvHlDz678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=kVh6GwrH; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="kVh6GwrH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=UmEvB
	uHoKxdCDi8NTjNH5i/58/6HmGIdPyxE60y/ZIs=; b=kVh6GwrHztb/c5RZzAo4i
	7lRVMMjart9bNext3/rkTWzKp5Xym6D833E5Z9L9BJb3t/XE6F3fvT7c4iScSs4M
	1B+Xvbesjh7le9t10lskljYcnKNSVq2QQPZwvBK/C29EOM1QZ+Lyhssbuj5W3KfW
	3MkR41XsifaS7zg2WZ6UeQ=
Received: from localhost.localdomain (unknown [121.229.84.192])
	by web4 (Coremail) with SMTP id ywQGZQBneJ0B8lRqb+TqAg--.18679S2;
	Mon, 13 Jul 2026 22:11:13 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net] ipconfig: bound BOOTP options by UDP datagram length
Date: Mon, 13 Jul 2026 22:11:06 +0800
Message-ID: <20260713141107.10418-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBneJ0B8lRqb+TqAg--.18679S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1fZF15tr18Wr4fJw4kCrg_yoW8CFWrpF
	yxK3s3KrZrGry5A39xJFW8Wry7Ga9rWFySg34Uta48Zws8JFy8Ca4v9rsIqFWYy3yqkryj
	yF9avFWqyw4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjVBTOUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgMHAWpUphh5+gAAsE

ic_bootp_recv() accepts an IP packet whose total length exceeds its UDP
datagram length.  This is valid at the IP layer, but DHCP/BOOTP options
belong to the UDP payload.  The option parser nevertheless uses the IP
total length as its end boundary.

Consequently, an on-link attacker that can race a boot-time DHCP exchange
can put DHCP options after the declared UDP payload and have ipconfig
consume them.  A QEMU/KVM reproduction with ip=dhcp accepted a forged
DHCPOFFER/DHCPACK with an IP total length of 290 and UDP length of 248;
the tail supplied a netmask and an off-link gateway, causing boot-time
network configuration to fail.

Use the UDP datagram end as the parser boundary.  The receiver already
verifies that the UDP datagram lies within the IP packet, so this retains
normal valid DHCP/BOOTP parsing while excluding the IP-only tail.

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
diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index a35ffedacc7c..192874623a24 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1068,7 +1068,7 @@ static int __init ic_bootp_recv(struct sk_buff *skb, struct net_device *dev, str
 	/* Parse extensions */
 	if (ext_len >= 4 &&
 	    !memcmp(b->exten, ic_bootp_cookie, 4)) { /* Check magic cookie */
-		u8 *end = (u8 *) b + ntohs(b->iph.tot_len);
+		u8 *end = (u8 *)b + sizeof(struct iphdr) + ntohs(b->udph.len);
 		u8 *ext;
 
 #ifdef IPCONFIG_DHCP
-- 
2.47.3

