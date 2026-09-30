Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD645FFAE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775738; cv=none; b=MVKqbRIFLZcnA+jDN80YQr90vDN00lejccANXrHIPXLKBoAkYXhy7149Sr5jB0uU0amy9FyQKDMGplZ6NdQFb4T6078hUNY8+iDjgI54DZ/fa9ZvswGRKyf6kPNkA30a5tsDVzz1Zb8FFsd/7JRReqTIQDkldseYcn7F129ahV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775738; c=relaxed/simple;
	bh=hr7TWfX6t5oARZsZqz6yfA7u5R/jRYHC+22MeRqKNS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRE7eAqQr/07KU3KHo+Cl9KlJaO6nHYezlVUb3V9h3cKJXfb8o2OxD7K+uFkrnNSGILqhdN6cGEO+KK0hi/oKFM6cdSAZ4zKqvj0uSSPqPZGcVkGC7MmwJIWAEN3xQEZYmvC2Fjj0e9OxV/pqF0NTxqWklfLNkJp/qo7WMsCbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=EdmruTNi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xfTsbhsO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="EdmruTNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xfTsbhsO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F2077A0681;
	Wed, 30 Sep 2026 09:42:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 09:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790775724; x=1790862124; bh=elQZ6/zuKk
	qBmriXdSllLeEOO8hqJP9GLyba5sVaOjM=; b=EdmruTNihie1HlIh8ChSNtg3nr
	267NzfQdeSTSg0FqmoHqg19zXfwgxywp+ZOg+n5AXkdI4OCe+vAdL62Y0DcFq/12
	i83/YNPfbsfr8fjcHWOY5KbYpJBs6StgBqpK0n5bIocg4S92cOPhMG6Y5tt+uL7J
	FWWz19j7/0tr+l49wb2OQhK1yYzyufwzC9SGy4PdZGezzKQrru0fH/56Jj1ReTVm
	pSHbc7h9M/OFbP3H0eAnbbFElnbqY/3PlmO4XfHJCofuH/gDmUvXJ2t0NyeRhPX5
	gh/k1Eyjkf6RtsY1/sSwDGLDE2xnrGdM924qJuf7NnSwEKvOd/wInURkyLqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790775724; x=1790862124; bh=elQZ6/zuKkqBmriXdSllLeEOO8hqJP9GLyb
	a5sVaOjM=; b=xfTsbhsOatGX5xrs8YIkPq+9g28OYrL7Sa2TpJYVfMYlvW2f51p
	CfsX+Hf39fmf8QddcRKurrgL2MJHWW3IZMgB5A5WDiyl0fh6o3+AtCax6QBKtVmx
	e9+um37w6zt11CY/GMysfKlGWaULZzwCScNU6nB6M38fxVrPc4QpyFY1HwqbJopb
	cIHN4aIT5VQV94hD2uLm9/UCYbyb6U/KK5fJNX/L9vZ62eDxTJvhR6KEQQRNIAnu
	OZOdV4A/QDiLWjDhPcNsIJotDBxgIuXAFWaZVV++xZR7kO3UCNK1SVmzueCj7nqU
	r9H7TPwWbeu7q3OtyyGxiZ2USMbisHdxnLg==
X-ME-Sender: <xms:qxG9ajdDLirpzZ3Dor5K15oHFiKYXcdlbquJtPRCvpNYFsPsDwZVLw>
    <xme:qxG9aqxFeGEgTonpmX3ZapTW4GJlVoEhver6QPogKdZsdDyPs9ZWPrfRZFVN4kxPX
    RzzW08p0GGTELIg01T8_k0pAB3QN2iVRVIq1zB4cZOJHi8Effs>
X-ME-Received: <xmr:qxG9arzI6Dd1xFYiFGLuQ0l8WzkBAqT6UsgAlLN6lYMuOZCWIbUmXwRIBK-K9jFN3eh8n23QWUwpkNGXU7us8sPnkjr3ZL1FfYAM25wA6dI>
X-ME-Proxy-Cause: dmFkZTGcIHTRpi6ybHnLVWoKaKhHsJyXy2jHuar2Yx/7ajNNQEV+H2EVlExlIuezGNAB5h
    p2rngEaW/fvsHXsC7CuH30+X/+g2njBwecvkWrQUQgmcZaGJSmQ2iXSRQ6JSSQZiOK9ZrH
    e2zJhj+Y1DzXFme84Tu4GGIzFmOdDDkTcJ9ZXIKATXH3cvnKpX8HZA8E7VJWnP+Xc7St4D
    vldotRncYcg9pdXY9mpAgNHDvaUVRAC9LPNSbvIdY4kPmZU5t4OSozf//4NYB7hxsNsQYc
    WvUekE/3UBqjJTzj9nsD6gjm5u2CubRaW/SFHm2HztJlW4gd347efQAt41OU42Q+yaIsjY
    n+JuR7sVi65gOlVCV5x2ysqQxns3Crc/1YQA0ukCkQJQjcFfFHe1o4FghAD4iyT8PHKxlC
    RriQ6gjVR94Wat34nWIit9yB3uC5OxJDfeQxmj1EaXasx5HAnqirg+eAPKiS77QgyfXfS4
    4kMsUw+JpY97kLjzFVXKhhpMDoWjgJClTMnfWm1GuWFphG0VtRNd/axkEg85e0PqkIZwzC
    X1kWyhAsRJCfmTJq9rWY6BcPsKySFc56gmPyl/VcYemqVuGABSRr0uOmTCGCFIsyVdav1a
    ThGyUbcsOtT0HE3opErcqvR8RLJuQxetIrdsy6KOBS7cjIE2cn63Yee+rXVw
X-ME-Proxy: <xmx:qxG9arYxxTLRBJhOCruf8Q8Y6XPp-8EUsxVkXYSNL82rxTw_BkWr6A>
    <xmx:qxG9ak28ADr1zsq4466eORhcxUcWOBerP4FQ6G7fXTHXUHexx6qPFg>
    <xmx:qxG9alfZ4wq1zV7d841T8_3H2KaLGGaJgY9wDqe_Loi1gbZNzoLouQ>
    <xmx:qxG9apLVa6PDByiU2bdMutQnFAmGI33wUi648yyiVKJwK6PGKkMqmQ>
    <xmx:rBG9aglqtdWKV3926w6hYTQkztn9T-PDBXY3L-4YnuCoI5n8Qodtnj7P>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:42:03 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:41:58 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chao Yu <chao@kernel.org>, stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.12.y 3/3] f2fs: fix to reset all pinned status during
 fggc
Message-ID: <2026093052-tamale-payment-5a95@gregkh>
References: <2026090944-celtic-lavender-8b43@gregkh>
 <20260912115644.2476312-1-sashal@kernel.org>
 <20260912115644.2476312-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912115644.2476312-3-sashal@kernel.org>

On Sat, Sep 12, 2026 at 07:56:44AM -0400, Sasha Levin wrote:
> From: Chao Yu <chao@kernel.org>
> 
> [ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]
> 
> Otherwise, the pinned status may affect latter flow of fggc.
> 
> Cc: stable@kernel.org
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/f2fs/gc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 80a88748d71f2..0bf8041050add 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2137,6 +2137,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>  		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
>  		put_gc_inode(&gc_list);
>  
> +		/* reset all pinned status during fggc */
> +		f2fs_unpin_all_sections(sbi, true);
> +
>  		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
>  			err = -EAGAIN;
>  			goto next;
> -- 
> 2.53.0
> 
> 

Did not apply
