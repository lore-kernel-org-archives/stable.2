Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF878F3A;
	Mon, 21 Sep 2026 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959678; cv=fail; b=p3b1/c4sTZjPzechw2xw+lfc3cfxvrC0D13xVkHsr1jmSQ9WWJBzYs8YemnYF3fROML0RW4mylihvV1VA19Cw+V/OEkTk7yjofXZI/IXT3uY8a73+lOPA3f4rRj5L7WCy5aI8GPpWVvi2EIA6cCOEdfHlHeNU+ubYu5dA1kSWns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959678; c=relaxed/simple;
	bh=WtVV+IvVP7mYZY7LWSp++1YPFG0V46w+nV+uEXmO20Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EeNzhIbMyk8JD6WAtqG6sH0MVD8E733OF4XI6+2epyXbdsCxOyNkXadteSlcgtoN6psE74IpR4MZXRgUKENV3ZSksx1bjeepuUibk+wDFw5tiWz3CBly/x3IeG0/usWvvr6RqBKR+N9e/81WQbCzZMVfz2XP3KJvfh19PoZ8CaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lyeTD3md; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lyeTD3md"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROHeDxahoiFR2SQhP7saJZ09/FW7cUoJg7jT5OuWrVTUassGaNeACZFy4EvJXWm+OaOuUSBitnRJ+Pp6gDC+4YrDa5hUPMh/59uobk8lftJ2G9DIdwk+UTvkIp+DaB/zopqB1+d70BgPWIAhiee9QZCWWzZ2Q6K20qie8SNHpl3ZGtTo7KvDyKHBkSbukYcq8NS9wecWXOfCpltqpF3++SzCPwMUqmOPWbo+ZWIfqqvDCV+AH+ROU9DpUDtFakAXIQ0VDrUEbDkRooougv4LbvDbYTSvAt/e/Q9eqyACMPWlwRc2+bkFwN8HU4wL0qLPU/pqrdMXLzOBotHzb6VQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtVV+IvVP7mYZY7LWSp++1YPFG0V46w+nV+uEXmO20Y=;
 b=FiHC+VMKlN7hW/mIsGVXGE6YbtuPqK0hth9gYh8GzyU/ZB0Nq6wZT0VGz6KGSS0hDFSQCx984aIcqkqYTZV2RC0Lbw/ZtQ5XDzHDKCe4XGWxDyX1hnhsld7P2diuXwLoPtYlZuHZCGTgwqliW4IKd+bUnQGLQtVITc/TdvEtoQ2Wwec1QgSeZqiAg5e82ixxP+aNilOcxaE3i6xFYhSvsXNA/NvxEpaaUYxA89inDdTpJ8weURvQCj5WUSVG1VqEZ7VKxXRDgc3ZS8sU/mSBwelJ7QqijW1pvUew5iWbE/2FKvrsTUJy25rQGKSD1g51xOBtUai1mEqITq9QeSA+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtVV+IvVP7mYZY7LWSp++1YPFG0V46w+nV+uEXmO20Y=;
 b=lyeTD3mdeeT18HzK9gELEsLhegbjT551PSVpC75cDg36Wg42rVTaKzwdLJ8CEs5QxTXNEU/7IeFwXbYS/ZzTVuaB21LAh11gRyBgq3yjLCgRQqlCTbYlsWI+w1U4RmSRl0GHlPZ7SGl+pMYsGAhTjc92+1cAu7uXOIBekyzO69WwB7xHI5EOe4KLNk6Cw6x1UIHAcVl3FlNUJjKs9Ch2UXOEL8qoCzNqHJmQWgcrXM6BeeiQngDe4CsDnAwb30gd4bhdy6A1mqbjjeUAS1qq2iSBhTAb6FaLMEBZYcsQgEzS01c2Boa7XH3//UdMDP5G+19MySihce3qer1linlZ3g==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by VI0P189MB3236.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 03:01:13 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:01:13 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Yuqi Xu <xuyuqiabc@gmail.com>
CC: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
	<kuniyu@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Vega
	<vega@nebusec.ai>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ren Wei
	<enjou1224z@gmail.com>
