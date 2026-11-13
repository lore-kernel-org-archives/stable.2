Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544266;
	b=Uz8mxJaoAs7fFzehj/RZ2mM19nMavWbQW0yCG0W3JjOM1Uk5zsbFNKaO+DjnDEfdI7du
	 /noObpnxXxW4RHW0jecBX7GNC7eg5tVCA+mttyUz3+y+mrrAFv0jb6YbETeFL0QzJk5jh
	 XVkECvvrcxo+zoW3d1FYhYIuJKO/eGE7dQJcQjjLBSQx84RFHDCag5n991ohLuGo8VdWT
	 GtVVESvNMT3O/WR/9w/KvCn9W1PRKPF3jjsMKdNi+Ic+SxcwfGC3+SmuHKbuiZwBmxcTy
	 w2qrd3YW2bYlW6aTvobDvaEftbeMiQKJJYYvS2pL18bcIA8gbMvv2sd7zYdsxhM5jNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=++DzozSDXGoGQ0O1+uMvDLSlApNVfPaQr26d6Yana4s=;
	b=SRiWTJAG/uqPfOsEGnrEAJIQTUPGk1akyRrdcs164A8smuq62kYTBHq535URhxRiuz6p
	 O8+HWWOGPy/oFJx7mh/QoFMQu/ZpmUTisr9X4RBDjn3HJArxIesRU2JW/l/kbHkzaawIL
	 sadc+dZoQVSIPrzDcbfqH94EIpUk6YQk1vQml2IrZ46UusrV8Mc1XNx6mbO1fQEPrQac9
	 BFgzK/iIRpkO5pdN2Gi6TU6kz6ltNC6sodfB/IaHLYC3XNvbnWQdL/tnrnkiiHEa2BSy5
	 Ixe1C7LpyZuEnCMfsTGv2XHQ0rbqYGFhe2qJXgQcSIdKEEAKJsIL56uNfuFE/9nsQTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=G9eIfylm;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC0606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5DC0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=G9eIfylm
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e4c00d71aso86265385a.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794544265; x=1795149065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=++DzozSDXGoGQ0O1+uMvDLSlApNVfPaQr26d6Yana4s=;
        b=G9eIfylmt5CojRvIIXwiGqovzH3PjwsiBaGIjEcKbWvZ6g+OCGYrpEV7Lqw4fTbJzN
         QE0QymcMBlylboQ4+VeJVXL2dSi8rNFWS0uTvYylwTLoaLpI+MJZZ0HTlGJe4j27LCPt
         96BcFFdT/fYtrX987TeDwZSsd7hR42gka05D5UkcxoF5930mMa0Kc0V/abyoHS5cLW92
         /NdKfBOZBuPFvLh3a0exZZe7AL1dEqi8aEn1685/9kOHu6pEPAU7DyY7BulfgdZKJ9xk
         QGOJzLrJyHQj4+AiACGTe/mxqDAtxv7ylCN5/3snDDk8Fd3SCpAqU/GE6GN+sPB7HUtW
         nLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544265; x=1795149065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++DzozSDXGoGQ0O1+uMvDLSlApNVfPaQr26d6Yana4s=;
        b=mncb+aVIXqrWjHfeMfD2Q5x+OUsrjdmiyzjQRcM3CLPlgPBAR5BBJgyHnCeq2yrPMu
         LUYRqUZZtliLTZAKCLzHSO5rMlJzt5cObpCcIu5jlMT8MlxDRqV6W9pChVpkvvhKUAEA
         FuBbN/CW5pujjsh/+IRIY289dgs9WISq1WD3uwnKxisQF5BDvkweoPSrpX8BCTdOOsbf
         L2p0SxF/oQ6agq0ILfZE/k9CcQUzbqWZxZBd84dAC0tALvUCAAgJdBXnSMnaUgLasMuJ
         ZtggUeHrPSmwHdhHUTptqfDJlJJpmCG1OH572sON4staAdSaynME5hBSL5s0pxc7Vxw4
         pu3g==
X-Forwarded-Encrypted: i=1; AL+hErF5L1lrRA/n9PV35PFtXm87VbDp4y+2iExhgI/je3gPhc6JcZ/tYJLho7ToQV7zYjUmymd7llk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8fe/nb5eQcsApeYGdhVu9ezgOod7yLdPVzenkiJarkpfKVwj1y
	Jd+eN/fgmzGnr9wJeQsRLnVpdyLZv2BSjbN7S+CKrJyZ8Q0S6odPWAmuCOiQWoSYeQ==
