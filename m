Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4E35F172;
	Wed, 12 Aug 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522319; cv=fail; b=dwsPs+kR0JDDtOfVIZX3kZFKt/RnGrrn9cTOHBSSC4sG7BXqP8PLgORcOyVBkjdYUcEze5+0Qmq85Y9wlK5KgUp8bXt+v6LCq1LdS8CFLtZXmxVUjljD6rHlBtO1Q1PVx77D1PxwaDUf4I4cbykF/6W2R0xOblMi7EMBEBvPtKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522319; c=relaxed/simple;
	bh=jB+sXhmO14UtsmnPR/KiHCJaQt7AuJKcS+YZ8vX0u2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=egpQCawKmFhjGqphoYbZny+1LqkjsVIWN9am3Gl3GHaPUZfcYsIUm/uaNOJiBed+TRUAOMxk97G+Qz2DWfcQ3ijInOzyAboAgdiFY/sKc39rGvVIvvLB4sujI7Eb4CQxRPSLiSlAQ31tWD8qBPyzVklLjCMPH1HR0A3+KBYcvQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DEqrCiwA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=I/eNETI4; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DEqrCiwA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I/eNETI4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786522321; x=1818058321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jB+sXhmO14UtsmnPR/KiHCJaQt7AuJKcS+YZ8vX0u2k=;
  b=DEqrCiwAsByohIbOdR6BZReAWU3cC+q6HF85P0HbMlI06++FiITWuaJW
   k1w1WyClfkeJp9z/Vt5v3wr007KR2PTPcWbpdOorzwuMCKNdRPD0eNuOX
   U0HtFUCsY2gx7dkC+Y9AjKPXonlzQKqIk+A3t52EJvWyZVaZCqv827tui
   Y/EsOQF/4pm5Ilkds2gB9ESYIL1BZNjp8e2SxFbIz1+2u8LmGp5oqlURY
   4T3C9DSpChu5NVNM7KIIIZdC2LQzZSS9Vl4ZYlUov3vOy1k9NMjtpJ6xe
   r/UCLj0XhCQpQVUHRRLQrcOUXy3hB7BH//HwBFJ3xbwoFHWrjStOZOf8i
   A==;
X-CSE-ConnectionGUID: TiTMQwasRx+P4Y7V2K++WA==
X-CSE-MsgGUID: 91Vax1OdQqSfjYrc2TKbEg==
X-IronPort-AV: E=Sophos;i="6.25,219,1779120000"; 
   d="scan'208";a="148809667"
Received: from mail-northcentralusazon11010009.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.9])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 16:10:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe31td8dpGYiQKsCzU8OXanoh95vI1k4lp4xnoGkwA7bTDQME5kuNm5+nW5jkTp3ZppkRJBA8QyCpPyADOt5whHDeBb1p4eP3+6VIJnazmLnt+cBW6S/Zxv6RkBw7O9TKleLXgqfLXuKtSGCmUz95r69vXFDJtMYJjrRpSZblOEJi9W53NoNWRO7ymjXHd0gMSWvs8wiDz9JjbkEUQJmVAkbVuZ1pLYOS39LgiANmMYnkMmvPj66vyhbmxnBLoXO7wALn4RdU4EW/YXQXBYXdJ7STtu8o7R/A0H0eJDXmTkMRZpj5tC2xDlBmUvsy9ulBQEjHAjS+dj2tQ5POmEBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCqQNByHxVNjHfr2WBz2udzB4viFfla+Uoe6auXOeuQ=;
 b=ZcbA5lFByDvCibI0P0XI0VknQ/W6ZZlf63j8/UaZtk79cA2Cd+e2qLbsfJw7YobhZWYeO/22+JZmiltihkxpfoyVAL47BIqr8L4nxsZ3hAHo/gW++P512Scr+vPCuGvk+BMghwLA2lHjf3GdcyKmj7y+4geoEsQRHfxpkjxwVGY9webdlTjpKWDplfbVMKuOeugMg3N+2P8fup0orhq2/iIkSBmdcTPo/iB2GiP7PhTwHWFRDY8m3hSJysW1GDj5b/x08Jy+z24V+xXVh4ZMw2mgkQOhG49/ljkq5fIIARtfCIgkZuCRyYkvRwmKIqQqMWa6QMh6y/zJ5Pvp+tlx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCqQNByHxVNjHfr2WBz2udzB4viFfla+Uoe6auXOeuQ=;
 b=I/eNETI4gE32N+B9p8EI8Qolq7GjxMH8J+H20DKXV0/YOIuHzSsgmbs/Pl7hxq3632wWexaRDztWqeI4FuYNwwb3dbfTYbWNeS67Q1oHu72vw5sPdLplfcMvCiknc8CJbwf1pvm7R14lP58y2GLZEvV+Okh2sigoj6LfUgF/V4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CY2PR04MB264774.namprd04.prod.outlook.com
 (2603:10b6:930:118::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:10:45 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 08:10:45 +0000
Date: Wed, 12 Aug 2026 17:10:38 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] loop: drop stale partitions on LOOP_CHANGE_FD
Message-ID: <anwpf-WdSj4W8AGp@shinmob>
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
 <20260806-b4-loop-nbd-stale-partitions-v1-1-67bb75a8d7be@amutable.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-1-67bb75a8d7be@amutable.com>
