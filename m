Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214007;
	b=MnTdRbGVp0fXYsb/ak8run0HskRPp6471rW2VzBMQcZ7Jhg9qVRszaKg6iY6pu7ECgSM
	 eK2By6ujZyJ0BrP8fOC99/kqcfo1351DRhsLDBCbslNMj8jKzwnETPgc5+jFur7z7pDWA
	 e05BR7LO8nTk9lHyx0fhbCLGR8o/pxr19u6vA1vaBsZN/m5i2EsFXsnSj6O62dnEpXGI7
	 h/x0malZbnNevMIPDaqeZ1ddYs1Y9jrBk983IFqhh82v5gSU84QnM1hmjkw+i1k1Vk3wd
	 AgSn2dPHV+aNMXuaz3KItgXX0YsRqAU8hpi3BFwqifBfPyNqUpNAhDG5G1uNMaX0PUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ol7FKfusB4tFAUQx45a/yRdaJGgULjBuaFt/SytYTok=;
	b=LsWV6yyh/RHl89czlo2hcXLzLcCNiGo6u8NUY9dqrztSyGZbb+1BWHJWRuaY2USy6ZoP
	 GyfUcNuCqaKmhSnOlrWOppyCGWwvdpjgzJrvoBn4t5w7VBbtHbo2eBvBAwz6pHlRp+Q3F
	 puF12GzO/GZcHX59h/455JHjSGot2j3y+ETqO8Wn7LLPoedF+W+z2dvN6wacQdbaGtC0T
	 SJEU9MkJR6uKpj8rTpA3Aa4yE2zY9x9j4IY254OlQoR8VmzDB9iKLpwMcGhwQNQQp024K
	 8Udtwh7GeIqj0znQvyQZtNarARTExo4PCuGPWu4OnXZGXpbgRGsvHEDhbeVnrkwbB2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1G6ehDf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342F606A32A;
	Wed, 28 Oct 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1G6ehDf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D8F1F031E2;
	Wed, 28 Oct 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214006;
	bh=ol7FKfusB4tFAUQx45a/yRdaJGgULjBuaFt/SytYTok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1G6ehDfXx9bRbWmBH/C5z6BTE7uuear7WOBZ7oV3L1LMQR9AQdrpriKH0pUfWg6v
	 uBpNzoJbL0UXMLm8gPWwOW6G8ILuwz9KP1+XzBbSjLnjn8nGCA2Rjr6u4Yr5fR09eW
	 j6xRqW0VGihndRihgsuliSDPfAB6oMt/E/G+mkRDOcqeI+uYPr9XMWS/YRLozPJ2k/
	 QhJFjNBpUm2qd71+BN1qzWDLnS6mEQxU4hNxd+2SNXjGPOAX+XI93Ntze8VYLW+cRL
	 OXe1y71SiY3c7hAChuCAjUGYGoMsrs/tipx3XOlEK5+y4V/c4VYgbprts8CkJ6eOdY
	 KQYARC+2i98JA==
From: Sasha Levin <sashal@kernel.org>
To: Mikkel Sejdelin <mikkel.sejdelin@proton.me>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and hangs when tiny_power_button is built as a module
Date: Wed, 28 Oct 2026 15:00:02 -0400
Message-ID: <20261028-rc-reply-0001-tiny-power-button-f4203@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dyJyEj-TY1YtRVdDYPD4xnYF_aIP78z9wliSc3251tj6aZEZxux0c81AiZAFPpZvbg6rjgqivtHTFfY29YHTS9WZmw569IbyVF0NPVTxqrA=@proton.me>
References: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me> <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org> <dyJyEj-TY1YtRVdDYPD4xnYF_aIP78z9wliSc3251tj6aZEZxux0c81AiZAFPpZvbg6rjgqivtHTFfY29YHTS9WZmw569IbyVF0NPVTxqrA=@proton.me>
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

On Wed, Oct 28, 2026 at 09:15:22 +0000, Mikkel Sejdelin wrote:
> Now that ab06eb920401 is queued for 6.18 again [1], could f4203ec64e11
> be queued with it?

Yes. ab06eb920401 stays queued for 6.18, and f4203ec64e11 ("ACPI:
tiny-power-button: Convert the driver to a platform one") is now queued
for 6.18 after it.

> Tested-by: Mikkel Sejdelin <mikkel.sejdelin@proton.me>

Thanks for testing this.

Your stack also included Ting-Han's 2/3 and 3/3. f234fdaae1ca stays
queued, and I added its upstream follow-ups edfaa81d5da5 and
7617cc05df28 as well, so the nested-resource regression (arm-cmn) that
7617cc05df28 fixed upstream does not come along.

-- 
Thanks,
Sasha
