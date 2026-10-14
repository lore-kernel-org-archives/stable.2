Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90434F4743;
	Wed, 14 Oct 2026 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976597; cv=none; b=sidez+91UiruQsP+OIGXJ5/STIKLGJw4c87pO6OtOpwedU5D3m0HnG3OyW7lsooUqvfSGGY1RpWWnukvcoIu+PaSVZpB5wAsQJXrK+WkMbMbRHrBzIgAL/ELkHvYzbTq5DeJRD89iw7EY4QSnJGq+rwWTn55LiT57d2NrrG7I0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976597; c=relaxed/simple;
	bh=X0wUMTslYRaZ+6QJ3lB5bFDrVgR1nrY+pVd4qFFwDso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9CLWOfnH7qU/a/8myPblQ5xm+WUDbHIJ+sGZ9zn/m35wqnFwDPlMFnR8tIMolhVBYSOqQzMfkwzKs0yg6AfOEAzbv7EYY6BK2J4fJRqRl7tY3mTsPid6256s7vWvIZFkVJRiw8smTQ69j3jFGlF3vNE+in7VM4Uo1nYCqqrd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2LyVyw8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2LyVyw8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D651F000FF;
	Wed, 14 Oct 2026 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791976595;
	bh=oMVE59ilNM9y/kQGfVIbxIHq8wdIsYTtCtgxqmMIs+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2LyVyw8Aw7HGbN1myWLyF9gVtYO24oWK7G1/o4bevcflnOCakjucHWDZJANJ3mrAL
	 e5I/dXSNTVQyQTDgxNB+x9t1O0t0InRzfdpBr2nvPz7iE1mW+lKVxQKKSEq72V0Yep
	 c25OSsG63GGsa9rKKsWc9an80LbW0i04OetUe6S4=
Date: Wed, 14 Oct 2026 13:16:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
	usb-storage@lists.one-eyed-alien.net, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: uas: ignore UAS for ASMT135x bridges (174c:55aa)
Message-ID: <2026101459-mortuary-curator-63f7@gregkh>
References: <20261013221944.41598-1-olivier.kaloudoff@gmail.com>
 <20261014105700.19433-1-olivier.kaloudoff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014105700.19433-1-olivier.kaloudoff@gmail.com>

On Wed, Oct 14, 2026 at 12:57:00PM +0200, Olivier Kaloudoff wrote:
> The ASMedia chip detection in uas_use_uas_driver() assumes that every
> device with idVendor/idProduct 174c:5106 or 174c:55aa reporting a
> config.MaxPower of 0 is an ASM1153 with working UAS.
> 
> ASMT135x bridges (iProduct "ASMT135x") share the same 174c:55aa id and
> also report MaxPower == 0, so they take the "ASM1153, do nothing"
> path — but their UAS implementation is broken:
> 
> - The first READ(16) issued by sd probing times out after 30 s;
>   enumeration only completes after a uas_eh_abort_handler plus a full
>   uas_eh_host_reset_handler cycle:
> 
>     scsi 3:0:0:0: Direct-Access  ASMT  ASMT135x  0  PQ: 0 ANSI: 6
>     sd 3:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
>     sd 3:0:0:0: [sdb] tag#26 CDB: Read(16) 88 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
>     scsi host3: uas_eh_host_reset_handler start
>     usb 6-2: reset SuperSpeed USB device number 2 using xhci_hcd
>     scsi host3: uas_eh_host_reset_handler success
> 
> - Under concurrent load the bridge stalls: all inflight commands (20+
>   UAS tags in the captured incident, mixed READ(16)/WRITE(16)) hit the
>   30 s UAS timeout in the same event, forcing repeated abort/reset
>   cycles and eventually a USB disconnect.  Writes dropped mid-flight
>   during these resets returned zeros to the filesystem (observed as
>   XFS metadata corruption on the mounted volume).
> 
> - Sequential-write throughput is ~45 MiB/s under UAS versus ~136 MiB/s
>   after disabling UAS (usb-storage BOT mode), which is fully stable:
>   several tens of GiB written without a single error.
> 
> - Bulk reads of healthy LBA ranges do work under UAS (~190 MiB/s, no
>   errors); the failure pattern is command-timeout at enumeration and
>   under queue depth / write load, not a broken transfer path.
> 
> Since 174c:55aa is shared across several ASMedia bridges and enclosure
> rebrandings, distinguish the ASMT135x by its product string — the same
> approach used for the HIKSEMI MD202 check a few lines below.  The
> product strings of working bridges using the same id ("ASM1053E",
> "ASM1153", "ASM1153E", "ASM1351", vendor rebrands such as "YZWY_TECH")
> do not contain "ASMT135", so the match is safe.
> 
> Verified on an ORICO enclosure (iManufacturer "ASMT", iProduct
> "ASMT135x", bcdDevice 1.00) attached through an Alpine Ridge TB3 dock:
> with the equivalent usb-storage quirks parameter (174c:55aa:u) the
> device is completely stable.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
> ---
> v2: fix the comment block: added lines were missing the leading
>     tab, breaking the *-alignment with the rest of the block.
>     Apologies — the v1 diff was mangled by my editor before sending.
> 
>  drivers/usb/storage/uas-detect.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/uas-detect.h b/drivers/usb/storage/uas-detect.h
> index 4d3b49e5b87a..d8dc77015992 100644
> --- a/drivers/usb/storage/uas-detect.h
> +++ b/drivers/usb/storage/uas-detect.h
> @@ -78,6 +78,8 @@ static int uas_use_uas_driver(struct usb_interface *intf,
>  	 * ASM1051 - with broken (*) uas support
>  	 * ASM1053 - with working uas support, but problems with large xfers
>  	 * ASM1153 - with working uas support
> +	 * ASMT135x - broken uas support, shares the ASM1153 MaxPower == 0
> +	 *            signature, identify it by its product string
>  	 *
>  	 * Devices with these chips re-use a number of device-ids over the
>  	 * entire line, so the device-id is useless to determine if we're
> @@ -99,7 +101,10 @@ static int uas_use_uas_driver(struct usb_interface *intf,
>  			(le16_to_cpu(udev->descriptor.idProduct) == 0x5106 ||
>  			 le16_to_cpu(udev->descriptor.idProduct) == 0x55aa)) {
>  		if (udev->actconfig->desc.bMaxPower == 0) {
> -			/* ASM1153, do nothing */
> +			if (udev->product && strstr(udev->product, "ASMT135"))
> +				/* ASMT135x, broken uas */
> +				flags |= US_FL_IGNORE_UAS;

You have a 2 line statement after the if () here without any {}.

Yes, it will work (or it should), but it's not good form and will
confuse us over time.  Please fix this up, odd that checkpatch.pl didn't
catch it.

thanks,

greg k-h
