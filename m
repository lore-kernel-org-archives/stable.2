Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988112;
	b=aawZMiPrUucEJpUZ/qf8MlQF/joPXWYjQLcTmniQtOHg+mcPxOMEY1soHW6iakmX4AEZ
	 zb3/d2Ne6O53VOlJmao3eWzZi6Q9JiZEoNNzevtIYoS7pnwCXWDHP5i/clScskQZdYYd9
	 efiCGlLlv9pgAv5eRJNZOk/Neji+rW8T6hykR0Xllpxb51GCsDG+/TPEJGyxJfFrA4NOY
	 qRF5WN4ExIWPc6sxh+o1leYo6O5k3facDKiE2ktR8M2ToyffqgdDkw6m0ZapmSG/W0tU5
	 fsa1xzsoBxazTGHE6VEKmirT3oo4nIf6wZOHn/7W+Les8CPA1V3ENaRzkDgJ3jIVBtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	b=fgpXi2an8Li6fMce+/TUNj4nx7OA/XSu9LD60St8vcqHaIkCsHe2Yypak6FfgPYLnkaP
	 36Q6YHIulFcKNSjpGLw2LojeR+RTsVod9OEFX/u1t2qnwk4azKrA029t27t0qS5qG3YsJ
	 ZwoNGrUPJFk2XELTxZI/nE2Naa6K9CNmxaYsUNEZFU9x1IvBI58f8dcTwjb2X/lNlpEgp
	 yc7vtqvZy5rqniqZJvZQ08F0eiH1EVyICHudsa5WhQzOqq6DWOT3e5sE6+g9cfLTNOYQ2
	 qn9Lj6TTWZeJoIeklbtjohtPEkiosvc2pCjX8qm/o5ER0RWYeKBZfy7wqUT/rrPKxsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUUyOPVR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9041606A325;
	Wed, 18 Nov 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUUyOPVR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA2F1F000C4;
	Wed, 18 Nov 2026 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988112;
	bh=Uwqp7Bz8a5D3/B2xkBHbhP2Bh4hQYQFs0RxyAqY1Gn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YUUyOPVRat2Zhm8Z8rvJjjQAzYllaE0HfjcF4x9mPrturX7w5IQOAieMahfF9MCCF
	 tABRouP03sjIcVMCEtF1W7g3PdikQ+hkf1xypHAWmerjDt6byIDu5Sxr69BiVRXOII
	 Zf2V4aczJenSQLXWuDzF15TRKWsF96nTuXu++50sV0r4mOMCrE/OvyHB4/7R5e2pVv
	 sNPsgJLrUwm4ERfXujqiiG/WfCOAsO4bD7nAjUT7xRrd/wkUjK4QqNayL0mQLyyJfy
	 uuDO1Tx3ZEWNCpuM7RnfSyU8TjXbUSb2NOdZ9I20dAyKU4gkfj/fKeaBfPIX8xhPPS
	 z9xHuLXKfngkA==
From: netdev-bot+sinfo@kernel.org
To: Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] ice: Avoid tracing bridge ports after initialization failure
Date: Wed, 18 Nov 2026 07:48:31 +0000
Message-ID: <179498811103.3291.4517029211414094145@kernel.org>
In-Reply-To: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
References: <20261118074324.1583964-1-a.kazinsky@ideco.ru>
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
