Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127E346AC5;
	Mon,  5 Oct 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208289; cv=none; b=dVZHGqc8mcZiy/mnqyaJHCZc3hJoWoPa/PKkD7VNtMx9WgrUXNorkSOQ1PKnOd9/9YmQgV6b5fMFdUX//OHArH3LFCCpWaw9I/N1NrIHEEKbc9YuvkwSBvn4LnLVMpmKRQghvMCT+3q88i2Q2JNP0W/Tz71aF6duCxcfFaT5llo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208289; c=relaxed/simple;
	bh=mN90OI7LQisdtZf0vXX9FJ/XRJxRubnn4VC3ERDeVrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjUmr2pjYjV1ZOaBjPMbtoOv7RAhnKJM35B4U0AcLe/BLHHEfouZNQUIIIYsb3ke5Kfci3BbdXnG0SGI76KC6m/PjnYQjWIDWjtewrl5c46p6sQRPSAXi8Z0zZw8s4OznTQ8EvG+8vY5n2N7WQdIVA7M58SQbAKbupo+0JQJszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUM/aN9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUM/aN9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EE51F00893;
	Mon,  5 Oct 2026 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208288;
	bh=0PVrZwefmUCqrmwGV9/IUrficqUnd7AWeUAWQCPFnnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FUM/aN9cfoL/P6d17IMALk+W5LiyUCezSUEjtTjGkYLG/4QYax761mBDOsuw+OMlu
	 6twX/RfOesLcJWlEq4VGFI0QxeNvvf+zGE0VTAH7o0cwRTilha4O1kU+POgrR/V9mq
	 iLJoGdjKo/WxJHAj4NM1I+NduAD0v2VErOAeQTu7JuSNxex7h75qvGCFfy+Xkyw+E3
	 jki8whWHo1P9K0XHou0h19lFmRmbN2uZlNcM30G29+dz9MSTH/p0N5s2ozCNWUaPg+
	 70KIPvwggAY0l21LwQlijaMe/aSbzVl5h/5pZ8aFO43Vyl7YfWpd0ywkuJgY1DFOkk
	 ZK5lM3VNSdktg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan McDowell <noodles@meta.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Mon,  5 Oct 2026 09:50:27 -0400
Message-ID: <2026-10-05-1-daily-reply-0006-tpm-get-random-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005075934.151106-1-jarkko@kernel.org>
References: <20261005075934.151106-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Fix this by checking the response length against 'offset', which
> already includes the skipped parameter size field.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
