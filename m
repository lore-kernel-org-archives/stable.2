Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86A30DECC;
	Sat, 26 Sep 2026 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384650; cv=none; b=LjOZR023qqwB5JyQ4/wIbpe5Wpce5Fz/b0tJRPrRyPUNjMzWF3OLRX4X7Ksk7Nw3+XhY3WV/GzHz8mghjr+aAwDk3EyL8B8ROzeYtbeqVL/ZsIPW5dx0n/Lz1BJXxFGCPCHJizkOkjzSCKGaG65cIOsXECPzcLwli/wzcnz2ZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384650; c=relaxed/simple;
	bh=8U75LH2YZ0EjERmAG9HdSnS6B++Zp3ysbEY77KLY6x4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpRsuTUIZUu2mvOTswOkDcjCwmkUpvtWbC60F0W6nz7U/P4obFhmnH2qmOL2TI2ZXayB0/+Zsss231V4FKpBK5AsaoszoX263q+QTRfMqBsDIJHMKFKb9D8543xrfRUmT1y+6Uc9YSY7xoUn1WhLGF8+bICFTZa2l9THsT6aHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekkDi2p5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekkDi2p5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E85F1F000FF;
	Sat, 26 Sep 2026 01:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384648;
	bh=/x/hINYzxjUDohV8lYnbflg1TO7wpw67uRBOdDOfqZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ekkDi2p5aQaxDGv7wlTSxTbhgC63gxSMILdVfMItXZXQlui4qtZV/T7GgRcHgiPhH
	 hQEmUvV/cc+yuiHiuhAld0CSnVcILF1057chOzhffYt5rxMh2vW+jfT2Nsd2835bfw
	 hP2LwRQ1HCNSvuImOkX1kVNCi7AA2sFRHz67PjNPWVQdxf+/jYDSZlMes2qg9lwvuk
	 8yY4g9NX0fIJIHj3gX3PAAgZMQizikZ1lyVbOA8rCaaMxXGLvvbWuMb7xkJit0dIEb
	 0yHnDjFPcipGWazzsUZ4hwD+ZWuy8k7zjwPYD+MCuhmWCCBIVE9GtRlxGFPHV1CWuv
	 cf9h744tUNX2g==
Date: Fri, 25 Sep 2026 18:04:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, Simon
 Horman <horms@kernel.org>, Tonghao Zhang <xiangxia.m.yue@gmail.com>, Victor
 Nogueira <victor@mojatatu.com>, Zero Day Initiative
 <zdi-disclosures@trendmicro.com>, hybris <hybris@mojatatu.ai>,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: cap skb->queue_mapping when the tx queue is
 picked
Message-ID: <20260925180407.63647514@kernel.org>
In-Reply-To: <QDISC-9R8V.v2.20260924072708@mojatatu.com>
References: <QDISC-9R8V.v2.20260924072708@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 07:49:06 -0400 Jamal Hadi Salim wrote:
> +#ifdef CONFIG_NET_EGRESS
> +	netdev_xmit_skip_txqueue(skip_txq);
> +#endif

Can we have netdev_xmit_skip_txqueue() return the previous value,
and also define an empty version of it if !CONFIG_NET_EGRESS
to make the code less ifdefy please?
-- 
pw-bot: cr
