Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795547324;
	b=5PKTfc31pqpV5R8TnsQa1aJ1YhiCIJzkOBeCVUyRW4VfHIvr5Jhn0Bw0SM4tjdDT87CJ
	 7HgdN/sWAlkbcIbxmZGfiQi+IJO371XfEPZ2YtIop9VlsMk79+oJuyPgpI+VERXZ1AyEQ
	 zStVikK2ydVwSMh9YVIfnYLfGEKLS9Ed2WREt+xpT776xBJ9pW7f3Fl/CiScc/2SLQxpE
	 UGJUx1JhBhxtD88QZM53KFtNu+5xrTyde07gj/Uo5f7VU06BgQPpvLy7rRJD2kL8/hHNN
	 uLS5HWDTR4t9Yx+BuJm7e9/EMPHtRTlYCHoCa8afu+xd1hbN3aB8q6JBcthlDCP+vvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547324;
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
	bh=cyr3+lH3WeXCLkSU5JPTjhQVKbdeqzreB5XoHHgXGa4=;
	b=KLTh6kQT4owj0GVwHvBRB8fVu6q3/V12NynM10F52hqALS6V/pKQIqxjfFpDI7lyLA9V
	 1sPan4xGIc5+mQjir0U7jgr5kZH543RPMtPdNLiSjgAL1c8pRSk7XLsGuYkbY5/5KNZ/D
	 7djm5lwjhwPSlOtCSWdhWudcZ50WMPEEQjMnBVDwVNb35G7kY6Yf3BUjzass1ExLrK+UV
	 UNTwUHRWT6WHDWyCkNu8dwTGZp86AISp+BXeE8Zhc5wfbm8l7S0gqgMpZzykylFqSl0ed
	 g0YFo/CW1IK47UZ8/Tu9tiOxuTjPc557Cumqn7P2f86KkVCCfeSKs7vknOmnyDPsyfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EbJFQkID;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.21
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D7606A31E;
	Tue, 24 Nov 2026 19:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A04D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=EbJFQkID
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ramUIoswigTr27n/NkiO3peY8Ae0l/KOzEGtgcu35OaoDI+Vc33dbIwCmVMfD7z4rPa8G9mtd/U0E6olFbN+ZzUwPOezQ8bXs4yFiBuoa7MiWlHxUqo5lHFI9T7Sh1JQrIEsirgItGEsA8Q2ztKtAluU/+5yP8AuC07b6oCH3AnXqf6bTAWBC8lio3kGRR+/yGaGVbYGcWCcCb6D2cgDUpZeOvw8satAbaiPp33RLZKS5bXGVrYweo7Fan1tQAj33VEegzMrf+Xb5VU7REnGf9nmYH7JP8vrulOr1aYowEoeVri5tdMod78Y6BqEHTVrFAg7SawIFLq2+EO9v43GwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyr3+lH3WeXCLkSU5JPTjhQVKbdeqzreB5XoHHgXGa4=;
 b=T8Lws59RcggFbsxB++oF4ukNHAtRvKmkjV+KM5n4N7ba9l69SEixEYIQhQkljtEMyJEsWuH5JgQDjIkJWh6Uc2WZYOVdg+YbplTZ4ZArQzM7ILxCkjz3R3Uc7Uv57uPih3OZMFyPTFiYOMJwZG/l1BtlHRCSosyeinEFHXyVIQ+D3QmksSdWO1O7m2samTFip4TBN6IBeLYJzGxjLPXAAAFpBI6Q6aMlH1APmHMnx6zr/Wr3v1Ck2po/xD8i/8Jn5pRCTfHvivtBOgBwP2Ir8ucncW5T93oEuJMLz4+qOlbDSfvjEjugDRDatQfonL1ADnmqzERQNWfrxmHE+5lYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyr3+lH3WeXCLkSU5JPTjhQVKbdeqzreB5XoHHgXGa4=;
 b=EbJFQkIDqSaczQF8TiIkx0BHiiXfKFqweDAIVDpF4uWtai2NIC4i/nKStsbpDLUSIYcxc1Qj+8ceGXVzloly2E5oRHgl7XfhyfxmricK1O/0Ov3ZM9CSbP/0N2xHqTlfIz6hngfJjveH+UJi969GNCUOekRhZvShGju8Q8Hb0tb/lpYpx4KneB/uTKrQ2CqyXvXhEC2859ui7ziSpQxIPtFxdbYDOJE2WMXffDlPS4ycYPQwnwotH9M4QTzs5TC1diJDC2lhDmNnJGkRiyTqt4YYtTvVMWHfxVxV4kBDD6yApxkzL3Ou4o/HuUMslmA6I7lQuKktMuKyCHdxdpVbJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by IA6PR12MB438941.namprd12.prod.outlook.com
 (2603:10b6:208:601::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 19:08:17 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 19:08:17 +0000
Message-ID: <bee8302b-bd46-43b6-885d-09e9d89f9dd6@nvidia.com>
Date: Tue, 24 Nov 2026 20:08:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vdpa/mlx5: Increase the maximum virtqueue size
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
References: <20261123135646.3962652-2-dtatulea@nvidia.com>
 <20261123135646.3962652-4-dtatulea@nvidia.com>
 <CAJaqyWeKT3A2A5OHiB47j1P+e8BSoAbtJ9XaGLjU+kKOzOusMg@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAJaqyWeKT3A2A5OHiB47j1P+e8BSoAbtJ9XaGLjU+kKOzOusMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|IA6PR12MB438941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dff42ff-ff31-4eb6-9eba-08df4a5e4bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|261009223027099003|261021121427099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	fg9rcUAD7W2II83d/bfT/VJFstCcNbmqkxVwH61zooOUz33L1kychbxCsfLfdwmtJIs2onquGQZaDPtbK/CnGRZu54RWytfNJdJUNBqN2dljZF02Kdb562W6Sk1GfvugkDPFze7bymLzYeoweuzhT97bvZt8vngqiE9kkGAqFSaa27IkoTLf8IdaNKdRAFv49cTizXvUQJKfNZbu+cV3GnOpGLZYA3tgJ7bXsfoO0N25rU4Tp3XZ3YJ3w9bhLJOZn3fb3kxAwceFyJJesyY792UgZMpR+Tmm+wjhgZcM7gY6udwFc5AXTNPQ1qNbUGz6EC2F26DFhrl8gYEyD/a0XFBKsoItI7FLDqXZ+5dTXIgbpKL4b+yRZvXW7wHYUqG1D0reT7j5/j+1i7WTftzkGMUebVQ0RL+smDLa0e+YRbOAc6vFwzgoAIpQd5OvHHMiChrBiyiXBoQbUsC9nlHdNL0D6awWyuix72nwMRIpnMfT6h6ryi3x00n3lzb2DAH9usO3mRC+mhUL88UNN2Zl8VXeArJ9RPukT/TthaksF6nlYWXBZUIq6jiHbSNWfJM5Rnvt8nSU4xF/L5GN1gFK2MS03mfoPYCt6l6C/R7HH1ORGpYgATZAyrFVTYaMxAT9p2XH+6k8/6k8VbUBDmDxRgJe7lZvjOg+DgqyAYazdLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(261009223027099003)(261021121427099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXRKTzduYW9RNE0wQU5CeFVVYWZqYUVNV3BZYVB6Vnp5c1R0VXh5Q2J1RlVC?=
 =?utf-8?B?ZEpPZ2EyMUVPZXFpcy9oWGdDdjBIUVFlK0twWjNKQUdISzBmb3JPUlQyT0do?=
 =?utf-8?B?R25sejRtSy9xa2xFRjdZS2tpT2VmYS9LbGtyWDZFOWVSSEFGeDJRdnh5SmZH?=
 =?utf-8?B?NlM1TU1PajNQSzlGTnF6dTRnYTE3UW1lWWJsZjBmVFZwM1hjY1RxdGNwMVUx?=
 =?utf-8?B?cmZwdVlZOXloVVc0VGgrb29Nc21zcXdlQjlaYWxhcTZqSFBoUlFQYk1OZjQ1?=
 =?utf-8?B?ZHVyeWZKS3NWams4MWxyNlZWN016aFNjSzZudWNhbjVseWg1MG0yKzJvTzRs?=
 =?utf-8?B?UmJ5RGZUNG1SQm9KZTJpamJjM1UwZFRXZEo1OGQzOGVkaG9CNUlCcjlIM3hM?=
 =?utf-8?B?Tm9VUDcrRkhaYlFqSW1DT3I1YXBqeWFPbzhnOHppNVBKRDd2YytGSFNybXRy?=
 =?utf-8?B?WVRRa0FkNjNXclpZNzhxVlJlOGp0ZW90MmR6WUVYTS9aazB5ZDlrQ2VMRzd2?=
 =?utf-8?B?ajRYdEFzSmFNYjh0cWZ1MHVtSURKZmZEcXRkVWI3a0FIMHBTVXR0a05hK2F5?=
 =?utf-8?B?U2pCaVl1QkI0MUZobHBtTmRQSUsyVUNzSlhvOUtWM0F0MVkwK0tmaFl5eVAr?=
 =?utf-8?B?SlZYOSs2YXE2ai9YYkJNS2RpWE1XTEJDQnBRbUhnNEpSeE1JMnhnZjlzbGVi?=
 =?utf-8?B?NW4rczFhSDQ0WTRmYXQ1OHVob2s4YzZsdU90R2trN1V3TktHV0pJQTF3dmNy?=
 =?utf-8?B?WDBjcVFTUU5WckkzMWVjOXNtdDMwTmtMSlJZZHprWTdsaktJSE5xczBWZG9x?=
 =?utf-8?B?MllFa2E1MmdCR1lhR3FucG5hKzBvaDRYQ3NFL3ZOaVVpbjhQaGlEcjdLVmg4?=
 =?utf-8?B?b0tHYnluQUwzUm81TVFrNWZ1QUxMclA1WUExWXdkSFFpY0RJak5ZUG9aYXJW?=
 =?utf-8?B?V2xYU1BNdUtQbWhpek14TVRqd3RsM3NrNlJ5Wk1hdFMxeWJ3Tjl5dTRWK3NN?=
 =?utf-8?B?aE1sOXZNMGZRbndJWVgrSlIrNlBMNDY5V3RDeWpJQnlUVGs1YThnNTdPQlhC?=
 =?utf-8?B?dTllZ0FoMVdRcXNiZEpmdlUvSmtVc2NWb2VIN05PSDJNNDRxbjRCTkVMS25x?=
 =?utf-8?B?blFwaXh6VCtqaHNqRDJZVlc1VlE1R29vc3psK3MrRVlxbUgvWS9adklEd29j?=
 =?utf-8?B?TlBWdEd3cWdqTUZiaEhzK1ZLaGVVaCtLeFBKRWdOWWVYNklFL3BRWm0wL1ZI?=
 =?utf-8?B?Z2VoN0pnTi9TVnEzR3BRVCt6N2tFeThPdmxLOGQyTGl5Ty9EQ2hRM1U3S2p6?=
 =?utf-8?B?dVlnanN1TGFtSUEyVktyd3U2Sm1XQ0tBdmZPVTVoRVFLaW5Jenk1TXoxbkJI?=
 =?utf-8?B?MEZUVzZPRm1uZ3ZNOVg4SG51NDFoZ0t5bFhXdzBJbElSZkNDL3dYSWhHMjAy?=
 =?utf-8?B?RHRKdjBqWUJwMFdlNG55azVyeExKKzBPTDQ1RnFaVGZqV2R3MGF4QW1hbHlE?=
 =?utf-8?B?dzFLa3lHV1BBTlM1SzhFZzcyL3RCRlRNUzhoSWs5NGxyTlpTKzNGNVhOQmpj?=
 =?utf-8?B?V1BzS3VtOWlDMmEzNXdMNEpNZjc0TnJOcUJHYWgvZm81b2FsL2VqVWJrTmxR?=
 =?utf-8?B?NGE5RW40bXVMaWVRVVNMNjQ2alZPM2Q2THF6M2l0QUpWQitwSnB2VnQ0c2hG?=
 =?utf-8?B?Wm10V2FpRWxDZlBaUVdHUEJPOHYrRjlyQUVYMCtEZ1I5WGJkbmZLMkhTUFlR?=
 =?utf-8?B?cVQ2N0haOGNYQU5hT1dCZHIrTjhBV3JLNWJlTjdDcjNMZDZsK3FEWnhVQnE5?=
 =?utf-8?B?L29vWS9FcWpBblpRcURmR2NqZ0t1d29zdVlFOUdOTlI2dURESXFiMVkwN2pP?=
 =?utf-8?B?NXR5dWtDaFpwNW5QYmNrMGF6T0hnSWRneFl2cXlrQnJmL20vUUl2RXphYTBH?=
 =?utf-8?B?MWsyOVprS2xZNHZUdlNWeCtvN3RMSzc4ZHRHM3NIK1I2OERlWm9malJKald1?=
 =?utf-8?B?Z25ndWlRQXRtdmsxWGNJcy83a1dMWGtMQ09qaHpDQTJkVUpLSFhqb0tuVHpY?=
 =?utf-8?B?MUhRTm9XRHdDSkMyWGJoYzVXY3RmWVFqelJkMlJ4NkpMM0ZEZjRCcEJsOWVn?=
 =?utf-8?B?b21Kb0ducy9XZmNud29kQ1pKSFVjb243RDF6bUcxcSt0eDVRby9ET2JMZVFh?=
 =?utf-8?B?UjNSdlJKQTZpMjdwTTFWellWVFhRT1hYSnNvSUdFNXpScjl0S0tCSVB3YVVx?=
 =?utf-8?B?QmNXNmtlV3FIdlpGVTFMSk5JU1RxKzIzZHI0aWxGUUNxcDhnaXB0Y0k5alhv?=
 =?utf-8?B?ZCtoeGZtYythMmJYMnF4ajNMbXlEbDNWeTZJRm9RMFJLUTlpL2E0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dff42ff-ff31-4eb6-9eba-08df4a5e4bd6
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:08:17.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j294nw4lKGSd66rvnyL65L4/iCJVP0xr+XJWjn2OuValsAK39BS4GD7ClMIqqz53d8ea8PrfmMje8C8dCH7KlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB438941

On 23.11.26 16:38, Eugenio Perez Martin wrote:
> On Mon, Nov 23, 2026 at 2:59 PM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>> mlx5_vdpa has always advertised a maximum virtqueue size of 256 through
>> .get_vq_num_max(), while accepting any queue size in .set_vq_num(). The
>> hardware handles larger rings just fine and users have been running with
>> 1024-entry queues (e.g. QEMU's virtio-net rx_queue_size/tx_queue_size)
>> since the driver was introduced.
>>
>> The commit in the fixes tag vhost-vdpa enforces the advertised maximum
>> on VHOST_SET_VRING_NUM, so configuring a 1024-entry queue fails with
>> -EINVAL.
>>
>> Advertise 1024 which is the max that qemu uses today. The device itself
>> supports more but doesn't advertise it in any way.
>>
>> The Fixes tag points at the vhost-vdpa commit rather than at the driver
>> because that is where the mismatch became user visible. It also keeps
>> this change out of trees without the vhost enforcement, where virtio-vdpa
>> would otherwise start creating 1024-entry rings instead of 256.
>>
>> Fixes: ccb1dc7c527f ("vhost/vdpa: reject VRING_NUM larger than device max")
> 
> Is it worth backporting this change? Nothing should break (or be
> broken because of the 256 vq size), it sounds like an improvement to
> me.
> 
I considered it relevant for backporting because configuring VQs with 1K ring
size was not working.
> Either way,
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
Thanks for the Ack.

Thanks,
Dragos
