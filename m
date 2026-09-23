Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAD35E549;
	Wed, 23 Sep 2026 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132477; cv=fail; b=gxNUjtzB8IL+ZJfHoXKHR6eyS4TRI+DRgxMbeivuqwfAecv1oH7Fj9ppCqWjOMxrvZxwYjk5XMYndEGX0PSSNVOapkFM6ulae8pX6M4fNpj8FNU/ksEx4q1GTdZANtoiS8tS5oVwFHUxy8nW0W9hESBHk0JrWnPz1Y1ABjmYkEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132477; c=relaxed/simple;
	bh=lGoQZkSOhObBSGBmOQqUl4CKDyZTv754S8QyLTisCic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QWFcMgaSGR5X3AFkHWsDhGKw0tQ2VqVVvJ9Imkca53LqhNXUUv2kmmOMIsZwlMqSnFRAgaB2SVg1EAHdGTRcsdP4zqr7857iWU2Ht51u8+g/iGXDlT5bAKJqoHfU2dhA+AZb2zl9ZdVS169EkBqCVh+/7oT1VQj7KfPO/1xeT/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LQTWcbrH; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="LQTWcbrH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOt4N/PL54G/yTrnSiK/pgLw7BT4vphwJFxlAXsoYkNjJ6Xkjj8yJtXFThQfsxHjkpeOmrAdnCY+qwvr9Oo5ve16WSt5i0BAEDaojmGF0TBdHaMnzX84H7zDTgxC2xKjOOxAe4qZovCbeJ9740h8FDK/dgR2vUV6xZDDQMVFow+pSx5iougbFcN/IYrr0TurwaJ9SWeaIqKV1+jEmUilKGW2phMU/bjfqw1ZEnUGD3KDQvbEiclVlqkmn20nBtghBTLKTQsEVbADf+t45DR/6r8YtXZBpFJD3y/kuHxeR6WuHGZigsZSKEvBbfx2bWMxeiDflLgxicJf6f2bBqpUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u4G0gTo/T+5ncq3T33u9kke1zq4WytrvZWuIbDkJu0=;
 b=vcNs/L4oxnEWDpvxdgnvITWXhmzLlxQ/ndiEZZCZ6T3d300fZ3af+hKq7sGNFrc26iWgZ1poxaZp3B4/tTzmFcPVD/SUYvzdLhUXVHjbsDu0/fIkfhsEb3UwJgzpPTefLXgST8EJJ7ud7uSzqvKT7B+AlP10BMK72NTsBvH8YGR5SiKnDPCTrZyf5OsRjPQ95TJEkoZv/We4lMVErpVJd4Ybd3lCe8ag+LavlXSHv9N1muSTeEa9NyKvNOtLoEeo1ESR7Kfv03IHuGIl0XWogvY6g8Le39T6yuDki1WWnNKn3SPMEOFYUcuh4+FDzXcbk7mWyCf1y4icjBU5cSex9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u4G0gTo/T+5ncq3T33u9kke1zq4WytrvZWuIbDkJu0=;
 b=LQTWcbrHMraAzQEjfC0YYlhZdOh4xgG93AuBw5ybI7uJiZy+39tMDxR0iAT3FjjvuXHjyu3YjV9kzSSecPeqhpHxMDCZwCNSV7udew5Sr98ot6wydffA+FZRerDCFJBfYgbMSxjlb23qDsqQzdT7ASQ5QodMmG8ydj6Fj9NdTnund+juAHGGHxtG0+lizjgVHTcwrnUru+V0nNEGb+GQkQcZEwfToQy7WFWD3o+Bp4rr+o1Dn6egiSv+PJtiqQrCEBU7wUVYnx4ZyM67JgqUix0aoM8oMjGXmNfq1fX2fqc/CJZBNWCd9F+DsAKTpUOZpJ1w5ldAh92aZChwsC4tlA==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by AS8P189MB2509.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:637::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 03:01:11 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 03:01:11 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Yuqi Xu <xuyuqiabc@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, "xuyq21@lenovo.com" <xuyq21@lenovo.com>
