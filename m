Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845210;
	b=F08kcNt7JAKjkYAKLWZtJWXtc1eyYZrYOhnprXusCdKuI0tDCkp9Qd5AFDYOug9EwqOP
	 VnzEVYn8FTpvQMXl1inMtMTtsM4yQ5MCWRH3AqB+vyH5uWcSOIL6HPhRekqnZ1qtLckcj
	 sMuheyQhkZi9srEtfHKfx0UvTj59YH4FyPeeSfWKOzic3dET+rv5AtmM8z6fviJdLzhTi
	 kmzPepmmHq+U1q+hzYZ7++eEFSiHZrjso5uP7WbGOVdgh3OgyJdAr3qr2N0Eq7fT3cL17
	 dtNsKReGugFEpo5CsJVXe5mEN1jmccA8oSOHM6DVFbC63MaHGIgsZOULwN9TlGj8qLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7pu2B5V4vcyRH/xlSfCXnnvZnLeOA4huAlDPsEgmYYo=;
	b=IohAU9ToYyiH+CZSk35xFmJ97OnPTqYafvuuI0E/U6uYASlDhkMIoWhKpNLRoil/oIK6
	 UMw+FXJ0XPd4kfEsVyeX9V8A8+Np2JjgxCyg6jcmkxTf6t3NB6OBcppVuRu+20fL51k05
	 HE7Dv7M+ipPM22mwm99RDBFumqXsQmmJrzCwjEhbKZTwdl8zSHInyAlDv5i3bncjn0tLa
	 T1Ao48vBP20lYC5hDtb+iM3ks3ztCJz4m+OrriQo+2YXAF05C3/sSIZ/+E8S6sdZkao05
	 RMV+JckveMa18bwdAUA4KHcST3rMS3G06GQ7zrMPoFpvP/QQq89mWfJAu8raWmjXvvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IbM+g/jv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36430606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbM+g/jv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085071F000CC;
	Mon, 16 Nov 2026 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845209;
	bh=7pu2B5V4vcyRH/xlSfCXnnvZnLeOA4huAlDPsEgmYYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbM+g/jvwxvSgv89m8Ope8PTzx0a5ve8Fe1kKzHV1wod9FPspM+8Q986YnUyvovpC
	 osQ9FyDdiaqPv5fUsahzUvIFPCfY1YMd74QlvjebhbjRZFCdAzInjnSQUK/wb0070b
	 CP+K4vvxfMLZSrdBtMcDBHAzVZDQ/wOQv46tfrNP4F4zPm2Nbe252nUIvQfZe4j0xk
	 +1FHLK2VRbdEPyPQWX+kVby0W0GGTP3cG8ugaOwPQwRJX3xvHFVtqOPww+jYSmDTp2
	 /3p1ClanfcfYZKZfSg9FHJlKf9rA6PNNzRZH/dbRHBGzzlmMMFc8OscpuS6RX3NDnQ
	 FWTeqCKOiXhDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Salvatore Dipietro <dipiets@amazon.it>
Subject: Re: [PATCH 6.18.y v2 0/2] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Mon, 16 Nov 2026 11:06:39 -0500
Message-ID: <2026-11-16-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116111734.3798483-1-dipiets@amazon.it>
References: <20261116111734.3798483-1-dipiets@amazon.it>
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

> Patch 1 is the other prerequisite, fe21f930d1e6, only moved from
> mm/page_alloc.h to mm/internal.h. Patch 2 is adjusted for this tree, see
> its changelog. Acks from Vlastimil and Johannes on these adjustments
> would be appreciated.

I'm holding the 6.18, 6.12 and 6.6 series until Vlastimil or Johannes
acks the adjusted patches, as you asked.

-- 
Thanks,
Sasha
