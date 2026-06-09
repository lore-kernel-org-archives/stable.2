Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43955379C32;
	Tue,  9 Jun 2026 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995600; cv=fail; b=ngO9+XbdANjiKjIWBdujz5r1sBXll4HlT1fLAd4f2sIlZSE59UJzLPmA8q40NykzFRXEB8UOwVfR51igQPUvqrliHQdr0Wavz+RjYXa12FLMRDJBbT/tgcTETR6YLpdz+wpZug6pD2cZycozGeOkTiHmMmF01VMWPCop7bpNIHs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995600; c=relaxed/simple;
	bh=KRcAilLO/NKjFMP6CjrLEfQRqGYFDpLNIpL0luCk9Kc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDilklOXjwEHZn3CluJYLV9KmV4FBV7VixHcM37vB4j6/KCE0ecmTI7eSaNQD5EDA1kyAJPapGi0Tj6nmz0NXJU3KTC7lbu7PwFICEkQTpf9Siep/2wk2ARw97TWWQHP4UHKFqIPdg9lFOn3TeRjXjjhxdMft82gc754W1gKPbw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=irPDcEdt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=irPDcEdt; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="irPDcEdt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="irPDcEdt"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rkEHLdsMEDbqmzRsttecHIr/H+oXVcOsN4uF7NLNoGhzZO3l57bOaks7sRALomncSAW8iVYW6AmTitSxhwtGMIy7r/NGGfkJWQkN1ly/1pCyI57t7sAaQT6v8ecv2ZrSdMsNLvJXOELe0K+fY7hnzdrVx754vvEXuYvEorn4F6DG45qQ4sHLpaMSdnOdx2mXuXEK+oLBVQzn2FDIgbQyqrOuWjdHsMTl0ggwTGDca/VeU47ij2VUwgHd78ll+XVFDYFqn3Ig7ihRPhNRqVSF7JnqbC3xnOyYTSuYO24i/n983PACf/3E7k0toOq/2El4uLjBYhmnd+2r8cbr9Rc9Ww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZiTcIzf6mchD+iirvn2EBbk408ewfHKzsbm0mbDaVs=;
 b=hGEFQRXvjEC97BjEHeajMt8xL0H2tmxbxgrCneG5x7mBBQfqnQ+En/7XWekJqboZTsh05wn8hh7NeB3KsLPlkXwOCxIiHdI0dLZKzj/42tqwnxMATXvmkWQQM+47y9XkyyEJKAyWpHNkatdyyTSWH/PRU5wY6I8hjiF0NM0dknXIplL5rngDh7JUQ6xIkWdMCSQvzTI5WMXI26hApawLjs5ZQX1qB4WfxLxyxnmTlTWHJRJI4tlGWjm5dIbUIgpy6aNSi9U9Q/svhafwiJy9W/ZDXr6swTMB5GQWfBJD1w2jh+h1Q792alA5nEn/2IAajElaNKCsBcqn6u5qDp+dHQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZiTcIzf6mchD+iirvn2EBbk408ewfHKzsbm0mbDaVs=;
 b=irPDcEdtPIz5fl7UYeixEd/3ucQzfY0ioMMl52ETeTFTnCASjk/IqiF3u8tp7l+VfpFMS/Ip8RnZ127fcq163n0nTFdRK9I5LZ1auhbK2swRR1io3Mp7rSfh735p6NFpbGJybVenLwyHtOlIir+Wf7idL6EJEMfjmwAGwsyP3zo=
