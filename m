Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769428;
	b=JIrsh4YBc+QPWf8EYNp5sj07+D5/7IgNMiJxt4xSc03q1EMAVRmWdwgqNb434TmvnQc4
	 /gwLkzHravpKJZjCLqYwJ+wPFUW4xkDnPmvoUN8FlRU+aG61INoufNJkc48eJDVmrENJb
	 O+gDnusd90qaU6LJUj9vmsNB3/8YtTg1sVrvXBEF9L85+f4mbqWL7ysiUsd4V6OiEotBR
	 s+abqfJvLqv0RqDflBc5Itmmr2J+pUTlfWP6TWgHlOdFNnBXW4wcr/QhJxYoKDWjFkrbn
	 A6kEtP6fFWrkll1msIyrw1hOZ3pP4z5TwFEaNNYkTaR3PlqEGrwdA4WDz9vPiWQYZXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ROnGks4KYpRui41sSEQf6LMRfROe8Og9QvbvYoT1JlE=;
	b=S+mzHapDU16G6SbQ5p5Nn5+tqObcZGg0qu1ha4e3YMMK9i0bZ4+EWFY1lg0mlO0ZCiFe
	 Vh+FnygJWV1yuRPq9nyQYBdCbEoX9MXCmYKUDcbuEeYFqKE+5TXYNZeMXc94TtRpiNcgt
	 6PwvmYGJA7jZMG0w0oiP/TXXeD8CqAhB2qHlSgIiOTwaKaecfzOFsuRA3LDK4DGlaBEb4
	 vqP8cIe8En7Z2z6Bugg2HBT331bFeajFpGSKLzfBya+/mwSoDDPqV8n1MHVyZZyNMcNTN
	 sb7HijiFH8FBfb6JcvRHhLJdh1L90XwHt/bNREBqeW/nTmWtszCtXVSAFfR2l5XDlSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/xCeUbc";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD6606A68D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BD6606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/xCeUbc
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so4898004f8f.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769426; x=1796374226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROnGks4KYpRui41sSEQf6LMRfROe8Og9QvbvYoT1JlE=;
        b=g/xCeUbchw3f/7WFuHHQB4er9HUf42ben8Zb5/Tbl8F+B0HO346GrlqWYF1Q0p5WK1
         znlCIb8D8+/nE5XpC3jpABV5zQEZGwTYOK8Yk8iGYFjDY268Bj6fWCEXCcEb0q/AJ5P9
         bKAbrN+eUmNhq8ZgYe0cQJcwNce+iMoHtBp58gOHn2XbCcMnLRpsx8/acNEHjylTWo8T
         8SXTwGAkYa/XYqr2bJH1iqsbAuwthLMl3C9WGVinmbw8OzZ23sGXGVGKWTVfgMsXzxJD
         LObG9qXofC82hUZJT+g9Wbh7wEnXyXIJwK+03yUPCFWFw+SQblrjhFN5OxJG0SxoUffE
         SAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769426; x=1796374226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROnGks4KYpRui41sSEQf6LMRfROe8Og9QvbvYoT1JlE=;
        b=tlfzyk/Z0uMmxWuztXXJQymMiNySiHLzstr9M3HbQvQrkJacfVrd2RkZy94VjYmAtH
         XSXmSRv06vA72i6+kdKbSWphWAUbcXl/MVZ7q4lqJFmPxGKUQXn5jmmayRx7BB2HCMmf
         jwiFe1csRvqbEAwe7udApA2WGxEE3M7i+ysU8td//9xcv2H/wdchmH69OW9v3kUR6TDo
         3KgWBvmUicN7Ut830DCvxBA6xhRPA2iENHfKnXZvL6YHvf/8uz4ay+9iO/FBAn5SHrvL
         MS7wf0RQvMxNCAMme9N8WbqJeaAbcZonyMlYWGQIni4rKqKPH4WVFpszOvJOJ82SQ1Lk
         jTaw==
