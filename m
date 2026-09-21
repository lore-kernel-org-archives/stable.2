Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C2488DA0;
	Mon, 21 Sep 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991929; cv=fail; b=NFdDIM76RfTTzMaJ/Df2ojdsAi2goie2kfpaF2ySJv6LaRbgxyntdUDxKAtPiGsDip7rlZ+I3gH5D0vq0wYIdYAwebkBMfdz3OZX5osutSzOUc7zgIx87utn+Kk6wmIOuszf/y7ixzAW0/vcXaGEIKu+bkz6Z02flRruvmyw8qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991929; c=relaxed/simple;
	bh=k3dNX7STTJUHu2XxmhZyKl63rCdggrgLzEYDh4v/n+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mol8c72YMYwF5fTTFCiTxVUNOpw8rqLhK6oPPu6NtR1VR+PEFMaYI/RofuSupqSa+3QLfX/lOr1IaBT+Idros2oeLlJ01EZj6UAFjI9tB7KNi56UY3Joh8DvowAUXtA210gYDDwwI8dvlleliEtuWcPpIZqP3tC7DGv/szj59o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mrtc8hm3; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mrtc8hm3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAhbePa/6x+5tlH6zpqvn3c6rDH+U9tXGlVvoDUV9yJenEaup3vEd4QiEnUelAithvcst/K45SqckaOS5Z9/AadkVcjLz4T/NZft0mfbIHlhdxz+GL7OMlmeCQDXD2X0L7hvl44rQQULvBiQ/76cFlv2981Iyg+IUI51q5tN8nDa0qlVuBrHMIrMkrk1daJYW4X95VWep9K/xI4hENXRcx4CJLGvePQA5fdMLefJtTj3ZIWB7M1vL2YCJhP/Rd8Jskb39lJSUgqfPnl/LXVuCuAZKFKx5ZBWqOLAqjiBPYu9Xm17RmRF7ODZXPSJTNARKzlUhnkY6BYloPdXHmL/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHJ37jyKnbDiCAdb/eDrsA9ZwcIS7zaAmG/0wd5aDuw=;
 b=JNPTV+RR+vFFFObiVNknIQxYDTMy1KDDNfMKvVaW29IKHt65s+eIsb2973vCVRu/tvXsL8rIo8U9oUd16YVtZNmFT0BhFdGfIMk6mJw2UthzCXeDnTkpxeL0gQY5jEQKDz3Bq4oFwq3z83AY3CebrZJOnRGvVYZ+EuriAZrQ6FMVDKqOwwSmTXJF6LdGb6llNPSekNZmSBYiEpamUgnkU7xpPmeT2lUPXbCGFJSN+H216krFdGesE2Mk0greF0gGpHmt0h6aTJme/rwCODYIOOHk2pXbln7aF9qqnPVcxK2tS34JhqqhRM1f0rpbyVYM0GHAlWvGrFwucrW3PSMczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHJ37jyKnbDiCAdb/eDrsA9ZwcIS7zaAmG/0wd5aDuw=;
 b=mrtc8hm3bnKiGY9sLEr7TF4/t7Nl5ztRqDo9pNHwGbKyHleVhWJIMs95aZWnG+jNiFN/45Jl94NOOfV+6PBiPaz7UlwpzLn95TdsT9Xq0D0jqSP49fuul5LcAcrqbtq2zy3hZZltcl5nTMEf3HSmo586fk780R7YTsge/SID8Qc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:58:43 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:58:43 +0000
Message-ID: <e47aa112-7c09-4c49-9514-6c346dd40c39@amd.com>
Date: Mon, 21 Sep 2026 13:58:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: "Prica, Nikola" <nikola.prica@amd.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jerry.jiang@amd.com, haijun.chang@amd.com,
 andy.zhang@amd.com, jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 gbayer@linux.ibm.com
