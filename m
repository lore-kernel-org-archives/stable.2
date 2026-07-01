Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A49A3148D3;
	Wed,  1 Jul 2026 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940055; cv=none; b=LIRFdQdrVGvlixRwJaSC81eM65orW2jYXzeRBuuVOnUaGimbJNqE90RNgylcTlmc0Z2G7KkcbDekvG2ub41ofP8Ue2T1nBoFctU3ZDxkL7m+ViPWEVCi0Y5Q1jg/ZfMaLsANePPrQ/K6oo0r9ITxvIo8ejBuw+IVTHlb7ICnO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940055; c=relaxed/simple;
	bh=Se619ilXFmnOD4vsuJEgr+1gTZlFx7k0OJ2EzEelEWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fRyJvfE2U88F22mvQTeSvsPhNyh+/vo066ABGbFKGPVfoRYwpBgyrLOLOX5J0p1+sx81hWj1hRaE/KtSf79RepcOrpH9REs+OtYEl8OJJUhTKfhOLF07/OFxRH1K75MjKh1482HY18vaS3ziCUhtJ15OrU677mDrCgiMTTZc380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOQerWQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOQerWQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3171F1F000E9;
	Wed,  1 Jul 2026 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782940053;
	bh=cHw32tRK3AgkBd4BhJ4E2eTb3oeKdtreyLog08NiLw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VOQerWQO/pRBRiZJukB8yjpLQAtaUtF2v7SFJSjcZhJYuCROjyMAn76g/IxW0dnS9
	 MDFK+K/nvksLyGUEwnuSOMPenKs3zNzEN07WcouGoqMo77FllAthOMP7HCWso5/hkv
	 7cNSceWycX3EaWFSTPI9rP7blbgbLpl028p/tK/v1K0TJYTex04F5JV1cbHRBUX3/C
	 3+N+hbGCcck/sdHUqLI7+ShClMH7Qu/5+0Wl6qzfp5SdTm9qHaw5+eMyk6t+oExg9T
	 edMWyQ5GfPmSKhZfpsov3phP+UyJ2WlAB823obbaTT/TKe4rM/oFsQLlukishckqn9
	 BpsMzKo8t+/Bw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abel Vesa <abelvesa@kernel.org>, Junrui Luo <moonafterrain@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
In-Reply-To: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78817DBE3397783540CE3372AF122@SYBPR01MB7881.ausprd01.prod.outlook.com>
Subject: Re: [PATCH] misc: fastrpc: take fl->lock when moving mmaps on
 interrupted invoke
Message-Id: <178294005196.13032.14515168616227927407.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 22:07:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 02 Jun 2026 13:29:58 +0800, Junrui Luo wrote:
> When an invoke is interrupted by a signal,
> wait_for_completion_interruptible() returns -ERESTARTSYS and
> fastrpc_internal_invoke() moves every buffer from fl->mmaps onto
> cctx->invoke_interrupted_mmaps. This list_del()/list_add_tail() walk
> runs without holding fl->lock, the lock that serialises fl->mmaps in
> fastrpc_req_mmap() and fastrpc_req_munmap() everywhere else.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: take fl->lock when moving mmaps on interrupted invoke
      commit: fbb084ef5f984af90aa56fa063d278a54e677cf9

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

