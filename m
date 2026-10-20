Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490056;
	b=CMOIFkK2pKxeFzrXkW38qVUFEGF+kr9jPAP4f1bJ0rnyq6jvH+3jeaUX/c3h/0xj2LXv
	 QQ+iIgNP0hhk/vBceDBzVqKh/AZAOYDrWrZE5tuE4Ya+hlqR4moE/Z35P40w5Vy/k74Xe
	 H3D2wgPfzLE8kOErXF54ElAFMX69GKQvtbTlxq1UyWLQ5gaecoCpc7dh9jAXktWidN5RD
	 F4yFWYXWa9rBUCOySrEyKjRINPgfDrNjCwF+qjnXalqyU382iTVcCTHO5jOncrfh5WkzW
	 DPanj38Xu5VEhsSw+Ee7Rf3DZtC9hqv6d5lni+WrnY5naRHv9htpuz5bWuHVDZqluUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490056;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=artqVHYwLfA3rNS6curj70sxHdKIUF4ARsisg35C+BY=;
	b=j6zhNmvPvtDY2f1bctQhYQl5wfGxN5KFqEPu0rJRV3zRIqcQzjWnkWx3gA1w3GYvYmoo
	 esCcfMWnmEcG6GvY1hh4IbV8gtISO2S8f9SSud843XE7MkqiYSIRC75JQP5dOzYQjWUN7
	 wkMzNTv9u3/XJyNxcSn8au9ujixbHjTXQAVJbvmMnZN9HXpgszqF6WxSfi2E/PSrmDaKX
	 yo+OqJGCKMGR2IkbEnndCvUmmhOcVHKvUPEkgsj5FS46viUkwa8ekIUV8J1pi5WH8caMD
	 0MTgtHCqMB3KepHqBBUfp/LMIgVLNCVDS2H5mjhyezdkmSw/1OUtiNkYu4ebKrdzhyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AovypkY5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE88606A31B;
	Tue, 20 Oct 2026 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AovypkY5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473E11F000C4;
	Tue, 20 Oct 2026 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490056;
	bh=artqVHYwLfA3rNS6curj70sxHdKIUF4ARsisg35C+BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AovypkY5UjrZtDb/MxxKugfxW2dDJq1XPk457GKOUEmDlJ4Bz2/PCJstKdumxm6KR
	 tUNEtwmm0ynOXctcavOecCYpvlZgRwHf6gMZMVCYZ/UM6vjoz2XiRTZl6IzvCZ/bHh
	 lF7UZr6TYg89GPljalCp+7BQlhTBbz/O2zUplUeWLnPrsOLtpe7OsWwk8nwblG5tzU
	 o+jo5znQWx8QjWTaQGz180xSvZvbzXiRJQJ9CAuMJlGRNFLEZWk3y0bblMKLnl+w/S
	 WbVUowhUp7YzF5RSLwf+dyb01/KNUgQu8ngPMziat9XOZ2+a3IQ8mxT86JN6XhZiOs
	 4GYtVRcJun9QA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xJ6Xt-00000008kSy-2jqn;
	Tue, 20 Oct 2026 11:54:13 +0200
Date: Tue, 20 Oct 2026 11:54:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: garmin_gps: validate packet data length
 in nat_receive()
Message-ID: <atc6RV5iox6w-s-I@hovoldconsulting.com>
References: <20260919112819.3885778-1-benquike@gmail.com>
 <2026092059-hacking-coveting-c629@gregkh>
 <20260930075247.471109-1-benquike@gmail.com>
 <ar9-ULmQkzUJ7-uh@hovoldconsulting.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar9-ULmQkzUJ7-uh@hovoldconsulting.com>

On Fri, Oct 02, 2026 at 11:50:08AM +0200, Johan Hovold wrote:
> On Wed, Sep 30, 2026 at 07:52:47AM +0000, Hui Peng wrote:
> > In nat_receive() (called from garmin_write() when userspace writes to
> > /dev/ttyUSBn in MODE_NATIVE mode), while garmin_data_p->insize is less
> > than GARMIN_PKTHDR_LENGTH (12), the loop copies up to 12 bytes into
> > garmin_data_p->inbuffer. Once garmin_data_p->insize reaches
> > GARMIN_PKTHDR_LENGTH, nat_receive() computes the total packet size as:
> > 
> >   len = GARMIN_PKTHDR_LENGTH + getDataLength(garmin_data_p->inbuffer);
> > 
> > Because getDataLength() returns a signed int from __le32_to_cpup(), a
> > 12-byte header with a negative 32-bit length field (such as 0xfffffff5,
> > i.e., -11) causes len to underflow to a small positive value (12 + (-11)
> > = 1) without any bounds check at that point. Then garmin_data_p->insize
> > >= len (12 >= 1) evaluates to true and nat_receive() calls
> > garmin_write_bulk(port, inbuffer, 1, 0), which allocates a 1-byte slab
> > buffer via kmemdup() and immediately reads 4 bytes from it in
> > getLayerId(buffer) (and again in garmin_write_bulk_callback() when the
> > URB completes):
> 
> > Validate the unsigned 32-bit data length (dlen >= GPS_IN_BUFSIZ -
> > GARMIN_PKTHDR_LENGTH, matching the existing len >= GPS_IN_BUFSIZ bound)
> > in nat_receive() as soon as the 12-byte header is present, resetting
> > insize and returning -EINVPKT on invalid lengths so garmin_write_bulk()
> > is only ever called with a full valid packet header (12 <= len <
> > GPS_IN_BUFSIZ).
> 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Hui Peng <benquike@gmail.com>

> >  drivers/usb/serial/garmin_gps.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> > index 8020149f5658..a3f599043a4d 100644
> > --- a/drivers/usb/serial/garmin_gps.c
> > +++ b/drivers/usb/serial/garmin_gps.c
> > @@ -769,8 +769,14 @@ static int nat_receive(struct garmin_data *garmin_data_p,
> >  
> >  		/* do we have a complete packet ? */
> >  		if (garmin_data_p->insize >= GARMIN_PKTHDR_LENGTH) {
> > -			len = GARMIN_PKTHDR_LENGTH+
> > -			   getDataLength(garmin_data_p->inbuffer);
> > +			u32 dlen = getDataLength(garmin_data_p->inbuffer);
> > +
> > +			if (dlen >= GPS_IN_BUFSIZ - GARMIN_PKTHDR_LENGTH) {
> > +				garmin_data_p->insize = 0;
> > +				result = -EINVPKT;
> > +				break;
> > +			}
> > +			len = GARMIN_PKTHDR_LENGTH + dlen;
> 
> Shouldn't you fix the sanity check at the top of the loop instead so
> that we never reach this conditional in case of a malformed header?

I took another look at this and this check needs to go here where you
have it. The check at the start of loop now essentially become redundant
however. I'll keep it as a safe guard (e.g. to not rely on the driver
clearing the buffer when switching mode) but add a comment about it
being redundant, while also moving the comment and dev_dbg().

> >  			if (garmin_data_p->insize >= len) {
> >  				garmin_write_bulk(garmin_data_p->port,
> >  						   garmin_data_p->inbuffer,

I'll queue this one up with my amendments when the merge window closes
this time.

But in the future, don't spam the lists with dozens of LLM generated
patches while ignoring review feedback for weeks, or your patches will
just be treated as LLM generated reports.
 
Johan
