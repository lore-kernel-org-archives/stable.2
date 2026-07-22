Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B573932F0;
	Wed, 22 Jul 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688892; cv=none; b=suTe/hqOxadc+uQzyBiRBxLx8FKPEYT5WRoALWy2TiZqGzVn+B9IlXRuKF5gQWKQd94uel7Pi6mfitEk5/pVsOoig38r/i0Ast5g1uXaepSAu2KFTScwLPH0+fa5SHwWScMq242cf9ByG1cgFit5PVXsy5k26khBZy/5EZIguoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688892; c=relaxed/simple;
	bh=RIQieOyKvsoHB1jjFmzJVT8wCbZkwA7yJHtop2ZhiMI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nLLak/DvIZf8mzvjJ1T9hdROHQ47ye0XilAcusYNOsawiti4AA5lnykLo9aQjJjKwsUQ6sF5nU7FsqlttShAU11uLvWL9+LZVE2VulPKxZXbA77JzHM2dgiNJOGToUzdn2aS3rS/zZJkokUZlLvjch5jCoEMUeIpgVD76yJeXhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=m0rVmxmq; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="m0rVmxmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; bh=Z2H2IwwIt
	P1S4NpryZcWz4oeis1Hl/KZkpii41lh6E4=; b=m0rVmxmqBu3KJSL49YtCgoHfB
	eE03/BrpGqpxhoDayQcVTAPqJgoorycEIanOUHPxD+CVE0I8DMDnJ7vpLr95QyzD
	LbAlOlGvrMw4LmsU++vp+r5BiMjqzxKWOJbRjEvRUKXX7XqU41mQewNV6q0BoZky
	Yi5EQ1xfNgyQEpZvqU=
Received: from smtpclient.apple (unknown [121.229.84.192])
	by web1 (Coremail) with SMTP id yAQGZQBH6MfdMGBqTyVXAA--.53622S2;
	Wed, 22 Jul 2026 10:54:22 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net] ipv4: require matching source address for route hint
 reuse
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260720121629.GA2309447@shredder>
Date: Wed, 22 Jul 2026 10:54:13 +0800
Cc: pabeni@redhat.com,
 netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org,
 Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
 Ao Wang <wangao@seu.edu.cn>,
 Xuewei Feng <fengxw06@126.com>,
 Qi Li <qli01@tsinghua.edu.cn>,
 Ke Xu <xuke@tsinghua.edu.cn>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <87514BE5-D9D1-4756-9A39-311A5E988078@mails.tsinghua.edu.cn>
References: <20260714122618.21698-1-zhaoyz24@mails.tsinghua.edu.cn>
 <20260720121629.GA2309447@shredder>
To: Ido Schimmel <idosch@nvidia.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CM-TRANSID:yAQGZQBH6MfdMGBqTyVXAA--.53622S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWxKryfAw1rZr4xGw43GFg_yoW5Zw48p3
	4fKa45K3y0vr4UCr1kJa17AF97Z3ykKryrJrn8Ga9I9rs8t34jkF4UKrW3Cw47Cry8Gw40
	vr4Yv3srAF9avaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl
	84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0x
	vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
	GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
	CS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkI
	ecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUswIDDUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEQAWpf8TNE9gABsV

Hi Ido,

Thanks for your review.

> On Jul 20, 2026, at 20:16, Ido Schimmel <idosch@nvidia.com> wrote:
>=20
> On Tue, Jul 14, 2026 at 08:26:17PM +0800, Yizhou Zhao wrote:
>> IPv4 list receive can reuse a route from the previous skb in the same
>> receive batch. The current eligibility check only compares the =
destination
>> address and TOS before calling ip_route_use_hint().
>>=20
>> For forwarded routes, ip_route_use_hint() skips fib_validate_source()
>> unless the hinted route is local. This means a packet with a =
different
>> source address can reuse a forwarding dst created for an earlier =
packet
>> and avoid source validation such as strict rp_filter.
>=20
> I'm not sure why we are skipping source validation for non-local =
routes.
>=20
> The comment above ip_route_use_hint() says "Implements all the
> saddr-related checks as ip_route_input_slow()". I agree that
> ip_route_input_slow() only does source validation for RTN_LOCAL, but =
for
> RTN_UNICAST it is calling ip_mkroute_input(), which eventually calls
> fib_validate_source().
>=20
> Paolo, WDYT about always performing source validation [1]?
>=20
>>=20
>> In a KASAN QEMU router with strict rp_filter on the ingress device, a
>=20
> Why mention KASAN? How is it related to this bug / patch?

The KASAN mention was only intended to describe the test kernel, but I
agree that it is not relevant to the issue itself and should be removed.

>=20
>> bad-only burst was dropped entirely, however, a paired valid/bad =
burst=20
>> with the same destination/TOS made all of the bad packets pass =
rp_filter.
>>=20
>> Require the source address to match before reusing the hint. Packets =
from
>> the same source/destination/TOS still take the fast path; packets =
whose
>> source changes go through the normal route lookup and source =
validation
>> path.
>=20
> I agree that it fixes the problem, but we will always pay the
> performance penalty, even when rp_filter is disabled. According to
> commit 02b24941619f ("ipv4: use dst hint for ipv4 list receive"), =
there
> is still a performance gain when we perform the source validation
> per-packet.
>=20
> [1]
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3f3de5164d6e..89338111793b 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2194,6 +2194,7 @@ ip_route_use_hint(struct sk_buff *skb, __be32 =
daddr, __be32 saddr,
> struct rtable *rt =3D skb_rtable(hint);
> struct net *net =3D dev_net(dev);
> u32 tag =3D 0;
> + int oif =3D 0;
>=20
> if (!in_dev)
> return reason;
> @@ -2214,14 +2215,13 @@ ip_route_use_hint(struct sk_buff *skb, __be32 =
daddr, __be32 saddr,
> }
>=20
> if (!(rt->rt_flags & RTCF_LOCAL))
> - goto skip_validate_source;
> + oif =3D dst_dev_rcu(&rt->dst)->ifindex;
>=20
> - reason =3D fib_validate_source_reason(skb, saddr, daddr, dscp, 0, =
dev,
> + reason =3D fib_validate_source_reason(skb, saddr, daddr, dscp, oif, =
dev,
>    in_dev, &tag);
> if (reason)
> goto martian_source;
>=20
> -skip_validate_source:
> skb_dst_copy(skb, hint);
> return SKB_NOT_DROPPED_YET;

The approach in [1] looks better to me. It appears to make the hint path
consistent with the source validation performed by __mkroute_input(),
while still allowing the route hint to be reused.

I'll wait for Paolo=E2=80=99s comments before preparing a v2.

Thanks,
Yizhou

