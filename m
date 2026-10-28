Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793203115;
	b=JJhe84xDXEg6ydVnCQ91qnCtQ1TpkyZZQW5g0AlxX4YSBfqPvvwftaQUBZ3zoVYBibfW
	 YfpDiFsaP98lcseaFTl3A/eLy6i46lINf+xyVeg0OWR33PY1SHMJyPQ0RdvzRLNCWJJAX
	 vevLjYofOY1cWEJR6fPFxj/ouHf3JLj8ie/NSevClh+eXuRjN8ouQtxnJrJTrKbpA2WHS
	 wPbsZk3llZ6HOEku5yND46AlnIu1Bc4jYFq0yrULgEQXV487iEyei8p2DOGmSxliIrNM5
	 pkhN7VcmGoZPFY8IQyKkGZjIWMHEc9vXlnYYabxu8GWYottyS0igbT02T8ZO/im9E1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203115;
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
	bh=rYjcGfHcGR2ceUKHkFl8X8fTkuun/00KDqBWt5UDvHs=;
	b=PnxRHmLkqG3P+qbnHyydhI5XnE7I7jd7jDV8ELjbShSgWIyoFIH2JYevCyLpXOSUPR+e
	 TVFIs7ERWs/gaZmtF07m/4bQq2lpMXlFDO8+vXTiNrcAHRylLpakNRaMPe2pjx2/K96y3
	 lh3VgH02P2v46/I0Z5JVm9RncMVA+73AKWdGWb44pd+mM0DW/ZpWN4a+23P1s3a9EfjAL
	 uOIK+pD7y1h613ZbKJrkTvi9q8JTQZgcs7NZj++u+r9LJLaULvuUpWXaWoHip5tKoktyi
	 oU+2N74wFsRlzh0SLM1Y/RrdROzE80L+e8fdCJqq28AFkIr5aFScJtdJ2jbS3MTqmhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=imMbMAH7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C44606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C44606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=imMbMAH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793203114; x=1824739114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6+1nAA+478pbrjDTlVyR2zYkx7epWlaghDbNzi5FKo=;
  b=imMbMAH737tXBMT9AgjNqiB0qXGqhObJ/NhZT24UCa+TPYBCcvwqQed+
   AJryvdo4833ESZPw4acYZYd38Ugv/ucDu2NH1eZG4xXYLPaeKvmC9HBA6
   AhRygEo9cXrO6Wnr2MbDo3AIyqyZSJk2Pmbr1KxbbwTzb7V54SYzMi7Fv
   29ln0jTndyVkoirl9m51DWzeL5s3yekOOfAmKBc/Nc6PlR/U13w7hNyS+
   EHdJn2PHeS0wVjfmsJdXyMob2ZOImQbqqqb+r6/IKVEdzuWPjghuz+4OH
   mNXre1cAGGqZQ7GFIclr+olLvL/O+GUlbyDWcAh/Bbkr2gl5Y9tYp5db1
   Q==;
