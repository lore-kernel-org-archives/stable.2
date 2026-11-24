Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795532422;
	b=lq7T+1fyiLBm+NcI/pp4A4KD2lIz0fX2iDNA0H4FRogq6xZ13ytHOaFMdP+ShkjltkOt
	 lxUyTcypa+3WpenobQgLihm2EbiYUvFt5fRkhEM46e8CVlHtEtr9yAbxhzKc2Me6BWznI
	 fKKjgnmdmancReK836X4kLTt5fy+zH3MDmnXjLU1xg/I/8t9GIeuB3XXJDtqwJB3iMwez
	 D3YqiqcrXwqUshD13IkUrMtvfMl9iSoyh9ijaEU2hEhmH5gluyUb1CjMeIWgOamKYv7Dl
	 cBJhRPNjQK3CpnqZAIcnL9ScYLDYkVRml8efp5y/SM6lpd2hgByjV87+tvLKBJDtpCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532422;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wE9tjS4dH5x5GabIar9Fn+3sz6hdjUEVjoqr0IZSfmk=;
	b=CSo+0EGrYRv+oMEhDnVmaurUQG4Im+YXCUHRM46epFMselgjpTK81Y231qy5tJ/2TWF+
	 XbGh29RKoMnPTFz47AaPB+kp7DElyXdGStXLu5Ds3UOoya/dMmiSnRiUzPG4g3Z5wA9Rf
	 Z5lMeQtNLlU5Or5GUK4wHchXkMFR77Rh1qAHAajkOriIOz+lBTdllK93SB5VNsFT8f2M2
	 ji9n6wIQtCwRGnHgyDFvSqwCjztrONqjJKxP6//RgSO7U8oEaOe9IZtlCstwgNvapKS5x
	 W9eKltMPrh6ALg1lr3kaIlrnh1a4UffjeqS/0NATfJ2xVJTr+PZn9/l8YUrTZXXKuYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=Y1MpwNdt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5AB606A31E;
	Tue, 24 Nov 2026 15:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F5AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=Y1MpwNdt
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOEcwNR2160662;
	Tue, 24 Nov 2026 06:59:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=wE9tjS4dH
	5x5GabIar9Fn+3sz6hdjUEVjoqr0IZSfmk=; b=Y1MpwNdtnsGPo5K2t/S9FjY8P
	aG3ecQbJgfIf3mNiW0d1D1/1h7JZAY+lmjwYam/On6EPfLhUvU5uYh7WLbCRf5fu
	Nki3XNCkKaHOBSMZvxY09xhqTTV0qYBIKmgjAguFRvqz9zQWsdnxAtyOrHRT5j8z
	AV6m9WaKH2Myb4iTNN0Syj3lIeCSb8+KoW8yiw+c488IW+CJXCHDiwAydLHJUWwS
	O2UN5YUYno9HxJaqSfov9OFZYvhAqpzIWOkOqhhA5DB1arErBOMcsq7YAvrpHjpO
	FB9rNe4RoIEBxm/XwOapdQe8ob3YM4sDYCcLOSSlVp6YvloLFjgnlYNA7rakw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022135.outbound.protection.outlook.com [40.93.195.135])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j516wrytp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:59:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAjxYKalfb7t+UCxDs/ZeuIWXLcHDbFGlgvFXLZJyyneQgq7ylVp76pxiWKbmuJvoSX4XREkDVb4wFOn4i6ASjxgsXDP7In0Y57g9T1I1QmYg5mwOXobkXVC4cF7Xl/BE2GcBJQTxkZckoWPfHD3fqqrEkAzKTVWUQhvYxVE2kblz8h5cRtlP+W9IbhpEd0ktiP5NGFUGspVqWAYA0vovugHkj9Z39T31rS2z5LgMSHXIsykBU8uVvITMIlVxr54yEq5eZnaM6W8asSIaxz7HTfxeP34ayDh78BJsdt+hlQ16j2OZsgpGLq0Y/dCH1Ul2qisAiGY4toezHTVXsmsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE9tjS4dH5x5GabIar9Fn+3sz6hdjUEVjoqr0IZSfmk=;
 b=aBV7vZ7sKeh+h0EOUYAeY853hY19ZlyOtiHMrXuTBLz5YvyWMhmNq2g8p3wqfGYiIm5LXcEGQ9xILgXjqMHpuLMFju+rgY9/eXZFvHfAnabZ9gn/FGorbuq5G8PeDIo1AKH52iwF0fFF267FkRmKpFwoqnvh+UJgNq26XWUUhnNeqSwxsal+GIA+OkvsO9ECkZrB3DwJfx0tEFduAfBV6e5pz+IxGp6MUFY9ObABvWvhOUkwubPXzozUjTWB2kOfk8+69tkPRrSC91C3Rp+HT3azillhSGoDjcmapK9wwFj+gKysgmkpVLBxCypUTgwa2UMkxWY7oZtUYM/4uzJZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by IA1PR11MB6321.namprd11.prod.outlook.com (2603:10b6:208:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:57:53 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Tue, 24 Nov 2026
 14:57:53 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH] fpga: dfl: release irq triggers when a feature device is removed
