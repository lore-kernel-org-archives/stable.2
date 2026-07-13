Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043C37CD52;
	Mon, 13 Jul 2026 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940365; cv=none; b=HTJDpJ0MV8htT90+Y5AR6xbOLt7amRxP0h0o8R5D9mXTjtKwLAPhU3ebK672TVUUDklnjNAZSv0eoDUz68C44qsskgC/JH8M+wEzmHSsUxBeEdiM3MmK1NiTSKGwF+NRzD+b+gWf0ruqMh37ZcWh+JcOohqBTVNSHq8icrc50yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940365; c=relaxed/simple;
	bh=hMUzyfPsZITC71r2AApuo/5sd8jeSwkGVY9URMR8w9A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C6FkYNpfIZ1UtknvwcJ0PBzlOXacyw4BFg/m1VcT8GI+HkvhIUMUN2HCzS0vHFa4m/N830wR51hsoqay3KlDh1xs4wIRp+nmO2PvFi1py4z9JHMqpnTLRoMf0dma9LMST96wHfcxOKWaIETU+4S8tYuuW0PdqfgE/1JqYT6IwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SlEx8YZX; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SlEx8YZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; bh=i0slMDNhK
	lMyKtTXMPPaVwgKTGbRsXdDj4D0CFNyp8s=; b=SlEx8YZXNk65B/21Jeyn0TMPf
	bGaUytD4QtgkPr8NfjoqxsMMTm1uUSHjzUUSeI1K9dJvkwYLgW9CJAsk7KJtp89P
	gk+45V4WloGbN4qjuvMBd90gthy/XU843t8wdmLeSHpfwfHBqXpDKXzoswDgVclF
	JWtgDm7xbj5pgcNZxA=
Received: from smtpclient.apple (unknown [121.229.84.192])
	by web3 (Coremail) with SMTP id ygQGZQDHE5EAxVRqfF4kAw--.20159S2;
	Mon, 13 Jul 2026 18:59:12 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net] tcp: initialize standalone IPv4 ACK options
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <CANn89i+jA5kPcZrjXfsY1ic_LjeEwPHi-U54kYmZdkBKHB+vTA@mail.gmail.com>
Date: Mon, 13 Jul 2026 18:59:02 +0800
Cc: netdev@vger.kernel.org,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A9A9EE6-1859-4F1E-B8DE-2ACE839D5274@mails.tsinghua.edu.cn>
References: <20260713081842.3119-1-zhaoyz24@mails.tsinghua.edu.cn>
 <CANn89i+jA5kPcZrjXfsY1ic_LjeEwPHi-U54kYmZdkBKHB+vTA@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CM-TRANSID:ygQGZQDHE5EAxVRqfF4kAw--.20159S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur4fJFyxCFy5XryrAw4xZwb_yoWkurXEkF
	W7G39rWwn7ZFWktrnakr4qkry5Xayj9r4ftrnYgF17WryfAa1rtFs5Cr9avFyxGr18tF47
	urnIvF1jyr9IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxE
	wVAFwVW8twCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
	WxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU0kWrtUUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQAHAWpUpbI4RgAAsQ


Thanks for your review.

> On Jul 13, 2026, at 16:48, Eric Dumazet <edumazet@google.com> wrote:
>=20
> On Mon, Jul 13, 2026 at 10:18=E2=80=AFAM Yizhou Zhao
> <zhaoyz24@mails.tsinghua.edu.cn> wrote:
>>=20
>> tcp_v4_send_ack() constructs standalone IPv4 TCP ACK replies on the =
stack
>> for SYN-RECV and TIME-WAIT paths.  It currently zeroes only the TCP
>> header, not the accompanying option buffer.
>>=20
>> TCP-AO options may have actual lengths that are not 4-byte aligned, =
while
>> the transmitted TCP header length is correctly rounded up to a 4-byte
>> boundary.  tcp_ao_hash_hdr() writes only the MAC bytes, leaving the
>> TCP-AO option alignment padding in rep.opt uninitialized.  With stack
>> auto-initialization disabled, those padding bytes can be copied into =
the
>> network packet and sent to the peer.
>>=20
>> Zero the whole reply structure before writing options, so the =
alignment
>> padding bytes are initialized.
>=20
> Please fix TCP-AO instead of slowing down TCP (almost no TCP flow is =
using AO)

We have posted a v2 patch following your suggestions:
=
https://lore.kernel.org/netdev/20260713105631.8616-1-zhaoyz24@mails.tsingh=
ua.edu.cn/

Regards,
Yizhou=

