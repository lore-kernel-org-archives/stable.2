Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762281;
	b=buzl2u29pYRuqCmFNJJGLRNGovV79T5KN7La2NmWb20JdGqxjLaEWvZpgorrnAI7JbG3
	 eenH9i/Uhc2pI3zwJXgOabz+H3ZYTxgAKS7f1EPhjwLBvqcL6p+7bTxi+Ln3EFW84Zwke
	 2C1GNMdOJLOqzFg6IiLJj9Ag7HRp+bxfkCeFP/0N3WjJw2FBrSo01NSpR9Le61Psr8vLq
	 H0cKRSUQxyVIEjqV3HE8VPIZ4hHCizNgeZmwEoYEu3NlsL7TDmwC7NyrNhMsjck1JGiyM
	 G5ki1xk9SiJ9QZO4z/i5xX11HiDRcs2hxrDuJjl4eUy+ZbJHt3qoKnbeZdbryiDdjug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762281;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=J6V0Kz0XMpC5wJkQlSs9iIsGa6Tot3NeP2rg3wU4mYg=;
	b=xqu6cEWADUeqW2DLlONQe3Rlh9FTe4a0wZ/tH7Wp8hwDHA4nXPpsYPIXeIsoP8DPZRvw
	 5gktPf9ElSAFkfgX9Qh5WqEG1aRQ9Bx/erJwheiPYK6wJF1KiXKTB1XaMs6QzMDqvFLPt
	 j4B0JNLqJHGi0g/RHQzqTbUiBZH+UgI8HvIGiuPiJPBYfpEm5qKLnQm13iQBIwLRqe1Vk
	 +UwcGTjW6NFNAKJo444TWdLfhoKImJZvA2QIfEiZQRb3pPsupTsqHg9rImX1jwTnFKBMr
	 Tqom9pQh1hnF/RUgdj2V67VxWDVGTU30++0Nr4wl4WswxAhFMEgfvXEMR+bfVwd1s9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="hR/6g12X";
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA68606A31D;
	Sun, 15 Nov 2026 17:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA68606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hR/6g12X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=J6
	V0Kz0XMpC5wJkQlSs9iIsGa6Tot3NeP2rg3wU4mYg=; b=hR/6g12XkkFjrk/aoh
	7V/vYb0LTdmLsPVEY4FqXUexd13Y0Swxc12TEw5r0RXVnsOrflAwrmfNvNm7q7vR
	VlEdoVbVg2TXgJL1jTlwjw/81Wm9bzczCY9D1ps77txnl8RDYgv776BaVdWaGMyj
	WRacK4GJpKzsXJfsD6NoWsKQ0=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXb0L75flqS77DGA--.57717S2;
	Mon, 16 Nov 2026 01:03:55 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: reject non-PHY mdio devices in phy_connect()
Date: Mon, 16 Nov 2026 01:03:54 +0800
Message-ID: <20261115170354.944219-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <04781560-2b66-4ac2-9e7c-a786be43fc10@lunn.ch>
References: <20261115161811.941022-1-zihengw03@163.com> <06c3990a-8f2d-4e8c-931f-6ad77a79a84b@lunn.ch> <20261115164233.942709-1-zihengw03@163.com> <04781560-2b66-4ac2-9e7c-a786be43fc10@lunn.ch>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXb0L75flqS77DGA--.57717S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUTYhFUUUUU
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7hvQIWr55ftAkQAA3Y

On Sun, Nov 15, 2026 at 05:53PM +0100, Andrew Lunn wrote:
> You have to defend your own patch. Do you think it is worth having?

No. Without a real user hitting it, I don't think it is worth the
churn. Please drop it, and thanks for the review.

Ziheng

