Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE251531E8;
	Mon,  1 Jun 2026 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294765; cv=none; b=b/oJtvKdlzNGInmooNui9ll3NSJ1cuHJhpSI+UV3NKLuEOVuhU05NH1X7QfLbpXfxUljGVcGr2cjZ+ps7W3i71JpBJ7JXEczEjBGSkp/LWp96163P0C0e16fUGDVrwcJNenMf4UFGGVL0n7fjdxyBrdvi6hJ0ufFdGapIozXCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294765; c=relaxed/simple;
	bh=GEJ30X3Y/jDTunkvJyexa7O+v/l6s7xBV6oFXh6Rg/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exsyp0AbjnvpudpZ+g97M7cO+welxEbGnnjU4svrQI7zzB3YqHR7GPg8l6TQfUbFsZddJbnTGT8znDLmSAWSNfanOJW4EMGJzawVy7ZFvTbn0Puz1EuI3XK6cZSAq6j77TO2WaAqZoEMiRq4BGIMvH9e0BZWpRriwBbI4FUdUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Y4nRvHGF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Y4nRvHGF"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3D70620764;
	Mon,  1 Jun 2026 08:19:14 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e7JXtIOBHxZb; Mon,  1 Jun 2026 08:19:13 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 18D9C20520;
	Mon,  1 Jun 2026 08:19:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 18D9C20520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780294753;
	bh=aCVW2hII9s0ija3d96EY8+eFESNZ2ahFsHTBD4uBmzQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Y4nRvHGFlOfjVHKJAalaAT6mhYAbsXmlHJtCTPjaImLsdQm57j4QO3yZMruTgSFCs
	 ABewHb7TpojzPCrEtNVfRqFlVnC9CS6vbt/9ghyyD41ZXLJUX73Cjpbr6IytFdJSWY
	 vPU8rEhv6Ld+RWc9dmJ68xV/XEqAEFd6mFMDGBH01ahJgH1/IGNt0jUsCz2Np9hSvC
	 Dp5yoAWJIUlxHKbF/t3+wSruYyAr/XF92Q+ns8KwFk1qdw0R89yIC8UshRQyo8ZArZ
	 Vp/aGC8RU37c6DCc1t+twSAcsXT5je3gXTLqEcFLqTQEDj5PNkS6x7FhIKXP5WmOt0
	 LeDmTgUgbfTZQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 08:19:12 +0200
Received: (nullmailer pid 3203635 invoked by uid 1000);
	Mon, 01 Jun 2026 06:19:11 -0000
Date: Mon, 1 Jun 2026 08:19:11 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Takao Sato <takaosato1997@gmail.com>
CC: <netdev@vger.kernel.org>, <w@1wt.eu>, <davem@davemloft.net>,
	<herbert@gondor.apana.org.au>, <chopps@chopps.org>, <pfalcato@suse.de>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v5] xfrm: iptfs: preserve shared-frag marker in
 iptfs_consume_frags()
Message-ID: <ah0kX12B8xvNj3Sy@secunet.com>
References: <20260526160957.1497109-1-takaosato1997@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260526160957.1497109-1-takaosato1997@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, May 26, 2026 at 01:09:57PM -0300, Takao Sato wrote:
> iptfs_consume_frags() transfers paged fragments from one socket buffer
> to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
> the same class of bug that was fixed in skb_try_coalesce() for
> CVE-2026-46300: when fragments backed by read-only page-cache pages are
> merged, the marker indicating their shared nature must be preserved so
> that ESP can decide correctly whether in-place encryption is safe.
> 
> Apply the same two-line fix used in skb_try_coalesce() to
> iptfs_consume_frags().
> 
> Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
> Cc: stable@vger.kernel.org # 6.14+
> Signed-off-by: Takao Sato <takaosato1997@gmail.com>
> ---
> Changes since v4:
> - Rebased onto the ipsec tree, as requested by Steffen Klassert. No
>   functional changes; only the diff context was regenerated.
> 
> Changes since v3:
> - Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
>   introduced in v6.14, so earlier stable branches do not need this
>   fix. Pointed out by Pedro Falcato.
> 
> Changes since v2:
> - Removed security impact paragraph from commit message as requested
>   by Steffen Klassert.
> 
>  net/xfrm/xfrm_iptfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6c6bbc040517..62ba828632f1 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
>  	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
>  	       sizeof(fromi->frags[0]) * fromi->nr_frags);
>  	toi->nr_frags += fromi->nr_frags;
> +	if (fromi->nr_frags)
> +		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
>  	fromi->nr_frags = 0;
>  	from->data_len = 0;
>  	from->len = 0;

Sashiko found some issues in iptfs. It is not directly related to this
patch but looks valid:

https://sashiko.dev/#/patchset/20260526160957.1497109-1-takaosato1997%40gmail.com

Chris can you have a look at it?
