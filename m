Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986624;
	b=RzRdJXJdLIy7qdqGuKWbnEPnksGTw8JPBlVwJzlIEgAxYndNmuigCBD6fTMb8Vp4SoVR
	 ewKDUf9Ggnb25BFjPhj0BBs65dq7p16xRDAM/9yiEfwgYwfBw2xnpe0vBFcbnDV7ak8dv
	 KUtTok3Jwtc+GkOIlUK52SdyesX+w++x8AtqQvqC6yHNKf8XEg6e5X75Hy7t/v/3Pikd6
	 1TaNngwX0/MEiiuTZJPzpb47WMLWP6qXc7wVP8amLmJoD9WfdESI3aMHuU9Bv5IVtEiOe
	 d5ay+uTpsYGoEHgcad4IxcwxlwDHGo2+5y4j+fO5VcrV+k6Wax02rbZbWuVhuJliiIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5bCjFCftZY+2sQA45xJDozhTjhcUphJevAvIJETfdPY=;
	b=25gK265tv1sqr8HABCHeyc7Cll/sNzXnyYX/0TGCZwUMpRUvDAG8dFWIHO65744W3s+b
	 qH3j5Tx3Ivl0wz8llIvYE8y5FHDCqa5HUvJ7W3MiAp24L8mdsf8Q6qp/yKls2Jv8zJGVt
	 ic4E4v4pBjHO9lctL/6RAOLwPjR6W7HaRh7qufXX7uK/KBfwul28FAqpEbm33vIkFaJ1q
	 +K/kYAjaiLeOJ7rLFaHiQp79HSbOUhalyBwM0axGklXq/p3W3WfGlS39OJ4EX/gW6immV
	 brOrMHgIJjVI/71AxDTY6Gug1vTPVpxfb2SsZlb4N7DfjFCX3GFcJ1qy/XuXL/f7Fdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncubXofL;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEC5606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DEC5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ncubXofL
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so565749a91.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793986623; x=1794591423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5bCjFCftZY+2sQA45xJDozhTjhcUphJevAvIJETfdPY=;
        b=ncubXofLpiA0x6STkrCaCodfzBpBsbyhIUCMKNiTmOtnlNrL0bt5hLRYEeMt4CxwQN
         LjZCs4CB7KiYhuZl4jWzyp6tpfuEqfIHL64au3kYvAsJglY2bYlaU3UA6Z7uQ8c7X5Ry
         /BF54dVhGkKw3UOQGhVFKsBNzZ5x9toSqcXi+O/jy3qrzh9QRsr1fnUp/E9Th4h95RNZ
         qil1lIy9FrHndIaOpY2ZX9AW0PndYKMmf94wm9kztxaQOwweHj+h1QNNNfxiEQM42eGk
         dlSl+Q2zxSsxEnStg6q4sLkXnTS7k8rD1+lvFeuae0HG4tIHdxLhP+pmQq/OYD9KFrDb
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986623; x=1794591423;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bCjFCftZY+2sQA45xJDozhTjhcUphJevAvIJETfdPY=;
        b=SXWHOrN0Ppwz5i40yIXK0ifZo/w2u4f/aJdZ7/UdYLuvt2wx62/RkMebCXoCKnFL5G
         rChTaURFqL2weX4jy10CKaApESwBl6MSi1x8eEC8b1sEBszcuhcgsrFhyRF4G/Gcksdd
         JRLmMUWE2ueU0AsdQwKL6YfwDtMixZlimp4MkeyuXnHXvfmBcsAPnh1y3aAXbvN5K9dI
         FsoFZMI8m1K6FjaOebGwuXwecG0k8+dLSd0Nw3nD81ry4mxZ5pSaEMpCP91/zIqZGs8Y
         RhFxo9uszbh7xnbGHaGjM1UGflIOQ0s3mPL+q5+Y4FKRK9Q4P2lLRa+aT00jm1krMJDc
         ievg==
X-Forwarded-Encrypted: i=1; AL+hErEUUMSXlsBMaZ1iPV+vtAYwbBVAujjxdqjIaD3ApdnrTVfe/ONkkUw98i5wHBci3GFjyiLRU1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L7FyLBrCvOcditzg3hERfM5/8IS1p2pF4cmIC8GlU5HyctcgE
	bzDqB35ibyq21jjPxCU8IUCD0U7KjDXkvWsLt5vo/j6ON9LFhDh1TQx/
