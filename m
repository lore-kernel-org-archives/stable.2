Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956482;
	b=T4ogw0DslUrOfCxY9CiDV14WRlaP3EKRMcp4GVbwMl9VtOyg7Ur/sCqqgqSuim9IaTrp
	 TGVhktwFPvO/uJp3K10/OiYxgwxEV03sPWInQBJgDI3ZWMgHxcibPBx+WM4cthTkDkz3Z
	 KxBKlCca+KZp7/ggqFAXCtg1NfYeRdAKAw2qRyCKUXYGGxf7qEA27UL6a1HZ7Wx1T1KIn
	 luIYXMMdxypHvaKbyNnLDAf2cw1MWhM99hl9Uu9zkERUw+CPpVNmoqmrkyjbKWLijbrje
	 V7gTWMwCZY2GxTJ8y5JLFC1id3rcR4jHvTHtPBrpLqTDLiQkANAh0CfJIp2ofpDgeqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
	b=cwyiiHW4uHaOJ/D3ATgQkjWwTzr7y3UsyMsc12O8ztx5qVQU8ON98kgirh2SPFBMeevs
	 uihcWtn08TdKZY70TmooqMOnAXMdCZrCqqMH4XQFyzRb+6oHCKs1hiBLqKL+CEEaSNl3+
	 6mw3T1YB+MipN904aWwhwhgmc7zdkk192cc1W3q0fShVQsebNHg839UFt7dPqmX0lpqVW
	 qyLf1DrbmJm4MiJRyJ+IMfydBBSQHjy+JxKwyj5zCZM5w0iQLBTB9FPlEzdXjwNwkfZM1
	 w8qd0fQPqM1VTjf7hj57sSyMpJ1XKXvZBbxJdeCDiJyea4VPLu9txwxOptTOxTEybwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1vVYBAu;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3990606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3990606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1vVYBAu
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a8cc11ac42so419531c88.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956481; x=1794561281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=O1vVYBAuspiUR1oomZmXY7dNsJ7oNWqcp+Lup9ffYYr5jDbW7HIniF9XbY/ets3sgp
         nZbXrrhsH7lecYgvrl5HG3xX+0KIuw5/R0tN8+LjuV4HnORN458aCRch/xQx9q1umg/s
         vsIKr6YrT8nVKv8E2ITY4upXOncrt6fvVvnMtdsUojkDw/yFTejiL/prlbMXemrBoUW/
         D5ArnQZ90Zxzr/1snmTVUOefMyhxOf6Im3/XgOaXE3M2vQNlIccXrdqjpp9sEZNba6u8
         lwbDDbKhNAW2e5fPw4WKS/3hgr72Dp6tluEyk9gz0cUKOKLSas6WmYWqoJBGlxndcQ63
         Pg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956481; x=1794561281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7NAa1AOfWrbfnp/EeNFL0KXkV/5wtZ7cjfajD4eOnk=;
        b=lPUXx0QUMsMbQnnAodyqb8iNEq+F16MBjQQ8F4hFkF5eVOXPr017Oo/N8iDQXNnJxN
         G+VCLMo5YXRm3x4HCHVorXe7Xt8bgGhEYLE3/TOjwDMEQNZRzI6sbHFawhnE14gghXCq
         9tGazYS0N+dMumMZDeqMsuJZ3awNAiTXpDTa+sRmfg5HVoe34AuaTtYeVnVNjkvHmaRK
         uS+US64O0RLZ+xqcunWXv9QCTnya7KjGpfAkfi1qCUMT1dOHIgCh1l22d0JqAlv8H5B5
         9AjNTeFyl0e13vT+9xrtCwcMSYV2our/iVe8pYi9UVGiNR9E27LvTGamYrtjXkMFpG+r
         65Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxgZbTE+dAEqcT4QMm+DStKD/b8lTO9mSeaySP6GOSWJMQ+M9jNcjxl+WeRmNMtnvzt6Ey1uSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uTdPriyLv1eMs9kSskEcrAZkBnYMSef1ytLKH67S4TiSmPvxn
	3wLh6dtGpyXkdmnfofaUH++Qh2t6ENZ+FML6Er7YKcHAXlIlNrizQTyD
