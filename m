Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021283AE195
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745116; cv=none; b=azy0Hob+AKVCS8/0DjbwYNpy8WPslXbXFhfkir7bsgDaWMNRn7g+mio23Zmj54zPUjMgZov/2z4Il4BSXd4A8W9dWUNJQqPz1Wv/8XGh2/rz0+MWW8yjGdCccCkBSrq+iXP7/cwvZ6NMSslPUoPqgU105R4KEWtjiM5L8e6WG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745116; c=relaxed/simple;
	bh=O67pmowHWgU9F4aYcvvzY0blvwu6WfZnDRzj7fLaGd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKbS0WodP9Juet1xW/XmmyuYCSrYc8XDjCClopjNgne0DlXYU0l7Pd5sCtZRA5zJhOH5bhpJzouDU2ZiYFXj342LVQtDq6/NS+Daweib1WfrfAGcOZyYs3fWHCIt3sbdwQANSlNlvJNuVJcqgn8vNfiYcqSi+xMFGgbZR4ax//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt/JkCXe; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt/JkCXe"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f186025973so14044416d6.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745114; x=1787349914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+byDgTzEgx4Gr3ZSkskCbtI+EfBHPCCCfhKahAfUKes=;
        b=dt/JkCXeb4jMZ7ptoYn6JAe7wFpCpPmbR7hf9Q4CpOr94tcSererFirBGqS2Yqf6Ku
         4EBcGR3B5mJMaV69RX+Y6mS+zdjHah/HWlXnu/FXjMnqgs5HAVLVVnW2PZp8Z3/ClJG3
         4aYdgewtBZqEITYQNIHeiG5GjA+VOXFNKRj/tnJdBFLD7bZe8Mnk6Rt3hsxPFPUDEu2h
         3BSo7GMV8nhuADwYaFHWHSObKXofwXN2Tt+fzWfHKZN+ZBj4WWakedO5giXmxaRXo/vZ
         OV7fbRLK9IxvVPvQAJNpBncAEK1TXzMsj/aCVMz7a2iwUInbiJvE+2oIv6mrYH9CbQWV
         4V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745114; x=1787349914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+byDgTzEgx4Gr3ZSkskCbtI+EfBHPCCCfhKahAfUKes=;
        b=gMlt/B+4lPObqg5ACKx3N52mO4FwcUU3FeldO2ZvjhFTMatXKVVMBNTkTcShH15doY
         wfO5OUN79sA2Ec4Prff6JByCKjo0yzuJePNOygSX05hxDGzzlg19UgWfVsAPHpsT+1nB
         C+EzS/gxYRrjO63TWvOhPQbXpBR1nBPHg+IkcChddNSY6yn00vkMB5XmfB6rRG+A1EQW
         amku0+zxUcB7P9xKVYgvY2eD7pa/1e2Fu0b35EdDuWmwL3EsZ5NedBpmLyPLm7zb3Nxq
         TivkkQ3EWNPtM65sCtfTluNc11vbtVO3wHjt9DuY0d8vn82Dj6W6hJdo3IidJjHhVS7v
         wn4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq1/krPAnCg2ngDOur/2BfjbmWDnfOFpUO9GZKvmCbawVrQwiXsGl1oewMkdIiPhnaeIlVsGsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NwznC6FPTw1cvYuxxrKvA4U+h68VBwD/I7OddJd0eFpBFfNC
	eRb2oNR3KDzv2GSiUoJGAmkZ9/a46gQOSwn5qPZghl9tfA/vHD1CF6uU2ADy6vIB
X-Gm-Gg: AR+sD11ASV1Cd+6v+hgkhZnxpTahWDJ0QJ2dhogkikca1zCdjZ/VQuuuy9bpP2ajFE8
	SCO2HOpROpLhGfboLozYqNc0Yj3UCu9L0muqEeqpBW8jqbzLtk0SiCoYRePbSiQP2Sjt4hG6VA1
	nBm3W025BcFp7KLsn7ldnBoScqwn5fVU6HAbiFGauJZ4+1GE+n5z4mQAX8R9kQpLZ1DcFRf/p56
	QNrnmK/9ckJyVUEQ25fYTqfpGDrvYSS4ziwA0djHWPXTzwN99z+wOT4fY8/oXjDULRmeKBa7dJL
	LNz+eFbx/vlUKdf9udP1GiMDxA2B1Oo8BdSk0kVihjpUga4W3UtNagEpV8kVyri/DsI5MCQkLFJ
	zVSAhTbKAyD9D19M57ZI+HLruGhY0ZNcWVjLQBAB9yi9pJxFDhRasUV2GJ99Tzjfdfl7gFJ3mCV
	qDkqzwGR8TjvfhQNIpTJ8K+vD4m00S179slTkkwclTxkxaRbTH9vlh9QWkJ1su96n5eg0QEeM1y
	jseEtSEs0XEAunKBw==
X-Received: by 2002:a05:6214:428a:b0:908:951f:415 with SMTP id 6a1803df08f44-90a91d350efmr118520916d6.13.1786745113943;
        Fri, 14 Aug 2026 15:05:13 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9350678esm26867806d6.26.2026.08.14.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:05:13 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: clear ia_ranges on sysfs registration failure
Date: Fri, 14 Aug 2026 18:04:48 -0400
Message-ID: <20260814220448.4085032-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

disk_register_independent_access_ranges() clears disk->ia_ranges when
creating the top-level kobject fails. However, if adding one of the range
kobjects fails, the cleanup drops the final reference to iars and frees it
while disk->ia_ranges still points at it.

A concurrent disk revalidation can wait for q->sysfs_lock and then call
disk_unregister_independent_access_ranges(), which dereferences the stale
pointer after registration releases the mutex.

Clear disk->ia_ranges before dropping the kobject references on the child
registration error path, matching the top-level error handling.

Fixes: a2247f19ee1c ("block: Add independent access ranges support")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 block/blk-ia-ranges.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 7be8b58893c9..2430e475a8e7 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -135,6 +135,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk)
 					   &blk_ia_range_ktype, &iars->kobj,
 					   "%d", i);
 		if (ret) {
+			disk->ia_ranges = NULL;
 			while (--i >= 0)
 				kobject_del(&iars->ia_range[i].kobj);
 			kobject_del(&iars->kobj);
-- 
2.43.0

