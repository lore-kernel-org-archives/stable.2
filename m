Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961205;
	b=XhHMhxMIwMX5+cPYawGgXbu770lnwyMMqcihD7sNNoLvr80DojnOPmMhGETyp6XSee3E
	 +Ua/Yedn9aDzEQmIfJ8JvmQmcf4uUp6SzCF61rN+vX9fsxK+RRSyjpbqoCoT+JX2esJxG
	 NZ5WGpaZNFveWpn0MC7EZ9LP8FYIsREqnGZ0G7XZWbYi4X/XmE0NQeb0x1YNBt9DNcpJK
	 ARP8YlALtxROBat392pH3/NAk5l0uxfRconfQc0oAFOeeo7uNL5wgRPxmA1sdEyv8XBZA
	 hm80Sl9Wowa6Gx76SKW2ODfzxpoLoL3pQnJDwJ3HhRjTE00Ei5uXrJXbn3T//YO4oZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961205;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tDw64PTidKW4tbRkOeBVG+vbMqrqY/9S/VViLcg6PMM=;
	b=Wpd780M+EFz94ZmXDjUcSO6FrDYxPTeS/1GNPyBdF+cpl6kZyYxY9q/azGvGpK7ZaH8y
	 VjzHRWLwtqSGyKNK9UtHFVdN6l072vcyXb5zMUa3sbXlPU8ddqjhELMTYYSHkDxXrge3S
	 A1rEKZFYc0ERZ6Yw2ggFk8rUBquHVsgX1DI9Glha5hT2KK8ylzF4LTQqIQ03BqU2wj7DK
	 X1NzFFUohSrVxhRwAC8949vvIigTueHeLOJx9tvhhGXuh/j3ejaxufpg2vEWgG4Svgqc+
	 78jbBlHk+GaJs2ADnJG2mbB46pubSe5xn0oX94Uq4w8QkoF2vJP360WJp+r93k7rE+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9sd6MYK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F55606A31C;
	Wed, 18 Nov 2026 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9sd6MYK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F931F000C4;
	Wed, 18 Nov 2026 00:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961205;
	bh=tDw64PTidKW4tbRkOeBVG+vbMqrqY/9S/VViLcg6PMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9sd6MYKKOBvdy4eUUtoUgKvM6bcT+c63xz82w76UMm7Kj83ltNnU2tbzPEALkpJW
	 aevWAN97OciRDl4bnibjY+8vrF7DHw5QfQ2zNXdzDyKi7CZuvqcLu8K4sRP6jPU2bH
	 VKOWlmxWfQDjbrbas/+c0UTWlX2wr35s1/81Po6oNz8u/Hkfzwx2u+15sD8YHJ6RcK
	 1eC5Mb3MUVvbhwRuwqSdXK26FahWZ5F+7Epl1fA70SElg8/7GvSIM0kJl58wkSa0uN
	 0hN0DiEoSrCLIK7dHO4S/sXhkeKRry42rVx77TB8Y3KVyTBofvcDwttiKAPwWcH0Xn
	 OQxDAFavDoN6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Alan Maguire <almagui@kernel.org>
Subject: Re: [PATCH 5.10-6.18 v2] libbpf: fix cross-endian build with newer libbpf
Date: Tue, 17 Nov 2026 19:19:52 -0500
Message-ID: <2026-11-17-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116233301.1531563-1-asmadeus@codewreck.org>
References: <20261116233301.1531563-1-asmadeus@codewreck.org>
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

> Newer libbpf versions also properly ignore trailing data in the bswap
> case, but the patch is too intrusive to backport, so take the header
> length comparison fix from it instead.

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
