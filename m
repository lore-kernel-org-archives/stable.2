Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8843F54C5
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595415; cv=none; b=H3512179079m4BuYWxEiXVQh2679wAzjNU0Jev7SNnPX5gdpM73caSfzh/rQe8xx1BEVFp2tLnacBs56Jg4NyCLY/edzNKwcuae4Q/EIyxaNMg/MGHUIf5rEFPesXLWvdDfSRZZYyBmQOTWq2OIaZSVAKPu8p5VZ7epCfyrZSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595415; c=relaxed/simple;
	bh=pfwdKmCGspjzYMQ4Mk5erDQXGtfNJN2mDxZiTkMkepE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8Tg9ymALxq1Le3y3TciLoB7WZLk5NCaxJkS1wlWeC3IClkEys2IENmqq4km1pNoiUJ2BYqOG0jGFA+tV0RgRqeIXgM5zZIEFP9gZubvIetBK+0gaiQTEcNeEKIS+9mdCkrYxKzWxbSWMYFAHRup2eTn9EIpp3HGTNhRg75ALUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgmW8Ue8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgmW8Ue8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EABC1F00A3F;
	Tue, 21 Jul 2026 00:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595414;
	bh=wdnyP6buDhpD+5sOpxGHBvEMeHRWqdcjGJzBGrPwaUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgmW8Ue88AM4CJvfW4ys9qdO+1phWx3ACQaku6Uw1sQIXJcRXzOjePkDx9ciFP+u4
	 BW2HsmyMdT6Faq2Tjgz2MOucNPARP1r5WcFQagBx140Ij0meQE6b3rj66dDxZtIfu/
	 0p9REkFO4OicYEYDl+L16bIB6QdweYbaptRF2EhoarfG0XmXYQfzhw3/ONpcEclJ7p
	 4pAmkYUqZgfoUdHaGE6mmc3TltrYNC0uOwLNWZ90d4FBXeNvffL2yY5lMp95rsI3xw
	 OP9y0ZCXp3oteGeqFAqlCxtWFPwbDYBQsagXfBttsm7l+2Ek1bArky4+Esly/1QWAI
	 6TCPGmAK74g8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5.15.y] batman-adv: clean untagged VLAN on netdev registration failure
Date: Mon, 20 Jul 2026 20:56:29 -0400
Message-ID: <20260720175500.0022-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720134954.703026-1-sven@narfation.org>
References: <20260720134954.703026-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The register_netdevice() call will try to clean up the net_device using
> unregister_netdevice_queue() - which only uses the .priv_destructor to
> free private resources. In this situation, .dellink will not be called.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