References: <20260918170735.GA1162623@bhelgaas>
 <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <e7708479-1e9f-45a2-878a-cd857d5468d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa2bd4d-35af-4975-97aa-08df17d7af33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	PJQ8lkfZa+lTnOEcMOVQPkBGpB/A9HnYje0FA868yNp25cv+iOjtLf72Kwmo9dvIZvOcM5h3gP5gLMzCsxXj5x+BBZ3tyLbmbdenHo5IBS/+3GkuNzKWKG6pQtFlpdrc2xuU8ZqxM0zxgXPxdXzR2lz8jTwABQIe9pMZLtk/8H03s3fKvaasHoflHDnaMoaPpydKNE02ePSb6zD9o1onJ57vYaBucd0bd+FnnEPOWnzX6t0yO1FH7qR3H2NhsNbnVdQ5AHstyOEn5/pNOyr8TaNUS5C6nWrcNIXmnAlPI8ZrRtnfX56bdoI1Ny7tMiOgfMlZPX1/RGqErUKpkPjsKx2Nrrr3xyKgbKGhlWlm36GyPLmnJaOG3GYjVrOn0IP/PnIP5j3ynA7Q6vnr3oh0+HH60tHEysHny27l38uGEj5gaFQtsiJgLl1WASXeFMPaHQyhrLpwRKdY/u1yq5CqvgUAsAGNhJBh4gaYAPP0EV6dLCZwQHj9ugV3VLsfClo2rfdMCN2by/I+HC+MVB6KeB6WSqx2gqKq4IrL/5mixW4OxnR2ei9ZgJTchMB2uIrGY3tg2CY2PaJvjdhSTZ0ncXoWZ+0aMGlngG3lbsF8O6yOaFl+kpFpEeIY2mjQEbgW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUVualNPN2doc1BsMnNrTXVPRDg1UlB4a0Y0OHpreDN4ZWlXNHZDWm9GVXNR?=
 =?utf-8?B?bG9TaWJtcGZIYmRwa1hPVDZzZGgzRW94b2wyaWRjczZCcW0wZkJGUU1ZZ3A2?=
 =?utf-8?B?U3pXRW9Uazg0ZkNQbkx5VEhWVzBadnpiTlRFTVZyTGZBWlhnWExJaW1aL1BR?=
 =?utf-8?B?Y1Q4L2dMa1l5WElJUTA3d3F5YU9pL3J5S2ZrV1N2YWtFNEVPdkJJZ0plR1Zl?=
 =?utf-8?B?bFZNU3hJcDZXd2Z3VytzNWxkd1pUUVB0SHdLM1RwUmgxWXAyVEVPRVBqdnV2?=
 =?utf-8?B?ZzNoanJFYm05cEp2QjBpSUhYd041N0k2WHNQUTU5ZzNDVlpsa2lOUW5MbWk5?=
 =?utf-8?B?UnZhaDlUR0VKcmJ3NDljOC9GODBaT2dwZ1pkNGFFRk1YdlNkL2o4cGR4ckVr?=
 =?utf-8?B?TUNzcnpOMUkxTHpUUkJMaUhyNzkyb3Rhcm0xMnlmRXQ0NlFKQzdyWHFaOWxI?=
 =?utf-8?B?Sk1vNHVCVFhmZVlWeU9NLzBqL1E0TmdzY25xRStXaU1BTXRuM0drcDdyNHh6?=
 =?utf-8?B?RkVCd29uVlBsdGJhQnpNaDlkN0pac3U0alNnNVl2NWRFUm1jZDRlWkEvc2Ns?=
 =?utf-8?B?dTJuMlIxWEpWR1dEK1pmR2lSdVpNSENpTkFNUEhwa0MwWU9JN01GM21TNUNT?=
 =?utf-8?B?K1JUdFBzd2NCSndUeEZNRFhNck5BT1d0R0QvRFNNQnZ2T0J5M045THdUZHo1?=
 =?utf-8?B?L3dQQ0UreFRhZGpySE95ZXMzUDVaZ0hFSlByVnNFZUdhbjZnL0o1cmthWTBn?=
 =?utf-8?B?cE1KZUE2eEJNRUc5YnBoYnF1bTVmdUhRTDBCUGRuaTNTalkrckpjL2lzanNh?=
 =?utf-8?B?eEh4T3gxVmtNZGJzdzdqSlRSOVNVbHpXaDMwbWJnNnFMRnE2ODhlWDlBYk4w?=
 =?utf-8?B?YjFZdnBuUmlEaFNVYVpNakNjN216UlpFSGJJbU9OVUtwNUhlZ1dCai9UWmdt?=
 =?utf-8?B?N1l5V0ZxN1dSaUZNTDY1TTd1S21Vcnplcy93OFljSXNCZmQ1NGl0OUFiSXlX?=
 =?utf-8?B?L2xHSFBSblBIcll6Z3M4eGZJektJbjVLbDIxZ29KQWQzNWZha25KcWhPZWpI?=
 =?utf-8?B?RzZScFJia3dxTThBUERxeGFQcUpsUVFSclY5T0d1cGd0QThGR0hsbGNaMGd4?=
 =?utf-8?B?aWU0WHJldjE4Um5BUkM0dld5OGptRzZRd0IyUy8vZlZLLzhnVVZqeUlXOUZO?=
 =?utf-8?B?RVFQZk82SDBJVmgwUXMxa0lsYWtZeEdyRGU3RTZJbSt2b1V4UndtWVVGWGNC?=
 =?utf-8?B?bmdSM2xxWnFmN3BrS3I1dDBSUm9RRmpOanVEL3UvamtVQWxvcWxFZm16ck5T?=
 =?utf-8?B?aktCc1d3UEpyNkk5OElVdDl0SXRQYWpSNFNZd2x3bkFrMGZxNlVKa2pJVFBr?=
 =?utf-8?B?MitybGs0c1ZvRTVhcWJzNnk4Y2JQZFN3Z2VzMXFTK1VBWWovQW9DNVZ2MnQx?=
 =?utf-8?B?WHRQTFFyYS84c1FwUHh1a05ubjBLUUI5UXd6eGI5aWZrRHNnSDFhKzBPY0ph?=
 =?utf-8?B?T3EyODBRREJLQ0ZabXFZNlBXaHJFeERYQStUZXFIK1A0QW9HbGpwWnkrdTRQ?=
 =?utf-8?B?ZHFrdStQT2EwUUFCYzkwdjN3UmEyWGhwdkV3UHBSd3ZUeSs1OXBBQ3k0d2dT?=
 =?utf-8?B?TUswVTBuS05NTXYzYWpTN3V5STQxb1pEbEhiQzI4ajl3MTZPWWdTUEpoek00?=
 =?utf-8?B?SjFjbFBmM201MThVRHVmODVsNjFkd1dHbllIeWdCbFNTb3A2ZVd4VUNkaVN6?=
 =?utf-8?B?ZmZ4bVlxZFY5TmhzVFkwME1obFR3bzNkUUc3ZngrTkY2MTY2ak1GMDVYbTBs?=
 =?utf-8?B?YXB6elVqd0FlSUZabk5LaEdGVmJ2NkU1cTdpQmpienorSllpdElkcGpoS1Iv?=
 =?utf-8?B?WWdKd1J4bnlpZkNXcktqRmVqbEZ3QWxkWEhxODE4MEFoelpXcHovV1pOUTFh?=
 =?utf-8?B?djUyVmhhTytOR1djZXgwUkxvemUvMHkrZWVBT1JZd2dMS0xMaFBvMWdScTlC?=
 =?utf-8?B?Nnp0TEc4eHlaK01IcERHSTNDaVJxU1RmeitjK2huUGY5eW1MaWJsK2RpUEQy?=
 =?utf-8?B?UExxeGU0RlFtNGxKRmtzWnlUbStpbkRLclFIT3dBcjlkd3RTQkdDRERrWmFT?=
 =?utf-8?B?S1d0anp0VW1PWkdyK2MzVUIzY2pURkZ6T0MwTFpWWnZtVDJoR1FKSnhFTjA2?=
 =?utf-8?B?TEIrUGU2eFk5YnI3UEg2cWZJbnJJSnNRSUJaZVNhS0o3ejgvR3RGUDN4Wncr?=
 =?utf-8?B?VUpkVFFjcXp4SDl5WXFVa2thZlNFZ3JjRVdXUSsxSGlRU0lTcnd5V0h0OU1M?=
 =?utf-8?Q?/VGETczpShtGy4tQC8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa2bd4d-35af-4975-97aa-08df17d7af33
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:58:43.6643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIfzJmxU6uAMx0Rymto0SLaX9ltqTStihYrkVpdc47l4PusxNrGwPIoyW3p0JcFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660

