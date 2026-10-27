Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128239;
	b=RpkkWdNco/ce8MBwCuwUMmfzLl/SOazic3DlmDULKPYs+ugk9Yale+n+a083LwG0DYuR
	 1snTDkA4N8HVz7Few9+macTNGSKw8yIqN6cXRsw/4+H5UDG0091Uo7L7WwfMPrvGwbgW7
	 z2M8hByTHIaLyl7O28r1yiiu84rhEotJO8PFwgZ3hzVIaRR3X5jMknQEefTqD79L9yA3P
	 5m8A9UGr6jEWvIL4KVgphzC7SjDU/HJvSnrwIDW0Sim/bx+hKASHIVf3rB+GaqthuLy70
	 q+99nLz+VqO30bf4/Wer1kH28pFsWG/+RSoNbug+Xe2yEnYIAGJYu2r18RXfcfQ6RKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=364661cMqZmbQuoyQiSWjWLJu9FJucvDfaTNX1PmnSc=;
	b=avwY27knwq1tpUiIfRAv/XE5z55OEfaXZT9rMcjuvJ9ebPN+S9/rcQqiNodqxFQD358u
	 q9xfuBJS6M4vHGpKO7WeNCZCnihFK8ZRDXD0joOhV+ufMdOl1awx8rseFp2sKxpyPT/wi
	 +oXbyoYXY3i6O/7AnFu74SRAe4bd5luojejL4GDf8TVm855DU/mBbCYf15vL7EbGqYzZK
	 FIK3r3KxtEc0NZOppmCnAE86wv6AtCGo28JSEpmEdK0GpEj0tpmcwxhqqWCtgCwYi5zQJ
	 QUFo/xUvoUDg2V+4H3BJTRexDSzEmkJenk2Rl6vXxVvg/pbAFqNFriR/N9TVWj4+hCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeV8iqCb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A7606A337
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeV8iqCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA181F031E0;
	Tue, 27 Oct 2026 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128233;
	bh=364661cMqZmbQuoyQiSWjWLJu9FJucvDfaTNX1PmnSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeV8iqCbrvAFIR5lpLy7YP1BLyKLwIaAHuUVX9DDbuHfiknNTSjDk+2gWXuenQ7QH
	 xvSF3Idw99XKGVpuFSpoOpeCWpfnYqhZ0mX7mu5u7Ledmm/7fSu2H+BClrhHnM6iK5
	 WDQtPmQPjJLprJG7NjysHPymEq6974JM1XHSmBsz6CnbZNVdbqUiHU6iM6u6S4Z4FR
	 eCkCD3RStgZsmE5bsvvdiwNAAUG3Ypk4bTj3Jos4/EAzxl38X50hurUP/LIG0kUOGN
	 0/oGYUQQc0kkkirykLDBAQg3RlZ3jzxAm+7iwgCvpfKbT+c1Y8xbXKQPAOBh9boEXc
	 1YqhQPiDK1F9w==
From: Sasha Levin <sashal@kernel.org>
To: gregkh <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable <stable@vger.kernel.org>,
	"tuan.zhang" <tuan.zhang@amlogic.com>,
	"jianxin.pan" <jianxin.pan@amlogic.com>,
	"yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
Subject: Re: mm: call the security_mmap_file() LSM hook in remap_file_pages()
Date: Tue, 27 Oct 2026 15:10:29 -0400
Message-ID: <2026-10-27-1-daily-reply-0001-remap-file-pages-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102716561458946426@amlogic.com>
References: <2026102716561458946426@amlogic.com>
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

> If use the original commit, there will be conflicts
>  that need to be resolved manually.

The original can't go to 5.15 on its own. ea7e2d5e49c0 ("mm: call the
security_mmap_file() LSM hook in remap_file_pages()") calls
security_mmap_file() under the mmap write lock, which creates a lock inversion
with IMA. That is fixed by 58a039e679fe ("mm: split critical region in
remap_file_pages() and invoke LSMs in between"). Greg dropped the earlier 5.15
and 5.10 backports in February 2025 for leaving it out, and 6.1.y has carried
the original without it since 6.1.120.

I've queued 58a039e679fe for 6.1. For 5.15 the backport has to be the two
commits as a pair: the original, then 58a039e679fe.

> 1, What is a "tested backport"?
> Is this for verifying code BUILD and kernel bootup?
> or
> Reproduce the issue and verify that the patch is effective?

At minimum, build and boot 5.15.y with both patches applied. If you can
reproduce the original problem, please also confirm it is gone.

> 2, How should I provide the "tested backport" to you?
> As a patch file?
> or
> as a link?

Send them inline with git send-email to stable@vger.kernel.org, one mail per
patch, with [PATCH 5.15.y] in the subject. Each commit message needs the
upstream commit ID, and a note on anything you changed from it. See Option 3 in
Documentation/process/stable-kernel-rules.rst.

-- 
Thanks,
Sasha
