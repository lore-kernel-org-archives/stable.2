Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497464EFFAB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775940; cv=none; b=uVfDnEZNcApzxxRijuNPvXlg0qJhP8rgT8cail1nEtV2sRcV9z8+UEDwEV7dTec5LJfrDCSACImXDkbCW1/VRIYag3uMPMdEBBYm0vRyUf9IUfRPLghb+ZG8rmE9qjZddoZLM4FmKJkjyejiqawbl9MOCTvXx0foszucjd1M+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775940; c=relaxed/simple;
	bh=w/x7F/a+7XF20gXIfx4TZvj/EbHGssE2mhDtWNw1S1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmVNe1OTn9QcZE3HC9Y5bixYqnqDeSFsOQa77nb9X3lOJtbzJyaSEiLczaE7mgkdxdE9oCxvQSlvqeRXoTpfCUvOEhJq8crwdMcTq3g6mSUZzFmhL4vTfSySUn3P70/YvO7PRpacJnziRZIBZiwFoZJoGk4qXVrpd2XjrsagJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=iM3+OM0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xa9r804C; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="iM3+OM0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xa9r804C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 291917A0742;
	Wed, 30 Sep 2026 09:45:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 30 Sep 2026 09:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790775925; x=1790862325; bh=eIdNM/swN+
	bBA2sqwhv4CMafgisuLTpdSKacjY59c7c=; b=iM3+OM0dOSDC6tK6mjjf4/cj9N
	DuBYaP87cB66z1+QTHMZ7P1Bg2AeozvssinucOAugPRcEmvNj8N+CQQ+FnP7HgIi
	pfDRMCFi6zAQEnIef0dbD0D8wArzLCW12CuhZNMRXryAbUKfECPpAMURFmXwYQVj
	xqMpRdfffQ4BeUhlXXSlxpdqU1Kvs7F+GL2t01/NtqBTHhDcAtC1MpP6wl/ZWTed
	1vAlxpKPeALJj3Z08JcQeweCeM/7saC5hMTSPhkdOGDIi948R0iRQKU8hMx9LSub
	K84r48cnRton+l7FVgk6xaGCelsK1n2aLT8CWsLkhul6I/HeItJPg+YLIPEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790775925; x=1790862325; bh=eIdNM/swN+bBA2sqwhv4CMafgisuLTpdSKa
	cjY59c7c=; b=xa9r804Ci+en2+4hT/IDP3xkp+Hvjo9tYBklQNOOwYaNAGS9B3Q
	cJxB1DKOgIDPc6EO2qjGItWNss77S4BXal8dsJefrkS7DpoQbRIfrhKmURnOq5t3
	oAc+fCr+mcY6+hVVtazeXfaPX8lViyFKHwK2p35jF7tlUyxPc+0QCXEH3FSFm+uW
	vm27Adoq1IOr5mHT+37uA7W8RHt+U+lZ7+ha2ZhEBr/8lVcAtZcjNcNpTWPVUdp4
	igTIcOZlXpY/8526I4zKjHn+yxPjEB39bgxrPfJWf6TsGLbUO6pOkR6uwiIycm5H
	75RXv39P9D/X/zfUWTkrWTiUuGsLBVZCsuA==
X-ME-Sender: <xms:dBK9aq2McCLNlhct4xrRiU-suHIpSmgPfUL3lHEO3ckVIZnygKcohA>
    <xme:dBK9anFxtPIYXxYKgihPNqK23RsO5A9zcishDF_D0Cfu7Ka51yDps6bkGR7qfB4hL
    7BcvqgHFbjWXKS4Kn2Hyarx9_lvDfGblnVU-JNFQ37YnPkGsg>
