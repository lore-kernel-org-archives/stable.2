Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739837B40C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490511; cv=none; b=JR+VCDVuPt/lDhEhyknnlMOh69t+9anqu/mNPybxry0JTeghPVaafyc85gVVOPI7J+oVL4fo0pFNWzU6Ho+jcvPk+xzYmNNjVW4lyez2qF2uTNbaR0pSCpgG74+oGlUV0O2m/Huy3tMHKuBBs5SHcYLwZiTr7plEgAR8BghwwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490511; c=relaxed/simple;
	bh=NeM4yva9geXBtGRSW2En6kPCL/SVOpeLrV0ggY+Lq5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljA0oGeDxiCC3taIhy02m5mZ3keBHccyLhy565aj3KSjA9IKvNmfEAsHjX5VG7gyTq/U4pVc/bEF7+qrpycfCfOACAdhR+F1yuV9GYMatXPsFMBzq36RS79+O/9pE44hL58asxO6Nls0CFYNNt9/oPl0BJJgzmguzQ1PjTzGfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zaj/siHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zaj/siHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2D11F00A3D;
	Fri,  4 Sep 2026 02:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490510;
	bh=scHdjvh2lPwOu9C1ASf+cH9p1TI4ZHsF46fLdzpmY0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zaj/siHfYyU0UEnWhCzabw5NUGZtPaybtXnAThOP9IA008q7S6mtTnA/nYBEjwLIF
	 Jz929cj8/RRHf6J1LdgxD9MND4j0Kg0gmnft7vmomR2btCdrosD7FNpZUJw0x8rZMq
	 BDmK3uXyDVggYIRPnD0u/Z6FfRQJytJC6qOCI6WxUgz4n1ZxdcE+1r7U6j99tLyNL2
	 /9Nm9Is32oA9zMiwpslYDUydbd/hzxsltTqScmVusivxyjVpxZ4FalV8FhtCyvT2YR
	 OpYvodRXJjJTjgKAvYv6hDIc7vpTxAvKC1vxnQUvpbCpXCiYYg+aEoxEnyOk88CEzB
	 UHE1Aud0wlcWA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Stable <stable@vger.kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: Consider cherry-picking 4 patches to 6.12.y and 6.18.y
Date: Thu,  3 Sep 2026 22:55:06 -0400
Message-ID: <20260903-daily-reply-0009-re-objtool-rust-noreturn-scope-6.12-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANiq72kmYx5GBU7VL3z8h3bAWB=vw-TX+ptskDO0k3Ro-F450w@mail.gmail.com>
References: <CANiq72kmYx5GBU7VL3z8h3bAWB=vw-TX+ptskDO0k3Ro-F450w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider cherry-picking (in this order):
>
>     c18f35e49049 ("objtool/rust: add one more `noreturn` Rust function")
>     c431b00ca6af ("objtool/rust: add one more `noreturn` Rust function")
>     16861ca3508e ("objtool/rust: add one more `noreturn` Rust function
> for Rust 1.99.0")
>     993f235c4af4 ("objtool/rust: add one more `noreturn` Rust function")
>
> for 6.12.y and 6.18.y.

The first three (c18f35e49049, c431b00ca6af, 16861ca3508e) guard symbols
from the radix-parsing code added by
51d9ee90ea90 ("rust: str: add radix prefixed integer parsing functions"), which
isn't on 6.12.y or 6.18.y (it landed for v6.19-rc1), so I think it would just
be dead code?

Did you want just the fourth one queued for 6.12.y/6.18.y, or is there a
reason to carry the first three anyway?

-- 
Thanks,
Sasha