Subject: Re: [PATCH net v2 1/2] tipc: stop the listener before draining
 connections
Thread-Topic: [PATCH net v2 1/2] tipc: stop the listener before draining
 connections
Thread-Index: AQHdSa1jDH3bmNtQLkei7BrjveTFc7bbb+Zg
Date: Wed, 23 Sep 2026 03:01:11 +0000
Message-ID:
 <DU4P189MB3750BEF36FF7EEBA03E152FFC6822@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <cover.1789960909.git.xuyuqiabc@gmail.com>
 <d16573ddc2464277a04274fc12630daf00b8f149.1789960909.git.xuyuqiabc@gmail.com>
In-Reply-To:
 <d16573ddc2464277a04274fc12630daf00b8f149.1789960909.git.xuyuqiabc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|AS8P189MB2509:EE_
x-ms-office365-filtering-correlation-id: c4d50bdc-dadf-4194-a8c2-08df191eec39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 9vRJ8FJdXellp7ljRlXP/02GCJgWePNfeCNTiLVVgMSl/bDt6+MLBKA+lxIEgqHtP+/XivM/FG7xQKoAaRjNWk/SWOog1jIQzekzQ6sgN+K1H64T092LRYugPKMrKSTM42GuTbwSFAYhd+Y4X1GYOlILDdEvuD7iFsoafisNGspPZhPPz6gPF+aUrCqgv1Baqfz0GTSpvr3Mu1Akr7qHtgyWhls/0D0W79aV312ZyvLwHoAdUDvDdoar8ukrrEy2xZYrXYp/ENZuyrXuRzbRHdm0tzFJKQwny1wX/822P3HOuR8y1lUZYsV3tWyV8T1hXrCWjij0oiqwbQadFF8xtRehl14StIkjG4Wuy8+s89kx7V68Rs6myg4utc8l9iZGabMo7T7dcBazhbPmWsYhPN0ctLg8kooaiaYga/Y0aHfHp/5CPlO9JTMFMLeUo55lPzr1a8Tjd86dz+7OhIRZBkAhF1jD4YWLWYMiSw10pL/tP0MzZhOVh0gAQ3SAfjMz3FlM/pRFv14OGxrJvZlm/6DrFlKvDPzaqUejnMAyV6Vcuj8OQiWAB0ouZ6JqfAmJMsLX8bGwPQ1O0PmS9qmtIsfEjvTTEMU0WRRd8bOytH5Ii2kvL6FV5t3o0lng4r0b6rsFFfpBRb3szR7I/hl/rHmEsgqsM2HS1Bkgs8rawwWXtlwUs4hhY4yWQPfWuYC80wLJQiMvMNK6JKGN2CcOPhY5lCDDwPaUUt/85yLpq0Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GGeOpyc2cXJGpFvx+XATbpWA9N8VtuZIh4zEuj0fbvt2IltBe91twY/nJM?=
 =?iso-8859-1?Q?pyukFqYLqJxG/lhsWx8G93A36jiho8xy5SUxdxS126nZY7JeMMyPYZoLZC?=
 =?iso-8859-1?Q?WFlK2gwGTSOV4deicZViy1FmdoBTEFKRafaRheNNzhK5nsJaMT/1gNnzOJ?=
 =?iso-8859-1?Q?eSBeRByYfmCT047xJiYC5pu3i6L7S8FCgb2LNBA/EPxw+l4R9fJK2DhJOa?=
 =?iso-8859-1?Q?ih+ZDUg0jbWy6XjQuDiK3A7WEmRBfkgPe1vU0rFwJMPfoDxyRI40GlGOsk?=
 =?iso-8859-1?Q?AZhCP+cYRWp/qEg1cIlbobirY3dF3+nFE0tvyjte9bYWAJ/Ookbj1VRSmB?=
 =?iso-8859-1?Q?DjXI8AvjNKST6IO/DwNsbdCLePV0hIsPddA9Z2Z1I+Y1uIq5a7ddFr76aO?=
 =?iso-8859-1?Q?LQzZQ/WjzWa/NravXhTGzeewqlbZJeA3ZP6mkkdg+BpdDf1kW88oi0Xfb6?=
 =?iso-8859-1?Q?FPah1yi4t2mY5Nc9WiFHBNvA1+Ut75UHTpkcBa7w0/XGR9PmEl3lh7ccrB?=
 =?iso-8859-1?Q?n0Gd5adTVwkW1zFmCeP8uTkqpwRGTap7I5MfKMe1YKS34xCc1z/wiHWYUX?=
 =?iso-8859-1?Q?0CUH9tMtQojEyh/yuwVHDMyy4N0DlfP3AaQWJG+xdXSxayYiq5mxKrTkht?=
 =?iso-8859-1?Q?8fG2SxEoN18jKBX+W441K2CnknXFA0Xl1ECzHGV5fxw8RZdTaR6Bx8e+M6?=
 =?iso-8859-1?Q?gQY4OUpUnD2oq2wu9/MraVjQGA2eEC5pqxPH9hM0qoQQA8xXIPkF/wxgHc?=
 =?iso-8859-1?Q?kyOobySVvcCu+wLLytG8Y1+LyPD7DtIaKepKIkaYdih6gfOHeRtUDBlbac?=
 =?iso-8859-1?Q?ey/Vgd7Y6Ce/ukJkbLuT+ELyOGxmsy2j9Jw4JhQ6GWctempyZf1cnP2cwq?=
 =?iso-8859-1?Q?/oflQzVNodJAmPh5YSYx1FlGpswcbncT5s4oEJ9bSxv7fiu9AgN/JAUBEq?=
 =?iso-8859-1?Q?AIiZl6zCS3pWdtIPmmWaAUB4jHCTqgiz69y1C8H90nDtY7zS/enBlUiFer?=
 =?iso-8859-1?Q?5q+PnQhAZ+GdKhjn4V6AZTrsbXc//TNIUCXopoal6oNO45CNedAA2CDXXw?=
 =?iso-8859-1?Q?eDOESUusJq7/tadqBB9gMn3Kd2gLATWg7WDqkscJnV75A2ZhrQIYCy6ciN?=
 =?iso-8859-1?Q?K3MuqxyfP0/0+QeD9pQXf+HqgdZKXXBlVUVydDIEFMnrBL7RX+rNfmTCQ4?=
 =?iso-8859-1?Q?kYBcNmJxNXvAEsK8IDEschpAVbedhqMs6z587t3Ut9BWmpCe2ykeZ9JvoK?=
 =?iso-8859-1?Q?yn5HpxDJAX1nhMcSNFQuTb0uywZlCFtwseLMHpirpVVPWYOSWpPjOVqxFQ?=
 =?iso-8859-1?Q?Ih1dpRypJO1S+myqHxeGIPrMfLT61XZiGgtBUvzaq+DFXWsSucDTDYAPXA?=
 =?iso-8859-1?Q?rn79GL7PesQT8KtkppcfoQwzpNePFnUTFFUKppvCakmAWaXVMSc14uSyRQ?=
 =?iso-8859-1?Q?zYL6ZBv2nfZCBsCz0JFloTonrfKSwX4DqsdMspO9NkbwJWF84+T/Yrh+pA?=
 =?iso-8859-1?Q?AIMBZjvPaFZmq8IyCGZazeDgKzfDd/bp2Td2j23d5NalAyyfJd0xr37O3S?=
 =?iso-8859-1?Q?6KJzLklHaCDj+VEtW084i/RYRhNVGnwg77ACpmkJy+6nyBPq9XsE4DMRf/?=
 =?iso-8859-1?Q?Nl1PZI22l6T8lF1AUqhs2Pcq9MlliXim24sVrBuBu9f137QmyEujE3T+Ts?=
 =?iso-8859-1?Q?WYW7YYpnLj3SE7iFHTxpGPxc8GdScRb0adLKURG/63YNLOmb6Usy7of+eX?=
 =?iso-8859-1?Q?pPR6Z3K1+8qBniOMq6J0/Q7l16kHa8fOMkSHrdFTuWKxyiA9nCam3HUd5L?=
 =?iso-8859-1?Q?JEC8dvdTdsGgpNfumhFdYbCcbYl38WXfHoqMOQvcTRYRX372KZQnRMYlef?=
 =?iso-8859-1?Q?Cd?=
