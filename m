Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745162;
	b=ryjo5DIyEnyCvreS0DfxbaL4Pn/vPk4bR4YUQyAxDtix294OSLOdHW2LmhZ5d9l8pxBU
	 uDh+yPdOVSG8ZPsq+APOUaucZCgaoroAsjv/BDKosuqMq53OnECdmy+BiW/qDHv8ClsT2
	 r3+3H6cjU8UjVJ8cxde3mMeDey+pXrhSbP2Nw096Xolkcb9Sdyey9qiBCCthpy46W8wcE
	 ZGtRAe0JAYtC1OgqEmsPpooRLOUfuyf4bUEZh8A+D8CLTYw/c8sSSbIl6j0yXoJWdrSU1
	 +tp1rYz6VuKDKepkqNPiVbgYjmwkp+j+RAMwi0cu4wFRR72kkD3JJ61wnyXlwaMMuCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745162;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=+P7RG7iGKKPuGYKkdoIDgJjrSv97r23WN7bfpjoFjXk=;
	b=rjchzH5VaPuzYrrwS6BDbXhvlcU9sENI4IdvzorHoLWXt6HKCSmVhyv487eRz2YAT6V5
	 OxKugmFsdeDfK5e7AncL+OjVdNp2CkvUwARkiNgK0IjdfAfPtBrjNLlBGK7FJw9sQULgG
	 6Ww4qXvzmXC5JyA+JFrZXyGO1l+Pigo3BmBTt9PzAAMr1jri3cn84xDHwVsfqQ+n+NwDA
	 BEjU+K6WIXOhsMDRPc8KZWEV9qBIsrs7drUs5kzRSFtCSCXgTwB9LS6ubcEKqLhgK8KB6
	 kT/kWom+D5/ek919+52OxeF4b5zjW5KU68VoNoT4xxgrU8ZRoDqXj8OoSv0KsdoZPrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=M8Zgabd4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.91
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020091.outbound.protection.outlook.com [52.101.228.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A8606A329;
	Fri, 27 Nov 2026 02:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009A8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=M8Zgabd4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtysrxYO3MFA7omS5NnGKMaRU+ZOHhjYe71axC4jBQ79lDSD7O9f1Ix5uI9+FGXChAlDVBjLQmb/kJTZM+k10Tre/iVD/R7MGXbWBamGCrF2bvoma6AS7JY9AuhpC4oFkQEbTFLm/LgC5iAT5SmSofcuTGRXb3EbFnydji3AmOrYs/Mwa38Ho/UmlJpQPb0Ulseb6nX4GU/M6nBYGcRYfqDRO4Z1QQrmtu093FG150GttxRcPz39JfqPKEUBEBIhCfmb9MRi2V83BLobjZVS8EgjVPeZtgLKswlCchmAX2lHv0hNHFuz/y27I4K/XfdvwnrvRrbqRFY0e5SJFbtygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P7RG7iGKKPuGYKkdoIDgJjrSv97r23WN7bfpjoFjXk=;
 b=TwR0UnFow+kcY0nGIbgoxwuMjclPWI23ViD3PEN6Gf6xDp9EKi4/LDC7cgpRAVFrLGKa3W3MUYBcdasg5blVGJccXIiVpDZ7iH0bOCV1fC1ldJphsXU60JNkGDhn/Qq5P8OjBz8dEKGtVHFnaIPpSmzQKrKA5Q+RJz6fqOyEcvVwKVeXQpJAduajOWURmXNQERpwG5htIkMEQ+DNJpWqHBBXdEidVd5cuwYBDsXebUHPVwqW6g/t6c/4bnv247PmEEEve8Pm73rmnzZOjKT3XQGxUZON4qKXl9JQ1R/JnbnTYL13BIL7iHxRnA/ymjHoQEXG/SVlf6IB5s+/lcqAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P7RG7iGKKPuGYKkdoIDgJjrSv97r23WN7bfpjoFjXk=;
 b=M8Zgabd44xiRTHQu2gjnN3z2XhVFa2is4/sLWCg59wdRVARRJjjkmvBDH/TJWX2RAjbaqZOehM0o+elxsf5ZPqIoNO/kCorq9GUTLELYcjylFm3tV+8ulqU/pBuXHqS6sbbPdWPpGLDgCrLtVnngmi4Y3ukrlq4aGLglGC1Wb00=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 13/15] NTB: ntb_transport: Clear QP pointers when freeing an MW
