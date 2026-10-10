Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CE41D4D0
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616504; cv=none; b=RZ7gonWaO4QtDZeyariKun0MSCcTdfwrYFmbJY0zOY+bZgwvIGGjb7wJTkqNSf49IMBkaUEXY0mO8atvmgnQ3rvjwEHa/K1931fSBuxCvNt7vhF8Za40LqxhBUW58AVeUu9ORhmz+avUqjuy6LFjkSzEUg8o20DXHWJLjtPVOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616504; c=relaxed/simple;
	bh=AgqPawQLsHErmF3nORcLRMqaINWXlnncdcFbCC+PyuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=exrr8Zf1GBcp0cX/hxQZde2afXJv/H57vMYlyhVvjx2D7IQMkZDpwHzqOJogqgeeGEimHDy3mVMXae9UfB2XI6odfXBHmhybtF1kmxxNl73Vu94PayM+l6Fw/ZL69bkqryTUQ1+D0Vm1GhBfgxkdU6FLQrsCYqUMGyP7gyzshWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFPkPhfP; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFPkPhfP"
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e609985789so1778485ad.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791616501; x=1792221301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=959yGHgkihQFutwKGlb/mZ/n3GWGE1NHJJyd2mFaKLM=;
        b=hFPkPhfPPbuxbfmY7+UwzIgq2K24FnV234YTzI7oMUeoLiKdFvr2fbqgMNA9AV/J63
         71Yl5lR2eDogeslFMEExZK/d5P05Fbgvh+geXlzDJi5aK/OFUkBTGkjTX074pEVCh1W2
         SfRIQDel5oBxebzV57evUBJBhhFdUcSmbVUEhBx3Udk0FO/Vn3QsptPM9NSVNUPXompM
         Zso/2/l3331o77ZgTWLkJ5Nql23omuylNPYuZJMSCAKreABHHMPUW3sz84DgLBD+mwFN
         mperSALlX+xvzcyD2POj7B9J6cKDJq0dFjSqK+Ix5yFIC0qG2CqywzB6yvjgTkkgyvXF
         svRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791616501; x=1792221301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=959yGHgkihQFutwKGlb/mZ/n3GWGE1NHJJyd2mFaKLM=;
        b=n+Ux9B0YxvxA9+ia5IqLuD+QiT+xgEe6L3qpqPwATwgYl8w+aW+OQzI/qYi+K69Tcs
         0hgzwiM4/rucYL/wbLEcsRLtv/UREtDSHOwpyxgN8at4nSYolUfy5TcW82hb6zJYz5og
         auNc+aefFwSKkGZ4SWSuST2ozMKH9vAZ9G/7aJNO2jIjzLzX/Ks56MTMKWNfSrdo0z/E
         CHB2tX766h2j6ZJbivnD5xwAbaV3l3mRXVDsHNlps6nn+VhcbG839sgdABcl88OVcpEf
         I6vyXDhE2k2lnhP1xktj0ZBO3SfDjN6y8vYNzJ9pACZnOg45aS1sPWO5T98sFNqG66h4
         Dmgg==
X-Forwarded-Encrypted: i=1; AKwUvBzgwI/Apvd/wvt71MVFSmzQ0XUvFx9qHCT1evOaS4ekgSfb9iYpj4HMIJ65r4Mzlx89G9BAo3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHLnDfXk+/6WsKzes8szgummVqZ++oEWp0DozWT33JcuG9j9mq
	n7VC1icwstNLThl1vnjugaTyor7S6ptYR9fekA3B21nbpxxf+5V0o/TW
X-Gm-Gg: AYBFou1OerjAocRD65Y5Yp5eRwy853r/yJc3l7zMMhuOj0xUR+A2UJC6KlKPwaePc/r
	T/4t9wSl0rpTDQ3/bl33m+39ZwUbb7BY2RFZvuB76FC65LDho+z7xUX0fN9PrIZ4l+dG1R1jJgV
	Ey7yLrxPi3Y85Fl3biBw+zsepGJozVS+de7hL7AGWNSVRDidR1A65DBCzmpW1PyL1E/lsXfTF+c
	BHoruIUNFHieBNUGWIp0O0UgYRX9IPh3nzbVOD+M4+80w1wSkc/mpm7jTh4rcWEITelBtsvaoHO
	J2EEOU/wdlXVs+fcUnM3EYNX5VRLzbH+2yVemZfxp03cUi0YVmHQIx+z3HyTG3YvCAKRNfc00o2
	Itoh6mIcfAGUYmYHcoqyMsGY1ufCxZP7xFnjxEGYUciXPJ9bMuBZQ6n8JnnDyv3gaIZ0kVhDU6E
	uJ3uRCQUIOXYzKW8KAVbUBrh5Qtdob9iBg2esWQWCAhvAyNk56qdOd2JsJxZZPyH7uD4pqex8Mk
	KYNcDX5c5ZSdDSsb2I21+kiYIrN6CyhdPSp29jdy3+Bua6FYnoseq2HUG+MO7Q=
X-Received: by 2002:a17:902:e88a:b0:2e3:1776:278f with SMTP id d9443c01a7336-2e842bcd141mr39945135ad.42.1791616501197;
        Sat, 10 Oct 2026 00:15:01 -0700 (PDT)
Received: from localhost (ec2-18-183-150-125.ap-northeast-1.compute.amazonaws.com. [18.183.150.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421b15ffsm20468025ad.36.2026.10.10.00.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 00:15:00 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH] dax: fix wrong size passed to dax_iomap_direct_access() in dax_range_compare_iter()
Date: Sat, 10 Oct 2026 15:14:53 +0800
Message-Id: <20261010071453.6028-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

dax_range_compare_iter() passes ALIGN(pos + len, PAGE_SIZE) as the size
argument to dax_iomap_direct_access(), but this is an absolute file
offset rather than a length. This causes the underlying
dax_direct_access() to request a massively inflated nr_pages via
PHYS_PFN(size), leading to unnecessarily large access ranges and
potential spurious -EHWPOISON from driver badblock scans.

Fix by computing the correct aligned size:
  ALIGN(len + (pos & ~PAGE_MASK), PAGE_SIZE)

which accounts for the page-in-page offset of pos, matching the pattern
used in dax_iomap_copy_around().

Fixes: 6f7db3894ae2 ("fsdax: dedup file range to use a compare function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/dax.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..213b1c9e197c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2197,6 +2197,7 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	const struct iomap *dmap = &it_dest->iomap;
 	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
 	void *saddr, *daddr;
+	size_t size1, size2;
 	int id, ret;
 
 	len = min(len, min(smap->length, dmap->length));
@@ -2212,13 +2213,13 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	}
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
-				      &saddr, NULL);
+	size1 = ALIGN(len + (pos1 & ~PAGE_MASK), PAGE_SIZE);
+	ret = dax_iomap_direct_access(smap, pos1, size1, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
-				      &daddr, NULL);
+	size2 = ALIGN(len + (pos2 & ~PAGE_MASK), PAGE_SIZE);
+	ret = dax_iomap_direct_access(dmap, pos2, size2, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-- 
2.34.1

