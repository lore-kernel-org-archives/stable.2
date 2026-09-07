Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E84DBD95
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785627; cv=pass; b=Gtlur25nBZjPhCRj7xZRPiLXNuJoPxMiy0rzGDPOneMhCkXBsHe8UysaHka8wdu/DyH+CvPLTG7Khd6mR8bZH6NRi89pZyttOapAG1/+otffFY+NWYFD3pCsZvKBOR1Kb4IFXmNqiuA0niMCsgFIeu4szWUKD3Jv3i/buSbsg6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785627; c=relaxed/simple;
	bh=8m9GX5w5lxT8loUdxPM+WgOlnMcCdSnplV5yJYmeSSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUnkM44XlGZBo2UUjhVJxz4eYnqg/lRPf1KN6h9cjtBtoRzle4vyA+uz8ASJ7ldkL3gLYnkhIjHv8zNEnWYyTrc54kjSkBB9dV7jOMnzm3g+HxOxob+zmPWGeuc3Z0NU8eGmwTPwLRDaTDQU0Sc6tLMXpfrc2SzcIKey6mpT6Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NqoItOLI; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NqoItOLI"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a20f56876eso33304671fa.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 05:53:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788785622; cv=none;
        d=google.com; s=arc-20260327;
        b=cNsDIb/Gs0kJjP7a2ffBCMIBo++kY9t9b9xwPRjShL5d43FhPl/H/FTgI4Q1N63bZd
         AIA7vJp03OKfTy4u3B1T7OKnhpmyP48gvdv1/u97c4cvQy4bHbio0LaHhBJePSHprDZR
         GsQcA4jSA4O9Qx1n8gUmTtntLCNv6P6Bg+FsXr9xQwj2jUzHMpAtrABX0JciGKwxS2e9
         qqY25+Pet0HcZgDGMUgSgPui0nt6nBt/0ASJnw9PeTNVDEVyOsayCFwSmveetSB9nS6x
         9jLjiUNqIKfSiPyGu0WoINdylqUGAzLHkt8+szhiK0fIPr9yLn39q672Zna4Kd0hxuze
         uaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8m9GX5w5lxT8loUdxPM+WgOlnMcCdSnplV5yJYmeSSs=;
        fh=BxLimT7AiKPXzvrFQo5fEc0pah3EO5GzEZ7svWVXzDQ=;
        b=KXjtdXPd8fKJNBAfzePgQyTAkOPM8lGeZ/RwxvhMOmSGCZIUbUyzkYZiiVHg6BvMOQ
         QVj2yeePG4f8QPbPvAA5BbeM9lPFQxuVUFyNioJppowUvUAYCWSXK7w8wSqthyZAvVRz
         n90VUyCOU46x5kaADp4FAy84S84CtSt3HPcTMm7BDqEWmtsalB3VALPlQ8L6/sYWysiL
         4K1hxmKTR5kW4+S/2DDgjT9T3KjCqvzVHaoenoDzOgCVqlxUonDVgumLi3hNzrADGb7a
         yJ2zpu9af4fITfw40YAx0xLoPxiIUxWfro4HTJr6qXq+pxj/p8nVt1eZxLbMXGbJv3qr
         gyNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788785622; x=1789390422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8m9GX5w5lxT8loUdxPM+WgOlnMcCdSnplV5yJYmeSSs=;
        b=NqoItOLI8buUm+bCoGln8l5ILJ/2SDZCzo1+5vgty37NfsLiT4e2OyJy4T8Egp969w
         gSvsNbm3y2i14vuIBI16yT5VA0oIYZ3qhkUI2o4+XaXWrtgp1tGDXy3fa8cOmrWPOEDU
         T6KIInPhioD28NMk8rupt6ymDxP/0p6A8cDXlkVAv79k63cjy/KlNfoJeuLNVexr+G/E
         nEBVbMvRuM8efxEJ2/LI8FQFdVdF7U4JXqSe/ueGbq8lPXXnDeTjTErFAHpcIw/vYk3J
         ZVBmCxNbkL8wSTTGmFBYc6phmTWFqh3cIHBwFf1gMN8kwoYZihA1Koqzm6KFWmyRlLZW
         s/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788785622; x=1789390422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8m9GX5w5lxT8loUdxPM+WgOlnMcCdSnplV5yJYmeSSs=;
        b=QP2kjnKGcD+H4DAMlW6flHZRUCm0dixZWub1N7NfrV2vnSb7ah/x5kyxefFfOXrcpu
         5ERLPGZa8J4IDdTknY4V98afB0+v1lXs3hzaeSoTi7WYccxy6iOZwik3PApX6tQ7r1jo
         PF39KJTT0MM0qbD6oRGX06Y4qmDBjjXUf8OQikNKdWUeyVH65PznJT1VEThDO65ddw96
         DimJuI9K4zTbShAErQo8eJ1uDtXBmvk7dSDnV73z2ELS/8qm0RdTEsHvyxLl/+eSVOZ6
         4Au2grYqZmxq76AZnUodtr6FeRaPqfeBnCpR9DpEqpFgo5CjzyQv/exxM+4mXmp1CC1I
         l+mw==
