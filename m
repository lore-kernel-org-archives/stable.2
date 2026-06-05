Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C4416CF3
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688270; cv=none; b=sQZWYKim0GMn7YJ5HtrJE6q9xwPWSNmY7hRv4a8HvU9zhE3j+sbDTfkh27YR5muzEGLkSloBwozlBFY21l05DFdFopsiiosmtJaN/sstKbe7FW4q6Bo3d+G4GjcdC8NdaFlNWUr1pirTL4UuEvJM2D6RWotFgekoeyjtMwybbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688270; c=relaxed/simple;
	bh=IoDXSL066FRtEy7ArijmH0nqvEhjtksZvFXy6TyEyT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF7fUshUEVCDksE4UmMA0eTZ9FHHkcpxyiXrbq5nJ9JlN//KslAcqHQfHhhVikW4xemgjzVK/yG+1AX5gB4gP7vWGnBtxrPvZFCNwdCFrnICZ36tqzhNH99TlTfnUy1bvQZAuHal5fV7ZvjuASEMl8OygNDiiTh08oKMZdG+FyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng06dZP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng06dZP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5BA1F00893;
	Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688269;
	bh=VNAJWE8Y2MkeM9gkoJtSJUoxPRcdNYQ5Jx1OSEmu3NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ng06dZP2jBKpOHSPjpBjdA5uocrpYK1oUGlqQooVn4JDZuHMTSjErlsrMPMyGFhH5
	 t/vgPIHsZLdCsSAcvf1h9G2LsJZQ5TaOx4DZxwtDYbeZ3ruvzdFN4PvMQddu5MGsNk
	 wXwaPQ6YmpCm1bZ14rLjVeRcOZD3c9173IbezCfz/MAMylSuvxkJ/k7kJ1iSolm030
	 lJfV9DRzIkqpe0aazB5LywD+qhrqR6YQUEDv7TmxUvKqvD+LIK3UZx06beH9XNAmtj
	 wiMpTBGYGMs3eKBO0D9h0ZAvUrPgYmfU3zsUGimm4vInlIpvfbGEKSxvKJHxRuVLz4
	 iPX1rfZrpGWzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 5.15.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:23 -0400
Message-ID: <20260605-stable-reply-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121916.150415-1-weichengc@nvidia.com>
References: <2026060435-suitor-humiliate-81e2@gregkh> <20260604121916.150415-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 5.15.y, thanks.

-- 
Thanks,
Sasha
