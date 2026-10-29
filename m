Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299429;
	b=1nVKJL5eVM2w7Yfdft+J+0mcfm7Z9IyKvkD1lSihuOC0N9VB71bpcWEWz3GfA3A3PrGz
	 6jQW5KfTkxb3d6m8moq8FZkvPmGWELbuE9f3cWwWB4/WMVDLxk0WhU6MayOB6o8ty70x+
	 PWM7Ru6EWLw/x0X//Mc7lYGIiXi5EEyAnNYxNo+M+GzI2Z+vNM7KdjI7krlmBgBN/1++c
	 ZHNoimzkUDoFZIhr7D1B15aJ9dZ3S2WlG0wKmn1axthyayENxbCqhWJLdNaFIgzPOnhXd
	 Hbi1A0QV4mk/thoiEeo/Wfbt9RhQeiRtlBZ4Vg+tOeLNsjPCPt62oZsRjtUK9fkeDUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=55OI7muBs5J5lfk6ys3OgO4nit173CBzLSx+PE8oj5I=;
	b=gj1CMz1IxkRTESZVkESWDRuCikd+z8iR6YnmwA6wCf0zVlkgSFUFeS5eoE7uuLEW9EFp
	 /GrwIAVsJoZQHcqWer1cyT9mbJe7k7YZKoC3jG0Ytt35VaLROnHGJtZ6lhI2hT9grcaqT
	 8yQUSrnK6lSMZqHw4ceEG0vAEDYepu8f/dr/MS2G6XKLTxq0D7W5QKVgJWkDvQx00ynTx
	 QyIp3B912jDen2GD0ejjQhgSXey0WMc2NyF8JO0LBeyYsKPEp/M3VQ7JCSESSsm73z5Nr
	 zLser08ETfA+fq4JgxE/PZlOlfDe3UF50JOwQH9LLQ4iPeDGnRVOSGIm2kcGCyOyNcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e33fJNXE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F9606A325
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e33fJNXE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21CB1F031E5;
	Thu, 29 Oct 2026 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299429;
	bh=55OI7muBs5J5lfk6ys3OgO4nit173CBzLSx+PE8oj5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e33fJNXElKAv992dAY5bgyvtcal/Ci8fdpl6x7jHNlOXKRMET+QWfLZExtgeaENBr
	 izmCE9mSsxazzg5IgozQFEfYdj7vykZDKmFoeaZ/vcO7dgi2GNizNY3uQkbfWlyNKN
	 r0ZSoc8Rm0atdIZKtpaz9dkRSEgKYMiuDETOhfhUXMk4Xj1QWzPY44+gm+xsuQlWSU
	 oxDsP0MCVVKTK8sCwAerH8iDC0jmOdk95lkx0+fgvbf3Ax1eerTDBXQ3OwhJhxO/HV
	 J6zpHnhfnmkKOevoJKusXg7JbJADRJBNcH2QRiJSdkIFnFL1KCIiaYj3wkFvRDnzfA
	 UCgOnPNPjFMnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@kernel.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leno Hou <lenohou@gmail.com>,
	Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Subject: Re: [PATCH Resend 6.12] mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU
Date: Thu, 29 Oct 2026 14:43:20 -0400
Message-ID: <2026-10-29-1-daily-reply-0013-mglru-dirty-throttling-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028-fix-mglru-v6-12-v1-1-e44f4f97ca67@gmail.com>
References: <20261028-fix-mglru-v6-12-v1-1-e44f4f97ca67@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hence, for cgroup v1, let's throttle reclaim after waking up the flusher,
> which is similar to commit 81a70c21d917 ("mm/cgroup/reclaim: fix dirty
> pages throttling on cgroup v1"), to avoid unnecessary OOM.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
