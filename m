Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984445D5FC
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255022; cv=none; b=t/Id44RFGnbyXhVyqYZaXaMRCywXu0inkr/UPVbjmI2KcUE6OUp93/CXm04fwfYlSOdyme07q8NNhojW+85bKGMagkz/W5JvaSg50aHkdF5jPLDcy4wS+O6weNQ7XK34cD/5eCkI5k92LpO3CYEQrKlhXXx1R3gRrUPnQxqrdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255022; c=relaxed/simple;
	bh=GMZOr5l24+0mkLS+M3tFwI+2m+Hp/DmOkYIx9whlKUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHetjezDha5SXT7t32iUWdb1aZvuAo7/rdoDatV5Fn+YuqF9+oiQVUQziRjVI/9NYiK3dAqcxRedDpY9+qYcI3iPTNj8CB5fjE3aJM0KTv1JKFLF8EeLE/MCzXHHxxq62snrYY3JxqlksnwEQo871p1YJwjCGf4+4V6Bpc5rtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPYtUJsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPYtUJsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1F61F00A3D;
	Tue, 28 Jul 2026 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255021;
	bh=iIwMj/Xbn8s9IaReRM5/xxOf4nTQUArlXYwhdkrEONQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lPYtUJsVWkoVPrwwQNyblHRPbbVurq5oTRWBjUHy6q1SLj9eh+Xkk7T6meYGZvtv7
	 IdGOy/OycFXvYVaPN57FizIDMtBB4SdnxGDwb4NObIEbGWQiNcQdDm4A5sKud9EsBN
	 4di0eH6HBywr5ReZU5SwwP8+4dElgRPLx1u3eH6bleZ0j/DAkfCsawhGEEoLJ1zut9
	 CA/Sd3SSEkeHiie5eHnimk085cnOZLrTVCec6bSD/BlBgenHUfRWBkYeBy2b6HXt+s
	 ohmmuLLtVC8ykz1HdBZvXmj7sflxuJbaSg0X/0XzCfhprwL+q/Lcsbe8fgh9mxrleI
	 Ta11Gb2GUAguA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:02 -0400
Message-ID: <20260728155654.stable-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728054341.1816656-1-zhangxincheng@ultrarisc.com>
References: <20260728054341.1816656-1-zhangxincheng@ultrarisc.com>
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

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
