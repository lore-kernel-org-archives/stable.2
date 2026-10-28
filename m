Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195111;
	b=2lXZKnE/yriFOhQeEzuRVIBHRZZ8eTPzsmP5PZjT3cId2bHKNUyxJiN893dLPccNh/H1
	 Vf9oM13PZoMlIat07ovUVakH6PjOVfTCrHvj2ZCUSV917Dux/rXdWBUrcjtmfbz9uLMZv
	 ykfUEQpxez+IZE3A4fcCGPzTaUw/iBGO/Y+4l1pGyu/c84Rt1+0vT3owls6/r6d1mD4UY
	 A5W7BJD1QgJFcz3avWtoFvuBnHzeiGZVSkhEoKKw2P5sqO9+ohFWI/dX0esxio3Lrlco8
	 lP1hQdJKMlCNuX4AE6uEOy1fGLO1W7bgj74uoLsRR5HZdZpAYfDwlU1EZLSISSIOtOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195111;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=opzdp3tWFUH++3YejJs1b5n63O1y8G6hkh2Ie5rQjiE=;
	b=fhOClhaNylqLXVtXzjWavkFo+HB+9MegBpmGqOKf3paRPMSiP5AwMoRqNKPPunyky7hG
	 JZsuKDiYaC5Th/luuqou1eVp+tS5qAJXrGehT7s9ahoX6HiW6Kll+w8ApjvqCQg9WETL6
	 rfYugMffAJ+YPgFXw74G3IA3LWpxqEH3Df/HkqX8huGT0HP4LWH1RKFdBVkFB1Bue6x0A
	 jsMw7h0dTL4PcdqwleRQTA4/ScfZ/52PLr3gO/Xrvge6HIp4c3uhoAPHcT9JHmOkbZeKJ
	 mCN2A9bufRTwDTEbuNey2RIiHreshMrxW7W5VvCshvAznBIgVuaX7NZirGld7GNOLXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1PqISLP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1PqISLP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3711F01828;
	Wed, 28 Oct 2026 13:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195111;
	bh=opzdp3tWFUH++3YejJs1b5n63O1y8G6hkh2Ie5rQjiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E1PqISLP8cDUH0xiLKVCe1dUiyqgJZzXkvENl4jaC8sop0yNs9oN16+TbkvtU8AEV
	 IYX876mVolBqqCP3UXJRWjvxfGyP0kkYOlpRbz77oS4ce7wQ6AWyDEGZ4TARKKR0Ks
	 vaepkmaTk2LHD7AJcCudrA4uYr8OV63JIa3HUVrJrRexGqOWaws6D1QqbUPXK1qCkt
	 Ki7L8Z1sU2A2wabQ7OfcFZsx0gRsPxB6tgDNVSTMb3P7NnyySm7d6lnfMadPBY6Isa
	 kSBZVGjkRdrnEQoXRuUDUKIYEvB9lBCxSGBz1LcWWdKyNNUKiAVt+/xcHVRt22lBbI
	 5kRrEBD5hAkYw==
Date: Wed, 28 Oct 2026 13:45:05 +0000
From: Will Deacon <will@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	catalin.marinas@arm.com, broonie@kernel.org,
	linux-arm-kernel@lists.linux.dev, Zhang Kunbo <absoler@qq.com>,
	mark.rutland@arm.com, tabba@google.com
Subject: Re: [PATCH] arm64/cpufeature: Fix malformed SME I8I32 hwcap entry
Message-ID: <auH8YYUGAZblhf5r@willie-the-truck>
References: <tencent_7F47B27F7FE811035796A0AFC61993769409@qq.com>
 <2026-10-19-1-daily-reply-0021-arm64-sme-hwcap-held-6-6@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-19-1-daily-reply-0021-arm64-sme-hwcap-held-6-6@kernel.org>

On Mon, Oct 19, 2026 at 04:55:46PM -0400, Sasha Levin wrote:
> > During the backport of a75ad2fc76a2 ("arm64: Filter out SME hwcaps when
> > FEAT_SME isn't implemented") to v6.6, the I8I32 hwcap entry was mangled
> > into:
> 
> This is a stable-only fix for 6.6 with no upstream commit, and it has no
> Acked-by or Reviewed-by from an arm64 maintainer or reviewer, so I am holding
> it until one of them has looked at it.

If you're removing the 'depends on BROKEN' for SME in a 6.6-based kernel,
then you should be grateful for the build error. The runtime errors will
be much, much worse.

In Android, we put the effort into enabling it for 6.12 and that involved
~50 hairy backports.

Will
