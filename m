Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87D344DA8;
	Thu, 11 Jun 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191589; cv=none; b=NRbn8q3SBaU7/G86rxp323Voa9Fcm6lHGJUOiYPhnssf9WJQcwOfZwBzusogBO2f4hTb94v5w1etU+Xrk35nUjVn9RqACKR5uQn+8csMp9a47Wp6iow/T7Lwvmks+Nf1Nvh9A/dXYbW9zoeIYsbK+96s7CwG6bB0/jcYsjZJMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191589; c=relaxed/simple;
	bh=XTWajMK6bH1jKnuhcK0cazfy6hb2heIOrcYynGZuUfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6y02DtyM5ZBX1U71M/4+yWKnkWljxBtNeeYLIYa9x1F8RXX6acbPBoDkR4e8IcNtlx1gGb6s0wRn5e0xwXWbphSBylED6sKqJlPT775Qq12JeRDFaO3KsdkoPD1GCCpnmDO17wockyCyMb+lpWotKNovDH7ZqNAnn6dPbrzm+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EytGKTvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EytGKTvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEA11F00893;
	Thu, 11 Jun 2026 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191588;
	bh=XTWajMK6bH1jKnuhcK0cazfy6hb2heIOrcYynGZuUfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EytGKTvEv/LBxF+nw+betOjnSHgQhS3cBMqcWjSKMUgm7eK+cticIsv9l/OgIV7ql
	 Pj7vDBKDSFpEweSMY/tyHz+D2g3xXpf6N6R2Dg6u+o/sult5zvXzPT9TgZRmSYRDdK
	 yc55E0ipqN7ww4j149UVJxdDmmwYGGa7PI57ewofcB5tF4a22pYQT8DNwUH4HgZ5Yx
	 tTnuA1dND1KakGejJdvtjTi6lN+tKVxtRHJfmbC7ij+Ha1TD5u+o+qTRl6sIrfnIAF
	 qNwTgfdLiTnIZIzlRu/vUCYEgCoNGlMNQtJzEhxKa6dubNSxrOK8eIcLPv+4n1MInL
	 yvJzZSKDHyH0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dhruva Gole <d-gole@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Robert Garcia <rob_garcia@163.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] spi: cadence-quadspi: fix unclocked access on unbind
Date: Thu, 11 Jun 2026 11:26:19 -0400
Message-ID: <20260611-stable-reply-0101@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611063719.3528053-1-rob_garcia@163.com>
References: <20260611063719.3528053-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 02:37:19PM +0800, Robert Garcia wrote:
> [ Upstream commit 233db2cb14db8b1935dda52a6affd97276462b82 ]
>
> Make sure that the controller is runtime resumed before disabling it
> during driver unbind to avoid an unclocked register access.

Now that the 6.18.y backport is here, I've queued both. Queued for 6.18
and 6.12, thanks.

--
Thanks,
Sasha
