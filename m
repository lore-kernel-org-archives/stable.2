Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C554739
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682372; cv=fail; b=iJWPyh+AnLYkol1sNFR3vChOZMJjndn/8RFcMpyBHISuxq7qlXENUaqNkfjnJKMf+DcpRA3bMh4B6I4Z0wIOcBYRVgS5iSG1ZfHkRdc5kOFZ0tyhBXt197N9v5l/5YVRn2oNmMLtY1uBcUIi/xOC1rPOrpzpY/Sk6p3FB7SmKgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682372; c=relaxed/simple;
	bh=7DAp3nvmtCvLixCPJoaiCdCeny4JD5wc16uJLaGe7Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3vSusXSJzhGAuQyuWlPNoLOqkzsUxQU9sphnfCSZEXypU4Gd0FdiZfysvoZUjGNcJTXBosXFpICh8IQJnY6/U0NX/1g9y931b/ILFnIQ5L/dWCs1gx+57EbkeAovuVFiX+bh3NZMDNDjbOa+5mzHjTapEqrY2/6/jxI/nA9aN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HmX1uoZQ; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HmX1uoZQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fevKkIS9mQLTOVYYNPRamZwzheENQeUTwHtWNxO1yFYrbFcVLmKWGzQ7ngMbFzNEAsVQe+JUJ8Raca1xfhh4iK5tsV/O+u0VXbAU6w7L2ZRoIdYKmIdbZP8l0hx51/LCVQqPJNb4Bt7wc+OIZQDT7M5b0aSnsn7Dqj4OOmCYKHdPyTcRxMtZwX+ZmcqcqYPs5kxBNYbr07Cc2Abm8ZIAlIJg/SKUIKwejcFa7J/QPzUKpHXsSu0gnlZ5W7kKtAApaVjd/ufym5GLsQJnnoIRECObZ3P28yEMhctzfoSM6OKntchlILvaiOILkYyW92sICEdyvVN4mKi7Ct9ELwFKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajpgXC4MGnFdAv3KNxthM5Y88aAKNbGKviZXTeL0EZE=;
 b=s6zI4gv8B807g8hu0x7eGSubC8E5yQLZHbrB/QBpUAckEsM/duOLeZnr8K3v4G7+kSZYwZ+ZzWT1Aem7uAE85Z2+pFaa0XpP12hSONHCrWU+sNMdnUFKVuKG0U+GpNcyNWo6WDbs5oFXZ/xOPv5aq6FhEQZO7awdcK2j2W3WyKuH1/cldEROwtitNcbi7g0EgMpkpTlT7oxiD4hnPLuExaDVq16ujKXtwGcq6LMn35en1j1wStADPPEgWUrGaBWpygoVjFOSRHYOP8FgyyT9YOJS/8k7NJFTiMb+n03gZ4qsEik6AlITlXgdCaP2xEzJmBv+qfjsPIQ1JqQBXJOxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajpgXC4MGnFdAv3KNxthM5Y88aAKNbGKviZXTeL0EZE=;
 b=HmX1uoZQuJpNCu+FdJiMVq77FS05MNLYirMqo4fIRgw4CHRjyaJadsxZfIdQjvbmB3b8dptIzUCaTG9zJ1Cb6ZFL8m86YP1l5Vps9Bjij34sUPpD9NI9WcohYR+vMFZLth5MIGKbNE/7VBpxknEMtM4WrwWHLesGjiRvdZrMBbM=
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:59:25 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 17:59:24 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: Gerhard Schwanzer <geschw@pm.me>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes
 SDMA0 permission fault on RX 7600 XT
Thread-Topic: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes
 SDMA0 permission fault on RX 7600 XT
Thread-Index: AQHc8nc6MtynYsKuA0C+f6nFSQ54mbYr2S0AgAB83ICAALdmAIADN7bQ
Date: Fri, 5 Jun 2026 17:59:24 +0000
Message-ID:
 <IA1PR12MB85172F7FE9157C092EDA46A0E3112@IA1PR12MB8517.namprd12.prod.outlook.com>
References: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
 <53c2ad43-091d-46e9-b825-9aaa1d7114e8@amd.com>
 <2145b14f-00e7-4565-b1da-9e08d2c89a49@pm.me>
 <d39183d3-b961-4c74-997f-885eb7a887e4@amd.com>
