Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE0374A1D;
	Fri,  7 Aug 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111110; cv=none; b=jyu/ZPajyRPTT7QtLvxdrJWnMXLXMACdGWTsvhcOMLnQDiJMgKrM23RZgxo0FKH7kV0PwdKdzGIg8NsBjFOaKefGO1xZ8BZSVundixiL2VIhg+AlKQ4/+Aq4HVlsnjysYypVIcth3nznUnCfUMp0u6et8FmO/mWdpEW7UDZGgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111110; c=relaxed/simple;
	bh=v3YM2N3DRd637DVKXyQ/GKT7jRYHB+7HXyKtD1c8Qsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUdV9rZk3ejCtWUdhykCTWTxfMkLBfqrqdv+DQn7jWX78W4np9UVbJIlHbnIOR4sQGH/MGJZa6sa5+ccpLgH0PUaU8Q25dstBP5+hosNEG1MlQ6UAnB+X1HazqJUQUcXhky9XSQgwLo3Wy/ppbEPURwFukkASHUmNJ8OvuSzFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/3gjV7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/3gjV7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7B01F000E9;
	Fri,  7 Aug 2026 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786111103;
	bh=zr//l4F2y34kbTwdCcCLYro/yeJtktwRWdx59Z/fW1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R/3gjV7lu6cX3mypQmgQ9nlDdJOZGyxCriEvefS3DURGBLUlqyYjR53WFMA3Be9yc
	 KYCBfHI1FfjCOV2mfSxvUgqwyvfVGdi5RCIeTGIiinOdNXJbmZFc0XMM1tFdSgRo9s
	 4qiBQJh1aQ/6bfd9kTC6QCMlo9Ng+s91z0IvtRZ0=
Date: Fri, 7 Aug 2026 15:58:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ricardo =?iso-8859-1?B?Qi4gTWFybGnocmUgKFNVU0Up?= <ricardo@marliere.net>
Cc: Shuah Khan <shuah@kernel.org>, sashal@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH] selftests/bpf: Fail unbound UDP on sockmap update
Message-ID: <2026080745-difficult-batch-6866@gregkh>
References: <20260807-selftests-bpf-sockmap-v1-1-8c4936fa03cd@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807-selftests-bpf-sockmap-v1-1-8c4936fa03cd@marliere.net>

On Fri, Aug 07, 2026 at 10:45:27AM -0300, Ricardo B. Marlière (SUSE) wrote:
> From: Michal Luczaj <mhal@rbox.co>
> 
> [ Upstream commit 203b06932777b9ad5085319389dea566f5c2ca63 ]
> 
> sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
> check socket()'s return value.
> 
> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
> test_maps now that sockmap supports UDP").
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Link: https://lore.kernel.org/bpf/20260707-sockmap-lookup-udp-leak-v4-4-f878346f27ab@rbox.co
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Signed-off-by: Ricardo B. Marlière (SUSE) <ricardo@marliere.net>

This goes above the --- line, right?

Please slow down, there's no rush here.

thanks,

greg k-h
