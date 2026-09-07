Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CE479872;
	Mon,  7 Sep 2026 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788800743; cv=fail; b=jTjkrc27Xsi0pksn3OvnxLedQsSSFHQxxSTvo9vc5MbdtZYivPbKdZ/E8iafhHOlhYfNeOET9JEOxhOr2Nc6qNU56h5pQs7csUwMRnaQ0RojNhsOdhuXEQUPr4xRAZcL5CYgUKz10jmTAka6PWPfEI1E6rOmzTjpyBYfmeGlbdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788800743; c=relaxed/simple;
	bh=3v7w6PxqkfmF2ZiU7UQIzXt79pXKP9df2tOBD6EYI+0=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=Ba2W3/x6fjdbQvnHRv2p6Ee0tgxQ9NidkXTiWKr8nRMk0Sv3c9ACxlyjqdNigmPY1kUGjtr+GCgPByKrMUhGYypQMgby703ztQyElpo11k0DxGEdCyEuooYmOraWagMQe26o4oStmdUbWS16CM/TH0ebvq+CN+m6A1k2SBLda1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kT3XdoaL; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kT3XdoaL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUD0lu61l1K+3+Bu07R7gaiT0bXvud/Shz7SgmFSnWiCO4TbzWyIUyBtCnUnNoouGwnT5IU0u22t4lihAWJkNipck21WvwnwaNENvIDDl3A+CrmgvHHx++Pm63o9c+ckXApXduz22XbXvSgu9AXGPh2/3Ezr384sZ5PVp708il3PuDy23BJX03T6vTGvkvZH19h+zVXTpKjcchJdxDOj8vYv91xZ6mlulgeXnnUI4TNLb+vZEz3A7SuaLb74XsgeB0AOJxsd7TcXXoiKLmw3u5Y9emoD5lngfiupXfspRvJuX0JOyE8t3xOjbSK/MH7HNTXtzrhyUUWSNS/8zusVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3v7w6PxqkfmF2ZiU7UQIzXt79pXKP9df2tOBD6EYI+0=;
 b=eISoDXJZra3YPoimKtiHWOVqVTouI5IRUNcyJXdJ81plSBwoTAWIBhycPic1l+m5eiwGWq+n4w/lp4pXqSkQ7O/7hEIcskEiGkSRHWeF6IsBwYQqnGg+DLIh78WbJXrswVfWM9e80DNOtVKkFpJMe2AtdsUGDX7YghFR8eSVJC4aJ4UVStLZRrhqeHkHDRqaBiJ7LAMdpdAcrTRi++9W9s/RjdRKOQZsPYW5XI14qZdMUbvCOTCdwefs1kh/fqeKnn73SxvT8gPIziRAjNYlJL2rkzagrIp1OnZbbHVo1WpfaKiIWol4/ZCxGFSq2q4rWLjr/qr+iLTvjRUWluF4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v7w6PxqkfmF2ZiU7UQIzXt79pXKP9df2tOBD6EYI+0=;
 b=kT3XdoaLYeIhlJGjeM1yMwXORaCaXNQTbyaGkcFq1a7dGmD82MdXb+bXgmKW2B7E+JfDR3jgnjvgbk3GQ7GjK54QnJeUN3aZw847XpHmATcQeIw84j/N5CSUNJmEI+CbcPGwMz2hUxAkMKyShPYaBj6wO2kD3F2x/0J6/Vs6SDXe1h2Sgjcy2GjKjdATP4hfDF/DJpPVg/vSrU7c97iiv+Qv/dH7IroTslHnRnyk0v8Q3wJrdUuMifxlb2oj7FHS0gheDWpHn2M21X2xrzrZFVP7vVmPt3Un9ZRRmUxPYFxls9c7zLxTEnffZHw/KSPg4pQwsQlzyqMmF15/KhrMaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 17:05:38 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 17:05:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 13:05:37 -0400
Message-Id: <DL98XU1QOKDM.U9TLB4G5HLXY@nvidia.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>,
 "Nico Pache" <nico.pache@linux.dev>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Usama Arif" <usama.arif@linux.dev>, "Peter
 Xu" <peterx@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Cedric Le Goater"
 <clg@redhat.com>, "Saravanan D" <saravanand@crusoe.ai>,
 <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Lorenzo Stoakes (ARM)"
 <ljs@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm/huge_memory: bypass THP tuneables for huge pfnmap
 mappings
X-Mailer: aerc 0.22.0
References: <20260827-hugepfn-allowable-orders-v1-1-94819c8807c8@kernel.org>
 <DL08J4JGJ4UK.2G92WO0NK8XU3@nvidia.com> <apEzvfGgsvbc3vBI@gremlin>
 <dc52dd1d-f62d-4278-ab4d-95746383fd50@kernel.org>
 <ap7i1vLkfZj4rbNM@gremlin>
 <4743f22a-c24f-4f93-80f5-3260f29bd410@kernel.org>
 <ap7mZ1Ktd_rRRrdX@gremlin> <DL98S34F6I6L.12UZGOT6NF1J6@nvidia.com>
 <2732913d-dbee-4726-aaad-c7c60b6c62fb@kernel.org>
