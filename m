Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294D3EB81D;
	Wed, 12 Aug 2026 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524289; cv=fail; b=cICIMw7bsui3/sTQwhffDReyagNVx5E+hq5qpTC/iBNcOxuuIkMx46SfZjJkblfaNWXsTjq7DHwh2p3oR7Xe/fkqjp+icgez5Hu9VuikJdbYeVfXX32iQuPxbCliHlubjsu7wi6Q5LQRovtgitrwmL6UbkkR6LZZLCcU3591aJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524289; c=relaxed/simple;
	bh=aJDHEWEGZV28tQViLwbCE0timTl9DUmpuOlxAg4fd20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MP1euBqt7ZFqOdmFEHNK8AcBUSfCCKbTwNiKLrD1deHfH6Kafvor9j5+6VWAd940Qm1J2Yh0xk60ZQScSxhal1Vx50UkbG5MPhuu9pkrUh1BNvUXxdCAs8d5aYrRm+hyGOidc9Uw7B0YQIVCNjIuvkMGu0Kchr4ldJrBDSsDtxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XhmoKD70; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KiIX6lr0; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XhmoKD70";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KiIX6lr0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786524287; x=1818060287;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aJDHEWEGZV28tQViLwbCE0timTl9DUmpuOlxAg4fd20=;
  b=XhmoKD70m+FaepmPgpGAp0j3eYDb27SboIC/Q4qZwZ+bBlNhSXf2G7F/
   NFd0fN595VoA75cc80KBxYinZ4QYl3hoyOq+fXdRDzzM6mSM5qWlFdDXs
   YcKeNSk/6n27YR5k3bX7wwiwyjBGwY/gf4T7Xh/1wgAcT5mwao3ZdHnkT
   B3L49rxvoQ+FrrvZAHcGKnN+LsAA/c/cMomdoEuonZxpUiJK8H9UuIWFm
   TInirvpq3ykkR1CPl9NBwiIo+MbWr3T19gDDwqJ+FXqN8FXa8ljgh4mWX
   b62h0gm9/Q7RnL6BjvlK25NPwQVEY4M2wK29fDvfCEQ4KqP+0+v/vd/CZ
   A==;
X-CSE-ConnectionGUID: 1tmFeoZCTv+YwtUmg8KnJg==
X-CSE-MsgGUID: xd2Y9VLbReyXNjQeQ1fr2A==
X-IronPort-AV: E=Sophos;i="6.25,219,1779120000"; 
   d="scan'208";a="152034038"
