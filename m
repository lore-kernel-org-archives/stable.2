Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45399357A25;
	Wed, 16 Sep 2026 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519476; cv=none; b=D1jWs3oAbd4UDFmMCWoFCIO+S6ycCTwlQGMFk+JBHxmpMjGZasf9wjSjSh2SwVxn3PxGLTsp9gS0gMNVobCDJaqBTfKyv+8NogVblWE5LkPFJA6gz41gX0aiyfkvnd3r4BXcMKc/Xvc2uWwuJ1tu7i4GrB1eosV711zRSJtgeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519476; c=relaxed/simple;
	bh=c/Ne27LVwMSFL59OHXkycEQ1D9vNDY3vKe+mfsQ/GdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7Yc9wFJWKdnQYRKSkDU2Hp9Qgm/1pdbs5qZxHvJrmI2kOgS24QVAiQXTgEfKQegb2ScUObLk4iaUaSGlDfoZ3cCBxCvHppcsPmoxZX8TcDkKdzKwZa4rjovsB6UxZgWQIgKfK1Tthws/CNH1Wn3ec2z4TtieWBf2Ef3zdRXxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpJDm7Dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpJDm7Dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551151F000FF;
	Wed, 16 Sep 2026 00:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519469;
	bh=egZZv/bMo71hhE1ID0nMeKHvQ3PeJ3nZpu6Akf8k1e0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BpJDm7Dq9pgXRKhtbmUiNicTVBU1m/1WGUH15YdcV9cWPBvviXoUejC+8+A1iF+7D
	 745VKcrvD0riwchglApz/zumGI2zjG8ZepxdSQo3ECQ0kAwKN5e7dUN2MwLhH0ccDy
	 a0MoJhMmxFEQ3BZ0uMRLyh2/0YkueN2mW83v6hqeK9ZD5iNIKE6LH/tDYgyqgyMATJ
	 mxd4AD2O8ucIZFC6ErKKl8jMhhTq6jJ5nAg58DjpKTnDvJgzJMma+TvtwM7mwyaxoz
	 foGBhR8hZei0rnnTc7aJ3fqHTAFgr5kOlWU8q2BraQ74bvz+8zASRqodYzvQKjYLM5
	 +S3n1xRx/fq1Q==
Date: Tue, 15 Sep 2026 17:44:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Ion Badulescu <ionut@badula.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: starfire: Disable PCI device on probe failures
Message-ID: <20260915174428.68af5d63@kernel.org>
In-Reply-To: <20260915020150.87982-1-mhun512@gmail.com>
References: <20260915020150.87982-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 22:01:50 -0400 Myeonghun Pak wrote:
> Subject: [PATCH net] net: starfire: Disable PCI device on probe failures

waste of time
-- 
pw-bot: reject
