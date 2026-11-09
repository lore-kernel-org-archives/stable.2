Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239632;
	b=OuJs2eDotBDJPzYnfFEk+5VHAfDr4NDfuBa1Nz1/soTSKsTc6lMA3o9X0gYJuaaGjueP
	 +ESprLSxhefxvyBXQH4DA6cVwon4ogcca4nfK7qqy5vRltDK+LPV3cTls+wOpOFy4la3U
	 vyrOs57bPdbqByF1BhIzAU9NyTCAGTBphynN4po5uXCn9rZ+UY54AaCkSkovp9A/xObGb
	 HrG9TUInQA2GIaN/gZI/WIlBsijXdTNLoaCFVasefmLLyveJGhU3Aw2cc7md5VqrFTCNc
	 XyF1eUWe0i15hCRCie9pu2hxKbXaUo8bGxlnsMi8QSyeK+I6i3dtecQ7OCofz1bjpvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jYByMLrk/QtBf5nOjqX6WqLKythw8JVgf3I5soofIso=;
	b=AyUnqOq2j67tIN0LgZEmZ5LvhBjYzHAdfecv9efyYt7syIA/pzvDtCjfNuKA92FIbhBf
	 E9RqxN97keED4eRqjRnZyhOoOfldoIpkpupWHGiuVLkF7rRMD82ZhiRiv4AEfZzSWCKf6
	 4EmAdOCeRzkmDH8W3hby3CeTWkDdRL4Ne6jI4KAzCBJM1JUPDNKwPbF/5tMLErTikHBmI
	 ywQbw0uwDbyP+nFtgTEEiPFvaTf4LRS7mSDIoiLgJj/ArKiaCtJsxGpBxNnJ61S/WKjdI
	 DTHCrl6QvLss5P+vW/zy5nEjAVyR3spjGglRhIGSfoyzORN6WHZwni8UX8rMpXjTkEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXEbVpSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEF6606EE99
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXEbVpSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991811F0089F;
	Mon,  9 Nov 2026 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239632;
	bh=jYByMLrk/QtBf5nOjqX6WqLKythw8JVgf3I5soofIso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXEbVpSBKfG22PCoBW39ChduzZCyrj1UDDbUEPWQu1vGxgef5BitmPdmwqF6wbfTW
	 6kAGel1Mljuax35/1FkVYK6OL53RoNmcO6HG/jAVK+ILZru8EHniBdLpKBhNuzTphQ
	 8iSueTZOdjItTSzXMuBcMPXh4t0AthWjD/knTN5PYB4GsZnit+EE4oCdQ+dccklyvQ
	 41YFCj/hy31WGdRGHge95E8+7/7vLfEuSLc68FG+tkf8f2Gy/H4j/tUIBWPDKZCJNB
	 83h+pRuOtP+ANGcJtwd8h3BlFUqANMxOVNk46SGoGnkVWYwQ7fZj/J1Q1lpaJ3GvLV
	 YHOYmGESbHjeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 10:53:08 -0500
Message-ID: <2026-11-09-1-daily-reply-0026-uvc-gc515-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109092551.2315410-1-ribalda@chromium.org>
References: <20261109092551.2315410-1-ribalda@chromium.org>
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

> media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
