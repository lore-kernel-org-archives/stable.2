Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677193E1D06;
	Wed, 17 Jun 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695853; cv=fail; b=KfYNdEFoVX8ZxBWv5RKxLDFHYMpc9UbzYYxoWxeubsFPomlViPD1oPvcx4fXUNLWusY/RkJFbKSRn7jJ5Ib5AvB5rnNgxV56Tdjk4WjRqiEhcmdDyWTfvB7FH6E/DJyz1cxpCyPnSLMA86jtIsw1yXs3gVsDHv2rPJBe8ek3M5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695853; c=relaxed/simple;
	bh=o9ac4ykSSGyJTHGJkhoopnOD8LNoFsOKVAVZgnTWlwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n4JXrqIrSVZQ+a7keup+OZPKzNM2jInCEi4E3zBJdQ7cRN2RWldnHH60fALhVw+CG+drhMTiRZnYlBSOyhvbAnLJF54fkAgedsiWOFfkY3My5mW7xYj9hzwjLKZFirp031PTViPGgfshvqylhNmWNp6VmR9rGRuEWMM+viPjC0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmT1YLrN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmT1YLrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781695852; x=1813231852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o9ac4ykSSGyJTHGJkhoopnOD8LNoFsOKVAVZgnTWlwg=;
  b=JmT1YLrNDnVzevfVEFLlPytH2daCrqLszZqrS2FeBN1pXMpGU+b2D5Ty
   IS0yeyZA3uriVuCMCSbHgKGI1EcJkHw5UPotbl9xtjJcOXNy0MDFeBpwI
   BLYL0Ld9kI1TbMpNmsMTdlGelFfTSFT9Un4B8ZhmLoPIjsbpl0BYM2/4i
   ocvjRADZEXhf2HARQ4rijbZoDvY9FpKOe8XJcFCzf+CJDAr3eGdxIUN8M
   6F83e0K3rYCq3OWpKOawCrBknLoVR+iQ3jqbWc9RLkGVckzKmb/NcwPWi
   1XpSzjwiOmldi/FwBIoEUVEo5IA+x1qy1N/sqXdt3GXS4fv/UyCDaO0y3
   Q==;
X-CSE-ConnectionGUID: 2b46pFyNQUSZKokQrsITgg==
X-CSE-MsgGUID: Fk72VrkYRSCkAibqetyRUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82365046"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82365046"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:30:51 -0700
X-CSE-ConnectionGUID: roT8q04cQZ2fKdc2t3zoPA==
X-CSE-MsgGUID: xJ/lMaIzRY6sNKpMn4LOGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="286156617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 04:30:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 04:30:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 04:30:51 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 04:30:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR4a+DHkXR9CkwEcCWlw6CoLqRzmuoYVG5s0ogVfLw3HujQ9fYq1gJ7LIBRH7e98+pRn75XXBMNP6hS1jFjA1bRVl4IU/I+1XL9oz37ukHnZtshPcDjE9T3cTgeDEVyDfzzCVqR/R5poCUwhpvQZXF96dWA7wB5dQ/z6ax/Twj/A+xZc4wRlGZ8vI/kydp5TOXKkeU4XUCPKIeqhqzOjOO+XUexHE+IDjuYuV6G19CDdREd1KXxM3d6m//bNGKoL8Ahtej0904RU+A6abeQ8O+ClbqVMIZoC6RyCW3AUeZpmiy6dt9ebA1v/hanbU/zSTQVL2Yfz2uWfrnQi4nGA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9ac4ykSSGyJTHGJkhoopnOD8LNoFsOKVAVZgnTWlwg=;
 b=Ra+4hpk3z3QzWh+GitvXIqTjRodXGaV3M0xN0/VDML4mhEjYkUKbZxbbYe6q5ZnOcKSk6HGTB1WG/M0XQ5qsDXgZgmRc20RWZNknwpfSpeGZAXIexMSJ8lkmqkF/9Qa58Mu/eFyIdmwpAgOCzcGJipf7Y5971XMOSDc0LakmZzVpEWs2GGlvMmG8ZUaV9ETNvQ5iTomb1/P2KtQG4fR2ZKHU7t7zLYlmLMAvaE+avBjVSE/1qmpoS71H0xxvVslZDb1DDQrBZtvem1m4QtxHvMlmkQLbLQtyv5VBXeFQapuL8H/D2D/OtSJ2YIYd4SP1pJDYXe7c8TjWmhDEAZyC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 11:30:48 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 11:30:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "yosry@kernel.org"
	<yosry@kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Topic: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Index: AQHc/dm+vhBqLF7f3EanPIP01uKgGbZCncWA
