Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700617;
	b=rh10NslWP1BCm9O360AJw/GTnaBlH0csesZAJJb5DD/Q5cJGdIAH6mHbiqwopgLQVeQp
	 E/VMGtQ6k2O0Ja9HIuXs4nkuIP1HcN6iyUY29i7Ji6c0ZtZKg0K6JVvXnGiEdW5oR0Ybw
	 Fu895882FMzcc0Gv5EEVtWHJQejWlVY3EcPagqXCUdPfYaeqSM9E2GNPZ0A0nQfkdYW+b
	 LsNdPnvsnzDW2IpMxU89roNjlyRWuQ3RZEULEstuDqKGZ5fdCka0JDt+oCqPWSK5NqgHu
	 lZ8Osen1k8Xk70JZE5ROkufD2l3AjG7WGWDe/zZzt3ARa918/Fgd8HZ0NWu7XHB1oqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700617;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=P3PNQ3gLqMD5pdAVtkAuwIc2miHLMpcTnqqAZno27+ZSWQfFFwFtpgoxGCBeUgIGu23u
	 m3PIFbray2UniD0fWXsKKayu6WwpwvA1QTFz99Nzlsuhr3kusuvfWKnKLCHUSTE8aedCH
	 HqhpwULOGYZsS+BxonliJLF2dU9zk37dGzpIH0vCXaQmr7MFzIZ4dgpo97mIWeVnsoc8k
	 7MdnJSebEZRxfaLr9kSpZ6thDXz2XwQIVFkxY5/rQyTT9INMGtr4+pAIXDR5gqA9I3ixn
	 h7ppGpmWYzkPyn9cVCUdHg0FKn+tPhynXIpAnD0vrw2PY553fNAimaqzcLHVuRtd6LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZUIArnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5665C608363A;
	Tue,  3 Nov 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZUIArnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491371F00A1B;
	Tue,  3 Nov 2026 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700617;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZUIArnY5+hUTUWcnXtLxF8u0oA+xiayejYX5MIG0WfCavOhWOs9kITZFHKvqYxHq
	 mWYZEvditWgCZMizICpen7ipc5+tYwTC8g1g7K9Pt6MrB8RA6qZzPAcborUGJBHZ+w
	 SgYzPxFeST8sYgu2WMww9lwxhrgU3QKQ304k+tbHDGNSVKFEbWBQDUtvO+sfyQWLGu
	 9XmvlJigcxVnGIZ8J/jKFLKecy+kDQBR4nT4/wmx0ZibGtPpVcUnjWAmHMqPP9ypiY
	 6swSTDEAVMK1nmogPLAj9V7eE6Z6RBYkuf4Ny44L+9PoEAxtA6QSNJM96wiMuS9wLz
	 fs93If4Qw+H0Q==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ice: release the VF reference in the switchdev trust path
Date: Tue, 03 Nov 2026 10:10:15 +0000
Message-ID: <179370061582.488859.13591313498954037306@kernel.org>
In-Reply-To: <20261103100530.1309907-1-vulab@iscas.ac.cn>
References: <20261103100530.1309907-1-vulab@iscas.ac.cn>
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
