Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550373;
	b=1njvds61tMuQhJAwBEGRT0mt9yCbuh+DmFnixGyfw7dNElwSMzT2tSgY45K1mp6xDF/Q
	 0mQiIQa0wyj8VqXmb9ITkgUhoVWkpZlnzA3TaGK3SsbQ0w4TaZyrA2bT6llkB8I4N/k83
	 S20OODWBbb7zieG51SO9WsFzYFTPv/vBew2GO+IjEDBrJLRtMILf2TJW6aWWwgwxDF3Cw
	 99hOk5pWrKZ4cAsxTCtfkv9eU8jsg8gZkHjqu9h8ZNku5jYGysHMl1P8uOC9RPy+6iz/4
	 1YHZPlvqUo4ULdIzzF0nh4DBIZnKCchajZSzvXFxra1aRJ5WDFQZnRHRMlXPEsXFnrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=KfjeDLxq0Sb2eabTGvUtMocSZTpAhjxsLr7fdFj1f0ijHF51e8f6ylUGb8QHRGJcRTOI
	 wev5MT+eVyMkZsk67D5Qxw+0RwwhuTVtdyTBDOKmoB6cekswWW5HaxYiOnOJAmN9/lVpE
	 7/eEeIiPqxrPPPXj1TfeI3rEcYVVMHOIg0UrAyA2yHP5Si4hQI4iPRREeI7VnOWJG0Gd2
	 dPG9qsFIotuZ3eBNXQf+DWJjYISkY2x/ffSXG9i7xJUVI8Iu9k1VAEnAjy9fNy59FYN6v
	 uxnLT5igJNosD4hs3SH3aOdP7u4JsRWEUJFFHw/tN2Qmc2RXq6oesLiM4vSNvTYdMvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP3UlWGl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1381606A320;
	Wed, 21 Oct 2026 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP3UlWGl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C979E1F000CC;
	Wed, 21 Oct 2026 02:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550372;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aP3UlWGlcsxc17vwlZ0h9TUfJskO2KrZ1hiJjgBRaJeAsdwG4ya3iPVAhsKIwzo/Q
	 9F9Eznwnb1cxHkBCLSgeqSR+/bT0K+LuaaQ2//MSOM29L2+A7U6cZ47I05giNvUS+T
	 1kT97YZmXY8gVS9F/aavi9n938Znyk/VH5nkNPyKSclq/5vymZaWdSAr8U4oAQRR+q
	 gejGdyBLSsFoCMFbYqc5yxgV3qzF30zMxDKn31lwSzX+tzGJ3FbXF+AK0n7qQnFTAt
	 SblSRNqL9Q+zxKULhEPiVid69qTX6XjpxHlHDHoXiyX86s/XII5yZucErxSzQ5tZpy
	 NvfB8EdIF6RaA==
From: netdev-bot+sinfo@kernel.org
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v6] can: dev: can_fill_info(): don't wake up controller if
 interface is down
Date: Wed, 21 Oct 2026 02:39:31 +0000
Message-ID: <179255037136.3290.7793994198845677922@kernel.org>
In-Reply-To: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>
References: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>
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
