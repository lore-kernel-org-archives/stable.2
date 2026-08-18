Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D312FF69;
	Tue, 18 Aug 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034676; cv=none; b=m7eNMQY1u2E8PCBkNh48ImAxbtwsCgpt69dbMa1jZHCZkMAK/MbE1+gNYEM36RxgzLXFr1x39RXenxzBKEmngEzCQ8pcMTyKbvmq6xljOWokj4QtHDjEZsTXEnwJCEJWuszWJdR18GKuSBqj3DIk6t9C56LqQBdf1lDqPshFrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034676; c=relaxed/simple;
	bh=oyTnicrXmfy6OAYX/BWV3WFgIs8HebwOm6OfeXNFF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8grbt80n273TryS6JHaHaYT/tU6heEIeKIkJI6hHXYm4hRe9qNO9nWM6Up2/Jo+axGb/Dc3Xf/Qa2uKAF66oWhexcqrDGyEJOTS4+ifAMrTEQBpsjOIEsir5GZahFdGTaB86Wi1O0Fr7NepLshNMn0S92M5imBzLDYJgGpBt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YGm0DQ97; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YGm0DQ97"
Received: from ideasonboard.com (mob-109-113-29-237.net.vodafone.it [109.113.29.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F263244;
	Tue, 18 Aug 2026 08:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1787034592;
	bh=oyTnicrXmfy6OAYX/BWV3WFgIs8HebwOm6OfeXNFF5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YGm0DQ97CtUhFos+SLlS0jgWJ4MvY3Cdi3w9CbfNIpaXlyq7lm2ZA93ET+V2ibU5M
	 /48eemRnKP+si2EjXpqHksfKTArmUm3bbi4xzRqylhP2AZu9KntFe9lVNSnQh3GDYc
	 KWZ3LVr3+Qp8QLtZR7yYZ0plMqhJStJMYfaOSsTw=
Date: Tue, 18 Aug 2026 08:31:08 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-isp: reject zero-sized parameter blocks
Message-ID: <aoP7A6oYPkjmh3gv@zed>
References: <20260815193839.141406-1-devnexen@gmail.com>
 <aoLZ5e0ffVvZ-FfB@zed>
 <CA+XhMqxR+m7Jt0UUHetCfXSHHtW5w-jUc0_PSSWjTbprYn8ZwQ@mail.gmail.com>
 <aoMuMvE0zJG1MYD2@zed>
 <CA+XhMqxY3u5YR06j8jX2+wCwX95vQrb5EVH39GvuJXrwA48XWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+XhMqxY3u5YR06j8jX2+wCwX95vQrb5EVH39GvuJXrwA48XWw@mail.gmail.com>

Hi David,

On Mon, Aug 17, 2026 at 05:19:18PM +0100, David CARLIER wrote:
> On Mon, Aug 17, 2026 at 05:56:30PM +0200, Jacopo Mondi wrote:
> > Should we instead deman that all entries provided by the driver are
> > populated by failing validation if info->size == 0 ?
>
> Good idea, and I'd rather keep both in v2 if you don't mind - they
> guard different things.
>
> info->size == 0 is about the driver table, and it lets us answer
> "this driver doesn't handle that type" rather than carrying on with
> an empty entry and a NULL block_validate.

Do you think we should fail validation because the info table has
holes or we should simply skip entries with info->size == 0 ?

I'm leaning towards the latter fwiw

>
> block->size < sizeof(*block) is about the buffer coming from
> userspace: a block's size includes its header, so anything smaller is
> malformed no matter what the table says, and it keeps the loop moving
> without depending on the table at all.
>
> Both are a couple of lines, so dropping either one is no trouble if
> you prefer.
>
> > Right.. you might have seen ?
> > https://patchwork.linuxtv.org/project/linux-media/list/?series=29170
>
> I hadn't, thanks. That takes care of the rppx1 side, so there's
> nothing left for me to send there and I'll stick to the core change.
>
> I'll reword the commit message so it doesn't lean on rppx1, and keep
> Cc: stable unless you disagree.
>

Yes thanks, as v4l2-isp went in in v6.19 this is worth a Fixes tag I
think..


> Cheers.
