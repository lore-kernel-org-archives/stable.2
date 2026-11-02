Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650322;
	b=jomxfn0CifMSPyw2cZmZ+yziyDE6Aqht/TYPJH3jv6gzR1xMn/y6xgxfS0tDJ7Xx0frV
	 oeRwzCTWMwO6U6PFyvUa4nWo5ht9h37dBrhUUHrbJWEsbLGZy0xiz9KYIs36LHtorYqOr
	 f3x3uUPC+GCGSIsainKrJdY3gR4BrtOkSVrd2LxHSD+vVWcYqdAb8j/lM93W4nPq4UwXD
	 Vn9MdOc0a35+tN6vCowGOWqTG8nne8YJfM8vGmEOBhpmwu7Ue6iHcMl1ABemYXjMATVPz
	 2mAmMv6MsSOLqYv5gS9/0Z4hP8/BjF/J5J7sJNZjR3Zm7ndCyaVj874ZFrFgrEIHiTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650322;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BjDOfNesHUvUYdnemATt3QpEnFnBaEWBJAu+ke/IeV8=;
	b=iD8TjRKy0SMKRNx/m1rOKASPU/g4mwMseHJ3ndiOE3mXtf5zEj3zOyJNNnTSOhFV9Gl2
	 SQNEfykV/apCi30JcgkUyNgutulRLm+GPaAijS303q1RJmWYrax9cGu4/wo0ltpGYEOiR
	 m2f535ezNyvj3IxUgK/L55eB+LuA1baFp926rZVe2qVlhORREX+CEwwFWmn7YglS4Crn3
	 ob+hMcQipS8DqpS6oBWW1ahp90Y/heCanhIQHa2jn/tGjDCzo5kgBu+6n7M81Fk5J6OAH
	 mHQYyiS/dzgnVuFSf6530mH9VemzhjDuRP9ddcUprAHZxngI3TcBVZui/COQ6cs5uSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McxsqyC0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E01606A334
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=McxsqyC0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EED1F00A1D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650321;
	bh=BjDOfNesHUvUYdnemATt3QpEnFnBaEWBJAu+ke/IeV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=McxsqyC0gzl+XOKZisxRUfguzN1o1crXDnXW3AqY7+r5QfqJrmI0DCYcyCe4NmMFs
	 0nb0JSN21Rjz57RKn0QholqTrs+nSYEfCfeLFZgEiEAoJMBSAJe1KqJUKnj4Wm73DE
	 Yp2e68RoGIg1u6+3Z5c0/4I8FFgfR3/nesMk2JOhB5lboYtR0Ed2T6F79PBjuhekMt
	 Yt2o4mwK4Jqjh9k40LpiFAxr6czwwFwURcJmRMEv29/Y6qprFvOu9xEbKoFchQdyRq
	 JGV62si467AURsBWnbZlCraHmNgP1GPy4HIHbgWb1WrFsyIAr192APppSI2zWIuHm5
	 QNYdA2NM0S9wg==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b55859245so53359846d6.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 12:12:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxj1CvL604D2J40Dxw28VyOOpoSRAl7OA7sWvrBvW4iGP4Xguau233EvDKRPZI8r8i/N+7BbWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbiC1QGyyEUG+96IdPDPpyqd6utrfghxwS4kH4c1FHc4Wd/iYn
	Kr9ocIMiRoJd6eMSpiGDJNKs6b91QCyZUcY6zoWB8T9cJc7kX3W9PXeD01srxSCVGSsmQCv8Y+2
	9Cjn7CXSdKYvgB6e7xPz+XkBn6vXx/7M=
X-Received: by 2002:a05:620a:2614:b0:93f:baf:279e with SMTP id
 af79cd13be357-94421588032mr1947387285a.8.1793650320775; Mon, 02 Nov 2026
 12:12:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6FACF8FF-F943-45C8-BDFD-3AFB5C060E0A@linux.dev>
 <20261031055838.60138-1-lance.yang@linux.dev> <a704d458-ad60-43bf-a0ce-3b128b218d88@kernel.org>
In-Reply-To: <a704d458-ad60-43bf-a0ce-3b128b218d88@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 3 Nov 2026 04:11:47 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
X-Gm-Features: AclHuK_rJzE5Yay_lHuYFvz2Gw1cEWyIS737R4EkfHxGw2G6SeGPSgpipiW_eIU
Message-ID: <CAGsJ_4wjGjDoFPz3qWHqW8WTv31AkR_zrY14ON0dLbTZNsohWQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, muchun.song@linux.dev, kasong@tencent.com, 
	ridong.chen@linux.dev, sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	kees@kernel.org, peterz@infradead.org, jannh@google.com, pfalcato@suse.de, 
	hughd@google.com, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	willy@infradead.org, jack@suse.cz, ziy@nvidia.com, riel@surriel.com, 
	harry@kernel.org, apopple@nvidia.com, nico.pache@linux.dev, 
	ryan.roberts@arm.com, dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org, 
	matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	osalvador@suse.de, minchan@kernel.org, xu.xin@linux.dev, 
	chengming.zhou@linux.dev, chrisl@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, youngjun.park@lge.com, gourry@gourry.net, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, ying.huang@linux.alibaba.com, 
	jgg@ziepe.ca, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, josef@toxicpanda.com, 
	stable@vger.kernel.org, usama.anjum@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 5:42=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/31/26 06:58, Lance Yang wrote:
> >
> > On Sat, Oct 31, 2026 at 09:46:37AM +0800, Muchun Song wrote:
> >>
> >>
> >>>
> >>>
> >>>
> >>> Agreed. FWIW, I think Barry Song and Kairui Song would be good candid=
ates
> >>> for the maintainer role.
> >>
> >> +1
> >>
> >> It would be great if they could take this over.
> >
> > +1 from me too ;)
> >
> > They both have been really active on MGLRU and doing great work for qui=
te
> > a while. No doubt they'll continue to do so :D
>
> Fully agreed, we really need some people familiar with this code to help
> maintain it, and Kairu and Barry have most experience on this.

Thanks to Ridong, Muchun, Lance, and David for all the
kind words. Your encouragement is truly inspiring!

>
> Just a note that I also don't want to pressure into such a role (which co=
mes
> with responsibility).

It would be a great pleasure to work for the MGLRU
community.

Over the past few months, we've seen many active
contributors join the MGLRU effort. It feels like MGLRU
has never been this popular. I'm really glad to see the
community growing.

I may have missed someone, but besides Kairui and me, I'd
like to mention Baoquan, Baolin, Hui Zhu, Ridong, Kunwu,
Maxim, T.J., Siddharth, Xiang Liu, Bingfang Guo, Shakeel,
Zicheng, and many others.

It's great to see so many people contributing to MGLRU!

Best,
Barry
