Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5338E12D;
	Thu, 24 Sep 2026 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267842; cv=none; b=CanWwvJV0KMpao3BbvyN0Or1UBfPHYJeo6FoI0NnZawPmZXxFgGQMtFx/8Ub0iITg6HxA5QqIYm1YiNpA2MuWUcoo0ykjHKMIVwQLYWy3KCmR3xfb7EoiMeznOXbDpmvd2Bpt/kvZYfLb6DyaCrIDg1YGhjd6MxTVfDII8JXz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267842; c=relaxed/simple;
	bh=JNY+3lrRXLTOXbpNBhs6hsk9P4bg73o44gz+JJNi1+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQDDLgqxXK1mod1GZyezSs9xpFQazEN6o4zPoqwDu86xg/Atcqz2w2L4hWy1enRCLDbxn0ft4sgoFN1dVsDCEEUYFgFJFRbGgrme7LMkCTYUxiolGCotK8p77Xq9k+G94jggo+rMu5LjY5vNek1vrD1r3RfFfXWLZ5RLSy9/rOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Vfz+ZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Vfz+ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DFE1F000FF;
	Thu, 24 Sep 2026 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267841;
	bh=I+KM3XycZb1fB0feVpZefYDBavv/Sx/AWXWw4Fmm13Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V/Vfz+ZXD/r3+1W5cwPliw16S93R0IiT68GX2q1xLne1B68fHVD0Pcl2oTLxrZLR8
	 Bed4jmBw44Eegw5lQss+P9vm8JGA+eeApWkkV32ywNdYWYPsWkrkQ6n00Yn4mKjuoN
	 upQvcMdOg9gHZSEd89ReIPwjl42zOfb7sustzjhXyUvU6ykxeVLHkr4M1kMtVASwAk
	 vWIuwp7E1G1s0sBn7AtiQNDvC5amVtNM0GDO8piYoPf/mML4hJJDskTPkLnU34MlHv
	 9gNDR+x5dpv3ZC+yW2unz+IVb3dUbLPV8czA40R4S4/0ezmtQk6ndMGj1R6vrnZPWA
	 spTGA09k1+2gA==
Date: Thu, 24 Sep 2026 09:37:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 lorenzo.bianconi@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linkui
 Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: request the MDIO reset GPIO only
 once
Message-ID: <20260924093720.1aaa697e@kernel.org>
In-Reply-To: <20260921015727.2643540-1-xiaolinkui@126.com>
References: <20260921015727.2643540-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 09:57:27 +0800 Linkui Xiao wrote:
> +struct gpio_desc;
>  struct stmmac_pcs;
>  
>  struct stmmac_resources {
> @@ -287,6 +288,8 @@ struct stmmac_priv {
>  
>  	unsigned int pause_time;
>  	struct mii_bus *mii;
> +	struct gpio_desc *mdio_reset_gpio;
> +	u32 mdio_reset_delays[3];

Someone already marked it as changes requested but also no need to
forward declare structs unless first use is as function arguemnt. 
