Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AC3F0A81
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409223; cv=none; b=H2m5E47o5pBwSIWIaypoP1UEpIQJGpVn9gL9IZA7nKkqSPilMBWx0pZXv6a3xw+YOCU6BKNRkMCHgaYk942gzAXQHXsJVrlgV54AFeBu7MQBA5+BsUZgHlT3Be2sXZ48IqgidHuvdz+QKqK3YQVgcbUa0AQlH1oq2SAS4u6ZFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409223; c=relaxed/simple;
	bh=YGXWoJ4LhhhkF7EWbP81eYh61/pNV08G4d7PwdAEWO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FX2dny99RS7s/yUsOYxO5WI4MtBfvY6l4HYgaB1WXf5B1IcnW9cyi/lqnnTQyc0y08Ac/IPPzqUXi9F2b3GgRJd3iExpiIJAcJFMvxT2JXB0nHT4P8lcJ57UBD6GifruFmmmAHAUSZff88myDroA/ay23IcuF2z48h5INPFL3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbfRkvK6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbfRkvK6"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c16794450aeso275251666b.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787409218; x=1788014018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FlxrXjQiw5bnwrdA7FzNpOb5hdE68uhQMeRmlYnIxQ=;
        b=SbfRkvK6GjbkzxcKu1MzCjYv/ng3EyqKSr4Iqn9crkFP+MynNlhjpI+6Zupsp/EXIV
         Y/S81JNvSimbru4VDwRnCE8Om6WEOLV2nwaGwI7Jak3lzJuIbwbmCW+HeBHnVlnqHlH0
         NgczhhZ5Ti+YsmHze6lVxOWkO1L3qls9iXJ6jT5fyz8u5DtLrEE2F2jiCZf23ZI0lMwM
         AefZsQK8NsUZLW4jT0degFgo05zy3UW8FuYG1O47l5m9n5fadOCvY5IPUqvi8GUCOAf6
         FgL5Dykm7z6qM4Idr44JuELES+M8Pjp+T5uUWqnhKENS5WErjDTeM22vatAagbjUJBcZ
         DGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787409218; x=1788014018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/FlxrXjQiw5bnwrdA7FzNpOb5hdE68uhQMeRmlYnIxQ=;
        b=MWJW5MCfrqE8JBn+jjgJGxQ+BV4W8EWJdzzPFyf8p5xGnA/BgHSYuCTS0PdaHU893t
         oUNZXGG76YmNOk1WDB0ErZkFA6Qir5O1KY9Yg8/s1JphPRAN4q2XjDWaigRL2PNkPfXQ
         KJn9uzdn0ae8aT2JF3REehS3q7TqSLLgGg4RMGC2Udz1zDrJXncP7Pyep0jgQPIUTo+p
         oHL621FXqEfPkjRYuEclKPlII4PmJEBbmZzt6i4szE0MHrsO7Mxk7eWhKZIB50ByqmIv
         BDrNumC9F1ym7kyPq1GK/Qil+73p8Khci7b9bpzSNPfolx7Ap2NHUBMVZrLiR2dp9Ats
         zNKA==
X-Forwarded-Encrypted: i=1; AHgh+RrrF0m9oJ0RXrjyi9UJiLHBqEXamedfvGoKGDLLR9G/eHKBzDlXi1HvoQo9uxpW8Ztz1msncLE=@vger.kernel.org
X-Gm-Message-State: AFuF++kk/VQnoP2w9suw/eY0D11JS6bt823SvqD5YTAI0aljjMX1I/9C
	Ww2QVnNPHOSGS6dKdx74ZQ5wCPSCkIJvdHZu2aRRKg88U1cpFSAjoiT3
