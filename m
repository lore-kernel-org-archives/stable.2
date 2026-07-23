Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E83345CD3
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774584; cv=none; b=Po7L+xWu6/JRYeAU5rKU787DroUhLnaQHoZEV8+WGqq97ZWcPOqWWL6J8qSrE9IwxZEi068Y8JfXL4Rm0mB9yaRunxkqBJrPgK/Fogkp/8rEwrZ1xj/pwqqo41ez0Jg5m5MNWTS5Oj3IzQj74r8sW4bpbOwYtOswLDoGWx0qlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774584; c=relaxed/simple;
	bh=bpSmhtGwFeMOPobdHhbNHkFPFgQbhVSGsS1PrwsC3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzHHDQ08p/4xa/F2eMyfT3KwVoAaCNnU6rTK9LVLBLOaw0qmvQE+6FhN51q+uimQr6yd6EoZ8dX6uHLSOm/xRrIAuKpz5SdO1I7m2v1jzy2Is6FzmziG1wTF+BNYXEDYSAOn4CcStuuk7lTLo/3w1U4ZDa1vAL4qkyv9iNxryos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cxu/M8kr; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxu/M8kr"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15b719d71eso12231866b.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784774578; x=1785379378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSVaMA8i9SCUOwVxbzkmaNsdv3Zk1rqWeSYxDOm9nrE=;
        b=cxu/M8krv0NB6R0msa4gqNfVJ0d/Sp7wDT9ujWigWjrkZwKuDRbCgy/Y/EC4BAFpMP
         JZpGn69caulE3hg+rZPOTmNkv0bX+o7a5gRivzDHruHBmUJZrPx/eKei8uG4vCoCYKiv
         fFPJlfttwcXFdXbSLFBMc0Limh55EU4d0ybR79qHmbcPOTu74Zy1hjWZ2qVKN01ALOWT
         L88Gzr61R/QohOd6FvwDz6GAM76TVNHPExsBPs0XpSbJg6oQ5EBHRVFWvBYrF9QAjWIk
         sP5BwXnsj9a44iWwdNnZ6GpzgbIPhtST/wZON8uiQisdxWg6bDHy09nVMl/eVtNK4W6o
         0K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784774578; x=1785379378;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSVaMA8i9SCUOwVxbzkmaNsdv3Zk1rqWeSYxDOm9nrE=;
        b=rVhmiWomsyLHxk+dg8lqVMkNy1tL+Ddg13h71eNihKWLUjXTcKIhfUpC+YgxFMxSkE
         T0tMBCi4/jNbs6JdTxNvqAiPixrLndn9/rWjJlDl/faTdAEPNCmyXAivjkywPQWAn2Hh
         eizVa+JAhBpcHJlBg2+VOWT23ognJFlwXe9n04vu985WrOlN9TjFsarVCzIaJ7UH3SkN
         v82ycX7OfBFBahd6brNZmWG/uCUulq13VHFKChHrd2vD16clNtZq7UHmDgIMvUsZaBcx
         7qGq/nqwHuzK9FQVEHDZDUkg6H5ftk4DkpIMoWNFfWkUmpxzeBir4AxblmkyAETEpriZ
         d3ew==
X-Forwarded-Encrypted: i=1; AHgh+RoIS91BP7LWuRDf54ommKgi3Fbn3rfxX/Yf84mBK4iFuXZTmK3ivG8iC3kjacgmhzQyoJtzoE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAaMT3nHOqJjmtqnq4ceh5hf/52AjnULO6Bs675ZNuxlHhPlV
	DWLHNVPMtXvMgUgBV3ZIUBFiG4F00kiCkkc8ZwcVnZpksnJXYiEZSQ24N5nExptYE9+eJNeq5/f
	uWMhJ5Bkw+jNo
X-Gm-Gg: AR+sD13oRjuwIICoSeeNKUD+jG4KLxBYR7YdkUfHZ40EmEt5k/qtwcPnNlnvhYJYas4
	bNZKWRK0OHOITxGbyDHZGac/ojm452l6ZWpEYvmVDfX3FJMBC7tw92Bgmy3w/GqpC0ea3Cq3ap2
	wRBvtMV63kaZg7jcjqgMRSqXRbYtRPKvxl+Zi2+ekNPO5jWUjx+tpZRYOB67E08NFnByfi/XmdW
	PfEEDkV1WZ7/KzX4MDKhRHJTj2BmnhGEtQhpTjUt27yfMu5BgKD51qAP14npUliKv/Xg4IPmBa4
	K8fG7r+sWwBRnqoWAbSwR7P2++s+deZwdqUjUpHonPyCb0+vxsdDOp+uxVIwPw9TLjdKJev4ZEC
	z1SYVkRp3A2UJ7KMGd7hmK9CBNxiYbk3msT1m7HvfO4caG2bK/nwHw5SG3Le4vBKGJ4SbH4ReSd
	hWFvrPmHUv7W2y95F55TE=
X-Received: by 2002:a17:907:3f0f:b0:c19:6ac7:89a3 with SMTP id a640c23a62f3a-c1c509344b4mr50914866b.37.1784774578177;
        Wed, 22 Jul 2026 19:42:58 -0700 (PDT)
Received: from u94a (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd80cfsm23869135ad.25.2026.07.22.19.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:42:57 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:42:52 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and
 fixes
Message-ID: <amF_Wj2YpJy4iQ5U@u94a>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
 <20260718192718.0008-stable-reply@kernel.org>
 <al7zWrJAeYdQ2ytz@u94a>
 <2026072146-apple-condone-0ef6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072146-apple-condone-0ef6@gregkh>

On Tue, Jul 21, 2026 at 12:18:03PM +0200, Greg KH wrote:
> On Tue, Jul 21, 2026 at 02:45:15PM +0800, Shung-Hsi Yu wrote:
> > On Sun, Jul 19, 2026 at 11:00:22AM -0400, Sasha Levin wrote:
> > > > This patchset mainly aims to backport upstream commit 1b327732c846
> > > > ("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
> > > > 4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
> > > > tests for stale delta leaking through id reassignment") (patch 6).
> > > 
> > > Queued the series for 6.18, thanks.
> > 
> > Hi Sasha,
> > 
> > I realized that we have commit b0388bafa494 ("verifier: Relax scalar id
> > equivalence for state pruning"), but not the preceeding commits in the
> > same patchset[1]. I not certain that b0388bafa494 is expected to work in
> > isolation without the two previous one:
> > - 3cd5c890652b bpf: verifier: Assign ids on stack fills
> > - b2a0aa3a8739 bpf: verifier: Clear singular ids for scalars
> > 
> > I going with the conservative approach of reverting b0388bafa494.
> > However that also means that commit 1b327732c846 "bpf: Clear delta when
> > clearing reg id for non-{add,sub} ops" will no longer apply cleanly. Let
> > me send a v2 to address this whole thing.
> > 
> > 1: https://lore.kernel.org/all/20260203165102.2302462-1-puranjay@kernel.org/
> > 
> 
> So should we drop all of these from the 6.18 queue at this point in
> time?

No need. These should be good. Thanks for including them in 6.18.40-rc.

Thanks,
Shung-Hsi
