Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE9448CE2;
	Tue, 14 Jul 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032044; cv=none; b=cxdRQ8qaIvt0yJRx9tR4AVEK+qyFlj08L8dF2OTXfUhJDuE95HIJZ8Yn5jpf8plSbTTSIambmqrUj3i96BBUYuH+hTNwzVtB2PQJbbfiK/tyTAXDg+i1OOOM/Kvj0PZBDoLUw+Mb21dIUFkspW/AdyPJXUQgNH7NIUOyJIN04iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032044; c=relaxed/simple;
	bh=mf25ywtL9Q+yeI6sh6gKZ7VdxR4ouIUbPFmGFmgMWAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVDc8w9lRTSx2ch3BuKGhkS40MYGj0+MUFIJiuuYYMckvLpza8/zYm4OOL7lazXC2zNwldzCd0nkgwfGgGsL2DMli+jlbYSmEt61S2SUqwsdGAL8Z9H+hVa9r13CEt3uovPfSNKbMORG87DvNkcAEv7lyJlVVmXBYZXDunyNMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Q27ato9S; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Q27ato9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=u9Zo4
	ytzjqMfIxJVTDUl3YZj8WOW1rECCH+9hIcKu90=; b=Q27ato9SHUIWqr2+ru74m
	r9Ymjm3f0fp2y22iGa/EWjNlZB0/kzQW6rVJUxt5IObsVRvY7E8sed5hk79GO4Md
	esjG8tK9e4/SYP2toOsi/E2MaXuhuHG/7yqY7NGgordfzZilhM5lvU1N4Mw0pC0b
	PhShHeC2l66kU+J7ceERek=
Received: from localhost.localdomain (unknown [121.229.84.192])
	by web4 (Coremail) with SMTP id ywQGZQB3W5vvKlZqS77vAg--.16019S2;
	Tue, 14 Jul 2026 20:26:24 +0800 (CST)
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
Subject: [PATCH net] ipv4: require matching source address for route hint reuse
Date: Tue, 14 Jul 2026 20:26:17 +0800
Message-ID: <20260714122618.21698-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQB3W5vvKlZqS77vAg--.16019S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1fZw1xCFWUWF4rGrW8Crg_yoW8Cw17pa
	yjkrZ5tFyxGry7uwn7t3W7AryfArWvkrWagr15tay3uan8Ka40yF4xtFy5CFs8CrWqkryj
	vrW2v3yjyrn8uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0FksPUUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgUIAWpWBJIxoAAAs1

IPv4 list receive can reuse a route from the previous skb in the same
receive batch. The current eligibility check only compares the destination
address and TOS before calling ip_route_use_hint().

For forwarded routes, ip_route_use_hint() skips fib_validate_source()
unless the hinted route is local. This means a packet with a different
source address can reuse a forwarding dst created for an earlier packet
and avoid source validation such as strict rp_filter.

In a KASAN QEMU router with strict rp_filter on the ingress device, a 
bad-only burst was dropped entirely, however, a paired valid/bad burst 
with the same destination/TOS made all of the bad packets pass rp_filter.

Require the source address to match before reusing the hint. Packets from
the same source/destination/TOS still take the fast path; packets whose
source changes go through the normal route lookup and source validation
path.

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
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
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 9860178752b8..970a2c11ec2a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -316,6 +316,7 @@ static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
 			    const struct sk_buff *hint)
 {
 	return hint && !skb_dst(skb) && ip_hdr(hint)->daddr == iph->daddr &&
+	       ip_hdr(hint)->saddr == iph->saddr &&
 	       ip_hdr(hint)->tos == iph->tos;
 }
 
-- 
2.47.3

