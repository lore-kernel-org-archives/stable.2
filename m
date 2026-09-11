Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E143DED4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125675; cv=none; b=OtL0xoWk4vOBdw4okUAHub8uH12eVA8PDxAnhq7LnrCptENGbLUiIf+p6W529fj5ECTQAE1WwNJqnqUub72ITHxkfErMwGgpXwAdgFAp5luimcZjNIZD9mlNJW/YrpKWa431fosD6ERjgO1qRt6HkRnTm2bS9kSj4e7EeGTpBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125675; c=relaxed/simple;
	bh=mE6htTu5I8tl0fEiR4rNVNYBHDSIKzgjCHfDEFH9tes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twOAxsv42juHw/7hPdDha0PPQWxKqLJA6Q5p2AN1XJJ3PXfxVaCQAa6wmjD0XR7QpfWy08svtQmNLHq7U9YyFXrJValXPuFkqiVsA+aCG8XvBkra2pL8k32e9ZMuDToQi043FJP4se1qL2lXdonUJxJ10NvSFCsaGq2a2zRmhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB4q1lzA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB4q1lzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6340B1F00893;
	Fri, 11 Sep 2026 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125669;
	bh=JBD28xLBmxrMOy5c+T+R5ZjoXptdTEpAOXKaYt/NNPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XB4q1lzAueSULniAqvZFLZ8U8H1uQx2D4jW32OMPAo7mzOcEtKk2BXfw/p4WqSIQH
	 gRHgfngdfjmd2gfkVnHdMv4lTaVH/Dcgy28UkuUCwkCzozyTHfCxrEg0Z892M/9MpM
	 zQ3CvK/+KWo7y4IZCSCoD87RtyUouJxKN+yJohaEaU0CAc/qEb8ojNsTpruWnMfpBU
	 jXNWUOvVr7YY3E2hVnWYTpNWQhV0fUufOqN8EgaoGtDrlm5az/00C85S+xpCHDtQRn
	 xoWgfgI5qQP1JJ4bach1j0EBxAb8L5x5IrrBaI4/1tF/cYV6h+V9fsMYyqBQ70SwWO
	 JMOsK9Xf3ZWxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	alexander.deucher@amd.com,
	mario.limonciello@amd.com,
	superm1@kernel.org,
	Akhmed Zhitaev <zhitaevakh@gmail.com>
Subject: Re: [PATCH 6.18.y 0/2] drm/amd/display: Fix full-range custom brightness handling
Date: Fri, 11 Sep 2026 07:20:25 -0400
Message-ID: <daily-reply-0004-re-amd-display-brightness-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909152635.83860-1-zhitaevakh@gmail.com>
References: <20260909152635.83860-1-zhitaevakh@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series backports the two changes required to make full-range
> backlight handling safe on 6.18.y.
>
> Patch 1 restores the userspace [0..max] brightness range.
> Patch 2 fixes custom brightness curve normalization for that range.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
