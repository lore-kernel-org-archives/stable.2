Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9634D6C2D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222766; cv=none; b=B6oy8nf4JH3YVeZeeTJQAe/zKpFEUN8lBmSiL4QF0fcidB76FqCqhF22PBZBr16s0eDC03WRdkYR8yEe1yfLGxYjpk0r9SqyohYIMq70AA06U8bEb60VlGyC4U9iRZLaDxphZCPb7nC5Pe+jAkjLyPUkXn3qdawsFLYjcE8AoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222766; c=relaxed/simple;
	bh=FqXzvLNrJ1gvEf2hEzF8NJkOCzEnZpowUiTzZXUVVfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTElbVR2RB8V1kwNlANqwpksiT8OVqy9R62Wa8QcGMs14P+yah8B9bTkGxMPhrA+R6snZ6xthewmeFyZuCrZQHT67hWLTF8JUw2u8+Qb0GDQZ8JL8ODNyQQa4aTC7zaWAxJAnh1un8d1AmBEqPR+9saPN5P+AOye6CXWEPZh4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcWYI/vy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ke9LR6lu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcWYI/vy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ke9LR6lu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791222763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBAsUVR1OmdgkzVKrFL95Hhct+vzLxfMnnB//wn7JxQ=;
	b=hcWYI/vyQY1l2fCNGX9AeATQoL83qdyaIBHWz1ybwnqcPu2DOOvZBcXx1wg1whdkdmrWIs
	d1aH0mxqJLsjdfNFJaprbkz+mOM1SKZ8AcTBR4gp4DW/Me3aPsC//wiV8E/x9Y6U7QgJoc
	5OaLd8spiqSrqOACoWyVELViT11EfyA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-GhHQmozMME2Q-a8XwnJUYg-1; Mon, 05 Oct 2026 13:52:40 -0400
X-MC-Unique: GhHQmozMME2Q-a8XwnJUYg-1
X-Mimecast-MFC-AGG-ID: GhHQmozMME2Q-a8XwnJUYg_1791222759
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ca9b53afaso519050385a.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791222759; x=1791827559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBAsUVR1OmdgkzVKrFL95Hhct+vzLxfMnnB//wn7JxQ=;
        b=ke9LR6luH2/f0zeOlshRQa+7JWggcKzeTSHpU866jBRrdaEsSAnmf582Npu2gjOu3g
         7nFo82auru0dAzMi11L0m6yact2pUXU3MHVIPZasA8sPG65lUBTBnBix0aP+sio0PO/H
         +PBZzfiNIYVCFIfYBylzTC0Q/xW/aHr+ry3Jg67pnZz/p5O+m6lmA38/najmdWxWO1cC
         viTx0EeDsEv9qPsyElgvGiBxrsIP1r0riUCAWpZySnnrjHALPsZ8DbrhuBlSLsTupGUU
         NZtbcY+8eMCGIHqIioOBB/NscCReUIQ8/G9dqvIvEZjL7by6rWlY8tnBWYVYPAUmnNqg
         SoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222759; x=1791827559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBAsUVR1OmdgkzVKrFL95Hhct+vzLxfMnnB//wn7JxQ=;
        b=13p49ZCpzvigGnM7hnzrOgTINIrChHmsNRaARYTygUek13xuQBA9laREzpsTVCqWv/
         qXoFFyFUHZrHd/8lck7FMVp+yzXFnquKosIEe5lfCC6YYZ4CnLKDjw4UZlqmfL8gT9to
         4PLl+h3LwToOh+YtkRsWt7QT5LXZYiZzJl+eB2EPwQ8UAINK0tG70KQtITSzb0cMyt4b
         sP+pOATLwT70vk5cQ1RuHw+IE/Jh5tKdytnJKW5hFlK4Az7fncXEe9G7LfDyoVJbD4lK
         M5sBTsQcCgN1ubu+nn/snz3iSnOvd2wyrbJ0M/ORm9T2rS6QGDdIODiK51fX2xKf2Nv/
         jWPA==
