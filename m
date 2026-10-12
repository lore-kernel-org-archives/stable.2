Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353503E40F4
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800271; cv=none; b=HOSCTMhK9KONFcVF64PJZWxZM0e0vfGGW0usv0HNvLPWnut91qJDRHBoIFIMPzSC+Og2MwnbxiDAZMt9z0ITObfQvJxFOpBXfmmbIkbepV90OkL4LbcNsymeip62oMgQbvBfIUpmBbRfnPhJVwU1oLp98uKJaVebqlWKNZSftw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800271; c=relaxed/simple;
	bh=Wjt9xafsmJwRLm+t7Koub+gEcsrwTZctZnayflAgvz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7f8tRS/G3/sKD2gBgUiTu3wGOXV2oOnHgBJrPc0AU8VVL2Tt7NU4cjY/0cS3tHBr3LuFoUOe+0s/MTDfQ3OIPjXKZcnFPTeW8VyTd2NBm5GC/xEa/C2rbZowRK8tAo9oz7QWG3VmdbEh8hz4i65L2/G3cerDJl0bkpgYo6+J9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boUbEq7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boUbEq7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79771F0089C;
	Mon, 12 Oct 2026 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800260;
	bh=6W9w6FX63BCRNL5Y5+uTi7NjbH9MTl+NIN066JxPdjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=boUbEq7QOkVayeZfV5djEa96a53ltXgA5Gs1RkcU/5Esvv4rZ+tT4ZLkwaSg+Olme
	 IHJvM2BbrwxBdLd52wt/QcFMqlrTRnBPv3hPGbsA6yPQ8oyF3dxacn7kgdWIgO2tpO
	 BK+8/qI4695zI5FCbwoeLJb3kE0o/NfshFONNz4j1LZrEHjTPM41qVFHeiKI1Dl8bF
	 54wXh5md4VEX0iGTFcXt6lwuqHjgRKyKjxv+NANIRvSthmS+Xe7I09U8kHdPIFi+h4
	 uZBGJ+ttbbK9PAK5HfWkZT+aDIXLVs1KEwXzXiP5AiFeOCj3H7ccsMXnDXybffFbpf
	 tMhCOTQeTUF6g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 06FE7198003A;
	Mon, 12 Oct 2026 06:17:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 12 Oct 2026 06:17:38 -0400
X-ME-Sender: <xms:v7PMatf_AQlmyfcCnYGtsT8jhwo4YI7LI0b6fFcb7FoQw_GcDN4LkA>
    <xme:v7PMatk-W9HXB6o8X3sF3BmBp2ozWmWsyX21nujvlA3O04hjx6eIh2tXHTcvx1s77
    kp5vv-pQIO5t3SrJf3deKmxLMFdSBFjIzPg7BaZecCb5AQk4s8Rc8Ha>
X-ME-Received: <xmr:v7PMavy57zUWBm3JlOJpaqljUxpAic-HNXoW3BDmyUB7CFmsy6tC8xn0LsQ>
X-ME-Proxy-Cause: dmFkZTFtEePNEwvbObMFMgRHgPi1bvtoSd5qbrO694Kd+ogzCGFJMi0UGAD/xTvnHA50RE
    JCM/aLjoQB6DzJtDHwghLRXFYdBkvVdisA5BKYNM51m7QOeq/Kv2boQh/coCxEOLtiw8Io
    z3hAUsc1EkJsbOBWpNkKoT2mH3TL+rRQN3Jd7rwwgMesNQAsnBXWR75AuZ89wlgd1pnbKq
    uZxx3ckpzY/HsaWhu4ZNhfvqUzr/kYBIwAn462JE4fNBxYqHAOWaxSA+cD2dyHnjPtvtx8
    T5vucOnKnvh5HpjQD6xc21M7w/4HzHey4lTSRpPxrJn6fsxetQs6a2bKgHgm0ZgQoSZBWZ
    PxyHQ6YmVw30IQBY07qLhJH9r4FyHz6QXj/UOZq/YJHs9l+F/8lWNBt1W2dNie825IsZ2s
    axHRX0B07aM4zLNhwIOM0LVjTNPQr7jY3qhZFEcCe6Hn0VFxWTNJfYaMwyIvpbmKFu72NS
    IxuefQNcRYhgSaProoMZpaBjj3HGGqb2h/eRi+pY2+JkebFi7MMRN5PiK6PoBIA5fxh/Kg
    I6s/xPssIUddqdP9drO7UP2Y9GJOELwEQrXKwVVrAj3HQbx0XCIx7AiX8CStCc+hffmOLA
    rpq1XFKxuvTkBBHb+ytkWreawLUndqwHAr8udpIY6AGNK/yrEsibS6ildKqQ
X-ME-Proxy: <xmx:v7PMaqFDO-D2O46EQrLF2VBylvKOPRY-GbsoNPM5wkdqJ2B3U5KiKQ>
    <xmx:v7PMasF63e87WHczEMM4h8hFe0oTqkOmYztVxDH3VerISTWXVoe1Yw>
    <xmx:v7PMatDZR9O7FDT6A35YiP8MOIAEzKLlUhkMTdKhW85Ybh4onoRc1A>
    <xmx:v7PMar8zp_Q4SBTIMtDI67x3lhTN6r_SPWd0NOJIoJayIISwp0FDvg>
    <xmx:v7PMavfklJSyUMscVdZovkqpOlEaaxkfuJ5sz8dIIEk7zjCBEELyOfLS>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 06:17:34 -0400 (EDT)
Date: Mon, 12 Oct 2026 11:17:34 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <asyzhoDeI3U4T9wZ@thinkstation>
References: <20261009125503.126202-1-kas@kernel.org>
 <20261010154923.998e04e42093ffe6c7c205ee@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010154923.998e04e42093ffe6c7c205ee@linux-foundation.org>

On Sat, Oct 10, 2026 at 03:49:23PM -0700, Andrew Morton wrote:
> On Fri,  9 Oct 2026 13:55:02 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:
> 
> > Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> > storm in defrag_mode"), direct reclaim and compaction for non-movable
> > requests under defrag_mode run at pageblock_order, to produce the whole
> > blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> > still use the request order. An order-0 request can therefore retry
> > indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> > 
> > ...
> > 
> > When a promoted request takes the fallback, reset the retry counters,
> > so that the fallback attempt gets a full retry budget before the OOM
> > killer is considered. A request whose reclaim was not promoted spent
> > its budget on the request itself and keeps its counters, as Usama Arif
> > pointed out.
> 
> Thanks, I updated mm-unstable to this version.
> 
> > v3:
> >  - reset the retry counters at the fallback only for requests whose
> >    reclaim was promoted; a movable request already spent its budget on
> >    itself (Usama Arif)
> 
> hannes's concerns/questions at
> https://lore.kernel.org/20261006081050.GA234057@cmpxchg.org weren't
> fully addressed?  I'll add a note and await followup.

Hm. I believe they were addressed. v2 changes are based on Harry's and
Johannes feedback.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