X-ME-Received: <xmr:dBK9aphhKi-Z2HTxBDPEiit1tgXWTx0A-nlX94LyIZrWLyeXEM7isDOPGgjbwS9Ih0X70Gdm27F6D8vvAofVIiaSr0LtY3gXU1eHZMSrs3k>
X-ME-Proxy-Cause: dmFkZTGqTedq4KSAHCiCZP1StgCgB3oHSgIQzZURPPvE3xFZj265vYX5j6tmiIUxw3BsNV
    iihKpftYhSmlvfdmWzubgkSRoVErkCVvDptedxkATRcojcte8LaqvJ2ZHk/oNP8HDmzB5Z
    jGH9w4amV1INSyYBADNl9lf36Ga9swwNYJ8cWlXlz+W0owHDah/LPbBoG3N4Iz/l23cdId
    XYpQ02R285dzrSIhGzzb+/MPcnXx4eNNNT6POS8fG4xSA0zjyBVrG1U2UHWKtn91ML1ZFq
    p308Z6D6Rr/keJltsrkaVpgNZ+GO5kMbXrQEQwTM7mgIrYJIEj2lNrt25yRHH8Tenzwwga
    o8owm0ANY4nVF9XA/aF0mtO0gNydMkjYYX51k7Dn8joNz8Qq/0lkjsotbVXMa7gZoLHcLc
    +T4MmWlNGhO+oPH141yTk6NcR7wbOgoWBJOaQ6hiGNZCW6aT/Fmt4gFGSeAs8CN+gJH1/E
    2tYXj+Zrp9xj5t6WKA3Jpx9NfNPosR1WqZmf4beJxPSPH2c2ID+zBAOUY6QWQ67ElxqjfV
    bcF6zKU6TUGI+DbANZ36zrI5mTtOE8VjCvQdrv+PgmHxWbwy8VyPZGt8EPOY5/+o/J/FDn
    Ke2MFysWTWefxxF/0UVPPcxQFcSmXXv2tL55OJCJqu77AmUcFs9PSWkVCfMw
X-ME-Proxy: <xmx:dBK9aqAbktEccTpa2wOa07YOEb7CGiltZxcjYHgPbeD6vEs3ePGSzA>
    <xmx:dBK9arTTSjqjqzhpAYTRGjG-aNWVZSKfO9URGqCWKnZRN9fxGqz8WQ>
    <xmx:dBK9avW7s4CZcYs4A3dq9-xx6P9TcqAwh6QRRrUBt71lcVRA99FdEg>
    <xmx:dBK9akf6Xor48EBpo0jZlC_Ghbr2kU-CXhIeEAoRbetqYsTi64Fu9w>
    <xmx:dRK9ap9m_Ux7_-IEhYAeshm2WAWd2-s-lyTpTz0i6OaBV9muNtUE9Mjt>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:45:24 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:45:19 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	lei lu <llfamsec@gmail.com>
Subject: Re: [PATCH 6.12.y 1/4] fs/ntfs3: Add more checks in mi_enum_attr
 (part 2)
Message-ID: <2026093016-basin-decaf-16c0@gregkh>
References: <2026090803-refract-segment-1a96@gregkh>
 <20260910012610.3866859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910012610.3866859-1-sashal@kernel.org>

On Wed, Sep 09, 2026 at 09:26:07PM -0400, Sasha Levin wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> [ Upstream commit a8f659ce14f8f734894227ba2c5ca78c8451501e ]
> 
> Add offset check before access to attr->non_res field as mentioned in [1].
> 
> [1] https://lore.kernel.org/ntfs3/20241010110005.42792-1-llfamsec@gmail.com/
> 
> Suggested-by: lei lu <llfamsec@gmail.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Stable-dep-of: 7c4841e2a627 ("fs/ntfs3: fix slab-out-of-bounds write in ni_create_attr_list()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ntfs3/record.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
> index f810f0419d25e..61d53d39f3b9f 100644
> --- a/fs/ntfs3/record.c
> +++ b/fs/ntfs3/record.c
> @@ -212,7 +212,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
>  			return NULL;
>  
>  		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
> -		    !IS_ALIGNED(off, 4)) {
> +		    !IS_ALIGNED(off, 8)) {
>  			return NULL;
>  		}
>  
> @@ -236,8 +236,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
>  		off += asize;
>  	}
>  
> -	/* Can we use the first field (attr->type). */
> -	/* NOTE: this code also checks attr->size availability. */
> +	/*
> +	 * Can we use the first fields:
> +	 * attr->type,
> +	 * attr->size
> +	 */
>  	if (off + 8 > used) {
>  		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
>  		return NULL;
> @@ -259,10 +262,17 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
>  
>  	asize = le32_to_cpu(attr->size);
>  
> +	if (!IS_ALIGNED(asize, 8))
> +		return NULL;
> +
>  	/* Check overflow and boundary. */
>  	if (off + asize < off || off + asize > used)
>  		return NULL;
>  
> +	/* Can we use the field attr->non_res. */
> +	if (off + 9 > used)
> +		return NULL;
> +
>  	/* Check size of attribute. */
>  	if (!attr->non_res) {
>  		/* Check resident fields. */
> -- 
> 2.53.0
> 
> 

did not apply
