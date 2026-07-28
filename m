Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63145DF56
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255023; cv=none; b=gXzDrZBlZyOQA5c2AKCsg4lEVWPyoleezDEdIAdbvIM+YOebFu7HMTr+nzzCR4s/m974Vd+SThOAAAAGR0woHAuy8hkqJBwjUF2/AUX0ngDuUjfB857gKq8ieVSyHf9CV9QjSPvNuMEevYEafR3AfOPf4u4whusNxhPMpaNDRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255023; c=relaxed/simple;
	bh=qJ7uLrnazyBsTWNwTY1WNEDAlkaGNWcH3wUlNJU4QhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6kqEM0u984NyrpoZOUoFqDx+jZ1Flu1fXULVgxcN0Tfra9aQEy0I/bFtzeKuEEQlf09vOxLD07cRnZAFkxGdJ4ieUg4D5UEoRVCAUA9KjGHrV71AnCBGw2wtg2AGl7ZZlae6EDEUGUl/FcLs5mJ4WbxhmQLPCfecUDHSpoc1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ligb4QR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ligb4QR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D691F00A3A;
	Tue, 28 Jul 2026 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255022;
	bh=r/FUKGwjPWDuURr6yFwtXFBAf3yCDBXC+vOlNExgprk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ligb4QR1x7GzCpDYGeOzN+KXT+3qsUpoMMa/gqsYIFPI1YcwUKrx7e+gGCX8oDTfF
	 95iVsKOnxeEt7qh9dIYLrHH+M1AbPAu3MzLRTn0uv9aUz0jThTOzzknUXijljiEsxo
	 ZVhEOYUGYLES1SahkeCNSQ2EHxG7iiJcH6VNFVh25DhT/TQtPmLbzsdDsDkG4nd6PP
	 r8k+JykdNbA5Xkke6wQ6Ko2N8bbX+erpXo9zAeZnuU+hjkMuPUxg09l+n1a9oAFhRX
	 T0WkWPrmRGqmtQ2cpo9Wkvdh4juJ3Ox94nQFDnVIhzy+gHpjqDDZqn/YM+Z5QaehAP
	 MSdsjDMW+5IYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:03 -0400
Message-ID: <20260728155654.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728054210.1814218-1-zhangxincheng@ultrarisc.com>
References: <20260728054210.1814218-1-zhangxincheng@ultrarisc.com>
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

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
