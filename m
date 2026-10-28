Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227981;
	b=4Fg7/x/zoRO172AuenHHgtdHEMCaoKakDsFH9PTEfAKwmnK3SYoqFf0rJARTGT3EOP12
	 R/wWhNqwBzLI91cGeoOF9t0/zlowetjE5l+pYW0HX3ggUpMunH4qO/i8SWbInW6R7jaIU
	 58xNT6dKQswygEj60TKUa0ARbLE6JfH4kG0UWgRl3hrf5S0DuWL7ypNqoIYMjhjXsA7Q2
	 tlC4MK7JjffLGqLXHS7hRE2aHp/VfTiDZcFHD2/vKwjo6dW7i3EoKHF0tCKub788dUo6O
	 erCpaUOQbwYIn/PlOHDh/8vgcu9lqEUuyz3xg3brMPNqnrIhRo3hoh0wQDh88UShKEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227981;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7YC5j2ssFWEjwqFWHWsXZEzhpYxoMIwo3twbK6FLCoQ=;
	b=YQ9I89ylNIJ8tjbUqE8Vuu5XSlRNMbLGKexzu7Zb6fQ/I/ntlVSutjbgSJy5HDBaBhd1
	 fPt7Vj5zxCLT2Sv6YNKEhLxFPmNdGtSv4MEF44clmZ6UHax24dtEXoZVczEDeNcaK9HGJ
	 kUe1AUz9MjTXBfVoq51XuCM+FU0OfET7Y4Bdu7RWNW61hCKPyJiH8M0wGIJY0h0roWNPp
	 K2IZpVqdqp8uGftZtjHNTorwxWDP9yl1Q9rp57niA+lXrfQ2PqP8K+SkMZFAfFyANvJn8
	 DTXeQepi44YNuKMFcfaPoOKsfDpAEtMWRz++pBUHBFF3h0Yq4JyXcKXZmm2LBHaL8+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs2PlsKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1C606A31E;
	Wed, 28 Oct 2026 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fs2PlsKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C021F01825;
	Wed, 28 Oct 2026 22:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793227981;
	bh=7YC5j2ssFWEjwqFWHWsXZEzhpYxoMIwo3twbK6FLCoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fs2PlsKOunPf4mKdtCRP70bP22ox7atM6qZeeuBZrh4TgWPd2m/vEFH1Encq1t75q
	 8gXBNBQKYKLusuNIe1IODcpPTbkK6f8LcKqrUa0UGLaJ/kpQHDBo3vB/CqB23EkXls
	 ccz34BWzeZplGNlqgjC285El/IckQ1YdUXc0ZfbXFLcv8vDsqafcBRMV4axVrhwHGr
	 TyIDOFUJgKt8BvRZJMAF6HoTlk4oAFXtzUQz/N/TKGYu773x1oGY9ywymC30hsXFP5
	 VczkO4jcIq5vSx51Z0pwNRWHeFrqsQYFsMcxoBHTsYMF/okMlEjaGqODPZ4jIGEY4A
	 kzBJLJT4+Tp9g==
Date: Wed, 28 Oct 2026 15:52:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Esko Mobius <echoowall@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, Thorsten Leemhuis
 <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
Message-ID: <20261028155259.280feac5@kernel.org>
In-Reply-To: <D0F0DCA1-9CAB-4BB3-92CF-223C9ECA9BF5@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
	<20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
	<20261027161813.3092f32c@kernel.org>
	<D0F0DCA1-9CAB-4BB3-92CF-223C9ECA9BF5@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 11:38:24 +0800 Esko Mobius wrote:
> On Wed, 28 Oct 2026, Jakub Kicinski wrote:
> > Is this your real name? We need a real names for code contributions.  
> 
> Sorry, it is not. My real name is Yongjian Wang. If you can fix it up
> when applying, please use this identity as the author and sign-off on
> both patches (and in the Reported-by of patch 2):
> 
> Signed-off-by: Yongjian Wang <echoowall@gmail.com>
> 
> Otherwise I am happy to resend a v2 with the corrected identity.

Thanks! Switched up when applying, hopefully it doesn't confuse our
bots.
