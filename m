Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794784911;
	b=fR7m4Jmeg7MpI8PBj3QziKodKJNl6PDSrQ7J78biRiQtZbF7/jfXfGDghwyPTVsmut/3
	 15kFrb9QRUkK27TOFyCCwzLQYOsZysSQKyYySbq3y+9lKimdgXE+bT8iz0pg6Bvq5+sqV
	 RstFvTleiWWRaRnOrK6PiI7u12yTkC4H7gB5CdXgZxfD0ZwHuW3ZChKnRoG2LOAA1Pp0L
	 HO+Ozmhya3NU+dmw9T/egTh/s6IGRXWRhlYv3GqgYsKR3hH768JSORJW2VBp36zTPNBq1
	 P4NIX6MImKy7zv05Ox/9w12RzY8iTiWhMJaqyxlUCH7C8eiSoXbYqkz3h34om9tiZkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784911;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xhDC19L8bxetJWEOwt8UJ+2i0dljJZjZERjlDf4H2rw=;
	b=AWCy2bhqeKeCovpvN3B5TeHA4WCV+7+vDckImWNzwB10yBCCi0Su0k5EFLeR1ezDrca4
	 tx7+rs+JH/eW+RQh548oU5mqvwDl0xFbkeFZrfn8mVI0eWySWaN2PBr7SRrnTnTgtdtju
	 G9AGciQdns4gXVSc2GkSGyGETBtFFOv1B+NnTeU/XKQRzyxGQo36Lf49R1je9Gzt1GNkW
	 EfeJkTJvuht7FSke3Y3+13kM94qaA2O9xCAYasKdltbVmVVIJ3TfR9pxf+4/9Lt+8gN47
	 36S3nGekMfBLZjk7AnNFpufzw2AyrSD/nelnD3kNyMq2Gn9uvD/d6zBgGcz0/q3GgDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fUMPf3ZX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF6606A31F;
	Sun, 15 Nov 2026 23:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFDF6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fUMPf3ZX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e59+uSck3V6RDo5TQWOoJsYfz9osy5Nzo54ogUC+y/gpNVlX2gCjLomvptMD1umIUmtIkLd64L5C2MFFMpP2jdp0WaQ7C8e7czwZ4p9r/67V3PJpCPttD0YGhvcFWKeEScb+teXCouIhGAGzqkkZpkzdeSAVT8sY/K2iR3IizLABlOCzxkP1vwiJGPrGDy1d6zILTkoK9sCr1qW+/VNSGvkcjs8u6HVYiK+jQFRfkOWW35FQHxACZ/CWasQkdbChkmxBxGdQ+n7MmKG1wY4eKgKhUd+psc6tjioBX9Q0Qood1Q1eAb0erqpdinq60CwkdVx3UtwopL184DDPdFHozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhDC19L8bxetJWEOwt8UJ+2i0dljJZjZERjlDf4H2rw=;
 b=NLKuihxEQyoLRo1FrYs6pwW+Aq5CWHeRGCAngziJYVdhr8L5783Q8P+9LBinj1d+Nt8bpYCAnfqWARut97liEUTmomktc5cjfYt11AKy0SavE+R/FXDi5sH5lNMSZdqDc9686+NJigEszkFL3sp0M7El88ROGP9Z+4rD3znE6A8jz558sEXazs+fAdcqF4Bq4Zpo4qfhzQH1N0wSgoj8LmN+alxXw/2xYtipl+V6fSgNlUTYFRfW7n9I4wuPO1GPId+UL34i4Rim2zRZIPU9eSTBV011YDyO5pEAAuroBXh4c94fNxqTSGZUExQ6qcw4/ZiJBUtIUzyRs87yz3HA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhDC19L8bxetJWEOwt8UJ+2i0dljJZjZERjlDf4H2rw=;
 b=fUMPf3ZXeWHouh7tWV9HWX3STF7dn0fGEauUnGh7Y+kWbasSlyrGwwCPmP98xGrmfO7veLbWRW91A+ECoZBYHzs65Kg74dr588Mn2ifrwVjUKwLXPyLKIyCH4sbld0g0fmbLDmBDqTK7eWuqpQYmJ2wV8xRsKVium8tvMQlJDbsrUF5W4tqBdNkJbrF3mPZF9b6GgSOA2QrBrZF7+uxDiDV+AF3tgJbMo2imCKZT3ZFzMy4ryw+tRgk/chbKfjakfs6Hcj1D8NvN33+42b3fvr3qkdWFZzDe+OLjLig1LRxRx6ms6Ayy6FQjYguaNjivrpSKfWSxk0c+0j5mALa2SA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by CH3PR12MB7595.namprd12.prod.outlook.com
 (2603:10b6:610:14c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 23:21:43 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 23:21:43 +0000
Date: Mon, 16 Nov 2026 10:21:33 +1100
From: Alistair Popple <apopple@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Usama Arif <usama.arif@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 09/13] mm/migrate_device: fix use-after-free of the anon
 rmap