X-Gm-Gg: AYBFou3CxybxlA455U8GMfK0rRUa00Ia1doYYRw4l6TlUWJM2oZGN3+YHnA+0FANaqk
	1L1UdWvZ7BuRie5VD7gXz05lxmc+4we8zTpUFF2zo1wf34B7FVgo+qbWej9LmpDRJbcX/cZWURH
	yGgepMr352ViTnLZa+dqvF3gfNInewqAuYngANhQF98KcbkwY9c3W12W36ISwKXj1kh0lrw9JkT
	cucB8TLSFxwcs3ze+Bkg7lRezAVXRVglRYEr3Se3UBh7OSCZkt88KVW3cgnxoHjL8Tyd0nWHKTS
	xUGYnl4m/f7PtiOXt6nKKHBvGFvF1AfscHOOc+6NlkMVQKCK1U9hHEEiU2TkvEZrkhH4XTeQwpS
	WGu4cgZbIXkkl3vCkPUnTk8MSjS/kQfYuk7B8NpSexrldpdb1Zk+6+wicAvL1QLPHRvdYwQQj1T
	JUTYVILaclMTL/FcNeqwdDQVaTebxShU0QexQJNVTZY6iUybpJEFZAWXK28ECHiAkCFrPHu1vFq
	zJ++oNaYMfnr/F6ENXV4l7oZqPaVmHkj2gDOFibLt7jJH1ywXcPNtAoqj7z90aHfbONqYTO9cXj
	Q44DuITdfN9wID/+fWukw4HAUrYqIfxR7Ki+sJIinFbmMtg3eUJXACRIdQ8nsa1RQZyZ5BtWdQ=
	=
X-Received: by 2002:a05:620a:6192:b0:939:b099:d52f with SMTP id af79cd13be357-9494ba7dfd0mr226368285a.20.1794544264634;
        Thu, 12 Nov 2026 20:31:04 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8f9576sm96595585a.42.2026.11.12.20.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:31:03 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	John Garry <john.garry@linux.dev>,
	Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xfs: do not let tr_atomic_ioend raise the minimum log size
Date: Thu, 12 Nov 2026 23:30:55 -0500
Message-ID: <20261113043055.2578595-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Commit b1e09178b73a ("xfs: commit CoW-based atomic writes atomically")
added the tr_atomic_ioend reservation and made
xfs_log_calc_trans_resv_for_minlogblocks() copy it from the running
filesystem.

However, the copy has the current log count of tr_itruncate. On a
filesystem with rmapbt and without reflink that count is 4, while the
function puts the old count of 2 back for tr_itruncate itself. As of
now, the minimum log size of such a filesystem is larger than the one
its mkfs.xfs used, and the filesystem does not mount any more when its
log has the old minimum size.

The issue can be reproduced with mkfs.xfs from xfsprogs 5.13:

    truncate -s 512M xfs.img
    mkfs.xfs -m rmapbt=1,reflink=0 xfs.img
    mount -o loop xfs.img /mnt

Before commit b1e09178b73a ("xfs: commit CoW-based atomic writes
atomically"), the mount succeeds.

After that commit, it fails with EINVAL:

    XFS (loop0): Log size 878 blocks too small, minimum size is 962 blocks
    XFS (loop0): AAIEEE! Log failed size checks. Abort!

This patch will use the old log count for the copy as well. These
filesystems have no reflink, so they never use this reservation.

Fixes: b1e09178b73a ("xfs: commit CoW-based atomic writes atomically")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
mkfs.xfs 4.9 to 5.13 give such a log to an rmapbt=1,reflink=0
filesystem below 1 GiB, or up to 16 GiB with -d su=256k,sw=4.

Application impact (Ubuntu 26.04 user space): udisks2 2.10.91 is asked
to mount a filesystem made as above ("udisksctl mount -b /dev/vda"). On
v6.15, it mounts it at /run/media/root/STICK513. On v6.16, it fails
with "Error mounting /dev/vda ... wrong fs type, bad option, bad
superblock".

Tested on xfs for-next with 45 images made by mkfs.xfs 4.9 to 6.6: 26
do not mount without this patch, all mount with it, and the largest
reservation is the same as on v6.15.

 fs/xfs/libxfs/xfs_log_rlimit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_log_rlimit.c b/fs/xfs/libxfs/xfs_log_rlimit.c
index 37712b2f8757..9454c91e9fb3 100644
--- a/fs/xfs/libxfs/xfs_log_rlimit.c
+++ b/fs/xfs/libxfs/xfs_log_rlimit.c
@@ -128,6 +128,8 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 		resv->tr_write.tr_logcount = XFS_WRITE_LOG_COUNT;
 		resv->tr_itruncate.tr_logcount = XFS_ITRUNCATE_LOG_COUNT;
 		resv->tr_qm_dqalloc.tr_logcount = XFS_WRITE_LOG_COUNT;
+		/* tr_atomic_ioend starts as a copy of tr_itruncate. */
+		resv->tr_atomic_ioend.tr_logcount = XFS_ITRUNCATE_LOG_COUNT;
 	}
 
 	/*

base-commit: 48326a2382d80715475d10ce98734ac65d2d2150
-- 
2.53.0

