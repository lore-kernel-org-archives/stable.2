Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716913;
	b=1z5a8Zi7JbLfOuRfxuqyEJ6WD+YpZATrPDaxGzuWeuyk1C4+x19D8UkyJyhY7l/XKvTj
	 z7oqPdDcBWQ7ldZnddD1tRONmDwih/rY3fTb4WLf0lim6fPRxFarQ/PBkF/hXrZOpw6cz
	 F1n6Q/o35pKEzOr9jE9jzk1YlW5keD8McRL466wHtLi2moL5ZdPWgYfeaHYmAOSGFCSfN
	 YUsu9wXS0L4T+XkVxR3TNfPJKlrspumWMej/JAiW3IEsFCmLRzwsgWmVkKoHI52O0TYF1
	 eTBoPohqEjpqaK1AP2PvO00YYcs2vmQwrvGQwh+Q84pB1BopDdO4BF/FkG7fT2kuAqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wAZrtUg1BsyNyokf7QV/XjN8JssSgTHPtRi+FaZ4x5k=;
	b=riTEt9RLZz9AoBDnN9nX+PWMbx5lO+SQU381+00Fe9Ulz3HPJ57C7tUH4h9OikcJ8R5F
	 iuGwgfve+WsbsovUcvNiEkFJz6mrNH9uxzs9S7tjAjVx31cweUazjHX3JgjOyNXygKUgW
	 rpJpCaj4jM575mQo58w87KZWGiD+al8zGvO9w9fImy1hJCUTkrMA/dXYjIQF9VCqs9jXN
	 qYncfKs8/HLRrnuYSoHLnxMtBG5bi+BlGPwzN/2YzAGlaiXRNbFyCRIN4dTqcHOipmFNk
	 msCpEhgN+QwbJUc9OmnXK+VcBagwboL9dgMi8p7BBrQ/rgxzZIx7a4M/ldi8f15pGYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcmgInj2;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A2606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7A2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EcmgInj2
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3ab37ea4798so111212a91.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716913; x=1794321713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAZrtUg1BsyNyokf7QV/XjN8JssSgTHPtRi+FaZ4x5k=;
        b=EcmgInj28Z/xNpXnXxOAon2wrmz0QcoPVbtbQ+dQ/l1NrXqh4Jt+hVHNv/Tq10DxEa
         0rs6/T+PYEbYVQ/O/13R8nO2zv7Ta3OCcaXdg0sH/i8rWZDINWSu0X5oXNl39Mx4TJXQ
         As+s+MyHC4cr6xfWL/B6dVsNW48MlIqxaa0sJlXoKkj1cspZTkMiPSJv73sF1bRx2L/8
         hAct1/B3l2XjJgTIgnfdCxzQcHrlXDe6VAlY+JKXxtU1LZ/IFRTOQ8uxVlQj6mbKCK+V
         wP7cBPxIeuvcP7XK09bxQK/2VbivpumqkWm+gg8r5UcZdiElfM8Bpi43DVGmD6USUxvh
         2BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716913; x=1794321713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAZrtUg1BsyNyokf7QV/XjN8JssSgTHPtRi+FaZ4x5k=;
        b=HkaKJQc8WmIt8f0oQIcbXm0vfHwmvKzZjazPPYzup/haCrwx8K76gPT2eziEVbcnAM
         /8OjIoVVt48c4kk95BMef83vf1vBcOnIMziCGdfFB9i2Db5wqRseB09Fq+W02U4e8vKI
         pSuDlo/8FYy29ZS/3Bx8ljC00U6BsGJYALsYTI+dnSt9pynpdeZHmJCfePjdjJJ2Ry6r
         l3riOA4tuEqCi+UH4qz2Obv559e5lS4LBQ420rx5XMj5LANzr69hSoh9fb99PEuzjdxu
         YMWr7yvvLKnaCM1xwutBasMCLGaLheb+nc5PLeyas+cKvdHji/Gj9WTcqJNqbTMvOVmi
         myOA==
X-Forwarded-Encrypted: i=1; AKwUvBzQnXQQIlGreUDg8rccmP4iOTAqGEP3MPmWTrxKbTT9dxhrUDY9AY/oxQ88nM5H8b50rhQeAPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ExAeGH6vqCWZNZc/osBOOY3wwYoYfNEJMEab/6P2AnSxyKwYA
	IlF4ojsKzCc9Hrhz7s1Dl3keeb1hih0cYpNZSGDyaNkBexXl3vLlthQ/
