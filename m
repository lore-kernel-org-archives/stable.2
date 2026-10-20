Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792519739;
	b=poa8x+ILgkOc0NuCB1ATOXUiwo90I3D+Lqks794Vu443RqmTFCL4fN/RwZ0ABCV2n3Ow
	 EE8blTHkNU9BeIIPIvNdD8C46LmGyOCfSWsxNJyptBdbUZ6QhFEtpRSxdmrS0Sr40BMhP
	 XTY9cVFjIKo8Sly2xwILXImWg2Syd4xNkeRLKxc8FUii7yT/7uuuinMeb9TcGb8ZRemIA
	 T2I1MpOQs4TLO0WRyX1gV5uIlYqP4f/sNrVopO3MhTHrTLtBWaeDFfHsl66rmIUOoq/Gy
	 TIk3yUa8oQo2jwBX/sGvkindYbjyi/q3DfxUfLhr8MSLlUBHoHJVA8kfTiDNOZZGDrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519739;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=kHNJbrdVpQLh/BfDtgN3dzUfjCezewMPXxmL80KAvoA=;
	b=PaSA+Hk2VBLIbSwdw7NQI0iKf1o3d6asOySCn6onRyKXz0Ea0UB5lzRO4ovn0iMFf3IJ
	 S+rUg8MFvAY8HMy7BFDRIHRLKnfkkE2SZ3a+Z/VD9O9ZGOdNPJaxOFoIhxz00aS8XYY85
	 brzKF5UWwvvcd8CyoBDL6zK6ZfCpPWnwSSC2k+OoxmnIzYrZA1JXPV2FjGZVxYGg9gPMq
	 5Z6kgn+r73abnDEceaX6WE+A6TbYf3xKN8DhmAjO7l7QGqxv1K2MXnPiilZGH0cJGru+H
	 W/DtOb1EO7gxGJ4Z0qe9q7fQPKH+Twp+AYDbCvTr4bL8YC4/LU+zOnvUTlQU7ptsRaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NyVi7WMh;
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77010606A326;
	Tue, 20 Oct 2026 18:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77010606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NyVi7WMh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792519737; x=1824055737;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LR7J0/CsKo8+am5+xMZTgqWl5T4yCG1pDm5sNHO+b9o=;
  b=NyVi7WMhWOIuXxKj0QPpdfBgIebDBANWDAmdB6ukYeMUdplPjEV5C0TH
   utaHJk2yklP5PPArngBlpqNyMgOhD5iACU6navTu3MUbZh0FyHFMeBsA3
   xCpgPCZ15SxUxC+zkgBhfL7+Q2fCstBTTEvXen3eRpgnyMZle4nN8vh9z
   m03bxsd5sWPjhHCetALKisL2OBTyAWZzMcxl95toWRVtPN7yXxpdo0jQ+
   oYwbgrGsIOn/ednDcIX6Fgq/z/ZJeVyYqHCGZ1oU5447YESqIAwNtin2N
   4h+msKOaq5iIAqeoeGk0AYdQt4TEoH3PE+On2pCDbZRzUDXVr0xCryR9F
   g==;
