Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6613EBF33
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407462; cv=fail; b=LLznJvyKwprYJASQxWJNeIFjbyb11APtkZ/tU/0tukDl7TN7qiVHWmYolv/h2bpjyFYwBt00l+d/0VM2OVL896Z28bFIgnHUp+7es2qqJK9iroQFdGgYdiy44wrLLS+utDHcZlA9h3SjG+DWmOtNKkGC8HDRLJdCBziGguC8KTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407462; c=relaxed/simple;
	bh=weCY/0YjMf7GI6SKle3l9T140je0ZEvE7engF4p7txQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XyeGeXobl9ckQokcWJ/NToo30JgPsfnfomK3kVX5IcR1jRgdKLD9k8ghrq/5/kc7gyoB4WZXHJPf6cI1axDRUPgd3Tx46+yzVs0siBMj/ajoJAuXkqz8q7PlCfT07U2pgb/k2Te0e3ud3f/aU6seZRmRjiAohKuH8yqlUz2Jlaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCP5wdmN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCP5wdmN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782407459; x=1813943459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=weCY/0YjMf7GI6SKle3l9T140je0ZEvE7engF4p7txQ=;
  b=ZCP5wdmNNdhEg4YA1uWoWFwVFQp489KboAkCDCWo0/LoatQV+TKxG1Cr
   NExIcWxkHxJ8QH3FuiYJU/c8vsMLQl0amfKzKUuzqH62hDqRAMHKN2aNs
   uPgVtKb+vD6KGZhTF+SYsHNPrt8hb03zMUDy5VWyFWC6elvsyg7N4NSjh
   oWW5msgDastdgtKjhk3SxQTlNmjn+JSy2Q05pLlKxJNMe1+wBHCsrEuB/
   oTUNUrAZasf18yuG5Pe81GOBq361amQMKWTDupMJiXiNcUkJ0FpVfaHFh
   9PihvJHFmkZ1AFsKYVwqgqWicBs3xDwq3gSVHb2m6DFVIhyhiVJkL2Ryx
   Q==;
X-CSE-ConnectionGUID: b2u5xcvxQ8GRI5YuWpGkAw==
X-CSE-MsgGUID: 5oBHzoF1SQWAseja24xPQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="100616040"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="100616040"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:10:58 -0700
X-CSE-ConnectionGUID: QJGz377sRhuppjDwDzaWog==
X-CSE-MsgGUID: EK/OedNfT5OeFxoMGpcr0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="248270463"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 10:10:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 10:10:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 10:10:57 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 10:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ+GUQFwyfW4yae2bjrGS+Bdsxvn8atebAjtg2DfQwGIX9nYUv0GyyAzi8tKssiWqS6H6Vp0riWlhVvAK+Vkum/HgRLdCQq3HQPTQdOdpEvuCssdCAGZgY1BCAlfxfrf7HBO1X0di0zOpipBKShEWz9wjMXcD0269Rsz+Zxfc3XmbPDHeA4mcDXWJf4hiA7ix4/GLUp2N8nBWQcsk6kco73oYUzUwH7PvoqLA3eMmVN8ZoU44Jws/M+zppTgXByfXOXfVpKaBCYXvaB4giybqGqnir8WF8FHjjVFvcOcFGfEpvxjiP77EHOH4dEcBPARC1Hql20n80xv+OeeEEC4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weCY/0YjMf7GI6SKle3l9T140je0ZEvE7engF4p7txQ=;
 b=ckpq/xc+WqDt45xOJbJajv4qe8/83iw1WXkg53tSpiRNh6Ztg9ZyW6VXOTc3cDzxcSPz+FBE3qHR4TGtv5k8l075MupmCBYowvoLPsX//357BRgyY4hnIC0Joxyip/G8+DX9FXJp0B2W3221agL0ffSccSjf6K3qE2rGpzntTFCmpKX/hFAq0IDDkJ/xF+NDwOi9odGn7XkgKEPdri8D38JR+Yx/g9C+gNZNJq+X2Ac/ZwwHT5b6kH5UIsOSwO6wFewwKUlWXJ9P75FS+qF76BLWRreTRCTk5k3HxJfNV5uMWznb5rhc32sfzGMAfW5OjiApNezMBdzYu+btFW/plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 17:10:53 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 17:10:53 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Thomas Hellstrom
	<thomas.hellstrom@linux.intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Thread-Topic: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