Received: from mail-eastus2azon11010017.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2026 16:44:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ/ZyiF26GbCqEDtCYpy9Rn/oTbW+SEWpVNv+Q6dYiGUM8GkszHEqKPK/+vjDl7Zq+8MEcLCWnaszHbIZIeaDHXcgdL1/8imHXaaGs3n4vTnttED3fp/sccV/8/vXyILynSjeFzVMEqDsqwKlACUsBhx2yfwm728J8R1rA5DaYxTEvIc+OMSZZTgnQHTMqIaCMrsWGvqjAcVPpn+DQ4O4r6uIH3X6ktrIEtyCdVF88VvduUROvkCrMK77hytdW9jv/0j2I8HbDqlD4dAFExQMysqEcpJPaFfFCo3GgmxEOpXlnOSzqqkfrncjU4qw9eIBDb5+7YA3YS7g9bwpQAj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqhP72Gk4Qz/ucqp2CcZcze9HQBDZVtRIdcTRMnR9Yo=;
 b=wMP23jCMBiexbHFsnzgtsuBKjc/bCp6AQChMegWbwV9lT9zFfclGWN3hjnZa5wyhtiIy2T1h6jGijZhGwFlVYJXoYy08ATLDn82eIoL8KQHnH5yDFmMr4BcpnacDbUcgRQrPIeJL0TYF/EW1c/J+4ZTqp64jdbMUiHfKsRxbT+iMHaYiANoHL6Wn9n4zPN7gIAqJa64iCLzfRhmeSb6KP4V208ELnDHGmkWg2SCk7O6P7dWjYnw/3viWpzOI/lmbBj13dQBjoCbFzvko7aP13Ao0i3smSVevYkFX7EaIhPxsG0Utab/8yvRRv2fFBIlCzcGMNKjxQvaTJpOcsvkkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqhP72Gk4Qz/ucqp2CcZcze9HQBDZVtRIdcTRMnR9Yo=;
 b=KiIX6lr0R11r0e8h9CtiFyA6f6MIXeC/Ut5NQLuJvRkD8E+uWgJ3jb5XgJB9xadkYMSGeyRixiO2TcfgpUs1SfARhcKEWk3DIxp1r6JmyQ3/gYYYANtGtRSuWpJAcoAqJjjsTb/YBvYlMIU0anDAMvLMjGTmoF0ruJA2Htl+SZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CH1PR04MB9712.namprd04.prod.outlook.com
 (2603:10b6:610:2ad::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 08:44:42 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 08:44:42 +0000
Date: Wed, 12 Aug 2026 17:44:36 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
Message-ID: <anwyEbZhRHgSAyqB@shinmob>
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
 <20260806-b4-loop-nbd-stale-partitions-v1-2-67bb75a8d7be@amutable.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-2-67bb75a8d7be@amutable.com>
X-ClientProxiedBy: TY4PR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:405:370::18) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CH1PR04MB9712:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ad57d5-7cf1-40b2-9c3e-08def84df3ee
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|19092799006|6133799003|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	/YzmnclqtSajSZkdkz0Z4Zm1a6WbBvwOi3AOQ+HZzI8RSbxu0n60CT1d9JVb4Wl1dVF9BOhD8Ita35yrH5qw/jgmnr13aULbSd/cSVUkslVflcMqDvFYSAcEye5C9w7UONScjKPhJykXMjPB53gID2hdQJxND6QQpAy3c7Ds5/o+FVtQ41CDOzRfqrfT+j3482qzgtsEnkCGl+Iepb51m2DNTKfO9oIEdtW1Qglfuv+LzSnlYgcq1zS/D/cnRsL4FYpiAXDqBoBciC5gyhQ5l1LpGzf/V2aRwwsuwllZdvr+8m7gdOH/i8TY48B6e17/HHxzbT9ztPKNAbcQnFa09arTGoG4dsPHo/bRf2OzzIf8g+76zYVUgVjXfnHi6VQH9eD3bIkASPaAo5rOlnxIoEaSwBVYYxY9l3kA71MzMvxTWZJY46nJxZrRou8RIMkdxcbI4hciQoaMR4NXay4qUqJ2HThiFe1C+/IuOQez7d52OrP61zcBMXtIQ1wTX8POrRekg6z+R9YfduYzNOwNeX11/fmyu/ccASUU9QukTxdXUXi8SChicFRr/H4flKQ04CxAqJjFr4qceBXMTejiFETMwj5Bnm9IsXb7VoR7p0NVVDnkJL/nnIhjZjfmRBYJ4DMQE2P4xTGHoGOiMdUEZMsarp0b+lh6svyyjpmB/jA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(19092799006)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wq28Gq1fNN931LeJmpAm6n63rWxSa5vwQq+rXEO6af/DDCi0UZJK5iNvNCMf?=
 =?us-ascii?Q?/AyxoveoZgR36ajRbt3LCCSX59898n5tS9+9D9C1JgM5deIPdGx0FERzpV2s?=
 =?us-ascii?Q?ZI07BDXVxuY67OHCoup8cjxAvxftA+nw+X7lseataS8txF5gfiUIkZ0zEMNr?=
 =?us-ascii?Q?NvABaH/2DC3Dlycx/gCme6cHcVfzopzhZZUM8uBqwBIrmXmdfnHz0F0IK3+K?=
 =?us-ascii?Q?zTC4w5K0kkV5tAqhi8H/fverI/O3g+omfbRUoDztog/sq1bEOMrFhpT2kOSE?=
 =?us-ascii?Q?YivBPzUnbIslH3kCPNlxkky5l5L/o8/CBt0L7YB1Duaq/qgOxASgW2irlxRK?=
 =?us-ascii?Q?miACA4ZWfpaOLAKLhuoGYyGUF02d7PtmA7K74vmRHOjhf+vsKcrTq9TSEZY+?=
 =?us-ascii?Q?TOO+71oivfZjSBmWZmSKEUrMbTscXGAOyoBuDllcR1cRoWjW3iuGdhknEDll?=
 =?us-ascii?Q?+5H9QxEYrmch4NRuVZS5V/iRPZBhsMW7IybLVc9TfWx+QR4AJ2xR5lDHoyT7?=
 =?us-ascii?Q?vmmVaoOIXBGS5d0NRITMY4rhkLBeV8Zg2bwqiLwKRG4BPwQOuwoyDxe/myBu?=
 =?us-ascii?Q?PdQklfN1kiqk9k3Wp4sIoIeygnkQ8FAeeTqJsZrY9iWwZQPz/UVLZcuV0Vrl?=
 =?us-ascii?Q?Ku0KKHPGiU71O7tP/gCBJJElSAlnugW5NsmiuufNHwH1Nw7By7bb/CwIS+QV?=
 =?us-ascii?Q?lWGYclIlVWxUHcZxeXbgFPKBybF0wHNaITh8V7KuuCFEnrcLAvPaNntjZ9Br?=
 =?us-ascii?Q?6AJ68NJGrF5vZgOQlihhcQGKlZa3+1tN7vLV/jexjlGpAwWiqxshli8FGuSv?=
 =?us-ascii?Q?g8H9pCR+BumP2o6T0fl0dui+HXpRYN/gP3jhn1tXTAQSPfWMsAhy3SSiC2AK?=
 =?us-ascii?Q?00PHbvZUcdIUCrfhZqpNNH0VIfmXYwrYOUz3MivvNzfVflOr7MQzDO4ohFls?=
 =?us-ascii?Q?r35dJozv+fAGCgfUUAxXDKkKpM2Od2tFzn9C4WLs5GL3SO97KMTTM1uqarsu?=
 =?us-ascii?Q?eAiyACXB1guO2XJlRnwQWG8POjSHdB6fYK0Hx0f3mGcy81XkZzN9Z473eFLc?=
 =?us-ascii?Q?MEbGKaql7AtGCTaVz3G4TkLTx4svDLbrF4NPkBPxGo8LBdryZu15mkOl6H9F?=
 =?us-ascii?Q?YDjKYDPh7Ftfy7MvqGtjTtfxznM+6qIXfhpA5wOvzzQJWW4prSfaeUkeb521?=
 =?us-ascii?Q?2eLn3xo1OXwBOObY8StJQdHPR6y/ZDqrQipbSLFiau9QDOUVMzVTFx9BDYYg?=
 =?us-ascii?Q?cnGJyYlSGQVVuSbxAfSPSwcVXSf7vjRJdqy4BtJM2IotqNc4Fz5kjc5BJ7Bc?=
 =?us-ascii?Q?bzxkQSkEzKqxZ6seqkOt1onQrj7Mx3cr1VKfD9qvvneuDObqkEwqyR4puXwS?=
 =?us-ascii?Q?6JrivWS/Zft4aQ/rstYtafPb8MKNk7DPLI3NxNaOnJzq2tHauF/tZdZqM9hH?=
 =?us-ascii?Q?b3gIwHxGmGk7nkNwkMMTfvzLXnIDAifcgMQADU5o5y0AHceF1UdwFZiIyo5/?=
 =?us-ascii?Q?kqP8BIebkn6Vp8gldQjradCZxjldI7Bk9v2tmE5mf3ztyfK1XUmtjlTUmqTI?=
 =?us-ascii?Q?gmK/unLCQnZUVj/2wsgyEmNHDd0Np7vvC8k6K/pXaZLMDlxX79QWZJ/IbyYD?=
 =?us-ascii?Q?HdP09C2qsH5ffKzEdCLRhPVZF9LJEat8AB617cu2S0amecbVdrGtJDRPlFBp?=
 =?us-ascii?Q?2Ynzm/OlSaAMIHJnDicWfnZ0Us0b3ie49qGZEg4CbFDOqoe15JWRUBQyQtr+?=
 =?us-ascii?Q?qykmTFCqM7C6xdMllgffBOONerSP2WE=3D?=
