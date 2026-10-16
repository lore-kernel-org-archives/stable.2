Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF638C423
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162365; cv=none; b=DMQi/rgxeMcHgmeIa/+eCbpMXjOnwXvM2Sipg1WqTcR2J/9ydwc8VYBu25MgywU3HcYeCVDBOfSk8heEYC1MDS57NdDATgMQphzgAX3R/BPKsql440njKPAYsArvfECQvDZdJFkMFC/1qiH9xpWqEuZnLenQ065jqCCcBbLM4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162365; c=relaxed/simple;
	bh=wyiMk4hONwFxYLA7nMuP0zItich67IsNA/CfSKVmG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmNDdujNKAOoILnnHPufwrb2JIe68h1iW7q+zX9+xc/IM0ndj0/PIII2p0ZFymiNBkL0hzOO+ghbvzn/LZBF/D610BQ5QNVnxKomb4zeigvfxlBuhsPlVY2UZo13WTLVAOTldYZzL4h5twl/R/EcauD9JLqaTAp66WhVYMHlqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zjJ/fB9d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjJ/fB9d"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso51412a91.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792162362; x=1792767162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TE/6RzGv7jJq9CwfLCuEzYgVfWFh4QPtLCq+jerO/7I=;
        b=zjJ/fB9dxeR/PAntykLId6rysjdfqDPYdt79k9Wk0f2mpGN7cqNJVoFewwjTMBx0K0
         qcUQBtatNhVRmhhB1Z/OY5jyDd3FO4FrRbImbvYq0A/GMhZVOPd2bL/NjdMhBCCFohAv
         ydNttxOYaElFTSHVPDdvXODCpDg4XlwUN1aEYXI6X40XAsQumeVtxyHPO9CcoWUV13gl
         hj50XGmo9Lw+ARYDxiBfdLDBuMFg1yy7n9pLCvHvfRaRa2UfUgrVlz2koEd4ep7DBqJ9
         1HjYHyzAESMZbReQpmbW4LJE5XBG2QO/tK2sRKYCb1B2b7sV7NvGfCTG92ZyW5cmfnP7
         N6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162362; x=1792767162;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TE/6RzGv7jJq9CwfLCuEzYgVfWFh4QPtLCq+jerO/7I=;
        b=oqLW2OIAqFFubT62r1qIfFvtYMJ0Pcp8SjuUjF+0fYeK4RZE6Wj44+6+eR3WFYIUxl
         8YORK8aRkV5Wt3HyIrcG+jrPrAtetRKwe+I2J1t7RQqNrpagkDULDKgXvnMCBv8UBDXe
         9Gwk2ywWavcMGPhVwSwnbNxvScEKqUkl54ZyKoKOP0xy5dg9BzPhhUV/LfgAPSD749rS
         77CcFPBTSL7C+eosoBQfHZWenUUHWhyKyZCrcmpjKEjHJT+2rGLlpWkJ53vvNFhEw0Ep
         ScHFMnzlwiytOgfFY6tpii3ZbLj16kSRj/TC90Ag8r5hOqfUrzu/YRptjyyRAqMICbmB
         TcIw==
X-Forwarded-Encrypted: i=1; AKwUvBzEn2zgpEPMuOVPdV33ZHqLgpNGXOPfSZpAmw8AAVEAVVzk7yODUXU876+0n2pFIkmWcevE2J0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK3sS/MOeBm7NjFPqvDpsX50a/yZsatx3gaqjeU1ZdAGlGksB7
	mVml8biblf8KULKHpoVkmDvoIFMN3sx6OY/RFNkUWZTMR/Lo5DCi3rpvfE2YYYGfz90=
X-Gm-Gg: AYBFou1clidHhijzK/SfP+jW7aCqf064i7owGUmCKDsM9thfQ1btLt929ak2DwRf1na
	JAv+7SwYlf6VZjumFZcR0ZuwNzxNKNaLO9nVQ0OL1JmXSyPrCcu3PK0pDvlMsAkjp8ri0xLW04t
	U/A1/H8/qV+v7TctoBlMIYScYNC0SLu64CWaIT12XH8YcVg8bXO5N3kgLN6XchyWj5NDckrjeC/
	8CwcNZzi+qfr5q58gniZvoVqJV9jhRFAoYkAigRnAdxVQOKuXC8NqHuLG1voIf9V4SodeIlYlLU
	cTMPJWr+1QLpEY3cExw3hcDmsLz0CITufooMqlwxwXLtP1g44ZRtU1iqJXB1IrJXALI5MWnnT8i
	QUIdiPnt2XHzsdHAGwu63YOM5jRUS0CE0iEii9jhayMVLAiJDNviARODczHTRPRMurAVIgaTy6t
	p+wOBPvW5+T0+9IgPGdHAZd+g9vjTrCtmFUtHHOsxpDaF43ql1F33tLddCg316gTV/N0GpUO3V1
	w==
X-Received: by 2002:a17:90b:2688:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3acef13e5a4mr57248a91.23.1792162361887;
        Fri, 16 Oct 2026 07:52:41 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff2f:8a9c:5623:f753])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94794dd9sm9514599a91.12.2026.10.16.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:52:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 08:52:39 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Atul Akella <atul.akella@gmail.com>
Cc: bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] remoteproc: mtk_scp: fix da_to_va() bounds checks
Message-ID: <atI6NxHI6zgTb3-s@p14s>
References: <cover.1791198233.git.atul.akella@gmail.com>
 <20261015151938.1331-1-atul.akella@gmail.com>
 <atI5VLH_CiIBu0tq@p14s>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atI5VLH_CiIBu0tq@p14s>

On Fri, Oct 16, 2026 at 08:48:52AM -0600, Mathieu Poirier wrote:
> On Thu, Oct 15, 2026 at 08:49:38PM +0530, Atul Akella wrote:
> > Hi,
> > 
> > Just following up on this series. Both patches are compile-tested only (arm64 defconfig, W=1).
> > I haven't tested them on actual mt8183/mt8192 hardware, but I'd be happy to help with hardware testing if someone has access to a suitable board. I'm also open to addressing any review feedback.
> >
> 
> That patchset did not show up on my radar because it did not include the people
> listed by "get_maintainer.pl".  Please resend with the correct recipient list.

I just noticed that individual patches had the right recipients but not the
cover letter.  Next time, please use the same recipient list for the cover
letter.  I will add your work to my review queue.

>  
> > Thanks,
> > Atul
