Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795542568;
	b=sUZbfui4I3sz7hSV6ODRCS7pExCFoUD5/bzsOaK8X1RzJmFzfmDeBzNamigcS2eXrWcx
	 niwnWJ3L8kMTAb0YFWeguWCDieyw/FLRkz+BC6mo50Bp2/Of/jgbaml6EcsvR4Xhh/iM4
	 eBOjHs0DVLLcM84Ec4yrN8QuxG5esv9vcaGpEIGPM/k+95QPDKeLi1LwEz2U77fTR7lMy
	 ggx9+i4Vhzi42F+mOOB5hal8YSvC8pRf+TA1O845MQ/mM4taveMUUc+PPyaB3iRHyIBtT
	 LBQr/PhAlPgv42rzxNE8XS44TY/Pr9B+kPAoVZ8i8fzTpA+XH4H/khH3SdoYLjnlODg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
	b=XzEORCUAaIfmKmuR0BN1F/22UMfiDMZBBw025838MmjS0+54KbvjXQvfSiCmXGo7on1t
	 COfrpziTYllnVbc1YtMQKikfpCV9JGkqfPNEJKXJB6XpCJdPLoSHSZF2MzWO5Da1ywZ6V
	 0u6CB5uq2Sl0O1zQWr/bEax3py1j54ZArDnGyufY09nTnyrz9xKnN52E0ufrBddiI98QP
	 /lXsx/LTuMNMInEweqPUr2URawF8Q2hAtEV//PVHflHbhn57ypX5+/ScUpvoFoWAa3AU9
	 nBV090xuOz2iUyKOqx4jPa6Rv4a35DV2vJwm8Pmr6zYSeIbGm5lG2LumkpSXwUnhwOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7UYrUF4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39F606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B39F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e7UYrUF4
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-533202fe429so983181cf.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:49:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795542567; cv=none;
        d=google.com; s=arc-20260327;
        b=cDr1v8SZWlOn4Ak7S47ps7h+bfKvYyZZFFwwr00+Ke+A35IDitHrrSGSCYOIc35LW1
         59eF0hEXt9DJWngvR4FIm1AUK9NTRa6O8QVOfZvy9D4gFEbumGtVd0B5+K4kISDM+L/j
         DhkrI/v1FlhGHaMESw74Ult1CI6I4SHGrbObWbPNj2GMbI17u6Ar2aNSqbTnxIJfcKhP
         n4BveTFL6QON2fKBUPTVynAHftrEDTos0CydzUy01ufGB2tjbOJompmxiudiGLPGQbgT
         9jTVUf5VuTLEujAI6XzSK9CfdeuUKqMXooGQnfA9K2Xkxwdhr9Yvhkq2P/KDcl2IvZA/
         vtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
        fh=rGfOTSVfZ2Ey5C8GIkkn70Hyqc+cXK8VpPibpiEE6NI=;
        b=oHOurRPcxAmUTw8V2+Cw6/z45fyxW49M5Ty0mIc1yMqr9bNQZkM7KFMC3pQTfNd55L
         ypIXMySJM5fZ2MYA2TgwBPTD73aE6kBtpXBvGL3W+YcAmfnNldg1En4b/veu5ID1q3PH
         YNIAPfD13BSbCHqwe0N3wrkpk7099Pho7yOMhoCi+a+YxjXNktjH0oz88Wok4gUllfqA
         +Xv64wc/IvPjKei3PVnk/td+mqkj4jAGSN+XgKynPeqXkLv9Mj3DUvt3eNbQ2VezR4sq
         E5ccO5eWDA5VR9sQTYRWRA4wchRqxBJQfFNBEx7IMu3dAZzYZAUMSXN18zxP0B7QTUzI
         7XFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795542567; x=1796147367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
        b=e7UYrUF4nKBxaC4jgXXgDe3ZHrbdY4HWtnith9cwWZ5pPz2rLq2vrIC1LAn7Bqtsn+
         qRPXxsQL6IUeSY4EqKzAPkao+gInkgCliPsaW6eapl7cul2FUcBTg/EkOYIKRYDSj4P6
         M0w2/jLe0ObjVWu9Vp569S59fawsJ6IhiF+k1yRM1qhp6QRb1EGhBuNgrjdYc4IJ3nys
         n30s4RRkTEzz0BLshm2yaYf9HGiI12deEVOMMk/qcTkCr6vxyvy+ajm/2kcPSMgGpiAz
         x9uFRLvarokBWXFGSJ6NWWFAY57w03jxyEo90ZmKtqp+G1R9VhLof92MbJKOi4LuM17q
         lN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542567; x=1796147367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZpsKsMasCu0VG55k4IFjBDsARDNBPmeWnpoFmnC3rQ=;
        b=rS0L01TNWYr/nnP3Bq+uU6+FpJ7jn85+q0vmwoVuUx83RzXh3/utNbcNW24xCQfuul
         aKtHfwXr1U12rVhfNpGirqN4pwz4SlQKX+DRyNJerWo0CPqlAXhsfYj6J9ekx4v09yty
         BKncU51J70OcGWRtRTDFGb5YCpXygxCLGeDpVDEY7ff4dNCtBTdfy6jtlzhAfPI2tSUx
         MtbNzmLdakVie0tnHrZVJpg8R0bmP7gukAuIZYdl94elSC1lfo0mI2E6QnyUaJXh69mu
         Sv5UmsPsBgkAd3Yt2xJrmq+0gXYIfXzQwYcrHL66vZX2cwkZGefY7CI+wa4tqhYHefz/
         fApw==
