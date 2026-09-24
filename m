Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39B41F378
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233688; cv=none; b=WEnXq7Z+M9Yw49K0Ixa1Km3b+HuVxmI5dmHDY4vqU5GpOnna98puwMxs8mS5kBcAudDMVHVYYDlT9MGgRDiydEDgJeLLh3lrEAjNxI/TMcBA6BxPrYupjeNOE1DThK0FY3KsVB3EatsKQ+wvzSmgA8ZiIkp8mtuHggY65zG5xik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233688; c=relaxed/simple;
	bh=vcPUZbFrBI9CL60zx721prFO1FCW3vFMLr0evu9pNyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3mv9aC9p2BFo5DqcS4AFuOxc+vjq/mbhLMsU+tCJxowD9xzIuzsiCRi5E7N+1wyfVuzNNX4fPgNey8OBd4GBqXu5rZCz0wGkudfDaqpwfi8coYBXdgg5P6LKKSagpxdCvJcLYXnpUTPyykubwhT/OeP++SRjXt97PY++XXddG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjsiEF9J; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjsiEF9J"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso10634705ad.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233679; x=1790838479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5R0eORI8KBwokh6UjkxTkUhIY7LnGT/YgU3s5d7Wnk=;
        b=rjsiEF9JoDc8Xmw2s7hjfQwfQTHYDY9krWnuwLiU7m4ZQvdg0pnsjLM3z0nKUoYkDI
         r+Jjb+FY5JTts1ZVscxfj/ubs2CTHbjXNhtIzsllBw8DpOOGPtQ/bUyXzYyOK4MeTktC
         DLsu9kE/1bXISxdCgpbFalxuKXkYMGcoUq/dZL0rzP1wuuizNv2zeQIoMXB2ZTijOg4u
         uiVew1fShdhz5q2w8BrLCAaRbohaIsZDHbU+1VeQrAqMckq5iqHPYRRmIayQC87j02hI
         IWwQODcLQ8KgTNkEGeWhLrWg7lc7aCegkCx9EQy5tQfEk8MzXCsROK5FOJO3sZ6gWAjd
         p3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233679; x=1790838479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5R0eORI8KBwokh6UjkxTkUhIY7LnGT/YgU3s5d7Wnk=;
        b=tn6a8EmujVqZ4gvNusjeA7CB3XSFLqneEM1IsjRkVrGewHovb0+OY9aNI5/tXvH7Om
         GEmV9RfP/2KhpWxZdCE29Vb1Qhmzw2sPwg+ABXVxJrqcLz+YIaSDQBmTjI99UKj/CzXy
         zjPEEt166ntx2O+v+W7XKcvue/I3azk4RG9YP4Jtalq24CcOfNXGPJN7sXbr/SmlGNo+
         vxazL1FQY8xcjntR8bQeA5eWEj5+1VTyzd8ch29LQJY/Q0U3ZEXPRn1DBrzrxFZ0j2E+
         X/mLejYqnXWDqiRyADJyQj01klCEIEufVoRVxKDq+9PFXLjKKAxJ8oACCjovcUNrRD/F
         XRCQ==
X-Forwarded-Encrypted: i=1; AKwUvByXxfnYvsHbbklL7DK++jKNxEWcyNO6lPgrNyP+6b9QXNDLK75IHK5oKtpk2M16TqGvygI/6tc=@vger.kernel.org
X-Gm-Message-State: AFuF++m2D5Jyi3e9tm04oCbTnCStOzTtj3tKhhpRbaa9D/9isUtLwRvW
	cvfGE8qpLL4sa8SHI4xVrQNxYUyZ1jw6ETH8QyeVyzEN7A3FIS8i+9oY
