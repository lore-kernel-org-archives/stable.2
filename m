Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19158332EBC
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414208; cv=none; b=KYNBKcMpCC/BmjpVlZ8LnItKXTbRR7An3hwuhNnia2crUi5SCcOXAqfruSaM123kkyZkmQEMgsE0mQLqSONk1GPfHoZg5xz+4Hae2J4SgG2bZyXm/s5BaVpBSqp2blSQRLnU7INgi44P4PPF9v9uQO8Bfe1M1NJINwVj3TuTToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414208; c=relaxed/simple;
	bh=X4byraDO7yHmbtmSmDsc+urKVfZ/c235kuLFphUiZgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyZt2rjMmqiprn1Gh0rR89ixgDfHPvh4DXrlRsa5pPXFknlXJaEDpJCHsfutkBPSCDvXIVgIQgtC3/ea3ZwMoXUVjEnV2iZzk4Bto0MD2+c6vnn6G7SYzXpxWsiyJusfi/AXxdjXh2R5SHTZwQWfJsgI1+DPjDL2I5O53pqGu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYyAMsHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYyAMsHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005BA1F000E9;
	Tue,  7 Jul 2026 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414206;
	bh=oHu4L+U2DMMQuBEWzdV5HgX/q2fy+pNOqSxXuYOIULM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nYyAMsHdDdg8gcTseG3oUDYb4MEZqwL+uE+I5yQiitbeQlDyiTDtga7NH6rt+9Y2i
	 lxGFw69xFAa2QzoRE8NyQNuvtfx42RkCTmq+crqHy8nR0dU1wmO2QH5NKnNqECJJwO
	 2dC3OcIbtGCYJzgamXWQ2I4f97QCMmj2Wl6aQsq2hcKsR7AHwjQNUlr6bSdGBuwczA
	 J5vx55T2OUyLA91LA3WJCfml6vFxtB2H2ag2O7eMOknGz3Jad00j0663i3q4fkrS+T
	 XgZm9DDhYlh8ntdsoNmu2xordWH1fM+00GQWEIlCCiEXt1uchqUzhicp1r0jS5QpVZ
	 UmV3i+uPXUlPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 6.12.y 0/3] Rockchip GPIO driver resource leaks
Date: Tue,  7 Jul 2026 04:50:01 -0400
Message-ID: <20260707044731.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706161713.2676365-1-heiko@sntech.de>
References: <20260706161713.2676365-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Patches 2+3 resolve resource leaks, while patch 1 is structural
> change without functionality change, that is needed for 2+3 to
> apply cleanly.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
