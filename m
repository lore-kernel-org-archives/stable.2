Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE02E8897;
	Wed, 24 Jun 2026 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303954; cv=fail; b=dIB55PvgU3c8bZxHGFLzFNV9b+lKPNx6rmsIeECjlfkzPkR1AWjg6WL7p/R3ZEBFRAHDhTQKEgx0CNupLnP32iF22rTSOFiCsoDQyOjW6xd/cWvaiyYXtDLfIXp00zl01tXydhJM2ajM3Vl7Wqy4JCHCnXmN6pN/eU+pit07EuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303954; c=relaxed/simple;
	bh=D36FrvhXk+Lbo8PbEgcs8eDZjqKe4DjecEMFuQJ+t2Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TH7Hbs23xaLEnhglMcmRcn6MXflW7QALy8R7Fce9qS3Sw63n4vvsDtOAgFbtY/m54IBJ64uk8T8Cy7s1S2ntUXIMtIjujswf2hPBZKiX0loqNwuo+9nXh330Z/8FUcFQ8QvnoiroD4mGAXw+2QG3m1izcBpFm9AASHjFjXeE6v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbR1blbm; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbR1blbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782303951; x=1813839951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D36FrvhXk+Lbo8PbEgcs8eDZjqKe4DjecEMFuQJ+t2Y=;
  b=hbR1blbmDTBjF26bApDTbk+/dlATUCZIToYszxO18x7U2LSd3r27bZy+
   2UwGdLIW2qwZ8tG9vSf94xWmK3R0LtDCzF03oISX0CBn5XXeoH9nu287C
   2aobLSyaKGKTpLIl9lLPRdDVJmp+cuPkO7WFj/5fD6oOtB1n6b+UjOhIJ
   eauwo2iuAzHO8dDxTfi78tFDChrxAeEAmfNd5fSmh0y5Ct99B22AVAneP
   YWDOxKj/ND53x9LM6XW+jJ1giFCsMC8bVB/QHHCwfBWaZDkwYOT+eiRW8
   RRukKbL2irRshkVS1J7lqnIdmIGKsCPtP3yXcC3QW8DgzLUT4yWNNYcx4
   Q==;
X-CSE-ConnectionGUID: 3iJlDjaDQgSibWJQcQVBxA==
X-CSE-MsgGUID: hUcU22x1Qeio1N3q643z9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93716064"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="93716064"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 05:25:51 -0700
X-CSE-ConnectionGUID: WoRHyt7GTdugpeCK+Nbxcg==
X-CSE-MsgGUID: 6uP7JhYjTXajPe/8Jzasjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="249954167"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 05:25:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 05:25:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 05:25:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 05:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h31JNw9QfNFSgjH3iuO+KkEGOGUebBE8KaUQEKfE9GZ//iHf674xgqCxc5/Pj1d3AmdRmwfrVzHsu7gPjSUIMdx4ZdA8H6ItzW1cBkUqz/qiLmmutYaBfQH1h+uacV7B4hqvfFCqFKwVMMGQR60pruOSkTlJ68YNb0wTFRm7ffTgY7g4FhVCNBbozeHuPHPjVOvMAkJfT1QvsEvRVLn6sGIydHSpea+CN9cxQJp4Ut+K1PtZ3LYGYvMiMu9OFSxsKmYzYh0r74O0sa+UIyxN0wBAJbolhaqHddkXH7nP6qE67GJ1hfeYt17UohX2jqIBJfhXCvy5Z/g4SQn/OsLKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYcqYhGeUNJaST2QKyR5gEGIReOKEFCVx03QBs3Mam4=;
 b=tUHDdRHoZ1AcbF0r9k82hDW3pktVcRiVCBpge2eBO+EJrZfYI5gWjKoyZxwC18OhEHjcuZ/9UYzYEs6KvKIlttBR6TgTRw0iNUHuC+f5L0lit3C59LmuwHiC8vAsPSw20ASxJw606YMnowHMGD20lXzEqVgD4V2gaRQ1jubtFIvWqV/1VfzFybzQ4M/zZkr7LXdulH5of/jt1DqE9r65EpSEwi0FOcG3aXhzEGQXd1m7UwUqTQ1Ov1gpSs1TLnk1znyZz4SgwjeKF2NNY/ET3ZGBeU+3MGKJnJGXk9XXPupXUkNftQMxvXga7WNYo33HWeQFd5Kz9icjlG7Thalj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA3PR11MB9013.namprd11.prod.outlook.com (2603:10b6:208:57c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 24 Jun
 2026 12:25:46 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 12:25:46 +0000
Message-ID: <6312bb2e-9ec3-480b-bb50-f70e8e5b9025@intel.com>
Date: Wed, 24 Jun 2026 14:28:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7 3/4] iavf: send MAC change request synchronously
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<netdev@vger.kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <aleksandr.loktionov@intel.com>,
	<jacob.e.keller@intel.com>, <horms@kernel.org>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>