X-Gm-Gg: AYBFou1ugBqYMTMwUxDYqtjnFwPqJ7hXm9iYWvF1n0NqLGyFUvbfuRB4y6c+IqeugeX
	nMVF2KkFQcWhi+3nOhVBSeDIS8Yn9dJfGdyk8DDUTwaxYhQjqytTK3PUA+uVSLkxaSAAqaH2ky9
	uW9eOq06ThdUQn4l8Pj7FXgnHYzjPbTrDfoWzDe6cDPLbHtLiEvVoToAipYmzENOb5+/hpBCxzi
	YomZDDbbkPfifvXAOjmLlbqKHOYGDoH8ZYK7EdAGn4PtSskqotu8f+5B+hbWa+tiL4/hUszDHiB
	RS1f05wlpHpygAA61a73OCe/XUV8XWiDFmFKtRS81Y8pd+cq+b2/yQTVkADZnTvscg1VPHSFaGu
	cfPIfSTJqjQ5EwkVksL3GzZxIdWezv3ng8fmnrUp5FCPeQN27iXOE3oKH3JI2QuU9ByzRxjZhhX
	J4PxaoovazuWaC9HiE6LKXQBLAwAQ+Xb9J5drauzvGvUQWW3jelJ7jUfERrASKR3HNluXIMu7lB
	EZfd+4m5d6gT0KQeTsT9xEGhZT7X9JZWHxRBrsUO9tLH9Ztdjh4UsZzLTA+VwtB/TZ4mYsDvUq0
	qVMVMYP5Eg==
X-Received: by 2002:a17:903:94e:b0:2dd:4f83:eef9 with SMTP id d9443c01a7336-2df7da60be9mr14149235ad.4.1790233678960;
        Thu, 24 Sep 2026 00:07:58 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6afc80easm21832025ad.30.2026.09.24.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:07:58 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2] hfsplus: validate inline xattr record size against entrylength
Date: Thu, 24 Sep 2026 07:07:57 +0000
Message-ID: <20260924070757.2646279-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __hfsplus_getxattr(), record_length is read from the on-disk
hfsplus_attr_inline_data header and only checked against
HFSPLUS_MAX_INLINE_DATA_SIZE without verifying that fd.entrylength is
large enough to hold the inline header and record_length bytes of
raw_bytes. A corrupted attribute B-tree node where record_length exceeds
fd.entrylength causes hfs_bnode_read() to read past the end of the B-tree
record (and potentially across the bnode boundary).

Validate fd.entrylength before reading xattr_record_type, length, and
raw_bytes.

Tested in QEMU against Linux 7.3.0-rc3 by mounting a crafted HFS+ image
containing an inline xattr record where record_length (100) exceeded
fd.entrylength (4): on the unfixed kernel, __hfsplus_getxattr() read past
the end of the B-tree record; whereas with this fix applied,
__hfsplus_getxattr() rejects the malformed record with "invalid xattr
record size" (-EIO).

Fixes: 127e5f5ae51e ("hfsplus: rework functionality of getting, setting and deleting of extended attributes")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Drop the hidden_dir cleanup hunk (already covered by Deepanshu
  Kartikey's patch series) and focus solely on the __hfsplus_getxattr()
  entrylength validation, as requested by Viacheslav Dubeyko.

 fs/hfsplus/xattr.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c71f..10aae766ea42 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -649,15 +649,28 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 		goto out;
 	}
 
+	if (fd.entrylength < sizeof(xattr_record_type)) {
+		pr_err("invalid xattr record size\n");
+		res = -EIO;
+		goto out;
+	}
 	hfs_bnode_read(fd.bnode, &xattr_record_type,
 			fd.entryoffset, sizeof(xattr_record_type));
 	record_type = be32_to_cpu(xattr_record_type);
 	if (record_type == HFSPLUS_ATTR_INLINE_DATA) {
+		if (fd.entrylength < offsetof(struct hfsplus_attr_inline_data,
+					      raw_bytes)) {
+			pr_err("invalid xattr record size\n");
+			res = -EIO;
+			goto out;
+		}
 		record_length = hfs_bnode_read_u16(fd.bnode,
 				fd.entryoffset +
 				offsetof(struct hfsplus_attr_inline_data,
 				length));
-		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE) {
+		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE ||
+		    offsetof(struct hfsplus_attr_inline_data, raw_bytes) +
+		    record_length > fd.entrylength) {
 			pr_err("invalid xattr record size\n");
 			res = -EIO;
 			goto out;
-- 
2.55.0.1082.g2b9226bbc0-goog
