Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287D31ED8B
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270896; cv=none; b=KtF3hygtYwwJ1mzL9+LSHG3B0fxSvIyMsM2IM8xC757tGoCJi/sqjsbIES8fyGFLnpZ43Hy4msa7g5sZmeMku8S9MqzleFO2tR5RE5HQD2KcAw96uEt0oc6Oky+/BOH+HRZvrDp3VL8awBfB5yqOg6XEnS+CH4kaMluMUN9nsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270896; c=relaxed/simple;
	bh=Qmn08evHSMv43v0YQCFOwx+bcM/SBxpKzIKiC36SEYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tr1cQ4VVroftBJvyiqWDTnZd9br3n8g9x2DUbuM+4LqaKALZbZ4CCwf9g0rpS1XqcCcFRilojlaPLucx/Qh2CNVHObDi8hyMawqgwNO+XEgFLhV4jvhJqevXOm1wJRyC47tbMzROftofV6MvB6V/sRdFXgfj3TfX2zZwZdFLgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwrXLtFZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwrXLtFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62EF1F000E9;
	Fri, 12 Jun 2026 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270895;
	bh=ch+yj1d1xkzfN77vmuNFUc+RE3Ma28b1qL2J7+Wwpio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XwrXLtFZu0cYo0VsvAzGGWQxsiuhprgFN6uuIaAcoT50FCyGnbLkikPtvpaa6L/cw
	 mVbiF85+bI1U/QlZyHoQ9bH8GMYsougELaMNGRU7ydYqK2muhA4SDF8oY6JSgCoRpp
	 INLlVP4JfrpmSJslGc3SRz8LkbGv/NHVDg8GmvGLC8AjlWEA08COsuFFqRoeT5G1rs
	 mr0Iruqh0RPhkfJhJXLtkJlo9IDKaCUlshgcwYI67ZMPT/1XwVFvyfpbjkwqQCBGFl
	 u78f6X/L7enyc5+o/+phLuv0S7cG5/qk3fmA+52i4liKEkgQ2BReLWv65C8ETUIziD
	 nwhkRaqGvTdRw==
Message-ID: <598af26b-0f1d-4015-a3c7-b738a7364ab2@kernel.org>
Date: Fri, 12 Jun 2026 15:28:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/uaccess: correct check for CONFIG_PPC_E500 in
 mask_user_address()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sayali Patil <sayalip@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org
References: <20260611010914.429574-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260611010914.429574-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/06/2026 à 03:09, Ethan Nelson-Moore a écrit :
> CONFIG_E500 was renamed to CONFIG_PPC_E500 in commit 688de017efaa
> ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500"), but the check for
> it in mask_user_address() was not updated, causing
> mask_user_address_isel() to no longer be used on E500 hardware. Fix the
> check to use the correct name.
> 
> Fixes: 688de017efaa ("powerpc: Change CONFIG_E500 to CONFIG_PPC_E500")

Correct Fixes tag is:

Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")


> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index e98c628e3899..619270bb7380 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -511,7 +511,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
>   
>   	if (IS_ENABLED(CONFIG_PPC64))
>   		return mask_user_address_simple(ptr);
> -	if (IS_ENABLED(CONFIG_E500))
> +	if (IS_ENABLED(CONFIG_PPC_E500))
>   		return mask_user_address_isel(ptr);
>   	if (TASK_SIZE <= UL(SZ_2G) && border >= UL(SZ_2G))
>   		return mask_user_address_simple(ptr);

