Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4928462
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531553; cv=none; b=dmQFepkFmx8008KUTwmFAlX3ytVNKmZbzBvFNQFEtwbrRglFVgCr9p8FauFh0j/guMfd8eVmc0lvu0DJ7gzZajmRPntbcBKjcYJTlHONg8XLrU7KY2OQ4rDajxmc6jcPi3Mc4WzeMfLvb9iWCng3HUQfcNeijbvCAbTNvoTMRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531553; c=relaxed/simple;
	bh=Skr5uB6+9unmwr27Hg8mIVMx81Td8QVwj0cFCOTMowM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRtIb4zr5hb0PUj8H76JCags6pZoYcHFRUbG8yKTmqecGBsCk/inRMtC/1gp1bwYVWLdYSvuzq5SOfWaZvr6JhzfL4d6rRN4qgk3QXPCQD9LA2vrq9QESLgVsPuo2tu22pZcQ4eG7uj+vC3BzgVuLonIoA3RCd00hHY2E2YJwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVkCecKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVkCecKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6771F00899;
	Thu,  4 Jun 2026 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531552;
	bh=QElHnGptHvThNr+gz3f90rSDdabt9zXLeli01lmg3Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVkCecKRswJ4sp0M+t1eYNLbsDpITjnfa93mRyCWdv/2lPm8+2WO9WsQ3aD/32A61
	 MyLKqnGX1GMAUvwajAY4WZgofjhDgC+FoF0vGZKFZ+bZ1Tfm7M2/o9E0qgExQ4Ymp/
	 HXvCsfBKHqxZEjUGCsdwkFzh9DT54a13gJYmH5bKqDxDsRzZWY39OAZYE1r/FAoqZo
	 Ia6PY0Wbp6R0O8bzfpHzO0tcA6b1OtV/uRwb1v2JZsArRm31HqfYoodwobDvImHTAo
	 yS46SzdmIn1OHcizLw1CYpX1rcQU6Ohrb0OnrXmoFPQp9xygfR3WuDeZCAj/o1G4AL
	 nU5AC0DBC4Emw==
From: Sasha Levin <sashal@kernel.org>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Xiangyu Chen <xiangyu.chen@windriver.com>
Subject: Re: [PATCH 6.6.y 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
Date: Wed,  3 Jun 2026 20:05:38 -0400
Message-ID: <20260603210831.item003b@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
References: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 6.6.y 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
> [PATCH 6.6.y 2/2] arm64: io: Extract user memory type in ioremap_prot()
> (CVE-2026-23346)

Both queued for 6.6.y, thanks.

-- 
Thanks,
Sasha
