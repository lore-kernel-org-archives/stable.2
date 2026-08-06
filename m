Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44556388E63
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038028; cv=none; b=lrl9sPA63rrheDeVdkyqtbZyWyrGlG3caVxxOnvGKwWSE9K7lckI36d0nwIORdCvYJI6v4vAa6UMBtvQ4IUFmEbHhmT1DVuvWmRjhMd8ri4dJul3QPbl+cI8+JjkdfG1nNmsNDdPb325JUm+oTX2wpGimr9x3JnkafFqqG8FoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038028; c=relaxed/simple;
	bh=4gBC82AL16GBiQM5oXJdtIeduPX6rIIaoegoKmo97zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOLIWdQX5lzdOoutafTD8wM4jw6XVfhcR3ggNc23X5nhtaT1EaofGGyq+udnl0UwC/xWatJJGe+659Dk5KrlJXFFpWz6e0T/+07fNPzdAtM1Am8VorimGcI5Sr9LzPYvfj4BMcDTnOS70DhFewBhkQ6YN9rO4ThAslVIVmx9zVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3RMcIZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3RMcIZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14051F000E9;
	Thu,  6 Aug 2026 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038027;
	bh=znfJnEAUyeO8D49zhqYdPlQPDccY2ViV9Q9H4TbYnpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E3RMcIZjHimluJnG+8yIcGs4JuU1GliAPEJyHPWBGo+eLn0pUY6SQqRzVPHLsFQNg
	 fahx95G3DEUSQvrk4cgSr+fLsIjMd/cMNonCRsvh0vZRCNx5N8b1SjGCiOgsIdd/d1
	 aboOcTEJg1ZkgQXJrPPdUqZcwztr15Luh/bL+fozi4+IfVTrk524iafkbTbcvEk6n2
	 /ItolQVQUabNjXP1b9bcJYB7JyTsTbVqQtFzriSFd+ok8mNWdJPM4IUSHArPISHwMu
	 CsfHsQFlI42PvECLYtWPy3x1YJwXzPqOSY4ZY9j8PR/6W+D1HV0tQ49Wfpp8WXF+n2
	 cXXMfo6gQsVsQ==
Date: Thu, 6 Aug 2026 13:40:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6.18.y] can: isotp: fix timer drain order, wakeup
 handling and tx_gen ordering
Message-ID: <anTHCfIquCTzW52G@laps>
References: <20260805125414.30592-1-socketcan@hartkopp.net>
 <20260806021809.0018-sashal@kernel.org>
 <6596e764-a9d8-4557-99e5-585bd680c3ef@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6596e764-a9d8-4557-99e5-585bd680c3ef@hartkopp.net>

On Thu, Aug 06, 2026 at 02:09:36PM +0200, Oliver Hartkopp wrote:
>
>
>On 06.08.26 13:36, Sasha Levin wrote:
>>The skb->hash echo tag doesn't work here.  isotp_set_skb_uid() is only
>>called from the TX paths, never from isotp_send_fc(), so FC loopback
>>echoes arrive with skb->hash == 0 and alias the so->cfecho == 0 "nothing
>>pending" sentinel.  Upstream is fine because d4fb6514ff8e stamps the UID
>>in can_receive(), but that commit isn't on 6.18.
>>
>
>Ouch! Thanks for catching this!!
>
>I just focused on isotp.c - my bad.
>
>What would be your suggestion to solve this issue?
>
>1. create a 2-patch series which applies d4fb6514ff8e first?
>2. turn it back to the original if (so->cfecho != *(u32 *)cf->data) code?
>
>The latter was tagged by sashiko-bot to be not safe enough.

I think that just a 2 patch series would make the most sense. Thanks!

-- 
Thanks,
Sasha
