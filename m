Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3323FC41
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435747; cv=none; b=I1yJK5cdLsdNqt15fgAdsBJVkTXlTFEPItTTn+WwYqk7P8l72nlIllpQohWfd5HHw54Fn2VtzhEmpEn9GcroSNU8I/JtmfORRNXF2b0QvHaTGj96PZdL4BLPJhyWifySIxnNcceNAa34FmyyErntT2yQsthOcAY8HhcoHPhvPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435747; c=relaxed/simple;
	bh=cN56vkqtUcNihjn+Hz//y7e54+XzLhZoycPV1BPVx8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Go8R8eqb8Dpv8lWrshTv/uxASVF8AMpw6fxiYlQeK1FYd89i1yT4q8TPdEx+YqLeOrMsVNyvibSwRaJZB4vxmmyQvmsvd3mhk8/foY4O/5tzn3zxC7tXDI5RL63MFZ5SwdHluf4oxIx+ktKE4LwNeE48L5hJaRll8e4Mp0aArXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBkEZ6UV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ez50fWur; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBkEZ6UV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez50fWur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787435743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNvfEtHsgFIZfKx8urPXlA3nvaULkRFJM4C3FTjbo5c=;
	b=iBkEZ6UVRt5whrqNjAvFSArJHrzDPfJUBkVlVO7y+/OnguTGkorSsdGwfJCgWvtS+GfgaT
	IC0NXrymxgoKeWHxyRu53NUH+ILB8Q//iD0h9036/AQjCywxDYWQA494un9VE8NHrTOO9T
	v87NwYBHbm7XpxfxKSjf6KqgVfZcoOw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-OXerX83ZP_OFWtlCf44peA-1; Sat, 22 Aug 2026 17:55:41 -0400
X-MC-Unique: OXerX83ZP_OFWtlCf44peA-1
X-Mimecast-MFC-AGG-ID: OXerX83ZP_OFWtlCf44peA_1787435741
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so391180585a.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787435741; x=1788040541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNvfEtHsgFIZfKx8urPXlA3nvaULkRFJM4C3FTjbo5c=;
        b=ez50fWure77IxWkITsMOQ6BNhOBZ/rtty8NLZjgh/BylLhDqPWDgorc1v8sAbizVVz
         V3/59/RddDBW4P2ow4YMC5KoMfUZVQxhJmJLsmC5snUhG+nStz0oItaLL0iqGW1uhIhw
         Kkr1ugk5F6x6qJTMGcTk+iDv16q+daVscQRShKOyCocjTZ0jg3XyRvkJSpI1rrqD3uNZ
         d/nNPffIHBQPxCAQc54Pq6dhNhAEUY304ktBrvOBoVZzWZ6QN5+hShSUOFLyc7lbOHZw
         HAuB2eChMytL5ToGO9TCIGUateMXK3LlaKpoO20UJ7x9NnrX7P3Kxa/OEWtFaIK5G3xY
         ohPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787435741; x=1788040541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNvfEtHsgFIZfKx8urPXlA3nvaULkRFJM4C3FTjbo5c=;
        b=jjUhw4ubl3yfXBrUlaM+U0od1LLy8XBdFvMU9Az8JIC8Hb+sDmeWVe7ARdZ9R2ZWF7
         U8BoQkhgSMZ13OBc6X3B7ytqal43XebqGjEH03te4V1djx0OpT2DDGxyJq2QXpyQlL3a
         GQzo18WH4HppGBflGAKsQxWhIkTqmJ3HvnN0S2sfEZ+eqiqO1wEU6zRbUZyJ9erj3+Qi
         rLSsyQZNdc+8Z62I1X3zfVL0SPJIvDLN9om/V68ippxaSvmtuflezZTICLdCEkZ4/NPX
         fPZyu/iwnxcLM5dIVYE4XULPgpnw7MKQXW4O3tTY1N2RUqwF6CReHyy2LUzPz5THnjOc
         f5/A==
