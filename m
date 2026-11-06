Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.149.154
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793960366;
	b=vistlX85RE6ZU64YEZnQOXcEsVrYvfkARknpJgLgw6SXFr+U39M71lRZpgu85LTZ8ZBb
	 uw39HCu4qKkyGQPl9+PLnZ+bX45SRzdclns01QWpqIPlGqBc4O0Be7JSFkI8cx3wyG0iM
	 FryuQOS3Fg+lfoKeumLmIjRo0Ejy5KgKBCspyRH8OeQNdpiSsgsRt21av8uBN/Ed5Qlul
	 yHNWlr7Zl+aHB2m7AmiXfDj7MsBjVMoHBmxqKoMNADarWTag+ShXLIlFkMlFTwMuFbZi9
	 FNZIZo47nSjqehpNmDounD+3+/bqhmXpwRRUnlidf+URbIyPWeo9dmbeH9TZuyEp6TA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960366;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:Organization:
	 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=a9wcDuClyQNVsHx3hFl2CwG6lwUYg4ipULa5SUr5GxQ=;
	b=L16eENoOuBYP2IwefQI8kpbXnj8FZviklSLHE+E0uy8ZOqfg02CHPKWzSaT6kJ/BrLmm
	 MSn9/pvKE18NAKGEg03og0Plh3vENToDvQklG5x5BxgXWZgIYsDjnC8NPAWLrtlKF17UB
	 ivCcWOM04Y1Xv9sfpW2RHUGuQlv4emFufmDwS48OCLoF7SBn69u/ekKzkLCmtKIzVs6lb
	 7ULa9e9D+/0UGQ2BKUstzCjjSB2+2Ni0WoXCF5PT3MWkZlBA8Nt8dlMNNGYMEK5JKMt3a
	 D6mfSxFBr3JSeQfOYq1SlsQMqUCxe7o+yBqzZk5XfhG4Q4jtacNeD3AfQCjoojy1aEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=silabs.com;
	spf=pass smtp.mailfrom=silabs.com;
	dkim=pass header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=pps12202023 header.b=Nf0GaDFg;
	dkim=pass header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=selector1 header.b=Ne8WIJly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.149.154
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAF606A33C;
	Fri,  6 Nov 2026 10:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70FAF606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=pps12202023 header.b=Nf0GaDFg;
	dkim=pass (1024-bit key, unprotected) header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=selector1 header.b=Ne8WIJly
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67Qnvo2956111;
	Fri, 6 Nov 2026 04:19:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=a9wcDuClyQNVsHx3hFl2CwG6lwUYg4ipULa5SUr5GxQ=; b=Nf0GaDFgKt5c
	FwU8XK5WQZDIWn5uev7k5GobnAs1eGoSLWHPJK2Nq/zm5rVdoDnwPSdqAat8TA2k
	Tnp1bMe6B7kZHEohxlr60pWFwZCiUyWWgAbK3+w0Fb5TNgoyw05r+CnjnHgfoOud
	0xdMabClbU+9cKXoDvcVEofXDFQWaeC5KV+NhzTejVF7ElXwhksr9JuZfDPiGwM2
	KQBQHSATXkpdlejBFB7XUGYq6RlqtV2x/49sjcrOJjnWQc5q6XJbgKJGM+jUnQgm
	+Rl77ekj3HkhFKtpKUxmUcvIThrpOVE1h4AgQP1pdPh9huMb7MwyL0OwFWNflKpL
	JQ0DJfo6dQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11021082.outbound.protection.outlook.com [40.93.194.82])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4hs3q0h06d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 04:19:06 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpOwgNDPcLLPhp2rxxaxvFaNhX5tW2gBen+nWillTX+UHSCnW65vCJx80myxhukBtquLTNNe4LVAAn4gJH3GKWOMiZJrO5JA8t8bRtp8XAtq3ncgpIWF3UTvUo+KT1OSAZEBTWzOy8AOA8m5U/Nam95R3fjN0yaz9lBHrNYPgtzbWztuuTaN/6t8xF/AXlRIJOUGkwFpgaQM7ufia52yvZsOnNKXtfupjxOQPfbyxiD0BZ+v3+Om0nj33eQTU0c9eHds0OLPoIcAzKRuVhr4bHnqIpRu5/9KtiHvZu6IE2QY+zdWzrCapWTT2irHsnIAky9EUuAWaitBy1PHsPabxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9wcDuClyQNVsHx3hFl2CwG6lwUYg4ipULa5SUr5GxQ=;
 b=oehh3yal+7IwDUUOL5TZTqLG4VX07Ld2jS7cdZ9fvIQJWlARE3yjQH+lKuJ++mKv8Ssiy1RoMegQdnhha2vHJpA2rqNTH+npMwXTLM9Gzg1vxj5ryd8FdtOQYwpZI2OJxAgdTnBUyO+bpjID+fNt1EBFbdC1E3sMIdhft6hFw8kELgrc4L7lU4x9naZ9MGwoCXhVZLKzEZ9ytzH2IuK0gIIPU5RFkxUAEMHf+2WhBLT3atoh2aJPrFDUIWKDkxeRL5Ngw4hlWr9ny+joXL1XJGhWHNxFVOYSuRQmJBb7fc3+Hjkh9+Gty7MRs0jKzReBIaGaahgrSTXrN7VrHryDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9wcDuClyQNVsHx3hFl2CwG6lwUYg4ipULa5SUr5GxQ=;
 b=Ne8WIJlyVUuzC8J6vhf1wW/5GjOyx9x7EtDIEnLsN3OMs5k7wCiQUqi4TV5Aoa+kqlp+macXr8ZlLN7ujLe1oxIo87zd1j94S+oO7PPgK4HUTSMc2NErXERb9ZFKyVDKM7EKrMPu+tyMlNmB4oDq1GEHLXJnWtaiClKlMUSL7o8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DS4PR11MB256287.namprd11.prod.outlook.com (2603:10b6:8:50c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 10:19:05 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4%4]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:19:04 +0000
