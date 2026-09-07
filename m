Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013074.outbound.protection.outlook.com [52.103.35.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA502BDC1C;
	Mon,  7 Sep 2026 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822538; cv=fail; b=BIxMEaaSLL3Mj/T557UEwEO93Po/bRLsMAcQidY3m6pT4GyFBnTi+n0BFd/pneqB0ivP+0d+KwiUapirpRJdR973/oaR5HqI0aqG6q+7/lmGSxa/FShtwRo8BekUgc3gbhdC8o5Bg0Cy3P/eV8KxW7BIlWPYCaY00xAYaBydU9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822538; c=relaxed/simple;
	bh=e84buPIt4Foxybly6mWwS+dx8sbxKKYQiAGrykgmBLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jxw66LC7jqtjpghhbz0128aURlnEYNauHvEQERAdp7jonrfeCgTYTIHAs4rwgLE1lZFkeSl150wPzc0Qny3JIEXxjYtqjX1Lf774jlI0jBwSHPIfGapwAB7xwCmQ8/vvrr6pPHluuvpFv22DKkHhthJp+YCAKZPv4aCobUxGEm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=o/hO/Db8; arc=fail smtp.client-ip=52.103.35.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="o/hO/Db8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsZc2pYqPZyrsno2KVNLqOQDeT9bAW1Zmu3e4RRXsNJ8XdghbCS0FBwskHm2tY/43esBNQ1kfUxsXycskQOXLlTosC8Q9yQOR3ufIXvpvWJwiKY8gqFt1MJmaBZ1So+mWR0Qs7tRQ1QtkgM51m8Qvv2eKWPmAdqOXRhBZBkXzPxZm2UdjxDT2aDIiQv4cDYMYEIvQstcpUxNuAyBuVYZyMKx8Il33yzlMa2A34QzCiQtYVLcEgvX41DidJ7mrpeVhuuNRqJN1lPajztHZSa2NNYsGpVE/4BYc6wR6YceNHAjVsSwmNcrsGHwasr+IeFQjFg1Eyzv0J5xWUNvwTiHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e84buPIt4Foxybly6mWwS+dx8sbxKKYQiAGrykgmBLo=;
 b=Tk6kR7odRiRAxfrmHILKywWt8LNrfhRKrcOyTxHiW67/5vbqhgJPNjIaebYF2LDgdPi03a4u+17BZZhmZQBUn/lYleSgbkP64K3uuMmwGeOnv0nph+jYNtAHp+cUk9s+DQilVrMdcL6qVDwQCaxNDI94/tmXeJvFYSrnS/w2fx1m+42qr1tbhhF/Y01WDGjhHxkw5Ynu3ILpcpaWAlalV3SjGwIcQjuHNuW1fWJIyRoZYtJBxlsRXKmuQjoxjClbef2XRUa9B7oSwEwTG3+OoFgHvp8KdCxrF7xgWiFouDgUSNK9e/GTku9SLd2n6kRhB71xUD8zg2Dgfo1m75FGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e84buPIt4Foxybly6mWwS+dx8sbxKKYQiAGrykgmBLo=;
 b=o/hO/Db8Pt6WWsBnSNC4chosETF2ilTO3DjWSmUEUduEsWOpd0zOYJ1cxLZCB0OhHeREny6WeLOf5xPNC8lWIAoVqBSfGHoqpxzM61V3nkwLKy8xE1F3TwMD7wC7vCaWCU16VkpHWRu5UN5QdhhBUnsyJFY0cEUwrTOfKkWStx5LK8yL5Ol4aqyFHdZWiXcGMigmvVNolsYVrHSS0ZPEAQ8fnQ8H4504CguQ5FQ94PW5rQrqJkDVaqqM481VTllABr2shE9d+Nl75z4pVR2LmhffTIBPkQJZhCpQqj0nWoZGXLYyun4Q6Z4f+5MjEaXYLNlnbK02/q3uRY3vMjN34w==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB0235.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 23:08:53 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 23:08:53 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	David Heidelberg <david@ixit.cz>,
	linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: validate PDU size in nfc_llcp_recv_dm() and nfc_llcp_recv_hdlc()
Date: Tue,  8 Sep 2026 00:08:50 +0100
Message-ID:
 <AS8P251MB000117D809093AB17783833EC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <2026090735-overhead-epidermal-9d2d@gregkh>
References: <2026090735-overhead-epidermal-9d2d@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907230850.113367-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB0235:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f034354-11c4-46d0-f786-08df0d34fc31
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5072599009|15080799012|25010399006|51005399006|23021999003|37011999003|25031999004|8060799015|19110799012|2604032031799003|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u2zDqHxQF6LHiADiDGZlWkweISxYy41001U1cT8P8zWFSf3lTKwwpfIKTqVm?=
 =?us-ascii?Q?gCsQaCoamb/89X5Lr8+DpuO2GlqnXjaGiELWBmmeoCL+3FEqmX+ytGWM2lbw?=
 =?us-ascii?Q?gDKoUDcHNaEgUAUI41Br0w280N2kwXWjTiTkTVOkJ5n13pEyAJeYwolv1rQs?=
 =?us-ascii?Q?A/vwdUSTlCV9fLYkwyd5asgkMxAgZyeq+n4P6m4YUdN3N334m+UUem52h2EF?=
 =?us-ascii?Q?7cmraQpmXB3Pdfl+CVEzoIQ1LhtJR8CIvkW5e79uTbu0asG6Nqu4egV1RNih?=
 =?us-ascii?Q?yyNGHyySOSi+Rw0lFoxmhOkj2nvqS85ZmsCgjEmDPH6H/Ky9Vq7noyfaoUT7?=
 =?us-ascii?Q?mnEC5yf5WnRVCwda3+dVukvqUSYFK46YExc7su7ex3fdaalKgTUIhc9qUVzx?=
 =?us-ascii?Q?uK7Csx7fQQRL6aqu8sYf84VHf5kyarOy+6Gibw5toCrQOLEv4thT0htTVQkz?=
 =?us-ascii?Q?KlHzT+Z95VNct8qhnWfypT6+9jP+Bok1+8ENidMo9AgRjhaJITB9j1YVzMuo?=
 =?us-ascii?Q?DZ5N9OpsorFeEdXwrlQI2UW1qbkJI3OxANCaTyh78A+Pfppw6UAYMFbsNQ0t?=
 =?us-ascii?Q?j1tYiy7z0Wf8d1GF5Ii04onlv7SeBIBhehcuK2fXDYIO/fdrFflZctMSo8YA?=
 =?us-ascii?Q?nVCWpDTa1pbYgHrYhD6VV31Rr4h7RZAKmEH51mnbiVgi4l9ZWVe4OIVG8Zub?=
 =?us-ascii?Q?xGE12z2fXiBKKXwLIO/a2PMlcM+/CYYa+ID+f08yVDvPiDBLEKt5W7R/k7Ey?=
 =?us-ascii?Q?lpDDKM90JAMOJwLRfyiwv15DJKR38TzkRQNYF4zxJac26hVWrb2mTpfyTwaL?=
 =?us-ascii?Q?POCdtPGXMc296DcB4d+FnFikQTXPMyLpT6Z3xsr8lXBRsUAIbdtlJc/wk9QW?=
 =?us-ascii?Q?dYagTIxhdG6r7U8IdoIcIo14RUhHO/pge5tuqCpq6bIVcg+83daEEqyUuXBI?=
 =?us-ascii?Q?SiZxDqlEJNYNLye3aV8qjNFHAXVfu9Nm7KWIJ0EE8SFlChS41yIEgAd00QGs?=
 =?us-ascii?Q?teuQZ2+aTLnADmvdI5/DKQQ7EKwtLFtJ/bWyyUGWX4rPtMbRLFZ5YcPM04Sl?=
 =?us-ascii?Q?OFToa8OykAX+Kvf98Bdfu3xHhbiY7pnxLuoFcL3iU68zXzq2Bvs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y7aNnHdoc0cA3ItF2dLNCUnRGa95k/Z7o3GVQ5HvVCPirv3tKg8xhQs45VX8?=
 =?us-ascii?Q?Owg51m/ORMmJ8AFX2Aa0beu9H/e8dN+vkk210KTX/cWTUZ/P30Gjiup+wqbJ?=
 =?us-ascii?Q?UpC3UQafHVe9p7rvmfARjg5ErKPHRldy75qUMqwCcvNPWK1+zFSP7nqqxlMa?=
 =?us-ascii?Q?ZZkIsuStyDphSWcgpWXsxjI0aPLO3yBhTRLgQfQCpNPCCdPamf+q+QmMn7g/?=
 =?us-ascii?Q?MofzhHK+trVOiBB78FoYIE+WMaPoVkjan+PK5hF4TkNjZ/Y3rmzf36XZRSZU?=
 =?us-ascii?Q?m7wZLlN/6nd/j+37Q9SaPegmovrqE24C31UQwyR0zl4LU90bB4SLAGMp90Sg?=
 =?us-ascii?Q?BPo7nhNBdm3Y8RGm8akVmd5RQ7tpr8XyKOcrP1Kh1irpqCysPBdN17j7xstz?=
 =?us-ascii?Q?ECmNc7vuoyEPnTe/8NGHJQTTdBJbmRhcdIq6+iH9aMPh0bvxNTHeJxgI90p5?=
 =?us-ascii?Q?zZTxWhSqD3Hu3JG6HTurdt0RnywFjB4joAzO64nAZPtRUubCCtI0IJTXlPYl?=
 =?us-ascii?Q?rBGbtERVXsw4ZOu6z8ohvOvCmK0dKHZp1to6A1G2JVbGU8AEO4Ryowfu2Po9?=
 =?us-ascii?Q?x2g6XOEccSFXgRz8qwMY5uBRnAiEJ2+ryrbj0jQ4I3aXiWVIRZVpVR+TVoQT?=
 =?us-ascii?Q?owRh4X7luDouZ8OTctaMMCe6Mx9Z4nqTb+fvwDClqQEbzqzJybzv0Glc/ICX?=
 =?us-ascii?Q?U3UfsMafZmlh5o5ga8gVsCpAwBOHzS1WZJhQklLwdImVGs43fsddnvPODNzt?=
 =?us-ascii?Q?afddEShPMMBYVa/1A3Ty+vsGsIxFt5hX5eXNQGToorknXX+qDm+pa0Ekp5Hm?=
 =?us-ascii?Q?XHLFVNcRUsdKgffHVbdN1Ac84N3zYIAWdmcUzJggzNmZa1IbG0lY90CkJSHy?=
 =?us-ascii?Q?0rs/S5MCHEGfYJNWxwz+vHX8rhJWo/K0XdaebQu0VmtPjDD0ohyeGgtZC9OH?=
 =?us-ascii?Q?HqHWbMXDFHuhuvjYI3vs3jf5NulOb6AN/+W1EhyGyEvPAg0QKMZAYY+WdjSK?=
 =?us-ascii?Q?wyN5XEDuzD6lL6TBUdaSkRwfNmb0E2NWVypKPfw8mo/3AwUSBG6d6Q1ShjqK?=
 =?us-ascii?Q?RRppMKCQDIVnQmVxCcsHRcLBvHnoWicSxm1z5268cj3DcIv/c+vzU+LG/kuq?=
 =?us-ascii?Q?tl5D8xJZjxmNzmjNdqYPhd9XqEXw1dygPANWwSP3VsFXT6gSQtpvWPheNoR0?=
 =?us-ascii?Q?23XoD6d3UZ/BFIzo84SP7rveemvZkYkK4DqAqBS7fiaE4PUbWym3fmU3OCXG?=
 =?us-ascii?Q?Sf1ldF4Gu0sulOF4VhXJoyjB8+ytVVVxM415eGodjcSOJgKpsaTXGiTxEZ2H?=
 =?us-ascii?Q?8p4VIyEBDaHQKM9gY44QsG1NWheKUjkfHTqeJOlWf1DXMk2SI+qYjcNfNdEL?=
 =?us-ascii?Q?7fZHGnoKY9ZsW7ZVmTE93CKqcJRinoZep/D27Lprw51eQFuIPlLtCW68G0GT?=
 =?us-ascii?Q?r9lCzFOMMHqP+vqTINgDz/6NtcuMPyhZ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f034354-11c4-46d0-f786-08df0d34fc31
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 23:08:53.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0235

On Mon, Sep 07, 2026 at 04:33:06PM +0200, Greg KH wrote:
> For all of these different patches, did you forget to add the required
> "Assisted-by:" tag?
>
> Please resubmit them all with that included.

Apologies! yes this was an oversight on my part, will ensure the tag
and other conventions I missed are adhered to in future. Will send in
small batches to avoid flooding.

Kind Regards

Aamir A.
