Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89847125B
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723806; cv=none; b=JeeZSaLWPg54Y4CPuMCVQrX3zqpMVZdzbNLZTN6nwP74bUGn8bMmO63waJ1jEZytEtm6vcCzQ2hjPUv8Mr8b8rfJC4cIDYnj5WmM6w9vWu8e46yii51aRBpyUpkV0hfaam1YGRU7GSoZba0A8O/vgUesASrdaMUhS9WoPPyvVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723806; c=relaxed/simple;
	bh=ed9wtRmkoP7Wdhmi/WVgPoAqFaryqSGPXBlc+TkS3Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sxc7T9ivBpvMogr3cS2uzCBSxZsbazQeTlmU/DP0rHoTCd2XVSAqwsYfGiw1Tf3HeH9E0xFVK98SsdPLS/FcTzuR12/2KvwrILWwM9I33q0Ng5rPKU1Vk+ddUY0220o4u6CI4EMB0vCIUhcuRZ/c3rKCmDhYx5NqQY8VcswYSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbEAjc8P; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbEAjc8P"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836d2861a39so14116637b3.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786723800; x=1787328600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yxq818myupXhtwcrZIn4DVpAwIlvbEBii869YtzAJT8=;
        b=JbEAjc8PzCCLWVHjL+l2Ag8GVALJVKjRlUkr7At05fKWnZ3JnM9rk5cqip/vo+qWcG
         yMc2dQfgcVb3Qv7pJ9ra2VxpsYgBFEJutMGqO+qhqC0pvW1mwIJNmUrfo2qfZkyB33bk
         waU4VoB6ETRLKhRJ93/z+EvDBQmuvF7y1TIXQzB1CsPejqxVzCscgiYdJLqeVjnW5Du3
         EPZyZQKu/K1Nej1wXEDi0kBnDteNBf5/ZBPcnBWHSTLOKkRPI8htnuExEoWozmdmiO+B
         Q6aAA6KgX1FcwHjgELLxIPqTk5Alg1kuTkRjbHpehVRDLwkXt3B6NhVMQbJfN0Q1AAU+
         uMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723800; x=1787328600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yxq818myupXhtwcrZIn4DVpAwIlvbEBii869YtzAJT8=;
        b=hHMrbIWtLxTnehkZY9KP2sluqkj8s3tSYbKhS/te98QWH821D9m833I0eXK/5AC5UT
         UKpLoKpirhQCObnf6ByoGg+q7PRhfx8IkU0tGKo8EQNFU8tGB9beIGVDaEHlkIqhZCgD
         jBJmb7/q5VnR8xxiZn3bIRWDhgTakIXMchxWnEStv8egc7s773jW/Nrrei9xYH5fnEeF
         281EEMuh8GalqAj9WYhmZYyi+4iij/d8RX7GLIM8V4H36fiNdzS8cfCPGfkG8SviNOgq
         I/Uc/IyO/avVRUuar+kJTFV9UfP1eIjL2mtSvFW/ACvLYr99tTSg9wyaMvw7GG7sY6vM
         ve6A==
X-Forwarded-Encrypted: i=1; AHgh+RquCETYvVE0V4/7lVQ3qhWjGWX/5OYg2vw9rxqaf13ezhLyE7zh9DUs7Yezum0JbmufqVhO+zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1bRYUhcOSTuo4+0DQrvwmh+lfzfnUUhPppq6TZ5T4hB+xj7u
	wWQCbOwJeUHIvDWbgX4dvdqGKQtXUPcR+OOLjnzUur2DmtVgqd3lZeZh
