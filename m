Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011008.outbound.protection.outlook.com [52.103.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9C33F377;
	Sun, 26 Jul 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062710; cv=fail; b=lBETXbb6dKKatDSPpyMdZKoQyplCDFYG7W70ids8VuebEEyhOlTlUipqaEHT3kA1sRkxmW6OVL5Yc6zkU7OANrg+GmS8LFk4Q/Rp9umVYBXQ4hcl1c1gE5kiwYaAbTELWXOo/pjm27reDFa3uLWsu62/mdo+RdMPeX4WGqyWI+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062710; c=relaxed/simple;
	bh=XvkV9+L26RAXU8HXlsY4gdtV+6zoHMQsqosacR8zcp8=;
	h=Message-ID:Date:Cc:From:Subject:To:Content-Type:MIME-Version; b=WccZ+JQZcKgAfb2qJ1ikh6H+GrUnmftSKRqKP1UfS//gr7NpGTHxD7oj2VKyCIIQXfFDspVwGlof13n05Vg8LHZU/8IKdnXkHHpFvFY3sLrbwfCKY/72hyv49hazeEirVkj6Vy2x0uQy3hCbIUt5yKVahrJQW6D2gq592Z6TFgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LDKUkg1U; arc=fail smtp.client-ip=52.103.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LDKUkg1U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/SGpWPti716z5ISyLsZYziHn7EzKIzN6pEv51rBOZ1yXRND4Tbt0X16MoVoWuRZ0JgIvt4AXh7XQ7PAkHf9fy6CZhTdOxqvV2c+sgiKznr673+tcEIe99eheTK3hE5JMnr2iyB7O/KyoMdBbnnv7jgOLUY0cxa9r4dYKQhlU67dw1b9KuQuvq1jwLkWFiPEuip72rh4gNnTAayNz9fpoBJdH7ngY29obdGhIHJocuH4ijys56f+/9OXnExUJl8EFuso3WhYcQlgeNiSalh3U+po+VdkPvpLfUgttZJFMtdDsrGeFFOT7K5Xm7Pf/13NsBdhoph8hrLFYgeexcPEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2jrQMbIvl9pcaczgcKVGzz8XxFn00wvGasF2pdhbdw=;
 b=o1ACka56270dvYUL0m7tdaoGARmB0iX167xUft6x56RjSEIJQnLnSzKpCLuAaoiIquuU50VJUoQdXdrcKYI7j4kKhV9BlVgdPRu5cOaMb5ttkNJzvOYah0SdKml5jX2YmfcNX4P/KHNZ331bDkufWe/CoJKwlqf6YIAjkY4ZXxu/wCG02DUGbC2+FEt91qc14c8H8byryJVPa3yBwo/sAk6xZbuzrZHTHJA1egrdTsVmo6DXgDUrp5dRKb0sYIfG4W/FTzKmaYt/pWBOXTORIW3bVp8WKVkQruiY/OBd58Pcu/P/wkK3JxiyA5rPg7VbHAYoHdRzf4u3cYCs0xd1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2jrQMbIvl9pcaczgcKVGzz8XxFn00wvGasF2pdhbdw=;
 b=LDKUkg1U6OcNt4pJVaDz3OIb8MFhPAacx1UjWkky7zKvDh2BO6hwER5U0stYDm55o533ohHCSNLaA6Lhp6PjCtYZhuF2CrGAln8eVCcI9B1Isx/HSPwSQQDbwfBZSEP693iav1GcJ35Yn4CBQoVo8O4qp94HQu/yuofY5DDo4raLr/9jS/EaqV2ZSNMdkFRXnj21RVL/uZ3izySP34/XemTRdAgyCDWseeewnlWZE5nnUavmu9Y3aikblA9SC8luzzD5/xfS7R16EYzKbM0pv+1x9ojKZDPDjn10Jy8aIl6/ytTaPJWn67ULIJxf3H5wificTspDRP4KtrBj/vlZYw==
Received: from OSCPR01MB13468.jpnprd01.prod.outlook.com
 (2603:1096:604:333::13) by TYCPR01MB9336.jpnprd01.prod.outlook.com
 (2603:1096:400:194::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 10:45:04 +0000
Received: from OSCPR01MB13468.jpnprd01.prod.outlook.com
 ([fe80::b096:31ee:f7bb:82bb]) by OSCPR01MB13468.jpnprd01.prod.outlook.com
 ([fe80::b096:31ee:f7bb:82bb%6]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 10:45:04 +0000
Message-ID:
 <OSCPR01MB13468557BE10B1EAC08EAF183C6CD2@OSCPR01MB13468.jpnprd01.prod.outlook.com>
Date: Sun, 26 Jul 2026 18:44:59 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Vivian Wang <dramforever@live.com>
Subject: [PATCH 5.10.y/5.15.y] KVM: VMX: Make vmread_error_trampoline()
 uncallable from C code
To: stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0205.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::12) To OSCPR01MB13468.jpnprd01.prod.outlook.com
 (2603:1096:604:333::13)
X-Microsoft-Original-Message-ID:
 <e64bf472-370f-415e-aef5-441782ac5e3b@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSCPR01MB13468:EE_|TYCPR01MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf9747c-efa6-4c5d-ed51-08deeb02f353
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|25010399006|24021099003|5072599009|4140399003|23021999003|39105399006|6090799003|41001999006|5062599005|12121999013|8060799015|19110799012|3412199025|440099028|4302099013|41105399003|40105399003|10035399007|18071099003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azJkZjhwUk1vRHJtUFRHZFFiQ3RJbjExYlkyWUJpQ1JKMklhTnFyVnozOEho?=
 =?utf-8?B?SkJ3V0ZLa3REczFsYVp6LzRZb1Byb1BTd2Q0a2tFWnFiM215cWRLZm9DMWFO?=
 =?utf-8?B?aDNHbTk3QUNEU3VkeTNxWXJNQVNtbXJQRWZWNmozQXZyZXZDUUE5LzV4YTZR?=
 =?utf-8?B?VUhLbE94Y0JJVzhObnROM0lTYmtZUzJkbFR2NUtzVzNCa2R6MU5GWXFYOHRa?=
 =?utf-8?B?MFRZR1Y4MVlqUW85eUhWS2hrb1g3TENHRFZHcGJUVXJ5cEwxQkh6eDRuRVhu?=
 =?utf-8?B?Unp6NUdtYjMvTU1WN09PSXlWUjFLdkhPOFNIZEF4S2NBN2JUckZGYW1IOXNY?=
 =?utf-8?B?NlFtOVppcUI5dHhQMk45Y1kzZktpUGhvckxoOEpUY29yWjRyU2V5dG5qdU9P?=
 =?utf-8?B?anI0cXJFcWh3b3J5ckMrV2s3cS9oVENPOXhYY2FwSFFncVl2TkVmOUVkdEk1?=
 =?utf-8?B?VkpIS1NXcFAyR1BadEFrNElYMlo4TUxudjlXUFIvb1UvcEQwN3pFbGpNMjJ3?=
 =?utf-8?B?amo1bVUwVytMMnZ2Nk5VUUk5MElXcHlHL2RodmVKSFI3UFNkZTlvSWRNUzZo?=
 =?utf-8?B?RDBOam9ndG5YdjF0akhEZWdFMzFMQkZYU1Ixd1VWSWYwNHgvdEprUnQwZWJX?=
 =?utf-8?B?VjZUSWtVRDRLSmlkcWV3SnAxS1lnajNFdmtRbWsyMjEwbU13bC9sVUNacnhp?=
 =?utf-8?B?azd0NnZiaWcxa2hxUFI3eVdid0ErdE0rUlFPdVVMdE1NU0JMeHBobFdraWs1?=
 =?utf-8?B?ZWppTGZ0cm1QT1pFSzlQbW55Rk9Eb1QvdUZ3YTNNTmMyeDV2MTRTZjBYSVNw?=
 =?utf-8?B?U2RzaFlSZ0xGV09yNi9Fc1MxZ3dvUzZML3FJRGJDM3VWdFE4ejVZdWpQSkNr?=
 =?utf-8?B?dDNrZExxK05qVElnc0tXeVhnOU5JdTdKa0xvbkZzeFcxYUVvK2ZQR2lTcnBM?=
 =?utf-8?B?d0JLZEgxc3hHNFpSWXVTM2gxZnBwQ201a0lUSldyVUl1RWpLK1IrK0VxTjZ1?=
 =?utf-8?B?RkFtTVRReFRnQU5kMmcrOUhFeWVudkJkWEVVQ215MHR0TWtWMndFRjVoUHJp?=
 =?utf-8?B?OWtiWjV2TzNZR1EvK3R6ZEdrYXF6KzZ4MG1YU1RaczNQb0RhS2tIYTVHWG9m?=
 =?utf-8?B?UWgxOWZKc2l6NnVUUTBGWUlpSHkrYVQ5eU90cjk5OHc5eUxDeFNWK000MWVx?=
 =?utf-8?B?MmkwZFMvYUhrRWVOcmM5TFZHVlR1MU9mN3kxdCtBM3hlUnN2eVdsMVpVQ2Q0?=
 =?utf-8?B?VnhOVVJDRzEyd2p2TFBSREtqTEUyVHVBTlRRbElsYmNqeXVBSmhManBzaU9O?=
 =?utf-8?B?SGtnMjJRdmg0eTk4UDYvcTJ1SEd2OTFPTWZOSXNFL2FNMGZqVlE1cU5tYkFv?=
 =?utf-8?B?cEpxMHh2eVBLejRSMTBQVGN4KzlCc3FJbnU5SUUyVi9mTkJCeEtFU3ZaVk1a?=
 =?utf-8?B?TjlLRnk2V1MvbzlFWFY4MHpYQ1dPR1dXZWZUYnpvamgxaXhEbE1UYmlMTjJo?=
 =?utf-8?B?N0hndkJRWWdDT0dQbjIrUkl1amxZNmNab2MveG14M0VpNmlwNkFTUGZTMmM3?=
 =?utf-8?Q?Y3R8yZH3E7UAGmDK/pFH1ryNg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnNxYlZQWWtmSlJ6RkVXcjJrZnJUQ00wU1YvdllZQlB1TmpYL1hOMFUzcW16?=
 =?utf-8?B?R09PSVpxMEhtZXJHRGdHSHJCVUFDTUE4eW9xVUZQRC9tWkNGaGR4MjNlZmE2?=
 =?utf-8?B?NHI2SEZHeGp1Q1piN0FSTE9sbVN2dUxOMDcxZFFLR2pwUC84dVBoQ2xUdmZy?=
 =?utf-8?B?cm1TUTZzZzUwNkkvUWF5aHdsVDVQL3BGSEVnM054YXY3aHJsa0lLZ3BVRjE3?=
 =?utf-8?B?ZU5EV3JOWS9oYk91VlBJNlRFVUFhK1kxN2JLUEp3S2lUWXltNm1vSWxZNGYx?=
 =?utf-8?B?VmhnWWYvbmhIN0ZTVE9VOExuQUFxNENxRXhuaC9EYTVRcFA0bFhNSnhBTjBD?=
 =?utf-8?B?NlU3Ui9kb3kzVXRkQXFrSEd6c1R5NkhxVlhTRmdKeThTUVQ3SGFjYzF2WU4r?=
 =?utf-8?B?NzZSKzNCYnRSR0J5R0Vtb3lwblFxUm5rRlJTRmwvZ3JSRGVSY2c3WEttVmpj?=
 =?utf-8?B?MnRIbTNJM003dmU4amdFY0o4S2RhRVBFZFVLNUtVQkZKQmpabGV1NGVmbGR5?=
 =?utf-8?B?OWdnVm9RZXJoZDFOSGF2OXRxVitDOGZQeEdDNFJpU2JOUk5tMmVFNDFBaC81?=
 =?utf-8?B?NW1uNDFRVUx3c0l4Um5nSHJhZHZaUyttYkxJbVhUVS84MmQxakVDNWpiNENM?=
 =?utf-8?B?cHJRRno4dUUvYjBJY0JmQk9uOTZ4YmRMRTVOOVQ1ZjIrOFVrVk1wemxIU21Y?=
 =?utf-8?B?SXBEMGJYY3UwdDRHS0NwbzA1K3JtdHZ6MUQ0amN1TTYreGp6L2l4aEI4a3RX?=
 =?utf-8?B?V2s0cFlmd05hdytvRzFXblY2Q1RXSlVES0RxeGVHZ1lkUFFNeGowajJXNEZq?=
 =?utf-8?B?d052QnB5R0VBb2k5QjVDdVgzWlk4NkxDOXN4blFWVUhraUdjWi9IYXlwSWNl?=
 =?utf-8?B?S0lGc1NTNS9xSFJDYVZuTFZhQXdYUWg5R1dDN2dpOEZaYkFaUlFTRnJ4YWRt?=
 =?utf-8?B?em9hRDBOSlJpMklQaGs2SG9RbkNJaVhheU1Oa2tjdzVCK2daRDVBditlMzVY?=
 =?utf-8?B?YW4rZFZ6MEtLUEY4TkRqbWVRS3Fmc2p3Z1FCVk81czhqdytJdElVcHFOVEdy?=
 =?utf-8?B?ZGlGUGJjbnk0NXhtbEV4eGtUV1h1ZlBia05XNE0zU2hCUlBZbnhZYUhHdnQ4?=
 =?utf-8?B?NStZb3VZYnk4R0ZOc1phZEIzaW5GdVdKZmhmYWhXa0FXOFBmQWt2bDM1MCtS?=
 =?utf-8?B?ZnAyM1ZmS2ZTWGRVNDZ1T1JlOU5mQ2drd0dHN0ZCMEVMWUV2REZRTVkyOHhT?=
 =?utf-8?B?TzgyOHczNzRNQktwL0RyU2RxeGJkczFzeVpoUkJXMjVSakl5eDlpck1hc1Rs?=
 =?utf-8?B?eXdSbm45eFFOaUVoRm5rMFQ5MDFlKzc0RmdqZUZPTjZ5YlZNd21yNUhXMXRj?=
 =?utf-8?B?WGlzeUUvaHZUNnIxQUwzRCtkbW9LMUVmWUFic3JROXptOC9EcTlNbDBlcS9C?=
 =?utf-8?B?czh3MndUczFoUWczOE1TMmlwNXpRTVorQ0lySDMyZVVObTZucFk5YmkvRHpm?=
 =?utf-8?B?WThoMlRGWGRrQTdtemVBOVp6NzYyZmFTdE5zbHNSeXlaMkgwUkYwQXJlM3RZ?=
 =?utf-8?B?Y0FUbTNxRkRBTDVVYlc3OW53K2E4QWozVSs3REpCZEpWUXNvcm13WFRvMWc3?=
 =?utf-8?B?cEhNV1A0TWRpd29Ia1pzV2xEQ1FmTXNDL2Vta2xHTjczekQyQ0M2U1lLZHdF?=
 =?utf-8?B?bGxkeWdkQk9MWnRuNEljUDhpTmxCUm0xUk10WUdXbyt6RGVzWDgyWVNCeXVP?=
 =?utf-8?B?UlN6TStNT283bFMxWk5udWpEQ3Z1MUw5cmZ4c2swdG91dHlBTyt5bjJPUzNL?=
 =?utf-8?B?QmVLeEYvMkRKcW0wdmNLVk1heGZPMW9kZzUwaGVHRGw0Tjg4NVROVHkrZyt4?=
 =?utf-8?Q?tk5xNkExvqk4y?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf9747c-efa6-4c5d-ed51-08deeb02f353
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 10:45:03.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9336

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0b5e7a16a0a79a3742f0df9e45bca46f01b40e6a ]

Declare vmread_error_trampoline() as an opaque symbol so that it cannot
be called from C code, at least not without some serious fudging.  The
trampoline always passes parameters on the stack so that the inline
VMREAD sequence doesn't need to clobber registers.  regparm(0) was
originally added to document the stack behavior, but it ended up being
confusing because regparm(0) is a nop for 64-bit targets.

Opportunustically wrap the trampoline and its declaration in #ifdeffery
to make it even harder to invoke incorrectly, to document why it exists,
and so that it's not left behind if/when CONFIG_CC_HAS_ASM_GOTO_OUTPUT
is true for all supported toolchains.

No functional change intended.

Cc: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20220928232015.745948-1-seanjc@google.com
[ Vivian: Adjust context. Remove check for CONFIG_CC_HAS_ASM_GOTO_OUTPUT
  which does not apply for old kernel. ]
Signed-off-by: Vivian Wang <dramforever@live.com>
---
Note: This is my personal email. I will reply from my work email to
confirm I am the same person as Vivian Wang <wangruikang@iscas.ac.cn>.

This fixes build on GCC 16 which trips -Werror=attribute with
KVM_WERROR=y (the default). Please consider for 5.10.y and 5.15.y.

This would help avoid workarounds in NixOS/nixpkgs, where we have all
kernel versions the stable team supports, but also would like to switch
to GCC 16 before 5.15 and 5.10 go EOL by the end of 2026.
---
 arch/x86/kvm/vmx/vmx_ops.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 9e9ef47e988c..6d342e4f5920 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,14 +11,26 @@
 #include "x86.h"
 
 asmlinkage void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
 void invvpid_error(unsigned long ext, u16 vpid, gva_t gva);
 void invept_error(unsigned long ext, u64 eptp, gpa_t gpa);
 
+/*
+ * The VMREAD error trampoline _always_ uses the stack to pass parameters, even
+ * for 64-bit targets.  Preserving all registers allows the VMREAD inline asm
+ * blob to avoid clobbering GPRs, which in turn allows the compiler to better
+ * optimize sequences of VMREADs.
+ *
+ * Declare the trampoline as an opaque label as it's not safe to call from C
+ * code; there is no way to tell the compiler to pass params on the stack for
+ * 64-bit targets.
+ *
+ * void vmread_error_trampoline(unsigned long field, bool fault);
+ */
+extern unsigned long vmread_error_trampoline;
+
 static __always_inline void vmcs_check16(unsigned long field)
 {
 	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2000,
-- 
2.54.0


