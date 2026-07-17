Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5A30DEB2;
	Fri, 17 Jul 2026 01:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252277; cv=none; b=LiLMKBC+nVYHCtD3inuYvN0Y21gU9HWbuubHRK9hhsdv7gRGGmnlFh/eP2vB8pDQFhUaa+jmPlSVUpmCvQlMy0sNJeWXRMFMHdnqwcxk18tHnpfng8qr2PkuOeNAJ7h71zLLV55rpLRHWCnNRiCI/7flJsZYwt0n1Bc1l8+K66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252277; c=relaxed/simple;
	bh=ZDSjLz/D2uphuq+GHhV+cR61KHhnKRRXT47L7Laew4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKYUp8yYfAvaaW6Y+v/glyPDtiJU/aoGIPnIZaPbXG35U19zScOn+ShXLfPDcnTFvl19889mFTBYPrJ9XDltgxutnmq3sZh75YWmuAlRM84TXixmZpInGfeh21IfM82+mYl1pJpx6IiMck8uYv6fAz9jJGF+qkZ5dVbtETA4bEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIjUb8Ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIjUb8Ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CDB1F00A3E;
	Fri, 17 Jul 2026 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252276;
	bh=HQWHI05VLoFmTDGLD/8BrEB9TvW9zVg8VbA2I33LjSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SIjUb8AeamEEXIjQWPL5g2nKM1WJlVr1ofaI2WGxaJ2yDbrytsFrAgMPqwGwBmtN3
	 7NYI8KEj2LUXkZvvOcs+bda2TUbTbPvjTA7U1Y/MJWyTSy0xhHYiM6XypYjqBoEgSv
	 SoQy6esckD/8rVLNhc+/4l4BIaFbBXn2ntmmt+8PIZ5PL7qeD/6FzvfVqrC9fz07Iy
	 9Kq1WenZdQeSgIToBYH4qXZFlG+/zUqILKX9TbDrN2bbIbHrebV464VadK2s1PDePJ
	 TKQF3Ppf4apxHj75gEcdvUJfgJxACGi8UvkwbliDGtzXVH5rf/40F/QNKhMPldv+Xg
	 J4GYyJpJDbt9w==
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
Subject: Re: [PATCH 6.12.y 0/6] cBPF JIT spray hardening
Date: Thu, 16 Jul 2026 21:37:34 -0400
Message-ID: <20260716232340.0007-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
References: <20260715-cbpf-jit-spray-hardening-6-12-y-v1-0-d8585a9aed80@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 02:27:39PM -0700, Pawan Gupta wrote:
> These backports harden BPF JIT against spectre-v2 class of attacks. Without
> a predictor flush, execution of new BPF program may use stale prediction
> left behind by the freed one.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
