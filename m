Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452961;
	b=VigB0IaAKa0aJrsXGkz8RfhIcVmVcBXdSDixXsjmSry2LWmNL1QhHr1EXaPBJnKo/WEe
	 jG/CUiaFGEFV+7msPLUwCH8jWFm1gxIFk7B5UQa9MqmaJrSbY23DlQTdNO3sBI/jloYwG
	 omyAxzyB+2eDfzsmztmB7UC3Xc5d/4aI7U20ukEkD1Crp9IyAKgcrG839Yizj6k5UVuD7
	 F4TltuOQN2tHbyornutXKCnp4bQlVQB7KDIM0rBI6J708yYsguIeTqqsPxiR61sHSUUxr
	 Tc9HbjGPC+CcSMVlKJHX9Qv5aTnbdw7hhYOiFSXEbU6ZL0Wwq0pa7Ovc4ARSiWpzAew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452961;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FhKtU5w8GBj/yeJDEwS7da8UC+5x8nc458iXyjzet9g=;
	b=s8R2jtO6+9YZffqaHQaUcxNyfOy5Ey7CUMLR6TBlOv36W7O13sF+1HntuMc7Iqs2T9hL
	 Mck+11tiitZ2L+6SnEJz+oYhrFJ4nuDpkxf5ABju++tIF3EXQj/LhKrPKjp9MDU/wJDp7
	 egxE5MnhokTk+8rTmP9ly3g/wJngYktP19EVynJ6coKQwyXYQ14Xwc+6AKLRDRT5X9QvC
	 2phU+0nCHwAYKoX5hvSwUbKVLaD5uXbYzYKcZc+qqiONzbaNNJOtTUfUZs0ILPfk4zMny
	 dncM/7oHHiNPy3K19d+NMWnypAJCHLMYq+mUVmk4GjSaBk1V9RoBdS6ySug80lnQBDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNXTSu92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C9606A324
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNXTSu92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B189D1F000C9
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 23:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792452960;
	bh=FhKtU5w8GBj/yeJDEwS7da8UC+5x8nc458iXyjzet9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gNXTSu92jBmXmdxQAiSfPljfEV05rK6BJ3RpiKEQ8XRwVUwxD47Iy2yQpmQPI8rGr
	 a0tfbEe44MYi5/6ImPwdDhvNth6OoSa8+tru3+d3uAeRTNUfHBgvnUj7jcYiCw5ccj
	 jNytduKQoMz+o9r04sXSCNlimT5Yd7+Ze3Gh3NqdOyr4c4rVoU3yt5Dbbn2vsNyxN6
	 H8pLOjIDJmJ6lw+sROT8F8pILSFhRFf9UebtFlcF5gJI15Ah91X5Bg+z/MUPLLGrsi
	 GQG1m9eRlWKo8K/1Mk1gF75G7n5exymRzJYA//sgauhgH16Zd6jXZd3I1NW5IJzPoW
	 M4qt/rrJoq/BA==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e515769d3so246084385a.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:36:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwW0dFOEw6xpLssXGgrN+yVyj5YRfEPocXWeiDslnMCZW3bGc7hRHCxYQwIQMi6+ypitU9OIwQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHtyw679OEv8oBGph4T++xQGSFpM2R/qhMW66m0A2qz34nZxoN
	uKlCL/JR7OjfHcs1XSk9NXlZwYpoP6GdGknwAeKUUk0rh2S5JQ6x5zKX8u3TWC+jmuQ79AnhZg2
	iha64EEmz7dtOX4/bKd8jE/CYdYcfhdY=
X-Received: by 2002:a05:620a:4552:b0:93f:3829:8494 with SMTP id
 af79cd13be357-93f38298718mr932075885a.31.1792452959559; Mon, 19 Oct 2026
 16:35:59 -0700 (PDT)
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
In-Reply-To: <CAE5sdEhGFtGF6LC4xNkMwGj3vTxLOW=GNBXnk3-JmsgjntXx0Q@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Oct 2026 07:35:48 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
X-Gm-Features: AclHuK_aaDmiOoPjOifUmGBKmvM4s-x70UIqD7plw7aV8rDhARGqcnWCGr0bz_Q
Message-ID: <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 4:33=E2=80=AFAM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> On Sun, 18 Oct 2026 at 14:24, Barry Song <baohua@kernel.org> wrote:
> >
> > On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
> > <sidchintamaneni@gmail.com> wrote:
> > >
> > > Andrew Morton reported that get_lruvec() has the same problem as
> > > lru_gen_shrink_node(): when memcg is disabled on the command line
> > > (cgroup_disable=3Dmemory), it returns &pgdat->__lruvec directly and s=
o
> > > bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
> > > interface calls get_lruvec(), then dereferences the pgdat pointer in
> > > lru_gen_seq_show() and other paths, so these can hit the same NULL
> > > dereference.
> >
> > So userspace must have booted, since otherwise we couldn't read
> > debugfs. The reachable case is therefore a memory node with no
> > LRU folios when debugfs is read? So this could happen on a multi-node
> > system where folios are landed on other nodes but not on this node?
> >
>
> That is my high level understanding. I'll let Andrew to comment if I
> am missing something,
>

I made a silly toy setup by running two numa nodes with one of them has onl=
y 4KB
memory, the other one has 1G-4K:

qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53 -nogr=
aphic \
-smp 4 \
-m 1G \
-object memory-backend-ram,id=3Dram0,size=3D1048572K \
-object memory-backend-ram,id=3Dram1,size=3D4K \
-numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
-numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
  -kernel arch/arm64/boot/Image \
 -nographic -append "cgroup_disable=3Dmemory
...

Then I got a machine where node1 is very difficult to have a page in lru.

then i ran the debugfs for mglru:

/ # cat /sys/kernel/debug/lru_gen
memcg 0
 node     0
          0      14972          0         953
          1      14972          0           1
          2      14972         18        3308
          3      14972          0           0
 node     1
          0      14972          0           0
          1      14972          0           0
          2      14972          0           0
          3      14972          0           0

now you see node 1 has no page in lru but yet i didn't have any crash.

i think i will need more time to figure out what is the problem and how to
reproduce it.
