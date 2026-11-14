Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621501;
	b=okzL+d64QoNIzP01Y7sY6TczKyL9IkemWMUYhPn2S8Ly/ODWJNB4mwSRIYasNeG/LyBx
	 UcS8gd6s33/LsXoNLqsnUxj7DeryKQ3B2aD7MBfKN1lHfxsyuDrakayu+zFtKUPhuukHq
	 F2BtBuu6onqGD8aUKA3t+DYKMhjmdV7rdVefXWOslKiZGvkl9gN5cY0zNu2a53A/1HhIe
	 HQ0MOHnk/o4o7yVBSO7CKwLI9GkJXJUEnxXhIvDBB9hqlgjXhV55N3mgINUDqvmVhZRxw
	 QNc9qbUrOab0Tli/STiw5yWu38aFm3bKMbYupeBaBFK8hCja1bR+IybZSI7GQ3Bb8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=Ii6FDbYQnRGIs0vL895bCcQuaIa+XuIlf267cv8Z8FB0FXwLDy67WvhvljFRd5B0c0U4
	 cGoa7rcP85DwmNXyB7kw78UlKZi9ZXssbJuIgcm/0f4s+Fcle43qF61DouG669yiGknyu
	 iBUASHR755j2SF73ed69xHId/FmDa/5mYrr4fguWNbCp/N0DOSrMAUEfuaLYC7QPZAc8w
	 XcadxjKv+qAl9TZ44saq1HFcYqQynhd3XNq2HcvGMY1Rk5TIhFQlnXuqeZ2ZPX557W2JO
	 O7NCd2Bnsi6JmBmoNhBBXUh6xpNHPzX4OE05gajciMG++9WBsoT+Jw4bvfTeZtc6Wcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sdiioxly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CE606A333;
	Sat, 14 Nov 2026 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sdiioxly
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146DD1F000C4;
	Sat, 14 Nov 2026 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794621500;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sdiioxly7NjwFRO575POppKZvua3L6WryftyguGqSYZamdJsAojMHIkMmxVFp/WNU
	 H11hZPL1loqMrPcgNMIObTCzDN/d+3JZAhV6qS6+qU0Zi4nge1AKK8jHoqEHcbgbrS
	 JszJ5sF2FyY/XmcApaHlAFQU7Q9Wsk5CakCfoT7+Go+rxOSdAXTbhHHoSOw4jzACop
	 cztjbReNHN7gII6vEbqAbtU9WxXIp9iWIewja+SU7FfvjTgWOjeIKZ/NxPYWNw5Ms+
	 9ezlAnYa4JJTxUYRklbQGmxKWLeuahQB5NUrtbmkKiUSrAE0hDM6o/5NMF0yCibrje
	 9W1GVttm762lQ==
From: netdev-bot+sinfo@kernel.org
To: Zxyan Zhu <zxyan0222@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, horms@kernel.org,
 0x1207@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: re-enable on-chip parity checkers for
 XGMAC ASP 0x2
Date: Sat, 14 Nov 2026 01:58:19 +0000
Message-ID: <179462149962.2168702.2687296647559611353@kernel.org>
In-Reply-To: <20261114015554.2187341-1-zxyan0222@gmail.com>
References: <20261114015554.2187341-1-zxyan0222@gmail.com>
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
