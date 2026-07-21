Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF83EFD04
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595409; cv=none; b=W8207mfaiCMoiHXKeRTREI+DAbSwCTwmHkKnYf1W3d6GLMul3LXDXqFJKndXu1vwfV8Q+J4GOLDz/wCzibB/c8C764LleZSGsyTYjEEkdCqik42tFF6A53Y2I71vfTnSBFtIlgykJrwSzxiumIEcIzpECuiUQAT8Q1Z/75pUlTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595409; c=relaxed/simple;
	bh=j8JXvHy3aSzDpn9fWLDhZe49pudcxLfgLYWtq/jmz9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHUY2rKAfc5a6NsGu91N4Fw7D21hKFdN/gYKNAqRevM7J0+/BwOTRcG7DNLtIueGJimoEoaB66Fr/z+tWREKXF0/VXqJ9wp1CuT42rQBVLGg0LNRzg6tLVe+PqchseJVGwGBdTWteOH7oJaYex3Ea/BlAtkDy7rvxfkSsN+J7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFXszBTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFXszBTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8801F000E9;
	Tue, 21 Jul 2026 00:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595408;
	bh=HtPONjiymAmOUCi6yRoyACSvNErA+i4msgYDn4BMFd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFXszBTFo+QWWNEH2nyfOwHR1DocJHLcsdOM02KmKYSezLJfIe10LfV869XjpnBSE
	 xCSOGOYaA2+nqg8amCNy0qOxIlt9v2MKQccA618Dd+O994th1Q6uhKtNx77t+adKdN
	 gKDIgMFgVjAd2uL1XgJ1rwt4JeCCq2SYUThuW3zD3wmt/6ZPIZcnqgN25mU7LHCh9Y
	 KkuPLL8IX7fM8TNNmirnDSysb9+KZ3J6WPUTmmJHbcZhoMrZZYg+QkbRdlob4L7SP2
	 YEmiFoakIAVw8deKtSegx00rXLyIeN16nXnMf/WfGoz9CvenpxkwUXKT3eGe+7lMHF
	 PK2qHjpM2WKeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5.10.y] batman-adv: ensure minimal ethernet header on TX
Date: Mon, 20 Jul 2026 20:56:22 -0400
Message-ID: <20260720175500.0015-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720133205.385345-1-sven@narfation.org>
References: <20260720133205.385345-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The batadv_interface_tx() must therefore always check itself if enough data
> is available for the ethernet header and don't rely on min_header_len.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
