Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239631;
	b=YA9mWC7dIr+3IVLWrqz01Eub+JIEcOYYN92ZzS6ArFod+veD13Kbt/S+152ZDpV5vQxB
	 445AHpJpF1++9Sif9n6puGuUWkWK0tMUXhLW5u3RLVPVQTT0Z1U9azNGaQLppQBcJRbpT
	 uMV23m/xPnxC5plnL/ePrtsDpuM3iX0UQmIvTO0bn92dWDwMgDMOGBTczOjogo+Txyvkb
	 cW6kbY6aJy4QTIzew5D+1iQaJGyIboJsYhc7aNjd1rkyn7uoEl6XvZwgmX+SEnl8eVIid
	 W4P5x223D+46Bwb0EqXintb3njwyvzubN8P5GSRXGydd0EprV7dySyhmkPHWvXH/tjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239631;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sgAa05Uzj9W6DybLaxrSFsRhr4qa4X21X/23x0PlB+k=;
	b=W2c1tG4lgSrkIvy8/lbHdx+TJEYm9mFsblqHXRj0/9PLPNuWo5JVMlk7XmeOW76ObEFg
	 1mKPsOt7PcXIVqrpzTq1ehcElULk0PcsYyrnMtEj9oALuHBkBzP37bgyxpi3LS2HYT3zs
	 iiPHR4p1VucawzMWg9y3HJR7efWTqet7gfFnmWKhBC+weEO0Jvq4uMSbnheD6egrD+PLi
	 M+tgMEndRtJtyB3cPlRkxZRvd7LnDCEitCIuNcQD8WpUd4XFGebaI/kcwWLrhzaZoZbns
	 8Ut2rFr+GtI/6ibXtuh6YJ8jcVOZ59zbOFG//Hf/ULmRrG7nadzBipY7bZENJf6PwTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNXQKNM9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BA606EE95
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNXQKNM9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE01F008A2;
	Mon,  9 Nov 2026 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239631;
	bh=sgAa05Uzj9W6DybLaxrSFsRhr4qa4X21X/23x0PlB+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bNXQKNM9ePgNGLFaE190sGiurM9uhyqwKimuJ0Z15pWhnwW0ssnE793WKbLukxgOl
	 aljR2VgKjE43/PnQ2V9lRB82HLnRSphffeQJXIjm3lkxvFHxDOx6yoUKy/pL1jNWvk
	 qkAmb7UU4n3TtPbCH8WXUy8bf6NRHWR3Vo+gijnja1YyVyfyHBBVYfKuOiy3sKLjlI
	 hCDvsRPKW5ZXO4oezFghnJ0O1ZsdxKlVJ8Pn7wnTpmPs7WxtVyPl5+fPmmIruVzhzl
	 xqRFssZ0shg0oN/6NmCa+FlF/VjH0juY5NprPVUSExw4uu3fHdp5d3oCmakuz5Le1W
	 LT0wdJSXkJXHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 7.3.y 1/2] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 10:53:07 -0500
Message-ID: <2026-11-09-1-daily-reply-0025-uvc-gc515-7.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109092707.2326885-1-ribalda@chromium.org>
References: <20261109092707.2326885-1-ribalda@chromium.org>
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

Queued the series for 7.3, thanks.

-- 
Thanks,
Sasha
