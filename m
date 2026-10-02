Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745247DD70;
	Fri,  2 Oct 2026 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934619; cv=none; b=kgaxou/CS8A1rHC123bsJ1Sdi2goZYe9haneBhT3TXLpEL/7n3Ih9lwzoAbIz5aS90k+kozCSWZOHboA+l1AFbAVYqZnJ4RzOJKPLIeKn3zS3DOZ6H/my60q7FjgvIOWtpMTwV0ggQoh2byb6JBU9CxKDEgWkk37cnYaRaIUX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934619; c=relaxed/simple;
	bh=UvBj8J9ueaXiSrjEk+JIaV4jLp6XYtfl+L7OJ8GVDb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCbxLv9P0iXc1n5yq7kkoN8zNcnfARIsVnMgYMRTILmFBoVsU2QByzDSQKvfGLw05lu5F2ip1wkLuQeRlPBMFsqT7546lGOyn4pp4K+C2fmRHOcUy2n3uQBlFgB3MMjYuDGOzrNlxfhDFYP5IzwfGzA0MFT5ArXyC8SEjZn+3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUhI+wLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUhI+wLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D47C1F00898;
	Fri,  2 Oct 2026 09:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790934611;
	bh=Aw4IKNNBiy3dP+FaTD9HMFn/n/0v0uX/C9fNbDZwvO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IUhI+wLDx0yo7qm7wOwjbcMOOxhzxjpz3ZaTsipuo6PwNpXtwtwgmAxY+4NCrohkG
	 wC6Y1By+bY7p2/bVhUAyQOeC98LIAb5oog/f4NUeXWifWXho2hlY6wwW6hSHzXCVYc
	 R+EoYF4WH2uXud8TqZR0z5EtpzpYiQ8Y4hVJgiOtu1TTA4wKDuSl1wGQWu4uTiADbM
	 gqD8pj8duuxNK4ZxaiPIOkfJqzQSP1j+LHkLdJiMf7vEUZyD/uC1/BTNFz8SL5Mco4
	 HHZWxxGYHCOxq1WUnpCIdgpuu0jjhtSFoyYsuFdiCjd2bmWTMTE5DaPOI7vQFESVfI
	 3NFU6yC5D5QBQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xCZu5-00000008zm6-00Q0;
	Fri, 02 Oct 2026 11:50:09 +0200
Date: Fri, 2 Oct 2026 11:50:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: garmin_gps: validate packet data length
 in nat_receive()
Message-ID: <ar9-ULmQkzUJ7-uh@hovoldconsulting.com>
References: <20260919112819.3885778-1-benquike@gmail.com>
 <2026092059-hacking-coveting-c629@gregkh>
 <20260930075247.471109-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930075247.471109-1-benquike@gmail.com>

On Wed, Sep 30, 2026 at 07:52:47AM +0000, Hui Peng wrote:
> In nat_receive() (called from garmin_write() when userspace writes to
> /dev/ttyUSBn in MODE_NATIVE mode), while garmin_data_p->insize is less
> than GARMIN_PKTHDR_LENGTH (12), the loop copies up to 12 bytes into
> garmin_data_p->inbuffer. Once garmin_data_p->insize reaches
> GARMIN_PKTHDR_LENGTH, nat_receive() computes the total packet size as:
> 
>   len = GARMIN_PKTHDR_LENGTH + getDataLength(garmin_data_p->inbuffer);
> 
> Because getDataLength() returns a signed int from __le32_to_cpup(), a
> 12-byte header with a negative 32-bit length field (such as 0xfffffff5,
> i.e., -11) causes len to underflow to a small positive value (12 + (-11)
> = 1) without any bounds check at that point. Then garmin_data_p->insize
> >= len (12 >= 1) evaluates to true and nat_receive() calls
> garmin_write_bulk(port, inbuffer, 1, 0), which allocates a 1-byte slab
> buffer via kmemdup() and immediately reads 4 bytes from it in
> getLayerId(buffer) (and again in garmin_write_bulk_callback() when the
> URB completes):

> Validate the unsigned 32-bit data length (dlen >= GPS_IN_BUFSIZ -
> GARMIN_PKTHDR_LENGTH, matching the existing len >= GPS_IN_BUFSIZ bound)
> in nat_receive() as soon as the 12-byte header is present, resetting
> insize and returning -EINVPKT on invalid lengths so garmin_write_bulk()
> is only ever called with a full valid packet header (12 <= len <
> GPS_IN_BUFSIZ).

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v4:
> - Kept the fix strictly inside nat_receive() and dropped the other hunks
>   from v3 (garmin_write_bulk_callback(), gsp_send(), and changing the
>   return type of getDataLength() / getPacketId()) per Greg
>   Kroah-Hartman:
>   1. Assigning u32 dlen = getDataLength(garmin_data_p->inbuffer) locally
>      in nat_receive() and rejecting dlen >= GPS_IN_BUFSIZ -
>      GARMIN_PKTHDR_LENGTH (matching the existing len >= GPS_IN_BUFSIZ
>      check at the top of the loop) prevents both negative/underflowed
>      lengths (< 12 bytes) and oversized lengths without needing to touch
>      getDataLength() across the file.
>   2. The out-of-bounds read in garmin_write_bulk() and
>      garmin_write_bulk_callback() was only reachable because
>      nat_receive() allowed len to underflow below GARMIN_PKTHDR_LENGTH
>      (12 bytes). All other callers of garmin_write_bulk() always pass at
>      least GARMIN_PKTHDR_LENGTH bytes, making a separate length check in
>      garmin_write_bulk_callback() redundant.
>   3. In MODE_GARMIN_SERIAL, gsp_receive() already bounds insize to
>      MAX_SERIAL_PKT_SIZ + 2 before calling gsp_send(), so the extra
>      bounds check in gsp_send() was an unrelated defensive check.
> - Added Cc: stable@vger.kernel.org and QEMU reproduction details.
> 
>  drivers/usb/serial/garmin_gps.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
> index 8020149f5658..a3f599043a4d 100644
> --- a/drivers/usb/serial/garmin_gps.c
> +++ b/drivers/usb/serial/garmin_gps.c
> @@ -769,8 +769,14 @@ static int nat_receive(struct garmin_data *garmin_data_p,
>  
>  		/* do we have a complete packet ? */
>  		if (garmin_data_p->insize >= GARMIN_PKTHDR_LENGTH) {
> -			len = GARMIN_PKTHDR_LENGTH+
> -			   getDataLength(garmin_data_p->inbuffer);
> +			u32 dlen = getDataLength(garmin_data_p->inbuffer);
> +
> +			if (dlen >= GPS_IN_BUFSIZ - GARMIN_PKTHDR_LENGTH) {
> +				garmin_data_p->insize = 0;
> +				result = -EINVPKT;
> +				break;
> +			}
> +			len = GARMIN_PKTHDR_LENGTH + dlen;

Shouldn't you fix the sanity check at the top of the loop instead so
that we never reach this conditional in case of a malformed header?

>  			if (garmin_data_p->insize >= len) {
>  				garmin_write_bulk(garmin_data_p->port,
>  						   garmin_data_p->inbuffer,

Johan
