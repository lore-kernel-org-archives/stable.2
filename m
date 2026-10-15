Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96403582BAC;
	Thu, 15 Oct 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093002; cv=none; b=ahMyDOSqrr39PZmL1LCOVwmHanMoz2Hagp1ISduWHi2zrzDR0M6jhYE9Qc5OhIAv9AMrvMvARzOSnTq33yiq+qSGahDIcrc9cJv+oIZM//1WhGpLTsC/YOVbSg8k2iincW9R1CqHU5j0SqRx32cktMokso0K8bU8LhYr8yNBESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093002; c=relaxed/simple;
	bh=Sf64QDR25MuRwNXHKkGXGVCS65wKOGmyzT8qX2MBr/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbJJUTTOdTPv7YSnpJ0nvTClwegtGG9Sq9Pfkr2Sa1ws/zoYMAMVkjQ+KGiD7G5qcyg6FWT8iHVuV9TcTn/Ogk2dgW3som0pFoAurRqp0oSw1mrMiZuO3IPSYtHRe0hY3LwssAIszQWoIFI4QVeaXonhuLyLhXVAi92sEpV18c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERdGRhOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERdGRhOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5142D1F000C7;
	Thu, 15 Oct 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093001;
	bh=b/kFE11n+SzYHUgEw6T3G/BaEKprI4ylAtgCAKURTUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERdGRhOFsNVkGswFDe/vGVJSnGpeG27P3MRL8Dfm85Tu6P+NXu8wa465hFKkLUNKT
	 K2jRg0cMmnc/nHeCzgP1KAI4/aIRQLRqvMe2LU363F4JbxJ8gpxisl3gOEt9DhA5nI
	 x55XErz+pskAEXUmcCedBgbA+rjxy5Y5NxmpW7Y+EFIuemAracEPZ800Q5efupeUBy
	 oz3Hmq6ki6sT4VA5HSoUV4NIp3HDBKRQ3KKuJKXcE/umC0eBIA+ScStTQE86wXC00R
	 yZvYcFIAaF8EbgH9a87vsOHAQFCk6d4J39SL7pTWSc4q60AALmzsAy+YjMQhAO9acz
	 TkXMMt57IBjWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	broonie@kernel.org,
	haoxiang_li2024@163.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
Date: Thu, 15 Oct 2026 15:35:59 -0400
Message-ID: <2026-10-15-1-daily-reply-0016-asoc-hdac-hda-hlink-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014193647.25131-1-artem@trailofbits.com>
References: <20261014193647.25131-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> hdac_hda_dev_probe() gets the HDA link with snd_hdac_ext_bus_link_get()
> before registering the ASoC component. If component registration fails,
> the function returns without dropping the link reference.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
