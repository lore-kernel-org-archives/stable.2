Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793037727;
	b=aG4fE0+sW7haTUHUO6r8GD/aLiep99mO8mj3NoECuMdNCXNdkmaDF2Rj5tZhG7FUVF8C
	 +VxEURNA0puWsIwoLeYHAliLHCTlrcLTHD4eYI86c3nizaAHyrMYFEAY28Ax3dZArNGSc
	 ttEtSTk5JNbAoQBc+V5kjEQU4rfMVJducbUzbd0P6peTZLk9PGF2GbZU8RCvgZBaNPcgi
	 bZn5TZY83zdCJyrNIXGiLsbG34rjW8+TsVIt6qLM9hHSc8zKd87Cy7DJpeiEFg0eC2euv
	 nNb/YKYyeAZZfP6ldRRqDXFY81IcJd3U9MRkMpD3nlBgosmVQ+ujh1WsL1IMglZZFYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tE7RP4VYsHqrXApguz8sNdRczbXmH+5NrdAtgpflwuU=;
	b=uCFPy+q0bvlXGiOihO4vQyXEiathjsNQLjVg65bDyPfwuWmbUzy+D6w5M9SDO6pBBOuS
	 JLfcEaTNIpiiKUn/Nve9JM70qI4yhEwwlHwfftqpx3DaB17azcYuiQSCqAOXZiyObJ8mS
	 NiI1AjYUm3IgVyRsiEeUbspJ0eYnl+f0Z5lCgNf7ZOjtwvFxcp1wZvFsL5qGtgQ2ORboL
	 2boRp7SBJOveVTWIAswByeneWq5ZdJiv21ntF2zjAKVNj5gUSyn9XM4QofeoQE8uRlluR
	 dZBIlPT016Q0UX7N9dakEdf09F9FzpY+pWVvwF1fvyiUltr8akST/2JRGBFkv3BLTqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GSt8eQMm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C4606A31F
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 057C4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GSt8eQMm
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso6875e9.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793037725; cv=none;
        d=google.com; s=arc-20260327;
        b=XWy+uu1v3wdtcDVCeECdCAXtvY3BTJlKAvkx5QZ7z+9IVeuf8IiGv0BLxHtrC8lq+3
         rra/V73iKblz+prX/++hVIiAMs0kRh80WoFPPeB0700FcriivjqrO9nX192j1UDXTPRI
         NBqSeBMNt0N7+uBllg/VMRCtEVsrwLg+99XMXVUj6PGEczqTbqe+QYsF940NwyNqzRB6
         TtJHYK5yzrItEEpZJgufNh8pqEyqw0Mdc8Wmx22GVj2wfylvv2HHHLV/R66HnJ0wdPZO
         WOohM0p1d18m2qpLSImNweiWXivnitzODBtDsl9DT/L4UsmECXuLNxMEW7tUHAstZOoF
         cdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tE7RP4VYsHqrXApguz8sNdRczbXmH+5NrdAtgpflwuU=;
        fh=Fm61S3MYGCQk918oBU3ab4zIJk+D6GUcHdqcm3YPRvs=;
        b=r++7lkVr3gJ5525m/kzWZRJ+d4tmcq+8j4RYFLCXLmSNrsn2O91lbG+h+DYM/hIBZR
         neFIRcG9mlaze1cw8DVSJhmZdtu2J6UqbfdgFOC/82HRjt+hn44g7IL1A/+y69ZX/kEB
         8AhwrZBon8I7rQmK7JlQypio2qRm5dmcDZFq3b+LUrdb7/Jbh99G/9K6qFoDklq2DKlX
         XWbTqtu1CwDAH310q8ix/1aWgbhTsroMmbpWARTi0aP+a6MN9uh1MP+JsQ2qBmeGszYs
         p0Zsdi6Aga+QTubkTLqoaq4rXEvqHg9f9xjJXNnnYk9QrLFpJRtjA8ASQuWn74k4wyx+
         LyhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793037725; x=1793642525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tE7RP4VYsHqrXApguz8sNdRczbXmH+5NrdAtgpflwuU=;
        b=GSt8eQMmyonsmu51tnuB3OOoCLAG5Ub3saP+6hzbZxjvXs2HavzZWqdru6q9odLc4x
         8LZgJ89V0wIRfGdc7DhIluw7u2J5YCb9BrvVTFuHpuCVo+Dh63PI4bO6EdT/unM+OkvQ
         fdm85tXjnIrCIlStBx5JtUdJV2+GE7Ymx6AobqUFzfBG6IkIaCVYdsqs0rpUNtzdqMGo
         G5pbGkRiBT08huUAERs6p1O+qMMPoGSQ/EQfuk1JgUcg9wyGzK1sxkCBpYJ6wjVEHIBN
         f0qJBda99t9zffio2My9RsJ+qhwXwPAlb011+xum5s8GmE9XRsgQo3ncrBNVFI/jihAe
         PcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037725; x=1793642525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tE7RP4VYsHqrXApguz8sNdRczbXmH+5NrdAtgpflwuU=;
        b=O1Qs6eSnABZS3H0+CABsWAfJCFXCXp7ihNE6tw2jZ7PigHBUfmOcrHNcc7kJIGWvOJ
         klr46Z+IgkQ+2uNWsCtDPnchz1fTERz0nf4pwK1aNYwPw7oCWWt17wE+aJjw+uUurTsr
         gGB0ETNsYk7CX47HJAIV63V+aLyK2Xkg1oIxA24rBugaESgcZYvcI1dMNiDpOPReuebi
         o8c2zuUOIUKy0kfVDfp9F8m4hyXSAvT08QkYwIKLbJco50ytm5bXEiBd2wdlhd0ws3yW
         6JassIjPfNAnXQg5fKcaiVzbBlyHD/BtJuxOHsHySPFissF93Y8XRr7XSn/M18aFZTVJ
         1Ktg==