Date: Tue, 24 Nov 2026 16:57:34 +0200
Message-ID: <20261124145734.38683-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|IA1PR11MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 477e0d39-ff9d-414e-ca1c-08df4a3b50e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|52116014|376014|18002099003|6133799003|261009223027099003|38350700014|10067099003|11063799006|56012099006|261028144727099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261022115727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	Z1hrsdjXeljFPFF4/cw2lXCCSbMjlyOuAK3NnoK8uNcOYpnITWjD29wrZC5Ko9+WiMr+V/cFdfHKpwdLgmiJYrUE/MEuHu1kRtCQ7V0igXOnccWq4fGD31YsVueF2iVWYy/PZUom/98zcCMLV5hue2SpddQKqyRN5+Piez0zmX+NxV37c0mb3WLXECxkPCj5ZbAfeyvEThj/v6XY9XQqxIiQ2L3H8kCnwbjToaAnoaukPL7lC8NXhyqbbCqhuqfb2oxEu/aApS9hkE2rSqN+cS141NOXQGHbAAMp2us1LBsEJvY2FNmQuW8yEtOocC48crb6bVTjHt2xZQYv/IBnM+wRHHpvE1eUKfW1bo7cAOjHYIIOXKdU/DjA4CEU/LwdIrglMFJrjxYaleN9+1Ki7g2VgGnSnm5AwQZAJ4lJm9xS4ddzQ+869lNhC5NZNwfVB3CahN9jOhntqrJFosZgI4b6jm4Uz2FoBzyO83hEs+PO8HjPkSz84JNKSJEcnQi25wbFCpAmUF07XHa2tP2gQ3/Q1KPI+p7DyXowk4yNz7Z0eCovmcEVUhftr3+yoYHT+0x/cTY0RfVRRo8fKVony1yqlVM0BxEgr1HhAkLHf7HV6oiKaADhLrEbRVzQPP2XkGQRvkz28goqmkTvXKQYy+v+7bEhIIddlU/XprNoLDZouJAtnomD63gegUAtOLVog32C4jqgsWjiPvIbTbgmYmI4uS5SmAJj1rJZWqWVd/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(18002099003)(6133799003)(261009223027099003)(38350700014)(10067099003)(11063799006)(56012099006)(261028144727099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3mfwaOa/NiZKUjuljZkmmX7gWtNdW7H6BCkwuNc+F8Qj3m23uPqwPLgJZ1Uc?=
 =?us-ascii?Q?IRhkjwD3SUzUwULo56ATHEJgETKIBnn8tPeVAUqDulH2RCF+Og9fdR82mYz7?=
 =?us-ascii?Q?NqNbz3O4G9wS1sJ5hcJdFdUsUX/K4SbDHmYy8E5CdtjEh4N2CAEYDWm5/eUA?=
 =?us-ascii?Q?pkbJ3YB1Id+OuCjPM5UsZA/PN/WNIm77egQb0LByOfFGaRTSbpER5FyH3GQy?=
 =?us-ascii?Q?kaZwNzJhkhkzNEbXYXhSGTytWmrW2wyhe+lY8KNQKd3Ekr4d90/dux0ENgMt?=
 =?us-ascii?Q?uCsga4KAB0fQUiRI0vuHJxN45gPM4MJJejCedw1wUZmcsnyXbtgL67T8Dgp4?=
 =?us-ascii?Q?MwzG13cFXAua46cVNYqGskMBN6/Tng9p+lPY3FPOOGm8r++VbHj+5jtV/z/R?=
 =?us-ascii?Q?xY1wA/XOyS0Xjcq5hMfi2lQy/D8o+A56Ktg6iykOhNEynrgOFXOYsr+zwXvJ?=
 =?us-ascii?Q?3QrL3jkQC0NI3XDaIMfjs3syDXVCUakP0G+gtFAYy0CElYSrnd2rK7ZFVbos?=
 =?us-ascii?Q?/fs6yECJ8glvMqVYipOQUz6DtiPzvvRYbnk44EnU13IIvWarccRtlDN/adDL?=
 =?us-ascii?Q?sSGb6BxJhbpbfdx1ybA8Trm+gBT5jYah1XRVwic4PfBten2oBnszHvF6gjO4?=
 =?us-ascii?Q?x3zSsJ8uPhTGk8i5dnZCTq8YCwEH7MudWcSV8DFzM0KiQ5MIxrhHvzqcngwK?=
 =?us-ascii?Q?kuGIbO/OgDmWJyBc76+Sjbw1gXLJYUkuYEPVweDCZolQDYbH/B6c02iElmX2?=
 =?us-ascii?Q?8nDhKx5f+YOtXXS6cjRAgLw64rl/E4Eu0HFBsSIuDgL64kyZR6PxLcr3Iz8B?=
 =?us-ascii?Q?H/MGPsG3R3BzUsneq+va925xraIfA3GXBHUt3G+tqEUu4aFsO3SmnWxgfWFo?=
 =?us-ascii?Q?i9lVZSfCkQuH+eJEMDNLYbJm8dSnbGRrD98JLdqJThSkpC4i4YZDnF32mxS5?=
 =?us-ascii?Q?4QhKQjaQkcRidzY8qGCa4/FY8X3yNhWKNQMYu3Xijt/YdRMJTBRQZjWB4BEH?=
 =?us-ascii?Q?EBK18WhdFj2KREpi9BCQugBSZwSlVOtprWF+uhUEMdOktEFVTwHSE8DHtZIH?=
 =?us-ascii?Q?gksLEVG9ORoPn21j2UACj8qGEfVH2rrRBCfK/jzC9xZlkfBG4MK0Q7YMZW3B?=
 =?us-ascii?Q?oatqythG22xbIgKdoK7HpDn210Pg+TWIfZhWWDhfq9MbyJKEt4TwjyE30iS8?=
 =?us-ascii?Q?wtb4iO9mZGIpe6mTrXhjRYzlGrJPt6DImBLaTBcmdftzaUAUUhk7Zm0tzQk7?=
 =?us-ascii?Q?vi4CQQV+6fkDmcC5TM//3qvaVJSfbxDqp/WjZyjAjaFkTmCxKDxUu9WfKfUY?=
 =?us-ascii?Q?fFt3VYXDGoOfipBwh4oUvyQzuDzLyL9hDGNXQ4D9w5MX3QbIBzBMnZ4xDhtz?=
 =?us-ascii?Q?KkiDuzv+lJ+KFH2Xz90Q5T3R2F6fKThaQmkOGzE1FaU0D7N1JrhrRepjBuMz?=
 =?us-ascii?Q?JgfmM5b8zbar7NnkNvYQQGd0Nc32p3flgQ9G8sUITw9UNfmvvYGfzsvn5D0g?=
 =?us-ascii?Q?uCsbfLhXzj+mCkZPc+btuautpWCFG9081lu/rzfdsXmqlecuwI9H/CLfZnrZ?=
 =?us-ascii?Q?Vk4iKDKiV55/FBc1ayS9o1gmbBVJ51iYaptzmPINzhR5P4xO72G9JM52uixx?=
 =?us-ascii?Q?OA2STsOvzYWseppF1Crpa4gz5cZ6J8PNodAd7scBWnMMTrTa9MdrsboZe5wt?=
 =?us-ascii?Q?d7CROlmsRoiN+Iew12DIPtx/i9E72bmanJRw+HtT9OmKtTnsJnxY44qABHaF?=
 =?us-ascii?Q?EBMBJFBubHw3uhzWm+jkYomRbHR06kQ=3D?=
X-Exchange-RoutingPolicyChecked:
	Z5vUIT5sSVATYXmAWZmHRf1/xGtfyo8c26nN3rIC+eTKEnPc7VggIbO919ThMPrmrbobpVZWbR4ErfhfXxz0lnm2oxW+dxv/q7Lst7xhC7XoIUhYtddejwDLKcDPgElcabzG54MbeFRILTOvWksHZHvEa2PotFnvSYs4xm+KbCrC8GZKIEUgLz/e4bAYRK15+rVf/t9ZFUbxB26OCJArw8ZBuIKIMztd+DPIM8y7DAY51ZjD1vJw9F8lJKdhcajOdbr7TufvwZNrZDHIqG0J648xY4RAJBNueyy1dlGcrulGasGVwNkTON1pSqdM10Q+0qA9xrrS7/Gu6n6dL/WniA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477e0d39-ff9d-414e-ca1c-08df4a3b50e4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:57:53.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnipItGNOuhHVT/9pzs4UauHHyVxv66LWvHBoTfTS7K52U91vttC+GfoUEuG1KVdKDDIwS43ewfXGUtzvy7J94Q5jQXsZglEDD/H5aRKMxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6321
X-Proofpoint-ORIG-GUID: xhjF42zbgvN3cpkSQqi9DqKc8drMaxtC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OCBTYWx0ZWRfX2WtlRYbU5B5I
 iLVOI7jUKaoqqL+Ge0PIcIDY0CrP9nh5zFuYWrSbMZca0NKelMbuYcPbJNa0QJiJWn3CeBGmSI0
 gYTKkD6kRGuBZdqhr8rHEfyt7nUUezWyTXj9FZg6YG8pkGj2zLwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OCBTYWx0ZWRfX51KV5hjJ3UVx
 Js3PrrFzTqKgoVd/RxI72Lxx/iDbqqw5sg1TuJ01cuzmjK2+ej7Tjw6eNCbuvE3vfUJbf25wJMa
 KggNODuKjjXJu0Q3vMVJA7ROOVZn8/Vdeg+lyHG5wfnl0LOale6105fbSxZb6xytVbAPHs/e7C7
 NL4uIH7G6Bz/Z2eBJwfEAN6h8e1q+/kzJf/l2ZL9uso7DuepPRHpP5Q47tKdFCjQZM6sH0OO+HM
 PFSWXL8QW+4ima1NTHaue7w6KiGck+9YnOb1IXtI0hAiHW/jcZHv8BvsHHFQKKzVRoCzXiY/el4
 I3UcMW/H8vl2rQjvaQ8f4wRcn1GX+WfBQea62hLtUQH0JS/4orpvZmjSrhDQpHdZ7kNml5EN6VQ
 6HBTJBf3r9U8P8t2n5iJ8WuMQJ3xZWG4m1VatCKrecfNkabN0Z9GroEBn6lHUexCwhfNhH9YNnG
 QXAFrrix29W1Zy/f05w==
X-Authority-Analysis: v=2.4 cv=bofZl0ai c=1 sm=1 tr=0 ts=6b05a66d cx=c_pps
 a=j8jEPmhjjLnYR6B6k97zMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=hhZ2xx0I_0QV31tAHi4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: xhjF42zbgvN3cpkSQqi9DqKc8drMaxtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240058

From: Ionut Nechita <ionut.nechita@windriver.com>

The eventfd triggers bound with the DFL_FPGA_*_SET_IRQ ioctls are only
released in the release() handler of the feature device file, when the
last user closes it. If the PCI device is removed while the file is
still open with a trigger bound, for example by an FPGA image reload
that removes and rescans the card, dfl-pci frees the MSI-X vectors
while the handler is still requested:

  remove_proc_entry: removing non-empty directory 'irq/62', leaking at least 'fpga-irq[0](dfl-fme.0-4)'
  WARNING: CPU: 24 PID: 19313 at fs/proc/generic.c:742 remove_proc_entry+0x199/0x1c0
  Call Trace:
   unregister_irq_proc
   free_desc
   irq_free_descs
   msi_domain_free_irqs_all_locked
   pci_free_irq_vectors
   pci_device_remove
   device_release_driver_internal
   pci_stop_bus_device
   pci_stop_and_remove_bus_device_locked
   remove_store

The irqaction, its name and the eventfd reference are leaked, and the
later release() calls free_irq() on an irq number that is no longer
allocated to this device.

Release all triggers in dfl_fpga_dev_feature_uinit(), which runs on the
remove path of both the FME and the port device before the parent
frees the irq vectors. Do it after the sub-feature ops have been
cleared, so that the ioctls no longer reach the sub-features. The
release() handler then finds no triggers left to free.

Fixes: 322b598be4d9 ("fpga: dfl: introduce interrupt trigger setting API")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
The warning above was hit on an Intel FPGA PAC N3000 when the card was
removed for an image reload while /dev/dfl-fme.0 was held open with the
FME error irq bound. The fix is build-tested (W=1) on next-20261123; it
has not been runtime-tested on hardware yet.

 drivers/fpga/dfl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 6f5fa7b2f..70abbdc7e 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -503,6 +503,16 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
 			feature->ops = NULL;
 		}
 	}
+
+	/*
+	 * The device file may still be open with eventfd triggers bound.
+	 * Release them now: the parent frees the irq vectors right after
+	 * this device is removed, and release() may run much later.
+	 */
+	mutex_lock(&fdata->lock);
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		dfl_fpga_set_irq_triggers(feature, 0, feature->nr_irqs, NULL);
+	mutex_unlock(&fdata->lock);
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit);
 
-- 
2.55.0

