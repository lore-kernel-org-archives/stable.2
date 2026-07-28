Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78C3DD862
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255026; cv=none; b=ZrwXIlHO895csqb9NGkxAmia21uWNR6qc8EAL3T4LBsIVgn+yUQWbir1NXg1YdyonDjz1kGM07WGtr16FSm5T3IoQPJo54fImsaz+1qxj3Y261svjuEmXcN6GrnTu9iEPn9lWEIY0Vt07O6NBh8tKwFZJd7aeo88se2lmb8C6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255026; c=relaxed/simple;
	bh=GCemi1HB/B1VNmIqHcU0H5H9tsJkghXS1zKjaJp2bT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMIHkG++L/0tJt00ZshCHR11JZuRF+qW/hYfbgwr/VJrGuo3Cv+cNbJKr+EH4ukYCzaCGFlUqTN6VFgpfRumaoCh2QRc5XEsEc2v6bldT4dUeZdNqwNlMlqay5h0SDZ/Iv9VfDZBsN2ypVFtjjL+ZHo42giYRevoFVQysP3aHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku2YtRGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku2YtRGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E91F000E9;
	Tue, 28 Jul 2026 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255024;
	bh=gcwVl3lN8qMnvvfE9NnLngP76raX3C+whG+7+Q4ea8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ku2YtRGfthwCNk35IaT8TtVDEjQFfpkrk+yec+FebjrVPebcmc2o/TpdCmKNA5eRa
	 WkaBbYX6nC9zf/l34pqgAxfR1pI1SUNK5nEKzrTtlhUAPflMDQ02lXIDlzaP0e/9ML
	 1MJ94tbC0pUa7SGaBpODfWhMoLUl1vyYBgvsgiPzTR4fKogPZC1WN/piw02+BhjwYe
	 horSx0qkuQ2YW/+ScuB6G+XLOxmR7Ae1ROI1HetenY+kJqbWT8nKiwAwzbCJ8SmEqK
	 qNtWLkw/R5ihV2m2y6zlIBg3+SgtdPv6f+anHoE6Sg7nNM9xldiF/WOqOV61syDemN
	 zXEJ/Ljyuc0CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:06 -0400
Message-ID: <20260728155654.stable-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728022514.1501006-1-zhangxincheng@ultrarisc.com>
References: <20260728022514.1501006-1-zhangxincheng@ultrarisc.com>
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

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
