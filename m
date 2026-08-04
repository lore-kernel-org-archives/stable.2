Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC223D7F4;
	Tue,  4 Aug 2026 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810942; cv=none; b=fYnStYS4WxChJFMvMXfsudH6ETyja/7yUNxzAYFHnwrkonIo9XmKQKj5XxeumUNK7qE6FU3Qql7bMjnCQfMSgHYAqVwWwj+rX7TBkGf+VEdeEAPFEuwIq/IsnI/Dg75dtqAFYJc+86et10wvk5o2e0UELS3wZBWTcHxc2e2w+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810942; c=relaxed/simple;
	bh=+AUUM2CWf4bZ2TzGdu2/PRLqjjjioY2Cxl0PuJ3O1Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIhYng2a1s1FpsneoAHYUw/awbrKf2a0wfJlGYDbqiQ2mjw31sCtlZ0qNlHr4WSNXTEx8gFg43llnsWBytKaCgTnR39Zw7XrvleX46LA9J2AWvwINxK3FhiD6+BJ7RWEsL5+COJp3I9fczodiCJg5G1NhgwAt5yXX8mVguotnSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DVaupEJs; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DVaupEJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785810895;
	bh=41ybH304Ss0xjqoeVXnypj4vQr/vpDo3e+WOlxxag+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DVaupEJsL5sgchWPVWjq3RR+oz17AOLluPD0m1AF/ZKOUxWUvSSAoPfr2V5UZRyul
	 gRJ4iN6aIW2FWls2k18H9ZBNlmMe3/8G4mQ0ztgddvPJJ/nVJW7tgiVfkqoO45OvVB
	 fxZoK8T6fIF+A3+++mWOMpbpem4WJ4SvP6Eu5U4k=
X-QQ-mid: esmtpsz16t1785810878te39423aa
X-QQ-Originating-IP: NylD66GE/BR+UmkQQcEiCIehO6p+Pu+b+Ijm65kBfY8=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Aug 2026 10:34:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5437765750704406172
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: dlemoal@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] zloop: truncate finished zones to zone capacity
Date: Tue,  4 Aug 2026 10:34:03 +0800
Message-ID: <B39E5FD81D1A07F4+20260804023403.939767-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <78d0627b-e711-4ce2-84ac-6e501898407c@kernel.org>
References: <78d0627b-e711-4ce2-84ac-6e501898407c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSkpWZrWmABAtR1+stc4QQ3uJnmuQK60AgLzhYwvjQjJHZwlZR3hh9m+
	p7WSVsU4nx45BtTh9319/BtrzaFZR0k90S/gckBqXsbJEuUg0qGXcIkr8PEo0ZDbTBk4QKw
	oRQvIA3mKLh0ixLdYppFdKqaRLhXj4Nrd7zcJO9pYIxwNQSrwPlEYB9x2SBWRI+1stscTOO
	7HsRf7VNWnUyCGtGfbmlAmJ4L7ElbAXgq7qx0+NJ56oCpQ0MEOrtjPg5ki5mKH7lVnTPcir
	RFqclfQfh0k6eUM7OlgJ1UPrvvUBctSIyb7naCX/YBcnUoRBk3MYnDTnu8WpMkmXOC45i/x
	+r91CadqjcZrczs0Smn1PeZgza9j7vYI3YmGIo2JhZTNGcaRILZIkBbQPe2+/ep3Q+UiHYn
	GpsJ/CPN6zlaQeAv5C2zGEWaspEg4NZfJvqoRk3PKFpcszXi6jM3v3k3FyGE2lk5Gd1pBbO
	QDEdYAXgy0RxiIaGb6rRXeJhGGlsnNdzvfJqi8dSI+GYKu71JldfGCl73doUlRaubgxxhOA
	g/UpwNw2/uLw1LyRBCXbHBiHywsrABSFebDRALKq9blDe+LmwD0GAocDJ3KYP1+4pFS8TDO
	6wJuGdxVke+p38dFmTH6xuVqKpsyFGp1kQT4gwgPxjUxvks0Fe/GehMCUpiYDljXWDvNXTi
	/jk1L826g7ga9gSyzrdAVAK2wdjIApUbHW3kDc/PJy2CEULvfxBK4PYSD414jdi3e7NHv01
	AAYnwNnUXJ8EgJQtfSeyTIaQYOGqtQOMbDoAVVgXuHKZBlr6se9foQp4Jfc+ZUQgd9yFBMk
	4Z4wRp0pbn+FOMmub9qRkWHPzldfjBysoCVs0MaMi1zLaucgcVBut6vpmt8sZJqgHhhki97
	k/el9VFXdg2l92RX0x8UYvYelKyy5wvjd8vLAz1oF6NhQZ+q4+WFAJCKMxCMgkjCrhfr2B6
	36qent5+eVzo2pmJFSHdnkGb69cpeCklYYzYJgWwM1IKjNtunEwMYiH/eFWsZ2o9aopJwoQ
	XoOITI4hUWy2f3UQCUpa6JGgtErURPVp1DrEsoZphcAhDPfZHX
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

The size of a sequential zone backing file records the amount of data
written and is used to restore the zone state. A backing file whose size
is equal to the zone capacity is restored as a full zone, while a file
larger than the zone capacity is rejected as invalid.

However, zloop_finish_zone() currently truncates the backing file to the
zone size. For devices with a reduced zone capacity, finishing a zone
therefore creates a backing file larger than the zone capacity. After the
device is removed and later re-added, that zone file is rejected instead
of being restored as a full zone.

Truncate finished sequential zones to the zone capacity, matching the
persistent representation accepted by zloop_update_seq_zone() for a full
zone.

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Fix zloop_finish_zone() instead of accepting oversized backing files in
  zloop_update_seq_zone(), as suggested by Damien.
- Update documentation to describe the corrected backing file size.

 Documentation/admin-guide/blockdev/zoned_loop.rst | 9 ++++-----
 drivers/block/zloop.c                             | 3 ++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zoned_loop.rst b/Documentation/admin-guide/blockdev/zoned_loop.rst
index f4f1f3121bf9..95974425ca05 100644
--- a/Documentation/admin-guide/blockdev/zoned_loop.rst
+++ b/Documentation/admin-guide/blockdev/zoned_loop.rst
@@ -30,11 +30,10 @@ indicates the position of the write pointer of the zone.

 When resetting a sequential zone, its backing file size is truncated to zero.
 Conversely, for a zone finish operation, the backing file is truncated to the
-zone size. With this, the maximum capacity of a zloop zoned block device created
-can be larger configured to be larger than the storage space available on the
-backing file system. Of course, for such configuration, writing more data than
-the storage space available on the backing file system will result in write
-errors.
+zone capacity. With this, a zloop zoned block device can be configured with a
+larger capacity than the storage space available on the backing file system. Of
+course, for such configuration, writing more data than the storage space
+available on the backing file system will result in write errors.

 The zoned loop block device driver implements a complete zone transition state
 machine. That is, zones can be empty, implicitly opened, explicitly opened,
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 55eeb6aac0ea..1333fae05ac5 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -478,7 +478,8 @@ static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 	    zone->cond == BLK_ZONE_COND_FULL)
 		goto unlock;

-	if (vfs_truncate(&zone->file->f_path, zlo->zone_size << SECTOR_SHIFT)) {
+	if (vfs_truncate(&zone->file->f_path,
+			 zlo->zone_capacity << SECTOR_SHIFT)) {
 		set_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
 		ret = -EIO;
 		goto unlock;
--
2.50.1
