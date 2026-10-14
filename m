Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4051A6803
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941263; cv=none; b=QC9BlNQ9UfFiP5s3xhffQd88PxGquhtBexFwNCmrsQFa786z+wbt1V41cXJctT0C7PD01gJJF3sAzGRlLjs1eVIJpFCRY5lMRipCsW02oUeYkfqw8a2Pak7HOJpWMty6FAR9I3hcExmlTbtHwn20qE/yVCZ/zum6uCO1/x1lX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941263; c=relaxed/simple;
	bh=3qzdkMsLey3IIctODTuv5S2hqMY8zcCq74nfbJyyGYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwAIEIvAcrjUCK1QqIR199bKgmqXbbNjLPJPalz5zvMI0uXzogBC+EjKlG4/Mjmm3FiY6eSs8T0ek6Ph/8buNzCfVx0/Z1PIvTLVLbAsT5+wwzUgKLZNVTo+jd8kvi5gfYrbPz2QR1UofQYWm560YYbVmJFpmB++J34k3HYypeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD17/s+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD17/s+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9594B1F000FF;
	Wed, 14 Oct 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941262;
	bh=0+Bqez/f7HNr3lX4fAiYOB0hZk4CX1dvOibK84poVqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bD17/s+YpfSwex+I7mWS5rsjlBymiZjekV3qRdHjNsVd8JYtZsop5qlcUqx55ChxJ
	 8H0aL4Tm5414bdlP5EFdulWo4i+aQhTCCldCat6kaNxHFG5awa3JPoO7X+40yVHxic
	 GhrjDTFSvRTciRz29klIFH+N96R6qvLtUWsEimGWFdUh0L4oXaH4wQXIbHU/Zl/qT8
	 ifAvYx5fTeQCh3r0V0U/Lqe0MzGYkScwoc70VYmO6DCX7tved92MGPYTmZFPRGm8Sp
	 pkFQedqX3/IzVv1NIf0Q4mF3uQJgr3RGPHX6CRjU+RSMF89T5MaqARddrUcn/y3df7
	 IBRL++XF1KHvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: Re: [PATCH 5.10.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Tue, 13 Oct 2026 21:27:12 -0400
Message-ID: <2026-10-13-1-daily-reply-0022-amdgpu-sink-mode-native-totals-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160529.8505-1-adrian.betschart@cinemaone.ch>
References: <20261012160529.8505-1-adrian.betschart@cinemaone.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Inserted modes keep the native sync positions; a real mode with its
> own active width does not. Compare those too, so only inserted modes
> are patched.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
