Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3F54A7D2;
	Wed, 23 Sep 2026 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181437; cv=none; b=VbisY7LdnXi7J1s7X4e03xQHzPkO6wrFwKq+MruGqW3nZn5V+rf181wM+EJwEjLzyWY6HtLNKkkBIqhp8NeF4QTBuYgbSPDbbLrqaMcGbclipN+Rgcc/gfUWPOfI71FNtw/H8PkTO8t3yKv6EG/mhaNgHgwRjsDRyaiamnTP9M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181437; c=relaxed/simple;
	bh=VJ6k3v3g3uC4ku8qZkTZdCAmEPQre1m3/iL2RF/VQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh/mCdpIpDREIHD6RSairi/w8U9JlQboEQk40ymOUxFlSWfaHvVo0ruk7C2Ebkm0FvLivUFq7gvLnEDUmekz23vr9y30fLfUDexhjAW9Ij9DmC+kqiKc5yRq3x9Gzjo1D6QSz6x2AWj1D9+9l0dPCz3dC3hljre0N7D7v4Lib5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/6RPCbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/6RPCbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2018F1F000FF;
	Wed, 23 Sep 2026 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181421;
	bh=vkMTLYbwrn0gGdUhzUEoCFMAmPBpnUybolC0O/HsSbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m/6RPCbtGr4qJwwbG1wf+9xx2RriPqEhyceRyEFLCdMvlBG5ugiU/2VbNC0BntMHd
	 TM6zx00xhar00tGmPGhvC0PVVncPswFX1G9qmE57sd6Hv368oNvySFds1EQu6KrI2r
	 FOPIJTYZ5F0Qb0+o4Zv9A+GekkeXHGsvcgDMaVFwvim15ubsQU/fnHp/pGGUoDZ2gA
	 37z3W1RV+Xq4R8Z7aaTR8Jo6yI+2auLmqlydwMrjI2MtL1DZiDPFuFg3BIlLs+7mjn
	 NuvSXCb+3yUxaw8eCWuN3Wq8vOrW0nGiZIbFBxGV+QTCDo5j5W9iryAeM/dIRj8fL8
	 26TL2Leom4mSg==
Date: Wed, 23 Sep 2026 18:36:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: bound the ATA passthru sense
 descriptor writes
Message-ID: <arQAKYab-LWSIRfy@ryzen>
References: <20260922182655.2423663-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922182655.2423663-1-matthias.goergens@gmail.com>

On Wed, Sep 23, 2026 at 02:26:55AM +0800, Matthias Goergens wrote:
> When an ATA PASS-THROUGH command to an ATAPI device fails, the sense
> buffer holds the device's REQUEST SENSE reply, and
> ata_scsi_set_passthru_sense_fields() trusts its additional length
> byte, sb[7], when adding the ATA Status Return descriptor.  A faulty
> or malicious device can use that to make the kernel read and write
> past the 96-byte buffer in three ways:
> 
> - scsi_sense_desc_find() is passed sb[7] + 8 as the buffer length, so
>   its clamp against sb[7] does nothing and the walk runs off the end.
> - A type-9 descriptor found near the end is filled in unchecked.
> - A new descriptor at sb[8 + len] needs len + 22 bytes, not len + 14,
>   so len 75..82 writes up to 8 bytes past the end.
> 
> Reproduced with KASAN under qemu, with the emulated ATAPI REQUEST SENSE
> reply patched:
> 
>   BUG: KASAN: slab-out-of-bounds in scsi_sense_desc_find+0x1a5/0x210
>   BUG: KASAN: slab-out-of-bounds in ata_scsi_qc_complete+0x1a15/0x1a50
> 
> Both are gone with this patch, and a valid descriptor is still filled
> in.
> 
> Fixes: 97981926224a ("ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  drivers/ata/libata-scsi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7e22bbc38238..40e56ff52f09 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -261,12 +261,18 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
>  
>  		/* descriptor format */
>  		len = sb[7];
> -		desc = (char *)scsi_sense_desc_find(sb, len + 8, 9);
> +		desc = (char *)scsi_sense_desc_find(sb, SCSI_SENSE_BUFFERSIZE, 9);
>  		if (!desc) {
> -			if (SCSI_SENSE_BUFFERSIZE < len + 14)
> +			/*
> +			 * The descriptor is written at sb[8 + len] and is 14
> +			 * bytes long, so it needs len + 22 bytes of buffer.
> +			 */
> +			if (len + 22 > SCSI_SENSE_BUFFERSIZE)
>  				return;
>  			sb[7] = len + 14;
>  			desc = sb + 8 + len;
> +		} else if (desc + 14 > sb + SCSI_SENSE_BUFFERSIZE) {

desc + 14 can point past one-past-the-end before the comparison, which
strict C doesn't allow. The kernel builds with -fno-strict-overflow,
so in practice it's fine, but:

+               } else if (desc - sb > SCSI_SENSE_BUFFERSIZE - 14) {

should be equivalent and safer.


Kind regards,
Niklas