X-Gm-Gg: AYBFou3DHz4epGR/7MuKzO+y1ztmgMx9Geg4tdO9bOIt3ZqY/GkqEI9jK7oglV/50MI
	59rBm8aiGKcbbiN/IWNg4cZT+3vnz++6U+ZsSOYvb/nlYmTtB5pgo+60wEqLvLySOwZYwK2FDsy
	V26brSHEhitCooGg69Vdj4OlhNILpQ4ecCKZj1KDGZpid6DDTMGjmqhqmcecmU4igkAzXxByzDz
	cNz2tCNzEQFM87VWOB/lkb0miZc7AyNgy+v6LZTJb8/xitevoD/itWBxkMFv/Vi3SxdDrfk4lOd
	d0J7r1Ww0iHhZIc8odumaR+yV8RmJT8c0LZOvvo/ByiYKwQekPs1JHr+IVbo8wp5MtIDdgiF0Je
	GUU8L5wU91G1T0sySzCRJ0hEvAEqf7yUvAO1LEsUPVs7Cv5vvgHj2CPsIq1CeydaUqb3lxrn+T2
	K0Q6UfvvoYr2jFQyA3z/1pbsLzxAbZxmgq8GVlNHFW8vF8KVfGmgJS5FtIeWfL+p5CikMHuD2bw
	/fTHoVUoem/SaOH52o2BzYw9Otv/Mwc/ssoVB7mJNLxAVRd/5epdaUWNfIzeYD8vxz1U9l/hfRQ
	7hTorwuQbiNrOxsddQygvv7ec8zQ1GpOVbDAX0yHwW5KLCqhDcm3OJXAKZ3BcRqzPA==
X-Received: by 2002:a05:7022:2097:b0:1b2:4c54:d976 with SMTP id a92af1059eb24-1b25d34277amr1679882c88.31.1793956480611;
        Fri, 06 Nov 2026 01:14:40 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4200968c88.7.2026.11.06.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:14:40 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ntfs: do not read an index block outside $INDEX_ALLOCATION
Date: Fri,  6 Nov 2026 14:44:18 +0530
Message-ID: <20261106091420.2461683-2-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106091420.2461683-1-wahidzk0091@gmail.com>
References: <20261106091420.2461683-1-wahidzk0091@gmail.com>
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

A directory whose $INDEX_ROOT has a child node but whose
$INDEX_ALLOCATION is missing or damaged gets an empty index inode from
ntfs_read_locked_index_inode(): size 0 and not non-resident.
ntfs_lookup_inode_by_name() still follows the child node and reads a
folio from that inode while it holds the mft record lock of the
directory.

Since the resident iomap read started to take base_ni->mrec_lock, that
read waits for a lock the caller already holds:

  INFO: task init:1 is blocked on a mutex likely owned by task init:1.
   __mutex_lock
   __ntfs_read_iomap_begin
   ntfs_read_iomap_next
   iomap_read_folio
   ntfs_read_folio
   ntfs_lookup_inode_by_name
   ntfs_lookup

The task never returns, and neither does anything else that needs the
directory's mft record.

It takes one corrupted byte on an image from mkntfs: change the first
byte of the type of the $INDEX_ALLOCATION attribute header of a
directory with index blocks from 0xa0 to 0x00. The first lookup in that
directory hangs.

Check that the index inode is non-resident and that the vcn lies inside
it before every index block read, and fail with -EIO otherwise. This
also rejects a negative vcn, which was only checked on later descents.

Fixes: d9e00c457d4a ("ntfs: serialize resident iomap reads with mrec_lock")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index fce10baa2..9fb5bb3d3 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -308,6 +308,20 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
 
 	ia_mapping = ia_vi->i_mapping;
 descend_into_child_node:
+	/*
+	 * The child node has to be inside $INDEX_ALLOCATION. A directory that
+	 * lacks the attribute gets an empty index inode that is not
+	 * non-resident, and reading a folio from it locks the mft record that
+	 * is already locked here.
+	 */
+	if (!NInoNonResident(NTFS_I(ia_vi)) || vcn < 0 ||
+	    (u64)vcn >= (u64)i_size_read(ia_vi) >> dir_ni->itype.index.vcn_size_bits) {
+		ntfs_error(sb,
+			"Child node vcn %lld is outside $INDEX_ALLOCATION in directory inode 0x%llx.",
+			vcn, dir_ni->mft_no);
+		err = -EIO;
+		goto err_out;
+	}
 	/*
 	 * Convert vcn to index into the index allocation attribute in units
 	 * of PAGE_SIZE and map the page cache page, reading it from
-- 
2.53.0

