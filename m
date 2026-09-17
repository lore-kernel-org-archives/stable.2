Received: from mail-lr2-f32.google.com (mail-lr2-f32.google.com [74.125.230.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7DD5947F2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655385; cv=none; b=UgWZKvPRovabrrkg+PcobDq1NTRaJpSao7Zu5Yr+tKo1Qao6zqata6rzuuDm4/kCkUO5YBsBoODYaaH8t65Zp0iOTgOaqpGnzVtj5EznxABUK3bdllf72xFbUq8jsGNlWtK9nedTpfwY81VmFVmXAFvuxtlJebDOdPU8mksySgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655385; c=relaxed/simple;
	bh=KK99SGOpVo0Sh2l7pX+m5thw7TySG15JTH25D7b445s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuDgpG29JZdI9IomDXLYXRa68QdgFV2Go1uKD8KmFzA/XJSxsYoaI6Z0MOU2XyDzR/i6fsIG05B9iU1PMyc9OL6Qfw5hw6GVoTkq837wOrvuNXcm2eKPsrvHI07WBRL5ZAmBxCm5pTFkX/iZ/rDserWCbA8w4B5vFGkTGAEdh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YjCZ1zJ2; arc=none smtp.client-ip=74.125.230.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YjCZ1zJ2"
Received: by mail-lr2-f32.google.com with SMTP id 38308e7fff4ca-3a3156692e3so3013391fa.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789655380; x=1790260180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLUsM28SSrjqBmi4DDelq5Ueb0+ylvS4bDAd6TEXb10=;
        b=YjCZ1zJ2xBEAnj0paJGkrWY8WewXRlexrSxIG+7MouP3+uvJ+F39sfw3XuEI1rnpKk
         GuL54IpC0w1bCVMiiiB677P4z/XBtTV+7MLZGzh667RJy6xLGhIfakH6Tx0NBH+HuTJD
         EYjN5taBqcwBBsGm0uxgSmTLt+Fv6UeZNJRn2htSidUtzYDRaqfouI2Qv6dey6gJC1rT
         FDVOXvNHivxQOBxUL4jpBWLvZYLoF1q+xHZF4pSafZQ/UYbiHkVaOHayUiCZiQGMAxts
         Qy6uOJKrDoQGyOni+zbP1fRjIy834CMBO09/0AGCV7fYfxd1YurrD/WUIM+LDpQLxsIa
         Ho+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655380; x=1790260180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLUsM28SSrjqBmi4DDelq5Ueb0+ylvS4bDAd6TEXb10=;
        b=l9JftSlTC4l9dfYCV+0m3np0CoviQwVjmzAP4NKJs9jBabbRRXFbkYLn9t//KpzpNW
         zdHcWghEyMxjCyUO89RY5VFPyt5wnwh9ArH1hzLzgyi4Szq12MHgRcZR1jP4MrgtV270
         s4/Lhjop4fALqAd4oXzDVLjvdoCnyF0TkkG9X82gzjHfdtAgg09PJjcYh3B6kaQ7vkGi
         GcmRurOLQCUk5ZlHuRthmqSGVboHOo3DPUR/YSYQslIFgy+cP+Jrs5AV4pWixtkKnE0v
         jrpHbXbSbasCwjd/QEEfBYYESHfWH5rMist8ajSxDMu3i/1Kd7PU8nNmQe3s2GlvI668
         LdcA==
X-Forwarded-Encrypted: i=1; AKwUvBx2Trso0doaDk3BPUd6VQDIry3+5/m48FU4qH6VfhiCORKFFu1lasqNRFmO+boGRC00GXLiWxg=@vger.kernel.org
X-Gm-Message-State: AFuF++mGzlkos10WBnkYFB/ftHIaRNj54ddiJnzBEL0IAF6saNgT9Ag+
	W5nIXmKYOpV5ss/n1VUnG6WTw1E5hBwDneu6BFh4KMN/JoRqb6qbrc2omD5A2tLb+Us=
X-Gm-Gg: AYBFou1ei4fC5jgl2LJyPxrlPeqgUwUuipWj4LmE0p7onD3uA1kAJ5SB2T8gHRWhaIW
	N/PIoFgTojwILMN9h1uhGvjSqpYS1NCKR2OX6Ag+mHJ5/XM4L81LvE5a6WqTK7zwkmtPn6CRkMo
	tuFFp9AwzyT/WvzsjgmUJgTTHmijmP6o4wQZ5wZkiYnjhcCOLroiErNZNhUSqM/bV5PyBNzLeRd
	Kk14AdYHhlryoNhwwhdIUMS1f2Dbe/RHMJvYVwkm2fuhI9YmOKLnkt/XePTY1pIb46QBWqCfD9o
	iF+88CLtSlHphYMuVKKbUHQtHiBiEkJeg29CAarWYFH/ei1TJOzkF9ZZ0e5t46/OUwrbcGLzTel
	yoRgxE+zgLqkEX5E/5HnSGmYGZS8ltgZrnNm977iIYw8gKl3/6aO9wdjxkOUQ80wxz/LiJt71MN
	4IbIbYKYI1RyuEOADbYIwPw1yvbNwxK9mroPJ+UBDibABuOnh6DwZWsvL0E/OAD0cRn5tBzGhIW
	fy8tg==
X-Received: by 2002:a2e:bc10:0:b0:3a1:fa0f:5d21 with SMTP id 38308e7fff4ca-3a5e71460b2mr7532451fa.3.1789655379911;
        Thu, 17 Sep 2026 07:29:39 -0700 (PDT)
Received: from localhost ([82.145.119.8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5dafee366sm15755461fa.42.2026.09.17.07.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:29:39 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 17 Sep 2026 16:33:18 +0200
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrea.porta@suse.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, saravanak@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] of: unittest: Fix np reference leak in
 of_unittest_pci_empty_dma_ranges()
Message-ID: <aqv6Lv5EZrziJVOR@apocalypse>
References: <20260917130307.2152615-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917130307.2152615-1-vulab@iscas.ac.cn>

Hi Wentao,

On 13:03 Thu 17 Sep     , Wentao Liang wrote:
> of_pci_dma_range_parser_init() can fail when the node lacks a dma-ranges
> property. That error path returns without dropping the reference taken
> by of_find_node_by_path(). Add the missing of_node_put().
> 
> Fixes: 1a75e81baf4f ("of/unittest: Add empty dma-ranges address translation tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/unittest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 939cbff45ab1..6bc5babddf0a 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1250,6 +1250,7 @@ static void __init of_unittest_pci_empty_dma_ranges(void)
>  
>  	if (of_pci_dma_range_parser_init(&parser, np)) {
>  		pr_err("missing dma-ranges property\n");
> +		of_node_put(np);
>  		return;
>  	}
>  
> -- 
> 2.34.1
>

Thanks for your patch!

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>
