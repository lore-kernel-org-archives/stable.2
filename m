Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972952;
	b=LpKrzhBxrqm23Rpu6h2TvyfX/fHib8xrFoefZakszmCEiwkVUgA+1v2YbWRru96QP6yk
	 m74vmcSwiWqA7AodLy1Rh7E4hshlfJ99EWM6ivfPoG1ZClklGe2RQV1i1r9su6OziMpVB
	 nsTdzYU6P8LdMzA4U0f+W1/mIcWuciVXUwOXmHL5r7v7V9rT8VAgdPZxs9sWJYV/18iyb
	 9+VNWnmbOVNXjv+i/UUJ1kkKWn/25CyCbZxoUJSYCyi5GukPpVUgfsKXIHbjEvoeK5XxD
	 ZJOefBPOXdH4YrPIZ6vSeVOUKbqqqajpToJH1TCQlW7CPC76BnhOYVopVuS1tP/toLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=goEwqDn2eYKToeRxOVfZCjIr5NYHVGNIUeiTdWCM6aE=;
	b=tghNx+WNHlS/dLbCqb7Nb9QDiSxXbgN1LiLQpAnFfho6F62SNF7XAYNavUZnOqcOsY7x
	 Aqw4PkuE0CPKVF6Pi0iau2Qc4lltEYHZFsdn4Hu10Nskt6rvFzusJvnXuRl/d/1fE9peF
	 Ncn2Cjh18TYmA3QSEjoN/a6hFCOPY0ByNRi2D1zepJTctUm7jJdpjaD/OEg2hu1qi2URQ
	 7x7rUQh0/DM/Cwfrrj1k1/DtJT/kRcTS1sLEYSBdJLGBsz0mYHghbYMp2AANQ5L5fIYl/
	 XzbIPn7FCQZ/JI3i79fcn1R/qRRF571A9A3tn7EQMdtjC2IyYLTrXiF1QTxHcEnP1FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u4usKOQy;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550AC606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u4usKOQy
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a06e79e152so297595b3a.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793972951; x=1794577751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=goEwqDn2eYKToeRxOVfZCjIr5NYHVGNIUeiTdWCM6aE=;
        b=u4usKOQyo7y7sS8gJ0W9+TeF0+TN9wBJcfhPuH8r9v8O2beV55nNWMNOlm+gILVkQV
         DbaogKM0QgECLtjX9Zwq5QiQJfIgoO61eMFLY1Z52RQ/mYAL1y1yXw66rBfGolCgPF5Z
         D6IwpFzY/CLLmGzkmxeSEdKt5iNqVN/8yVoqclcjgD78AyVE2BG3JHcAdC/FX6R9Alus
         93tKujieJ4P9LRMYYAfsBOIYlMTmxQkZHJrGCSEIQlr3Rj+8jUNdxHOXi7i8LJdVLDHr
         FIEqpgqcPE5T9DCpEuSdhZNvk+54+Ai0gIbkeBZvi84blCn9bMQMnPQYn0Q67OO6zJvC
         B92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972951; x=1794577751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=goEwqDn2eYKToeRxOVfZCjIr5NYHVGNIUeiTdWCM6aE=;
        b=Q3fec6kBVSUrhi/8BIg58WlSW0HWUYL8gRZEElaj9IJ5Lf4fy/heCp96zRVQa0xLT0
         UvMhAaN47N7QnD9q060MJfrYL8j3BQXOPEjJdCRT6Ed+iEXrbgWaTITg3JuBSFJD6MFt
         ywyKqLrji/oH5lMMNSCVko3N94JYYKZeHug0Sz2nwrJynInhWxJLwQvgkWRic/EvBziz
         GSoBMUlEiJvIVlGn2K6arol7w16MAZvX9Fyi4mnHHoNeUMQdeOJBrYLQj5A2vnduQzUB
         7A/3MNKamBX8Um45WDJ1LfQ8g/PmaazBFn2DQcWM/7L97jZeINqMPFbbaKN6Aw0BOwGw
         iJRw==
X-Forwarded-Encrypted: i=1; AKwUvBwf7SPsg+ex+vLyWqYRPjGdO5UenlJE/DaauGemgFIF0T52w+1M85/s6Mm9/gamH3OrZs1Tego=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gJvO5OpqNCbzo08KKlxJVMZS1GJmFAt+1Z2wYcqXyNWRvN7ev
	WBlJIaz4inrpYpMUvzGN+nsl+j9EIadr7pOlVEcqIz8jedtlEjL7OFW3