X-Gm-Gg: AR+sD10DsdPQIMzmyMHty9AAc3+aFfzgLXtSJGAuwnp3cwqVaAItvzKi6Fz2GmdZQys
	o7yxNbpbktg4HFtwFHvstp/RC/u6m/LVAL5t+oU46odKU8CoOnCz85TNzMp9bFd3CIYzYI3C2VM
	pLlLSjKePhg2KkElp8rnH7Sb4ILAjsKfZw35lMPsHNoyJRS0Xzy6D5YDqA+qHTwck0/0rHDjLhz
	zBCp8ec9yYtk8vy24XLjcF6TqHgsrSSX3EBFjKhBBaCLu9YHE02ur8AavXSrMb6x5witku/Okg9
	WboQbqw4g/djMXPzbzxjfq/FfzrNlQjUX6z+z5VA7AnYSmI3C/fTSV4nvkpnM21A+eZH4iPXkJN
	bZTdQ3eZec0TN6CZUUFMS1hdQ2ELSX2fyfbX8MhYZ1QAvgzVPm+4LQOxL0nij/DbP5XTF7DpXBP
	dS9lYqUQMpgwzWAPCMvv/2KCTzYF4avazKoymjK3EeBZpOPIADmxtF0UdJtneV3DQh4RaxiJDsk
	gEXbpZP9gDk7uwRIA==
X-Received: by 2002:a05:690c:6310:b0:7cf:d242:d94a with SMTP id 00721157ae682-8371431484fmr27885107b3.25.1786723800495;
        Fri, 14 Aug 2026 09:10:00 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c261a59csm15358717b3.36.2026.08.14.09.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 09:10:00 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joshi.k@samsung.com,
	weizhu@fiu.edu,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH] nvme: reject zoned namespaces whose zone info query failed
Date: Fri, 14 Aug 2026 12:09:54 -0400
Message-ID: <20260814160954.2839507-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_query_zone_info() returns either a negative errno or a positive NVMe
status code, but nvme_update_ns_info_block() only tests for the negative
case:

	ret = nvme_query_zone_info(ns, lbaf, &zi);
	if (ret < 0)
		goto out;

If the Identify Namespace (I/O Command Set specific) command fails on the
device, or if the Identify Controller command issued by
nvme_set_max_append() fails, the positive status falls through and setup
continues with the zero-initialized "struct nvme_zone_info zi = {}".

nvme_update_zone_info() then configures the queue from those zeroes:

	lim->features |= BLK_FEAT_ZONED;
	lim->max_open_zones = zi->max_open_zones;
	lim->max_active_zones = zi->max_active_zones;
	lim->chunk_sectors = ns->head->zsze =
		nvme_lba_to_sect(ns->head, zi->zone_size);

so the queue ends up marked zoned with a zone size of zero.  This is
reachable by a malicious NVMe device, a buggy firmware, or an
attacker-controlled NVMe-oF target that fails this one command.

blk_validate_zoned_limits() does not look at chunk_sectors, so the limits
commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
size, but by then the limits are committed and the queue is unfrozen and
nothing rolls them back, so block devices that are already open keep
submitting I/O to a zoned queue whose zone size is zero.  disk_zone_no()
then shifts by ilog2(0):

  nvme0n1: Invalid non power of two zone size (0)
  UBSAN: shift-out-of-bounds in include/linux/blkdev.h:747:16
  shift exponent -1 is negative
   disk_zone_no include/linux/blkdev.h:747 [inline]
   bio_zone_no include/linux/blkdev.h:1052 [inline]
   bio_straddles_zones include/linux/blkdev.h:1058 [inline]
   blk_zone_wplug_handle_write block/blk-zoned.c:1423 [inline]
   blk_zone_plug_bio.cold+0x25/0x1c8 block/blk-zoned.c:1605
   blk_mq_submit_bio+0x18fb/0x2870 block/blk-mq.c:3196
   __submit_bio+0x315/0xa70 block/blk-core.c:637
   submit_bio_noacct_nocheck+0x488/0xba0 block/blk-core.c:755
   submit_bh_wbc+0x575/0x740 fs/buffer.c:2824
   __block_write_full_folio+0x728/0xdd0 fs/buffer.c:1933
   wb_workfn+0x8c9/0xd50 fs/fs-writeback.c:2403

Before commit c85c9ab926a5 ("nvme: split nvme_update_zone_info") the
caller tested "if (ret)" and bailed out on any non-zero return.  Restore
that behaviour.

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Cc: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..dd7859826d2b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2417,7 +2417,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_query_zone_info(ns, lbaf, &zi);
-		if (ret < 0)
+		if (ret)
 			goto out;
 	}
 
-- 
2.43.0

