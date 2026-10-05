Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30319CC0F;
	Mon,  5 Oct 2026 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791173325; cv=fail; b=U75uQIe/eQzGHq39ETnDIrrPXrWAecdncWF0bSIpv7y8BzDR4pITKHVXs55C5MUPsCxl3KyJwdSjPWLBQR2zKxmBjnEv8gmOUJ7cOzyWuCFMVxnAT12IA77Xm/xuLwltf767QQPS2ki3ft3PwOYZzzTV9WLsh6VwCjjyqQXBVy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791173325; c=relaxed/simple;
	bh=XMfOaDqvb5wgA+sUlEotAZrHorw2hVH18tE31OV8fFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAMF7AdAzb3JFSSHmffv/okuHdv3hvjzn0McnhdH0D7I28nvXsz8atfBewSmSTGGwTMT4laXolPCfPZY9eFCyxumiGAz7lEv9PhhdD2WcEHBOAzw2DGhdykYgggun3nZ6YLim0HH5ulgfbzbJrgETUm7cFWttpEx2wQsgrxAAhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=vkDVEXKw; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="vkDVEXKw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUSu/rTEel6rC5oVfNcwrK+kDCGKzzXx7FRcH7f9XPxDcZabwTUMIrp/0rlcu7IjTzQM6T7a2ANX6YU6RefapYEfAqSXgTU15rMgrypuAVhBNy5WzpNBI+FnMA+NShiJu9elkPZ9sszIFcawo23M9QBZSfbMnUD4Q+77tngwENB1eQm/h5Vjaq8UtqLGmWhFLPZlrj4ZNj9uwrS4GZO47LGYH22+aYuLhnXWhXf7jT7urbD4MYkCharxiNoGFhV95B07Yei5p8eTg2v4skrtly53Gkbj4S+Ib+GkuvwYLxTTBWAgMCZeUs7fKdNLjFhY6oSs5s1Y5+KaN8opdh917Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMfOaDqvb5wgA+sUlEotAZrHorw2hVH18tE31OV8fFA=;
 b=IM4eRf+U74PtQR+2wKA+2fOPxn1dhx5DjxZ/gYbtrJN+vh7iXJ3Ld3sWaAa/6/XS5LyplRUDE+7lGQYLX0U0bWeByFpBjzpBbHORijJfZ5UelB+sB7h2+aB5+kBgdXj/prBlIAfWIXfXkx2AvwvgyWRclPQu+7wa0Lg8FmughDYbWrowmFEULBGZlhwUIUUhWvAbewOsOsj9ukbVUxtEdbl3DacCpl4kFtUVNXhGSYtVNHZ+711hVbog/SWMC5gZNqBOykgiYIoQDBOoQlv+mMsht1pptwpBNnQUWr0is1LBAz2nnHmpQ04WwvkgGrri/N7vyKK/8pK8UV8OvqN8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMfOaDqvb5wgA+sUlEotAZrHorw2hVH18tE31OV8fFA=;
 b=vkDVEXKwGmnZHNB59Ai3/w37SjEl5nDBPyHQKgdGO9/pAAf5Yf2sSl4OtsiuuQyItJCR/GVz565NdA96FIw0ClFsSlX0M2Ybsc4xew3Iq+/B5OdbkwoeLxXOfwMurrNXlmBBPp4mDqzdeTO7xHHiC1H6Nxiv9GMhpfRUJ8Kw+7mtV5VgHMHRz7giRQB16NVaOzWt5rpfVlRCGGmn85TFJYIpPjowbhLEiuoCeJvYUdzdsibvtVgbHLqwH+ol+LhhQhK66fFjXNLQasGwTNlK8pp52jfc0J3mEC5SupDlCXQVW1LOZLn+vf94ehLJynuUZZ3ueyUE38JzjlnxOiVlVA==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by PR3P189MB1147.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:08:40 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:08:39 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net v2 1/2] tipc: unlink publications without a node
 lookup
Thread-Topic: [PATCH net v2 1/2] tipc: unlink publications without a node
 lookup
Thread-Index: AQHdUdLWX9fFSNV1L0mxV6xESAfgarbuWfHg
Date: Mon, 5 Oct 2026 04:08:39 +0000
Message-ID:
 <DU4P189MB375033B6F5978460BB988D89C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-2-nicoyip.dev@gmail.com>
