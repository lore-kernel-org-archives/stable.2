Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187320;
	b=CY3MN3HzKKRCkTuQuzw5TV6yckcpVs3X5tmPN4s0420Sdv4IrewzxHvIjCtYkbSk/cGW
	 7jqUTOe5vggu1cfVTFZPcAf36wt7cxnyzrvIVjWOdOTLld6BYu0kj/sQ+JYNSvLQjSHTq
	 KNxyvVqUELuZ6bugdCFg0p4+oSnUS3KNp6tVHkHb9X51n4vVj2sC4tYb/isIr9LCom2Wv
	 oDFeuylJ98VOco/6rZ1vPeBfsRXsZoiUZAgageJPCNqwXfm7TEEVSYKjZoInG0XfSMhK7
	 ZUtSykYbQYYMjOIH4gNYmngLgwQIrVrBonMMHol2lTTMP2pKdrZrSrhr1RXBZUZE3/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=B8vJFfofHUzZYZ/GbKfSFUlRIzxbI853xLgZK6SUVxEYJnmoP6pOSc0s/o3p4a996jzn
	 9dCpaUiNoWflC15gWk0kQFtZ9tLcoDgyQYBR12lIUrFIl2elg4NCzrxJtJ5xhiFSRyRrR
	 kt4MWAr68nQFynI2j52CaNw0TRrW3xmvpi9+JLPG9v5jMK5VbSz9x8HPym4JE7thsxgQe
	 0Cv/7IT2NJbPiTx2qWJX0NhbDBJUzbjdibFOeWk0aeesYKn5Cj1WngCyFyxac5HMC8r+U
	 4w5iAPHmuGWd0RKwOpojuhrE3G9Nv81/WXlP2p5js327PWRPB91ExHRTSDeeW7uK4hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENLrp3x4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF65606A31D;
	Wed, 28 Oct 2026 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ENLrp3x4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CA81F01829;
	Wed, 28 Oct 2026 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187319;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENLrp3x4fVCj2fd8PUkdXs7htbYd0m0ytAAujsddQ9q3EjQ1ctCRP6aUYX4rmHVum
	 0zTVn+CR1ukkvg0yt+cwOA19es186qwKxG+tp162zBuJurM4Ls89sIn5/HkKFePXsi
	 5KdjLtvlZsrsBMPu9wqtSd65AIRHfE87A7B65zcCsYCWfQBvE20sTGtobch3RPDRKH
	 jRB0ZMBftRPl/0qXpCkxLnNBFmudKVqE6xcWNIfzxzXMjuMlu8efMHdkJ8nt8yqjeC
	 s/bIUKA/5D4fruMpvMZusPJOkyiPeTAX3Wsr7SWFkyKrpjwNwIwvhO72upWi8mtfrz
	 mu9LLFOapM9kQ==
From: netdev-bot+sinfo@kernel.org
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] seg6: fix OOB read in advance_nextseg when segments_left is 0
Date: Wed, 28 Oct 2026 11:35:18 +0000
Message-ID: <179318731865.3327.13254506298277087120@kernel.org>
In-Reply-To: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
References: <20261028113141.2111-1-tangbin@cmss.chinamobile.com>
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