References: <20260623101800.991293-1-jtornosm@redhat.com>
 <20260623101800.991293-4-jtornosm@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260623101800.991293-4-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0081.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::34) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA3PR11MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe87b53-92f0-4ebf-7cd9-08ded1ebb7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 66kB0KE/n14VsD++BRWFg+VLEnPLJzuaOFwXRdzhUe7WEjjFi0fGFiueHNoG09WqR5x2JvR0lgPsgKB8906uEgzGRjTqrgDlN57n1CjVriogj9kApdVMsRP3cAzFf0/XhnW6XwBK/fDx9tp2WxSO/bz4eapR/qsi99ZLN+7ktnv7JID3X8NfeE9PicVsu/JRd3YstLGXeP7+gb3Y93duybGmREUeiIqO1sHH8G9cN0SYueNE632TdMI0LaK8IYU+EQMUXXlhPk+56VGOvEa8vnySSweUlZI4zGInwLDPTt0dk5jE2AUS9RagS+MoWtxwdQ0y21NoniRzNKdgqGqQof8R3AvjdxWMwzcwZsOKwff2YHwU1Ggmhnj/HEeR2Lo/mnt36Cz+NgRErZxPzJ7sf9d5izjs/+1ZEGj6mLe4b6If2vkQFS7Dg0GPi+94mRvLE+6iJXs0JqjL2L0HjMd1Z9NrG2+k7d44yT+dWF23nn60VjeXG4pdEJ2mOCwcfOzxEo3Hnf9/pvEfTOIMN1RunNOA9N9OA8CFefrhh4lmBXIVwbCirRdMsnaUCaDqEe8KF9Y8P8MqsXKgGbggCAXcuB4cKQSvI7bIvvuYVzc7z8i2IGJf/XGqWQNlU0s97h2La+CltEe1WApsnup4Uu4Fj2bfIixUi03A5VD2cHBMx08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhSMUkwM0IvL1hNR3lqLzhXQ1YxcmRsU2c5SHFsdzBuVW4veVFkYUxaRjRk?=
 =?utf-8?B?Mi9DU1ZoMmh5cWYxNVR2UkhMMUtSSnQwTmI3ajVWRmUxZFFkQlRFaWMrbmI4?=
 =?utf-8?B?NlZoSHJHbkNwcnE4bHJWTnR0c05Wckp1cjd3TVdYVEFMUjl6ejVxcUMzZEZt?=
 =?utf-8?B?QmJkN1hJNm5ZWlZLODRPNC94S1BMS0FXNTV2elgvWWhmQWVVTmZDWjJpYTNO?=
 =?utf-8?B?UFVmQkE5SXIyR08xdmFmemhrSkdFdk5uanpJeDZseFUxeUVKcWcvVUE2SmRD?=
 =?utf-8?B?bDZIZitBeTdXVThJYnp3Z2dYRllaSXpMS2pwWWxkdkxwZ3Z0Q0o5R25LUWVX?=
 =?utf-8?B?TjRlVUR0aHVmc0xrTkhFRVB6ajgrWnc1SnNNZ0FpbVZxTXZpalVZdklvUUFH?=
 =?utf-8?B?ekdiK2FnR0FiRC9JdzdYNmtwYklqMWMwNEZ2TUVvQUNHS2cxbDAzeXRvU3pr?=
 =?utf-8?B?UWEvT3BCQnFERm5kK1kyWDA5SWlNL2VoV0FLaWtXZVhPMjRtQW1HVjhKRXpX?=
 =?utf-8?B?dlBVWWtiUUxnU2Q4dk92eHIxcU1vNjhnOUFiMmJ1T3ljQ2xsYXl5K1Z2RG5E?=
 =?utf-8?B?cjhCbkl6MCtHQVZUWW0xR29pM2U1VVBwTTVUdGdTeTVoaXM0ZW5scDhkeXpu?=
 =?utf-8?B?ZkRnOXlZTXJvZUxsN2FVVWJYNktnODhpYWxvckczU0tJNkdRWjdoMUdRRXRn?=
 =?utf-8?B?RTZOKzVRdXpPdHNNbTdFM0JEODlENFZXQW5tTk1ZcFVpN1YxdVpMa0VNenAy?=
 =?utf-8?B?czdYMnN6Wlllbm9ERGpDZUFXV3pLQXJvZU9ZY3Z5dkxXUzQvakhudXpCd2Nu?=
 =?utf-8?B?QWZGdVV4YncwaDg2NC85TkQrQlN6ZFdZTFZESkdSblhOYXNZZmtDcld0QTRF?=
 =?utf-8?B?ZzMzOWxqWHM5V2hTcitiMlllQWxld2VvTElBay9pOVpLZU5PS3BoTEZXcHZl?=
 =?utf-8?B?cW14bXpzcXZaMlRTSWNScDIrWm16TVFLNVNmaVNFdjFyUXpadFg3aDNQUFZk?=
 =?utf-8?B?dUxCMS90K3BKWkgzWHR0NVNjclBoRzlvbDVWZkFYOGcwTzB3NVptUWJCUlJV?=
 =?utf-8?B?SnFpazVXZ1BEdFZhcVYzTHhpRVN4dis4VGZvL294eURIYUhIVTRhSWtabm5B?=
 =?utf-8?B?YVJlVGliT0tZY3d0YmtBWVE5Q2RLOXpBa3Z0ZVA5QWZLUm5KeXRPM0oxekZ3?=
 =?utf-8?B?RDlJSkdNeU5lUkxPRHFsQ0g5WW5rY1FWT1F1M3dwYjI1bEdtaUF4ZStHRHR3?=
 =?utf-8?B?SUduM2p6QVhFbHFzclR1czFuSkVBeXVGTG1DVTBHWlpkaUZaT1VkU2o2aDN0?=
 =?utf-8?B?ZTk0R21EZ3lVaWlWZTMvK1NMTndJN1h6Y2FhYklLQ1lkOWluY1pheSswZFVm?=
 =?utf-8?B?UGRoc0FLQ0ZLVVo2dk5LaXc3TmwxOVUrMCt0NDJCVjNQbXFSTVFDRDMxYkRj?=
 =?utf-8?B?NzZNY0tmV3NzS3FkUmVadGhTMWEwbWNMNXBBTnU4WVMvR2ZkOGR4SGpiTWZ0?=
 =?utf-8?B?ZTA1THRwQUd3MW1zaXFVVTIrMlA1a1Ira3B2Uko2dU5rNDFneVZYNEQwSTdi?=
 =?utf-8?B?SWk3OWduZWRRRUFBS0JNU3FSQXJyVkg0amlFZkVITzhLZjl1bE1uWHJtZVl6?=
 =?utf-8?B?U29FMlo3OXlyQkpRcDA3NkczTXNwOFRZTXg0MXNQdG9xMFY4WVdodGh6T1pD?=
 =?utf-8?B?c2hRVzIrK2gxUk5GWC95UUJRYmxScVRZcGhFbXV1NDVtMEVDTTVQdE9iQ2Rv?=
 =?utf-8?B?VEgyK09TZDRVb2J2NXI3aGN1SmpnbzNUMlg0YzVXWUZwM0V3TjF5a1EvLzZh?=
 =?utf-8?B?ZHB5dFdpeUdBcU9ldWZiK1UwV1FxZksvQVhwbHFQSHM5UGlhRS8zQWFscGw1?=
 =?utf-8?B?NDMvR01nYktQcGVDYzN3NlFINFNLQmdja2FPY2F2Z2NHMklpRmMxQ0pwRm10?=
 =?utf-8?B?VVpZOFJWanhGcE10Znp3YkVLVWsza0N3WkJYZ3BLd052US9TZEh5RktMOFNV?=
 =?utf-8?B?VS80bERaejd2a0JWbnJxbXk4TTF3clZ3WlN5OTJCb28xTDA4a1ljYU1FL0NR?=
 =?utf-8?B?R0R0eUs3dmRnNkFrUitHVUU5LzRadVdPRENScGJTNVgwd2RjWFNFUjJkM0tS?=
 =?utf-8?B?MVEyaW56N2RKWTJRNmVtSkRYWEdPeUdvWnorWUZHN2pKY2RYZE94RmJRai8r?=
 =?utf-8?B?REk4cW1xNkxTZUpWVTZHLzhNbW5EZ0pieU1LemZpdHZoN1RtV2cxa3U3VnNC?=
 =?utf-8?B?TTRpSWxDZlkxVlFEbDFDWWRJb2t2Ry91TEtKZG15OFZhMXphN2NmT1d2WDcz?=
 =?utf-8?B?S3BYVGt1cnlQcDJxTW5vYXQzejAyQ0VEOXpPNWZzenJsY1B5T3RnZ2pjQitU?=
 =?utf-8?Q?c/SNtNe1wd+PiBWs=3D?=
