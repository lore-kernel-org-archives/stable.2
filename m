Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600225;
	b=Fj0ydJ8Y4qPKpa4bBLCX7j2MWXMpbZTLRK2tEcPidbM8qeTZey8EN6a898vbm5Wa4ktT
	 iFHCEuLIUzMWV2bUqiPx4ZJPSCYRO0yF9m3KObSr3NhyMjhV10zWpdwDdHUGnkXpnsUpQ
	 Lio0OMH8FR7eGKwULKZ7bO/phfLBGSjed3lvuSe+CCV0oG3bUKztSDhx6jKX8MeVZSW7D
	 CIONUNADJlELyBq4MSJfv1Q9khPod8c785Lcs4ZPSnPVDgoloy0xc74nQkwmzD5kHmLnx
	 m7yZA2wsnJef7Hvk4CLWCt9NTbmEe2d5XnguCfSirMqbrehzIX8uSa0QF4+MJBc1IYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JIuVYhzDr7tBsDpbhyh1CCeaiWBRpMDlHv7fDLl13QY=;
	b=Vgy48mvFclUq8WP/8V88HuK8yvu9swF2hHXhJShbdqw0z24s+XD0L3lcFlXON10hFnh7
	 An99rgjVhfHpJeRAoGvs8Ow2KodGT3WRHwplOXPQR0+l94buVvCh6idjiH674iKbnZyML
	 ILID3GJIbA+FmVTzt6C15dBcrUEgvtQak5nIimvKA09CICgoubz3egDyycmRc3pubVX18
	 QK1zL8KAUXSF2A+u4Hwj5lD+TgJ/vXcAZpjvPUV/EssqCgAJDc/cw4jfRqtI+gKlnEa9k
	 R3/G5qwskz7m0JFXsdXJ6mhjcTJoSwxsevrcipzlgENVB3NXZQFDxhDQw0JE42VCrhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mAr9hJBE;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2411606A335
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 06:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2411606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mAr9hJBE
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-35adc681e1aso5166923eec.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 22:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600224; x=1794205024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JIuVYhzDr7tBsDpbhyh1CCeaiWBRpMDlHv7fDLl13QY=;
        b=mAr9hJBEtrch/cLsG+l8iSEMx4rie4Rq4wlLYZk8IblWD+idnG+d8AlYE8h1J/sL3d
         /LjNBZa6flPW/Y6ma7ooi8LTW7ZzlIICfQYKXRnuVi7zPSQwFYRkFdwvRZIjKI9BzuGn
         Wt/shzDTFefyt/XpNgduVodd2GE4fL86Jmbsz+eOod0tKtp0YIqLY77loE/asc9gimx2
         bIqcYL3qmBQM8E+30KuNspN3diiprMKamCjuXBneBj5zDNedznko9Cbv60tQNuFAYRKH
         rXsW2ZPccAGZp6LU0u6lr7T+YMmtWyyYUsLBHF/BUUtDL2cdqONMsY9rw2F9KLfK9hr6
         SQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600224; x=1794205024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIuVYhzDr7tBsDpbhyh1CCeaiWBRpMDlHv7fDLl13QY=;
        b=hpbbRiL1ZS7RjsJ5vazd3dLnoPfJZcqcthd/x21A6Ds3Kpa7CiqXML/bnBfPYuA2DO
         awhT2beEMmL7WqruFSzyh1m1JSM7OUB65yqvGOIBlTQnZ508ECpcn3QX9oHTKncKuY+R
         lgOt4qKO9fBWbz5numaIzqz+4Qoa0mk+8K3IrH6w/W9A4GkXPV9UNAFOKnCsi0prTG8S
         7qrSN1ZAIrP6neYym/GT8HmJ3CdUxogk+ZzOLhWVDObL5QHoD3lVu+dvwp/qim+udZFP
         FGieP9W1ORIzIDKiZKy9QhkY5NuMNwWHae+KwyD1e48bZq6K5b3esY8vyk02whIXrlmZ
         kKDA==
X-Forwarded-Encrypted: i=1; AKwUvBx1koLjZOGPPy0TKJtIhuhWIoT1cCzmkQm1jxAWX/XaFcWG9T3dPaYBGSjLdYHAZehyZrMcwaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z87KdjROwWaQhI6Uf4edXgW/2/bIQDyCeC09zvBYl9zchXBAxXt
	Q++z2og1U4ResdVTig4v1Gm581c7X0iTRGfoJcSPNgBRGQxvdm4IzPvA
X-Gm-Gg: AYBFou248Kw2Mm9V/O2uUtc35sjPdORvZXWgwLNfXmkzyWroyEqDeByBgCwGT0c448J
	5+6ctXbfh+6MSYteCneQBS39PplDKQuflllIfK9hhS2XJSBFIwXsryyMjyT86Bl4ilxKr1xnvH9
	jfJyPKVwauLhHJcAstkoZLawj4UnDM1oGy/yq2hVLUD5Bz+pRiohhbAyOoabxf0APJDzqxoPRMl
	c+vn0lCMsZLvz/OKucmvw1wZ606eEWN82Xc/m0kJQDDuPVJXgufsvn7f+4ddkkflcqXezCy7QVK
	Up86uSMhxl7FIJ9njmP4+zzisD+r4Ksi47JKOgBdPI4SHm6XgGbdM9hYU9TLcNow/2N0n9CLtOp
	qZqZ5tKQMYfDXJIaHcUW/tjMed6v1MC6BSMAgaFxzQSyUHf0uSmiOw1d9l6hnbexUpgBrKG73Ai
	MMd1qNGKkPTtp3fJYSyqaGS14E93AZDBRR7XUhPeNaReBZ1/QeBZGSG3VrD86xlWuGYI7p6IOTP
	CKndBnXZ+170BE+0z/FuZE5UQeiF68ZPmSvzsbROf/0BRQsNvkxNNipmN/8cN5DdZ0vazNYejsA
	rHnH7miTywGg7MQRvzt/Fu/Ictt054qLd0Eaf+f80ri/E/Hnml6P9L7P
X-Received: by 2002:a05:7300:4353:b0:369:fc93:eda5 with SMTP id 5a478bee46e88-36a42434630mr21125404eec.39.1793600222582;
        Sun, 01 Nov 2026 22:17:02 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm39820872eec.25.2026.11.01.22.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:17:02 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] ext2: preserve completed DIO bytes when buffered fallback fails
Date: Mon,  2 Nov 2026 06:15:55 +0000
Message-ID: <20261102061555.55183-1-dennylin0707@gmail.com>
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

ext2_dio_write_iter() can complete part of a direct write before
falling back to buffered I/O for a hole inside i_size. If
generic_perform_write() then fails, its error overwrites the completed
direct-I/O byte count.

For example, on a full filesystem, an 8 KiB write to a file with an
allocated 4 KiB prefix and a 4 KiB hole overwrites the prefix but returns
ENOSPC and leaves the file position unchanged. GNU dd with oflag=direct
consequently reports zero bytes written.

Preserve a positive direct-I/O result and return the buffered error
when no bytes were direct-written. This restores the fallback policy of
generic_file_write_iter(), which ext2 used before its iomap conversion.

Fixes: fb5de4358e1a ("ext2: Move direct-io to use iomap")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/ext2/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 67fe423c3828..8ddc149d4884 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -145,7 +145,8 @@ static ssize_t ext2_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		pos = iocb->ki_pos;
 		status = generic_perform_write(iocb, from);
 		if (unlikely(status < 0)) {
-			ret = status;
+			if (!ret)
+				ret = status;
 			goto out_unlock;
 		}
 
-- 
2.43.0

