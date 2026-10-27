Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062005;
	b=bXLdbypZfEOztHdVySqRRZGuiXYqmb+hK9+7Az+cIp21Do+NqLdhndF3xnor7omXkWjz
	 FtzsOEpVO046VIslJqaMIuGwROte5+MSSq8J1N7A2UiQJscQaLIpY1WTeAKZ0tzfnhg0v
	 G4Z+tXEvCnMbVnlC07uYDwpwamVgyr/nT6Vn2LLSRr6//Ntf0owulg/Yj6w5fZDNBZcFD
	 sHX8Lq8P9NlGqjwuGgzkDFXkyvb07ww4h7qPIUs+lIWFUxlEHa75t8nsiSxXJTMQhZIsF
	 On2n0dJnMXO9Ke00eAZGFxpaVF2X2CB4SmVOlWg2sQbMIGTv6nldwd24T+1g8HZZlGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062005;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZngjApXBwmI5Dj+rE3iM/EGsXH1AqtCAMJVJfN8fDto=;
	b=HVhibsKVpnQgTMjSomaP3CyuiweTpaCrPHmaIeq7TAjRZt6S3Gz3NiR+IDLb4OdjHgFZ
	 2hzddBzIbjdr99zooPGDVh8KB02exK/cLVP8mVSsaLgIx4r2QGwKMOGYaZc1sadDTh0w1
	 uB4yeyz89udhZfPifDGsqkE+WMNAYhSKcUCmrI/6p6vqCFU3tn55rP7Dt29Re6iUWNAYL
	 Ju8eIqRHBQpQAAT6sPcgkjniySYNkjS+TQ1iNU6q1zDeCxJITW1aIqyfyRqFr2PSM28pP
	 maej3ZKQYIif4GFxbc/Gyj4n6Fpch1flLMoohQE68a4KAP/6vUBQBKfLnhjNjbnW8GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAS3a8wf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CB606A32C;
	Tue, 27 Oct 2026 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAS3a8wf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788E81F031E1;
	Tue, 27 Oct 2026 00:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793062004;
	bh=ZngjApXBwmI5Dj+rE3iM/EGsXH1AqtCAMJVJfN8fDto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DAS3a8wfxOvx3pVaKXP8jgKRdrOHg3ZxCBwkxO74lzHvYBpIrdxTAjVcMHZr0ahyZ
	 Li7JVXbgzYH0TYG8kiZyIzezfNCIOvghaLD6zNCqnMfFoczCjZGPQn5EiBeUQbuCMs
	 oQaRL2HzGr/lCtXRapnDcRVSHG7nMeW9/QMJDvJAL0FA2Jr3dbJqSQG0p9DSilEoqW
	 Pk/yhGIVpogoiPWfSpJdz7C+1DCXDQ7k3z1Z3wGf+MxJMuK5BVNQ1SpQcJfIZvULWf
	 oAVPDAFcEmGoR7kTx4aMQv0xl/eillX9lm21tNDGyCzfw8umkEQzOpEKpLhJaRMtjx
	 8Hr9fdftdT9Zg==
Date: Mon, 26 Oct 2026 17:46:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 victor@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
Message-ID: <20261026174643.088e3f49@kernel.org>
In-Reply-To: <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
	<20261026160747.283702-1-horms@kernel.org>
	<CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email says "Hi Jamal, passing this on for your consideration as it
> > seems to have got stuck somewhere."  
> 
> There was nothing wrong with the headers this time - so not sure what
> is going on. A bit frustrating.

It is frustrating, you are the only one with these issues.
Patch 2 is posted in reply to patch 1. IDK what else is wrong.

> In any case these are complaints about commit messages in both 1/2 and
> this i.e there is nothing to change in the code.
> If necessary, I can resend repost 3 with the fixed commit clarifying
> the "identity for every other parker"
