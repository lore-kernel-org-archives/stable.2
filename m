Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299432;
	b=194exZU9JR1WrUsTUIvx9YXYzbGKCHq7zS+jXEyIaE+VFi9jFLoWEzQrnrF7JYdEEwsR
	 uE0Ej+V8pG7L9G3NDHDMAuQZKwOsMCPNFMvIopZ2TEAvXR6j34ynbWXXSsxHsqmVU7WIu
	 l7mP/Rfx6u5Gf0i2diWpjxhKkaI1l30JIh4DIGjpp4oIp4+wzUv0OzdOH08+IXXndX8qa
	 mPxHQsZVRYBoQ6pA2Y4ub3QOOKu18is+avRLF/QUG7D/qunO5wAkAfI4NplbyMH0VPMsU
	 jE/TmfjAvV75Hulg3K/SVNzmOuIbYPCMEtZH85KJkbrClq+bFWKq5DnCZyPOnyzfwOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J68FU8UBSExUZilHlsVxynj8C9ZqKCJXvQDIgLk8qmY=;
	b=z1VoHCBt1pBD3dWgZVRz0KV0EQZ/FwnNxmbgdx143hDCHZd6V6zNSt0og/c/K07qy4eQ
	 Dbd1vrGInP4UHMFvi91PR9ACLq5QvfBvtDlSAxp/m7+zsHZ6OgFlTLuju34J+dIwov4as
	 302ubiFz4y/pl4lsnVO+FlyqDVoiBdus3weKkIRL3oDZz9cezDB3UXZcA36pn7n8Upakh
	 64+ydyGrlwbzTsfXpfP5dxTUHQDatPIBwoEWBQ5U/PTrZkQFuRX+dz0f5bJsMxKvruM59
	 fovmtGRbs7iYu3FTEnwIzVDwmWTfYZr3eJW7w0S1pD8NVUPHg7ueLr3F29HxfCQo03Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gS8fWvJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7289606A323
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gS8fWvJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28FA1F031F0;
	Thu, 29 Oct 2026 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299431;
	bh=J68FU8UBSExUZilHlsVxynj8C9ZqKCJXvQDIgLk8qmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gS8fWvJCl9mvV3c5qKk/Y8UmR6kGDKB2Zi3yuqr4Pen2X3LYqeYG/XD8WVTFaerhE
	 bgFYjZi3DXtuVaj+irM1be9+UpwssbAR9YKpCafllQ1YaBfEMHPvLz/uObR2QPJlMM
	 9CRgRQu/Pzmoya5R2BgAULDSEJR5QgHLRGbOShPUTcMwFHk1OdFH/rRGzE/iKMHF60
	 RUXEZEXWpr7kRhMYn5It7Yf6xDEXBOhaFyXic8kUuuMpVyS8gT7L0A1icSHNELnsGk
	 rYx9BF2pAHPMsUL4QPK51Q50oIunCZYYBpNXmyucQviq9pyiIm8LZc/QAk/ulrbmxZ
	 mO1I+dPiKXEzA==
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
Subject: Re: [PATCH PATCH 6.18] mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU
Date: Thu, 29 Oct 2026 14:43:21 -0400
Message-ID: <2026-10-29-1-daily-reply-0014-mglru-dirty-throttling-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028-fix-mglru-v6-18-v1-1-5813f30470a5@gmail.com>
References: <20261028-fix-mglru-v6-18-v1-1-5813f30470a5@gmail.com>
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

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
