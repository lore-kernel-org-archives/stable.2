Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793365797;
	b=BoIlkeTpqE2kigi9AsQQn74HOz1jBcuR3mekHv/+t9auEORHN8+nMWOVjxUpLkM0C3KO
	 Te1HO2q0VM8yF5scfuTsvAJgyenl9fhC/EG/TZM4fggvrUyONuVzXNmMHZ2iN036WrKz5
	 x31GopVcCdMvUwjm2c1Yhdf9BKz5K1g1uKM1hwmBWoiD25TexIQ+HRqibS6lKYaHUQUW6
	 OpJaIqUJuIcgey6YaCaQhzzrOInVTe0eO5MyWLuSapphZl/oHY7/LvFuBFWNDHvlzceW2
	 nOQPr7i/sPN6jcL1w7QH1WmxA8x1fgor20k93pWbH0mGTEGr0c0bwl6L9/6E3mJS7JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ElIOgGjfucEqUYnS93c67Ee64HPyvVL7l/fh2yCUC9U=;
	b=SlGMS+tMIa61a8OguU57atvVavu/Y11qXB3gTsmDYRly+Iefn/uNy4SqhxKhJYN5TX9Q
	 nQczdSsTM3NptakOGoUBPs+QMeyLQ/IGQeDsn6XuREf5GfnNuko3nMka5HNGNHm/pnxN1
	 1l+9W2HZub1qjL7gAjyIP8l6kcM2626QA8Txv2u6wxzqp0T6RO/CuZwvyRCb467Ys/6Rf
	 mijW6Wo2Frajzegn05HvK/AQEyJDMtJhgE53ede+w8XxsTQUyorkxRDgARyJ1yEPTdG6s
	 DfURkhF3AlXtWxJeV/VUCJ6d9IGytVqew+mdu+9pM00VwKzhag7JAYsrEdOVcLXsK2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gu2CfEcE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E1606A31C;
	Fri, 30 Oct 2026 13:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gu2CfEcE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793365796; x=1824901796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AQu62rxel7FKsV2Cm7tIQfOoWTpuBQQCIaeFjLGhqx0=;
  b=gu2CfEcEXf19JqgfyfgTa1uFjT3UcdPLV+hxbXmjGA0YrHLJVUJjJpNA
   ZGj5oARgoTSpsLNrDXn7BTUn8t3rp6Q6yaGH5j1Us/OYb48QqQbnDPmV/
   TXHwwf3SbEvqQGU7Kio+ogwK3CMN+JPXMUDG3FEii8Pbl2Z+egzDCw+Sv
   71mC5cNI6ZXm5ds87ojkwcjEtNC4F2iP9AZdQpsCsxoo3rtntE1NO+b7m
   OVFMci7Hj2uzgcsi7WSdG/jPxlgT2+lUuov5jGMwYCFb9IDhfMLpgcM5Y
   RIBu3lQaVMFm88aoaLlVJNX5ddzoWJX76UD08PKMhljl9ERxOYukAdbTM
   A==;
X-CSE-ConnectionGUID: NLBeuNwoQjebYhh4EW3LzQ==
X-CSE-MsgGUID: BN91Vo67SI6lsmUlP+Cgpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2131646"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2131646"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 06:09:55 -0700
X-CSE-ConnectionGUID: SUTXyMuKQ5yR5iugt26t4g==
X-CSE-MsgGUID: inPLDnFcR4iYosUDGR6m0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5325120"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 06:09:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 06:09:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 06:09:54 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 06:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etcf5VpW0SsVCtFjh4Hm+FBv+BvHN3tw7HlorgIUne+sX9wc6RnLropv00MiLM23q2PpkoyMKVTtmEjvsfkbSUf89NKkQfnegzLuRM3aT7SfklTzzLgbkNMyYw3ddklR4xbJ2/B1AUX+Ar0oHmsKOB8C/HMHvi2bpcILkez8PqPiZa11oHqgN8FepST5oVR5IfrtZpEzsVAbcFLEIVe0Od/Mx+SIajgp5aWQ+2+E4X2Ciy17/xvil0xjFcbQCGJBwR+tO85ON/zu/jhY+hzXumOIiMx3ILVIph/geyaGEawS/3eKdwukcc5e8TZuFQu4enpSIMha1B5LqGIFETBipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElIOgGjfucEqUYnS93c67Ee64HPyvVL7l/fh2yCUC9U=;
 b=czfifjZkvK9ZK1PTh5+RHlyVzDfH+MeWVnyqr0U7HSOEICkjefSWkJRlEfXZFWUjrZotyT+i5TCAa0TW797vhUJiexf3NjVHfUfGsl3evAaZm2q+aoElaLZjjlrYXfCYJFEYitm8y1rs3RxugsWtzbls7IVr7ZEgdzA2kthRxdvOjesOXulv5kWIr1PM1M9iS5whc7pQkx4BjujPHNxvtyYcsLcn9z5uRSYCR2F4mY/6GALURv2n8VE+u9od7KkapnG2UAEFD95MtdboqG4wk9bBPMW5dGfGzjibzo2csBR3OUZ1BW2wEnBfRzw5ZsZ/EJZPLNrjWenok6BpYZWxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 13:09:49 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::3df:33f9:59a1:da76%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 13:09:49 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Peter
 Ujfalusi" <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, Kai
 Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul
	<vkoul@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	"sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA
 before closing BPT streams
