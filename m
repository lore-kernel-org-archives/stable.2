Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362264F4024
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625905; cv=none; b=E23ik5T066AiT1stFh84+zBusuWiGHIpGJ8b1OtOFxnsUSS/xi9++99dUaJxGUHqsuqDlTRBB/WhjU3qFdcMUCMbOZ0HZkajz+MEGz0p+mJhkIWZzxT6L9UwNvscTC0VwjjA30/sPDMqQh3ob6zll0liigkLKa7unUIRNkLPhmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625905; c=relaxed/simple;
	bh=fDBiAhy/gjUqsADUcZNU/vSANuxG2/pdruvBG3o2m54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS9O9syu8ct2RUwgC0RUC4SavSoy4GjUAU0K57lR7XhE1fCV//HYdsEZOv4GpaCndIK7i2FQwLaTxqWxAQnjjwuaRiyP3bK1SgExhBL3lNfTRtNUU6ZgnPcyOdbmyWd+ayacxZDdFuWSAu3vF3F5uMybwBed53qBiXNO5SjEx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=sLxg1RKh; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="sLxg1RKh"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso3560613eec.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1790625902; x=1791230702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G65G9x7X+KDIM+1/pLIufiX3V7hRvBMRWxOStVH3Yl4=;
        b=sLxg1RKh7y0/3bvgS9FK7y1Hq6ujpntFgMILOHUmQ0KDmysqr28TugjmP8FLt0MMSd
         F25VQz42TB203BdrstNX+oOngDNskxepReCU09uy6fNPclZZQ5t0qUe6ryraLm6nCMLf
         ArLMD1aq3bPJP5p3FmPtSNiGGYb93FEBiQ6Pv+uTZd1DyNsFQ5Nzl3Ahv7TxZjI5zQa6
         h9F071E4lcmiC6fK38ZWSaWaoa6PmFLZiY+/a9LpgrKDxt467bB1Ql8vb581BELKY8Dd
         Ek0MyDjxO7uS9uyMmgQxuowMVx8OBJ0ghXxk5zKAjMBwBwJjg0nKaa89frFrJoa9YER9
         E1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625902; x=1791230702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G65G9x7X+KDIM+1/pLIufiX3V7hRvBMRWxOStVH3Yl4=;
        b=EbD/DJvnecdbTTry0o+V17WqlT1SY5CDTVlZDaruGziz4mDJOOqboaExVq/+jmE09A
         xrRJYWkTh+HAKMyPAlke+l3LPMUcSAs1sofd262l8Yn0yxi6yRYDD3GXdQ7rMw3SsrgY
         XTzCxxVoFRKB2K9zrHZkg14+TbpORa6evWyFf0ND5+W5G4iXa9zn9/exb3NFT8AwbJCF
         10le2iFE3bO9eEGRsGErNxnpeUiigaLVyW0fBG2ubjkpKoLBB51niwg2gAhaakGhEBQN
         yLn9UyYRYZ4Suec6dG3PE2N3w24dsz3G9mMJfrT2/9yKLnZANITB/52G7lBkJ2e4g/A+
         qhYQ==
X-Forwarded-Encrypted: i=1; AKwUvByd1Yy/Jbms43hNeTNdZi7vv4fIQv0HJxV3UhH8lwZu3FMz2hjLjVo2NI+2DmMdEyLZi/JgJSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6eT8g8fjuLleVlO9cjWM+VOteJBW8EwEETf1ai5ax75RXYzyk
	w5ImaL7ou7Rgtn/HV73jToIS9McGwB+K91nLl1Ucx6Krhrq6btAxP8Q7R0J412NXS0RQdNLuyrz
	7af/Tx2mH
X-Gm-Gg: AYBFou1Z0ffeDsbBzCE+OyTN5zHS/YHfaSjuHtTx3bL8p9gxxNgN56OTOS4Kqg1EBPE
	7f1sRHaa+FNpV+A0I5KAp8o3mHQ1imlvQxyO7DXQSlejPXQmq7ho9ZIypDaF33V1r4o5HK+jpCy
	/29Ex9Mo+lXUdDccpaqqFRyrIPg65SvtEijgRbnPJ1VcHSSq3v7HTtYH52PuCDXxG9F0EMFkI4p
	upRDXfFIgjQucYVcNiwe2lDnoQZvctTF5neidXgLn1Eo8x2aCgItAE8TOb/IB93eF5Hryze267H
	AnSIycQKW541Hzgsut3skMZH6pKKk62ug2GGpRzkS8zArc2583VtkF7KwEZ4BSmW9JyMUZoOGwW
	AepDsuae5G/9Wln7PeJCENrsjEh9rceyXlliJ/qnWDcCzPp4dW9IJszD5T6j/NlYAAIISJO6T+R
	NPu6nHlXAHd3AaurGRz9zYFd3zRPi9S+OakdvVc1yxIq3At/FyjTC90RIfKxOBvQmsD98HPvE9X
	AgMPDFt/zFU4P/jmR8amb+nRw0jv//Rpg==
X-Received: by 2002:a05:693c:8812:10b0:33c:6e0:3cd7 with SMTP id 5a478bee46e88-34755659554mr4642693eec.1.1790625901912;
        Mon, 28 Sep 2026 13:05:01 -0700 (PDT)
Received: from gio.scai.dhcp.asu.edu (209-147-138-22.nat.asu.edu. [209.147.138.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3475546c982sm7704302eec.5.2026.09.28.13.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:05:01 -0700 (PDT)
From: Giorgi Kobakhia <gkobakhi@asu.edu>
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Giorgi Kobakhia <gkobakhi@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] udf: fix return value for non-recorded-allocated extents in udf_map_block()
Date: Mon, 28 Sep 2026 13:04:45 -0700
Message-ID: <20260928200445.18722-1-gkobakhi@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the if (!(map->iflags & UDF_MAP_CREATE)) check the ret is set to
inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset, &etype),
which returns 1 on success, -errno on error and 0 on EOF. ret is set
back to 0 only if the etype of the extent is EXT_RECORDED_ALLOCATED.
In other cases the ret is still equal to 1, which is not a valid return
value for udf_map_block() and is later accessed in page_get_link().

 Oops: general protection fault
 KASAN: maybe wild-memory-access
 RIP: 0010:page_get_link (fs/namei.c:6503)
 Call Trace:
  vfs_readlink (fs/namei.c:6419)
  do_readlinkat (fs/stat.c:583)
  __x64_sys_readlink (fs/stat.c:605 fs/stat.c:602 fs/stat.c:602)

Move the reset to 0 line outside the if, so udf_map_block() returns either
0 or -errno, even if the extent type is not EXT_RECORDED_ALLOCATED.

Fixes: c226964ec786 ("udf: refactor inode_bmap() to handle error")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Tested-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Giorgi Kobakhia <gkobakhi@asu.edu>
---
 fs/udf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index e45e546a739a..2f04c4f0e1b8 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -372,8 +372,8 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
 							offset);
 			map->oflags |= UDF_BLK_MAPPED;
-			ret = 0;
 		}
+		ret = 0;
 out_read:
 		up_read(&iinfo->i_data_sem);
 		brelse(epos.bh);
-- 
2.43.0

