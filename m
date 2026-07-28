Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA533DB625
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255025; cv=none; b=l1eZBbQOhB60StZpLSEToP/RZ6l5wDb4UG1kBcDmqFwzhaUWAMiQEHbCbR6GGFGI/CegbutvX56JV+5DTN9qByJeUVLwCXsljcXBqmGUg89C4y14B0+yilS+kQZkhWmSBy7Ezk8MEnF3+CfNZVBV641ptITnsc+mUltBTvYLqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255025; c=relaxed/simple;
	bh=WrRPa0C8+pVJy+7/w5vO/i/BfyCpzwbdKeUemHcn+Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlBKojMmrq0IGoYUho1M+0tIaHx/uBNZEa/ww+RtjNPT0eQ2TGedhmVzZ0ONYQAo4xVZb4x4V27ywVnYcKD21wXseaY3WM4PyPH7MkaonVGIBRnX7Sid3Z+ZHSqWuIkb0iOVvMI4jMaYhAYRn/pPr3RApL163wNMGOJKGGUXJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1d7t2dd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1d7t2dd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB5E1F00A3D;
	Tue, 28 Jul 2026 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255024;
	bh=+0QmtG/VgrwedcW4POdgqrp7AnlOBX8bPubftYiE2K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L1d7t2ddY1gQKZBGDCgeDLQPh/OYEbJ4kw/x/+hl9A2NJPmD3+p7F35Q+bSyYLBL9
	 vUEVWMu+s4D60hYkrC3FEikc9xAWV7caoJY9u8rTlfiCj46r2V33LIy0INGsdH7fVt
	 HZdyV1sZiZd/YFyzR407ELxVrmTFK7hz52kJEdUophegRggdDznBxIA4B10fBXh7Ar
	 uk6f5tKw4jSDfSVxr2j6B7lVcV3uCddXi4UfX4zV5WSsQjLJ7/IuaVRsvhKecgw8UR
	 hP3WxlRUkkzVAphrRELUp9uzALSY42Yl7oM5SCAE8/cPoLwpiE0ofWF2fRb2Jwxwt9
	 Wap/n1DgRWdkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:05 -0400
Message-ID: <20260728155654.stable-0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728030116.1607312-1-zhangxincheng@ultrarisc.com>
References: <20260728030116.1607312-1-zhangxincheng@ultrarisc.com>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
