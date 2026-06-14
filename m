Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C94317D
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781410446; cv=none; b=NdrI/lx94Bfzt1IRml2rdHNYpDwLRKKsVxmQ15ltzV4e90PhlKI32qRxXOtn/Vigr7/6K2kJ1kw0gb1ltgBBYrev1zQjORjSnkHRdW2gQNvC/nfzQu/Fk7StFjSuhll6//UnB1q27UHR56j8RFQuj2xWaxUlkdahg6GYdToHyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781410446; c=relaxed/simple;
	bh=pAoJZnjBXYb/Y79ehbxsVZc0W3B+3a1UmShPJr+8lUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIMxbl8IBb+lR5qofTaxaYn+jO4Q+oVxvj5Uq8Y6/5lxc1N2MSShK30X56eTOQOfZo8EqRkpHKlDTsQDmlyEWXAco9RL140vtaSa5H+zmaw+j3gp4WAvI12atlnW4534RIsPgoXfUbdyisG1qpthLoHfF9M0Kl6xwnTnq0lFMnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSRqY7FK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSRqY7FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779D11F000E9;
	Sun, 14 Jun 2026 04:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781410445;
	bh=8ztIp1EnB0i0L59Dq65EK0EwBK/UElwyGVDQXT8QwVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fSRqY7FK/yeMrrQAlmAvXFDoMC68LrVk4tWNmkMDn0uYDcJ/pNebb0m5rePuvRtqy
	 VZxgKqbk8p5CxBt7fWi/fB0LTig3XVMRY5E9tAfYDURujGIKHfULsmUsQhGCIr14Ze
	 S5q8px9eZLnQWr0+Zfbej4Oo3iJftSCpDrPMf2AI=
Date: Sun, 14 Jun 2026 06:13:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Clark Williams <clark.williams@gmail.com>
Cc: sashal@kernel.org, stable@vger.kernel.org
Subject: Re: Problems building RT stable for v6.1.175
Message-ID: <2026061424-spew-jumbo-fa78@gregkh>
References: <ai2vCqAXVEMQJDOJ@demetrius>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai2vCqAXVEMQJDOJ@demetrius>

On Sat, Jun 13, 2026 at 02:27:06PM -0500, Clark Williams wrote:
> Sasha, 
> 
> I was having some compilation problems building the v6.1-rt branch after merging v6.1.175.
> I'm building on an up-to-date Fedora 44, using gcc 16.1.1.

As you have found, gcc16 doesn't build this older kernel just yet.
There are lots of patches that would need to be backported.  If you wish
to see this supported, please do so!

thanks,

greg k-h
