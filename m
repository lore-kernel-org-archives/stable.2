Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798946;
	b=FKRtZcjCPkvoVRaMhk6GvwIJ2JReEJfStJQIgjrQr2OVRrAwdG7a31bbGANPjLuox/Sp
	 yteVv/JFS10ae1vnyeAvVaqajMPUgi8NIXCeBkcohK2Edz9PGm4GEMgs2/oNJXSBz04cf
	 ok5rpAHiFMpk0QjujzguiszYWvcSKYRlxFgOqmzAAUXU+JR+2430IbWe6AtNhF13Pphqd
	 KXiN+MrU0bqTCgxcGNMKtKaplh2VlqKbN+IFZKLJR/XIHVpZP9SfeBMCP1hP6IM3fvqFV
	 uDhognaKNdkjd971WlzgffawY1h5Mq9m9p8rsQ0Lulyjxkm76pJY20metnl+GHS6s4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798946;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IZTo/mwZb4dZgzaOLgEEGpl25UQU8GxYF0PFzcr3j+s=;
	b=M3H8u+mVAhcyUMjYCThpsg6NLAsMHK97WVz1R9KBKtWd1fYazMWfb5LqZlPg2gmPGJjX
	 AgfRAcpotb8x0CCpwBsswQ4A4nefZnXkKZ8/Gma2cZ3Xc+Vw4A78u4g4XJMMp1NuGj3H7
	 vI7BxtD/Se1Zv/5cNSZhiVQ26eXQAfBq6nnYp2hP4LLBJ0v89X6uKYAYIfujShQwLnjVB
	 Qs0VWonKjK9bOhzRjHnfHismrhswaKxdYrtwfpYDwKOurvL0YlbJliWRIUOt/NZqsbFsC
	 c9Cb1Db3NxD2hDGy8ZA0xHZbBqd5DAZFyO3oJRCsLr9dOvZ5wlqVPT28LAmdIGYKC6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcWPo0Ux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1B606A329;
	Fri, 27 Nov 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcWPo0Ux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD011F0089C;
	Fri, 27 Nov 2026 17:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798945;
	bh=IZTo/mwZb4dZgzaOLgEEGpl25UQU8GxYF0PFzcr3j+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VcWPo0Uxx5RkqFr8l7No6hlqEP/JoDWImgE0O9BNhVY/CAJNM4nIgvZ2J7PIgVI4X
	 KJU9z8Zo+e2OCVqYgZuIDuMtSavNrkTy42Ric1QMMO/SUUbsXUNbZIurM/HpjMX+8w
	 WDNIq5WRtC+EYyTXQ9Pml8XdEmopvO1JKvRNI5L7lB6Ly6J5U8aaHrQ4t4q1s2ME/o
	 Lctv0DNek5M0fIjDhT6Ral+4/MPe8reotRXL6C3e+Rln9hunXLHnaga4/rY+TgXaeo
	 qPtHkBRY6z0h9YxKgAwCMahzeUJcjxy8LszrswblsWnQEtpRDxeghDitlbUkpWwXxq
	 aNoaC+KowKpoQ==
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
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.6] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
Date: Fri, 27 Nov 2026 12:01:18 -0500
Message-ID: <2026-11-26-1-daily-reply-0030@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125093708.227125-1-petrvaganoff@gmail.com>
References: <20261125093708.227125-1-petrvaganoff@gmail.com>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
