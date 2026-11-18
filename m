Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961209;
	b=LrLpiNYujWby72mtJVThgz8uNC2Y1EFTu3lCZ9Z1GuH21tsz2KtGhbPX4/A4NQQIRwTj
	 AtKGczNwnAIvxyTyLRCl8A9Y4BJ/Z6PucVbe8LnAF6mRLd8tAM4EHVxl3y06wI5ZIumdn
	 nJTFYQGmf+Kt4iqN/H5yTHyNzuue5LLxle6oSCi29JEy1S5vzuqStQKUivWc8Qk0m+KO1
	 3dlsfWC6XQDOsRVuwcGPUiAoP4nrdUG5CJG5rAf1BR59w2UGQtNFCfgcb0hYs+GbW8jgq
	 DFJLyTh6Da1XRDIw547LRBisNz2f2kmegepY8PpJ538dgSFFXJK1SeYp2Em36iOd+/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961209;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4bbODQ8lbn47OYKS3LDBYU7IVB/7EA0DDppuHioC3F8=;
	b=vAGP+p6A1oaeDXIrenhhuqBDGrSdYb8RWRQjqZOocd9MwJ2gm/IugaF1fsFnnSfWTBXa
	 FIsTi4jYyYPHwDVq1qATxPa2CeKngDZ0KzBlzqNF7yZ/Co+deK7MvKbLgWIYnILm2j2u+
	 tlcjbqBX3amsuJ6J+A8MZtn6Nr0t7dV5Gm7y2iLd8oP6UU36NFF2qMA6LqL502+OBgaLa
	 EX64qwTXRwq8M9GrcADSFDXx23i7QkuPgvOIyzeo+7/2pcHAwJbZMS/mPjh5dxF5GdkKJ
	 abqMruQoT730vDy2Y/slFiQtfVhXHUv/aQlycoL+j0zA/5o4i5LON7EzDRSjkjwgoRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YKcJJlQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93113606A889;
	Wed, 18 Nov 2026 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YKcJJlQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF6E1F000CC;
	Wed, 18 Nov 2026 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961209;
	bh=4bbODQ8lbn47OYKS3LDBYU7IVB/7EA0DDppuHioC3F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YKcJJlQ/MSyJyNrE9ahfYIcRddoE/z6uQZuBIAxOILLtGFUsnf5MWeScaaMS/jmFT
	 sp88TO/pKL8c5VEVNQqZbkYePF7ca/MJwJVxJt1yGQpT6jrQy249vrilfQaH7WQ6NR
	 lCWz1lNMDZA5dB5dl2D/1+yCyLGdOYcg6W/hvmN7UoPiTm5hzt8XOipwrGFweyXCyy
	 ikrhqcFOqCwXl3N+U2nEcFo3XdJB1YIRyMhpbgE49JaKsacmzh97F6pADyEBZFtBFD
	 iHBVolvxkW8O9uf6odM07Gly0G1GVkG7a+HVT08SijtJTZs7MFQpWM0fKVoJyjWl2E
	 JeStNpSy8j6jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Patch "vhost: vringh: use get_user()/put_user() for IOTLB 16-bit accesses" has been added to the 6.18-stable tree
Date: Tue, 17 Nov 2026 19:19:56 -0500
Message-ID: <2026-11-17-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAHk-=wjJ80Ajzu6vd6TOjaV1jSVgvBJ04nMT0qK3igvqgu_Oxg@mail.gmail.com>
References: <CAHk-=wjJ80Ajzu6vd6TOjaV1jSVgvBJ04nMT0qK3igvqgu_Oxg@mail.gmail.com>
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

> Note that the "now disables page faults around it" is not true in
> stable kernels unless you also take the previous commit:
>
>   05fb07c40e00 ("vdpa_sim: disable page faults around
> vringh_need_notify_iotlb()")

Thanks, queued that one for 7.3, 6.18, 6.12 and 6.6.

-- 
Thanks,
Sasha
