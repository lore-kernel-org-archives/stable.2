Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104535;
	b=ghF8Hxijy0AcybZi4obJO/Fl1iYH/G2tJpp1TtO0VZzE1nAT8nXQIEuhgwX4Ix440VW9
	 asuxF3AB3qQXRikpM4F6DGYLS9+ohp3xZUhKlAjuhXk1CbQ4euBTvJT32c3oV+yuuEusu
	 SFpCLhKObtTKF83oydliIzpQTkz+POK6mEM0Gq1ClaonNqKBl6sWLP0hn4WZ5YqOQdkJy
	 Wj6hI+n2dYNume2YfQJhZu4VBSfArKF6oiPmL8iVTt8Fj7GT4WhJh7AL9ddoa+V8UHXfn
	 7XEKMlwj0yMZDGBRMyDKHGg+j2qBiSIxSZeu3YsaTnlbdSM6k9Pn6Eo5Oe8edKQCRcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104535;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Aid4JLRkfzPe5XEtSJRE865XphMBK/uPR/qKoNyWNEo=;
	b=1KYG1t7L7lS2eeD/WOp3Jj2HPwENDYkx0ncLX7/m0ohdr9XZRxIIuM+6w4q8FyI+b2Y2
	 evouRPuACR1XMhwyst53C7G1r+Nu/O/2He4tRYTWevCBt/5Mv27iNAAEcQcUy0odhSA3C
	 BGp114b4UZ0LRnj5xXDdvGWuSZPODDx4Bxkk0UoHmne3iieoZ3HdCtbUjeyKuFdzUgDPU
	 7ID6r/caKjguBcuKrPNjev/z8/sjq7LDOnBL4jLd90VBpyBMpGOYHgsu7KHV/g6IVSbEZ
	 1cIjbPPBcRLQb1Il7+pEplArSyjy8NEqD18fuTCAHNeVPbJbyn0L033oJI9hygIoggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPv34hLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3E60A2616
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPv34hLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C3F1F000CA;
	Thu, 19 Nov 2026 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104535;
	bh=Aid4JLRkfzPe5XEtSJRE865XphMBK/uPR/qKoNyWNEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BPv34hLsR+PqFOYap5vTwpe9+SbGBv/VTWQfwQiWCXAWS6JAjRRUTlv9qL4cJriYx
	 KHHtGZ2SlcVMuixkqoyob5q9E5CYbYUluZzFWFlX1JoHEVSinBb3loJuJg8qTECqJI
	 CJeK0gJlW/PsLpOQKDlUd8xnxNnbcuMJHexUTr5Y5co7lmlE5xZVd6Ryy3mBfklfCU
	 NWGOHjmT8nmPVZc04yrBO7QHOKxvhoiUdjEd2rH59YaMp7p4JqigM8HfTdTlys2TxM
	 UZ3pIbV63oNkpMGZZ2jgDyBGNAXpj9CXzztJKALOBwvdVDNQk0CB3m/W3vAJ8AcUVC
	 qBEMDu2MU4WsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	adrian.hunter@intel.com,
	Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@kernel.org
Subject: Re: [PATCH 5.15.y-stable] i3c: master: Fix recursive locking during device registration
Date: Thu, 19 Nov 2026 11:08:22 -0500
Message-ID: <2026-11-19-1-daily-reply-0020@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118105254.2780893-1-claudiu.beznea@kernel.org>
References: <20261118105254.2780893-1-claudiu.beznea@kernel.org>
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

> commit 456f832e5fc26fbfd3b8200fd4553eee520cc377 upstream.

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
