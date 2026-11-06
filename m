Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989515;
	b=PY74MkwJvfzIHuTt2YQfrrhasXgJSgx+kv2Pq3DC6J8jWguu3gokMal72oKnF7ptuLN/
	 gIcvN8E7mMot+NYjczRmzMj4v2hiXwgFr0RNYWNx4YKUGE/SJCJpXZv0VI5uY9GWFP0IE
	 Nuc+TjgIynscu6S2cbiM+sqiY2uGtrAmBDGiQ1E2ePMmgw25UcwlbWFPvnmysQ6cyOWhY
	 KtHTk3+/boVOk/wkvQSg7imkMN4GBJOx9KMWzoUZAB+pilZg2vMfEnFd4a/rjHCbBxAoJ
	 Fv2fNjXJF++Uhhj9Uk9FjMwrUuoKHogqeQ36Jbv7YQTiLDz2ektH06wJukLZxIjtCEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=61pPT36wk9gsvl1mSQ3N0/G/rK+4GfJ1X+9yAQft2gU=;
	b=f0TPSsinvsp3NXQ/gZ7hDLBu6AAQE5uOiXUS0oI1yGRC8X7lBSncfR7cn1poNa/JIVJa
	 Yy5ycR/G3aDWFvjCcks3bIYJdTAAN6X4N+i/53guAxpWKuQXgqlpif63ezxG3JtlDxWym
	 8w7/V4gR9DBxm+s8fwMsuGyuiSZjvUZC3eiyPqnpwq98y6FP2G+44zronNTx3e6Z/W+rQ
	 0CIsO1q8NZ6E3NxXr6uPgTqEW2PZ5YBCCVtdNTEeVIKsDu7hu2YR0Rj8FHH10Sh2VoM3v
	 UIMJMEQP2DD198EMSFg/C5TFG7Dddv1YRQWp7TS6enUS9Ts75T9CxUJoKGbr2pv1npA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=r+PQSooN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C275606A33E;
	Fri,  6 Nov 2026 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=r+PQSooN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE0A1F0089F;
	Fri,  6 Nov 2026 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793989515;
	bh=61pPT36wk9gsvl1mSQ3N0/G/rK+4GfJ1X+9yAQft2gU=;
	h=From:To:Cc:Subject:Date;
	b=r+PQSooNWi7EfDjpwtDD93uPeu1pxYueNbPo9sQPYsetRf458AEPfXyNaR8rZzkDe
	 /zZmsO4TSJkZKwkjJRHWMWjH26IypgGQ5/rp7bEg6B+x1UtUl5cyvqEwWoF8vkQjae
	 pI4S5A5dqXqjCFBI4bjSL6Ds4P/KJ6ooKzBq1lmQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.116
Date: Fri,  6 Nov 2026 13:25:12 -0500
Message-ID: <2026110613-recycled-giant-5f1b@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.116 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                            |    2 +-
 drivers/block/xen-blkback/common.h  |    2 ++
 drivers/block/xen-blkback/xenbus.c  |   31 ++++++++++++++++++++++++-------
 drivers/net/xen-netback/interface.c |    2 --
 drivers/net/xen-netback/xenbus.c    |    3 +++
 5 files changed, 30 insertions(+), 10 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.12.116

Jan Beulich (1):
      xen-netback: defer xenvif_mcast_addr_list_free()

Juergen Gross (2):
      xen-netback: Fix UAF when reading statistics data
      xen-blkback: Avoid UAF when reading I/O statistics

