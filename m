Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903970;
	b=3t5QfWtqC819Hdk8Lk5kQQXj4/ytWKOBEQC99j22WyHvP8pzltJFntCfTDxazxDy3rgk
	 3nA1tWt2uNjuxT1xoK9YTb2OLq+YKghakarrFaym/DOAejxT1S9G573in3sHgAOYl/CHf
	 UJ9N9o1ogjo1DW+HD9MmNEd+gXDvf68Op363KN9CMq0kOpflziywxwUpPT6CqccmGSxPv
	 res/WMbdeDeTKCJ9qwsi9Z96KXJ6x9evAnHrbN4AB/XMWbB14OgY4MZbxJ9SMnVuZrs5n
	 qhAkx053dUCVSlq2DHWw3gYg00SWF35mIdGd5SSaLy4+aYMtG0nVQQfVUan9R1ot0ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WIttHt8MLH2jTSzYQheQYAwliFTwRr5jOJrAPBStUTY=;
	b=x/Zr8NDIofNAkJtArmODnbSiE5PEUmumkgk41jKybADTnjjYqiFVdOiXQ2tW0V+fzRpY
	 tEdkMM8s/S4VOQ1g7UjZM4crPEhWCzHVBwGqVOIghj5fCRA/OZBU7v8UvgDObcIHCuRle
	 e9QNxJpyG1UZmq1sntUiy2R4rSke7W3fhkaZJTD6myO2VZVBuF+JLMTnpx7Ed3QYBrKZI
	 1P+1Bb0E1tGlpgJjqFGZakQ3IPyOnK7oFcxErEmStDHHcATOjZzW2qwRfU6h1+tSOqFZj
	 C+oZYiYlID5625jGwGYWT3oX+yYeadjuDJku3ZddylPl7urBTRScprv+YUp++mWzQ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYlPkkl1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF38606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYlPkkl1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D83F1F00919;
	Thu,  5 Nov 2026 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903970;
	bh=WIttHt8MLH2jTSzYQheQYAwliFTwRr5jOJrAPBStUTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fYlPkkl1UWp59eaHviUuKF0kvPT5meJXMhgf5goGnST46E1uOji7Gbhn4sF7UTOj7
	 j0iFaO8HEq/rX7rvs4CYGBP1EyFnNtMAaMkD2BRzpeiC2hj9KuuIbDWco4OeNG3gKJ
	 zojeAc6iRaQokNryQGrs8UZQRH3nc4ml9ukaP/4x6/NS89DnuS+9+YAAlVZqkBi6qy
	 XorXmPg7njmlU55bYAMcyMqkrzZNvuRGRYyph4Fk5Hz9/WMRuz0e0tC64q2OQgCNi1
	 DzKripSPhOsXSZH5wp74mJkvhdleSEj9wo1wnHzA9hakbGaCoaz6IeISIf1T/3pKsB
	 X8ojoJJMasX2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com,
	nicholas.kazlauskas@amd.com,
	Rodrigo.Siqueira@amd.com,
	harry.wentland@amd.com,
	Wang Jiang <jiangwang@kylinos.cn>
Subject: Re: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Date: Thu,  5 Nov 2026 13:39:13 -0500
Message-ID: <2026-11-05-1-daily-reply-0008-dce-post-update@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105090543.930342-1-jiangwang@kylinos.cn>
References: None<20261105090543.930342-1-jiangwang@kylinos.cn>
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

> Restrict the pre-update call to DCN, matching mainline behaviour.  The
> full mainline rework does not backport cleanly; this is the minimal
> equivalent for 5.15.y.

This is a stable-only fix with no mainline equivalent, so I need an ack from
the AMD display maintainers before I can queue it for 5.15.

Alex, Nicholas, could you take a look?

-- 
Thanks,
Sasha
