Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961368;
	b=hZlMQCfitsITjcgJ+PASGHd/y/g36iJU0TdWcxao2iUYTBa6bzP0eTqP8Iy7nGim0Gw8
	 xTxvTO/+RjJ4ClpAZC3saOwmJNbolumioeq3p4dfNFAteTs+oL6FqmkOWRsdrLZGui8ET
	 odqKOxGRT8RHsGAd5SN/N2MF7a4loyjScAhhCYq1fOfwdMj6XmaaAifbsxuHw0Zqf0pFi
	 QL1sK7cUVNgXliRKuDQAaHyXo9v8Z9CD2t75gdUHrXaX72eieDM0+4Hzlw0bvAdrkbOQz
	 w/t8w33np5OZjPZhYqfrNxvME2gr0flwh/L0UWrrXNEx705XSbbCXsdoMu0LNzxBBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tDw64PTidKW4tbRkOeBVG+vbMqrqY/9S/VViLcg6PMM=;
	b=t0uJBw+ThDgDh3CDbOR0pGT/pZ3aF079JjA2csSRdvACGfwQyFzIsmJi+aRdoucgEQ4/
	 wGDIVRKvSdj3nhgm2bTskfEtXOe/VGX9ZXFp17VZnaHspopjziITmWc5I+9sa//WItHQ2
	 MJcWMdmich4awadqlz1s/ORjDk8gMwaommTihE2ZwV4/2qxaU7UapusRVBPP2yXOU0dyz
	 ApyiwOvV6HRR+UoNn+T40Qz974TjG5SQ8pqnaoPE0si8qVyuil3vp1Shg/r9OjHSP6ixo
	 gQ+3WlcX8GjxUXADkwHi1JNDsVexw7DBHI0wR+eO7veUscm4d26yR6s6LDL1wCGa+eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0GAUhSE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88874606A32A;
	Wed, 18 Nov 2026 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0GAUhSE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943811F000C4;
	Wed, 18 Nov 2026 00:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961368;
	bh=tDw64PTidKW4tbRkOeBVG+vbMqrqY/9S/VViLcg6PMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0GAUhSEdI2xuc28STR+/Da083rcuE4Y9BI1AQVJ/EOvn4MDOhHyFLvHt7ETfHRqf
	 VDwnmHHwLEvqjV2RlkAkMecsp4lf5zpfOhJqppfZ1hhvVmTITph1zeMo4I1q4aKMgy
	 RRqRFDxaBnL6Lmrfdr3eFFh1KhKi3wL/eTADd608v2YNo2ooKVzABT0xkraAj1k0kD
	 IzhZVN8cBhmSmvg8VC4xtMs819PDA4vCu+d97NjrqwfOxJ6JPTCSVfqaFd1S7StV6R
	 akEfMZkysjNB/iDeMCQAACO/40b4IHtKE7oOOr6BiP1nH9cPRRheOtSqhlQJRVuAS5
	 BOwso0ArGq2BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>,
	Alan Maguire <almagui@kernel.org>
Subject: Re: [PATCH 5.10-6.18 v2] libbpf: fix cross-endian build with newer libbpf
Date: Tue, 17 Nov 2026 19:22:45 -0500
Message-ID: <2026-11-17-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116233301.1531563-1-asmadeus@codewreck.org>
References: <20261116233301.1531563-1-asmadeus@codewreck.org>
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
Message-ID: <20261118002245.zx5_b5yPdHt-10wuyst7c39O4DXkdDuID7G3GifLKgw@z>

> Newer libbpf versions also properly ignore trailing data in the bswap
> case, but the patch is too intrusive to backport, so take the header
> length comparison fix from it instead.

Queued for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
