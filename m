Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700566;
	b=ArECY+cwDrPGYaV3V5CshppArVpYTi3ApN2sAQw3ZSf50zKzcWix9M8TAYKBwVsLSsqH
	 FDHbIW4UltfvNA8jQQHD/Qwzo9fior+/EEn+T5roGINMLSzDMtFJDoM8nDHEDv7+9hI4n
	 UCczb32w9bngvX3pphe8rhhdfJ9Ny1p24/wEmDgyAFZ3hS+f9aTRLzCGf5J0KFcDNWzsQ
	 Yg9r9DMzj5KiqOpJOCaBplb/PAI0oZwl5r2Y49kvexbteEOJWphHtuRCFtOVn0r1vBsW+
	 Twhj7Tk2B53bOq0kh8wkLpORE7WPuXp6X3Hc4Due1VsS2CpIaX4/OM4I4AA9hwpZ/Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=opBbZrtSoUCrs1Na2bk5Wguanv+3P+sl6QZ4qL/5rWFdVWB0R1U76jRHXt4vuoOjksK+
	 zaC4vRgvV68Q+acbeO42lVET3pOZxZw3kZxBD9qOvnc2AWDXjacddittjBB8RySLcn9i7
	 pFRGRFOYy1VhDOIH4iSsDWp6vmf+Ir1SeBxP2gT2oGfevtoMohSVh9MlK40aXLCsviOMA
	 If4J4bkXUlfQDtK2L9GOv2ySFAmrbsKqqtheBKu/evW9PigUQgjgHZ+XdxOxIVmbjBjo3
	 omKwEv8y8cBKBuac4iZ1N+snyjFYIJ/FtIyP+lXIfN901tQAvtiyTG3bll7JaLjc2Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYSY0agv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CEF606A329;
	Tue,  3 Nov 2026 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYSY0agv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F31F000C1;
	Tue,  3 Nov 2026 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700565;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYSY0agvQjfnrpE4r8n1o+LXvK4gDPO6U/OgOptG6dCCoK36X7BCqGCT4Z7xBhO5Y
	 IrYxFc0AQXcm4bXSbDZFjLErm0C9X4pcuzVlqGActFl8zYgMnLgzSsw2arhsBrLgEZ
	 xpRMT2HNUBoAYq63ttf8/Pa6xDJ8mJgwiO1h5epV0qaDR46ihNGEFjzmfLLjsnulrG
	 iCGuTk5h25PT5bAS1l3gMTUlRBuqt5EbVrtmFpadDYFjBw3C8Gc2Z1AlJZndmpdTgV
	 JoQvND0U9PD5quv4VhsmZaV+n+Qn47xfr+B6xKQDj2tNEz6JAwFIRoWo5tMfoTfE1f
	 RXPcfb0jNvoCA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: cxgb4: do not leak a PTP skb when the Tx queue is busy
Date: Tue, 03 Nov 2026 10:09:24 +0000
Message-ID: <179370056458.488859.6137271730587813880@kernel.org>
In-Reply-To: <20261103100530.1309928-1-vulab@iscas.ac.cn>
References: <20261103100530.1309928-1-vulab@iscas.ac.cn>
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
