Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BD3955D6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089006; cv=none; b=ObjAgEPXiiYyThCGszrjJrRiIF8fAdiVyGayNjaXWP9rCdUN2imxhfU5dQz1599rO7SKA8VTD9acrLNVxPzGucE3+98hBVo4o84CRpWsc9/f4McdbAtSBme1Om7eljJTn5S6aeW7TM/guvIgOcK7ZBKl9AtnExuXk32aR+F8vU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089006; c=relaxed/simple;
	bh=pD1m0ePRQ90sS/c3NSViNGNAJbxTBIWurXZPVtXHgE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/UnqGBkAoI4L4lIrBA8xPrem+fuG1x9LT03pWoqog6WzUuvdlhhQmX51upcCAiCFXy3ZaO1NlJJX1FlEYevigvQVKe2JJHJ3vSWvQzz6L0FK8Y0i4TQnd/vCb7S94jJMAFvisyRSeGHJe3U4/D/JxOLez33nZu695w6612BZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4dgEtQI; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4dgEtQI"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4858bc96fabso9776f8f.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790089002; x=1790693802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gbf5D/Qb2Uh5GvQijbxTit0dkMqEzLpdwd2/LdNq8Y4=;
        b=U4dgEtQI7M2C78XdXYBef/anKygIfufVzE/niS8lrbeE45HT/Id8poFS4A+8buRrSM
         fHW0djos1L2DZiATULEhO6lN90792fKGD/rC8SMNEr8iz72EXi3/JfRP8MQmaETrFRbo
         w3kcK60W3KcgOpzAriVPV5/07c0Fr3uIZRlYOadL6r2l71sGUQe7jmAm52L63xudKE6/
         KLogcyOmSbbCzKmSnWTkLx692k5SJ2MZ85q/74NH3nJuK/UpJpt/QwGCROkrWdHX6Hfw
         kk947bUAjWeEuqCERjMZy/bKtgR/OND7BkHy1HApsNPmkmTSHmmQXelfgYX+MRRspJFJ
         yV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790089002; x=1790693802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbf5D/Qb2Uh5GvQijbxTit0dkMqEzLpdwd2/LdNq8Y4=;
        b=ckgJDTC2LO4kqjWi5amP/Hxh7RcvHrsT7orFcVaH6ZG6ocK6NmOrc7+BiO0mehGw4s
         izxgbTLrY3vosvfVQ8VRtLoIGPbXER2Ky05rJiH4+ZPqeHWI8aBptGsraxh1NmOxWJR+
         Oo+Ihh+3UE5foX3M27CVsgDVWVSnCkdQXEh5fjfJ6OJ32T/YvK36Ouqq9AHE0C14IV2b
         0bZmLYgk/PCMXXaYK9X9wDCaLFelTexoAn2kjCSkWdWWKKDExzFuWjNA8LkLiBmqb+3A
         qxEMBenIKc77DA1HMFcZE1/EE+gI1UjY0ahky3ShfN4V8wyLaoFPSMoYCttduZ+SH033
         pJLg==
X-Forwarded-Encrypted: i=1; AKwUvByLqx9qyBUGaiwHMzlQCUdIlEVaAIGltTzkkWG2OwpPZ3wxB7gIGIHnGO5VV0dxIq/BcmTVkxw=@vger.kernel.org
X-Gm-Message-State: AFuF++kKqsV8IQd8OCYzCu6iD7F0lzyP8VpJoHlXa3yBLsITFZCFMeGk
	m6M5nHYq1SB78qayCMPJMJnCSpN9WaIL1wW9YWVFRkqdwN4R5d6Rmuz2Rzjbuap7eNc=
X-Gm-Gg: AYBFou0MIY8iGQqO1HszlgO2xoUTIWbUnbOWmxqRceVt3XWp54r0rz4/1soEjtw1frT
	bfY6s/JrztoSMSt8cfvFSsWIpmB911Df2fjBo7ozqYnRmGcImpHxiYOLNRivQqvDzM2K2XSCUvg
	1TdnCBuYaRf/r776q/d+W/HGKdvK2kTGlxncdpxQGVVwyQcIH5vhLowGPZFbmq1s74nPvRl8Ev8
	z4l11iQkyIPm8PBfD5vV1IYHaker8Wg0soO3wiTYjuXDIm13sKXwrtSCkEhcFimOUiwkVc7JH3G
	8dsSanU5nZVSj2npJMMEYvdtdK7Hfn7a1yyTTGciiPruD2I3u9NRxaIW+5PkIsA9YS2K+CrK1I1
	n2YLFNdJPhJeiRSLVoVSVAaOwM2A+xa4HeNSMVGrMhyVuLz6rEo4WJc4+FmWpIgPTN5GLTdZhJb
	zDP7iUgKvy1/OyhOEJ2Fanuvzfc6JtOps8MfdgYhwdUsy6k0xI7TN/RtnnBEP10ZOYFDMNLorqO
	e0I0ac7fiI0dQPjqOmm+oxY+kKe2mXbs1oGxlCh12/t7TqFBb4doSZPBkwaERaXTfMdllhZVFjF
	t60S
X-Received: by 2002:a05:6000:1845:b0:486:f767:8be9 with SMTP id ffacd0b85a97d-4871e244b67mr23497956f8f.10.1790089002313;
        Tue, 22 Sep 2026 07:56:42 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862788f61sm5638813f8f.26.2026.09.22.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:56:40 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in path_unlink/path_rmdir
Date: Tue, 22 Sep 2026 16:55:30 +0200
Message-ID: <20260922145530.369775-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lsm_has_d_inode_locked() makes the verifier rewrite
bpf_[set|remove]_dentry_xattr() to the _locked variants, which assume
that the caller already holds the inode's i_rwsem.  The path_unlink and
path_rmdir hooks are listed, but security_path_unlink() and
security_path_rmdir() run before vfs_unlink()/vfs_rmdir() take the
victim inode's i_rwsem, so a sleepable BPF LSM program attached to
either hook mutates the victim's xattrs without the lock held.

Drop the two path hooks from d_inode_locked_hooks so that the verifier
keeps the locking bpf_[set|remove]_dentry_xattr() variants, which take
the lock themselves.

Fixes: 56467292794b8 ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 6cb8772679782..357a379ef92a5 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -472,10 +472,6 @@ BTF_ID(func, bpf_lsm_inode_rmdir)
 BTF_ID(func, bpf_lsm_inode_setattr)
 BTF_ID(func, bpf_lsm_inode_setxattr)
 BTF_ID(func, bpf_lsm_inode_unlink)
-#ifdef CONFIG_SECURITY_PATH
-BTF_ID(func, bpf_lsm_path_unlink)
-BTF_ID(func, bpf_lsm_path_rmdir)
-#endif /* CONFIG_SECURITY_PATH */
 BTF_SET_END(d_inode_locked_hooks)
 
 bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
-- 
2.53.0