X-Forwarded-Encrypted: i=1; AHgh+RqeA424LTagJqBadcoj3nKo94/Tf0LKRBtLmLnIHST9oUi5TgaDSHG8rKBPsu4RYvcp6Gt3Dcc=@vger.kernel.org
X-Gm-Message-State: AFuF++mGAmP65nywuUWusKIS6jz0cFOLtFX4K0+NJHf9arspeeLtfsFX
	JRYmyeDcwpEDynssF9SO9uW8tu6YVsweO04ucnYzIWvLo/AWFCsIeSHVLgk26lYR3oDBSmBxDtz
	i8v4eNIfzlCYSR1KqpuIQub5PBfWFJ0VyW37WYngZp9CfHd9LFeQ1ZxGUxChR/8k5vg==
X-Gm-Gg: AR+sD11avYCwYZSGg7iuZHsVk7NRAO07hsSea2jf0nQGGQE5HEpUTHwSa9NtoxtBxFq
	NVK9GIfwrlduR5kikWcgAdk0aJavL9MmyOiOO0nhI9UJYz9lj0xOwe9NlDrZev2m3RrxB981ZHL
	p5kdgOeliw6TRZb4jifH6LIObY40oSQn1vikXL7OagHhfbK3kX8qgKY9fCO8rkjpcBATBBQVA3a
	gF5RK3eB6GqEvHsDhMi5MRNFQ3UCHllERCU3+4R9S9zV+ysEGXojgqvVBoe7QZ9nMYbXvL3OEwU
	DcyA9Zl5AfqgiDlqSbphQs8NCbX5rHm6HAUlObXG2f/gZIGzYByK/LX7+MWtjeJItJ1ZNj0Wfmr
	ki+9NaJX/RY4ZgkmcIserfolYb5rvTu/Xl7DKHTAKHQan/Ud32vjZESlycIIn0eYFRw==
X-Received: by 2002:a05:620a:280c:b0:930:f129:1a45 with SMTP id af79cd13be357-9374695204bmr714076185a.30.1787435741010;
        Sat, 22 Aug 2026 14:55:41 -0700 (PDT)
X-Received: by 2002:a05:620a:280c:b0:930:f129:1a45 with SMTP id af79cd13be357-9374695204bmr714074185a.30.1787435740474;
        Sat, 22 Aug 2026 14:55:40 -0700 (PDT)
Received: from bearskin.sorenson.redhat.com.com (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749d9544dsm186786985a.27.2026.08.22.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:55:39 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: linux-cifs@vger.kernel.org
Cc: pc@manguebit.org,
	linkinjeon@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cifs: fix loff_t underflow in cifs_remap_file_range() when len == 0
Date: Sat, 22 Aug 2026 16:55:17 -0500
Message-ID: <20260822215517.2353835-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With len == 0 (clone to EOF), the effective length is computed as:

    len = src_inode->i_size - off;

If off > i_size, this is a negative loff_t, corrupting the ByteCount
in the FSCTL_DUPLICATE_EXTENTS_TO_FILE request and inverting the range
in filemap_write_and_wait_range().  The existing off >= i_size check
fires only after the ioctl has already been sent.

Snapshot i_size_read() once for both the bounds check and the length
calculation, eliminating the TOCTOU and 32-bit torn-read risk.  Reject
off > src_size with -EINVAL.  Treat off == src_size as a no-op,
consistent with __generic_remap_file_range_prep().

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/smb/client/cifsfs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e9e5ba4fa865..d8be6c707b62 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1415,8 +1415,19 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	 */
 	lock_two_nondirectories(target_inode, src_inode);
 
-	if (len == 0)
-		len = src_inode->i_size - off;
+	if (len == 0) {
+		loff_t src_size = i_size_read(src_inode);
+
+		if (off > src_size) {
+			rc = -EINVAL;
+			goto unlock;
+		}
+		len = src_size - off;
+		if (!len) {
+			rc = 0;
+			goto unlock;
+		}
+	}
 
 	cifs_dbg(FYI, "clone range\n");
 
-- 
2.55.0

