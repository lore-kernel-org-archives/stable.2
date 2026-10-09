Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3A3806DC;
	Fri,  9 Oct 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572482; cv=none; b=Dhpuuuh99UXc+jQvAurjitRYSHFgNHJqbDgLIJphXfQoylU97/MfeVHUVGt7CNDzY/sNKyzD7PtoToVFb6u8XQQmgiwVMyPtxOyxjazkPNz4ogVgYYEDdv9CDVmuR6OX0g3dU6Iy46cJAy/9wd0KTI2lcTIPxBhGF2HE3zHz9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572482; c=relaxed/simple;
	bh=sDRdYuTA/LTXpMD7LlG8NIi2W4B4knX7XSYWN5wRIGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+BxJPQ1qg2YKZqANRLDPT3SAUfd5PAOAr5A0s8Ubb2r735dTFlqh3lMWyilMedJBUi96STWTBnsAQTnQprQ5LeoUygl+y1/xuecIxhF/hvKB6CWbCIRFK7qp9qX8Vk9DTlivOwCqWPdohRV9ZI8MnKTTyM/qooEmqBHOg5JoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsvA7aPy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsvA7aPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD781F000FF;
	Fri,  9 Oct 2026 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791572478;
	bh=MaHEgRvIPjOiIVohU0OwLCN6dcXrjGmPWiU3FEOK/ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZsvA7aPyJ65aeRJG+bKMCCH5lX9mZs+u0YlpARqjyqMm6lLHVVVERfrYXtdTdeK+w
	 lPh6T94R3K7KhA5z0T9BW7q7yolQPM/0M/0MkugVhmx/klGsi83WSR/IOWLhpoMmAu
	 gUC6sM82H6JeWjE6ZlQeN7p3UIEupTQBRiOp4HtiAV44Rdo3mTLbXVCWmoLoEJCG4H
	 SBV02jp47cgyffsB3GvqInGFbsQJqEJZKpihxhxxBetnD1hBmzEefk2W+nLEDdfqBi
	 r4yvYAoo6PY835AGbLaG0+BlGsvDqfQKAyzrIeotvfYFruxRLOKmYoh0qU6nCZqGiF
	 DAjzknsCAg5pA==
From: Sasha Levin <sashal@kernel.org>
To: Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siddarth Chilukuri <siddarth@nexthop.ai>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO"
Date: Fri,  9 Oct 2026 15:01:11 -0400
Message-ID: <20261009145800.rc-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai>
References: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This reverts commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7.

Thanks for the report. I've dropped e6fe3ea04f01 from the 7.2, 6.18, 6.12
and 6.6 stable queues.

-- 
Thanks,
Sasha