X-Forwarded-Encrypted: i=1; AL+hErF/S2VJXhZYKDwyUgVP2elegi3mWcQaWpiUjRaeKILh3dxBYNd4uc2jknXHRoHOWeyEZfOjA3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IR06UyO5RA2ATeBThqFxERvdnR6PEPypJIDtalsjAwQeRuSr5
	o3zqLFYmS1LajxxOF21fZi/TwvU/2cvXWn776LwCOB00aLTzuXQkSJ6w/vbqQ37h
X-Gm-Gg: AZFdTZchxUsYL9GW33t6xoFOckTkdIj7XDeUYN3YS9S8PZnnwCJwBCTzXYmR/4oEovZ
	IYSV50tnsAefTW9MScTJ2Bt5vfiuFKdIgdlfFQ4kSEIA+dGDpaGt68dFgcsNZHxj2OCprLQTbwa
	FBWje2VMVQrHqDzaDlAi0Q/uMf3/ihAjjAj+XSI2Q0n8dRykK79At3M7KvIrX7HajpGZF0yySMm
	FpLThwhq9Uym5iEnOCWGjhlM8gja6uARSrO28T8WSXdxZu5S9MI7Fgb789uXh91tWfYCCmSuuPC
	qyzhvwEwVCYmvC81lq7Q+XkQSc1aD9P4xtzYThrkv/an1XjwdJLI3hBv0jBFHJfV476jnQzUZNF
	feh8aV3u8N9ex2hEsXIVwofidoxFS4Dmd7Dj2/wrjhICGiY/nnupsA8gsgkzpknWvpE8H7Ay6Vr
	6gUhBAL1T0R1Xka1bUI2AmpSLebVs04NyHMD4tK1333Zk7tXsfxRz0tOg8aRL0wfmAvaoaiXz0g
	FcJny+XNNpp5H0aI2p8ZinReWZ7W6ZiGiDYDMzILtmOgIGwjKJ4LiM1QmOMUDAIoD2ghG26LztJ
	6xwxXzm8yXWycaIUQOzes9rYsQNcRs5Rg2SuOkWBxxhIvtMWx+FeB8MMGrUJxzQfq8Q+R/6DwIy
	jFlkN/ySe0mo=
X-Received: by 2002:a5d:5d88:0:b0:4b4:510c:51da with SMTP id ffacd0b85a97d-4b4510c553amr30670632f8f.11.1795769425756;
        Fri, 27 Nov 2026 00:50:25 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm46461938f8f.16.2026.11.27.00.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:50:25 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.18] xfs: only assert new size for datafork during truncate extents
Date: Fri, 27 Nov 2026 09:50:23 +0100
Message-ID: <20261127085023.2340874-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

From: Long Li <leo.lilong@huawei.com>

commit e942498385bf80f4d6d075b47174035545eb6a2e upstream.

The assertion functions properly because we currently only truncate the
attr to a zero size. Any other new size of the attr is not preempted.
Make this assertion is specific to the datafork, preparing for
subsequent patches to truncate the attribute to a non-zero size.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Long Li <leo.lilong@huawei.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: b854e1c4eff3 ("xfs: close crash window in attr dabtree inactivation")
[amir: without this patch, the backport of b854e1c4eff3 trips
 this assertion from xfs_attr_inactive() in fstests generic/013, generic/070,
 generic/103, generic/117, generic/417 and xfs/181 with CONFIG_XFS_WARN=y]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/xfs/xfs_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 3b487341348a..5abdcf1f46c9 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1025,7 +1025,8 @@ xfs_itruncate_extents_flags(
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (atomic_read(&VFS_I(ip)->i_count))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
-	ASSERT(new_size <= XFS_ISIZE(ip));
+	if (whichfork == XFS_DATA_FORK)
+		ASSERT(new_size <= XFS_ISIZE(ip));
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
 	ASSERT(ip->i_itemp != NULL);
 	ASSERT(ip->i_itemp->ili_lock_flags == 0);
-- 
2.47.1

