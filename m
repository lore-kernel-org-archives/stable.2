Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005E49B5A9
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538029; cv=fail; b=ts4AIT1rkMpd4V4Dgd2v9J2LBoUF38ZkiXEHb9fPTWsGBrl2lvIsqsmE+mf8EkgjD8Be8eEdlKuVinMDkrkHRm+KoJdblSN/8JsIiWJwJfjiLHZHCMOtClDSBWyXCGMVGfrXhx44yNPloEf+nJ2TmePd8TYPYz6bj8EqyK1zj4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538029; c=relaxed/simple;
	bh=OcxwjVQrqp9vaCjM4BHJOqVrR3Iw4SdVIsiSoKJpkHM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Na/891i+xrVOg0h6RnrT+PsnjdajuMbOVOGX34IQMaIrPLUhVPVoS9kxthxYHjcpx63DQLJHc7xvQnoaGUo5odyeujpDrFxstZgHEcQrJyf0C7XUPRO4+LDMdiF0S/2NSKUXCjO8Q52QJ3ytAMAfkX31FCsmnGBW8a40i/uzA1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mhp6xVqR; arc=fail smtp.client-ip=52.101.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mhp6xVqR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlIZdSW4X+cZPShfVAJaRc+Fc93PrHisS1SDs+Tsgh90WXwNlaZZCQJfEUHErmwTrhymGTE2YbgkwlMDaym7omSBI2gb8k0Qv1CgbXiF9hkLquW7Ps2mqHz/jLTJf0jJW8StKBN2LsEvIy266KMX2CPYvr+zD8Ac1THUGEyTe7wGxpmIEdSiALa6x0PSww9SdcpyyfeeEvgg3sH2Xhi0l5NGNNw7hueKVQIwAmItiQ99j+soUGhELgJ4TlsXvlsEjfkIAjAijzWbMrBzE3jnE/tG58f3TJn49nTxQVBhgb1da9mgW9lxTZMoAgheqNPLsCZpv8n4qzJ4SFcsyro/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sACCCDWk3JT4p2a+L/Lh3FXFUTNc9Obxpy9pcKODqGU=;
 b=UvHUETKl/JzxIwWLN6+q3RSR8kqNeLeZba/OyR+4pJw5mGPANyAydtXBnLR5+3p9omM0X5kJ9/nwZjh31vhwOu8z3DJFoVlz2Tk2tTydmat/jPSmTwNR5szfjY7tw4D3oBdQwoe9Q+EMOQDInIFgkjuM7Xxvc3zsD16iTQ1kmnPwfcMuSTuOnw5HAMp2Fo+81k+vrbI6/ogvbteENI+lgi8R/xduG/IT7iPYi0lpNPW8aNvulYSa9DwBiw883DuVHOuduTIIkHzrbMbkLKufraHoN8WwFgqK8Hy/60vhimEVQ2j4owQzid8XRC826nSH5/xTe2Cz5pd2Hvn1YAOzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sACCCDWk3JT4p2a+L/Lh3FXFUTNc9Obxpy9pcKODqGU=;
 b=Mhp6xVqRUouP9DINTD26CFSlxV5Q6BxknzieWl2ohrWl0lNo/YLNv16q52ZeJ8CAaocZBmEmsuNTjObyrosC698mIpDV9FNaenRTVkn7LG53lLTrmyIYm3eRzrW2Ra2Ah2C6imb7idoxzkTOTTEqeAsXbCw3dNvhel2s0dklNiU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:27:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 09:27:01 +0000
