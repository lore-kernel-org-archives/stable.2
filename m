Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A063AA1A7;
	Mon,  7 Sep 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770873; cv=none; b=K4chEHHPCf/whVUFTIji41PBHOZDcBL8yQ++FEDxVaLEpmKe1Vbgfu0hH3IoXPHpu2gEzWzs7UXHTEVfN9LFYbkGwmb2H4IRKkT27w9NtHwOtf6WZvctNvG6QGQn/lOrnPLp5Za8TNRY7QaHtvkGDuGFdnZXfkzR9YIf9zsa+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770873; c=relaxed/simple;
	bh=Gb9Auh5ZNXWHXHOOwQE32rxToV+hQ0pGd9M/BCS1nJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgXOv/mPXWs1FvY98inVbGwC7kVq23/C7ABsdiX14gEmESOSogJyk5SNHVbrVfoV30iIo+f7ZU6IgPrCrxD8VXsQBDluqKvAQIY4M/m2wnc1uBNB/+MPtXzLaPcptlB0BrDlae/4nBfIpGW/LM+fya/8QIZA44dqeZJLwNjiwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXZfYcPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXZfYcPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173D31F00A3A;
	Mon,  7 Sep 2026 08:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770872;
	bh=Bf6fIph90GFv45/3lNjQ8b5NbyisSGZ3v2BSDp0jkbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GXZfYcPGffP3RD77IEVgWgvCRjTgLEnnaiZhU1EyJMr/jqZY43VjtzYh05kwvRKzm
	 JTERkAApMJ3DpIFZlUEYhClts9WLzFZxVM5nJ+rQSa7Rj89WAv0WLW25Rh89NCmFb8
	 IQ4gJA/KO/jPqlhoXBe1+COex29Nc+Y7Tut60P6dwZneyNwOCXj8pG5kFztfUAxuQH
	 lci+xAiNwvDJa34AI5vwuRZ745bYHxetI34isufCRjpCN+HsDUyn/AaH3hnZbr3Der
	 av45lPbsG/Cwn0h5E2aKFeCe8MtMyOZNdlV8sK5kF6OAS/NRnUD8rtPVSdzLwXKOW0
	 OQ6p/WnL3piew==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3V13-00000000UOX-36CK;
	Mon, 07 Sep 2026 10:47:49 +0200
Date: Mon, 7 Sep 2026 10:47:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <ap56NTVMq8GlbjmR@hovoldconsulting.com>
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>

On Mon, Sep 07, 2026 at 10:17:38AM +0200, Oliver Neukum wrote:
> On 07.09.26 08:55, Johan Hovold wrote:
> > The wakeup condition needs to be checked after adding the task to the
> > waitqueue and updating the task state to avoid missing a racing modem
> > status update or disconnect.
> 
> I am sorry, but in this case I have to ask:
> Isn't TIOCMIWAIT inherently racy against the hardware?

What do you mean?

Looking at the implementation again now, it seems further changes are
needed to fix the implementation, though. The completion handler should
not be updating old_count. That's for each TIOCMIWAIT to do.

Johan
