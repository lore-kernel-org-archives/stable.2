Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008923672AF
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281836; cv=none; b=o4T8PEVFHs5ak8ilMHhD0HV8qodBY8DdVMc/dizvl8C6G9MV28vJM2H8/2qCOrPckbdZ9Leg5aNPgJMQOfKtjx8iA/v5wBj1fAb+U7m/MWkGhWmXVFB+lcMMaoMYwKrC0TUgliFpKl3RPS7GYB5EzRxuoDJnpV3l98a2LExRt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281836; c=relaxed/simple;
	bh=rbbFooIRGOGTXmw5EUqaW6a1PcTS9yrcKzLrdDqu8U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKZbmoEwfvQ6zt+ixvbHMuiebcoHTW95xa6LIWmdj2nEqim31L6l8Bfv7JR9hJXuaZWg8sTCBlgyWEQ51CZWhX3J//tv7TZZYPn6gnUjRJ46lBd+b2Lju9wnzGtLgEqt8t1shSGGe/kw6eu23BaC3YKESgg9YXb0kWw1dWnqGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjqGp+H/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjqGp+H/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C961F008A4
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791281834;
	bh=YmX2e33OtnyC8Zxmc6TiwfeqHnZc+9E9szDbs6SS/Jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fjqGp+H/NMcqXRHqNX9hJ3U35OYZBK3lYTsNnTk6HmQRjMFfWv3vREk7IE+ji51tF
	 7ju8O2LAm3gLX4Chsgtp5ysz7IXw0HHhb1cbLG3Bb8+WuObBfvZjKeQ1mQLe6zzR2f
	 ge/bW5cX6muyHXBfKAYhnc8ld1nchS5ZdbZPvCngcoTevDThcJbMP8EODgFPWxCs6L
	 bGoC+nYKYERj79Fnh/mv9F+HujyGExO/Ln4I2EyUmomS7GMUT38QAytv4HKuFv71B6
	 R2Y8HGxk5ve22a6MhgmohQJUAIoKRHuEN2wXir6uP46pKYbYlUTYECu0Qo7OtwaR6y
	 dSAU4kzLpVLwQ==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93a40a9a01aso191247885a.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 03:17:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwSaOFqHz5toNZ+HFU0fxuu5BatjcOL7dnFFlDTjo737gSGlf5DKWfm/4ggwnKL+bMLJDZRccg=@vger.kernel.org
X-Gm-Message-State: AFuF++lRcE9ofWOxyfrATm5CZ9aKLme1/YhPHjzc/0KwXzszR47uqNXI
	c4UB5ImQJsvtdXKZ276HKJAIJoffAcEMz/8FSdY/gKC+OJikALHtypZWfogTeziirQQ/yELnJWU
	pupE8cjIeG9tyXEpSFyHC8uFRb7beOWI=
X-Received: by 2002:a05:620a:298c:b0:93e:60b7:eb1c with SMTP id
 af79cd13be357-93e8f30e9bemr133098185a.8.1791281833664; Tue, 06 Oct 2026
 03:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005062236.564210-1-vernon2gm@gmail.com> <CAGsJ_4yKSoCwcEDhtd=biKoUjUX9eTJJhFJGFAZWc=WsAyXycg@mail.gmail.com>
 <4cdb95f5-4140-4116-8247-c04f4b2a5c4c@gmail.com>
In-Reply-To: <4cdb95f5-4140-4116-8247-c04f4b2a5c4c@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 6 Oct 2026 18:17:02 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4x3n1g1tqxFnnLj8mS46fyYNWQq6goqop+_2QoKO09eeA@mail.gmail.com>
X-Gm-Features: AclHuK8lN8z7X7d6APZTpemSkGo0Ao6gHmfTzep6EKwyapPzIeCYDccx1RXySzg
Message-ID: <CAGsJ_4x3n1g1tqxFnnLj8mS46fyYNWQq6goqop+_2QoKO09eeA@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: don't count per-node proactive reclaim as
 memory pressure