Date: Wed, 17 Jun 2026 11:30:48 +0000
Message-ID: <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
References: <20260616214652.2157032-1-yosry@kernel.org>
	 <20260616214652.2157032-2-yosry@kernel.org>
In-Reply-To: <20260616214652.2157032-2-yosry@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY5PR11MB6317:EE_
x-ms-office365-filtering-correlation-id: c5980513-6560-46f9-d8e4-08decc63e121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: DHs8OwRUCUt3xTC2aEPAUfR7NQ2PxHyhXisyxGZJm3DwRF56YJuQiRz5/Fbmq1jdHG9Oxc9WhKKItOB1X+vb9zaJyGhoSiwcPNyNu/IJO0Ktg6KULZculF2SZKIYRF+snD3gYnVm/jCUs+mqFfYPe0d0VfwWV9HhK9IcjcwRxs4gHWdJKFvPF7Zh8PCUo9y7MmD/JRu1YBexgr48632j+ivldaZqdEFDdMsv46+X70sWcjOzasHeMFew7EDtNeWwE4VSdKDnzxePQIM6oI6BObTvJnHSa7Gx55sKOdOBQ3yGCDQa3PKaBeZObTMFKnec2RJKne+jNDtdphgQhXyo3vsLbPN8cAYt1u+9HbNjx432rCYZEhbV69wU0mrpHBZKG6UBcVOg0L9lTJ5IJooDB8Ug7xPTIXws1W8VqHqDmjKzghOJWvs3kAWhnJTV6Nug62CdJOuQEAKFHkwpJEBBrbs3iy8RQtTeVIR27pe9o5buo3HT6VKtiS0gTtwVYl+kRZksjddaetn0vXCb2pWT8824Ugndz4rDUA9x1JzwGbJ48ES9VM2MmC9mFw0T5Azn8EK9aVw9PSrK1WS8jZdu6IejxQ2A78o/0+pR1mZ5xJpcnDucd+PQUtkirBtVOUNbW7y9SoPnQdEP8XyD1dCJI+GrPclk9ga98RCV/IpXufZCky6+XI3QWTb7o2Y+m3Gu8h3BvJoJvdpKTf4uCOVLIuriQMRCU9Swq/67GSSnAHbhM1S+Vg8J0jzJT94uLrtZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHcrbW4vcm5vTC9hb2dVYUo4S3NLMWhKcWVKbnhBU2dGd3ArdnhKRStJa3BS?=
 =?utf-8?B?MlRmMWUxRktnNzl2dU5EK0hVelQ0TjVrbFlpYUVUNVNqYXRTSTdxN1JaTG9K?=
 =?utf-8?B?ODZnOGZ3UHptME1BVENiYzZFTTZIN0FseDAxMmh3RFY5V0k1a0F5RmlQQjM2?=
 =?utf-8?B?ZTFXbUlHOE91bGZwNDBpWVdqWDZObFBRMk1ZZGlQZEIxckd6Skp5MThOU0xB?=
 =?utf-8?B?QmN4b2pmemk5cHdWQ0cvWnJNTDU1N0huMEJBbDhZeDJHNmdjTnA0RDdwM2s5?=
 =?utf-8?B?Q3h6a1hjKzlnbm1XOVRaUkYwSWFZRVVKZ3BPVHM3cmlreENoNmsxdFUrWjd5?=
 =?utf-8?B?aU1DSjQzRDJLb2wyRVV3NGwzZzczV0NhOG1LS21HZ21PdmxrVmhSMTNINTFj?=
 =?utf-8?B?MWtCRnl0UUtTUHpMR0dKN2t2akNtRVhzMThsVHJnaU90am5kSWFpWEZ1V28v?=
 =?utf-8?B?Q0MzaytjWC9tQ1lhVHprOG1yR0dJazd0RngvcDJXTjVOdnVuZmp0Y2dpS1Iz?=
 =?utf-8?B?akZMdTNRVGo2OXFSUHJLTDhYeDBLbC9iVE0vdXJyZVlycmRzRityRDJCbUpD?=
 =?utf-8?B?YVd0cVo5Y3JwdURVc3JraFpPTFhBS2JPZkxkM01nWWx6UElxeFlIcWFjTzVu?=
 =?utf-8?B?YTcxVjlDS3dJLy81M21ndEU3SDhjUTYyb0cyRk9IdFlrTjMySXYrQithZWdi?=
 =?utf-8?B?UXJMbkQvK29nMzFHUWdnQ1E5OGNqWDV6OGt3QWpWb3hhK3pwUkhBa2w5eFVY?=
 =?utf-8?B?VTFYUzNkZ1l0MlpkYTd2MHNNRmg4UFNWNjBVUTA5OEhuTmpGWVRwcFlZNE9L?=
 =?utf-8?B?RU5wQVo1emVFNWQ3cXZqZUZtMGlqd3pGVnI1dkkySzhteVd0eC9XT2lPQlpC?=
 =?utf-8?B?ZkJRYWE3czBEWldMNUlzRXNCcHRVZmZFU3BhWEJkWnlCdmh6TGwwQUxleVRz?=
 =?utf-8?B?UDNCUGlNYzV6OHRvMVhMYjdDRzhYVmU4SFVQYkY1N1hwbDJ5Sjd1azgwVkZi?=
 =?utf-8?B?U0FTR2NpWld6UXZNRnE1MlVUdTQyMmszZ3hmQTF1dmRON2ZYMnZQQWVjZ3kr?=
 =?utf-8?B?N1IzVk5kMmhaUjg4d2JnRGFsR2c2S3ZpMHZ2cTFBalpOWnBpRmJHdmg4ZHpv?=
 =?utf-8?B?SWJSR1hjNjMyR3ltamhKa1U5QjEwb1pML3lRMERvcGJMQUFiVzMvUUlQZVFt?=
 =?utf-8?B?V0wwUGVXSWxMcnN3YXNUTnRwOE9Hcnc5ZzE5d1F4V2FDdUtoMlhHLzNZdUJh?=
 =?utf-8?B?S0pHNVZITHJhelp0KzdNNkRwcVZBTStNck1vWVhkejJwL0tTaFIyS1VzUWF5?=
 =?utf-8?B?Z0NNWVozS0dPVGYxOEltT29pK3MwREtzU0hEWUVkN2R3bWMvTTZJTHhTQlQv?=
 =?utf-8?B?TS91eEVZaDhWQ2FIcWM4aVNOUXllTXIxZ0V1eitXRDZLUFF5SVV4S2RSK1ZE?=
 =?utf-8?B?dS9LcVFMb0Y3S2JxMzYrWkJ6aThCRmtqRUJhbFo5YWJEcmhTMlI0RklJODE4?=
 =?utf-8?B?dmxYTTVCczErSnVEWWNkSElLa3FBQ1MzaWZEZ3JqV09ML1prVk41bXA2eGFq?=
 =?utf-8?B?d1V1NEFtUmg3VXJxcVErZ0cybmcySzh3dDlZUFMyZlAxazhwamh6WlBKTjRI?=
 =?utf-8?B?eWkwVmtxQkF4OWdyVzdMaE1hdUZpcWxkTXduOVdYWG5seFZkTUczQi9oQ2o3?=
 =?utf-8?B?YWNxcVlxa1BjVW5DTkUxYWh5OG0yVjlpNmhwditYQmpPYjcwRnJ2dGp5SEFP?=
 =?utf-8?B?ZjVzSlpmY3V6ZGFWM1dhME9yeWhtN2c3UUdHeXNKUXlWNWpRSm1sNkQxYTVM?=
 =?utf-8?B?MkZpbjRhY2llOVYybGkvZWRaUlhXSkxZSlVQT3B2NG8yVHNsWitETWFEWmZJ?=
 =?utf-8?B?TlBuL1VTcnFqcFVQVkhmaTBKNHJBWG1UOEx0aTd1TUhtaCtIR21ia3NROUt5?=
 =?utf-8?B?WjJtYkxzblJiQW1GRGhma0RPeWtPMjYyNzJRRXU2Qk4rN0g1NG1VdkxZOXlk?=
 =?utf-8?B?M3l5ODlidG9jbUI2cVpTMnM3R1d5RU42cThLTnpVY0FrcGN5SURzUWFHQ0JB?=
 =?utf-8?B?K0Q0R1FGemtUUm1VTHJBVEo3NG5PSnJnKzdNL2JpM1BoZVRJditOSi9qOVFN?=
 =?utf-8?B?Lyt1N3FzZnVEd0prZ3l4elczK1BodGJTb0d5Y0FKTk9CVWFSb2xlY2NjaFZ6?=
 =?utf-8?B?TnJDTXM0NDdzaWE4L1RkR1FlN2oyWjNXaDhpOWVxOUFERk5FM0dYZ0tlQUlq?=
 =?utf-8?B?NUNyWG10eUUxNnUrSCtSVHVuaEdUM2NJVnpvZXo2U0FjN1gzRlp2RUNqaDNN?=
 =?utf-8?B?allMa1hKMGd3R2VFS2M4RWl5RUFMRmF6bTBEQmQvdnV1YzgvRS9VQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <931BE1BEECDF52458D854081C9CE423A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gb3ccMkWoeuff6fGUgUzAp/oSJs1FX8EzhMMVyXhyn+A+H2ptPCpXFLrLEr/+LeeMkeVglSZohiJlSSu3ofP0VRKd/G1xf85R0ZYASeAKxAzMDwf6N0TJgE9BKdthfSn60IB05hl8fmya09yKGQflU1PIxnbhtWQsHC5dgthXW0XXCUEePVLpqYjxApoJ9lR2YOo2rZS5DFZE3uASJ+6eEkH35J6kWxf/geuSMt/Jfr0rsLB72AC+X9MQyL1y4rVgCaufbxcO39FCYrGJwzi3rLCpeo/0hgcCES/6e5W52pOH8RN8d4WNYFlHG/J9FdqwXmRY3yX+AeUMCrXQW0Z7Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5980513-6560-46f9-d8e4-08decc63e121
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 11:30:48.4031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bn9Q8QA7meUvhOCFKtvPcXYDB4X4+6zJ1yv+VGPUIn9W6joLyXIZoRY+OsUlI4HXCPudrLCzSgsSMmZb10L30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTE2IGF0IDIxOjQ2ICswMDAwLCBZb3NyeSBBaG1lZCB3cm90ZToNCj4g
TWFrZSBzdXJlIHZwaWQwMiBpcyBhbHdheXMgZmx1c2hlZCBvbiBmaXJzdCB1c2UgYnkgc2V0dGlu
ZyBsYXN0X3ZwaWQ9MA0KPiB3aGVuIGFsbG9jYXRpbmcgdnBpZDAyLiAgbmVzdGVkX3ZteF90cmFu
c2l0aW9uX3RsYl9mbHVzaCgpIHdpbGwgYWx3YXlzDQo+IGRldGVjdCBhIFZQSUQgY2hhbmdlIG9u
IGZpcnN0IFZNLUVudGVyIGFmdGVyIFZNWE9OLCBiZWNhdXNlIFZQSUQ9MCBpbg0KPiB2bWNiMTIg
aXMgbm90IGFsbG93ZWQgaWYgTDEgZW5hYmxlcyBWUElELg0KDQp2bWNzMTIgOi0pDQoNCj4gDQo+
IFRoaXMgYXZvaWRzIHVzaW5nIHN0YWxlIFRMQiBlbnRyaWVzIGZyb20gYSBwcmV2aW91cyBsaWZl
dGltZSBvZiB0aGUNCj4gVlBJRCwgdGhhdCBtaWdodCBoYXZlIGJlZW4gYXNzb2NpYXRlZCB3aXRo
IGEgZGlmZmVyZW50IHZDUFUgKG9yIGENCj4gY29tcGxldGVseSBkaWZmZXJlbnQgVk0pLg0KPiAN
Cj4gTm90ZSB0aGF0IGxhc3RfdnBpZCBpcyBhbHJlYWR5IGJlaW5nIGluaXRpYWxpemVkIGFzIDAg
d2hlbiB0aGUgdkNQVSBpcw0KPiBjcmVhdGVkLCBidXQgaXQgaXMgbm90IHJlc2V0IHdoZW4gdnBp
ZDAyIGlzIGZyZWVkIG9uIFZNWE9GRi4gSGVuY2UsIHRoZQ0KPiBwcm9ibGVtIGNhbiBvbmx5IG9j
Y3VyIGlmIEwxIGRvZXMgVk1YT0ZGIC0+IFZNWE9OLCBydW5zIGFuIEwyLCBhbmQgS1ZNDQo+IGhh
cHBlbnMgdG8gcmV1c2UgYSBWUElEIHRoYXQgaGFzIFRMQiBlbnRyaWVzIG9uIHRoZSBwaHlzaWNh
bCBDUFUuDQoNCk5vdCBzdXJlIHdoZXRoZXIgaXQncyBiZXR0ZXIgdG8gc2V0IGl0IHRvIDAgaW4g
ZnJlZV9uZXN0ZWQoKSwgd2hpY2ggYWxzbyByZXNldHMNCnNvbWUgb3RoZXIgbmVzdGVkIGZpZWxk
cyB0byBjbGVhbiBzbGF0ZSBBRkFJQ1Q/DQoNCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IFlvc3J5IEFobWVkIDx5b3NyeUBrZXJuZWwub3JnPg0KDQpB
bnl3YXk6DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
