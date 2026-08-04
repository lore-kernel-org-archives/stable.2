Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB15439F9D;
	Tue,  4 Aug 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877482; cv=fail; b=p2nVVBMa7bWF2ycVQ72/6sRmeMBxac351SdKsNIQu4B1j97pP6+TAV0xXNF6948UN0xkafpxUZrgIwYHzGF/9wPcHlZi9YNmxA1pnyUOBwHkdH+Ve37Fm9lL/U5dcM5zkCd3tb4s0cLgkF9xtXsq4C7X8PO0+cDMQQMfCU9dwhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877482; c=relaxed/simple;
	bh=yASFh25a1XAnICNo3IeiCM4YFQveMYl+9b9QXGRLw24=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=J7zwHnIr7z+0llqwXiFZ+0/zDKCgXS2nzBoK8uNksw6EGQOwUHTAWtOJgJZeAn7Mty1yH1OrnW0ze28yZFzhLW7rapImDa9dWstwvObohMqbxwz7LTuulgdKbW3bni8Ltve6pAFGHLkLI2toCPxtC2ZkSmD0DKcXgKhWraXfd0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PISQglBQ; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PISQglBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWlNLkOHwT7fp+2eyhqHTcfSlne6pnaBDsq4owkS7v+NZsxdUEbESVYzuPM57QhnoR2jCgqacEs54ln9SVU1Nl46N8HA9e7wJZ2gJRBH3Dc+2PXO/HAC6fHpqiUBH+mSUVd7+dQQG4LldptVLTPT9wg9KHIb6dJYrA5mCSqQ6VsX9Cl3B4X2UpmrFhmbjNXq5OQKT8ec0JYYWZIneEkATGDXW5Wo8YxXD91UsnX4vQaIbJMtGufoUn/1Z3qnEPWt1yQlAN0bxYr3UfIOiNxti7yxgmjtqwQ5Czpj0Zp1hLCxCAk7RShuAX3Mj37dhdlRt7OImF/nG4rN7nICvzzUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4gT46LGphXGJiLSjg089nv/cIXZ1S8FSkL2JbGMz2w=;
 b=WWwyVpAk3CJqLAu0IyIdiwNM1GlbVoz6/wgB/TxJ9tG5c6Q9FGipX4DkKZVjBXktZj4kSyf5Ii/nQRxIY3diroCH7Fu7eyx3XzQd+4Bs5Eq3Qjo2J97KagvGIypIbRBVP09cGS0No3mltIutjDxHC+LnBMSDgGkteaPqGiAP1eog+HbpZFSI2jfL5+GeNdNeZN7K7Xj2VUGB/RbbUOW/tZ1nUCasxKd5Y8K8FmJAhtKglGqdq2F0ZnoWnvBtvNFhWMX0VKChFSEuMf09PERWjkx15pUpi92dl9LIKyLjMDq+NeyVDZ8fHEvFqfME+m01xR3NVhgVAXF8t+C+IBR53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4gT46LGphXGJiLSjg089nv/cIXZ1S8FSkL2JbGMz2w=;
 b=PISQglBQtWhqmCg8Nqihb3XpToLicPEp5ucRM7BOEd+EpCyjUgbqqVMKu1sXk4yoSQUeanj1n/WzLH4tl5xcQBLjdliVzaAK/FVHQ19p9sXkNWWr/ZLO7v38ums0riwtPfxOyHU3lWVBzgnxsBb5ARFfE5cv/Grwg4cpygvHNI9PPNXIarsLPTTSQ6pW/zAqrV2fRCEL2GU+tnqukVih628rJK/FoLUH4VT+5CnioCS6Era/PhTsa4QCsxh4XaNIEOMQnTqdyIK+yxYV0GJ2vjEJsHWRpTSDsDg60JyZZPhA34vX5leU7i7JFcWhxU1avHCGPsnP6bKxOOVZbQ+eNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) by
 MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 21:04:36 +0000
