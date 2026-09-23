Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81653A8A3;
	Wed, 23 Sep 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190593; cv=none; b=WNxTGyWGkExLxkWsjVGyAY5Qk9sAdiHHd5LMvDgQwLFLdH4d1Fkal+lKlrKZk+BygstLO8QgVNP8nnU1FPzIDsay6WPAiR7/0XZo9Wf5DOly9VUrJx1HwNsUkT9qExGe4R+LzuM1VSSIcO6rKawgXBZ5abZYOqm3EeRSD692IJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190593; c=relaxed/simple;
	bh=vE9jHy51IVlmQeI96WNmi52fnodpOckuGpFY7hmCvxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TzMpGcg+9k614ApzMw6AxDv/4PGTYFseAzsZ5aderiNIVrM9Jsg9ekI9DxzeR1tFGXwcEBnrdl7Ak0HPdUcl7UVcnNV/Cab2RJt+MpImh1LC9+JYv4Ggqr1dd/4KL1QONUvyPp6m7eRwpRSNg0Bvl1hUvWcFJuiRkj7K5bDaKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edv255MZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edv255MZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55971F000FF;
	Wed, 23 Sep 2026 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790190591;
	bh=Ejd1kebqLQU946zKMGHG4mDBRf6wkCc0yxC2fMVobLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=edv255MZyI4Xagu2dn/DOdom0RqpZAqwkCT3C5wdP8lL7MIAaP4Rp8BkfLhPZeJA5
	 1j2NpedwE3QCcavrMW2p//wyCA3P4eB6wdsQJFHoVWu61ComaMRN31R34zcpDNyAkB
	 zGp3F8U9R6Xo0V03Z21g9cyULTKtWnll/7bD7nMns2Ub1KlRUWgYuUJp3NJ2ZCu2Xw
	 Jgw49Kmnl5CaTKtcSlnRnt3EztoFASrMMljnnxslMBmHPO4EB7aCQnb12tfzcEwQhh
	 NhHYjQQps36TfZVEVgrJjepfZb7WSu6CRyU5azFjmm1yPks/S5fisRrgeRMk9vmlq5
	 EPqGqTnmek0MQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260923175203.1576825-1-matthias.goergens@gmail.com>
References: <20260923175203.1576825-1-matthias.goergens@gmail.com>
Subject: Re: [PATCH v2] ata: libata-scsi: bound the ATA passthru sense
 descriptor writes
Message-Id: <179019059052.3560943.13648184219606999768.b4-ty@kernel.org>
Date: Wed, 23 Sep 2026 21:09:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Thu, 24 Sep 2026 01:52:03 +0800, Matthias Goergens wrote:
> When an ATA PASS-THROUGH command to an ATAPI device fails, the sense
> buffer holds the device's REQUEST SENSE reply, and
> ata_scsi_set_passthru_sense_fields() trusts its additional length
> byte, sb[7], when adding the ATA Status Return descriptor.  A faulty
> or malicious device can use that to make the kernel read and write
> past the 96-byte buffer in three ways:
> 
> [...]

Applied to libata/linux.git (for-7.3-fixes), thanks!

[1/1] ata: libata-scsi: bound the ATA passthru sense descriptor writes
      https://git.kernel.org/libata/linux/c/80320b27

Kind regards,
Niklas

