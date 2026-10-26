Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019411;
	b=NC7xze4PQxK9o38Lz0YcsmaU0kCO59kDw7R6HZIaC02XYQUD5OSP4WVgu/4PG3t+AZ2z
	 1u9meqhGSFwY6PltbL9Tu85ueIEOHX3nMbKv7xCFyvR1kG/zWB7jnhrobVp503mO9BccI
	 bfFwdyzYNyHwEA5UVRWO7zfQIzsUMaS0cHjQANsnUAwDKNE4A/kpCtqVr7UduHbmYpGUb
	 ffB4CyDkdGW1EkX+bMYZcWqxPV24kCPNBgzLzwakDh9QJftJsVVctQk7Zpu73PIUe4FPB
	 6i3XPQYwh0z+nXaIB+V5cIdl08w172aMHVhddzA5WIYQvms3BkpthfHYnrU4Wutt3Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019411;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=anlSkHx0/vYrMyEHmH1kZ3Ylu3Zwo/oQD2STj/UK20kfBlaBCD06lP5r3XhVsxZYwHec
	 KIELzRoJsYFtJ22Jaz0IuLmtuTQgFwX7zJkAO9i6ctyYgO7t5YuxqPd6WDSm1AsugCjGc
	 2DKkfGeCceGDmncQr8G4pquvCC+lMx6WAXQYBN0u7sGbJuMq02S5NlyotNI5I6/RCRg/9
	 CMwDSgLd835V+N/Dqa8kRpyoceCivv6e8Djgo2eL0BjHIDoU5l9B6SYbAlVwb/g3ZMhF/
	 YSCEGwfvoaB9YOSYiitChhq70eNdS9onQ9/fZyLZe1Sdv41AzFZavShjHm4gU0+Y2nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kX/7XElo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33842606A31A;
	Mon, 26 Oct 2026 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX/7XElo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667691F01825;
	Mon, 26 Oct 2026 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019410;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kX/7XEloGKraumUnc3PqXVAUGLGkpCxIBgZvuyr0CnxnLkwdE/6dehqKG3BX4mxxC
	 k/dxrHwbrvcF0klHU5VtuiSCJUFiKkuDlaMuEchb00REDX3D6LxIy66mM3yeHXkYMn
	 Vf4ouZXz64dls534S+ZBcs6kFgLaLlT8KEZ145Na4KwIB9RcmGCcXoqLgK8Yum4mMd
	 WVTa2Y05jAuE2DmX3s7pX0c0Q8uM/N8V8TwSm0xA1UOqUdganWfu1ghR3zIlC1EyIz
	 xKD9W+2X80RVcOIlTi7juaDW6wrQ3FvN7i8KIsmPgBx/yhaMMRpBHg1bx/gTzjeQ9C
	 +wKmdAii8go8A==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?b?5bmz5LmL?= <treebacker@foxmail.com>
Cc: Greg KH <greg@kroah.com>, netdev <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Ahern <dsahern@kernel.org>, stable <stable@vger.kernel.org>
Subject: 
 Re: [PATCH net] ipv6: fix dead half of the MTU guard in __ip6_append_data()
Date: Mon, 26 Oct 2026 12:56:49 +0000
Message-ID: <179301940992.3327.2471984737675968211@kernel.org>
In-Reply-To: <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
References: <tencent_B58BAE2F5FF485D1B4F652E9980EAB132A09@qq.com>
 <2026102604-circus-juvenile-c521@gregkh>
 <tencent_7454E65EE7BD1C085B6951A7D2305157370A@qq.com>
 <2026102658-jockey-volley-94ff@gregkh>
 <tencent_E14C00D5FE957DD7E12FFDC2E75A4FA9EE08@qq.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
