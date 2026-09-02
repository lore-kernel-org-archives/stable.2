Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65694428463
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387269; cv=none; b=dWRH+U+KKRkco+nBEF9o24hx53VXn6eac70nhQ+uHeLWVhR0ROLPvHKkwp/7XlQvgE2LQlPd04zjGgsilR5YVxVxNKCDU4qU/bZ1WsXCJC7TXhMmfhIbXvukk6rURkbnBEzM11FqR6807exEkDsC79glP1sE0DlDAYl/Df802Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387269; c=relaxed/simple;
	bh=CXGzpUIxcmvQXH1k5OgVgz6HfovhIr/abcXS19mcn3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoObdQSxBEHLYrkzdG5EWYEX0O49qH4DHpaCSUzYEFBGWh7JUP4uQ1Jyl+xk2he5EXj5KeOlnW1VHNwdWGny7uLuvaCrIUNM4F1ClAZVsieQy2xEraWxO3Mn458xfLc+G49qZf+Mk4BK7UKO4pPIAY/V/qyO/qERv/9yCM3zk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVmz8qdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVmz8qdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53921F00A3E;
	Wed,  2 Sep 2026 22:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387264;
	bh=LytUEMbNrozrHwVFLHv8pXINt2Kt+sy84mdvwXFQli4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVmz8qdmqp26r3Y4MAzMAsjqAZvmQZBh9m79DRnypZ4MZjnzwfnUHpjtPGDGr1L4V
	 X0V6jJadFCTWhK6AP97zrRb3FGZPQ92MZZVLZGJFz/99QFrcfQv+IK8ZgARSrEUpHh
	 QM5W99EGTkDQAxlXKABdR+x23lqa1yqUwUxcs0w/wdaThft3AajeX1YP/WAq9hPPSa
	 AXiMVzC/sBusETpTi2SKOscSH3Teb7zvr4gwIa/QIIs4YMvkzY/b/vocUQqFzMzha4
	 F5+3Ck8e6euBbsZv3+JushS4nMHMCC/BH8jMkxY91fh538sQMz+JYutkeI1vW04saO
	 nYQMi26KPC+mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.2.y 1/2] drm/amd/display: hide Apple Studio Display secondary tile
Date: Wed,  2 Sep 2026 18:14:03 -0400
Message-ID: <20260902-daily-reply-0004-apple-studio-display-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901150222.2671040-1-mario.limonciello@amd.com>
References: <20260901150222.2671040-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The Apple Studio Display exposes a 2x1 tiled panel over two SST DP
> links. The primary tile advertises the full 5120x2880 mode (with DSC on
> the bandwidth-sufficient link) while the secondary carries a per-tile
> 2560x2880 timing on a link without sufficient bandwidth.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
