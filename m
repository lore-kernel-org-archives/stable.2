Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642317;
	b=QvgIfMuGJv8dV3LQ0w6DWeFezZykouhR4gajpd5uuolcYHcdnuIoAuP0WpqTY4SZwUBy
	 gK8ySvgaf8PxGyaJbDreNy+yWthmeJwlZR4/HLqh1v+Jh0VDjT9wgs5V6Tmi+L7Z+FUKi
	 4nEQu0q0EvCmuGkKGPRG4u/lu5E1XRFYuihJmuz8UQ5o1HJsCRJ3jg3u8V7mfG0LacLFq
	 iak3TIWr2m/ngzyBAbyHwuGK+i6uj+UxQcuEmGNBbqphvDoubzTYNuLtYSFLjIvmhw6/Z
	 H5LLsHYg8zEo2fK0aMIfY2gHc8YIZ3vnkp3UFtqY8SCXBd6+0G39Rnh8sWdFimoAjrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=njXw7uBGnQm1a3Z3XCMRbG3czIZqupOT3FL6jxYSW6o=;
	b=U8lGewg1X2GrW5tLVnxsiwApG5mpNqKDZL429LMf8Yzn6uBaoFHYxAc0P4GZfaG3WeGM
	 x2Os/41I7S+/4A146Ja73qGn/Eo7Q6OwR89KBvi9pSRqoGEb3SUlezO3ZNP6SIIPvhiX/
	 x4rF4HFd9otKGB5fEMyBWo2N96Yi8ggm+mTH7ciCbloBw5F3cQn/ohi0WFtMsJVtzAP/N
	 1AVEbZTOyL5s/uJvVWmAvbsleIjY4nWLP+9kO3Nq+fjzmVK2Uzvn3W2OlVVl/oxbNsZg+
	 vGGp9SFRt/ZhDa3rNWc8BL/7YHJmrjWCvJnee8lScIKpNv6z85kPe1bJDNMFn77lxLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VAP3QEj+;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23629606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23629606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=VAP3QEj+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1795642317; x=1827178317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njXw7uBGnQm1a3Z3XCMRbG3czIZqupOT3FL6jxYSW6o=;
  b=VAP3QEj+54HIPefrmq52lstd2BWyJvKzM6kSsx9eQG2B3cwjCexwwK6m
   gdOnU1JJRdaY0RGq/HKFbRCEICokAq5qcBAwzvBRhLAshs7eXYMZGpnV0
   VoAIJxhRbp7/OU+ulLCyev5FpAHI8K+oLUqFaQKueP+8X87obYLg5EJN8
   MPtISBKNIV0+iBswDcTfp4hFxWuQvZDkjCMQjDYgrkpaX/eJDIRDsS6y8
   wndkL6Q+rXG50sqHLkZ1qV/aV4OU4pAnRCBQQFzZA/U5H5sVolVzuowSH
   22/rhUDnC4cW8cj8MANBqlxbSEISD/DzE3NywHpR2M116y7/mfx7icaX3
   A==;
X-CSE-ConnectionGUID: PdIFDzkORvykTmGeKE9CuA==
X-CSE-MsgGUID: CokavZiQS4CSoZ6T26b2hg==
X-IronPort-AV: E=Sophos;i="6.27,233,1787011200"; 
   d="scan'208";a="34975072"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:31:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:1882]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.86:2525] with esmtp (Farcaster)
 id fea4c9dc-1e20-4a57-96cf-4f49083b365f; Wed, 25 Nov 2026 21:31:56 +0000 (UTC)
X-Farcaster-Flow-ID: fea4c9dc-1e20-4a57-96cf-4f49083b365f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:31:56 +0000
Received: from dev-dsk-mkbund-2b-9ea2efba.us-west-2.amazon.com (10.2.100.138)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Wed, 25 Nov 2026 21:31:56 +0000
From: Mark Bundschuh <mkbund@amazon.com>
To: <stable@vger.kernel.org>
CC: Mark Bundschuh <mkbund@amazon.com>, Mikulas Patocka <mpatocka@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.6.y] dm: fix infinite loop in dm_blk_do_report_zones()
Date: Wed, 25 Nov 2026 21:31:41 +0000
Message-ID: <20261125213141.1359087-1-mkbund@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026112527-crate-icy-9c5c@gregkh>
References: <2026112527-crate-icy-9c5c@gregkh>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

[ Upstream commit 648320de920b30ae1730bbf0e8b86c0df0fb490a ]

If the device underlying a zoned target is removed, its capacity is set
to 0 and blkdev_report_zones() returns 0 without reporting any zones.
The mapped device keeps its old capacity, so args->zone_idx and
args->next_sector never advance and dm_blk_do_report_zones() loops
forever. On non-preemptible kernels this causes soft lockups and RCU
stalls.

The following sequence of commands triggers the hang:

modprobe scsi_debug zbc=managed dev_size_mb=1024 zone_size_mb=64
udevadm settle
echo '0 2097152 linear /dev/sda 0' | dmsetup create lin
echo 1 > /sys/block/sda/device/delete
blkzone report -o 0 -c 1 /dev/mapper/lin

Fix this by returning -EIO when a target reports no zones. The target
always maps args->next_sector, so a zero return means the underlying
device no longer covers that sector.

Fixes: d41003513e61 ("block: rework zone reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
[ Context differs due to commit: fdb9aed869f3 ]
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
---
 drivers/md/dm-zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index eb9832b22b14..c7d373afa0f4 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -42,6 +42,8 @@ static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
 					      nr_zones - args.zone_idx);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
 	} while (args.zone_idx < nr_zones &&
 		 args.next_sector < get_capacity(disk));
 

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.50.1

