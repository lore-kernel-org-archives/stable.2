Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3523D28C
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804452; cv=none; b=AbmXvj4gp/R9u4YunVmOFggC8YRKdvyS0m4aQ9wBTwPmpWEynA/daXFGT+SLZUzC54+TSkwurKKYw/8crywA+1jTt7ACiBrUOf9ZkSC6YW3a9LNFWSpclagUucvHTv1CZNEln3Cfkbh8e/8WiSBiHU5rzeVhXD6+mixdd4Bxnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804452; c=relaxed/simple;
	bh=Lxtzh0L/wGThomBEzUkhF9UrC8qQCZqRZU4x4sPsg9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IO9iwrphJWgPsH4k4Ohgh+N3KB+iMei58Im7+BU+/pbSFdGdzhpjAikNojJCtfWILyiRf8mjw/PAxxPm4XtTmlF7swCgCy1s1QhNFweUpfqWk0Hv2R/82MTu2f09LBKSvjZlRmQ1ub2dkvUBGVbSfCwYKnG1E7iIZ8XSpaVMeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlpMZifO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlpMZifO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713151F000E9;
	Sat, 15 Aug 2026 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786804451;
	bh=Lxtzh0L/wGThomBEzUkhF9UrC8qQCZqRZU4x4sPsg9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZlpMZifOA7R+tSaBe9jSK7LSBBlSqak3chu0lN1U58EGI3Wv6+pPFptjJMJ6VJQ2i
	 b7gjtdS3f3KVQX/luteng2+vYwEXtAc5xeDbuYIoRrbdugOxlkR6PPn9NVweCK54HI
	 NN1K0o7bIT5r32rAQ7LbYtOcDVWL1w/BVuVrO4c6lB/nK37pCXFMkyaTSPZNOsxsf/
	 Wdh4qI79ZIqYpr5qh1FV26J8Tt+kjtvcvTfYhgMHAFY/199ZWKZmsHhz0TB/IICjED
	 R2pWd0IUQC3/6tSUwFuqQRf45daON6VQ/tGCHXqnOY67mx9DyDvmKpq4BrH1YzG7/B
	 tfK4dp5nCwsxw==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 keno@juliacomputing.com, keno@juliahub.com, mingo@kernel.org
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 7.1.y, 6.18.y, 6.12.y] futex: Prevent robust futex exit
 race some more
In-Reply-To: <20260814193000.16@kernel.org>
References: <877blsna8f.ffs@fw13> <20260814193000.16@kernel.org>
Date: Sat, 15 Aug 2026 16:34:07 +0200
Message-ID: <87se4flag0.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 14 2026 at 22:33, Sasha Levin wrote:

>> commit 6d4514ca9cdf61fec4ec634cf50386f6f7e69748 upstream.
>>
>> A robust futex unlock stores 0 over the whole futex value - wiping
>> FUTEX_WAITERS - and wakes a single waiter. That wakeup is a one-shot
>> notification: the protocol relies on its recipient to either acquire the
>> futex (and eventually unlock while aware of the remaining contention) or
>> re-arm FUTEX_WAITERS before sleeping again.
>
> Queued for all the active stable trees (7.1 down to 5.10), thanks. The older
> ones needed futex_wake()'s signature adapted; the logic is unchanged.

That's why I sent two batches. One for 7.1 - 6.12 and one for 6.6 and
older :)
