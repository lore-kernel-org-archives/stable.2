Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39A40863F;
	Mon,  3 Aug 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760894; cv=none; b=FHfMLtk3Io4o8G7NL3dpPZfGmZC2CkGgH9obium1BZVLGZnqM2riDCG8CXHeHm7SR79b8hwm/Cw1JxHWVl3bdRoccpofGVMokNxBBKckwvdIQAWA0V+heaFrxrdgcHkR3oMMQFa0Qyh/2iKgwqPJA3C6L4L3x35aoi/x5e9E13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760894; c=relaxed/simple;
	bh=kypzo7PFHTb54fSWPg0/qSCEvrKo9dGfjSskWQPRFe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H15XunLJTGtTxXgRxPLq6pxawkSRzPVzqMPiHZ13LYTNefJxQFoJ/IHJkswQIeVUgO1jgFOdJXn/ax/mUuaxcyTXKSWtrDABg8pKnzGJAfA0NRrqfU/8A4tZ3FhnDDUge8nL+DkmPWVWdhLQoCV7gEXdLehrsniRA6sIyz2RVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nRRciwV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRRciwV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9EA1F000E9;
	Mon,  3 Aug 2026 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785760892;
	bh=ME3Zdz9emkMdk1R03uGxVGvNkwffgrXocrqjgRXIog4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nRRciwV2sXhwC1LMWtfhgpL2JHRHCvWTBoyiPN8xXZ6/gKQREBCdXwKgYHORzjNRz
	 /KK80Zx9oP9k5KBO5GN9Al72qxc2pZI/QhFUrZUeZTCqTStkCnEMZY1wiCNNZcE6xA
	 CImxdytpQvCTZMrH5SI2KE5kGj3UFuKuDs7dKEpY=
Date: Mon, 3 Aug 2026 14:41:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH 1/2] tty: moxa: unwind tty driver if PCI registration
 fails
Message-ID: <2026080347-diaper-uncloak-ced0@gregkh>
References: <20260731161809.45066-1-mhun512@gmail.com>
 <908e828b-1fbc-4a44-8718-f0e7459b6ed1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908e828b-1fbc-4a44-8718-f0e7459b6ed1@kernel.org>

On Mon, Aug 03, 2026 at 08:06:58AM +0200, Jiri Slaby wrote:
> On 31. 07. 26, 18:18, Myeonghun Pak wrote:
> > moxa_init() registers the tty driver before registering the PCI driver.
> > If pci_register_driver() fails, module initialization returns without
> > unregistering the tty driver or dropping its reference. moxa_exit() is
> > not called after a failed module initialization.
> > 
> > Unregister the tty driver and drop its reference before returning the
> > PCI registration error.
> I think, we should remove the whole driver instead:
> https://lore.kernel.org/all/2da84e36-7ac6-407d-8e08-edca82f4cbce@kernel.org/

I agree, I'll submit a patch to just drop it.

thanks,

greg k-h