X-Forwarded-Encrypted: i=1; AKwUvBz5vRKfbNAiIOMuOU3wcrPSiaS8CFwDHJ1rkdolnyS6Ve3qIsG2dMIHAUIT8jgt6rhK6LB0UzI=@vger.kernel.org
X-Gm-Message-State: AFuF++lfZr3cc4Su9nnAF0RW7LVXnsG081AHqmreja6nq3azOYSSWruw
	9I3Q8GIgDShYKEwBEqKEbV9KowQ4S3R7/FdI/8bhaEQdW6ba4+TuXnFAJGqkIeGnc1OxTTg20CQ
	3Eov7HAxq3H0ruWiQBRu4Nl31SO6RMRh2LfFSvNKzTsY=
X-Gm-Gg: AYBFou11QhiNhA3KpW6wOLKgz87ZZc5uGzpjEuiW0ZRsyPnU1tFwVe4uKsaqFx9Jm3f
	d9JpUO1tFjJgShgFEz3A0y+06+9vDgoGbns5XLbFrxRoKsZILFznEPuDEG3Zqk5iaGeZC0/DgC2
	JXY/mrxPp8B0LBXagnUgX/weqI3wJjMGy7cwakpr7Z5hOXGRpxASWr6+RiVHv3YAThlFQCtQ3iD
	+LMwhaA2Ez3Nj0bY1x67Dllvs4gc3oSpyIRSXIJLnR/bQ1YdTDHOf2Iuzd03+ExMpuA07h8KPkt
	sgNLiZq15HxnpfFbAKeZhUtrNqr78d66HElgGfZlqCUGpEuElDZ+k/VvH/A2OApTtNovt12HXtV
	K
X-Received: by 2002:a05:651c:43cc:20b0:39c:8124:93b3 with SMTP id
 38308e7fff4ca-3a371ba9af3mr18512751fa.9.1788785622569; Mon, 07 Sep 2026
 05:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788765185.git.zihanx@nebusec.ai> <ef4076c94466ea4b147653e2b7f933778f245437.1788765185.git.zihanx@nebusec.ai>
 <20260907121830.GA647811@shredder>
In-Reply-To: <20260907121830.GA647811@shredder>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 7 Sep 2026 20:53:30 +0800
X-Gm-Features: AcwNN1Uk3i8a39rPmzWaebzH5pBKLNcdaTlZf_kVKmdapl2vlm677TXmYyaCLb4
Message-ID: <CAANe3eSV3JYqzjnEE+vVmTJdC4oUZh8v=9vy==1xE9H9+YkLEg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] ipmr: account multicast table and route memory
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Benjamin Thery <benjamin.thery@bull.net>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 8:18=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Mon, Sep 07, 2026 at 08:10:56AM +0000, Zihan Xi wrote:
> > A netadmin in a user+net namespace can create many IPv6 multicast
> > routing tables with MRT6_TABLE. Each unseen id allocates an mr_table,
> > links it into mr6_tables, and leaves it until netns teardown. Those
> > objects were not charged to memcg, so the host unreclaimable slab
> > grows with the table count.
>
> This reads like an IPv6-only fix, but it also applies to IPv4.
> mr_table_alloc() is used by both families. Please reword this paragraph
> to reflect that.

Will do. v4 rewords this for both IPv4 and IPv6, since mr_table_alloc()
is shared.
>
> >
> > Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
> > IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
> > handling of IP addresses, routes and alternate interface names.
>
> The bots might complain that this doesn't cover unresolved cache entries
> that are allocated from softIRQ context. This is correct, but: 1. They
> expire after 10 seconds. 2. Bound by the socket's receive queue. See
> commit 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len
> limit"). Worth mentioning in the commit message.

Agreed, will mention that in the commit message.
>
> >
> > The first unaccounted IPv6 heap table appeared in commit 4e16880cb422
> > ("netns: ip6mr: dynamically allocates vif6_table"), which replaced a
> > static vif6_table[] with kcalloc(..., GFP_KERNEL). Commit
> > 6bd521433942 ("ipv6: ip6mr: move mroute data into seperate structure")
> > only wrapped that already-heap state into mr6_table. Commit
> > d1db275dd3f6 ("ipv6: ip6mr: support multiple tables") only expanded
> > the table count from 1 to N. IPv6 MFC entries were already unaccounted
> > from commit 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast
> > forwarding."); IPv4 ip_mrt_cache is older still.
> >
> > Fixes: 4e16880cb422 ("netns: ip6mr: dynamically allocates vif6_table")
>
> I think it makes more sense to blame the commits that allowed user space
> to create these tables:
>
> Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
>
> Your reproducer depends on it. And dropping / rewording the last
> paragraph.

Will switch Fixes: to these two commits and drop that paragraph.
>
> Please wait 24h before posting another version:
>
> https://docs.kernel.org/next/process/maintainer-netdev.html

Will wait 24h before sending v4.

Thanks,
Zihan Xi
>
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: LLM
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
