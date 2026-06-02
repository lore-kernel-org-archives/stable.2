Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4222E7F39
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381455; cv=none; b=H57x0Ju1EBvzPzQJst9Fo+HqCPjAkuhIq+MfeZhWRwZz34S84wLNLTeNcaRE3TENiiryASldl0OzCDnQj5pfiQ7N3gjeXXJ7uPNdHzX4yNSGb4MbNV5//T62mFFTYbazDqVFyn3//ykYAcOK74fYnT33DmXfSzyZkx05OEFnUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381455; c=relaxed/simple;
	bh=CWOt5keY58fzK+pE6b4uSIOgyclOO9R7QqSeFSgUI2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUSQfyaevNBsRITtWxk6XrUA8gRFnGI0uYaGjZ0IK5cOh+dDhUzqYm2HQryAEvsLRNiZOR+j+ZsxN4WfZLbOISKgEeCJwkFMOqPtFsCZO0A2Yw9ckLHmqf49c3fJMK0um92rcAIW13UCUQ8jWOvk7jR8uM40+bsOZNKuGHSu5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwIXW8A5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwIXW8A5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA21F00893;
	Tue,  2 Jun 2026 06:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780381454;
	bh=RpAPDmNA66WNnfJ4AvN0raoD8EJGzen/3LXo27lsL7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LwIXW8A54XgAcI8IXyrpZm+VtfwgbM+MIcaueaafGe+QRdiE5JMHpEJmxHr1kjPdU
	 2YN0S/RblTUFchG64dc8VXPIfsussE0UW3hHlkETI6OYtVphfj2KxF+T+0+dwGwRir
	 LHsBOgR+Jd6HuoPLWvIIKbDqgGpY3JPR2vXhGHeo=
Date: Tue, 2 Jun 2026 08:23:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Erazo <mendozayt13@gmail.com>
Cc: security@kernel.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: nvmet: pre-auth heap OOB read in DH-HMAC-CHAP authentication
 (data->hl unchecked in nvmet_auth_reply)
Message-ID: <2026060255-flagstone-salaried-7cab@gregkh>
References: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1e4ed5.f18a29c3.bfe2b.5229@mx.google.com>

On Mon, Jun 01, 2026 at 08:32:37PM -0700, Jeremy Erazo wrote:
> == Disclosure preferences ==
> 
> I'm happy with any reasonable embargo length (14-30 days). I have
> not shared this finding with any third party. Please coordinate CVE
> assignment with the kernel.org CNA.

You sent this to a public mailing list, there is no "embargo" possible.
Nor is this how CVEs are assigned (please read the documentation for
that.)

Please submit a patch for both of the issues you reported, in a format
that can be applied, so this can be resolved properly.

thanks,

greg k-h
