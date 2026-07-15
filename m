Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384D249EB;
	Wed, 15 Jul 2026 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074377; cv=none; b=dNlGF6HT7XMnOpVeWddrPLa7q4BEgK9CR7N0hf4KNgKDf/HgH+m8XXtnrjGT6rWV6qXEWNtEB3gzyfjn1B3hX0CRe+VoGAUKn5/ohmCV7QkZTuTYLLx516k2H64wKa6WRnmtgzNHlu++QwAJBpzNRwde58tXHTlZ7WSYaf6cJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074377; c=relaxed/simple;
	bh=6jc+yjp1RQ5OnSkF89Ts/Jm0d9pCxfFq87zIRlLRKY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAzM5k89wx2Ovy6FUOdxPHe6i3xAG8ChDcIt7pQfPwLqhigb3f04MotVZhxsCMbVITmifsLH4KaU2ZBIsW+krjTvl2Lalqrj4OKoaV9uAtEsNIIO6FQyHwIXHcYUSZ7Es6ULqUWBCPuxu+OxFXB1tVNZfwx1QruGlroV17uQHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMYw2Fig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMYw2Fig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E381F000E9;
	Wed, 15 Jul 2026 00:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074376;
	bh=SDbonQLIoOSfVB1dApPM6LkzNs1SHNxOM+rrSsaUBBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CMYw2FigPP7WfHBpvhgZlAhmWy0bpTPXB0dWdx6Sf2hHBsld1RyoxLlCa++abrtsP
	 6EV4GohitQfVk2wKCr8O71Tk0CdeD46bXWbAd2OqoAUCZQKX4FEbqODHs0l9VZXgHA
	 iRubQs5iHitl98Xt++qJSvdKnk6DPP7t4j7rCfrbbuns2ri1g0rNuDJt2wPVOI5RQC
	 Gkks8B8BofuZ3kPdXy6OKqse1ZB5GzONMooax7IYKIEDgxmK9JfdyAwMg8UBJjWMwL
	 te64+fdolGgdSWPyG5+w2q0ZQPCiYtxCHLkkE2gxADmGExi2IMa1LU+wdk/ZFNBGYW
	 n+XWGFINNchSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH 6.18.y 0/6] cBPF JIT spray hardening
Date: Tue, 14 Jul 2026 20:12:40 -0400
Message-ID: <20260714200600.stable0011@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
References: <20260713-cbpf-jit-spray-hardening-6-18-y-v1-0-755f60c55705@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.18, thanks.

-- 
Thanks,
Sasha
