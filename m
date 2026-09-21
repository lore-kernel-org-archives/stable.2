Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52362E1746;
	Mon, 21 Sep 2026 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984999; cv=none; b=l0jN3Nv/Jki265OUY+zhfsm7DT1zAFg+VmTxUct9SO8m6rUWv7DJrPVf4mO59ef3+09nvMgemw3U0sm0SruMC1hkeLU9BqX+wde6wnaJcoBM5S3U2KBQtjv2ImCC51nuF0CutKIhelET4JMGVuALC7giTU5+wzsm2l3w2GK8Svg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984999; c=relaxed/simple;
	bh=CLClXsDVSZdWSZ+ZbqLqcjL6xZU67jKJmKuirQM6Jfw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FDKkxEsHGXteCLvYAN8Voq9YrtTRsrun3dxShjFjD8GTv2uwRv05CQ0tQl8hATdcrlCGuSEg5qUDPGJPKohfdxloiHk6B5fO98AXJEaS4QJIeAJsIQY0wuU/2hy0Oos9BFUmtlE8JM6vA02tftFJFtTTlrmRTH74TD8xZ7NGtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyh6FW7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyh6FW7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586971F000FF;
	Mon, 21 Sep 2026 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789984998;
	bh=oVZBHT++EBLpm974p4QU/ut5BA2+uMVDbG/JtjHvgkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oyh6FW7lupTBTUog7zx4gidxY+uG1fQBoiSF6o7PI9o5fOwsub9ApPgPaOkQuMZQV
	 D64iXXdeaDA6mFZR0II4n1vvpLn2W1EVO9WKojkwOuqK7XDg7qlttg3ub/43LIvQat
	 aVocXdVi48AzOpCL6Oq6Ye7KX9A/MLTYbk2BaGX2xwq6BSx+uWjffHCuIxxR83LjHN
	 tJG4eTZNhs1qk2C7j0yttsY7WSTAwSSSnAA/vIKoS1aaDimu7qpmSWDe2ReasaafLI
	 xHcSxHD6+J/P+d+X/9AE9khzFwVKvByCNKTE8elmRsPOV3sVMNQdyuv5P0BD4QrgLk
	 5nMcAlUB/cPyg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hui Peng <benquike@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260921032556.1160734-1-benquike@gmail.com>
References: <20260919222625.3797581-1-benquike@gmail.com>
 <11314f1d-ee6a-45d1-a7aa-3bc1cca0c82f@kernel.org>
 <20260921032556.1160734-1-benquike@gmail.com>
Subject: Re: [PATCH v2] ata: libata-scsi: abort multi-sector pass-through
 commands when multi_count is 0
Message-Id: <178998499708.2887554.8560091477968447397.b4-ty@kernel.org>
Date: Mon, 21 Sep 2026 12:03:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 21 Sep 2026 03:25:55 +0000, Hui Peng wrote:
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
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata-scsi: abort multi-sector pass-through commands when multi_count is 0
      https://git.kernel.org/libata/linux/c/3bab8c7e

Kind regards,
Niklas