X-Gm-Gg: AR+sD13JbjxyxmlStDi4XvDB5nDCCaD7YqGPIQOOAYZfQQEVMLKQr6sVvJAWZChFWlj
	hshjX+URiu9bo3iRA75pc/NUWKumAMizU2FI6FB2OCM1cihaKpZTSRYKYq2xv/mCw8PIvTV4YOd
	dfgQ5FVciaDtGyzRRmmTcZv/UBO2U3A4E26V4cAwMBlJzIepAnEfo/TD2xda+XnC7iAriQJcA2g
	w979jRzgyKPQt666Z7pyPyqQxBgtTNRljfiVSggny3UMKH+hnfw64JUFf7FZXYXPCavsJDdTXdm
	1Oj4rzQx3af4rhw6gpe0R0QRVVAW6TdEpOgllyouVUL6R2OE3ry1+zRS28F9fjzvk6fn5pMU6T3
	DVqWoTjENBP7EYm1OaUvRpPIM3qnPbCtfDsZJhTsM0SGF8dINpncUR873hIRrPVBB0AYmlu/SWw
	izfVR/nqjf7XWsyjivqVT7wM6jfx6YIorFxxpREiFn5+7nsyNCTnj1MELeUGYmwLRg398n6AJvN
	tmNEjqVEw1vCRH59fPxo6Qqi6zBue6eTeHzYoBwEyM1MPyYa4YDrmX9ox6Rj9XYm8KhJUi8kXqt
	IrN/MRxMbaU9J0V6F58HBMrT8MhEQZjkqaNzp9LCGkWLXv35/M9gpJwJxv6JbpXrjEyf1dusTPg
	YWkw=
X-Received: by 2002:a17:907:9603:b0:c07:43ed:1b3e with SMTP id a640c23a62f3a-c2469f9a365mr1597208466b.0.1787409217798;
        Sat, 22 Aug 2026 07:33:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm326597666b.48.2026.08.22.07.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 07:33:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] squashfs: fix fragment index table sizing overflow on 32-bit
Date: Sat, 22 Aug 2026 16:33:27 +0200
Message-Id: <20260822143328.68867-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822143328.68867-1-kmehltretter@gmail.com>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SQUASHFS_FRAGMENT_BYTES() multiplies the on-disk fragment count (an
unsigned int) by sizeof(struct squashfs_fragment_entry), a size_t. On
a 32-bit kernel that product is 32-bit and can wrap.

squashfs_read_fragment_index_table() sizes the fragment index table
from it, but squashfs_frag_lookup() bounds the fragment number against
msblk->fragments, the unwrapped superblock value. The two disagree: an
image declaring 0x10000001 fragments wraps the product to 16, so a
single index entry is allocated, yet the lookup still accepts fragment
0x0fffffff:

	if (fragment >= msblk->fragments)
		return -EIO;
	block = SQUASHFS_FRAGMENT_INDEX(fragment);
	...
	start_block = le64_to_cpu(msblk->fragment_index[block]);

block is then 524287 and the read lands ~4MB past an 8-byte
allocation. On a 32-bit build KASAN catches it when the crafted image
is mounted and the file is stat'd.

Cast to u64 in the macro so the multiplication is 64-bit on all
targets. After conversion to index-table entries,
SQUASHFS_FRAGMENT_INDEX_BYTES() is at most 64 MiB for any u32 count,
so it fits both the unsigned int local and the int argument it feeds.
64-bit builds are unchanged.

Fixes: ffae2cd73a9e ("Squashfs: header files")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/squashfs/squashfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index a955d9369749f..93436c7d80c97 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -136,7 +136,7 @@ static inline int squashfs_block_size(__le32 raw)
 
 /* fragment and fragment table defines */
 #define SQUASHFS_FRAGMENT_BYTES(A)	\
-				((A) * sizeof(struct squashfs_fragment_entry))
+			((u64)(A) * sizeof(struct squashfs_fragment_entry))
 
 #define SQUASHFS_FRAGMENT_INDEX(A)	(SQUASHFS_FRAGMENT_BYTES(A) / \
 					SQUASHFS_METADATA_SIZE)
-- 
2.53.0
