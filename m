Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE332B137
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941259; cv=none; b=MOOSKr080BoOsXZNhZpcGij3Uu4vjNuoafFuOi1sfDEpk7JuFj3XAb3jGxNKJwkS0VsJRZd3JIo5OxMb7XWN9cG00PBipueFRpKDgaJCF/y+lznk4tmtBdK7RMLVpNKinZkTMrN4pdsLPPRcUqVm2W1JSEak8BCDPNnAA+1ZaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941259; c=relaxed/simple;
	bh=zKEc9Wc9hn1FCrefJb4LZUdbGP7IKxnIbWbijUjiruQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTL6xAKu3Uzxy4o9lp+AiyvJYJN2aRLYisall2+lzdEMEbD5GjUiXauufBUJf3HpDVBU0fl9mbu8VeYPMPrLBHZ1hIoSNUrHPOVCYWsUsdtTHn4Ai78vslHZc9fQtc8noaAR6T/+tDtjlWm7S8YG0qdGmncIQAMV2ZGS4i2CRa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKGMix7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKGMix7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E711F0089A;
	Wed, 14 Oct 2026 01:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941258;
	bh=f+ERSgv1gV19OdHzb5Vdrcrqt6O7rdSmI5XslXyCmGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKGMix7UVHJBuSwupSmVJDwBgBlRHk7DQwq0XsNnHB/2/Wxqct/UgVDDT3kPNr5SJ
	 CwQ1FAMmQTyQnDEwEcKwPPolJoHfNjRqNIuWurBdx/i7N68avF81P5FDTNxOr+e8m9
	 7O03qgXMDi89KwMDj/Cq2IT+pKl5PJTKtu9d/SCmPmCxLTz8JGcNNuCKlnYR/VfraE
	 bzDFnYuRVH/zUROO4KuWGVveEJZ+eO7FaPIo8gVQd5F2L91SabEqE2cAf13SUGapUt
	 oDPHdurJhROjxaGmdI9RrTFqAbwl00/dsxufD2Jl8o6GhTSmUJVgTy8/3XeTucFS2x
	 u3Z4wS7SDwgdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Adrian Betschart <adrian.betschart@cinemaone.ch>
Subject: Re: [PATCH 6.12.y] drm/amd/display: Don't replace a sink mode that shares the native totals
Date: Tue, 13 Oct 2026 21:27:08 -0400
Message-ID: <2026-10-13-1-daily-reply-0018-amdgpu-sink-mode-native-totals-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012160521.8405-1-adrian.betschart@cinemaone.ch>
References: <20261012160521.8405-1-adrian.betschart@cinemaone.ch>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
