Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597011;
	b=yxrWCi5NfaWFHeXyu6TdYPCj/oc+EFN2dqobKrUxkkDO1csntdFpmv5yec7hwM2LwOJ1
	 Nv1NMhfo7Lk7iCJxFn+qhauJwLXOqm11aAa82dZaoZWQlCFTBc5fFwBgLR1RYisHZ0nEs
	 Dv/I7ovISzwFJ+mVcrK2QtEN2Yi8TsMTjX3Dz3Upq3QPYFw9nzqmYNSpefBA8TKMZXb8R
	 sZS7P1OrwrtS75Q+fGDWDU43V73sKxWvUaKXWnhDBFdJOCu3oleHNN0sezDNuEaeXSGOJ
	 l/msYZ2FloEl8S88TqLeDxDfKyVV25K5TkF82SID3mQhXHLJmKGYpG9USEm3ZVXnNsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w1+gcJYOOBT3546OhhrWsd09OEI3KoHs3G0Jie+Nnw4=;
	b=cLP0DZN8cko4Dq97b5WtBQbaEF5cg8Bhzn8tSAsS+EOrgDnZ8HEKckNDztiGAT/+JBb9
	 Uo8Sflu5bw19b8eMeyYJPwFG3+vHQvg4UMP31tEgF/kitGcVn6e/klc2pOxwm8ClAEVKN
	 dj9yTRRAvPaLn8DeF9QZWG2EExlMEXp/l3vD/b4kbzES25Qn3YwhWP50QxEyPb9osaEPO
	 pKzsXKaYHz2X7YcWp68oPvxpoPZuo5QLLFy0cURZI1JTHS0E+PXTD6Shhu8GXeWxVS0EB
	 QYfVrRpNIQeTsut0q16Ahnfe2WN2dpqptPCTr+yWtCJoVpUGwZOk98xNbGn4DwvjqnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrAb8w7M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45610606A333;
	Fri, 13 Nov 2026 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrAb8w7M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4E61F000C6;
	Fri, 13 Nov 2026 19:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597011;
	bh=w1+gcJYOOBT3546OhhrWsd09OEI3KoHs3G0Jie+Nnw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrAb8w7MTqfzm8MiH5mHaCHf/VgiGYeM0CV8bX2NetaMW6C+lKr48KOyLJt74Lv3T
	 qpAEul1JtQsBFHvZTbwV/eF2iarKTA78cx99SdRptcvGCLYEXlgcTlyIQiTuxX5ra3
	 tRHow4CPJxkpy+8/jeUvtMn10SKX7Wq0e+QVmsbT6ZiSOfidv1AkTpWHS6dtaLFVeW
	 OzO3r6K6+hManv73DjQDhJsLDCfvtEb0E1g2x3J/zV0pj5XEZB9jKFvprHx8nJUkqg
	 zat1TEw68k+5UAzJWZtHdyznapa6882PMb/6TB//pejR+PkMi0Tw/nN+ktfGjDou1m
	 tJAjGQkxlxxTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	liwang@redhat.com,
	jackmanb@google.com,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>,
	Vernon Yang <vernon2gm@gmail.com>
Subject: Re: [PATCH 6.6.y] selftests/mm: include kselftest.h in vm_util.h
Date: Fri, 13 Nov 2026 14:09:55 -0500
Message-ID: <draft-0005-revernonkselftest66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113090059.380783-1-vernon2gm@gmail.com>
References: <20261113090059.380783-1-vernon2gm@gmail.com>
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

On Fri, Nov 13, 2026, Vernon Yang wrote:
> Subject: [PATCH 6.6.y] selftests/mm: include kselftest.h in vm_util.h

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
