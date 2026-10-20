Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792458134;
	b=2kHQoYyJgZexk6tCgp/tDCETvH4iiPEjkvTdu3QRYBkELo0Vd/yJ4GqPL4JuH+zUEJ8x
	 HRU3p35Emk1zclmavye7d4/iWB8VMTxArF9MqgUrpjTXy+XdCJO7jbJ8w/q+5/rjJ63Bh
	 ecAA2nTLYQRp01fCvZDKtDuAU/jlbGLFAM0zp6IY3CsZkvUc1I+ke1zEEKPQcdrsdNyCQ
	 GTxZQ0UaRenrkTepe0Lx+TPeshmSE/MVWiPIQNxXVWkT1lXKYr/y01qh1yNt0ZDXzzG+h
	 qqqhufKb+v05UU8cMvNMyiK7GKUOoqC6uCKLSUdWjbR1WV9unBu1KWWMStrODnCQGxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=B/WVBOtkMP6M1xXLJUzfcGRzgTR4eIpAO+QQLGvxAdw=;
	b=4uqxUZN/sNOKcM7Iwt1A2tZ74PRN9usimnEQy0ZLH9Up5xz/Er+Y7XdiwLQpa6FxrZkq
	 bKD3lkRcYHZTx5Zu3a44ghusigtTFFDh4BYXREJzqRqDpKv04rdmJrNudZJd73zAwP+Ul
	 iwKb1e4j2rOpDmN1tuTLMhgPep6r7bAQv4uDKLe4oRL6RYyCp0A5Z4ENPMuARtWdcOpzI
	 t0Pc9kgfHytWeOLhZf2yrIko9li3l8GZUdSanekqs/dHGeCBqOvycZWTbbR6knBWWKI6M
	 w14t6jNR2RpuBu3axV248aMFlxV0K5Y8NnO84Ss7eMeWf3yAk+z/Xcz2b0XkUFWOeKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gH25syzu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A472606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A472606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gH25syzu
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b05bf699easo23151047b3.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792458133; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/ihBNhowgj86zcjuEeUBaXA/dhsGeSFIR1+yKigAefSSBU7/4BjkxHY0jSARMlFZy
         yxpbtHFDn20w1oLZUX0JiLP4/7IN90cHlS8WVebWsxxBqga2rXwddIpCEOkC527x42oT
         9z0UkDEuqUZtnzaupQ47ltZ/ueA91wqekijX2GPeStQyNs3NRRimm2B2QvZbxQxG97h4
         6v7ouEYvKqzOusRxM0yVXZMdd9257y7adnHWrpZTJ6QSAfhBUdxl2gjzbsZK+SryP3Ff
         BJjMhnjOrKro6mrG/XmH+6RIFkYzz15NE4XyjrCme/rDxLaFMYhMUVe764yb1Q9MOobr
         OKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B/WVBOtkMP6M1xXLJUzfcGRzgTR4eIpAO+QQLGvxAdw=;
        fh=+fHpGF7w5laBdWPpMDLUSU+dKensAn039aHXWInb34Y=;
        b=W6zu3rp3czQxQfndROsgaFw8gR76ZYQW0PIxlnG4/P+ry6I8ktvn0tGO6XyIJVUovl
         JhDe8z8JZ+VOfvY0876pdG8r8P2CPnTKwbjqHrZDPGVrTqx/EPWxL2iYOQyUuzrN6TcN
         F6QprR2XPtia9oHS9gkioxxqMm2hLJDzqSV11VaMTroNYxB4TBDc1/7tlowyIi2jkR+D
         CGLxhNaVgM1NOQ8r61mV6q1nRXLZu8vnbKR9VNyz4mqMEfiDzdbaJE9e6a2zftDdx6uL
         CcSR2nVVXj2VQwtp2P9hfylSoXJqARZXnPE5mJMBqNfybrF146BEkvnhQNYvaEwu8vcf
         Fs7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792458133; x=1793062933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/WVBOtkMP6M1xXLJUzfcGRzgTR4eIpAO+QQLGvxAdw=;
        b=gH25syzuggQs+bSMqDvkNi4lUdbQvCsLZqS3Zt1blZ4gsOSKiufEvf7ZH2GOmNlNqo
         C640sWZH5g5eZQxh2WkCLOYKmhU3CqVCmcmag7pWq+1B27e+D2CNKNEFNyGKMHFC4mVQ
         49xc81Shu2hPVHepsK7tEwY+VgX3RjSkJHmd8v19785v41ajyHlU4pgRR0DJXIAYEijK
         LlzRUdYo3lYcmwIslSDVbG1E6v1lLzPLdXsQuW+giA3sq5hOZxx/8ukkHAVSrFRL/ZlN
         GsSATJrvNaG6PDWzEeEa2UZUhAfWMtV8Oce5Yeem0cGChfxRyn7ULEeCa3wflSus/46q
         9hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792458133; x=1793062933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/WVBOtkMP6M1xXLJUzfcGRzgTR4eIpAO+QQLGvxAdw=;
        b=kqg21d/bRngn9kLESlbDsCgTL2nEsHtdHMJj6nC4h1W0fZsC8T0Wt7XRiePeX5xxw4
         FDkYS8LL6iKK8zTazUg2Mw7CRKvZUXNE3wBgnBvPXcVgjbQ9zSjMlPtrfaS2M9Ys9dDF
         CCMz75oi90uQqldcr5D/ruCHum+QXtXBZGb12IGg4NxsVPNMNQqXr/KPlOxLU4AXeQE1
         712fcpp1O89eLAdHxiJOlRx3VvGOhvgrJ/fwWz2Ygwtv/Uds9E45cRYo28vF5A+llHKL
         3qjy43DElTmom9YspfBTNfvtvmfN1DdN+yoYCGeF+/fs5vuJYlvwdEXY3QJQ6usNogH1
         9Muw==
