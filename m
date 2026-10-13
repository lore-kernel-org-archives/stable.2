Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D0331200
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882297; cv=none; b=Pt4I+rSr8KD0lt9hWHxjsGH5cYpzZPMHH0bJ6+27x1u+8FPDW9TiMoNheInCgtQuo4wStFoV2CSec5GqulVGkIhzfo33bqwfOe1S5c3UrTh8f0Mjzd7k4EbnS+wqCFjttLt+YvMemQUKyhGrk7SeE2XDB22JhA+/fty4SqURrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882297; c=relaxed/simple;
	bh=GEyscDG3hRct4i5PqeupCLPTXDZZMD3LI88vgtxk/oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuWezhfA8Qg9GpZRjVxl67O9UGzQO0nkeWlsMVbtZdwIo7SMt+ltU0ZgwCqPyW6wAv7U3Oq6lvby2kpX8tc+F3tbNKs8Slu3sf+EW1djzbe55IB0oE9dIxs12RS30bETPpKsZ2oVW8h5l2+oZhKgHU4RrSEy0czqFRfWQGN4RcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsuiHND5; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsuiHND5"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535dd9a601so200443eec.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791882294; x=1792487094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxhG2H1+Sm23DRdhBURFp45TF5bOWuOpjOESI+s8Fjw=;
        b=SsuiHND5UcztOFPmlpRUzqFDIddDCL5nVwQxbuwx/X8zyVb94TfJ+lg5bRSoFwiQjZ
         9i1cDNadjyTsxPMMq43gPSEA5HjvhGAMj6kF0KuW68Km6QTXOVrjtHvh3+SgRkrKmwQr
         Rx4sIoN7bnc6Dswtk4oDJZPRMM5vF4rm6SZcoY4+zoZek3ORcX5BSvhxcQpwlytMJohx
         sulTHaxBjqF60+VBHhaCabSDWGzk7DA+d0U2n0FFeqZRPNAqHFl22iqZqU4KL6cFBqg6
         cm4GWRzz3SDKkaVFj6rEqw1bcs/nzJgzl5hE52p4jDdSAKis6KNuEK9AtbwScLxSqjhr
         T4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882294; x=1792487094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxhG2H1+Sm23DRdhBURFp45TF5bOWuOpjOESI+s8Fjw=;
        b=qnkTfjz8NXkCnIQowb2fRBDlp1pobqf7r4b8jkaZydxD+LwYQjijO0XEfrDWE545Ac
         dD/i2hHZawHjdxkuUkVStzddEoR99vYIV/ysNMwnpqhBHOJ0ALphToSygHWxb29rVW32
         Pj/MYKQbIajWKEhOCq91cnsr3UZJRp2Bx4whvDVVHvMzg+jd/bs8B38wal1zq9ksQ5xT
         pwmFuTrMOmm+57hPhfT0qts11uJ+MFHFc34RKwbYOGXRHT5/r2U/A7AW27iFCSUs5abO
         Exx+yqVK46ig2Z++KNiMSK4Cc8ZNXuCcCw/bEVhn5GJ8xyXYnvqxXfC8hqnl8vCXbHAC
         669A==
X-Forwarded-Encrypted: i=1; AKwUvBzXE4tBDm/jna2jRyGnOCzwThyRuyh9spB9kYl55b/GfUnVQtoq8+Si7LXgnYwWnlvVXBNT/M0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2RcEa2eWFwD4kyTmbVpvkLhVc1Ox96Bxq0pjqCKOouRA1UgP+
	ykRoXrj5XasffZwZauoKOsxjWnGwyFzAjEvb/LTSp7Myfaq7EHiLcb2S3ph7mVu9
