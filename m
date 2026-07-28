Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01263D9DAD
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255021; cv=none; b=kwfyfPE0OmtswLejwYILmdVi4bNB7k5+RJpGLVk0ivEdneAhn0ws1EkY2NL/3k0YGikSMsCNAmwE37W+RWgsTCC7rU9tl85gUiKOigLQRzy4Ojk2p9Cfxp8nC/3VuB5RP5Siumv75tCWCvoqARFVQrIZssd56/4vMoTVWwejiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255021; c=relaxed/simple;
	bh=ZCpmUgluMzaaLH6JMRKOL8lChTuInOfj9SAU3pgC8v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li8kWtA1OiByZOKR25UyxQXMV+hAgcW88p3vRi7RRwKdd7SSLGWUam4diK1yA8Hsbmv/B68DvaxgKXpIFHUAb0f/WYNr5M1JczAuBkyz3gPM2SEgei/pUThkwEBXlWGIZ68n0m0i8Jjj25Jn7Ug6jD+O2RVJUaFuaGDPv3aA3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIcYSKSK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIcYSKSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF71F00A3E;
	Tue, 28 Jul 2026 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255020;
	bh=TKyXJFW2yYm6QznrxNqecbl+Dl6rSjts9LJGYReHwBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FIcYSKSKZBKo7ge/HLe/DDTiDTUnq0Y8n9WWrT7jgIiLGkMIgYyE+D4ae7TPOblUl
	 doN7d8c24r+1aCofNbzO2O961UVT+os1x/zMFaitxKwU1EWlDY/W2e880FM3vNyUPr
	 LcFrQLhFZI5SuVaiH/dMHCQyCw6UPohOe0rorOZeqSJr1bw42JtQpxy2aLGb5BEIec
	 +ouJuxail6G3RPdaFZ0rGytnNr+sf/w13HUs42eE3oj9o52ws5NBP5+6qUyrn8gGjn
	 7KHKaolLnToiVlczKOp/F8gvvp+oe+JzrWP2No2zDPWFgMvWtvDupKjAFnmEqOoO6/
	 sHqi1fuqeIiYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7.1.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:01 -0400
Message-ID: <20260728155654.stable-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728054607.1821712-1-zhangxincheng@ultrarisc.com>
References: <20260728054607.1821712-1-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The VIA VL805/806 xHCI controller advertises AC64, but fails to handle
> DMA addresses at or above 0x1000000000. On systems with large amounts of
> RAM, this can cause USB device failures when the controller is given DMA
> addresses beyond its usable address width.

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
