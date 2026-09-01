Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F51409604;
	Tue,  1 Sep 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274088; cv=none; b=eT+H59B0FUYi7rJM8DmbvduR+RyVBjLU5NjVaruBRDS807OWjvWQnbEvfQnmjH0OV/f7AYPdkN9UtbEFmeCPxlzINZZiL1xQcvM2gLKuqgMFeV2ODr/VdHPzldRARcjproaDTA4XoLWo+W/opddM0rzrlOejtA1+Oy1WpdKtPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274088; c=relaxed/simple;
	bh=coK5TTMaV1ozpbQkWTAsa33M2prBNphLswExeTMjGtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwQW7iMzJhMD2BltkeUUyavjOZH/OjrySGp7ZIJWUxmGsHgccwt03FRlW/xX4q9YEgptHH+UlufdeuH8ZFEQmAyfcHmVaYfLSdMzO5N+oWGiaLI23mC26mGCEbzZM5omKKOEBzdQHBx2sZ+9RAc5rQpGlxQ8xV5MiiEkaAN4F+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VEkjLBSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VEkjLBSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998C01F000E9;
	Tue,  1 Sep 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788274087;
	bh=C6OWTHcVFtEJ7gP5DN1+BWPem4qX2064mvnZewlekTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VEkjLBSWvXgeil2pfqbz2AUyZTKZpXF31PiwHTdN2ZgmeQB+RnCLZlCEcvYbWFzrE
	 aNk0GLS1DLyYm9Y5YQwHm2j8W3DkQsxYUy+V2kigGlMBnPw3UcebzysCI3yGU4eqia
	 gU/RyOFUgC7zz7fWXC95IFwt4GOlH/1ynyxIuSHE=
Date: Tue, 1 Sep 2026 16:48:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Orgad Shaneh <orgads@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: octeon-hcd: fix the FIFO-flush timeout
 computation
Message-ID: <2026090139-shout-unscrew-0197@gregkh>
References: <20260827175703.1549-1-orgads@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827175703.1549-1-orgads@gmail.com>

On Thu, Aug 27, 2026 at 08:57:00PM +0300, Orgad Shaneh wrote:
> cvmx_wait_tx_rx() computes its 100us deadline from
> (u64)octeon_get_clock_rate - the address of the function, not its
> return value; the parentheses have been missing since the
> CVMX_WAIT_FOR_FIELD32 macro became a function. The cast makes it
> compile silently, and the resulting deadline is effectively infinite.
> 
> On a healthy controller the flush bit clears on the first read and
> nothing is noticed. On a controller whose PHY did not come up (for
> example when the reference-clock configuration is wrong for the board),
> txfflsh/rxfflsh never clear and probe spins forever in __delay() -
> observed as a hard hang with a soft-lockup splat on a CN5020 board,
> where the board watchdog then resets the system with no console output.
> 
> Call the function, restoring the 100us timeout the code always
> intended.

Should this series have an Assisted-by: tag?

How did you find and test it?

thanks,

greg k-h
