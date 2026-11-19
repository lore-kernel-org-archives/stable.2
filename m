Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104533;
	b=AhoezvouSgScu2MRxPtk123lXeNTzMqNqvEe08llTejhDuOBpBCmqadIFNx8kBIqiSJy
	 4oPrvwwqhLhMrFgR7sFNsyxx/ED6w8QlOToZU3dOHEUxTyzjRtE8a0yt9cCsvStNR7KAE
	 l7kDvR5bducTCkCNpBPl821yMTU8PHg1ReL4fvsX3ctWIPbZY2ADhACKpOoaZTtkAe3Wd
	 juj3GLP2AW8U6sTQ7RzelFJCs7F0fYY2ISrnkOqcV3zlAqptvGykrWbNkJ6KzrbiIT9d/
	 araLOn0eHeX0c4tjtK2JOW76ozcKnfZ2/sKi1WKN2EEXWqMu/Mh4A1UxKwgGcws/TEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iGI7cF3Rgd9trKFvpA201zuW9sW+rUBojNQVkSuXAk8=;
	b=5lFZyuMPXSbmIxK8oYbAtpowOaCKGmKn7AIMkfGH5uk0h44M3bmoVWsFImrkQtwWURn2
	 yuNiU6GFQdkZTAqURYD1/krSGl6LHwyoGHVpVO9L50nM+81WXFaFAUfVCPVsRzXFVBKL3
	 mTaQeVcKYHuQmocIpbheNQqOx2C8ePlTkM/W+DHki54hyQ0vBPI2LM8QuA87yzxLA+G5v
	 THoquRqRT36oZ7irCZFCZokw7Hqy6v40iSHx7dN74/vI1bvvAuKqpSh1Ky8X2p6q6MEcY
	 SKWjwc6f1sGIsbQgW1ollt2mvGh/8yok0zdaljdzvVMH2Sx0RioGQeWF3hcFfRwbLzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UphGAnmG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA7606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UphGAnmG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EC41F000C6;
	Thu, 19 Nov 2026 16:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104533;
	bh=iGI7cF3Rgd9trKFvpA201zuW9sW+rUBojNQVkSuXAk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UphGAnmG0B2Jp1w/XuQbGgOdUJyLgc+9xZBmNMAKA4DU8VqgjC6DDQ3uAJ/yE5PuK
	 fDEPUhwDC2i0iypZI4GkiFstday5DOLScBS7HCwFZc28+3RhWTVzGJTn7V3mito/hh
	 wdDdqdmtI+Rmdz8LvN7JR87iZvQc1cQAGDP9CeZMvKwR/Q8V100PQPpFvT9A0evkmG
	 VOFsXDxSQuoijKJX+iV8MVB7QZeCiQs1EJJ7+lgzpx7mTseGKBmFgy1q7FKi/kwVV1
	 TC94VwkeHQTD1ESw/WetOtcOjj2/J+mFCaLwx6MXz18LVSU+fcYhV1bfCtJCbtplbP
	 asOcc1Dcbemqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Zilin Guan <zilin@seu.edu.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH 5.10.y] mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()
Date: Thu, 19 Nov 2026 11:08:20 -0500
Message-ID: <2026-11-19-1-daily-reply-0018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1794979939-14045-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794979939-14045-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
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

> commit 53d1548612670aa8b5d89745116cc33d9d172863 upstream.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
