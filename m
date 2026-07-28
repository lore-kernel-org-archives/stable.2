Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6E3D9DAD;
	Tue, 28 Jul 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255018; cv=none; b=jDbsrPaiom67aRXhWKzjqgp15JP+xtzP9DaO7vjoCfnESS4xMPQLW1/aTECtC3RrjZDoo/1pkiWnrWkG1KpVy1/xGmAUCtsEDxnKtUwNJRz9qEKoc7N+XzBeqF+iVtvYQF18npNXWKXHu+pMKNuy6FT3SYwlmN+kZU2eVZQCeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255018; c=relaxed/simple;
	bh=C7zAtN9Qykt0frGx0V4LDXZChU1I/OwRolmy7ICVPWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUgNYOdWvxKKFm6zFyZIo8kBMog3+Op+DfotpP7AliBCGmkoyxxWP7aXDLfbu1MNqDKrF2M6TkkyWdx2Ln4YBen82Z3WUV6l8Xdweh2uelZlrXG0XHKgugBBXMJWb7HM7/ey1Tv9WBM2NbKjEIwJ2HS2+VsLOTWWfrAvZHzv/gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwZkmtlO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwZkmtlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5AF1F00A3D;
	Tue, 28 Jul 2026 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255017;
	bh=NNcrZEoIgsjRlQfpNUSscujkjqdG5gnXOGlFPul8Vj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwZkmtlOEqgJzxP9kpxKylRr1oAVJ4H0fI/oiWcXpKrqsZJaulION1aJcFgKI+3M4
	 J4+d36B6uxZwll9fPB9kvEt0BG73EPSkLHD1Kl0SVvG/W3Tq7zQfy9P88F9zqN4Ukd
	 nm9hEAAYIlrQrm+e4r6jEUtsr1/3cGJ10rxv18Mr6bKquIxGeECPh3oTeYCWiZqQzF
	 GKXIBYTyRCSZLdhYXPGSMTmOKxd23bi9UOPxu4RgROTujexaQpVlkLwqnMg/pmFVEI
	 2VWS6A8SMz7vtptcaQG0TzACaGm/iRz43aq0/ncIgTRT9POaJJrjIowgRa1uRT+ByV
	 MmUGIKR1T1sbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	info@starlabs.sg,
	ast@kernel.org,
	lulie@linux.alibaba.com,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	dust.li@linux.alibaba.com
Subject: Re: [PATCH 6.1.y] bpf: Fix ld_{abs,ind} failure path analysis in subprogs
Date: Tue, 28 Jul 2026 12:09:59 -0400
Message-ID: <20260728155654.stable-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728094937.110393-1-lulie@linux.alibaba.com>
References: <20260728094937.110393-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit ee861486e377edc55361c08dcbceab3f6b6577bd upstream.
>
> Usage of ld_{abs,ind} instructions got extended into subprogs some time
> ago via commit 09b28d76eac4 ("bpf: Add abnormal return checks.").

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
