Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478839;
	b=H6OVVPiPN9aUGRg0KegwtA2XUoa89Mav2BYy9lQstRp5lxPkUZAv5WkuEQ+jhJwMU4of
	 aavs98SoSsaOgsOl0ySoQh2cc/png0YhSCqfodi4pEQc/CZLuGfmQ2HIlynHYEXRZym55
	 x2c6U+hD9vjqAEiJPjM3BF9ZZTdj4mWuVm21kTztvKdm+1a7mkIS6XfevYn2BDQZ28etC
	 gcJYUef9BTDAfdacGbyW0eNjtfBMEWvdBmyZ52yHcAqZb3lwgKqNa62QtHPIdFNIkkzK6
	 1cbySC2VVqDpqbLfLvrWa6SYoxv3zSvJLgu3VUUxN7JcjXk3dIpd6v9W+Y/4nzh0wEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EF7KRxBo0qNjwVf72fb3/RBlZOqXFYYSTlSs7Me9Vk0=;
	b=3hK8aR31qkYWSvkj/hMpRFAIuXgtZOon9D534ciA9lt+yOZmZbFLC/simqT8oJx2UNPb
	 kJMJCet2hS8BWkVUZ8GSLGI8FelyygSAXIwtj4PDLSfiLv1y9t4wdDmzCK1gwy4WpZMZd
	 xnP3kd5l4gW6fPQdyaEknDXlee7lbbD/JPfKCUzxuYUfQwkdnmKjyfm/orcW3OjglIHb7
	 /96H1bXSW/ofCjourDfOrAFqHtkEizqKB/QRf92hd9TsuPvLkKSrrdkCVsor/NUzIHv0C
	 rxaFnIWQmqmEzbSYOo6RMH9Z34U9MGyi5fvCUqpIK5cfrMpDjIDGu1mBCwkDE775BCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=BZ0kacbc;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC8606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BBC8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=BZ0kacbc
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f3c895a0eso349480585a.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794478837; x=1795083637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF7KRxBo0qNjwVf72fb3/RBlZOqXFYYSTlSs7Me9Vk0=;
        b=BZ0kacbcCRVq6LBGBfa+HzANug4uNF5z0Lf8jwfzYrm1y6NYl9QHzLqnz9KNipWQWY
         nTZnUTi006r+tN2LBDLQNShf+oemvUPDqVuliBF+QIuyPx5oOqsuwbXLhOiC1CfSgcB1
         2Aq4jnAuQOsdy2mcuDvEVQRdXWpwVghQ7pJi24Uk7RGBGO1QiPHCslgbJpZ+IZwNNKCp
         mqOxnrecpPgEsRvQD3XCt57xznz7iMIvpw9KcteBARSdGVmxQJoLBvllPC2EEqBThiJ3
         laJ6SW7CT/viIhZGjKcCbeb4KTZAweFxs11Lo26Jpf3BVtEBCc7rSklk+mmRR4WLEk/0
         iilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478837; x=1795083637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF7KRxBo0qNjwVf72fb3/RBlZOqXFYYSTlSs7Me9Vk0=;
        b=bOYaQaXZr9sMiDetpBNImZmaCnc27dMWo8zOYba4kGdPDWFOe7wq9V41tO2bZlV1ld
         rY1IeWdqpvZIF5ZuJSRqq41nBtL1dyKxLF9mrvKYbRrwMKXGMMMdaoFEHD+gqbcbsPJ7
         Fx+/VYfs+yCqZFoQTuunubAEWjanqNVlDtjQeLl9jRF2LNIGGpy7hOzbGTa8MoTbT9N9
         RcYSSAPwoMsvgRskiv2wygH0HeBjyN/OkYdROzpApPYTXKBm8L0GA6CP2922WIRCg2ev
         WblAEaE5z89Ejmz/4ves7KDrCLgXZBmfpEOJ+Z8BvfB0IJdStNpZK34fEOnb3Hzo9p4/
         MpLA==
X-Forwarded-Encrypted: i=1; AL+hErFcFqX8sL+iobDM+1brqCBoDvhXvDOBCenNXRsDabhBcRljbQ3qcdtfIOmmxakLVGmoJ6TqX1k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G2c4jLBqKClgII05XC/ov4+XdX/wg1kOo49zoTnVjEBa4Mkf2
	18WfziZ9Q9Wadd7gX1aUlG9yM/Ifur0KfRrUgsQDcR744HyGsML4rbqPynEKwJUHQ+uPPlH+swV
	bST0Izg==
