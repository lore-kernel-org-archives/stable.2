Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CC25E469;
	Tue, 28 Jul 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250027; cv=none; b=DJAErv1YW/oM43Qx4sD3MzWuhVt0XAOVvOqP3iKABicxEWmgkm5eOFppkQwklyxNKHWgcWqxw5BJehP7EFpA4/gbvafkImpR8pMuGzobu+CKh+NkFkXH8OPCDq4Z8uNLTZLzBHp8YoLieMZmOxrt4e4PfgHY7+JMxVHSAef3+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250027; c=relaxed/simple;
	bh=GDlALHpSYvMVS3esr38VHv/LWHesNAL37zDP1ToS0Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3KpUHuxqURk0p73WUK0aai7z6hKxidJ+YXzwSPvTlgop+M9eamJNRRIez0hCThwYBPeEw8pF0xpkFf3QlaYK6uXgDqOSjABaVUdE4pOgY739NOtA4oKGINm2Ry5TKt0EaWOnjEg72i14SiSutSVJ5l+2c5CHVcn2UhyEFGzmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=dOyN0lfv; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="dOyN0lfv"
Received: from [192.168.178.102] (pd9fb98ab.dip0.t-ipconnect.de [217.251.152.171])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 86ADC2FC0079;
	Tue, 28 Jul 2026 16:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1785250019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sT6CbhRkcg1e9pX5FPp/IPdht09tHunh0WoTtem+JSI=;
	b=dOyN0lfv7yq8986YwwCYMxm763MtcGIdTsl34GoLr49jCdQa7AhzeGbnbgWfq3BZDyi3AA
	6vY/niNyCISifWwdqSOsAdjRH/oStrk2S8aWRsbZSV3PbaKao7op3GRhr6hr8GfknX1GR/
	DywEjL1dItJIH8ZuafrfbvwEKPN9muU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <cd0f5c3a-73b9-4954-94b3-27818b4c9664@tuxedocomputers.com>
Date: Tue, 28 Jul 2026 16:46:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] platform/x86/tuxedo: Fix keyboard LED map ordering
To: wse@tuxedocomputers.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20260728115938.125444-1-aer@tuxedocomputers.com>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <20260728115938.125444-1-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch was sent directly to stable by accident, separate from the rest of the patch series.

Please ignore it. It will come with v2 or a later revisions of the series through master.

Sorry for the inconvenience.

Best regards
Aaron

Am 28.07.26 um 13:59 schrieb Aaron Erhardt:
> The LED mappings in sirius_16_[iso|ansii]_kbl_map did contain a
> flipped line that caused LEDs to turn on in the wrong order when
> counting up the Lamp ID.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
> ---
>  drivers/platform/x86/tuxedo/nb04/wmi_ab.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/tuxedo/nb04/wmi_ab.c b/drivers/platform/x86/tuxedo/nb04/wmi_ab.c
> index 8f1ffca0430d..2b985b030197 100644
> --- a/drivers/platform/x86/tuxedo/nb04/wmi_ab.c
> +++ b/drivers/platform/x86/tuxedo/nb04/wmi_ab.c
> @@ -232,8 +232,8 @@ static const struct tux_kbl_map_entry_t sirius_16_ansii_kbl_map[] = {
>  	{ 0x2e, { 246000,  67500, 5250 } },
>  	{ 0x2a, { 269500,  67500, 5250 } },
>  	{ 0x53, { 294500,  67500, 5250 } },
> -	{ 0x55, { 311200,  67500, 5250 } },
> -	{ 0x54, { 327900,  67500, 5250 } },
> +	{ 0x54, { 311200,  67500, 5250 } },
> +	{ 0x55, { 327900,  67500, 5250 } },
>  	{ 0x56, { 344600,  67500, 5250 } },
>  	{ 0x2b, {  31000,  85500, 5500 } },
>  	{ 0x14, {  51500,  85500, 5500 } },
> @@ -337,8 +337,8 @@ static const struct tux_kbl_map_entry_t sirius_16_iso_kbl_map[] = {
>  	{ 0x2e, { 246000,  67500, 5250 } },
>  	{ 0x2a, { 269500,  67500, 5250 } },
>  	{ 0x53, { 294500,  67500, 5250 } },
> -	{ 0x55, { 311200,  67500, 5250 } },
> -	{ 0x54, { 327900,  67500, 5250 } },
> +	{ 0x54, { 311200,  67500, 5250 } },
> +	{ 0x55, { 327900,  67500, 5250 } },
>  	{ 0x56, { 344600,  67500, 5250 } },
>  	{ 0x2b, {  31000,  85500, 5500 } },
>  	{ 0x14, {  51500,  85500, 5500 } },

