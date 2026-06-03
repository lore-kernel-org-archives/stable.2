Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB736A35E;
	Wed,  3 Jun 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520819; cv=none; b=DA22FUYvBAaRF/2VvCw6l0IQh+/v6sIIPVJQgJQsoiHrG2pubBOpxzrdp0v52hSG85o789L4alww5y1ZEmPVVkjfdfgfFoCrywLRbHMCsBg7UcvwzycmuE9L9zkxy7qAK2UneOJRzDxGEXejcc+dDtCTkyLiR97mW0UqUVIAhd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520819; c=relaxed/simple;
	bh=b569LO8bKVVvgOBZ5ptkIZ7jgs19zGmSuLPYmGanTew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=da6I/z93NcMUA/X58WI2U4OZtIxyq210hZKyouBVqhx8dfYqCGdGk8/CKL6BGWq/LO9kH0Mx6lfyPzlJqcldKJ0sq7E07eAQn8LRa9lXdtglwNUfBy6G2rIFgHqDW4PE4reTlH2hxYKZ1FUNNrjKVD/p7g8pXlGxOHzvII/Tows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMhURuLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMhURuLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121991F00893;
	Wed,  3 Jun 2026 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780520817;
	bh=NpR+7wiWD/rAqFXwbqkFvRjwiyFhI/b0gfggdBOcQ88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMhURuLlHGDlvB6QpQTxQx5S9YrNGHnchwVLyYwGFIsRglLGagiWh+UzdrxJhbusX
	 hgyhmVSI4oRVvwLME9RPwi9D/i/qY39jQXCmIt2xFOI97GxoJIDAuLmhMK9IWYYaEy
	 Mg/guVntqWuMU0PvYosopL4pZ2VvCEpkgvNmVZsH2U0zwEwiVamCXKdtiBlllQqTMO
	 D8LIqrT+1IVf8Ye1HR3usgc+r1yJL+/JFqLaTazRGS6vUVTV55GvH+rGie0FUdN7yr
	 naRA6colzZeXFJDjmTjJyHO/PkMVbtI7TJUeFhn3Wpaf9tBFfUOp/bBLamQ/Rmmisb
	 QIYsNXsJn47cw==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Fix DVM node events
Date: Wed,  3 Jun 2026 22:06:29 +0100
Message-ID: <178051622492.438149.8722719507583787401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1af20ba3fb35cc507e0d74408675b50340feca39.1780065225.git.robin.murphy@arm.com>
References: <1af20ba3fb35cc507e0d74408675b50340feca39.1780065225.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 May 2026 15:33:45 +0100, Robin Murphy wrote:
> The new DVM node events added in CMN-700 also apply to CMN S3; fix
> the model encoding so that we can expose the aliases and handle
> occupancy filtering on newer CMNs too.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix DVM node events
      https://git.kernel.org/will/c/5936245125f7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
