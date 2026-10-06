Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CE3B4EA4;
	Tue,  6 Oct 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295107; cv=fail; b=rJhiuxrWe8eVE9RvSm27dCnUys5rceVkDqWqIGGSTjtZcBN0PVg519Q96MPfiO6yoHQRl3LH3GQJsA1j3EqhUOvObTV0fMCRIZiDi3zTJ35D8vEt3xtCyF5dsrSO2dn13WTcjVXEFG5L9AknD/f2RlgIY2/MwGSzZNfxCLrkNSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295107; c=relaxed/simple;
	bh=Ogkut6Z7juqQ81S53PiIpBkPKMLqHqw9NcrItjfkUUc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dnhLuGhwnT1vM0ZUkpOVaQJFgLCFld9p19XsntcxWAd9qqDZeSqHsnosh+NVfY4b6YCirthp41Z6bgQ2rO5LHqYvxJuZApOqKxIqFESNBpCFUy2uZtQNLEyzkaSX66XPAOUcQnWq3uyff+sc5Od3SwuQRLGQjWrKqeUEmqSG5pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=sAc03lnt; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="sAc03lnt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POMZoS6ntfaMquniUF6vy+olWi2ODdhTz779ZYjbPIRdgi8Ijh3lybfkgVJM6C9WkIA7EBKdWhDC/9r7enRluW9WsisZuiflxujBMXY+3SfBSM8VmDXbctgBvOhvPSmYKzvStPSoRDh9gCT/iSnNYdJ20bDvEIs28DrbB9AChnApHadzhJDBxuCSvzyYCnRNeAZhhwscubfnyOgOy1zEY7OMF1Sx+cJPRitErvXdf5t7FRxzSdhU7ynEsulzANf6YqJaTt9Pu7pI4Pw+ggXbIvD+ticMtDwPflj24ygSGBYDbSbXE4ILPJvc1JzDDybgRjPXWXe2ZuLELMQV9W08Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX8X2R1DDq8edidJA8juOKqxFOJ2vapFzb/jiC8u58U=;
 b=g6FyaB3lP2g52vrnKmDj/67AqfuotkRAnD6714EETNEbUd+eGz01DCoZcufwJ6E5Je8XmoCNAHK2qZpHAlc6VtlK0tktiS/ce0EQkjTGxNHVERprT+g2MWMg/YfEGBAlAgUqJ/nTAhX4tqfy6rdUrnNAQ6cVrdDVTVPoePFtcpzrNG72uaTmyaE2MMglCIUhhGHLsl/WheAI6SywYQFTcQ4fEbXGyd0Mc2x2HM4oOfdmqmRKoMm37ulgqgWxZ2mHGqfZEzuOoCMpON4/kyXNfvgOwlGAN9h11fzS8gglkRYPK9+WCXuSEnlfZfAnrvn1Kbtrfbg9g+54XsdVzYMqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX8X2R1DDq8edidJA8juOKqxFOJ2vapFzb/jiC8u58U=;
 b=sAc03lntszfRbSsCOosByqVmvmao5apYqUzIlVgvdKCp0jGGlJKSi7xklft0ZUVmQfUrltGC1cpzZLqmWBWf4+Orwg5YkEMp6JH/nW23aup0GFk9t2sQYAkA7dBThwb58rm83ai0TCQbjV+fb4fNts3D6OuKS+7PDI1QW7UHd3A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by BL1PR03MB6086.namprd03.prod.outlook.com (2603:10b6:208:31c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 13:58:22 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:22 +0000
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH] xen-blkfront: Fix IO race during unplug
Date: Tue,  6 Oct 2026 14:58:06 +0100
Message-ID: <20261006135807.2571779-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|BL1PR03MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 829da2cb-2c0d-427c-b64e-08df23b1e262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	L3M/Qb2JU21SdjhNLTGBgTacUclL0m/4MCmOPLo3LhwXu00OOFn2EP7mGimKtYdE+SwgFc8m2mO5ZWHlSn8qOtlTZqmyVP8dekWVv+kSqeOtpD5FOJIc7eO0dISNR5ICVzWhGAeqBbzY3MDzR75sN9E5B8caYDgU2GdT28G/SCjkL5II+m1sxnqKFIDs3DODR10XkHZhnI7KV1MZwC0Gmb/dKjYtjKrh5S/zjy0VjjiGFdsT6gvYN6vgL5k9gDegRr/A88BSXmo5UfAyG0QCAhhCEtBUGz0axyyveo7PBkJ4iUmD8kssyy4D+upqu5HNT0OLu9dg8O3bl+sxPd1hOhRtXrmXH3lHX0JtrqHGH+NQQM6uIXZhwmEPIX6Z4WXn6oKRc55utVau0bUE4aIeph0Xzpk3gNsyCi9UAQim/j90Tx8INajK886g61xai3phuylhjg185oLK9vRRPt55AMDpHnQv/QJF3U5OLE5thgf42ftE+NSri8nZdwSgmBMnKOOBnwlkaKftU040mKxEsxq7C9CbpeYQTZ/VsVVfIPr6gzXMCK4MS+crNNhWGLOdgsSVgsyt01GK/QcPgLvQ6fjfcRDqiqdwyFks/qRKxDtx/fyKpDcb26ICF7HeBshxQsBpSbn/yrzEvlE0CCwUGwkSr9HJNsec7o1rNTrOKns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8274.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5MZ5bTFcUntVBoYYTGCZYOuO8iZ1FqmTddfi5dpm1+G9RvmXFu5UHT0Dsz0?=
 =?us-ascii?Q?Uygghsa09PFz2yXuuOv/ddyEJGeI/vChlg7D/htlIVoC6N3YGmnVjHN+YgsD?=
 =?us-ascii?Q?Y6F2APlKk0UpBEZVumCCTOsS65gDVN7Wetgze9WNjefAgzDMnocIiBt8NNZf?=
 =?us-ascii?Q?xekL+ey5ttFPZj+WZ70hwQibFDRJMuPMdFK1/CvIbSiNcT1BLmJa1WKAnFkf?=
 =?us-ascii?Q?2jPDqq7lIGEnNIHyELiLHDfDOZHx8WWgYTWmfD/P6MFPCoJZnxMgDFFhh9I+?=
 =?us-ascii?Q?f44WbCrD/YGzeGvOD24lBqlqozg4WjMuKPBCsvUpRheGA+mfrMi9Kes8TB+V?=
 =?us-ascii?Q?YQIF88Gf8nC7tyEYRhqCrVW1gKuFmm4tqaARSOyz10w6yN2/TA9+BF1JiKqC?=
 =?us-ascii?Q?4XWx5Z9K6QTBM2s2+yAhRtBU7qRx+itIfJu+wgjjfaUMb40lHc0Fp68bngfR?=
 =?us-ascii?Q?dO/HTwD++r4BjKt62U1BgIdW49xa6nH0QJeBcdmZT5bfaCTFXIMp3Q/bPydJ?=
 =?us-ascii?Q?vA6D7izEgVZ9zq72UKyKmUZyrk+rZSrmSCazkBCIGTVetHfh0PjZ4sdaSfmk?=
 =?us-ascii?Q?y/YM5pLm8rdIuhklbtyozje5GyD5hfNSR8popccBFcFHeoI8SvjoyKx4UrBj?=
 =?us-ascii?Q?hOa/ZXYcELkdW9rDR99/5ZNloLZCelHmhCj6x/bXrDhz62NEMMXdjiHGoEUF?=
 =?us-ascii?Q?c5a3WNdpGKfMIdkSfVlGmStr/G3t5eSlQshBf3poO2U/SJxTTrvKq59PxTCg?=
 =?us-ascii?Q?IAE59yHbPNppIzEw1nw+JvOkixEo+oxgwi15k5wUzzGc5U2BixcmXcXgLgu7?=
 =?us-ascii?Q?8b49WmMUc8KJ6iQoN5pexxYMoGPMc5/c+Z+IElkM6pItX4VASd9SkOi/H2VX?=
 =?us-ascii?Q?SqxRYCu02E+dGO8tXEhtSfZhyAFws9HIIgF1mlMy5XVn7H6Iv9BguYNFbDt6?=
 =?us-ascii?Q?S/Kqv1DOMYDR8pOLKSC/53VIz8w8NjZAngmRL0VcrlRRW09zh26lYE3wq5WT?=
 =?us-ascii?Q?i61lvgNK/K6Z4PODaCmg1o+KBl/ggVFk4NDoBJGDVi3fuOffRMvSKyY6EiXF?=
 =?us-ascii?Q?cPh95DddsZgkaLcolYaqhVZ5J8oSxG/7bR9VqJMcnaTXKfs7GXofB8tyb4/u?=
 =?us-ascii?Q?QIX4YZhq8o7knu88sksRVoOXv5pMX+GSTs1tCOJuVhGu65NVxr0L0dJmVJrt?=
 =?us-ascii?Q?2HmMwHX1tgeYANDlDOrvvXp3A71aCgoKZHH6Yo4FO8G3W4E5+5woK11iw4CO?=
 =?us-ascii?Q?ofYL/lzoLC/bUAOeIyR33JWV2bd8JRHY9DOam3ORD9pMNMDpZPspqb6Sjuu+?=
 =?us-ascii?Q?ClGVzQWtDdq4o13FDZkmWPFF9ie4CbiEqUS/CcPjUXjKb9OrSfMH6tK+CxP+?=
 =?us-ascii?Q?Rk+GOsNXAiUGkszsBxSvZkK1NyhXOtDQnZ/DI0tZpZoouQCdvKNB6rGOnw3s?=
 =?us-ascii?Q?8BlrzzPAyDVk88Un6KM4SiIPo54/ZlCJpA7ESYyI+QPFUboUW3SEfc/kJbc1?=
 =?us-ascii?Q?45OOUQU4yaE6Mdzxu/gjTapSMtmL2KuGa7cZNyp5i/0HRBtANNGk7LGe07H+?=
 =?us-ascii?Q?lsFFGVgxHO6CKFMRQs5lakB5spgcEwbnKdw7DKTcimqfKxPVIO4QD5t3y5/F?=
 =?us-ascii?Q?A9Bvr8dHRHzq2qECiWIT96iw8vH0x5v73KsMAyuey7aoDMXc+21XVQxDmUTB?=
 =?us-ascii?Q?NEpXlJCY5xEMtjmFoqsEpyh0yDZLkTsN0u9yXrPkrdGbGWxODSefdhiNM2KB?=
 =?us-ascii?Q?43sjE864174CriJgfRR9kOBcQ/uD8dM=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829da2cb-2c0d-427c-b64e-08df23b1e262
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:22.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re4Fg4Jp14KLzr5fnXUK6HX8M18IRnUs0rKX/As7+q2sre9AiKvOkT3kuvcsufFDGjoQUgncXVPkn38Kuj1w/QPgv9hXtb3pdz/7kM0iumo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6086

During unplug, blkfront stops the hw queues and marks the disk as dead,
then later during removal calls del_gendisk(). However, IO issued after
the hw queues are stopped but before the call to del_gendisk() will be
queued but never handled. This causes del_gendisk() to hang forever
waiting for the queue refcount to drop to zero.

This can be reproduced by issuing IO during an artificial delay after
stopping the hw queues.

Fix this by simply not stopping the hw queues directly. Marking the disk
as dead also freezes the queue which prevents new requests being added
and it synchronously runs the hw queues to clear anything pending.

Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

I'm not sure about the Fixes tag. It's the most likely looking candidate
to me but I didn't confirm whether it actually introduced the
regression.

 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8dad7bf5f664..69a2315a1b20 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2138,10 +2138,8 @@ static void blkfront_closing(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	if (info->rq && info->gd) {
-		blk_mq_stop_hw_queues(info->rq);
+	if (info->gd)
 		blk_mark_disk_dead(info->gd);
-	}
 
 	for_each_rinfo(info, rinfo, i) {
 		/* No more gnttab callback work. */
-- 
2.55.0

