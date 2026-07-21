Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5048C8B9;
	Tue, 21 Jul 2026 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635728; cv=none; b=oWQc3bixmbmCpzjG3a/3FkHYnMyj+3Wn1kp/euuSaeZrxHsyf+ounAH+G2ukwDoCYE/3cPyLYZOv1tAqWJagvxf3LKpS9gy8pKfgvzVqeyRlzICOTMbCtKkuwvhJd5LvGwRhDUIgfC50vO3TpNKz3u6pN/Bd9xCqFusMsYHNGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635728; c=relaxed/simple;
	bh=Tf0zYWJ/uLxYB7lgixjGpDYjmJjPHBrCHuGby0hXYsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2hUQyLuntdIgmMyhpWXTrqKtfnRfrPnCFFFoAcGcD53irLrteNJ5NYPS+u4E0Z5ho4Bbq3NmDQC+H2SJ2qIVTF/31yPCzESgpLIS17tO7/hsdbBY/NjmXfzGmCmOUX+vUMaq2RfW4v8ERD6/bPfGNjdCZzvV8mME5yuz/xNDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnCdchBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnCdchBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5841F000E9;
	Tue, 21 Jul 2026 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635726;
	bh=xQoqwdSxXNJ+1VgR6813nBbdXnTsQ0GyT0E58RS4UA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnCdchBu/Uj815SxlPF6YjA0tjgMLyPXdUZ5MrRLOBK24LB4AmGDL9I7xHWwB9u/N
	 7ohw/spen9uSkIEvFm4xgwDAF+4llJMpiLGCOd1RZhfRfvBxceXJqb1HClnyzPxoAO
	 0goSCW6kP+kOT6PACkJzrZwe0l+ZDP0fq8kSlCqb2LvHnJ7usHUeEke5C3q5GBtcrn
	 VGr+5ggfyFBqOm+5zxeuma+O/VHnkSu34dWuAlIg/Xd+vFusnC8KxzAyPJSxEfXpOA
	 jeiSCsSCReBpN2lqeghvFszlYNhUQXf1V8IEcvCkI5CtGBWk2SrAVs9Dc6eSeREXYS
	 JrlWOv2VkL+Mg==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Subject: Re: Patch "net: ethernet: oa_tc6: Interrupt is active low, level triggered." has been added to the 7.1-stable tree
Date: Tue, 21 Jul 2026 08:08:37 -0400
Message-ID: <20260721120236.100003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DM5PR02MB3369AD2C28DE0ADB1A57326A83C32@DM5PR02MB3369.namprd02.prod.outlook.com>
References: <20260720111749.364311-1-sashal@kernel.org> <DM5PR02MB3369AD2C28DE0ADB1A57326A83C32@DM5PR02MB3369.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jul 20, 2026 at 06:31:26PM +0000, Selvamani Rajagopal wrote:
>There is a follow up patch that is in review. In my view, it is better to wait for this to be merged
>before taking the patch to stable repo.

Dropped from the 7.1, 6.18, and 6.12 queues. We'll requeue it together
with the fix series once it lands upstream, thanks.

-- 
Thanks,
Sasha
