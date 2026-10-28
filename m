Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195997;
	b=H9ehfKFZX8QSdHWCZkd4qmZTS+ZqiHZKpW7kgsptqDe6j0vvaLbrJm9UlcnSZVed6iGB
	 tL078QnKjJNjM07t1B6HFAvJoV8EmCvtz9G9TQnVIF1rJ0/dQ7fg7fgRnVothSIRhvPJX
	 fHShp4UMlxhtIMZKCW+1st/4ce3rdhoy9Z5zeK7q/t37B7ltaeQzRsoKFQoxkclXXQbuY
	 wmjcWFsiPK21orjXrVoYDz0a7cTxMZruTrdvKuWTfpGnMTjIweg2sueiBBlfw844GMY52
	 CZSWgVk+ULnq+2V01v993NaND4Ud1vy88pE46fg9vctVW1TbQDfhzMJgHYWsHHH4ryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195997;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WvRNeKAdCM8GQT6dCZadzQJcxQsOaKoimOsC7IxNoGs=;
	b=ztA6bo+X7yVwLRjFFaTHUtLAO8uMx3wI6CyA9n40+P6fNu0XbzyNVWFyDCKjBdD1zp1J
	 hot32LCHuXuYSVNXOdQuIv06r7D/1CRN015+A6JnOIF5KzITw+LLblIVbjSvjku4QVvFd
	 rGjA63uOPJCyEwxtIiK/xelkDHMqmZmJO4pw8vAAg8dMqwGxc4FqbSHpNX2uV+1gs9Veb
	 huS/MGZufE0qreOM2QoUlFO64jbX7+L0Cp/KEcso6TYqxBa3U5vfv/BcGqZM74kYzewrx
	 IaV3zM4kfa2JMPgyynH/ZF2w0ApEGY6VjcCxpizyg5twRhfIQVMoIpyZbcYWXGSmORQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUod2IkQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD869606A31F;
	Wed, 28 Oct 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUod2IkQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2701F01825;
	Wed, 28 Oct 2026 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195996;
	bh=WvRNeKAdCM8GQT6dCZadzQJcxQsOaKoimOsC7IxNoGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fUod2IkQGpTIl1fw3p/ejMDWNpisrs4zuoh12HnsD/Kf1l+qah14IsS7czIY/5CFu
	 h1mzDgrhiDEhkipFHADWiouMwVyAKnjrN9JcPvyMSjE9Ao/WY5gwTMVv585BThtzu+
	 O1YqMKZGryq3Dmb3bHDSWjZsHiihI/9eF6XpkB+dOmh+tUpHTiCE8wT3cZDwZZLuIb
	 neNty7e+LT7/qdUNYLF0PmKdZw38UiUhAResiZXmyH8Dg2dK3WXqOBtvngTdDSywPh
	 fdb9KKd5vfhjWZU/ik+Ii0QgNqJg3KM0452jKAj59jiVqcHhtUjrmXwgbe8T835WL5
	 Ns4dcGC4O6QqQ==
Message-ID: <8ec9e401-4c00-42fe-b997-228e05ed9c2a@kernel.org>
Date: Wed, 28 Oct 2026 20:59:53 +0700
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
Subject: Re: [PATCH v2] ata: libata-scsi: reject data-in commands with a
 data-out buffer
To: Zhao Gongyi <zhaogongyi@bytedance.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
 <20261028113903.19569-1-zhaogongyi@bytedance.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261028113903.19569-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/28 18:39, Zhao Gongyi wrote:
> ata_scsi_rbuf_fill() copies simulated data-in replies to the SCSI
> scatterlist without checking the request direction. SG_IO can supply a
> data-in CDB with DMA_TO_DEVICE, in which case the pages may have been
> pinned without write access. In the reported case, copying the reply
> into the shared zero page caused a kernel page fault.

Sure that can happen if the user sets up the SG_IO incorrectly.

> Translated commands can reach the same kind of mismatch. In particular,

No they cannot, as long as the kernel is correct for internally issued commands.
But t is not clear here if you are still talking about commands passed through
SG_IO.

> the ZBC IN and GET PHYSICAL ELEMENT STATUS completion handlers rewrite
> the receive buffer, including when the device aborts the command.
> Checking the direction only in ata_scsi_rbuf_fill() leaves those paths
> unprotected.
> 
> Reject DMA_TO_DEVICE requests in the simulated-command path. After
> translation, reject a DMA_TO_DEVICE request whose ATA taskfile performs
> a data-in transfer, before issuing it to the device. Return ILLEGAL
> REQUEST / INVALID FIELD IN CDB for both cases.

Why is this being checked here and not in the SCSI layer (sg driver and bsg)? It
seems sensible to check this there.

> The original reproducer panicked in ata_scsi_rbuf_fill() on all four
> runs with the unpatched kernel. With this patch applied, it completed
> without a crash. A diagnostic run confirmed CHECK CONDITION with
> ILLEGAL REQUEST / INVALID FIELD IN CDB.
> 
> Built an x86_64 defconfig kernel from the current Linus tree and booted it
> in QEMU with an ata_piix disk. Normal INQUIRY and READ(10) SG_IO requests
> succeeded. Each command declared as SG_DXFER_TO_DEV returned CHECK
> CONDITION with ILLEGAL REQUEST / INVALID FIELD IN CDB. No kernel
> warnings or oopses appeared. ZBC IN and GET PHYSICAL ELEMENT STATUS
> were checked by code inspection; the test disk does not support them.

Test details are not needed in the commit message.

> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
> ---
> Changes since v1:
>   - Rebase on Linus' tree and use INVALID_FIELD_IN_CDB with the current
>     ata_scsi_set_sense() signature.
>   - Reject mismatched translated data-in commands before issuing them,
>     as suggested by Niklas Cassel.
>   - Remove the deprecated Assisted-by trailer.
> 
>  drivers/ata/libata-scsi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a61fb0331..a5170a36a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2048,6 +2048,19 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	if (xlat_func(qc))
>  		goto done;
>  
> +	/*
> +	 * A data-out request may contain pages pinned without write access.
> +	 * Reject a translated data-in command before issuing it, since its
> +	 * completion handler may write to the buffer even if the device fails.
> +	 */
> +	if (unlikely(cmd->sc_data_direction == DMA_TO_DEVICE &&
> +		     ata_is_data(qc->tf.protocol) &&
> +		     !(qc->tf.flags & ATA_TFLAG_WRITE))) {
> +		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
> +				   INVALID_FIELD_IN_CDB);

The CDB may be perfectly correct. The error is in the SG_IO descriptor setup,
NOT in the CDB. So returning invalid field in CDB seems very misleading.
This is not something that SAT defines as far as I know, so we need to find a
sense code that is more informative. Please have a loo at
include/scsi/scsi_sense.h to see if something better exist.



> +		goto done;
> +	}
> +
>  	return ata_scsi_qc_issue(ap, qc);
>  
>  done:
> @@ -2079,6 +2092,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	unsigned long flags;
>  	unsigned int len;
>  
> +	/* A data-out request may contain pages pinned without write access. */
> +	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
> +		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
> +				   INVALID_FIELD_IN_CDB);
> +		return;
> +	}
> +
>  	spin_lock_irqsave(&ata_scsi_rbuf_lock, flags);
>  
>  	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);


-- 
Damien Le Moal
Western Digital Research
