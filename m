Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792457003;
	b=Ie2bEDEmNgbsI7iDj0DRKOjhcZgCkR6CMesiAsr2ZU5kbGBdRawCTU36QKbCEvtPgEoc
	 G/6rTiUnLPHJbMkqPoHG55OZGHw8Td6XpFhwuaMJ3ONkuryr5aABxAjVbqwx3mvl+rXf/
	 obBS1zrruY1CgxJpk0IKWKgNtesMZodXmB3DO0T3+RDcIZgw/rudvp5Zu6/ly8VOF45kF
	 fYlhdkHu0sbuaSlzuyvvpFydWwKbsjIUQ0DvsZ8u4MeD1ZKKdDLTRlNv9cBzWmT+hYuvh
	 bOj0o1YoCBQ1WVS0TsA/UgecW0rua2S/dntIHOItI6cQ5TD4aDG0Uh8TwmABmSVHFQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792457003;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f4ZdPaHrQW6w9mgMz6+ac4it4iyaDjTjOK6psKUBxIk=;
	b=GOMdSC7LVRFEW9wGtKG+GQjC/XgZEJKGb5oHYLeLxcpEbaMqHOhdbVigjQImycwusuIp
	 ullFJf2GrwLbHPzlaLiyweSAHKEprAx8U5/KkUjTGhSZgO94xASaVXwsl3rlzIVSYrLML
	 Qfws+6DIy4xQxeqfaBp2wcW2t5mUFf+eIcXUZyH5xn/CyepytCqwjAhfmoulig/hE+ubd
	 g5XsWsxgcHiW/tDoJijzxFjx0xKGjsYJafpsvs9Z2S4NdPQ308xsPCV4dfTHnZGIo/w1i
	 9HUFU0hGhvxTK714CTEUj1SIg0Nr49SbLbF2Wl3urXVD7bWhL3i74e2xmHQgAl+ozpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AU0JOoKa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B9606A31F
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AU0JOoKa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D391F000D0
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792457002;
	bh=f4ZdPaHrQW6w9mgMz6+ac4it4iyaDjTjOK6psKUBxIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AU0JOoKaq7nzA+pLcOPR1wjiSLeTxt/51qv3AI/sFJpHZDbCw53jHvO8Yan67gXpq
	 uxibzw9bD2Sd4dCEmYphGe6YVDBR0niQzlSGi0M+CX6SZ7MifLTKIsXXW79i5zSImR
	 BrwAdqbAHEzSRLpeD20s0L59TpaU/BObRagL05aljpJ1PnVKovI5dSqZ8Ks4RX0o89
	 UQUGKKfChmiPITDbOWnDB8vuYfe8JiVlQbSYn1miwcbpdbAmqFmS76egf53GLk5URK
	 sBLsi+rurl/ZLSc+prlE0lj1+6vaeB0RYxs91DecRqYy2O5IqbTFApDAF1n4O/qH+Y
	 f152jgG5W0Ndg==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93e55db58cfso227348485a.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:43:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGAno0+NEhnzJtz/lmiO0PLfzL73msEJbPDO+49aVTcSQoT829dxXOnPOdEl9V+oTAxmKvGjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL997LfkTcj96fW5ukCTG6QysAgtyhvTriksHn21CQSUZX5Kj3t
	EjtLrOgjSd+w8crQRl93uyN+pKAphlHKM+wiOb0l2p8liZs2tFV0wI5zcQTifKeXirWb9LUYQGC
	qYmaYCIDFzIMzSkoHioPj2gKJPwgD8Cc=
X-Received: by 2002:a05:620a:2989:b0:937:6de8:b40 with SMTP id
 af79cd13be357-93f29ceec65mr1607493085a.15.1792457001621; Mon, 19 Oct 2026
 17:43:21 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
 <20261017050928.128582-2-sidchintamaneni@gmail.com> <CAGsJ_4wGq9oc05=-g4aWptLdCbTwUjMjXk4Rd6KjJ6x=tzMm+g@mail.gmail.com>
 <CAE5sdEhGFtGF6LC4xNkMwGj3vTxLOW=GNBXnk3-JmsgjntXx0Q@mail.gmail.com>
 <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com> <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com>
