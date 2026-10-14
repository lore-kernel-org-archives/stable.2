Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51A01A9FA8
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941256; cv=none; b=UfRaq+Sv8FbRZghG6B0xyz0HA2+6JeHSUWhxJ4UfJqapDIWrG9132vklxNN0yGx4e7QTO5evKNouYiF3Z5YFg/880HDLGba/DOp0r8xizGEKg2DkffM4+rFEQswnypoVV6yuq+inn4Gs+2a/vudYJOBoIDNFx2euzhHLjYoYnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941256; c=relaxed/simple;
	bh=QafqiUYgTbNU/YeqfwUPLrQyIygf36or8HchtkTpfTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zaary/WB3wLBbrh7WvSo+qXVFulrLxMaqvBgv6YlP5c1TirwAN1KndbfZkuhRVq9g9FtfaJhnu1WQZ1DYd7bBUV3piT58MtNDRWFX6CEh71dNcykfTOPf7q8urbgiWv1jlBpEvdWoopBCGG2jK5nfkk9EdbW5bujr3eGBjKEBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRlC88YX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRlC88YX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FDF1F008A2;
	Wed, 14 Oct 2026 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941255;
	bh=zrTNLmd75A7wc6tWAljgeg1Vg9ZFJCfkQl4FxYiSxTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRlC88YXcm+sMJp8QfX9xAu4KoucKUZDCN4HfiI1FvaK+F1tsFOKh94cCyRFLq/nW
	 ck4FD76Ygf1h6jJfoZMJyo47xOzE2i8GszU74blJTF+ewi0p60pHlF/cff90hzRF4x
	 1aiI0OC8dAxegAhzqLGpTs1bDWevXMoKF0B5qdbceRrY1KjGgtc+ZvcWsasOP/KuRQ
	 ifk5NcEmKbTaAqKVKLClmEZFPmzb4Jr2e1fS0ZgnWoe+52bm6q1+2a2Rt/CaSOWQiW
	 7xzYL8RAL4faLJXWF/wInih+iPKyoCSH3aIzEL6MLyIJ/jhlOnUWfIP1EPBKwubK7P
	 xqQ+y2ecN/PDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Charkov <alchark@flipper.net>,
	Sashiko <sashiko-bot@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.18.y] regulator: of: fill in supply names in of_regulator_bulk_get_all()
Date: Tue, 13 Oct 2026 21:27:05 -0400
Message-ID: <2026-10-13-1-daily-reply-0015-regulator-bulk-get-all-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012152921.1140956-1-alchark@flipper.net>
References: <20261012152921.1140956-1-alchark@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> of_regulator_bulk_get_all() returns an array it allocated itself, and
> fills in only the consumer of each entry.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
