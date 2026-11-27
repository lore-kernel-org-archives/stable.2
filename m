Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798955;
	b=k5mx/REUeK3E4Gw4Kwc/Ah+snS5jPn6TCiuQHfhSWIwmyCiQxgnkG5jJRsCkRPpNS6QT
	 +7CozVlRX0Qyo4qEl9hNoCl5iq8HmPP7/TtOKzYNczbE8ccUR9VcDofzNQf/HIpqCc950
	 e7DSUN6Gs9qxu5cHthVzp6SFg10gwv/JGAz65TvRj8rkHsRSN8a9DxkWGJjmBZITIiIxI
	 HeB46KDui5rztc2UQeTmvXbyrijQ1jAZ9snXiRGPOxgVxEDXwflIsU9D7kOGEZ8xUCw+c
	 WFsWNaKkfLfINMzzLHLDdJzVIg0GxOqAQqChoGc4enK2INv2CGnWW5HaD9Swirya1Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798955;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RIbCZV3n02t122v9jYgXjK6KQZHTCpSZCprTxUaIcuY=;
	b=IBVQAJqlTdB68tgdYh5r9S8xwx7vbzTx06NATuqmEmLcFGNpDNACNgjuLWLbfDFqS5U7
	 buB3Ld7aXr4wdQVy1/NeAvOsw79cjVL/OXgJu5UvDTcchB32S+PjoNKvVU8vAzZaoOuEL
	 l6f+1tUfqa1ezVMxhckApJawcxJtXmO16hknBUMgT+qJ/VSFQXtAAGTvNOpwSgSNqnVB/
	 few+ThzVg9oVrMdXeNckcvSsSSu5Qsd3dO88ELhwR2oIG6VRPCQ85IOWhq3Imaqq6SFYZ
	 /1pqogDk6zyJ+sDHzaOmYJTtfUOwoGhZNG4OzypFUS6UasMhuduE2lV/nrdkYCppjKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMeBPhTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F4606A332;
	Fri, 27 Nov 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMeBPhTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965491F00925;
	Fri, 27 Nov 2026 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798955;
	bh=RIbCZV3n02t122v9jYgXjK6KQZHTCpSZCprTxUaIcuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HMeBPhTDUcNcDwuInzyOBXEubg/eyFTj26RNglepbo6MrNgwnlHG7Tk9XqWTEEf69
	 zwY4dc2cUjxBAZksUrfT5fdRpNmZ7A2Op0ARpVH5oTWOGPxdb7rLTqGLMWiPwPIIP3
	 d0Br/lD3QILL7olUFGpE5WxQ6GmdI7W//5bD+O3F+ZK74A/QBEsYkQWGJDt7zlK0BG
	 u+nW3pAVgDASXRokwbMLA6SS7cgNn/ObDZKZLEc7YlKkP2sVTuHMKR9LY13GM5I65R
	 LrIgk49dvBpzyHoBohvpgnoasnjNNSAj4SOXfot+6bmh/u3Ap3dnYqmaTFhR4zYRpz
	 Um7wzjJuwVGSg==
From: Sasha Levin <sashal@kernel.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	"W. John White" <whitewj-debian-bugreport@outlook.com>,
	=?UTF-8?q?P=C3=A9ter=20B=C3=A1tori?= <batori.peter@gmail.com>,
	Mael Bras <mael.bras.ext@idnow.io>,
	tycho673 <tycho673@gmail.com>,
	hanta <hantahrabal@disroot.org>,
	skiwithme <skiwithme@optimum.net>,
	Suvam Sen <suvamsen2004@gmail.com>,
	Celimar <celimarj@gmail.com>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [regression 6.1.y] 967473b1e8bb ("Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd") causes backtraces and non-working bluetooth
Date: Fri, 27 Nov 2026 12:01:23 -0500
Message-ID: <2026-11-26-1-daily-reply-0035@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179567271700.947722.15185762256491350563@eldamar.lan>
References: <179567271700.947722.15185762256491350563@eldamar.lan>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> But reverting the commit does not immediately seem to be an option as
> this is as well the fix for CVE-2025-21969. Is there something broken
> in the backport or a missing requisite?

A missing requisite: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del"), the upstream fix for b4f82f9ed43a, which has the same list_del
corruption trace in its changelog. It doesn't apply to 6.1 as is, so it needed
a backport.

Queued it for 6.1, together with two later fixes for it, thanks.

-- 
Thanks,
Sasha
