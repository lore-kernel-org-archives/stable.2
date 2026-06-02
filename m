Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2F3D45FE
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393631; cv=none; b=Y2jsR683Pwd6WaW5eYkpm98lFjjyAMlsesoWWuxNqlomEUaoH2WDYoN/Zc0i7FhzEudK3+frKGWgJQm1HWE4qlC4vaBUO6q5lXIxfIGl9axwiJp8VHg/g1wpJ8YlF/JpjeE6GZYjVrw+/DIXNkTrDol4xMNVPpVcXGmY+W/c438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393631; c=relaxed/simple;
	bh=GH+I9RsdgTE0OHCyZhbjj1jnDfvIU8wsj/dmNuKaUik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC3hMjlURevt5OOkiczSwcqE/77siNb2lC/snM0p6HF50X6T7jFDLp8BP92O9yo2HlMoH78CP1P/yJEOOoi7/bgr89fnn4ahGSIoOUSnIJX0G0nke7vxbZxsP+WwiJX+CeEMayTcz0qRFa7W+QawJclYpNaZsyiIbh0XN+voJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCPMbLBN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCPMbLBN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso22202755e9.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780393629; x=1780998429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwsVWUXBBycIdE/ihGu428I0auaTKDjLFd3QwYVOS/Y=;
        b=XCPMbLBN/aiL5UzjeAZ5SxMnzjYDorlpHiZ040eFaOnQewYh3S2sj8+R7hJ9FCBQ63
         HDYqUPDb08TXuBeU3Fv8s5awpntIaj4W3iD91nwtSbTtSoobPsdmfq3j1Qi14PId6etH
         BUySj8pjuySeDbu5mDA92ac3baYqpxI420pk2m7RD5gvDN4wzF/tgrpIM61jgFHW3Miu
         CCk5rwFe148YaKtlGSOx136hT9W3QO8WSHpP/vEmfdAbjGkU9bbldNA0hykPg7fafilN
         w4smA3ulkSDCFINcTUTCCHVZLqBA3bh6wuLX2BZVj86E+fQrgiBRh9IbZ3THEaAYhiZ4
         NccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780393629; x=1780998429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwsVWUXBBycIdE/ihGu428I0auaTKDjLFd3QwYVOS/Y=;
        b=j+E4DELu6ER5lgAiysHawNeClAp/ND7RyKSsVnWzis/0X3cu9oq0U5gKR+Dlixy9gs
         n7+j/M7EZ+wZDNzWhcfHostdm6Yl4pN0Pi2z7sSy/YntHQa4CV2945BstIy4y8ipaJSG
         0gZAyxSCGFgDbOjJfwA30o+EBZv/S4KGDG5+ZWY0VRD9oUbyXbjuMSaKij6mTDwQJZKz
         a5q+iXsBstvaOCLoSZi3VgiqWTWV0EKYoQ86UXzmq3tZuR6NySS1MHdxYatOsD6Bila/
         KdmThii/4WUk912oBSbpZowjyhyr1tOXvg8ejCqVdgW9hhiRjsgs6jEaDhULJEsPEz7k
         J2WQ==
X-Forwarded-Encrypted: i=1; AFNElJ+25A9bUGYkzQDHVZiVrYr4hHvLmmXhWoCAyJYkhZHSmy2t/AACxi84EQz7/NOd8ux0vu6yWlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbT5yfjje+dXmA8tVB9yYensSt6NmBBHoMguaGzJGHe4d8A8bN
	lEMesf5Kbd9mtcjxjXL+AqTG7PuSY3X22kjoPLtVOK9qbfLvcjNqjb95
X-Gm-Gg: Acq92OG3WVl1LrAjdCWw6qCwkQFIKUqdJFFOFm28kIPKWquIaTXs3qHCJScbwA2jkgF
	umIacm/wQGyYJ8J69m0eKIr4hw+hCznzB0Nm3pIxiIycrlIbVHsJGGaTMb8iIfizcbSSlNSGiQr
	zCLr9B+3XhNV7Rajj2RUsXgZcQvN9PvanioeyOmSI/C8DnwCWf0A36eAJmk4gPvNnzr53C1B8IH
	B9uNsaHSoPS+DjW/31Gq4PeNhpxL440xPAf3DZ/IAsx4m7VwDCmpGsMJN+RfsvK5tfZJlrCruWa
	6z0b1g1jhS6rkDHVuBGBXIQLMFYJtIxiUr+fjjlbtIoe6wRK6nmQko4VMRLND0hvpxMOwuErTrc
	6NMKzU1S2FzBYYNBPSNKxbuPsnpx9Qoz3ESF8FiPITQa0AXV3EzDpkPNUokoKkTirSe07FHKOAs
	gPBac2R2erPcVc8qiUa2McnGf9EoPAtEgSj6k+Eu9vWcQ2pxXWGgVkzzj1jvuHrOm+usz4IJPEY
	qd0T+85bw==
