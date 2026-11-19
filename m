Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057428;
	b=aBzaXGilrLYe66zrq8dr7hLwixc3EXPQCbEgvbzwY038ZAE6HxKaKr5npAIXp+t2wuqB
	 d4JQFBsH0y2tHSoCXRtIL8wXKR3Iy5fXbUY/9HS2ut1t0TuLBNDTCXNST4LRUi+PsY0St
	 GpYLBpDcwtgKosp55mq/FdfHkPFHXdVo4SDY95+/fgEmtBBQ8E4kyma2Fsi+SRnpNO8A5
	 bJ+cDqZtJVQcWTOlGUAKF61RsqJrwqOs39CdzEZjTK2D7UoMfKTPz0xPIKHYyo3Kzs25Y
	 YXtyfFV/KhxvO9wRX2a/KlRnTrJWwQ9V7S5X/j5TtMxxMm/Ec4wIl2h42zQdX80YobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=vJE0TgAs1AZ60So9szEOWlYGAIAbzKKa8mE68+E6eakTfhuZYRZrLh+VX3TlODUcV4Uv
	 M6pgmAzYubhZCKkNEHK0vrnBm7OWQExkaAFtymVClDmvzAEJ3wCOLs3WgF4WT19WDlpHw
	 PGCbySO6F+PkW2+fQPUkHA6AUzbCDVn8ZHJIt/4T0N1mFgi3DSrdoJhdM0u8Luyomh+VQ
	 WFHIMbrbfjwyF60jJMXrpxKG0MYNGfdt0MPTBZEtnwY7Gg3LD0zNTzDxPG/mTqaKXhJ/3
	 mStLqgUKKDxfwz8YUmNPMdT+3ADRUq36v6BTJDdW4/Fy6bhr+/ECHVthE50RE5hYDUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khuYAM1S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075B60A2614;
	Thu, 19 Nov 2026 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khuYAM1S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DED81F000C4;
	Thu, 19 Nov 2026 03:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795057427;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=khuYAM1SB1MSNkcMQI7BSTZBt0U/y0IYKRYdsnRhbe4u4RUn2emPzePXzgK/y3lQ5
	 gQuc4Zrj5SiC1U/XdFXf8ztglaytcd2ByD5qGNOh24Dg0YmrMfcFt4Q3QQSwvcUXs3
	 I83eJqN48zxj0I2S21HRsIMAt8EwVkp+X3SuMKYdGNIS8qKfRGzkcBf0FQ2OMtwwuV
	 umAV7sbrYo423JJQjDegL/88aPTD5v8jL7P3alIkPbq3/tQ7QeDXCE9kXVS9jSkQU/
	 Fd+go8SN1c0qVEkSwRKP/xQIOW0/Pu1P0c/XUyixhSsROWAHZO8yBx45C14P4L4wnL
	 ItbncKdS0vjRg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Guan <guanwentao@uniontech.com>
Cc: edumazet@google.com, ncardwell@google.com, kuba@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, melotti@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] tcp: cancel cloned request timers without waiting
Date: Thu, 19 Nov 2026 03:03:46 +0000
Message-ID: <179505742682.3291.16254736450582630386@kernel.org>
In-Reply-To:
 <0907415D86226AEA+20261119025619.3485277-2-guanwentao@uniontech.com>
References:
 <0907415D86226AEA+20261119025619.3485277-2-guanwentao@uniontech.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
