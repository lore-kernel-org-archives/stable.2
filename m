Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D98230BE9
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791066833; cv=none; b=FiRt9lHsQXOveyGsJSG6hVNnIvm2drfCLbe0MeW1Ur+8Eqa52TQy2X/IswsN696E7tcQJTCA3XBk9wZlhiFWa4seShiPop/rArKJookuqo2lYPKAsV2DPdXcMAudT+vpjd27G6n53FnrOEOgPOSVuMevVRvCjNLe+lsSeY691ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791066833; c=relaxed/simple;
	bh=Iw5B8KlKE/T6ZgZzxwbiYRJNkhpfwh/1LOHk1tyYDw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzPyhoQHCN4WCxrf2PVRtH8ApmppOA4UQF4XvGDmuqp4bXL/pBvorFmIov4OvAjIFxMT6MMtNV2I0mgXA9n2dTCJ44PUq73lTf+BP6E3UEEEs+hH3tLs1a3UK47HUk4V42tI2crG/LiL896W0mltwdG7vNUx8P5e1kmlpubCy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmesr5kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmesr5kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B9B1F0089B;
	Sat,  3 Oct 2026 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791066832;
	bh=buIMEO5yBG7JjT4e7WMsoWeyiralhs5IZ+CnN+YdSYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmesr5kteV8ED7UY37GlLo3Kl8+pSKW2SB8aZB2sfcDiEb8JqK6eH0r0XuUp7BQ10
	 BwV8FhoYwlx/dsPQL2cete/ixOY0mxLtpgkD8i169WDQgT6RHQNPunTRPtQ/Fh27Rq
	 PJwq1ch9xCmNazfzC7wXIXBRPQRe4gteiRkVMCKqZhEYq/vzIbVElxSQba+TWPIzOv
	 7osgemTW6p/s8M3Z3dhn+s8QP8fvkjpcUmZQCK6HRbADNVdSz08DfCoAWL5dJUngqT
	 5/QpGjMxJZMOVUk9hZXqcR/57jo+62zrn0Ykb6pKt69QKb3oXezN+RqztU9Svg/Hnw
	 Dl9Ybgl5eg6bw==
From: Sasha Levin <sashal@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Deepak Nagaraj <deepak.nagaraj@baseten.com>,
	stable@vger.kernel.org,
	mfleming@cloudflare.com,
	Kaz Kato <kazuyoshi.kato@baseten.co>,
	Stephen Day <stephen.day@baseten.co>,
	Greg KH <greg@kroah.com>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to xas_split_alloc backport
Date: Sat,  3 Oct 2026 18:32:47 -0400
Message-ID: <2026-10-03-1-daily-reply-0006-re-kswapd-list-lru-aca1f2d5-6-18-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100327-shrine-refusal-0488@gregkh>
References: <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com> <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com> <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com> <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com> <2026100327-shrine-refusal-0488@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > Rather than picking your patch below, I think we will need to backport
> > commit aca1f2d5de17e ("mm/huge_memory: initialise workingset state before
> > folio split”), although the backported version might need to change
> > mapping_set_update() like what you did below.
>
> Please send us the properly backported, and tested, commits and we will
> be glad to queue them up.

I've queued that one for 6.18.

6.12, 6.6 and 6.1 are left for the tested backports. 6.6.157+ and 6.1.188+
carry the same 789763523fb4 ("xarray: honor XA_FLAGS_ACCOUNT in
xas_split_alloc()") backport without it, so they have the same exposure as
6.12.109+ and the backports should cover all three trees.

On 6.12, mapping_set_update() is static in mm/filemap.c, so 62e72d2cf702 ("mm,
madvise: fix potential workingset node list_lru leaks") is needed first. 6.6
and 6.1 have no __folio_split() and already have mapping_set_update() as a
macro in swap.h, so there the call goes before xas_split_alloc() in
split_huge_page_to_list().

-- 
Thanks,
Sasha
