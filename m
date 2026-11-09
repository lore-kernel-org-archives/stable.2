Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241476;
	b=vdI3+gQzk5og40EiD0dUTdf0DHi0QyTAxzG0HzX7g3Iw4niim8n3x7ZcHbBquUS7iy+h
	 jxNND2o+6lAy4ucngCcXLo1hZCWS2UVEOhPxt55Jy0QsqT2avsFAsLKj/05YUxqkGnFEx
	 CVHNzkhP3KNZvs8gfdXXITloKcZJgigVj9tfO8n5HzbOpHGmkr5DS23P3YmVmctg1w1xG
	 JyvuSC8NbS+/CVFgZmXsepkJi/1Mye3p6Gr4dcjQrKTB+OhuX+e4qoZD9yeDjdRCxoblA
	 rXrkbXwow5ktGbdkWO0qVh0rJFvhDMpBC8tazHORfwu+Ya1d+SnfprEJ2TS/aiXEP4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241476;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wxzIwZBXQwQmi8OchGXP2O9s4V8MOMMVWtVq0gehf4o=;
	b=Q7y81nf3em/Z719hydy2+BAV71nKLdQT6yPmqL0CXFkU9MBxJ5PsiahV3T0aSca5KdjM
	 nMpKnYO0kf6iNjnqx9W7pWL49RpHGUx8+LNfU9YQEPuPAF6CU+2AOfY6BQ5SNxp/D8HaF
	 U9q8BpiNqcA0nIIQkJ8V3f4dZzjqiR7EtN7ynt5EwaSZbhrowVnWJTK0+k1fqKaGuYDp5
	 6OgPi40bc6O/B12joZ3DFghDfvkbNiNoU08UQRIlN8pCobUHwjlUgHkPgfA5WuqSQ+DMx
	 kkI/Zps9oc7myXfY8Iugyw+hHJJ6QynZEJJMVG2G84itkHYbGODl4LgPUUPaDJDjR0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QIX+aSjf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041C606A31C;
	Mon,  9 Nov 2026 16:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B041C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QIX+aSjf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaENBG2LD224Fu/j7eR8GetSgWyPbYarcELcxWw1t7zF4uBX8TUE8qUZYopYLl4iOYaVnro4Jv1NDOyHg+6pZ/+Ut+oXsbzbok1HvBJdyvj+R0GjOFvoVjMOEG/MpP88HmYvT0nDFJWIPBAIS0ZBaFvbhN+ZSIT+/v48Sq4UsO0Ke1oAlisWIATE1t1TWMXA7oerZ/5RLLtJ1qUoE0PTqyXIyn1JBNiGm42i1bacp5YZ6e/YkctjSrYFZNs3hdi+CpZRAa1hjEozqEnYeTKtwPNqP0Z66MdzqrV9UukPIjSEgeCeONe1u4fhKMKFdHAYnp/w3J1WPbp+NXyg2IgMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxzIwZBXQwQmi8OchGXP2O9s4V8MOMMVWtVq0gehf4o=;
 b=VRgvUV0+ntxskNGv/hYPFvEt0JXGaCSbSVR3ivcd64MxkO5Pa0LEB5eHX7D0fqu8caERtmTeWj29iY/vjjY4PYb9noMcePcVgX9gJabUj8v/Cs41bmOWLBoTOKDtHvWs2ZH/ORh3GhjEqLZ55VRfIIPoiiFFhsNpOebOMTNGmTCABTfb1Mm/JLF0Mrn9IMRz2lFdGhUHn0KxzW7dN3MeIxkpopC8FvjRTeKu+6DWsLRsfdZYkxpDC5E2CPQ8RNKd9uQToneQ2gwy4VPcOEvkdtM2i0wdgemIYQRxE3uTRPMg7I36gZ90PyBFJ35eIv+gI7ISnUI4zJlZUueD3LesIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxzIwZBXQwQmi8OchGXP2O9s4V8MOMMVWtVq0gehf4o=;
 b=QIX+aSjfVdBupJE4SiFkmcOxbGGuRySKw/Zn2W95cKyM71U3p2QUbH+13jP3RJS0kv7cDGmqHHehCnIVMOinWYSaioWyBKy9YmQ4RpEwMZT3KwgdywUQaDKPQO1nHf7eefCCCS6Hngo21NNx62/MvdXJBQhd0uw+3KGeLIWIMxDKOfbK+DVGXWqbULvdWscNpIgtjqzb/wWmlIdzfHBGIutppNdBv3J1aQW+BS4E1ae3y/aOGvzYQwiMdazOUi6L5BLxiCTC4rGakV5mxLW8dE1RUZ89xt8zyhDyDKtLoFIe2/lBPsBtFV8si+TTHs/WBczcUkqY51wYRLuNqbFcMg==
