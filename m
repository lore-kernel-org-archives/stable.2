Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012066.outbound.protection.outlook.com [52.101.126.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E7325494
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799529; cv=fail; b=ZYdKi96CHWzcnZmBY6jqsu4Km7rRpEuPf3Z0ivTOj7uVrgbHscAEaRBUSlKmB3p/WLgBGVAp6sDgP6T8tO+zoLhNUhT03qt1ZJqFKsljiT33tN1Uvg5sa35zk+EbEHScGMJm1r0H/Bi7CoIE2rLdQjw91Xa12ZC/yYWV5W5DYVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799529; c=relaxed/simple;
	bh=6vSP4j2/7XXAHBnjTdUZCsTqw4HdvTuJiDubTmRaerI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ar6UGsPZ+0t9m5veztNGgPN9amTr6OAhVJctsC2REXx+oQy8W7DGbbx++COi4m4XrsygEXSGREKUUvKu23AEOFsCDvaitemGF8hnOq37uLD9UEAfUFJi0tPGdiB+vyq0E1vuMsIZOUpQ2bPHOtcpIcUp0KayY/VSdxlwY9pgzEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PywKSV4l; arc=fail smtp.client-ip=52.101.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PywKSV4l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLMjVDpN49CfbGx28H7zrHjY4dkuIylAPvUTAhcYWlsy/HgVon5jCN+QapTeFYL5jF8xjSugM30nRUxZh8p5LnWFV/T74OVFs15Q/0TqKL4rme1o7faI22Jg8JbxLWtgfhw5CYL3o6oK8ZcM4Ubltq/l+y5LuF4S3jDMtIZIRVqnG2J2Wyp+JW80rbXVD+eMn1ZoOhTglH7XVKeKZvq7YIqq6j/26vB6p1rOaYBjY2Mr/lwpna4qOHilZNAgy47zcmHNaMqHOAN4VVB7LsnlKoZgqiwPWB7bKiAnlxOgJW/U+XhK45680q7N3nqm+Jj5OWMUZP8yw7stX+Pfc/BhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk5qIFAZYmSHERLxuaohF69WwMsPNCmD941XKcB8DAI=;
 b=tWj8I1oHxZC6k22t2oXbmeHs7rZ9C50hcJY7FBFY/T3IxVhbL4Id8v7kPmaYK/QxcDMmrwJYejq8efGZnPmsMQuvcLoXTJdj+jC/ofxyztgDHKkgLNlUl9GJ7pWYEDFTEKSDUs6LIw3U4niJWpDMTYfPkm8A3sfZSE9lIbpALgd/8xz5NCZ4nyjmRijN1deKqcIYTZt7SsO6PbETgphrkuYnGBmwMiTzFJKmyocP4H6SY9vNiw/g7AFuXdF2P3Kp+9F1YFD6TU7i9Ld1ERYFYgcJaBvYzWfH+eW8BQgpJWXuMI9BUw1Vurpy6VvwZYFKzia+RGF5luQZzgUN3cGA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk5qIFAZYmSHERLxuaohF69WwMsPNCmD941XKcB8DAI=;
 b=PywKSV4lUa7ILdpQkQgF8ddSPsWG+7QL2DYGG9MyouSvgfFyuL2BYsD6eOe5SoMOEY+2rQuJl3CkquSwwK56szBEVXSQfCh7v33MKNX5dLMPP7QSXbS3rcMhuOY2KE2KcQPjouCQu0YrFUByvKImj3AotceAqHGVtYpUK4eGaPBvpUzv8cFmyDlqmdLqBgaXxhcmi5PSnHbkYmh2HjU/4nSgEa4eW2WaPv5M592EPwOJ6cq/j1VDK70nSL68YwIgA/WZdFqdPkRfIddpcCPTjNGJt0lAuHYmlqN418z6se8m7Pl2NGJDS5ML2V2UiAGly0XNqNMGKP+gx4WOGAF/4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6805.apcprd06.prod.outlook.com (2603:1096:405:1e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:05:13 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::8d51:58c7:42f3:ecc]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::8d51:58c7:42f3:ecc%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 10:05:13 +0000
From: Lianqin Hu <11127579@vivo.com>
To: hulianqin@vivo.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 1/2] scsi: sd: mark disk dead on surprise host removal to avoid I/O hang
Date: Mon, 12 Oct 2026 18:05:04 +0800
Message-ID: <20261012100504.3368010-1-11127579@vivo.com>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To TYUPR06MB6217.apcprd06.prod.outlook.com
 (2603:1096:400:358::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR06MB6217:EE_|TYZPR06MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 604e2705-6004-4279-e19e-08df28484ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|52116014|376014|366016|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|11063799006|38350700014|5023799004|6133799003|18002099003|56012099006|81742002;
X-Microsoft-Antispam-Message-Info:
	67jSgsVjxyvT/UgbrfGKJWbC19nUa0fRXm6Kqi9HhUqbmRJ3gJ9Bqgk4WHyEyZLayclgPJZTmXTFEHBfOk2cTYh/fE0lvjuajrIR75w5Sz+1uPQ9yua90tCj45k0vKA6FMgXtIFzh9FKd4dK2Ery8PCM8zUYHlRWZNSKxyc+2UEmu0jfyH2aAwZj5wBClqdHe2EMBL6XMUrgSRvf63x9FJjwwF7qXwzTIW86wMGmZjpLzk4qKBhbRmiT/JOVBMmtDdmYExuUNjuZqluzLXryc5Rg8pOSrPIWOllUQ1VA8Xza9X+UtuSAvwKzQ4ZJ0+D6vMjL310FzerB55uK9zkhmpTza9wSH2x5G+aYn2MsFle+WBBoHzXEtyDzwFrql9ggjZOIbY9ISI+YUu6rSxy7t+XK5oeyl7M/Ef+UXIvmcpq+hvKjc/Z6O9My+sXyP8dHF9jIgfk1z/cSRyGfuVSxgeb7OVf2snOgoNOcZbv9LVKsQCl6xDWnP131sE4YHnpFbbD7Bb9qiimd+wxRq/Kmc0QWldkEXQaIGENgDZCP6D2ZpK52BnoacksvAKnxAQKCtWnM20Oodpy5fpVEYTi4LoqabqOErwhF15H0tVKRChtW7+RlS1CYEsh5WpZPe7byKT/T2uYmzF6bhtK7QCoEMztlBkdpoxBetf1huNnY/RvG9Pv0IDz6bF47xtLOAlxvw9bcjPJRg6c1gtHjzHHgCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(52116014)(376014)(366016)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(11063799006)(38350700014)(5023799004)(6133799003)(18002099003)(56012099006)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1khlmfDX3Y8+U06v6a6eOK/XvYwSaOm/0yHH87NpgBE9MvD+AvfgJX+Q0ChV?=
 =?us-ascii?Q?gqjB+B112oqK0dF1GjpXrXURitSUhXDdVl9TRNM7PapHJ62AD8pFgl6ASpu9?=
 =?us-ascii?Q?RxgoH0FUS7xg7edccx+fgQ13lUG7xr2cRH7DTil08zFEc2krzV4JI/EKWn91?=
 =?us-ascii?Q?Y4oxk5dVzL4XT2OfaNdobidFo9LvAFVJ87vXW3eRTTTVsRjdsNAnj3WE3sa5?=
 =?us-ascii?Q?smMANl5hjPYzHClwkr+fqDyUeo3fe96JTQokoEomIToWshHI68QO/QA79YTS?=
 =?us-ascii?Q?omcGhraxjGbUhB4jkmnLJZP++AxBfeY7jqRVpmYsRGowZcDuxeVRYVIkq7Fl?=
 =?us-ascii?Q?SR3DQFjmDBztOzZ3mFBGvWY3vNSL643m5OTZkk/f/YwecOrBAKu2u27vYD4K?=
 =?us-ascii?Q?rOkqPgbD404wO7XUogNID6hwbk48CftcBO8es7Mpj7wa+KkP3jx8q4He1rra?=
 =?us-ascii?Q?dInWr3Z1AUOM6Gk84VPVmOEjNOEvGPIkPTXKMMPUJKHIHq0Rcg+82PBux2HZ?=
 =?us-ascii?Q?c4KNW/l5fIvKA6Azq3Tie7ZlJspjUjYpA9QFXMLnMFjf4jK9xHMnPU6mpzOK?=
 =?us-ascii?Q?n0c89Xvn3fLYbqx/E+t6zQl/bxtLKILBw+fRGZTZ7UaPMOIJGrPABWJJXvKS?=
 =?us-ascii?Q?Y/o1XPdXsT6mWFsDymek/vtgtRrHLOsEFJ5y+loJgcaZKZwmjmuAp73NgGZa?=
 =?us-ascii?Q?qzB4E9Wqm29pn48Rff6WF0AojPS3JUy46WWBMVvhJ9SRjtW8Up5LoNj2c8q+?=
 =?us-ascii?Q?7ltr7nxd/xrTZyOi35HJOjPijghVU2/ZzSgjgniSaxNaoXtAvxaSwlWn4pHg?=
 =?us-ascii?Q?S4dWwHozQS3pNVROFNBNrt5ewbNvcm4Ofdj8cv7NkwDimHk90Ij8cE8D2zga?=
 =?us-ascii?Q?2RLcerN7lRQB/DcZeuEtBKY8NHmf4+6J7aDmiYdqq8JBXZ1GQTIZcBpUXKuN?=
 =?us-ascii?Q?bout9jNbPkm/BtpKy9Bv3Fzq3VQKAopthbzLWFf98Yei41vwn9wMD/gs4AYK?=
 =?us-ascii?Q?QedUbG6v39QUvJPWF4877dXbC6IiLSheBoQfOV1nGPR3YsXXxDSHP93UEdBd?=
 =?us-ascii?Q?pU6Q+VwPiudHlugdikqN/2syLUVkzBHGXcGmlfmpYz/aSGOMjybv5Xgzkh4h?=
 =?us-ascii?Q?6XopSGF3bhHtCuw96s1fdlHbvxtmeYFet+TtZaqkpd9lAp2EdKDDh73NndB5?=
 =?us-ascii?Q?233kq3ED+Tuk9x77ho9RCpEkuKzbTnKhChj6EVmPPwgapGN2fqN8iT0rpya4?=
 =?us-ascii?Q?/lToiRr41Sc8/WfFp2m7P9sZiYmnEZfkNdPxJLRBOJLhiGAs06Yker+do2cW?=
 =?us-ascii?Q?Iz2YpJUo4IZ1SWgiXPLR1Dtd6b4zm7bHJjQ3vw/Hf+V9uACfhZEjw0nF+BHw?=
 =?us-ascii?Q?pwtocfaqXJxF9BxhKTwIS314aCqMbC8f1DBQT4TvI7/A35IxeC/ay3YAeUKs?=
 =?us-ascii?Q?exr52YVsC2HCIcWpDxB0QW3NAeNaTOm+OmlfHP3dm5+EFv+VYcMMaElh15Wv?=
 =?us-ascii?Q?F0JDof6HvqTD5tQCmawfSl9AmLuM+3ONrzr5eo9bePXL43aATn1+k0FTxY76?=
 =?us-ascii?Q?SamxD0IGEOEs3VdJn2BE9xt2cCFPMmD32sc6LeBy7RTYWhWzXI1encnWaWna?=
 =?us-ascii?Q?rbTCdRUYXc2/LTi4MvXDBpGOskWquxaaftvBdYq7PgyzggbW92IXEExT1A1f?=
 =?us-ascii?Q?6g0nI/vI0rAlh/5bXD4vW9sKDF3EFPCghzakhqfFAcRhEjKKd2JzKEoL56bR?=
 =?us-ascii?Q?n8gjf6Wcig=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604e2705-6004-4279-e19e-08df28484ec0
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:05:13.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +59y36JGKzKewIuc9NakOhGpyBrpGRuE9oyWEw4UvGmKOhgEWILHbSaAmUvhxyjMwjLsNrJx1xr07M9UlL8TTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6805

From: Lianqin Hu <hulianqin@vivo.com>

When a USB mass storage device with a mounted filesystem (e.g. exFAT)
enters runtime suspend (autosuspend), physical removal triggers
scsi_remove_host() which invokes sd_remove() -> del_gendisk() ->
blk_report_disk_dead().  This triggers sync_filesystem() to write
back dirty data, submits bio and blocks in __bio_queue_enter()
waiting for I/O completion that can never happen since the device
is already gone, leading to a hung task.

del_gendisk() unconditionally calls blk_report_disk_dead(disk, false)
when GD_DEAD is not yet set, which always attempts to sync the
filesystem.  For surprise removal where the device cannot handle I/O,
this sync is futile and hangs forever.

Add a surprise_removal flag to struct Scsi_Host that LLDDs can set
before calling scsi_remove_host() to indicate that the device is
already gone and cannot handle I/O.  In sd_remove(), check this flag
and call blk_mark_disk_dead() to set GD_DEAD, so that del_gendisk()
sees GD_DEAD already set and skips the sync.  For orderly removal
where the flag is not set, sync proceeds normally.

The actual setting of this flag by the USB storage driver is done
in a follow-up patch.

Call trace on USB storage surprise removal:
INFO: task kworker/1:0:31 blocked for more than 147 seconds.
Call trace:
 __switch_to+0x198/0x380
 __schedule+0x548/0xfbc
 schedule+0x4c/0x118
 __bio_queue_enter+0xb8/0x174
 blk_mq_submit_bio+0x640/0x7e4
 __submit_bio+0x1a4/0x314
 __submit_bio_noacct_mq+0x38/0x8c
 submit_bio_noacct+0x678/0x750
 submit_bio+0xa8/0x1c8
 submit_bh_wbc+0x148/0x1b4
 __sync_dirty_buffer+0x120/0x1f8
 exfat_sync_fs+0xa4/0xe0
 sync_filesystem+0xa8/0xdc
 fs_bdev_mark_dead+0x30/0x88
 bdev_mark_dead+0x54/0xc4
 blk_report_disk_dead+0x8c/0xd4
 del_gendisk+0xa0/0x2f8
 sd_remove+0x30/0x60
 device_release_driver_internal+0x1c4/0x2bc
 device_release_driver+0x18/0x28
 bus_remove_device+0x158/0x170
 device_del+0x1c8/0x320
 __scsi_remove_device+0x9c/0x184
 scsi_forget_host+0x50/0x70
 scsi_remove_host+0x88/0x18c
 usb_stor_disconnect+0x68/0xf4
 usb_unbind_interface+0x13c/0x340
 device_release_driver_internal+0x1c4/0x2bc
 device_release_driver+0x18/0x28
 bus_remove_device+0x158/0x170
 device_del+0x1c8/0x320
 usb_disable_device+0x84/0x190
 usb_disconnect+0xe8/0x338
 hub_event+0xbd8/0x19ac
 process_scheduled_works+0x200/0x9d8
 worker_thread+0x154/0x3b0

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
---

Changes in v5:
  - Fix v4 data loss risk: scsi_host_in_cancel() cannot distinguish
    surprise removal from orderly removal, causing sync_filesystem()
    to be skipped for all host removals.
  - Replace with an explicit surprise_removal flag in struct Scsi_Host
    that LLDDs set only when the device is physically gone.
  - Split into a 2-patch series; patch 2/2 sets the flag in USB storage.
  - Link to v4: https://lore.kernel.org/all/TYUPR06MB6217570B9AFA4B5980FCCED0D2932@TYUPR06MB6217.apcprd06.prod.outlook.com/

Changes in v4:
  - Repost: v3 did not receive any review feedback.
  - The block layer counterpart (7e9a46004b47 'block: set QUEUE_FLAG_DYING
   unconditionally in blk_mark_disk_dead()') has been merged, but it alone
   is not sufficient as the queue is not frozen during autosuspend.  This
   SCSI patch is still needed to mark the disk dead before del_gendisk().
  - Link to v3: https://lore.kernel.org/all/TYUPR06MB62177178F9305DF5C1A7D046D2A92@TYUPR06MB6217.apcprd06.prod.outlook.com/

Changes in v3:
 - Repost after merge window closure as requested by maintainer.
 - Use scsi_get_host_state() to match scsi_host_in_recovery() pattern.
 - Fix Link to v1 URL.
 - Link to v2: https://lore.kernel.org/all/PUZPR06MB622453C37D2BABC5E71B195DD2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com/

Changes in v2:
 - Split into a two-patch series for independent review by block and SCSI maintainers.
 - This is the SCSI part extracted from v1.
 - Link to v1: https://lore.kernel.org/all/TYUPR06MB62172E412054140753D5E782D2C82@TYUPR06MB6217.apcprd06.prod.outlook.com/

 drivers/scsi/sd.c        | 4 ++++
 include/scsi/scsi_host.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a1b21ea14e54..98f861fb7e80 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4272,6 +4272,10 @@ static void sd_remove(struct scsi_device *sdp)
 
 	scsi_autopm_get_device(sdkp->device);
 
+	/* Device is gone; avoid sync_filesystem() hang in del_gendisk(). */
+	if (sdkp->device->host->surprise_removal)
+		blk_mark_disk_dead(sdkp->disk);
+
 	device_del(&sdkp->disk_dev);
 	del_gendisk(sdkp->disk);
 	if (!sdkp->suspended)
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 16243ec376cd..6788e284877b 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -698,6 +698,9 @@ struct Scsi_Host {
 	/* Host responded with short (<36 bytes) INQUIRY result */
 	unsigned short_inquiry:1;
 
+	/* Device is physically gone; skip sync in sd_remove() */
+	unsigned surprise_removal:1;
+
 	/* The transport requires the LUN bits NOT to be stored in CDB[1] */
 	unsigned no_scsi2_lun_in_cdb:1;
 
-- 
2.48.1