Received: from DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a]) by DS7PR12MB8371.namprd12.prod.outlook.com
 ([fe80::23d7:9e07:1de8:d80a%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 21:04:36 +0000
From: Zi Yan <ziy@nvidia.com>
Subject: [PATCH v3 0/2] Honor XA_FLAGS_ACCOUNT in xas_split_alloc() and
 charge to folio's memcg
Date: Tue, 04 Aug 2026 17:04:26 -0400
Message-Id: <20260804-add-gfp_account-to-xas_split_alloc-v3-0-38cb3ff325c5@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpTcmoC/5XNQQ6CMBCF4auYrh1DWyjVlfcwhgxtgUmQEooNh
 nB3gZXudPm/xfdmFtxALrDLYWaDixTId2vI44GZBrvaAdm1mUiESnKRA1oLddUXaIx/diOMHiY
 MRehbGgtsW29AS+Sl0aku85ytUD+4iqb95HZfu6Ew+uG1f0a+rX/xkQOHc4VOlZVKtdTXLpIlP
 Bn/YJsfxYcpk59MAQlkmCkjpOJWZ1/msixvQEtopykBAAA=
X-Change-ID: 20260727-add-gfp_account-to-xas_split_alloc-83a1bc848b77
To: Johannes Weiner <hannes@cmpxchg.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: DS1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:8:454::18) To DS7PR12MB8371.namprd12.prod.outlook.com
 (2603:10b6:8:e9::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8371:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: b7512dc7-ccc1-4cbd-6b86-08def26bfd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	E2TDaAS9Dxx8JAvm22kqXm7FgK37a7FXJ3M+jFIog18NNw/D0JfxRDtFKaEJG0hfHUFYIvD1R2QZ82mcx3AIYXelpivCfbqBMRyY6dpn66BjAjCgHXQ1ZPd2OSLMaPw2HSmhrCmEJuO0xFx4yl2+mDlEzq8cQ533x8VPLuoQ3fPTBmKaYOyvFyeZKizH6Oq8/uBnEYtLXAlWftj4tMk8xSKub2e99VZJuWcR6nAeHNg5d7NsLsNJGsHxe+QdjdZufssMAqGk1OEIY33fAG6rIWGFswuvVES97oP+1F4yguZ9uOEGM/1TY5FTmtv+Y82Q4yX3ctCSKXq8+INX2sHHXiCErjjcMXIUz+bJOcfu1bYz64V/nVeZvTQnRwjEd2If0Tyv+BRstQwQAFKl/lTNgAUVKJa7SAojeKgWoboNKD+v2p+uMG1wN0kzpRF0PTHenIuQh4OjzqOytSqb0lQ0XJVJKJgUFfUkgdwGuan2M+FhQv3gxzTsmauJG3woDV5EC9h10n18KJkzsyQ3vfzwpK/OknuxX/HnghUlmLciRGoJluhG57IxhO9/0JG5hGtLqdge67kU5AX3UmDXXkZSJYIVT6ie0clDm1+UN17vROwYPieDiRg/u8AKC5ecouKz0Gcr8yVe2qhRn+sYiuj+0J9GcT2pY2GjZtjFVZVjdRlzRs0dT4SlwJw4OwYkVdS7LT7wRjVWE2DQJDVdHV/64Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFRBNXpadmY5OThzNG13cnlNNjM1TnB6T2ZFYzNEb0w0YStscjZHdTg5Lzhz?=
 =?utf-8?B?Y3FobEtxUVFpZW0wOTBLOTNYWDVOdXUxVHpzaDFkMStvWnhCanBVcm9HaXVJ?=
 =?utf-8?B?OEh2SVJqOXozUkRQcGpsSkxzMmJWVVk2RkVKam5WblQxSTJXWmRrVmVPeS9t?=
 =?utf-8?B?TFRkd3ZLaGpuejFqU096NTU5aW9lRmdsMlc1QmpiTGJqNnVqZ0NRRjhLdVVw?=
 =?utf-8?B?dCt5LzNJR2RqM0FzWUh2emNmeHJIakRWU2QwZ1kzdDIzTmtnWmNIOHR4aEMz?=
 =?utf-8?B?Yk1LZXZBZ0tVMFpQaU1ZS2tSYndBNmduM1NiRHdxNHF1eG1UOWZOV3VhNDJJ?=
 =?utf-8?B?Sy9QVXNNTHRtV3JrTWNUV3pSK3psQU9VejlMWGdSd2IvZG1vOHFHK0E5WUcr?=
 =?utf-8?B?Q3lCUmMxQllwU20wRVJlTDNaTDVLUVFUcDJVdFFpTnYwSFYrVkxheVJHS2VJ?=
 =?utf-8?B?clQyTVlWVHNZUk50N0dwVzhBbnlKRzNwQmJiZk1MenVIYzRlanZNNXRBYWhH?=
 =?utf-8?B?UWNXcE9uRkh6RWpjdHp6VjFGVFAxR2tQd0JnWVpwWUdUck42NGNGZlJSTmRs?=
 =?utf-8?B?Z3YwMlFZR1ZyVWdoRkxGN2g5dFJPMHpJVGN5T2V2SUNBK3JMU2FieFAvaXBO?=
 =?utf-8?B?Wk90aW1yT3haZ3B3T0tuMGxWZUVTZU1iRnE0VllxbkI4a3lkKzJQK0ViUVE1?=
 =?utf-8?B?a1pLOU5TTS9LNnBTWjRGQWlhQnNHMEZsLzZVRUd1aWFXN3ZxcDFESzRwV0xX?=
 =?utf-8?B?RXBDRFU5aEZBUGh0bmZEdGFOV3VsOXBpT1ZxTkVJckVTSWdOc2d1aVFLSGdp?=
 =?utf-8?B?aVpHK1RpTldjaDBwbWNsNVYzbFY2Z3VrQTdhRmJUenE4MW5GUFU0b1p5by9Q?=
 =?utf-8?B?WHY4eEY0bzQ1aGdSWndNcVFnS1hxM0JzQ0twMVQ5R2xMOENYVHpObkpOZzVr?=
 =?utf-8?B?UHlEN1NYcUo1Q2NxcDNCNldVUDdrN3ZubmNEUStrTmNhRlhNSTg4ZmN3SERU?=
 =?utf-8?B?ajBuNmFvbVVMUms3RlcyT21XWXlQN1pXd1BZdGx5cHloNDVtMEYvNlhVU1hB?=
 =?utf-8?B?MzVpd21adjNWQmM3VXY5bEpjT3dwQllXWUd6WWtuNC92UG9pcWxVWDhteS9J?=
 =?utf-8?B?d3ZXa1NTOWZlaGg2a3dmTlVZZlJvNk52ZTllR2NpRzJsYzZVcVBjWmhSQm5t?=
 =?utf-8?B?S21hUjFWOVNVaCt5bEpRTzNIUnQ1N0FHMEZ6RkhlVm9xUktoUHN6dTArV1Yr?=
 =?utf-8?B?OGE3ejZMSENrLzBDKzN2VjlSUWxuMUVXQUwxNFJRRU1GWitmZDU4bHhyeWlo?=
 =?utf-8?B?eUtidU1BSWRFbWdJUUtXSERmVlMrTVFGbUlMdW5idEJmcTNIbjZZNlIxTDdZ?=
 =?utf-8?B?dk51d3d1T2FndFhDbFNMNnlORGFvbzhjQllDZStmc0NXNW5EdTNCMXVWa1lI?=
 =?utf-8?B?bmR2VmJJUmVJQVlrckxjWEk1U3BaMVFWMW8zZWFGdXJvcm4zbkhMczdsSmNH?=
 =?utf-8?B?MXluUVo3Z2tRTHhmUGt1S1V4YVNzQ0hjUUVZY2xDZ0N5bmFrUXFBNkh4ekhR?=
 =?utf-8?B?T1A1eGIzRjFGOWdMU3o2MnhtN1dzZ3lQQWxwaXM5c1NGRHRwNzNZZmRDTHRN?=
 =?utf-8?B?ME5zeFMwWnc0alRLQ080WmlnRWRvQ0YyWXZGNTRIWmFMMmFRY3lvZUMrTm9u?=
 =?utf-8?B?SE01K2lYcWdzOENPb0wvdzRPNHdZOFpBdzFsYXg4c3o4VmNnN29EUncyQ1hv?=
 =?utf-8?B?b2xuRUpMV2lxT21LMytxaDVjdGdVSG5TbjJ4WVlIb2dWcTF3K0NzT0hJSFpn?=
 =?utf-8?B?M3M1WFZSSTFyV0JiTXZiOUxxcGRSYWU1SlpZR0s2Ri9sVS9FUjRkeUJRTHVk?=
 =?utf-8?B?eGNKMVRJc2dXOFJwdlJzVUlhTmU3dnQrc0NhdU0xVjRwd2F0Si9KLzZvV3hL?=
 =?utf-8?B?eVBuMDhPSGp4bWVqS1BEcEROZGd4b0xHVDhKUWpLUHZGeCs4ZExQSlJmZm9p?=
 =?utf-8?B?STR5aEhOdDU3QzNXMU5zTHdzQnlYN1orbzFEY3UzOGdOZGtoSWkxQXRjMlJr?=
 =?utf-8?B?L1RCZWpNdU43WXJkS3p5blVtSGg1ZU1aeFlPZ05DZEQvekgwTXlIOUFrdmNr?=
 =?utf-8?B?U0x5UGdxN3FjdnZtUFMvYWlUNndSRTBJVUNpUkhYZ3krSnpRY3NNS2RVYllZ?=
 =?utf-8?B?OFJxT0hUTktRd1MreW02TlF4UDJicUhqV3dhdThSYURVVEJzdllvbFlEV3J0?=
 =?utf-8?B?UEhUNFJqVGdiSTNzc3Vnc0hTQU9VQlltT0VRSkZ4N3U2WldtRXI2emNPUnBM?=
 =?utf-8?Q?sBAdOFxoL/JUbgelDN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7512dc7-ccc1-4cbd-6b86-08def26bfd57
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:04:36.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frd77H8FZ8BhJ89nUwSRvwqdVVzQllQxxLuoF+2fo+/GJsTmKCcXc+lXJqmRN9gC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269

__GFP_ACCOUNT is needed for xarray node allocation accounting when
XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
convergence regression") fixed a workingset regression with it.
xas_split_alloc() does not have it and needs to be fixed.

In addition, based on Sashiko's review[1] and Johannes' confirmation[2], to
charge the right memcg, folio's memcg needs to be active during folio
split. Add that before adding __GFP_ACCOUNT.

There is no workingset convergence regression related to missing
__GFP_ACCOUNT in xas_split_alloc() and the impact to userspace should be
minor.

Both patches need be applied on top of the mapping_set_update() fix[3] to
avoid causing the same issue for uniform split path.

Link: https://sashiko.dev/#/patchset/20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838%40nvidia.com?part=1 [1]
Link: https://lore.kernel.org/all/amtcBZ-_QVRgCd6b@cmpxchg.org/ [2]
Link: https://lore.kernel.org/all/20260725101419.3938406-1-matt@readmodwrite.com/ [3]

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
Changes in v3:
1. Cc stable
2. clarified Patch 2's commit message
- Link to v2: https://lore.kernel.org/r/20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com

Changes in v2:
1. added memcg switch code to __folio_split() to make __GFP_ACCOUNT charge
   to the right memcg.
2. removed RFC.
- Link to v1: https://lore.kernel.org/r/20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838@nvidia.com

---
Zi Yan (2):
      mm/huge_memory: use folio's memcg inside __folio_split()
      xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()

 lib/xarray.c     |  3 +++
 mm/huge_memory.c | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 34cacd0ac7c10dc9e34e1b9f28a2b78d335cb487
change-id: 20260727-add-gfp_account-to-xas_split_alloc-83a1bc848b77

Best regards,
-- 
Yan, Zi