Received: from BN9PR03CA0882.namprd03.prod.outlook.com (2603:10b6:408:13c::17)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.12; Mon, 9 Nov 2026 16:24:17 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::a5) by BN9PR03CA0882.outlook.office365.com
 (2603:10b6:408:13c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 16:24:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 16:24:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 08:23:49 -0800
Received: from tuxedo (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 08:23:44 -0800
From: Petr Machata <petrm@nvidia.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev-bot+sashiko@kernel.org>, <vulab@iscas.ac.cn>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write failure
In-Reply-To: <20261109132226.GL18859@horms.kernel.org> (Simon Horman's message
	of "Mon, 9 Nov 2026 13:22:26 +0000")
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
	<179405323723.994134.11947248661617076904@kernel.org>
	<20261109132226.GL18859@horms.kernel.org>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Mon, 9 Nov 2026 17:23:41 +0100
Message-ID: <87pkweynw2.fsf@pmachata.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bd8c1d-bebf-4ecb-8720-08df3e7de6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|7416014|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261021135927099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	a8lvcLRwW6B0BNxfLwIW1vXILiCJJ7trDVyhjFTnXMI+xd9NX/QizuPyfc4ViLo6j1ODDar4gYOHyHDhDi8WcCvxLsR7wVtkYVHTnIZyIxOmRKWyPQ7U2IijcyXDQIdQXm+LnThQ8QIQdw2oxmPF0bTA3nA7gPfhOrGzv7CPAMcxbsCJhskhSCG4UFbYb/nm9OfuS45f9OMm5qkO4clCZQiPON/w7JRQuVDlfO8xngq1m4eyODus7lFmqKfGxUnWuws6bQsgSX2txLIJ00PvIGDxE9SpxR0vg93p1ANSmhxmEamZmAyPDCqOx0qJsn3FXQNggJ8hnJiI+UG+DbL0grFfGH4rkUnHRBTBGgFD9xApSjOOGoQAwUddM7zjrZnZlceDOT6dFdn1nTomp6qOeZermkh9T+Uwl4pJYnm8SsQ+6SwAnzaPQg49xyK1CuBpqy2zTYXexU5x5iA1LTbP1zJT9/BEoOCJtRRsDst8xL67sJfvBrk7iaNLJFbr/p6JZ+g09cRy/4+kd7/tcC1wlo/I10+cmStheTLF1o7nePPs523jxJkb8LoMupYj+3QwLacn5QeXGIYHv5AoDPgOBXQQ6KGCjTLmPmEvluS7xSiun+zsczWadm+gzCj5bZWvTk0z30AnLZOBCR/rnMbRzOLBlcTErK5AShmR1CDtMiXYiRU6YqVyaEKXVzhIPhdkEO3W1IPucTbOwwoyzucIHA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021135927099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MMTe3/cyZZBIle7uO1+1r4l5xQScDpL2K8xynRHCOfie6w0PMpaQj8U4f7jDzz0j9LaT/HfrC0/K+8tnJE/7qAjx/AscqdpGkzLXt+VcgWvklL1SnQETYpVCRXGZwR3rrH6PlhyY95iz3V2/8p0Yo+rT2JXlTJGxeeeJatMnU4dey8VpMunM5PcsqSm8bTgUy0GQN8mURUqPWSX8Xa6nZJxsLo2SL2MLcqpe7Fmqbt2gEnJju081V9d6UxsOnB+pkqQ8vhm2gvL5ISDmunkm+PLeEXriz7Y8mtGePTm4DPcHaROYRm474wg6A69WVyhItFbwDdaGU6ikL9/CSUKNSxKBDlVUslr1GsVlYFNDdUccES72jBPWtrox7hWOdcGRv6LNK9R+CKo4jDbVwVAUFeuwrn4ty9zD3SJ3kqOXw6IvzgrVe1ktOhBs264BOuYM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:24:17.2228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bd8c1d-bebf-4ecb-8720-08df3e7de6c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336

Simon Horman <horms@kernel.org> writes:

> On Sat, Nov 07, 2026 at 12:07:17PM +0000, netdev-bot+sashiko@kernel.org w=
rote:
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>>=20
>> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>>=20
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwo=
rk
>> know by including "pw-bot: cr" as a separate line at the end of your rep=
ly
>> (one such reply per series is enough).
>>=20
>> - [High] The patch fixes the enable-path leak but adds the same leak on
>>   the port-removal path.
>
> I believe the issue flagged here is pre-existing. While it does affect th=
is
> patch, the patch is still an improvement in its own right. I would
> therefore ask for follow-up on the concurrency concern raised here, but I
> do not think it should block progress of this patch.
>
> And while the separate bot email, requesting information on how
> the problem was found, should be answered, overall this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

(Sorry I didn't respond earlier. I saw Krzysztof's emails and assumed
the thread would get bounced. This morning I saw it's still in NEW,
decided to take a closer look, but got sidetracked by some other work.)

I agree. mlxsw_sp_parsing_depth_dec() looks like it can't fail, but
that's not the case, it is fallible, it is just void, because it's
dtor-like.

I've been staring at this a bit and it probably can't stay like this,
mlxsw_sp_parsing_depth_dec() needs to propagate the failure for
reconfigure-like paths. It is IMHO legit to respond to a user request to
stop timestamping with "tried it, didn't work, sorry, we keep on
timestamping". It's only during port split where we have no other option
and if it fails, well that's too bad, stiff upper lip & carry on.

But the code just masks the existing failure with a void return type.
For port removal in particular that means that OK, you manage to disable
timstamping on that port, but if prior to that you failed to dec the
parsing depth, there's a leak anyway.

Contrary to that, devlink reload, which sashiko mentions too, is less of
an issue, because those paths go through mlxsw_sp_fini() and
mlxsw_sp1_init(). You get a warning splat on fini, but then init sets
the refcount to 0 and you start with a clean slate. The splat is not
nice, but there's no leak.

Anyway, I'll be reworking this a bit, but for now:

Reviewed-by: Petr Machata <petrm@nvidia.com>
