Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795318774;
	b=5ABZiK7oAyM9/FmLjwi3xNMVNXkYRWbWnhsQDH/3g3rjDHZbxPRvJf/AbFzN8E9Nok3u
	 wIX890ryVcIFvzUAUExCm/0s8DnDtkW3GFuLsNtVUz1b6Vjg1sIYSms1NkV+yYEF1wg+N
	 nkoDaIYT+D0cEeC5fwXfEaRZym+THPnOrRXck5T96f3ktOog3N5N+JZjDh8xEGp3dr0FT
	 la3H/4aF8JJa7VQnXWoCrQ4zlqNdJfA8cSOe+B7r8o0wx4G5zjOB8jffiLoncJk2wRUYl
	 3Tt+xy0SvOiNGeBQvDaD65KEhLDyirAcgUnnQV83KeTbIe2GzKfG345s4qQDQo/x/lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uUNm8dJej5nfWl046hwtxB07+w92Spr0JT1mTM88Lag=;
	b=DrH6CvNr6TscveC8D8yX7ZEL5fg8uvgFkSLWS+5AFrkNHJjgZVX3ef9gS8ornjb3ILOG
	 efppo4+wBQzqaPBDe8LVkDmI0jShlUV+F4WVqNkAALwmaMhOyWfckek9rBhTpNKRcj1zt
	 AaAoVVT2STdrIE5TU45u6XOCxHyRzNjai/SMNGAf6HjrDvUu6O7P2OZ9Zu23BfyGvDXyI
	 IIOU9/V7PN/rnWLi0Zg9UHV0EEVMieJ2wOxgNdLmJwIkf9RjCU9SrpBPdXW42XAEulVW9
	 TzqdmpbuLYHUsGvGilFYqQQItg2iwQcVUqqWkGW0FP8KyNJJ0tpiRXbzy17A9lQm/0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4LpnTsO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4598606A334;
	Sun, 22 Nov 2026 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4LpnTsO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0D81F000D1;
	Sun, 22 Nov 2026 03:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795318774;
	bh=uUNm8dJej5nfWl046hwtxB07+w92Spr0JT1mTM88Lag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4LpnTsO5r2Hk1Dgkb9yFT61VvFF+0zxVUml1m1Ht/CGKmo7n2wHveNdbiR1mz+wS
	 qKlosSwaK2jsIILDYKPCmnI2K2s+0nGBaQpJWsI8QxCSYPAFkubYnaZXgjKaC7srlw
	 /OYhj7nkKWv+Hus6ajnDirqobwAlWyhMfDdigKC4yb7v6QFJ9BnND7Q82L2U0uMR/I
	 kt3iy1AYApuWc1PT+1oqeKOLzSVTIs4B5ucK2go75zLCeXsnrGhtlgvIKKwcEWwHvk
	 LJO690f2XDABbs+9lBPsGadSAI8iILbXP8VRbdBgyPVgwPFuYPQzydIjK/dQ7yZmdr
	 6XvRGtiFDSSwA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Sat, 21 Nov 2026 22:39:00 -0500
Message-ID: <2026-11-21-2-daily-reply-0017@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YCCGb_21rrE+b-3E0brvSupto3+ouMDL3=4m38cg0nBFA@mail.gmail.com>
References: <CAFAa3YCCGb_21rrE+b-3E0brvSupto3+ouMDL3=4m38cg0nBFA@mail.gmail.com>
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

> Here are the six fixes merged in mod-orphan since then, for 6.12.y and
> 6.18.y.

Queued all six for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
