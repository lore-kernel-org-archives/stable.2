Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD23EE1D6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621047; cv=none; b=ncXlzq3hEfGODFpghaOekow/6REqsJERC/fe3U80oNOdQ00CExccobMfn0Dhctc1ED0AUif5QrN00DCWCpl2M+2/o/o75Q/OYnzYltDwfqZJjkkY8H6aeHexsiq96sKd5D8iMpkFvTNa9OY5iXFYZ3SNoZeaH7f/WeJr+XzvUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621047; c=relaxed/simple;
	bh=PM6Psgw0LOHdUqYR41tWNvfnOKVZCkA1iAfk9OdjHS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7E6E0O9TMprsi/lufbZXUrmXCw6x4KvQyNe/M8FYHFNfH2nm7VeHcS2mhgI5r6bz2GeBrgIHoFNq8qj04yL03mhx4uocBbNE1JjvzPEzzcBKy5kRbtOrEeubeNpdF99zZHEUBpsgKHT0P5ZwcOsE39w2rOQgqdprXp1K6DcFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YhYcParQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YhYcParQ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c167aa9500dso814720566b.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784621045; x=1785225845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ln8pbd6ZXzhM2Lfnk5v+YSie585FC8L0hWv+/ORFtx0=;
        b=YhYcParQlJoONHV0uzkcpnV8CVE3YNXDX4bacgyMSppSDSmc+pXUphK3qPmf2lKRID
         zgyuqSMtF9pub++pt/aN6R4dR1xcvb5mAy3Bvp4d8rjJvbddgpwUYDlVSIgMuP3Tbq6z
         ExDd27t6W1CbKenbS55Es017cWFx5e8plKVwbFB617DMP/IHduL16TwbbG6Ih+q/Inze
         SLlHAFPsjHoFAB/qeAJ90BtqOtvpa+iGbO4pMuN2BvYJSe1yIlC1YX8MvSNdyQoL4uSB
         wCasYNs2+VlZN1kBz3h7nItQvTjCC/0Xo8B1WPrfdhgQXnAWRYcLjfgsl6MsOGkM6n79
         u27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784621045; x=1785225845;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ln8pbd6ZXzhM2Lfnk5v+YSie585FC8L0hWv+/ORFtx0=;
        b=rRhISIdIWHCsU5dwv0y+BDd/3X4P7wMPDD2pKUuVYSrp16YSNnxL34YX40xTEsjbVO
         4GHsi/Yi0wO4OAmLQc/nL2aIE6mWWAy6E1Whc9omLIIETc5k6Y2ChQA5EA0xGRGSFubL
         HX6owFS3JOUvfMNKII9XfVNyBDjVO2asAgtjLq/52PE0D7/HL6+hi3pfdAPAfFBe2Fjd
         ZKWn7rSIUR54vfs/WRq3Pj4NrOAsGK/5zANfuOwrpG+66I2b4zhYdOS5wacbxh7UE3mf
         hUmtmlX2wTE6Pr7y76TPq3fa77bxtnAz2gnLASUnWbDoLC3A1oK1jSTJJHbB5LENDf/S
         DZOA==
X-Gm-Message-State: AOJu0YytUrrtcfzwzf4uBT9zfQ/0vPNY38YJmx8YDllZN2l0950MKJgZ
	dSHc/1gPXNQqT/B03QKhg5TslPCLGlWlH98YB2XiBSYBeUGx/AdhgCUZxRdK3Pw5MGa4xHv9c58
	NGzCW3zA2yg==
X-Gm-Gg: AfdE7clfN3jnpr9gwNyzSM7s1JXn1Pdx2QPjwh22ZF2gAsi8NEus2wQeyOS7t+dT/EA
	PETVhLBVF7H4IuSbsBs1yWFovCqB+KxmtnZRdSXSmkDwZc1vPx5sLNGrM+aI5bm3d4RVfkjGiuG
	CD1eGAWT8+zlHaXYxi4j7W2CAGapGnT6k2kDo81TfxspGljAdQEwLPkHRfrEGCCf7rwN6UMGTjU
	rFkjF6TlDJhMw3aUxuT1mM8bzRIUna/FuCvX4il9tG9FAF5PymH/WmCkJCdAGPRe3BYJMt95k75
	D3Ma9avXz+1ZyHPHleF04RrHE0IZgd68v8vnNkZ1ACt4B+irv+7lFmJ1s5VuBQGLtp8pnaYZGeI
	/1KOIgnKc5v/8vX+3o9/iQs+V4bb7+KE/ulgALqYFgaPKW2AU7zOS2XaK6yc5PcOfHDsjwXvsSd
	VcILYnR2yLToOiTVdGpeMlBF5U
X-Received: by 2002:a17:906:ee81:b0:c16:9d5f:df50 with SMTP id a640c23a62f3a-c16b4868d70mr678836966b.63.1784621044618;
        Tue, 21 Jul 2026 01:04:04 -0700 (PDT)
Received: from u94a (27-53-137-220.adsl.fetnet.net. [27.53.137.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2abe3e23sm7011304b3a.0.2026.07.21.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:04:03 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:03:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH stable 6.18 0/6] bpf: verifier: linked register tests and
 fixes
Message-ID: <al8ne7ZecARiFQHs@u94a>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
 <20260718192718.0008-stable-reply@kernel.org>
 <al7zWrJAeYdQ2ytz@u94a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al7zWrJAeYdQ2ytz@u94a>

On Tue, Jul 21, 2026 at 02:45:15PM +0800, Shung-Hsi Yu wrote:
> On Sun, Jul 19, 2026 at 11:00:22AM -0400, Sasha Levin wrote:
> > > This patchset mainly aims to backport upstream commit 1b327732c846
> > > ("bpf: Clear delta when clearing reg id for non-{add,sub} ops") (patch
> > > 4), and its selftests patch in commit cac16ce1e378 ("selftests/bpf: Add
> > > tests for stale delta leaking through id reassignment") (patch 6).
> > 
> > Queued the series for 6.18, thanks.
[...]
> I going with the conservative approach of reverting b0388bafa494.
> However that also means that commit 1b327732c846 "bpf: Clear delta when
> clearing reg id for non-{add,sub} ops" will no longer apply cleanly. Let
> me send a v2 to address this whole thing.

Nevermind, this patchset doesn't need a refresh. Commit 1b327732c846
("bpf: Clear delta when clearing reg id for non-{add,sub} ops") fails to
apply due to a different reason unrelated to the revert. 

Please keep this patchset in the queue. I'll send the revert for
b0388bafa494 separately.
