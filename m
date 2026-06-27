Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FD2701DC;
	Sat, 27 Jun 2026 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578145; cv=none; b=Emp8fA6Q40bon+QgvrWpmyRPO28PQHAJIr687ac9GExx78iDF3XEAJp8jV6xMOkqCiRWFvnhYevjvjBB5resEVBw89KdkT70D3Rz7VpU1RZZr4vPKK7DOYXLTjqpuxKupt2QJC0oHSHNwO6n03DARJsoW2PnpNSKvQOC8blTJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578145; c=relaxed/simple;
	bh=BI0aVFVn2gPFp+jQXi9c0CU/fJ9YlsafViDvbp2j2tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBlhdCs8oWGiCKJD+wqFSt3B8ss/xNry5vFthzIGArTyhO1CTExxp3lei67qbT9u7sfUcuUgyK0pAXnWVlQZbrXc2E+2M8Cokh3bzSCZuGi7Bm8oNTkLk/SVGhwng6m/k4Ub9KLbQNbYXg7OFYJgMga6muvxGsloZfDlmd9R7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ0CwFGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ0CwFGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEB1F00A3E;
	Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578144;
	bh=SOW2A9X67pJiFypuasGaNCH5S7wfwdO9WUzAegDlmvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJ0CwFGrY75wg3xZLjVyVQhxHTkb3fhfKRct0ivNmrNFrYyyQvNf5riwxB6wwH2Ue
	 W72naKrfmuEgZdFDNE9Vk0of5zYsV7BL/Ny6v1oakUHd2hClfVC2V/xG/NTEn0cw5s
	 5bVyvEhZH2vX7y+6mxKeKWS7zPoP+pB4SYDlN0a7NFGXytC2LNEql+4I8bNj7dCg9K
	 DjaQyIe0FDVG66MWQ1yNBBhLlpevkDtXFwjdrBAVtlGj+ciJmKPjzM6wbMoma2PhDp
	 qscKxgBwkE8hRgwC74qfR66X/xsx9gTJNnuvq3YCR/3xRO1WFpnY2YK7J6M60KQ5jT
	 GeGPRbDPGHF0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	andre.przywara@arm.com,
	linux-kernel@vger.kernel.org,
	cristian.marussi@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yijia Wang <wangyijia.yeah@bytedance.com>
Subject: Re: [PATCH v2 5.15.y] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported
Date: Sat, 27 Jun 2026 12:35:31 -0400
Message-ID: <stable-reply-item016-arm64-sve-515-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627032259.2086191-1-wangyijia.yeah@bytedance.com>
References: <20260627032259.2086191-1-wangyijia.yeah@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 11:22 +0800, Yijia Wang <wangyijia.yeah@bytedance.com> wrote:
> [PATCH v2 5.15.y] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported

Queued for 5.15.

-- 
Thanks,
Sasha
