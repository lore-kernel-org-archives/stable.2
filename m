Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FB40F722
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387271; cv=none; b=EhjFLPxq9JjNLmoTnp0+XCEVTKvYFwjg6JaEOXabXs4GlE86B/sfkqhpxxCSbCuxLB41yMr2giwu0x25dJj8Cr4J1Fjrj5KjdGpO3XcR8rhsZNgDCSIv9fhGTZQ7P6PdidiprIJd+vFdztnP7SSL2yHIV3WElmX6b76cC4zu+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387271; c=relaxed/simple;
	bh=Ax34BiUefAaL2kf058Ph+kdA6F4wfvXpXUNLJ77Ii2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/LfrvuLdJ1V1McKwmlw5kJaPCv2kbts6VSlcF02z0WwM5UPmgAztc2vTWlWNqHQrcJMKupGzDtyf2DLhPjpXYuRRdWN0xBHPfLyiTOHkYk/57i4D1S3o8lQpAzv9XrkAaBry96xeEeag7CJ2whqw7mNhSvZenKA1LM/FQrMOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyf46+HL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyf46+HL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3F01F00AC4;
	Wed,  2 Sep 2026 22:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387265;
	bh=24M07Q7281fkheYZDab4J+2R8hm+UMMjkr2mdbjA1XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fyf46+HLXrv+XyEpiLQ9tVS+4nhUwYVTJdifm52C2c8wiNn+zCeennfXpV4jjIuTJ
	 3sT3/w0TiF7JG6lfgjU+OfxHWkgvsSa3qFKzcp2ljCgdhqMj0Sdl9Unh89/ofG/8gw
	 ir5rwyy5M9WKEDyjINOGAwH0abB7p80O7dQIYmlrnfw9pq7gbblM7F0owyvl3CNsiJ
	 kEES8EzTMxuH8cy0GZVgh7hEno/Jf6WCy7i+rlPczrvJUp9mG0e/69lL8A7d3zelg6
	 rduncScRBj9Ak5caVZF+tJSZzv9TWR57zvmBSmqAPSuJjuHiVE8HDC/54EeJoZDqD0
	 WZuF9cR8u4L6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Li <Roman.Li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6.18.y 1/4] drm/amd/display: Skip PHY SSC reduction on some 8K panels
Date: Wed,  2 Sep 2026 18:14:04 -0400
Message-ID: <20260902-daily-reply-0005-8k-panels-phy-ssc-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901152219.2694884-1-mario.limonciello@amd.com>
References: <20260901152219.2694884-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Why]
> Some 8K displays cannot tolerate the reduced phy ssc value
> at high link utilization and show corruption or black screen.
>
> [How]
> Add an EDID panel-id quirk to utilize existing skip_phy_ssc_reduction flag.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
