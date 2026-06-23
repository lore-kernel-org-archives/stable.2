Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C82E36F8;
	Tue, 23 Jun 2026 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178897; cv=none; b=UjRcd36pGwkE52fELX69bSoszWjXYhPMa11oDS1QQRvhXbb/6k1p3JavAt2GpUcqrThxOhkJ+vTxkd4RapAq2Zel5TJev3zhAGd3khmepOduX+fpwwXL0Zzuto3xSTFBxuBrZXsPFQ7CtP+2AiVGK+u4CbKa+UpcenlNifPUEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178897; c=relaxed/simple;
	bh=jZJvMjh77n8hdoYT97eN9tBxTe9H0AF2EvpQ7Y+WUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF6+HRnDFlkY9HEuS7Yiuhx20Ccv4h1gWwDOX5/w06FD+KBQCeOByvBJjBlULandsvo2V/XI7aRAIcMQuhGNf2J2B55RHzHEcawah9kwYRvT1qV/89Wt6hJbjRWw5Gh6qbtxkH9MDMo5JmrfGh2n+vSMFxybamQ61ae1Cc4n1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGA9qcDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGA9qcDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122BF1F000E9;
	Tue, 23 Jun 2026 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178896;
	bh=jZJvMjh77n8hdoYT97eN9tBxTe9H0AF2EvpQ7Y+WUH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aGA9qcDkBHeimBJIVzteOPU828olZbgJoFvC2ANRWr2N+AziMo9cOks0ahzS9DdSM
	 pwDZBo1OX7uUNO1GYobIvZ2wybfpKn3DDlhnmnwf6tSd7xdus4NrsL9pHTqmvS2RU2
	 jTJZTKQ4eW1A70C8XNPt+3YLzOmBxXuly/EQd85hcGaIvEYma4Y2htmKo08YYK0U92
	 hwB0ncFKb5wSovB8bJp7Xr5gHduibp0Sa9sP8VjSYo82tX0b36puXx79lyv+AOrQo6
	 uaE0zMS9XqS/QEg46fLpLA7Z3/yd+6LCzXWZ0h6zs9CC8fK3ah+00Oi8N9FHFhWsgc
	 uWbRdM2/dNCpg==
Date: Mon, 22 Jun 2026 18:41:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>, skalluru@marvell.com,
 manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, barak@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: fix potential memory leak in
 bnx2x_alloc_mem_bp()
Message-ID: <20260622184135.4f185dac@kernel.org>
In-Reply-To: <20260622130515.GE827683@horms.kernel.org>
References: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
	<20260622130515.GE827683@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 14:05:15 +0100 Simon Horman wrote:
> FTR, there is an AI-generated review of this patch available on sashiko.dev.
> While I don't think that should effect the progress of this patch you may
> want to consider it in the context of follow-up.

TBH it seems like an adjacent enough issue to me, but okay...
