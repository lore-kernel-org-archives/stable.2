Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700587;
	b=urnCcOnyD3mRk/+9WZ815H9MXX8enyc+xjKOY+nn7fSP8TQ0jtaWnGEHJKSyVqSI5a8a
	 tsQgpjw1+hhLM7YCBe+6uTNGAQE4+PsA4+YJ6eKOiN6L7rabKlqA/A+oO3Cm8B/H+SJ5v
	 JQ+D2EZZiJqx06543ptGYeJg9zVM7k7dXIG7uIiWMIjKusQDuEXaxN7zlNT2Id+aur8HV
	 aGVcQjP5AisVLBA3i2IWjmFaeF9z6+McJzM7H9I0Z3JOfG4dC3ff/shmifZHbWFw6F3tI
	 XPu1axYObFvwkZYu8KKpuECNS9GnN/3A9xo/6ZUhqZQ01YZ8J5Wp5bWDLrIrvUCTG2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=25mfPvOOt9Dlxvz597Sh7NdShj2EMQz1IqPcQtMbGKbqh50LCNxIsteDj5E58myiMbaB
	 oyUwwDSJRRJuZNgF4f5g8ntLaew92VD4sX3ZOS3G9apNCG7nf1etwryRxzNFgqQ+/oJ7s
	 YgigHZcQ3bDtFGwE77oj8aZrTUxlSlpdoC6MRsJzt2lkzj1yCsdm0UbqOwV3xsuAAK0S1
	 4RpoRDZz2EnWEmmB7oN9m+3llHXupOKB+jAffMWsjaZlKDUT2lA08AYw0BfD93E535wtX
	 6PLgBGDsQm+2pDu0bYZmk+aJIqVQPYVEfu45Am602r3QIUe73AznNP5Nb3wmZDSY70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxWdSQ0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D16082BFF;
	Tue,  3 Nov 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxWdSQ0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744801F000C1;
	Tue,  3 Nov 2026 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700587;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxWdSQ0+w7l46vanigC8eTNAA7oTbxAUsSjy8H/EhdsQ9N2EzVKn4V9gOVZn11B0s
	 1q0TxD4BCUyONuwUNS5/Aw1It/I1usM69v0mlPkucyt0IDH0aBIrRetTUS4MIh2uRR
	 x6oZLlqVq9OhwVRt+GAGVJPLRxXo7J45701P1v84ZOO789pxXi2vbf3HuL9d8zIPSn
	 5WVkrhwrquWe63f29+Hbl2AdzvCbUihaad3AWwlJM833H7r2R9Ifm6d9IECGMRIhYQ
	 4n8X4huyzIqyC9rOQvzXMEMJfbFb+5C7OcSKVnRThEw0m3tx1kuzsnNM6xrz6sIZVJ
	 jiD3l7HbS3d6A==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: fman: drop the FMan device reference after port probe
Date: Tue, 03 Nov 2026 10:09:46 +0000
Message-ID: <179370058603.488859.9070965025678524669@kernel.org>
In-Reply-To: <20261103100532.1309969-1-vulab@iscas.ac.cn>
References: <20261103100532.1309969-1-vulab@iscas.ac.cn>
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
