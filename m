Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB5319601
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212879; cv=none; b=FxzFs5UlChOFHQwHOkYQSC5roZA2nd3mJ3v5pj9sZHBBU1lMI3F793SAf6PdLR/t4eEvxAxLWfvuCZ6K3h/aF7SRgrirxuM6YOWQhwGgvT00awEkfjxnW0DKs/ZV33PNQ9gklbEv99DDAU6PVOr1ubTTo/1P+yQMkTOMB0cP1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212879; c=relaxed/simple;
	bh=gz8XXCvKDIUvwALZy3EPayeAQ0OgphiwA++tk+FDTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTXXKAI3pKRkxcwEktb371FGEcNSDTN8a1nHLtCOHFzBkTPenSn+6jWEplLFC4TnjQhqrVrI1guZFDZsRg9xAh2828ikMx9dGE3LbnHZsmXNc51UfMNbfedIf7LfC9pyCVvO7KPsZORWJ0qHDFF1xp5/W+jZt48xYMHlpBBLo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=L+MxZmCY; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="L+MxZmCY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5176465a4a4so2648541cf.2
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781212876; x=1781817676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9gu0vVO+upgROS7/Iq8V7N+x8+Xf5/itiHQvLUydmI=;
        b=L+MxZmCY/6A2WvmS0Msem7/23zhTU5D6xyYFWirum4xSS+ciNFkioAm6ySqBOKvYel
         clZXy3OpxBkxh8KR32I2MS1ngm7mbZFU6vaLn2z94hvU9KSk5vArrqoIZb519kufcykK
         u0znP7JSOusSw7OEdbWlR6r0Qrl2T3CWwU38c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212876; x=1781817676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9gu0vVO+upgROS7/Iq8V7N+x8+Xf5/itiHQvLUydmI=;
        b=tD8PJlCbTCp1Uwdr/RmsKJ3tD1QE85LcAkeEoxEF+GupjMsOY2NO9MPnqR5aAlH7hN
         FmmEpXBpPNYcsYAT5//na40Y72nSeIhP9Jiq2LllgrLDokUE+gm8ThPAmepe2sw1l/gt
         bK73YL3eOOhs0HzTEnzxjnM4NIBMbb1gBHBreMfo8qIr9YsXjSLrrJeQ3naRvbuRDJ9B
         63phB6IRumm2YQn83k4LCGQH8IBScydeqijvsWRBWuOE/43wbElQUcDwSSYeItNzKKqX
         kC+J/MHnYXFB5ufZPmx+56iv/v42R6aYd0c54KJDTf1mB4zLnujhs6Zf0+zvxLjyNrnW
         Kgig==
X-Forwarded-Encrypted: i=1; AFNElJ9va7fk3r2AbWV1d26MG1nHfJxU4/HTn6b/r89SSQWBz9/Kzdzka9iecZpIk8A2v7dgHldXuBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8VfwV76OfKVLsbLA7zl5CIzeK91d/sZkS2af4tQKWJq+gTVYT
	/F6JcuuwmkpLDFMUdVTC3LuiaMMbq3pjKthyccWqZSJ0JWRNz0owZi016QYRyRFRqP0=
X-Gm-Gg: Acq92OE+UpwVyVJLbtp/VZTU91uaN8PXZvMs3uqNOzZ1FOa1SY8EWA0wvoySZkphf49
	5Lb3tSt28W4xhgJkVi7QVjtrHnOgrjKJ8BuYOflUNz/mfPMMt1Ou1A0XW3iDcZoS5KJzoBmdjOb
	W98UCbV5c9puohSChmneZxsl6PCHpHP6MIusjGF/DcAjibkWnWeHrnS8YBj8WBwOzm6P942PkOp
	Dr8mCQQBB2hrUGxCPV23tDHnlRtQNn2ZjzUT+EbKnW9d90qFd8wB+8n6GWc1gqVMJlEpnWGI92I
	heeT9yU/U34jR34Jvgt/56ZqoBuxQPMZnfyOQK3Qv/p+TtI7VjKwoZxM81Ya4RCpRkVriEO1zFf
	vyr6c7mMYyzyjpvis1Yc99yADin8XDgVRwfcYXPGvD9rwudfR9iyz7XJ8HDTz7XDnWbN0gjKt1f
	2md5KdeeQY8VrCGVe6/NAukcOBC930jquj4HPVX+N37bGBnVOVUwh4gLkRjLtzncjNcQ8BK7v4a
	oXUpxiF+Gb+OYYhKncEhCf1JRToA2L/SwY=
X-Received: by 2002:a05:622a:4a0a:b0:50d:6b06:a453 with SMTP id d75a77b69052e-517ede809c0mr72010571cf.18.1781212875850;
        Thu, 11 Jun 2026 14:21:15 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30105fd75sm4844076d6.2.2026.06.11.14.21.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:21:15 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] affs: validate blocks before freeing them
Date: Thu, 11 Jun 2026 14:21:10 -0700
Message-ID: <20260611212110.4042-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

affs_free_block() accepts block numbers from on-disk file block tables
when truncating or unlinking files. The function currently rejects only
block numbers greater than s_partition_size before subtracting
s_reserved and using the result to index the in-memory bitmap descriptor
array.

That check still accepts reserved blocks and the one-past-end block at
s_partition_size. A crafted image can therefore make the subtraction
underflow or make the computed bitmap index equal to s_bmap_count,
leading to an out-of-bounds access on s_bitmap before the bitmap block is
read and updated.

Use the existing AFFS block validity helper so freeing uses the same
range as block reads and writes: s_reserved <= block < s_partition_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/affs/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -46,7 +46,7 @@ affs_free_block(struct super_block *sb, u32 block)
 
 	pr_debug("%s(%u)\n", __func__, block);
 
-	if (block > sbi->s_partition_size)
+	if (!affs_validblock(sb, block))
 		goto err_range;
 
 	blk     = block - sbi->s_reserved;
-- 
2.50.0