In-Reply-To: <2732913d-dbee-4726-aaad-c7c60b6c62fb@kernel.org>
X-ClientProxiedBy: BLAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:32b::14) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY5PR12MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: a50494b5-8ad6-4f82-a7ba-08df0d023d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5QRQqStG/KiVaCEvfYjId5T6SFDYUV97v2JB0t3g4C3jwAqy2pjYmFRuwWupQZCZF3zMt+brbRpk9MphS7V2D0gRAIqxF8c4OZR3MilPfZKlleKiAsHS2g8TQREnNITkvFnlo0HBdob/jknNXA2aCZR9MJDNoQ9FxEp5ENwHeM8BGvMw/ozVmCCYFvi+OLl1gCZYow8jinat4jUy2VLqBDNGoJ7nWQAlp5HxbfnCjxUpvvS8WpNMgzmJLIGzaoTduDJ7t7CT1fACQdZCE4fp4OgeeCjY0Tiy0C/fOQvQmC4FK/MpL8Vi1C/E/mDCH64VmmN68wSQZHBYmzFPBes5ZqVrSAhmYiiquObxpHuWhCPD7dcS+b0IiQ3GmtpedThvduK7eDUurC7TEeKsBzLRC6u7F2Q15iMX5q9ACKSak5Kqlw0v4MT3DM/P7OQLgQiAImk/PPVDpWLd7ucDN3fN+OAW8vuxWBcL0lh1IjJ1WSmR0Xar8M5djewSu3CoWCI2znSK9Yx46elcvMdXS6e+FfvyV1yW+WiAYicWZFRXFO12qlR5iOJ9H3v+cXmU//XeUFFyCch8l4vdIt5rxgRNj+34pIHzgubGstsgGetcSzCc1GbCfMEHH5IIarwPD2ULIOy+DN1J/KjdEqQ5neF6+WLeWlZ+m/LC4g3MLX42TaY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2cyT0VmdXJSS3F0VnF3TmxuRXFrbWZnUjhiT3JRV1lIK0ZHNVlDVWU5WnMy?=
 =?utf-8?B?UkU2SUhUaWl1NjYvR1YwbCthVEp6NTI2SFE1VG53UDhkTTZmOGFyRkQ1QjNJ?=
 =?utf-8?B?MmV3ZFdnQ1V4L2hraWJ1bWVUU0ZyMmxabEZONnppbldVUUo1WEVrZWQyTHp6?=
 =?utf-8?B?akxtdTJsSUR6c3BtNGxzQUxCeG10UnppczNqOXhUdXhyRElsYVJJRXVrM0Y4?=
 =?utf-8?B?MXo4TVNRNFF1clg4VnQ2bWVCUStIK1dJVEtXZGlkOVhCS3EyMEI3cHZpRU9L?=
 =?utf-8?B?Yzl1Q0RpUkNqRVBCVTB3RVEwUVM5ZkROVW02SVNlSWhOeGVWR3kwUUd6L3BQ?=
 =?utf-8?B?R3RwQ0NZYWFjQTVSWnhRVG83VUloM1NNUFhlVHpIc0E4ODhwSEloZ1NwdjBl?=
 =?utf-8?B?bk9MSkZvUkdscUtDcStnVVNLYWxSMEF1c2psYUdPMTRiUWRLOHN4QlFNbCtP?=
 =?utf-8?B?cGNYYXMxSXNXWmk2WTF1UFpvMmJub2J5d1lUc3YzMldhSk5yWDJpU3JNdTNH?=
 =?utf-8?B?ZjR6VWNkUmRHamE0ejNHL2RqUW5rUUJ2RWo3clFFakJxakoyd1k5NGpEdHdi?=
 =?utf-8?B?cHUxbjFNS2JHd1pYbFdDQWFmbDl0RnNLT2kxT1ZNaG0wL05HcnE4b3kvR255?=
 =?utf-8?B?Z2JYNkNuWXJFdlp5ODR0RWNTcmtrSlRlOEdZMVZmcUZKWkhvU1EyK21MTmhJ?=
 =?utf-8?B?RzhBL1pmcnpFcDU4ZmhXZkVaUjN6QmVSWURJNFRFRW9GNHBsN0tJcHRBZ3R5?=
 =?utf-8?B?Y0Fwbjk3eSt6NDBvbldJTkVROTQ4K1A4MDFGMFMrc1pPcGszSkJZams3Mjg0?=
 =?utf-8?B?Q2IwdGlhSFBjZjNLTVpocTB2U1RxZ2tvd1dWWmF2b1hxeUlMRUd1MU56dGJL?=
 =?utf-8?B?T0FoVHhIcGhvTlZpeE41TDNnTytadnhLM0had01oeWUxaS9iblhweFlmeGUv?=
 =?utf-8?B?OGxrd1VJbDdQYU5Sb1lrL3VCM0x3QWdlYW9jdTg2bG5tL2ltT2FuR0pNMk0y?=
 =?utf-8?B?YU4vdXRaMmVYRjhtS1Bqam5NdUp2Tk5QN1dTVW54ODkwY3R0aTh5ank2bmFv?=
 =?utf-8?B?ZFp5RVlsKzIxeWtrK1oyWnBmWDFyNDdaeU9xV0VNRGpjZytaZHAwVWpXc1cr?=
 =?utf-8?B?UW1tY1doYTdycCtPTWZqc1RvUGl6RERxOWhHMUdGV1E4dmQzSUFBU0tSektM?=
 =?utf-8?B?bnF2MXZxQk9NSjZHR1RzMmhhbDFUZmcvdUt3Q2FUdThXZkFFWnRMU000bUI0?=
 =?utf-8?B?SHI3SmoyWFJUU3ZMazIyNWYvaGdKMExGRjJralBtampNNHdCT1NWdU5jQkJT?=
 =?utf-8?B?RkZ0NkxEY2tNaFMrNGVua2l6dy9MR2tZMFBMRlBwMzVQMzNnR1VzZEpSYUdo?=
 =?utf-8?B?eWFuQlA2VVRiSk1jTUJscmtFVXlIL3oxOC8vSDkyaWJHSko1a1lDLzRzZDlz?=
 =?utf-8?B?c3V5Wi9adEdFNlpKOFl6U3EwVFdpTEp3R2hYUlNSbmpEZkhOaFRCaFNLQlNZ?=
 =?utf-8?B?OTljc3l5bXBvQTUweklZZWJOeGhabENCZjF3Mk91OThxZ0xtRUV6V3JjZGU2?=
 =?utf-8?B?TmVlNGQrb0VOeGlvMmRKTHo1WXp2TjJSN3JrTW5WLzNnMVd6WlhOaGNXMGgx?=
 =?utf-8?B?RTVxTXNsdGhCSStSbmtUU083SXhQcFRzR2t3S0VIa2ViUisrUmNCRkNjdWlU?=
 =?utf-8?B?blQrME5jOUcwSng2ZFpJaXlxM3JkTThZeklpMkVvZUc5MCtlU2FzQks5TW04?=
 =?utf-8?B?TXVXbkVUR00rOCtlM1NyOEZqb09OZDlHT1NEc0ZZQURaVHpzMmdHN1BNVUZ3?=
 =?utf-8?B?K2pOQ0s2dDFiRzNqaXRXdzR1My9HaFYxaTZTcHBBVHNieW8wcUFMb1JZazBv?=
 =?utf-8?B?SjhaWlZjQ3VVdzNsd2ovNjBvRThxK2xJeUpPTmgxbEZqOGlDL1J4b2JQeUhz?=
 =?utf-8?B?Y0tGMlNIc1Zud3dxcFNDMkdMTHBheUdMOTMvLzRoRVNCa2ozU0JPV251UzAr?=
 =?utf-8?B?L0ZRalhyUnRyWUYxazJhaEJUdWRqUEk2NFc2RHA5VmUyMHZvRHlMdnc0S3Z3?=
 =?utf-8?B?VTNvSjB3alNySWhKazM2ODRQQnpEb0dEdU9GQk9DdUo4M3YvQzM3QmZOcHho?=
 =?utf-8?B?cWU1MHlsV2YwR2Nsb3NZNEtnTkVsRUwrTlVIcjIrMHdMTkFpeHZ0YkkzVGRL?=
 =?utf-8?B?V1BZNkNPeW4vN1pJUDF1bkprY29BR2IvaTFGNEpYUTErYzlFRWJ0SjB1d1h2?=
 =?utf-8?B?M0c2VDF2Y3NkdHB2cmlab2NLOUZyN3RUVHpsOGxwZDRDUFpkcGVtclp6Szha?=
 =?utf-8?Q?64R5b4xzw9705jeFqF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50494b5-8ad6-4f82-a7ba-08df0d023d5e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 17:05:38.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypP7QF+fBnzt3jy4bpIjwKYYiZr6AExfWEmijVa3SRwq0vgp5e/N3CxBmMVcNp5V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055

On Mon Sep 7, 2026 at 1:00 PM EDT, David Hildenbrand (Arm) wrote:
> On 9/7/26 18:58, Zi Yan wrote:
>> On Mon Sep 7, 2026 at 12:30 PM EDT, Lorenzo Stoakes (ARM) wrote:
>>> On Mon, Sep 07, 2026 at 06:19:30PM +0200, David Hildenbrand (Arm) wrote=
:
>>=20
>> Probably worth putting it in the process documentation. Always resend if
>> a patch has any change.
>
> For things like fixes for spelling mistakes I don't really mind. So "alwa=
ys" is
> a strong word :)

Sure. At least a fixup could be sent as a direct reply to the original
patch. In rare cases, such fixups can become messy if more than one are
sent and a respin is better.

>
> But yes, such stuff will be documented in the future.



--=20
Best Regards,
Yan, Zi

