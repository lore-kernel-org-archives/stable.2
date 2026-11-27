Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798925;
	b=QnLnXtxufSAAFATtwjomD9T7x8xrmEYMTwALAehDO8PJIHfq40V7e4rI3ksjk98v+CGK
	 FJdG0WqBwmSfh9BQVpJ9lrq7wZy6oLm6zgmtUuQ949ha5xJ23FNsjdB0IfHGc+y9W3b4g
	 iFfttNeriHOUexjq4iwntOBOWiMh5N9HTfRy65EHMFIWswSfhsTQOjwgkt+RVHCuE2PTU
	 44uuZkGyRnpAurxJrgoNNoysV6bowjI0GIQF+NWMsPqVUOXBCLkHMhGLWR4Ek+iQvh3rJ
	 1mEL5+lGzG3qBU0BmpK+6u1bIU8slNW7uwUVmZ/Xig0pNnJTVtK4IQdeMndGC6I+lWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798925;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qIRW8614WFZ32dH8ORYZs1XPb5XhyQAJ5Kw7sf5zXNY=;
	b=CWSdIdM2YqCRPBEnrXkuriJQ1sBdPPk8x6F9hx3U9Ni91eaPmE4R3TojPH5VRzWw0zrB
	 lgk0qWt5WY9QZxdJwlYD+YtGQfnhOUd3lN6R2Iqv/PEiLMF4Bf47JBzenygEi/Dr75h1s
	 S7fzYiqpTyNtvk68P3ryTYFNpTMycUefGjeEKRWZd5G/0XNxQFzLkyMi3Z8f9mjt+BAx3
	 pqzhSXtIUCQIESDCMyNbTjTd0EaGUy+eqUKCb+8G9WpqW/Hklkgq++0E05SeF3jn5MmmR
	 g5+WuxjPxzqoK5njSwHCAy5pSbUI8jXIcTXTXY2KmJh/X5otkT/4IbcRQVO1xffLqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoEp3KcC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42124606A331
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoEp3KcC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6141B1F0089C;
	Fri, 27 Nov 2026 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798924;
	bh=qIRW8614WFZ32dH8ORYZs1XPb5XhyQAJ5Kw7sf5zXNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoEp3KcC6Ibcg0jUP8yNBl2NmDHT8n5QkN0M5HBST4glYs4G+UwetBUaRGXwGg5eA
	 gq6F5Gjo7damcjbtvmupobrZOqyeEEMorVpDnVMc1aKjRwCJtKg73DEPct3xJH9qvs
	 yomITioggTGBeRddPHnDk8cvKpqq3TRPAbnhcv/SckqqmM7RLBJBIEiPv12xPzL5Nv
	 xVjlwhza1aoN2UIZzWd4Amg9I72egBoHhbxXCwXe7/rRC4OKH2BTmOBZeVHBMx/9bt
	 kUJJxv+XVVIhS0h6ZLc+4Yvy65JMvflZM+CajN/4+pUXXMQw5p3dqMfhOoc5pIRtpW
	 r9PMXVInU+pTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Subject: Re: [PATCH 6.18.y] tools/bootconfig: Close only opened braces in compact output
Date: Fri, 27 Nov 2026 12:01:07 -0500
Message-ID: <2026-11-26-1-daily-reply-0019@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <89e26475cf9f34274a05eb3d79b91efdaf088b83.1795602749.git.edumucelli@gmail.com>
References: <89e26475cf9f34274a05eb3d79b91efdaf088b83.1795602749.git.edumucelli@gmail.com>
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

> For example, a.b=v, a.b.c=w and a.z=q are printed with the brace for a
> closed before z. Reading that output back changes a.z into the root key
> z, silently changing the configuration.

Queued for 6.18, 6.12, 6.6, 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