On 9/21/26 13:04, Prica, Nikola wrote:
> On 9/18/2026 7:07 PM, Bjorn Helgaas wrote:
>> On Fri, Sep 18, 2026 at 02:07:46PM +0200, Christian König wrote:
>>> On 9/18/26 11:28, Nikola Prica wrote:
>>>> From: Nikola Prica <nikola.prica@amd.com>
>>>>
>>>> pci_enable_atomic_ops_to_root() currently fails when no Root Port is
>>>> visible. That is common in passthrough guests (ESXi, Hyper-V): the
>>>> endpoint is assigned to the VM, but the guest topology has no Root
>>>> Port above it.
>>>>
>>>> In those setups the hypervisor may already have enabled AtomicOp
>>>> Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
>>>> treat AtomicOps as already enabled and return success instead of
>>>> failing the Root Port walk.
>>>>
>>>> Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>> Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
>>>> Signed-off-by: Nikola Prica <nikola.prica@amd.com>
>>>
>>> CC: stable@vger.kernel.org # 7.1+
>>>
>>> Bjorn do you want to pick that up? Alternative I can push it through
>>> drm-misc-fixes.
>>>
>>> Initially I thought that this is a new feature, but it turned out to
>>> be an regression and we need to get it fixed ASAP.
>>
>> Let me just talk through this to make sure I understand it:
>>
>> Prior to 1ae8c4ce1570, pci_enable_atomic_ops_to_root() enabled
>> PCI_EXP_DEVCTL2_ATOMIC_REQ unless a switch port didn't support
>> AtomicOp routing, a switch upstream port blocked AtomicOp egress, or a
>> Root Port didn't support the requested sizes.
>>
> 
> To be technically correct, some hypervisors do not allow guest VM to
> set the PCI_EXP_DEVCTL2_ATOMIC_REQ. So there were cases where this
> set command didn't get through. But drivers relied on return value
> of pci_enable_atomic_ops_to_root(). It may be good to read it back
> to make sure that set went through.