X-ClientProxiedBy: TYCP301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::18) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CY2PR04MB264774:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e42e34-65f3-43b6-e3b6-08def84935b2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jkrM09Whm0vP2GIP8MueJXXXFzMaQBeJ928Msu4w/kSYUIGllY317TX+LtS8kEJKlY9hJ8RlhI+kKgbHBR+GwDmX9jLuSvNGTi58AbtpOHZT3kJ6bb+s3VLdcmLa4jibe53DsEweHJV9hDCBbWl2LsZYvosf+pfzJHKxPSArA352iOadX0NCkFMY5espP3IhkRdlquKjtdtvOCzviEhfzGd+aqFipRsAW2bMoFutaSBaQUZs+eDLr8IPQFi3itFgRTXRv+2Ux/mVGyj3CEIXcefNgLEWpF1MlKiXIrRFbaHOR2rl0o7CrRiB9kAZ5nsEfRsqBJ260NW7K/mU7MO0YivYRZFGVdVWRhHfiRT4KCVYQOCd7lGjJwQQVTU/Kf2/Q0/sQwuvCasiOyZ+XHGmwLyFaUv6f/Tg0KEtlCqEfgkgs2jlpvaOpI8oKrTJsIa3896JZutjXLwGOY+gf8jQVr2qDUqf3W3GOwKmI9otHo8NiyNMjbTpkKKre8Jq0n5fZQnpB7scJGEVyUZwaJOTcsT2jmexwkB6JXfwuDD792RJ+VarZ0pMp4PIVjK2ysbflihzldemiP0tj7b4H6ufUMzwLFJAI77hxaVWYStTWYEdvKS13VoQUM0qL7wWmSQCySc0zcW8kKadxisbRFFE0zEf/hY5VTGqJXaqqG/cRm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dJMi8JzAit5rdjZ0x3lmGcUu7Mt25CRMtJhGkmG6oD1Sm9q3Sj2YaXjd8Kwh?=
 =?us-ascii?Q?HgWp7Ij8E/yX+6P0TGz9utWJgMkcDCBExy/QUt7036VlToYKTiUs1kahzD9g?=
 =?us-ascii?Q?JA6nj2CdlbBVc47NNZRSv3N6bDmTKESYb1P7gZmvyuXVWH/YIgz91ERivuk+?=
 =?us-ascii?Q?e4+WDPqrLKtYwjH6szNcL+Gz3KoSz7z2bXNvb9x8l1L1YUBMNZVIe4PTsrO2?=
 =?us-ascii?Q?Cuh8Hz6XftPITqAvgsWZT3vqCvnGHppL50sTBUTZZ0K6rgE0AVCOWJJjl46K?=
 =?us-ascii?Q?GDMkClivqABLqlOpy9QvAYg3VbvAANX9qiKow2FNoEdlYbQoSzAGSJPCfzD5?=
 =?us-ascii?Q?uZc5pNtGkVa5cApr5MP4RuXGUkjrQwzru+f8m8aFT+zqDk0qp1V4ufwZUQGH?=
 =?us-ascii?Q?B/z1W+dyA/L+YRmXAhPBhB/IYnq96DCjwRVzEpBQvJKcU31l7c0yJXMQO7Mj?=
 =?us-ascii?Q?t8tXX7g7Ihh8WmKfp80fpCY6Q34elpqOo7XSF+j+BwuLWst+nn1NwUsALDrc?=
 =?us-ascii?Q?TW4mzTgPlP0H0bbHVy5Fkki9UkJKeDJAvuB/Men1de9i94QhlJMH+m4mr7C3?=
 =?us-ascii?Q?pHY+JI1FojBLC03QjDRkPpEjuuWPxHn0uYLt1WtrbHQwIy75sjuQDeI8gG97?=
 =?us-ascii?Q?wv76aVcKBo4dJB83KsBpNsVqPKC3Riwt6n7TFheItYFygoewAo6rAswIBNP1?=
 =?us-ascii?Q?4qAUL60ThCMmvJ2czQgi6iKdYUpImBFJjLQYniKYWt9NmwRjF/drrYeNeQ1u?=
 =?us-ascii?Q?aiJ7GWHrx4a9VSqk9j4KM7WyUZIixwVsmMXqNkOKwPFSlTfXr20kPY6lb3sJ?=
 =?us-ascii?Q?l7T8gx8DB2ZMk1mpFNFtVAdrwStb7fhfg66ck6EfAJ0iczheqlDzlyxCKTsC?=
 =?us-ascii?Q?IzeHiwseVqrk8CFpfeDTGA/lHqKehhNWSwZw9sn+ULVjuW8D+mQ8Ey8TeJ2b?=
 =?us-ascii?Q?Bzir+AWG5ptiyjILJ+DSjCkttLus11gnqrbuRVzTkNey6f88rtr7Dw5S33UQ?=
 =?us-ascii?Q?TxawuaRCmc1Fw3y0hFcU6j9WFRQZIqbPADuitKf9hB7qpTns+5iG0ASnu4Po?=
 =?us-ascii?Q?NKL4KcT/dxh90Rz/7GtCi2mIqY/sLBbhJ0ISs9rP6ptcACPxIdPd4secy7Wu?=
 =?us-ascii?Q?DGClFpIsvX6dVfvlSJOxfqR7n+7giazcsZrtQAp7H7CMt6MlX/g19nqNzMln?=
 =?us-ascii?Q?TeY2ue8KXfl9OFIh8lTnyVdHAhb181/cqL2WwoNgh4M2B0lNO/dXXPxLNuNh?=
 =?us-ascii?Q?bF651kw285E4Kn8BSw5wvIgouCyzWQzFNvMphRw4re0+kt291odtYtv/qGsy?=
 =?us-ascii?Q?NnKUDOQICWHapuxiSH3FbvSJD8aKKzoWHQbnzO7a8xVEGMp+dfsbjGIGbRUc?=
 =?us-ascii?Q?B9CC4EK4ruSIr7apehuj5AhILJrBo6xN4sVu9Iqsda0CZv52ErNJwl7bgMnb?=
 =?us-ascii?Q?BcQJMT9FmmdLWksKek31V2RYV1s5xYOwrQz8vvvRbJLTa7/oN79p9RjVzTGP?=
 =?us-ascii?Q?XcTy3L7C0zHlbBC9jJFuE82V3pCy+FO8rwORsmnwvpq1iBd4bP5sR8Wqc+kY?=
 =?us-ascii?Q?f1Kt6o2fQMJyrGg1exKxmwbqqmTT6OQHkUSim8mHGP/8MNp1Gus+4qErEz4a?=
 =?us-ascii?Q?qzOva9sJ80b9sM3hg8UZvusu1+SMpUUfkD3pNb8wNNjXQeT4V4IUluI792vT?=
 =?us-ascii?Q?IaXBMmZoQydmN/WRW7MJTzkUt572l7pqfskeg7Hw2u1uhscClZGlAz/88llZ?=
 =?us-ascii?Q?Edjlz56m/GtZlwJg+a4bhw6ZPGZLvRU=3D?=