X-CSE-ConnectionGUID: YQJqj+R0TAOpsnq1zE5jsw==
X-CSE-MsgGUID: J/fEP2F0TJiT34BKYZE5RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1807786"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1807786"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:58:33 -0700
X-CSE-ConnectionGUID: 58FqPNDJRBqC9m2mjMmebg==
X-CSE-MsgGUID: yYp/ExhDSDyRo/+oVEvS7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6716907"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:58:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 08:58:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 08:58:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.52) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 08:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh8XCdSc+OcBlfIBc64Meu5OB6M+MEvqmpnZlzh+I+3nF3NJgLzbpJkTICZaLPtFQBAS6RWKm2DhjO03QQZGJaHwgGj+GUOf+IqkzDwfIZAzWfat3GgV0/ThQ5+ggy7KdOqK8yBGySInorWeCgIcVrVIp7Nn1GBVpgltiXrPk4rlkyr1jo+X4skIRSImSBfTgTR2n2qYe6Fb6Ayu52dA+JT+MI945crZNsMThBZbnyEU79SRGa+J1yh7WtnujogdOFTV1WqsGRtbe5T93qThFFEJjyr4ueV/xC+zSrI3V+oSA8rvND58u4rlnpW/jt0ujLaZ5SBSJrs/vVauIbxTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYjcGfHcGR2ceUKHkFl8X8fTkuun/00KDqBWt5UDvHs=;
 b=CikZnfsqmt6h1KpSVFTXqZnnYpIK4oxRnMVYWGwNlu5h16PI+N3J/68AhwlaumJHqfdLYRwr3POoRDfA1aI7tsm5MTk9Hy1VkOBrqjPGVOkls4J1POsMm2BVcv9Wt1xiHa3Vd4OllmnBNOb05cNEXrVFd31tA3BiE8Wv6NDYxoTlC/mFT5oY8bznidRlxKXBCyVgUj0BQsjUT7kTEg5VOsOnuFZGIS1RAjQQEjjAuu5JLlZhves4CheDWAvn86l56Jq2bqt9TXniXX0fzp5Aqzaec90OZp2c6ncx+p/icM34n67e44V1obgMciwSjqeSVzVP4oSDzQuEaDsaou49CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:58:29 +0000
