Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798966;
	b=LQu5yCkTZiQ+yt912lPMeQECMmXQKfwG/+oZe6jizxTZz2x7q/DwwrvwxM5+J0IL5hzb
	 6X2CcZehoyN9ipy61hIhlNPSA/w0Hhoo6JjU8Mp66VKZLjqGp0MpQXas+J1QPz5C7m1bR
	 sd8VR386zfOFBxYhhNX0P3w1e7ODLGg2isvelFF1OUKyQqfIYGFEa5ot4N2sqf3xkricF
	 EuOG3qw+i8NAFT8M0fBH4oB7E2tWw5HQ9aLc4grqFLe44DnmfbZFHJfjE33QKPcbv2znh
	 B18FDDOvChhTrTlEJna4w+nnQOlnjU/F1Ez6NvoaNAx2zvNcn8t1vSijziuhZo8azJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lWGARJAENFFmoX6d06sfLCp9JZJjCBArvjeLymZctpw=;
	b=1Sp7ivAQzTPp3OCmXd+qZsOWDO6avBWPFve95QILpTDlfwiUuJA1ohtq4mo0FuWJDgu7
	 nXPhfstspNPV2w/QXiAizxwmroCxK6OZu0gGyCzYwcfuJVPoPh/x9WBJeJZG2whiNuRlr
	 7ciCKThHWSbb/I315Sxe5NeYDJkxVXnGwmzgEBETy4aOMI0RRIC6RMqRR8AfzsrIPr1ZL
	 reBK542irjM5bB0RWExTPmfOrybgIyZNBevKtJNAf8KrJgdwpvWpZ2s90Z1mBf2HgLCCh
	 xmE7vN1BvO2wTT8bSShr+M4JrV8mVHHiLwTwrJgBjWXRQNnRm+AWaGwthCW8jbbDgrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/2mAZAL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B9606A681
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/2mAZAL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792F71F0092B;
	Fri, 27 Nov 2026 17:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798966;
	bh=lWGARJAENFFmoX6d06sfLCp9JZJjCBArvjeLymZctpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/2mAZALIUbugidDY6EOzXdQIR5FHF7pwCiTWJmxEt2ksr4RJpgM3pU3UO1/ezdHZ
	 V4UK3lZLuAUcLWQ/8wWOyVuAdYHktJ5nwg1zuOtT2jlaJMxm3pl8i9PrcAwDtpo4XD
	 7JB6mS0Vej/IZ2UlaNfo26OJjT1Cup0OACcI9RA++rPuTY43pfHP/b07DpF5MSkNni
	 BhUNFAdtUHO4j106Ec2VEjHxjXrdQnm1mkq2Bpfcid3QnQ5vYlxe0mrA9LyYJUvnRX
	 0V1a0kzVAIiYiueRLtQTQD/kpKwd89nTT6fq1mrYWytTHTgYmemPCkeuDKaFCAKnfx
	 0e2NtNV8pNoMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: Re: [PATCH 5.15.y] net/smc: fix link group ownership in handshake abort
Date: Fri, 27 Nov 2026 12:01:30 -0500
Message-ID: <2026-11-26-1-daily-reply-0042@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126060536.642851-1-mjambigi@linux.ibm.com>
References: <20261126060536.642851-1-mjambigi@linux.ibm.com>
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

> [ 5.15 adaptation: there is no link group refcount here, so the lgr
>   hold/put around the abort is omitted.

Without that hold I don't see what keeps the lgr alive across smc_conn_abort()
on 5.15. This makes smc_conn_free() unregister the connection unconditionally,
and 5.15 has no conn->lgr reference either: 61f434b0280e ("net/smc: Resolve the
race between link group access and termination") is v5.17. So far the
connection's entry in lgr->conns_all is what keeps a link group claimed by
another context alive, since the terminator has to lock_sock() the handshake
socket before it can call smc_lgr_free(). With the connection unregistered
first, terminate_work can free the lgr while the abort path still reads
lgr->conns_num, arms lgr->free_work and terminates the group again.

How does the lgr stay alive there on 5.15? If it needs a 5.15-specific pin,
could you send a v2 with it? Please also keep the Link: and Jakub's
Signed-off-by from the upstream commit in the v2.

-- 
Thanks,
Sasha
