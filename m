Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82F3EBF0C;
	Sun, 18 Oct 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352416; cv=none; b=JPnqP4mmAl9UgXGmUit3rM5FSBoxq/kxt3vJm4EgOnRPnzROJ/no7iFHnblA8lfSrqPDMwIOpVjWod/jD3i8+yy2+vbhISGNMfhYPo1sWocMbVZdpehxtZqoMdbQE+/sfJLeRgG7A4rsDPTw0A9JCxdYGbiKiEaMJXHsUxZjjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352416; c=relaxed/simple;
	bh=M140TgpDd5AN4bSSqJOSognDUr7mdaJjGjL+X9E34PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU+gf9GbtbcoR7iKm2Zp1eQuNodaG+9mxanSpBOO2Nir4AWTmcMfiSmuYDvcviP2a0mjuxJMDS4612sqb1uyAv3h/xNL5Id8GBa1NiHxPdXY5w4jqEwnB2hczWrxibV9vi/55d9gYI3H6I0H6YhjaHP1pXJJdGOcWNYbHsys4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=qVlfLvpj; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=qVlfLvpj; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="qVlfLvpj";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="qVlfLvpj"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 8E76AA1C00;
	Sun, 18 Oct 2026 21:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1792352412; bh=M140TgpDd5AN4bSSqJOSognDUr7mdaJjGjL+X9E34PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVlfLvpjiSrKeL/0ISeVHa9wELJAqYuCtVyyX8WlhoRGeq7scjLMU8S+yGLjXS/On
	 b4D2VHol3ZAcJGpdT5ndTu5BW4AGvpiCx4OzAXxc2umq8pjGenPIlzbNFKWtQh1zx0
	 Fnujv2LGPNyM2Ule7ZDNKNfPjRLwEUuT8cTAiRPDVUOKS0RFfT2tR8ezj281cPvLHo
	 EoiidWVIoIKZ3ahLAkwU8EXeerZ1nuq/bYxWenMLhHqLkzD7ZDfNYkuuNZe1ARLpK6
	 wwKG818dZRT0rLy62fq8kKQefFbTZN9zZMe/FhhwL4pW1Gi/LibjAr9IvCN3LblrJW
	 QlX/7RPzD4piA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cG1I5t_hY4eW; Sun, 18 Oct 2026 21:40:12 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 5045CA01A3;
	Sun, 18 Oct 2026 21:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1792352412; bh=M140TgpDd5AN4bSSqJOSognDUr7mdaJjGjL+X9E34PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVlfLvpjiSrKeL/0ISeVHa9wELJAqYuCtVyyX8WlhoRGeq7scjLMU8S+yGLjXS/On
	 b4D2VHol3ZAcJGpdT5ndTu5BW4AGvpiCx4OzAXxc2umq8pjGenPIlzbNFKWtQh1zx0
	 Fnujv2LGPNyM2Ule7ZDNKNfPjRLwEUuT8cTAiRPDVUOKS0RFfT2tR8ezj281cPvLHo
	 EoiidWVIoIKZ3ahLAkwU8EXeerZ1nuq/bYxWenMLhHqLkzD7ZDfNYkuuNZe1ARLpK6
	 wwKG818dZRT0rLy62fq8kKQefFbTZN9zZMe/FhhwL4pW1Gi/LibjAr9IvCN3LblrJW
	 QlX/7RPzD4piA==
Received: from samy by end with local (Exim 4.100.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1xIWjr-00000002CPB-2vjB;
	Sun, 18 Oct 2026 21:40:11 +0200
Date: Sun, 18 Oct 2026 21:40:11 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
	w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] speakup: Serialize synth clearing against locked
 readers
Message-ID: <atUgm3nwEQrJibxn@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
	stable@vger.kernel.org
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
 <20261014071713.321914-5-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014071713.321914-5-xiehongyu1@kylinos.cn>
Organization: I am not organized

Hello,

Indeed, the check for the synth pointer should be guarded, so it doesn't
disappear suddenly.

Your patch makes sense, but while at it:

> diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
> index e3d909bd04804..19799a362948d 100644
> --- a/drivers/accessibility/speakup/devsynth.c
> +++ b/drivers/accessibility/speakup/devsynth.c
> @@ -29,6 +29,10 @@ static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
>  		count -= bytes;
>  		ptr += bytes;
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			return -ENODEV;
> +		}
>  		synth_write(buf, bytes);
>  		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  	}

You can as well remove the check above for simplicity, since it becomes duplicate.

That is the same in mostly all other places of the patch.

Thanks,
Samuel
