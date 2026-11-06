Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984404;
	b=AgcMy49ZzUC5HZQujYlaO2oKbriW62B1ue7A/rFEAphYZPmo6Mqv2dQo8zi87BWRMLoL
	 VLzuiMKjoFKm46DeF7GX6ooPpmmerL91Ja/9iRtNNGML9tXlYfW2bmFkErZBo5osDUmY4
	 g6sE7K2Hc5GqgkEG5HsSzTzpOUefmadETKyst2c5p4X5Uu8BYaU3nq/j2KDwzK81rpRhu
	 i88mCzQSA/bpjOlFo4kfvEB05OySrHaaH1H30/im4KjXRbQ/msqnqvve7LHlo243wFXMG
	 wmnqIc+bcTIcjltiqx2R+4NbJ+DceT2DsFvEDiaMY9osWjYou2lxR+0ahER9/cL1UCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984404;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xUrvLi8v5PVW3mtZpb5r6hg1JHrY+OISzmk00mxPeZE=;
	b=tKcJkZ/Nx+CkHvKUj0RRfXyxi6D+2aYwt2XWbh7qK3a/8DzLQmd3AhGdRhmtGp5WSFZz
	 Wd/IzFtY70ZzdnqTXZ/rvaIPpZFNbTJ19pRFgRwjkqZd4S69ecKc7hkeTjOt8PGpHUvgX
	 vEyYS+jZ4JPqI+ELOeNeFlvQY7KHMe9upkit9eKcH+M77kJcasjiOCChKhLLXEv7TAnUS
	 DReIGMGLDGnha9k5AHkCgb7v6Ya/ZPhkbyXDmpg7lh8gCQO+x57BmxIELWgGzwDduDGGO
	 mDIkMpPPTUiOf96TYvdfIdU6Bng3bsFxg2D6w9hvDCc6rMo2kehvxoPWG6W8JuzqOjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=pXM7tqqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.117
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023117.outbound.protection.outlook.com [40.107.159.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CD606A326;
	Fri,  6 Nov 2026 17:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=pXM7tqqY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQgrFayHABR+G4CQ4VGyAXpwmxjR2wKFXYnPvUZzVE4RSo4MGEHmgAmLXU3Y+2EC/0dK4zlgccUv2Jy0axOUvXFhtHt4x6N4fiX6Ma8fEtouTILgynzVG6RXwYpp5DsEGks1Ps/EeaPU5R9EwysgNwp33wq3+L+BJqWt6qrzqJsFXI8CSiJE0sqC89E5X6MUI7S6UfCUkLuqteFbrbSpPFcd0HWO7BOmy0ET/oxDwpMmRT8WwSH3Y+P6Mdi4Og5Lhq10GMiibjmNp+P1ioB9ip81J2KDniTzMlOptUNbUvSLJZ7wqzYn0E7aQhpaqPS2f/AnfGhwzphcs2tFRzvqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUrvLi8v5PVW3mtZpb5r6hg1JHrY+OISzmk00mxPeZE=;
 b=TENa6d645YalXkziQkhTkFWDrsWBwYJQMoieKqpAZs7AlfWQ9eMfoHCwA21KZ1D8GHPpFfpGc5ItRv013mpBfMgrP71sBHlg+FJTOU+ALK8A0jYuxZnz7h3Oc8dkjGmJE6ROGTsCkXcCZjRQJRwA3OlCDyhbVzFWGhVaCtq+qiUVlj69t1gF9xXKQKHJNU1SvKtEgTdzaYJGIVl6bq4GZJLAvORXDGdFoxJ6guaMGXJwoFdhFtYMKdYzdU9ciNs4SvCyBFJWtbDp0sUaCaGrGN5zY3jgYfUUcdHojoQ3Do/TPXY2tvDWIe7XVMQRCzYklvW/C31R0m6LNUArQaEjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUrvLi8v5PVW3mtZpb5r6hg1JHrY+OISzmk00mxPeZE=;
 b=pXM7tqqYG/Hgt3Y+cLvq2/ncgSPjsszyn2SrG/QEXpFNu5ywcKHwsMrA1VbykipOnDGGlJh5CfVB5gicTxGEos4QOffcke6ur94o9ohX4Rcqz3fSQUB0sxhcIJ4lr2NaskC1/YkLlBoisSM9Dq2Pzt383A2bEHKwAS/vUuJHqZMxnZUkFs8DhFt55xLj7cMKRgnZiZwvp3yO89R4VDp3mpS2iiAelN/2rMu2Bn9/Qe6d09d5g3yajAbKG9OxYebgZf9n6OLA2rAYpLZM119GMq9F8bLb5P4MlD+++Upy91C8oFTe10yrovFtLvGvTe8YlTRJ1m20DcCGQ+OmFTBiUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS2PR08MB9075.eurprd08.prod.outlook.com (2603:10a6:20b:5ff::9)
 by AM9PR08MB6690.eurprd08.prod.outlook.com (2603:10a6:20b:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 16:59:58 +0000
Received: from AS2PR08MB9075.eurprd08.prod.outlook.com
 ([fe80::3f57:9ced:7a37:1bd8]) by AS2PR08MB9075.eurprd08.prod.outlook.com
 ([fe80::3f57:9ced:7a37:1bd8%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 16:59:58 +0000
Message-ID: <2f3e4557-f4d0-43df-bce2-c653d1de305e@virtuozzo.com>
Date: Fri, 6 Nov 2026 17:59:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] mm/huge_memory: copy PMDs at fork like the PTE
 path does
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, =?UTF-8?Q?Lo=C3=AFc_Molinari?=
 <loic.molinari@collabora.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261105211819.2a6a349b2edc077784ca52f9@linux-foundation.org>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <20261105211819.2a6a349b2edc077784ca52f9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::15) To AS2PR08MB9075.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ff::9)
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
X-MS-TrafficTypeDiagnostic: AS2PR08MB9075:EE_|AM9PR08MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: a491597c-7e47-4671-b75c-08df3c2763b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|261022075727099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261021121427099003|10067099003|4143699003|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KqdUF9srlb+YSkRBI7D+QRBoDrPHTJ4s32/mKzcOckbykMWN++Zp5aMSw7Rf9JMy4n+tkOMvYxfZkmL4vlRdBSjQ+jyrITBjXIT2Tfam4/C2LxLbY/cXK4RdT+Hf1TmrLNhtQK/SIqWUv0gEGTUKrSuF8K7NhMfJiQfGUnDmvJMsgfMIWhFSGiTRu0eSYgsaDpTV7hGax0C2k1V/b3uygu9Yyk7lStKJPvD+hVrxHPIn5hxQPiwTeaAnHktbEOKjXNtDuMLcp/k1m65olA24tYWLOL3uw7CdCzMhOgfw0jP8Tt7Gg/a20b+jbD/cdnqnAbr0m/0NNMMU9IQivBXDN+tslBMpzKdVEClm3vjJUT0idu329S8PAUAmG06HcF1O8G8MjuwzoBnCU0cCD4mXwh6aslGlq9jtpM55b1JLsGRg7xEUMehtAkuqZw4O/pnN9KUwsacJBKqN+UKyR1s83W35FlkqHUCI5JMBURCW7tx3g5AJaEmigdGOU0zprUSi4Pev9REQSGK1xO+D3IAyZpMQy9QtOJc5sVaM9i8nct/J7Ccn0V/wwSRHEpUlYVt24BSQREP17WXguOepV6vVD5qE3/Zudxoc4F23Htv4756Ii+3AcB4TPxt8sWO3l5iG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9075.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(261022075727099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(4143699003)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2t3WGlkZGRURjBtUDZ0b0RKZU16aGRjR1NZd1lEdk9QWTdCVkxMNzZyNmdu?=
 =?utf-8?B?RHpTL3B3K2FNdGxocGFXTWczRlRPZ3phNjd4elNSTDZzcFYzMjJ1aGxpMExV?=
 =?utf-8?B?Z2dpSXRkQVUzelBlSmtYRkhhZWtMUENEcTE3MmxtYjlVV21JcmtiVG13L3l1?=
 =?utf-8?B?MWZlZGlYTjRzTjBPQWQzNkZpY3VaeWI4VUxEYlVuTFRUamVzTkd5ZEpZdnBQ?=
 =?utf-8?B?NTFiRTN2cklBS2RleUtkQUplK1N4dHY2d1ZPTU0zOXFiK0FSMWpIaXpaNE04?=
 =?utf-8?B?NGJRN244elhudXdXbzVTSENRMExSRkhGd1Y4N0dqeGxRL3B6YmI1VlpGaUgx?=
 =?utf-8?B?N25ZMnRoM1VaeWNjWmZxQTIzT1BoYWFqMS93a2lEZFNDaDM0SWF6dzAyVkM2?=
 =?utf-8?B?aURrWlUxVW90UndRUVNIOHRzcnVIVkVtNFBUU1lmbiswWkk3M3A0a3VUcEho?=
 =?utf-8?B?bUFpMUMrTXZjWU9BZDhCek5KbXRIcjF6MWw5QWgxUWUwN1B5NE9ZbUF5SEd2?=
 =?utf-8?B?VDVlRTY0Q2Fsb1ZMN2VDRjVXdW01c1diVlJZaWprNDNpcFIxU3hLTmNacUg4?=
 =?utf-8?B?ZmVhWlJGWElpdUxYbWFUSEd6eCsvUnFzRDlQZytKRFhjR3lCNTZBOTRnMUJY?=
 =?utf-8?B?Smo0MFlhcGZJU3ZFRU1aOTlFWk5rbUNaVzBzb0QzWllxeHFYSGF1TTF0aG5R?=
 =?utf-8?B?Yms5R1A5MWUwakpSdnZhQ3hlV1JYUU16N0RIRnE2SGxRVHo4d3pBdDR3MkU3?=
 =?utf-8?B?ZUR2N0s5cGlqTjRXRm11ZURoRU9wRUtHODRYN0RLZzl2Z0tHSWpPZzNTUXIw?=
 =?utf-8?B?YWxwMkxFM3dNNE5jQ1F3ZTFKNGtpd2FDUjRYN0RGT21ja1psa0NRd1pHTzJp?=
 =?utf-8?B?bENwMWFKUkVNUHg5TTE1YzVxbjFhcCtrR3o2WStYNUNLbkozTmxOem1jUjZV?=
 =?utf-8?B?cDc4SjIyL0xoL00rRTFneXNuTUpTTDZyTFBzdW1ZbzlxRUVMeDVzM3IyaFJO?=
 =?utf-8?B?RG9XZkR1VGNOSUVIZDVMSmNRUkg2Mm15cXhSbU9iakpsUG1ZUm1pYUFWeHBx?=
 =?utf-8?B?ZXlCOVRLTk5FUVEwc1lJa2g2UzhxYnRvNlZ0aU9YaUQ5YmEyOXBjZ1VpN09q?=
 =?utf-8?B?VHlldXBvOUg0QXdPMzVwZjE1U0I5QnhxcFc3eFliWUN4TkxIWUwvUDBiTmpH?=
 =?utf-8?B?cXA5aVArOVZwRUJDOGRiZUVGUExuQ053UURiUGVFUlZkZ2YzOXBPNm50Y0xX?=
 =?utf-8?B?NlBENVJnc2FBd1lzNDQyeWdCeVlBY25SQXA5b01vVTdPNnU1dkJQc3VnTUov?=
 =?utf-8?B?YU1maHJrbG1IdjFwKzNkT2Y1b3F2ekV4WUExNDl3eVNXWkRuM0pRdS9NbjN4?=
 =?utf-8?B?M0tvaUJhZmlIUDQvUzBpVXhaSVF5NktzSzRzbmdWd04rZnNIQnZUa3lpUkQ1?=
 =?utf-8?B?Ti9qczk0NEVONXJCQnhrcDFyamQ2SnI3RFJ4M25sbk1mWnRoRE9FTVdNSk1E?=
 =?utf-8?B?S3VJcVA4SEx1NHhHOGdNa2lBdThsZ0NjRjN0YW9sa0xrM2ZwQ2h1OG9FUWhn?=
 =?utf-8?B?ZFowMW1nRFNJY2VpS1NCM3lBTmpQbFNTT0hUZjZpZjJCUEF5c0Z0bnBHUHM0?=
 =?utf-8?B?ZDVqZCtPbXNGSVZGaVY3azFvSnYxbmNaOGltUmFuWGIrYXZlNlJzQldtemk1?=
 =?utf-8?B?TW90eVEvSk43UllacU1CR0ZJSVd6eHhRSWpGMTJSa3ByZVJqTGZMRE9XdWVL?=
 =?utf-8?B?WHpZVjZvQTdYRDM4VTFvUHp5WmZSZHVRblozTll0VkNST1d6S2xRelBMb3Jy?=
 =?utf-8?B?MDRlTVhaaEZVbzYwbG5WTmtmeTVyRDFHWlhEdEhWMWtjNDRUekdzUXg2VGNm?=
 =?utf-8?B?QkpYNXZZK3o5c1lieWdCSTNhS2N5WG1KOGNEQ2FvMzNtWjJKSmJqa3VZd21F?=
 =?utf-8?B?b3p6cFAvSEZEbkRldlFmVjhnWng3bkt0YjF1b1lCbjJNNmZXQnZRS0R2dG92?=
 =?utf-8?B?Ym92NUM4eTFpM3RIQmRvSGFZeEZ1Q2ZDeGVpcnBuNlA5ZTZ2YW5CTzhoZ3Mw?=
 =?utf-8?B?cE1iazFEL3dTU3l0Qk1vY1FkcnBhRGtQVjRIUlRCVm5qM0RMclRreVBSREhj?=
 =?utf-8?B?VDBpRWphTzBZK085VElZUDJMbThKVEpKKzcwckxGWWkxdDVIMEp3aGxQYnI2?=
 =?utf-8?B?WHI2dUJjeUVlRWJBRXIwbzBlK20xcWVmVHdIRnEzbFpoZ05nUnRuejNDclAz?=
 =?utf-8?B?YjMwVndWbG00Z0tyV3NUOVNLRFdrbUxiZWx3Y25xY2dOVmgzbnJ3MnB0ZW5G?=
 =?utf-8?B?Y3Y5NUt3L1V1N3g2NW9odVpGRG5TelNDRlNmQmpCMk02SHJjUVl2QT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a491597c-7e47-4671-b75c-08df3c2763b4
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9075.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:59:58.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogzO48TyRfiiw/CvWwTRZEIIM73vwkJkgMBEFZwWnZV6qeNxEzzJPYE5H/A4E/xaoBG9gruOJOSg1i717qVgmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6690

On 11/6/26 06:18, Andrew Morton wrote:
> The second column assumes that the child touches all the file THPs,
> yes?  If the child touches only a small proportion of those mappings,
> or just does fork+exec, that changes the "Cost" comparison?

Yes. I measured it again on bare metal, with a fork()+exec column:
x86_64 with 4 NUMA nodes, the benchmark bound to node 0, both kernels
v7.4-rc1 with the same config, 4 GB of shmem THPs mapped MAP_PRIVATE
with an anon_vma, medians of 2000 forks, range over the rounds. The
exec is of /bin/true.

  +-----------------+------------+-----------------+--------------+
  | kernel          | fork()     | child reads all | fork()+exec  |
  +-----------------+------------+-----------------+--------------+
  | v7.4-rc1        | 135-141 us | 3820-4036 us    | 559-567 us   |
  | v7.4-rc1+series | 429-440 us | 1007-1036 us    | 1190-1226 us |
  +-----------------+------------+-----------------+--------------+

So a child that execs right away, or touches little, pays about 0.3 us
per huge PMD: the copy at fork and the teardown at exec or exit. A
child that faults a PMD in itself pays about 1.8 us for it, so the
copy wins once the child touches more than about a sixth of them.

> And on ppc64 hash-mode setups this also allocates deposited page tables
> for mappings which the child might never touch?  So a modest increase
> in memory use is to be expected?

Yes, but a small one, judging from the code (I have no ppc64 to test):
one 4 KB page table fragment per copied 16 MB PMD, 1/4096 of the
mapping. Radix and other arches deposit nothing.

It is freed when the child unmaps the range, execs or exits, and a PMD
the child faults in itself deposits the same 4 KB anyway.

> But I worry that this change is not an overall win for thp-file
> mappings, which are the common case.

Only a narrow case pays the extra cost, a file THP that is:

- mapped MAP_PRIVATE;
- in a VMA written to at least once, so it has an anon_vma;
- a PMD-sized folio in the page cache, mapped by one PMD;
- itself never written to.

For example:

- a big data file mapped MAP_PRIVATE that is mostly read and patched
  in a few places;
- a private mapping of a memfd or tmpfs file.

The common case does not get here. fork() skips a VMA without an
anon_vma and without VM_COPY_ON_FORK (vma_needs_copy()), so shared
file mappings and private ones that were never written are still left
to faults.

In these VMAs fork() already copies the PTEs of the same file folios;
only their PMDs were skipped.

> I'm not understanding why we need to mess with thp-file behavior at all
> in order to address a special-PMD bug?

It came from the review of v3: David asked to make copy_huge_pmd()
decide the way copy_present_ptes() does, instead of keeping rules of
its own for PMDs:

https://lore.kernel.org/all/973fd409-64b7-4c62-82e1-c75c784b80f7@kernel.org/

> Changelog is soooo long.  I replaced this Reproducer section with simply
>
>       - A reproducer is at the Link;

Sure, thanks. And thanks for the pmd_psize fixup.

--
Cheers,
Konstantin
