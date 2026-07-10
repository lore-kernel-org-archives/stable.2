Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BA2D3A7C
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650662; cv=none; b=mtXhq0f4RYLHuMRopbKmeD09qczdxWYoQWQhQDkgZVfnYh285LmmQCDKp8D8/d0/AhoGrF2LeCShtRniC98oIpbWjzKqhh+vsiVXH656I9uATO0IBtp52FgDK+9k4lb0k0QmSIK+d9XvF5q8wS/tyEBgFVoEGDAC4W5b0Vc4dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650662; c=relaxed/simple;
	bh=46IHW5kOXqyiB5yT1qHGgFEZCMXtxEsKIeHLPwqmOc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJ7obIYysm6HPJG9YdoRuu0GCMNrt0CxsfBYW+uAqyvfcJ9bz7iFx4nwwjf8cUt0/Soz1GQLmf8ufi8dZPO4fJSjaY/xSZ5voRWq1rqV7LU4zOwPkbf1DaWIG9Kvx5ZAorWF285bDsh0PTw1xwNZ7JcJvnLm19+0eXcKHODtwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9juJ7yr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9juJ7yr"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0c45c580so2812821cf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650660; x=1784255460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcg048O+IxpZhUZpV0edccOsRb7Kf/SXUV8o+WElGKg=;
        b=i9juJ7yrepmXC2+dyK/HuF9eVv0NwtMHpIkrK01Tkdv67LsGOkY0JM4ifCDLmGvUiG
         jkl5SG1riO+MaBDJN8rYWynQY1KxEMbu9e6T/nBfB8cEzdpmddDR9Rah88xSE73aTwcM
         UO+R5AvZKi+jDMNqY9LA/BjYup4SQDRHnRtAth4dDm6HYcBvBZTwJ5S2zC/mvQIE1mJO
         cmnpdO8gUSJK/O/SMV5QwZ8qWwefoLv2U0r2Fl33k880iy3fHluxhN6+D4LBAIxRF5gz
         BcGsyvAPQWlwcxUoxF2uvXPEt6YvNaVDkQeih34sYM7ktVpnI089cgSyDt84CSwoglJj
         zzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650660; x=1784255460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcg048O+IxpZhUZpV0edccOsRb7Kf/SXUV8o+WElGKg=;
        b=gij61IGJPcZUYi0gSI/eNe5ogr0wF8cvGhoosnilSjHZPBbNegBTy5aWuWOZkIDt3G
         x6LuJLm8ZCoeAFxmmFu8lAB+ZCdcenQRhCuiPV/0DcLvQISv6Fy1/Ffx4yGG+j1PtGuq
         msHYqnOd2hTrAUat8XITEiputfWSI/MP374cm5saS3NCK5zMtZeU5xylkgQfVQ2E4tz7
         e086UqCVqnDr5JWQyVNV3WdMLi8RHfNtuzFTKvhbgnddd+gc7J/lUi68OtYtKuvWHNqD
         wbBOe8dAw7fZ2ziU/sjOMQ3rx+l7Yor0CvuMn0YR7FRK6RNDKBWds7rc2xI9yAc7XTTv
         9yHQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvL47bbbj2sjtbqslO9BKU1FzTm9l6/+y7N+8WFxHH6R/AQSsYllP8Tq889UN3Cu981Z+ZbCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX6dwDHI0EKo0JwhJ3brD7so7aB5QiqVVomu1U1HDI7rL7eXNa
	7Lgir6+32jXYMhun/lb0wNVj14OgADRrwhrMmidMZfpXSV5l4239XgSf