Message-ID: <avo-M-Fq2jznQMYU@nvdebian.thelocal>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-9-3d2454362e8d@kernel.org>
 <avTzHDlCiaNSzhtX@nvdebian.thelocal>
 <avYNv-bmQAGE0ktf@gremlin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avYNv-bmQAGE0ktf@gremlin>
X-ClientProxiedBy: SYYP282CA0009.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::19) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
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
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: cd15c9bf-e0db-457d-a6f1-08df436f35ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ldn5Gt8fFsZaBbWUVqOxvD2WY36F5utiSx/+A5cInEsNArf1Y1egMFV9mHvxigO9sZ/4LjIHoTg+Bj7E7Ti5WvAKob6PS9cBiMdDeXS1tC5PwWS+pDnKpWjw+VYXMqeGcjMkgelGQUZyEylS5ZsAb8JR9BLTWFLlZKPstJ1dByHDg3pEbEjL6brcoSbc5l15aUdRLzwoa2l9UhnHXFIWWeCkJW+33crEFjETRtzPyotkCzLvXZj0E2/uLe5HESaqF88Jk285cKT5IIK233HjBq1hXvOimTj1zfJ3Yl23SLI6KCRZxY/Bc9q9nN4DIaXZRGYgA/bQqwwJPsSqn4WnB16IyN57wueCiUghPiVbhaIiZlrCp4LWN4Sq+QvbldzyjqSwUKWE976QpPjyJBW93VzaDOt9GWTTLIZGJmiBaWXUSkEbBMKXF0bHMuvHDlzI02g4CIUP1GTbIChrmkUqpEvKvEbPLEWrxlq0bbKkJs3e+It1P/PCpoQZqn6hb9RDg9bZAkhjqFkIzNOsPCnVYsrWdiB9q/yWB/hpOJcWHU0jtB/UdPHJAGl7Bo+uwLRr+NSAzKCl1Pc6yAVOynCiBmZgF66i6ouVf9dc9Wm1lV9Z5SQ6M66eHvAey6ynDW7FOxkmKaDqgsARNabZ84HwG0STVlP42tNJJOwokAoNYIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5RgADQErEK89JKfnoSX0jjUeUzCc0jLD4O9MB7I1xGJc6Yc+mZNTKwC9YlVJ?=
 =?us-ascii?Q?3WfpBRAF39I4saNxgbBamPWWI1nK4ddWE1rXJzYd8QsuPH74ewOkeQYvXgvw?=
 =?us-ascii?Q?TFBk4mvlVQNbNutL66kTBuTfwqawzt0VXd/gBownM0ulFKjN3Yrhn+6/rOcj?=
 =?us-ascii?Q?vDROCwAR2AM2jkTVNl+UzhbPECSwQUegQj7ombBGMKxtCNtMm4COg8QJdx9J?=
 =?us-ascii?Q?1U+VH2Wk4Ut8wLNID19/zp4kdfjy/s4QwkIVZGooR1vHf/KaHmq3nTQ06TR5?=
 =?us-ascii?Q?cbB45CjLx5C3pzXTKAghvy4ZtW3WnybECFFYk1bHJGYInY4WPZiF1UgV2oZD?=
 =?us-ascii?Q?6mnHXjTJDZIS25v0owHdEwEJLvlJnl10XnFHrFGrmjhDCqx5peqjMVzUJiqC?=
 =?us-ascii?Q?9oRHRjeTnS5GYnPzr8W08cr3sYC4YfMnZnHrepvRCkskSVtcflpbsiZoHS8+?=
 =?us-ascii?Q?7vAPNnZdJ1PZly6I9suzp+yPwFaU4ytBQ5TT6b/h5ZFelDPk5GePqvtWaEoP?=
 =?us-ascii?Q?RIxleCSjzkUFUXJlwcCViNDwMtyPwvVCDKakqRh+TlL9Ooh77s5jLI+iqjdn?=
 =?us-ascii?Q?hlJZWNDbRlefwVYpqXz8ES5AqP7mTRgEESj7XFdXxeYiAZVekHACkmKbrRoQ?=
 =?us-ascii?Q?ESdAgKQMpi3N6TRuZXd9G++siOzqNcXYXIB+jG5Tw2Rk5jWPEsv3pGywZNDf?=
 =?us-ascii?Q?SQIWd0TLrDqYgc/x9f2GJGD/mxJgvaIAztC+cTUl6f7+BFvnabT0FLdwXY4V?=
 =?us-ascii?Q?xgnXpSrED4VFdmQy8CzKsy5pH0XNfjJNvOp0+EDnul9reKbx1JdbGogXYIr7?=
 =?us-ascii?Q?3g4a1cJALNsdQnkoiTffuGJCd9obbsFX+4AQH8dxMvKCWyZq/HC3t8/2HeY0?=
 =?us-ascii?Q?C4218hGnJ0JtrpeU/q/qIa3pkbncJDIzbt0ae4nzJYMCqDDLp1F66TMl0+Fs?=
 =?us-ascii?Q?cxthXHzPq/+oQbyT3Wv5gMOWxZiQyFlzm0Ilo/JnSiGFAP9ZPnOEUfDOaJl6?=
 =?us-ascii?Q?KYpjfwUF97MNZYwfJDnrxTlwcJgD/DNcikTbXnuicOk7U+pR6uFymdKaFIFZ?=
 =?us-ascii?Q?y9NA8CQ7v1D2ep1rd6wfHZKDyx35ymNg+zvaxvsQD1Hn54M4zDKtnD6e9PO7?=
 =?us-ascii?Q?yt3qIEND7RJL2C1jjYUHjvCa4trcr9ol8djfZDVDY+G5pHA3C9xMQZBj8bT9?=
 =?us-ascii?Q?+XT66Pp1xW6mwOLvhb3EqVOB/ivLnSleYOlnNJ73DegIJMv724QqiO6D6M/C?=
 =?us-ascii?Q?JQiDC/MijwwDzjqNtDy+43rHNOYtrpDNSI6aRpdL/k2TK9mrFwyD5IK8UG+s?=
 =?us-ascii?Q?kGlAckrMtK8rdhTIiUipNbxwH1Czggy0WUmZtz++qhkbUjbVwx5zi1F39Qf/?=
 =?us-ascii?Q?llusniWxLhvKSR1Zj/gKwb3gfFoR+LrHVZrflwNhZfVKpZzuQNdJA/vdUcsM?=
 =?us-ascii?Q?CuVZAKBpaKNfdicmD2AEK3xuXsHy3Tw9mIHUPEm1VtwdlD/mq8qrX02FY45J?=
 =?us-ascii?Q?sWEgIh/HR0B95TuY9OmyjG1glZMWrRU6LkUhsCJ776pxyhIQNzqy8kN+9oPR?=
 =?us-ascii?Q?xI4sKjxspFCe93LxxrfdB45bHbsWI7a+y2dcbXG3opSP0EkpwHTZKQ2ATtVA?=
 =?us-ascii?Q?pSLtmlIggfHkb9wf6o4LTjr98YMXop+7adz6FDB/e2NtM01VY4kIYnGZSqx7?=
 =?us-ascii?Q?PVQmhl9b2e83dQVaAqdhJ+BmUdp/ev7V3RfmwD7zsWplukd3q7m7ih7aTVS+?=
 =?us-ascii?Q?KQx449ssfw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd15c9bf-e0db-457d-a6f1-08df436f35ab
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 23:21:43.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN98nuiA4iicw1IRtXOLEv54/+93GHmXFi08tWPo+10n53L7df4xCK/jeiw94P9EdciOQ2kjCUWj8KDHg3grZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595

On 2026-11-13 at 06:05 +1100, "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote...
> On Thu, Nov 12, 2026 at 10:04:10AM +1100, Alistair Popple wrote:
> > > Resolve this by pinning the anon rmap of each folio which possesses one in
> > > migrate_device_range(), migrate_device_pfns() and
> > > migrate_device_coherent_folio() before its PTEs are replaced, and
> > > unpinning it once the walk is done.
> >
> > I was going to ask why this wouldn't also be an issue for migrate_vma_setup()
> > which does something similar. But in that case mmap_lock is held across setup
> > and finalize which I guess is what saves us there?
> 
> Yeah, exactly.

Good. That confirms my understanding so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> --
> Cheers, Lorenzo
