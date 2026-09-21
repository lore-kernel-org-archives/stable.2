Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BD45DF69;
	Mon, 21 Sep 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984499; cv=none; b=Eg+eLsYHpSzMRsGIKjx1jlYz/yr5xiszDRgInrZBxJot654upn2P/2rXcfh1QjeE0SuPyX8OurJi2TXTSPkhFM66zAKVb/6zEOQyUTeIf5jO8/SGOgQtkcG5lEgi4EFoYbQeldMk9bp3O3EQck/p+cxHhDX5qn5WhLu2b0h0Onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984499; c=relaxed/simple;
	bh=i/LWvwfMZCd6VMIKuugSxj1ahOW5AT4N5tbvVFl2o1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9jHFz1K8srM/Q9ns7NkUncFDBytu7030B+Jcgm2rbfVIYcX0hKDBNiF4SKa7SfW2vjUFBQXVUsZqVkHyKHFG0zKLpDypF/k53IYgVZI5S5EYRWxFRft0L/ia3liGFp5fAAyCMz9fLux0njuf7dPpoh2zWJR0rTFQgR/sEeSIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ch3MJQB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch3MJQB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C141F000FF;
	Mon, 21 Sep 2026 09:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984497;
	bh=OuZTqCCgMWgOdfCse2USkp44WqLuwSD8rdEVXSEp6ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ch3MJQB2e2yUcSEytQhY91U85p3iRe/iyA1EAkHSDHfZSyl9j1Fot4ROoW+SdLhM/
	 avW96+bH7GBbNmEB3xS5ZghOjPDGvNJRC6AGu1rz7f2JmZfJwLQfstYFw6sf3AHMb3
	 w5uRRO9hpPI2IM4Y3mpnr+YsAgQL9YVj2OIxwWLBRYeymLvQQJ5fKJb1DrYJOMcQTW
	 Wril2wjF4RhzVmfMnbJcgUK4iVsOt7Krt3HeOAwCNdHvJURG0a+r1RKCht6XPZIOyw
	 HkBjL6+RsTcdwNCq2lvfkTvfT2JbXl/ITJkdHzB2KMPBsS95HOklvoZjcxNj87vMbY
	 521qKwPqPlBig==
Date: Mon, 21 Sep 2026 11:54:52 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: abort multi-sector pass-through
 commands when multi_count is 0
Message-ID: <arD-7NGIwLaXFNEK@fedora>
References: <20260919222625.3797581-1-benquike@gmail.com>
 <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
 <20260921032556.1160734-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921032556.1160734-1-benquike@gmail.com>

On Mon, Sep 21, 2026 at 03:25:55AM +0000, Hui Peng wrote:
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

Testing information is usually placed after "---" so that it does not
get included in the commit message when applied using git am.

I can drop this when applying, no need to send a v3.


Kind regards,
Niklas
