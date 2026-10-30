Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350431;
	b=Qvz6MVj581drPRwaQYeUCLlUrXDEx8RQEeUvSxUpA6DSTRq8K5IO9OMDhT2jSDrQsK8U
	 LxYo+XiemZPkx4I+z3C4HQ4CbR/DqyM3GuMb4FmgZ0R+j8jofc+1iG037+nDM3+zR5A7F
	 oy8qAxog930VVmGZWonLeNzHP8X6paJDkP3CTs0+VpgYLz+HQ0WbejnyJ2UMJ48Ue/0A6
	 YAY7huoBOmp+jctvyDSTPY3JWMZgdOnLOxaAzb6WLT2RxSDHLHC2OJoxOo/HYm2Md8AD1
	 6av2TRHTSskBTEy5cpJqMUlwmLZ0hGf9Zexd2lRpSA0FESrUN8m49TQLpsaEWA7iynA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=e8SZWBVpBtGPrssPoRGVkSrkW63IXG4Jl5ZfJTJUw7kSkbIPkUZmVBQuDFbIE6awKtkW
	 yQzt0gxy7D6uSUxTEXDO7FPKe5lnqnpWkScaYCZ7lIUcaHQEVaq6J4Vp0Ee7e5YlqeNOA
	 /p4hwxs6SN6I1cYOcDaIfRvZyAJy4IHBmkgN4uRKE+VputW+LmTylIoHIpOD+x3JtEcAW
	 VRPZmBQrZ4dbM/0Uykcx5IO9Os4UrQm8i/0kaCZaYzhQ8u4jzbVa3HsuZ+llEJSynjzvw
	 IHExRvQlAy7Np02E12rhN1GIVCWI8wgyzvXHrXuwCDkchgvi5abbAfxUv+8ZAgh0LfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QySjnKSz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F9606A32E;
	Fri, 30 Oct 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QySjnKSz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58271F0093A;
	Fri, 30 Oct 2026 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350430;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QySjnKSzlFUdafk9Caerh1nnlPJfgamKZzeEXHjYiRsxdbBHmbMVUGNhzRJT7CYDm
	 s0eAC8wtEAGYoZnxso3D5BUW+VHghwgm+TIte12SK2JTvH32d961YCZcuGfwQtueXd
	 SPI5JfS6n59GWUNOE7MXh51ImQeES0MnRBIA7uii28Qw56XhTSXadftJmpyudThUk0
	 4hwgGsRHu2cXPkZ3rI2MG+tHVr9wr777PRDJKRedYatE+vE6NPzqHI1YzU83nOPbNA
	 oK7r7O+4wwakJ9hMz296UarmNo6lk/kkp2AbTXplfhhUTycldnXfxN8cabT+7HwSUI
	 oBKPnowdQ8cOA==
From: netdev-bot+sinfo@kernel.org
To: bo cao <treebacker@foxmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, edumazet@kernel.org, idosch@nvidia.com,
 horms@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
Date: Fri, 30 Oct 2026 08:53:49 +0000
Message-ID: <179335042941.3327.2302494904520671268@kernel.org>
In-Reply-To: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
References: <tencent_AE3DA7423209553B562E5C7FBCB808EB680A@qq.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
