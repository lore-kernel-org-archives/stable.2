Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6330566F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807889; cv=none; b=cryxJrpqdts1pv6bRVHdl0UxNzEhd89C/zMGSxAifo936l6mpa2oy7uhB8fIcRwpgMiwg27Y1kiKPw/kH+lpV5JIyk7OMFdnIX6KTzRKN8SF+QkCQkIq4vsdvghe1bfeSKYGlTZ90Mh7TCkDKEnvqKGsN80YJnkS3xMK57oLQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807889; c=relaxed/simple;
	bh=FTERFTHEdmpzjO4yo5HzyIIhROZxTam0uTeNiMi5tsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2DTal9ukxMHQpLMEHyoxJwzPFasMN0cBG+aEMZbgRAqra+3oglUsvihXNAY/9bkSxTmccVI//BFeFneSwaIuc8nawv38DQAnqwNrWL1w7ZA3zWKq8coPY1fUQRXBYWZ7Q20YRjBl0y0g/8+joanAQ7BUUxF4tQosNkXSFm4A98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt5sfC6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt5sfC6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D71F00A3D;
	Thu, 27 Aug 2026 05:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787807888;
	bh=gFktFl2mkOKINux/ZI4Yan4kd705nThHZzQuo2AMbn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lt5sfC6hHF4Njai4K+Xm7TFsBaIWqF4v9SFgnDrUUkTEcvn5mpvpaqCu6tCWkjUZi
	 MUAFqoLqZ1YiSFI7ZdX9gFAm4ZKVdPXDVBDCnr+OIMNu0E3x94CQuisTb1VdCtCiX+
	 qevUY++8Ii90H3WWrEdYH97GyLr+5AroF4Ch2sl+jmPoMji9tqjmy2TTps6BghMQaL
	 cte49cM/h3bGwNBXKpwBO3awn86a/uW4vXwK5meX2Fz/+/GpSNIIzFyxCSL79iaD1R
	 Flo7do3u7fqa9ERtN+JFqEexQoxVbgggkoopYy6GwHaUZNBs5zUpkTeAAv8k4tEE7k
	 +2kCzFlzYNo6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Date: Thu, 27 Aug 2026 01:17:58 -0400
Message-ID: <20260827050834.10008.stable-daily@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825034113.642528-1-jia.yao@intel.com>
References: <20260825034113.642528-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> (cherry picked from commit 6af05de0dc19bbf3aaeec2020fe48b37c834b811)

This series needs a v2 before we can take it...

The cherry-pick lines name drm-xe-next commits that are not in Linus' tree.

The series also does not build on 6.12, and 2/3 is not safe there:

 - XE_BO_FLAG_PINNED_NORESTORE does not exist on 6.12; it arrives with
   045448da87bf ("drm/xe: Add XE_BO_FLAG_PINNED_NORESTORE") in v6.16.
 - xe_guc_using_main_gamctrl_queues() does not exist either. It comes from
   94edd6518613 ("drm/xe/xe3p_lpm: Configure MAIN_GAMCTRL_QUEUE_SELECT").
   You dropped it from guc_um_init_params(), but the second call site in
   xe_guc_ads_init() is still there.
 - On 6.12, xe_guc_ads_init() runs before xe_vram_probe(), so 2/3's
   XE_BO_FLAG_VRAM_IF_DGFX reaches add_vram() with no VRAM manager yet: a
   NULL deref at probe on Battlemage. 2/3 also removes the
   xe_managed_bo_reinit_in_vram() call, which is 6.12's only working VRAM
   path.

-- 
Thanks,
Sasha
