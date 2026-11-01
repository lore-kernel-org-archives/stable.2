Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544242;
	b=GpsUXlqi1Sf6fFjrFjYUVu5mM5H8q9eUQINQl3qIw5dkINit1XWzK4rhZAVwhC/eBuHQ
	 0fIkRE4CNh3fn3KrSqKYmcVFA1YqQ7ejHDZSj5q7apo8NHl0lQoHgtjbsmR4iB2JpQF2n
	 97Ph/z4h1u3joy0z5m0hIHeZxj61jHwHT8BQKn+1If3KdUyFvacWxVTEQpcDLyHRlgqpJ
	 hJAxMQQeF+FQEJyrC6lvDvOxlM+KFNgYABGOCApFVhoeEXw9fmDu3hCRytSKxf0BkgIBu
	 2cgCzcyEzvWDrijjfgGARWeImfOmI7ZwvZk2vI9sTVzZmdC9F2trdR4WsH/mM0Xs2pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hPExGPBJj7j8zAaDKOhmfGheqxsfH7qwRcaI8tQJEoo=;
	b=05XpWBTHwAbieqtDmoWpnBq1Sf5QShYVupcB6zuwAD/+4aywh6CeSHF62FHfm/k0yGUT
	 tOibG9yeOC05Y4IX78O4mGhpnT99jxML8HWuarlIoqPAs+OWbUA8qCb0QWh+17joGxjKc
	 6dCzCUBIhdfJXTBStFo+44MAT1xpclYCGqfsvYNBMo1LrW7cjeNu5M1k0zknyNTP8XfQU
	 ICz6x1Q6R3NgBIbj5BsIxfSdVwe9JsvRCFdx2ZO+I92JAA1mBXeNJAlALpB+txua9yegg
	 EsMyQTVCMZAaIqfQey6v09wQXy1kXTaV6qnFwaqg5C2VvIOOK3mtqoDxwIPxfTbMbcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9zcrYCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBB606A334;
	Sun,  1 Nov 2026 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9zcrYCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD931F0093A;
	Sun,  1 Nov 2026 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793544242;
	bh=hPExGPBJj7j8zAaDKOhmfGheqxsfH7qwRcaI8tQJEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i9zcrYCGDA2NmrgP7GmSmPCgANGhMB92TNXjqXnRgoTVAGF9/psXv54eRc05ovJuz
	 TRVhU9IvRCox3r/G/YZh33q8ui2MR8UZJ369reKamW/nnOwDcndTmoaq16ZxR+OGfI
	 4Qg0zmmgaKxDhVTgN7l01jWgOIR2njTGopjPUVrOfXxo1cKabiMEwpo/TSiJDk5cY+
	 La+EAacjVGgex2OXpJdw2UExtAixnXlynHeINx1dZbBR3ie4q1DC9KIexcX1eVa9RR
	 KDRCdjsr0ChyLTql6y/Rp7r50fzXLEzcLxbI40OFZiVi7unr0fKfg3VF5jf1692all
	 l5aik1Se8BegQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	kartikey406@gmail.com,
	harshit.m.mogalapalli@oracle.com,
	johannes@sipsolutions.net
Cc: Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH v2 6.1.y] wifi: cfg80211: release locks on error in cfg80211_wext_siwgenie()
Date: Sun,  1 Nov 2026 09:43:56 -0500
Message-ID: <2026-11-01-1-daily-reply-0002-cfg80211-siwgenie-6-1-5-15-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013102041.2113948-2-guanwentao@uniontech.com>
References: <20261013102041.2113948-2-guanwentao@uniontech.com>
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

> This error path returns while wdev_lock() is still held, so one
> malformed IE request can permanently block later operations on this
> wiphy. Route the error through out to release the lock.

Queued for 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