Date: Fri, 27 Nov 2026 11:05:31 +0900
Message-ID: <20261127020533.2481725-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSBP286MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: afb15200-e432-4967-3e38-08df4c2afb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xkrmEfU0/MbM+ihrUnrh8BcD1i4s8POu9jamJSZUIhaSUFXa1LFqgE04/WMnWvfSDkD3Ln/5Yr5zJlttlPXVzNOlYkuPsBmG/5d23d9j8waBWtIc7dF0XHwideQgtSKLRuuLP2bLHIMF+SHmrsXc+nkTu8qX5zc9Np9WxgoqCcbR6PB2plHgHZOoS+J+J3K3RW5Zy4vjGXS8BS29RXvmpAEKGb0ZWdG3KEtBz48Zdde/P/SmfJqohNFiedw7VPBK9oFwJArJ97cT3LTux7JTZpmNpxDAShRL/AFcY8bNhrXSQK00dKZU3fTVwQ6X9nWkBQDLfClqUy3OtEl9zFFiFxw33fdtwzED/ddtsILCP1KDtZ7RSpbCkDm03isQVoEn6fVGGsSADUM1QIvPlR0CibQObRklulDb4LEOE3fOSuNSzFKzWwnea/WOFrCQ1BhnU+Qi/ELP//RQn8jwIIryxc5xKeLgUtJWCVw3iAWHtSKVj3tM89dXiz4YX/t+jcpJmHYc7OqtcUZaYcji6nYEwFFCJWoFfXu14PB7SwVRzjrefODrp4uEBIC+mDCbM/Jc4uIMLg/f41mIH+610RTqhqgPrsefFVOAuwerH8SaHm1Arb/sDXzheAECWIEEBJ8pdqDloatNnVdIRdcmZ0fig4xJhsw6JMR6HfF+lXRFM0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81PGyZQLh/Rv0O9rFZ+9eJci0mSRFDo+2IzUzv9t9HGYO9NbWxsl+Z9r31eY?=
 =?us-ascii?Q?HcZgFZ2otTscV/XW2gHnOdsjDQtSS6r4TRlOkEHAC2Y1ZFtREQd3023Hqnpq?=
 =?us-ascii?Q?MOjiN81nexEoie3J2zhCR5fNT6rVzFORU3F/WJrbGgkUIHSMTZ5WayUKbv3C?=
 =?us-ascii?Q?h6srUE1hlvr22pKGcBMc1V0qcVkVSDp04tfjUvnYtrmMFcwzG1iRHKUzRjkn?=
 =?us-ascii?Q?27BaB/tEJBpA3/r7nexKl3Ycm8Sxx+ZR5bQjNcKJIemDx3R/WmxwyniNl83L?=
 =?us-ascii?Q?mWwGY6aO1F3KBr+7A015KH9g6gmqQOtiHm7t8kIwnerP8cnsDmtQBkihGWf7?=
 =?us-ascii?Q?IWm680TJ5sxFfR50S3TAZgRqJS0k7h8nnA6nnmGEGRNktIQwgHV3VYcEVtcL?=
 =?us-ascii?Q?S8g6MfOICgmDWxOQg25MWT+q6WSGVM+U227UX/Jboh5rT+WKg93BuVm9HOXu?=
 =?us-ascii?Q?oE8Cb+ADWJ5RPP8wdGOP2QcRKub8XoyOxJwvd7EZrKoWb2FhF9Cz413s4x1e?=
 =?us-ascii?Q?HdnE/B+SS+t9sapA85+fas/JrtRekfn5TmIBAl/tlZZimyIqmYAzbZ5DwtYa?=
 =?us-ascii?Q?CTv2MEZ8Fi3Eh8OQiDmC1svl+/sG5Fo/+crdFWG8ffjDJKF2RgnsWBXSK0Iw?=
 =?us-ascii?Q?mARH0L21JEzydCNdivug5qE2VO3cI6tvUStl+hQ4xoELZ3aQrYgWC6b7db/J?=
 =?us-ascii?Q?0djH0GA+Lcsmtg5LyaMLR+D/YYt0Z8faucR12+wRAt7jRKzaHYy4CsiHZHnO?=
 =?us-ascii?Q?KZAA1GSnq58g2lbPv3WGm1orLYLy3wAMIKv8BG9cTjspfijWCRHHKPtmJy9Z?=
 =?us-ascii?Q?V3qUZSe8uARZu3MHSvBpnQaazcU7ZeQC7zTF2XnAzZel8v7tX33+rkRv6u0U?=
 =?us-ascii?Q?nLNkgQv+43nmygQFfCmOEwH10Xary8FANgdJif+ID9Xh6cUgmHgu0qa6U55k?=
 =?us-ascii?Q?NuNwWSaUTS0to+T/DQiddaBI1Xc1oUZ+TRNh6ibrMS6qpSRhGRGMma/x2p4P?=
 =?us-ascii?Q?OAsrv8ZSf9pCIhOpCtqPcpjcgD8EYASk30hc5Js4PP10a58RO8lYoHNrS8nc?=
 =?us-ascii?Q?t7wyo9QJXrHbqJE4DEjmZ1xxqWHrIITFMXpJaT6u5DUw+nOkdz4q0Xoro1Ch?=
 =?us-ascii?Q?oMjvVJRPKtjXsyM78n5EYZwNnks0GnJKVadJ1SLuLX7Z39CFRjZ1DBBi37RW?=
 =?us-ascii?Q?rHOXOa8kO18ds8oZvKqV5y2rGC+1mBnUQyABxuuHIDDsqfZk4wnKCkzYt1GU?=
 =?us-ascii?Q?/9Ad6zKE9sBzxltnAu0eBpPb3TshnhbFv8tyrZ6D11d95pn4++XXph9S5KN7?=
 =?us-ascii?Q?lIdmdH+QpimPwPc7+YO5bXOvYmPgAqnA/HVk9TrA23wP0qWZQXwsNKuzqNEm?=
 =?us-ascii?Q?OALKiuhJQZKnMzq7N0l2wvFBPu5MSw3uLvKWVOkc28KpUbblRzVnZOnd1oKd?=
 =?us-ascii?Q?jBmP+hGUht2hLfB7zMjVeNDRdECI3GklSX2e1gsDngW0a3yVerOdIGoozMaD?=
 =?us-ascii?Q?bVxyK5swMZys2KotgzwxNhOiNB1xvocZP0AzXcqev9WFpu1/nz/YRRI0XStH?=
 =?us-ascii?Q?uu1GC0Nx5r4h/ZoaD4voJ5ipYI1tgFy7cUuN4MMvkzwgXE5NL2gZ4AIFCuYd?=
 =?us-ascii?Q?KBpPlFePjyNyPAXi8fRFVX/6s5oN+5r9WewB4Co0/ueqCDJ++BZ8JfhCDK4G?=
 =?us-ascii?Q?VlWNa/2ZGNyHFaNVZD7xo5T/VdurudqqUReGgDU7wuCul9OWepPFi6yMCfWj?=
 =?us-ascii?Q?XdqBzuIeHDutZVzlJGllYOiHOiwedFaumlKqe0xzTZWTM9dWu3fR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: afb15200-e432-4967-3e38-08df4c2afb14
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:59.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfszaWxHr2Q335KVHPmSFFZQnyAU1N4uBVJcscO2LfE6C2/nBltPKwcbqWNIg9ejq6ClvubIAFkN232umB+bKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