X-CSE-ConnectionGUID: SC0Yq9TCTDGjpeLXBad/QQ==
X-CSE-MsgGUID: ECAiMoMVTK2PruLviJ75oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1105749"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1105749"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:08:56 -0700
X-CSE-ConnectionGUID: +OsST5OJQ/6j+TfPEvGw0A==
X-CSE-MsgGUID: j+XtbVAiQFmAC8rD9ncuCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2770837"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 11:08:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:08:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 11:08:55 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 11:08:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1LRRBiLkqEZZ1ieC0nAXgcV9kZkJHTJ8DtLXr/3+5F87IGgLEO9tQL53SiVeju8rfNm3cRsVhLAII2JHTiwZJl5HTAGJ7KdeDKlW723tYo2pXNz9jBrlptaWxxQfVnyEVXsEm11iRo/krqFiz5j7xs5huAn8n9BuxJoQt1KcHWO1dVlDAPSB7PVf9ulvIPCTVn3Nqq2BOy1WC0bPF/fXmeKBDnASUYvFH06AUey3IGvncFHwCkMNczLHfNR0awETe+GcOu1cbpE7MjME6r4Q35qaQj5ic0yerNEp8UyQ1UTJVUWGQxjXXOyq9XLt4jE57qJYJNl10YXscQ7cRPYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHNJbrdVpQLh/BfDtgN3dzUfjCezewMPXxmL80KAvoA=;
 b=H7H3jRAPCs1bFeUud+LcfV6ZM6M7vT9HW3ChUNJghhD5zI47sCHxfmDwaklSYu69sSMjGOa37VBT2KCTwJLWCf1xPa7DYiBJY8QDHJIDFr8RVZ101Dt7xclyFgrmkHf4vDThl3gzUBxCTBh3M9+lyuo4hiU11oSbqKLz/rr0fqbkF4oYvJAHYapYesZFmFZ4fiyCaQSiftlN72XNm7laDNPtyrlzQaW2AKoBac/9laVmfAUjG4BNvOIhSRjBlp6rCGtx1EfgmooSE0kuLgkF/jDPqqj000+3u5cKjAf/OgKqT5I9v7aAjrm45p3YlPcO4rlo/s8qzVrrZrpXetu/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH0PR11MB8166.namprd11.prod.outlook.com (2603:10b6:610:182::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Tue, 20 Oct 2026 18:08:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 18:08:50 +0000
Date: Tue, 20 Oct 2026 20:08:38 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: Paul Moses <p@1g4.org>, <netdev-bot+sashiko@kernel.org>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <aleksandr.loktionov@intel.com>,
	<avigailx.dahan@intel.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] igc: only strip RX timestamp header from first
 buffer
