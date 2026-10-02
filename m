Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67113DF59;
	Fri,  2 Oct 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790907319; cv=fail; b=gYciqS4ZVHppz/na81cNCGbe3ThaqNGMK4Nit/W124PoovcXEXhN+ZFCE8VvkR8HQ/+fHQmFwWidI8HqFuSdSmMnvxc89eXnSIm0vq11KfEKrF2hviTm6HYi76gUMqLfuPB9nxWid4FwoIztsJNVb4Qy9v1EfYfYoY9CNoaPZZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790907319; c=relaxed/simple;
	bh=LDmaVbpGX/zKmjfDrdqdkUZx9zv/cE58bWtopqRXZQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ij2K/dkJALTk4CmYAfVc6YNQTH/aHlbr5vA+gPbvXW6sbE2G7IfckM9k+ZpKzADLP6ew9YQKvTe2NaaRp7fgOZLa6I1r462FvhCQpg86MLzg4aGwOD8IobiIGoDQ9HrvlIqVj57m91ayxywrWxq1ifco5BCLUkeGOL4aMUFIrNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N8x6A7en; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L0ckZwf4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KC6D1SnA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N8x6A7en";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L0ckZwf4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KC6D1SnA"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691NFsC7350896;
	Thu, 1 Oct 2026 19:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=LDmaVbpGX/zKmjfDrdqdkUZx9zv/cE58bWtopqRXZQc=; b=
	N8x6A7enI8o+maCAsy85pHo9E7euK7j05CbwPtIT9mlVLXnmHmg1nM+WqSsngJer
	T3cVexfNQgeg6NYa4A7a6MLoLeZSPC7NZxXQWifHNoqAfuOfs9QjxydMmsuhR4CS
	/HQGpazS7l6XDNZ228NYY4Z9XOZlCDkCsOHxmLUOBKMaESZRyajuLH41wZBw5Oyw
	ubsXu9n/BWVAgX/X1qitxWCqmOPhdqVAIArRouUaY/1pT28P1ruxZ/QChO+tCSOf
	RYDB5i3yUOeUpklKlFGgUkJx+0+83pmikfmj9kD41zT14r4smtiXSDt4oJhoefre
	af+pa2Pm6e5k+lXsmAFPmQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4h1dfy14bp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 19:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790907309; bh=LDmaVbpGX/zKmjfDrdqdkUZx9zv/cE58bWtopqRXZQc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=L0ckZwf4kiRS5BraJazKi4II1LNHNse/059SxTxmV71qZ9aGJvIqg9L2EPhIhK7Wc
	 tZBEZq7Z0lUOifYqR2j8OUlS9W/qOAxOYLMAsmye8qORtswfW7kSZC5/X9yTVwNaGp
	 MCieFUjhEqlS15dgAX6M84n2URrWh7j/bOjhZsi+YTH0WnloH2oZY+qpsjPm9TgUeE
	 Ir/r0vBMRqP5m+7hgqc7gzjabXoGSR79VYfjw19klmPa50KTNv3ofuxg2ViNu+arQY
	 R0iI+yMkgvpsamhdbDbseAlcKGTU4bqtFy9MGq8xpfHohsTf3gLdUY3BcEYJqXHl5u
	 VLNH7BZgrf7KA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 596284014A;
	Fri,  2 Oct 2026 02:15:09 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9FCF5A0079;
	Fri,  2 Oct 2026 02:15:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KC6D1SnA;
	dkim-atps=neutral
