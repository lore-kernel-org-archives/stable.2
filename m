Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DA37CD29;
	Wed, 16 Sep 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519442; cv=none; b=QkaiKCGmFPb4avRiLaWY3l0L7HpoV3mVT4+JxAEFgjerH45lHvqT7FoiFO/BbB9nS1URtSo3gFu1nNMRCK1HSy+/uZkWBEet2Xjo1NPIUW6J2KoBoZLuHZXXnKx3WuPpwJiOiV5TOXRepF0gE3EX4Hz8dhyt2pQFuYc3oMIy1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519442; c=relaxed/simple;
	bh=WxDSRqy7995+Va2Mq31qoZJtvt0+l09Tb5YzKqPnv6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fq+L6+q+Ni6Cfd+mwlm9KzNkgnGeiArtxqxOEj3iwvU0i/bXASFOfiGnfUhMWHWTTsMW3fiXD7yU5eFTCyO068p9/Gz8rAL2uswK2bcttCjOzv41pGrlSfvb5Lg9x0KgXCPoSyOnWJBHKJeK/tHVp3ZT9ibLR8UmnwJKp9cgwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqGYoeEd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqGYoeEd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B321F000FF;
	Wed, 16 Sep 2026 00:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519428;
	bh=UZJ9ZLYDY9Si6yZkpOfMCT2e7GSOMrfiHFCZtwfcegk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aqGYoeEdY5Y8yrXBYhNzKYy1XCqEyXyGWTxGdi16vdRlKleFqEYCpf5KuF1QP/OM2
	 VSYCXf8uqQ+Uotj30cZKL6xxgLxZEP/x7kKH2mB++397MCP6VoPBGaDC4bQxFmK1gI
	 7s/YRB3bHP3GJYaSRwGEUWQ9DSml/tNsqpb88nzgEh/Ec70p0OAjr9+VnEwlFvVLr6
	 7jbHnIgWBvDO6JAVWhFjdTBMKumigQrb1AZSTTpXYaFMFVMhxVQ3frY6QnkrVbGe0F
	 lc1ebPj3q1WlOKDCfK9pVjzOpPySj8u/1ig/8lUYrBIDUUMRWv0cGUlpLfSjj0LFMl
	 863527/kYv1Cw==
Date: Tue, 15 Sep 2026 17:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: tulip: dmfe: Disable PCI device on removal
Message-ID: <20260915174347.4f5acec4@kernel.org>
In-Reply-To: <20260915020359.89842-1-mhun512@gmail.com>
References: <20260915020359.89842-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 22:03:59 -0400 Myeonghun Pak wrote:
> Subject: [PATCH net] net: tulip: dmfe: Disable PCI device on removal

Please stop wasting our time fixing bugs in 30 year old drivers that
nobody cares about.
-- 
pw-bot: reject
pv-bot: slop