Received: from CWLP265CA0424.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::23)
 by AM8PR08MB6546.eurprd08.prod.outlook.com (2603:10a6:20b:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Tue, 9 Jun 2026
 08:59:52 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::90) by CWLP265CA0424.outlook.office365.com
 (2603:10a6:400:1d7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 08:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Tue, 9 Jun 2026 08:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAwEVV5O6ahUXeQVvnkQRIWxXAZJ7N879DlGh+GfocwyM0IjpQ34hhdVew04VOGj4p0bgh5Ei+vdDVJmQn2H98ZvFyqQw/LIB0ImmTPq03pp/0ljHD7zD05cuR2xLWyQCWT0YBYPkRDYtbfHWDvGR3n+384BiYbchyST5Do0lQ5RzWWvf4ZwbjcEEwEuK5Iip5aD+X+/ptr6D9a8xvQrlV4PoCw7HurnAPmHDW4oNQe+/GWV45kDaSuKgop5BlNjM+Gmgmfup7UA/s4iM8cpk06+cgU4u6PeNl6mUO4W2ZES8kKQGDUH1IjRfu44UjS1QR8xC66FvvUJ2Ksx/vgQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZiTcIzf6mchD+iirvn2EBbk408ewfHKzsbm0mbDaVs=;
 b=lvkHcsyLKOTsnEHn7EAFKtNuLIsE2mj6aALTiCb40VcT9rFNIUkPYBJO1SwGr1MXSURoV/1UvljE0ARa3mfy3SeQ2rtoJ9PCAPag7IewjdUf8+ue5b+n9AtSOEg1Dy22aJYiG4y2QngTTojS8uV+SuXAydP75wzXjUJw01561Iz1eQx1XUBCZXag6ovWG2l7Mm/gkieQP5LSvzfhu9v7Ft7DdAp5TIBoyHKC8hagXgA9vnTuhrwfmG9ilPuaOAElRtgU5u/HY1Ctq9qaj7c/UiXY8TlKd1a8mOyIUpFoG5TaSDh/Hq49Msyexb23QjaJpV1DDmggzbWcufij8V9Ccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZiTcIzf6mchD+iirvn2EBbk408ewfHKzsbm0mbDaVs=;
 b=irPDcEdtPIz5fl7UYeixEd/3ucQzfY0ioMMl52ETeTFTnCASjk/IqiF3u8tp7l+VfpFMS/Ip8RnZ127fcq163n0nTFdRK9I5LZ1auhbK2swRR1io3Mp7rSfh735p6NFpbGJybVenLwyHtOlIir+Wf7idL6EJEMfjmwAGwsyP3zo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB10975.eurprd08.prod.outlook.com (2603:10a6:102:46e::7)
 by AS2PR08MB10180.eurprd08.prod.outlook.com (2603:10a6:20b:62d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:58:44 +0000
Received: from PAWPR08MB10975.eurprd08.prod.outlook.com
 ([fe80::3c7a:9a64:14bc:ce15]) by PAWPR08MB10975.eurprd08.prod.outlook.com
 ([fe80::3c7a:9a64:14bc:ce15%7]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:58:44 +0000
Message-ID: <44f409a6-ce8b-4fde-a86c-b1ecfb307bfb@arm.com>
Date: Tue, 9 Jun 2026 09:58:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: etm3x: Fix cntr_val_show() to match
 cntr_val_store() behavior
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: James Clark <james.clark@linaro.org>, mike.leach@linaro.org,
 alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
 mathieu.poirier@linaro.org, leo.yan@arm.com, Al.Grant@arm.com,
 jserv@ccns.ncku.edu.tw, marscheng@google.com, ericchancf@google.com,
 milesjiang@google.com, nickpan@google.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251202082613.3265761-1-visitorckw@gmail.com>
 <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
 <aYAxbbkHslAP9RBN@google.com> <bb521240-ab53-4c5a-aa1d-6b140ed4262e@arm.com>
 <ac-BEX0Rfe9RBJJn@google.com> <aibz51FAJG1neRg1@google.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aibz51FAJG1neRg1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0322.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::6) To PAWPR08MB10975.eurprd08.prod.outlook.com
 (2603:10a6:102:46e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB10975:EE_|AS2PR08MB10180:EE_|AM4PEPF00027A6A:EE_|AM8PR08MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dec6991-e16e-4e59-e6c4-08dec6057822
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|6133799003|22082099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 6YHgtGS/hSWWEU/f4otJToj6no2M7dkZQqph5RzFe23d5GLgedqi1NphA0w84k3cF7alW1Y/ZabMRHW8TYNsiyNg22z0dGC310irBqhmtH+GIzAsiG/WAUuK1DyCA7/VyxvcKMDkXKCuVFG/E6vEvZYwAvmvyqnd6Ckl5Gr2Eou9VRU6JGkX2HTR7Q2UlsaHzQOMRA+IqAKzgpMXPWBIbCOBKVInvAaDGhftwcglUsJR9mxgevuBvyzA7O8whHwH7JQMnwUKpHppK6WnqwV8ejb5e0lmWbvgmQv9iD7Wm5Btyqi1ug40FZLjXfXCkhpdoVY9qAf1gDUkRjBqv1Kn4oJM8E49ok7MqPDISewbrt2OzzI7cQj93KlIZRrloEWAdFXREmu7qQkDVunTW1YERSpMH2yX+kXiNlvbmEZ4jd4OIHYhGG4mZ0NdKs0cfAhA9cJZtW15G9z9bR2temvS/0Zl/MxnOxBzO6RMYRKR1/bmmZPTlwvoU/QCtJb4m8tNaKDO1v+YkQSmeiIzM2lgYZe8xIKRLvcx9cPJ4iZhEw61NOTTM4C1zrIEXZdfkVm9OwKNWibtIr0AA3Ia7giC2toGaOdMhTQ14jk9R/1y66zbeZUX9jzAK8cqO0hwsgoRc5xVXeR2Jbh7C7VRuhup+GsSQI2gdoDk1EcFtamNYEDTLa36Zvpw3qE9J0VjLrploXwOTfNl/Zue5q6ioU/8nA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB10975.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(6133799003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 kGR/4MxI7paFdG8pT5BzAYFCGEhr11rIp0sPSmienQuL9sDCnVyRMxIkCUWOFzpIwFnzjH2XAJYr9A7M91RUP4+JuvFnvmNsDrV/mi4QXrR4Pi75MTBWWrxYrUht2wZ5YtgWsGaHt7B/CGJI3Irfp/ktNKMiQtG0+wcxWlTMBqVZz0XtuVahkdYc4nBGnW25nnwsbYIKQNTF3Gk5Uhy8IQYZchoIWdPAXElrKAAJq2NqqpMlOq3qexFEL+aXSWmSLpSVlE5mC6Y+LAnRONruTknqLqkrHcBe2j8IvqFgJNPJlAgx3WMfPoFu3YcEJa0f5yu6eCF2+48iqaIboxMmPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10180
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	72adb7bb-d727-40fb-0a08-08dec6054f7b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|82310400026|7416014|14060799003|1800799024|36860700016|3023799007|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XpESv6u57XhfHG5L+zvgN0UmWTztDiniKRWgQWYZ+YAFpk6WbIkJlFvL+V1w0JlZNxNVU8m7cEWcMSfUXlZxkQkXe7LlXUGbnQx3QY3Q6GYmiEfpZfrEzZQoofIcRJ4Y4WsMamsv91F+IBxMmmEQBEum+pktL36tCuS/ixPO3U/XEebFw0peB8S9N/Z+ve8VN95FGDe+Z2eHdcTVH9TWjD+BRRYxRxDd80EHMPyiHuKCEqlZ0f3CNvaZmynTPYfoSO8KvX1tX143XZHwCKu5riyIH5F9MviiEipqtwsydADRxDRR0bvSaWl6+cWqBaUDagGMj+GD4nWzw95uZMRY/xazTqG5ecnMykkmsslaWe41Nm9rRZ/7okbsqaQnN8CTVp86XqgGrmTxE6zTtNFXkEdmYdRRfmAw5knUIgMyMnIFAXxQDIANHY0lcs662+6CvO6Vkxc0TzExjOCa6Fpu5qlnF0c3kj3A8rBknbMpZy3ZrDUQXIDOjifHe9wGwjfZotEK6RHEhssKMiu2CV0F3avfMNSsIcrE4KxGhCEqBK/ycLPPKgA51DPYImTQ9OW7iUI/tBxIfNs6ULA9QMffKtDc9Vrey1/l1A8rLgmWos5SwBbMLqp86ct43eGelxpA+knJJW64oh7jXgyLCDwa5v9uSr8XsefuMfIGP8g/I2qMZu1fecNEyB34QLN1KptzF/E5yb9cfkblDM6880t8UDJyemSX6pkz+wfobMF1aHE=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(82310400026)(7416014)(14060799003)(1800799024)(36860700016)(3023799007)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5CQbulxAPTNdb7jVM0EfWHpnir5fqf9gsb78lZ4NOgnELzBdlLs+IDpgReOuQ50ijqjjCyPTDEJf3sJw5MY3dyOMIl6ek+YjsgdPK/HLQgasrgkmVl6gA8Gr94vO7ICvtX3gup5+M2eRHUxd+8LEY+qHzIMl8OLNVXIItXNz+MKVezI219ZchssEJMZ0SfiRMDMOaFxPeKhMu9xdmPuwokySDbEH/TJ+nf31ZAKGBq/xWJZ/gMosqoJ6uB7E06FwdSeQkG8OnMPtNxbg8x1a0wsMS9FZSr8aX/dX1h1iSxRmPOI3HVAURAaAb2HSqJS1WfHnk3eBV/pcsuWL5VkJroYjVa/66L+daP2ekHAjS6LpVnvPllLKGcb8NMZUK4dASt3gCUYwREN2j/fYoL40fU91wq5HTpNSvW0QaD40fKukTBpBM9uBe51XPVEt/+Sy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:59:52.4922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dec6991-e16e-4e59-e6c4-08dec6057822
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6546

On 08/06/2026 17:55, Kuan-Wei Chiu wrote:
> Hi Suzuki,
> 
> On Fri, Apr 03, 2026 at 04:57:59PM +0800, Kuan-Wei Chiu wrote:
>> Hi Suzuki,
>>
>> On Mon, Feb 02, 2026 at 09:33:59AM +0000, Suzuki K Poulose wrote:
>>> Hello
>>>
>>> On 02/02/2026 05:09, Kuan-Wei Chiu wrote:
>>>> On Tue, Dec 02, 2025 at 09:26:19AM +0000, James Clark wrote:
>>>>>
>>>>>
>>>>> On 02/12/2025 8:26 am, Kuan-Wei Chiu wrote:
>>>>>> The cntr_val_show() function was intended to print the values of all
>>>>>> counters using a loop. However, due to a buffer overwrite issue with
>>>>>> sprintf(), it effectively only displayed the value of the last counter.
>>>>>>
>>>>>> The companion function, cntr_val_store(), allows users to modify a
>>>>>> specific counter selected by 'cntr_idx'. To maintain consistency
>>>>>> between read and write operations and to align with the ETM4x driver
>>>>>> behavior, modify cntr_val_show() to report only the value of the
>>>>>> currently selected counter.
>>>>>>
>>>>>> This change removes the loop and the "counter %d:" prefix, printing
>>>>>> only the hexadecimal value. It also adopts sysfs_emit() for standard
>>>>>> sysfs output formatting.
>>>>>>
>>>>>> Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>>>>> ---
>>>>>> Build test only.
>>>>>>
>>>>>> Changes in v3:
>>>>>> - Switch format specifier to %#x to include the 0x prefix.
>>>>>> - Add Cc stable
>>>>>>
>>>>>> v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/
>>>>>>
>>>>>>     .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
>>>>>>     1 file changed, 4 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>>>>>> index 762109307b86..b3c67e96a82a 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>>>>>> @@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
>>>>>>     static ssize_t cntr_val_show(struct device *dev,
>>>>>>     			     struct device_attribute *attr, char *buf)
>>>>>>     {
>>>>>> -	int i, ret = 0;
>>>>>>     	u32 val;
>>>>>>     	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>>     	struct etm_config *config = &drvdata->config;
>>>>>>     	if (!coresight_get_mode(drvdata->csdev)) {
>>>>>>     		spin_lock(&drvdata->spinlock);
>>>>>> -		for (i = 0; i < drvdata->nr_cntr; i++)
>>>>>> -			ret += sprintf(buf, "counter %d: %x\n",
>>>>>> -				       i, config->cntr_val[i]);
>>>>>> +		val = config->cntr_val[config->cntr_idx];
>>>>>>     		spin_unlock(&drvdata->spinlock);
>>>>>> -		return ret;
>>>>>> -	}
>>>>>> -
>>>>>> -	for (i = 0; i < drvdata->nr_cntr; i++) {
>>>>>> -		val = etm_readl(drvdata, ETMCNTVRn(i));
>>>>>> -		ret += sprintf(buf, "counter %d: %x\n", i, val);
>>>>>> +	} else {
>>>>>> +		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
>>>>>>     	}
>>>>>> -	return ret;
>>>>>> +	return sysfs_emit(buf, "%#x\n", val);
>>>>>>     }
>>>>>>     static ssize_t cntr_val_store(struct device *dev,
>>>>>
>>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>>>
>>>> Thanks for the review!
>>>> Is there anything else I need to do for this fix to land?
>>>
>>> Thanks for the patch, I will queue this for the next release (v7.1).
>>>
>> Just a gentle ping.
>>
>> Since the v7.1 merge window is presumably opening in about a week, I
>> noticed this patch isn't in linux-next yet and wanted to send a quick
>> reminder. Thanks.
>>
> This patch still applies cleanly on top of linux-next.
> I suspect this patch may have fallen through the cracks.
> Would you still be willing to pick it up?

Apologies, it did. I will pick this up, if we have sufficient fixes,
I might send it as fixes for v7.2, otherwise , queue it for v7.3

Once again, apologies.

Suzuki


> 
> Regards,
> Kuan-Wei

