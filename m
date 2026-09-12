Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DE360EE9
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226788; cv=none; b=f8YVIQEkPG/n5ibzLOf/upnHwuChykbxX5/VgBcRSlN+z4NzNj8pw2CKH93Lu3XK1RKCRADo9/ZQgdmnYrJqXN2L93Vt/3bTHxOxnXlnalXPePiR8tX8yIToMAy0874+VGPcgH6lYnuAwUuA7unUOPJzCdPvEXSFrqfySdQAK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226788; c=relaxed/simple;
	bh=dz8vNhZKfg1vKtAWQxk7d3lvhG2iMrSknjfUWwBzDlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvnP1/QQhCsxrRjUYeKNYXY/lctFhEs2JVj+Hg0JtxF97A6Z2iVInjGraIZDmHBBumeKW7BQ6OhHgppxRZI3FmnUyH6Od8KvlvDMQJFkBzlr0EOPnJXccYgOm3+puIj799gey+GJOkucKdPVvrlum78PsJGgIaomxq4+gpHbiVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5RAXBJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5RAXBJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EC91F00899;
	Sat, 12 Sep 2026 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226787;
	bh=IhGTSMu+JOr0RpTo67v6gqurRTSm5mTAu2FBXxNMPbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W5RAXBJb6zkZIcDAPcUxCV+sNcg5Wp36yJ95jOelSNmU6VCctjtIQese94wUqjolx
	 eo/NK/1MJBRauYFXWX9OBpYUCE+ZVW36/BsLb1C1ScOBeZZUUrh+xcTo8+0JlvDleL
	 cpDC1mig1x/BToV1wRohFMBDuxAsNv2t3U6zuWXq/z1qoybrdQ6YdFy9cBARvxdDim
	 0BKSERtFV27DFFNHeU0Uq7Di252QqYgq8nizURXfVTdIRW2OTYYyhdC/u1TRDsPZad
	 cyh8tYb8DNn1yG6o8NlNSFXs+Nn9+cAtuP8BsIvMKdtnqVLkBhiIulQ874kZ1zyid7
	 0tVAGEIEEdoyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Li <Roman.Li@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH 6.18.y] drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
Date: Sat, 12 Sep 2026 11:26:15 -0400
Message-ID: <daily-reply-0005-re-amd-display-dcn35-36-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911174247.2973758-1-superm1@kernel.org>
References: <20260911174247.2973758-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [WHY]
> Splash screen corruption on some 8K monitors.
>
> [HOW]
> Set GPUVM min page size to 4K for DCN35/36 to use the correct DML2
> calculations, avoiding the corruption path observed during splash.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
