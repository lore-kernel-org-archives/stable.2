Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434118;
	b=Ja9bHsSvkmasv5pD6iYPdj/6siWjEyHKPHiiS9G8IkoBi4c49ErU4qk4W+vDdt/5sAD1
	 Ay5usJrCzQcmgjByXQlSJwaIvnt8vt5k9gHjSh403o4vELMNIxeyR4Zf2fpGSBAEJa7KU
	 N1q5QxB65OPmf7m1BfZy/CuGVUlxVSabrqgTo3SU0irP4YlMmFLaBOG6Bi3uCmkYt7Xnv
	 TEJu48SyJZfcjTc8EYqDJo8JxK9Rqj0l0DptoFjX4R56IphC0bujdhFdKhu56wvWy9+dM
	 kyuZNP6sIQSiTMlfLbOHa4GExC4pVqKRQkp5uTuhAZp3wqvB0r0kM+HRlEAmto5GPBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434118;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F53TAJHjv2w2/cbxTcjJlfxPkAXvyz1xgwQHmGneP9g=;
	b=BJDBsIy+wcAJyNM2JX8Ocv7Iee6FDkMrLvR7X/dCTg5bEER7BFhs9eFDWFIN2clvcPHk
	 DJW6HBIE35B5+Dx88khMsaMOxRFvqEwrAABxKnHvoSIOfFKHQq77jgrgpzDUscef43QTs
	 h/mklNTK+KX3Fyit1ItyCCHHpKFH4rIaCcG6lwM0a0C+PZh2trHWAuPxp2TN0U8Eu1CaW
	 z9rWoo5r/VdoyPMtVF9M2JeKAAy6vn+P8uOivN27Snl9M+tAUYVpXPb9Vq/G0NynrFv4u
	 DsU070FI7PZJxL5EYVvkxI7MmRCpa7AFWs09aYYGVaVbL9OT6vJV1iucpvNVvjoK+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPQi762f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD469606A8BA
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TPQi762f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8AB1F00A07;
	Wed, 11 Nov 2026 21:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434118;
	bh=F53TAJHjv2w2/cbxTcjJlfxPkAXvyz1xgwQHmGneP9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPQi762f8JAhHzGZkrVftbQ2njUoqUicQu6/CeGA+iLxsp0XS/TqV5nfw3bQcC7Zu
	 D42V5HHC9LKJSrkezuBu0eOR1A6upHCJjVVVMLGC+bO8n7UF8IR55/cQH0Q0wCTW+I
	 Do6oa0LIl3w/reVb9N+WvJJpdOJOkbceV0T18Tjf2W5XSrW7iedEAbdkEyho/i0ZzC
	 D1/+pzJI6Nek/RL9xzEg5oBBUZ3U9voqL0+CKsYMMVIo63NBaGyfsudNOa3If4EC4B
	 OwJwF8QxDJwyd/cOQ7ZPyU/29tTcPHgdCp1yHPizVFXS9F4PJvaYc6psWYh4f8Wu+A
	 hxlew6nn8Tbsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	Mark Brown <broonie@kernel.org>,
	Sercan GOKMEN via B4 Relay <devnull+gokmensercan.gmail.com@kernel.org>
Subject: Re: [PATCH 7.3.y] ASoC: cs35l56: Wait for firmware timer expiry before system suspend
Date: Wed, 11 Nov 2026 16:54:54 -0500
Message-ID: <2026-11-11-1-daily-reply-0021-e40967988dae637472c1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111-cs35l56-fw-timer-7-3-y-v1-1-43fc95730c11@gmail.com>
References: <20261111-cs35l56-fw-timer-7-3-y-v1-1-43fc95730c11@gmail.com>
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

> [PATCH 7.3.y] ASoC: cs35l56: Wait for firmware timer expiry before system suspend
Queued for 7.3, thanks.

The same bug is present on 6.18, 6.12 and 6.6, but 6cc7db9fdd06 ("ASoC:
cs35l56: Wait for firmware timer expiry before system suspend") conflicts
there. Could you or the Cirrus folks on Cc send backports for those trees?

-- 
Thanks,
Sasha