Message-ID: <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
Date: Fri, 9 Oct 2026 11:26:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
To: Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
 <20261007153605.1743626-8-matthew.auld@intel.com>
 <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
 <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
 <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
 <992d57f0-7327-4c36-adf7-6dd72137fe73@intel.com>
 <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: f6365078-f89d-4ac6-e948-08df25e77922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|5023799004|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	+x8w+JzxpeZFSdeu6ljqjq0x8DeuKtcTMd0431DBAqXM4cSWZkcRq1POEbcNJNfGaf3WMWhLQRifWudzhq+TnV5+1S59q4b6yskCKC0RY5HVyQRKCiq75KQLWE4ZiRHycg9oIA22Pm5xP6fNlN7qo7GeGD5x3amSaji0E5XwifVRWn0fOjglXlOspH78GFf6nOjUmDEkVpOOcJY2qM+8BQJwj6PLbhAibAecMS2Fm1smA5tgkSznxfiET0NL0LPhm+ifq5XPOQGMjuFrB+etaNH7lgBp7sLlCG1Uy4viorJ37kMU71LMMXQsox39+J0VQBUfKd755rOa3lCCTNwpf40oJV8Y9PBI7Xw7jt9y+Nqesict9offgDs051PK2Cu/XwYNGZ10jzXUawLOBELA2JJmp+FFtkBSq/U5c1+bNRgu0Vd9EPNtfaV+WqNDyILFw5N4QpJLoIzmmS8t0zZvfXZ9uwDbuU7nNHOHBBsbzdGWBemeAzrgkNt1P2zXtGu6ngNmTXxuTzx2AKy5bywZvp6bmwlb2IVAFXcgcwMTIQgcegQ3x2X4Hc97WZ5GBnF3hSiYushQZO18RXTmzHm1hO8D4+BOS6MR2scH7bqOoD7WLV14azhpl7s5A9bUzVKV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTB0TUJIVE83eUJxa1V6SFlKN3lrK0NKbGNMQ0pVWHVWdkgxaVRoTi9UNE5H?=
 =?utf-8?B?bCtzTHczUE9EMHBzcmxGMUJrUlB4cHFvZjhYNXE3UzZlSEwrTU5BaVk4SkV6?=
 =?utf-8?B?VDR1clFGTGE0U0lRYy9KU0x6cTJuaVhMb3pvWmJPNks3RjlWQU9kQmsxcEp6?=
 =?utf-8?B?OEpHLzFrY3NOc1pTOWw1aUJubDRSdkFKbHlJNFluNk1OWENja05kVisrbk5s?=
 =?utf-8?B?Q0d6TEY3b0llZW8zRzA4dHJQYzJtbjZHZFRIVEdxVWdwekhYdVJJYm9jZ25E?=
 =?utf-8?B?R3NpWCtoaGRLWFNUZmdDZWh4STNjR0E0NmppWmZDdXNsTnV5bi9nMXJFY0Fo?=
 =?utf-8?B?YzgwT0RHRVdmYk9VanRwWkh1NWJHOHlyQjk3anlzQ3VNY3hvU0NCaXV3c2oz?=
 =?utf-8?B?cE5QSDd0N2MvMGEwc1c0OEI5ZWpWYTB2enAzSlYzZytma3BUVFhXeHRpNGln?=
 =?utf-8?B?ODVyYlBzc1F2dkhxcUlOTU9DRXVRcVUzRFRPVkhtR2RRM0J4Qy9FamdMMm5x?=
 =?utf-8?B?NlllQkFFc1ZJYXZzL3pYejhxSjBGdU9HUmZFOEVLc0ZMT1dvNFBJRlE0R1RQ?=
 =?utf-8?B?YkpCYTNHa2hFZ2RLTkR2YndITUF3R2dHdnc0MkMvajVxNUs1eUc1c3BWMGtU?=
 =?utf-8?B?YzB6VnNlWTdFWEhOMkFibzhWeGd3dkF1RzFUZmRKckhQRXRvbmtvVkRYRExx?=
 =?utf-8?B?LzlxSHk2alZoNi8zeis5WFNxY2hxZUhQSGpqRkpQWDlTdU92RUpPcVUwcGpS?=
 =?utf-8?B?ZmhiZEdieHh3dUk1SVFLc0lSbDdjb1lSMFJZaXBNMCtOY1lncEE3bG95K0dS?=
 =?utf-8?B?dWVEdysrTW5ZVy9SYmhHbFR4T0pDdXB3MmVsSXZIWjVkbjRGQXdtY21LQUVv?=
 =?utf-8?B?S24vY0M3S0x3bkhVNDV4bXdRK0l1Uk1hNmJ2WDcrTDBQSElWdTluZnc0YmNR?=
 =?utf-8?B?MHAyMUNsMGNXYSsycmx5aVFDQWo2OUxsM2I2UzB5L2UrZTRXUlBJbTB2aTA2?=
 =?utf-8?B?QWdHZUI5a3Z0RnJDUGsydWpqNVU4NVdkK0RNeFh1bWlIR1FrcXpmMmt1SWJG?=
 =?utf-8?B?UXRHa01NcW1TUk5rb2JTK1FrUW4rRDNzbm8xOU1zU0wvNW5jbENEQXNyWXpa?=
 =?utf-8?B?Qk5SMGZ6cTlVY1F1b1NCZEo2a2ZyakxXaEExVjVLbXNoL0R5NWtSVEFEeTFS?=
 =?utf-8?B?QUhORUVaQUMzK3FJU0lZZmQzbHJQNTdOaWgyU2JGK2RFNjlqOG5WaFFtZFo4?=
 =?utf-8?B?UmY3R0pzUU1OYllDY05TdzRkS28vZnRodk1iZ0RJODdMSnBCNFBRbnVzWlZ3?=
 =?utf-8?B?MFprL1JXTkwxbE91dUFPbTZwMm5tcGxpYXRRUnBiRG5lNE5RMkZHUllsZWxm?=
 =?utf-8?B?NkNsQXlncElBdGxUMXFYLysxYWNCYUhyU1UxcldXU3B0d0E1M1FISE0xSWpp?=
 =?utf-8?B?N2R2bG93VGFML2dtc3BDUm1IZlJNcHFkenBHYzR4VitEcS9KSE1hSU5lRitD?=
 =?utf-8?B?RGd2OS91UlI1WkFNaUdXMHFnNWRrbkplbkxvVHdEYkhPMUZsVWlzOVFvMU5t?=
 =?utf-8?B?WUZNdHRET3dXQThlbnhCMktpUURwakh3SCt3VHN5dkVlYTVEbUlQcXJ1SWxp?=
 =?utf-8?B?d2FqMkZDY2lrdjB4aXFTMHBLaVVKV0l6cDJIUFYyK1pSelB6QzhrVDZFMFJV?=
 =?utf-8?B?WTI3VnJrRHBrU2s1a1hsZEcrTnhmUThKc3poZXJqbFdiQTlxdHp5K2FKN2xZ?=
 =?utf-8?B?b1lqMUZMYk5jK2Nzam5aTmU3d0VQVEIrS2xoNFlvV1JWS1BmWGM4K3YyZzZM?=
 =?utf-8?B?VjFtZHh0aFM4VzB6dXVrMHZHU1ZjZUFOYVRXd04vckJMajhmd0NYbm9ha3Jz?=
 =?utf-8?B?by9kVW5qZnpWbnVBd1RrQi9vMkowSEI0ck94MGxZZHB1eEYybnM1SGMvUTFQ?=
 =?utf-8?B?QW9PRUVYTjlvYVhHcWlicFFJUVdZL1l0T3RJWHlkVnJGTzNWMHp2QmhjczlN?=
 =?utf-8?B?UU56ajE0MVhud1kwK1BtU1VjamtPbzB1NXN1QTVtT3lyQVF6SjRRL1czUHFl?=
 =?utf-8?B?eTJsRkJnMzBMMkx6QlpkT21RbmNPZ1Y4a29NcFlQS1QzR3FzcWxNZWp5aXFj?=
 =?utf-8?B?R0lrTTA2QTJqeXlKZkZ6bDVPcklIRWZuUDM0NW1PZ2xOd1RRZXVqeW5zaWpa?=
 =?utf-8?B?OU95Rm1UQTdTL1MxNG5wVnRUdG9LUFY1cnNiUDJ5RDA2cGlscTdvNzN3cmpY?=
 =?utf-8?B?N3RkV0Q3dHMyZURFbmhJaTdJMWxxVHMvbFlhSCs1M0x0cGdRZmgrZ2o5N3V3?=
 =?utf-8?Q?TjceoOSdCNfxeyk94K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6365078-f89d-4ac6-e948-08df25e77922
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:27:01.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3BAJ/qw8Av2fwehcES/W0HWoxlffRXN86Gtj5q091aw64ktDNZ8I6N4p1fmQY/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

