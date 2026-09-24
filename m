Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D6469840;
	Thu, 24 Sep 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248922; cv=none; b=qfuFWCucg2wqWOB/ZTASVUx1me0AioMUEVcH6jLuzK7gk3OQRsJwZP+y4nmFrfd+NeG950Ddg6aNtFIFaOg6OdrhVuNWwsgCjomjQnQLAy4y6S2G46RshUPxlJmkwAkP8lgzQ4Iq3Yjn65IA92FtlBoStOQtAUxLYA1+wd0O1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248922; c=relaxed/simple;
	bh=ZeksF8DcEtkJLGDq/0YPdPOPXMc9LDK1acnPJqTveFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ul6uIoKCFDBYYbut4fB2TIZPQZq+XxNY7DFdd+QBAbHLaCDd3hMUW5sX2Tz9PLOA5Am7ACSAs0/NBtKZ0tm54Asa2FIIofR1xdJewsvdHzhip94nUp8Q9yQzzum5t2rXyiFlAvqhBhVSzJ1KrxC9b1bHEAMEptinE92Hr2cN7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F07yxIx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F07yxIx9"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BE4F71F00893;
	Thu, 24 Sep 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248921;
	bh=UHlYmsPI7MrsS8FFdJPkKJWSjssCp414l3jKo1ZEHTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F07yxIx9ySbB9rrE3Ln3HGmXUOpyLtR6wak2KhadFZcZDTJVpdCEZQS1wxh/H6Iis
	 sPskXAVheNiDPau6G6i0yqsMYcKKlHmcXdcTccB3XY7bWZJGvhNjt1/LaeIaPhnJDl
	 M7/5EA8oc+AedtXLtuUfAT32SxJKCWTywqYe8FdzjAi7/2ofcNdMlY55Pzkw+l1jOq
	 mSLBIPDvye2qh04Avj7aTCNmP+hNMSJyHNDmC0w2IFpYatxDcNQ+yg7VeeEiB39xQt
	 AO4YqIzJJvFoYLgMX12dNLPzOJTDk4yuGd+KTkTCZlGTQb91w/W6yB/JeNZIu4bU6z
	 1kxWDFAb5qEIw==
Date: Thu, 24 Sep 2026 14:21:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gunnar Kudrjavets <gunnarku@amazon.com>
Cc: graf@amazon.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	peterhuewe@gmx.de, stable@vger.kernel.org, stefanb@linux.ibm.com,
	surenkj@amazon.com
Subject: Re: [PATCH] tpm: Disable TPM on null key name mismatch
Message-ID: <arUH1YndAAUSiMu0@kernel.org>
References: <aqykXxFybNMB_KSv@kernel.org>
 <20260918183507.9418-1-gunnarku@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918183507.9418-1-gunnarku@amazon.com>

On Fri, Sep 18, 2026 at 06:35:04PM +0000, Gunnar Kudrjavets wrote:
> On Fri, Sep 18, 2026 at 05:39:27AM +0300, Jarkko Sakkinen wrote:
> > On Fri, Sep 18, 2026 at 12:07:31AM +0000, Surendran Kanagaraj wrote:
> > > The null key name check exists to protect against TPM reset attacks, so
> > > a mismatch should stop the device from serving further requests.
> [...]
> > > Set rc to -ENODEV on the mismatch. The error path then disables the chip
> > > and returns the correct code to the caller.
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> We reviewed this internally as well.
> 
> Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
> 

Thanks, I added your tag.

Br, Jarkko
