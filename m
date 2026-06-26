Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386B2D0C62
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496484; cv=none; b=iSVkPF02KETh2I38ANR+c4t1/a+eezRINrxitmvy7l5WMukK4wXZrRyX166n8PeBUDH2Iy8jMhQfb7qJTXOu0yXeZog2AuhiULEBz4Dwovs7GXpG2ExO6gpmzYEWNSce1nkzOFvpS2w3He5VR2GskLS3qi9lWF+F2DvDaBP9mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496484; c=relaxed/simple;
	bh=nLnB2Xjah1r2bogmBgPF9tW85l1QmtRoKwet5+p+QDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKHZv6B6j/+u5ycJPjIadNH/4hEBzFOCVyahrZts59zaHjU5Md3mRW1ZuUuld0GO1Vl+DYQMixCYB37FVkl16ttTf0NUFwxQkwysISFN9RFja6w81bz6ykLC2lBhHr9tIWLZHBqz/+wBDRns12MYuFcyMYFQ4zp1vsFf1HFO5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6OBWLcD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6OBWLcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810A11F000E9;
	Fri, 26 Jun 2026 17:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496483;
	bh=IuTng+WZ10GkqQ8CWvgAuIHMWXedK3vE/BHHr/26VvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6OBWLcDAQ4WDYRWaKvYUpHkG3GR9WskL1Pmou/I4oS7aXrO/S6SI1gcriNDUK+f5
	 G+MfatfeGGcvFEjM1LRpMFKIBJw2WaFbOX5Ho5uhGSBm2YBSGB/4OPlcaYN53VCdxm
	 utaWphuQGCzSBalcJ73dMv+N4YuSYEWpgKllUaQGZjASvGBg3hjAbi16/fEJLdebkZ
	 QjGnvX8PyX/hCOeZL0BbmIuvOx8JkSO02002QrGzRbRGazR+PvNZ23vFcKNjHaWUwU
	 vcp3aKOKGg8sAE+yrw/2ojlLRmSzYXBPUV0KTm7zCmKBQgVssqJOFwSmN4Bnw5PEfy
	 g/l0Q3hXAFHgA==
From: Sasha Levin <sashal@kernel.org>
To: guanwentao@uniontech.com
Cc: Sasha Levin <sashal@kernel.org>,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Fri, 26 Jun 2026 13:54:15 -0400
Message-ID: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625054005.0011.act-pedit-510@kernel.org>
References: <20260625054005.0011.act-pedit-510@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> pls add 10/9 backport (net/sched: act_pedit: fix action bind logic)

Thanks Wentao. The inline-pasted backport got mangled by mail reflow (the
@@ hunk counts no longer match the body), so it's not git-am'able, and a
plain cherry-pick of e9e42292ea76 doesn't apply on top of the queued v2
series. Could you resend it as a standalone [PATCH 5.10.y] via
git send-email?

-- 
Thanks,
Sasha
