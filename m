Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8593314C4
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213433; cv=none; b=BQobMl8H8r3dh0hcZ74TwzrMmQEyTxq3oDBq7/QyeeHcICm7D8e3ki4NJArdCqsxRnbOoTR7kP1sr+Gi2mEb16EZVxx9QarfrLELPGGJLTd/ajKd9eRIwj2QXl83oWABFV3kdL8tg5Y4cTlxpdHRXptJHLctcEUqCEvTaMzS/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213433; c=relaxed/simple;
	bh=1ojnM+ca62Hur14sQ1BvBHTUsOVDrBtkpIrpG/aMOlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqE/O49HLmlkKvbkxMkbldybRfGWbiT3MwolyXlwgtzVeaTQN9kKacQz0Bg0y7VAc01tSZk3quMZbx/EJYQBULOwf/HNXVMOCFeq8AQ1HGeb0rhX2ixMhx0GobmU9N83hb5aCditn7cGRqsDz0V6o0DbdyBXI7HnYfAb6JbH+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DhBcxowd; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DhBcxowd"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915767ea2d0so28856985a.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213431; x=1781818231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OgrHRlb31PNlK7ylFz1YKYLL0ZIzxKfy2sHe06P0fhM=;
        b=DhBcxowdTWEniaxZakVmdeNtYqZju6VUe9PKccDhwbenFs2NjSQH/ph1liNyNzFWe6
         xLyQv0c1t7SdYQ8QB4Va61gE1TcJzIg5JCc9CEosHZCPwfRevnfOYpotSl+f45i2l1QN
         6SKRzebn+zV92HeloeWnp2Xv+uiei6iaCS0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213431; x=1781818231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgrHRlb31PNlK7ylFz1YKYLL0ZIzxKfy2sHe06P0fhM=;
        b=HYQEUmrAy0x6PhM30Ttipt85fO1YaLBw/Z4EszGyxa8gTw63btqp5qvLqK34d7263H
         K5T3zsqXuywRHu3gKGjZcPaWDw6eRre0gIWNHQgx7GLeiYh4TonDbJRLbP/YNWGTdUTF
         s6rAPLcowzY5/2/Ekf6eFRcUn3GXr/xUBxY1Om5Uc1U6FKOGAUE7hHpi5WjL6fMP7Sqy
         Bw4UERe1aVlaCKkBEFUFGAyRPcCv4U/viAutu3J2ATiIuBxpFeanRSX0gbSXJ5Vw7VTf
         AdHgdVqfriiJZzIW1bz608VS9xD+2wKw5KHxaK+PWc1OXZfNyEoOq55y6/j7TqKW0VT0
         YodQ==
X-Forwarded-Encrypted: i=1; AFNElJ+w14L+iSPOwb4lX64XKbYyJzL8J2JZ08/hAHMgJxwXUo+iLqKe3hazCGLw6blanQ82b5jbIBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEgs/CXemKTlge6UesX6I1taMyDwWJjW6kNaJo9vyZ+bH720XL
	7BIf1/EBX6A8+7Rdw1X4J1i7yicmAVWFOFnBzx80MwVHHVX7Ee8Faz44lIFrgAWLEeQ=
X-Gm-Gg: Acq92OHprojFcCWhYDVs6HwsIDsieiqIOK7lovvegoQI9Y+AwT82Jx4hK15ebiaD4RL
	PNr7uZ1wiSjKVKiy1eTSTCwlJghzZXtWFB/BWg5MjQpevI+s9QpUlO0YnJTTRg3yKU0x0Bq1KR2
	zvfTKrUhfAVyeTnCZ4kKvzAZ2Dun1r9HSHvxz4WcExWItuL6HbYC0a3619hNH0PwbeiUjBAHCpk
	omVHnj1pQ+Svbdoc95wyqr/Llw6B5YNl5OTR5NaI7ydmcvQP3HCot8MchxsDVsWuhkI7N4uvV20
	bUGkHecWjgWiYi88GHqSQFgArsFtWPLPp/enn6ZNVKX6aoJHufWVC8Y645DEzeiKHPMr/FG38SS
	uoZdf+emBPCP59W8Nthb6o3re4sG4MzbErj9K1xN/YUxIEMB0Xd5ycjIPdvaFm9xzKH/R59iXgV
	IhTkEAukiva1haNSO8NtaoeuGINMYsM+JV0DB6xRHPZQhOjHE4gAybtng2VLbHaeVDCYcb/LflG
	bFZ+ieHS6hjn6A4zpZgO+lUO2QjJ4u0kJI=
X-Received: by 2002:a05:620a:2704:b0:914:7e9a:2716 with SMTP id af79cd13be357-9160ae0ac85mr738496085a.38.1781213430744;
        Thu, 11 Jun 2026 14:30:30 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f06835sm29843685a.14.2026.06.11.14.30.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:30:30 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: jfs-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] jfs: reject malformed xattr entries in ea_get
Date: Thu, 11 Jun 2026 14:30:26 -0700
Message-ID: <20260611213026.12684-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

JFS checks that an extended attribute list's top-level size field
matches the inode EA descriptor before returning the list to callers.
That is not enough to prove that every entry in the list is contained
within that size.

__jfs_setxattr() walks existing entries and trusts EA_SIZE(ea). A
crafted filesystem can store an inline EA list whose aggregate size is
self-consistent, but whose first entry advertises a value length that
extends past END_EALIST(). Replacing that attribute then subtracts the
oversized old entry from xattr_size and appends the replacement at an
out-of-bounds address.

Validate each EA entry in ea_get() before any get, list, or set path can
consume it. Reject entries whose header is truncated, whose encoded
length crosses the end of the list, or whose encoded name lacks the
required trailing NUL byte.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/jfs/xattr.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 11d7f74d207b..a7432cfabea2 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -118,6 +118,33 @@ static inline int copy_name(char *buffer, struct jfs_ea *ea)
 /* Forward references */
 static void ea_release(struct inode *inode, struct ea_buffer *ea_buf);
 
+static bool ea_entries_valid(struct jfs_ea_list *ealist, int size)
+{
+	char *p = (char *)FIRST_EA(ealist);
+	char *end = (char *)ealist + size;
+
+	if (size < sizeof(*ealist))
+		return false;
+
+	while (p < end) {
+		struct jfs_ea *ea = (struct jfs_ea *)p;
+		int ea_size;
+
+		if (p + sizeof(*ea) > end)
+			return false;
+
+		ea_size = EA_SIZE(ea);
+		if (p + ea_size > end)
+			return false;
+		if (ea->name[ea->namelen] != '\0')
+			return false;
+
+		p += ea_size;
+	}
+
+	return p == end;
+}
+
 /*
  * NAME: ea_write_inline
  *
@@ -574,6 +601,15 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 		goto clean_up;
 	}
 
+	if (!ea_entries_valid(ea_buf->xattr, ea_size)) {
+		pr_err("%s: invalid extended attribute entry\n", __func__);
+		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
+			       ea_buf->xattr, ea_size, 1);
+		ea_release(inode, ea_buf);
+		rc = -EIO;
+		goto clean_up;
+	}
+
 	return ea_size;
 
       clean_up:
-- 
2.54.0