X-Gm-Gg: AYBFou3+m1m8abhOCRHVy/Q3U4FqDcbU+fIuE7DmnBh48WGOvGkff9Pg8dvgXofBu0m
	nVuBxbNRQiCRf/uCyQJMf+ylceWFFaX5kK+yHiSWkue6lX5KRrnylnWtxjNLMlWuhp9IGsvW+rx
	9xL3f9fNk5RlhreNc3itKmFebC5olKUZQsJNsNylMB/+itS06i8j2cUmqxQa1ltA1ufKLXK62RJ
	wURjjjdBgv6xEx41Hf5AekItgnKQBtelsFUQRuZrpZaowb0IuzCZQuQaWjRc6DBqVW+oN52EL/N
	clt2kL/xEU5oFpPNMtylLIXFAUL+JS/sH9c1OHnjW9yJe5zzvlPBcuJ5wsau/nsymvS0iF+vnUq
	SNAUjcFGjOeNs03Ew2CFjeyrgcePJL6VeaaRkMv6MCojVSdLI95RoK4aMXj5H5q6w6prMSS0x6o
	kcDOa39P20Z/rXQpwHWN6URVR931OMTGFL1Uhg+GSUm//fIclN59JFx911Y/OLy8aoAPzoDIJaF
	TvmWQKN1uymv1MYzVkW0Nk2b6RbqwVZNpzbGjvAeGq9BJUWDMBLurQrx1vM/U/X42aQETi8rWRT
	eznnnIDcPFNAobEIqJea17E8RMJThROEzrdeZCvzWXVjZQ==
X-Received: by 2002:a05:6a00:3ccf:b0:898:efb4:ec4 with SMTP id d2e1a72fcca58-8b37c826278mr2349025b3a.55.1793972951123;
        Fri, 06 Nov 2026 05:49:11 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35a0c4431sm603114b3a.42.2026.11.06.05.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:49:10 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: don't write a compressed frame after a short copy
Date: Fri,  6 Nov 2026 21:49:05 +0800
Message-ID: <20261106134906.3139994-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

ntfs_compress_write() skips ni_read_frame() when the write covers the
whole frame, or runs from the start of the frame to past i_size. If
the copy from user space then comes up short, the rest of the frame
is whatever the folios held; ni_write_frame() compresses it to disk
and the folios are marked uptodate.

The copy can come up short after fault_in_iov_iter_readable() has
succeeded if the source buffer is unmapped in between. On a volume
with 4K clusters, writing 64K at offset 0 of a compressed file while
another thread unmaps and remaps the last page of the buffer replaces
the last 4096 bytes of the frame with zeros. The write returns
-EFAULT.

Don't write the frame in that case; fail with -EFAULT as if nothing
had been copied.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in QEMU on v7.4-rc1 with KASAN, page cache dropped before each
write:

  before: 3 of 755 writes left zeros at bytes 61440-65535
  after:  0 of 821 writes changed the file on failure

 fs/ntfs3/file.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1624f9b014e0..b1b925f95b8d 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1099,7 +1099,8 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 
 	/* Copy user data [pos : pos + count). */
 	while (count) {
-		size_t copied, bytes;
+		size_t copied, bytes, want;
+		bool full_frame = false;
 
 		off = pos & (frame_size - 1);
 		bytes = frame_size - off;
@@ -1135,10 +1136,13 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 					}
 					goto out;
 				}
+			} else {
+				full_frame = true;
 			}
 		}
 
 		WARN_ON(!bytes);
+		want = bytes;
 		copied = 0;
 		ip = off >> PAGE_SHIFT;
 		off = offset_in_page(pos);
@@ -1165,6 +1169,23 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 			}
 		}
 
+		/*
+		 * A fully overwritten frame was not read in, so after a short
+		 * copy the rest of it holds whatever the folios contained.
+		 * Don't write that out.
+		 */
+		if (full_frame && copied < want) {
+			iov_iter_revert(from, copied);
+			for (ip = 0; ip < pages_per_frame; ip++) {
+				folio = page_folio(pages[ip]);
+				folio_clear_uptodate(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+			}
+			err = -EFAULT;
+			goto out;
+		}
+
 		ni_lock(ni);
 		err = ni_write_frame(ni, pages, pages_per_frame);
 		ni_unlock(ni);

base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
-- 
2.43.0

