Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38B1A683D;
	Mon, 21 Sep 2026 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974480; cv=none; b=hQuVghUm33CuZDHxokbKFMdn5oiJZEeO4MOhSa1GEBr2s8ByEM3ymZncx1XQaO+fT3cTI9ivonq3gibTkH0u/IziF2k85M3yjGdeKYnP/b9dfyjUqreymeYaLEGiwXV2Yg7lV8FPX6JCSkOomHTDl770ATSHupZITKIOTnCzez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974480; c=relaxed/simple;
	bh=rSj8hBcd8ZndQAeqf9fyfCA0DXPFXxCH7MHPGTfWvWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sESe3eG8TpxLvXAb1aOs0dCZkcBrlGnCq8G4aHE9GA5+Jw4R7naFxq4SR5erT5XQmXAtm/WxH1qN0fII/aBV7E/sJX+yOWB1xMjwq9N2NbMB1v4ktvC/ZfoeEP33x1y32a3dfDr40/B7LE8i8yY02ZSF9D+8T9epKeVhFh/NA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adbtzmn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adbtzmn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870E21F000FF;
	Mon, 21 Sep 2026 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789974478;
	bh=5IdEsVhx0lS/O2gGgfVa6jEzl0SVQ0tM8a9ZKJOim1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=adbtzmn57qosIzBsOA+jgSEsgbVxQv0jdxISB9HX7GsPwSaRk/IEoa/Zc5Xc+0UW7
	 QKVjuCKdICWpTTHx/YUhC6rPwt1xXZm0qrbNLjHtwz2aFPk5ZOAfFAswYQv5YADZti
	 2f2jep2RfpxrEekN5qq0nLIdq7eGsmj7spl5iu0BbNdvgxarCOFv2q9jGAiM0GnPww
	 Oyp/eYESF3LAnQhUkV1hyJk4ZQ9BCSG2PfHt6MybC0/U9mvSkM8y5pu7rDLCBgpnik
	 fxfZZIfj+slZdyJBn5t/bITzVvC64wpDOJhQQG5Qn9efsYdy+oOOsqGIwYx7SGEfMw
	 NYB5/boW1IFww==
Message-ID: <e8a11c49-a60f-4c08-8599-dadb6101872b@kernel.org>
Date: Mon, 21 Sep 2026 16:07:55 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: abort multi-sector pass-through
 commands when multi_count is 0
To: Hui Peng <benquike@gmail.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260919222625.3797581-1-benquike@gmail.com>
 <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
 <20260921032556.1160734-1-benquike@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260921032556.1160734-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 12:25, Hui Peng wrote:
> When an ATA_12, ATA_16, or ATA_32 pass-through command with a
> multi-sector PIO command opcode (ATA_CMD_READ_MULTI,
> ATA_CMD_WRITE_MULTI, ATA_CMD_READ_MULTI_EXT, ATA_CMD_WRITE_MULTI_EXT, or
> ATA_CMD_WRITE_MULTI_FUA_EXT) is submitted via SG_IO on a device where
> multiple-sector mode is not configured (dev->multi_count == 0),
> ata_scsi_pass_thru() currently logs a warning and still dispatches the
> taskfile. When the DRQ interrupt fires, ata_pio_sectors() triggers
> WARN_ON_ONCE(qc->dev->multi_count == 0) and computes
> nsect = min((qc->nbytes - qc->curbytes) / qc->sect_size, 0) = 0, failing
> to transfer any sectors:
> 
>   ata1.00: invalid multi_count 1 ignored
>   WARNING: drivers/ata/libata-sff.c:666 at ata_pio_sectors+0x27d/0x300
>   Call Trace:
>    <IRQ>
>    ata_sff_hsm_move+0x211/0x22e0
>    __ata_sff_port_intr+0x1c8/0x520
>    ata_bmdma_port_intr+0xa1/0x5b0
>    ata_bmdma_interrupt+0x1f5/0x550
> 
> Per ACS-3 section 7.12.7.21, if IDENTIFY DEVICE word 59 bit 8 is cleared
> to zero (multi_count == 0) and a READ MULTIPLE or WRITE MULTIPLE command
> is received without a preceding successful SET MULTIPLE MODE command, the
> device returns command aborted (ABRT). Per the SAT specification, an ABRT
> error translates to the ABORTED COMMAND sense key with NO ADDITIONAL SENSE
> INFORMATION (0x00, 0x00).
> 
> Fail multi-sector taskfile commands in ata_scsi_pass_thru() with
> ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0) when
> dev->multi_count == 0.
> 
> Tested in QEMU against Linux 7.3.0-rc3 (-device ide-cf, where
> dev->multi_count is 0) by issuing ATA_CMD_SET_MULTI (nsect=1) followed
> by an SG_IO ATA_16 ATA_CMD_READ_MULTI command: on the unfixed kernel
> this triggers WARNING: drivers/ata/libata-sff.c:666 in
> ata_pio_sectors(), whereas on the fixed kernel it immediately completes
> with sense key ABORTED_COMMAND (0x0b, 0x00, 0x00) and 0 warnings.
> 
> Fixes: 1dce589c38c3 ("libata passthru: support PIO multi commands")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
