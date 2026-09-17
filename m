Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EB1448E0;
	Thu, 17 Sep 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610981; cv=none; b=KXFNL1SISf9qQPLCgSilBxCq2AtVhp7tUYY+bgKlbS+3WPXNF7SFT5xPi07rGVxGYsC19JBpf6ivPEmj5aeV7oh6d8FDRkc/WtxAtFMpSRrxO+tJMcFg+BU/P6eIl2QMwVfZ887yl4U1aVPDLTs/zkOs1PlcA83UhsMp6Ww+F6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610981; c=relaxed/simple;
	bh=zxsmily/PsWjTxCjdQ/ZA1UnGlr8xhl/uiitf/p8pas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIFRSdAIA/56q0aPQJ+1dScALJawcenTI+CbQFrBA+OIbb9EwHqBlzS1oEoHHB7aDv3enhOWHp29FCCLGUmGict2oel/RZNRGw2sLXo/GJ2S/rNFZyD5mLVZrLfe0au4a9Ucrj+ISrXyB4xyKThQ6BxnbhVmDSiNXDYVLlRDgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAoRUh5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAoRUh5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2511F000FF;
	Thu, 17 Sep 2026 02:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610979;
	bh=zxsmily/PsWjTxCjdQ/ZA1UnGlr8xhl/uiitf/p8pas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fAoRUh5gSgBf5dns0QgEiqkplb8cqBlX8tS1iwPTjOxtwRIhDoOXaLSqP2wv5SlRd
	 Ntg7Xj/3sQTgc+NBZVyCAVQQicZfV1tWCjmGb/AwLrhtF8h8PSIiCFa16Z19uHi4Au
	 coAl0qKUnIptJFdP16mpSQ3jaV+o6mBGLW8JolYg51d6cuiKw4hBQGCLxaZ0dI6d5W
	 oEddxhd2ztV0syGKW5LlYbhfp2uai7Ci1Z5znwYqG3qNNd4LF9u2Int7mfiYqWS85R
	 mlal38MxPFhOY7QwmJeVDjS5KxfH/koGZ8Qt/4vY2NQotAY3dm15Sv19PsYo1mEQXa
	 OClIxhCloAa1Q==
Date: Wed, 16 Sep 2026 19:09:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Denis Kirjanov <kirjanov@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: sundance: balance PCI enable on cleanup
Message-ID: <20260916190939.3410497c@kernel.org>
In-Reply-To: <20260915010849.54718-1-mhun512@gmail.com>
References: <20260915010849.54718-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 21:08:49 -0400 Myeonghun Pak wrote:
> Subject: [PATCH net] net: sundance: balance PCI enable on cleanup

We're not fixing minor issues in orphaned drivers, sorry.
