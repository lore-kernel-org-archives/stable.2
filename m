Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334780;
	b=kVUUFMHAEDvnItJYE21NdTtBf5xt/kh1C60DWS7vDftmopjMno/F8xq3mSP4rJxN+oe7
	 9k6MwImB349dmtFPM0mzM2qGnhXunQhfe7WGw0DEKvuDQ9xLUFz4UI04DqVys18Xmc8aW
	 CKk0s0+/aUmISXtfppTp0+RFCEWG8YvPgEpK3/Z7x18awVyPY020QqiO0yUhB5f3qaWV0
	 +g2i9BCxCZkJzJWqCFrSsbOFu+xvwTbspkE6M5m8o1gwV6vdMVz8muT79mR7yWmSRYcBF
	 nsFq22NYWrpIpvoZhukUjrfcKU73TTUkXgUQtxz1XbWOZ+geECWyCQpW3KeuTv8zMsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=08cN2zjiidPHi6YZg4T3YGZ1WyZF/coSaDDzfAKnE0M=;
	b=otDuzW344t+C1TDqi+wYfEfIFwLBvC/+UNAgmqNHh5DX8qYZkZAiO0csqwbeBpKkiFg2
	 hXjKCQns4O7ofueEp36IiickWUmhPeptOMEKoR28yFyVOXc/cWF7nDz6J8qcVbM6c20zj
	 JU164s6FYDEkEFbmTeqCHfMSMDWgvdDrc8ngeu0p3rV56WhT2h3ZpYWjQc2liM01tGSEZ
	 zwr8171j9WeQvk4ogUEuSVIrub80SqTFEEo+0Jb/gIzp5NJL7EcbxOLVuzirOVHxuutBN
	 qszGoRJQIufVu32gl3DADkifq4YSZq6m5Jr8D8Q7mehDMUbJw/iTKDpjscoDdnmyLHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JwLkZznZ;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50C606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C50C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JwLkZznZ
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53bb57f1310so2857991cf.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793334778; x=1793939578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=08cN2zjiidPHi6YZg4T3YGZ1WyZF/coSaDDzfAKnE0M=;
        b=JwLkZznZNTP0IQTjsQ/sO8D36bcEPSSHP62VDPaa/tII8C1FIGC4m5nduW2ivEW8Mu
         nCmyHRx89mNXnFrKVQbwLWREjA83LZ4XrX21KJKCcAp7wVZzrhJXTXHXsQk5sdEFIbae
         9E9VijIGmjuRKfeByhfOIQCpwPw3O+OW0E1aBbtHaFik5/QZxtAS+CrMIaUlOL5bsNJu
         Dv6DHhH61VmDQ8aDJIkjC1kJm9f0FoR+0HwZCZ+1JSMBqhZdAAv+kVldgt+SjXWFbzU5
         4LvhLU7SuMaAypCr0tf5BAWmbjQazsTQpOnmJ5PS4JFZDhqTtNbl477mMzdd5awOcHH3
         JQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334778; x=1793939578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08cN2zjiidPHi6YZg4T3YGZ1WyZF/coSaDDzfAKnE0M=;
        b=DSstum2Bw+cBxy5teCK5nIjcP4CL0683Rik42PSsrHZLjwHXO4aJmxZN3w+GIEKbWW
         4H38svxmqNUPmoiHQIHYyC9do2j1WutRqyUIBtJIPz7PqEOqT+VsOafB4fV4bYFypVm3
         n37QKZ/IXnvj/JaMJW4ERlW44aNE1io/qfovOr5A52PJ9+38AIwwZdWP6+tEJQMq/HRm
         OAlVMdBhDEXzagtuOB4XBSou6Q6dx/OVlXPcmt2YThFvcd3FYRhFoa9BL0uBaHlSqnAo
         dvPCYWaUhh4cOlZWcBIltyCEYuuBQx++6iT/kKw0b9kR9Hx7IYP1p7tMf076N9++k42R
         PptA==
X-Forwarded-Encrypted: i=1; AKwUvBxLdkhfXhajZugOpRcDjqgJNZVwHg6KvdIF2s7vlh+ZkoqUSIeVg0HyahnAeUZ5LjHnSNRH2oo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEAWkeeXTOXbbmu4RMpAbDLkO7Yl5PCRw+c8dhWY9TT991O8a1
	XQGrrw/gHa71THdngOq4wZ+4MQvU5bp+HivdCES3mksnxpcofCg/a3sd8ymwx6OG6g==
