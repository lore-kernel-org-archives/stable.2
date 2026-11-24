Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479124;
	b=ulsX24yvxoHcQ6E8kNlcEvVbrErM7pkp468Ayov81xuAEl9hHwQpV4GhLE53sT0N1jmh
	 uILq2XYYkOp1jI8NRsKPUU0vQZY9ej0CXaTyVjKwFz26gFcmYJh/Yqaw1exz8RX63R+7J
	 KesylsTZ4eOjDufMP4dDn7d/W43TwrWMRl0mAG1q3wO35AuKXccUU513TKm6jXDnq1AFw
	 hGxjkDCVWCftDPEC952DLTUbmiC6AmgVQOk3PfXG8kaTAOsnHz8aE/NmTQ7H8ei7hW9ja
	 tqnPABC3WlbkJ9uJZWvu4O+1/7xWV90QbxQ9gFE3hR1XKE43JB4D0qP8g4bR7ZgketQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479124;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PxtKZiMF/xkvbjpXRHTaUOKaKaxhFHX1FEX53f9U+AY=;
	b=ziC7rCMk5zihE59HDFQ3CpY7jr82xhbiOyNOUJbhMOQpCMD7fQ9SUZzB96BPL3a4RP46
	 mhJZsqaVRsXNJVDMireh0Rn8gg/FYsU+k1VrzEfc9BIAxvWeEM5jVfE1cvzU4RWQ5P1ug
	 DE1k3DrF8f4c/ZXOd0jpq/CBfemcH8EWSuqAof9ar48ioCBKilZ1Ck8AGBxPd3TVtzkAU
	 d+V+lxwzz4rIGHIstQI4mulZbtHT2yY1XKV8A0hGknPhbLmyvYt5RF1H3ikbwOePYXFta
	 IRDtd3zHS1gXz9sQQ7Knm2+VzuAwPYV84KYStQfuT8Mhkzc4MAGUCoyWOBNxXZbsiCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngYl+EZk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B7606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngYl+EZk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C71F000E0;
	Tue, 24 Nov 2026 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479124;
	bh=PxtKZiMF/xkvbjpXRHTaUOKaKaxhFHX1FEX53f9U+AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngYl+EZkokZU495Y4ckwe3Pci/sJi59f9SU8X1m++3tUAs/w4NT7yDjs+oapptSO0
	 7CBfUNn/qXwhhhjwU7YgBFREP23rIJoNx6ANCkb/01eGg+nNVEBW8HXb6CqEKeDkTh
	 C+Nnmuej/Q6twqI6rHV957cJDP8XuOOdU+dWRUAEdShcISRIQRG0NZer9P/8i5mtfy
	 GwVVsOBDkpluFZuD5HYIlrDQVjU1G2N++zAiPOyrKoS27nayYg9DjIhqtqsiMqOLlq
	 78PnlDF3wDoGmoOT1yW+XMUiIvY2UuJfdYiOD7B4bUHJUTj9cCvXK7tN0LtMPPmXbo
	 U/iuZEKeM9QEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Feng Ning <feng@innora.ai>
Subject: Re: [PATCH 6.18.y v2] staging: media: atomisp: use array3_size() for overflow-safe allocation
Date: Mon, 23 Nov 2026 19:11:51 -0500
Message-ID: <2026-11-23-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <-vu06mkQjTtk6gilB3T4FGBceGsoELueFpq207X3D9Fdocd3mDRCyOwiwdfoXbuZ564KECaSk8qatdb7pjKo9vtBHWjp9wtC622mxWPTX_0=@innora.ai>
References: <-vu06mkQjTtk6gilB3T4FGBceGsoELueFpq207X3D9Fdocd3mDRCyOwiwdfoXbuZ564KECaSk8qatdb7pjKo9vtBHWjp9wtC622mxWPTX_0=@innora.ai>
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

> Changes in v2:
> - restore the upstream changelog verbatim
> - drop the incorrect backport note about <linux/overflow.h> includes

Queued all six for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
