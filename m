Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED007223323;
	Sun, 30 Aug 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788058905; cv=none; b=lLQanP4YjDPXi63M7pP/c0a6xbfW3F110YS7rMbleNOQszeiXE1Q1GqVtGRIM2tC6lktcXShX7+h6QRSXpywkj2Gug6d5S/BxvUcsTlPg9gBurY1gtqwZWbeR62Vo3eGKRgwvXoP/z/rLVcyUpvR5/4CnTcDJJe7ykRiJUvs03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788058905; c=relaxed/simple;
	bh=J/fv7QqX7SSRt0D0FHPDU8uAYBh+QfS4lte7hWukXfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhGWdr/+2tpN8sEuJorbJ34C3SwEt5xHyVwMh66V1fal+92wgw8o8SgXzzxm5CdBJX6ErTWSd4WJt52ONwM5NU0KY56jtFzX98Ivd+P56gvy0gUyVFYYCfVBT3Wn2gKWY8LpCIEEYskJU6ZUtG/kMNRoFbLzAbWUqYgpUsaoCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsCTdnpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsCTdnpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB61F000E9;
	Sun, 30 Aug 2026 03:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788058904;
	bh=Q+ief/7MXRUhTKAPBX8J/VzPvrDpOiSEd5e0OdK358M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsCTdnpCEfq5yC+vOA2Ib5EFU6dy7tqAESzY7haRckOHV7nLeo8NiNcoCaXZiLfZg
	 /WQEKzXLg9yV01XAtWi7N4t/C0OBTrBGe8VXVmSA09PfGVZYEfBz4PKVkKpdPdL0Ih
	 +lXclO8kzm5lxHHowobAIiHgy/644AgDa6zfAI1SEHalTTnf1iS30l5mN7iHqt+vGp
	 gXUZlZz1VsrLa5inmhqO0T6KCazY2ejLWzNxdDNVn28nlMR/VNj5VqBHebchR5UN6F
	 tPi8NIKaWE7Uai+x3y6y++nIn6dtXwVAGyZ/Fdcd5r3A8lpY7CQkn6qlhCkc9HaHwW
	 Kg4HKvECpTD8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	tao.lyu@epfl.ch,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Subject: Re: [PATCH 6.6.y v2] bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
Date: Sat, 29 Aug 2026 22:56:41 -0400
Message-ID: <20260829-stable-daily-0001-bpf-process-iter-arg-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829032748.2324743-1-xyx2021@mail.ustc.edu.cn>
References: <20260829032748.2324743-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 29, 2026 at 11:27:48AM +0800, Xu Yunxiang wrote:
> [ Xu Yunxiang: Resolve the verifier.c context conflict by retaining the
>   6.6.y BTF lookup and its regno diagnostic convention. Omit the
>   verifier_bits_iter.c change because that selftest does not exist in
>   6.6.y. ]

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