ntb_transport_link_cleanup() frees MW buffers but leaves rx_buff and
remote_rx_info pointing into them. With a QP still allocated, another
link-down notification or transport unbind before MW setup runs again
can make ntb_qp_link_down_reset() write to freed memory through
remote_rx_info.

Clear both pointers in ntb_free_mw() for all QPs using that MW,
including those without a client. This also covers link-setup failures.

Fixes: cc79bd2738c2 ("ntb: Clean up tx tail index on link down")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

How to reproduce:

  1. Load ntb_transport and ntb_netdev on both sides and establish the
     transport/QP links once. Stop traffic, but leave ntb_netdev loaded
     on VHOST so its QPs remain allocated throughout the test.

  2. On HOST, unload ntb_netdev and ntb_transport, leaving ntb_hw_epf
     bound:

     modprobe -r ntb_netdev ntb_transport

     Transport removal sends COMMAND_LINK_DOWN to VHOST. Wait for
     ntb_transport_link_cleanup_work() to return on VHOST, using a
     function-graph trace. The "Link Cleanup" message is printed before
     MW release and is not sufficient to establish completion. Do not
     bring the link back up before the next step.

  3-(A). UAF via repeated link-down notification

     Use ntb_tool on HOST to send another link-down request:

     HOST# modprobe ntb_tool
     HOST# echo N > "/sys/kernel/debug/ntb_tool/$ntb_host_dev/link"

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_link_cleanup_work+0x2c/0x50 [ntb_transport]
      process_one_work+0x5b8/0x12f0
      ...

  3-(B). UAF via transport removal after link-down

     VHOST# echo "$ntb_vhost_dev" > \
         /sys/bus/ntb/drivers/ntb_transport/unbind

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_free+0x68/0x588 [ntb_transport]
      ntb_remove+0x5c/0xa0 [ntb]

Verified that neither test triggers a KASAN report with this patch.

 drivers/ntb/ntb_transport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index fa53fcb87bad..be1ae3789da1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -782,10 +782,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
+	unsigned int i;
 
 	if (!mw->virt_addr)
 		return;
 
+	/* Drop references from every QP using this MW. */
+	for (i = num_mw; i < nt->qp_count; i += nt->mw_count) {
+		nt->qp_vec[i].rx_buff = NULL;
+		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
+	}
+
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
 		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
-- 
2.54.0

