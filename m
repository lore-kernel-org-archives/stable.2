Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7288B242D65;
	Mon, 10 Aug 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386513; cv=none; b=WJfMvdJ6FYczaf8ctPZlQ9UNWHZYrvfsibXaun+gvjnJJoXnVlAlLNPnTohxHq658ayHK+qsuChUuPYTKnr6wRmPIPNwqQqBpjjIgSYgcuc9fiBvcvXVKpIkeeyVewaTiYanP52TgM5Fkn8xuJhmEOKFqCbLmQin/dovaUM3cpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386513; c=relaxed/simple;
	bh=DSWiriXPJN83EsiPkwFRZ0KuOnyiNPR3j/cpPvUMDTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/7twkH87gapPxwXMqX0vcvcnKXP9FWq7jbPjScL2vZnEGCRf35D4A1kInEo537A1NpslPRj5ksXmG+YfoBO1ucNL7ugQ/waqt4sxxb72js2uo/qotfo7PsuSR9pYt9wEECe46klCUI2RN5wvZ41IJZJtabXiohuZrpHdW/j2F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKU92crh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKU92crh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FF71F000E9;
	Mon, 10 Aug 2026 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386512;
	bh=DSWiriXPJN83EsiPkwFRZ0KuOnyiNPR3j/cpPvUMDTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oKU92crhoB7Cta23Z9psLPZ8YFyM3XgFj0Xdjub+1x+QjrA5HPX1aEyagkmE4CcOM
	 d2U9Pz7QE71sDY0bKKxT/YQQmc8+hc1RLWwwTzkac6Le9yf87GOrJBlKfXqW3fUbpz
	 C0xi4nz8I0vH9M/O5DJgws9UDcAV9ZCUopkY236T6hlxpA1WmSZeFdZYhASV91GDVF
	 72PpaQUyYzLn85VwFw3OydbwV6plsXOW+dMjEuvPECbzvLuClKb3iQJGhFOsbK0sTk
	 9QwX362XoFdNfBZKFmiFYfORmm3puQXZVtbzLl9S87dtRf/x59qxQXuGxz4d6IbXb8
	 KFNqTg7tM9v0A==
Date: Mon, 10 Aug 2026 11:28:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lee <david.lee@trailofbits.com>
Cc: Ido Schimmel <idosch@nvidia.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Kyle Zeng
 <kylebot@openai.com>, "Dominik 'Disconnect3d' Czarnota"
 <dominik.czarnota@trailofbits.com>, Sven Eckelmann <sven@narfation.org>,
 Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] vxlan: keep the last remote linked during FDB
 flush
Message-ID: <20260810112831.7b6f6ecb@kernel.org>
In-Reply-To: <CAC_etQG00pK5AT7n+BCxiRFbc_LWBkyBYSDhV-Ngnie6XBq=mQ@mail.gmail.com>
References: <20260810144115.821654-1-david.lee@trailofbits.com>
	<20260810154802.GA2803521@shredder>
	<CAC_etQG00pK5AT7n+BCxiRFbc_LWBkyBYSDhV-Ngnie6XBq=mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 00:52:12 +0900 David Lee wrote:
> Do you want me to send v3? Or would it be fine? Thank you.

No need, I'll strip it. Just keep that in mind going forward.
