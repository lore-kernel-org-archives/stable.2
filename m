Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BF35CB91
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738172; cv=none; b=ufh+kdwLDdt2wZrFrYVMIptntBbCFYyfEz96TCh2tMg279Lr9boqUTpsnLQjHeDx/ViH5nBRypY5lsv/n0qtgKsXjvC7bMFnED/+H4ysLzK6N++dbiM/wDjIbj8avtRtapQaS8Y4Y0X6Ert7Wpc5JJ12laj1cddRK3uVoZ9JX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738172; c=relaxed/simple;
	bh=GwlG6UlV1cLzB6P0R4GVEk+F3ect+UN/UsEzBHwB1AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn98YvCLM96H71U/QoDZYDUs29dTubo6Ry75BOx393YtZ6SAKQsYADLAGHq3xzWNmSjxs2YWuXo+eKXLhlkiirw2dY4BogHttaQY5bUEQiM76kD6OKX+1JBRmbyoH2ZfeF9xD81+6AlFX5ciVkwrF1u7jUal9y00uKvZ35RuXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/xGGOxe; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xGGOxe"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso1741947a91.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738169; x=1791342969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fARVtGGuJPknRqNtIyIcoRVsEn2tgxMNe9tXK/dWuo=;
        b=Q/xGGOxebYAaZsHkPYxCys9oi3O24yHTgyhGAIGlI/QCohJPMXVfZC0vcM1Pq3Z5MR
         fJryvP9++EAZ1QTG+I/RzI1G3Cx2IK2/KYXZMRvrqGqGtpOvn7lGvJ5KhCeExz5x3Mq/
         QWDoU1MDiL8WrJDxIjb1sxgiN99L5Q7zJdxXGMWo7H+ga6AIWbz0Tl2iJCbOV7Zs3JXr
         b2AUmVM+X9vhccGRMUUqhDe+YYOEAB3cTQu2Qjxdd+VLVDQs1mHtoN3ozNXAWxDXCL17
         mTX1SYryQUY130Fn7HUhsdJOSDwYC0vlZEzhrWj6MM8WVw5Iqi8Ep3rzSq/lad4G5ZLe
         hiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738169; x=1791342969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fARVtGGuJPknRqNtIyIcoRVsEn2tgxMNe9tXK/dWuo=;
        b=aUJtMdw5GAed5vyfhKhaNAbt3UIKQCOwy+MYSNuhHgH4fCyMordU8PBhqSvQco0B4a
         CDbSoWldGt+m549o0HFcIDXl0Q8JHbbt159DS5/mOmDlYPOkpGyr2cc4kvXnnrVxmief
         Us3VfGob2m71vIrxLwvEg37gfc4ZNw/gAwFz2Ncjun2G8RQAGo2nzHJVAChuM+vhQ7r/
         UKAArT2eRyfDLpmWIFwlo2B8ZDyOSCUZvOGVVAztsv7OX9cBJydcoyIot3lAAtCLmgch
         y4plok25jipi4QgmCDXi//SkNj7hm8I69z+pXdMHqGofSsfs0/oEHMS7kEELi0E3EjVg
         8AaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXqzxUByWDSU+on3c4zf5IoujfuZNNvUVGg8pBC00BcDPWhd0JA2ywbIHxEZilLoiqg/C2lVI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNXAKZVt34F2bgBR/I/WJBH5Ujn2y3X/wM0gnXfvD7Id/5i3yX
	yX22Ad3acorlhntVT0y4HhreLbXJ5lgPYo1kOuxevJtJmh8RpATR2PSi
X-Gm-Gg: AYBFou2v/rQQe1+P90toCaQ01MT48J2GEsvdluNr2NdYLh+knaPGJLb01k7oy95EUzF
	RKDhnV3Okb99LdRbWeB4XXxEPLxRt+UI/y/NXBc5ekHQ89NKMPTsw0NLu4dHjRlj84faaj5kO1S
	dpETy7TZ/k5j28AxYaVdPe15kGPhyULy4GaSVH381hlrXTRzBgG0GdAYkT0HgGNMmCG0MW71QF3
	Q0gJH4D8BJ/WEChgUlGJHaizroDOU42qAghucfWbTlCInNd0sfABkFmFADcsoDKXxU0mWeNo5pK
	if7Fis6U2N2RlGgUtsVzWJDx+eFMIImeWuW07PSF5OQcF5RtNKGFCVtqIIILeFEyBdQybAPJg7W
	gFph7B7aw52uIzC8kONoya0uQeB94T0zuu4pRJZ1QyW30gSYBDGr/W3ksdYW186WTBRODhOIO/U
	Kqut0mamrSdMK2LjNBmYOmKyPqvVqCuDzxH/SzELEGNV07/yGz0isdp6BMfr2zVThonzwZG1aGR
	+W/iraObASpBxmsEZU3YKYVu7OAiIpUQJ+J39ugXRY4xPP9tv9mMkqH1KF1KFk6DSojwHsq15aH
	cQ/fCgTFPQ==
X-Received: by 2002:a17:90b:39cd:b0:3a4:aae6:f4ac with SMTP id 98e67ed59e1d1-3a4d18e5da8mr47944a91.48.1790738169404;
        Tue, 29 Sep 2026 20:16:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 5/6] qnx6: abort mount on superblock magic mismatch when silent is set in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 03:16:03 +0000
Message-ID: <20260930031604.70544-6-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), if sb1->sb_magic does not match QNX6_SUPER_MAGIC,
the goto out error path was placed inside the if (!silent) block. If silent
mount is requested (silent != 0), execution fell through to crc32_be() on
invalid superblock data.

Move goto out outside the if (!silent) block so qnx6_mmi_fill_super()
always aborts mount when superblock magic does not match.

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer mounting an image with invalid
sb_magic=0xdeadbeef and MS_SILENT: on the unfixed kernel, mount succeeded
(rc=0); whereas with this fix applied, qnx6_mmi_fill_super() rejects the
corrupted superblock magic cleanly (rc=-1 errno=22 EINVAL).

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.

 fs/qnx6/super_mmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 797d8c238bbb..5f62df30467b 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -51,10 +51,9 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 	sb1 = (struct qnx6_mmi_super_block *)bh1->b_data;
 	sbi = QNX6_SB(s);
 	if (fs32_to_cpu(sbi, sb1->sb_magic) != QNX6_SUPER_MAGIC) {
-		if (!silent) {
+		if (!silent)
 			pr_err("wrong signature (magic) in superblock #1.\n");
-			goto out;
-		}
+		goto out;
 	}
 
 	/* checksum check - start at byte 8 and end at byte 512 */
-- 
2.55.0.1082.g2b9226bbc0-goog
