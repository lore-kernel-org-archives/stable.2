Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD0204C3B;
	Sun, 14 Jun 2026 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781426451; cv=none; b=aiQ959tYulVNABpR8o9/pqHNSlpEX76nUwnXz/tRaGlk+akvEF4ZYGBOtm9RBlC9DzqGPcLX0SZW4Y+u9SSHFLXJFacX3AfGcxBij2mS5bOxYxS/+XTeY7c5htHi+FpV54zZeiDiNy93DSzAxpvpEs9ZArOnYkt6HsdigUwup0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781426451; c=relaxed/simple;
	bh=wnJ2V2tWE9FQV7A8hKDEvTwDBMFoDrSPvkfoTPf19dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9vRQJJTkL2rhn959DKCFV0H029UyGUehBw/qlgjAkXlAPOUT6zbqwpnoxxYl8nmFDT/8Y0HqMOz3jIvTOFKfU7aqu75PQCYtycfI9AHCPJGMLo2aG2KgDkTRxKw6POcYCtjp+Bq3umjJOnp5M6tkWX0Kxi9KjLDtaBdRB+f+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Xe7FNDpw; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Xe7FNDpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=NAgki
	ZP5ccnOJK1dR/DHvqpExriXXY5iHVNkiaZ3ct8=; b=Xe7FNDpwwSo3AVfCgWnxV
	2ISD0YnDUYZiJOj+ZowRtmGTGD4cMcpz2F2RuNeByVJMp7GED9Sj34yICbxtRbHh
	c8IByvDlLt/AuqncGQi5oDblzrw+bOgAYkTapM8825x5iK3ILtqbe4nNVY6rpoWR
	/0UOZ9phQzPFpHdqME/O3w=
Received: from DESKTOP-35NLEVI (unknown [166.111.239.35])
	by web2 (Coremail) with SMTP id yQQGZQDHoJj9aC5qpIlJAg--.35704S2;
	Sun, 14 Jun 2026 16:40:29 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] atm: br2684: validate IP header length before filtering
Date: Sun, 14 Jun 2026 16:40:26 +0800
Message-ID: <20260614084027.1179-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:yQQGZQDHoJj9aC5qpIlJAg--.35704S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF15trW8GF1xWF4kGw4rZrb_yoW5Xw48pa
	4UCr90kFWrGr17Awn2vw4Uuw45Ar4vq34fXa4xJa4I9wn8Gr18KFWrKFyY9F1Dur45K3W2
	vrWv9ayUJr4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRXZ2-DUUU
	U
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgYRAWosh5zoiQABsp

When CONFIG_ATM_BR2684_IPFILTER is enabled, packet_fails_filter()=0D
treats skb->data as an IPv4 header whenever the packet protocol is=0D
ETH_P_IP and then reads iph->daddr.  That read is not protected by a=0D
check that the pulled skb still contains a full IPv4 header.=0D
=0D
This is reachable through the receive path.  An LLC-routed IPv4 PDU can=0D
contain only the 8-byte LLC/SNAP header; br2684_push() accepts it,=0D
sets skb->protocol to ETH_P_IP, pulls the LLC header, and leaves=0D
skb->len as 0 before the filter runs.  The VC-routed path also reads=0D
iph->version before checking that the skb contains an IPv4 header, so a=0D
2-byte PDU starting with an IPv4 version nibble can reach the same=0D
filter decision.=0D
=0D
In both cases the filter can make its pass/drop decision from bytes=0D
outside the packet data.  A reproducer using a dummy ATM receive device=0D
filled the skb tailroom with 0xa5 and showed that an 8-byte LLC-routed=0D
PDU and a 2-byte VC-routed PDU were forwarded when the filter prefix was=0D
0xa5a5a5a5, even though neither packet contained an IPv4 destination=0D
address.=0D
=0D
Drop IPv4 packets that are shorter than struct iphdr in=0D
packet_fails_filter(), before reading iph->daddr.  Also reject=0D
VC-routed packets shorter than struct iphdr before br2684_push() reads=0D
iph->version.  Such packets cannot contain a valid IPv4 header, while=0D
normal minimum-sized IPv4 packets continue through the existing filter=0D
logic.=0D
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
 net/atm/br2684.c | 3 +++=0D
 1 file changed, 3 insertions(+)=0D
=0D
diff --git a/net/atm/br2684.c b/net/atm/br2684.c=0D
index 6580d67c3456..fa4b1852d72b 100644=0D
--- a/net/atm/br2684.c=0D
+++ b/net/atm/br2684.c=0D
@@ -393,6 +393,7 @@ packet_fails_filter(__be16 type, struct br2684_vcc *brv=
cc, struct sk_buff *skb)=0D
 	if (brvcc->filter.netmask =3D=3D 0)=0D
 		return 0;	/* no filter in place */=0D
 	if (type =3D=3D htons(ETH_P_IP) &&=0D
+	    skb->len >=3D sizeof(struct iphdr) &&=0D
 	    (((struct iphdr *)(skb->data))->daddr & brvcc->filter.=0D
 	     netmask) =3D=3D brvcc->filter.prefix)=0D
 		return 0;=0D
@@ -482,6 +483,8 @@ static void br2684_push(struct atm_vcc *atmvcc, struct =
sk_buff *skb)=0D
 =0D
 			skb_reset_network_header(skb);=0D
 			iph =3D ip_hdr(skb);=0D
+			if (skb->len < sizeof(struct iphdr))=0D
+				goto error;=0D
 			if (iph->version =3D=3D 4)=0D
 				skb->protocol =3D htons(ETH_P_IP);=0D
 			else if (iph->version =3D=3D 6)=0D
=0D
-- =0D
2.43.0=0D