X-Exchange-RoutingPolicyChecked:
	MZcvnx6nYxy38Ofp1KfrliF8a9umiiC/6rBtfm5WZSsfjojKJPm5RE/ouVyOUk2sXakA2HfCiPGD8UImgkdLPuUK2lKOxzftSoDV9dO7wnbejgkP1t+eiFOxRnx7UGWix6/DPJZM68WY9F322hp88ZHqJSL1R0o1vaZJG1c810/bikwhOp4/TavUWjk00B5PI+ywX/mgDA6L0PUdfqbFcBNuHXLq8/cXxYFXV/uUhyB/jOertYSrwSo09Br2MJnYwk3BEU85gsTvxKstItuinjFXYUjezTiXHScyjdeVXRLVoX9UOeB7OehOZ1XWEF/QQ5Zdwrsp1Qcs4fDlxPKCFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mSrpXeH2baX+UkpSNJAUtesZqGuEZOgLCPRNW8tjbCq41VPW7CjOQHjCP82nUGybxqXiHYNg+W1k45pVaq3YHPhnUhXOAVzPeFQNUdU2PBPDMSjOGnnrco52RlQQQSaJ13JXOP1A8Hzuhb5kjXRvkA2KGP5nWxQeLzGT1+K3M+k0QZF2CLrMmEo0cYg2a3Y0SC59KUKvhPQRytEEvgIimNEVUQryRl7UiGGOxr0+YjMo520ExA2Y+8g8Mfy/U1q+MaEJ6kzInRarvhIt1sXpAoeSkXbr8eX6N7rFUzFFi1Ru8VhLKUU53bRZSC+fcxqYtM63ZRNxrYCuDdcLK+DDut/DpigNKeUBdhT79DM5+HxInobLwAqfiZiBuKeTiXb1F7i2Y5Wl68/35bUch6qgYSJGF9kKyZMr7VmFW80n5Iyp1cI1QjC9bFCfH/Heau2RyJULOM1jGbDwRxsqqHy4p0Zq4YKN+ZfnYQjAGX0PFl38DeohZ4vtzHmUDp/84CHzrwF2xCBRfDcMO9OesiQIUaRdpawIgKLtqvSoVCXXJ2E04Oi8tufFq3HnRkQo9QsUu8+5uONfKMHlbzIAXzQotJ1faelJ4QDiWbTKIY450vQXVgQFx5DniAV8AT0ZsarK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ad57d5-7cf1-40b2-9c3e-08def84df3ee
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:44:42.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFp6OBghoapgY3Z1t1WtUJYA5tYJniAA0Gh2DYKH4gjYO4mWXutHiM5Sl0DW/46oY6lwHb6s4jGX2arC2VO4FpG4xt6MlN2udU99sWSMHTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR04MB9712

