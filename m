Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3D30C14C
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067501; cv=none; b=a+SBZqdzom3NEz8PCECaP8XNnlpKu3x7XzGKKKSab9nYf2phxN0pyI/zl2G8TUOSvTVAPaLv1/+7dagY6F9+lvS8Idt8BC6j2oZxfL0IB2oAHwb+ebM/hZ+JX+SPkECJQmlgp79Gs0xBYAAjfwP8P4PLLmu3y03WIVsHuoKV9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067501; c=relaxed/simple;
	bh=Hs6yqvmTchnLUx+8FuKqoTrH0Wu7kRC6zEE4v0vSR4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKDMPmIfcGtPPFuFc8XrxJt2x4zXJ5K6eBYnIO/wB4m/H32MHzu5RihzJYHcT/SQAuq9KIDz4na3xJeUn+FEX/4cPrT7X/qrKDwV4b4UeANc+aSb81M1uZn/ydhxVe2r7mmkJmfU/1Ej0aMlae5rgCo7oM4L/5JPWiOfmYBxZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc4zfDGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc4zfDGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9773C1F00A3E;
	Sun, 26 Jul 2026 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067500;
	bh=YicbYix//gBK6TqcVY8ZF5x5JTtQSsfQ/mb0W6rUmWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oc4zfDGw2IbrhlFE1H2IuadlEOngzdx0kRgl7GYHTwG6yHkeR8inohIZTrM5ULi6Q
	 4Zr2awnK6G1O0GmMAYUAbVdPeKFl6sC91N+9iN1xTpOtEFki8FZCE/LE9fTnoNm6Fl
	 Bv0trOyfYumk6qMw59Raqbz67/EHATwO9BTWUl5fH9DBpmL7yBj2DFBWexZz4pMpnC
	 qJK9D0MlyyjluwB38L2OsKp3nX1Uq5hZQwmJ52ikDQuBszzWINfBjhsHBGksaRPByi
	 OTcq491mg5ehe5x22qaU8yFGY6reffaY3TI3Txds76PqxCLq2Ger5dQHYGu8hOeFs0
	 MZVZoVRlaYxBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6.12.y 1/2] can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER
Date: Sun, 26 Jul 2026 08:04:42 -0400
Message-ID: <20260725192000.stable-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724103455.18012-1-socketcan@hartkopp.net>
References: <20260724103455.18012-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 20bab8b88baac140ca3701116e1d486c7f51e311 upstream.
>
> isotp_release() looked up the bound network device via dev_get_by_index()
> using the stored ifindex. During device unregistration the device is
> unlisted from the ifindex hash before the NETDEV_UNREGISTER notifier
> chain runs [...]

Queued for 6.12, 6.6, 6.1, 5.15, and 5.10, thanks.

-- 
Thanks,
Sasha
