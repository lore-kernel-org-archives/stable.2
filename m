Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032185;
	b=rUOlgU5rGTF4gYKgnabkNnY7NoLCFWWCkVCTadRnlDdMlWV1DXwS1v/6gsHtg2Wnzht1
	 nC8yNx2i06OQSj5zDVn5bkZjBPfz+kL4OPsTJfgCihVym82fHIQ/VTlhEN6jZAnJFcuIK
	 GKjFPwngP3ELR2AUVGjHBfhXvZJB+O5UAIhGfAMUVSSETJnBTDTo/g3da5mPsWaRxFpW1
	 wE0wy841vHBJQenQp2vR1ql99r5qwrHtggiv/k8LIr2onn353kwJTK4zJO2yFDNPYbnpA
	 4DCaA3fK6Uz2dT5wt4ZUnu1tEA/2svu8F3hA++AClf4RKAEQhyhI6eZ1hvE9Wj+IYyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
	b=Dv2K+wV/E2jyTXObs7VKATLvt6UTGjexAR/WZwvivOS7yJDuAZoX21UjSadCKDiRJevP
	 GeH//n9U6lWaZUuEtg9vl/ivBaohpNE0iIhQY4w6Ea6BA6U22PXpQ3WBg0r+QasaXgU6d
	 BxC7hzYRHJBxPhmkznpcJXNJJLmsTRom0bndHoA5kSW/XLDVQqKY+wDkBnnolqdKn+gBr
	 BAVXFCgpc96WJCjmruNAkrG/UbXvbuUPldae9vXQu1jQlhZv5b/m84UjXIMJafG2sLTj4
	 uDzQiyGqn2y7npj8EJ8cxepupHp6u+PQoSh5yEqgvGuTR4Ox0MhENSS9JwkxsfQnh7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jg1PHzYa;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01653606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 06:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01653606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jg1PHzYa
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1114960a91.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 22:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032184; x=1794636984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
        b=Jg1PHzYa3kliZFxL8EDIl7AnZD6yAFza/XkwkesjfHzw9/J7RtYqcT7RkpKZDqJiJO
         5Jn7wS7BFrvoDHdH0in+NHNwus7zA9QPU/7Wmbxll6hInRKkcrjvfyytdQlzfVq1fZwh
         xz34+A6JeIqPsTNkZFMyCsE3cME5E3MnHJRoc8YQVKfomjMW4tRcxYWcNwCDUZEEP90k
         yo8A2p0tdFyycGTYuXTLBFWFajJkRmBuUP8NILuqwpnxiAINV4ARudH6rBDMm4X3Z6FD
         jAAoL1TjMvgUoYEG9UWLPoTZzcbuzO+4ULm1DmAKJLbNP6iSH9OCLECzaQFLE3q4Ggab
         FqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032184; x=1794636984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBM2nSAybAfiialNHVzu3HSG2mME3T0XPb7p1fQfDMc=;
        b=LN+eaf78QYc5YrUJ34OjQD2Co+ycf5LQBemDhz7uOKujYQ4h56erQxO4WPes77Tr+c
         +aYauaIh5M1S521Nax99QGy+vF5USDQdQjXip/Z1H3sRPxYCQXae++mxhaayNh04TpFv
         VQmkpa2M/EpYfP1hIzgn/an4mj/A5XJo0Veid0ICijCyg+6/p0KsRklN1AyzJULtfC4x
         +Kfx5csUadNlegA7TbZMEHr20x+gW/2MfVCspCLSWAnJkVgvkDxMldMaEyHs7QTvvvpP
         ABV8EsOU8ipSI1IZ9Sz2H37zfJrT+RfphDuJgKmwi/3lPKYNhhh7J2IJSzx0bd4Dk+EX
         x5Kw==
X-Gm-Message-State: APuU4Z+Y1/xOSZNDNV4eRkuX8sZjdkf/ppdtg+re5/RrGoYP76Um/Vms
	53VTTbnbiNjQcwMNqb/UpG7Fwm2QHMydVkmKuK4zFZrmKgR1ZS62A6Rdp/2GWw==
X-Gm-Gg: AYBFou2hT8gInwXf5QBziwKGoGClhClwlmeqCwgH5HNnkyMJnhH8AJXIAbBLXAzhXqo
	iAb4AXALwApyrQQ1gyTAjj+O7k5KlyrSnWwIEffSIz9nhhvyHJgQV1w0vkdD9ysl9/g2vQBdDWq
	ajMVUdEu9calRvBq3+xQ0BkaFmZaMXOEKARNYFR0Ad6bQI8FhdL5CK025OdibjLAai5kYM1mSMQ
	zxKFda29nDTmZgfXytRaEJhNJ8wk3xmIqKKH8X9cnFBiA96t12YhuoI3C3DmHsFDt1LVh0Km+4J
	2kZYhIJOt/KPrnULBw8zufaFCmdEF4QhvrDJPp573sLUArsYcBHl7Bhw7cBHrdDocoph4Y35wEm
	D1kIp9CPjvPE/VRMldLopYdtQR+b98RfK9C2yBmKuiI7o1b6GvzziipCN7iXe0MD54ex9AzMJkM
	PB5/Y9rdDh/ABRDowJ7z1qXlZt1yoIaBTL/inemtrYLu/yZaQw8v2/KdTLu1TRUvZAvb7rXe/MU
	bTBcSuzUI7glFB4tWMaRiqBDaUCBiQj2y6nHihVLO1hBcNFKvDODkSOG1WJALOYA21wS7yGDCu7
	D2ykQUD8FVBvp6dgjv18/AqlMyfNbUE6JQmrVzkTlhFFlZ54BWET7QF21H41zpKs76x7Mtya1aH
	BL6edZ/B92Y1VSdE8VTnMYdM5V3bJ
X-Received: by 2002:a17:90b:3b8f:b0:3ab:1285:dfd6 with SMTP id 98e67ed59e1d1-3b0db6e4139mr4880614a91.38.1794032184100;
        Fri, 06 Nov 2026 22:16:24 -0800 (PST)
Received: from codespaces-2362ac.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10580ca47sm1987238a91.8.2026.11.06.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:16:23 -0800 (PST)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jsjlee1020@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] f2fs: skip further SIT updates for already invalidated blocks
Date: Sat,  7 Nov 2026 06:15:46 +0000
Message-ID: <20261107061547.29197-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When update_sit_entry_for_release() encounters a block whose bit is
already cleared in cur_valid_map, it reports the inconsistency and
corrects se->valid_blocks and del. However, it still proceeds with
the discard bitmap and checkpoint accounting updates.

This can clear the discard bit unnecessarily and incorrectly decrement
the segment and section ckpt_valid_blocks counters when the block is
not marked in ckpt_valid_map.

Continue to the next block after correcting se->valid_blocks and del,
so that an already invalidated block does not trigger further discard
bitmap or checkpoint counter updates.

Cc: stable@vger.kernel.org
Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")
Fixes: a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
V1 -> V2:
- Add Cc: stable@vger.kernel.org.
- Add a Fixes tag for the discard bitmap handling.

Fixes tags:
- 81ffbd224e5f introduced the segment checkpoint accounting regression
  by replacing the del-based adjustment with a fixed decrement.
- a66cdd985532 introduced the discard bitmap update that still runs
  when the block is already invalid.

 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 51858f64e43e..fc2f0fd8e318 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2560,7 +2560,10 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del += 1;
-		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			continue;
+		}
+
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 			/*
 			 * If checkpoints are off, we must not reuse data that
 			 * was used in the previous checkpoint. If it was used
-- 
2.53.0