On Aug 06, 2026 / 12:36, Daan De Meyer via B4 Relay wrote:
> From: Daan De Meyer <daan@amutable.com>
> 
> Commit 267ec4d7223a ("loop: fix partition scan race between udev and
> loop_reread_partitions()") stopped disk_force_media_change() from
> setting GD_NEED_PART_SCAN. Besides requesting a rescan, that bit was what
> removed stale partitions on the next open, as bdev_disk_changed() drops
> all partitions before it consults disk_has_partscan().
> 
> nbd_clear_sock_ioctl() relied on that. It zeroes the capacity through
> nbd_bdev_reset(), but nothing removes the partitions of the disconnected
> device anymore. With the default max_part=16 they linger until the next
> connect sets GD_NEED_PART_SCAN again. With max_part=0 nothing ever sets
> it, so they are never removed at all, even though nbd does not set
> GENHD_FL_NO_PART and partitions can therefore still be added with BLKPG.
> 
> Set GD_NEED_PART_SCAN in nbd_clear_sock_ioctl() so the partitions are
> dropped on the next open. Calling bdev_disk_changed() directly is not an
> option as it needs open_mutex, which nbd_open() acquires under
> config_lock.
> 
> Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daan De Meyer <daan@amutable.com>

Daan provided another new, blktests test case to recreate the problem describe
above [*]. I confirmed that the test case failed on v7.2-rc7 kernel, and this
patch avoids the failure.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[*] https://github.com/linux-blktests/blktests/pull/260