x-ms-exchange-antispam-messagedata-1: 2goXVgkxHbgG2Q==
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d50bdc-dadf-4194-a8c2-08df191eec39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 03:01:11.1848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBnP2iX5/rCw1EaCIHsMeCeG65ENfwcA+CRaG1DjVliyr1SPfPW6ZRdAlcBks2THwCcatSiUCCvxx31OY1fb7lAG8sL4334IsALhbUSLTJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2509

> Subject: [PATCH net v2 1/2] tipc: stop the listener before draining conne=
ctions=0A=
=0A=
> tipc_topsrv_stop() destroyed the receive workqueue while the listener=0A=
> socket still had its data-ready callback and sk_user_data installed.=0A=
> An incoming connection request could then queue srv->awork on the freed=
=0A=
> workqueue from tipc_topsrv_listener_data_ready().=0A=
=0A=
> Reject new accepts, clear sk_user_data under sk_callback_lock and cancel=
=0A=
> pending accept work before the workqueues are torn down.=0A=
=0A=
This is not enough. Thus, this patch does not fix the original cause of sev=
eral issues (use after free, counter leak, NULL pointer dereference etc).=
=0A=
I use your reproducer with this setup:  ./poc -i 6000 -t 4 -r 5000 (and ./p=
oc -i 6000 -t 4 -r 20000)=0A=
And the same stack trace is observed BEFORE and AFTER applying your patch (=
kernel 7.3.0-rc3):=0A=
"=0A=
iter=3D0 ns_failures=3D0=0A=
iter=3D200 ns_failures=3D0=0A=
iter=3D400 ns_failures=3D0=0A=
iter=3D600 ns_failures=3D0=0A=
[  271.777365] ------------[ cut here ]------------=0A=
[  271.777368] refcount_t: addition on 0; use-after-free.=0A=
[  271.777369] WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x6a/0x=
90, CPU#1: kworker/u8:4/929=0A=
...=0A=
[  271.791358] CPU: 1 UID: 0 PID: 929 Comm: kworker/u8:4 Not tainted 7.3.0-=
rc3-default+ #31 PREEMPT(full)=0A=
...=0A=
[  271.794423] Workqueue: netns cleanup_net=0A=
[  271.795096] RIP: 0010:refcount_warn_saturate+0x6a/0x90=0A=
[  271.795951] Code: cc 48 8d 3d 88 d0 48 01 67 48 0f b9 3a c3 cc cc cc cc =
48 8d 3d 87 d0 48 01 67 48 0f b9 3a e9 0d 97 72 00 48 8d 3d 86 d0 48 01 <67=
> 48 0f b9 3a e9 fc 96 72 00 48 8d 3d 85 d0 48 01 67 48 0f b9 3a=0A=
...=0A=
[  271.809733] Call Trace:=0A=
[  271.810177]  <TASK>=0A=
[  271.810559]  tipc_topsrv_exit_net+0x1b4/0x1e0 [tipc]=0A=
[  271.811439]  ops_undo_list+0xd5/0x230=0A=
[  271.812056]  cleanup_net+0x1ec/0x320=0A=
[  271.812666]  process_one_work+0x1a5/0x3b0=0A=
[  271.813343]  worker_thread+0x1be/0x330=0A=
[  271.813989]  ? _raw_spin_unlock_irqrestore+0x12/0x40=0A=
[  271.814814]  ? __pfx_worker_thread+0x10/0x10=0A=
[  271.815551]  kthread+0xf6/0x140=0A=
[  271.816090]  ? __pfx_kthread+0x10/0x10=0A=
[  271.816738]  ret_from_fork+0x288/0x330=0A=
[  271.817377]  ? __pfx_kthread+0x10/0x10=0A=
[  271.818017]  ret_from_fork_asm+0x1a/0x30=0A=
[  271.818681]  </TASK>=0A=
[  271.819067] ---[ end trace 0000000000000000 ]---=0A=
[  271.846984] BUG: unable to handle page fault for address: 00000001000002=
cf=0A=
[  271.848215] #PF: supervisor read access in kernel mode=0A=
[  271.849079] #PF: error_code(0x0000) - not-present page=0A=
[  271.849945] PGD 0 P4D 0=0A=
[  271.850420] Oops: Oops: 0000 [#1] SMP NOPTI=0A=
[  271.851145] CPU: 1 UID: 0 PID: 929 Comm: kworker/u8:4 Tainted: G        =
W           7.3.0-rc3-default+ #31 PREEMPT(full)=0A=
[  271.852937] Tainted: [W]=3DWARN=0A=
...=0A=
[  271.855014] Workqueue: netns cleanup_net=0A=
[  271.855702] RIP: 0010:do_raw_write_lock+0xa/0xb0=0A=
[  271.856486] Code: 00 48 8b 3c 24 85 c0 0f 85 5e a3 e9 ff eb d7 90 90 90 =
90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 0f 1f 44 00 00 53 <81=
> 7f 08 ed 1e af de 48 89 fb 75 45 48 8b 43 10 65 48 3b 05 96 55=0A=
...=0A=
[  271.870488] Call Trace:=0A=
[  271.870932]  <TASK>=0A=
[  271.871331]  tipc_conn_close+0x24/0xa0 [tipc]=0A=
[  271.872088]  tipc_topsrv_exit_net+0x108/0x1e0 [tipc]=0A=
[  271.872938]  ops_undo_list+0xd5/0x230=0A=
[  271.873588]  cleanup_net+0x1ec/0x320=0A=
[  271.874211]  process_one_work+0x1a5/0x3b0=0A=
[  271.874891]  worker_thread+0x1be/0x330=0A=
[  271.875536]  ? _raw_spin_unlock_irqrestore+0x12/0x40=0A=
[  271.876376]  ? __pfx_worker_thread+0x10/0x10=0A=
[  271.877119]  kthread+0xf6/0x140=0A=
[  271.877686]  ? __pfx_kthread+0x10/0x10=0A=
[  271.878335]  ret_from_fork+0x288/0x330=0A=
[  271.878980]  ? __pfx_kthread+0x10/0x10=0A=
[  271.879641]  ret_from_fork_asm+0x1a/0x30=0A=
[  271.880314]  </TASK>=0A=
"=0A=
=0A=
So, your patch does not fix the original root cause: not deleting topology =
server's send/receive work queues before closing connections.=0A=
Please help test this patch to see if it completely fixes all observed kern=
el stack traces:=0A=
=0A=
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>=0A=
---=0A=
 net/tipc/topsrv.c | 73 +++++++++++++++++++++++++++++++++++++----------=0A=
 1 file changed, 58 insertions(+), 15 deletions(-)=0A=
=0A=
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c=0A=
index af530c9ed840..2fc10bf593b0 100644=0A=
--- a/net/tipc/topsrv.c=0A=
+++ b/net/tipc/topsrv.c=0A=
@@ -55,7 +55,7 @@=0A=
 /**=0A=
  * struct tipc_topsrv - TIPC server structure=0A=
  * @conn_idr: identifier set of connection=0A=
- * @idr_lock: protect the connection identifier set=0A=
+ * @idr_lock: protect the connection identifier set and listener=0A=
  * @idr_in_use: amount of allocated identifier entry=0A=
  * @net: network namespace instance=0A=
  * @awork: accept work item=0A=
@@ -301,10 +301,20 @@ static void tipc_conn_send_to_sock(struct tipc_conn *=
con)=0A=
 static void tipc_conn_send_work(struct work_struct *work)=0A=
 {=0A=
 	struct tipc_conn *con =3D container_of(work, struct tipc_conn, swork);=0A=
+	struct tipc_topsrv *srv;=0A=
+=0A=
+	srv =3D con->server;=0A=
+	spin_lock_bh(&srv->idr_lock);=0A=
+	if (!srv->listener) {=0A=
+		spin_unlock_bh(&srv->idr_lock);=0A=
+		goto out;=0A=
+	}=0A=
+	spin_unlock_bh(&srv->idr_lock);=0A=
 =0A=
 	if (connected(con))=0A=
 		tipc_conn_send_to_sock(con);=0A=
 =0A=
+out:=0A=
 	conn_put(con);=0A=
 }=0A=
 =0A=
@@ -334,8 +344,14 @@ void tipc_topsrv_queue_evt(struct net *net, int conid,=
=0A=
 	list_add_tail(&e->list, &con->outqueue);=0A=
 	spin_unlock_bh(&con->outqueue_lock);=0A=
 =0A=
-	if (queue_work(srv->send_wq, &con->swork))=0A=
-		return;=0A=
+	spin_lock_bh(&srv->idr_lock);=0A=
+	if (srv->listener) {=0A=
+		if (queue_work(srv->send_wq, &con->swork)) {=0A=
+			spin_unlock_bh(&srv->idr_lock);=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+	spin_unlock_bh(&srv->idr_lock);=0A=
 err:=0A=
 	conn_put(con);=0A=
 }=0A=
@@ -346,14 +362,20 @@ void tipc_topsrv_queue_evt(struct net *net, int conid=
,=0A=
  */=0A=
 static void tipc_conn_write_space(struct sock *sk)=0A=
 {=0A=
+	struct tipc_topsrv *srv;=0A=
 	struct tipc_conn *con;=0A=
 =0A=
 	read_lock_bh(&sk->sk_callback_lock);=0A=
 	con =3D sk->sk_user_data;=0A=
 	if (connected(con)) {=0A=
-		conn_get(con);=0A=
-		if (!queue_work(con->server->send_wq, &con->swork))=0A=
-			conn_put(con);=0A=
+		srv =3D con->server;=0A=
+		spin_lock_bh(&srv->idr_lock);=0A=
+		if (srv->listener) {=0A=
+			conn_get(con);=0A=
+			if (!queue_work(srv->send_wq, &con->swork))=0A=
+				conn_put(con);=0A=
+		}=0A=
+		spin_unlock_bh(&srv->idr_lock);=0A=
 	}=0A=
 	read_unlock_bh(&sk->sk_callback_lock);=0A=
 }=0A=
@@ -418,8 +440,17 @@ static int tipc_conn_rcv_from_sock(struct tipc_conn *c=
on)=0A=
 static void tipc_conn_recv_work(struct work_struct *work)=0A=
 {=0A=
 	struct tipc_conn *con =3D container_of(work, struct tipc_conn, rwork);=0A=
+	struct tipc_topsrv *srv;=0A=
 	int count =3D 0;=0A=
 =0A=
+	srv =3D con->server;=0A=
+	spin_lock_bh(&srv->idr_lock);=0A=
+	if (!srv->listener) {=0A=
+		spin_unlock_bh(&srv->idr_lock);=0A=
+		goto out;=0A=
+	}=0A=
+	spin_unlock_bh(&srv->idr_lock);=0A=
+=0A=
 	while (connected(con)) {=0A=
 		if (tipc_conn_rcv_from_sock(con))=0A=
 			break;=0A=
@@ -430,6 +461,7 @@ static void tipc_conn_recv_work(struct work_struct *wor=
k)=0A=
 			count =3D 0;=0A=
 		}=0A=
 	}=0A=
+out:=0A=
 	conn_put(con);=0A=
 }=0A=
 =0A=