Thread-Index: AQHdBGJ7e8Pzz1K/k02eguko1UqUK7ZPFtiAgABjzaA=
Date: Thu, 25 Jun 2026 17:10:53 +0000
Message-ID: <SA3PR11MB811816455F96AB93CD54C57CD0EC2@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260625055734.2831607-2-nitin.r.gote@intel.com>
 <331d68c6-aa51-48d7-8c15-69d5dbbe35b2@amd.com>
In-Reply-To: <331d68c6-aa51-48d7-8c15-69d5dbbe35b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|PH7PR11MB6858:EE_
x-ms-office365-filtering-correlation-id: a2ec12c9-9ae4-4995-6dbf-08ded2dcb6b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: 09kZsMlheQ5DHtqhFYZf4x0dNduFwltg5E0i0e14HxZU28Gcb1bMpcrmfg4HqffrTNSRZlS4FDgYGUpXDvubl9SiEzbf80QFhaX29PUaKu0IgUlNBZlPM2v/6o9bLBFrCWgIbBTkCbEJ+90th3Lpc5hJeXYYoUai/uYhQUmc/AqgUMOMLbXbIJxMbaKunBQ4PT5bSS87GGWkg+Bglj/an1hNZKh83WrZmWxuAqw93xEXQHb2yr68X4v7w0ft9lwQb6xGrIIkJfafkC3dJXzzKkzbrTbiRInk7h3+VJPGYWs4QSDFt3v64peDXOpkexfyF/QdfMImwvyHf2h6PP150tcaoJKkbcZjn8VblXePLDmTjq+8FjcPpyxlmYOeyMSoG5fhNb2bVN0Fnd7Wg0wiNnBh8PCMFFxL4z1SwDG4sgo4kU8Yj6kU6bYUwODBAU9Zavyzi4SAapFtU+ueqKbp7MqA6Za1nFCBK4ayKMxeSuDFiT2zaYbPQh4rpiBpgWnlpusIxAlo/4x6UXZxLdeZX+UXM/caaZdHQQk2/oABiNF1WchvctUZ/sFThLuJx/GI+vJB/mZshePud1NOn90II3LNXvQO2mbYosha6mgN+MwZYkjafXCTBv4ipYljfuC6bA8ftqT2TDoJ/uqyFmUpcV0xOJThpuFA5AtQa+TgoQ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVpmRVNsTG93TmRBZ204WjA4ajNaR2NPWmJNZW1Qdm1CdTloVmxaa1k1cnBq?=
 =?utf-8?B?RGJNaFBkMjNmTUxiRlNtM2ttTlg5VGFuUkdSWGtmd1NTMDk3SENrTHJDQUdJ?=
 =?utf-8?B?TUIzTkdCZm5IVXVtTXZ4Y2RRZ29BMDk1cVlPOVFkNmtmWTIrSjRWQ1NjdjhM?=
 =?utf-8?B?M2NBdnBwUGt1RG9EdmNoZ0d0dFYvcGtFcHp2czcxdFEycDBDOU4xbkNQUmk2?=
 =?utf-8?B?WnZoTElJQzBrZFVpTnA3bEtxa1BwTzJmdG5tQTRvTVc5ZG9VV211dFpyc0J1?=
 =?utf-8?B?TDluaFp4c2s1djhnTVcrYW9La0w0dkI5Si82enU3U1U0eURzcDUzN0dQVWxm?=
 =?utf-8?B?dysyQ0NuT0tsUmlRRVFBM3BQU2tPa0ZyNkYrYmIyU3RLK3hTbXNON0FNb1lK?=
 =?utf-8?B?RlZ0aFVYYlcrNTRERkxwVmZOaGlWQ21JYTdSMTY3VUNFY05wQm9lSFdpaHBV?=
 =?utf-8?B?ODgyQkxtRUlYdERDWkFzb0wrMHBRMEc1OHJXMHNNckJIVm4zVGJOejBDMVlk?=
 =?utf-8?B?ZG1YSm1VV0w5STQ0OU1yM1JJbWxXc1oxZHkzTkluREJCTGlLSW9CdjNnMTVQ?=
 =?utf-8?B?eEwzRWY0ZHdOOHVyTkoranR1WlBLc3I0ZEs0TG9UeG9iUCthcVJsei9PMU9a?=
 =?utf-8?B?ZzMvUXltWEpBUkpxQWV1Zkc5QllKeG5CcTQ4SzdKRmV5NzhpS3VCMVdVNHFR?=
 =?utf-8?B?OXAzTzZhOStRdmJ0cnV0b0ZSWkNPMDYyVU1BUGZnai9SWGg3Y2ZHckJONGZu?=
 =?utf-8?B?dmtHRkE1ZWhyWmFYWndZc3l3dXpOK3lzVThLOHM0ZXJBa2gwTDNEZzZDSXpZ?=
 =?utf-8?B?ZmZIbitRNDRLL21IVUI3OXBOWUw5Zk1NWWYvdzZ3a3ZBRld0c1lNVitNUUdB?=
 =?utf-8?B?UG9vZnpMU2lHc1daZ1d3MnhMTHdjLzJjVklzbnRNU1JsT0JIVlhpRFZBUnE3?=
 =?utf-8?B?WmxpbjNQT044Z1FLSFRpRjRKeXlVTSt2ZkpSNTZHMDhYUlhWYnMrMDZsUFBv?=
 =?utf-8?B?cU9wd0xKM0tJQ0RhT1VjTFB3NHI0TFJVb2doaFN1WGFJWjJyVUVWZ2lnaFg5?=
 =?utf-8?B?K1hjU1hxODNoTWtsdFJMSVRleVZWc2JNVkQ1Mm0zNkpDVGc0bmx2V2QvaDkv?=
 =?utf-8?B?SE5wWmdIdlNRTmExek05WWtGNnVmN2RicHFFcjZtbWRFQlk4OWJSNHNGRFZi?=
 =?utf-8?B?RGVmM1dzL3Z0ai92bXYxcmZUSk4vSEZTd3RTREdBckZSNVJpVCtxRkx3NlUx?=
 =?utf-8?B?ZkIrNXRlOHRWcEhqZjcyN3MrdlNocXVxVWdYeVd6ZUZneDdRMVllMjhYU2p1?=
 =?utf-8?B?RDYzSEt3YlhlaWk1UUJqSm0xRFN4eCtzZjVxc050Mk5ybTlGeldQYmExTytX?=
 =?utf-8?B?R25CRlFaR3UvUklYMk80d1VDK1ZhRE1pN1lPZTVLcHJFcUpiUTBtSnlkUVM0?=
 =?utf-8?B?a2NSazQwUVAvR1lWZUgrS2M2cHVyYTZkVG5jbTNHaWFSVlNmSzU0aWF6VVY3?=
 =?utf-8?B?aGE1d2dzdEJkMm1DODFPd3labTVEWVJkUkFPM0NZSlF6azhselUxK3dHU2Nz?=
 =?utf-8?B?aFdNTURidEs4YVZ6OW80Vk90eDZKZ05hL1VwdFhxc25nL0I2UGp0WkxxSysr?=
 =?utf-8?B?aC8xZnhSL3dOeWpOcDZQZDRtd1dVTHNNQUt3aXRhQzZGTmVsS2VuU21mWVBP?=
 =?utf-8?B?dmtxT0NCT2hGYkdFazJIVFNxNTR2ZjE1ZzdQZVVmRzBuNFBJRmFPSjJaVmRZ?=
 =?utf-8?B?bkU3eE5sd0RFdENGY2phWC9BZjVQN0d4Y1BlQ0k0dmJDUllnbEpWU2h4cTJ3?=
 =?utf-8?B?Wi9lYzNsdUpjMDBCcnpMeStVYWQwTUFpc3M2OWhEbS9pa1BSWUdPYlBwVXRo?=
 =?utf-8?B?MUU1Vm5iQVZQWWJkdnkzdEh5Z3RNME5nUDlsRGx5czZ3Y1BJSUg1MTBnaFlX?=
 =?utf-8?B?bktsRXkzOVFFR3JqNkk5dTM3N041RkdFQSt0azByTlJSdmhzdEVGWDRkQVV5?=
 =?utf-8?B?OHhQRHhHcVpHUmFQNFNrN1pFL2RySjdBMEZrUXVEbjZjOHlBd2crS0l1TVgx?=
 =?utf-8?B?eVdTRjJrQzR5dEhOSHdGVHFSZFQ5YWI5OTRyRWVnVU9HNHl1N3pFYlhwTkwv?=
 =?utf-8?B?eWJidUpmcUdoWTJ3TFhpZkY2YktzR0lHeGJFU2gvUWRCdFhNWU1tc2hvRVFx?=
 =?utf-8?B?N28zZ3BjaE5XeDQ4T0hEMEtvVWQreHNtVFovazIyZU8rZ1dHVFJLTE43dUhF?=
 =?utf-8?B?Y3BPWHQ3VzlRTnRld3AxNFdWcUxGQlBHNzk5Mm56Q1B2WGdXeDlIN2RUMHc1?=
 =?utf-8?B?RFozTWhLRWtNK204QWNrSTFkUDIwdldQQjNsTXFkU2lEUU5xMkpQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oLUToogLuLcLN2wGs6Zg2lDLgVUYiDCcGO+W3CutKik4zCGlKhuGbL42MewoaDc7C+VUMDzPnr9MBjUqoHpuaRns20570llzvjKTeQlIktbb034wVJ5NNF7sVLYDGO31sNz4hq16GXC/C2x4Gptka5CWyJCrfRLvZ+kRw8DeuzVeBafCWHufe/RjGp0AGHd9KgooEhjdn4ij8s5Ox/WfN1rDF7cMsvR0tKLB+moqxfizUiXHpl22OgFi7nl6JHWUkSyzIpNz1O+S21eIuhzdNfcAHI5d0G2w6cJgxNmApOg/zbRr2ZilXGIZ9tEjahK1Xqk7jsdkOegLzcl1pYec1A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ec12c9-9ae4-4995-6dbf-08ded2dcb6b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 17:10:53.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vl3AP3Ecs+FPeNzKOBQH4NTGchqVHf3wvQfg9ql9rZUgs+dIygiEAYfC6bBRnc6MiXy5sEvDBqKuGEt1FiA8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI1LCAyMDI2
