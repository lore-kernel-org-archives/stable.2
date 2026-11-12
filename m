Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794458264;
	b=cw+hrrx9KaJfe5dsnpsy+VZHxiw/0+DUmLEq9s0EPgdpoH0z+h2JPTT/Sz8AVsLnGZY3
	 3AVf9R+061EDsoM2aAkFsPUciOBZZQFulUds02wrz4Oi9hiAODFzQ1D715+Q4wMF+xghO
	 d2v5Mhj/Np687RsGhAOZ8fcbPmeDPLqcOg9CC8tsv1Ek0azKFVyx9Kbowf6n88k0K7RLj
	 3sfS9BWgzR8EcLNtKerDReD/GqcPFj87gtbbr2BxJkQNvQaEjWaXVWChXBhEQ85yLEszW
	 zigrBaSjBz2CY1xyAtTYLTRGpKz5T8bkxkzRHvbKHlCXVn3NaY2uSFf1OLOSIxX/QRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458264;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=ru0UVv3xr4gryqXsGdFkarR2n1+SP2x/tAOcKQIeiRE=;
	b=McVfDjuy3MvAvqJqZ9jBtAiBpeC1sYmDlJW1fgWTn4/YOSIQMpB6BLhIa9nKS/QNoTfc
	 vK5J/hmbSwMdT7QWsxeNsVSBObj6itHxKOmEsqOHi9WT28ZSlkhctz5zLS9Dgc6Tpz4Ty
	 MlB+SlJt2SEYlGIsoPQz2xgB/xKmzbTyvLr9rzppHHIhZWK515+KDWt/GuC6L04cIJ/aG
	 rz/vUtuYadX1lFU3vrVALGRKMfY8Ejk3yeTT1a6eAR6nMXhiD2P3gdnSNIylI/hNurIaz
	 zY3JZOQwYgFJo6Q9ZZuwwpe4bML3WWQlHIiDRMD9HBjo807RaXFcb2Aoq6VkgMg85LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=rMdZLHU8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.122
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022122.outbound.protection.outlook.com [52.101.66.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A110606A330;
	Thu, 12 Nov 2026 04:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A110606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=rMdZLHU8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWAqWjWcCW/2FsWGXVavlykZMWW7YEYM6qFNRiOcl5C6fwiW7rLBZs9dn16NrtkVJASQ028ZcTeUR+kKA4p0IAIFSstyGCpo9tE/pN34XRtsPqdnHll3R1vnviC9VyERYRfqX9N/qbNq0NDLDkbO7el2agR3wYO5OIlfd7tg6KKSWYpFiIvDp10sRS+D6if7YagkDjYYXCwpLkEXITlLqW3tT2BASG3d/g43b21JNdQE4LFLhJX2PqUNOIG1i1XrVnJAAufu9tsN8C9PtfdIXzWNUpcpu87sjGlKTN2CjKbTedclXMbOBXwNSH3Mnip70GFGeO+/pQxfq7QgaYJ6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru0UVv3xr4gryqXsGdFkarR2n1+SP2x/tAOcKQIeiRE=;
 b=LUIm1wtkY2R0EAPliG0hPqmfB3ri1+O8ZiwyMDS/V7iQFznnAljOhFecPpOiRHQ+8iwC4kXInE4toTJdjGcNN8WMNBdqT2PXBD/DbWFDu8ke9NPXLduZ2d7A8w9cM6uyXq7R5amj0ma2BKS9sC6uu2o1ReCcBIsVqkBKCW26RTxQDs8CZLF7SC7MB9YN0qp7+hCeL/BgRHqFk/dqF0SO2i+6vMpcxDOSssFGiq2jx1ZKenT1jnYPg01nqkgamNpy7PWu1NKcZtnl5r4e48Dqs7Lxh4Fxonx5flXwux+TWPyomMzXJ4ININ+4WRO1J+i0C2nIzhxzI7ZPuLjUQmTOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru0UVv3xr4gryqXsGdFkarR2n1+SP2x/tAOcKQIeiRE=;
 b=rMdZLHU8JOHm6p5vUvhqbT+js7PhedBEZSjp3vxPVFitUz8fVVXdhF+iHxvwd1XdjK8sNsOfaQ+pfu/8WCmRb4+Z+Cvf5HLJJsU0lubSgD7q4/5tan/KOabY7AaUV9tOK4xHwq4fjbbu9ZSZ6RNKH8Ld9Kyw+i8E1WtQ4hVeomLOZfzbVp4ZmKnfyxs+cwjP44/Q+cKUHbHGpsr7tp/NSP28mf4P+lhosVLZzkiNATy1lMHREgmdQeeCHgRKVrG8TIvOjGBVPAqfh0+ZI9z8EAhOVN6B0s1HKD0q78snsam/+tW3F0UZvKHxmmuBQjLB7QsexYRlzjLwKIvn3tpZPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by VI2PR06MB10826.eurprd06.prod.outlook.com (2603:10a6:800:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 04:37:35 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 04:37:35 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 12 Nov 2026 04:37:27 +0000
Subject: [PATCH v2 1/2] serial: core: do not hold the port mutex while
 waiting for references
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-serial-core-remove-deadlock-v2-1-d3ee4ccec37a@vaisala.com>
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
In-Reply-To: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794458254; l=2624;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=CDVl3aYvbTd++Zksyu3p9VN13IUQKKqMkyWMz5rDals=;
 b=LlsvK4GelVEJ9buWMfmQPks7Wl3HS+n1xmK6XzWtnJfjQ2Jtb1myMgGHCUH1vO6kkZfX8o2Kp
 Dz3olzq6ilYCD0azP0UPyFT8FS4kyLcusEF45COSGdIxtPgz/ML10ib
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::17) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|VI2PR06MB10826:EE_
X-MS-Office365-Filtering-Correlation-Id: bc34857b-9ee7-417b-e14a-08df4076ac6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|261026140227099003|38350700014|10067099003|261021123027099003|261021121427099003|56012099006|261009221227099003|11063799006|261009223027099003|261022075727099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zPcli3UKZsOyzFU8WZDzYgaXfDhIfA4wDNevss9dVP52drB8aa8waTri+tjAGRB/yJVfPHGF+hVJl7EJZKKKPSenLpoJA4nyNzdCJ9F183Gns1zU22lokXWNmDMVXYcML2FD5g2wBEcTo19zR4kvLtrU0CmEZUpSy+UuB4P3yTnEofGPEnuxHtuzenLjnoaZMC9yeng2QM5awyUUDq1Xo8ag9mMK7SASjkW0axqOdY6RBqprgToSX8WLQIFz2/D9ZY3gdnXQKqXqiuPX0DrquN6OJEof7qE1xVO3jPWEg/lVOZRB4Tfe+1lEfT2Iyfx+xxr9D24gobfDNE9olkBqL88Pgc+Q8ECJ0oQfMuYJ8HM8mf5mDYDYghpVjjvuSfsIJqG56YzXvrcy/AanIwtZVPxe5YD/1PZwSuLjXlDWOMr/205PHqDS5fPnyhB5n1y5rfXD5uQlILDce0sujcGwK6yKMPgq2+qTDX+Zm2ylYzhkfzfMYNIKvQw8i+66KzJWQQw8+Thm1i0TFEhgJbFcO8zNu8uoGx4NEtCOl+JAJWS8Mj7TEIqBr/NOA+5kBL609nyHCz4PqQBzU5Mg2fMuLVrgfrMDPyEdev6Aaaz7emipZurrjUip/g/KqI30tW7LPfgUn2PPWc2fUnk6Ai4v6z1wFfTnqtZLmwyJvMvOBejfEXAp44LVGycNxoh/OzwR4cotDKbK7OKrT5SbTdXXb+oldcwk3H8QgB0r4LnKJvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(38350700014)(10067099003)(261021123027099003)(261021121427099003)(56012099006)(261009221227099003)(11063799006)(261009223027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2JmNjNrRjV1RXRteW5hNDZHRjR0cG03T3J2ZXZMdW5PendyZXZIWTdyYTR5?=
 =?utf-8?B?S243MlRPZHZKb3JNcjE3Tkg1QmE1V3JiV0ZPYzU2bHk0WlZOUWFLVk0zZVB6?=
 =?utf-8?B?N0lWLzYzeGN3ZnhRdW9yTWJ3TlZGV0pnVHE3bGoxUHkwQjJXT3dtLzBYemEr?=
 =?utf-8?B?OVlhT2g0L3lqUU5Ia1pWN08wdHhsQkpubEVqdHVxU0RkVWJkVGRKQnM1cEpn?=
 =?utf-8?B?VmYxcFEwZzh2OFFwdVYyRGZmL0pNbHFYRW11Z2JZdTc0RDRteUdFQWMxL2xa?=
 =?utf-8?B?NnIzZ0pxY3RwUU1YcDlEcUZGU0lIMU5qZHFQZnMwQVJPaXJKcEdMeEFDajE4?=
 =?utf-8?B?elRnK2pFNmVwL01RSUxBa0g2NFR2b0ZsTnZpRDRkQmo0eU1sTU1SZjRYRFdk?=
 =?utf-8?B?eWZCOHErUDFNbzNjRFViQmVUemJyUVZwdU1ORFpObmtaYjBPZ0Z2RS9ZQTBq?=
 =?utf-8?B?N1JGMit4QWpjVktlOTNwRFdQNVg5aUwvaHhIUVBZS1phYzdGQUJiUXNKemZI?=
 =?utf-8?B?TSt0K2RJQXRqVkhkdWZObmJPejBEUGxoZXR5cXQyN29jeGdzbHZuQzIzSjBO?=
 =?utf-8?B?RWxXcm1KNkUyZnUrOHk0UWJHdjVMRHBIandhVGZQeEIvODZKU2hBdlpvRmtl?=
 =?utf-8?B?bm9TVVd2SnZmYlA2ak9iV2YwVDNXVEZUem1vN2ozMHpQNmdlL0owN0xOM2RG?=
 =?utf-8?B?cjBTbFgxQXgzTGVkZ05wdVYvQ2dZQk1wOFBQdDNmcFlQa1ZsMitJb0lBYnYz?=
 =?utf-8?B?ZDhzaEFRUkR3Y04zWEhtN3AweDR4b3g5QTI2QWdmSEtVUVV0WWh2ZTc5aVhI?=
 =?utf-8?B?WVF6ZzFMYVJzYW94a3ZMWGtGRUI1bGppbXhHM2xnekFnNDE3VlJUV1VHaWM1?=
 =?utf-8?B?TTl6bzd4NVZMOTVZUGF1QWIxMGp2amc4YUJsQ2gyQlBVNHpGdTVlVktYU2NN?=
 =?utf-8?B?R0pvaEpUMEhqbndZVHg3MG1HWFUzRXVGZHVzZDF2NTJEL0JtYWNZaFdQbFJy?=
 =?utf-8?B?bzNyTjdCaUR6K3VVbDRaTHFJWHl0MFRJUDhMSFlrd3pIQ1pIRUdYelVOU3lH?=
 =?utf-8?B?YkNtcWMvVWYyTEp0VGc1bDMvcnZ2b3l1RlZ2aFo4K2pLR1hvZnRjbEZlcStW?=
 =?utf-8?B?NVlnbE1HR0VGcTRiZFVXNkNRTDFHZlRTQ0w3djVmNEhzUGN0NzNSbmVpZFlQ?=
 =?utf-8?B?TmsrU2NEOTNpb3V5MGNqUHNvUkcyTFdwSWRic1hKckZaR1lzMHV5dzNaUjdV?=
 =?utf-8?B?MEVlcEFNMi9pOVhiNTA4RVRBZ2kxVURXckh1SHpuZHVScERUaW1HcmRIQlNz?=
 =?utf-8?B?c0RGdE9DeXFvRXE0SjQvMzNpSnF3RU1nZ2U0SGFnSWdPdG0rUmloQ3R4UjNJ?=
 =?utf-8?B?STBaditlM3V5bmVHOTYvSGMrQTM1bm9aaHBJZVZOeTRiclUyUUcycFIrM0hh?=
 =?utf-8?B?Mjczd3YyNi95bnYzWEJFUEZoZGJpWjJVbkxVeEg0cG83azU4V2dVRHhrWjlZ?=
 =?utf-8?B?Z2hOTndGbTJHU1k4QndZNjFGOUIxa2IyYWtDSUo1OURPTG4wczMxaktNMFhy?=
 =?utf-8?B?cWdpaDZFOUY1N05TVEdIMWczclJ3WEhHMU56bEJiZk1LRndsZ252M3dCSlJa?=
 =?utf-8?B?N3hUemJ5WEM2TDNBV2lLTmoxcFBKdjFaaXhOQkpvUWlMOFhVeXYzNjJmMGF3?=
 =?utf-8?B?U0VwbXRvckFxeHErMXU2VWdjWnVQRU9wMTF0blF3ZjVlVEc2NDhIYkhxeS9T?=
 =?utf-8?B?OEsvblBuWkxtZ1BPdk0rUnN1d1Y0YnJkRnF5K3RPMTdLYkR2SEdIQUxWVzVv?=
 =?utf-8?B?eVNWN1liZ1pTazNERFJBU0c1a0FRUVk2Z0IyTGJoYWY4S0svMXJrVS9nSm42?=
 =?utf-8?B?TjdPaGNDUCtDWVZSdzlUWWhlWERrY3lZb2JMUmx2TnJsVFUvcnpiTWRCYmdk?=
 =?utf-8?B?WmQ0TE9SS1RyQ0dpRlZsR2FUcHc1bWFXb013a2MzcjJoVzlNR0hrUkpGeWpR?=
 =?utf-8?B?V1hxbXg0ZTdqOWZVMVV3M2tEdHo3bHRYelhNVXl1bE1JU21IUjV6eFdXL2Fp?=
 =?utf-8?B?SEV5eGlGWXNpYXVsQXF2Z0paMW4zOEltL2lidWVyK0xMTGxlMnd6d25BRVRl?=
 =?utf-8?B?RVhnTk9xbXhBamFuVU1VSE1xWEFjc0gxSXluV2JuYWUxZURaVWFjQlh6UG4v?=
 =?utf-8?B?S3VuVFo0OGhMZW42M3hPelRLK3dTNUNIOWdobThaY08zblpNZllyTE92VHFW?=
 =?utf-8?B?azNjdG9CM3AvOXkvRDVCRjZwRWVGVFRBYmVJRFVGTWU5bnV0YUxmVUN0TWZB?=
 =?utf-8?B?VklnQW9PTkVTc2JvdHRiWXBmMkV5bVFWTXcvVnQ3K0JvZWtKS0FBcUg3Ny9z?=
 =?utf-8?Q?wOnZgmD9CmuFZcyk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc34857b-9ee7-417b-e14a-08df4076ac6d
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 04:37:35.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7RnCYzzZicUESYsfypvh9HLPV1F556rO//YnVTN+Iuyb9b/f1G2cvYSuU4AGdOetHJOS72s0JgMhFob2Xb8DwKzwxoYEyV80yV2k8NfTDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB10826

serial_core_remove_one_port() takes the port mutex and then waits for
the uart_port_ref() holders to drop their references. Since commit
8ca59f7baee7 ("serial: fix ioctl hangup race") uart_wait_until_sent()
takes the port mutex on every poll iteration to check for the hangup
before it touches the hardware, while holding its reference for the
whole wait. A tcdrain() in flight when the port is removed therefore
deadlocks: the removal holds the mutex and waits for the reference,
the drain holds the reference and waits for the mutex. Both tasks sit
uninterruptible, and the port is unusable until a reboot.

Reproduced by unbinding a UART driver while a process drains a few
kilobytes at 300 baud: the unbind blocks in wait_event() under the
mutex, the drain in mutex_lock(), and reading the driver's proc file
blocks on the same mutex.

Drop the mutex around the decrement and the wait. The decrement is an
atomic paired with uart_port_ref() and uart_port_deref(), which never
take the mutex; the clearing of the port pointer stays under it, where
uart_port_check() readers expect it. Between the hangup and this wait
the removal already runs without the mutex, so a mutex holder seeing
the released port is not a new state.
uart_wait_modem_status() takes a reference and then the mutex in the
same way, with a smaller window, and is covered by the same change.

Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Cc: <stable@vger.kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Tested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af41db10de15ccca4169c603d9cebf6..2e53d194ecfe853ade1ac6f33e047eb8ff11e283 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3266,10 +3266,17 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	uport->type = PORT_UNKNOWN;
 	uport->port_dev = NULL;
 
-	guard(mutex)(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
+
+	/*
+	 * A reference holder may need the port mutex to see the hangup
+	 * (uart_wait_until_sent() does), so wait for the references
+	 * without holding it.
+	 */
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
-	state->uart_port = NULL;
+
+	scoped_guard(mutex, &port->mutex)
+		state->uart_port = NULL;
 }
 
 static struct serial_ctrl_device *

-- 
2.47.3

