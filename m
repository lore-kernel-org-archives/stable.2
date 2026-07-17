Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE03375D5
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301426; cv=none; b=ckboEC3i+RGk0ViQtjUmsav1O9XffVEExCS1neV6gJeHVcxZXP/uFKtnkIjsBcgrqyzZrFEoJxcg0eMxXUXaNXKgWU2Cv7mcDnPJ6rYJaltSnpOE1gC0c1Thq3ffcA3P3ypHg0OKZi4m853t9N3iwRwN7J4JawhPQyyu80Nzb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301426; c=relaxed/simple;
	bh=TTq4I5LbcPxcZinSKb8uDNZe7BzWWqfDJESOfHGQhhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFVpTGIKkZ7ypn0fcX7zy+sLuXHYxs2CuHt2xzDpJ724ihV5TJNO4fDLRTGkUIDyRNI6Epb/wmVguHJl8aWoAQLe77g+ErM4rva0zEFKxTqJqKKXwf4cn1ltM+Q36FF5CphdI5mocjO1ZySqTTPk13UbSZiJYKMxGlFKEWMLOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ErJkPTqi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ErJkPTqi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47d70879764so5777710f8f.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784301423; x=1784906223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ksrf2BBRNj0ansfYiNu1tWZJpJoXMwRWSwrgtPfAp0Q=;
        b=ErJkPTqi6TFyCzk66sOzJ6eY5wXAONttNlspawckWZB6mO/2+vkBDUVSoup1nTZ9LY
         +z2xw9fbKouIUNwc6WtPIHZ/qMVocg9Jji0YsNiExBavq7DVgngSs5YDGtS0YY/VbI0M
         pGklVkLwCv2SHiK9R2Je6fPX53LSrAgx7sxNGB0/BCwmiOtc8UrP1CvZJHFh2JXsTClw
         F/tbEWGU3odKvljxsKGq7HnAs94Mrkprq/U8+clKn+jl/ceBkVqRQNaE5Z55m6sChnEV
         ym/m/nld7jylR0r+T92gIdRq8l7hUUaNgwQ5xzQkWGHroh610TxqkZUy8/bxDdV4wb98
         mtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301423; x=1784906223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksrf2BBRNj0ansfYiNu1tWZJpJoXMwRWSwrgtPfAp0Q=;
        b=a5/V+ro41XVKwfWPzMleps5G5hALJNbOEPEsg34BjhekZdYYrifCfIBtg2ELopVVk8
         l3g6jnQx8igujalREKhXAxGDyBwv5q2M6Vp3LxkFNBMr8eBISa83nMBfrhixdFNOuElr
         6R+VKwlBJvPVn8MjOl4W2KQ57NanI3ay6rhmFfqs9H2aH2vVRVA3Be6lLdsqiijfXHGG
         iTFvRKf51JpFXaTeR5SboAvBtIALM2id9LlgsyLIhEEi23kNrivdHK+7VJMcZsiua4Ug
         83PgoHPN+qNPy71RlKuQ53cETQl8wH5N+bUoy4fjFWgVRB576lmF5ZjiaN85Rag5VNDH
         yRXw==
X-Forwarded-Encrypted: i=1; AHgh+Rrj+/yc2RpPPW4XEHeH2otk0LAOviZpIS2Vyd9SEEI35DN9M4t+nloslPI6/a8OE5/yFTfygcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRxuzek45YVTygXYwT1An2O2KpDaXXzBjQ8rkGL+2aGsElHrK
	ADuY8wIS6AoXpBJ1YKiEI5DE2njYM3sbtEODBNDCJbp5O+0BMkaysrLHNBrioFfnbf0=
X-Gm-Gg: AfdE7cndqwUHvdTyodZabnj7IAHxEwvVqJpuFK1UQJxhfYKS4GCFpFwNco+eXfbXnVt
	J7cSuJfyBN3nKMrpjVYyL+nO32z4eCGQbvEzGoQs5NdopnL49Trgk/tczXF7lk+862cka//R6kT
	UF/S3QnsXrmb76h3x3GTP7LZb120pjnKkEn7kKKi/YLVv2zVQlNQH6a8LUtVaOvZ+y5hiekm1u6
	3C5D7zjqvmNXnihViDNOMrgP3uc72BhixLLpFFBNQc8OVhugZBzGpBrsHsqc9s1IsgD9JCiSR4h
	sjTT1FRH8oVZHNafV17olhZe8SEUeRQN0Oal0p/ag5muaViRIEIl1fNVsuOJufhT1P7aMBdnI5a
	O0s8ph717v+OULTD4GFj4woll/U/CqypRBCWTBm0unU8DsBDflBpDzPYe4bQ4zponcwjXdaXAIC
	OJyjkQ
X-Received: by 2002:a05:600c:4fce:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-4954a404bc2mr40817825e9.25.1784301422930;
        Fri, 17 Jul 2026 08:17:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm55142625e9.10.2026.07.17.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:17:02 -0700 (PDT)
Date: Fri, 17 Jul 2026 17:16:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, feng.tang@linux.alibaba.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] panic: flatten nmi_panic control flow
Message-ID: <alpHZ7ZbeyWAGoIw@pathway.suse.cz>
References: <20260714173103.11585-1-include@grrlz.net>
 <20260714173103.11585-3-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714173103.11585-3-include@grrlz.net>

On Tue 2026-07-14 17:31:01, Bradley Morgan wrote:
> panic() is __noreturn, so the else after panic_try_start() is dead.
> Drop it so the force_cpu path can be added cleanly on top.
> 
> Signed-off-by: Bradley Morgan <include@grrlz.net>

LGTM:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
