Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E8F3BBFAA;
	Thu, 18 Jun 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788961; cv=none; b=B5e91608JaegZMEJamtaYkcdLkYIgEXwxaQP6ZYsdRjxkAp8dBHsjHpyuVsEARg0XxkIObC98EqyPLiwR8w27Zs2XdC9UoQAGqlJkuAW/QL4FfNlQ56TxuAEpdj+LMGdC+t4N0+vEW15bPtQvMEJSrVA3tzeu2TBiol3W78DpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788961; c=relaxed/simple;
	bh=NysP+TsrG+Yrp365dboWfUyVESBqOp4Tu9pUXIzMkcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5tvAnm30Gqt0nZpuAWQ/LHklQLg4QSMhgmPrrIHjQe20Cuq3mwM5dt5VZGiPNCUNt7lVaQUIjI86qGxwIUiXguvqlKSNr5f45GndUtF3HijkBSFWLUaW/QTCTWaCm5hpWt8rwBWYdRFrGc/ImaYtEVJtwJZXUewTzxNTgk0/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYD6SJee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYD6SJee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB81F000E9;
	Thu, 18 Jun 2026 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781788960;
	bh=lV8i9wXYLtkKmB6SEFvhX1sabI/eumkfBUdQpHCA4IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XYD6SJeelUW2NZC203jLPs96X1YbiBk3X3dvRCtd883lRQ60L/mOacl0lsy4820rX
	 pZR+G7rOc5VwKDQVo147Uc0PEkN4IofsXDsaA+HODMPgeKOVEycs85RD9/gQU0utH1
	 wbmhsU/0+1nqCY+BVj5KWiKu99GBjIvsGMcaYnrHNILQOoNjEz7IhX0bqWL3G6OobP
	 PmfpIchh55eo8CjaQaGfRrbFB6ktTJDq7QgM73WuDa0KLYm3A62VM8zeJs7EO1ruBn
	 uyU2mbaglx+aKjUsCf6bKlyrSW+gKe8rrELGalwlLDiiq2LOeTAmLIL4tsacKT6H9N
	 RRPEUuKNkVPGA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1waCha-00000001EEQ-1Crd;
	Thu, 18 Jun 2026 15:22:38 +0200
Date: Thu, 18 Jun 2026 15:22:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joseph Bursey <jbursey@uci.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ad2aac2febc3bedf0962@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: iowarrior: fix use-after-free on disconnect
Message-ID: <ajPxHmA-iHF-aRfX@hovoldconsulting.com>
References: <20260523170523.1074563-1-johan@kernel.org>
 <2026052449-sappy-everglade-4e43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026052449-sappy-everglade-4e43@gregkh>

On Sun, May 24, 2026 at 08:09:00AM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 23, 2026 at 07:05:23PM +0200, Johan Hovold wrote:
> > Submitted write URBs are not stopped on close() and therefore need to be
> > stopped unconditionally on disconnect() to avoid use-after-free in the
> > completion handler.
> > 
> > Fixes: b5f8d46867ca ("USB: iowarrior: fix use-after-free after driver unbind")
> > Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> > Reported-by: syzbot+ad2aac2febc3bedf0962@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/all/6a0ce39b.170a0220.39a13.0007.GAE@google.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Someone else just sent a fix for this so sending a reminder about this
one in case there was some confusion about who was going to pick it up.

Can be queued after rc1 is out too of course.

Johan
