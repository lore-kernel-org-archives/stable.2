Received: from mail-qv2-f13.google.com (mail-qv2-f13.google.com [74.125.230.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DD39793C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701706; cv=pass; b=dEjjhSbIXKdVg8c3k4/xQcsOT6sY0QvPwsw/IvN50MyakUrrWKPTWY3GBZu9mt5B3aJxR9eZ8rc3LYhZuQ5OZUkoCJPeIPP7HkoEZNlvp5sLe3hfAJnzsRoLo7B7vYCT7pbhJSGpVoSvXQg+F2liojYjHTNX8WBGyGdmzs4f9yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701706; c=relaxed/simple;
	bh=rmTCDex/Z766FtnBu7Ba4CV3FoVdwmvovlkUigV94mw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+jTR0fNPfLlHCbmRIey9SRLbnwsKV0fsRGfM7kh+pVgRZVtritcHxlDoc6VdL93Ee7jaTL+9IwjdjT/qd8tnSSLjL7qbHe23dVyuzBqKrkNORWUAiyTFPKw/14XlXhbjBnt//H23r2g7vYoyGgbMyh+saI1NLEYCg+SMydnRJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0QJYxs6; arc=pass smtp.client-ip=74.125.230.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0QJYxs6"
Received: by mail-qv2-f13.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so3724176d6.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789701704; cv=none;
        d=google.com; s=arc-20260327;
        b=MxY/o8m+dfXhIsFh2hzV0FV0QfoNkbc9e9TvxOBmwW1ajoJ5UdHVM2kpk6Aq066eQS
         ndalfBt6FCKu9JVG3dUmGlyqynetChmEw4G/VsFRhlyAmt7BPTjtGiD4fAfUJb0GntOL
         AJCFMRHpb0v0GfbFksB2dSumem3hL3Eh05qQVWPcr2UXpFvbaCUwyh4tTNBz8iLjdfMp
         wEKn93tOaHlQOhrlVkufc026CH9hbhhSoYWb6DJFKBKr0IxTNhquxq7lGw1ZqxBl0wP/
         ktF3+6zMQfyUz6Yhev/YZGj/lBCH7IozChw7PFZADXKr++Ap3Y2rtD7FekCv3/b7+bxB
         130w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AKLDi2InWGreAxz5T4V5Lg4sL/lYAuzfpcW1EZWy0TQ=;
        fh=rrkQ2Lo6T6kGUCoPKmgCZks/hk0RplmwLgyPU1nE7pU=;
        b=RsF5qOOn8dSrveevyYaMzPNQa0lxADw066ildUBCjhKcUUszR5bqztdLobSak7cp19
         gVmx291H0j3twTZ4+L2MFdY+cuOhnjkuFLMPdDxcqBfEu/FESvfx3RDnzCOh0rNEZCC9
         a6rSDyCO0f3LOCsS2PHUzDGYNGD2DagFvKtZ0S7c8Om3/cTT64eUrBqLJ3mhjqC5f9uc
         fZYLzZUttIhjuNP8NvIYUNA1wnYNry1gNnc6izikuips0wZtbZ0a78ClQZeQtrrK6QHc
         UZu8ctkWL5OvaynltciYWuxBWukQil14Oah6lyDnP3yf68FsZpPRyNFTHR4OIbEEFgar
         jw3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789701704; x=1790306504; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKLDi2InWGreAxz5T4V5Lg4sL/lYAuzfpcW1EZWy0TQ=;
        b=k0QJYxs6KuzAjvp9mY+SBJKxff1R2KzdiUnWvh1kxAlAbqsJAMq3PJybQDLhDqKqnZ
         8rDeQOqi3l1B/WPwN6C/8R/VMd6kcpXGsC9IcEX2RF/Y4C+KwA3DJd7WenAvBAGkc7NP
         MUZEdOqb1VBz7dSpOQ/EeybiMDfpwPT9LwsQu2sUV4ciyd98WeuwWQx1k26/ZBrwoS/J
         6GMFnvWvBMjCW7LQwc5UJBkwh1drAnZuAwKqWvEYbuKGGpIUgWpiV3DhT1PlkYRu1ES5
         E6Fy01MPxuPGApNVDAWhX2WRCHUGGP7r9HR2N1YvD/i+IPogvozPnBOrH5jwoIQUTLZj
         nAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789701704; x=1790306504;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKLDi2InWGreAxz5T4V5Lg4sL/lYAuzfpcW1EZWy0TQ=;
        b=p4C7aGHus3I8g7glU4Kr2rgKNysWYVkhZ7YNDVYomPB/KQ0lcV0vztv4s9mnC/z2vO
         Qfosc+6Qgrey8krjraLnypM2ccpXC+4b72udD7oe4707OJt4TLUfFw92fQWORLJ5uV5Q
         og9IrwDF+CPxDBI7YpV7k3GPkB5wW95oivxHErZBpW9dz2DfNwGXRknxnmQCAUfnnNEa
         z7wp+iYG7l2XBaXGO498u4nMsja+9msjM7M37VbK1/Vms6OA3YPPeSgrZyIdEqHq6mDo
         5Kvxa7C8UjpqvEDn/4fUQwr8Qy65Tsy/ENNEHwc1OcpL1iFXc0bY0TQhoi6zkkl+Xz8r
         ZNpw==
X-Forwarded-Encrypted: i=1; AKwUvBw6jl5tWYzCDnO84+NcE/z1n5stSIQkDAOvb6lJCp2UJoku3xYAMkLPkkki8a0mi0MY2mR5CrM=@vger.kernel.org
X-Gm-Message-State: AFuF++kK64hs1ujrwI0tzGuhcCZg7Lthnl3d6yEm9VYIo5r0quZU/kFO
	jdVs2lx3/GEqWeaPETegYJHrsKqW34ga7ZNg2FAq935b/tCPA8mnky5DlgW+zQbTkGxR3cuuu9k
	0QKjgSfIfjJbhGi+TNHLAVNeBhYfCWWKzFZ7a5Iqc
X-Gm-Gg: AYBFou0ImUoNKHfYaHPtWc9Ioi/kV+TOKAVZWCq7q+1G0j3Gt7g5xSxrTd4FponwONG
	tBamF8zLbE24prEMdqQe0FCr975qK9izT3/5xSQTO3Fbnn+pggURxmzDfUVNzo0V7kRI7JHUC3L
	Y9G13gQ84ZPnQkDXW1ZK/NHZc5nfKbHmS/cp6QW+quRNkqdOltwMtj4hL1dZ1Oee7ThI+3qjyW+
	tdIDBHneAAnPg0gRNbpwVBDiz3b1rOscxq7q98qng2nolJ3V7BjapAiC7z99Xgf0L7JDgyoM5KJ
	OqP+8PdJ8G77SZr9yPQ0BcL+hCRVhKefTw7vOKy3Dn3N25KgnD248PD4kq00en1dt7AS6z9Qjew
	tOq8da1f/w50=
X-Received: by 2002:a05:6214:2f03:b0:8f0:d59d:78d2 with SMTP id
 6a1803df08f44-91254b085edmr20535346d6.5.1789701703240; Thu, 17 Sep 2026
 20:21:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Sep 2026 20:21:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Sep 2026 20:21:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
 <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Sep 2026 20:21:42 -0700
X-Gm-Features: AcwNN1UmZTajHstBlVwK_8w-qiRF_BNJfwUwN_LNEwXV7xnF5kJXV5qm-KLh0ag
Message-ID: <CAEvNRgGDOG03=faAE_ZA1aHQ7Za8gShUUd=h+J0xZ2f2FaWF0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, Alex Shi <alexs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com, 
	jthoughton@google.com, rientjes@google.com, vannapurve@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Andrew Morton <akpm@linux-foundation.org> writes:

>
> [...snip...]
>

Missed out replying to this!

> So if downstream people (-stable maintainers, others) follow our
> recommendations, some kernels will get two of these patches, other
> kernel versions will get three and some lucky kernels might get all
> four.  Are you confident that the patches can be split apart in this
> fashion and still produce a good result?

Would it be better to add Fixes tags such that if one patch is applied,
all 4 are applied? How do I set that up?

Patch 1 is kind of a fundamental fix in subpool accounting, which allows
other fixes/simplifications in different places.

> After all, we're sending
> downstream some patch combinations which we didn't test.
>

I think patches 2, 3, 4 would kind of depend on 1. Without 1, the others
would probably do the wrong thing.

Or would it be better to just squash all into 1 patch?

Each patch does fix a different part, and also I didn't want too big a
patch, which would make it hard to review.

In terms of bisecting, even with patch 1, the bugs fixed in patches 2, 3
and 4 would still be buggy.

>
> [...snip...]
>