To: Vernon Yang <vernon2gm@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev, 
	hannes@cmpxchg.org, mhocko@kernel.org, ljs@kernel.org, 
	roman.gushchin@linux.dev, dave@stgolabs.net, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vernon Yang <yanglincheng@kylinos.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 6:21=E2=80=AFPM Vernon Yang <vernon2gm@gmail.com> wr=
ote:
>
> On Mon, Oct 05, 2026 at 02:30:36PM +0800, Barry Song wrote:
> > On Mon, Oct 5, 2026 at 2:23=E2=80=AFPM Vernon Yang <vernon2gm@gmail.com=
> wrote:
> > >
> > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > >
> > > When the cgroup has no memory pressure at all, writing to
> > > /sys/devices/system/nodeX/reclaim triggers proactive reclaim on
> > > NUMA node, causing increase in the writer cgroup's memory PSI.
> > >
> > > Due to this reclaim is performed in the context of the write(),
> > > accounted as memory pressure on the writer, like
> > > commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting recla=
im
> > > as memory pressure"). This is unexpected, the phenomenon resembling
> > > senpai will appear again.
> > >
> > > The Documentation/ABI/stable/sysfs-devices-node documentation also
> > > notes that "This interface is equivalent to the memcg variant."
> > >
> > > This patch unifies the semantics of the memcg and node interfaces:
> > > per-node proactive reclaim is no longer counted as memory pressure,
> > > and the per-node proactive reclaim interface no longer produces
> > > phantom pressure.
> > >
> > > I ran demo[1] that performs per-node proactive reclaim 10000 times
> > > in qemu, writer cgroup memory.pressure as follows:
> > >
> > > without patch:
> > >
> > > some avg10=3D31.53 avg60=3D13.42 avg300=3D3.31 total=3D10602985
> > > full avg10=3D31.53 avg60=3D13.42 avg300=3D3.31 total=3D10602985
> > >
> > > with patch:
> > >
> > > some avg10=3D9.59 avg60=3D3.41 avg300=3D0.81 total=3D2686221
> > > full avg10=3D9.59 avg60=3D3.41 avg300=3D0.81 total=3D2686221
> > >
> > > [1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_nod=
e_psi
> > >
> > > Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interf=
ace")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> > > ---
> >
> > This seems to be a valid concern. Personally, I don't like
> > having the code depend on whether `__node_reclaim()` and
> > `node_reclaim()` are called from proactive reclaim or page
> > allocation.
> >
> > Can't we check whether `sc->proactive` is true? Am I missing
> > something?
>
> It is also fine to directly check `sc->proactive` in __node_reclaim().
>
> I chose the current coding because a previous similar fix commit
> e22c6ed90aa9 was written this way, and it is also very clear.
>
> Of course, it depends on everyone's preference. If everyone prefers to
> directly check `sc->proactive`, please let me know clearly. Thanks!

I personally think the following is much more explicit than the
current implicit code based on path dependency. no?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6a931b576b7d..048ba11852fe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7997,7 +7997,8 @@ static unsigned long __node_reclaim(struct
pglist_data *pgdat,
                                           sc->gfp_mask);

        cond_resched();
-       psi_memstall_enter(&pflags);
+       if (!sc->proactive)
+               psi_memstall_enter(&pflags);
        delayacct_freepages_start();
        fs_reclaim_acquire(sc->gfp_mask);
        /*
@@ -8014,7 +8015,8 @@ static unsigned long __node_reclaim(struct
pglist_data *pgdat,
        memalloc_noreclaim_restore(noreclaim_flag);
        fs_reclaim_release(sc->gfp_mask);
        delayacct_freepages_end();
-       psi_memstall_leave(&pflags);
+       if (!sc->proactive)
+               psi_memstall_leave(&pflags);

        trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed, NULL);

>
> --
> Cheers,
> Vernon
