Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299416;
	b=o7nyQgns3hMJOSP2wiOPyXc/iDtmwh4/4WvSSq5hnxIUWRjBy/eT+zYRi3DBWrJpxq7o
	 jOPfYchoQqCL9lY0gxV3VAeR5Y5ML6JRBy/CJ3rbgImm/PH1WJZfiru9NBTTdNvOX2jhQ
	 DIVEki1xMyYjYKG/4vldTvgBo4TWOzXXyEm6PvuFYoVBblPevGA0c0F991yyQ5vZI+7RJ
	 lBcXNkbNRN4BJUUI+EarVXHzTZH/TvY8pB6JZzWypVR7Z7F0dzVJIdqhdEozGKlVsgCmt
	 JTqLkCIt4oXnJ1N9+gey1yH72yNOZxzEareZJ60wO6tfjdu9iyfSKuan5pygiqNfSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299416;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WQsBCYJPFP8g3/q9mDIq2M55lwHybhC/ju0LSf/TM3k=;
	b=Wm6qgrfXRtSyUxeLsIlKhcPHHD1huVZL++KsU5FkFO4bOGwWaf0YaHrWRFzSAdOp/WYm
	 4FjkiZmC3ZLhxjPJuXw2Ut+WN5worDDw1wcFrMRKZFrJ+isvYFSPA1dEWSleE15cFtIZY
	 vRV6HvUAfmi1nvKKjj1jTG/OoisSZu6kFzLnAHVkkSpg/UaCZwpUrGjhC+lH7NSAdQfdM
	 t6CquFr/+f9EfWDmmq79KTccAcUYNqQu6UaTAfGqsCIm0QHyLkjiwDTVGXVQZ4+wwW+Pj
	 nroOzrEPjX3fi1mHq2FbA2ioe66jqftETISz+4fFynSQDbwfzPlEJlFFGBNFw4vnCaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBtPu7yI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC468606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBtPu7yI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EE51F01826;
	Thu, 29 Oct 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299415;
	bh=WQsBCYJPFP8g3/q9mDIq2M55lwHybhC/ju0LSf/TM3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GBtPu7yIsp8AwI4HnfXKgmPNVbhsIdjqDu1fLe3CboNFdbu6DAsHmnTgbpgUkH/jb
	 2jZktyXFpDuFQCoOFpYM2WVS8FKnGDUtKJowN9JYyoXnhYUwHwMtryxuKeyOwitcWv
	 1xLTgYIvYGOHBImj88dgw7pncH82Du5ue8hAij7BZo59ccUVwF3+a1WOCxSm3g8PwB
	 fFjLwuYDEboyT+gCGplEatYYjR3r4ARtgDwVbaDoar9jdYzuwjP+5Y4HsClTXrLR5x
	 RQaxeodGpdsUebxfLlGhLmmb8rBud4/Yu8jaBv1AjW8eGFh5t8faMhgZEM/CDagVd6
	 FGFeU/mDgm86g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y v2] net/iucv: fix the recvmsg window update
Date: Thu, 29 Oct 2026 14:43:09 -0400
Message-ID: <2026-10-29-1-daily-reply-0002-iucv-recvmsg-window-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027163655.1403341-1-wintera@linux.ibm.com>
References: <20261027163655.1403341-1-wintera@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Test the transport, claim the credit with atomic_xchg() after the last
> error exit and hand it back if the transmit fails, and send once the lock
> is dropped.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
