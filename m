Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60942CAF2
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225944; cv=pass; b=Vagguu5ZSMPya6Zke/NwvOpwCMVNsuoe2kC1YnRAcWNrwKmAZcghnMhhN8eTU5ZmNQpOk6lIiCNwg8VQ/BS4LB02qiBqiSkA1KYjE6Hpx3/wSI1DKFIgvrAE1Igm0CyUXoNMFuLa7YXsHZM8Nsy3uX1gQvqBAGBqyTyGkw0twVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225944; c=relaxed/simple;
	bh=40CP3ck5nVy6QPOWWJBMR4rjP7Y/oJjXJIQelgpWKGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPpt6TS0CKdFHRE293x/UM6kBKiWK875ecykZfZ6BckxgKZAEfeSuhObgYXzOYI3LLH4L5TIZ5/ohZV7QmCQ99dildhF++YSjl53nPuqiZKzOgwLVnEkVrRth2rjP/5foqk8TbD83aG1hhEqrVA+3oqoOBSK7jEmIdVcHxGqScU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7dZtMHV; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7dZtMHV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47640541585so3464119f8f.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784225938; cv=none;
        d=google.com; s=arc-20260327;
        b=GqSCLYxsuNvzS5QtenLinVmeRAjFR93i+3ddej7iIGBs3802SpzjnjPazpge0mxnDF
         ZErIyNybAWQB1V5Y6LZMKU7a56lYTDta/uHb99vD4L/YqxjX3+soqC/jdyijsmo8ZUpb
         LJPzpE4PqWgo64XlGh5kkeVPK38bDi/ZTyKFTvwsfcFtbspB4D0ZPLuJ8TNNo77nHgo7
         of7LLm9akNAgI4gikD6nD/OXMuLjhmtSxXcn//r3upVBUaK9OwNy6tpYBrgfjhMKYTaG
         LidtTY8T35efahT1h06Y67tYJ5OF465F2faSSGBUavhdIviZuJm7shVtwYQ2Sqo33gNb
         Prow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCJWw44Yt9QfTMjmF/5pzznV1wMqLVnfAfzAdUp6RWc=;
        fh=Suw8hqtKe2FA102HBYWv5dOE2jHlmGYgIaibAu3e4Dk=;
        b=jYOBnMgE6LnLrK/k1z+K9qvps7LwlNn8PdQAEblDLteGBlqjTrkHTVOZZoQnn1fAwX
         3aXocNHX9jTeq5gowJeCj8rZ9Y9GYotkYXGNF50Hgnc9sYpmF0/cPcCu2EM209c4ePfJ
         ysJJOvPypIyHu7pnHdv476KqBGtA49fWwSUGiVZeCiMZlm9Ezcf+VFAqCt70Op6rPy9e
         xTJCFGKwEuYiC0O/qzdfFFDoxCx7+8mKltcPtZI7126sT+6OxA6EuiTDD41aJqZnPmTs
         EMgMYFa7TUHrXfCXiKTl3qRi/Tbl0doKnGd6CiluGabN+7OlSUgHJXUYlZlN2IMUD99L
         PLHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784225938; x=1784830738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RCJWw44Yt9QfTMjmF/5pzznV1wMqLVnfAfzAdUp6RWc=;
        b=e7dZtMHV8W1WFXBv5njNMIwwKMR4ccU2LNIzI4y3USlM6Uebp6GpnVuEoff70Kb0a4
         WlsrxK4epVDfdSiGUDWFe668OJe6s2/Rn4O7fj4E2mqNknwHKetLY7fhQjgJazOAHF6T
         TKVAT4/jS1bt/sKweV085w0Jsn+/dFbleu1CQ2YMyOuBg/T7rJ1ansjHj/t6ndqyBhIj
         AJoHAvxeFIZCL9oLNqIVvDWV729/AAQAKc03sz9lupckCSkckcmrhAObDXpdZdvvEego
         6RtoOVkv2Cj4YCTQ5p+Z9OadJq9d6ZlgYQlz8xIZizciykkJIC4fc9tb9aY5YC0zw5mm
         ydKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784225938; x=1784830738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCJWw44Yt9QfTMjmF/5pzznV1wMqLVnfAfzAdUp6RWc=;
        b=swsDZJpQMp+QWPWh53GCsPLozA2MFjJSPQ2+pjBrhOXR6BQLNJ4xgWeZfT+ELGQLZz
         UlwbGr/ml45b4hom+F1fnlDyE5lpM+RDqfPWqfXRI/ydnYwd6eBQsLoOw7+9cNW6Lwov
         tAhLirCv8vinsl2pyTrqBfWY5wvi4bkJN516LxEpihMjHFBcVXi+jowNTTdM7WTplpeU
         hcSzIdgO/bf3yH+P1h17iYNTScbQmvF7dHuNMAWh84/EJEhu+4A4Tp5B4YVsPtFUSQVV
         linWHiyVwpBvEBTRAo5wEdYIseiiXBEgnE5Vf9zc0xJK24ySHSgXIUUi4ATJ5/sNi/X2
         bXLA==
