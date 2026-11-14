Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678146;
	b=pYfmS9eYwRgpFeReAxIjKSnD9hoazUUaaWuQZnYWIT08rV5sZ2m/rQNHNk5uMtOkKD46
	 3mK2AttqwSooOtTjZA8Qx1mnF6AkJ1vUqs7dstMOwt6i+yw9VFcY8jH32+HyVPT3YElN3
	 ZW039lVKCjXYqykuGgv/mkWI4qTa2rqRtpnDoZmgAj9yx+bFu6NfX2w872HU2reLqyEPO
	 TeO57x1l25VswHYWRn52w3W0mXPdInCimvA31OxDV320HCHYYHN8W1CsQ9Qmw/cXMMw69
	 6ZTK1DuwDh6XrwRnQC8fU75pQHfWyappBhp04Kag2D9GiQtTf/naGZ1E1kIaYc0qhrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dFUURcKLA5xFxnWUOGSllcX6Y3/uDYDVlu7q6QIBkgo=;
	b=AhqJeEHZMZ6f9q+RwA5XjEAmBPnJJg3YiGrlFHebI3lt8u3GOySFqPbGjB95Y3T70e0h
	 kXLVj12wezgLHXc0ESgU85aTaxWo3T9XMfs9tmry9MD4RyuBRilnOHiwnSHBHDMV1XEFq
	 GdS4UtixookGrTX1CaHtRncxajbYJOUjOIG6WL5PqTKD5t0RfOhGvXAxM0vSeZm2pRrSE
	 mvFpWEVVxCrBF3+thV/k9t43wQr2J+GX3W55gDKWyLL3UbcuXm9WcnE2VaLZJ8DED1n85
	 zhkPoaZ6x6w3c6O2lu5pEsg0G/98+0s4iL5IwmnL10W39bWnRYtmXfn9EQVpXb3OXPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L28goqBX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEB606A334;
	Sat, 14 Nov 2026 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L28goqBX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE731F000C6;
	Sat, 14 Nov 2026 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678146;
	bh=dFUURcKLA5xFxnWUOGSllcX6Y3/uDYDVlu7q6QIBkgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L28goqBX21fwhDcTfKLO15qt85aFvH6QHQaistXZbZTUmy2Yvv0X7IQK8ehB439Is
	 9Ric+QyH1+L5M+ShE7uu19kfmpejti3iE/xzhzFG3wyZQoLS6FS0UCY+TwZ7c8LXIB
	 1UoC9ArOTh9VOCT2clcCsKOZxZb3RC4maJJ8R+ORpZt9rEM0gINqvya8S1ttAI699x
	 XOB1r5jSutK+0rCTtNt9njXIPcJCTCsEXarF4hsaUdLnO3l5kGZgslFeznvWWPlqnc
	 3c6JvIdtpfnLqTMCHLeNPh5ETTSJKdpmjtna8kMJJuBTB0+Jki/p6Y2zor/K1kWhTt
	 7VBt2utrKlwVg==
From: Sasha Levin <sashal@kernel.org>
To: Matt Turner <mattst88@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>
Subject: Re: [7.3.y] Please backport e517a172b776 ("alpha: select SYSCTL_EXCEPTION_TRACE")
Date: Sat, 14 Nov 2026 12:42:13 -0500
Message-ID: <draft-agent5-0002-re-alpha-show-signal-msg@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4ab8d1e3-4e8d-4172-b36e-570eb1ef9e11@aosc.io>
References: <4ab8d1e3-4e8d-4172-b36e-570eb1ef9e11@aosc.io>
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

On 2026-11-14, Mingcong Bai <jeffbai@aosc.io> wrote:
> Please consider (partially) backporting this patch to fix build on Alpha.

Queued the whole commit for 7.3, 6.18, 6.12 and 6.6, thanks. We have no alpha
compiler here, so a build check on your side would be welcome.

-- 
Thanks,
Sasha
