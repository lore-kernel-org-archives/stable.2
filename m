Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA23859D3;
	Wed,  3 Jun 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497628; cv=none; b=QvMmlFMYeUbYgAE9bPTjZF2eozuLq8slQvjd3Pl5SPkLwSvKmtpMRVRrucGQTEEqJEwLqOAKDcezO0JTNnSJN3f5xOtIBqONFSsy8X19Y3d0eFKUKWM4VknPNJ08yjPtlk21txNzYDv8/zLV9OwmULCCkwhJagEfJ3it1aO0PqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497628; c=relaxed/simple;
	bh=QCvezOOFem8vSjdh7KRvh9+XQIHIrK1N1KJUb7V0KJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R88y/Id27oY87buxkNBa9VAc8IkQLUsl+ATa3VPb24vQf8Dd7RE6ow66JiiNIcT0QX4BdkZhhsGMeRcoAG3Q5q9bK9Wp+z1I4aYtQm9GE159OWHpBZclZqW23jpS+JSKuKA6LgaMuw96E29vVfWer5+5KRACPf00j+/dWdMEu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=pxmSsQ+7; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="pxmSsQ+7"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1A9DC1D40;
	Wed,  3 Jun 2026 14:40:21 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=pxmSsQ+7;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D2EF6223E;
	Wed,  3 Jun 2026 14:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1780497619;
	bh=ZvLSfeUx87wEYCxwP7qXNOB4NvHqMJCSpqJa7Jnbzzw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pxmSsQ+7RbrgsDuJU87BRjyT7i84Nf7Vq2qIZK9aHmstAsdrJTv2ixPfCt3zrhU8x
	 g8fKZJ/R19zC9BM8WLDAH+TyIx6vWCqYaI1auinJUjdsfzary3AMT1NyepDyWTalUD
	 BzOHIB6anXEHXLheVQPcx/C+99C854nLsd0Uot5U=
Received: from [192.168.95.128] (172.30.20.205) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 3 Jun 2026 17:40:18 +0300
Message-ID: <f67c98bc-88de-48e9-a510-1542a76e6c41@paragon-software.com>
Date: Wed, 3 Jun 2026 16:40:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ntfs3: validate lcns_follow in log_replay conversion
To: Pavitra Jha <jhapavitra98@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>,
	<stable@vger.kernel.org>
References: <20260502154252.164586-1-jhapavitra98@gmail.com>
Content-Language: en-US
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20260502154252.164586-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

On 5/2/26 17:42, Pavitra Jha wrote:

> log_replay() converts DIR_PAGE_ENTRY_32 records into DIR_PAGE_ENTRY
> records when replaying version 0 restart tables.
>
> During this conversion, the memmove() length is derived directly from
> the on-disk lcns_follow field:
>
> 	memmove(&dp->vcn, &dp0->vcn_low,
> 		2 * sizeof(u64) +
> 				le32_to_cpu(dp->lcns_follow) * sizeof(u64));
>
> check_rstbl() validates restart table structure, but does not constrain
> per-entry lcns_follow values relative to the entry size. A malformed
> filesystem image can provide an oversized lcns_follow value, causing
> the conversion memmove() to access memory beyond the bounds of the
> allocated restart table buffer.
>
> The same field is later used to bound iteration over page_lcns[],
> so validating lcns_follow during conversion also prevents downstream
> out-of-bounds access from the same malformed metadata.
>
> Compute the maximum valid lcns_follow from the already-validated
> restart table entry size and reject entries that exceed this bound.
> Reuse the existing t16/t32 scratch variables already declared in
> log_replay() to avoid introducing new declarations.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
>   fs/ntfs3/fslog.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index c0237f7d0..91dc2d503 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -4215,13 +4215,22 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>   	if (rst->major_ver)
>   		goto end_conv_1; /* reduce tab pressure. */
>   
> +	t16 = le16_to_cpu(dptbl->size);
> +	if (t16 < sizeof(struct DIR_PAGE_ENTRY))
> +		goto dirty_vol;
> +
> +	t32 = (t16 - sizeof(struct DIR_PAGE_ENTRY)) / sizeof(u64);
> +
>   	dp = NULL;
>   	while ((dp = enum_rstbl(dptbl, dp))) {
>   		struct DIR_PAGE_ENTRY_32 *dp0 = (struct DIR_PAGE_ENTRY_32 *)dp;
> -		// NOTE: Danger. Check for of boundary.
> +		u32 lcns = le32_to_cpu(dp->lcns_follow);
> +
> +		if (lcns > t32)
> +			goto dirty_vol;
> +
>   		memmove(&dp->vcn, &dp0->vcn_low,
> -			2 * sizeof(u64) +
> -				le32_to_cpu(dp->lcns_follow) * sizeof(u64));
> +			2 * sizeof(u64) + lcns * sizeof(u64));
>   	}
>   
>   end_conv_1:

Hello,

Sorry for the delay.
Your patch was applied, thank you.

Regards,
Konstantin

