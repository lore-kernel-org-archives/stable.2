Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD43BD246;
	Tue, 11 Aug 2026 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463227; cv=none; b=ABTyVvwI32sNREKlFiavhvSnfRxU5S+Uc+rptsz6+oqKtGFw4znpbM/T1awNcbucaCIRTlz5U2v2EjtTcHxT5/9oJ9SHHvKiYX07Dg8RqHc79dVC2U0TQGOaLAAlX4u0eVN8WQjsG57i4QrJgw/DgOUQOyhQ8z8HzVT4hlkAhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463227; c=relaxed/simple;
	bh=/Eh7qukz5iL62EB3UjaWXb9COdL8SHCLCxRpjaLm9Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXh893ZOAiPlSjUOQuw0a1dhJbdMutrfJDlQhSrKfsre0a9abH1acl6PygAOISf7hcJHdjpw3Pau7HTxscDcIpMabwdH6lELUUq75OjznMRXu5BKKdwxxB76GcW/URRz8RoCRGrVLddIuyvH5R59jtRzzNs7TKQQ65pCex4Bu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHFn8ocC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHFn8ocC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C73C1F000E9;
	Tue, 11 Aug 2026 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786463225;
	bh=P7BrtxDZSYqK7Ssz8XKfAJxDQOQOUT5KYjPUoFcQw4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MHFn8ocCeQOEhOGPaJ6jN8TKjft5g9fx20Amhhisl7KxwJSmlDqD80LYrTW2Ek9iV
	 51j9q/peywZ9i2m6uvclhZlnKa2eAGdIVAdVeDvbyyBoKEDLh9hFIkGi1gOVU5BDkS
	 cc6BnFyYIJ0Ffv90nrDtX+OkOqlb+ZstOCWcsMh0Xh5gl/pgvDbD7bg/+l2agHzqNp
	 /iNsTagc69xUqUpY7/fFSSrTvljIUx4Gu9e9a77pQvOCqHCaHaH+3qqXmBDYnDkIVL
	 iSuoUf8eoYOemo7cBamOpq6heDp/xdTIXZHlUPGPsPYPb9HTuernX8RCKAhP08zk1S
	 ebw9qTpLfKmfA==
Date: Tue, 11 Aug 2026 09:47:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: reject overlong negotiate identifier lists
Message-ID: <antD-Av1yueclXkC@kbusch-mbp>
References: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>

On Mon, Aug 10, 2026 at 03:56:15PM +0000, Jérémy Jean wrote:
> The DH-HMAC-CHAP NEGOTIATE descriptor carries separate lengths for the
> hash and DH identifier lists, but each list occupies a fixed 30-byte half
> of idlist[]. nvmet_auth_negotiate() uses halen and dhlen from the wire as
> loop bounds without validating them, so a remote initiator can make the
> target read past the 72-byte request buffer. KASAN reports a 
> slab-out-of-bounds read in nvmet_execute_auth_send().
> 
> Reject list lengths above the protocol maxima before either loop
> indexes idlist[].

This should already be fixed with the inclusion of this one:

https://lore.kernel.org/linux-nvme/20260804033800.3975537-1-kanie@linux.alibaba.com/