On 10/9/26 11:16, Matthew Auld wrote:
> On 08/10/2026 12:17, Matthew Auld wrote:
>> On 08/10/2026 10:55, Christian König wrote:
>>> On 10/8/26 11:46, Matthew Auld wrote:
>>>> On 07/10/2026 19:11, Thomas Hellström wrote:
>>>>> On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
>>>>>> If p2p is allowed on the CPU (like on AMD), we currently permit p2p
>>>>>> for
>>>>>> all exported VRAM buffers. However, in some multi-GPU setups, like
>>>>>> with
>>>>>> prime rendering on a dgpu and scanout/compositor using the igpu, it
>>>>>> looks like the exported dma-buf window buffer can in some cases end
>>>>>> up
>>>>>> using p2p.
>>>>>>
>>>>>> However, user is reporting a kernel regression where performance here
>>>>>> massively tanks across many games/workloads, where it looks like on
>>>>>> each
>>>>>> frame, the igpu is reading/sampling from VRAM over pcie for the
>>>>>> window
>>>>>> buffer, since it uses p2p. p2p is currently more intended for dgpu <-
>>>>>>>
>>>>>> dgpu, and not so much display buffers with igpu <-> dgpu, at least
>>>>>> for
>>>>>> now.
>>>>>>
>>>>>> We don't currently have any hints to say "please use p2p for this
>>>>>> buffer, or please don't", however we can use some heuristics to try
>>>>>> to
>>>>>> determine if this is likely a display buffer being exported to an
>>>>>> igpu,
>>>>>> which probably never intended for p2p:
>>>>>>
>>>>>>    1. FLAG_SCANOUT being set on the buffer. Window buffers usually get
>>>>>>       tagged with this, but not always.
>>>>>>
>>>>>>    2. Importer being a PCI device with display, which is not xe driver.
>>>>>>
>>>>>> We also rely on the existing p2p Intel CPU whitelist to stop this
>>>>>> happening on xe igpu. Currently p2p is only enabled for server CPUs,
>>>>>> on
>>>>>> Intel. We also limit the above to dual placement buffers.
>>>>>>
>>>>>> The original regression was bisected to commit 609fc8766d68 ("dma-
>>>>>> buf:
>>>>>> Always build with DMABUF_MOVE_NOTIFY"), however the behaviour was
>>>>>> already present when enabling that knob, so this goes back even
>>>>>> further.
>>>>>>
>>>>>> User has confirmed that along with the sticky dma-buf TT placement
>>>>>> fix,
>>>>>> to prevent ping-ponging, the performance is back to normal.
>>>>>>
>>>>>
>>>>> Actually, I think this needs to be fixed on the importer side. Until we
>>>>> have some some user-space hints, I don't think the exporter should
>>>>> second-guess. Most sane solution IMO is if igfx importers could just
>>>>> not advertise pcie p2p support?
>>>>
>>>> Yeah, not sure tbh. I'm not a huge fan of this patch either. But you could argue that the SCANOUT flag is already a good implicit hint/ signal on the exporter side, but unfortunately there were some games where this did not reliably work. The other implicit hint/signal is perhaps the dual placement angle. For example, in compute-runtime, it might be that they use VRAM-only if they want p2p? AFAICT mesa for us always uses a dual placement or just system memory for these types of buffers.
>>>>
>>>> Christian, do you have any thoughts here? We have a kernel perf regression after DMABUF_MOVE_NOTIFY was made the default after updating to a new kernel. The gist is that this then turned on the p2p paths, with a multi-GPU setup with an AMD igpu/APU and Xe dgpu doing prime rendering. From the user bug report it sounds like the dgpu linear window buffer exported to the compositor (igpu) is dual placement VRAM + TT, and so this now attempts to keep that memory in VRAM instead of moving it. Compositor then uses p2p to access it. It works but performance falls off a massive cliff here.
>>>>
>>>> Perhaps Intel Mesa side should use tt-only for this type buffer (?), but since this is a kernel regression I was hoping we could fix this on the kernel side.
>>>>
>>>> Some questions:
>>>>
>>>> 1. Do you know what is the general story with p2p between igpu and dgpu? Is this a legit thing? For igpus/APUs, advertising p2p can't be dropped? It clearly seems to work though.
>>>>
>>>> 2. If this is legit, do you guys then also prevent p2p with display buffers? Are you just doing that at the Mesa level, or is there some magic in the kernel also?
>>>
>>> If I understand that correctly that the igpu is the importer and the dgpu is the exporter then yeah Thomas is right that definately needs to be fixed on the importer side.
>>
>> Ideas on how do that? Could we do something like allow_peer2peer = false in amdgpu_gem_prime_import() if this is an APU device, or further check if the exporter side is not amdgpu, like APU + Xe?
> 
> For example: https://gitlab.freedesktop.org/mwa/kernel/-/commit/7ec86c68b42655b4bb85ee90af434a617e7bec8c
> 
> Is that something you would accept?

No, you misunderstood me. Enabling P2P is perfectly fine for APUs and mandatory for a couple of customer projects.

The buffer should just be rejected from scanout in the display code and on the AMDGPU side we already do that if I'm not completely mistaken.

Userspace has fallback path that when a DRM atomic requests fails for an imported buffer it falls back to copying the buffer first.

Regards,
Christian.
>>
>>>
>>> At least for AMD APUs we clearly support P2P both as exporter and importer, but what isn't supported is to scan out over P2P. We explicitely reject that inside DC/DAL.
>>>
>>> And I'm pretty sure that you should do that as well. I'm actually really suprised that this works technically and doesn't cause corruption or anything.
>>
>> AFAICT on Intel iGPUs it will currently always end up with peer2peer = false on attach. Not 100% sure if direct scanout was happening on the p2p buffer itself, for the user report.
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Thomas
>>>>>
>>>>>> Assisted-by: LLM
>>>>>> Closes:
>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>>>>> GPUs")
>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>> Cc: <stable@vger.kernel.org> # v6.12
>>>>>> ---
>>>>>>    drivers/gpu/drm/xe/xe_bo.c      |  3 +-
>>>>>>    drivers/gpu/drm/xe/xe_bo.h      |  1 +
>>>>>>    drivers/gpu/drm/xe/xe_dma_buf.c | 63 ++++++++++++++++++++++++ +------
>>>>>> -- 
>>>>>>    3 files changed, 51 insertions(+), 16 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>>>>> index 5065a7bac39c..e63437a261cb 100644
>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>>>> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
>>>>>> void *data,
>>>>>>         * Display scanout is always non-coherent with the CPU
>>>>>> cache.
>>>>>>         */
>>>>>>        if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
>>>>>> -        bo_flags |= XE_BO_FLAG_FORCE_WC;
>>>>>> +        bo_flags |= XE_BO_FLAG_FORCE_WC |
>>>>>> XE_BO_FLAG_SCANOUT;
>>>>>>          if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
>>>>>>            if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
>>>>>> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
>>>>>> *file_priv,
>>>>>>                       DRM_XE_GEM_CPU_CACHING_WC,
>>>>>> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
>>>>>>                       XE_BO_FLAG_FORCE_WC |
>>>>>> +                   XE_BO_FLAG_SCANOUT |
>>>>>>                       XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>>>>>>        if (IS_ERR(bo))
>>>>>>            return PTR_ERR(bo);
>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>>>>>> index 1ddf3b6d4a9e..6965c2655731 100644
>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.h
>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.h
>>>>>> @@ -56,6 +56,7 @@
>>>>>>    #define XE_BO_FLAG_FORCE_USER_VRAM    BIT(25)
>>>>>>    #define XE_BO_FLAG_NO_COMPRESSION    BIT(26)
>>>>>>    #define XE_BO_FLAG_NEEDS_1G        BIT(27)
>>>>>> +#define XE_BO_FLAG_SCANOUT        BIT(28)
>>>>>>      /* this one is trigger internally only */
>>>>>>    #define XE_BO_FLAG_INTERNAL_TEST    BIT(30)
>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>> index b973579a69b8..0a347f09cee4 100644
>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
>>>>>> _ddebug *desc, bool *flag)
>>>>>>    #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
>>>>>>    #endif
>>>>>>    +static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>> *attach)
>>>>>> +{
>>>>>> +    struct drm_gem_object *obj = attach->importer_priv;
>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>> +    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>> +
>>>>>> +    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>> +}
>>>>>> +
>>>>>> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>> +    .allow_peer2peer = true,
>>>>>> +    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>> +};
>>>>>> +
>>>>>> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
>>>>>> +{
>>>>>> +    while (dev) {
>>>>>> +        if (dev_is_pci(dev))
>>>>>> +            return to_pci_dev(dev);
>>>>>> +        dev = dev->parent;
>>>>>> +    }
>>>>>> +    return NULL;
>>>>>> +}
>>>>>> +
>>>>>> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
>>>>>> *attach)
>>>>>> +{
>>>>>> +    return attach->importer_ops == &xe_dma_buf_attach_ops;
>>>>>> +}
>>>>>> +
>>>>>>    static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>>>>>>                     struct dma_buf_attachment *attach)
>>>>>>    {
>>>>>>        struct drm_gem_object *obj = attach->dmabuf->priv;
>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>        bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
>>>>>>          xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
>>>>>> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
>>>>>> *dmabuf,
>>>>>>            pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach-
>>>>>>> dev, verbose_p2p_dist) < 0)
>>>>>>            attach->peer2peer = false;
>>>>>>    -    if (!attach->peer2peer &&
>>>>>> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
>>>>>> +    if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
>>>>>> +        struct pci_dev *client =
>>>>>> xe_find_parent_pci_dev(attach->dev);
>>>>>> +
>>>>>> +        /*
>>>>>> +         * There are perf issues with using p2p with display
>>>>>> buffers,
>>>>>> +         * like with igpu (compositor) <-> dgpu (exported
>>>>>> p2p window
>>>>>> +         * buffer). Probably we need some actual userspace
>>>>>> hints. We
>>>>>> +         * shouldn't really assume anything. Also, note that
>>>>>> some of
>>>>>> +         * these buffers are not always tagged with SCANOUT.
>>>>>> +         */
>>>>>> +        if (bo->flags & XE_BO_FLAG_SCANOUT)
>>>>>> +            attach->peer2peer = false;
>>>>>> +        else if (client && pci_is_display(client) &&
>>>>>> +             !xe_dma_buf_attach_is_xe_device(attach))
>>>>>> +            attach->peer2peer = false;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
>>>>>>            return -EOPNOTSUPP;
>>>>>>          xe_pm_runtime_get(to_xe_device(obj->dev));
>>>>>> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
>>>>>> struct dma_buf *dma_buf)
>>>>>>        return ret ? ERR_PTR(ret) : &bo->ttm.base;
>>>>>>    }
>>>>>>    -static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>> *attach)
>>>>>> -{
>>>>>> -    struct drm_gem_object *obj = attach->importer_priv;
>>>>>> -    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>> -    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>> -
>>>>>> -    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>> -}
>>>>>> -
>>>>>> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>> -    .allow_peer2peer = true,
>>>>>> -    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>> -};
>>>>>> -
>>>>>>    #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>>>>>>      struct dma_buf_test_params {
>>>>
>>>
>>
> 