X-Exchange-RoutingPolicyChecked: KTHQOOgW+Xd0WTyXhpltQMmA63Rm34BksyELQWV6jj+mQm39pnrHgyABiyIXOwC5znOclUtq6L+gP6qFgzdQ+ciCYTtyUnEaZuVLObijgzjh66/hBWrleQRRtO1SkULqb99WZdl2Raa3JU/5/cqBTf5PBVn0jjARzgWaFWZ5F3te5MhnKw27iiku/5RG0fsflMtsR5UIKpsxUsHUvPK4aqFIQDRPyigy7jSfP6UDqZxi4xsnmHyBUQILvdkQoXzP83jHEGOwsBIaH583GiAmx+ejaVmZm74WcOROEQbeVGOGWnZlIMRKlOi+BHFK3oz5xkGwI+eKlT5O32QQ1NqGmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe87b53-92f0-4ebf-7cd9-08ded1ebb7dd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:25:46.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruc3gicGE7Cxq/AmZtq7AIm1XVaVqOn2mmEQ/0RydPPvD2LKqZXh0iw3J4Lq5j/ST+uIDUCLiSNxYFdjYIBhA/DyFJlXrVWejy3Qi6jGHMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9013
X-OriginatorOrg: intel.com

On 6/23/26 12:17, Jose Ignacio Tornos Martinez wrote:
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), iavf_set_mac() is called with the netdev instance lock
> already held.
> 
> The function queues a MAC address change request via
> iavf_replace_primary_mac() and then waits for completion. However, in
> the current flow, the actual virtchnl message is sent by the watchdog
> task, which also needs to acquire the netdev lock to run. Additionally,
> the adminq_task which processes virtchnl responses also needs the netdev
> lock.
> 
> This creates a deadlock scenario:
> 1. iavf_set_mac() holds netdev lock and waits for MAC change
> 2. Watchdog needs netdev lock to send the request -> blocked
> 3. Even if request is sent, adminq_task needs netdev lock to process
>     PF response -> blocked
> 4. MAC change times out after 2.5 seconds
> 5. iavf_set_mac() returns -EAGAIN
> 
> This particularly affects VFs during bonding setup when multiple VFs are
> enslaved in quick succession.
> 
> Fix by implementing a synchronous MAC change operation similar to the
> approach used in commit fdadbf6e84c4 ("iavf: fix incorrect reset handling
> in callbacks").
> 
> The solution:
> 1. Send the virtchnl ADD_ETH_ADDR message directly (not via watchdog)
> 2. Poll the admin queue hardware directly for responses
> 3. Process all received messages (including non-MAC messages)
> 4. Return when MAC change completes or times out
> 
> A new generic function iavf_poll_virtchnl_response() is introduced that
> can be reused for any future synchronous virtchnl operations. It takes a
> callback to check completion, allowing flexible condition checking.
> 
> This allows the operation to complete synchronously while holding
> netdev_lock, without relying on watchdog or adminq_task. The function
> can sleep for up to 2.5 seconds polling hardware, but this is acceptable
> since netdev_lock is per-device and only serializes operations on the
> same interface.
> 
> To support this, change iavf_add_ether_addrs() to return an error code
> instead of void, allowing callers to detect failures. Additionally,
> export iavf_mac_add_reject() to enable proper rollback on local failures
> (timeouts, send errors) - PF rejections are already handled automatically
> by iavf_virtchnl_completion().
> 
> Remove vc_waitqueue entirely because iavf_set_mac was the only waiter on
> this waitqueue and after the changes it is not needed.
> 
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v7: Rebase on current net tree
>      Remove the multi-batch processing loop from version 6 according to Przemek
>      Kitszel review: the loop cannot work without polling between iterations
>      since the second call would fail the current_op check. Multi-batch scenario
>      is extremely rare; send first batch and let watchdog handle remainder as v5
>      did

I was fine with v5 already, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

(we will see if Sashiko reads changelog notes (--- section here))
