Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FD27FB37;
	Tue,  1 Sep 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267463; cv=none; b=QBNJOCnT3mQafx0yX4G+1hugPbFVDzocgrKV/J86YqEbCEjEp4ZKPoxvOIyKTNKjEBOCHLG7z5pxBUQHMLyUj+coRe/GogYpmOMIRrF+kM/2G1SgCa5uUiAHm1uWWTbs9rauzK71r1dqK+nHIIW7ik53JBgSIz50X8FA0fR59gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267463; c=relaxed/simple;
	bh=yQJELEV8BpytQah2KBZcUtivlnDnBDdL1qf4qBtf29Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfafMkxnFp+cKaTwHJ06WjNSJ/elArrW+Lb889AMwNxR6pnZCIxkAPrfM7CzFm4AyCPhbQ6Y/XjjRqFe2SurIglNGJ1czWD0iEe4BdJvS6aR1ObpnpxFi99rPuEWXPgw0f88UhG/vWZ+KwUmQev6NjjChfeBdViE8AzWEU7lUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOEq26U4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOEq26U4"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 14DCA1F000E9;
	Tue,  1 Sep 2026 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788267462;
	bh=DcdztMizQHACXSuOpHyyHR+J9KrPlQ7rKAMUq2GE7SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cOEq26U4/SQvsuvdaqlnmS59+QbSvhcPMwhQokHGJkb4Wh/aFrH6CmxpuEzlCQb4m
	 VO4jDbccrBqrP+plSxcYkReupOjILbvZKVV/FGb2Nv6jBWzjCVSrdiWSmgX3BA6N8O
	 2pUCbXps74nJA1Pzax5PTGrEHgNL31usojEnpsTH6Q2FFQLGwhCmNC2pFBFYVB++Mq
	 pRIe9CHPMfwt/i1wPJINQ7Uf5qZCp8cbscQoFCqr2qScpCxhrcFtnvyjom7Bun35JR
	 CpCntJCciDXNQwW1IWRMZ5ndAg251NbgR5qQoyDBkUdYGkGrs5f/CPe2pIZpZwDhRJ
	 4jF9GmK3NU54w==
Date: Tue, 1 Sep 2026 15:57:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: MicroFish <f13208471983@163.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: crb: handle ACPI NVS memory region overlap
Message-ID: <apbLwhETZei6Lhi9@kernel.org>
References: <apDseLwm7saXAdbd@kernel.org>
 <20260828111141.1515-1-f13208471983@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828111141.1515-1-f13208471983@163.com>

On Fri, Aug 28, 2026 at 07:11:41PM +0800, MicroFish wrote:
> On Fri, Aug 28, 2026 at 05:04:54AM +0300, Jarkko Sakkinen wrote:
> 
> > Cannot and will not move forward given undefined and open set of gear.
> >
> > There was also a corrupted email address in the CC list (microfish at
> > kernel dot org).
> 
> Thanks for the review.
> 
> The affected hardware I have confirmed is the Lenovo ThinkPad E475
> with an AMD APU.
> 
> This is the platform on which I reproduced the ACPI NVS and TPM CRB
> MMIO region overlap described in the patch.
> 
> The incorrect CC address was my mistake. The correct address is
> [f13208471983@163.com](mailto:f13208471983@163.com).
> 
> Best regards,
> microfish
> 

Please only claim what you have quantitative proof for.

Also this is faulty:

Signed-off-by: microfish <microfish@kernel.org>

I'm not happy with the code change but I'll try to propose something
once I have the bandwidth. Need to think about it a bit.

BR, Jarkko
