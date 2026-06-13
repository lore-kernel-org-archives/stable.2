Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E384184;
	Sat, 13 Jun 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362894; cv=none; b=WPMhIjdLm+q+LH5PEb7fJDZvQkHkSep1wsON9cJqJTQxRdPkWWPP06wEwjjMLOuu5WHVtEJlw96m3X9IUJl9y0MYTNKykqVuwp15Px5GNqFeo8rLHx9ms9vvZpJYvEDqlWWTzy/JTyPJ4Zy3Eq74nbgbNyn0vnsh/aV3uWMso78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362894; c=relaxed/simple;
	bh=zCj1LadH/JgYCj85jNizR7MK6Ok8PF3bp62osy7RMdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFpygk9A7B1Btm2W7OCPFkoNdDYx69nvOHbM7+ZiYljXcqFMZg6R7lsQglgNqkGNRoYAryODdUtSjAOKf5ldesR4qae2+Kt1bXF0uqXaVCr3/u9LQywpNx9PVGr/hYHWY+1lHj20giiYEDpGqLdrfuhP99boFm2UasUuW1uDE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=HWNAlYbP; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="HWNAlYbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=wkce2
	+K3jXJuou1ul76vkBcweOJInmUMLiOtfM7Hxx8=; b=HWNAlYbPIjwKk8bHD5tbd
	oZbyiZdfq2yvIhhUq8SC7AUsh7FvWG/Kuy/KefiaQeC0t50nAm43aiUuo2N0ll+p
	9327vgsL9W9/mQ4yL1frQSfscZBFqO2Z0KN68+2iU7U3hbB1XHeLWaPqYFyBKomT
	Ffb00KmO894kwu8v+22/Ss=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.35])
	by web3 (Coremail) with SMTP id ygQGZQAnc5C8cC1qmb5oAg--.4527S2;
	Sat, 13 Jun 2026 23:01:16 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Kito Xu (veritas501)" <hxzene@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] appletalk: aarp: fix proxy probe conflict lookup
Date: Sat, 13 Jun 2026 23:00:59 +0800
Message-ID: <20260613150104.1985-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:ygQGZQAnc5C8cC1qmb5oAg--.4527S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1kKw4rtF48Aw4fCr4DJwb_yoW5JFykpa
	y8Wr4qkayDGr17KrWvvw12gw1rCF4DCrWxGrn8ta4Yv3Z8XF1j9ryxK3yYkF98Z395Kay5
	XF9Fyry8Ar4UWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_XrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0lksUUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgMRAWosh5zRJwAAs6

aarp_rcv() computes hash from the packet source node and later uses it=0D
for the normal AARP reply lookup against the unresolved table. The same=0D
hash is also reused earlier for the proxy probe conflict check, but that=0D
check builds its lookup key from the packet destination address.=0D
=0D
Proxy AARP entries are inserted into the proxy table using the proxied=0D
address node as the hash key. AARP packets are not required to have the=0D
same source and destination node numbers, so the proxy probe conflict=0D
check can search the wrong bucket and miss an entry that is still in=0D
ATIF_PROBE state.=0D
=0D
If that happens, SIOCSARP can accept a proxy address even though a=0D
conflicting AARP packet was observed on the wire. This can create=0D
duplicate AppleTalk address ownership. Depending on the network setup,=0D
traffic for that address may then be misdirected, or the address may=0D
become intermittently unreachable.=0D
=0D
Look up the proxy probe entry using a hash derived from da.s_node, which=0D
matches how proxy entries are inserted and removed. Leave the source-node=0D
hash unchanged for the later unresolved-entry reply handling.=0D
=0D
In a veth/SNAP/AARP reproducer on a KASAN-enabled kernel, a conflicting=0D
AARP packet with different source and destination nodes allowed SIOCSARP=0D
to succeed before this change. With this change, the same conflict=0D
returns EADDRINUSE, while a no-conflict proxy add still succeeds.=0D
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
 net/appletalk/aarp.c | 3 ++-=0D
 1 file changed, 2 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c=0D
index 078fb7a6efa5..1352ede79668 100644=0D
--- a/net/appletalk/aarp.c=0D
+++ b/net/appletalk/aarp.c=0D
@@ -755,7 +755,8 @@ static int aarp_rcv(struct sk_buff *skb, struct net_dev=
ice *dev,=0D
 	da.s_net  =3D ea->pa_dst_net;=0D
 =0D
 	write_lock_bh(&aarp_lock);=0D
-	a =3D __aarp_find_entry(proxies[hash], dev, &da);=0D
+	a =3D __aarp_find_entry(proxies[da.s_node % (AARP_HASH_SIZE - 1)],=0D
+			      dev, &da);=0D
 =0D
 	if (a && a->status & ATIF_PROBE) {=0D
 		a->status |=3D ATIF_PROBE_FAIL;=0D
-- =0D
2.43.0=0D

