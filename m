Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671804;
	b=JWIBmUmENhIToWABkH1JAgEdTBmy49a/HFb2vEjVPiBYt96h2/Vy2hagROJevZqeRZNx
	 foAbkifUvQMH1D60ZN/xt7s6lq03FqQsUZiM+4t+BfhXXVel0YnTrrC1egky4hQnPljm3
	 s52A6DOm4Z/S2eO+60LbaaBjRwuGDmhMXBj21aU4hjW+zxCRhCRDV1y9kzoBzGYbJmS+X
	 8w3kPFrCXGdZzWapOC9sG4WCAEQlT9VqFUcZMFTQmatvcfXCoiFs9ANGAPcjVzX7la7H1
	 Iv5JDMeuCQrkkGkFNEIhEDgyZVffzgHHsC6WRVp4HLuNyh5Y16Zmz3LO1ygsNRo0sPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671804;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=VsJKVWyvJvNd6rw27i3poeZiSdMiuaLhP947lKJp3V/YCKwcu0BQlQkqAlsPn9DzBMDE
	 YzZjVNulfxO1xdVZx7KOWliUIec17Up3032oNJaj8yVhz+dU0ju5NZUN8f5VgYuyp/fcn
	 MiEHJLZQhNXLQQ+EIa+e5uSRp0lVHQPeoo8u7Qi+WbDrPMSqR2p+XlRoYqGv0Icp7LHP0
	 NAg7VWFWy+ydXJqyxeHOm/4ERW+2D7WoHDAqfm6udcHB94pS2SOfZdLgoMuhYmiShtrkq
	 VhRE9R7O5RbicRj70RgxYZ9m7e4xGH6VdBaomg5nW+q+mWRahyqB6XoQuuzATLGgWpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzGXaAK2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731E606A319;
	Thu, 22 Oct 2026 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzGXaAK2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429711F000C1;
	Thu, 22 Oct 2026 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671803;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzGXaAK2B/37wt6KTtrEnonQwYK+DKQk1LNh2oTp8ZLVTTNdAJb6/JVpO3jHxTWl+
	 siVxuxbgChAiMcN1WNdACa8sAJrYiRm3id7JJo9Me80L1khhbTzboujJuPc7Tm8OuK
	 eapojzoBRYmc+nBpMl+LRLAnffFYxLJTT4xrpY00EAth0EivOX7dCfHjVf6I3pwoay
	 C9TaOKSqSBUaAmSj/xHLvCUrkEBU7YSe4/xOo2XZMPf1ic/tpappx1bEZgB45Dl0qW
	 vyu18Oma8XIKNMBnoDySG4YM2P9r932h53u+ZWWEPNGF9dzDQxMRcEDODdfQtIqGq2
	 iWNO0kgSL44Ng==
From: netdev-bot+sinfo@kernel.org
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Ralf Lici <ralf@mandelbit.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH net 1/7] ovpn: avoid sending UDP packets with source port 0
Date: Thu, 22 Oct 2026 12:23:22 +0000
Message-ID: <179267180279.3290.16441907746812616677@kernel.org>
In-Reply-To: <20261022121606.732029-2-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
 <20261022121606.732029-2-antonio@openvpn.net>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