In-Reply-To: <20261001182924.3928331-2-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|PR3P189MB1147:EE_
x-ms-office365-filtering-correlation-id: edac876b-ac59-4121-927d-08df2296564a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|7416014|23010399003|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 nALOt9LjFOtTzJ3BffkEO3z3h9h1cjr0Y6fYzKJFt2rBPyxGvD3bPwoOyhphtE6Qi6UAyqNj83kWmfbnENL7zNTqkrDy+wnvZo5KqNunjUBxVFHo1iEnTljktvnF5asjPvf07IAgntQrg1vmBLYqsLrRTKU/so44PtTkze0ZjpjfJkJnkYOL0MPkaN47N+B69QS4VPs7+GZLaqVWboVfe84SCLdPeWlIF529AdqUYT4khzgRnSZ+8mMvmIn5pKRtPrQSYkb8kfourpNgg1+Yc4VD67E+eBB23jDq4DN0I3A+NYRyZhkOh/y2AeP7IeoNkmjwqdg6uCityZ7No65yiBM7kb9lQNptc82NAgrRqkNsilIngAcNOGO0Lqoz8ETN22VWuY4wGHdKLtzGDjxAzg7Xzaz7tXZErCouSdlC4pBnwkrGpNEv3wLGbSAFHBSl6Z5JYCbCIpqK4KbllYyVvdHK1NyIU8dC6og5ZspCC91pz/1yjTwXFOdk/SIPzpPGHXO3EzYC9U/PF8RU0UMVT6wSkA9Y3mTgA85VCnt/ivAxoPKbRBeTSx8j1khLBDcOEnV5//R+IMXv6CkKII+DkREbviypMRb7FIc5fCmiJz0hbyK0H4bVls17e7ppKznD0SCwK+8PMmPBoka/s6+0+Flcv+HYXOJ30ViukH0JIn7kpImvmg8kZzSgTlLuNdGTPd49uXohkTVo80/143Z1RbC2Cph5eEikcrx/Caxzj4s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(7416014)(23010399003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rN4h29kPVcYPq8ApeBaJeWwpD0fZm2qKZVq7eT/riO4+IoXW+TUatBg6TL9Q?=
 =?us-ascii?Q?3FBJfUrRIll5CpQNF79U5I+990Jn8ZxqF0UY1VQckN+LsG2CSNGWTIrpKao+?=
 =?us-ascii?Q?haxEYxSc9V94HBXys4K9JRvJEFteVZ7bTf1ENDMIMjIOrh0OcjM6Y/M2VnDc?=
 =?us-ascii?Q?QTELthT4//BIJdV5ss0/kbR3McZusdT3ZW78RDdAwUf9e0BWJxfGCPSwPCxZ?=
 =?us-ascii?Q?ZilJ/4K5RBJzuSOYDm4DMbZOJg2EyT33cn7N/e6nMTpYajZb9ZhR3hnkhxO9?=
 =?us-ascii?Q?ELTOEFgbxl9nYrdI2laERB6NFFCTzgVldsnnyQEEpopgO+tl0j4MFAf+qMTg?=
 =?us-ascii?Q?L10qgmZZ8R/F9faSfILRCH0PatdhPT0kMkOeyrhmKVsk2ohrAtNKkUrVHR5P?=
 =?us-ascii?Q?LRheny3tkRzykcrh0HXikGG/bjV1quOkV/resrXCu2q+aTkLhPHGZcP3UrR8?=
 =?us-ascii?Q?WfypAQuYJMGJiXmQgZsrDB83UytYENODR8zYxXwLFq17pdtlO8BVRCQlQxBS?=
 =?us-ascii?Q?1Dnl/+f2ht0z/4bHwPo6K0VRD4hJ3Cbq/OHlanCdrIBzeio8bGSWHufSfzob?=
 =?us-ascii?Q?HwccEkeOm+u7UxSIhbrTrYRIrIVcH541KQ2PhNo3rO6AQ1jQAm0rhDDL5azC?=
 =?us-ascii?Q?3bjV94cjXzJkZDSgMAX0Bnb3llKc1AsYDMIjbqg7SP5++I+BFow7EDME4PNC?=
 =?us-ascii?Q?id2wb5F/I1qb38BdT0UEvuytd4BkxTsns0GWlspyZerTfwS27WMgEKjua0lw?=
 =?us-ascii?Q?l/72lMNM5wCxmim4CdA05R9+kUZ38Nmw1DxYJQp1aR7JjnH/hP6vxl2r/Iou?=
 =?us-ascii?Q?Ao+Ugw/7B0UcQcf7QrapTbnbzojxwJsnvvMFY1/kyq+XZbhyOGKS8JD7neZv?=
 =?us-ascii?Q?owrw21lJd9A2LB5rpqj9fcV5ibiy9ODOV6aKBrhnbOLtTp1ES+St466nQU1v?=
 =?us-ascii?Q?Pc/JuRLUovtbyBoGYhxT1C2DFvxuQqpnEFI0faMhQvBQjk0oJD9Kfa6Oeubi?=
 =?us-ascii?Q?oPLPZvsqx2EQRIlqg6lxqvO8Y9mLm1bKI2aBCBHuuRzEHi1WIrhE7hV0xPPc?=
 =?us-ascii?Q?wtcnpERNxjPrHO0HhmN2weyRuma6oiCiZp5VRDLxIT9l0MuTqhBBLADcQUSh?=
 =?us-ascii?Q?+6IRpiRM1bZV5d5TJvoOEhm/B9+cmNaYnXb8TnUx7UbAfKWcctyiQ3c/sWS4?=
 =?us-ascii?Q?vbQqZysnDeQUvEK/YA2Hml20kSfgFeVnqFE41MDwdDomxZZCmzwg4z9YPJq+?=
 =?us-ascii?Q?upyWou6/i6FkjsSUoG5ha00Al26W2jnoxkO0hKvjjsv2v9rn4WsqAkEigxAs?=
 =?us-ascii?Q?0WFnsguVMbzQGB4GjzuUaaw949nnOmbtSoIuPz0X00Smd6ypsrDyEsmXpdAq?=
 =?us-ascii?Q?r5YFC/ybel9+yZPBB/LvH71gXJbXynk6xlTvmVpXhwCkCeZ/JOn7WFo5jq69?=
 =?us-ascii?Q?krROS6gfegYGW1PrMORdtxsXvIrcw336jwiAgnBSlfrbCNADovS1yAS/SNqd?=
 =?us-ascii?Q?4GXUhtwAduAOV9VvCMwU+JGvWZnR4yTWvfcfrMfXQeoRVjwi4273zi/9Cqy0?=
 =?us-ascii?Q?STcvQKp4AsDUSIy37gjCTpSAv1P+hB2kpaITYhxtgk1pWoCbdxp0ihE1TL9m?=
 =?us-ascii?Q?T1Jp8cByPs9rwCXb3GnL5YEnXXi5rVOkNST09xJkQicnx7bLbZoQ/pZmsFI7?=
 =?us-ascii?Q?dNvnat9eYPDYctd64s4+rccDyc/s7UYczhRxchCYfPqNFLJdauIJ1eWY+cxR?=
 =?us-ascii?Q?8Bb5XXCYwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: edac876b-ac59-4121-927d-08df2296564a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 04:08:39.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBD+BVzsYLCEmnQpTaUX3lfdK7eq4IzmZKvTnZwgxaUSn9AS6Xslf3SdBOK1oidUCX27m03oMTDiFY854RzHpuMc4OQdXxx5ONBHge1dkRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB1147

>Subject: [PATCH net v2 1/2] tipc: unlink publications without a node looku=
p
>
>The two remote-publication removal paths remove a publication from the
>name table and call tipc_node_unsubscribe() before scheduling it for freei=
ng.
>
>tipc_node_unsubscribe() looks up the publishing node by address and return=
s
>without unlinking when the node has already disappeared from the hash. The
>publication is then freed while its binding_node remains linked, so a late=
r
>publication-list traversal can access freed memory.
>
>Both paths already run under nametbl_lock. Unlink binding_node directly
>under that lock instead of performing another node lookup. For a valid rem=
ote
>publication, binding_node is either on the node publication list or is ini=
tialized
>as an empty list when subscription failed. Remove the now-unused helper an=
d
>address arguments.
>

This does not fix the root cause of this issue: Not holding proper lock in =
tipc_node_write_unlock().
I will post fix for this issue. Thanks for your report.