X-Gm-Gg: AYBFou09rxapHSdZc9BNCCvzxjZv/9Y4w3KVc/02JpdonKmDY+zc/9UHq/vXVdVd78+
	V5UpjuSlZCYVsLsRIvkjlYi3YL98KnKH8r+hpB2DnMBfEwi2imla0dDwqWC3yvhVnVlSXJ11Vh4
	jwTDDnmYg4FuLd04bNVVgqqSW4kAyY9emMXpvP2gE6AC23NOQIXnCRiTQyl7ljnkangWDMBTN/M
	kfGh5ABnQC8bvY5MEYGzkyT8hDJJIMVTCPWXutZNiZw1DMkdI9tbjf0ehLxKLQdm7Y37l7q/q0D
	61koRBZ0ph7rwLo4k46pMQpxQjUoEyjAwPS4buQYPmF+++EtDXRfH5eFoLJ08ucO+Bb4HuR6+4Y
	9srKfSYP9s2f7XpSkE317OhtuhGsS5zLW7LH2r/YiNLVFdWpOikmDJ2RszuyRFLXi9qhDlY/lJ0
	UaFsUNmm/ECSciD4vOUxYYdfRq+Ve31IH/OuWIEja71OP2aHL9vpM8BOOWfKxt1AReC8dAUwF61
	nYUo94oErz4BKJDeb36LId37MIKuz94RWIsIQ2zLQOoI9/5L6l2DQHB3g6eK8rG4waOUqatwFQa
	eIScRq0NN4K4a6Yq/kjVptx+/+kH0CNtG5zmX5gI8jstE4RTArNhdjz9c7LbJFYVdmtC3bmwYuo
	+kTvz96/Vj3D9t8A5C9mxkQ2J5f9OLq2TNld7kZtGjC8AkfEBssFBrtEe9joE0skggw==
X-Received: by 2002:a17:90b:1c87:b0:3a8:195f:186 with SMTP id 98e67ed59e1d1-3ae897ee656mr9705547a91.42.1793716912532;
        Tue, 03 Nov 2026 06:41:52 -0800 (PST)
Received: from localhost (ec2-18-182-19-4.ap-northeast-1.compute.amazonaws.com. [18.182.19.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87f99899sm11006962a91.2.2026.11.03.06.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:41:51 -0800 (PST)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	Dave Chinner <dchinner@redhat.com>,
	linux-xfs@vger.kernel.org (open list:XFS FILESYSTEM)
Subject: [PATCH] xfs: fix spurious len double-counting in rmap three-way merge check
Date: Tue,  3 Nov 2026 22:41:44 +0800
Message-Id: <20261103144148.14430-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Jianyun Gao <jianyungao89@gmail.com>

In xfs_rmap_map, the left-edge merge path already executes
ltrec.rm_blockcount += len at line 1119 before checking whether the
right record is also contiguous and can be merged.  The subsequent
overflow guard therefore must compare the already-incremented
ltrec.rm_blockcount plus gtrec.rm_blockcount against XFS_RMAP_LEN_MAX,
but it incorrectly adds len a second time:

(unsigned long)ltrec.rm_blockcount + len +
   gtrec.rm_blockcount <= XFS_RMAP_LEN_MAX

The extra len makes the check too strict: when the real merged length
does not overflow but the inflated value exceeds XFS_RMAP_LEN_MAX, the
three-way merge is rejected and the code falls back to a two-way merge,
leaving the right record unmerged.  This produces rmap btree
fragmentation but does not corrupt on-disk metadata.

Remove the spurious len from the overflow check.

Fixes: 0a1b0b3855cf7 ("xfs: add an extent to the rmap btree")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/xfs/libxfs/xfs_rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index 14aef87837a9..c2b2f8e7502d 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -1120,7 +1120,7 @@ xfs_rmap_map(
 		if (have_gt &&
 		    bno + len == gtrec.rm_startblock &&
 		    (ignore_off || offset + len == gtrec.rm_offset) &&
-		    (unsigned long)ltrec.rm_blockcount + len +
+		    (unsigned long)ltrec.rm_blockcount +
 				gtrec.rm_blockcount <= XFS_RMAP_LEN_MAX) {
 			/*
 			 * right edge also contiguous, delete right record
-- 
2.34.1

