Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239649;
	b=jMcsCELK/z+UeEKirs0YoB8QtW+8nej1XvdDe7fdvYiHKJQ6EJbhh3fhW8EZaNtv/3aS
	 iRv9SX2xkIzIcWn1zxCc/RxoGRZ7Ash6kKYnN76eAanalOm5HUk2UzuFRqxLIIk5RLBKX
	 DVkgOCbU2s6mw0LqYmzwCkC8n7/m5ryR9nO2ivPgXmXBMn8JCr4uZORpExuOua0smCQWB
	 fXmS/3OxAlK+0ddQ6TJuNiLIFa6hjzlVXIbJtGkmY+CPiXzljyYRQTebP4SXiw4aqLEsa
	 hARf5Xpg22+AtPPJY6JftEJBXPPXjtgCY0tz1JbZkhLi6u/8JikqvuEsWjoos2griKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t6ElWT2v/Ff/yhK+DImxh/RN2lfektnNAA7wB6ztYCw=;
	b=wkA+dToeAhr1hcgM6Fzot3ryFWBlUwbTcChup5EKwSVJTAajgTCYnqGZxFfj+yNmDnQR
	 g9QXEkQdu+C22vq0bbxbvybmWZ9Bsgd9Rknhw97AeQ6IqMFwte//S1FpgN2jKRsZoiBtD
	 0B6JLef3Csi9EwzRmKdUxoBTFdRzaD12LHLsHKfLRxa/Tj4vg0s+IwNvbgi5NQmhbQUgW
	 Z7ksm9eJJjSDVhNN6XiGqmybhjxVxwlOQxm+M2+87yIDMEy5FY30yReA5Wp1howk8o3Kd
	 9YGZkcCO0ZIWON+6Zlaz+1uPVVLkGsIe0ekm9mybHiJv/VAaEGJOgy750V+2pdCt28w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkkLMyVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D583606EE9D
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkkLMyVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DC1F0089F;
	Mon,  9 Nov 2026 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239649;
	bh=t6ElWT2v/Ff/yhK+DImxh/RN2lfektnNAA7wB6ztYCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LkkLMyVXWWxdCwdmDNB/RJiPhvb6ZXdGaN/f1hSbozeNFBiFe2P3eZj2evNS3Ws9O
	 BQGWk6o5sTNvcZqTwHg0+TU65raLulavG1gAfauWrvuciGOEeUWhVHAtbXISsjyC0n
	 NPXyGB6ARDzMTkD76CzInzCl4GZis63hC0VMJAUIp2BA8RYzqt8ALsMs5RnnhwM18F
	 aEjTKhh4P8k43fRtjSNswCC74tvLH4qIikDzTMTtbcYTQfxsfgkUQzjZ6R4JtvknxM
	 6MVkCMZXsPd7zllCrFaxA3/Cdj6O69XdHt6Nf3z7uDILsuBMqd79bOyy3Q+RH4Rqfw
	 qiDBaRr9FB9SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Sean Baggaley <me@drinkybird.net>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 5.10.y 1/3] media: uvcvideo: Add autosuspend quirk for AVerMedia Live Gamer HD 2
Date: Mon,  9 Nov 2026 10:53:24 -0500
Message-ID: <2026-11-09-1-daily-reply-0042-uvc-autosuspend-5.15-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109094237.2534131-1-ribalda@chromium.org>
References: <20261109094237.2534131-1-ribalda@chromium.org>
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

Patch 1/3, b79251c881bb ("media: uvcvideo: Add autosuspend quirk for AVerMedia
Live Gamer HD 2"), is a no-op on 5.10, and on 5.15 as well (the 5.15.y 1/2 of
the other series), because uvc_probe() there calls usb_enable_autosuspend()
unconditionally. The UVC_QUIRK_DISABLE_AUTOSUSPEND check comes from
3de6df64f92d ("media: uvcvideo: Disable autosuspend for Insta360 Link"), which
does not cherry-pick to 5.15 or 5.10 (5.10 uses uvc_trace and the context is
missing).

Could you resend the 5.15.y and 5.10.y series with a backport of 3de6df64f92d
first? The 7.3 to 6.1 series are queued.

-- 
Thanks,
Sasha
