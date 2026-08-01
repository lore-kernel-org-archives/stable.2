Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D71C69D;
	Sat,  1 Aug 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567424; cv=none; b=S9P33yOIxF9r4atYlKe4octhpUbJZ5/R+DKibBAEa0W5QB0KbStWQWuOBqxKAN5qzKSZAqC0dwFMsesI/jwgm2pTHFOJDvFdOTB64t22CzWNapu0KD2unTke7QjreHTCCh7waN1fOAsbuVt4oPR/giwmx2C/fuUaPmJS/HcLPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567424; c=relaxed/simple;
	bh=F+BilUocuxi0JNb46ZqOJ+lA2P7SnmzVpiojai9cuTw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PqxEjFT/TK0GQJ9jAqFdl/kn0116dSVUDKjpMFjo+7s92/7lGSLMk2nbclgidNydJB+dLbukOhLhK5mc59OmuG2O7m1KpIEjPZj3uQYmRdI5ILOBTpLzDmLAZsLRB4t4m5asyLggfOTOP9+ttW+ernkFeCUwF9AOQzjd6OVdRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=OS7Bizrk; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="OS7Bizrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; bh=oTtkQFC8Y
	ovmfFstiEd3u82C3Q7pgIcYvgndMBf2Itg=; b=OS7BizrkH2mgV6rgf9qaHJv24
	PzSPNeI8KLc9DajDXqPOy2vTxrl6mu6KwUrMljOzKnnqioFJeAUrPP7cbsLMw15N
	+hsgJjgroiOGK+ek9avU46ezTaUBlBSxaumXxcdOdQiM8DijG/Hk+H0Rjxv1FyT8
	qL5U19Uh8BaOaOfQR0=
Received: from smtpclient.apple (unknown [106.111.19.250])
	by web1 (Coremail) with SMTP id yAQGZQB3FMSnmG1qa6nnAA--.57075S2;
	Sat, 01 Aug 2026 14:56:40 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net] nexthop: account nexthop allocations to memcg
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260730003845.4166255-1-kuba@kernel.org>
Date: Sat, 1 Aug 2026 14:56:29 +0800
Cc: dsahern@kernel.org,
 idosch@nvidia.com,
 davem@davemloft.net,
 edumazet@google.com,
 pabeni@redhat.com,
 horms@kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn,
 wangao@seu.edu.cn,
 fengxw06@126.com,
 qli01@tsinghua.edu.cn,
 xuke@tsinghua.edu.cn,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C62F834F-2E10-423F-9A2D-F5454184237B@mails.tsinghua.edu.cn>
References: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
 <20260730003845.4166255-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CM-TRANSID:yAQGZQB3FMSnmG1qa6nnAA--.57075S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWkur4kWw47AF13Zr45Awb_yoWrXrWrpF
	Z5tas0yFsrJ34kZaykta1jga4Y9w48Kr9rCanak3yvvwn8Xr1FyFW7KF1jva9ruF4fC3WF
	vrWjqF1UGa1qk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0x
	vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
	GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
	CS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkI
	ecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUx0tCDUUUU
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQIGAWptIDRUrAAAsv

Hi Jakub,

Thank you for both reviews. This is the reply for the first one.

> On Jul 30, 2026, at 08:38, Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [1]: [PATCH net] nexthop: account nexthop allocations to =
memcg ---
> commit 186a5b6499e65039b5037906ec518baac2833b1d
> Author: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
>=20
>    nexthop: account nexthop allocations to memcg
>=20
>    The nexthop creation path allocates struct nexthop, struct nh_info,
>    group storage, resilient bucket tables, transient notifier tables =
and
>    per-group stats without memcg accounting. As a result, a task with
>    CAP_NET_ADMIN can create nexthops and resilient groups whose kernel
>    memory is not charged to the task's memory cgroup, so memory.max =
does
>    not constrain this part of the workload.
>=20
>> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>> index 44fe75004cacb..c8685c5835794 100644
>> --- a/net/ipv4/nexthop.c
>> +++ b/net/ipv4/nexthop.c
> [ ... ]
>> @@ -2943,7 +2945,7 @@ static struct nexthop *nexthop_create(struct =
net *net, struct nh_config *cfg,
>> if (!nh)
>> return ERR_PTR(-ENOMEM);
>>=20
>> - nhi =3D kzalloc_obj(*nhi);
>> + nhi =3D kzalloc_obj(*nhi, GFP_KERNEL_ACCOUNT);
>=20
> [Severity: High]
> This is a pre-existing issue, but does this patch miss some per-CPU
> allocations in the nexthop creation path?

Yes. I confirmed that the original patch misses these allocations.

With only the persistent nexthop objects accounted, IPv4 and IPv6 =
nexthop
creation can still allocate nhc_pcpu_rth_output and rt6i_pcpu without =
memcg
accounting, so memory.max does not constrain that memory.

We will fix this in the next revision by passing GFP_KERNEL_ACCOUNT =
through
fib_nh_init() and fib6_nh_init() for persistent nexthop creation, while
leaving regular route creation with GFP_KERNEL.

Please let me know if you would prefer a different split.

>=20
> When creating IPv4 and IPv6 nexthops, nh_create_ipv6() and =
fib_nh_init()
> explicitly pass GFP_KERNEL without __GFP_ACCOUNT down to the =
initialization
> functions:
>=20
> net/ipv4/nexthop.c:nh_create_ipv6() {
>    ...
>    err =3D fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL, extack);
>    ...
> }
>=20
> This results in unaccounted per-CPU allocations:
>=20
> net/ipv6/route.c:fib6_nh_init() {
>    ...
>    fib6_nh->rt6i_pcpu =3D alloc_percpu_gfp(struct rt6_info *, =
gfp_flags);
>    ...
> }
>=20
> A similar missing accounting happens for IPv4 in fib_nh_common_init():
>=20
> net/ipv4/fib_semantics.c:fib_nh_common_init() {
>    ...
>    nhc->nhc_pcpu_rth_output =3D alloc_percpu_gfp(struct rtable __rcu =
*,
>                                                gfp_flags);
>    ...
> }
>=20
> Could an unprivileged user with CAP_NET_ADMIN still bypass memcg =
limits by
> exhausting memory through these per-CPU allocations?
>=20

Yes. I confirmed this in the QEMU/KVM Docker reproduction.

>=20
> [Severity: High]
> This is a pre-existing issue, but do we also need to account for =
Lightweight
> Tunnel (LWT) state allocations?
>=20
> During nexthop creation with encapsulation attributes, =
fib_nh_common_init()
> triggers LWT state allocation:
>=20
> net/ipv4/fib_semantics.c:fib_nh_common_init() {
>    ...
>    err =3D lwtunnel_build_state(net, encap_type, encap,
>                               nhc->nhc_family, cfg, &lwtstate,
>                               extack);
>    ...
> }
>=20
> The allocation unconditionally uses GFP_ATOMIC without __GFP_ACCOUNT:
>=20
> net/core/lwtunnel.c:lwtunnel_state_alloc() {
>    ...
>    lws =3D kzalloc(sizeof(*lws) + encap_len, GFP_ATOMIC);
>    ...
> }
>=20
> Could a task in a container bypass memory.max limits by creating many =
nexthops
> with encapsulation attributes?

Yes. I reproduced this with an SRv6 NHA_ENCAP nexthop workload in a
QEMU/KVM guest running Docker with memory.max=3D128M.

>=20
>> if (!nhi) {
>> kfree(nh);
>> return ERR_PTR(-ENOMEM);

Regards,
Yizhou

