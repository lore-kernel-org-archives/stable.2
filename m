Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF63DA7CA;
	Tue,  4 Aug 2026 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887006; cv=none; b=BGmAbj/naBKo0wnqOzsWFA/EUoJaYXFL3J4OViiyAaLxUx1asGNAg/PIeQDkzTwMSNZW2YSvQIU0FU0AdCR7UHVHLqBWCSaehFgJCGIMs9DOSeX0ue4EvZOeCqmoofe1ydknkxliXT+8KR1JUD/3WwTeBtFNcDRIGd7dVi+/WNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887006; c=relaxed/simple;
	bh=8fZ33NehbireN9X1cMc6ZlEUfw97po6kpyQrpB3D0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KR7Pnpz62cpvOe6VZay+q7PPHgSh+0qtBse89WeD6ECtngmtIAPe3LLR685tT+WaBzyFkaAwy6TkBkcNnPGN3weW18Or5XAeoMQv90iyvWvFHPUxsiQ4easxvWS4S1lxu6DTdmYyfHsgPppWN9mlRQLnxTwfTKxD8Sy5Q+CGz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJj0rmZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJj0rmZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BEA1F000E9;
	Tue,  4 Aug 2026 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887005;
	bh=VsG9+hWYXvtvWC6PNCazoNhEpgqS3GRZtRCLmZ1cPto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WJj0rmZbsQH8LkJw+j5T9nP4LuilRHfyLzPwpBoP0NCGBT1BSGlD42Nfot7ZTvHxu
	 cCaOHUrY2iZY9ic47q0L9I6MiTfo2VNiv0g34gB6oyG0MQRR19lVtn6UJz4JQ4l0jV
	 WCwP3S97rSYyJa8BicB9UgNMm7U3aRefZC8GmRxnMVHxX+Sq3NexBQY3P/btijNYOg
	 hUXRpdpH3xJ1OzEZp59rAj3u6+kQeV18CWicO5s3WvShbA02vaeYlvDk6h4d0FeDlG
	 1aEhGwWGEpxFFA4Ej+guLCyEgI1L0KrrOYIMTDPJiHywDkcs9XxnRhl6GtBtxkpz7Z
	 v1lIea+h624LA==
Date: Tue, 4 Aug 2026 16:43:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, netdev@vger.kernel.org,
 daniel.zahka@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Message-ID: <20260804164324.49528d7c@kernel.org>
In-Reply-To: <willemdebruijn.kernel.ad7f187edf35@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
	<20260730082925.93759-3-q.h.hack.winter@gmail.com>
	<willemdebruijn.kernel.f39af6152c60@gmail.com>
	<20260803192228.49a49867@kernel.org>
	<willemdebruijn.kernel.ad7f187edf35@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Aug 2026 23:04:54 -0400 Willem de Bruijn wrote:
> If I read Gemini feedback correctly, all reports are about the current
> solution falling short of fixing the instance of this race condition
> with dev_hard_header(), which reads dev->hard_header_len directly.
> The patch indeed mentions this limitation.

To be clear -- prefer looking that the netdev-ai instance.
It cross reviews the feedback with different LLMs

> As well as the same issue with dev_validate_header(), which the commit
> does not list as limitation. But that one is only reached with variable
> length L2 protocols.
> 
> Side note, in net-next I can probably remove header_ops.validate now
> that ax25 is gone, and with that all of dev_validate_header. No other
> variable length L2 protocol ever implemented that callback.

Let's do it.
