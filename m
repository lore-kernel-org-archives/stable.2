Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3745DF6E
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255024; cv=none; b=PENtsa9v0BZ39UaeBf/8RmJAD4uhFgd3xJPVm4UUudZMhYSK0g9m9hxMOimvnMZLjqW69owF1xzV4GOPoU14+yGeHjC/UdKvLpGKlfJFE0vEYRHFlvHs6JjN+oR8MOiBpZzw6KJXa/X3oYNq72GzDU45yLuY3JG5xylepvllnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255024; c=relaxed/simple;
	bh=AAporOiro98CeaGT1I3JOdp3hwUo9zIiJi8E/V6brW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF6F/T9k7BxVu66rQed22gWC3pPY3LBZP9256/CYQHZsDu332PuDNc1ejk4p3hPzPvtj+tOJ7edBLpxA9bL2CkiUSz4Vht7iptCPJjHyFmPCYjv7FZ5MPwnZFn7/tKPYb3kOXRo9nEedPCA8KaWFejj7pH9wiT/NWFdetsfysvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiNLF1PQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiNLF1PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C121F00A3E;
	Tue, 28 Jul 2026 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255023;
	bh=MEBRR0vs8MSIUTjV9CzyfBrmrH/MZnA3k+bPNTZsTWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jiNLF1PQ2JHg+qGIc4o+rA4dMso2yucZ2d52Fn6HwX3ACfyuPpq73raIJ1UeIsXR8
	 6pjV1GIMmK24lNAK8G1fY121RHcycj+gOF9Mn+mGxcn7LBregcKKsyjn2j8PEZJAk7
	 XTjVNRGsU3IHzmtpL8fLOYdcKcMBuQA/KflwMrIWXj1noCoKnKr9YqvAKPsWTP6UMU
	 Rf0AYeTS5jmk/ZLeEiKn2FcCnmT8YsT1cRqRv+O6Y1IGfaSZ1IEAOPeeISXS/tLaJ/
	 my2n+Dt0J45YFOXzGD5N2BDgwbYwqC1ozq0nAhgHEpZ7MAYqoot1VWgQ8+1bU0UbBo
	 yNC/sBX26/Bzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:04 -0400
Message-ID: <20260728155654.stable-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728054100.1812186-1-zhangxincheng@ultrarisc.com>
References: <20260728054100.1812186-1-zhangxincheng@ultrarisc.com>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