X-Exchange-RoutingPolicyChecked:
	ZXuXt3OoqUCsqRNfx6Bo3iRGU2zI9xXMijj+ulNRnwie6Q0+FfAVEDhUn5NTyMQs65LeGqkY0ZnYE1h+fwGSnwYGOB68YjKIVR7JfppF5o/4qfwijiySX7h8SAaaTVpyxDSu4upmoZBo3lVncT1dc6cwBS4fLQdT612ml32Dlf46JFSXI8t/AmPiHkFyVseHo+xDPiOzV5k6Qc9ci5ttLMj3UFNQmdou9LzbzlvxyKVSajF8NsKhskr5HGJ22mQ4hp/VFtbsmO1CDTzZisZACcNugKyiE37g3+iOy8jj8/zm4HF9+V1oMu3FygEKqwpHdUgMC/hxQcpby590o/5d2w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GBlxjMXJ+wqPwZL5OZoMmFM8JBEj8y6eOuSSQuAc7dib2UwBF5muavJIVYmz0uO3sxoMztNaDjRjckB6IiyKfVLr51PToc2U9IsxNCn2UuVcLTee5mQlpQN3XpzssE2JNc7P5GfLfrEnRoCF9v8azQ20IIaebz7+ygQ2qLWOe5o3foonXfe837tcHFs6fDN5UYz42XsISV8S6u08nEn5Cmtf9GqkbajPU3Cfdtc+N0qJjkb9gXSHsB/5GBUFw1byDIBBIso6hqzGiyF18hsMGWeix51IA0hVK3ifxyGo4d9BlhxxU7vMa0uyJR7WdHJdHMjKjHYogXHpZIC/DmK7lC4+txPZqlxk1tncVozxlhbdVOECSxkSe0aNpoZbrZIoQQZqDsBw19lj0RVYYju9nLfxySb4DSrkCjElP0ue/d2MCgZb4KTbOCFpL0eOLbD0YJsllv0lhmNMWLdXQLdKpjKzmzCQj6Zk0rS55QhAaYyCAhALQI79PQnjd5n+2pEKncQJoKTpGs4cKf54cypUq/WVWjMPOCOUPvnTqwIHLfF6G5ZG2npeChMfEFQKYYc7flRK6Skc2ke2zdg7glDPzrzzG/DHkGcoLN8O+375vFLoFzjzq3eaSVw02mgdZ3i8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e42e34-65f3-43b6-e3b6-08def84935b2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:10:45.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PajPQ6tYlYZ9ee26pLdha5T2UK7VRiXJtaV0DcCgpM0HYeNmqeiiJy0lxeVNia3pMywO2WVzUUpYcz156pIXv+8l21iXuvHsbMx1RnZt5KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR04MB264774

