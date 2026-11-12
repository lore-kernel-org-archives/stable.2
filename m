Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487813;
	b=zYFdvG24KK3KsuAG19aFwDuf7IbB6LYhsex/sxVuHRTasKngVEquOAyTjpdLzC6Ki7Qw
	 x0mSwEZvlxDSUplMAEcZZsZCN93Ulr+irtwoZrAt+aWyH6HnJpsnPIhO/rj8HkDkGVj9h
	 ge1Nm84XTOQS7hhI7F/uk+PHbaf+3BJ6iacf05Vnw/XNEMMPedFp27BFTUseA8UnR+FCC
	 Ic7tgAGdulbBe+TsQuReBhpltgYv54P7GUCVqS3dIs3mPe3TDU7o32ZRIMabrnTm6hfYo
	 Rp48ExR7HaoXy9LmRpAsr1Y3Gm/TaNk/BLiS3YsMMy12HXo0Hcp7bbGrSh909kiLZiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487813;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=1VUkhqSWYl7nat9X3+5adU9N9ySh0tvz2E+9ERMJ2LUqp9yogOYkkTqR981woIYYYKXF
	 8UZFD5J72Aid15vz9HMi/TjdtknA7fQZTf4KXIqd5kmDq8La1hw89o19Jz+DCpqK7p9W4
	 RqZw6RGPZ6f8e85CFhfXOp/CpbloJNCLtrKmlyX/82KmNiYOHoEtM1Fsz/18hWaEAppso
	 +iN1ZQiZ0dx86nxoxdtegNCz8gosNOhZ8rlJYz0KYdgKMuTZ+qG73gKGjFBfZ1sTNyaiq
	 TTVrGqFv9y4UhdmBsHr4Og5aJOKqjmiOFz7VC6q8jJp3XxDhzKK8hcUdbpPbmRGkLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkxOe0Wl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA9606A321;
	Thu, 12 Nov 2026 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkxOe0Wl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFF31F00A05;
	Thu, 12 Nov 2026 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487813;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkxOe0WlM4C0HdlVyMnguEBZMJ/Bo00lb/4UxIIeYzDXuivUCQD1LZGGOXI03wno6
	 x6e789SsCy5D0fBf3TJon4D2wCkIObhvMHR925cniwOwIrINClZQ3J26qEJyjslpl8
	 dmF8kLJbHbgTMXTHKsxT5MggRb85qGDOGXLYdiNWVwOGMi3mMeM/eWI6gAx5cNJGqO
	 GdcD/MNLz90Vp5ZIusgtwpngmDwPV1JnQWE9/5zm46PZ+2H8QyEP+NVaJwZPS81Guo
	 jPFU5gLTCGzze9r/l/2OqlrFc6zHbsdINJHAy+La63dPsrDVKLoouvAjc/FdLxWyOb
	 p47zuvgSt88eQ==
From: netdev-bot+sinfo@kernel.org
To: Hang Nan <2122295973@qq.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: mptcp: take token lookup references with
 acquire ordering
Date: Thu, 12 Nov 2026 12:50:11 +0000
Message-ID: <179448781176.2168702.6465221700323549644@kernel.org>
In-Reply-To: <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
References: <20261112124547.193812-1-2122295973@qq.com>
 <tencent_28A2BD1631FE531992E91753BA6419FFC506@qq.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
