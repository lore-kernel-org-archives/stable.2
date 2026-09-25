Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6B38758C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318653; cv=none; b=d4W8B9QxP/tSIQ5k8cZ7qOUTqUBZODZuG5CLOA+M7i1O+xaL2RuDW9SrkkRqtC1aqdtoFTR2FvD+jMQg63Y+UYhsMPG4AX81/nUjSDxBCXGQjF60rye7f14QSJLg2UymfRd/oj3ZYfNcnCBgr9BR9dsGErZ/yPikLBlWH2+kNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318653; c=relaxed/simple;
	bh=ZDL1HfNVxbiMqbti4og9R59qDW9u+w06j5ax8qGIoTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l74PcqgdERlEmNVX/8IpVcO87Tx109QjlWaDIUphL8FqTjUvUBKDktOcHcMLWdJSIJShBSATgebEZWCXEiSvezqGRieJGNOMo5YjEPwA3PiojMxNoNYbUvScxHx9CJEQwZEahuLXmTDeucrdlS535dEqVCHKuAppVXys7e9y1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQJ6UFgX; arc=none smtp.client-ip=95.215.58.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQJ6UFgX"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZDL1HfNVxbiMqbti4og9R59qDW9u+w06j5ax8qGIoTM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790318648; v=1; x=1790923448;
 b=JQJ6UFgXoyKpBSbSkUciVKQLZm3rV3z2lGYCkmknd+Mlfo/TYsPlCZHeCO4kkm3N4A/Q/oZn
 daF2UME8Ah0CtwvJuqnEBHBTtDNIX7lDnBqgE3uwrFwJBOO09wyl9MlW2Cnl1T4f5JRRlb9QIHX
 m5mSaOtH+N/Ofql5VFem3Rrs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f84654a804b26889;
	Fri, 25 Sep 2026 06:44:07 +0000
X-Mizu-Trace-ID: f84654a804b26889
X-Migadu-Flow: FLOW_OUT
Date: Fri, 25 Sep 2026 08:43:53 +0200
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iomap: don't lose a failed direct I/O bio's error
 when zeroing the tail
Message-ID: <arYXUaQCgdch5P4s@quentin>
References: <20260924091203.198225-1-parri.andrea@gmail.com>
 <20260924091203.198225-5-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924091203.198225-5-parri.andrea@gmail.com>

On Thu, Sep 24, 2026 at 11:11:54AM +0200, Andrea Parri wrote:
> iomap_dio_bio_iter() falls through to the sub-block tail zeroing when
> the data bio submission fails, so that the rest of the block is still
> zeroed and stale data is not exposed.  The zeroing result was assigned
> to ret, which overwrote the submission error with the successful
> zeroing result (zero) and the failed write was reported as success.
> 
> iomap_dio_zero() can only return an error from a can't-happen
> WARN_ON_ONCE() (nr_vecs exceeding BIO_MAX_VECS, which the existing
> comment there says "shall never be reached" for any in-tree
> filesystem), so it isn't a real runtime failure worth reporting to
> userspace, let alone one worth losing the actual submission error for.

I initially did not have a return value for this function but later I
had to add it based on comments. But I missed the return value being
overwritten.

> Make iomap_dio_zero() return void and drop the error handling at both
> call sites instead of threading the result through a separate
> variable.
> 
> Fixes: 10553a91652d ("iomap: fix iomap_dio_zero() for fs bs > system page size")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---

Looks good except the comment from Christoph regarding the reformatting.

Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

--
Pankaj
