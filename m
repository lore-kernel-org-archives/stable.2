Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479128;
	b=fMCSOyKaQ2rw8xwqS+fSVwnRWPzFwnJDIZc0/0KeMArHsq9OK2+VNDult7S4Q4PYGLQk
	 DB8mMTFm/mli6ZtmZaSL2u7mkauEE6W+B0Sjg5oP8V7oxOEZ3juCGK8VwX5KFuRYGO0W/
	 5uAjrrJ+sGVCA9Fqio+AjWAOnOhHeFufXIRuFy3fJvojz+7kxrLk/+eeDLPP123dTtbaO
	 0NGECbG88BAzaoZT5wWJuKTP6m5A7CEFSdDrWwu7Lwlu/5XdccuaxHqXcpoOKc5nlYkpf
	 yTc/5KqcAdpL+CSc6yk1Y1ihz2NcGGeIfUJYMjRqakl7kBaELfYpUp8zw1ohnN3SAZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e4FrmJ/HVhDhmoQ4w982pmizkMioNXEgD+uGEJNmMSY=;
	b=hY2NMBaxrv2nzMD4HJhMfR755evRcIDLSlF9VxZwEm8p+Oec/4RyQbO5mi67Yws206lx
	 MKXctPwsZ22mIxO82p4e0XbtNqROjJjB5oKchZrc+3UWMXdzcTL4qsIenBpQlcRRpGEHR
	 ZwDAx3AeEkpQ13Ok45iSLsJg0S60/GllnqqCIjzKB0VkGaOFwmmWotZRj/o8naRiVw2ku
	 g99KHSfu1L1URJoYETTD4kIpKlynnU4Ltm1hd2P3YeUtD4a69GD55uMD3T+tBzZaA/nSQ
	 IGnkKqrRbU/p8m6uVIifAKfrzb+7qX9nDNw5a+dv3976WLJahwCLZk0BxDQ/TjQ/OBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNZeUmtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FB606A31E;
	Tue, 24 Nov 2026 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNZeUmtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C481F000CA;
	Tue, 24 Nov 2026 00:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479127;
	bh=e4FrmJ/HVhDhmoQ4w982pmizkMioNXEgD+uGEJNmMSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNZeUmtQFSypFqtAnhrZqNgKlc2flAPD75wKX4RccE5VPwUUxHUTCMzCHhNEUf4tF
	 ldS4M/Ts66d9U1Qslb+lqKwxmcxC76JM4K/OD58sgFaAbFPdrMnEOnE+3mENBUAGta
	 /CbPzojUSXFPKvGSz9RxzXqlCkEk/IJY99V66/KDJ5+ru4d/2t6Up15ShIHHKa4f5J
	 bLii4bAKNlUziIEJInM3us6EFkZB/go89pMA/dgDthpIYG+2XrExmCREk7B2bqATTt
	 WW8cQlhuO+Txnr2Av2qmYNYFP28GQKEtwHBUuTBlroIU/4hOht+UyYlr5NjRHLobge
	 dNJTCWyGTnhnA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Iulian Vaideanu <iulian.vaideanu@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Unable to compile 6.12 kernels on SPARC64 since 6.12.105
Date: Mon, 23 Nov 2026 19:11:53 -0500
Message-ID: <2026-11-23-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <841bc5e9-51f3-4eff-8c54-8dfac6762c17@leemhuis.info>
References: <841bc5e9-51f3-4eff-8c54-8dfac6762c17@leemhuis.info>
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

> Wondering if this is related to another sparc build problem in the same
> area for which a fix was recently queued for 6.12.y, but then dropped
> for now to prevent a deadlock situation:

Yes, that's the one. 6.12.105 took a backport of a94204f4d48e ("fsnotify:
opt-in for permission events at file open time"), which moved
FMODE_NONOTIFY to bit 25. On sparc that is the same bit as __O_TMPFILE,
so the BUILD_BUG_ON in fcntl_init() fires.

The upstream fix, ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge"),
can't simply be requeued: two overlayfs backports released in 6.12.119
still use __FMODE_NONOTIFY, which it removes. I'll send a 6.12-only patch
that moves FMODE_NONOTIFY back to bit 26 and FMODE_NONOTIFY_PERM to bit 25.

Iulian, until that lands, swapping those two values in include/linux/fs.h
works around it locally.

-- 
Thanks,
Sasha
