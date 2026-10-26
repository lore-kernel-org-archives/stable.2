Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055366;
	b=daPFtLx42yhIjvt+pBA8jJJEXpnnbReQTO1mK3jdh7ypkSQs+upqfYX0vPu7exkAc4PD
	 3wvLMN1juV2H0rgE9uO475p3tbnUgHmFNN2TpT/AnvTL2p6WkQvJptR9KpZzIgB5jzFqq
	 KrUSoUu0D3+PPUcRGGnqVKuSJ+bSnivhPQ7dhP2Ldo3mtvHUNfw0/x2E3y/DXMaq3Xhdv
	 har76s5QaWH/Fc+BXxAc3m1fYsBjOSMXrpQ49eAhCKBooeHJv0AEW5Igv4drghhQOb9qS
	 yry5ANiUKnAcr+LSXRlQKtC4EAzghbHL2M3V6KD3hg+RiiXvjoIbVca/S00KevkCC4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0FC3NbFs+DPLnzfnTWFpWEFC6ZqH74Wu8uULElOQYMs=;
	b=w7fNQVpjbELYW4xmKsJeYyzRbD5bc/0hQjkr/g8g+0i8uEIyn7CFf347S0dKffu0EJeb
	 O18eQzq9yHS2lUSZg7j6t/ngmS4CznPNy9tItsldryAIik0V2ZdPqx8c59UVLp8gv5tby
	 MXjuUQJhPrc89+2f5Esc55pDIFQHdMxlS0ueOjtj/D62HJ6b0vBK8iY4nVZ209+g8v9Iy
	 OnTuFJ2CHrslVH/u6XcHeKLs8eubfaWofZ/niUV0CaW2GTjz4jFROXyGi3P5sujg6i3eq
	 j+9YYSnm/jkoMuIwkuoR/xejnjQp3J6xZgtbrEla/NIxMKDW8CySaPLwJcTDy8TqTDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J94fgKU3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D55606A320;
	Mon, 26 Oct 2026 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J94fgKU3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA041F01829;
	Mon, 26 Oct 2026 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055365;
	bh=0FC3NbFs+DPLnzfnTWFpWEFC6ZqH74Wu8uULElOQYMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J94fgKU3Fb7fJd9d8gKUhgCRi2CCJORTEF6PeKdvwd6OOWTlJcQMkTr1GCMhorVXx
	 FxfOpNGCmy2sAQ2ehheHPvg5lJZHMe6addf4mOqKN3bimamty89QtLMvAusLCjELQi
	 5xINTZdGxK75r61oVZGd9MKBC+EoHmmWJQz4qDtr7f+b6zt3A+SPfbRf7mFJc523NV
	 pPMaHx66ExnQqGoB9knA23/Zh0lPfL+FEJ85D9cUaACfjgpLV/1yiMieEgpFw915sm
	 CSoWlpZ3fYIj2Sw/Rs/VdXqvPDwX9duqG/idlBSOLFho3Dd/Sz02odD6yiocRfTIU9
	 MwWxLr2NSKNEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	hyc.lee@gmail.com,
	linkinjeon@kernel.org,
	liubaolin@kylinos.cn,
	zenghongling@kylinos.cn,
	ntfs@lists.linux.dev
Subject: Re: [PATCH 7.2.y 1/2] ntfs: fix race between fallocate and mmap reads
Date: Mon, 26 Oct 2026 18:55:53 -0400
Message-ID: <2026-10-26-1-daily-reply-0002-ntfs-fallocate-invalidate-lock-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026015533.1124816-1-hyc.lee@gmail.com>
References: <20261026015533.1124816-1-hyc.lee@gmail.com>
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

> Fix by taking invalidate_lock for all fallocate operations, not just for
> punch/collapse/insert modes. This prevents concurrent page faults from
> accessing unzeroed clusters during the allocation window.

Queued the series for 7.2, thanks.

-- 
Thanks,
Sasha