Message-ID: <ateuJiRnp2hwKmvy@boxer>
References: <20261013010854.4068874-1-p@1g4.org>
 <179194315897.434549.3743742848544230715@kernel.org>
 <Z4u97qIiSB-8nYCRmd03ddR4OFMcrpNVUcTHSoOADzNQcLvQVIQotijZpukYAO4AzV4r6j11nGS_lWTwyh709u_USu516VJmvffbjukcAs0=@1g4.org>
 <20261020170649.GQ503057@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020170649.GQ503057@horms.kernel.org>
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH0PR11MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: aca85081-3357-44d4-106a-08df2ed531ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: D1gV5wo0+nJlripc/pkMideWZzQRfi+3W6ekGDx7ji134K0n6u9HHQ85oqk3rHEyODS0NN7U/eYTvLSTGM586oWQwNYC6dDUiRktt7KAdSzNscHTkDZW+wgj8MS5TKAZJJRToDz0qXu7XE6UYm83vu8ZKrSsMdpzmk1J9+IL3xU4IkU3imQ8XhcOSMAx3z5EVcaXOoubfYlhZWoj6FXCwk+EYDd14kvoJRMWP2Gr7yJWmXZzNDmzhJXA3OAHowEpyLiuxH9XOkiUz6WicZsDhtbKFPzSY8J2GVOdK8FR9cEjWQsmWwWA6DN3kcrTTLmMla4muUyiMLLIX4cn6sunyDZtJw3Rij2zW6VCYRRvGvf+Mzo4XiVjSX0Mc6AhzjB4JBR4qmoSSI/CNG5ekSg7pxHPb9po1Vl1lLYC95Qpfe8e5b7XMHYoWBadfX6fNL3BuFip58WAZWi3ahzE9AZe69wYkPJgi8D7dkeJ8jCVi6KjCXHAK7bBlvlY9E0mDbOxFe1QGK0cCNpZqPqPIW/J3It5qr4bv7wu9ykVAK7NZV5Wd1uQzfszor6p0e6gm01pNdiR0fKBrj+88HZjbLswVgtlmEPP6yCGwx7IXJZjzJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjhYYVdWRkZYbUdoTDRiOWlFMnh4cDdWMGJyQXJuZDJkdTdsV1V4SW5VZmx3?=
 =?utf-8?B?T1pRb2xLMUtPZlF1bXdsaXBzRWVNNnJ1bno0bjhhNUFFYnNBZ0R6YjQ4Zk9n?=
 =?utf-8?B?ZDllSTdJQk02b3RDcm1uL1A3aE56Wml1Z25RQkUvSndhYTVndDcvRlo3dW5n?=
 =?utf-8?B?eW1xQkc4Z0ZmVDc0NWU5Qlh2YTlScTdLR0ZpajB4VUJ5d2p1SmpwWXJnZTFF?=
 =?utf-8?B?b1M0QWROdmNyWmVScTRFYitCODlYK2ZtakVNOHZsTEZleFlQWWVLd21ocFhX?=
 =?utf-8?B?QmxneXlLMUpPV3N2QmY0cWUvL05sclI1T2pLcW9hNlBKOXhWU3AvUmo4SFo4?=
 =?utf-8?B?d2xlTlBJVHlzYTlYZTlTTzJZVXZEQ2pGWVJVcm8zUVJmSW5lTGIwWHBZcmNL?=
 =?utf-8?B?OHBJK0tnRXYvckx6aVJDT1pzYlBOYjBhc3J2N0VJd01oZzIxUVIwdUJqQU41?=
 =?utf-8?B?V1pvU1JpT2EyWEpPcUI2OW9XZUFZdU9Namtva2xJMS9CZ0ovelFhSUs2cmVL?=
 =?utf-8?B?ajhXdGFERlRjWExPZERQK3hWZVRKQ3ZOSXJpdXUrdjBRNElOUUVXVnZCVTRm?=
 =?utf-8?B?NzNaOGg5dGFZaUZDait4VUV4a0U4T1BkTU5WSkpTdDFDWU4rcjN4eXBxNTFh?=
 =?utf-8?B?OS9ReXJKOGxjeXZUN1ZiUkpDODd2SFVOWkFVWCsyd0RERHp3QTVDUHEyY1lT?=
 =?utf-8?B?MU5xSWU1ZVAzQTFrSTNzR2FFWXkwUk9MeklzZXd6MVBENkRiTDFlWkZBTUNU?=
 =?utf-8?B?V3F2Z2VVMnIyZDhhS0RDNWwyN1pBLy84R3c2NWlXazJnWWlOd3dWaFFnMUlC?=
 =?utf-8?B?V3V4TDh6cjJhQ2k1UG1SdWRodW1oSFRKYWJEcTVZMjNHTzAzOXpyZ3BnWjQ4?=
 =?utf-8?B?eGVkblZ1NUNQcW1zZVN3a1NyYkhGRlFGOXQ4YVZZYyttOXQreldqT0wrdm5x?=
 =?utf-8?B?eTFMYkhCaWtwMUlQdEt6Q2VReTV6WGtiYnVQdnAxNFBQN1p2c2tERlFrTXlu?=
 =?utf-8?B?MTRmV1hoWjJEUmVCamtaWE1GZVNrSzNBckNkMEFaSzhjclZXK2xNS1J5bzRx?=
 =?utf-8?B?T09kTm53QzZMRG1tcVlQaERiVk5CYldCUzdlMmU1ZXRoR0xzdS81eXVJNkRS?=
 =?utf-8?B?QnJ6Rmc4eVQ3NnppUCtKbjc4OCtBT0JTcDJZQ3J4N005YjdBR2pPQm44ei9B?=
 =?utf-8?B?NFpBOHF1b1pKcWw1TFFTS1lLSWt6WnJYUXJvVG1zNDhMU1VzWmU2RWExdytU?=
 =?utf-8?B?blRqL2lFTGRXa2FZS1hPRmJJTUEvK2pGY0dsclFBeHVRKytjTnpsbFdyZm15?=
 =?utf-8?B?QkJHaTFJaHp0YnZFWGpwR05KM2FNSHAxV1VoKzllbExEOE5IaUJ5dmQ4TDFu?=
 =?utf-8?B?QUlZaHdBS0dCd2RSMzE0Tm5pKzRQQnJFSHA1SlZjc1JnQk9jTG5CZno4L0hz?=
 =?utf-8?B?OHovbzYwVnhJQkdZZkw5R2xocXgydTRTRlRzc0dESEQxOHNKSnpwcEU4L2Va?=
 =?utf-8?B?WDRSV1VLVGJQbmc1alFob052UTlwN1M3aENhNTgwc1lRZVdMNXNSaDBjaE5T?=
 =?utf-8?B?SjdDNklMcUFZdktGY3YvbFpEMzl4QktpTFNDSGw5aUlqU21PckU4Yndkc29t?=
 =?utf-8?B?RHRlbyt2TFZFUlBoeEdISmdaK2xWNHppMW5tWnhYMVJLOHFHOCtiSjFPZEpS?=
 =?utf-8?B?ZklQWWtYdmxSUy9wV2lNdnJ3Wmhlb2t2a2ptWnMxbWVuYi8rTDByYkZBZ05T?=
 =?utf-8?B?RjNjeCtWbDBXdW40RUNvSE8wWnI1bzl4K3luWktqTHJicllraDhpZm8vMm9P?=
 =?utf-8?B?eWNLMGFHNjFva1loeTBJSGxGRkZwTnFlVGEvZUdyc1cwT2dVelovRlBrZTJW?=
 =?utf-8?B?ZU1YbHJwTGhkeXZjN29VbHUvdUN6TllrSVBOVWR0akdicGVKTTlLZEI4MlFi?=
 =?utf-8?B?K2VtUm9KQStxMjlSL1lNN1RvNnB5K0IrTXdMeUFTVEFNNHBPUWdLc1JlVksv?=
 =?utf-8?B?N0x1NldCSmNPSWt2amphSEFVQ2VZL2h3SERJUy8wcG55UkwwN3B6K0d2MGxM?=
 =?utf-8?B?M3p4VWxjMDkyQWxTNzNrVHJZTHFDYTdxbTRUZ25GVHBqOGdBSzFsM3pQSjNB?=
 =?utf-8?B?NWJaU1FvSCtIU3p0NzkrdUF0NFRJOVMyamk4dEpXVS9NbUgxUXNBM2phQkxj?=
 =?utf-8?B?ZE5jWitmZkhyd1ZucE5GWEhKRWRNcURWSEVXSExaSENXN1FGbFJsSGNkdUlp?=
 =?utf-8?B?ZGZzdDVIaUNVYW8reEVtRWVxTTZqQkdZU1FFWHlkNDBJbzdZbVFNRzRGNlVh?=
 =?utf-8?B?QkJzQUVaK0p2b0RudE9TSzhkQ3NnT2RFOXVQTWNxbVpEMlZCUFhZdU9ZRmpz?=
 =?utf-8?Q?Gi6BgbTqInjtVxmY=3D?=