X-Forwarded-Encrypted: i=1; AL+hErGpSGSv6OXiEfqICBo4gm0VVUdZLWY2AB3MwYRBYtjoihIkSoXlFdo4yda6P6UcY7SvDEQA8AE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V4dUojVVypcpYcQ3iapMYLmxomJqa1Afje6t8NDlkZ/rWoWNW
	RXCGUdxaZCzJa5kU7ql0yNjxE+i1GcB4PwbAYom+5Wk3w9Y4mj+HA4HUpltKMkks4yqPJ894kvV
	p6xZLAth1rD27MCCuU8DndR4ECcwPTkPYrQf94ULb
X-Gm-Gg: AZFdTZf3D4y6kpeD4z4auYDADxv/Hpkr9YmhzhxjWMDhQq/CK8u7O3Tds81huLgs8ob
	Lc0KEgJ7yh8Pqe8/yfbU5PrwEq02nlq7BeDuuOKpeKoLyClIQz9LKSyLQck5mhxRKvFseChzHaR
	Fj2d+DL8iX+OWwGiUrP9AEz/iTOTq/yQU4fKw0rkGxeTUeqSAxBHtXjOcLZa6bn3OgN4bvqh3qq
	k9VSx7ol4k7KkETHacvQ8+UdjVgO+ZJOyUpSzRXivdNU4lV2smLANjCm4ziZdeODhmuIqnEqUaj
	41ye9bE+tETk9twdDOt+Zt08Ib3iiUbSAmTNwqb09W/fRsxJeiGC4LjaiJ+tT4pZTmbVsfedYFX
	MilsSw/PO/4GE4WMvmdb2qUkTxdxQOs3P6n104HJjW0leoHecP9gLMvvU9qq/VIxk+h8Yz4pSdw
	hIqPz3PdWwZ1vdt0jUEUkj9lA3HjU2xNMWL276/EThRDOQKbUO
