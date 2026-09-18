Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865F52F27C;
	Fri, 18 Sep 2026 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768604; cv=none; b=jztceA8fttO5Yx/IoxmjkoWj6a24bn+43uyV8ArG1cf0VUh8YvIZdtkmodYq70H1cFPciJo1IEDG+S8xmibsd9Ii2MI7DC2zNP1oh97HoaJwavjhexfyBHruftGIv2+dmF6TjGfZJJy1QQXgFeNpNXEGMVxbwUCqLk9S2/4hYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768604; c=relaxed/simple;
	bh=dxbYY0Hg85299HjVSe4S+ZHwNTIvmY4RrXwD2rTL1iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxSpQCRPeY4gYvoz8HG01EeRCj9P/qRD2GlOGIH6tk+kc3d7Xtj9mA30v3ZXeSfZzIvt72yb/RutlNfUrwNZyuKTVKXhB5WlGDe83tRxNH/wPb8UROd6Fmc8V+0/+SyCcN9evgrBfZbEOgfD6P8vS3CwvROVgC/j/jlYJAmAGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMvGcbeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMvGcbeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC191F00898;
	Fri, 18 Sep 2026 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768603;
	bh=dxbYY0Hg85299HjVSe4S+ZHwNTIvmY4RrXwD2rTL1iQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RMvGcbeBi+khVWRggdodi5gqDmqgZ9QgkC323zsnvqqZri/81c0Ws/uat5E5+xIXO
	 nnJD4Q+iCGmTUL+0nnoC51aQlCEIRN/mUhqVwppi+dOmYPogD26qKSvJsaozfg/bEg
	 gx0NXo7VGbhMPVhAW5N6eHnAIn8qSeib9RJDzpB8jJjb3Pzm5WBbAPZCb107k3i+L2
	 s6ffH0wX9D4n16ZelZgxAPt1jNZY4E1OaaIRYGgZaGw9/YeX4WXYmIM1NSioQ7wnFG
	 Mvk9k0waYRG9xPOiKP+ts/il3EVbGlS+CCR46OenEYkpQgHKJpPzdbadWdseUstETY
	 a1aT4Wg34j0og==
Message-ID: <25a17e9e-362d-4252-ac79-f78c1d98c119@kernel.org>
Date: Fri, 18 Sep 2026 22:56:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: sprd: fix out-of-bounds read in sprd_efuse_read()
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>,
 Srinivas Kandagatla <srini@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Freeman Liu <freeman.liu@unisoc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sanman Pradhan <psanman@juniper.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260904003815.462352-1-sanman.pradhan@hpe.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260904003815.462352-1-sanman.pradhan@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 1:38 AM, Pradhan, Sanman wrote:
> Read and copy one block at a time, capping each copy to the bytes left
> in the block so it can never exceed sizeof(data), and account for an
> unaligned starting offset. The NVMEM core does not validate offset +
> bytes against the device size, so also reject ranges outside the normal

if it does not then fix is in nvmem core not in provider.

--srini
> eFuse area before issuing any MMIO read. Fixes: 096030e7f449 ("nvmem:
> sprd: Add Spreadtrum SoCs eFuse support") Cc:
> stable@vger.kernel.orgSigned-off-by: Sanman Pradhan
> <psanman@juniper.net>--- Compile-tested only (NVMEM_SPRD_EFUSE,
> ARCH_SPRD || COMPILE_TEST); no Spreadtrum eFuse hardware available for
> runtime testing.

