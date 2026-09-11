Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010019.outbound.protection.outlook.com [52.103.33.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3E4A64CA;
	Fri, 11 Sep 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145870; cv=fail; b=FRoL7BXUicDINT1oSl+Q1QUguE8jyyHBpwjfl9p65hZfG26a28cHBOXZR1oGXSS2pY6KQK3A23ppEM24kelBR06Mm3c9YEZBDwtsDDGJu+XEvh/EfkAi/YHTXHF03L50Up/nN1n0pR0u6h0VMZsjOJnmb4BOluQxi7GSoBh4LRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145870; c=relaxed/simple;
	bh=sNj3YXJBtO2BFsgpSbTWbzqNUd27wh6rkL9TKTLZWYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uvbrgFL//75vVZ8h3c1rGXSKMUrQpj9WjS0YAnrSXh8GQwR+uYyziNhFkJrs0sJH18xibLAVELkuvU2lNZQSzutjLNiv+iK2DnfIcWXWO9Pft6n0SFtj3gPi+ly0YQjkHTTfqAfwXdUHjVoHZEqdG4vwYUcY1/NieI2kEQik1D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=nfKgWFK2; arc=fail smtp.client-ip=52.103.33.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="nfKgWFK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx5GHAbsu0lpTjqqJi32LPDFQq2kXLcnuooM+IwblzmfrgeX1VyHDRHyvEtkas0WvzYT8vI1xJWsTKa09mIZFVEzq7fhmYCeX0Sn0Hh6Rvb18oDEdlxeY3QrJMkS5ZVDKSstgfWIZmfiwIqPW1Xz4LFCmJWiTxFINDkrmaN5yAyh09yAAphSWrctcJn64kgBxoisCsYanyJbKoxA9Q6cMkZHD9yA+eXqjuzHb9MlbmuowItaJ3bedAfpAiAlVW7mBLt3Wm/uRFc6q+0VVhNgE1e/Cs3FVgVSWz9hck+f6tcNuvyRh+fFpRSCZ0pvfCkEtx1ljX+ZWsKV7v4BUhPXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaCl+XJ61t/PMM/8JSW+UN6JeU6scgnEIy3cEiqz/+A=;
 b=d1F+We/9tWlj0Aa/Dos/HJ6TpiXIK1h/cyJVvhPW8mhGP3tEfX/4LySsYlIxgmBTTYgTX4ExU8/AfRdljhHTIcL1sk0SteEWvA7q2XZ+arRzT1GKKlrUiW9u1kFYEPo5gpPXUQlModZVuo0yotRMrq2f+BkjqR91EKUrOnMir9IVE1IrNbA4Hr0VOrMx/JUEw8Ns7nh1u8SkQPQ6qYJPN0poFG7wbe0OVm9OljYQcrGRyQA145mlVLPaBEDBVKqBym/f2AVpqpJIoZq+wxJKsXOtUrEFTYx4JEzo92FgNXrtarJSj5cPH7d31hITp90PilLHT0NngEeKo/gX7EvDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaCl+XJ61t/PMM/8JSW+UN6JeU6scgnEIy3cEiqz/+A=;
 b=nfKgWFK2nuHbDs3Y28zBZlUdlbbyzS6I/RSfMzwqOxX4L5Pdg60pHGjgkWDDQ+iaDDWYmJ3up+GBvJAdERRe0o7LKJybnrQo8uHKRZ7DXbeeQNOGvYM8DB9btspZMGVfWqtM3d7bFM7uAyAIsXepKRfaMh/Nd2KDMIUcip5hbfTbtKXyvXYVbMhdrbAIA9jo9AZLQ78Zg82O2u85AuV3ajqP+4O5Ammfu8iUrksOMipojlERUWT8glfwntpkful0jlQJvsgnjiJ09ZMYk+8SX9TmlpMQH2NvkTQYtR/Kq/Xirq6VkicVUp3hBTO0qspJ6i0OZVKdDbKbWtDjKQS3lA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB0013.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 16:57:33 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:57:32 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Guanglei Zhu <zhugl3@xiaopeng.com>,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: Re: [PATCH] net: wwan: mhi_wwan_mbim: validate datagram bounds before copy
Date: Fri, 11 Sep 2026 17:57:30 +0100
Message-ID:
 <AS8P251MB00011DED0BF367D3BE6F6C5AC8BE2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <PAXP251MB001088904166C3D6EB0025C1C8B12@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
References: <AS8P251MB0001E25A247262552A62241BC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM> <PAXP251MB001088904166C3D6EB0025C1C8B12@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::6) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260911165730.53676-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB0013:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d01639a-c491-44c0-bd50-08df1025c56e
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+6TxoHw5fNkboUl/ASnSn2+A8PAYf9HVw7h1/+GCkgzokCeZb/V3nJ+7SnMaBayV9xDYLAMAJhVerwVsSLfKFQUPIs1eW2d0G7DfH7XOsFG829+XqS5DCCY2aERFwfpdx7zwJzgPs5T+68t1+g2lFNpv52jBrfrJqNB3c/P7tIirsP5QBfN0KfETos7mLlLxBJRqJh/9Zqj0hih/xsGxr2FvqHrRXuGCKco57IGWfnBH8h1rZVwL4tUlD4/HCB+86HzDdXZik/ZUMeVMGpvdxtiS0q7FYxuekIZ4j1eHxvvnriXz4iTuUSxYnX0kPorjxewuSW1Sbkja+4eWkDSiV7mWEE28zWD3+XtE/Os74mL2IvDJ6ReTADQjYCAge2CIPWse+EXmeVoBVJiZYqT9uhn+PISnnT0XYek7hiKJWRyyqYoMrzoioGd7dFKFthLQHmbq8DH0QhVIqCqIhvpkkROhzSVvfcEyJ0jUPfvdZdahB1fQfCPq+nw9KIzEVjamF8jziC+BwRh9giT0n8AGsdkgWaMleFpTFgNDo5wyXpKYNFc9yXHFqBtoXqXZJ2o58QZDlsz6r3RtXwI4/XF2D7gKo1ysdBe62CRmfnJ+euByJZ824VcKDM9yQNt/Sw7J54ds7LKvQK5MVcXmWth8nh2rCd8+3lad5qC89FVmdIjUF+DzQZ2nWkM6P77YlQy+Cs9UkAzOoaul974Rvc6LAeuwqkN9y4um9DcDxYAcbxsWgpITgdKIlHJarQ84SO/Njxdlvfy4e2sLeA95umV7AqDUl1ch32o50gONg+fBo8fsYdYtkdoZ99
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|37011999003|19110799012|8060799015|24021099003|41001999006|51005399006|15080799012|23021999003|55001999006|25010399006|25031999004|5072599009|4140399003|40105399003|12091999003|1602099012|10035399007|2607281247196008|26104999009|4302099013|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUrBOmpuclNgg1Y4URlg5zOI6VQ4t72IuiMhHE1944SfoITFwgLQDPpHb2no?=
 =?us-ascii?Q?rxqB+2vjbg3scFdI8lOm9XGc5g01SNg/VK28H81VBUWz7kR6IL4lcDwkqpdZ?=
 =?us-ascii?Q?OaOPblXCXqzwA5ZPOJ4lrPe4skivCjYC875+viU6l4XE6MJOpyuIxFL9lvaq?=
 =?us-ascii?Q?3+PvHLkozEfDu3bnsmnb6wUjrUckcV2bRgo83Xf4cIfxhMAt0EXGQ536m+MB?=
 =?us-ascii?Q?qimuNafPHqCbjac+WM5ikIweVrIbN6RENv3kNKDjBFtLot21w+KS628rufWM?=
 =?us-ascii?Q?JYzdu4G2pZM6nNGpbbFZsiuoHAbkudSsYkH8LVgWrLuwGrou6hiQvv8r47GA?=
 =?us-ascii?Q?IkK9nTsiITGlfBeCrNEEKyz7Dr5sCx3vL/xXW+OpjVdIRl1YjBcj9RiEddyr?=
 =?us-ascii?Q?TFrkZ3XSziHY7REYiI0JF5jGc6lYHLZUTR8h7zmeH7AncaZQL7DkIVXPLR5x?=
 =?us-ascii?Q?yab+e4xCKFU86Oas1RIVTO7qDh5bKucACfI5ZI0Q9eDazPM36WvQqKR/VmLr?=
 =?us-ascii?Q?vCtBO16xS2W+ghKCJOPhdtbSBEgeaXM5Vh4wCdDn0qJgtlCJnoa0595YnlPn?=
 =?us-ascii?Q?iJuAbN8KknSH8/EUMryWJgWug+89wMRiirkki65Q9n5a/WReRj2w88GxJ6m4?=
 =?us-ascii?Q?AM3DRAqLILZH5QvoKKheKgp+/6ynSLeqUE/EwrNvnQccdFJDYf6FdaFCdzGx?=
 =?us-ascii?Q?ddm2Db47AJY3Iri+/IVZqnKMsOb6IaQXGHTnWVD5OHBylbUtWA8pHhux8g7T?=
 =?us-ascii?Q?tK5JugICmIOqsZ0y5gC/EP1o1SJ9JgQHZvsBGFHqKM2a2dP98TLEvyEvXF+y?=
 =?us-ascii?Q?TyO7ZBSQehKCpg3/rsIcspB8se2ORyzToJ3k6uTHuaUAYHKYV6koMS1+kvOV?=
 =?us-ascii?Q?kCJef+FTLAdfzl3xD1oy2afMYGGLngVy7lVG4yadZcgf5S+EaWeNVTUZbLll?=
 =?us-ascii?Q?kaafNfJYsKlzZMcPumtP9PIEPGLJMdZ2k0SXSrpltffweRrgNvIF4Wk7+L6w?=
 =?us-ascii?Q?MsNivMf4tvXX/fBKO+AGOwSzeUhsc8Ghw58c98IybnU1utZFMF9to8x4A7RI?=
 =?us-ascii?Q?xDfCtSsFBa6lzMz7738XFf3ViJaRfevs0F6RcRT4L9YaoCXOwEkOhY3SKPjB?=
 =?us-ascii?Q?eG13H800NJEsaRNYSbbySIh0PF2MMCiFYWZ7QbeSb15KcCh5Seo7VTt17hWe?=
 =?us-ascii?Q?j+3xgX+99y+XHIPscIxVbBZOPL9eO8AjurVJS6a/qwBW8E1g5YrWZC0SdiZQ?=
 =?us-ascii?Q?VGjBhxiv0+DJ1fF9j3TG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlrbB8qWIcKKGrLUiqX3cCIfXRic/upQyhikR/YfWQq/KIEcaLh+huFIM//5?=
 =?us-ascii?Q?R80DwJpArFOO7iXTrwnHmxyMHwUUC2xmcAuRia7b588RmtJwHlF3KhUeLc2E?=
 =?us-ascii?Q?BoYOJf+3W97T9M6wMsKjvONjZQPd9sXcphiJ1Vab0UwA4QrAHd4DiD2WtgfT?=
 =?us-ascii?Q?WHCo3SEoAgJQ/AArHgGPt7mdg8WfOeox1Xy0ZbDlNy/zSNocHqvxHgdN82M1?=
 =?us-ascii?Q?G5eqfg/QFm4u9/Er/D7MPADvwc5NmHEynpCRw5nfrePQCymzGvelqlGF04l+?=
 =?us-ascii?Q?IN7czpb3hxqvhAcFZVFWIlf37KGIVN+mqdT6t++qrlJyhU/NuVfUogM+G7zX?=
 =?us-ascii?Q?grQsHhmAw53WFPC4BNGoe2tg/7FPiYCJz9CEiklrMVUUVqRb9VOfXyztYnqW?=
 =?us-ascii?Q?MXVW4iH3NVyQAqhaovi3em5Xk5IdK7SUFA7yW9k0q43LPCmDbsFBrTTRQj96?=
 =?us-ascii?Q?gmvTBnAREi3qjfiaBWKRJnXJ9xsuwMBkfF3GgMKfxN5VmW1tRUhrhn2TrCC0?=
 =?us-ascii?Q?518vKrrXGmuxzMma9AwvB2zPl1STPULqQrRCiWur3/D0BPxHf3DG6Xrb+tI2?=
 =?us-ascii?Q?IpcCw2pjVE+gFIzQuFAziUWdNVv+9TBX+tA/FPRUx6k/kpoDhb0462y7U6cZ?=
 =?us-ascii?Q?6z9B7AnQriihoqkKCplTstWgKQjymzwSNlMY2Uw5bp9Qemu5b1OEMXW98s5Y?=
 =?us-ascii?Q?o2NBCSROwJG+nZJJTPLwdTHRwEtHDzABst5W4zB6mE5yZgAdffGW+dH8KeiL?=
 =?us-ascii?Q?ULAYbwd+wxmzThLNwvDULtzJMcSvl//PBXtKMSzJdr6FDTxudyF1OahNdwX2?=
 =?us-ascii?Q?zP5wGKT0BLIRtT0WCByJcJMEEjWe4PdbJbDDLZNuECsSE1LSoERGlYOWmSAt?=
 =?us-ascii?Q?aa7HyuS+Y3IST6ZqYbJ7W67HkNaC2jzVE8gYOe7fWDuIplgJ2P6kOuN2zWV6?=
 =?us-ascii?Q?9ZPcAU3avr4y3vC1oUwzWya/aKMD97vUJVl0h4aHVluuxA7EFtwSFr0NoNRw?=
 =?us-ascii?Q?57/Aki5qFcMYKcRUm6u7x5d7m8xsaBskRIhttAToKxgf22uWw0KnbUuC+8qv?=
 =?us-ascii?Q?xvEnSGGIOlo3AyXIyvUsD8M+uI+VxvAoGC6gxG/JFYbQ6937G+pxtThCiSrb?=
 =?us-ascii?Q?ZX25PBNGSjklT6rK33a2J+EKfG6OBLC6BHHRpRMIh42k4GOKHpOHnKfKwvsf?=
 =?us-ascii?Q?uWP5rAXu35v5iu7IFkXpwVNjfeqKa0Vteasqmxd/l095a0EFUbUSCRxmLdhT?=
 =?us-ascii?Q?nCxtOT6AzuEdwegRSd8L9y1bez39TQmleR2ngqm9JuAgVwUV2TvzAJfaOUUM?=
 =?us-ascii?Q?P4w4kpNRWZ6kQs+eYzk4dMNWIA7+2VW/7w6M7ITPtISNyQFmNzHEswQRPkzS?=
 =?us-ascii?Q?etDUyxfXT2XlKHWeSFU9Wu43ck0I2c7fjhoOH5L6QTCP9Zru1jb4FubvfxG+?=
 =?us-ascii?Q?8DeUG9aKkcrJKSWh0UNR5MG2uCcWBU6d?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d01639a-c491-44c0-bd50-08df1025c56e
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:57:32.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0013

On Tue, Sep 08, 2026 at 01:37:32AM +0100, Aamir Ahmed wrote:
> I will prepare v2 to check the return, free skbn, count an rx error
> and break, as the copies above and the unknown-protocol path already
> do.

A v2 has been produced here by Guanglei Zhu with the above change.
This can be withdrawn. Thanks.

  net: wwan: mhi_wwan_mbim: check skb_copy_bits() return value (v2 2/3)
  https://lore.kernel.org/r/20260911021734.1396599-2-zhugl3@xiaopeng.com

pw-bot: rejected
