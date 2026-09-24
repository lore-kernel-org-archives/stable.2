Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E362FF66A;
	Thu, 24 Sep 2026 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209278; cv=none; b=Fgm5dMZgDP4p6A46YJEDDYALlGc1J2y+kAyctr5mC3VR1wImtwgHrGJt0C0IAbD2PKlJXZojyV17b0jTT2qpU6gCa+9oxQmWRST8TvwEfgDB0keGnnTPBTkPXwal5Lizir2NWexA3eO3wPV6SIGs6C22kmDe3NBtj6uPRpacrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209278; c=relaxed/simple;
	bh=Rdmf7ccVfV5oVO9jwkU08axhVLHD+vHOp+A+fpkOZVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDocs4Hw5+eRBzV2QrnGJ9TfJa1pPKtxTcgMVtR7WAi4oT1L1nvMLYi3ggmIukmmirDoGwgmlDdJdX/mhlPwM8UtCSFyUUM6kq2rhAGSArqzAUgA7GEbAwehlbevuSaqMZ/EuW9qEusEUJVZ/ARFrbiLEP65psmO2Lp63/3a+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKUjZt/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKUjZt/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6959C1F000FF;
	Thu, 24 Sep 2026 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209277;
	bh=erfixCGc04ItABZY4UtzABRXVPZWrXkdfNMP0O5k3A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKUjZt/takBa/iKxwVIrnm9O1YjZ63X9aG51go8lot8ycD6xEncH2a2JrP0RRePSu
	 IGe5jPUuTHG6ws8zlNgLT/pDY7DTUcVvNVx0+1fg0OFja9QmCEgzEynz58cA2ytw9S
	 4hTd0liSd2A7mlWA/Lp2JUX4kGtL9r+T+TATPvBrkY8ivaXLGaHhye+NArD9+xjKJC
	 aCKkHEi1HxV0VkH8fRbZPZgV2cabgaRhiKnio4M7fgP/hs8zEM+AgnpTEc79g4G3C+
	 9+gBnm7K7XkMX9KViUAJEKMJwNghIbe+M9/Riewgzauq/Httoy7X8aQ7oeplfav94X
	 8Q3LoC7u3ahoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Johan Hovold <johan+linaro@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 6.1.y] drm/msm/dp: Drop aux devices together with DP controller
Date: Wed, 23 Sep 2026 20:20:59 -0400
Message-ID: <2026-09-23-daily-reply-0010-re-drm-msm-dp-aux-depopulate-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922200127.27433-1-artem@trailofbits.com>
References: <20260922200127.27433-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: the source change is unchanged; refresh context
>   around the older DP bridge layout. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