X-Forwarded-Encrypted: i=1; AHgh+RqoTARzu+KkEnWZmKlSFoIPAExCO+3YDY63SnwMhiEwlq6yToUXp1C4fP+wrkvbdt8D9d1ZdQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7shxCZ6X7Bpi6slwxxQbfRciK8ttdWkbAcgfxBGvj7AdbGSq5
	jjr5B67G4V+N84UVjkl7pPq/jn6sWklIaWsWf893Y4QfpU5Kpe85fh27kBBYNmJ3WjRzq94Xf48
	+6c5vLCB4w7PoyVCn00iYv4NY3Dh6fOg=
X-Gm-Gg: AfdE7cnm3pBUvC34fhrFZn/NW3F9LEn+k/XRnYa78lCuysU6RKVHEahOnoy86uB4Ylb
	XpTYgikXSVCUOTqSgBDpYr/bS6c5P0qzkE+sscfN0jIWPQin1VT4xVVTQnQGI+6mrGztKJnvaaC
	qTgBD16RmGbiSo70xHaUWfxD0ToVLjL/WN4PnEVreQDChGzzGAzz2x4Jv93Swp3x8qqT3dgWtP3
	DLdpFdnqNBmBkB+K2Akq1ZMx9ewU7zvCtYd2fdzA4lggKvIgh3ym6hGGi2AvV8dpCDCNlo3eZX6
	Cv68Lqi/obKFUAUdqeS1B2MsxGo+5x/N9A==
X-Received: by 2002:a05:6000:490d:b0:47d:ec60:657e with SMTP id
 ffacd0b85a97d-47f4fcd91c0mr9789980f8f.39.1784225937975; Thu, 16 Jul 2026
 11:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
 <20260714081510.16895-2-jiahao.kernel@gmail.com> <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
 <20260714193129.f81711f516504b659d544741@linux-foundation.org>
 <7a1fe347-7ca6-4768-9308-420bf1251f54@gmail.com> <CAO9r8zMDndmoxi_XvQv3rkkhCfb+aW3=8JdE3gAv2YOKiyiFSA@mail.gmail.com>
 <7b35fd4e-7662-10ae-159b-303350e4e59c@gmail.com>
