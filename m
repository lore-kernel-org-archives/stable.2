Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795677723;
	b=MguB/9RNrY//TMjv2ZFa1h0lAPieg9VoQBtt3Pq+jjyaNMH/9qZTgjdBXofDPRdTcLB0
	 c3lCYZixFxz/VrdFkRUJOGt2GcsTdZhIj3afT0vaU2pWWDwCPo5q0fFDCVu2y/M7wiAAH
	 o1B30wXvOR7TrO8xPIcCLKclkXrp+IhQkVKDFIReDKKEArav6l97IYLoZ7+Ko2l5hpKfA
	 SQtkZ1UcWWd/AiXJLecv5KxwgePl4YutfXDTus7HqppgseYGGbqVA5shxXMUJxb5cE4tG
	 XEGcFkt7RCaxwKMlqg8VQn5Lx4kEdopltxmjN8iqBAzIuN5JsmDOMIvvWR6OQ0EBGcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795677723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cIaYGz3NPij0qtZB58VJrlaUl/vIDDdiKxwM1byHYKc=;
	b=c51sa6aR1OoJengyxlemwSoK+Baxf+B5574UDFXVeqA2rx/qPWVXPB3eg+zBnoUrGNTS
	 cJKVh1+gT4+YT0EP1JO/jFQa3A43QiWP3J1CM0Uj9+tL7ASPSMtgT1VgJFlE2IXBlY/qV
	 g3QAF9SXlF1Z1IURrHQG7sv1Z9KwxEeSZ+PGWrX9DQ/+J0GD+BmXcovKBkxZ23tYPj4yd
	 yUmE6gU4KPzuN0jABg2zHbSutN4B0s1s/3aSzLvP63ZO5Ca4HhnfuxxQaHbXRYld427oy
	 vvsYEkc7lzxp82h6LbXgGGRJa2rCgQ0QbWLxnwCnzLWpYV/vZmTWL0+x7MivB0l119g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vNlReoBc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F01606A31C;
	Thu, 26 Nov 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vNlReoBc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0431F000C4;
	Thu, 26 Nov 2026 07:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795677723;
	bh=cIaYGz3NPij0qtZB58VJrlaUl/vIDDdiKxwM1byHYKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vNlReoBcQmdzU+Vt6N44inAVo/Fc2ojJ5ykE9JYFJZDu7wvLl7slDQQkDt8+wU9Pm
	 RWr7+EeCzbyBNquD6WvNtBbudatvO6LAepV2AFOe5EeAC5kKyciq+aiOAVDnRqdDT8
	 iYeQyOD+gHj5JIyIm/bJhhzUMZd8pMGjY/Roz7ow=
Date: Thu, 26 Nov 2026 08:21:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yingke Xiao <inkxiao12@gmail.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org,
	sashal@kernel.org
Subject: Re: [PATCH 6.12.y v2] bpf: Reject NULL data/sig in
 bpf_verify_pkcs7_signature
Message-ID: <2026112651-peso-sandy-64a1@gregkh>
References: <CAMcAce97zgo7c2f5Th9FguAHEL5gL87NrJ9MJkJghMm6M44g6Q@mail.gmail.com>
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
In-Reply-To: <CAMcAce97zgo7c2f5Th9FguAHEL5gL87NrJ9MJkJghMm6M44g6Q@mail.gmail.com>

On Thu, Nov 19, 2026 at 11:55:07AM -0500, Yingke Xiao wrote:
> [ Upstream commit 49b18315be4e590fae0fc39c87d46c87e9ec903c ]

Not a valid upstream git id :(
