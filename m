Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142937E2FD
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514538; cv=none; b=Uiq9B+/JVMVXbYwmRJfy1R3WXSTkDidPlKFKAZEV9amLreJVs8iP1OgJy3R1qkgbpvF5PvfAU4Zbm7N9i+qQNlknQv2Gq90l+sM6j2KCn2IlzTs5j9QXA/6P2KdYbQ1Ij78aY4DOYKjd+YuJP1Ui1PlheCMqXo94fFjjDC0Flfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514538; c=relaxed/simple;
	bh=s3Nn1kzxuivMN3+36em0tx5g2Yp9QOI1qp8FrB4jP2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF0gUxtUR3aga1NhrZ8XsmqEC99NzXP2UcpF1V8SSSaPMERJMsFdcQ85U/XEfcpx2HenOq+TYqNVpY/5Mov6J/isdrmP8ykuFm1jwHEJ0iwApI2UY55pqWVYpkOAClpnnaXHiFjsrZC1TwvXlvXX9pDSWcM47ttVNMwp8xN8wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWtCNnBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWtCNnBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634BC1F00893;
	Wed,  3 Jun 2026 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780514536;
	bh=jGMo7whhCheS13JfLyUWX3GXLvk5IqhdeCSnUESs6ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JWtCNnBCtLF5cGkR8x7CAsmR526Dso/JskUm29igu3mlEEYMcpkS9mEoVJj3okGvH
	 WMiqlM5YfX8/fB4NHnGFtFoRCd2yb/olfUnZ0t6lQZAA43sX8mO4NsMB2tD2Ysw4S3
	 lHZ6PP8fO3HjyJopdC64/Yk+8iStYQJMRAE+7T8nHEaG/OlGpqnow6Iv6ZdwnHPtxm
	 oKq211llZgf+3TdW408j4aD/+xLKSEwcw7r0meiXNz1R/fWBC5gOZCk6Hq7+dtC8g8
	 fqd+1aaxvVGRnvUbyT39vwoiRGuOPw5yW4C1FIBhoB6H7nqDHQtW1nB1tH+san1boJ
	 IMmeHLShJYwTQ==
Date: Wed, 3 Jun 2026 15:22:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: stable@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: prevent TVLV entry number overflow
Message-ID: <aiB-5xvBQhgZA1Iz@laps>
References: <20260529180618.413634-1-sven@narfation.org>
 <20260603105137.batman-tt-tvlv-overflow@kernel.org>
 <3408862.oiGErgHkdL@ripper>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3408862.oiGErgHkdL@ripper>

On Wed, Jun 03, 2026 at 05:44:05PM +0200, Sven Eckelmann wrote:
>On Wednesday, 3 June 2026 17:13:57 CEST Sasha Levin wrote:
>> > [PATCH 6.12.y] batman-adv: tt: prevent TVLV entry number overflow
>> > commit 99d9958fa10fb684b2a8e2c48a8d704122721420 upstream.
>>
>> Thanks Sven. This one doesn't apply to the stable trees as submitted.
>
>This is odd. It was from here (were it applies):
>https://git.open-mesh.org/batadv.git/log/?h=batadv/lts/6.12
>
>Also tested it now on
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
>branch queue/6.12:
>
>b4 shazam 20260529180300.412724-1-sven@narfation.org
>b4 shazam 20260528205744.636746-1-sven@narfation.org
>b4 shazam 20260529180450.413317-1-sven@narfation.org
>b4 shazam 20260529180618.413634-1-sven@narfation.org # this is the relevant one
>b4 shazam 20260528202135.443823-1-sven@narfation.org
>b4 shazam 20260528192733.76065-1-sven@narfation.org
>b4 shazam 20260528194602.258724-1-sven@narfation.org
>b4 shazam 20260529180804.414401-1-sven@narfation.org
>b4 shazam 20260529180905.414737-1-sven@narfation.org
>b4 shazam 20260529181000.415087-1-sven@narfation.org
>b4 shazam 20260529181042.415322-1-sven@narfation.org
>b4 shazam 20260529181125.415543-1-sven@narfation.org
>
>
>This applied fine for me. Or here the patches I've just applied on queue/6.12
>(in my local branch) with the "b4 shazam" commands:
>
>$ git log --pretty=oneline stable-rc/queue/6.12..queue/6.12
>4569694c4f2a053cd2964cad24af604ae4ec2047 (HEAD -> queue/6.12) batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
>d32927f478de78eb5224ed73432aa4a41d3bdbfb batman-adv: bla: avoid double decrement of bla.num_requests
>ceab9caf4a4da8ee47e4e238b5f416d49cf170a9 batman-adv: iv: recover OGM scheduling after forward packet error
>8b27c099491f34e3e2050e298852295eff0a4a91 batman-adv: tp_meter: avoid role confusion in tp_list
>46f3587c0deaa3fee91d38ffb517a3b597758cb2 batman-adv: tvlv: reject oversized TVLV packets
>8cb77976278ae5aa212908a7392188f7ff042ba0 batman-adv: tvlv: abort OGM send on tvlv append failure
>ecd5b0eaf6fbcdeec2ad328aeeabd39e9c7b8f24 batman-adv: v: stop OGMv2 on disabled interface
>b2fe2f8b69154de1fb8aff110743966f5ebf2293 batman-adv: tp_meter: directly shut down timer on cleanup
>4420ab1d1ee86b11393a3f561a78edbc220395fa batman-adv: tt: prevent TVLV entry number overflow
>09964daa253a0b7427f01ff3b67f396d24caf928 batman-adv: tt: avoid empty VLAN responses
>7829b033f053aafe66080f20b68b4a60c4f58db7 batman-adv: tt: fix TOCTOU race for reported vlans
>f547e2d9c2a51405f256238558699d40449483bc batman-adv: tt: reject oversized local TVLV buffers
>
>I am guessing that some different ordering was used while trying to apply the
>patches. Just ping me in case I should rebase the patches from my lts branches
>on queue/6.12 (or another stable queue) and submit the missing ones in a
>single patchset. But I should most likely only do this after you published the
>stable-rc for these stable versions - otherwise i would also post patches
>which you already have in your queue.

Yup, looks like an ordering issue. Thanks for clearing it up!

-- 
Thanks,
Sasha