IDQ6MTYgUE0NCj4gVG86IEdvdGUsIE5pdGluIFIgPG5pdGluLnIuZ290ZUBpbnRlbC5jb20+OyBp
bnRlbC14ZUBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmc7IFRob21hcyBIZWxsc3Ryb20NCj4gPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29t
PjsgQXVsZCwgTWF0dGhldyA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gZHJtL3R0bTogRml4IFVBRiBvbiBkbWEtYnVmIGF0dGFjaCBmYWlsdXJlIGZvciBz
ZyBCT3MNCj4gDQo+IE9uIDYvMjUvMjYgMDc6NTcsIE5pdGluIEdvdGUgd3JvdGU6DQo+ID4gV2hl
biBhIGRtYS1idWYgaW1wb3J0ZXIgY3JlYXRlcyBhIHR0bV9ib190eXBlX3NnIEJPIHdpdGggYm8t
PmJhc2UucmVzdg0KPiA+IHBvaW50aW5nIGF0IHRoZSBleHBvcnRlcidzIGRtYV9idWYtPnJlc3Yg
YW5kIGRtYV9idWZfZHluYW1pY19hdHRhY2goKQ0KPiA+IGZhaWxzLCBubyBkbWFfYnVmIHJlZmVy
ZW5jZSBpcyBoZWxkLiBUaGUgZXhwb3J0ZXIgY2FuIGJlIGZyZWVkIGJlZm9yZQ0KPiA+IHRoZSBk
ZWxheWVkX2RlbGV0ZSB3b3JrZXIgY2FsbHMgZG1hX3Jlc3ZfbG9jayhiby0+YmFzZS5yZXN2KSwg
Y2F1c2luZw0KPiA+IGENCj4gPiB1c2UtYWZ0ZXItZnJlZToNCj4gPg0KPiA+ICAgT29wczogZ2Vu
ZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBwcm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNz
DQo+ID4gICAgICAgICAweDZiNmI2YjZiNmI2YjZiOWMNCj4gPiAgIFdvcmtxdWV1ZTogdHRtIHR0
bV9ib19kZWxheWVkX2RlbGV0ZSBbdHRtXQ0KPiA+ICAgUklQOiAwMDEwOm11dGV4X2Nhbl9zcGlu
X29uX293bmVyKzB4M2YvMHhjMA0KPiA+DQo+ID4gdHRtX2JvX2luZGl2aWR1YWxpemVfcmVzdigp
IHNraXBzIHRoZSByZXN2IHN3YXAgZm9yIGFsbCBzZyBCT3MgdG8ga2VlcA0KPiA+IHRoZSBzaGFy
ZWQgcmVzdiBhdmFpbGFibGUgZm9yIGRlbGF5ZWRfZGVsZXRlIHRvIHJlbGVhc2UgdGhlIGRtYS1i
dWYNCj4gPiBtYXBwaW5nLiBBIEJPIHdob3NlIGF0dGFjaCBuZXZlciBzdWNjZWVkZWQgaGFzIG5v
IG1hcHBpbmcgdG8gcmVsZWFzZSwNCj4gPiB5ZXQgaXQga2VlcHMgYm8tPmJhc2UucmVzdiBwb2lu
dGluZyBhdCB0aGUgZXhwb3J0ZXIgcmVzdiB0aGF0DQo+ID4gZGVsYXllZF9kZWxldGUgbGF0ZXIg
bG9ja3Mgb25jZSB0aGUgZXhwb3J0ZXIgaXMgZ29uZS4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGNo
ZWNraW5nIGJvLT5iYXNlLmltcG9ydF9hdHRhY2gsIHdoaWNoIGlzIG9ubHkgc2V0IGFmdGVyDQo+
ID4gc3VjY2Vzc2Z1bCBkbWFfYnVmX2R5bmFtaWNfYXR0YWNoKCkuIEZhaWxlZCBpbXBvcnRzIG5v
dyBpbmRpdmlkdWFsaXplDQo+ID4gbm9ybWFsbHksIHNvIGRlbGF5ZWRfZGVsZXRlIG9wZXJhdGVz
IG9uIHRoZSBCTydzIHByaXZhdGUgX3Jlc3YuIFRoZQ0KPiA+IGV4cG9ydGVyIHJlbWFpbnMgYWxp
dmUgZHVyaW5nIGluZGl2aWR1YWxpemUgYXMgaXQgcnVucyBzeW5jaHJvbm91c2x5DQo+ID4gaW4g
dHRtX2JvX3JlbGVhc2UoKSwgd2hpbGUgdGhlIGdlbV9wcmltZV9pbXBvcnQgY2FsbGVyIHN0aWxs
IGhvbGRzIGl0cw0KPiA+IGRtYV9idWYgcmVmZXJlbmNlLg0KPiA+DQo+ID4gQ2xvc2VzOiBodHRw
czovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL3hlL2tlcm5lbC8tL3dvcmtfaXRlbXMvODAy
Mw0KPiA+IEZpeGVzOiBkOTlmYmQ5YWFiNjIgKCJkcm0vdHRtOiBBbHdheXMgdGFrZSB0aGUgYm8g
ZGVsYXllZCBjbGVhbnVwIHBhdGgNCj4gPiBmb3IgaW1wb3J0ZWQgYm9zIikNCj4gPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjgrDQo+ID4gQ2M6IFRob21hcyBIZWxsc3Ryb20gPHRo
b21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBDaHJpc3RpYW4gS29uaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gPiBDYzogTWF0dGhldyBBdWxkIDxtYXR0aGV3
LmF1bGRAaW50ZWwuY29tPg0KPiA+IEFzc2lzdGVkLWJ5OiBHaXRIdWJfQ29waWxvdDpjbGF1ZGUt
c29ubmV0LTQuNg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pdGluIEdvdGUgPG5pdGluLnIuZ290ZUBp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gdjM6DQo+ID4gLSBEcm9wcGVkIHRoZSB4ZS1zaWRlIHJl
b3JkZXJpbmcgYXBwcm9hY2ggc2luY2UgaW1wb3J0ZXJfcHJpdiBtdXN0IGJlDQo+ID4gICB2YWxp
ZCB3aGVuIGRtYV9idWZfZHluYW1pY19hdHRhY2goKSBwdWJsaXNoZXMgdGhlIGF0dGFjaG1lbnQu
DQo+ID4gLSBQZXIgQ2hyaXN0aWFuJ3Mgc3VnZ2VzdGlvbiBvbiB0aGUgdjEgdGhyZWFkLCBrZXll
ZCB0aGUgY2hlY2sgb24NCj4gPiAgIGltcG9ydF9hdHRhY2ggcmF0aGVyIHRoYW4gcmVtb3Zpbmcg
dGhlIHNnIGd1YXJkIGVudGlyZWx5Lg0KPiA+IC0gRXhwb3J0ZXIgbGlmZXRpbWU6IGluZGl2aWR1
YWxpemUgcnVucyBzeW5jaHJvbm91c2x5IGluc2lkZQ0KPiA+ICAgdHRtX2JvX3JlbGVhc2UoKSwg
Y2FsbGVkIGZyb20gZHJtX2dlbV9vYmplY3RfcHV0KCkgaW4gdGhlDQo+ID4gICBnZW1fcHJpbWVf
aW1wb3J0IGVycm9yIHBhdGggd2hpbGUgZHJtX2dlbV9wcmltZV9mZF90b19oYW5kbGUoKQ0KPiA+
ICAgc3RpbGwgaG9sZHMgaXRzIGRtYV9idWYgcmVmZXJlbmNlLg0KPiA+IC0gRml4ZXMgYm90aCB4
ZSBhbmQgYW1kZ3B1IGluIGEgc2luZ2xlIFRUTSBwYXRjaC4NCj4gPg0KPiA+ICBkcml2ZXJzL2dw
dS9kcm0vdHRtL3R0bV9iby5jIHwgMjQgKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX2JvLmMgaW5kZXggYmNkNzZmNmJiN2YwLi5iZjhlYWVjMGU5Y2EgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCj4gPiBAQCAtMTk2LDYgKzE5NiwxNCBAQCBzdGF0
aWMgaW50IHR0bV9ib19pbmRpdmlkdWFsaXplX3Jlc3Yoc3RydWN0DQo+IHR0bV9idWZmZXJfb2Jq
ZWN0ICpibykNCj4gPiAgCWlmIChiby0+YmFzZS5yZXN2ID09ICZiby0+YmFzZS5fcmVzdikNCj4g
PiAgCQlyZXR1cm4gMDsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIFN1Y2Nlc3NmdWxseSBpbXBv
cnRlZCBzZyBCT3MgbmVlZCB0aGUgc2hhcmVkIHJlc3YgZm9yIGRtYS1idWYNCj4gPiArCSAqIGNs
ZWFudXAuIEZhaWxlZCBpbXBvcnRzIGhhdmUgbm8gYXR0YWNobWVudCBvciBtYXBwaW5nIGFuZCBj
YW4NCj4gPiArCSAqIHVzZSB0aGUgcHJpdmF0ZSBfcmVzdi4NCj4gPiArCSAqLw0KPiA+ICsJaWYg
KGJvLT50eXBlID09IHR0bV9ib190eXBlX3NnICYmIGJvLT5iYXNlLmltcG9ydF9hdHRhY2gpDQo+
ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiANCj4gWWVhaCwgdGhhdCBhcHByb2FjaCBsb29rcyBn
b29kIHRvIG1lLg0KPiANCj4gSSdtIG9ubHkgd29uZGVyaW5nIGlmIHNvbWUgb3RoZXIgY29kZSB0
aGFuIHRoZSBETUEtYnVmIGltcG9ydHMgd2hvIHVzZXMNCj4gdHRtX2JvX3R5cGVfc2cgY291bGQg
cG90ZW50aWFsbHkgYmUgcHJvYmxlbWF0aWMgaGVyZS4gVGhlIEtGRCBzdHVmZiBjb21lcyB0bw0K
PiBtaW5kIGZvciBleGFtcGxlLg0KPiANCj4gTWF5YmUgYXNrIHNvbWUgQUkgdG9vbCB3aG8gYW5k
IGhvdyB0dG1fYm9fdHlwZV9zZyBpcyB1c2VkIGFuZCBkb3VibGUgY2hlY2suDQo+IEkgZG9uJ3Qg
dGhpbmsgdGhlcmUgaXMgYSBwcm9ibGVtLCBidXQganVzdCB0byBiZSBzdXJlLg0KPiANCg0KSSB3
ZW50IHRocm91Z2ggdGhlIG90aGVyIHR0bV9ib190eXBlX3NnIHVzZXJzLCB0aG91Z2ggSSdtIG5v
dCB0b28gZmFtaWxpYXIgd2l0aCB0aGUgS0ZEIGNvZGUuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkg
Z290IHNvbWV0aGluZyB3cm9uZy4NCg0KQXQgS0ZEIGNyZWF0ZV9kbWFtYXBfc2dfYm8oKTogSXQg
Y3JlYXRlcyB0aGUgc2cgQk8gd2l0aCB0aGUgcGFyZW50J3MgcmVzdiBhbmQgbmV2ZXIgc2V0cyBp
bXBvcnRfYXR0YWNoLCBzbyB3aXRoIHRoaXMgcGF0Y2ggaXQgbm93IGluZGl2aWR1YWxpc2VzLiAN
ClRoYXQgbG9va3MgZmluZTogdGhlIG5ldyBzZyBCTyBob2xkcyBhbiBhbWRncHVfYm9fcmVmKCkg
b24gdGhlIHBhcmVudCB1bnRpbCBpdHMgb3duIGFtZGdwdV9ib19kZXN0cm95KCksIHNvIHRoZSBw
YXJlbnQgcmVzdiBpcyBzdGlsbCB2YWxpZCANCndoaWxlIGRtYV9yZXN2X2NvcHlfZmVuY2VzKCkg
cnVucyAod2hpY2ggcmVhZHMgdGhlIHNvdXJjZSB1bmRlciBSQ1UgYW55d2F5KSwgYW5kIHdpdGgg
bm8gZG1hLWJ1ZiBhdHRhY2htZW50IHRoZXJlJ3Mgbm90aGluZyB0aGF0IG5lZWRzIHRoZSBzaGFy
ZWQNCnJlc3YgYXQgY2xlYW51cC4NCg0KVGhlIHJlc3QgKEtGRCBkb29yYmVsbC9NTUlPIGFuZCBh
bWRncHVfZ2FydCkgY3JlYXRlIHdpdGggcmVzdiA9IE5VTEwsIHNvIHJlc3YgYWxyZWFkeSBwb2lu
dHMgYXQgX3Jlc3YgYW5kIHRoZSBmaXJzdCBjaGVjayBpbiB0dG1fYm9faW5kaXZpZHVhbGl6ZV9y
ZXN2KCkNCnJldHVybnMgZWFybHksIHNvIG5vIGNoYW5nZSB0aGVyZS4NCg0KU2VlbXMgbGlrZSB0
aGVyZSBpcyBubyBwcm9ibGVtIGluIEtGRCBjYXNlLg0KDQpSZWdhcmRzLA0KTml0aW4NCg0KPiBU
aGFua3MsDQo+IENocmlzdGlhbi4NCj4gDQo+ID4gIAlCVUdfT04oIWRtYV9yZXN2X3RyeWxvY2so
JmJvLT5iYXNlLl9yZXN2KSk7DQo+ID4NCj4gPiAgCXIgPSBkbWFfcmVzdl9jb3B5X2ZlbmNlcygm
Ym8tPmJhc2UuX3Jlc3YsIGJvLT5iYXNlLnJlc3YpOyBAQCAtDQo+IDIwMywxNQ0KPiA+ICsyMTEs
MTMgQEAgc3RhdGljIGludCB0dG1fYm9faW5kaXZpZHVhbGl6ZV9yZXN2KHN0cnVjdCB0dG1fYnVm
ZmVyX29iamVjdCAqYm8pDQo+ID4gIAlpZiAocikNCj4gPiAgCQlyZXR1cm4gcjsNCj4gPg0KPiA+
IC0JaWYgKGJvLT50eXBlICE9IHR0bV9ib190eXBlX3NnKSB7DQo+ID4gLQkJLyogVGhpcyB3b3Jr
cyBiZWNhdXNlIHRoZSBCTyBpcyBhYm91dCB0byBiZSBkZXN0cm95ZWQgYW5kDQo+IG5vYm9keQ0K
PiA+IC0JCSAqIHJlZmVyZW5jZSBpdCBhbnkgbW9yZS4gVGhlIG9ubHkgdHJpY2t5IGNhc2UgaXMg
dGhlIHRyeWxvY2sgb24NCj4gPiAtCQkgKiB0aGUgcmVzdiBvYmplY3Qgd2hpbGUgaG9sZGluZyB0
aGUgbHJ1X2xvY2suDQo+ID4gLQkJICovDQo+ID4gLQkJc3Bpbl9sb2NrKCZiby0+YmRldi0+bHJ1
X2xvY2spOw0KPiA+IC0JCWJvLT5iYXNlLnJlc3YgPSAmYm8tPmJhc2UuX3Jlc3Y7DQo+ID4gLQkJ
c3Bpbl91bmxvY2soJmJvLT5iZGV2LT5scnVfbG9jayk7DQo+ID4gLQl9DQo+ID4gKwkvKiBUaGlz
IHdvcmtzIGJlY2F1c2UgdGhlIEJPIGlzIGFib3V0IHRvIGJlIGRlc3Ryb3llZCBhbmQgbm9ib2R5
DQo+ID4gKwkgKiByZWZlcmVuY2VzIGl0IGFueSBtb3JlLiBUaGUgb25seSB0cmlja3kgY2FzZSBp
cyB0aGUgdHJ5bG9jayBvbg0KPiA+ICsJICogdGhlIHJlc3Ygb2JqZWN0IHdoaWxlIGhvbGRpbmcg
dGhlIGxydV9sb2NrLg0KPiA+ICsJICovDQo+ID4gKwlzcGluX2xvY2soJmJvLT5iZGV2LT5scnVf
bG9jayk7DQo+ID4gKwliby0+YmFzZS5yZXN2ID0gJmJvLT5iYXNlLl9yZXN2Ow0KPiA+ICsJc3Bp
bl91bmxvY2soJmJvLT5iZGV2LT5scnVfbG9jayk7DQo+ID4NCj4gPiAgCXJldHVybiByOw0KPiA+
ICB9DQoNCg==