X-Gm-Gg: AfdE7cmV9I5RuTWnr4OyoMCEa7pqFcweRUIMZvcEgDpkNY7S4JyPMkBt/2t4cliXZB+
	mfDLloIU4UK2vWd5ti5mFUxz+MdqF+J+H6BIhzIPuA6KD1D91inVymXwq8Vb5vT+UinvE0ixwrt
	4P9rl7DTvGCdENTpAkGNUbO3cjvfnLEJbLWjv3QJJdhxOwWIdTxqGrgraCF+wGoxgJwvVyxjdzK
	bnL8gC3w+tjGymuJXcoIqnnpYtcfTag5uYVE/v57jXflfPyDna7dvHA8E6Zj9Zkpf8+c13Cz1Fv
	grlivKR0F+WcKFBJdflVLFM4MmOs11SK9izvtXizb2ZTpjOeubW1kMPVBPu2XzOWMm5QXMoQKny
	mZsBz8lWLY/s9iBXu5Omx9sm/V6U1kZQD2PUwym/l7AWFOEkl33Y7SfMxj3nj0o1xUFd2yWUACS
	Y/M7erUN3dkCIgQstG0oUCoJRwfoBpIk1ph3pHtBMRtgsEBPcjKYfcXWmFRQ6aRYZmDF72a7IrD
	DDOAZIYzd/NDKo1FPFYG0HyLWRLg20R0OB4ZPz+Ss4=
X-Received: by 2002:a05:622a:a591:b0:509:3cd:b22f with SMTP id d75a77b69052e-51c8b2e2428mr106477241cf.23.1783650659833;
        Thu, 09 Jul 2026 19:30:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae24d04sm6804331cf.18.2026.07.09.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: Mihai Brodschi <m.brodschi@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs3: reject an oversized resident attribute on the inline iomap path
Date: Thu,  9 Jul 2026 22:30:54 -0400
Message-ID: <20260710023055.3746252-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

attr_data_get_block_locked() maps a resident attribute as an IOMAP_INLINE
extent using the resident value length taken straight from the on-disk
attribute, without checking that it fits within the single page that backs
an inline extent.  mi_enum_attr() only bounds that length against the MFT
record size, so a corrupted volume with MFT records larger than a page can
present a resident $DATA whose length exceeds PAGE_SIZE; on a buffered
write the inline extent then fails the page-fit invariant and
iomap_write_end_inline() trips BUG_ON(!iomap_inline_data_valid()).

Impact: writing to a resident file on a mounted crafted NTFS volume whose
MFT records are larger than a page oopses the kernel at
fs/iomap/buffered-io.c:1061.

Reject such an attribute in attr_data_get_block_locked(), before the inline
buffer is allocated and the size reaches the iomap core.

Fixes: 099ef9ab9203 ("fs/ntfs3: implement iomap-based file operations")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

The oops on current mainline (the inline buffer is kmemdup()ed), reproduced
on 7.1.0-rc4 with KASAN by writing to a resident file on a crafted volume
whose resident $DATA value length exceeds PAGE_SIZE (reachable only with MFT
records >= 8 KiB):

  kernel BUG at fs/iomap/buffered-io.c:1061!
  RIP: 0010:iomap_write_end+0x48e/0x5c0
   iomap_file_buffered_write
   ntfs_file_write_iter
   vfs_write

This also matters for the queued "ntfs3: Allocate iomap inline_data using
alloc_page" change: there the same oversized data_size makes
memcpy(page_address(page), resident_data(attr_b), data_size) write past the
single alloc_page() page.  Bounding data_size here prevents both.

With this patch the offending write returns -EINVAL; normal resident and
non-resident writes are unaffected.

 fs/ntfs3/attrib.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index e61c5bf7e27e4..d41ca930daebc 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1039,6 +1039,21 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 
 	if (!attr_b->non_res) {
 		u32 data_size = le32_to_cpu(attr_b->res.data_size);
+
+		/*
+		 * A resident attribute is mapped as an IOMAP_INLINE extent,
+		 * which must fit within a single page: iomap_write_end_inline()
+		 * asserts iomap_inline_data_valid(), and the inline buffer is a
+		 * single page.  mi_enum_attr() only bounds the resident value
+		 * length against the MFT record size, so a corrupted volume with
+		 * records larger than a page can report data_size > PAGE_SIZE.
+		 * Reject it here, before it overflows the inline page or trips
+		 * the iomap BUG_ON.
+		 */
+		if (data_size > PAGE_SIZE) {
+			err = -EINVAL;
+			goto out;
+		}
 		*lcn = RESIDENT_LCN;
 		*len = data_size;
 		if (res && data_size) {
-- 
2.53.0

