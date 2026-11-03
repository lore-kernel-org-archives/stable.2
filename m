Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702095;
	b=mtGe6vxKUaYFVmVN0SMcwE2hKEdDhHxqXwrjgONaHvqTABDNDD65Nb5SSJNctzyplCyr
	 9FUgR622qrjxS1U4CNDJri9xS/tfZJu/pwyFj+tvXD1i0Ie14ufwC1pnSrV9sHdDhsyAL
	 DR9rcS8TeWERjvmnMYqWX8FOGQTwxTo3jT7jXf4H+ES2RwoApk/gXtf8Nh+9ZLVI0vC+T
	 oMJ9ktYoGUka6NvS8oGne8riG9/9DaAKjTtlm1iQvU7JSUqPOIy6Us3NUzynbomok8z9l
	 MzPGi5c3mi5l1wmOEd4EX6KBjt3yjZHlLQcyQViYtVGl9yUCkOGQ89hTdEwK/OzaH0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702095;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=QY0lFI+x7+yAcrnSiO8G3skikb8sL1nui9pxnhLW5SIfV0m0N2BcrscLzG6GtJ2GihQP
	 8NIVxPTfY7tchYzywK7szTsH35VHRtbx6+oO9iiPwpDDfkT+nmCkFpJBykEqASglklZ6j
	 UpmS2nD0shFn7V06Ry3uxMGlPUjs8nVPqZ2HnYb+2ipAqbPEh/onfSq9wNC6QETxppvXw
	 nPLEqBNznvSJVOV2SKhK9dkjj88ihMxYMOClqbpu6uMK7pEorf20j/lb7OHg6Wknm1/Jn
	 +fA6cI1SUUqruqqnZBZogG7qlMNmxV6WMZfYIuJau3W/lvNzSpWmV+kr1TZPcENMSfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWTqbUNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90612607379C;
	Tue,  3 Nov 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWTqbUNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA01F00A15;
	Tue,  3 Nov 2026 10:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702095;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWTqbUNXtlq87uBXFvuxGVqBzCszxbq4IsgJQCNluWxJ7q8nseJC5XnT4yKNQrKkw
	 eH97iAr08WQ+7Mmi8MAy4mWZsAu2EitHj1NJQ8SaqK5TTo/EaXGDc8A/96lNBlb6ml
	 nFtXfMKPnvX6znfI40Ak+biIHmZ26IR/0hc8z6DCfkDpUAUcvL8y1EFZ2ztcdSUN4p
	 0iRaF1j7bTYXfj6Mr9kon0s9h1wdOouYI/VJIf9S1FfA6EyG2CZQ9iOlS9xGZGi2AN
	 dfUGoqARv5XGAePYkdA5zSRIbmhq083j9MpyTPgZ4l0a+OeeDaIdd7p+6qoA+AdLB2
	 JkJCYl0BkHfnA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: stmmac: drop the runtime PM reference on probe failure
Date: Tue, 03 Nov 2026 10:34:54 +0000
Message-ID: <179370209427.488859.7301348378104655949@kernel.org>
In-Reply-To: <20261103102858.1340765-1-vulab@iscas.ac.cn>
References: <20261103102858.1340765-1-vulab@iscas.ac.cn>
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
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