@@ -438,6 +470,7 @@ static void tipc_conn_recv_work(struct work_struct *wor=
k)=0A=
  */=0A=
 static void tipc_conn_data_ready(struct sock *sk)=0A=
 {=0A=
+	struct tipc_topsrv *srv;=0A=
 	struct tipc_conn *con;=0A=
 =0A=
 	trace_sk_data_ready(sk);=0A=
@@ -445,9 +478,14 @@ static void tipc_conn_data_ready(struct sock *sk)=0A=
 	read_lock_bh(&sk->sk_callback_lock);=0A=
 	con =3D sk->sk_user_data;=0A=
 	if (connected(con)) {=0A=
-		conn_get(con);=0A=
-		if (!queue_work(con->server->rcv_wq, &con->rwork))=0A=
-			conn_put(con);=0A=
+		srv =3D con->server;=0A=
+		spin_lock_bh(&srv->idr_lock);=0A=
+		if (srv->listener) {=0A=
+			conn_get(con);=0A=
+			if (!queue_work(srv->rcv_wq, &con->rwork))=0A=
+				conn_put(con);=0A=
+		}=0A=
+		spin_unlock_bh(&srv->idr_lock);=0A=
 	}=0A=
 	read_unlock_bh(&sk->sk_callback_lock);=0A=
 }=0A=