X-Forwarded-Encrypted: i=1; AKwUvBwNkUULOIN+DASXn6HeWnlHjUV36mpf6x5vxb+i7oykpBkiDYisW9Er6rzxHSTYHRBn6YKdjvo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzE7/HqWocI5Iabu/rEFHW0VB7oin98QTgrWrSAnn3P2b49pbK
	OugZNU2f+tdU3Iffrh8lHhGrYEwjiH8KkQDcnNmOGUkTGCzjE12E15apyixtTgiyG8YgxVuIPhW
	tahpsfAzHR7mPVujsWoHEOrndMe9c8MY=
X-Gm-Gg: AYBFou15JVxQWhLFc1PvoN34wXBzmy/lrinAcNd7B9YVfGTo1dU+6oj7YeN7ytYa8Wr
	CAEtoBAHbD4WklEYNCjYFf+pc7gDiZN8DDDns2VWHwM5tUs7tYI4qLL+eHkXeZRrxl7kMiujuBi
	B9+KLZzr8hm8tmTZ4TQmv7qa73mVx7T8PE+CijZ4WA0hRVbDPfWunSKYxCsgXyWB0XIt42+WC8b
	8ulGIMcDarBjAPl4J8XR8zw1mvRuhdrt0z8A+gbP9Sz00kil4xIiSe4EtKFMgsGMPiWJJBcOqql
	feQUyHa82AS2RrO3AjJu1mPKIQu6lI1JrqNC548aLogUbtV9gJ66X/qbhZ4Fou4quySu52JkJ/5
	jQs5sQi7bCHntBjubFX+cLsKezC8N6PMtYP2l+CpdIvxlQkNLTsqqGmTHt9FbHjZwD+5lvPhx1a
	UfOLEJ33zVq6sdC3vzo/oPyQzLCtyeW/bySA==
X-Received: by 2002:a05:690c:5687:b0:864:6f4d:ef7f with SMTP id
 00721157ae682-8b0f2072b1dmr27038117b3.7.1792458133104; Mon, 19 Oct 2026
 18:02:13 -0700 (PDT)
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
 <CAGsJ_4wmvBvEn_vXu8-c6BRAnRewYmTs8iUd8T7KRx7_svZrwg@mail.gmail.com>
 <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com> <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 19 Oct 2026 18:02:01 -0700
