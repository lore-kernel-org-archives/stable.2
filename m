Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143095;
	b=Tjr4YE1heG53xv7mn47RLbrk3lOLgi5ZXK+YCzMOFpngBjFiZtgpgf8uUcsW5XMQM91b
	 NSZ7OS6MWCjoCYeoR1zAf2Ly95TzvIR67l1zDxiIyVuXXBP2MIF8eawlJFPOoLkwIuxSr
	 4Jvnjhmr7N1BU6K0yBeJWU1AV86WAB6S7VzWtNDS2/JPs7x7diZ0H9QonHTN0RMtLH+dr
	 IZ/MLyJToBEWTsQQxZna/dWW5Q3GmN8O+yHNGyUwesRBSJealblMXCQDYadoIaD5+/Dxw
	 wj3fMCNzdJkUuf66/VeD4q7fYvsDBcP8Ol1c2zptKt/tLnBI/6qNzMM2qb2zT5r6YHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143095;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QFRpBHs1ht9jGMmD2NyMPobbl7bAUrPuIDNPHO1dXlY=;
	b=FGCmkWR50F+zhgVW3/7gtNMEBFM10sBLNPr7sGLiAYC0qxey/2m+nERFgj/IYW1mIHDq
	 kGNul7/CAR5CbQZDcoftJbqNTgo4gj7rdhoYFGqBQlM4bPzrjqVCUPprs73WSGA5DVFk6
	 9XgkYM3W05cOJwHXKrsqR0oHZLW83NlEnBmJH3u74yj2fV2iWGg4D5Uqqtt0LikwUk5ft
	 NBinmOaeixG6b7m+jL4fgTKCohOui097i92L/+MWhmJARhEABE6Qt2tb3Q66UpOaZH+mN
	 kuKA+a5eVx5Fr7eUBcvh+eFTzQgbmEnXe0lPwljJ+nP/cVQOgcbfyTdpm19bNh0TMhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k99C55f+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63D606A31E;
	Tue, 27 Oct 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k99C55f+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4371B1F01825;
	Tue, 27 Oct 2026 23:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143094;
	bh=QFRpBHs1ht9jGMmD2NyMPobbl7bAUrPuIDNPHO1dXlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k99C55f+ucEo2hWra/Y9Qw4eaZjbYjT1muVI0kO177+CuTSY8OxtvBF9bjTrgibSr
	 IMcyyeLanmZGyg8w7Jjfq9O0ZfRFOBzJncvU9+/inHkLOj9HnFNjzoPqPrxQgpBC+C
	 pn0zRWlxlDL9VEFrK5xoAnbk9ipkOmA4e1ZobtzfKMvk97+417zWEqN2UAqcT+r8tW
	 8jeKvjEjV9T4EsdaPBXt8iknts5XSBXPuuycsSFt94uW1JeHoQGERxQl6AE7YJjQ6M
	 Hl1GmtlwWIe7LFENJ1EMx8ln9lKCxF7SFlIRmcPYs7wS2jr/VZdo8mZm8AU0bMqluw
	 +qZIO5CYmGolQ==
Date: Tue, 27 Oct 2026 16:18:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org>
Cc: echoowall@gmail.com, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan
 <shuah@kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Eric Dumazet
 <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
Message-ID: <20261027161813.3092f32c@kernel.org>
In-Reply-To: <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
	<20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
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

On Mon, 26 Oct 2026 15:23:09 +0800 Esko Mobius via B4 Relay wrote:
> Signed-off-by: Esko Mobius <echoowall@gmail.com>

Is this your real name? We need a real names for code contributions.