X-Gm-Message-State: AFuF++l5l8Y/mIr18pZb8cCMyYyXjqUrx3Gn6qsmtm+a0yPYXmDbskRH
	NseTE+m1a5bJ+3HkRphOkl0Xm+hSqcjl0FRbjbvgtFhm1sfxoYqZWJAlC6cfwQT7KwjD8p5Cjrx
	OHWDvY3+uGAAI9yVwXw5BpjE4L6xdx4bJz6xRhRIXgdFvCXS/iC7cMxqNuF+9d8UJ5vIfeoiaal
	T7JoYr46D9GfOndP4fofk4ojVFj6/+O9LUjjCNVm5/9A==
X-Gm-Gg: AYBFou3vI1UqN5eLJ2wyMkcUeKGpZuBtIDxdnE9Pz0FLqH3kjLSO8C4pLhNgsLFRfxM
	TvS/Ho4RE2XF2wOavMISzmYv8DnNKjYROApMri8x1mv00zsu8RIVDC49BAUvgNc86pCMAzRcp8I
	o/CJN3HgQjNbauch0LI9mFtO3Gixc/oQWS/cEXfhYzblSlP7E6qjsKK+8FG0gRBCKTaFDYcyHgm
	AV0q9GUFIKsZzNLyqAGcGrmaN8MCp2t7HqGwQ53wxjk/8PFi1QIcOsIRJaKBaB735uUaiM5Qg4y
	s4F2s2MkidXZDm6uIOGKNVGtHVPVysN7br11h0J5GgTHBu+YyLTp1h3BHyHFN7/ZsWU5/UeXxvx
	6V88dggtv+BidrifejkNFieyUkCHpe/ZUL6Z4A+jMJ9uzZt1dFRRnaCkHj3TCZ3Ce
X-Received: by 2002:a05:620a:648a:b0:93c:6904:9644 with SMTP id af79cd13be357-93cf18b6da7mr1903118185a.35.1791222759116;
        Mon, 05 Oct 2026 10:52:39 -0700 (PDT)
X-Received: by 2002:a05:620a:648a:b0:93c:6904:9644 with SMTP id af79cd13be357-93cf18b6da7mr1903111785a.35.1791222758301;
        Mon, 05 Oct 2026 10:52:38 -0700 (PDT)
Received: from bearskin.echidna-sunfish.ts.net (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2643acsm920037085a.32.2026.10.05.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:52:37 -0700 (PDT)
From: Frank Sorenson <sorenson@redhat.com>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.10.y] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Mon,  5 Oct 2026 12:52:31 -0500
Message-ID: <20261005175231.3953493-1-sorenson@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026100538-barber-dazzling-d7df@gregkh>
References: <2026100538-barber-dazzling-d7df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446 ]

The invalidHandle, swapfile, oplock_break_cancelled, offload,
and status_file_deleted fields are stored in the same bitfield byte
in struct cifsFileInfo, but are updated in different code paths that
may run simultaneously, and are protected by different locks.  Since
bitfield assignments generate byte-level read-modify-write operations,
a modification to one flag can overwrite a concurrent modification to
another flag.

To avoid these races, convert these flags from a bitfield to
separate bool fields.

Closes: https://lore.kernel.org/r/7689764e-c0f6-4016-9557-b54cf4a3de4e@redhat.com
Fixes: 3bc303c254335 ("cifs: convert oplock breaks to use slow_work facility (try #4)")
Fixes: 4e8aea30f7751 ("smb3: enable swap on SMB3 mounts")
Fixes: ffceb7640cbfe ("smb: client: do not defer close open handles to deleted files")
Fixes: 173217bd73365 ("smb3: retrying on failed server close")
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
(cherry picked from commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446)
[ status_file_deleted and offload not present in kernel 5.10 ]
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 fs/cifs/cifsglob.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index d0905aa0b04c..8a5cdf4ba0ae 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1322,9 +1322,9 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
-	bool invalidHandle:1;	/* file closed via session abend */
-	bool swapfile:1;
-	bool oplock_break_cancelled:1;
+	bool invalidHandle;	/* file closed via session abend */
+	bool swapfile;
+	bool oplock_break_cancelled;
 	unsigned int oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;
-- 
2.55.0