X-Gm-Features: AclHuK_oIVGKOtgd9hzF8OI86eJwFkNPW92AAHzmGdzCl9JR3GH39OUDY1L-Ci0
Message-ID: <CAE5sdEjFgVoQbWw12=+AKdCOB9cWm-akxzbX7hJzvyO3vpCtgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref in get_lruvec()
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2026 at 17:43, Barry Song <baohua@kernel.org> wrote:
>
> On Tue, Oct 20, 2026 at 8:16=E2=80=AFAM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > On Mon, 19 Oct 2026 at 16:36, Barry Song <baohua@kernel.org> wrote:
> > >
> > > On Tue, Oct 20, 2026 at 4:33=E2=80=AFAM Siddharth Chintamaneni
> > > <sidchintamaneni@gmail.com> wrote:
> > > >
> > > > On Sun, 18 Oct 2026 at 14:24, Barry Song <baohua@kernel.org> wrote:
> > > > >
> > > > > On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
> > > > > <sidchintamaneni@gmail.com> wrote:
> > > > > >
> > > > > > Andrew Morton reported that get_lruvec() has the same problem a=
s
> > > > > > lru_gen_shrink_node(): when memcg is disabled on the command li=
ne
> > > > > > (cgroup_disable=3Dmemory), it returns &pgdat->__lruvec directly=
 and so
> > > > > > bypasses the initialization of lruvec->pgdat. The MGLRU debugfs
> > > > > > interface calls get_lruvec(), then dereferences the pgdat point=
er in
> > > > > > lru_gen_seq_show() and other paths, so these can hit the same N=
ULL
> > > > > > dereference.
> > > > >
> > > > > So userspace must have booted, since otherwise we couldn't read
> > > > > debugfs. The reachable case is therefore a memory node with no
> > > > > LRU folios when debugfs is read? So this could happen on a multi-=
node
> > > > > system where folios are landed on other nodes but not on this nod=
e?
> > > > >
> > > >
> > > > That is my high level understanding. I'll let Andrew to comment if =
I
> > > > am missing something,
> > > >
> > >
> > > I made a silly toy setup by running two numa nodes with one of them h=
as only 4KB
> > > memory, the other one has 1G-4K:
> > >
> > > qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53=
 -nographic \
> > > -smp 4 \
> > > -m 1G \
> > > -object memory-backend-ram,id=3Dram0,size=3D1048572K \
> > > -object memory-backend-ram,id=3Dram1,size=3D4K \
> > > -numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
> > > -numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
> > >   -kernel arch/arm64/boot/Image \
> > >  -nographic -append "cgroup_disable=3Dmemory
> > > ...
> > >
> > > Then I got a machine where node1 is very difficult to have a page in =
lru.
> > >
> > > then i ran the debugfs for mglru:
> > >
> > > / # cat /sys/kernel/debug/lru_gen
> > > memcg 0
> > >  node     0
> > >           0      14972          0         953
> > >           1      14972          0           1
> > >           2      14972         18        3308
> > >           3      14972          0           0
> > >  node     1
> > >           0      14972          0           0
> > >           1      14972          0           0
> > >           2      14972          0           0
> > >           3      14972          0           0
> > >
> > > now you see node 1 has no page in lru but yet i didn't have any crash=
.
> > >
> > > i think i will need more time to figure out what is the problem and h=
ow to
> > > reproduce it.
> >
> > I've asked AI to repro the issue with the similar setup
> >
> > qemu-system-aarch64 -M virt,gic-version=3D3,mte=3Doff -cpu cortex-a53 -=
nographic \
> >   -smp 4 -m 1G \
> >   -object memory-backend-ram,id=3Dram0,size=3D1048512K \
> >   -object memory-backend-ram,id=3Dram1,size=3D64K \
> >   -numa node,nodeid=3D0,memdev=3Dram0,cpus=3D0-1 \
> >   -numa node,nodeid=3D1,memdev=3Dram1,cpus=3D2-3 \
> >   -kernel "$KERNEL" \
> >   -initrd "$INITRD" \
> >   -no-reboot \
> >   -append "console=3DttyAMA0 cgroup_disable=3Dmemory
> > initcall_blacklist=3Dkswapd_init panic=3D-1"
> >
> > and it was able to repo it. AI identified that kswapd is initializing
> > the pgdat during boot, so blacklisting kswap_init was able to repro
> > the crash when reading /sys/kernel/debug/lru_gen
>
> Thanks!
> I guess you mean the following:
>
> -module_init(kswapd_init)
> +//module_init(kswapd_init)
>
> Yes, I can reproduce it with the above as well.
>
> But kswapd_init() is definitely called before we enter userspace,
> so this doesn't seem to be an issue here?
>

Looking at the callee sites of get_lruvec, all of them happen after
boot. So it should be fine. Anyway code clean up will address the
issue.

> So I feel there is no bug here, but this cleanup is still welcome.

Are you ok with the patch as is, or would you recommend  changing the
callsite of get_lruvec to mem_cgroup_lruvec?

> Am I missing any other scenarios?
>
> Best Regards
> Barry
