Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239616;
	b=G2twv57cbbydmYzq3XxDiFzeX+O6gHWR6JQGCR+J0GYoTJkQk7YLpNhgcjbwPlNlh65s
	 9t5dvbPvgzILAansUQHaovz8hEw9eFAQAmEtyz6JCRTSAoXo28KvcgeaWLvc8VWQtXBzO
	 JP6Sm2lDCG4Ou3B4EgIQoGXiCLdwnv0JkzLPyt7fy/BAndx+q87CssX7H9FNdjwM8UcLi
	 zoa3H5AV43+mxrR5sztGe0lfSUTWsJk+aUaAKzzuuAYJCCMSotWa+oXff+wamqR7wty6E
	 37buVZXb4BJwDsSbjSv3lA4nI28o3rGxYVP/APjVtrH47ASa31pt/aGvF12mRCnaF1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YbGDBqU4nxW38rvN5cjz46VE+ozOGhYAeWZw2r2wWtQ=;
	b=QFosviJBB6CcYnlPPHs7KtrkvVyTq7xrIX1XxClfL9cG1EL44QO3a/3MpqV3AdYYS8Je
	 8Y1UA7iMitmcz54nduTSUtsPsVLl1xmGojaDlOVFD5Qa4cTg8QbdPcqqNfAiAjxBeDSLo
	 ErzX8sNqnwYC+/sAfmSko/KLMtT5z0lOEWnZ19l9QVfWjRWEkO80x78QiYOfzqK5Cc/dJ
	 /OrwU059lbox3oA9ZsLoQ1hgjspRnCZebdQu9Avh8G0pwLP7Mn8X1j7e+dVYyedLXpoEt
	 hTPsdtycaqxGwDd6aloHSUpDr2GZQdr97/PMZ73VEu7qmJlnMlEP+f/z4vJuC+hMKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZD2W6ANq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0D606A33D;
	Mon,  9 Nov 2026 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZD2W6ANq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E61F008A4;
	Mon,  9 Nov 2026 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239616;
	bh=YbGDBqU4nxW38rvN5cjz46VE+ozOGhYAeWZw2r2wWtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZD2W6ANqH+nwDuzFgWpsFsA1zcRkNWiLxO/AHawwaWKnymA4Do/F+Yk/v4oqUYWjD
	 v+fCAIHVschbqevMzl0HOkMedPkWkRMeOpbmBfb/l18Nz9xSx/doUHrxhU/N3FLJk3
	 HUytSJv7gwmtQsUOPZjjZnZX/4XbF3JJqhZIabx3+AX2mJ7lieg0pupBpmIMIKMOha
	 CDfeZgIMepWKOrYYoVVWxyuF+jyYn7+xYKKzdQ9FaMxOq4APVpl4yfCAPDmOVjPtKz
	 4P3adLtS9aofXJYW+yUHUHfsRffabDS+NsC2T1ahdAYiX/1Yt6naGxIwEHJihk56M9
	 NMk2DZfM1UNtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Mon,  9 Nov 2026 10:52:51 -0500
Message-ID: <2026-11-09-1-daily-reply-0009-damon-psi-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109011347.92467-1-sj@kernel.org>
References: <20261109011347.92467-1-sj@kernel.org>
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

> mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
