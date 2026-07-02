Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B327A12F
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952732; cv=none; b=Cy+3ETKPXIa+K5y9xQYXjy6bH0f3lWUJZkFH+LSFRnJE5KyD0Bt4p/KDes6hG7DIIjFI2hoP4gB3h7DjYaQNMGp+ewgPlOa0fogrGGDKL5EqYXqKlqoi+iz1ufjNzRkcMyy536z4tXilTavEvMQi/+QmZ/kqMG71peDDXnncu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952732; c=relaxed/simple;
	bh=tRGWOi+X7kf9P3os+1zncWoJM9F1KIiTCXhZMqOWVaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh1tXKPcYsbCM6X33w2e76NVGDXGYlOu+gumbtIVWJaQ83YF9VwJ7//hSeDAZX3aMd61k2rG4mgM1QiFnbKePYGZL/w+1AzwBbU+5g6iO5PylNDkYm71/rjXjmQc9zCkvS59eQURt9aiKm1p1BwWd5sndBySqfvyKc1YCIeScTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS2n8/Yr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS2n8/Yr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8CA1F00A3F;
	Thu,  2 Jul 2026 00:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952730;
	bh=K2MvIxzJYyDxUHUyAWrPFvGMONjWCoIf+Y80Y08dkHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS2n8/YrYo1cgjGgyK3Smo3rv5av2X3Q2tg6yuI1ZufWx0ETT8LmnQxORX80KZD16
	 qGMsE7JaYzGu9lOU9krOnbZtKWMVvZBpLTENb2LJhJo7FnecCFO+yMKucpQ9/oV3hs
	 6R2/6jwJwSbgUhUgL9iFIne0+peYgEQtm/QLXcG0HX2Gzxd6BnuayXHaq/JFYLPvER
	 1g58/IyoRtklcxOiWeA3SmzQfOIBTKS3WaktNPBvBs57xno0dnrdm89LkqakjiTkHu
	 N9kjuUXRqJOWvCaIF/nmeUYCvpllJtnUF7T2iQOgbOvQdNtSwkfck9US9kN/4shXBq
	 c6RblpgT7Riww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Cheng Ming Lin <linchengming884@gmail.com>
Subject: Re: [PATCH 6.12.y 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page Program
Date: Wed,  1 Jul 2026 20:38:32 -0400
Message-ID: <stable-reply-mtd-macronix-612-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701024204.2730472-1-linchengming884@gmail.com>
References: <20260701024204.2730472-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Although certain Macronix NOR flash support the Quad Input Page Program
> feature, the corresponding information in the 4-byte Address Instruction
> Table of these flash is not properly filled. As a result, this feature
> cannot be enabled as expected.

Both patches queued for 6.12.y, thanks.

-- 
Thanks,
Sasha
