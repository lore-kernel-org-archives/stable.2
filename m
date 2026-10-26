Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003186;
	b=QsUI8hlg3Xc4jNGvOzApOQM6CFn4fm8vX6eZwgy+AXP5Yd8/IoFcv1LBjTTOD2Vo8cD9
	 eSYz2ur0jtOTw1m0ZuoQEr+Jm0BpNYPo62nKIFB29P5j1FAC6FEQsPN2a4/uTdZ3u6sEh
	 BIBA0kAU0x4T2rt+BQ6poubu6yODN/P7wedY7evAyyZNjkDTlXBIGAvcaWcioQU1owK9v
	 kESPzGfRlbKTfwo2qlrwKjDHJ3UPj3mzUt5xyNQ+FDFu0rL/kfmjbzfZ6uPPJJeQMTBy0
	 v3ER/ZYjMbtEK8k8xmeDsdaJQqcpL6HzBvdUcfu7D48muXuiVkHg83GGUlLHmJW4vNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003186;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=RAR/RUlYSy43M5HA75RJ7C18834o3KkEI8KfeDcLRYxFoelRc8UosIaN5ij3OrHeK/xg
	 acujOxgG4IU2NFZGuXT0h0HgulkIOaA96hEpL6+IzEbL8vySxNSAgFh8x825wjCqE9n3T
	 Q4E5t5BauNscKDdfVcfyba6i/MTKw72QB7XJ7nljcpWywnqbjV9Eny6NnHZqsalWW+R+j
	 QszwgsnCe65VjQmvI6iUNuxukDIkCflot0RVoNT2odS3z+Ddy2S2/OW0XfjNmsjP+hj+U
	 La4RWrT3r6xarkfSmpy9UGCTI68QzLe+1SIY+zwj6sYYCAcUfMVo/j6+qP4y7UM4B6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU1Labve;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F9606A31A;
	Mon, 26 Oct 2026 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU1Labve
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D311F01825;
	Mon, 26 Oct 2026 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793003185;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eU1LabveWxUpu10bxtC05VOu2VYoKVI2Yn3uddQRjePl89FglRmm+u0MUlteyBVPE
	 jejzzMYSaEiBeyqOKV8ukt7gVsinRonOwHpk+94GjuAry+dhuPlF2/XAyRM//rtl86
	 GGg7IIhXVJAkjk7rDQggsRuWfRMJI8x8ROrsCHS927Yiuh6pqeiVaUtbaGLzsIe82A
	 5ukeE4AP2GeqtZ5HjD/KCqNw8jglkQdBCoBPuz4dzAVyaRPlyxa80A7fy6RfytNJIZ
	 RSb/ZYqlO2Y9hAVkqKXEPEfTsKeXjvnctuHxoX9NfM/q8HY8HMdTfXiGZEB8QPgtpM
	 ZuDtA4Piqm6ig==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] ixgbe: reserve TX timestamp after skb preparation
Date: Mon, 26 Oct 2026 08:26:24 +0000
Message-ID: <179300318428.3327.13029076428746317520@kernel.org>
In-Reply-To: <20261026082035.335770-1-edumazet@kernel.org>
References: <20261026082035.335770-1-edumazet@kernel.org>
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
