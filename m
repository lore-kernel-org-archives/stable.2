Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439724;
	b=z9Xxo66/9tCl1hsedyMED45WCFX59mYOlgXCJI+39P36tKCcG9tA8xlhtLl4WdqgcAL7
	 gnDiDup3fn0jTuF6OJZOMxvwEJtf1sTSJI6sGd9yBM+BweWf8wPbrhnqy6NdU1ec6RMP7
	 VMpBBsUET+3R8il2+0EjbJnpJxyt67fEYQkb1xGqxXgL/8ycADuoERtAcMm87ezkub7el
	 wN35Yf6Fnf3oub5WKnu+1PPf6cVzMwpZYEjKBx1TKixZoBgwCWrAeCxFGaSWSGDMFAtsF
	 rawwjLMtCU/9Nvpk344ci26CUZsqNyuP/IyfISapebO9UsLzeta9kfIkd3Tl8Gtxp9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439724;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IKsrCBoJXK+5BoP6HnPY8QEU5vTMg70Zu/Nh+kOhTzI=;
	b=rqf4VNObulhDWuuZSrUd0A47gZBEQgOEevutcusANk4XPPrIhUHY1x8Hhch8VUsHI3Eo
	 B1RW2Pjs1d6tE90wtqbFq148fDN/S50cJ15jLrKcEV78yjPl1G8pY2HnSJDOWGFTHdkWC
	 +6TXd4HwNcMhkk4J1Pz5EYsv/dvd3ulxRRQnUxTS+Xe6/px6GGaSuWpSNpiADqNGr+oNV
	 4WQrFjbUODVC2ZrTNUHh/W08HtbVlCowpgJ5dicCKypx+oX/d7rXaCnRgptuq53oM3zgp
	 fIcS96EBDL0Nut4gqUjdgryDaTKKuYDjN+uLeDGDOZILiFWBZ7GlxunHCVztUjhcS/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI+3Fden;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BB606A897;
	Wed, 11 Nov 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI+3Fden
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC8D1F00A05;
	Wed, 11 Nov 2026 23:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439724;
	bh=IKsrCBoJXK+5BoP6HnPY8QEU5vTMg70Zu/Nh+kOhTzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mI+3FdenraiaeiNHu/j2Q9YoZmOQJb+M/aJNZiifIJR4RWnqvpp5Eg1+YrJ3mGCoE
	 r1neQvKFYSO7kpuxIEnYdAO2rP8CKQFWonZo71yDN1+J+EbCGBEAXIHo7bxM7fhpn6
	 tPhClSs/y7EzKIxk2cytcQanr8AEVmPFfHw844oi4WBen1Ef6KYG0Hm1eOvOdGc1Tj
	 o3m4n/yeVZqn4ioRpPmGuMo4rEJsT9VwX0qZ5D1fTp6n3Us6dlZHf6XQIMrb9TTVQy
	 bvdQDwz0VBhTCAIWc1tkvJvX3tjjFHb+xH03ypLMhL/EqKKzjNrblooCswdyzCfmCg
	 LsATA/xWk5nBA==
Message-ID: <440db014-a58c-44e4-bc96-e950e69b6763@kernel.org>
Date: Thu, 12 Nov 2026 08:28:41 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ata: libata-scsi: skip MULTIPLE_COUNT for 32-byte
 passthru
To: shao.mingyin@zte.com.cn, cassel@kernel.org, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/26 23:31, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Reading byte 1 as
> that field instead interprets the variable-length CDB CONTROL byte,
> which can reject a non-multiple command or cause a spurious count
> mismatch warning for READ/WRITE MULTIPLE.
> 
> Skip the CDB count checks for the 32-byte form while retaining the
> check that multiple mode is enabled on the device. Also report byte 10
> for an invalid PROTOCOL, where that field resides in a 32-byte CDB.
> The 12- and 16-byte MULTIPLE_COUNT checks remain unchanged.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Changes in v2 (Niklas Cassel):
> - Skip the nonexistent MULTIPLE_COUNT field for the 32-byte CDB;
>   preserve the device multiple-mode check and the short-CDB checks.
> - Move the invalid-PROTOCOL field pointer fix here from patch 3.
> - Regenerate with git format-patch; do not edit diff hunks or indexes.
> - Do not carry the v1 Reviewed-by tag over the reworked code.
> v1: https://lore.kernel.org/all/20261104220939917jqg8_alGN5sACGWq5M9D-@zte.com.cn/
> 
> Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiled
> ata_scsi_pass_thru() verbatim with SCSI/device stubs. An invalid PROTOCOL
> in a 32-byte CDB passed field pointer 1 to the invalid-field helper before
> the fix and 10 afterwards. CONTROL-byte variations no longer caused
> false rejection or multiple-count warnings. A device with multiple mode
> disabled still rejected READ/WRITE MULTIPLE; short-CDB checks were kept.
> 
>  drivers/ata/libata-scsi.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a61fb03312793ca94d81d8061a16c66e786c4cf3..227240514651ada8b5feb87a154833fb2cddf064 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3388,7 +3388,7 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  
>  	tf->protocol = ata_scsi_map_proto(cdb[1 + cdb_offset]);
>  	if (tf->protocol == ATA_PROT_UNKNOWN) {
> -		fp = 1;
> +		fp = 1 + cdb_offset;
>  		goto invalid_fld;
>  	}
>  
> @@ -3573,27 +3573,28 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>  
> -	/* sanity check for pio multi commands */
> -	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
> +	/* The 32-byte CDB has no MULTIPLE_COUNT field. */
> +	if (cdb[0] != VARIABLE_LENGTH_CMD &&
> +	    (cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {

Sinc ATA 32 defines these beets as reserved/obsolete, we should check that they
are 0 and reject the command if they are not. So something like:

	/* Sanity check for pio multi commands (not supported with ATA 32). */
	if (cdb[0] == VARIABLE_LENGTH_CMD && (cdb[1] & 0xe0)) {
		fp = 1;
		goto invalid_fld;
	}

	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
		...

>  		fp = 1;
>  		goto invalid_fld;
>  	}
>  
>  	if (is_multi_taskfile(tf)) {
> -		unsigned int multi_count = 1 << (cdb[1] >> 5);
> -
>  		if (!dev->multi_count) {
>  			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND,
>  					   NO_ADDITIONAL_SENSE_INFORMATION);
>  			return 1;
>  		}
>  
> -		/* compare the passed through multi_count
> -		 * with the cached multi_count of libata
> -		 */
> -		if (multi_count != dev->multi_count)
> -			ata_dev_warn(dev, "invalid multi_count %u ignored\n",
> -				     multi_count);
> +		if (cdb[0] != VARIABLE_LENGTH_CMD) {
> +			unsigned int multi_count = 1 << (cdb[1] >> 5);
> +
> +			/* Compare with the cached multiple count of libata. */
> +			if (multi_count != dev->multi_count)
> +				ata_dev_warn(dev, "invalid multi_count %u ignored\n",
> +					     multi_count);
> +		}
>  	}
>  
>  	/*


-- 
Damien Le Moal
Western Digital Research