On Aug 06, 2026 / 12:36, Daan De Meyer via B4 Relay wrote:
> From: Daan De Meyer <daan@amutable.com>
> 
> Commit 267ec4d7223a ("loop: fix partition scan race between udev and
> loop_reread_partitions()") stopped disk_force_media_change() from
> setting GD_NEED_PART_SCAN. That bit did more than request a rescan:
> bdev_disk_changed() drops every partition before it consults
> disk_has_partscan(), so the lazy scan on the next open was also what
> removed partitions from a loop device without LO_FLAGS_PARTSCAN.
> 
> Such devices are not unusual. bdev_add_partition() only rejects
> GENHD_FL_NO_PART disks, so BLKPG_ADD_PARTITION works while
> GD_SUPPRESS_PART_SCAN is set, and parted, libfdisk and systemd all fall
> back to BLKPG when BLKRRPART fails with -EINVAL, which is what a loop
> device without LO_FLAGS_PARTSCAN returns.
> 
> loop_change_fd() only rescans when LO_FLAGS_PARTSCAN is set, so those
> partitions now survive the backing file swap and keep describing the old
> file. The new backing file must have the same size, but its partition
> table can be completely different, leaving the partition devices mapping
> the wrong ranges.
> 
> Call loop_reread_partitions() unconditionally. Without LO_FLAGS_PARTSCAN,
> blk_add_partitions() returns early, so this drops the stale partitions
> without scanning the new backing file.

Daan also posted a new, blktests test case that recreates the problem described
[*]. I confirmed that the test case failed with v7.2-rc7 kernel, and this patch
avoids the failure.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://github.com/linux-blktests/blktests/pull/259