Received: from SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0]) by SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:58:28 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on WCL
Thread-Topic: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on WCL
Thread-Index: AQHdZqvzQW1+UCGndU6+uh1C8duaubcTG0jw
Date: Wed, 28 Oct 2026 15:58:28 +0000
Message-ID: <SA1PR11MB8253464494AEA3E4C79FFDC9896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-2-vidya.srinivas@intel.com>
In-Reply-To: <20261028070404.1913843-2-vidya.srinivas@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8253:EE_|PH8PR11MB7070:EE_
x-ms-office365-filtering-correlation-id: 9b108383-9684-488f-4af1-08df350c4ec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|261021121427099003|261009223027099003|261021123027099003|38070700021|260925022911599003|260925021311599003|260925021911599003;
x-microsoft-antispam-message-info: RSarkMUhcBqiajcgHmvLBk2M9+9z6EKHNqkA5c1vZ7OMh34UmKwDA6bChXy6xOHqyyUVLTxMZE+QEvNZOVHy1XI0ysSKyBa4KxR8C8PKTdLxFU4gXD+/gBuSP6hNU+3133oXhU6u5R75x7SMQC9/r4iJRg4mwMwWtv1GonTbdH4xj+pBHFaA8NYlW4UIvP745xtmmx4YQ3F5wFcSJ32JDJgtTzDQKzqBhw6MqiaN2stLB9CbJmpWiZshvcFjqumZsxNDOyXwEBZKfEaXHRhmvgouO/eJMbwLiIyv9MP6OATicmA3uyQoV/LUpeJNmCgbHfGnAsYOnyGLzCFLAeXRT6TyZ1zViSp0coGek3pwyRP4BreoC+WR0epQ7yDLTrIDXE45lOZLsOSZyPLr8BISQJYW5jGRGOeQT8x/fal4V7ElWuyKuNSQCGAGZXbwl/C6WIWgqRmc0QTwAYnM58ifEmJtVbs8ZuO0s4ukaOnUSo99nti2fjM+LRwu4wV5kC0J0i8SUfKmBHuHPaFX2ycpAAQUgB8se8NMynk3PayWGCleN8+9mtJ7N9RhfLL3W3pV0HQhGaWY1wVLP4pedirJ0mf9lhiovVmWC4/lX6ptEq8ytB/RA6LTf606J3OJk2DQNPSYweZfXaieILBJCvjm1KUNIslkb3N3T0x1g+AhIIdbKI/vRy7CCaMLanxWt/+nifOzJUnFwksCYvAfEXHr5nV6zaV6T6KserchRfDPUA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021121427099003)(261009223027099003)(261021123027099003)(38070700021)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zKmfrddZyxNOfpCG1/zdZMZof3Q7QCRkSk0nEF911hlMWO5CAIVKf+sirmHL?=
 =?us-ascii?Q?OJe78rz25VsJ8osOuFfbsT29HK+7ZdSfBHxCdZkzsr1aDaejtRZGVnMZPfO7?=
 =?us-ascii?Q?X4Ffn08GCHPrhK74ZdqP5fcgYUnE5HhDFMCpucZ3ypsg4fgoI6QjBcsH+sRZ?=
 =?us-ascii?Q?IyiEhZqbCyWqikT54vpgX8IYKKgpR1FbwQWj4zC4+2+IVvpyUTXdvziUaQVz?=
 =?us-ascii?Q?Qj2LJ2axQPGLgxHwmumTIjTz+Ku+gJmrHtIWlENaQB3OvzkNqr4LVkqovfpY?=
 =?us-ascii?Q?TWvReqEe6deh+YgIEetZXYJ10KAgnAGrAIFtHJCh0+H/zv6As5BA3OWyn82p?=
 =?us-ascii?Q?h5Yfoh+1Zq1tuVOH6zVD2Xiz1ArXFmf5iaCvvjIMlVmqY3Uv4ywQbfxs2sB3?=
 =?us-ascii?Q?Ix978ciikX97EdPE+sCZ/mV9qPlVyRBb6FGfjb5qaaFMKTRrxerSBiPckU9b?=
 =?us-ascii?Q?v6TEYSjcMdhn66dt7t3yzRZI7P6MFp459mh7NZXx0b2ajOyi2oDWfo7YGMa3?=
 =?us-ascii?Q?EYQAQ9dAxwwg6caVC/Oa0/RnLMSaqtRPtpnzTGna3rTuq980NwIq85P0izyz?=
 =?us-ascii?Q?E4vp+brbDiXWB/eltvrPMrhfq9c9TDUAvHDX1ifQDGuMFMLf1IwprDz1otJw?=
 =?us-ascii?Q?c7izaXSwJ6IoHIwAEw7wKPketF5WGbP7fWRgwO/Z/rC9somZvXxSW4SOZg8X?=
 =?us-ascii?Q?dpqtWCU/ZA3oR4bCvvzCHoTIr2xhOkJKAz039mQBOtyXeMgOpKhkzYMIXg4b?=
 =?us-ascii?Q?5x2ufbmVdCLFzUFNDDdazOH5BUYIk0yzVQzh76Rb0ZNorUxuz2F2qfXrVX0B?=
 =?us-ascii?Q?b5Yhl0fPWbORdjX7jVB5v6AkXddbTF69WywqmfZ5ayA0U66T0DxrO2JL7wXj?=
 =?us-ascii?Q?hTGpyhSOW4uhKy9UpTy02+TgjZ8uvu81D7fKtHVxGnaPXHwd1H4UGPfR3mcT?=
 =?us-ascii?Q?8NWL4hO27SQsrB2CHkJOICiKOsO6FRu76NgPMxWFUJBcioYJYtlV9VdDrzdh?=
 =?us-ascii?Q?dbveKKZ0TBBnzUGJI2qg+aOzyGB4rcMxaESb+IMnOXmp+ExvpKwg3ASr0MH5?=
 =?us-ascii?Q?MparTtRy3RhT9QfZ1qRcYn5nBCXvVxOR09EjQL8oca6UZvDkkjDCmaxSElNR?=
 =?us-ascii?Q?FZT2Xu2Y0ogMKBk3atwIUkXCtQQkL8hYp6PDurDg8eLojOxBrAOrdtIwpDMV?=
 =?us-ascii?Q?ZqFcm0DvfTVeegfSgHI323mudpKI81R35M1BS3QkL1X0rvTmxdWKtyo1bX/c?=
 =?us-ascii?Q?UoRodIVD3V8I3ntUKZAJAhZk2I5OdODwa78Z2Y37q+Quw281MMj3nX9YUheE?=
 =?us-ascii?Q?YlbgOUGayctcfcnJ5JhMCfJzwlT5VDUeyky6ngOHCHQLiiXkSm7ekG7PwztE?=
 =?us-ascii?Q?RHrwtcB/YBZv59BWca4qoxIRiE/ipDALuWQr6aCDUggmRU0vIZ4PjczI5+Q6?=
 =?us-ascii?Q?oZFIs6d2W8b0qjCXUD7cZGWTJJf8ab8MgLghjMY9B6gUgZMQAGW+NfQMAdht?=
 =?us-ascii?Q?luptYFXpI6EhnUU7I51hkZVzqbnaOfPesecR0skKsWH1oRPN+xtR4dZhl89A?=
 =?us-ascii?Q?sJ8U+Z89BY0R1m0T7JgX5zDG7KOfXOiwhmlp14EqP2waIQ+C88/ABifs8Cto?=
 =?us-ascii?Q?cQ/1gbA72eodl6ieHSdkw1+3ym0Mt14BsL4yeXlAvsHlp4IWFe7jbdoy2C9d?=
 =?us-ascii?Q?GzUIVvr+YMBVcmXJHhJ1/9BjeZb2+cpIVvUY4VQLilnTgI83e3vtrWxlUOfY?=
 =?us-ascii?Q?G5b8jfMxxA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: ONn8Ff2rjdAAwJ5yZy2i+48MK1yMRCJB7Lo6EYvPqrfWn62QdIOdCaWCj3v2i45+H15xHV+0pd9SvI5kOTiVZm7NS4Y6mYuSfB1CqutrKY3FtDdP+OTd+H3/Qdl62vnDvn3ANZyIV13KCzIsU12Yt78gT32M4CJAwUK34zLtrRDRuRVX9G8T272RBXUihH3Px0Rb07EyFv/gYljZRE5qRFnzyPuxfINUH22GPkUmZQ5nAIcqeb6qk+T8mR9p/08cqsoclQ69ZyuHuLwTPAgv1WWN6DjGf0cWVkX7+acO9EjvNzgbNjL/eGLibgyIApaay5GPNuEelOcgNqxpBJhpLQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8253.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b108383-9684-488f-4af1-08df350c4ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 15:58:28.6957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wod1ypEUNaXp0YtDi/KW36fQe2qBUUfTdm30Ko/Xn8I5Gunlq6gumsEuI5GIb+gT7s1Px9v7qm0sg1DSmyMOH1mZkIRS/9Xz3zidtup/JCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Srinivas, Vidya <vidya.srinivas@intel.com>
