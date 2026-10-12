Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C7306D2A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817163; cv=none; b=hLDUb7NC+PYpGg3pIi5ZJOIeNROqvL4IGYUfeohyhGgQEJaFS7pdFwyrzOQbjlnpMZu5gyNWbtQM82QtViVaog2up7NSMKIrl8jPNW8bzlP7nhkBRKSypC8aQ/CMV2PDeMnSnTGaEBrSMyzeJV5K57Gay+972QKf8J/7pxi8P4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817163; c=relaxed/simple;
	bh=pKJlqFdUHIyXieb4giX8WNO8NGIuxj2iYMv8sn5l6jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT5JkXtH+gfW9CnEFUeKII6cmT7/NHYlUM9X1Hnfd95tw7MbhbhCCMgh5DeCqQDiGH1VRD+l617wowwzG0AvZ4MKzCNQ5NWL02rERJjuD476xKqbxxfaeK55f1ji2zmK8aunLO2AyvBSVMx1Ajo3Fl6lwTJzVqBvYvWVWhFYAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDHNJD+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDHNJD+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2591F0089E;
	Mon, 12 Oct 2026 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791817162;
	bh=RScKGMZQJsHeOFy4A1Gin+MCmehpgKBlz5G518gERwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDHNJD+rejGzAqA8Ldu1AWipv7uqY6Xzcfnax7tcDV4X4Stsxbdl/DPS8hVXcyDtL
	 To5NQdRf5Q1R5e0HA0mHUOHn/0vfEw0aPjtkRlfm9dc/32+jkQ4i0NbDyeMRZzSxjA
	 NMzIWlh54ebAIN6xPT1UuphXdwzS0yKYjuQ/w2DYw9Nd1eM/rhnL2G7p0FexSCfp8x
	 hLAdhSSriUvnIfJjyCIAJkJDgEXJU5Lnmwf1lw0MxI6CmNd7fq9csrcVgLuPQG5USv
	 gKzFmBlZemBtR05Vce+6Co/gpOMmONpaun0eqdBAiApcalFXUvS/RRPqI5Kze71yAj
	 3nVsqOzJ27ECQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Subject: Re: [PATCH 6.6.y] iio: light: Drop ROHM BU27034
Date: Mon, 12 Oct 2026 10:59:18 -0400
Message-ID: <2026-10-12-1-daily-reply-0003-iio-rohm-bu27034-drop-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <asy4uRsy_Wgr3v1V@mva-rohm>
References: <asy4uRsy_Wgr3v1V@mva-rohm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If you really need support for the BU27034ANUC on Linux v6.6, you should
> be able to do the backporting from never kernels. In any case, the
> driver that was included in v6.6 is NOT working so it is better to be
> dropped.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
