Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479123;
	b=Vri18gmrZD05OrhEA2zSwj5k81KLIl6aGnenT3DWLx+5MM8OtiSgKdvnUVTbp/dlej/F
	 vlj8gxUB1SIFDqoRjwCSL0yvMuRCVCs5JKc4OFQ1nj/x/Lg9q72JaX2IQmsUvBfIhGW2M
	 RbZ01VlPzZARnTP7tF05XwULZv9N8m+4f89f3b1f9/mbjWNfRp2gErdt+7z9dKRSMKtzn
	 jE8n4fwZmpfcGd9IcKfSt0S1oydM5Tc6kyg7qeagL6GY/uYNUG730C0bz99Buk2rk3Pw3
	 8vzLD51RqXLK55r659BjE8XJGuTOrO+1tKFK87rzcbzKdTqYrFHhhamBDy4pl1nDHdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MhTcETdf4q0iY512fAaT7EjpVjngCmnsfhVFouuC46E=;
	b=bdLaUZbicY2o/QDsobdpbVQHg+DWjj4/fYlscdQ4LVDp9gQtej7tM2pDhJV3mpVvUQNN
	 q2U7WvWo+5OYgnOinosydoEBgE9W/lnhYfVR283/7MMjTJOL+9MaRcPHlxp4J3Ro7t7pV
	 FNLkwvVAmUl1PRo/FRM16a8/YttaU4Gdl574i08WpofS3d89G2aGQaNRfvTG2I+ywpEkE
	 cg9R/Gssvbg3CTELJy+4bteIiKdxcyA0ar2uX7MzCY6iyZqoBqAzZJ1NvsdxENZ0UXQp3
	 WNTftj95tN7FoAhyUxM3ighgPcAVguUc4I6m6GdhyaTcidYLfSUkuWqcrRS5fnbkeQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LitMptnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978F606A689
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LitMptnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AD81F000F4;
	Tue, 24 Nov 2026 00:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479122;
	bh=MhTcETdf4q0iY512fAaT7EjpVjngCmnsfhVFouuC46E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LitMptnbn3y2sybu/MpM9A1+ATpbQ/maOYYLeIJdhO+spNSPJ6SiIVZwii56oJdor
	 3b5Yd0/uDE4wSTzFEWvQNmiTyLpBGCocbXh0uzfCB1duu0rLeDl/DLMe3vX6qi/01B
	 hE5quit/80ktPHjVBmWlhTTlaQdptCKbR7Kk1dOj7zf3IFezC0oMUmtjW8VZp1Ylt3
	 w4YfDrFlVTWciT8EQsQhodTiy6E+fjL4CHpNqSeV76iYAokFtqhEQvunbBFPYXBIds
	 kQsjgwJhbDLUFYmxP1C4INYrpNCtcLEoZ0WxKzl1RiXq6XgoM/Zl5Frj99MVjk4O/a
	 YfMwpNZX+mHcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: [PATCH 6.6.y] net: sfp: add quirk for Lantech 8330-265D
Date: Mon, 23 Nov 2026 19:11:50 -0500
Message-ID: <2026-11-23-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122220759.72495-1-pepe.schlehofer@gmail.com>
References: <20261122220759.72495-1-pepe.schlehofer@gmail.com>
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

> Similar to Lantech 8330-262D-E, the Lantech 8330-265D also reports
> 2500MBd instead of 3125MBd.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
