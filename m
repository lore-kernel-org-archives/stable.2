Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13E3D25C6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588090; cv=none; b=MJWmIHXWZF94FYutB8d9b+UaI17KBCal9TRqSO6hiZjZtznipsuuW7wX46X5s9Sl88241dYOiWe473NfIGawRX+IjnTv7nwWOl6Os6gLENvhmhXLpNXfch4ZPrp56BFUInMf0zE0o+dUl9vjf8MM5DjrA7u2BJxFr8eWea3O9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588090; c=relaxed/simple;
	bh=OJAJRu0n0XMwis98w/W/bi9BjMgB+VA6wjfyMyjd+s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld1r5IlYloyL4216orYo8NvEkAIPC/Iud/Cd9IPsyud7lOG3GKJ/KNsPTpMHj5qC8/HR0OAeQvI0r265OReHJwqxmPiKPp1XA2bkdhw1SqN7NycCzLbT2hbss3zUlR7lf/US32n/jBMQTpkj255ZKI+Qk6p7VXzTM6IZkRpmYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGe+T+Gt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGe+T+Gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11321F00A3A;
	Tue, 16 Jun 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781588088;
	bh=kRgeD23SDOXTEaBOW3fA+2SN+82jwDbS4FXKc7M2R2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lGe+T+Gtixkz1cmQhwOapVfCYwxS5P1xxHtqk4gh/xGreBY+ooSaKPz5MEh94MLOK
	 AajxufIEP+BqlipeKj8abAu2kcNoOnPOwy2ffzml4hQfmBOR/rg9l/D7mQF2KZdC7m
	 h11vL8ZasN8Wd5OnsGMfg2ecGGu5l22hvrAFPLiWpAxi3qf2gWZBgofP7Z+d7JPiK3
	 BsfRgEQx1IdIGOkJ0Jcbg41+YnJwjDgUW3AmxBPkV89TqBZA1zxEQAnTcb/oodWirc
	 9JcUDbatjMxjUZ8d7qQkPqnyAI5Y8KcQN0JuL4FvXnlaMcDYUsNbr5wgJgLW3rYTL3
	 RcsIQci5aezgA==
Message-ID: <095d4604-b3d7-492e-b119-2bedcb63217e@kernel.org>
Date: Tue, 16 Jun 2026 07:34:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/uaccess: correct check for CONFIG_PPC_E500 in
 mask_user_address()
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Sayali Patil <sayalip@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20260615233729.29386-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260615233729.29386-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/06/2026 à 01:37, Ethan Nelson-Moore a écrit :
> mask_user_address() incorrectly checks for CONFIG_E500 instead of
> CONFIG_PPC_E500, causing mask_user_address_isel() to not be used on
> E500 hardware. Fix the check to use the correct name.
> 
> Fixes: 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> Cc: stable@vger.kernel.org # 7.0+
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Changes in v2: Correct explanation and Fixes tag (thanks Christophe)
> 
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