X-Received: by 2002:a05:622a:1f14:b0:545:7949:80a5 with SMTP id
 d75a77b69052e-55d890663bamr62644371cf.12.1795542566115; Tue, 24 Nov 2026
 09:49:26 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-vma-read-lock-mmdrop-async-v1-1-257f99f551de@kernel.org>
 <awWLCZ-jBjSD7V3M@pedro-suse.tail5790ac.ts.net> <CAJuCfpGk6eYK43Unxo+O4ML5=GM_siZ9owp6oa9fO0ipZXVg-g@mail.gmail.com>
 <CAJuCfpEd1rz3P7fB7W_mHkyzbpq9TscRE+QNwvHdYME=WJj6cw@mail.gmail.com>
 <awWz3nc_b8x3mIXq@gremlin> <CANk7y0gAxY18Ew+6j5YsqrOsf5Dx+v5M78r7_8JLXh5RHZj4qA@mail.gmail.com>
 <CAJuCfpFuDCUPTUi3SuAhmbtw5tubRZ0+YEY3PotjyJ8Or8pdQQ@mail.gmail.com>
 <awXHR007d8MlhJUC@gremlin> <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
In-Reply-To: <20261124093328.3ba2e066e5d5081c69e0e667@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Nov 2026 09:49:13 -0800
X-Gm-Features: Aa3M54rJtgRgH_rcKNgpafDHAbKng8SpV3uhoRslOvIjTwkRWkSfaO8JY91K7G8
Message-ID: <CAJuCfpEmFEX5iqLw_c94a97rVrC+xBWpKnO4rVpeDgkUfAPq7Q@mail.gmail.com>
Subject: Re: [PATCH] mm/vma: drop mm asynchronously in vma_start_read()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Pedro Falcato <pfalcato@suse.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 9:33=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 24 Nov 2026 17:23:35 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.or=
g> wrote:
>
> > On Tue, Nov 24, 2026 at 08:34:40AM -0800, Suren Baghdasaryan wrote:
> > > On Tue, Nov 24, 2026 at 8:06=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Nov 24, 2026 at 9:28=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > >
> > > > > On Tue, Nov 24, 2026 at 07:51:42AM -0800, Suren Baghdasaryan wrot=
e:
> > > > > > Actually, VMAs are allocated from a SLAB_TYPESAFE_BY_RCU slub. =
With
> > > > > > that RCU unlocking move you don't need other_mm copy and the co=
mment
> > > > > > that comes with it. VMA won't be freed until RCU lock is droppe=
d.
> > > > >
> > > > > Yeah but they can be reassigned? They won't be _freed_ until a gr=
ace period but
> > > > > they can go back to the slab and then allocated elsewhere  right?
> > > > >
> > > >
> > > > Yes, they can go back to the slab and become a different VMA.
> > >
> > > Yeah, you are right about that. So, we either have to keep the RCU
> > > unlock in place to keep other_mm comment valid (my personal
> > > preference) or update the comment next to other_mm to explain the new
> > > reason it is needed. Either way is fine with me.
> >
> > I think let's just change the comment?
> >
> > Andrew could you change:
> >
> >        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> >
> > ->
> >
> >        * stable and can be reused in the narrow window after vma->vm_re=
fcnt
> >                            ^
> >                            |
> >                            just this freed -> reused :)
> >
>
> np.
>
> --- a/mm/mmap_lock.c~mm-vma-drop-mm-asynchronously-in-vma_start_read-fix
> +++ a/mm/mmap_lock.c
> @@ -300,7 +300,7 @@ err:
>  err_unstable:
>         /*
>          * If vma got attached to another mm from under us, that mm is no=
t
> -        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> +        * stable and can be reused in the narrow window after vma->vm_re=
fcnt
>          * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
>          * releasing vma->vm_refcnt.
>          */

Sorry for being pedantic :)
There is also this comment later on:

        other_mm =3D vma->vm_mm; /* use a copy as vma can be freed after
we drop vm_refcnt */

That should be replaced too with:

        other_mm =3D vma->vm_mm; /* use a copy as vma can be reused
after we drop vm_refcnt */

Again, just replacing "freed" to "reused".
Thanks!

> _
>
