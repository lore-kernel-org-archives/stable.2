Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459212;
	b=cFmUr8vOky+YKRnKIb9nLEtfYyuQj7eXCWFBMfjOefQJKOrTIeCs4Di5NCFD2d24y1We
	 VuICOA/O8ZpipX5ZUcTpTs5hiGNd+wDJbfqEqPgDixkBI36X0bvn0uNrPRBfksKZhufIS
	 V4ZiRTOvSWQ9/iO93dmT2taOmYqVbYDEJfl4X1YAQRyG5MGFnfjSl+FPGNEm1XZAXcUjz
	 16URX6oSj8YUueES8IguHU8NPU/8coS4qSFNG83Ic2o6lACl3mNrGmuvst3DeFSe+rJqQ
	 wKZqoV3hYq5fnmSYpLyo7EyaPHaLAe5z8thj5Fqf30bIjQoJlHqm8vE1xey9TnnoW5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459212;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mdN55TTbw0U+5htfZUR2VCgK6iVR6j3/f8Ws052RgS0=;
	b=f6C0/hNDbDHuO7lv+OQxdZW+3nyyoene/sV/v/9T60TtOLkaZ9qUbOPzvR1YMxtjBc4O
	 7Z1Kd4n5ViL3Snxum4HktuDrRBlxlxZ9kZFhVq9s2UktpXHDSfhKLpx0rjQZjfuW5dQNp
	 TucnWRqf60q66a2cgH1xurjg2CrfmRoq+HoXpVv1sMPD2p7Vb0ZXoqZYuLQSkSAszpPKN
	 Vw0vz0amsQyn6AvNrKc1BGi7etNottXY3Adgxlg1fOL35vhGiMcaQZQVm3CtyL2gAkbPC
	 xPrRcTtemxMevaHSuAeQbobYCrFAHN3ePuzo0CTtc2PR3kSsQDNbUYHZemWdnhdvQSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7OGn8fG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F78606A32A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a7OGn8fG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1DC1F000D3
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 01:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459212;
	bh=mdN55TTbw0U+5htfZUR2VCgK6iVR6j3/f8Ws052RgS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a7OGn8fG461GryeWDftKmbd0r9jq4CpnKIo5bj2PLMkbPJjsPCLgd7XOfkQIG3mzk
	 cOZ0S9YCTNLGDXb1KAcKqsE5jngLbN6/VW5YPAMubSOuEnJ+f43Le1Y2j0LlyJzlCh
	 I8t5kfaDiMrjvzKulC27qKJggdJ9kgulsn44Z6pWXi36mA/X8DkMYdhhhRPnPHDT/K
	 c+0IIDPUxiQ5S9D3aF+6pTJc//erkv5HIkIE2noCEPNqKEMLbHsP19siEFsxkEzhSV
	 XwAWTouTdRnzRhA0N6BaTvPa8R6NGK5Ta+NywuL3o6CK1D5LQ9sM6gth8ONqKsKUBQ
	 XjuYw9FexNCqw==
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93efc0452b5so173411285a.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:20:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByD9Qvkd/H5SJ1vlUMaskkI+DXpts2LSCWdYdVn6IQrCiJsCZyF60C7vJSOH3VzQ47XDaXexME=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmR0yas1y5e7Nfbl5+CQ1IhK9XngfAwuGnxfeU8z86j4CAMEr3
	Ijk4ECyFf9Ti7N8VBIPvN/cwdY9KuRlUE5qSB3LCdGRsd8InvjI/0d0HOyrsMQsP1E5JMdWu/sJ
	I1vF/D9G3D6P9uUy5vJAVXFCHVNAg8PM=
X-Received: by 2002:a05:620a:44cd:b0:93c:68f0:f09b with SMTP id
 af79cd13be357-93f29b7fa3fmr1545675885a.5.1792459211376; Mon, 19 Oct 2026
 18:20:11 -0700 (PDT)
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
 <CAE5sdEiq3bY1kgMUQ6x7RRJCx0JH4sQ9Z_a9_YQSM5FKNwpk8A@mail.gmail.com>
 <CAGsJ_4yZ3rueVMaRJ_+25Nnab0WH5ZLQeLjporWAFj7xJnJFHA@mail.gmail.com> <CAE5sdEjFgVoQbWw12=+AKdCOB9cWm-akxzbX7hJzvyO3vpCtgw@mail.gmail.com>
In-Reply-To: <CAE5sdEjFgVoQbWw12=+AKdCOB9cWm-akxzbX7hJzvyO3vpCtgw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 20 Oct 2026 09:20:00 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yrAosgxnxqc18qXyeJQHszYOdTxJw4TzSJqp10YQWjag@mail.gmail.com>
X-Gm-Features: AclHuK9xt7Olf4mZCtGBt5rmDDZTYfTK8Foa3EtnoHBlxoLgp0J3AiuCJekg4AM
Message-ID: <CAGsJ_4yrAosgxnxqc18qXyeJQHszYOdTxJw4TzSJqp10YQWjag@mail.gmail.com>
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

On Tue, Oct 20, 2026 at 9:02=E2=80=AFAM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
[...]
> >
> > Thanks!
> > I guess you mean the following:
> >
> > -module_init(kswapd_init)
> > +//module_init(kswapd_init)
> >
> > Yes, I can reproduce it with the above as well.
> >
> > But kswapd_init() is definitely called before we enter userspace,
> > so this doesn't seem to be an issue here?
> >
>
> Looking at the callee sites of get_lruvec, all of them happen after
> boot. So it should be fine. Anyway code clean up will address the
> issue.
>
> > So I feel there is no bug here, but this cleanup is still welcome.
>
> Are you ok with the patch as is, or would you recommend  changing the
> callsite of get_lruvec to mem_cgroup_lruvec?

Overall, I'd be happy to see MGLRU-specific code being removed.

If possible, could we split this into a two-patch series? The
first patch would be this one, and the second would drop
get_lruvec().

In any case, if this isn't a bug fix, there's no need for a Fixes tag or
a stable backport.

BTW, I've been struggling to understand why MGLRU introduced
its own version in the first place. Maybe your follow-up
patchset will help clarify that :-)

Best Regards
Barry
