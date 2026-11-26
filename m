Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659495;
	b=UmUUR4BzBIiJJRGwKhbdOgP/hRR78/QK8Mu6aPU2JT2qEQa67hWEK1PVH2NU+uORu51a
	 2W26myZc1LNKZylSKUcdC0z7otlHOZXelqglWBZG3kxlWfYBSIOr99Te0PnPynuIlkl4k
	 jUADSoZquKbeJnRNpCw3VaEHQ58zZamnfLjMIhqRKhCDbI/5j9aoeDzPW6BMvYOpIPSEg
	 YY/VcseNKXhCBXtP/8bmtUblhmet7FlkWYryPEaRwNm4I3IhTNho8bAmroRDiULjI5B5e
	 c4+dDz9ig9c3Wd/+b9jJ9zu+q/brO0tINYYv47tV64wNaGSbn8lXf6BCEh6WJO+zT3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	b=X4ycQ/Rjq8wxCJYr+g0KT3oowqr5n7mV3Y5OOMwxY3+rOhDlMfirdZpsqhxcp/+ygf27
	 AiK10PG3gMabV2/67D0AJykec+onx3fqqtqsP5dKNUmXEKIgTE1QLC/tubPdMdekQUZJ8
	 r3+PbmF/AiHLMHYRq+5wHKsRPNQ4Zuph/e+jhqCEHlMVKeqU9XcRPyAful3EU8trJtOir
	 oWNh76teCtqPRT3AXwGNrtLNigFg1nlELmQY1xJhhgJt/H5xAW5iqpNqucSmVuu4cbI/Z
	 C6eZ83f6nztpljwggSfYVsoYstusNeBZQKgT4/YnqN3H92SecTuXNWTjeG9C0+JT46g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLuArq7D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC80606A321;
	Thu, 26 Nov 2026 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLuArq7D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538801F000C6;
	Thu, 26 Nov 2026 02:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659495;
	bh=Ld9+YyGfs/W/wYUchYl+G0tuTdeNOsMW/DqiAiz5bT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLuArq7DazoSFkz0wELCN9Gom4sLBmCEA0yU6bRpnWEOD2IMn59lFATXBhFXbmfZK
	 hYqW/Kzvj4kk9x9vVwRc+Mn9VVaE0sKzBXkv2O12V25abpJim3DS19sHkPRv9c6sWY
	 s2ufk1BlJfqzPObmGynVCwWqiEBvBkhG7ZEWkiB/W02oTEn4FahATQKhWCWkdoBI/Q
	 6RexlwPcOAqPCEdGQ/YoMhsfawN0BGdJ5ppjrikm0VGiket0DK2GPZbMXmH+RickFt
	 gKega6aYM7j0fzVddKkwtkS9zeMqq2ZZUhSxuUvrbvfiKOf1RUVS0bf15xNIkWRpNP
	 qIEJdNerr7faw==
From: netdev-bot+sinfo@kernel.org
To: guohongyu <guohongyu@cmss.chinamobile.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter
 async handler
Date: Thu, 26 Nov 2026 02:18:13 +0000
Message-ID: <179565949384.3294.6218603099017752049@kernel.org>
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
