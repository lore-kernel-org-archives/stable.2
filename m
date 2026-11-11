Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434106;
	b=vO19Dh2XkxSXMIIadLYuDwg8xcbde6gfw3ywSOEjGHzn1Be6lf8438cOMGg3ETMiXvCe
	 ZeqL5c7dU+vba+qofK5S4PahlBVxpbgosQZR6612xDF2tPWkoSzF9rCaRX+Vwv2TvjsYy
	 5knXArfozxnW/2VK78ZGazfIkNMMJCrMCpxavWg6m9iuWLSqM8egOsJxjCcpmDBsvpgbz
	 KN6CqiY0K62LxP0zUv51hRX2HW7AXtDXVdy6Sky+zfN5yj554fOJhFQaWAc0ekTveORJP
	 z5aPAjKR2HKb9UoS7Dd9pIfQptrm+0sN8gNnKg8UUJC9i3ZVAroNET7JyeH3enBsBgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tM192/milrwxxFIbNvR6/Rv+X5dFqunToZ5HQPBZCiI=;
	b=H8Ay4Vq6Dq5lTfI19lk3QBTtnb8y3h7JGHZkfk9iysnI5XxTmDPrNE1JWIp4gy115hwP
	 y/2dLvsDgOlb3vB35xi3p5EdmS5qu6Zhh5sWPQt8ufFxC+eus8s3Ekg8CrF/Pl3Wgl3Xk
	 MS+kLOlbEXwzZev/mBVyB2GqxpLxVzaJ3q2witXv1qZ+pm1W6gS/CBTpMfhQL8Un9BEw6
	 bVLTfs051e2SvALUiiDjeQDqn349MRnz6vRZLnP+wJ7KijOEuFuO4i8S2/i/TVXxV40gf
	 U1Q6euI/IBjIGDjpIwDvTsyrHtPcvjOiKd8TwQzKPVDj9Ao29to08PzriJUf1KJoGCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euGVsdIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B3606A8B0
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euGVsdIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84B11F00A0B;
	Wed, 11 Nov 2026 21:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434106;
	bh=tM192/milrwxxFIbNvR6/Rv+X5dFqunToZ5HQPBZCiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=euGVsdIirzqb2TLdmkwMZCZZsnDsPBV75lveCRyTL6BTzANMOiXr8EQBhULlnXK3E
	 gw2G7oEajYjl8ZNKT/7uY8EgnsTvbYvKKHYSGs6lUfNJAvykByKwvJzElr55lV92bi
	 sJ4R4ic2swR31ZIqCcNmq4iGMMuBD+hGtA1HLpE5Az7WjCALWGKtvijiRt0wzBGp0U
	 0PqAg2II5+PibZ5iC5pvKb//jnlkwGN3a1DTbvoVoJYDl/ZMuyjKPchYYY+CIgNstN
	 aDKtJZPTV+E+p+Xp2zIVIibGkIYgUtkPkwpx5uvnjGY07IRO1VGF0dKVPj/Yit1R9F
	 lnuAxxWpgPxlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Date: Wed, 11 Nov 2026 16:54:39 -0500
Message-ID: <2026-11-11-1-daily-reply-0006-5ec3258fcbf067cb05bd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190328.112717-1-sven@narfation.org>
References: <20261110190328.112717-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tt: send ROAM_ADV on each roamed back client
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