X-Received: by 2002:a05:600d:8654:10b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490a29121b8mr207121565e9.1.1780393628119;
        Tue, 02 Jun 2026 02:47:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b3cff37fsm2620125e9.16.2026.06.02.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:46:59 -0700 (PDT)
Date: Tue, 2 Jun 2026 10:46:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, davem@davemloft.net,
 dsahern@kernel.org, horms@kernel.org, idosch@nvidia.com,
 jianhao.xu@seu.edu.cn, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, runyu.xiao@seu.edu.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: use READ_ONCE() in ipv6_flowlabel_get()
Message-ID: <20260602104647.51ccadce@pumpkin>
In-Reply-To: <CANn89iJWcG6UH0ZqLnjRaCr0Ky6WeEYhj-pyeyrPf3oJcHU5KQ@mail.gmail.com>
References: <20260601223122.63c0d23f@pumpkin>
	<20260601231546.3407019-1-kuniyu@google.com>
	<20260602090034.7a5c243e@pumpkin>
	<CANn89iJWcG6UH0ZqLnjRaCr0Ky6WeEYhj-pyeyrPf3oJcHU5KQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jun 2026 01:10:49 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Tue, Jun 2, 2026 at 1:00=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Mon,  1 Jun 2026 23:14:44 +0000
