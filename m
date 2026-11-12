Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517972;
	b=jN6VYXClEI2PrUFqwQVRiMg9Q2mzZsirIuKY72EzM99yQZZneYl1Pa0AzscMb6XzzLap
	 I89CBthwOSINsoJSvJTLjzIY8GLFSJuhMh6ceX0ozolmvC5qJXE1EQhwiwICb9v8mpri4
	 n4baMO66VoG0Ip4yQmNJqcj+r7gTwabsSklVcPvi6MfKtXTEvOnku6HpnwlFuhBJ11mn5
	 FoT2zC6GXjKNdopQTiUWnqWK2XUJSgAxtaG1pqCbD8KZFQOHtCY+fM75xcNGogrTIdFSx
	 K7DMsUmnahToujN2tVQeX97IKn446nYD12C8uOUOQoXVtiVR1gq9NqQr61ppiGLniCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517972;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=BBTphs/cyovtrCBAnbIOqmAE4r10Zj0YR0LW0CiCMwU=;
	b=EyTTGcGVhQ7OUr75cSVmv9Ot2deJtECsRIhCEHvGvPF6A0j2mIwuAD8Ehq7tBX7eizFD
	 isf5dthrOXGLm8uEDpPvYo/PhoXE+NPB7zNvIbQ1KOtpIysv50/QNZHBQCzy6Mwbch/u7
	 6/RVaRxy7pG8674kogCMsEgWdhGB+ncYSp39mTMEYAiBBU6t+u1vQLFDn+inNRA+2eBmp
	 2tQ/vWpmjt2mqxR+Y6/o4FrEn/b1r01MHoJ3QfcywnIdCkMjv4J4e2bRVdyxSG5Xg+XII
	 nQAWybgzxrkmjzRgPKCRYt18txkKGnjPj8fIPgLK5YZ1ycfQ6HsdR9gN/UXihMQQehw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3E606A31C;
	Thu, 12 Nov 2026 21:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67B7A68BFE; Thu, 12 Nov 2026 22:12:46 +0100 (CET)
Date: Thu, 12 Nov 2026 22:12:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/6] nvmet-tcp: only wait for in-capsule data for
 inline SGLs
Message-ID: <20261112211246.GB11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn>
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
In-Reply-To: <20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 10, 2026 at 11:03:10PM +0800, shao.mingyin@zte.com.cn wrote:
> +/*
> + * Check whether the SGL of @cmd carries in-capsule data that the host
> + * will send right after the command PDU.  Only the offset form of the
> + * data block descriptor is in-capsule; a regular transport SGL is
> + * fetched through an R2T instead.
> + */
> +static inline bool nvmet_tcp_sgl_is_inline(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
> +	u32 len = le32_to_cpu(sgl->length);
> +
> +	return sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
> +			     NVME_SGL_FMT_OFFSET) &&
> +		nvme_is_write(cmd->req.cmd) && len &&
> +		len <= cmd->req.port->inline_data_size;

Nit: this would become much more readable if split into multiple
conditions instead of this giant compound expression.

Otherwise looks good.