From: =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org, Tristan Madani <tristmd@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>,
        Aamir Ahmed <elb12345@hotmail.co.uk>
Subject:
 Re: [PATCH v2 wireless] wifi: wfx: validate num_tx_confs in rx_helper before
 use
Date: Fri, 06 Nov 2026 11:18:58 +0100
Message-ID: <8256818.tM3a2QDmDi@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20261104110408.986252-1-tristan@talencesecurity.com>
References: <20261104110408.986252-1-tristan@talencesecurity.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PA7P264CA0493.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::18) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DS4PR11MB256287:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dc9c0c-dccb-4e03-7808-08df3bef6215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|52116014|366016|18002099003|22082099003|10067099003|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	j2ebqGg2Og3kvGTv7SIkx5zkNGablnT2PYY2zFpBpc9vHzwh8LXdbyDy3vZq0OpwvNnrseDOQKjRJB3I2ni3KggVzFLgVcbWydfMOGvQZKdpjnyRzgthPqzoJWI2r378HfHp6u97vJfIcnf/Me4clkCD+1nZMJJ4yxMeWTU1mQdxEagd1wGk3pXXOm453f8vPrNahIrJTuUjCQFPcB1GOK8PsxlklIe1YzRLvg20d+yDd6uROiEflV6X0YPNpG1cU9tvkmvgT6st3VmUNIAhtnmHTNif9nwTnncAZOXlhPO1Llrl2BY6MYMn2GouMXlI8WC5PiwqXxoGDgIJvC6PkzD/A1PZH7+zePQOvlfRzEW2JR9HtkAssj8fUwalXYwlDt0dI/I2SdpFU6ygjGdz4Hx5NxnukpqxjOervabV/NRgrzshaHVXaW2l+fpmGG06XzrubmtuByJ3MNZ2ZjpJ+0pUUqWHbeBGUws1URc1qyF5CGhhV50mJIfvkprmRhqLV6BUo5dxAwnFlVPs6jAI1AgYcffwC09Wlh4Ls0ITY67AsUs++fXDOL+aQ2uIgEbTmrRSKrtR1neQ5ZE1e0GyHiNciHFkdZnv866Z6pUNE7EqEjMyAgkRZo5P/WccDNA+VLTKW/LiDKIT83DwKvvJ4N8SCGY+f66z8FqJpEu5mVhnkjLOzM0C9UqNEnNI6DvCagDrnwTm811DE4sVSubnijKpp2dKRSdsbNLyDKE9HUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(52116014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEZ1NVV0U0o4T1BHem12Vjk2Y2U3YWxNU1RDS0kvQktESFNuQTl3WFZVVDJR?=
 =?utf-8?B?a0hXYUhOcnQ1RVU2YXE1anlQWi84QU56dXYvYytZQVI4bC94Zy9hRUgzblR3?=
 =?utf-8?B?SHE3Zm9WaDhnclNsRlN5MHRISnlVenZnVFNyWUVrS25NZXY3cHZXcWNHTmt3?=
 =?utf-8?B?by9Ib25hS0gyVy94WWZSQ3pYbDhGVFIwa05vdnYrTEJWaHlaaHVqSlFsaEw5?=
 =?utf-8?B?aU9yUytTRC9MbFYrVUlxQjJDWTNteFZxUE51dWtUVG50UkRrZXF4OTVKTSsx?=
 =?utf-8?B?QU1USkxPenQ1Y1AyclRwcE1pMHF5dnZPNlFUbDNhVUh6L0ZIMXM5amF1QU9I?=
 =?utf-8?B?RXVVL3JvZWVHK3F4Um1XZjVJSjQyMnJWK3FGNkljVkZnbFZBTEdWT2huSjFF?=
 =?utf-8?B?aTN4WlAxOXhaSG9zaitZeEFaOWwvSnF2RkphN0oxdkc3cE5TcVdSSzlORDhT?=
 =?utf-8?B?VFBGNVh4K2ZLTlFJYUVFVU5NeFRKUGFmZmsxREZ4SC9zYTFzSTEvQ1BHcWMv?=
 =?utf-8?B?M05sSFRsM0pVWmpCbDhjdTVId2dLYVE0cXNuMUwxTFl4bFI4Y2pxRkFxbHpK?=
 =?utf-8?B?QzlTMndEQ1F5aG1IR3R2MjlCeXZxbXgzZkFHZSs5Q0NST3ovRTA2K3VwTFli?=
 =?utf-8?B?eUQrd21lNDVsNi9LbHY0cDYzYUJ4VXNiaTREOTVIVU5iM05hdFRGM2I0SDV5?=
 =?utf-8?B?TW9IRTViWndOMWxKckxCV2pNU3JhODJ5SDRGczZwZFc3R3RXR1F1UUEvZjJK?=
 =?utf-8?B?c0htTVQ4dDNSZWVsN2VaMlpPaXFLamJSaDc1dFpWR1NnNWFZNFVNRkxoek9o?=
 =?utf-8?B?RjdockxRejBScHFQZDhuazBxVUpFZFVjTzRmY2x1blNqR0pHcGtJcm1GVGJm?=
 =?utf-8?B?ZUxOK09mMFo0YmtpdWxFOGsyYkxseDhlUkhGWDVWMEZSdFdLRnF5ZnhwOXRQ?=
 =?utf-8?B?dStDTGV1VW1IZ2Q1b2VIR1N1QlRvNHA1dVdCcXdUNXJtdmNOOHhsc05hdDFj?=
 =?utf-8?B?TlFTcXdBZjhkRlR2a1JZWGxCMnlOU2FHMG5sc3FQV24zY1hjOEI2NXVyeTgw?=
 =?utf-8?B?b252RlpHajEzcGV1UGpOcHBqTDBZOUVpV3l1eTRhWVZGN3E4VElKWk9ob0E3?=
 =?utf-8?B?V2c4Y0VZbjBuZ3hWMUFMSGU5bWR6dHFXdDFTamkrTmN3VWJya1BtNzB5NlIv?=
 =?utf-8?B?VWQ1cUVHOGprbmp4RlhkWHBzY29IV1RwYWdiM21heGtsRTlwL0NxR1ByTG9D?=
 =?utf-8?B?aGdLd0NIM2JpTXV5R3hZWEE2Q1RUT25kbG5rUy9XTllEZU9ueGpTYmVZNFhx?=
 =?utf-8?B?RGVSWlBxNFJtVDRWazU3QWdpY0ttTXE0TzhmVWdUTHYwdFMvY0s4YjhyK3hr?=
 =?utf-8?B?T1h5UndaN1g3SEwrV3pvNjJWYUxFQnlSTktDbnpueG1lSzFwcUJGdmtZVGZC?=
 =?utf-8?B?Y1ZYYkVrNTkvQWVFR05Ld1d6dkRjUVhLbTVhOHdiNTlTZmZqcmlmNGx2OHZS?=
 =?utf-8?B?V29XYUo3ZlRJVlhrbmdhUVRQZWtpQ1lNWm4wdHcyZU10RmNISk14ekNCK293?=
 =?utf-8?B?R202bDhvbkFrL0FqTUh1cnZGMUlvMUZDOGx3MVRKcHNmUGMxMi9VMmFwMlR1?=
 =?utf-8?B?ZVVSMVJaYm0xZzNzdHVNV3lLUWJQZ1hZYkNFNWZEeDI2OGdydGFNTE9vZThu?=
 =?utf-8?B?L1pwMnY5OWJPdVlzSjhFOGRoQjJjenRIWXVwWjdDV3VTbzN4aFozbXNGVEhh?=
 =?utf-8?B?dnZHejlCS0pMQlh4cDFaK2lGUmRvRFROZzN5V0xSbXp0THdvK3Znem16ZWxH?=
 =?utf-8?B?VTE1UFliNnRpRnFITXVuRWhueko2alk3S0orajJIamxReUt3eTZNbWtwcmhl?=
 =?utf-8?B?aE4zc2Z6ODhXVjgwQ3lRc3N3Qkx2SEx6ZjdRQVFDTlZjckpESldneHJ3OVVD?=
 =?utf-8?B?RUJqWmZaTm1yWmNmYlZyaEg4YktXSElzVkorSW9rYld3eklHM3ZReWF6RUpz?=
 =?utf-8?B?VmdjWUlVZmFZeDQ5aDV1QkwrZHQ4TVhOVTlnRUZoelMrTEtQdUZJN24yNVZE?=
 =?utf-8?B?SGR2K2ZuOURxRnhPbnQzbUpsVVlkRUFLZlk0bFB2YXFaS3ZYMVRPdG9ldld2?=
 =?utf-8?B?SHozTlZGTnFtTzNIQXdWK1IyajgvQ0J6K0ZBYTh0MnhMVDJudW5welNJSmVE?=
 =?utf-8?B?dDdWUXhtbmUzeXRiaWdnTWJPNzdZeUhsYjdXY2IxTWFHbG5tVStmSERzc0Fm?=
 =?utf-8?B?Y1RDdVdoUmVrS011Y3pTUTFnajBQaWVQdjkrblRPK3grSFg4NE1UQnZ2OTh3?=
 =?utf-8?B?UzJ1bUxxT1RSbStwQ0RYTkFESUJmb3NXekE1NjloUnhrRVUzd3JGZz09?=
X-Exchange-RoutingPolicyChecked:
	uRpZp9s2cLc75vdM/wAQ6aDXtDFI+HNnIm9z85iQ2K6YwyJ8YteISkyRaGqhkKANw/NrHnWon/6ilwmxa6UeJK13WMW0+cXXae9whsZW6SWj08AUqOiEW5b/AdSt0DkF7n/mnaf8zBVRc5WcqLOAlQFhVxjpOr/woC+wXr3YEJt11ox+eMkZSOrX1YEZ8FS/LwoT2SkQU1Pn9O5BPPbt20VUNjUvWlqRXBZJyvgL7pmYA8iWzFAk8z7kTwdrPK5FyzXNOPxEVe6vYdaHhkcQUJurrfWfDA39IqT25q4s6oxnhBugYp9Tnbtk4AXhhtAZ3GJ2dCp8Zmt06AppL0E86g==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dc9c0c-dccb-4e03-7808-08df3bef6215
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:19:04.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlfOhqi1jk3tszSOQ4WSz0X6ELi70W59JGecpFt/76qe6Vi9Es3O4Us0i0S52LiJ6Sbms6SSTkW2PHrUnfIhEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB256287
X-Authority-Analysis: v=2.4 cv=FcOiV5+6 c=1 sm=1 tr=0 ts=6aeda99a cx=c_pps
 a=A+KY2CRJZE6laZNMCPYSqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=i1IsUcr2s-wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gIHJBl62Mt9vjvfn7G3b:22
 a=6KgOrB_2K63Cyhqxo4vW:22 a=VwQbUJbxAAAA:8 a=J_-Nd1mkAAAA:8
 a=iI4o8IiMrWo__zZFI4kA:9 a=QEXdDO2ut3YA:10 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-GUID: 4kWp0nKLiJSSTrj2n_VSqLzy-RctBgZm
X-Proofpoint-ORIG-GUID: 4kWp0nKLiJSSTrj2n_VSqLzy-RctBgZm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MCBTYWx0ZWRfX/hxxBCv5hFhz
 UiH/GkrvBkrC52/qqPXL57N3RfCR21BIF7vIHJe6rTS3Cgdl+Sw16BmzZAFduxOM3wep7kjLxVu
 jgxP+fm0M8BQLND4/vEEytg1KV6voRI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MCBTYWx0ZWRfX738e70Br8jtq
 S280yjQJXnqwKxqwCb7/n9JOZHm7M9U+ZgBmHoHPwrplM3KyN/SFk9sPMY5MWjXQYlp5F3Z8+T8
 zzKCIb9Y7tUwcObcoOtbwssJRbCgRZOkovk8xTNYymWpVfVqC4e0G6rEQOC+vcveuFdryONVxds
 2OiBNswIDMpZh4PM9t2cAEPGW2iklrWERzsYqbipA5F1GCUMgDGNIT/BhxyOezHVyC90+0bGSq0
 WvxJpAstF6fovYRiVWCz2maznTCCfZfxGV2/M1EMzMgYJpCVzBt6eFniaUwkkz0uk1sAMX7Vddd
 s44/0zkCtPaqtYSbbKg45oK2O0vxO1tVCPFTlNgRwJqX6nIC3C/Nntp6SDq5or52NIpTwh1ARao
 rIdKT9CXC3xbpzV+UHM8VU0WwQq3S8169F1MrKB2bDvU8Kl/NGG1zvCItyzwZ+DEZl6DahUkgKh
 8+rx2o2xfS7PBVoJhtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060040

On Wednesday 4 November 2026 12:04:08 Central European Standard Time Trista=
n Madani wrote:
> rx_helper() reads num_tx_confs from a firmware multi-transmit
> confirmation and uses it to update tx_buffers_used before the message
> is dispatched to wfx_hif_multi_tx_confirm(), which iterates over the
> tx_conf_payload flexible array.  Neither path checks that the message
> is large enough to hold the claimed number of entries.
>=20
> Add a struct_size() check in rx_helper() before num_tx_confs is first
> used, so that both the buffer accounting and the subsequent iteration
> operate on validated data.
>=20
> Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
> - Moved validation from wfx_hif_multi_tx_confirm() in hif_rx.c to
>   rx_helper() in bh.c, where num_tx_confs is first used for buffer
>   accounting, so the check fires before any side effects (J=C3=A9r=C3=B4m=
e Pouiller)
> - Used struct_size() for overflow-safe payload length computation
>=20
>  drivers/net/wireless/silabs/wfx/bh.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/=
silabs/wfx/bh.c
> index 0071659bc9c98..d4c904324edb7 100644
> --- a/drivers/net/wireless/silabs/wfx/bh.c
> +++ b/drivers/net/wireless/silabs/wfx/bh.c
> @@ -99,11 +99,23 @@ static int rx_helper(struct wfx_dev *wdev, size_t rea=
d_len, int *is_cnf)
>=20
>         if (!(hif->id & HIF_ID_IS_INDICATION)) {
>                 (*is_cnf)++;
> -               if (hif->id =3D=3D HIF_CNF_ID_MULTI_TRANSMIT)
> -                       release_count =3D
> -                               ((struct wfx_hif_cnf_multi_transmit *)hif=
->body)->num_tx_confs;
> -               else
> +               if (hif->id =3D=3D HIF_CNF_ID_MULTI_TRANSMIT) {
> +                       const struct wfx_hif_cnf_multi_transmit *body =3D
> +                               (const struct wfx_hif_cnf_multi_transmit =
*)hif->body;
> +                       size_t needed =3D struct_size(body, tx_conf_paylo=
ad,
> +                                                  body->num_tx_confs);
> +
> +                       if (le16_to_cpu(hif->len) < sizeof(*hif) + needed=
) {
> +                               dev_err(wdev->dev,
> +                                       "invalid num_tx_confs %d for msg =
len %d\n",
> +                                       body->num_tx_confs,
> +                                       le16_to_cpu(hif->len));
> +                               goto err;
> +                       }
> +                       release_count =3D body->num_tx_confs;
> +               } else {

[Cc: Aamir who sent a similar patch]

Until now, I have considered the device is not controlled by third-party
and the device won't try to trick the host. The few existing sanity
checks only notify the developer if the connection is garbage.

In all cases, the errors are not recoverable. A misalignement of the
host and the device state (ie. the release_count variable) will
lead to various lock-up. I believe it should not impact the rest
of the kernel, but a careful review would be required.

So, if I understand right the idea of this patch, if an attacker is
able to get control the device, he will be able to break the WiFi
connectivity, but he won't be able leak data of the kernel. That's
it?

In this case, two things need to be done:
  - Ensure that the various error paths you are creating won't lead to
    a general crash of the kernel. Otherwise, we only increase the
    complexity of our code, decrease the ability to find bug and we are
    still vulnerable.
  - This location is not sufficient to prevent the buffer overflows.
    We need to check the buffer size in many other places (see
    hif_handlers table). It won't make sense to fix this location and
    keep all the other ones open.

[...]

--=20
J=C3=A9r=C3=B4me Pouiller


