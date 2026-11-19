Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104522;
	b=AYIh9P/oprXirPUBI1nqByvyhLHcsWR/XYyecaoGqs0KCKyDfHJQgVbTJSTs9Kp7XJ0p
	 ujxL0SV/Ty3Rnp+VsnchimuWsEdCGS1cGGSQ99twgYJd8PC93Lrjh4CeuzKXLehxD/MEp
	 SCcWaReJ5Q2Mta1FUXRUy+wNqpRVweXy5YQpIX09THQWprbQ49+CFnJqBWtQeXkvebfUu
	 h5zT/PhqQchGQt/zir6AwgaBWTxqYPWT4PcTT4tVRPuXPXwEUUH8zfCkc+DQvTpev9yMf
	 bpV7vzGkI0hKoU/Ep7ZcsGXLXBuALmIMna19OMb6sEI77AQZogSHSx8sm40CidGslRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104522;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CXnbkdO4aY5GHoiQwlccvfq+Y8f57UXp9WVPUz2TKC4=;
	b=KTOKyfR2BsCx8o85seky4Sa80FRVgpy45bCn3E6zgw5AmY6NMa/+Tgi2AkLux0eDC0Au
	 kdour+iVrePmhZuoHezfKwFCDNrrIOx9GhV4cyQ/sNJ2gNm67pT+g8/zgl39xBi0i80Zz
	 B8/BRHq+b0di0HiQTbzRDvqcTRfFh9za51W0kEYushVMdg3Znn2GjHeJukXJKLJ2R6MXs
	 ak3dTy74klaxcHjBqSqQtdBc8iRVkPUJk/XvawRA8wxSPkrXK7uz8HsrFXi/DT4Kr8tPQ
	 h/V/iO5z6LWhjZ0+QltQeuX+oZsHeJzLaum1VbndTI5Khb+avLgWZ36bPLdUajGzOfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+jvg3g9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B660A2603;
	Thu, 19 Nov 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+jvg3g9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF811F000C4;
	Thu, 19 Nov 2026 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104521;
	bh=CXnbkdO4aY5GHoiQwlccvfq+Y8f57UXp9WVPUz2TKC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+jvg3g9YaBjnxJ+DK6vdJLkEO6Dop4KLg27tmEKridRTuP1MPtWtaHRoSABLLnEd
	 Qnc0GWP41RH/eHJn61+73pdcJQYJu4UA5CoXn4FFta6bPSViQQJlPBofiXl2nx+n3w
	 Kgz24yOr7N4nEvCsJ8EgajaTP+n58bCgF3BJuJWL0p1GqL27hbHjh8GS8ZDhGCcsnl
	 kISKl7nShs4YmSJtbtOsYBspLNh3i1ZzVCJaJwVTmGU10EAtLjLnnmxgupShP+Pu4T
	 DUasHbanV8BmrCNR/b6YKrFk9rkGaE7/50+NZwsUt96OJenG2FL76aIgebrj70EXMD
	 DGp9nu1Kzf0og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	=?utf-8?b?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Subject: Re: [PATCH 6.12.y / 6.6.y] Backport request: 802eef5afb18 ("bpf: Fix memory access flags in helper prototypes", CVE-2026-45903)
Date: Thu, 19 Nov 2026 11:08:09 -0500
Message-ID: <2026-11-19-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAMcAce_2g8TiPUZVkexmxS3A3YoAFy5Tm_87nXUGWW=z+gW37w@mail.gmail.com>
References: <CAMcAce_2g8TiPUZVkexmxS3A3YoAFy5Tm_87nXUGWW=z+gW37w@mail.gmail.com>
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

> Please consider backporting upstream commit:
>
>   802eef5afb1865bc5536a5302c068ba2215a1f72 ("bpf: Fix memory access
> flags in helper prototypes")
>
> (assigned CVE-2026-45903) to linux-6.12.y and linux-6.6.y.

Queued for 6.12 and 6.6, thanks. I also queued its two sibling bpf fixes there.

-- 
Thanks,
Sasha