X-Exchange-RoutingPolicyChecked: WBu1ClaRbRG2PZXJGI1ZMDNXsuPtel2eVY7VyZc8d+5IJ+F9+CzaS6CH7+bD5u3MBTkdEFOLdAm86Gv0F7hFCrMAN8JVJVikGWR7MBiTygOj6uXPQN13BYo59U5mwOTKJpoTH/w0miYXmvzGv9o0opKBwap43AKdIgCFkwWKrUwQCq2Yz2kQG5ZTCLl5jamr04I4SLe7gko6V+B/P0qCto/9ks8SBJ4JKLs02FmKXYvvZB6j4cIoV9vmqM/QpHBk6PXS79+ybq6Oi3sRNgHRqkp6c0Bu0J8DGpH6tdzUoF9Q35Eb+a8rJPrE9LYl/mL3cWedjxy2048q7BQQy+YnTA==
X-MS-Exchange-CrossTenant-Network-Message-Id: aca85081-3357-44d4-106a-08df2ed531ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:08:50.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgXCVyXlJf8d10cgVSmxDXFnVdyokKPjbdC54j8jDzuqjnLXjAvyEG1LAnoMX9S2P1EQ0EmNyJsFRov+xbcKuVPNE6ksm8T23GLot8F6YXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8166
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 06:06:49PM +0100, Simon Horman wrote:
> On Wed, Oct 14, 2026 at 05:43:10AM +0000, Paul Moses wrote:
> > On Tuesday, October 13th, 2026 at 8:59 PM, netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> > 
> > > Thank you for your contribution! Sashiko AI review found 2 potential
> > > issue(s) to consider.
> > > 
> > > Critical: 0 · High: 2 · Medium: 0 · Low: 0
> > > 
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > (one such reply per series is enough).
> > > 
> > > - [High] The patch fixes the TSIP length underflow only in
> > >   igc_clean_rx_irq().
> > > - [High] In igc_clean_rx_irq(), the new condition `if (!skb &&
> > >   igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP))` uses `!skb` to mean…
> > > 
> > > --
> > > 
> > > igc: only strip RX timestamp header from first buffer
> > > 
> > > This patch changes igc_clean_rx_irq() so the 16-byte inline RX timestamp
> > > header is only stripped when no skb is in progress. Before, a continuation
> > > buffer shorter than 16 bytes could underflow the unsigned length and
> > > produce a skb fragment of almost 4 GiB.
> > > 
> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > index 1fb5f3cbe93c5..41b293dc10c3a 100644
> > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > @@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
> > > >
> > > >  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
> > > >
> > > > -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > > +		if (!skb &&
> > > > +		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> > > 
> > > [Severity: High]
> > > Is !skb a reliable first-buffer test when an XDP program is attached?
> > > 
> > > Suppose the XDP program returns a non-PASS verdict (CONSUMED, TX or
> > > REDIRECT) for the first, non-EOP buffer of a multi-descriptor frame. No skb
> > > gets built, and the loop moves on with skb still NULL:

What the heck?

1. This driver does NOT support XDP multi-buffer.
2. XDP programs do NOT run on non-EOP buffers. Usually whole packet is
gathered together *up to* EOP frame and represented via linear xdp_buff
part + frags sitting in tailroom in skb_shared_info.

Hallucination at its best! :D There is still hope for us, humans.

However, the ZC side needs addressing. I would go with data-path fix same
as this patch carries.

The rx frame size issue is real, but let us fix it separately.

Seems like no one has tested igc xsk against 2k chunk size. In this case
indeed for standard MTU we would get fragmented (!) frame. BSIZEPKT value
after 1k division gets round down and HW descriptor will actually hold upt
1024 bytes...

Thanks,
Maciej

> > > 
> > > 		/* fetch next buffer in frame if non-eop */
> > > 		if (igc_is_non_eop(rx_ring, rx_desc))
> > > 			continue;
> > > 
> > > On the next continuation descriptor, !skb is still true, so the TSIP branch
> > > subtracts IGC_TS_HDR_LEN again. If that continuation holds fewer than 16
> > > bytes, size wraps.
> > > 
> > > The wrapped size then goes to xdp_prepare_buff(), and the continuation is
> > > run through XDP as a new frame with data_end before data. On XDP_PASS, both
> > > igc_build_skb() and igc_construct_skb() compute:
> > > 
> > > 	unsigned int size = xdp->data_end - xdp->data;
> > > 
> > > That comes out to about 4 GiB:
> > > 
> > > - igc_build_skb() passes it to __skb_put(). On PAGE_SIZE >= 8192,
> > >   igc_get_rx_frame_truesize() also wraps to a tiny truesize, so
> > >   napi_build_skb() would place skb_shared_info inside the packet data.
> > > - igc_construct_skb() turns it into a fragment of almost 4 GiB. That looks
> > >   like the same corrupted skb the commit message describes.
> > > 
> > > Can this be reached from the wire? On PAGE_SIZE >= 8192, igc_set_rx_mode()
> > > never clamps RLPML:
> > > 
> > > #if (PAGE_SIZE < 8192)
> > > 	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
> > > 		rlpml = IGC_MAX_FRAME_BUILD_SKB;
> > > #endif
> > > 	wr32(IGC_RLPML, rlpml);
> > > 
> > > So the hardware still accepts jumbo frames even though XDP limits the MTU to
> > > 1500, and with XDP the ring uses 3072-byte buffers. A remote frame that
> > > leaves 1 to 15 bytes in the second descriptor would hit this.
> > > 
> > > Would it be safer to track start-of-frame explicitly, or to drop the rest of
> > > the frame's descriptors after a non-PASS verdict? Another option is to
> > > reject size < IGC_TS_HDR_LEN before the subtraction.
> > > 
> > > >  			ctx.rx_ts = pktbuf;
> > > >  			pkt_offset = IGC_TS_HDR_LEN;
> > > >  			size -= IGC_TS_HDR_LEN;
> > > 
> > > [Severity: High]
> > > The same unchecked subtraction is still present in the AF_XDP zero-copy
> > > path. igc_clean_rx_irq_zc() strips the header from every descriptor with
> > > TSIP set. There is no first-buffer gate and no size check:
> > > 
> > > 		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> > > 			ctx->rx_ts = bi->xdp->data;
> > > 
> > > 			bi->xdp->data += IGC_TS_HDR_LEN;
> > > 			...
> > > 			size -= IGC_TS_HDR_LEN;
> > > 		} else {
> > > 			ctx->rx_ts = NULL;
> > > 		}
> > > 
> > > 		bi->xdp->data_end = bi->xdp->data + size;
> > > 
> > > Can zero-copy frames span descriptors at MTU 1500?
> > > igc_configure_rx_ring() programs the XSK frame size through
> > > IGC_SRRCTL_BSIZEPKT(), which is (x) / 1024. With 2048-byte chunks the frame
> > > size is 1792, so the hardware buffer becomes 1 KB.
> > > 
> > > igc_xdp_enable_pool() only checks:
> > > 
> > > 	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
> > > 
> > > That accepts 1792 without allowing for the 1 KB rounding or the 16-byte
> > > inline timestamp, even though the comment there says frames should not
> > > span multiple buffers.
> > > 
> > > On 4K pages RLPML is IGC_MAX_FRAME_BUILD_SKB. A received frame of about
> > > 1009 to 1023 bytes, plus the timestamp header, would leave 1 to 15 bytes in
> > > a second descriptor.
> > > 
> > > The reproduction in the commit message suggests TSIP is set on such
> > > continuation descriptors. If so, size wraps here and data_end ends up about
> > > 4 GiB past the XSK chunk.
> > > 
> > > Wouldn't that let the XDP program's packet bounds checks pass for offsets
> > > past the chunk? On XDP_REDIRECT, it would also report a bogus length to the
> > > XSK socket.
> > > 
> > > Should igc_clean_rx_irq_zc() get a similar fix? Should
> > > igc_xdp_enable_pool() also account for the 1 KB SRRCTL granularity and the
> > > inline timestamp?
> > > 
> > > --
> > > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013010854.4068874-1-p%401g4.org
> > > 
> > 
> > Yes, there's work needed elsewhere, but it's entirely independent of my fix. It's 
> > questionable how much of this is even reachable and if any impact whatsoever. 
> > 
> > Here's what I can reproduce with and without kasan and what my patch fixes. You are on your 
> > own on the rest.
> > 
> > I'm sorry, if only there were more time...
> > 
> > Good luck.
> 
> Hi Paul,
> 
> Thanks a lot for your patch.
> 
> I  do accept that there are some pre-existing issues in the AI-generated
> review that are not strictly related to this patch.
> 
> But I do think that it would be best to make this patch more complete
> in so far as preventing the overrun described by making a wider guard
> for calling igc_test_staterr().
> 
> And including igc_clean_rx_irq_zc() in the fix.
> 
> My slight preference would be for explicitly tracking the first buffer.
> But perhaps that degrades performance.