Received: from SJ0PR08CU001.outbound.protection.outlook.com (mail-sj0pr08cu00106.outbound.protection.outlook.com [40.93.1.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D1EE940409;
	Fri,  2 Oct 2026 02:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcvRfY92R9bjwevzgc9NXVZJXBzkToqyqRL9VczrpX/ZTH3SElEvk1kb9KN8mDueLiMJActrDDe7FOQCIaXUFATA7NZGEWt93ALiCefbtXGr/BGydkNflhzydKJJFcnfAY2OKRMAH4J3tnvEf/rOpaGk+BEEkx69u+VOz7aqCbJ8uz0QfbPxrIatW8S7xrXLo6oBIHQNyfX+zM+abzz7v/yvicPpkLDE4RZ0VDPvAPYSsuMfcNWy3Lnsl9q5auHajQk5kcoY10Iy0hUuIg3BfRNHUfDFQ7i20MgR0SqoL4OW6BUMCNigprnLhatpyNv+38fXUvTi1w9tGiiuraDvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDmaVbpGX/zKmjfDrdqdkUZx9zv/cE58bWtopqRXZQc=;
 b=ulKHyuZpMdBN31wqZhKKA98XElYYw7zXLji/IHvFfZSx+tsTvEFDNkeGeVOYjb+vedspH9achaRDD7tiEIw8dSc8KNo9cxqgzv+U2b6Rfwbf6U9Gz2HThh48sdRMAgxZyTQYmAyrybjs9F4s7F8Cf9ywpcQbMXiwIFgQO+qncNN/4GbachBGSOTKlz/yR/ib5Jycpz1oCWenj+cOgcMxv37Ld6ttwugk4/2ct0KX45XCVjEWhxz4CtPirc7Me9ffFrRGykHBhRoNHc7k04Ph04dSRytQgGM27eq+BDyC+8Ea7rk4xIl1Dl1ebZeskGH7QshHoQ/EFsBFE9DKLHJehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDmaVbpGX/zKmjfDrdqdkUZx9zv/cE58bWtopqRXZQc=;
 b=KC6D1SnAdQNac+RzjVVDeM+Z440w5RDyNMyGXo6E6XBv21TcJ0xHznhBcxfq4h8LyCe/5MhH2rZ+rrXw1QAzyKNqgnToJjm6YkNb3n720wGWowz38eX28gzVwh8jrIAwl3XGlLCQnU7snOW1FdlbQdyUzu7X45Wm412GJhEj2WY=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 02:15:00 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0451.026; Fri, 2 Oct 2026
 02:15:00 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] usb: dwc3: xilinx: unwind ZynqMP platform init on
 probe failure and remove
Thread-Topic: [PATCH v2 3/3] usb: dwc3: xilinx: unwind ZynqMP platform init on
 probe failure and remove
Thread-Index: AQHdSr9KoX3T2SSZM0OlE1tyYqfrvLbpkgGA
Date: Fri, 2 Oct 2026 02:15:00 +0000
Message-ID: <ar8Te9BLqIxOC2S9@vbox>
References: <20260922182125.11067-1-radhey.shyam.pandey@amd.com>
 <20260922182125.11067-4-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260922182125.11067-4-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM4PR12MB8560:EE_
x-ms-office365-filtering-correlation-id: ce761632-e811-4c83-88c4-08df202af639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|5023799004|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 PoEUsKjQymgUhbEMpv6b9WEh2vwJUKkAzHbMQjj/W+i6Wiws5TYFfFCDEPHslpsDO0gvMK6AQ5pAU5b0NmshfpFWIgTXYwTpq+wuu8Olj0gxZkiAx5Psft/INb/Fng3+YDnvTLUXbZWueQuRtYcgjNEEf7OBAV/ttxiFFEL5M2EopAI3bQGStklNX3E05XeDbjUNMRCh14rF/9PqvdfYACXA8gTgCQU15JHeDyMNGRD9aKlEHBBIKI4TRlSrjEShbnvnnnnmTHLwCwzvOSfdGK/FDeSG1oeW987h1YgvHFr33P8UcAig/FXB/lLJwROFAZbfZy/uRokNfJREM+/gzryiuhnXJ12Ve4g1AwdWp59TRbM9y01kghOd2oTZIQy37vTnze8m3mscy9pTnXe+QfnOTdvnrSI21RFjqoxfepr+NBJsE3/VEgXNVFhEB9wBq71HV6qqvu/QL7MgoLul7JTTHCVwSbXu2XjCdKH+3Ozc27ys+D6jfR/A8z8NUDzkZZ9gxviaP8xPLmijYDkJiFaCMjAYiSXdbdLST+pH3yOtvRvKUs30wLhbt3oZ16D0hnbn0F1Dzi2kH5E9/JJP4OK2EVOFErtCTlyfulgh+K47mz1hA1QjAN2p79yNH/HMRQ41FCeSV1kCEQA/tbDsdkEiWslT7X2kTcZez+CqoJckW+vrYGmkFu8bui/ff6I+HLx/3rcCSyyMmwye0FraLiUY19ou0pUlEErnw79UK1Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEhmQTVrNzM0ako2a2hROXE3R0VsaDdlYWZrajE1eEl2dTdpTThhVWg0dGFt?=
 =?utf-8?B?QjU2MXBWcVRCbjNzQ1ByNU1Edm5uNXNaZTVYY1Y4U3VZZjQ2dElJZ3JPK1NW?=
 =?utf-8?B?QmExcUJ0TWg5L283R010ZTFPS3htUFVwMTBRQVhiM3dmVkZiT1liVytJTG5o?=
 =?utf-8?B?T1F6UGxOQVptQnJiRWs2QlJpdnAwZkQ2L3ZTR3kzV2J4aGxTa2U1MFJaM0lM?=
 =?utf-8?B?YTh6aHNlcUtKektWWE1ybnVBcVN5WWhqby9lc0ZlZHpSNkNHVU9LdzA1cnVU?=
 =?utf-8?B?akVPdnEyOU5QMDJxbWE2N21hTGxGaGxwTm5lcXR4am9sQ1R1L2J0bUpUNWZ2?=
 =?utf-8?B?Zlh5TDFTTlN3YU8vUFdnaGZXVDEvcmE5V1VsN25jVzFzV0s2MnJYdjZhSVRQ?=
 =?utf-8?B?NEhnc3FhdE5MU0grTkcrand6Y0I5bDVmcVVKTEJBT2FQRzBnWS9JR2x0VVQ4?=
 =?utf-8?B?Rm5UMDNMd2ptWFM5bFBJN2doM1dlTFFEWHY3dHlhRFdGZmFtMFBIVy9HUVky?=
 =?utf-8?B?b0RTLzEwcitHdStCTExLQXByUllwRytPaUcrNHBHcFBCRzJQSnJ3ZnFmOEtC?=
 =?utf-8?B?L3hFZE45K3FRY3JqSHBNUFg5VXlpTURyelVaM2hsNXVPeHA0NFdjbFA3b0ph?=
 =?utf-8?B?YWNBR1ZHUk5ZZ0V1V1ZNK3ljV2RlbEt0c3FlL0o2alRkbldWOVpRb1BLZXlP?=
 =?utf-8?B?bS9mdFhGdDQ2SW16Sk93RllZamRpRXBRZ2w3UFFkd0Z2NzZlL0ZMWWxLTUt0?=
 =?utf-8?B?SVNGRTN4eHkrVjFTYzVTc0dScXd3c2JUaHQrMi9Xb01SWWtqdi9hM004MW5w?=
 =?utf-8?B?c0RyOTJjaGZrbFRKVklWVkdQNDluOGkwTURwdEUyaVdkeEFYNnM2ZEtmY0Jw?=
 =?utf-8?B?TFVXbmhnOG1QSFJGcVRLVmhUSzZWVFU5bW1BRzFzRXNDWVFZalQyNjFDYTFl?=
 =?utf-8?B?Nk5zUWFLdmVGZUlFMDg2Ym9xaC9kVE5lUS9zNUIzVDJpOVVMeVFPZGVjUlpp?=
 =?utf-8?B?R3c1M0o2bFludjNHaHVudjdiWlV6MWlnamhhUFpVWkMxY1VBc1hPUE1nTWRr?=
 =?utf-8?B?dVBlNzQ1cjNyVWh1dEZjMUVpd2xtQTRDTEt5bzBndFoyNWQxZjFwc01hb251?=
 =?utf-8?B?VVhzdkhLc3JUZVNtRmordS9aWWs3OGphT3ordzlRcVZmZUtwZjNuYTFhb3Ix?=
 =?utf-8?B?SGpWaE8xR1pqd1NEa0RqSWRtZ0JlOUh4Mjd5K1NSM1lRTnNJdFlUWkw1L1JI?=
 =?utf-8?B?RGxwTjBmYjlEb1RUa2ZRY3l5SFgzNWxoVnc3L2VKSjVpd1BkaHFoaEVEcWRt?=
 =?utf-8?B?MTVCKzBqblBqeWEzU1VWcG4wVUlLN2RUTnhlWVdmRUwyUXl3Q2hGYUxoQURT?=
 =?utf-8?B?cFpTQlA4c3RXRUhmSlMxZUh6MDRGbC82aGpwWlJwekMwSmtrMFE5UzZNZVZ6?=
 =?utf-8?B?OFc2ekJIRlo0UmxKbWoyZys0cjZDM1gvcDc2QlF4cnVEVkdsREUvVXZOMlV2?=
 =?utf-8?B?YXlOZVlkdDAzWFE1MzQ2Q0tMSEFYYTh3SHY1ei81THI5bEw5UnptK1pyeStZ?=
 =?utf-8?B?MmZJZFpEVzZUcXZWMjI2ZDBPZkF6TG9LYUFPSXQrOTdvelFMWXZCcXQzeWg5?=
 =?utf-8?B?QWl2TTNaZG90L2xOREF1bjN6VGlxSWtzQm9lS3kyREFOM1BCTUNuckwwMWpt?=
 =?utf-8?B?V1VlcG1TclpCYmNHTUluTDZBNjhITTY4RzJPYWU1c09hdHhZM083anZtZEh2?=
 =?utf-8?B?UXZJWGdtdUFhMS9HU3dGUnkxYVJTS05iUmdOOXVwdWhVaFVSazllbFF2NzQ5?=
 =?utf-8?B?dTdqTXpyTEdHc0p2b01vdWY3MGNIMWFoWEhkcW9iQXFxRzlFZ2ZGVkQ4Q1Rm?=
 =?utf-8?B?cUE4NFBLMHd1SWZoQ1ErNjQ3TWRwd0JzV1ZQZnBsWHdRbEtabE96NThCaVBt?=
 =?utf-8?B?bVJ3UW5sRGI1THJUdThOSmVFQVh1TS9kOEZDTG01bnJRMmlaWFF1dXNsNloy?=
 =?utf-8?B?VnhIZGpvRW5nMXBuRjJSckMxQVloTlphbTZ5MUJrVEJ0RWZsNVVaQnBNV01t?=
 =?utf-8?B?c0JaYnA3ZW9GeS9ZZHFDVzJBY25pbk1XL25HTU42YiszUjk2ZGQvRkJqaEt4?=
 =?utf-8?B?QURmRXBSRVhMWmJqT2dZU2thYTFMWDJGdEFIMkp1ZWRybWlLRXVrbGVGRk1X?=
 =?utf-8?B?Q2dmalNBNEFjYWk1MjFMb0xmY0FrUHFYejE1cWw2c3VXVjFnMVZUWjByN3VO?=
 =?utf-8?B?T0xKK2hLYktZUFc2c3FPSGZxdjIwVk9oRG5wL0w1eDJqcVRsUlExWUZRQnhv?=
 =?utf-8?B?bm5XZXplU2ZvelFjQXluQ1d1anN0ZXFiWFJrK2lQSmcrbUpCckVHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23C94E40D4408E40AD963768B6982099@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TcdiaKntz55/haWZ/1SIu66WPxrryQV/eJwHWmfyQFDj3JuyiZ7aEdso1rvs8zK2z7nUytYYDMUnUWmXnLe1E31zsTWgMUGniBsLfEm9j8QM9eRnFEoXnr2HlKRExuVEI0ibJ1C4b88OpGADUGlnmvM45bSbAmsOKyO6IYtnRr0OA/W0CXWVgoNX9skFRdj8l5uoSgUhyPkNMbtNI4kth3yc7pj8AdsjnMkf3onlqO+Nnml2/o8UoSrxY/teRQf1QE3kJx4GjaJyhx0CEzi5Xni1lPpDWjUYnb1AT+RknsjAY1BhdO2TflJz9YZFSTAehBrovvqnytllMUDt7SO6zw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OLW/YJLuJqkLYtUjlDPQRX8p2ApIk2Ti1MWqOeoXmQ4/yXsjtzMzN1DHBFaJOB3CPv+tWLYT47sPDxHHdv/IAKhC1Rnx1tlLte0frGIF9Ezc/DA4XReRiy7D0QSVJO1xYX6tosqOq311Nw7GIpSXCUzoKiawWJJk2ouOF4bwCBBSOsyHTb2rMM57aS+DH0bAnSO8lHINfP3rWp11QT4gRlbwF4W2sNZU3haVS7TCNXHEyOzEYUo2lsZY0A/s7AD/uQp56A36jRXBu36ImTOVX0jzLoiO9BgFmTne4cQAnDN5mFQO8uvz+DzeU6RUpfzp+cgNw0qPBkp8xWUeus2oH7PfUuQXv2CJo103bJSpC3uU6Z+Gg5LXy2W1Av6YOdLYzX9TkLM1A7ptSJraiEuHxczC8EJuZYGXmhsZlN6wRviC+DIIAXbBJbsSh2B1eOLfy5xlQ4hmMRahxoLrKFACil/LBygSmWiu+vmiKECZadWzlZ9pyP25BKaQJuPs5NtK1yH6zuPP0RMfMTVNZj8Eo8zi9hw6IOL9yVs5Sw5AfLsipisbWuGjaL5huR/ash7VJ6TrAQHGAEtahV0VzijQjVhYTfZVlG7f/y6VTZKJq1XTMgjGjNO/x4+xR6nNduc/+hrwODRv9Mwl+WtRGjYRqQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce761632-e811-4c83-88c4-08df202af639
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 02:15:00.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVVzqo2IdH3ISrMEQWmNiv20WSQ3ghBYIfTG8zr38ZUyE7xiKUv2X90EtwCr4FMiR8N5UeVQDbvebrrJFtPtZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
X-Authority-Analysis: v=2.4 cv=T5oZ3PKQ c=1 sm=1 tr=0 ts=6abf13ae cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=-Gx3EXIGyT_ViV0smJwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAwOCBTYWx0ZWRfX2BP4gsVkS+io
 VxBb8irS/+QWzkuMsV7HsR1/W1NrNb5NT9ArVIOUxB4e8TBhe4GJzB6avJR4Pwcis4gJnWfiyeb
 EBkSTHHOIsPr5SZgvqrOhDMqdHFpTUo=
X-Proofpoint-GUID: inGGVIthZ-5GerI1ozs8DtrfoXSsLOKz
X-Proofpoint-ORIG-GUID: inGGVIthZ-5GerI1ozs8DtrfoXSsLOKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAwOCBTYWx0ZWRfXxihnOXQZn2Bl
 KdG31vDeNSMcj/f3MDIyfnFaUsV03XxyHBmRxrzazcbZX9Oi17Ma+d7Qg7xD406ZabOAYpGo0e9
 MSdxP10oN/9NwsfzMHnUXC2hBviRFl+g6+WaiGGMTLVy4dlHc3v8mzpBrfclwBzCzIKEY5CM39X
 qP0qE+zbMJJsA5X0T/YoCPE8b14EmxnTqt4L9GvbNYcLVNt2oLidN0L9fO6lv4U3a7WX27LHnBU
 B8iRMIb0UZLat03TZDA8jsTNDnWUujKC5tdxnxwiTdeoEuEYuZUVRmeS7AIVMyIOdgQOIikPDw6
 CLQabNzv8LJoH9yX191+Z/ueyvDwhZSMQlTeeyDoqGLhpiiVyAG9ingsNO59j1tnnq2WElSUHYl
 0Se6B+5VEHxTjydHN6ySLop5swlOev7g8Xrxhb/HFyqrhS1eXcDO9MgQgV+ihsiBzyat7C9eLUw
 87Uk3w48L2uJiI0/6Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_05,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610020008

T24gVHVlLCBTZXAgMjIsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IGR3YzNf
eGxueF9pbml0X3p5bnFtcCgpIGRlYXNzZXJ0cyByZXNldHMgYW5kIGluaXRpYWxpc2VzIHRoZSBV
U0IzIFBIWSwNCj4gYnV0IG5vdGhpbmcgdW5kb2VzIHRoYXQgaWYgYSBsYXRlciBwcm9iZSBzdGVw
IGZhaWxzLCBhbmQgbm90aGluZyB1bmRvZXMNCj4gaXQgb24gcmVtb3ZlIGVpdGhlci4gVGhlIHJl
c2V0cyBzdGF5IGRlYXNzZXJ0ZWQgYW5kIHRoZSBQSFkgc3RheXMNCj4gaW5pdGlhbGlzZWQgd2hp
bGUgdGhlIGNsb2NrcyBhcmUgZGlzYWJsZWQgdW5kZXJuZWF0aCB0aGVtLg0KPiANCj4gQWRkIGR3
YzNfeGxueF9leGl0X3p5bnFtcCgpIGFuZCByZWdpc3RlciBpdCBhcyB0aGUgcGxhdGZvcm0gZXhp
dCBoYW5kbGVyDQo+IG9uY2UgWnlucU1QIGluaXQgaGFzIGNvbXBsZXRlZC4gQ2FsbCBpdCBmcm9t
IHRoZSBwcm9iZSBlcnJvciBwYXRoIGZvcg0KPiBmYWlsdXJlcyBhZnRlciBpbml0IHN1Y2NlZWRl
ZCwgYW5kIGZyb20gcmVtb3ZlKCksIHdoaWNoIGFsc28gc2VydmVzIGFzDQo+IHRoZSBzaHV0ZG93
biBjYWxsYmFjay4NCj4gDQo+IEZpeGVzOiA4NDc3MGYwMjhmYWIgKCJ1c2I6IGR3YzM6IEFkZCBk
cml2ZXIgZm9yIFhpbGlueCBwbGF0Zm9ybXMiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
Zw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTUNCj4gU2lnbmVkLW9mZi1ieTog
UmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiAtLS0N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZXdvcmtlZCBzbyB0aGUgZml4IG5vIGxvbmdlciBkZXBl
bmRzIG9uIHRoZSBwbGF0Zm9ybS1kYXRhIGNsZWFudXAuDQo+ICAgdjEgcmVnaXN0ZXJlZCB0aGUg
dGVhcmRvd24gYXMgcGxhdC0+ZXhpdCBpbiBzdHJ1Y3QgZHdjM194bG54X3BsYXRkYXRhLA0KPiAg
IHdoaWNoIGlzIGludHJvZHVjZWQgYnkgb25lIG9mIHRoZSBjbGVhbnVwIHBhdGNoZXM7IHRoYXQg
bWFkZSB0aGUgZml4DQo+ICAgdW5iYWNrcG9ydGFibGUuICBJdCBub3cgdXNlcyBhIHBsdGZtX2V4
aXQgcG9pbnRlciBhbG9uZ3NpZGUgdGhlDQo+ICAgZXhpc3RpbmcgcGx0Zm1faW5pdCBpbiBzdHJ1
Y3QgZHdjM194bG54LCBhc3NpZ25lZCBieQ0KPiAgIGR3YzNfeGxueF9pbml0X3p5bnFtcCgpIG9u
Y2UgaW5pdCBoYXMgc3VjY2VlZGVkLiAgVGhlIGZvbGxvdy11cA0KPiAgIGNsZWFudXAgc2VyaWVz
IGZvbGRzIGJvdGggcG9pbnRlcnMgaW50byB0aGUgcGxhdGZvcm0gZGF0YSBzdHJ1Y3QuDQo+IC0g
TWFkZSBkd2MzX3hsbnhfZXhpdF96eW5xbXAoKSBpZGVtcG90ZW50IGJ5IHJldHVybmluZyBlYXJs
eSB3aGVuDQo+ICAgdXNiX3Jlc2V0c19yZWxlYXNlZCBpcyBjbGVhciwgcmF0aGVyIHRoYW4gZ3Vh
cmRpbmcgb25seSB0aGUgcmVzZXQNCj4gICBhc3NlcnRpb25zLiAgcGh5X3Bvd2VyX29mZigpIGFu
ZCBwaHlfZXhpdCgpIGRlY3JlbWVudCB0aGVpciBjb3VudHMNCj4gICB1bmNvbmRpdGlvbmFsbHks
IHNvIGFuIHVuYmFsYW5jZWQgc2Vjb25kIGNhbGwgd291bGQgdW5kZXJmbG93IHRoZW0uDQo+IC0g
UmV3cm90ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gZGVzY3JpYmUgdGhlIGJ1ZyByYXRoZXIgdGhh
biB0aGUNCj4gICBpbXBsZW1lbnRhdGlvbiwgc2luY2UgdGhlIGNhbGxiYWNrIGl0IHJlZmVycmVk
IHRvIG5vIGxvbmdlciBleGlzdHMgYXQNCj4gICB0aGlzIHBvaW50IGluIHRoZSBzZXJpZXMuDQo+
IC0gQWRkZWQgQ2M6IHN0YWJsZS4NCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54
LmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54
LmMNCj4gaW5kZXggZDE4ZDNlMzY0MzgxLi4zMWFjNzViNzk3MDkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMteGlsaW54LmMNCj4gQEAgLTQ3LDYgKzQ3LDcgQEAgc3RydWN0IGR3YzNfeGxueCB7DQo+ICAJ
c3RydWN0IGRldmljZQkJCSpkZXY7DQo+ICAJdm9pZCBfX2lvbWVtCQkJKnJlZ3M7DQo+ICAJaW50
CQkJCSgqcGx0Zm1faW5pdCkoc3RydWN0IGR3YzNfeGxueCAqZGF0YSk7DQo+ICsJdm9pZAkJCQko
KnBsdGZtX2V4aXQpKHN0cnVjdCBkd2MzX3hsbnggKmRhdGEpOw0KPiAgCXN0cnVjdCBwaHkJCQkq
dXNiM19waHk7DQo+ICAJc3RydWN0IHJlc2V0X2NvbnRyb2wJCSp1c2JfY3JzdDsNCj4gIAlzdHJ1
Y3QgcmVzZXRfY29udHJvbAkJKnVzYl9oaWJyc3Q7DQo+IEBAIC0xMTMsNiArMTE0LDIxIEBAIHN0
YXRpYyBpbnQgZHdjM194bG54X2luaXRfdmVyc2FsKHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0
YSkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZHdjM194bG54X2V4
aXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkNCj4gK3sNCj4gKwlpZiAoIXBy
aXZfZGF0YS0+dXNiX3Jlc2V0c19yZWxlYXNlZCkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJcGh5
X3Bvd2VyX29mZihwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gKw0KPiArCXJlc2V0X2NvbnRyb2xf
YXNzZXJ0KHByaXZfZGF0YS0+dXNiX2hpYnJzdCk7DQo+ICsJcmVzZXRfY29udHJvbF9hc3NlcnQo
cHJpdl9kYXRhLT51c2JfY3JzdCk7DQo+ICsJcmVzZXRfY29udHJvbF9hc3NlcnQocHJpdl9kYXRh
LT51c2JfYXBicnN0KTsNCj4gKwlwcml2X2RhdGEtPnVzYl9yZXNldHNfcmVsZWFzZWQgPSBmYWxz
ZTsNCj4gKw0KPiArCXBoeV9leGl0KHByaXZfZGF0YS0+dXNiM19waHkpOw0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2
X2RhdGEpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9IHByaXZfZGF0YS0+ZGV2Ow0K
PiBAQCAtMjMwLDYgKzI0Niw3IEBAIHN0YXRpYyBpbnQgZHdjM194bG54X2luaXRfenlucW1wKHN0
cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkNCj4gIAlkd2MzX3hsbnhfc2V0X2NvaGVyZW5jeShw
cml2X2RhdGEsIFhMTlhfVVNCX1RSQUZGSUNfUk9VVEVfQ09ORklHKTsNCj4gIA0KPiAgCXByaXZf
ZGF0YS0+dXNiX3Jlc2V0c19yZWxlYXNlZCA9IHRydWU7DQo+ICsJcHJpdl9kYXRhLT5wbHRmbV9l
eGl0ID0gZHdjM194bG54X2V4aXRfenlucW1wOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICANCj4g
QEAgLTMyNiwxMSArMzQzLDExIEBAIHN0YXRpYyBpbnQgZHdjM194bG54X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZXQgPSBkd2MzX3NldF9zd25vZGUoZGV2
KTsNCj4gIAlpZiAocmV0KQ0KPiAtCQlnb3RvIGVycl9jbGtfcHV0Ow0KPiArCQlnb3RvIGVycl9w
bHRmbV9leGl0Ow0KPiAgDQo+ICAJcmV0ID0gb2ZfcGxhdGZvcm1fcG9wdWxhdGUobnAsIE5VTEws
IE5VTEwsIGRldik7DQo+ICAJaWYgKHJldCkNCj4gLQkJZ290byBlcnJfY2xrX3B1dDsNCj4gKwkJ
Z290byBlcnJfcGx0Zm1fZXhpdDsNCj4gIA0KPiAgCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYp
Ow0KPiAgCXJldCA9IGRldm1fcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gQEAgLTM0OCw2ICsz
NjUsMTAgQEAgc3RhdGljIGludCBkd2MzX3hsbnhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gIAlvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7DQo+ICAJcG1fcnVudGlt
ZV9zZXRfc3VzcGVuZGVkKGRldik7DQo+ICANCj4gK2Vycl9wbHRmbV9leGl0Og0KPiArCWlmIChw
cml2X2RhdGEtPnBsdGZtX2V4aXQpDQo+ICsJCXByaXZfZGF0YS0+cGx0Zm1fZXhpdChwcml2X2Rh
dGEpOw0KPiArDQo+ICBlcnJfY2xrX3B1dDoNCj4gIAljbGtfYnVsa19kaXNhYmxlX3VucHJlcGFy
ZShwcml2X2RhdGEtPm51bV9jbG9ja3MsIHByaXZfZGF0YS0+Y2xrcyk7DQo+ICANCj4gQEAgLTM2
MSw2ICszODIsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX3hsbnhfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlKGRldik7DQo+
ICANCj4gKwlpZiAocHJpdl9kYXRhLT5wbHRmbV9leGl0KQ0KPiArCQlwcml2X2RhdGEtPnBsdGZt
X2V4aXQocHJpdl9kYXRhKTsNCj4gKw0KPiAgCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKHBy
aXZfZGF0YS0+bnVtX2Nsb2NrcywgcHJpdl9kYXRhLT5jbGtzKTsNCj4gIAlwcml2X2RhdGEtPm51
bV9jbG9ja3MgPSAwOw0KPiAgDQo+IC0tIA0KPiAyLjQzLjANCj4gDQoNCkFja2VkLWJ5OiBUaGlu
aCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywNClRoaW5o