Well that behavior of the hypervisor is a bit questionable.

I understand why the hypervisor blocks such configuration changes, but it is essentially a recipe for trouble.

So I agree that the Linux kernel should be as defensive as possible and double check if enabling the feature really worked as expected.

>> 1ae8c4ce1570 added the requirement that the Root Port be visible,
>> which fixed an s390 case where pci_enable_atomic_ops_to_root() enabled
>> AtomicOps when the Root Port did not support them but was not visible
>> to the kernel.
>>
>> IIUC the regression is on systems where the Root Port is not visible
>> but *does* support AtomicOps.  Prior to 1ae8c4ce1570, we would have
>> enabled AtomicOps in the endpoint and returned success.  After
>> 1ae8c4ce1570, we return -EINVAL because we can't see the Root Port to
>> verify its support, so the driver thinks it can't use AtomicOps.
>>
>> This patch fixes the regression by assuming that if we can't see the
>> Root Port but the endpoint already has AtomicOps enabled, the
>> hypervisor or host kernel that *can* see the Root Port has already
>> verified its AtomicOps support, so all we have to do is return success
>> so the driver can use them.
>>
>> I'm happy to merge this for v7.3, and I think we should add something
>> like this to the commit log to make it clear that it's a regression
>> worthy of a post-merge window fix:
>>
>>    After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
>>    supports them"), pci_enable_atomic_ops_to_root() always fails if the
>>    Root Port is not visible.  On systems where the Root Port is not
>>    visible but *does* support AtomicOps, this is a regression: prior to
>>    1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
>>    success.
>>
>> Is there any problem report for the regression?  I don't see anything
>> at https://linux-regtracking.leemhuis.info/regzbot/mainline/, so my
>> guess is no.
>>
> 
> Yes. That is correct. I'll send new v4 patch with updated commit log
> that appends your suggestion.
> 
> 
> This patch fixes a regression introduced in v7.0-rc1-2-g1ae8c4ce1570.
> 
> #regzbot introduced: 1ae8c4ce1570
> #regzbot title: Breaks atomics operations for headless passthrough devices
> 
> 
> Hope that this will be enough to mark it as regression. If not please let
> me know.

I don't think we have a public visible bug report on the issue anywhere, so that should probably do it.

> One more question though, we encountered this issue with 6.8.0-138-generic
> kernel, we figured out the regression point is 6.8.0-135-generic. Since our
> validation teams are using older kernels too, is it safe to assume that
> fix will be backported in new release for 6.8.0-*-generic version?

That is what the Fixes: tag takes care of. Most likely the kernel 6.8.0-135-generic doesn't work because the offending commit was back ported as fix.

So when the Fixes tag identifies that commit the stable maintainers should backport it as well.

Regards,
Christian.

> 
> Regards,
> Nikola
> 
> 
>>>> ---
>>>> v3: Add Fixes tag
>>>> v2: Be more strict and only apply logic in headless device case.
>>>> ---
>>>>   drivers/pci/pci.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index b2879a6be5f8..62729ade496f 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>>>       }
>>>>         root = pcie_find_root_port(dev);
>>>> -    if (!root)
>>>> +    if (!root) {
>>>> +        /*
>>>> +         * A hypervisor may expose a headless topology with no
>>>> +         * visible root port.  If it has already set AtomicOp
>>>> +         * Requester Enable, there is nothing more to do.
>>>> +         */
>>>> +        pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
>>>> +        if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
>>>> +            return 0;
>>>> +
>>>>           return -EINVAL;
>>>> +    }
>>>>         pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>>>>       if ((cap & cap_mask) != cap_mask)
>>>
> 

