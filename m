Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B57261B9E;
	Wed, 16 Sep 2026 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518467; cv=none; b=YFkF2JgfuZhq14D7D/97HfiBL60mXmySXB5N5vo/4OswK/0iR/YmHF4V8f44cLFjwBcjjY8lcIH1B80Pzlbxwur2uDEfzLNC7UrHbq2lgCjk+BblJWCXxK0vw6c1TrDCjGuJXQCTkpssrsTYhkA94ev9lbNnGevxMksesWTWefM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518467; c=relaxed/simple;
	bh=zBHeSccDFFkxDFgM+LQwqGnqD0GJ/exIAj5s4pWJfMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/WOoy7ZmSITwledjXrl6/H0sb4gt75I9TFjrAIt23Ifgt6DIrUEKzEDDKtetAxgnN18ZPTHeXlXppt4AaFf0ZyfUfiRuMZ70+b6P8iKCPUhrNEsACXTLYZCw6QAc2CJUa1+cpGZMo7+7R5uR6ckMubl9sV0xegkZCWZzvJp8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYt744jW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYt744jW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2EC1F00893;
	Wed, 16 Sep 2026 00:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789518466;
	bh=LZVhOwbUIyk+nmeyfUkudCPhv2w7uxIapEjDJgnaAYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lYt744jW6Ij05BMOv7YYa2wSwbwuP2gRHcMGj0ME7HHbUTF5ykuBuSU2Fx4zmudWw
	 7180uvdP4nQebB0dgT9pFkFto2AEgCrF2B7OJkmmF9HBXKlm7+9yK+btZ3PEDm0Qw/
	 OyjwdlZDEjW7i0srSJolTaxhuM2HLyFl87NJdH4Jih3rywJlaFAQQPxbODlRGrmdZF
	 TEtDvdhS+5aCamlpK9tFV0L+gQJo68byN8c160pBRSMYNTrO5XioDLo9O1waSRBt8O
	 8C6Z8OrAERMfaOVZ+So9ziN7x5sjwTYdiuAL0nFkOx6VhPzduRdTMSaIR9lfRlxceH
	 82Zsu9IbYlriA==
Date: Tue, 15 Sep 2026 17:27:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH net v3] net: mana: fix reset work race with device
 removal
Message-ID: <20260915172744.06c9521d@kernel.org>
In-Reply-To: <20260909042529.652301-1-fanwu01@zju.edu.cn>
References: <20260909042529.652301-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 04:25:29 +0000 Fan Wu wrote:
> @@ -420,6 +414,8 @@ struct gdma_irq_context {
>  enum gdma_context_flags {
>  	GC_PROBE_SUCCEEDED	= 0,
>  	GC_IN_SERVICE		= 1,
> +	GC_REMOVING		= 2,
> +	GC_SERVICE_DURING_PROBE	= 3,
>  };

Looks like AI isn't convinced by you fix.
Locking is much better than state bits...
