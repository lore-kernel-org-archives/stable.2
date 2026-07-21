Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B92343BE
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595406; cv=none; b=t1rrbfI9/P+6PhLsKbU/W49s5ndleqZVUgKa9GIQxn3imRQSt3scbpth1dqi+bNH6pV3qjA2UsLvOE4mFH08FpdYyfY/5xNvdhCQptRU6dGBbyt+Pyf5aPGxXORbhIk4pHSWIxA6h0myNWGVzNDNGS2Z7LQHB6yTI3zhJ8kMtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595406; c=relaxed/simple;
	bh=/z0+Fz/r5hIrgvJRc5Ymbkq2CwuUMTRwkzSUJBGrea8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOMBqfnwsETarmLEtzbfUp23XuHHh+tueYGT4ekjDtQthXsGQAcF+8SeZskZbOwIg+g1bG0qaOLMKZLSGOvSmq+GuLmYX64UC+/fhvl4IOa5nTvygwm+4lYxFwxl1FwPAgym5YqA8NVyU26f2BlYTQY2sOCzbsluBH56Rr/KoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7V7xiZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7V7xiZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304611F000E9;
	Tue, 21 Jul 2026 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595405;
	bh=WiRTMjYdhm+5WqhPHslKBJvKwGPN9AXHlG1GYqgWY+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7V7xiZ4MD2bED+fxJn1qKJrzCXwOaPuyOACl8e9WbrfxCLM3GE6e+EcoNC/nYzs2
	 4MUh0lH9TjOf0GvdP1IWs5wQGVc5KN0biI2ZRnSRI0//V9tVw5jr6XBN6kBd0pgjih
	 wqnfr6nTM6Fv/Qav6LEE+AH6BiUKgq5csZIrJAygZy6Vm3aAeFDn7ixpRTGM32Zi4F
	 2NJy8gDCSpY6umRrf4nH1cs+fvcgnm+6jVg7ligRxkflohTeHNjBEcGy3FBGaJQAYX
	 9NbaPtc5byns6zSfLXe0lpT5LOi+CJyOWa2K82KxaQh2QryqmFslG3YN+fomQ8HLbS
	 ih/kOBajLNVKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.6.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 20:56:19 -0400
Message-ID: <20260720175500.0012-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720133941.538930-1-sven@narfation.org>
References: <20260720133941.538930-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The batadv_interface_tx() must therefore always check itself if enough data
> is available for the ethernet header and don't rely on min_header_len.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
