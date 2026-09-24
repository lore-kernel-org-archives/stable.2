Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE2414A38
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270016; cv=none; b=OBU6cK3x1vQwI8EuKD7PPUWp6mHVWF6kY3pxcpQdkYkLt3Gp8tJ4QLsVXSkyNLxWv0fvoc/AJ0PtC2Dc8cmVUdQ2pO/942oe9KtpeJKmcLA5zdGtXtQaKwgsYOCfj4KEl2xUtQVSlfpDdU1wwE6sUJEJeAlijNZxN/keLD+RdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270016; c=relaxed/simple;
	bh=a9ya3PG1xlK3hK1P97iiQlC3F5ph8BRoEcQ2zT8T/OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUDwAaBQfwLiWis2ehDHgcsLBL/d0wmBS8zCEJpIWt+Q//gwu36X4N+fyktamFmiLeDhdjLtxvbH+4G/srCtyi/zvKz9x5zTfsHJxcdiZjiGTFEPVBdOUa6rMMrs1BvsabvSBP2oVhsxwUAY/j4If4v22FSOiMfUkbTh2KrT6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/uKSYOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/uKSYOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8535D1F00893;
	Thu, 24 Sep 2026 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270015;
	bh=FkRgW+yQG4wJzMzoiT63+fq1baAPsRs00clmwVeBjCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/uKSYOfoNxmzdZx7XMHwQ5erSqQ8ppSq74eyL2XEmrw2XAsyJMlILFJ64X6HJvzU
	 f7XKZvA88iNUZsFM9Fpe0cw4T4qEt5Qrxnk5If4QAINJP9p91P4dYkS/XRQPy778Fz
	 EgYQXbqPuau33311fr+bwdjoj+bFDGmP7X51H2ri2PTw/brbU3pVrZTDUutX1005mA
	 v5zb4QupVhsNcW/FMSuRPkcYOqD/bJHhQZCFoEF5D6HSfJqWyOH43vIYksBnfjEDNL
	 EBS02CjAjeBx+Q4J/4sfuSY1eoU6TkIX6sCtiW4XZJ0a/701dYmTaJVRAVLeX7GpLS
	 IVUzDg8GnJFig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Leo Li <sunpeng.li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 7.2.y] drm/amd/display: Atomize IRQ register read/modify/write ops
Date: Thu, 24 Sep 2026 13:13:21 -0400
Message-ID: <2026-09-24-daily-reply-0002-re-amdgpu-dm-atomize-irq-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923164330.3658735-1-mario.limonciello@amd.com>
References: <2026092220-morale-drizzle-4aa3@gregkh> <20260923164330.3658735-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fixes: c87e6635d2db ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")

Queued for 7.2 and 6.18, thanks.

-- 
Thanks,
Sasha
