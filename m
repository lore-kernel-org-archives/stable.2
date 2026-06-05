Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2E4071CA
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688269; cv=none; b=VAGeTv3npKOE0SC7swOYoeB7zMY6VPWG2sGWv5EOUXe2Sf4kiMNCqrDBP8zNvyQh7nmiqY8YaC76O4uQsBElmV4D9D6xZdadUiMBsUGXHypDjQn7GpRQDHGgf3rzSPp2F/WGAoui7D7opq7PnCC+XsuIFaROD5in4GPRQFvY7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688269; c=relaxed/simple;
	bh=wthuElmi8FoHOoUPwl3o2fwIU2TUISWTvx6TErJjIkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urm0E0ISc9tStlVl3qXp0csLoNYj/XWFLEctoHpzoHiguVeyq3ghvR/gOVymypNSLvaWz+sXy/XLcVWL22qNE9dwtC9IH4UoARfltDZjf6k7HxZT807+AqXxBzhFPvt8uEscf7TFvImyHhGIf2toVwUjJonjhDPYi4JSIt7/O60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXKaNKNq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXKaNKNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E40A1F0089A;
	Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688268;
	bh=YyTItRyysV5RNuVdQ6p1fHtkmU+cEkEJueNunRm45zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXKaNKNqV9x4mwV4Xtu7AbSZ2xHW7uYbUVBEawWF3/QXqCC6OfriOtdNZgqvtnHlx
	 zFVYsDQWCkzN7heYgk6Ojq05B0o55GBOu+ubp00NXyy7HnQAa/iVKfxewsMgHuv2KW
	 jgs66PJSpQWubLLfizTMqHZ9hJaOTHAppvjIHBPFMWsYEzD4LHIHgHkbsPdGpUotRG
	 bVzEq8EbFgWVrsPijZTFd7DU4gpDqyr/cmX9lf0YeXT2p5gVciY5Yu8lEYZ419QcYg
	 m2oe7EFHEc+j5kJPK/ffnUljYyJyIaY4RI9gB9M7jljRq5qNpjhQmdM7OU3IIIYAtc
	 0A1N3Cm9iji7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	weichengc@nvidia.com
Subject: Re: [PATCH 6.1.y] xhci: tegra: Fix ghost USB device on dual-role port unplug
Date: Fri,  5 Jun 2026 15:37:22 -0400
Message-ID: <20260605-stable-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604121913.150323-1-weichengc@nvidia.com>
References: <2026060434-finlike-uncombed-dc4e@gregkh> <20260604121913.150323-1-weichengc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.1.y] xhci: tegra: Fix ghost USB device on dual-role port unplug

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha
