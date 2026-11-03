Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703240;
	b=fx/Lubr2bNaD/RU174UJL3uZ9r8WFM6MM1BDG+jU8pdofJJ6xtpl+ZSaRRn+us7Dq0ka
	 f32u3M/R+Kly9bDPc2+XydfQW6x/+9jcLeJ8ngX4k+XYFEXS7+qaH7fplsDX64dWyF7AO
	 rkt8JdozUUpHwtJ/WMStftTuz8s/s2w2A/JP2C97lJc+e56mncZZfQRKAuev24M3ApiOJ
	 z6hf/4F0a6bce+YouMxNIsC/AWnwF/rCAaKUi1nfdY8wcWgjpd4wpOgRxvvlSi8A754EY
	 zuZ14NyuCeRy0bo2wj3TLQoXiLEnlhbqShmZEwSPuY9Fjb63QXGGiOyzniSXhV1OH5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703240;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=wRbkREsmbd8xND+sjDx4eLFzRxEy7ZDf+k352JEwzd8=;
	b=C08wbYr9WHsRLGPqRCXL5v4Oehftms+LeHpAy0krAIn2UTYRfzJP4GqTUJSs91Z4zQvX
	 NxrPFI3Axj/vAezmN0m/Wt7MYburlJNkXDmhAyG03cJCF2sRcY5Xbn8cafYYQrEWXFEtG
	 VnG8VpB6TczteG4U5f+CpeS2FzrZasUbWkCAzNsSayeRy5ifKJE3luxJTKTePDCCCWYhX
	 c9TfwKu1vJU7cGknwIpqczKSpT3gwAkfICFAOfutuoZ4nvFSFWF6MzOzvBzoOKyVAAbIl
	 VSndjOWOuky3PnlORZbLTieRxrTGuVwv+l13OIGZJ8BMvN1zV+za5x2ckSGJeXcGJcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543D6082BDB;
	Tue,  3 Nov 2026 10:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C543D6082BDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJln23GrZz8Xrrb;
	Tue, 03 Nov 2026 18:53:58 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A3AriP5053317;
	Tue, 3 Nov 2026 18:53:44 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 18:53:46 +0800 (CST)
X-Zmail-TransId: 2afc6ae9bd3a622-aad8e
X-Mailer: Zmail v1.0
Message-ID: <20261103185346937YqEZr3t5lq7FdnTzM3-TY@zte.com.cn>
Date: Tue, 3 Nov 2026 18:53:46 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IGxpYmF0YS1zY3NpOiBhdm9pZCBSRUFEIENBUEFDSVRZIDE2IHVuZGVyZmxvdw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3AriP5053317
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Nov 2026 18:53:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE9BD46.000/4jJln23GrZz8Xrrb

ata_scsiop_read_cap() starts with

	u64 last_lba = dev->n_sectors - 1;

ata_dev_configure() sets n_sectors to zero for security locked drives, to
prevent any I/O.  The READ CAPACITY 10 branch clamps the resulting
underflow to 0xffffffff (still wrong, but bounded), while READ CAPACITY 16
has no clamp and reports 0xffffffffffffffff, i.e. a capacity of about
8 ZiB, to the SCSI layer.

Use a zero last LBA when the device has no sectors.

Fixes: 61d79a8eb362 ("libata: Report disk alignment and physical block size")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a61fb0331279..eaf86dc2cefc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2984,7 +2984,7 @@ static unsigned int ata_scsiop_read_cap(struct ata_device *dev,
 					struct scsi_cmnd *cmd, u8 *rbuf)
 {
 	u8 *scsicmd = cmd->cmnd;
-	u64 last_lba = dev->n_sectors - 1; /* LBA of the last block */
+	u64 last_lba = dev->n_sectors ? dev->n_sectors - 1 : 0; /* LBA of the last block */
 	u32 sector_size; /* physical sector size in bytes */
 	u8 log2_per_phys;
 	u16 lowest_aligned;
