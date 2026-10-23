Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785786;
	b=Z+uec2HmduKzW9ovllRIyhvCUpg+381skumwwcKU+cCpN7NjBL3pi/TVeS43TLc+7jqE
	 IeXTAzOUnMxB1fQgyXeqgrHip3GfY+nzYKuqpFLFjuRKgEh8KvC9Henx3daprHSOZSCZj
	 +jC236Byblr7XIx5QWLic3N7Fm5OeZFPMGkNrRPp79PYfy+0P9CMAS4zgMzX5mv9cEQXE
	 36lQE8OLEV3/mdsqGc+pppyXQwSS3hB7EIm+D9++/ZssR06M3elad92k36snzFzCjv6O/
	 ipX4swffiWI7ZCnF7fwSk6TNwTWMoaI9vErptf4QGdVbup2SsSgd8sZHhHW7+vjuuTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XUIJ+QrJcJYvumQ8S2jYQmzBCArscp7pCGzwOK+IJs4=;
	b=SF05QrZTeD0oCClFxQlXyrBkh971SJ3kBipC/Ifcm3oN7Ap/+o59h7uKCBKvbn3HY1xN
	 JiueGPt444PmVp46XlYbP2kHeiy7qzaZPsdZpP6MF8J/5HiM3LK2MOwmoi9KfkHXHyGJ+
	 dzzv0E7ZANykPwgQJCh9s9cZI/6STGnfUJSeGaLv3SjdyyUGV1T4SV0SD/jA+wF1kpoYv
	 JJdA7IiFAB3WoIoVXuiTQhEgdXMQwqJ+htk2qtJ5HNku+DE70jOg2lSCXcqxo8wzBwLI1
	 Hu2mNgziU+moaGbmq5qjxNIoKKJq30gRE+qHX2ykopq47oigTaIo/PtEUAbVoSAMd+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vp71jFsP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E274606A31B;
	Fri, 23 Oct 2026 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vp71jFsP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03161F031E2;
	Fri, 23 Oct 2026 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785786;
	bh=XUIJ+QrJcJYvumQ8S2jYQmzBCArscp7pCGzwOK+IJs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vp71jFsP/Mf5njbOOLlzA5gZBuNHEIHWSehC+klURiMV8cZ0rHC8hkeNwkdUhzuyf
	 Q88IS4qKJURwWnApE0PIRtSwVvPC0mYIG3uBWWoyI7yV6c1B60WtRIXhv9vOrgKrUF
	 ETWQ6tjgpgifIUMk5oJqwYXq+vUaunpVHHIACeN8f9rd00XIYf+vZq1Cbkse7NAUs7
	 lzngEaNg/nED/qC9ayjct3UYUq3S0+5Gnjb1oUsVPiJXToXlqLQsUZtf05zkpix9mZ
	 STidplzd2ZbCPxMQcb9IOVVr+uYTp8/zSPBevF7SbmT6uB/zbQjSLIFGhbyyKt229P
	 3/D8bEk9X/oqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Subject: Re: [PATCH 6.12.y] net: call getsockopt_iter if available
Date: Fri, 23 Oct 2026 16:02:46 -0400
Message-ID: <2026-10-23-1-daily-reply-0010-getsockopt-iter-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
References: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
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

> Update do_sock_getsockopt() to use the new getsockopt_iter callback
> when available. Add do_sock_getsockopt_iter() helper that:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
