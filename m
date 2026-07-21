Received: from mail-ed2-f11.google.com (mail-ed2-f11.google.com [74.125.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9312641F7E1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616329; cv=none; b=lfr8FGMqGZ5LyEEtxciQIP5oZEXFJvh+ezA0kT7/sNmMVMdVLXhIWDl6WmLX3Hnot0qGNAc3G7bjFR4f+Y73kqFw7c7XeNvwo6XYoPG9ZZMkbrJgVRwNTjwXCmbrsL9E6ug9Bt/vMfeDI3Ax4c4/PU6IVxiUzA6chf9P2GEoUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616329; c=relaxed/simple;
	bh=kDmCTJcMnLlGlTtpiasYMD7OYhBY3748uc7tayBtvTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/cmsVa6LGLPYuoP25PxMEuFQieXsRptbUzj5uT2sEIcjy5cx7uJVFruPqMNdJc6HILof0WD0IWPsrm7aoj/0dQg200mfkqkpGzCMCTLUhcvjgp4nwY/nSo6dozOwqNU7dHSK1cckPdrqFUTOmvFvHuIVPoamGv9PX1i8GO2mDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jm/RhSeu; arc=none smtp.client-ip=74.125.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jm/RhSeu"
Received: by mail-ed2-f11.google.com with SMTP id 4fb4d7f45d1cf-69e9826d38aso877047a12.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784616326; x=1785221126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3JZBqZxKJuu9k0pdX2l/jaWzpywG1mYELeClBvfTN/A=;
        b=Jm/RhSeu1Au3HzwqVs1iRxI13//6j9ULZ87/hDnhiTkw/5xDZHIuDtkjjlWbQSS1fA
         06/aPE27u3DkhXzpbA3jJZkwkTk1lnqDr0J/bzLLm6Ae/p6nqqiM7JGmy0PJ2dEz9iFO
         ZLLMHxhg592OmFbrbQabMZAgBaFVMM4O8WTCzU1Gn3XyL/C8GdIImrEVRz41juTnrR4H
         2uZU6DHJDlYV+CDX5ibOxmsn9uc5W/pjon8IxzsC3C0SIYSNyHeKuKvID5KS4PzPlUub
         5RU4co8lLOwHkt5HYGALoy3uVD0vx6yw22GdwsbbpHguySfTRao+kudd6vKDbioUrq6e
         zxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616326; x=1785221126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3JZBqZxKJuu9k0pdX2l/jaWzpywG1mYELeClBvfTN/A=;
        b=dOkNRmZkNFjIxWsR4gqE2EAYWMt4KVw9yFc/vio+c8pGxz+3X2OoFDdhkr9h92JcHq
         zF9sEuwHsP9AdaZ7OgaUxNwbrZFOmM0f0grn9EP6vI1st8PT9xzjvaqO5FNNn7RakAsi
         T5+RDr7zg8SOLxIVW3RGbWrPjoOvOZcdNEQy611D6zPz281k5ZoJB6+KlHKN330v4EM4
         AnCSqHI+9+Ha2tTG3g1vtcFKLG80WNfJhQ0lA5Y16eUua3en7B0h7lRGfAmqVyZ45693
         cjIA24djyuSb8v2Uh4rv5N44fx0WeMINHC2YOVdGrWHAkhgUzzzuGhjz6VO/9myS0DRn
         9vSQ==
X-Gm-Message-State: AOJu0YzXDLeThVS6SrV4Ma7JQ0gUaUmGHLbgZwRcMfJVYcNC3wESVIK6
	HRtT0vYIgTHg+MKiFgxKhyua1/iOSpuScPZC0r0Zt3YCbmMlUmmb7uKrdFUIy68Y7aM=
X-Gm-Gg: AfdE7ckZJJLHhOXn9LnKVCvnVnzSZ+frefr7WCWLB1DpRhBXDs1r+xZzk7eR814lMw8
	1fYZK2WL64uPdUgvZniZjYLShbnhS2u5bmDpbWXxGd0P1dAuFw4QArAeDav6BoYGGskKVI5z0MD
	8W5wuIbMx8sHX4g9p7WQkUFC8d3CBwTaqtXZvlB/pNFNH7eVFYl4ke7Te0pFhj51XsvbdcnsuZH
	2L/efG/GSDrzzRTuCLPFGwicZBCFTRz5HyGByA/ovWYF8RALTWOOB63kxgnQ8IpfExiomFNH/WA
	dMdNeD+eKXcGqTb8SxM3on1qnP6kFJkjxpuRFOvSvlXdFDGxT0abrW8SSlIp72CkjW4IhS/SkUM
	Djibls/yoVhbxBjf2eL9lNQ7Bnu2wq8qXRABDy3bPO4sPvhh5mkvG5yC96VH4nJ4A4ZWfCyfjpZ
	4/R7ZtUoPoGDUUJGmR6x2iefeT
X-Received: by 2002:a17:907:97d5:b0:c16:2d90:68a7 with SMTP id a640c23a62f3a-c16b4703426mr767068866b.26.1784616325636;
        Mon, 20 Jul 2026 23:45:25 -0700 (PDT)
Received: from u94a (27-53-137-220.adsl.fetnet.net. [27.53.137.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448ef6asm69651705ad.9.2026.07.20.23.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:45:24 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:45:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and
 fixes
Message-ID: <al7zWrJAeYdQ2ytz@u94a>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
 <20260718192718.0008-stable-reply@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718192718.0008-stable-reply@kernel.org>

On Sun, Jul 19, 2026 at 11:00:22AM -0400, Sasha Levin wrote:
> > This patchset mainly aims to backport upstream commit 1b327732c846
> > ("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
> > 4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
> > tests for stale delta leaking through id reassignment") (patch 6).
> 
> Queued the series for 6.18, thanks.

Hi Sasha,

I realized that we have commit b0388bafa494 ("verifier: Relax scalar id
equivalence for state pruning"), but not the preceeding commits in the
same patchset[1]. I not certain that b0388bafa494 is expected to work in
isolation without the two previous one:
- 3cd5c890652b bpf: verifier: Assign ids on stack fills
- b2a0aa3a8739 bpf: verifier: Clear singular ids for scalars

I going with the conservative approach of reverting b0388bafa494.
However that also means that commit 1b327732c846 "bpf: Clear delta when
clearing reg id for non-{add,sub} ops" will no longer apply cleanly. Let
me send a v2 to address this whole thing.

1: https://lore.kernel.org/all/20260203165102.2302462-1-puranjay@kernel.org/