In-Reply-To: <d39183d3-b961-4c74-997f-885eb7a887e4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T17:36:53.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8517:EE_|SJ1PR12MB6148:EE_
x-ms-office365-filtering-correlation-id: bc68d032-cced-479e-920d-08dec32c2dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|6049299003|13003099007|4013099003|4053099003|8096899003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 v2wBSHJBe5VbFQoViaevHvJMCE+aDBbY+FVCeV5De7KSunP38YqFSfrTNoWM39KCCPzHWPU6NzFN4Y2E29FGEthsfQ/bIvn18DNEZUYAtQrLxupwWJ4S94/bs82L8bdujS6KqyF4o64ppsF4kBS7LNGVSRaMbDvS5anaEFdNUkbPtKJf9Cku4cXn7dG3GRa4GoF6QRBrEexciWDjVnRMZFMwYT5N9i1zKGmr9K/c88dxsyN++PYKpTgGqz24u4pRLRdYjjRoY2I9AcrBKCrVeLL9RjP1/NnHIsM1gLbL9+sD0kk4Ma35eQQn9RnEFLvqZakZG6/xz0UYeJ+igvrmrBjWLEbKo8ZiyuOwl6wsoHIniH3NNLEh7liQv3XUhivPN80jUZHK2ES4kgpiXqW7OBUTLT61FuloTgcSxhUkp6tF0qizR/LhcODjRxa9N+q8ZFCVxoiycHfobUKp3JioZNs0e0y2KVr3KMyNj80EN+zA2zKUlMICINUASRc4vIa77IVwtAR3ZcDJEnrD5VKF60CZ86BXr1aB0YASMx/sZ9Yy13gRDDgd96mk7ijGvoK2v3TLpMnLVk2qvZBTqVrK9LOXJKKUGLJHLcEJwmoEag3ewMXSo9ZdTdzZIuapRizhF7mE0DjVCC/pF9tFXMIRvxFMetbySiRe+AN/dCQe7hwr3Sp0X3H12WvwNkrXnQP44beV5y2XYMjpR3PauaFu1w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6049299003)(13003099007)(4013099003)(4053099003)(8096899003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nX/SAz5Z5eHW+5GCqQ90yqeZX8kMX5Kdx+3xQOGxmvkP5e2NNDDLPT6m5AeP?=
 =?us-ascii?Q?d8r+LUL0qpXImnlgAy+QGmCNRO94jq1gjM38R6MZCuKIb3B+tvRGfHat0Kgq?=
 =?us-ascii?Q?akoXjC8GvrYqZ7OV7V3tvMqjmCTZfhZeBRQgwwDPgGtvg72BnePWykHZ48eE?=
 =?us-ascii?Q?BOxXgX2B+Ml+zZ+B8RdoBR22SXIoskWf/DUfA6Yo4r4TUY5ZMA4w5FGp73vc?=
 =?us-ascii?Q?8pBOphn36zfWjsn8ukYqJ+rIUSpfZKtp54b6v6uPG+HHJEQqHUkHXnV7tA3l?=
 =?us-ascii?Q?pU5Vmgr1MZckEweXAGK12HRkfhT4J2EfRNAjQSZnYN3eqoOQ8XH9k4VMqNwZ?=
 =?us-ascii?Q?Vdia4Oe8S6clFyrFvhxLQlpQ5wMPY7I5JerdrCcB2g2qA9g/SQ6VSzjBNDPO?=
 =?us-ascii?Q?jA5D3UN7c1twoq1AqLReuIjLoj5hsxeYDPzdarqk8e9W1Xqg13/ld8olmSw/?=
 =?us-ascii?Q?tw1l+TXDFkbxVPL6TD5AKXjFO+FtPJ6meb2aDL7ndq0V7oRG7dkk4R2akx9l?=
 =?us-ascii?Q?eGToO7oZFNglGGY+bO1EjttwVVjk248KHQ7NqlKI8ATZeNDOgzajyw0vlkkF?=
 =?us-ascii?Q?NpM0iL1LY6w3AWk0tTAsb/z1uO7uONIqbjFWq2yLiJNqlWC4f36PDNsomiK1?=
 =?us-ascii?Q?kvu/Sc/DMq3xcmQeJE0yfZ5yBN3JJqaN8RXa37Sx0waSwb/jgNKyXZEWxrhy?=
 =?us-ascii?Q?yx2VziD3XIKjExbR826nYPQjK8Yiz79Pc76o60ovVqjnxDvt2GfEkiuAic5R?=
 =?us-ascii?Q?Ku/2tskIQy+4ghoKi410oz32zgYaQxX1K0RRiXNmQU0bpolQ4RjHxMsr53Za?=
 =?us-ascii?Q?jr0CKPcq6uwJ4W03F+yD3/mICP2BBIRA2dNWh3vONHjKLngWzFoWd+eC72nu?=
 =?us-ascii?Q?iRctKqNkAztSPzI9Ub5GYNUvSiIDAYaA+9yz3MGqPW7CEDVGlJxYhQw1HtoE?=
 =?us-ascii?Q?5Y6PJgHHBH9ahfGLd8yYTlDXMYVl08JXz8lkfMYZpmEnSdnKftNSXH5jee1h?=
 =?us-ascii?Q?Z9Tb0uGdLkiEJl8A6Z6pL3J974r+cCbtXBqJalHoCX54LFHkSplQKAuz8dw4?=
 =?us-ascii?Q?+b2Y0xIDJ1TrtVLSaZzaEVTmZpUsZLkAuUzsXq4BQCwianp1SFrocmylpQgv?=
 =?us-ascii?Q?ugCx+RoRUHPxBNVyPk9jQ/YaBikEd9etzbXyPcFEj//qQ6qHKHZQE6lQIpX5?=
 =?us-ascii?Q?LEl0DZ6TOT8J2IiA1Ya37a0TrijCVlCY+ZXeoDzdJVkD/d+XKJt+0RSR4Dpd?=
 =?us-ascii?Q?YmAxx2mNyT43b+WixLBjqJ8owbTgONJO8vAag/QITHpC3/qHHTiG9q9gz4Kk?=
 =?us-ascii?Q?6ufiWqpVrLOvy3D6yxvn5UYk+ZS9sLGiMGqbbwLmxAOTVJ8T3t85oGEiMObT?=
 =?us-ascii?Q?MmACD1AXRM7I78vf9Zxmx1NBdkOQc4TYVByCNhqt0tZ3LxHN6dQLfRT8bWJf?=
 =?us-ascii?Q?TrK0Jl+wN3XTEoQno7ux3KgK+7cZtqXefxpmDys6MGPUbxHWCY9i+jB3B9IX?=
 =?us-ascii?Q?kuIA6LZt/PLOCO36CUrEWWoI1l2a6IbQpDq0oRz9mA91A3CBjfTz60dHZUja?=
 =?us-ascii?Q?n5U6wADPU73hplM8lZnMJ+JR8cQK4Y9ZvtbIOZhAwPkeGduGY82S1nRfT504?=
 =?us-ascii?Q?pUpu8q/2sTauAyupKA9ucVJEyP0VLxLBXHpu96q0rNbfp1eRNlFt9DMq6VXs?=
 =?us-ascii?Q?z1yPN1RolrvHCg0NMbirAKe+vB8=3D?=
Content-Type: multipart/mixed;
	boundary="_004_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc68d032-cced-479e-920d-08dec32c2dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 17:59:24.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJUgtSxH4ZP4xX5GnXUoGWHH/eNIKAKfkZXeXB28tM0KkkHglOXawxqQNDSdqScX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148

--_004_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_
Content-Type: multipart/alternative;
	boundary="_000_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_"

--_000_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi Gerhard:

I think the cause is checking the last byte address of svm range for 2MB al=
ignment when decide possible huge page mapping. Your test case has vm range=
 that ends just one byte before alignment.

I tested your app with the attachment, no page fault during sdma operation.=
 Please verify it.

Thanks
Xiaogang

From: Chen, Xiaogang
Sent: Wednesday, June 3, 2026 5:51 PM
To: Gerhard Schwanzer <geschw@pm.me>; regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org; stable@vger.kernel.org; Deucher, Alexand=
er <Alexander.Deucher@amd.com>; Yang, Philip <Philip.Yang@amd.com>
Subject: Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regression cause=
s SDMA0 permission fault on RX 7600 XT


Hi Gerhard:

Thanks. I can build the app now. And I saw the regression. I am triaging it=
.

The purpose of this patch is to remap split svm ranges(head/tail) that were=
 mapped with huge page mapping(pmd), but cannot be mapped in huge page mapp=
ing after split due to new svm ranges are not 2MB aligned. It seems the rem=
ap decision misses case that both head and tail ranges are from original ra=
nge with huge page mappings were used. Will check....

Regards

Xiaogang


On 6/3/2026 12:54 AM, Gerhard Schwanzer wrote:

[Some people who received this message don't often get email from geschw@pm=
.me<mailto:geschw@pm.me>. Learn why this is important at https://aka.ms/Lea=
rnAboutSenderIdentification ]



Hi Xiaogang,



Sorry, you are right. The source I uploaded was not self-contained, it stil=
l

referenced trace_history_replay.inc from an older local replay mode.



I uploaded a self-contained v2 source to the GitLab report:



https://gitlab.freedesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7=
615d479c02c/kfd_svm_split_hsa_copy-v2.c



The --upstream-ab path does not use that replay table, but the missing

include

obviously broke fresh builds. The v2 source embeds the table and otherwise

preserves the same source.



I re-tested this v2 source before uploading:



   - clean build from only kfd_svm_split_hsa_copy-v2.c: OK

   - ./kfd_svm_split_hsa_copy --help: OK

   - good/workaround kernel: --upstream-ab completed 10/10 runs, no new

     GCVM/SDMA0/protection-fault messages in the test window

   - broken kernel: --upstream-ab reproduced the SDMA0 permission fault;

     the first kernel fault address matched the planned split-tail page



Validation summaries:



https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c9994=
39411f29dca/good-kernel-validation-summary.md

https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd42=
6b59edb32a9/broken-kernel-validation-summary.md



The intended triage command remains:



   ./kfd_svm_split_hsa_copy --upstream-ab



Generic build shape is:



   cc -O2 -g -Wall -Wextra -pthread \

     -I/path/to/rocm/include -L/path/to/rocm/lib \

     -o kfd_svm_split_hsa_copy kfd_svm_split_hsa_copy-v2.c \

     -lhsa-runtime64



If you still prefer a binary, please tell me the target runtime/distro. A

binary built on my NixOS system is Nix-store linked and likely not

portable to

your test system.



One more thing that would help me test any replacement fix: do you know wha=
t

specific failure or workload 448ee453 was intended to fix? I would like to

avoid validating only the revert side while accidentally losing the origina=
l

fix.



Thanks for catching this, and thanks for taking a look.



Regards,

Gerhard





On 06/03/2026 Chen, Xiaogang wrote:



I cannot compile kfd_svm_split_hsa_copy.c, there is no

"trace_history_replay.inc".



Or can you  send the test binary?  That should be enough to triage the

issue since it is a regression as you mentioned.



Regards



Xiaogang



On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:

Hi,



I would like to make sure this AMDKFD SVM regression is tracked by the

Linux regression process.



GitLab report:



   https://gitlab.freedesktop.org/drm/amd/-/work_items/4914



The regression was originally reported on 2026-01-27. It was bisected

to the

same functional change that Alex Deucher's revert patch later targeted:



   448ee45353ef9fb1a34f5f26eb3f48923c6f0898

   drm/amdkfd: Use huge page size to check split svm range alignment



The affected kernel line I tested identifies the same change as:



   bf2084a7b1d75d093b6a79df4c10142d49fbaa0e



Alex's revert patch:



https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html



A small C/HSA reproducer is now available in the GitLab report. It

does not

require PyTorch, ComfyUI, Docker, model files, or the original

workload. It

uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM

SET_ATTR ioctls, and an HSA SDMA D2H copy.



Single reproducer command, same binary on both kernels:



   ./kfd_svm_split_hsa_copy --upstream-ab



Same-machine A/B result on an RX 7600 XT:



   448ee453/bf2084a7 active:

     1/1 run faults with SDMA0 permission fault

     GCVM_L2_PROTECTION_FAULT_STATUS=3D0x00841A51



   448ee453/bf2084a7 locally reverted:

     10/10 runs complete

     no ROCr memory access fault

     no new GCVM/SDMA0 permission fault in dmesg



The bad fault page is inside the split tail and inside the SDMA copy

range:



   critical tail: [0x722429d61..0x722429dff]

   copy pages:    [0x722429b30..0x722429d70]

   fault page:    0x722429d65



A full ftrace/PTE run with the same C reproducer/SVM sequence also shows:



   split_tail ... current_remap=3D0 old_remap=3D1 missed=3D1

   MISSED_REMAP_CANDIDATE split=3Dtail

   no amdgpu_vm_update_ptes covering the fault page after the marker

before

   the fault-side GET_ATTR



The suspected code issue is that the split-tail/head remap predicate

introduced

by 448ee453/bf2084a7 can miss tails inside the final 512-page block.

Since

prange->last is inclusive, ALIGN_DOWN(prange->last, 512) is the start

of the

final block, not an exclusive upper bound.



I also sent a short follow-up to amd-gfx with the reproducer/A-B

summary and

asked what original failure or workload 448ee453/bf2084a7 was intended

to fix:



https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.html



I can resend the reproducer source and summaries directly on-list if

preferred.



#regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898

#regzbot monitor:

https://gitlab.freedesktop.org/drm/amd/-/work_items/4914



Thanks,

Gerhard Schwanzer



--_000_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Hi Gerhard:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I think the cause is checking the last byte address o=
f svm range for 2MB alignment when decide possible huge page mapping. Your =
test case has vm range that ends just one byte
 before alignment.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I tested your app with the attachment, no page fault =
during sdma operation. Please verify it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Xiaogang<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Chen, Xiaogang
<br>
<b>Sent:</b> Wednesday, June 3, 2026 5:51 PM<br>
<b>To:</b> Gerhard Schwanzer &lt;geschw@pm.me&gt;; regressions@lists.linux.=
dev<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; stable@vger.kernel.org; Deucher, =
Alexander &lt;Alexander.Deucher@amd.com&gt;; Yang, Philip &lt;Philip.Yang@a=
md.com&gt;<br>
<b>Subject:</b> Re: [REGRESSION] drm/amdkfd: SVM split-tail remap regressio=
n causes SDMA0 permission fault on RX 7600 XT<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>Hi&nbsp;Gerhard:<o:p></o:p></p>
<p>Thanks. I can build the app now. And I saw the regression. I am triaging=
 it.<o:p></o:p></p>
<p>The purpose of this patch is to remap split svm ranges(head/tail) that w=
ere mapped with huge page mapping(pmd), but cannot be mapped in huge page m=
apping after split due to new svm ranges are not 2MB aligned. It seems the =
remap decision misses case that
 both head and tail ranges are from original range with huge page mappings =
were used. Will check....<o:p></o:p></p>
<p>Regards<o:p></o:p></p>
<p>Xiaogang<o:p></o:p></p>
<p><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On 6/3/2026 12:54 AM, Gerhard Schwanzer wrote:<o:p><=
/o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>[Some people who received this message don't often get email from <a h=
ref=3D"mailto:geschw@pm.me">geschw@pm.me</a>. Learn why this is important a=
t <a href=3D"https://aka.ms/LearnAboutSenderIdentification">https://aka.ms/=
LearnAboutSenderIdentification</a> ]<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Hi Xiaogang,<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Sorry, you are right. The source I uploaded was not self-contained, it=
 still<o:p></o:p></pre>
<pre>referenced trace_history_replay.inc from an older local replay mode.<o=
:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I uploaded a self-contained v2 source to the GitLab report:<o:p></o:p>=
</pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre><a href=3D"https://gitlab.freedesktop.org/-/project/4522/uploads/7395b=
8985ecd7c54183a7615d479c02c/kfd_svm_split_hsa_copy-v2.c">https://gitlab.fre=
edesktop.org/-/project/4522/uploads/7395b8985ecd7c54183a7615d479c02c/kfd_sv=
m_split_hsa_copy-v2.c</a><o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The --upstream-ab path does not use that replay table, but the missing=
<o:p></o:p></pre>
<pre>include<o:p></o:p></pre>
<pre>obviously broke fresh builds. The v2 source embeds the table and other=
wise<o:p></o:p></pre>
<pre>preserves the same source.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I re-tested this v2 source before uploading:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; - clean build from only kfd_svm_split_hsa_copy-v2.c: OK<o=
:p></o:p></pre>
<pre>&nbsp;&nbsp; - ./kfd_svm_split_hsa_copy --help: OK<o:p></o:p></pre>
<pre>&nbsp;&nbsp; - good/workaround kernel: --upstream-ab completed 10/10 r=
uns, no new<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; GCVM/SDMA0/protection-fault messages in the t=
est window<o:p></o:p></pre>
<pre>&nbsp;&nbsp; - broken kernel: --upstream-ab reproduced the SDMA0 permi=
ssion fault;<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; the first kernel fault address matched the pl=
anned split-tail page<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Validation summaries:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre><a href=3D"https://gitlab.freedesktop.org/-/project/4522/uploads/e6d0f=
31c0fda0df2c999439411f29dca/good-kernel-validation-summary.md">https://gitl=
ab.freedesktop.org/-/project/4522/uploads/e6d0f31c0fda0df2c999439411f29dca/=
good-kernel-validation-summary.md</a><o:p></o:p></pre>
<pre><a href=3D"https://gitlab.freedesktop.org/-/project/4522/uploads/bdf8a=
3ac6786ddb88dd426b59edb32a9/broken-kernel-validation-summary.md">https://gi=
tlab.freedesktop.org/-/project/4522/uploads/bdf8a3ac6786ddb88dd426b59edb32a=
9/broken-kernel-validation-summary.md</a><o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The intended triage command remains:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; ./kfd_svm_split_hsa_copy --upstream-ab<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Generic build shape is:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; cc -O2 -g -Wall -Wextra -pthread \<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; -I/path/to/rocm/include -L/path/to/rocm/lib \=
<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; -o kfd_svm_split_hsa_copy kfd_svm_split_hsa_c=
opy-v2.c \<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; -lhsa-runtime64<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>If you still prefer a binary, please tell me the target runtime/distro=
. A<o:p></o:p></pre>
<pre>binary built on my NixOS system is Nix-store linked and likely not<o:p=
></o:p></pre>
<pre>portable to<o:p></o:p></pre>
<pre>your test system.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>One more thing that would help me test any replacement fix: do you kno=
w what<o:p></o:p></pre>
<pre>specific failure or workload 448ee453 was intended to fix? I would lik=
e to<o:p></o:p></pre>
<pre>avoid validating only the revert side while accidentally losing the or=
iginal<o:p></o:p></pre>
<pre>fix.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Thanks for catching this, and thanks for taking a look.<o:p></o:p></pr=
e>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Regards,<o:p></o:p></pre>
<pre>Gerhard<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>On 06/03/2026 Chen, Xiaogang wrote:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>I cannot compile kfd_svm_split_hsa_copy.c, there is no<o:p></o:p></pre=
>
<pre>&quot;trace_history_replay.inc&quot;.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Or can you&nbsp; send the test binary?&nbsp; That should be enough to =
triage the<o:p></o:p></pre>
<pre>issue since it is a regression as you mentioned.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Regards<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Xiaogang<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>On 6/2/2026 5:04 AM, Gerhard Schwanzer wrote:<o:p></o:p></pre>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>Hi,<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I would like to make sure this AMDKFD SVM regression is tracked by the=
<o:p></o:p></pre>
<pre>Linux regression process.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>GitLab report:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work_=
items/4914">https://gitlab.freedesktop.org/drm/amd/-/work_items/4914</a><o:=
p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The regression was originally reported on 2026-01-27. It was bisected<=
o:p></o:p></pre>
<pre>to the<o:p></o:p></pre>
<pre>same functional change that Alex Deucher's revert patch later targeted=
:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; 448ee45353ef9fb1a34f5f26eb3f48923c6f0898<o:p></o:p></pre>
<pre>&nbsp;&nbsp; drm/amdkfd: Use huge page size to check split svm range a=
lignment<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The affected kernel line I tested identifies the same change as:<o:p><=
/o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; bf2084a7b1d75d093b6a79df4c10142d49fbaa0e<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Alex's revert patch:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre><a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2026-Februar=
y/138824.html">https://lists.freedesktop.org/archives/amd-gfx/2026-February=
/138824.html</a><o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>A small C/HSA reproducer is now available in the GitLab report. It<o:p=
></o:p></pre>
<pre>does not<o:p></o:p></pre>
<pre>require PyTorch, ComfyUI, Docker, model files, or the original<o:p></o=
:p></pre>
<pre>workload. It<o:p></o:p></pre>
<pre>uses ROCr/HSA, an anonymous THP-advised host mapping, explicit KFD SVM=
<o:p></o:p></pre>
<pre>SET_ATTR ioctls, and an HSA SDMA D2H copy.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Single reproducer command, same binary on both kernels:<o:p></o:p></pr=
e>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; ./kfd_svm_split_hsa_copy --upstream-ab<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Same-machine A/B result on an RX 7600 XT:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; 448ee453/bf2084a7 active:<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; 1/1 run faults with SDMA0 permission fault<o:=
p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; GCVM_L2_PROTECTION_FAULT_STATUS=3D0x00841A51<=
o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; 448ee453/bf2084a7 locally reverted:<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; 10/10 runs complete<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; no ROCr memory access fault<o:p></o:p></pre>
<pre>&nbsp;&nbsp;&nbsp;&nbsp; no new GCVM/SDMA0 permission fault in dmesg<o=
:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The bad fault page is inside the split tail and inside the SDMA copy<o=
:p></o:p></pre>
<pre>range:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; critical tail: [0x722429d61..0x722429dff]<o:p></o:p></pre=
>
<pre>&nbsp;&nbsp; copy pages:&nbsp;&nbsp;&nbsp; [0x722429b30..0x722429d70]<=
o:p></o:p></pre>
<pre>&nbsp;&nbsp; fault page:&nbsp;&nbsp;&nbsp; 0x722429d65<o:p></o:p></pre=
>
<pre><o:p>&nbsp;</o:p></pre>
<pre>A full ftrace/PTE run with the same C reproducer/SVM sequence also sho=
ws:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>&nbsp;&nbsp; split_tail ... current_remap=3D0 old_remap=3D1 missed=3D1=
<o:p></o:p></pre>
<pre>&nbsp;&nbsp; MISSED_REMAP_CANDIDATE split=3Dtail<o:p></o:p></pre>
<pre>&nbsp;&nbsp; no amdgpu_vm_update_ptes covering the fault page after th=
e marker<o:p></o:p></pre>
<pre>before<o:p></o:p></pre>
<pre>&nbsp;&nbsp; the fault-side GET_ATTR<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The suspected code issue is that the split-tail/head remap predicate<o=
:p></o:p></pre>
<pre>introduced<o:p></o:p></pre>
<pre>by 448ee453/bf2084a7 can miss tails inside the final 512-page block.<o=
:p></o:p></pre>
<pre>Since<o:p></o:p></pre>
<pre>prange-&gt;last is inclusive, ALIGN_DOWN(prange-&gt;last, 512) is the =
start<o:p></o:p></pre>
<pre>of the<o:p></o:p></pre>
<pre>final block, not an exclusive upper bound.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I also sent a short follow-up to amd-gfx with the reproducer/A-B<o:p><=
/o:p></pre>
<pre>summary and<o:p></o:p></pre>
<pre>asked what original failure or workload 448ee453/bf2084a7 was intended=
<o:p></o:p></pre>
<pre>to fix:<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre><a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2026-June/14=
5800.html">https://lists.freedesktop.org/archives/amd-gfx/2026-June/145800.=
html</a><o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>I can resend the reproducer source and summaries directly on-list if<o=
:p></o:p></pre>
<pre>preferred.<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>#regzbot introduced: 448ee45353ef9fb1a34f5f26eb3f48923c6f0898<o:p></o:=
p></pre>
<pre>#regzbot monitor:<o:p></o:p></pre>
<pre><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work_items/4914">h=
ttps://gitlab.freedesktop.org/drm/amd/-/work_items/4914</a><o:p></o:p></pre=
>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Thanks,<o:p></o:p></pre>
<pre>Gerhard Schwanzer<o:p></o:p></pre>
</blockquote>
</blockquote>
<pre><o:p>&nbsp;</o:p></pre>
</blockquote>
</div>
</div>
</body>
</html>

--_000_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_--

--_004_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdkfd-Use-last-1-of-vm-range-to-check-2MB-huge-.patch"
Content-Description:
 0001-drm-amdkfd-Use-last-1-of-vm-range-to-check-2MB-huge-.patch
Content-Disposition: attachment;
	filename="0001-drm-amdkfd-Use-last-1-of-vm-range-to-check-2MB-huge-.patch";
	size=2184; creation-date="Fri, 05 Jun 2026 17:36:43 GMT";
	modification-date="Fri, 05 Jun 2026 17:59:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMDYwOTU0NWVlYTllY2IwOWIxNmRhY2M5Y2VjM2Y3OTg3YzFiYTk0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFvZ2FuZyBDaGVuIDx4aWFvZ2FuZy5jaGVuQGFtZC5jb20+
CkRhdGU6IEZyaSwgNSBKdW4gMjAyNiAxMjozMjo0MSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIGRy
bS9hbWRrZmQ6IFVzZSBsYXN0ICsgMSBvZiB2bSByYW5nZSB0byBjaGVjayAyTUIgaHVnZSBwYWdl
CiBhbGlnbm1lbnQKClRoZSBsYXN0IG9mIHN2bSByYW5nZSBpcyBpbmNsdWRlZC4gU2hvdWxkIHVz
ZSBsYXN0ICsgMSB0byBjaGVjayAyTUIgYWxpZ25tZW50CmZvciBwb3NzaWJsZSBodWdlIHBhZ2Ug
bWFwcGluZy4KCkZpeGVzOiA0NDhlZTQ1MzUzZWYoImRybS9hbWRrZmQ6IFVzZSBodWdlIHBhZ2Ug
c2l6ZSB0byBjaGVjayBzcGxpdCBzdm0KcmFuZ2UgYWxpZ25tZW50IikKClNpZ25lZC1vZmYtYnk6
IFhpYW9nYW5nIENoZW4gPHhpYW9nYW5nLmNoZW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9z
dm0uYwppbmRleCAyNWIzZWNmODVmMzAuLjIwY2NkYzRkZGU2YiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9zdm0uYwpAQCAtMTE0NCw3ICsxMTQ0LDcgQEAgc3RhdGljIGludAogc3ZtX3Jh
bmdlX3NwbGl0X3RhaWwoc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLCB1aW50NjRfdCBuZXdfbGFz
dCwKIAkJICAgICBzdHJ1Y3QgbGlzdF9oZWFkICppbnNlcnRfbGlzdCwgc3RydWN0IGxpc3RfaGVh
ZCAqcmVtYXBfbGlzdCkKIHsKLQl1bnNpZ25lZCBsb25nIGxhc3RfYWxpZ25fZG93biA9IEFMSUdO
X0RPV04ocHJhbmdlLT5sYXN0LCA1MTIpOworCXVuc2lnbmVkIGxvbmcgbGFzdF9hbGlnbl9kb3du
ID0gQUxJR05fRE9XTihwcmFuZ2UtPmxhc3QgKyAxLCA1MTIpOwogCXVuc2lnbmVkIGxvbmcgc3Rh
cnRfYWxpZ24gPSBBTElHTihwcmFuZ2UtPnN0YXJ0LCA1MTIpOwogCWJvb2wgaHVnZV9wYWdlX21h
cHBpbmcgPSBsYXN0X2FsaWduX2Rvd24gPiBzdGFydF9hbGlnbjsKIAlzdHJ1Y3Qgc3ZtX3Jhbmdl
ICp0YWlsID0gTlVMTDsKQEAgLTExNjgsNyArMTE2OCw3IEBAIHN0YXRpYyBpbnQKIHN2bV9yYW5n
ZV9zcGxpdF9oZWFkKHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwgdWludDY0X3QgbmV3X3N0YXJ0
LAogCQkgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmluc2VydF9saXN0LCBzdHJ1Y3QgbGlzdF9oZWFk
ICpyZW1hcF9saXN0KQogewotCXVuc2lnbmVkIGxvbmcgbGFzdF9hbGlnbl9kb3duID0gQUxJR05f
RE9XTihwcmFuZ2UtPmxhc3QsIDUxMik7CisJdW5zaWduZWQgbG9uZyBsYXN0X2FsaWduX2Rvd24g
PSBBTElHTl9ET1dOKHByYW5nZS0+bGFzdCArIDEsIDUxMik7CiAJdW5zaWduZWQgbG9uZyBzdGFy
dF9hbGlnbiA9IEFMSUdOKHByYW5nZS0+c3RhcnQsIDUxMik7CiAJYm9vbCBodWdlX3BhZ2VfbWFw
cGluZyA9IGxhc3RfYWxpZ25fZG93biA+IHN0YXJ0X2FsaWduOwogCXN0cnVjdCBzdm1fcmFuZ2Ug
KmhlYWQgPSBOVUxMOwpAQCAtMTE4MSw4ICsxMTgxLDggQEAgc3ZtX3JhbmdlX3NwbGl0X2hlYWQo
c3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLCB1aW50NjRfdCBuZXdfc3RhcnQsCiAKIAlsaXN0X2Fk
ZCgmaGVhZC0+bGlzdCwgaW5zZXJ0X2xpc3QpOwogCi0JaWYgKGh1Z2VfcGFnZV9tYXBwaW5nICYm
IGhlYWQtPmxhc3QgKyAxID4gc3RhcnRfYWxpZ24gJiYKLQkgICAgaGVhZC0+bGFzdCArIDEgPCBs
YXN0X2FsaWduX2Rvd24gJiYgKCFJU19BTElHTkVEKGhlYWQtPmxhc3QsIDUxMikpKQorCWlmICho
dWdlX3BhZ2VfbWFwcGluZyAmJiBoZWFkLT5sYXN0ID4gc3RhcnRfYWxpZ24gJiYKKwkgICAgaGVh
ZC0+bGFzdCA8IGxhc3RfYWxpZ25fZG93biAmJiAoIUlTX0FMSUdORUQoaGVhZC0+bGFzdCwgNTEy
KSkpCiAJCWxpc3RfYWRkKCZoZWFkLT51cGRhdGVfbGlzdCwgcmVtYXBfbGlzdCk7CiAKIAlyZXR1
cm4gMDsKLS0gCjIuMzQuMQoK

--_004_IA1PR12MB85172F7FE9157C092EDA46A0E3112IA1PR12MB8517namp_--
