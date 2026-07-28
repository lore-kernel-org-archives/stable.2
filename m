Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0E45D5D8
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255027; cv=none; b=DkcaQ+b9i3n/ZI20/6NZPNMdjXCebRybpjBZBnhvThzbXitf5GHJkmzTRSDfCVnTjtWV7oMs4nh0W1CHCLQWInuQffsitbtn85AwbD+PbsfkDsaRRYLy/MwWcZ9RnoEEh9L9PzS6PI6vBEZWEd8S7hZsVgw12vpo7EjCHmdQTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255027; c=relaxed/simple;
	bh=xo5fYs7g6pnIbhNjWD5vV59rNJulbioIHGnNSpG8ebc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHnLZUyC+dXmqIC3M/2pxI9jLNX+aLvWIha3XpNWy1skLSeU1xxdLk1K4RKphxrde3pp3a8IsyCndaCgIzNuejkkd0f/ajUzVOrIeSOBRIdAs8+HPPZRPSOfCW3mshwUIPkevFVAOIPS5H512o1r9m53hpnVQaGKSm5TcqEMlvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca3nyxi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca3nyxi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365D71F00A3E;
	Tue, 28 Jul 2026 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255025;
	bh=e9qInOZYU2VwlJ43G2d5f25Vj4BQemoUwW89Y77uL4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ca3nyxi2G2rrZsrRZiZVVi2siduI0j9lbRzXsxQ3ROYWpx/1P1org3XvQ0rXD6KWm
	 Y4OILhHlhJY51nkmaWO7iFSnjH7jjaCBi7tjKx3y+XUzyxTqxmsOa8ZOdRT72P43ST
	 yNf0fgCYZJhssbB6wA+3J+8bQJIh73cSzgIGevkOWFcujVtJWhr6lF30Tb+0x58JS1
	 Hso8Qhl3oxDKnSLvsKHyf+LJQzYMX4evYZjZRct6QMswO6LO/9vpV5eVyl163cpG0Z
	 4RdmHpo0IGSQxD5xSdBsDJ8luq1DnU6Pj6+2oPtxesmmzurn7W6TForuxgZ7VVfMsn
	 VTY0OwqGCEVRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.10.y] usb: xhci-pci: Limit VIA VL805 DMA addressing to 36 bits
Date: Tue, 28 Jul 2026 12:10:07 -0400
Message-ID: <20260728155654.stable-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728015000.1460189-1-zhangxincheng@ultrarisc.com>
References: <20260728015000.1460189-1-zhangxincheng@ultrarisc.com>
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

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
