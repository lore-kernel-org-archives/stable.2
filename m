Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798934;
	b=1blkmRMVpOQEOFWDcyw6Jq2Mml6BIGys8gtLUObFE1mK63sLqyo2MLCdxCELh41R2xpo
	 PfelN6gnaCEpAlJ4tySyIruBjeaO12hU6Mm0zoAtYgne36PpRBlpiyfGQ2ZRRuzjV3oJ/
	 HxcTlRuzwAlUO/NVB/6dE61eEfe54U2bShloEdwpPbiHEKsc7WpsbbqYnK8E+ThLWfB77
	 HQjEVT3Qp9BpiOFB8vWvS8o68LBTQ6AQ9mIKsNdhJC5ulODmsSSuNwSg2fuSJi3pm14F9
	 SAeX+7/wFesB7KLB0Fm1lSiz6G130vytQLmfZCFM6lq/sNZBBFpK4AdKzlDtfYCvdUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798934;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JmeBKnM5EkB+JVMoe/M6Hb5kobFiHhZOn7PpQ72bZh0=;
	b=AJD8b8AkSGKcJFtbPEMLYOdGLdZKMMY69alvnoxLSQRfst5KXNeYzRSBeEoHo5Edm06d
	 32rCjoJrUzzAZ/TzoxISf6Ejm0tWsvlWfXf0UAnNnvk4CLerGghCVskjy5SQfX1/3awTy
	 fjhFKsHkkfKZSTsVWvaBlxNwgLUQVuWUHUt+tgB93AHjKPJ7j7MCaIEnMgsaG6B4R2glu
	 gpzAzqiiGwAHBfbWNOrCLD20UNE06SK/79deFgCZTl7Su6V0Ga/6jIPWfXSuIkiXIzzZH
	 UI/CKJg1HA3c1KHYUne+zDmIAMsOJYJhLuk150NXXm1a4xFLskkp02ycgtb1JK/QL8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BICnhE9D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03418606A335;
	Fri, 27 Nov 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BICnhE9D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AA71F00927;
	Fri, 27 Nov 2026 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798933;
	bh=JmeBKnM5EkB+JVMoe/M6Hb5kobFiHhZOn7PpQ72bZh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BICnhE9DMRpOrTSvT2WYPdrkSUHdg2GTorvjgb9yi5DexdMmLPeNpzriwqgkqJv7M
	 UF8FXb0xdpo2svvYz6sP/DbQgGPoOn7dlom7tPxLRfJBvsEfMuSFPt663hM6qzYc5R
	 o7OgtTJhFUv1WutV2qbCAOWjZua6/8STiY0Wh00ZsWdmjq8YXmPrOmojHp1qCuzFEZ
	 QDDSmwrJvI3tvLOXmRZMMk+fVmhZDhn3l6/kXBJ0u2Uvg68VBTnj3QzwPDdK57MuCk
	 G5pEnJAr3qRmUcpW2C8wSXxdBRdukkA3P3Iy2KhowbLVCQgt4QM6TWL+aQQyj5IFKD
	 bUZt5h0C2pl3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Vaganov <petrvaganoff@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.12] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Fri, 27 Nov 2026 12:01:11 -0500
Message-ID: <2026-11-26-1-daily-reply-0023@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125093035.224140-1-petrvaganoff@gmail.com>
References: <20261125093035.224140-1-petrvaganoff@gmail.com>
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

> This fixes not checking if skb really contains an SCO header otherwise
> the code may attempt to access some uninitilized/invalid memory past the
> valid skb->data.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