X-Gm-Gg: AYBFou1d6jo2s2nXY/tMwOlyayTd0eFL0TKYZrAQ0RAKgx21l8590bZ452rfQbCE+06
	GXQQnufonkFmSw6zGPhBAtbDRi7KYFAA7P6+o0KEDtcqf8Ai1IUj6vvWHeWfXR7jFq+YlsgkUq7
	9FjjUe2jUj9extuDV0xA6zlkmqJca1CXP41VgQi6JLo3D0FYi/iBHRdWS+oAh001Xjh6nWEb/zv
	oukOv/B89aCmGWIsOOiNlAl6+ouJXvXDiE2g9o6nk7iZ567nhiDoiuSPEB9PgHSziOZdfnKMAcs
	kR5/QWvTAQuSDMDHWky+ZVpBQCPGTiHSEOKNEvltsKYQj7G6TbxHYUqyWtBjVyA4eKGSmvZlCRf
	IwGknE8oTroyBsmTJ0bDUhzLnJTxQFcJnRIddhEFk7SLnYqE9Z1Kpp7p8xeVDWyxH5Tnt3BvGYE
	gsqixmQRXJLwlf9T/6UJanztEEAbJs3lrwEdjD13eP5GkoyNIpHbLV6zbCoZxl2EYRVstTCYu5R
	55HwLy75b+SP5iJ3iK0ZU2i4ryRmPfCUcMD2A8XU0Zk1aWBJcinZH1BEPdX1n4LyC6BIKl/qvwT
	zYK9b9zDXOTAMcfIV8tql5sI30uwYSR3SemZFmEv6bpzOi45OkjVJXjwf4fuFmuu3zcq
X-Received: by 2002:a17:90b:5410:b0:3ab:5832:727d with SMTP id 98e67ed59e1d1-3b0db6e7fa8mr3207259a91.35.1793986623300;
        Fri, 06 Nov 2026 09:37:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64e:8358:c9cb:c17b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0f76ff45fsm983355a91.17.2026.11.06.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:37:00 -0800 (PST)
Date: Fri, 6 Nov 2026 09:36:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Juergen Borleis <jbe@pengutronix.de>, Denis Carikli <denis@eukrea.com>, Lee Jones <lee@kernel.org>, 
	fangxy@xiaopeng.com, linux-input@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: mx25-tcq - clamp the FIFO sample count to the
 buffer size
Message-ID: <au4Pt9K9145wF2r_@google.com>
References: <20261106075127.3105907-1-liuc63@xiaopeng.com>
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
In-Reply-To: <20261106075127.3105907-1-liuc63@xiaopeng.com>

Hi Liu,

On Fri, Nov 06, 2026 at 03:51:27PM +0800, Liu Chao wrote:
> MX25_ADCQ_SR_FDN() reports up to 31 pending samples.  The IRQ thread
> aligns the count down to a multiple of the sample count but never
> bounds it by the size of sample_buf, so a FIFO backlog larger than
> TSC_MAX_SAMPLES overruns the stack buffer.
> 
> Clamp the count before the alignment so that the result stays a
> multiple of sample_count.
> 
> Fixes: 4f7ed234f2a5 ("Input: touchscreen: Add imx25 TCQ driver")
> Cc: stable@vger.kernel.org

This is a platform device, not something that can be randomly connected.
SO barring silicon issues the condition should never happen. I do not
think this makes sense to backport this.

> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/input/touchscreen/fsl-imx25-tcq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
> index ff270b3b8572..fa8d8b736723 100644
> --- a/drivers/input/touchscreen/fsl-imx25-tcq.c
> +++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
> @@ -319,6 +319,7 @@ static irqreturn_t mx25_tcq_irq_thread(int irq, void *dev_id)
>  	 */
>  	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
>  	samples = MX25_ADCQ_SR_FDN(stats);
> +	samples = min_t(unsigned int, samples, TSC_MAX_SAMPLES);

Why is it valid to clamp instead of refusing invalid data?

>  	samples -= samples % priv->sample_count;
>  
>  	if (!samples)

Thanks.

-- 
Dmitry
