Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702023;
	b=RB0NiAZWH5jqOWAW4d8MySeLNOZ5fsthVHs328+LWPksDyeMIGg9E2Lft7/txZODT47C
	 LiGW/83fQQfCCJjWDJmp6AHzHqQCAGYTVQ7dXrjMRv93CqS8FrpmKTdhqm39mR0EjPrl+
	 T+FHoWpkqqOtOrL7TNxl/imrPPM+nTnhiG3y5+hQV3Q8r9a4X5T/Tw+t2bZEnfZbB8TTJ
	 gr6ZoDzxH+SNQq5Si3S0At3e6q8tMVeIu/xVyRp35WwqOsoeIZDcWZrQXRlNczJccaEoW
	 rmFO+LpIeAj7u3bgLx/P5D37GtrSLHTDqn2rmGztIKoa2fF+LwZIsHl66ApW5uBCUgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702023;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=XthYKv5JJo/XuVZg8yXcQBmZMRsRfe3r/EEbdumF5eesUFt8ofAQGFNulcNtH6/iVBjV
	 TA3IrxLadaOodkl+iyMWKLm81C3FJQuqcq+JF6G0pTFacap0uG7wdoVUMrocqCRfjmhga
	 ZvRVJMNo/X/hvas/jfCHPiR0MT9kD+Tb7EracDhdOzO6pFcb0LPpMYdXIUIRuV0+bjIfl
	 Dp3rYgZcEZtBvIQbTZ9rk3r6lw7csAqvESGW593B72i+igRfv8BB8UNA8OejB3SvhnBmU
	 8enh5bDZcy5XliXPF88U5bmyfcSD7F+ishhATk375RuetazyVA2zEHiPwyJGz6o/1Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl8RpG7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19860711DB;
	Tue,  3 Nov 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hl8RpG7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73521F000C1;
	Tue,  3 Nov 2026 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702022;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hl8RpG7dy1JZkCn8QnvhXvT2E6xVDnzHCLVxJVE30tTyP2stsVfsa8Fg8CT3IYv1N
	 ffEaW0yJ+pnvoD+cIL9U/GmdKn6XAr9XYvoZavqM2/gS4p6xGapmQBYlwDm5WfBoWe
	 CMlGJh5VXnqkCbA0axuwk/Iu5yhRG9CL7pae3Kf9fD8EK40apjqwK3LR1fc12V5o47
	 eAH7NZ3pHT/l7p3FtSWPFCw8xC96JAbtRdNLV54nJmPw6oMzM39KQZPCM24h+Mbt8P
	 4Gui91zosdeEGzKJPhQY5Fy5Zd57HTDYLelbK5WuIMX7R9KlirjBc0uXMFslx9G1BD
	 VAvyDO/TYZO+Q==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core_hwmon: unregister the hwmon device on event
 ops failure
Date: Tue, 03 Nov 2026 10:33:41 +0000
Message-ID: <179370202138.488859.12570263240763499288@kernel.org>
In-Reply-To: <20261103102850.1340455-1-vulab@iscas.ac.cn>
References: <20261103102850.1340455-1-vulab@iscas.ac.cn>
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
