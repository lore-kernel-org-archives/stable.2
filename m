Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794085982;
	b=SycOVXNfFg9+sSCRAWnzSqcfyo5g7afFn8ZPpHVKddoQpv0oG6ZGAYCdpg7rd3UjVu+9
	 TTO0/1l8v+9uTmJxUo0ObIck7ROFOtTNl/XQ0r0cBkeDr6wNAcWB9BMF0dqxg4KlycjsY
	 7J54T0krutQc93V2WWjSar6dSXdcv64I1hWQXHf+Ft+abiPFAJ2Kdy2CTNjEPGCnNbMDp
	 +hpXAOVvmTP5QGdMCSeUFR4CWmID1WAWAnnPTBWNSiMSbfta473NX0EdVkazt6oqgyUka
	 gabAozT1dE/yrwv3zkWcI2XIVEpainY/3KzQxn2u8khWpXuTLTnwdj/R+cTu8gpgiXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oKHVnRglM9S+Xs+2UEuiq8xUU1O3RZBks7ZX4T3wNq4=;
	b=j393SFUK7qnpERa4XDprCCpawq4tXzlWO9sH6k3J3kGeFG0niVfo8vIGz0fOXvSNuGTJ
	 IKPkby4BydvN+Ef+0TGHHYnlMGl/5ui9SyVbGXXrlLZqCVS/TKbV9S1QudSgiJrI2+s9U
	 3dpr9PJVTD5QK4M1YBBvzAlV3Ql67pYLSkD4jxYRCbdqAYxcW4yZnxggjEUJqC5GdbyHh
	 1uWFswpe/Il3Mhw6SxDsH5mRMgG63nJvy6NwLXU0UcAaIfWaxAOTSRssiALP7FqHRthU/
	 6reYCQTHbHC01DxN3lC/yFaCR6B6U00QsD3YYLB6W/jfnTataqsiVbpq0H0/Ko/xfIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkbfIGrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78406606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UkbfIGrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14A51F0089F;
	Sat,  7 Nov 2026 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794085982;
	bh=oKHVnRglM9S+Xs+2UEuiq8xUU1O3RZBks7ZX4T3wNq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UkbfIGrre4TJciQna1HuONOOcAxTUa8wWt8xWOQ2BMdy78ZhQToCWVj2sQQJnA7T5
	 nJaU3iAE7USA5QGT5rYkKfrXNnatxzJYSKZilPkn1G68QGB4GsE2l6q7sPh0Iiynk/
	 vq8epLAvZPbkxB/uIid5ZWzRnDo/yTp649ieAqxw0UAVMJXi7xzZhWT658QucheR21
	 0rKXRn9dAmCq/sAjlHA54YZMBSfjB3baVbPyD7qCi7kx94B2vEidRVEVgLtzCRIFD4
	 5wAoLhNHYv3dvSqwUQqE02Su33E/XGmH71VU3RhIGMo6VMv3UtoRWg2qRNCwMg3GAH
	 cFF67oYcRwv3w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: return an error from damos_commit_filter_arg()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 13:12:53 -0800
Message-ID: <20261107211254.271286-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107170946.102430-1-sj@kernel.org>
References: 
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

On Sat, 7 Nov 2026 09:09:45 -0800 SJ Park <sj@kernel.org> wrote:

> On Sat,  7 Nov 2026 06:21:10 -0500 Sasha Levin <sashal@kernel.org> wrote:
> 
> > The patch below does not apply to the 5.10-stable tree.
> 
> 5.15 is the first release that got DAMON be merged.  Why are you trying to add
> a DAMON patch to 5.10.y?

Seems that's because the patch has Cc:stable@ but Fixes:.

DAMON patches having Cc:stable@ but Fixes: can be considered as wrongly having
stable@, and therefore ok to be ignored.  Please ignore this and all DAMON
patch cherry-pick failures to <5.15 kernels.

For more details about how such wrong Cc could be made, refer to [1].

[1] https://lore.kernel.org/20261107194352.198354-1-sj@kernel.org/


Thanks,
SJ

[...]