> > Kuniyuki Iwashima <kuniyu@google.com> wrote:
> > =20
> > > From: David Laight <david.laight.linux@gmail.com>
> > > Date: Mon, 1 Jun 2026 22:31:22 +0100 =20
> > > > On Mon, 1 Jun 2026 05:36:37 -0700
> > > > Eric Dumazet <edumazet@google.com> wrote:
> > > > =20
> > > > > On Mon, Jun 1, 2026 at 5:22=E2=80=AFAM David Laight
> > > > > <david.laight.linux@gmail.com> wrote: =20
> > > > > >
> > > > > > On Sun, 31 May 2026 23:39:46 +0800
> > > > > > Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:
> > > > > > =20
> > > > > > > ipv6_flowlabel_get() still reads the shared per-net sysctl fi=
elds
> > > > > > > flowlabel_consistency and flowlabel_state_ranges with plain l=
oads,
> > > > > > > while writers update them through proc_dou8vec_minmax(). Thes=
e checks
> > > > > > > run in the live IPV6_FLOWLABEL_MGR path, so lockless plain re=
ads leave
> > > > > > > KCSAN-visible data races and can make the policy checks obser=
ve stale or
> > > > > > > inconsistent values.
> > > > > > >
> > > > > > > The race can be reached on a running system by toggling
> > > > > > > /proc/sys/net/ipv6/flowlabel_consistency and
> > > > > > > /proc/sys/net/ipv6/flowlabel_state_ranges while another task =
repeatedly
> > > > > > > issues IPV6_FLOWLABEL_MGR requests with IPV6_FL_F_REFLECT or a
> > > > > > > state-ranges flow label.
> > > > > > >
> > > > > > > This issue was first flagged by our static analysis tool whil=
e scanning
> > > > > > > lockless IPv6 sysctl readers, then manually audited on Linux =
v6.18.21.
> > > > > > > The IPV6_FLOWLABEL_MGR paths were runtime-reproduced with QEM=
U/KCSAN by
> > > > > > > concurrently flipping the two sysctls while TCP reflect and U=
DP
> > > > > > > state-ranges setsockopt actors exercised ipv6_flowlabel_get()=
. KCSAN
> > > > > > > reported races between proc_dou8vec_minmax() and the two plai=
n-load
> > > > > > > sites in ipv6_flowlabel_get().
> > > > > > >
> > > > > > > A narrower second-round UDPv6 + IPV6_AUTOFLOWLABEL send-side =
reproducer
> > > > > > > also hit the inline ip6_make_flowlabel() reader through
> > > > > > > __ip6_make_skb() / proc_dou8vec_minmax(), but that site is al=
ready
> > > > > > > fixed in this tree by commit ded139b59b5d
> > > > > > > ("ipv6: annotate data-races from ip6_make_flowlabel()"). The =
remaining
> > > > > > > plain readers in this tree are both in ipv6_flowlabel_get().
> > > > > > >
> > > > > > > Use READ_ONCE() for those remaining sysctl reads so they foll=
ow the same
> > > > > > > lockless reader contract already used by other IPv6 sysctl re=
aders.
> > > > > > >
> > > > > > > Build-tested by compiling net/ipv6/ip6_flowlabel.o on x86_64.
> > > > > > >
> > > > > > > Representative QEMU/KCSAN reports from the two target reader =
paths:
> > > > > > >
> > > > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_=
minmax
> > > > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > > > >   read:  ipv6_flowlabel_opt+0x6d8/0xd20
> > > > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > > > >          tcp_setsockopt+0x72/0xb0
> > > > > > >
> > > > > > >   BUG: KCSAN: data-race in ipv6_flowlabel_opt / proc_dou8vec_=
minmax
> > > > > > >   write: proc_dou8vec_minmax+0x206/0x220
> > > > > > >   read:  ipv6_flowlabel_opt+0x129/0xd20
> > > > > > >          do_ipv6_setsockopt+0x873/0x2220
> > > > > > >          udpv6_setsockopt+0x21/0x40
> > > > > > >
> > > > > > > Fixes: 6444f72b4b74 ("ipv6: add flowlabel_consistency sysctl")
> > > > > > > Fixes: 82a584b7cd36 ("ipv6: Flow label state ranges")
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > > > > > > ---
> > > > > > >  net/ipv6/ip6_flowlabel.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >A
> > > > > > > diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabe=
l.c
> > > > > > > index b1ccdf0dc646..1ab5ad0dcf24 100644
> > > > > > > --- a/net/ipv6/ip6_flowlabel.c
> > > > > > > +++ b/net/ipv6/ip6_flowlabel.c
> > > > > > > @@ -620,7 +620,7 @@ static int ipv6_flowlabel_get(struct sock=
 *sk, struct in6_flowlabel_req *freq,
> > > > > > >       int err;
> > > > > > >
> > > > > > >       if (freq->flr_flags & IPV6_FL_F_REFLECT) {
> > > > > > > -             if (net->ipv6.sysctl.flowlabel_consistency) {
> > > > > > > +             if (READ_ONCE(net->ipv6.sysctl.flowlabel_consis=
tency)) { =20
> > > > > >
> > > > > > That can't actually fix anything. =20
> > > > >
> > > > > It fixes a KCSAN splat.
> > > > >
> > > > > If you think you can fix KCSAN instead, please do so. =20
> >
> > ipv6.h has:
> >         u8 flowlabel_consistency;
> >
> > KCSAN probably shouldn't care about byte reads. =20
>=20
> KCSAN detects more than just load/store tearing. Here is a summary:
>=20
> Purpose: KCSAN identifies data races, which are a common source of
> correctness, stability,
> and security bugs in concurrent systems like the Linux kernel.

Ok, it can pick up CSE type issues as well.
But this one is still a false positive.

-- David

>=20
> Mechanism: It is a compiler-instrumentation-based tool. During
> compilation, special code is added to monitor memory accesses.
> At runtime, KCSAN detects when multiple threads access the same memory
> location without proper synchronization,
> and at least one of those accesses is a write.
>=20
> Operation: KCSAN performs its analysis at runtime, reporting data
> races that actually occur or nearly occur during code execution.
> While powerful and scalable across the entire kernel, this
> instrumentation can significantly slow down kernel execution.
>=20
> Impact: KCSAN has been instrumental in finding and fixing numerous
> concurrency bugs.
> For example, it has led to the addition of annotations like
> READ_ONCE() and WRITE_ONCE()
> in kernel code (e.g., in the TCP/IPv6 stack) to properly handle
> lockless reads and writes and resolve reported data races.
>=20
>=20
>=20
>=20
> > =20
> > > >
> > > > It is a false positive. =20
> > >
> > > It's not.
> > >
> > > =20
> > > > (Which I think you also said in a different email. =20
> > >
> > > I guess you meant this one ?
> > > https://lore.kernel.org/netdev/20260601074201.1186061-1-runyu.xiao@se=
u.edu.cn/
> > >
> > > This is different because, in addition to Eric's comment, IPv6
> > > address is 128-bit and data-race is inevitable without locking
> > > unless CPU supports native 128-bit read/write; we already do
> > > load/store-tearing of 128bit with u32/u64. =20
> >
> > But the code isn't looking at a 128bit value, it is only doing a check
> > for zero (and READ_ONCE() doesn't support 128bit values).
> > If there is no locking the value can change just before/after the test.
> > Even if it were subject to read/write tearing absolutely the worst that
> > could happen is a zero being detected when the value changes between
> > two non-zero values.
> > That isn't relevant here - it is just a boolean. =20
>=20
> It is completely relevant. If you disagree, please fix KCSAN.