> Sent: 28 October 2026 12:34
> To: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Srinivas, Vidya
> <vidya.srinivas@intel.com>; Lin, Charlton <charlton.lin@intel.com>
> Subject: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on WCL
>=20
> WCL has only one scaler per pipe. Set num_scalers to 1 for WCL.
>=20
> v2: Rebase onto latest upstream
> v3: Fix up the commit message
> v4: Split the scaler and joiner changes into separate patches (Jani)

Adding fixes tag:
Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")

>=20
> Bspec: 74286
> Cc: stable@vger.kernel.org
> Suggested-by: Charlton Lin <charlton.lin@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c
> b/drivers/gpu/drm/i915/display/intel_display_device.c
> index f17fc2c68472..c74256359c25 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> @@ -1813,7 +1813,10 @@ static void
> __intel_display_device_info_runtime_init(struct intel_display *displ
>  	if (intel_display_wa(display, INTEL_DISPLAY_WA_14011765242))
>  		for_each_pipe(display, pipe)
>  			display_runtime->num_scalers[pipe] =3D 0;
> -	else if (DISPLAY_VER(display) >=3D 11) {
> +	else if (DISPLAY_VERx100(display) =3D=3D 3002) {
> +		for_each_pipe(display, pipe)
> +			display_runtime->num_scalers[pipe] =3D 1;
> +	} else if (DISPLAY_VER(display) >=3D 11) {
>  		for_each_pipe(display, pipe)
>  			display_runtime->num_scalers[pipe] =3D 2;
>  	} else if (DISPLAY_VER(display) >=3D 9) {
> --
> 2.45.2

