Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29B3BED0F
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499682; cv=none; b=h/AeaDee8ldhGzDFpkU40MA9Hr2GuxwnWH/QrHUulRv1vXZCSaTKdp6/Q5sU/LlUZ8wcfXU7HOP7Ch5UpmasaVuqCV/VcStRd6sutU+k2+zoQI3TVrDmkgUFxhrYKHxNs4wvFwyJm6P51LQateqSE0XsxOYJZ0Tqn4nw6eBRMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499682; c=relaxed/simple;
	bh=2qqO/o06S/omlXQidaM5gm0NG9gdole6XRt8XDUnMXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJH7bfx/bDH854VOEMk+CcJpx0V1uOt0Xx5nNCYeKEW5DVg1ZifN0RrKNoFi6Lvrpc6irEqBljgm+NiLNtqFx3x8f7sIpk6690KT/VMJNvjD6tydCk0/Q5kbEApGgFi2L1Np0d7A4zf+A9IigrDWm3sNI1+ueW/Y07vS7APQKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYYne5xY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYYne5xY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F91F00899;
	Wed,  3 Jun 2026 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499681;
	bh=YdwffdwQaorbwRmse8wNngbWN3R8ZAVKeUQ0ovQxCXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYYne5xY91IOeYejCe04nbAraPtlrauEh3z1+dd0PktSkvlQFLXk35FtC8COXFOTh
	 YgZDW9Q2Qcf3yeeQuFqvG5JL8nA7WaYa1QoPNaLODwvv/Va1q51oj5dbNAAmPeVFkK
	 aEBZ16OqOfka9DZzHCpJaJUxQuLW+t04/m9kccQ19B6MSfQNUxFsfnL1s3E06oFRtK
	 pnBHWVWIIYmMa7pMQj/gIXCQp3704ZMtdTjFz02el1sNOPwC8OG1Vmhk26s+j1bR+B
	 K5gaUSar/Q6VxhFQciFQVkg3n9AffssOUKipPKayHOTppRkiy39Qipv25mim0juzAn
	 EZGdydU167esw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: reject oversized local TVLV buffers
Date: Wed,  3 Jun 2026 11:14:06 -0400
Message-ID: <20260603111500.item015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180300.412724-1-sven@narfation.org>
References: <20260529180300.412724-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, and 6.1.y, thanks.

-- 
Thanks,
Sasha
