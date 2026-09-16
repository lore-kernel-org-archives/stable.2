Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2030D40E;
	Wed, 16 Sep 2026 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523560; cv=none; b=IAg3nUoogUCZFk75hhwCatEMF3bhLbK2cNf9f23XqyhmUEZqZqOUCkbwV73eWuvZb4hsFouB4NKtw9EtMfC+1fgjjucAjQ5NgMxbe92ko7dAEIlU639hxcYBMqRYwCm4lk+uyXzl2Bk0ivZLda092tRtlhlSQrV8WCR3L8ULwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523560; c=relaxed/simple;
	bh=icnSWCZ5NcklNqLMEumZNzR/kuzRM/OTZsWRwA1yXo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cb/mZgJckYhQH79J98WaPHDlXPe+AunjA4CFQxvWWz+ZTn2Y4WGD8cVs/KGMC5d+OozRbeYP+2GN+m9cyldVK71NaSSxboLAujZ7+vcg2e5mFv55swkJFHqRbpC1tzPyVcdqY/dqRH+JE5mI3TotMtF/rbrmRDKdxGpcpstdEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUNXV5tg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUNXV5tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702F51F00893;
	Wed, 16 Sep 2026 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789523544;
	bh=RoggnMyXqTX8Q0RxNcj5GA4kKvWXwLxnK7Rigc2pLq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUNXV5tg7qC/dMPkp1LZAxRxIRo0hV45cXwnXFrbS+scNQxCIS1f/RsGFHFBcbZZM
	 fdkcXpnpNPqr7VX64Jh9VLMETSHkRI3ySTf5h0usU0z0s3PhNEmbGlpStsQxNFPNtY
	 Cm6CbsGJuAsg9aLig4wA43+ln4+oE641hLMF5ey9zHlF8sCxHxaEIpK7UYCaEVf1ZH
	 ji6R1etXVGkIDKOSqCH9hPlyq5zXKFQqr15UQq2Srm2oPd3t1bAXCA/7RkvftJpj4x
	 jlFrMnQ051uwyzEKA9xhrcjjK7sp5uWV/ns9MD/Fieff6dsx01+1/W2EWBuox743T8
	 diax7edr1svGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Roman Demidov <roman.demidov.nn@gmail.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Wayne Lin <Wayne.Lin@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
	Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	George Zhang <george.zhang@amd.com>
Subject: Re: [PATCH 5.10/5.15/6.1 v2] drm/amd/display: set new_stream to NULL after release
Date: Tue, 15 Sep 2026 21:52:07 -0400
Message-ID: <daily-reply-20260915-0002-re-amd-display-new-stream-null@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915074611.9133-1-roman.demidov.nn@gmail.com>
References: <20260915074611.9133-1-roman.demidov.nn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Backport fix for CVE-2026-68236
> v2: Include version 5.15 in the patch, as Sasha Levin <sashal@kernel.org>
> suggested.

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
