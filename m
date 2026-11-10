Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344403;
	b=o5n/GiTM+DmmTIh/0CjEv2mO3BYkXn65Z64W3pPnVddEW3/xCXTe9CwdV3yHgCikFv4D
	 PG6gDDibC75D2Sh6uai4s5JAFa/okZZz2lu0PIVjARjsYqWcyA8ashSGzZCjOeqXqw16m
	 mMYrBRjqzl4PUEjXc6Tr/wOzYyYXPFS1dLzQsarozoNJ2owCEFuYOC0rhU+o0p5Rei20+
	 2g9f4qQAtHhuhKtUzRTqyP6RTpxUabtJEHYizc1A3DJM7Fu0EctyPXoD31MF8QXGs9dK5
	 aPWNdMA2dQ5opCOcDM2pRYUu46tli6xQi/s36tTiclO7ItVvLck9lUc5qsP1W/nj/iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344403;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qDzaHN6nvGgPKKOR4fvwwxIm218qZyw8XGfd/opW9xw=;
	b=oAaQQyUKGRyWT7LYHFioI2WUWHnmHl9ekdSSAIxqx5mG0kVuRDx7ieyW/dSDDKtp4Uvh
	 BhPFmUfs742XpY+9QtF6EoavNtw7G8VJZ6JAL2HVzFGGKeZsxPKFlD4meR12fh1NZmkp9
	 PhNmPdV4GMFrV0OZNKl/I5tAFqGJS5+OYSM4sB4dyZzCnxLiVPeQwdxlZZ/wEvrJjJvXj
	 tv2311H7MQMTMrHv2BY4xU/DT4v4C0HRmMCCxTbs6/7wCVHyL/r7aQzTHXIyC65ONOH9o
	 rsqf6iczQ+6APm8kgFl64UIzXh4Eb187bNDqBiGKmQb3wfg5juS5hG4rm8Ut8lz4YDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nz4Uc26p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4077606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nz4Uc26p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA57A1F008A2;
	Tue, 10 Nov 2026 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344402;
	bh=qDzaHN6nvGgPKKOR4fvwwxIm218qZyw8XGfd/opW9xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nz4Uc26pEXWFNhs48IuP3p76efv3oWa+eaNJ8GSB8dlG2KBXayWZ7taeb3OBpSU80
	 xzR7mkLGdqzfYMWWtJGj22BOazX7ENVf1GDxxwBiv4ZZSB11lDd2wX97ORd1c/NnJ3
	 Fjp/rVh5uilBhlbGRkZAwST4PwFJtrvyI6z/HFFscYDHJodfX3Lo7Q+/uLzL7/JJnj
	 74IJkFi8/HJp7a8Z7Cn49iOJa9nZREYqTsbrnBgDkC1ltI2s7oAuZIXVNy+E2CY6Yp
	 8GwldURTyPu726K/t6772lFrI/IqtxkHrfeBrCPU6OnXEA2TSu2ZtLdEd5/Am1lfI/
	 VBQOsMRzchm1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 5.15.y 1/3] media: uvcvideo: Disable autosuspend for Insta360 Link
Date: Tue, 10 Nov 2026 15:59:26 -0500
Message-ID: <2026-11-10-1-daily-reply-0030-uvc-5.15-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109165447.1179922-1-ribalda@chromium.org>
References: <20261109165447.1179922-1-ribalda@chromium.org>
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

> media: uvcvideo: Disable autosuspend for Insta360 Link

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