In-Reply-To: <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Oct 2026 08:43:10 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com>
X-Gm-Features: AclHuK_z9u93TiyYoAZaSFwx9j8LW96gLUQ2eqyJQLstVMCqEWfGNy3WkacpWX0
Message-ID: <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 8:16=E2=80=AFAM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Mon, 19 Oct 2026 at 16:36, Barry Song <baohua@kernel.org> wrote:
> >
> > On Tue, Oct 20, 2026 at 4:33=E2=80=AFAM Siddharth Chintamaneni
> > <sidchintamaneni@gmail.com> wrote:
> > >
> > > On Sun, 18 Oct 2026 at 14:24, Barry Song <baohua@kernel.org> wrote:
> > > >
> > > > On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
> > > > <sidchintamaneni@gmail.com> wrote:
> > > > >
> > > > > Andrew Morton reported that get_lruvec() has the same problem as
> > > > > lru_gen_shrink_node(): when memcg is disabled on the command line
> > > > > (cgroup_disable=3Dmemory), it returns &pgdat->__lruvec directly a=
nd so
> > > > > bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
> > > > > interface calls get_lruvec(), then dereferences the pgdat pointer=
 in
> > > > > lru_gen_seq_show() and other paths, so these can hit the same NUL=
L
> > > > > dereference.
> > > >
> > > > So userspace must have booted, since otherwise we couldn't read
> > > > debugfs. The reachable case is therefore a memory node with no
> > > > LRU folios when debugfs is read? So this could happen on a multi-no=
de
> > > > system where folios are landed on other nodes but not on this node?
> > > >
> > >
> > > That is my high level understanding. I'll let Andrew to comment if I
> > > am missing something,
> > >
> >
> > I made a silly toy setup by running two numa nodes with one of them has=
 only 4KB
> > memory, the other one has 1G-4K:
> >
> > qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53 -=
nographic \
> > -smp 4 \
> > -m 1G \
> > -object memory-backend-ram,id=3Dram0,size=3D1048572K \
> > -object memory-backend-ram,id=3Dram1,size=3D4K \
> > -numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
> > -numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
> >   -kernel arch/arm64/boot/Image \
> >  -nographic -append "cgroup_disable=3Dmemory
> > ...
> >
> > Then I got a machine where node1 is very difficult to have a page in lr=
u.
> >
> > then i ran the debugfs for mglru:
> >
> > / # cat /sys/kernel/debug/lru_gen
> > memcg 0
> >  node     0
> >           0      14972          0         953
> >           1      14972          0           1
> >           2      14972         18        3308
> >           3      14972          0           0
> >  node     1
> >           0      14972          0           0
> >           1      14972          0           0
> >           2      14972          0           0
> >           3      14972          0           0
> >
> > now you see node 1 has no page in lru but yet i didn't have any crash.
> >
> > i think i will need more time to figure out what is the problem and how=
 to
> > reproduce it.
>
> I've asked AI to repro the issue with the similar setup
>
> qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53 -no=
graphic \
>   -smp 4 -m 1G \
>   -object memory-backend-ram,id=3Dram0,size=3D1048512K \
>   -object memory-backend-ram,id=3Dram1,size=3D64K \
>   -numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
>   -numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
>   -kernel "$KERNEL" \
>   -initrd "$INITRD" \
>   -no-reboot \
>   -append "console=3DttyAMA0 cgroup_disable=3Dmemory
> initcall_blacklist=3Dkswapd_init panic=3D-1"
>
> and it was able to repo it. AI identified that kswapd is initializing
> the pgdat during boot, so blacklisting kswap_init was able to repro
> the crash when reading /sys/kernel/debug/lru_gen

Thanks!
I guess you mean the following:

-module_init(kswapd_init)
+//module_init(kswapd_init)

Yes, I can reproduce it with the above as well.

But kswapd_init() is definitely called before we enter userspace,
so this doesn't seem to be an issue here?

So I feel there is no bug here, but this cleanup is still welcome.
Am I missing any other scenarios?

Best Regards
Barry
