Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC23344DA4;
	Thu, 25 Jun 2026 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399471; cv=none; b=TchLKw1kjpX/Onl63tssCS0KNG+pN6ZlYPB6wntmy/16vA41jynnRoXvmole607C0JqSfBV0LyA5e2HowQxj+JETsBZYN1MwTbyoPEsxa3YaY+/H2sNJIRNrFyVPZkKnRxkyOmGaMFbqIeZF0L30jBkCXNUMrgomQCNaB46Z9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399471; c=relaxed/simple;
	bh=kv294x4YAZ+0Oix+anqF2OBcUe8MY3JMsJIpKdpUTTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvj4GXFuxCTmLD/BbmGaOi18OSXDCjzy6atCY3sOF6sbQNVUEehNEYE98mjEAttbdcn+YdbN8ccpbI7hQFC1zWpggXmY6puJnkko0+y19DCWHMTEb2Es/hq81AzNSXEGqcCXqE2n+bA3esJy20LQ8GHtAXJPu27vFejKtZwK7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E19Df53u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E19Df53u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872AA1F000E9;
	Thu, 25 Jun 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782399470;
	bh=GOqinxuII2k9fZezRRO5XQKgi0k+V24HFIXhqb91kL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E19Df53uv0ltXwIwHWXKzpMYpnLj7nMDo6M/d4FGYEoBpkWokmZ0+mRXTc9TW0WLN
	 ik+M2NrX8FPjDIKoJZifYXZE3gzAIYZpWrsBHEwKIEdI14so8BceYl+R8Wwp87ixRa
	 vhH/SklPFoLAIByygNrGmCi+Ejjk66JmcFBWdQh0=
Date: Thu, 25 Jun 2026 15:56:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: digi_acceleport: fix write buffer corruption
Message-ID: <2026062529-entity-setup-6b60@gregkh>
References: <20260623151229.315224-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623151229.315224-1-johan@kernel.org>

On Tue, Jun 23, 2026 at 05:12:29PM +0200, Johan Hovold wrote:
> The digi_write_inb_command() is supposed to wait for the write urb to
> become available or return an error, but instead it updates the transfer
> buffer and tries to resubmit the urb on timeout.
> 
> To make things worse, for commands like break control where no timeout
> is used, the driver would corrupt the urb immediately due to a broken
> jiffies comparison (on 32-bit machines this takes five minutes of uptime
> to trigger due to INITIAL_JIFFIES).
> 
> Fix this by adding the missing return on timeout and waiting
> indefinitely when no timeout has been specified as intended.
> 
> This issue was (sort of) flagged by Sashiko when reviewing an unrelated
> change to the driver.
> 
> Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=11
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
