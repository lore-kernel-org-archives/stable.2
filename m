Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717712;
	b=shsICgF9yyuL8N8dQwbrf5iVHqNA/W3qPqwAz8HqXOUfF/ZXomg7RFbQuMJtZqOIQRMq
	 iHMujxvl+0IGv+nZjYEGw34H40n3cPNJ5ujFRfv9CR1biHO7tI4GMQYXpGAWGZEX8Uicl
	 dlLsTkWyeW7FRmtTqvjjsuZk9YbMiF6hetk/4DNqLaU5AjDtnPq0WNmn9Bq38/vKk0TEh
	 54Ux9kA6oFHbQUCa/Tvzb5kvyemuStjOKlsHqmupenjO83SGlHLN9i1taCTnvArVN26kA
	 NTn5555CmZ8vIqTzuI56v51eD6n461ejkr4DP+zvhZTDdyy6uT5l44ZYYizDzLjKBjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717712;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TXpL0iKQ4koaW9ORT5KKPDTcDPfFf4c9CnXseUynUFA=;
	b=1GHFKUjUREfg4mRTKbwM3dtFzco8B8pYlhu15JygML3zQZSpuInQ10WWuaBHTIu6bq/x
	 DxgqLPshJ0yr6qFPUMb63lJiiPuB63xPYvD1YeQZm6cFWEhNJvcPzqAZDycEqYvC23C0k
	 JGAT5zUiYCdulrcx7aSFgaHKCE7vFCFkS3AKR87+oqyC2aVhSedF5aMbqSQ/Gchbmke0p
	 npKHeZWScKWzLfJrgx1Mokcypx7l9rUee+8PZDmBj36+OaoNHRv2S/7eP6VYI32B+1iSJ
	 dfvPPJjgecyN6lFuNc2kwiJMTNu295wRrbgmHDtX4ec3XlKaJO8TX3A5WdEX8ha9gFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN5X8EQx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CF606A31C;
	Thu, 26 Nov 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nN5X8EQx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A35F1F000D1;
	Thu, 26 Nov 2026 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795717711;
	bh=TXpL0iKQ4koaW9ORT5KKPDTcDPfFf4c9CnXseUynUFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nN5X8EQxX27K1HxI69N72N4KFZGpt3nlNJ4ea9eUF8sSQbCC9m09eSrSL8IRSomcn
	 XAAmoLchSpRMuScmNSbjHP0PjeUj2t994/KVwwMU55G8SQ3lM3g4YzjKdNT2WYBblD
	 sH1KrajoQiEtq8JMeUP4S1/VfpKsNm5IFclgpKyIfbgzJp+hQC/6lxx0lMiH44Dho/
	 vo3d01xyyBJXEUDScLwuKVGEVJzPkvHQLDEkN4hXUpUMzW5OvUxckjIWP47v8e86QJ
	 9otVI1s+3CAU0WPAK61E1U4eRdFr3Ex8TMayBXj6EP+L+Up5/HtOFQDZ2sOSMg8v3i
	 D0YgMcfysOaOQ==
Date: Thu, 26 Nov 2026 18:28:27 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, mfd@lists.linux.dev,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Markus Haberlander <markus.haberlander@rosenberger.com>
Subject: Re: [PATCH] i2c: cgbc: Fetch the status of a write transfer
Message-ID: <20261126182827.GL38590@joneslee-macbookpro.roam.internal>
References: <20261123-cgbc-i2c-write-status-v1-1-5b0fa0322b57@rosenberger.com>
 <179568834099.302193.16315749597111506309.b4-review@b4>
 <awgwO98qx3zX4MaY@zenone.zhora.eu>
 <awhxAlhwF4QF3V6a@zenone.zhora.eu>
 <ef2953ba-1510-4bd8-85c1-81d4e45d2693@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2953ba-1510-4bd8-85c1-81d4e45d2693@bootlin.com>

On Thu, 26 Nov 2026, Thomas Richard wrote:

> On 11/26/26 6:49 PM, Andi Shyti wrote:
> > Hi Thomas,
> > 
> > ...
> > 
> >>> Yes it conflicts (compile issue) with the series [1]. The possibilies are:
> >>> - I pick this patch in my series and send a v7.
> >>> - [1] is applied, an immutable branch is created, you rebase your patch on
> >>>   top of it, and patch is applied in I2C tree.
> >>> - [1] is applied, you rebase on top of mfd-next, and your patch is applied
> >>>   in MFD tree.
> >>>
> >>> Andi, Lee, what do you prefer?
> >>
> >> Let's wait your patches to get in first and then Markus can
> >> rebase on top of them.
> > 
> > as you are going to resend your series, would you be so kind to
> > include this, as well?
> Yes no problem. Thanks for the review!

No preference.  Happy with whatever.

-- 
Lee Jones
