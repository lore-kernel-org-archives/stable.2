Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584210;
	b=WE+whdBXnlJZHV/XQToPR1MDqHjdaI7a3AEL8YaJjxHCV2ILDXSDHfHV6yyPk4oXuBZ3
	 55LdXlizWZwc+UczehiBqVvSDATRjk83K+75ywbNP0gtlQeyGx0Z2mRLCfXydMUC6ne5B
	 7nTXcHrzrmrsRsEv44Sm/oMAJOpxxxyvLaNI+vSeQ8UydLayA/KoUPt+eR4c/CE4a7ZX6
	 dJQA0dtUHUj3Z1eNEWGIo2zbBnL6/YvvEOIlWxqf8I56DiEdITbhwp1r6NpS0tpEhAhUQ
	 1ICTeWdenel9Y0uEca8ZmEVaArCqpxDY7BwPpz/mtZi5nmInaZ65cZPrDfzbheTP3SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584210;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7KZb1cW74jmBUh+q3Ymrsz3p/VddcH/rPDY7TKp0j3s=;
	b=orHSt8jhw2eMiIC9IE9nrTp9faqu52Yg4Tvc40F2D1yoPf/+ZlK121NucOjCjpao6FBR
	 n6m+QcuPSMntlW4Mu8eP7zG3QYNpMq6Lpw8CNvzCTcxXAMnoG106sWpzB4n2SOB6frTkQ
	 +dg+vA2pVtUechr/yaVRTm2+QRIMNryiicXThYSJdWIf0OMw/nRSBsO6r7m0ACyh9wY+y
	 odVSxwfNCQhZS8Hi2YdRjXwymRaCyTYaz3DNoskUPZEQyDcYLc/CtNZ5w1BeRTGV8k4t5
	 M6GJgOWcIUWTfY2NFP5SIYWnbu+CWxvn3EPsYv8Uev64qWQTqXUCmYAKD/15WiLyPog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzeuJCyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7FF606A331;
	Fri, 13 Nov 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzeuJCyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF0C1F000C5;
	Fri, 13 Nov 2026 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584209;
	bh=7KZb1cW74jmBUh+q3Ymrsz3p/VddcH/rPDY7TKp0j3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SzeuJCyXPvEmsQ7fCLXFQyKc9fCoYgbv4b2fg6a/axB8WbgUj45/rnQzFOHWdOMh4
	 pMnmE3MjjbWqibccZd1cqcYJfNL/MlWqthfdJhsM9hwBIsGMv1ATXHpTz4pUUjoyWA
	 ec/7dYVjDx+F2/1pxEpxieL9huCmKmz3sMvZHj2E216Rh9v9jof+u8m8OLrnYgEnhg
	 Ca+xIcm77WxSYI02AcjAy10VW+4WUfcZY6ACTofkkd8+ohU+tJJTtL6Yh8sTdUvQyt
	 /IBQVxM4FMm11tls3IcW9zfV8BjZFcZQ7RnQheOjv157gon6W7udn64HnrnB7SlxxJ
	 HhYwgS1iCPVng==
Date: Fri, 13 Nov 2026 16:36:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ata: libata-scsi: reject reserved bits in 32-byte
 passthru
Message-ID: <avcujpOaXJPfjgxQ@ryzen>
References: <20261112220113627e1oAXj5lbAzyI0Xe6Joud@zte.com.cn>
 <20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn>
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
In-Reply-To: <20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn>

On Thu, Nov 12, 2026 at 10:01:20PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
> and bits 7:5 are reserved or obsolete. Interpreting these bits as a
> multiple count can issue spurious count mismatch warnings for multiple
> commands instead of rejecting the invalid CDB.
> 
> Reject nonzero byte 1 bits 7:5 with field pointer 1. Skip the CDB count
> comparison for the 32-byte form while retaining the device multiple-mode
> check. Also point to byte 10 for invalid PROTOCOL. The 12- and 16-byte
> MULTIPLE_COUNT checks remain unchanged.
> 
> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Changes in v3 (Damien Le Moal):
> - Reject nonzero reserved/obsolete bits 7:5 of byte 1 with fp=1.
> - Retain the short-CDB count and device multiple-mode checks.
> - Update the subject, description and CONTROL-byte test expectations.
> v2: https://lore.kernel.org/all/20261111223129430zClEJF8TDgu_h8ZYM843Q@zte.com.cn/
> 
> Validation on x86-64 with GCC 13 and UBSAN: a userspace harness compiles
> ata_scsi_pass_thru() verbatim with SCSI/device stubs. All 256 CONTROL
> values are checked for both non-multiple and multiple commands. Nonzero
> bits 7:5 are rejected with field pointer 1; values with those bits clear
> are accepted without count warnings. The device multiple-mode check and
> 12-/16-byte count checks still pass. Field pointers are observed helper
> arguments; sense construction and device access use stubs.
> 
>  drivers/ata/libata-scsi.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a61fb03312793ca94d81d8061a16c66e786c4cf3..0bc147cf4c0fa50c7d5b84029b7fb1a548c6f1a3 100644
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
> @@ -3573,27 +3573,32 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  		goto invalid_fld;
>  	}
>  
> -	/* sanity check for pio multi commands */
> +	/* Sanity check for pio multi commands (not supported with ATA 32). */

This comment is misleading.

READ/WRITE MULTIPLE commands are still accepted with the 32-byte CDB, it is
only the count comparison that will be skipped.

libata reads dev->multi_count from IDENTIFY word 59, during probe/revalidate,
and after receiving a ATA_CMD_SET_MULTI command.

The MULTI_COUNT field is obsolete for 12-byte and 16-byte CDBs in SAT-6
(tables 203 and 209), and the 32-byte CDB has no such field (table 210).

The MULTI_COUNT field was only compared with dev->multi_count, and
if there was a mismatch, libata simply printed a warning:
"invalid multi_count %u ignored", yet the command was still sent and
limited by dev->multi_count (see e.g. ata_pio_sectors() for SFF
controllers).


> +	if (cdb[0] == VARIABLE_LENGTH_CMD && (cdb[1] & 0xe0)) {
> +		fp = 1;
> +		goto invalid_fld;
> +	}

In the 32-byte CDB, byte 1 is CONTROL (SAT-6 r2 spec, table 210), and its
bits 7:6 are vendor specific (6.5, table 10), not reserved or obsolete as
the commit message says.

The reserved bits in place of MULTIPLE_COUNT are bits 7:5 of byte 10.

So I think the test should be:

if (cdb[0] == VARIABLE_LENGTH_CMD && (cdb[10] & 0xe0)) {
	fp = 10;
	goto invalid_fld;
}


Kind regards,
Niklas
