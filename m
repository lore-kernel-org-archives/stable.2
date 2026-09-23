Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B9439F80;
	Wed, 23 Sep 2026 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142827; cv=none; b=ADmQ2AfJMSftK5XaanLks2Bs3eusmMOopH/vTSO8GarsLB4J8TUtdES/j7eHzuPyuIChIEpRsiUwOrhapqoOKzv3/J9/NMHIaIzUIwjeKrXKO+jnnnuk1JJAsIogVhfEg0yVWQznBMhC6z+eImc1tZskfRuNKwpNfzkhpLuEQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142827; c=relaxed/simple;
	bh=hRhZeDTazcOK82PbncOpjnCk8Dr96KRYQ/HLjGK6LoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O92tmpzonHfse7NVJuosG5L6iEBa8535pFLHpr4OUi0KIYssgUBrbVbJYRxp1+t9hLjgWHIuWUCB2RCYSx5sJ8z9oBvrOD5Ex+pPdA0r8fmi70JhIa/Hk3mC9zDswSersJhSN4LNPoNngBjPkWZlE5PQ/WIxi6YKQbGXGMGcPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH+0cT6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH+0cT6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40B31F00898;
	Wed, 23 Sep 2026 05:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142825;
	bh=Zgd9qOH7KO1+lE+JbjJc9wdRQruoNPx1tM5AUV5eDso=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OH+0cT6fcjM2VVyi8zulCUpyZ5zLXkP0IVKApIz1dEFoxAS4N2+4q26QcIYYt3lfD
	 WvOjpComfGXVa30HSDf2D6U4T+kF7AUzULA9dFpozP1sSpsr2quStv8WaHD5n63dtM
	 aYeASZn3n/UAHZpJ/VK9G03/7b3S0XJNSxbbV9g8iJfwfkh4si2NsIgcjydPFbkaJ8
	 P4DOXJJkSfS75ZL6Wh2/540emcPTUUuO3OVAu+/BdKeZNpnANTIlN0C9gh03CtIkb3
	 09qXGLl7SaqCOYf2YvbToPei7q6nkcy1pTdjGTAT5R+A9j1ymV92cc9ZJclK8xS6QS
	 G+Wle1QJIwW6g==
Message-ID: <345ac5c3-2071-4c52-9793-61173cbc72d4@kernel.org>
Date: Wed, 23 Sep 2026 14:53:42 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: bound the ATA passthru sense descriptor
 writes
To: Matthias Goergens <matthias.goergens@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260922182655.2423663-1-matthias.goergens@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260922182655.2423663-1-matthias.goergens@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 03:26, Matthias Goergens wrote:
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

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
