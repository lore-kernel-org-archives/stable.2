Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78B4AD4A8
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516435; cv=none; b=He/IidZMZfKPGnwzUegoTdh5zfmIVytIcrqfBmryaAYYiHFvOI9zSyTX4UG4OjGJPYFJcRhqu5hnewzAi2X6C90SO0E0ObZamQjZIwlbLD+culmPJqix5lPpeQ75CKHpXs7DXw7q2SKOW+YZASc4Ojx5TE8gAQ4cfohtXj8sKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516435; c=relaxed/simple;
	bh=9YCR2jAyq8jwYN4sL1CNBLWNLklyjMJf+GSPFtbaEnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuE9eLatyADJFITCln+AAbhf8OuIDfUgx49B/w+Up45NPwfOGgY7GrmTduEIT+1SchDfX7WUo8wAFLQ/d70d0Zeg8CJnEMOwlU2w1sPMSp5+z/x8QsNGIDVBbXs9KSTH03UwbULA5w84pCEHEKOTngstlAv2VoTNv9dsrNypyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnMi3DtJ; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnMi3DtJ"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae740487so250110eaf.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789516431; x=1790121231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDEJrVWlib24T1D7GSE0HjYSZrsnYM8lK5GMEYYnFBc=;
        b=GnMi3DtJLlFbZSrzObalzSREnowPAJcdNyp8UAI69vJyXatuwaNjAutFeNFhqgjdXF
         b/i6VyBHkGq0p89KxMo7UXEjIfNVPUtvA7xRT30HG6LQjC05s4Q41T+ObIUyLWNjxuue
         ZrpUTN8K5ZoLfGcbo4BLLRLNq0ynBV1lhD7CtqK6G6inkyL6axBP4sqT6m0EAKSyG6z6
         1c20MA6DB+5Vx9aiP4YQfBeyB17XwIcL7+jKTIK/U+GsirefECdauEzsb+BQvwIbyXv8
         BRGKAM3mqzXKZdEnCtTkqUCw4tOkac+FC+93/TtD0He3JWOHFvjaB9ln+S6hYoc7eaDq
         tyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789516431; x=1790121231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vDEJrVWlib24T1D7GSE0HjYSZrsnYM8lK5GMEYYnFBc=;
        b=ISy2fls0MfRxnS00Zw8CK8TmOq2kyLxKm6dlPm1oKlo5PnWnI5vk2Bkj3a/muifkQl
         6fRJnD9b4Lu7jRyXiQvjBk8Rm3HNL4V59dwAkenpMAiilCzrqacjv5KUY7y48X3Yr5mv
         2//7jjM/P1n+qC2i3aDFmjKcLJEDZiHjs3+J8pOmW4tphRBx+1UerEv48xIt8sSSh9vv
         RBEaJwyq0dDgawKoCpzIyKRAIH17RWo8MdSreXzTwSEih2io/J0JNu2/m0CzwvYB4Km6
         ihXFguiX81rslWkF3HyaLT6ULgCk38bxB4oJmWU1pBdHjhkK3S0y0hTGpuO8AjEeoh6T
         1vyQ==
X-Forwarded-Encrypted: i=1; AKwUvBymku3mb8CB8uYobxprdoMi38pysqig6LZIp+AObCLLMyDjmbhAPQuEp11ge6e4MuxsfpPDQ44=@vger.kernel.org
X-Gm-Message-State: AFuF++kJzMTiohSz7NZmpYTfZmleSwuTDaOHRDfYgnKsD5Q4kpdU7fv2
	GxNrI8tk/t/jikCgDKFtod+6LNcCKU3VKFCknQymtxc5fZ/SG2kIfvd4lNGwVg==
X-Gm-Gg: AYBFou2atLsfweyS8GY7J25GuqGB9aSP1H67rwKFLiLT5WyMMR8seFeXoxvVb94TNV/
	yBH40Dvzc7bV6+03X9eyBseJtR8Utle6ddphLCv21FEBPIK6sl1ZJKcfcdDWFdSPQovryQnfMVN
	ggdL1NkKeyWOuoAFoVepraQDY7vSx7F3YKj7b+ZfkAI7m3rikT+ONewHsKBYy415UbRMtPTftPs
	HNLM2zKSzA9l9/kE09mFxSMRVpCSTdA7GcP7626ygPABKZTv3n3PLuwXRFuKCpLyNU01MSQKRef
	6g5dtJ0mfnf/btbsexCFoWkGZfGq7I5QBzyV4EWNwMHK8PNyYIdIPZlA2+GJ4/aGKRhJ5ZIgrQ0
	uY8qnn22+ZRzmqbo2xRtv89jnPlkdXg2sEJJG0sFhMlN5BX7VvQ90aIspPyCgZhmXZ8r0R4ArvU
	4Wv+B5CkyYv0yC/Q8NJugIlhh0Zjs4rnVWd28sBykPjQPzuCIhQqke2mxo6/Nve1VpMMeRYC2oR
	JQ1sqvvoFz30xMTbEXMd+n6abfz7s4t1msoJ66zaDCOeK/OlYg=
X-Received: by 2002:a05:6820:290a:b0:6b7:8415:d78c with SMTP id 006d021491bc7-6c7d32fdf98mr609849eaf.55.1789516431352;
        Tue, 15 Sep 2026 16:53:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c7a061a054sm1420639eaf.0.2026.09.15.16.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:53:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] fuse: don't drop destination page cache on a zero byte copy reply
Date: Tue, 15 Sep 2026 16:53:41 -0700
Message-ID: <20260915235341.523416-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__fuse_copy_file_range() clears the destination page cache after the
server replies:

	truncate_inode_pages_range(inode_out->i_mapping,
				   ALIGN_DOWN(pos_out, PAGE_SIZE),
				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);

A server may legitimately reply that it copied nothing, eg if the source
file turns out to be shorter than the size the kernel has cached for it.

If pos_out is 0 as well, the end of the range is ALIGN(0, PAGE_SIZE) - 1,
which is -1. lend is a uoff_t and truncate_inode_pages_range() takes -1
as its end of file sentinel, so rather than clearing nothing it drops
every folio in the destination mapping.

That is not only a cache drop. truncate_cleanup_folio() calls
folio_cancel_dirty(), and fuse_writeback_range() only wrote back
[pos_out, pos_out + len - 1], so dirty data elsewhere in the destination
file is discarded without ever reaching the server.

Skip the call when the server copied nothing, since there is nothing
stale to clear in that case.

Fixes: 9b46418c40fe ("fuse: copy_file_range should truncate cache")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bf7cb590538..2aa575a02e05 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3062,9 +3062,11 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
-	truncate_inode_pages_range(inode_out->i_mapping,
-				   ALIGN_DOWN(pos_out, PAGE_SIZE),
-				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
+	if (bytes_copied)
+		truncate_inode_pages_range(inode_out->i_mapping,
+					   ALIGN_DOWN(pos_out, PAGE_SIZE),
+					   ALIGN(pos_out + bytes_copied,
+						 PAGE_SIZE) - 1);
 
 	file_update_time(file_out);
 	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
-- 
2.52.0