X-Gm-Gg: AYBFou2OxeP/5t8wGStSxLTyiVUjZvDiAYk5tnK0xHIfsqHfF3FDucL9JXYMDCPZULF
	tXHR2EQaF54cEuFm/4l2yYT69e9IgTZyc/33anF/yrObfBoCHUeaVGrujNxOgF/5a0m8k1skz6o
	5JdBSv6CEnz8+h7NxIa4myjoMDX+tiQkUlGwlICp4CcWpc/8dEMYFjTxFSwNAzQIODllaQR89ME
	pncV+hEoZyyHHVJOGx/P3rlp+tYJCvFvP9xaylg0aGX5IF7RiLcYtvIythX87lrcQ/jyejqIigP
	2ZBnrEyTL7nrx7SyfBPC743xTV2wwlIW4Jq5IZRHuK/h1gjMU88KK8uhKKTPWGmNh5KfxDr6S6H
	PUaRc8m7GjnjjL6SjfBwYhuaBqZqDGWoi4iX/g2YzkLaUJJbjETE6K1MdBj5dMQEgI+H2++lL69
	PH0VCAP/3D0N32I/imJsUNteu5eS15YWATpKXKn1dqHWlDEvSm/xhHx2yUVD007OGCR4EOpDHXr
	dcDnXlyONB5kHPkdWrf+toTvczEg1NeMsC4gRRmZrENSXS28xtXAQb1wryNJ0Sv
X-Received: by 2002:a05:701b:21ce:b0:149:c766:2965 with SMTP id a92af1059eb24-17a0d84a29amr2902969c88.2.1791882293581;
        Tue, 13 Oct 2026 02:04:53 -0700 (PDT)
Received: from localhost.localdomain (45.78.65.84.16clouds.com. [45.78.65.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2d2db98sm35211947c88.10.2026.10.13.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:04:52 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fuse: fix copy_file_range reply handling race
Date: Tue, 13 Oct 2026 17:04:47 +0800
Message-ID: <20261013090447.1180121-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__fuse_copy_file_range() selects its request opcode and output buffer
using fc->no_copy_file_range_64, then reads the flag again to handle the
reply. Copies to different destination inodes can run concurrently on
the same connection, so the flag may change while a request is pending.

For example, task A submits FUSE_COPY_FILE_RANGE_64 and waits for its
reply. Task B submits the same opcode, receives -ENOSYS and sets
no_copy_file_range_64. When A receives a successful reply, it reads the
uninitialized outarg.size instead of outarg_64.bytes_copied. This can
produce an incorrect return value, page cache invalidation range and
inode size update, and disclose stack contents if automatic stack
initialization is disabled.

If A also receives -ENOSYS, it instead mistakes that reply for rejection
of the legacy opcode and sets no_copy_file_range, skipping the legacy
fallback and unnecessarily disabling copy offload for the connection.

KCSAN reported the conflicting accesses:

  BUG: KCSAN: data-race in __fuse_copy_file_range / __fuse_copy_file_range

  read to 0xffff8881014a4d4d of 1 bytes by task 123 on cpu 4:
   __fuse_copy_file_range+0x1a7/0x6e0
   fuse_copy_file_range+0x54/0xd0
   vfs_copy_file_range+0x290/0x9d0
   __do_sys_copy_file_range+0x10f/0x2f0

  write to 0xffff8881014a4d4d of 8 bytes by task 119 on cpu 0:
   __fuse_copy_file_range+0x633/0x6e0
   fuse_copy_file_range+0x54/0xd0
   vfs_copy_file_range+0x290/0x9d0
   __do_sys_copy_file_range+0x10f/0x2f0

The bug can lead to leak kernel base address for KASLR bypass, the 
corresponding reproducer can be provided per request.

Use args.opcode for both -ENOSYS handling and output buffer selection.
It records the opcode actually sent and is updated on fallback, keeping
each reply tied to its request regardless of concurrent flag updates.

Fixes: 7a37f55af7af ("fuse: add COPY_FILE_RANGE_64 that allows large copies")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6 Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9a36d0329e221..939391b48cc9b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3019,7 +3019,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	}
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		if (fc->no_copy_file_range_64) {
+		if (args.opcode == FUSE_COPY_FILE_RANGE) {
 			fc->no_copy_file_range = 1;
 			err = -EOPNOTSUPP;
 		} else {
@@ -3030,7 +3030,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
-	bytes_copied = fc->no_copy_file_range_64 ?
+	bytes_copied = args.opcode == FUSE_COPY_FILE_RANGE ?
 		outarg.size : outarg_64.bytes_copied;
 
 	if (bytes_copied > len) {
-- 
2.43.0