X-Gm-Gg: AYBFou2j/BdE6szdvQFAR/g4Eb8z4nYQWZsIwdWvHNid8kVMX0HHp+LsUeZqtZRP1sn
	RhbKIHfwkb8yimVVx+SesVFFZe4vDPgtX5U2S9tzpfJTtop/fz1EN8vmjOnsarzyY/NeR+kiI0e
	jPo05ozSQh/+dkLElKKULB76Rzj1ngr85egAPIpPMW8BD8uXFW2zzyom5oMzDUsUG/yBWRcJ5PD
	x2O1pyooGdtfIh/BndvxiuhII4AtrjRE1dEIeWvOFI/olOeOB5+lB7E7C59gvXausia3Kfddsv2
	SimRJne+AKy0lAdpv8P/pT3K2pUslckbcjtXDlMTlYLnVEvJ0R/3PaxQaXnR1NH3Nj1DQ1wydi0
	gCaDNx/hYSt9ngwjEB+DDgrS30g2lhS4RT33E2biB5Kef/3G7KB9PI/zvRmChfRmmUoKxvOfv62
	65knjj359v6pPzUYxQEeXn120t4AFzBY7/wRbVSqmWlRK3Equ4kUTwRgkoHUpKK6n8V/n9bNhlj
	kwi6q7nT83isyDjijmDeGIvXvBd5CCs2iYRy2RV4VqUEDOCb6d+Mnw1RbBAqcn6HtFv1cc5uHVb
	rb92Sv3HiiUp88Lcd50HerCjUW/BKhVwP1DqYE7MQlnUa1K6z6y/lsFnDVmsVds93bRklxLZuA=
	=
X-Received: by 2002:a05:620a:4412:b0:93f:38c7:64e1 with SMTP id af79cd13be357-947affc99efmr842215585a.25.1794478837209;
        Thu, 12 Nov 2026 02:20:37 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7a8348sm691143785a.26.2026.11.12.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:20:36 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xfs: fix f_bfree underflow in statfs()
Date: Thu, 12 Nov 2026 05:20:18 -0500
Message-ID: <20261112102018.3922571-1-hengyul@cs.unc.edu>
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

Commit dd324cb79e54 ("xfs: refactor xfs_fs_statfs") made
xfs_statfs_data() limit f_bfree with max(0LL, ...) instead of
max_t(int64_t, 0, ...).

However, the value is an unsigned difference, so max() never picks 0.
As of now, when the free block counter is below the count of
unavailable blocks, statfs() reports f_bfree and f_bavail close to 2^64
instead of 0, and df prints negative sizes.

A similar issue happened before and was fixed by commit 237aac4624aa
("xfs: ensure f_bfree returned by statfs() is non-negative"). Perhaps
the refactored code needs that fix as well.

The issue can be reproduced on a new 2 GiB filesystem mounted on /mnt:

    for i in $(seq 3000); do head -c 65536 /dev/zero > /mnt/s$i; done
    dd if=/dev/zero of=/mnt/big bs=1M
    xfs_io -x -c 'resblks 100000000' /mnt
    for i in $(seq 1 2 3000); do rm /mnt/s$i; done
    sync
    df -h /mnt

Before commit dd324cb79e54 ("xfs: refactor xfs_fs_statfs"), the result
is:

    Filesystem      Size  Used Avail Use% Mounted on
    /dev/vda        2.0G  2.0G     0 100% /mnt

After that commit, the result is:

    Filesystem      Size  Used Avail Use% Mounted on
    /dev/vda        2.0G  -64Z  -24K 100% /mnt

This patch will compare the difference as a signed value again.

Fixes: dd324cb79e54 ("xfs: refactor xfs_fs_statfs")
Cc: stable@vger.kernel.org # v6.14
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
The resblks ioctl only keeps the reproducer short. The same values show
up after filling a filesystem, writing with O_DIRECT into preallocated
space and deleting files.

Application impact (Ubuntu 26.04 user space, XFS root in that state):
on v6.13, "apt install" stops with "You don't have enough free space in
/var/cache/apt/archives/". On v6.14, it prints "18.4 EB available",
starts the download and fails with ENOSPC. GNOME's "Low Disk Space"
notification is sent on v6.13 and not on v6.14.

Tested on xfs for-next: with this patch, df, apt and the notification
behave as on v6.13.

 fs/xfs/xfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a06132aa384..42be6bd34d43 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -916,7 +916,7 @@ xfs_statfs_data(
 		xfs_sum_freecounter(mp, XC_FREE_BLOCKS);
 
 	/* make sure st->f_bfree does not underflow */
-	st->f_bfree = max(0LL,
+	st->f_bfree = max_t(int64_t, 0,
 		fdblocks - xfs_freecounter_unavailable(mp, XC_FREE_BLOCKS));
 
 	/*

base-commit: 48326a2382d80715475d10ce98734ac65d2d2150
-- 
2.53.0

