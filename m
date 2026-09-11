Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782B427A03
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125682; cv=none; b=tFUr6TjYEYEbcFT04GP6zEK1w/rvECB16ArWbyU+d4VST+DsEgxFPTG2qPAjztJ3kfsKeZvPR0QpRbfbRqtTcrmAcGwba/ej1Qdl4M7KwToJ25OmOQjZUi++QHwwsMwCqFOxmq7Y9/CnPwlT9/JQXH2CYkiwyg4Sd5W8ytfwCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125682; c=relaxed/simple;
	bh=ZktiDc+HEv8yjSi5wlOtGTNLufuOw8P3caI5wpHsvAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFSMUCGz2+J+orOGpXF25pZs35P3AFNnBC2oiJOwo/D90nCGIWjYAeYyjfquXaA/z2afk8NVv/fNbuorKGYH0QW4ss3W3IHTacorLWO3UY/+zoWv1avEJkaX6YboaYsdgrYDVXFw+WccMRodpS4AL8KbUjgJbmUTkPGgyppNu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7OPCytD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7OPCytD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A981F00893;
	Fri, 11 Sep 2026 11:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125676;
	bh=mjbf+rfMcPHf0SqBCo4wiASE6e669JAJ0ORlE65R/3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e7OPCytDsboBrh+8zMJPwQMlS1l3rAl1bqWNdDyUXuC+QoNBq9vkKkg+P6fOfHJYM
	 uCBFoGY71IDYxtkrrkaqXBH3dvjYpqJwMcPHlKc2+Rbr3J6yxMv3sP6ny5YDPMsIKJ
	 aahhq2s+fqH5B5I7AUdajqNwg1He8PJT9zb/0SpUZdKSLVk9Cd72oLWOUYRmILx9AY
	 ketgTkZO8Um+IYzV2sTCztD8zlj0XtRtLNqP5lPLj2h7JDGZaAsHz4UngeQaVxKCCW
	 sJ+zfPYNtUbx/DBKxubTwTe+duhTnOETrd92j7ZR7npdzxHcPCVFokNkzoaLT4XF4i
	 YbaqA0mZQCriw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 7.2.y] batman-adv: bla: avoid CRC corruption due to parallel claim add
Date: Fri, 11 Sep 2026 07:20:34 -0400
Message-ID: <daily-reply-0015-re-batman-adv-bla-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909182302.917636-1-sven@narfation.org>
References: <20260909182302.917636-1-sven@narfation.org>
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

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
