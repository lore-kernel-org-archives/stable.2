Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537212;
	b=vJkNAeuCQdONfylTirvDQQpRFeR/dpPd2Ag26scHQRuEk/2qWhpiCHSP9n95EbGNW0Gf
	 B4VNARvISVTA2+erBSdI4hzBXdIoqP/vjUXmDfuwvEVtOUrjl/owgJAZxW3p0sK70JiyM
	 BNde+rILMYoGHS5lqgOs3xurPznDrVz7xYldUMNCzYhTF5ttpHdBmVEhfmWDr+9KBG0mi
	 6AVi3ym6PmsU/aSpGPMDwouHTuLYsePWuW3pUznsi8Bc9F5JcAWC8t//EpbxXkVnNkYh8
	 nwB6RThPHwb2YTbHYgGnZdn+MppktcQOwLlMWehZua5fUpsMYhLDeEz6doTk0QgJ/Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qOom7DRC2zh9KY1LJiflJAg8kMl0XVHLk/tXkFv+VHc=;
	b=1Z1fiuF2OHQ0BlizuDXPYXYfE77APl1qI07WoItDcluFjAHWAKIvzQ5f1bW9k8mNBNrw
	 4UzsikNYo2NGq7a+8hDgjNpg6aU5bWHmrpV2xOiTmm9+C7dVOgg5NsKirsqFbEJ53vRCk
	 MFxhusp7p3dB0EuNXclhVUCbsnnO1bwl/e1oD4Gh+c2UxZkP0m5EB4GxBiHtyq/1fMwTl
	 jaiL1y1JrsH+jKUNb3E/b2x6zZXbxBsC2A1mw8A/DF1wuMGm7wFMd5/1NPYXF5/tYG0hL
	 byyM6UWmbpaemYB2XTgVRJYzodOOpjCuiUK8evEGs2xl8+3WHsku8dFFJ7zBBIIBmMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2FX6D3g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A45606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2FX6D3g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E91F000C5;
	Fri, 13 Nov 2026 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537212;
	bh=qOom7DRC2zh9KY1LJiflJAg8kMl0XVHLk/tXkFv+VHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2FX6D3gdlJoX8h3JRZW3CnbPHOuFgCFv3LgXv6+6lkOzGcXGIPzyncYDrPn6fX7M
	 qYPSr2P1Y0irlFLuV6cE54lCAEphukZzKLJNMTfNLowBMTbZTKkmB+GBkP5N2Jm0uq
	 lSnOscMcfuuYi4Y6ueJyrXFw0/KJ+iX3rOgpQhl4ppuRQF41sQQKuNfidNeO+tKz+h
	 B2bRsjqABcTV7OKVQs1NEETuq8XB+ShM0T0tY6LkJSNiEMs6YGlv629JyM9B8t3df6
	 8Mh1PUdepPDnQX4aJngrhlypnmxQGoHcfCEtoe9yjC8ekuav0W7GVcwC9pAUkYBbGM
	 7cI10wviyasiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Kimi Security Team <bug-report@moonshot.ai>,
	Yilin Zhang <yilinzhang@moonshot.ai>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.10.y v2] SUNRPC: Copy the deferred RPC Call from the head buffer
Date: Thu, 12 Nov 2026 21:33:11 -0500
Message-ID: <daily-reply-2026-11-12-5417451315@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112135550.982415-1-doebel@amazon.de>
References: <20261112135550.982415-1-doebel@amazon.de>
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

On 2026-11-12, Bjoern Doebel wrote:
> [PATCH 5.10.y v2] SUNRPC: Copy the deferred RPC Call from the head buffer
> svc_defer() snapshots the RPC Call for replay once a pending cache
> upcall resolves. It copies the Call starting (rq_arg.len -
> head[0].iov_len) bytes before head[0].iov_base, a back-up that once

On 5.10 the RPC header is already consumed from head[0] before svc_defer()
runs, so the premise behind the new check in 2192a56b0686 ("SUNRPC: Copy the
deferred RPC Call from the head buffer"), rq_arg.len == head[0].iov_len,
doesn't hold. With it, nearly every request would be refused deferral.

Could you rework the 5.10 version so it doesn't change that behavior and send a
v3?


-- 
Thanks,
Sasha