Subject: RE: [PATCH net 2/2] tipc: make conn_idr teardown safe
Thread-Topic: [PATCH net 2/2] tipc: make conn_idr teardown safe
Thread-Index: AQHdR08frvGZ6K8NDE6OgUikFkhGnrbYWuqw
Date: Mon, 21 Sep 2026 03:01:13 +0000
Message-ID:
 <DU4P189MB37507552E268B353527B39D4C6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <cover.1789722780.git.xuyuqiabc@gmail.com>
 <909d83251b5e7d4b0cbe00e5e7246604ee03bb47.1789722780.git.xuyuqiabc@gmail.com>
In-Reply-To:
 <909d83251b5e7d4b0cbe00e5e7246604ee03bb47.1789722780.git.xuyuqiabc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|VI0P189MB3236:EE_
x-ms-office365-filtering-correlation-id: 2318ce47-d940-45f0-5faf-08df178c9897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 bY3aMIahCQWWNM/4TvIbCHwiDwGQfPSnnD0py5jDLDZAUQx99Y2CaOOjmvAKLhsE6trAGIABUatJZ6e+3abDPidZHHM60CU529zu0qDsOG0bbgmzcej+kFGxBo0xJ90+pfNT8qd3xabxzTqIqbCKH2YIM4CpG92HiplP55L3Gmn484ZhdSpjJNUjnwWPMHGWVf3UQtISP780V+A42RaLAE3LAoMAqK6x4Q9TCtt/43w3/3fPvU0Uv48FFk31ouZTBn9GHeo0vfHom7lIqOSov0bVd+lp63sQqj8aXx34oIvy5g/OQ5mQoDUPaMck85gJWTj9dQQedAsnqiPOd33GVVSHAfJcdxwxB990aT6zLrOHbUs7iNncid5ddYf+fr9oY4tvy0wrr+x2v0lGNgTXQWhgndIwYdLRkWnha54WkvAwwFniOACstv/wBdbvur/Ts8wqtsZ7Nt/5fHztNufYAMA5YE75kOBOOjXsFAj7mKkYqU4iA4A+djixxk2HclvfkOytTlHBsSgP5mFGCH4FHli5tUhfRennZoaAimndzIlgZNRiQutQS/1eGjFQJau3lYphVdAW746wEFyMX9KJmy0EU0h98v4e5tj0JSMwXqpRcVjZabYXHbqMpPsS2UingTD82QBBl8WkEfhhKApoC1LYHt1QwVIYNaBJgXc2CekovME0dBqiBoTO5sqAvEufmecbxiEQriS7p+b77kbAErVT/2yYlS1FwRXIboVYL+U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nie/vyXmQCAsnwsK2bLN1b9H1NYkQZQUUlHmjuTRswwy7dzm+Bom3k+CkzDZ?=
 =?us-ascii?Q?roog/wWZsuAB1cVrhX+nRLf7RvTeGCXOUW5EvAuxjBz4LFhjj2hSa77NI9xz?=
 =?us-ascii?Q?uU3gcA4G/W/3WRXSK4u+62a+3wOYCmoQFSsHQEAZuM91ICisRb9plVyUnHDu?=
 =?us-ascii?Q?/75//Y16WK//uXAt99Sekfrs3/9dRTCR1Olc+1pWdNxcKP0pqMdV3zoW0oGo?=
 =?us-ascii?Q?Klx2v0EDerWXcJetSj/MpuG9zDw3exzvW2QkRqafIBrxFbQjP5+zNdYFb2Tp?=
 =?us-ascii?Q?M1kJGmRPc8RVDtAYB4MOTfkBJomwDHoZOIm/bmvjqwGzlX18djDvlzQqSKtJ?=
 =?us-ascii?Q?pol/AzdMdo29CJvmfFHN5tQriCIpgx4OlLlqJahX5njFblbY8AOX6yFKwefz?=
 =?us-ascii?Q?6S+2PX21iPtPCo3lw2WpSs+hYOhtf1KQK8kh4FOqXq/O+ejVYTrETkcZeehe?=
 =?us-ascii?Q?Wp/iEL2peI9RYfGGya3G92nJ2ipLd7OVFXAxx7L++o+UlXH8/cKfdEBV5QxU?=
 =?us-ascii?Q?hJPFS9CfHQcqtpQSJ/vz//MwFhtJjOPV7d5HGnlJ/Os5u0+7qYaFtv5wu1/d?=
 =?us-ascii?Q?CQ89pCZs2rD488HqZn4UY615lkNWC9GjidbPkz30zb10r6t4xgmUHplJ8Dgx?=
 =?us-ascii?Q?Gt2JxB5/LEj/Diemn0Dp3U6ICen0LNKgkDZPzL4X2nobz+Rgs01Oz4sXl60l?=
 =?us-ascii?Q?BJ6mp+355omo6TdHDc16hNeeEYZQvQ38KiQ/qlpj3XMFlOZjkd6/nY4hReH+?=
 =?us-ascii?Q?CY4yxJ8ERW6elYs/HujDlatCJWGFWByfDejqyPCsNBcflofvRgOMM0DUtFkg?=
 =?us-ascii?Q?YNwbhhofa+c1CjF5IKPgd8AANGa4VEwn9WhTzK0xxwKrGPbHSpOagckeiVhI?=
 =?us-ascii?Q?CoWGb8mcFOIXVQjTXQxdH3OgQQRyedJNAl/MHrDg6yhPIQkNMS9ScLP2U9Sh?=
 =?us-ascii?Q?iqTiPMDG0WgpSro7KIRdN/8/0ewsXdsp+yjpH9xrKa273sZ91dvcg9v99glJ?=
 =?us-ascii?Q?2VxnR0k5t6sbTIWjEfXy1NefRvg1RSq9oJdCZjzzM8RNe67beg6RaDafSP7l?=
 =?us-ascii?Q?tnwd7y3hWKo0Sy4cKMz0wgVWEh7E61pmJFnNUGuHVpkQ4SrSMWW/bbWTBm13?=
 =?us-ascii?Q?c9Ug5aS9InmoO0xeaTOkuJ+cpfoVtMfxRl6Ai+4Nk69pOWcQHXeQ0K5vdbGg?=
 =?us-ascii?Q?vf/yUREGTDy3hnR1XGsb+SYQxJrcM1h5RdlUBvO5P39w+tUnIDCOGXTfPcVt?=
 =?us-ascii?Q?ifIz1dYtcUaHC08d5kE1kX6Z3hQRg1vStQSun4dxsvw9Vz7NOI7SHM/DtaSc?=
 =?us-ascii?Q?rkxsjDPCKZ9liuKncQGFpOOFwqLoN72xFlKZ4hpT2eBYns5xbXiDz7KFPsv1?=
 =?us-ascii?Q?pz2gnUx+eMUAWpYY92WYxorFwMw4cNE9ltV8eoejyKdNq6jnvFTtJYaO5n77?=
 =?us-ascii?Q?cXZQUcEr5gm73S/40PIvaG4ppKAsmJMbdEQyaxu3RrESThuA5Lw5yuKQS/+F?=
 =?us-ascii?Q?jZGFI0UHQEtwGfjZE93A45VOcyoDEXrNHe4EHxA28hp+1bT6e/LLM74G3vhA?=
 =?us-ascii?Q?BgKp2bN9p5Kdf0BI0AmOv/qdgQz12FH/dbiQOtn5vF3uVYNBTXdn/gPnUikM?=
 =?us-ascii?Q?4c4GQ7xLqJ4+2nMqoXCNQk+lIIs4mvNHSLMyWBHGfOP/xD4HREuvZPsNdi7K?=
 =?us-ascii?Q?bypW5Rx0xD9RrRLR9aqLE0W+dJ7OE23H5I5NtDlXvGxB3fONyIIRbtjz+fNi?=
 =?us-ascii?Q?R57s7pjqhw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2318ce47-d940-45f0-5faf-08df178c9897
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 03:01:13.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRhgJjVy0ZToXzgSKm0oiCJRyuAjnQ5C5cOVoRHxVg214edjJeJ64pmSoVH55nf0bv5Nq76wd5JpUxxJRX5uBkKbfWORslE1w2q8n6bW35E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3236

>Subject: [PATCH net 2/2] tipc: make conn_idr teardown safe
>
>The teardown walk iterated conn_idr by incrementing a numeric ID while
>holding idr_lock, so it could scan a large range of unused IDs without let=
ting a
>connection's final reference release make progress. An entry whose last
>reference had already been dropped could also be resurrected by the
>unconditional conn_get() while its release callback was blocked on the sam=
e
>lock.
>

It is not clear what kernel stack trace is observed when the issue hits aft=
er reading the cover letter.
Can you add the stack trace and command (./proc with concrete arguments) to=
 trigger this issue to the changelog ?

Note that I tried to run the reproducer (root mode) but the stack trace was=
 different from the one mentioned in the cover letter.
