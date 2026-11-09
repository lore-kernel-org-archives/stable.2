Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239619;
	b=KyONbx1LogjhFxwo1EE8SqLb/3mciYKIj5YmjJg/mhPBHCAFXeLQfs2+PoK6wu9hTXQc
	 svULaa8xJkDle0+PRVzALRv4yld0XvqqSle8X9nLzrDnaSpHT8nRHcqQUvzPMgScBdMd3
	 +fZzaed7PAT/tHx2Tb2VZg5R/X3wHUCxnI9+UMXrwj0y071+hbI/7tI8JIJWJP3z837xa
	 jCGfF1JzItrSR6tuCUAiIiVdCOhSKcywLuGYPfYDvFNg+UUda1mHNfr3sP2QPLZgXwN2M
	 s5svEE/4zz+a2/FwB1iGvmY0ykky/Cc0t89XPak13oOymAgPrMcWXZEAdrshCQmOJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FnDeOxopqvPMCqLDqX51Ft7w0NW6DnIPS1A6cXc+O5g=;
	b=r47/FH7jQJDX82GIUlD+vMZ4mdCgPOOAEAu3zdYYTDGYKQEOrdiUInYRU0QNj9+HGS0g
	 iDMRqGJdN2Ov43H8My4v8WWMvod3I2rhR6WTwwaS+NjoVgnvtvCuU35Gg72gj+QzG6/Op
	 naUI6NAxB2JdXCbCjF1DkrRVgQjAQ+ytP3u0zq4ijpfw25qflt56WdY7hwh0cePgiRzBo
	 tl66VpqaTXbJLk5Ib0NHBP+ikv9PZwpBWBABsITlx7VGFAKX2u34tGvFpMfl5Suf8CHfV
	 Got6kF+XBBMYqE+WAz40p1hmMFIax3Wg0hlJjsFF65fytFt0KYHi3+/yMMd9p9aLM9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G0q1Na/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8E606EE9E
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G0q1Na/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D4F1F0089F;
	Mon,  9 Nov 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239618;
	bh=FnDeOxopqvPMCqLDqX51Ft7w0NW6DnIPS1A6cXc+O5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G0q1Na/y5BGlBSTjJ3tjjR+JRK6IFK+RSolb1R2VZk9vNBTnLKg88CznCE4iN99xE
	 msf7/IgygFQLE+6X5R/cQyloy4hlvXm0F0Ht7W/YedOrf+MUemnmUtp4zfNz74dgkl
	 0FnD91Zk735o2eNdnHs//c6D6QpZU3LnAmEYDawaL3xwNAW9/H/b0os2oxaxWeCeWQ
	 VTxCr7FeWW5W8ajo3h4T1y4q3tVaEkytRtKVJFakTM6ZVPOU3ZKZf0Nx3+HZnBvJmy
	 kJFnCP7dZDKeRud0WZlVf0U++n7NYkeUzMbYa8cl7KMjSzsxwIhiIyoygRORMSaq6B
	 HxYlXgUFgAmUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Yi Cong <yicong@kylinos.cn>,
	Felix Fietkau <nbd@nbd.name>,
	Yi Cong <cong.yi@linux.dev>
Subject: Re: [PATCH 6.6.y] wifi: mt76: mt792x: fix negative errno truncation in offload capability
Date: Mon,  9 Nov 2026 10:52:54 -0500
Message-ID: <2026-11-09-1-daily-reply-0012-mt76-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109023245.51991-1-cong.yi@linux.dev>
References: <20261109023245.51991-1-cong.yi@linux.dev>
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

> wifi: mt76: mt792x: fix negative errno truncation in offload capability

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