Thread-Topic: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA
 before closing BPT streams
Thread-Index: AQHdaF+YJxcgxNjp7kyZtRsplXNn/rcWC/KQ
Date: Fri, 30 Oct 2026 13:09:49 +0000
Message-ID: <SJ2PR11MB84246B5E80CB20D56D247AE8FF6D2@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-6-lee@kernel.org>
In-Reply-To: <20261030104840.3361217-6-lee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|SN7PR11MB6947:EE_
x-ms-office365-filtering-correlation-id: 12fe19f1-88ed-4d4c-c09d-08df368713f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|6133799003|18002099003|22082099003|921020|38070700021|11063799006|5023799004|56012099006|4143699003|261022105027099003|261021121427099003|10067099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003;
x-microsoft-antispam-message-info: PtH7ElgEfO3K/pl+qOhTlqjuptMC5VQEbl4OCfHovR2CL6KCi2xqy98szqiUkKzHjACpbUo4+tYH6U3HTqQbsK8YH8sVtkHg/5NFbRnsura5bTo3/yHu60Mq/ni6wkAX3cfXc7WcIiyReS8aKBwsAMQmoauowJe6rxrDmxuWJviD1ogoFTeg08Fm8Zmpynu/HE+CeHSaWIqKnMBxX8txo0ihk6jSwj6XTIxQGOLO5ZKCXom4NMwJNst1sWWWpN1MI4w3XtJDAlTyCTpu5FT3bbYhXZklwDiob0wvgGdjBEI1FV0UseDEhJnLeVBZEvEPdTJUJU1CPYYhhAt4JaYjdmWzVQ/42f7TgzkfapgDlCUNtZIM3v6OadcER2V50ZULBzWoUd26DTTokUGcexjtFomuuatazfLHOpmbmUpz8VP16+Z2POVOH6kEoba88gGlA5uVIdBcu/Oiex7HP3cxM8a/6u/DoevReZ5XHBgQefwdqh8YQZH5QuVaBlVpQUwIhuF5BI33ca3j5veNgTp3VNuLiOrdVAzz2yuGF8eY2ZWJmWNF/6hmD1o/ikUhzYDQQslJUfu15XjKGEuBxAHC77lQLxuc9HN0QMFtH3pNKscahMfTEM8Hw4BN0+tyEU3sAkqzTUFngvhG5DzM0nr0L9Ro5q2JEsjGnVx/oxcybjWPpZwmtKVzu6jxDux1G0lx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(921020)(38070700021)(11063799006)(5023799004)(56012099006)(4143699003)(261022105027099003)(261021121427099003)(10067099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8w4EhTGR4LZYAyIL+jNopH/wWp6li9jHb1hdl8hFvmSMBFru6N6MCox92tnS?=
 =?us-ascii?Q?/hvQIn0tV5hpAcAPeeskWjASsTx0y9S8qZpwSk1xRkksXrpM3nafvyv5Uy6v?=
 =?us-ascii?Q?7Dwg2L6gjRkTnfxxUDIa5o94uZcuynVCdgxhUGrt0A3V2YFEi1gRC7/b/iqC?=
 =?us-ascii?Q?1zOSTyPfRUMK2M5aY+UIyUtCzsXafWEF0QMD99wIdubNlgBxW/911Hjj22iT?=
 =?us-ascii?Q?tYie7ymhpEd2NdVqbYAWLjzVhIwx6tI8wAOpSP5Do4y3LdxG8WME/G5eklRH?=
 =?us-ascii?Q?FCsmvbtod5ZzysMEL4tq1JzxFwM1AKBVUVOt0us9Jir380ZQE5sZy9R7NYbo?=
 =?us-ascii?Q?qtvHjS5YoSE1nU6AZJZs4apJ2tcYCp7XJnFWOoV9ltIRrOuuDM2icI2AkUgd?=
 =?us-ascii?Q?9uLv0RxmPf3fQU6yvGvbFjb+1l7W47tsddBoyMnbKbFGFFB4oYUKHFT7NIaw?=
 =?us-ascii?Q?fTR5SKIO3Nl6YfL24hJfdGnvIp2nyepvzwuVr7lcfuXs+AJtgoQaCMj3NsjU?=
 =?us-ascii?Q?dkDwgzoPrWAAlRuqz0capaiRxwrPs/w5b1dU9KRWioFAuYE8pbPpSHufOdPx?=
 =?us-ascii?Q?hN81kbsdnSwbs1AgliuAGBoPLTYydZbr1NJc5fwrBGaFt4uJT5aVjKFVIlo6?=
 =?us-ascii?Q?se+9o+1QwZSdSnzE6jDI/GCiH/WRLscbx4MQGegsOedpp32+roujqW4uKMw8?=
 =?us-ascii?Q?spPvb5jCWmRRb79hka6gy3gHhYsuaETi8f938U/iqzzwfzt+HUo1uH6Phx7m?=
 =?us-ascii?Q?4DAfJZIwo3VjbQnEAnbLJtnqbGUsTemxuP6WX8smSTif4hafzr1ZYUNvjFiR?=
 =?us-ascii?Q?O+FuJkYR5dJciN8+A+O2oCtsg1gzmBZdGm33AgbSxnJvonCm92rmp/oQj1rC?=
 =?us-ascii?Q?pMWoC0wOFzprE1sk5uuKQBzDq557xCQFtl0PIW3X1Q36aCo1u4joX3fBocVv?=
 =?us-ascii?Q?tKzNQbshQIPyyoTjHRviNecXd6jPceOH22Y9rJ96TZwG7lsRnAvCVapf1eWL?=
 =?us-ascii?Q?hpfDz1PmXtyLEX/aCzITo/jBE5/4+LlYKEKiEqgLXDzLwA4qBHuHdXuTAKha?=
 =?us-ascii?Q?mXfgSmpb8GjM58TLYAcKcPJMW2qPZHNkzI5EwRxZbmuhwd6THSLokGRoQt0s?=
 =?us-ascii?Q?BupMZ8ouobjgo/AMvLdW8Evd/7Zbf53kVcKUjisGNLVZsj/cSie5d+RVRa6W?=
 =?us-ascii?Q?TVRQcU6cqJGaNImWKnh4GhXmlmy4Q0KOQs2oWVK0MrEmbuVFLYZtuHDU9bk3?=
 =?us-ascii?Q?X45rPZ6FoY9yNYubxfQR0CnUj+JxEbyE3SxpQdLjg3ZIViqBBw2TJeUwfQLe?=
 =?us-ascii?Q?r9uxKAfKuy/qaCgE//5RTlSFtpglpw24gACYSK80+cKHgW6SxkewrpFtTykN?=
 =?us-ascii?Q?W1DJYgnycqtqtRbpEGEL13keGlc7Ej0j7yhW/TdYLe5l2InZIUrcxc3YcrGm?=
 =?us-ascii?Q?e+VLZ9ou07BhAhcVRQWhxLyyd0FLahd50MYlJrWrlXJ56WnAr3XU/VNYQbxA?=
 =?us-ascii?Q?vpBKHGatA9rKyBRG3cb0u59DZBcWSX/Cx6uttpFSWDe8tQru3U0kZA1xKQ1e?=
 =?us-ascii?Q?dzR6hkGnmtgYct4CNwEmNk9h/wYrAKoHvPA+8pThaFcbluTu4h7Kh7mEsbXy?=
 =?us-ascii?Q?m1Qpyy3TzGdvG64p5AYm8ewQYr2KGT55y4SOTP1eQzxljuZjiP4HFIH//QGl?=
 =?us-ascii?Q?cegQc8x9QD7MoSr3QGUGYs/XKX8KjoFACwtVhcl/joKcMDCo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QobgyI4sGjmlWTDMU8r3oyRgY0+3yNk3LHyD3vVO4GLykKBoEJSNofet/seFuGeilR9mBaP1beTwobwWYBs2K/+C1bGUiQaZLV1psjQtbXQC/mBedPBxBm/OA0I8yQ8JCnRo9T49w1dahafWQwBnn5JflJEmo+yvgriWgGEdZKwH/aCo8nngbHYusk5RIfVBMw/16dVf/BNvTrXZnUL/7tRASAt9k8QQPYPDzruafJjP/0u7l4ljpeD4DnVgyiEn38qiSA1GIdIPLTbzhxi9VwZFeWcLBXQhtRr52B0cBFk9UcknhV0G1QRdURN09xAlv90MHKsaUQBDND+bXksUAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fe19f1-88ed-4d4c-c09d-08df368713f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 13:09:49.3063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsozeJ7kZ9UrA77LrcvlS0+6znAPDDfiobBv+iyb5JQtrsXKdkcT85c8cYVhXLa/gh7E71o9DFWrR3bZbDpwJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Lee Jones <lee@kernel.org>
> Sent: Friday, October 30, 2026 6:47 PM
> To: lee@kernel.org; Liam Girdwood <lgirdwood@gmail.com>; Peter Ujfalusi
> <peter.ujfalusi@linux.intel.com>; Bard Liao <yung-chuan.liao@linux.intel.=
com>;
> Daniel Baluta <daniel.baluta@nxp.com>; Kai Vehmanen
> <kai.vehmanen@linux.intel.com>; Pierre-Louis Bossart <pierre-
> louis.bossart@linux.dev>; Vijendar Mukunda <Vijendar.Mukunda@amd.com>;
> Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>; Takash=
i
> Iwai <tiwai@suse.com>; Vinod Koul <vkoul@kernel.org>; Ranjani Sridharan
> <ranjani.sridharan@linux.intel.com>; sound-open-firmware@alsa-project.org=
;
> linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA bef=
ore
> closing BPT streams
>=20
> When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
> hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
> intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
> without calling hda_sdw_bpt_wait().  As a result,
> hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
> the DMA hardware is still running.
>=20
> Disable any running TX or RX BPT DMA stream at the start of
> hda_sdw_bpt_close() before unmapping channels and depreparing DMA
> resources.
>=20
> Fixes: 4c1ce9f37d8a ("soundwire: intel_ace2x: add BPT send_async/wait
> callbacks")
> Closes: https://sashiko.dev/#/bug/linux-ff0012de-abdd-4796-875e-b1fbbf472=
35f
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  sound/soc/sof/intel/hda-sdw-bpt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-=
sdw-
> bpt.c
> index ba9fbd662b85..9d97d8676251 100644
> --- a/sound/soc/sof/intel/hda-sdw-bpt.c
> +++ b/sound/soc/sof/intel/hda-sdw-bpt.c
> @@ -456,6 +456,12 @@ int hda_sdw_bpt_close(struct device *dev, int link_i=
d,
> struct hdac_ext_stream *b
>  	int ret;
>  	int ret1;
>=20
> +	if (bpt_rx_stream && hdac_stream(bpt_rx_stream)->running)

bpt_rx_stream and bpt_tx_stream will never be NULL. The current code
doesn't test it, too.

> +		hda_sdw_bpt_dma_disable(dev, bpt_rx_stream);
> +
> +	if (bpt_tx_stream && hdac_stream(bpt_tx_stream)->running)
> +		hda_sdw_bpt_dma_disable(dev, bpt_tx_stream);
> +
>  	/*
>  	 * In the case of SoundWire we need to reset the PCMSyCM registers.
>  	 * Need to continue depreparing the DMA buffers even if this fails.
> --
> 2.56.0.317.g454f8302e1-goog
>=20

