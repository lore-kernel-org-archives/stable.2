Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124442;
	b=jFINuVv3iX1UETGsSrnllPuS2xsd2nCQ4voVyngqyzrq6rwVtrKHazmTGL3mEy9M7VXc
	 DOy0V7HxVty793YQTbJq1E5pclvZIVW2zKlwklKtf0afKQ5K/KhyR3tLnZ8XM7XtW4JB3
	 oiZ8j5Ien0x0sxbC2B6/62kYqlCfPCM1ISrVJqxSqypwPbWs/yiFfpvIHnk1pYkZ0FxFg
	 DzaCIcLTDr9sLExoQwg96cI5IOpYVpUvNy2VUI5s1XfQJkh8POxwWBlOa5Q/oBuRnJB2F
	 1+g9U48RUwdIRzGUmBwVUm4Rw6naZiadDzKYqv/oKjE5p8x/1ppC7EYCCCwSh7ltODg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124442;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dNbDYzLQNCqxlf+4nrYorO8QI+OKRu/K+yOjcsmRS90=;
	b=cXMYpoNfKe8aDx+O3P9FhOi5tbjEzL364lnBodU4zFf3Sz3Z5fBD+RXeGmuqlRaCl7q0
	 G1dghvguPMUYL18qJiAxh6eztwkY+ku1vEmpunkoOS6GtICGNnlQ00TCeN68vSp7Yyb0u
	 mejvc1Z3Q2ExKBUa3e44eQw7UVoKoA9ZuNo4weQrir4k3qz3MGwI+261V2/tONkDigaxm
	 Sb3V4SsGcFpOfu+/c1yuzk3DVcyOwxZvalYavLoFTZcxnF/lQ8kIKXQMfINNLH/SdmBRv
	 rtJffvjfDiJExFDQt6oyCePnWSpqqLPJ3ArhhGeHwOXQB85+cIMD6k2Z0zGsoYIKgtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ndhlllkt;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9EE606A32F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA9EE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ndhlllkt
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YMm6iQrurkSXVUsqdlGljS4+ElHIs1WT0d+I1Wclx08=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793124435; v=1; x=1793729235;
 b=ndhlllktCb9uCa73MAZ/z7aeLlDPV3RHgnzhw6HB12y6lV5cjD4KgRX7ld9d2go/JErWwPmQ
 quSNjsp1Lbk3qvl8dQOcFisDKghMUmwEHOozZD2l2fmOIA0zHMJviCu0pN/x8TU8DzK/hF4+lrE
 4wysIAO6Qxe0Wymg5DJQI+h8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 126198f51eccdb92;
	Tue, 27 Oct 2026 18:07:14 +0000
X-Mizu-Trace-ID: 126198f51eccdb92
X-Migadu-Flow: FLOW_OUT
Date: Tue, 27 Oct 2026 11:07:13 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix NULL pointer deref in
 high_work_func() on dying memcg
Message-ID: <auDno4JDDyhV1Y4Q@linux.dev>
References: <20261023222313.3979455-1-tjmercier@google.com>
 <at9U2HvyUP-iYOCt@tiehlicka>
 <CABdmKX1mLKEJNiecW+meJ=LB_Kb8-ieeWdZDd4T6rNR9gKuq_A@mail.gmail.com>
 <auBxqU34FQYauoQr@tiehlicka>
 <CABdmKX2Hua321nr9vR=Q7-Uu5N6e2JARtUe5RnC3JFu6aGRqhQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX2Hua321nr9vR=Q7-Uu5N6e2JARtUe5RnC3JFu6aGRqhQ@mail.gmail.com>

On Tue, Oct 27, 2026 at 10:28:22AM -0700, T.J. Mercier wrote:
> On Tue, Oct 27, 2026 at 2:41 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 26-10-26 11:01:51, T.J. Mercier wrote:
> > > On Mon, Oct 26, 2026 at 6:25 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
[...]
> > > > On Fri 23-10-26 15:23:13, T.J. Mercier wrote:
> > I must be missing something really obvious here because I really do not
> > follow you here too. So we are offlining a memcg. We need to coordinate
> > memory reclaim with the memcg tear down, right? For the high reclaim we
> > can achieve this synchronization through disable_work_sync in
> > mem_cgroup_css_offline.
> 
> We could call disable_work_sync() in mem_cgroup_css_offline(), but
> that waits until high_work_func() is done and it could be performing
> reclaim. mem_cgroup_css_offline() runs under the cgroup_mutex, and
> cgroup_mutex contention is already bad enough. I don't want to add to
> it. It would also block the rest of the cgroup_offline_wq.

+1, let's not add more potential contention sources for cgroup_mutex.

