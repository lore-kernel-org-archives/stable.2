Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700573;
	b=r2mm2q6o4ytrU4r422Cqcb3aeAtDp93r+DCq2DJBllBrcn7ZWTVmqSk4AMd6C428eQoJ
	 J+NXTjSr/EtVRlLmBmOFzYbzSJth+18uIvco9xcy1p1ElHwPJ7Yby4oMDXAhrhuFqQshk
	 Qg382GuEuxpAhgHmYZk6DD4DHWKQur9bhllSmJWNW8hSIWusy3qp8zDBBXavLs3RQpfjj
	 sWBBreus1NYQYur3nySQETUrfqcpzd3hfip++Veae6HJ+uGyO0b73bT7HsTSEGR7G2opW
	 GZarqeUfih3uepB9sjUSWzyNStdm4H9I4QPB2WG3YcGu6CRTm81ORKpExggNXL65Wmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=um9+7W8/M8sVxqOfKLJAz9lmUGomYdDXhcdRMIFIuc2vzTv79L5YqBUqkr5V/iz4A37T
	 +SoxQ73kM6gv1G1Jl8e/r/35oSMr7BAleAQYOg+GNN/y+3XNudK47h3xbqqzhUwp+qtFt
	 4RJUxGLWjb249calmPsNQi+vC0Xaqa9eLt84lm3nMLDP4y2zCSbhcsUic8O6XwAamrf0i
	 BzkQUb5MJcWBETKehENa6OxpB1pGjCoEFmLr+buXe9SXVuqN+arTwXo2liaB40EkwHhzm
	 dUPofTikIZpGQA80wjjKGxT4QA4+p2BstZ9yq33dsWQVLfT7TDSLoiBoSeAARy2s2ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsLDJQqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02D606FAFD;
	Tue,  3 Nov 2026 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsLDJQqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2305D1F000C1;
	Tue,  3 Nov 2026 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700572;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsLDJQqqHcT+5ktQAFKn+kt7wNOoeQjyg5PNDJPoJVbs523eNj5+gcTODMB5vmG3F
	 SuBq/0yYXRdjjuI0LeuElVfeijPsLaPXroM7+eFxAmGD9nROvEQotlzSYiClNWDLZj
	 UWiFnfkr8bvUQCAuGeCc+4juQk12vQdw++QvpkD3nQXgAIndKXY1DbwiU8siw26oxP
	 HnxC5LuGKGIWA500O4a0ueRjAcXmfXMclpLZxBKI68uOCWl2HXJC/Wa8/1XWu2ZwZ/
	 2N4DlPRxDWbo5PRD+NZfU7KMxB+wX8ILhPbsj/54JMrPE7nDQou6VxMqbfiRPDtRWe
	 uVSutB/NuOJbA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Elad Nachman <enachman@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: prestera: release the ruleset in prestera_flower_prio_get
Date: Tue, 03 Nov 2026 10:09:31 +0000
Message-ID: <179370057167.488859.72643159878045825@kernel.org>
In-Reply-To: <20261103100532.1309990-1-vulab@iscas.ac.cn>
References: <20261103100532.1309990-1-vulab@iscas.ac.cn>
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