@@ -503,8 +541,12 @@ static void tipc_topsrv_listener_data_ready(struct soc=
k *sk)=0A=
 =0A=
 	read_lock_bh(&sk->sk_callback_lock);=0A=
 	srv =3D sk->sk_user_data;=0A=
-	if (srv)=0A=
-		queue_work(srv->rcv_wq, &srv->awork);=0A=
+	if (srv) {=0A=
+		spin_lock_bh(&srv->idr_lock);=0A=
+		if (srv->listener)=0A=
+			queue_work(srv->rcv_wq, &srv->awork);=0A=
+		spin_unlock_bh(&srv->idr_lock);=0A=
+	}=0A=
 	read_unlock_bh(&sk->sk_callback_lock);=0A=
 }=0A=
 =0A=
@@ -700,23 +742,24 @@ static void tipc_topsrv_stop(struct net *net)=0A=
 	struct tipc_conn *con;=0A=
 	int id;=0A=
 =0A=
+	spin_lock_bh(&srv->idr_lock);=0A=
+	srv->listener =3D NULL;=0A=
+	spin_unlock_bh(&srv->idr_lock);=0A=
+	tipc_topsrv_work_stop(srv);=0A=
+=0A=
 	spin_lock_bh(&srv->idr_lock);=0A=
 	for (id =3D 0; srv->idr_in_use; id++) {=0A=
 		con =3D idr_find(&srv->conn_idr, id);=0A=
 		if (con) {=0A=
-			conn_get(con);=0A=
 			spin_unlock_bh(&srv->idr_lock);=0A=
 			tipc_conn_close(con);=0A=
-			conn_put(con);=0A=
 			spin_lock_bh(&srv->idr_lock);=0A=
 		}=0A=
 	}=0A=
 	__module_get(lsock->ops->owner);=0A=
 	__module_get(lsock->sk->sk_prot_creator->owner);=0A=
-	srv->listener =3D NULL;=0A=
 	spin_unlock_bh(&srv->idr_lock);=0A=
 =0A=
-	tipc_topsrv_work_stop(srv);=0A=
 	sock_release(lsock);=0A=
 	idr_destroy(&srv->conn_idr);=0A=
 	kfree(srv);=0A=
-- =0A=
2.43.0=