X-Gm-Gg: AYBFou2x/q2K3pCBEafkWNlMM0udb8DS7LE84foBbX0hdIw/nlTz0G97XLtQEqcXgY+
	Cvozc1lia5xrObiplSeJj3HEUiGq0wi0Qa3g2uMO3ow2YcfweYoUHV80ysIevLng66lvkQNPDTo
	Yll2b+6pHKHwwruVFOPrO83K+i7IDfZwkWSbDzRhIQKc7RZjvK8+XWRSOflDWEaGaVUMioZuNKy
	mJxbX8Nxl1YCZbMmSphso0an/eetAOf8650RiWncN9ABgD8QlljeNQ5HE7qMNUgN0e1ono/Dxpw
	UfuZhZ3L9PgQGM7rvQJUP3Pmz/TnP9MpgLRRGHg4GEfJ383SQY1jNS94jC63TDbVsKooPN5jsS2
	ZowdKyAQZMmTPzTc8xh1ENfxB/M8upPTxHMwfZi7CRuLIpICeXmM5zu/5OkvWvKNDStPebaPfXa
	ELPP1AdT0O3XhuU3NH920GJbtiUteh7QbNq7Zsf9fb2Xrc3ksuHaE8TitJsjGgldxAkA97Z0bjf
	5EpGj0TGU6631v/pMaLoeVYNHpJE66KcORq3MCxB4WWQQJJfT0I+tmrinV1aix2WGrT3jw8AdrP
	O4SBjW1mrPSg+P6uwe7yPk400ff+v6vidVX1z8CgF87w8GjqM9/d
X-Received: by 2002:a05:622a:a1a:b0:535:25db:17ae with SMTP id d75a77b69052e-542b397a4demr17105461cf.11.1793334778444;
        Thu, 29 Oct 2026 21:32:58 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f25fc2sm5218726d6.10.2026.10.29.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:32:58 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: fall back to buffered I/O for direct writes past phys_size
Date: Fri, 30 Oct 2026 00:32:52 -0400
Message-ID: <20261030043252.4163173-1-hengyul@cs.unc.edu>
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

hfsplus_direct_IO() passes direct writes to blockdev_direct_IO(), which
does not go through hfsplus_write_begin(). phys_size only grows by the
block size when hfsplus_get_block() allocates a new block. It starts at
i_size when the inode is read, which does not have to be block aligned,
so after a direct write past the end of the file phys_size is smaller
than i_size.

However, at the last close, hfsplus_file_truncate() sees i_size larger
than phys_size and calls hfsplus_write_begin() at i_size, which zeroes
the file from phys_size up to i_size. As of now, part of the data that
a direct write has just written past the old end of the file is lost,
and fsck reports no error. Commit 5f63ac80aef2 ("hfsplus: fix issue of
direct writes beyond end-of-file") avoids this only for writes that
start past the end of the file.

The issue can be reproduced with:

    truncate -s 32M hfsplus.img
    mkfs.hfsplus hfsplus.img
    mount -o loop hfsplus.img /mnt
    printf 'A%.0s' $(seq 100) > /mnt/f
    umount /mnt
    mount -o loop hfsplus.img /mnt
    xfs_io -d -c 'pwrite -S 0x42 0 1024' /mnt/f
    umount /mnt
    mount -o loop hfsplus.img /mnt
    od -An -tx1 -j 100 -N 924 /mnt/f

Bytes 100 to 1023 read back as zeros instead of 0x42.

This patch will make the other direct writes that end past phys_size
fall back to a buffered write, as fat_direct_IO() and affs_direct_IO()
do.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Slava, you mentioned that you are rebuilding the HFS+ direct I/O path
[1]. This patch fixes the current code, also for stable, and may
conflict with that work.

Writes that start past EOF still expand the file first, as in
5f63ac80aef2. Only the other writes that end past phys_size fall back.

Tested in KVM with KASAN: the reproducer above, and all 805 fstests on
HFS+: 10 failures without the patch, 7 with it (generic/521, 617 and
760 now pass), no new failures.

[1] https://lore.kernel.org/linux-fsdevel/161fab786f919adb384fbf22dc19f3289bf5f24d.camel@dubeyko.com/

 fs/hfsplus/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aed0866499b2..70c13dcdcd8e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -169,6 +169,15 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		end_page = end_off >> PAGE_SHIFT;
 
 		invalidate_inode_pages2_range(mapping, start_page, end_page);
+	} else if (iov_iter_rw(iter) == WRITE &&
+		   end > HFSPLUS_I(inode)->phys_size) {
+		/*
+		 * blockdev_direct_IO() does not go through ->write_begin(),
+		 * so it neither zeroes the file from phys_size up to the
+		 * write nor keeps phys_size in step with i_size. Return 0,
+		 * so that the write falls back to a buffered write.
+		 */
+		return 0;
 	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter, hfsplus_get_block);

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

