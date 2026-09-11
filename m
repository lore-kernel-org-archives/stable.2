Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248B443C21
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125687; cv=none; b=tXBbQnpb+J8js50MY9S9OfYTPUFlyKjNzURmCcZLnEzPzVtdpV2RoMI1a5cCITAZgxiurBiine46DXH62/k0ZtcB5alusZd6jqLmRM5/8KhF9puR+9MoWtmKUl4wA8PO83gx77b9aBXRiguuhLyAFS0t/CS3PyoqGGrmi1AJGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125687; c=relaxed/simple;
	bh=ZAdGXmvhv6hlbrZC8lb+ilzEgI3iDKjebEsveC0qniE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3jfS1VVw91JSegaZBPjl1FEmeN2oQA0BdrY38flQsyccjdbEdTCb9m7yW1JHeqUiSsmKst8WgqNk2TCVfJN4Mg7ZmtDQmmRa6PwVZJfIoGxkxRVISPWaFv4+Vr6tK3I9+4K+On8kyaVNqqlXpTfD9yQ3lneYcDpHe4C1+7IW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+QE7FMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+QE7FMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065981F0089F;
	Fri, 11 Sep 2026 11:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125678;
	bh=mPj0xxHveWU16fQTlJgBvDU9RqUHQpqpnrUVenz7cAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+QE7FMvaYh07x6baeJiRqCtFFjoI1DQuWoJyf4A33sSTf0BgbCaZCuewCt2MKGR6
	 SLx0H5ce3pPwpmiZPdCVp8iYkcz8PEOY6K9VsyGCjzOKyybJ6JfYFCujugy1vCU7J8
	 gAAM8KnHsIaWuMsYTIVYQtRn+VcJrDHJLoahOWaRiwZUOipV/mPhqFAQO9N2L1xeND
	 5QLH8HQV7C92hMNO8aBcdyxvDViByPxXcMe2x7iBcViF0AGjdnY6fuX/wmNdD7o0cC
	 c3a022dJyf+M5Nvv8RXlDgVnJNE110ndws4gD6ezwAlRjzre/gtX9hpuTuvALYI1Z5
	 0u+Inf90BMBvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.6.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:37 -0400
Message-ID: <daily-reply-0018-re-batman-adv-bla-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909185858.1007134-1-sven@narfation.org>
References: <20260909185858.1007134-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 08645ab95768b88e2ff85a89211994651710465b upstream.
>
> batadv_bla_add_claim() is used to add claims and modify the backbone
> of claims for CLAIM frames from remote backbones and local packets.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
