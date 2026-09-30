Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B24E1C88;
	Wed, 30 Sep 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800022; cv=none; b=rR3ifjlX7hnwVK639RyFG9oP2e+EEY4K7iEBwfAXg0ID2OTk5gZPiIDcsfqBgCPFxOgP7DfC9LNdpPO6LQqQz8D0n1W7Grnk+UEo9ApNoK/ZnUj9Ab9LuEJTuEpGDZQq9MMkDOsIiNBCTHzqkRzvF9ENbKL8NdsNlm6Uesov+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800022; c=relaxed/simple;
	bh=gBxbbz8+38Y+s40Za87dlwU4FYsCKhVptdzqeBxOssw=;
	h=MIME-Version:Content-Type:Subject:From:To:CC:In-Reply-To:
	 References:Date:Message-ID; b=XXAonpSlMeNIIrdZ8C89I4kljSRqUy6PNCm0ye5UTgVpJE+fTuiBhJyphQIG6EH47Fe1BH1X0WNwEYAPzlzIT0iBQcACD7bhtIskKvtfCqePdLTbiDOZEoo5QTzGQXC0bejMuWaZdBIlfuBbxGEBTH64XeBHN8nU64/9fSZ+Vq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rQ8NtPMt; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rQ8NtPMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790800020; x=1822336020;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=Pv29v2l3ni5xtNbu+pW0MmRMAzR9cn9ltBlcm3SKBcY=;
  b=rQ8NtPMtChraEeiH1NTgZGrfDxbbgekm7hDsmp0Ex8g6LLO0k3xLlqYs
   twkMhKnqPAdfp2LCCb62REnHXy7HEs7IyCvHAQ3ku+/d2w7iIlopPkWG0
   ggTRGTI8NdrzyxzF6db+3f0poCerj9FTgc7K0Iit0M9B/4OIQnCBHhW4l
   UlTrtu8DkgniXFUiqZv6bmjKDRalmmOwqz8NnxS8AaKi7ujLKvtkD4H9v
   hYcMAj4hBz7TjS8q5Y9vv/RSR/F3WmwePdot2/1XR/9p9SGjICAlVjaiD
   T83oKMmC1irsOSLHp8JRNZ3cs5Co4YvYOcMXkOJr7GKiO5VlayhXkAYW9
   w==;
X-CSE-ConnectionGUID: 2EzWEmH8R6iGbrHniBJoiw==
X-CSE-MsgGUID: 4/5r+YDDSu2VXhf35/sWKg==
X-IronPort-AV: E=Sophos;i="6.27,133,1787011200"; 
   d="scan'208";a="29865497"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 20:26:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:24754]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.208:2525] with esmtp (Farcaster)
 id f3afff18-fd90-4d02-847a-62fbc03cd098; Wed, 30 Sep 2026 20:26:58 +0000 (UTC)
X-Farcaster-Flow-ID: f3afff18-fd90-4d02-847a-62fbc03cd098
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 20:26:57 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 20:26:55 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6.6.y] net: ena: Add validation for completion
 descriptors consistency
From: Arthur Kiyanovski <akiyano@amazon.com>
To: <netdev-bot+sinfo@kernel.org>
CC: Artem Dinaburg <artem@trailofbits.com>, <stable@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	David Arinzon <darinzon@amazon.com>, Shahar Itzko <itzko@amazon.com>, "Simon
 Horman" <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Shay Agroskin
	<shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, Noam Dagan
	<ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
In-Reply-To: <179073622069.31693.3189368668972123840@kernel.org>
References: <20260930024101.96014-1-artem@trailofbits.com>
 <179073622069.31693.3189368668972123840@kernel.org>
Date: Wed, 30 Sep 2026 20:26:50 +0000
Message-ID: <179080001006.18939.13526551078215165644.b4-reply@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On 2026-09-30 02:43:40+00:00, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Issue was real, and was hit in production. When a faulty device creates
corrupted descriptors this commit stops the corruption from propagating
further, and reset to driver either fixes the issue, or if it continues,
helps AWS detect it and replace faulty devices