X-Forwarded-Encrypted: i=1; AKwUvBzmaszBpmMbchNWPNIATL0XmzMtsotfuR8qlRDZ0LpY9THJAs+V1xOC5F+MRV8nIxSPPVCAfoo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5cYOLqwjpKavM6VzXl5ZMc9N2NaU1bq0dtIltoVpIR0LTSUAI
	qehHDThKIiUDHEDGsLwYTZ337Ux34vyJwE3pqmbUGBtkM3gJH6nKUPe+LERXTs/ooGVT2B0A29+
	ZuwQnT6samIoiWOxCUBBbHdZbS1+sY40sxKIPJq4d
X-Gm-Gg: AYBFou0rjUQyQmaOiHHqC396IuszgSsxNm5D5XC5MR45UbZLrtUxL4KLftNN0SuL629
	TOreIF1kkOPO2NZ3GsxCqriFStC54bXMOwaCgy6uWM7eIksChgfN5zfz+qD1olmZn0pHLoMrwIm
	Kk0KMAnCA88flxq6qwi0ARy3NTBId0SISpdqyTEy/2s3YpbVuopz2lS9NHP5COOzeKxyFdGPpZ1
	Vi2CZKa4F9uVfteXvEoWZBNMfNg/6v+/kTe8U+OGVbivNT/mNityq1ByxTsRD3D4/wqpLvIYZAo
	WN5YpZtk+3Mcv+xV6ZhAIiTYZ1V5W3Mft5jVoGSExOATqeMzMfEgTovtoZk8CIgWHy7X5hxR4w5
	gl5f24wAFIWC2QRu1oKViOCSZ5CDwvJ3DyULZtE3BpBxEb7/45Xp5U+QhNXdt1wXqaaX0YZr5Ug
	9KXUDe5Bmy5t4wKkcBA3rKRw==
X-Received: by 2002:a05:600c:2295:b0:4a2:bd1:a80a with SMTP id
 5b1f17b1804b1-4a7d73b0af0mr46865e9.2.1793037724801; Mon, 26 Oct 2026 11:02:04
 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023222313.3979455-1-tjmercier@google.com> <at9U2HvyUP-iYOCt@tiehlicka>
In-Reply-To: <at9U2HvyUP-iYOCt@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 26 Oct 2026 11:01:51 -0700
X-Gm-Features: AclHuK-fek2ms36qxSTQ8kH_qS9sI-bAShEDJFdyR3pRLqFaZUwSwPiYlTTU9KA
Message-ID: <CABdmKX1mLKEJNiecW+meJ=LB_Kb8-ieeWdZDd4T6rNR9gKuq_A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix NULL pointer deref in
 high_work_func() on dying memcg
To: Michal Hocko <mhocko@suse.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, zhengqi.arch@bytedance.com, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 6:25=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 23-10-26 15:23:13, T.J. Mercier wrote:
> [...]
> > ---
> >  mm/memcontrol.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a05d9a8baa1b..84f4a8fd4d16 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2457,7 +2457,10 @@ static void high_work_func(struct work_struct *w=
ork)
> >       struct mem_cgroup *memcg;
> >
> >       memcg =3D container_of(work, struct mem_cgroup, high_work);
> > +     if (!css_tryget_online(&memcg->css))
> > +             return;
> >       reclaim_high(memcg, MEMCG_CHARGE_BATCH, GFP_KERNEL);
> > +     css_put(&memcg->css);
> >  }
>
> OK.
>
> >  static void high_irq_work_func(struct irq_work *work)
> > @@ -4463,6 +4466,8 @@ static void mem_cgroup_css_offline(struct cgroup_=
subsys_state *css)
> >
> >       page_counter_set_min(&memcg->memory, 0);
> >       page_counter_set_low(&memcg->memory, 0);
> > +     page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
> > +     page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
> >
> >       zswap_memcg_offline_cleanup(memcg);
>
> Should we simply disable_work_sync when the memcg is going to be
> released instead (mem_cgroup_css_released)? That should both prevent
> the run reclaim_high during the memcg shut down and and also avoid
> plaing with limits to work around.

Hi Michal,

Unfortunately that won't work for shrink_many() ->
!mem_cgroup_tryget() -> lru_gen_release_memcg() which can occur before
mem_cgroup_css_released() runs. (mem_cgroup_css_released() happens
through the cgroup_release_wq.)

The high limit reset is also needed for targeting live ancestors above
the offlined child in try_charge_memcg(). Without the resets,
high_work is never attempted on them since it gets dropped when
attempted on the offlined child due to the first hunk, and
try_charge_memcg() breaks out of the loop.

Shakeel's remote charging patch
(https://lore.kernel.org/all/20261010210957.1350874-4-shakeel.butt@linux.de=
v/)
sends remote charges through high_work too, so without the resets
those would lose ancestor reclaim the same way. Before that patch not
performing the resets means reclaim_high() runs unnecesarily against
current's memcg (not the remote memcg above memory.high).
