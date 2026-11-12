Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505099;
	b=4upUiRUmH+NGxKD7GGXwqQedPl5lKhEsz5hl5Bk4s3mErMl8BVHItFkCcgxj4AvoN1e3
	 kGWcRtvIvVU7oXagELoRyrc4rsvNNSWsyVm0+9+q/DBZGb+SZ0Q24PXKfBdesz9qg6Cqd
	 Av46nFOH/mUqRb1livqDWTEM7Vq5ttjeyzRMyPSHGbDdMcEgDK9oPAMzuQ7E2HzdJBZtT
	 sNycgkHS85ZrHOYWANWHEBGk68tn7KayrF09HJzNVPk/3aG1ytCd/DHUgKc+n6b6sons/
	 h4XRmoz6j0MWKGfMyZm5x/tdAwDtRU5V10MJIgC2q4Rcnql7njKHZQaNkJ99LjgzIpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505099;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U97fnoD7MDO1xz+rlVTUI9VrSV2vbzS4xpJweB6GCX8=;
	b=ipt8ra+rWKIG5zyb/0cMghq+RchOq9AxrZp+wmqHHlxetLBMkPAfcm9wL1UMq5UfvjC2
	 hg5yUrU//ogc1QgWbrKAEA8j9PKz8oz2DZtTuFkRXh9S2uBqHHGgAfqrYo0r5S8slAkRv
	 3AHkeC4CO9zx8Q/pjihIN6skxx/Zd/MCZ93Vxqcm+2UQ/CFIOBoCgQRQT5f6udOFPEpjW
	 UR+G/QyqcKvHnpO5U6gpehEzWpzLEm08/JlFta8FnF++wTY9N+0YMYqd0NEP9HU6HIik7
	 T9w6I6lWGVdDLUgOi7W9IUyUf60ozIQrX9uk8mh0Tjb9QLGLZiXaC5LtW+9FcZk1XnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/cW18XC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF3606CFCA;
	Thu, 12 Nov 2026 17:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/cW18XC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27E11F000C4;
	Thu, 12 Nov 2026 17:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505099;
	bh=U97fnoD7MDO1xz+rlVTUI9VrSV2vbzS4xpJweB6GCX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E/cW18XCL9lGsvizraEEe13YTC7Cef/EEWxEXv2NWkojaoDGyq6g70bI+wfKdJiSW
	 hD0MgNYM45Asm8a5yLsiE4Jyc0atv6RbUA0/4wLhsYdE8vASKoBOXKwjd5rKAzB6hI
	 nwpnKl8oNxeJNkBz3Q5tU7UNhaZvgA/HdJX+6xnDDEDqFYM6eJ3Vx8bro7cHu/qwT8
	 5CsaUGlS27tMcqu++iGEwCV13pDBILCRv2j0Nva9k8MqWVrQXKJ2oUaN/qKMlKfZX9
	 WvFWG7BwqpEgTm+TsGlwRb57JkYc499Q1zx9ONrN8UIoaqUlhFSj1yqNmg9ft2uUlw
	 RSrFQO9VzTofg==
Date: Thu, 12 Nov 2026 09:38:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: liamsmith827 <liamsmith827@grapheneos.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, liamsmith827
 <liamsmith827@proton.me>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/4] ipv4: restrict on-link fallback to lookup
 misses
Message-ID: <20261112093818.0af5c5af@kernel.org>
In-Reply-To: <20261110061536.10811-3-liamsmith827@grapheneos.org>
References: <20261110061536.10811-1-liamsmith827@grapheneos.org>
	<20261110061536.10811-3-liamsmith827@grapheneos.org>
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

On Tue, 10 Nov 2026 06:15:34 +0000 liamsmith827 wrote:
> From: liamsmith827 <liamsmith827@proton.me>

Author and SoB need to be your legal name with normal spelling.