In-Reply-To: <7b35fd4e-7662-10ae-159b-303350e4e59c@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 16 Jul 2026 11:18:44 -0700
X-Gm-Features: AUfX_mxIpAby5cOyODbdsd_vYnsokVJLS1QcOfP3fFXU1u6G5EgnSr-TbOWYryE
Message-ID: <CAKEwX=Ob9shetuJK4y=NZods3KkT=U_3W4S_ALzxX3EDLomWEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 7:21=E2=80=AFPM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> On 2026/7/16 00:13, Yosry Ahmed wrote:
> > On Wed, Jul 15, 2026 at 5:31=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 2026/7/15 10:31, Andrew Morton wrote:
> >>> On Tue, 14 Jul 2026 09:52:59 -0700 Yosry Ahmed <yosry@kernel.org> wro=
te:
> >>>
> >>>>> When memory cgroup is disabled, mem_cgroup_iter() always returns NU=
LL.
> >>>>> Therefore, the global shrinker shrink_worker() always takes the !me=
mcg
> >>>>> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gi=
ves up,
> >>>>> so it fails to write back anything.
> >>>>>
> >>>>> Therefore, when memory cgroup is disabled, fall through with the !m=
emcg
> >>>>> branch and shrink the root memcg directly.
> >>>>>
> >>>>> With memcg disabled, shrink_memcg() only returns -ENOENT when the r=
oot
> >>>>> LRU is empty, which means the total pages are already below thr. Th=
e
> >>>>> loop then safely bails out via the zswap_total_pages() <=3D thr che=
ck.
> >>>>> For any other return value from shrink_memcg(), the loop is guarant=
eed
> >>>>> to terminate, either after MAX_RECLAIM_RETRIES failures or once the
> >>>>> threshold is met.
> >>>>>
> >>>>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> >>>>> Acked-by: Nhat Pham <nphamcs@gmail.com>
> >>>>> Acked-by: Yosry Ahmed <yosry@kernel.org>
> >>>>> Reported-by: Yosry Ahmed <yosry@kernel.org>
> >>>>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVr=
HiZZeLc=3DeyTPKPVQgX4g@mail.gmail.com
> >>>>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> >>>>
> >>>> Patch 2 doesn't really depend on this one, right?
> >>>>
> >>>> If that's the case I think this can (and should be) picked up
> >>>> separately as a hotfix. Andrew, WDYT?
> >>>
> >>> Please update the changelog to clearly describe the userspace-visible
> >>> effects of the bug, thanks.
> >>
> >> I am not entirely sure if my understanding is correct here, but maybe =
I
> >> should add something like this to the commit message?
> >>
> >> When cgroup_disable=3Dmemory is used (or with CONFIG_MEMCG=3Dn), the g=
lobal
> >> shrinker fails to write back any pages. Consequently, the zswap pool
> >> fills up to its limit and rejects further storage, preventing memory
> >> pressure from being offloaded to the backing swap device.
> >
> > I think you can simply write that zswap writeback when the limit is
> > hit is broken when memcg is disabled.
> Will do. Thanks!
>
> >
> >>
> >>> Also, AI review has flagged several possible issues, all appear to be
> >>> serious:
> >>>        https://sashiko.dev/#/patchset/20260714081510.16895-1-jiahao.k=
ernel@gmail.com
> >>
> >> For AI review comments on this patch:
> >> I suspect this scenario might only exist in theory. For zswap LRU to b=
e
> >> empty while zswap_total_pages() > thr holds true, it would require a
> >> prolonged state where there are always more than thr zswap entries on
> >> the zswap LRU whenever zswap_total_pages() > thr is evaluated, yet the
> >> zswap LRU happens to be empty during shrink_memcg(root_memcg).
> >>
> >> If we want to fix this, perhaps we could do something like this?
> >>
> >> Yosry, Nhat, what are your thoughts on this?
> >
> > Do we need to do this? The last paragraph in your changelog explains
> > why this can't happen because zswap_total_pages() should be 0 in this
> > case. Did I miss something?
>
> The loop would require the following sequence to repeat indefinitely:
>
> 1=E3=80=81zswap_total_pages() > thr evaluates to true.
> 2=E3=80=81During shrink_memcg(root_memcg), the zswap LRU is concurrently =
drained
> to empty.
> 3=E3=80=81Before zswap_total_pages() > thr is evaluated again, the zswap =
LRU is
> heavily refilled such that zswap_total_pages() > thr holds true once more=
.
>
> For our case to manifest, it would require zswap_total_pages() and the
> zswap LRU state to repeatedly hit this exact window with perfect
> alignment over a **prolonged period**. Therefore, I suspect this
> scenario might only exist in theory.

Yeah seems very artificial indeed.

If we want to be extra careful here, maybe we can put a cond_resched()
there or replace the continue with goto resched or sth?
