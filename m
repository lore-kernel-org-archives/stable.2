Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994F21CA13;
	Wed, 26 Aug 2026 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787705397; cv=fail; b=bjviEkI60jqKFEB+38GdtCJrDlCP1fDF7DQscKKi/6qi503U36l76e99fCyOsJeSF/01i+ECvXtjYRTdjK6AtOIohVfZ4SEVS7DB/8a1rc+jFTPtVomEMzgdOCUyyqxVPQCSv6OvhcltZ2P9VQ42ET2fJLbHanhPJfDJ8xhou/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787705397; c=relaxed/simple;
	bh=C1RJAf1oqQvS/ZIaKZqqavVau/VArpx8vzaNX5fFpRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNKDA/Bpc5HN/dQTfNCFBsNDT/9Z4Ktko85X3Gw+cDCPEjjvkisukqofulyXXFWAnbKSQq+9JU0jM0h+GAcda3CwSJgfX/7yn4G5V+DeyA2WtFm0FcKT4tVZaGaXWdLKIb1OmZUDcaGSaVGffZjAonbcqY9sFuPhrmqcww5zMEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dzuhfoNe; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=A8vSIPPL; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tk5QCm7A reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dzuhfoNe";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A8vSIPPL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tk5QCm7A"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q09Kxj2241988;
	Tue, 25 Aug 2026 17:49:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=C1RJAf1oqQvS/ZIaKZqqavVau/VArpx8vzaNX5fFpRw=; b=
	dzuhfoNeW8+ES2CRvlPeqpVmkovXvFAVImXEcv2wRql/r7KEwEXa0oSrURFsXpfD
	t0ybPL2Kcnw4Obe4BXg9T8vaOa913+QBCADKGKcirEehIyJbAxFAHMY/shccaEHs
	448bB6kGCse9xnLrsH8+YYUZhhC6IAMUpsm0VfJvTMvJJIa/Wce6xQj7CKKdmaSL
	ujeYm7Kh/TScOVoJg66uitQw/2L6dna0RCszr4hjtCFxLYIIUxRvG3qTgdY9vzW1
	kcO6tKhUO4s+cf1/sBE2uwSVGNrU1K/pn6G1e693c4qkUxCOOrYxK2w7BH/vx/J/
	ZPUaRBagi9Gr2VAFck1zkw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4g9buyxe3t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1787705391; bh=C1RJAf1oqQvS/ZIaKZqqavVau/VArpx8vzaNX5fFpRw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=A8vSIPPLB6C6jIbCOzALF8YlrrHNTTCQRwCgn6CBGQYIfVkYTKZOEX69jsRjZZ4J6
	 LDjO0t79jDDkyjRUUQ67TW6/yLAS0ViIZzGjz9uau6IeGis6leZLHDXZPFd0SPg/YT
	 1ck2aNPdLzDBh42ZBwtdmwYRCGIjn3aM4z4tLvSmZE9FM5JVTRyHF1/Xmf2nj6U9ea
	 x88orqHCkg9Jnhl0HiChK5HP3LRAmuoLrmjj8VQwnhLkIKrY9OG96qrjcdPNoZkx8n
	 BUtMuvmQUvoZCT2gH5/E/KMz6S9cGgjdDgikK8LkWpO22P61LApJQFOfD8PuoGoa3/
	 vNKwTPQuVn+tg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7D70640124;
	Wed, 26 Aug 2026 00:49:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 38B32A0B93;
	Wed, 26 Aug 2026 00:49:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tk5QCm7A;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00106.outbound.protection.outlook.com [40.93.6.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BF92F407D6;
	Wed, 26 Aug 2026 00:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDcTahp1EBCFjfs9rfayk3ynjLLH6/sMCk/VYn83iKsFz5FJ6jaFNwVmwxk8/b9NORh1thK8uSFwUf9km3VgxHShlQ/FLJOiASyeXeKp2AebYEdr0ICPQyaU22IrI6PqQj8N382YrSSKvF9sDWrkXQ4QI7LdiGG/PN+cTXdzbAFLhdVKDUBbWhMmd3eo4KLbP5Yb29ZYT5xgsRfBKrNXTeqhi9qGZ28XMgemHn3TbP7wij3m7TtzcDT6Aw3wz0Kwrb1uXVjT6TMYSmgzDVxR9OGm/le2YqaM0aH1mOtOk6BUZxcJH5m8JXEjsHO9r+iqDbZa7i2wWK2U/8EY/lCDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1RJAf1oqQvS/ZIaKZqqavVau/VArpx8vzaNX5fFpRw=;
 b=mwxkCRMBRk4LaFmPXtyw1xrmhaOT03jQEdm8RbhwlTjH6Mc4fPVAZm334ylPo7+jJR34xax7mMQmW0dGy9KnCLXGLOvY09sok+6XVHr1/MW4sbIzzK3vH1ItEpDYfqcbs6wGrcyL1NCuAS3dGzeqcmDIc0TeFHOi3o36x9vQ+DsCczMNyyhdiHHaKJmy9m7ErlEXublQqJP86M0tLIWUWE6kUn+rmjKDWRnEHgb+S501P3ja7VyV/kdeo/+d+I23X/rxHoZKm2F+/6Aa4pjfDf6ce36V0N/t8QGvABEeWmnu3CQ6YOcyN53pnL8U52pZEitcixla/WQmankjAgx9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1RJAf1oqQvS/ZIaKZqqavVau/VArpx8vzaNX5fFpRw=;
 b=tk5QCm7AvHxAk4gy4iKTQiaO2SHOGQMI+52p9cp0i4xmHpcWaCKEJqNv3kjzHTA1B9PuQ+ncSbJKnN/GGwcvexm34JirxSY2cwtWodhOt7HJOBXE7bquyF8KxCy8UJQtvy7TSZSCYb63SgC9XYEoB5lul/btaj66+Ow9Wo0r4RY=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 00:49:41 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 00:49:35 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Elson Serrao <elson.serrao@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: clear forceRM when issuing EndTransfer
Thread-Topic: [PATCH v2] usb: dwc3: clear forceRM when issuing EndTransfer
Thread-Index: AQHdKzaRaGkfbip1FUGHlma9Um6hqLavkxgA
Date: Wed, 26 Aug 2026 00:49:35 +0000
Message-ID: <ao44DlpRGsXPgTKF@vbox>
References: <20260813151456.867008-1-elson.serrao@oss.qualcomm.com>
In-Reply-To: <20260813151456.867008-1-elson.serrao@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DS0PR12MB6655:EE_
x-ms-office365-filtering-correlation-id: 1f27cad0-9408-45f6-2122-08df030be64c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|11063799006|56012099006|3023799007|4133799003|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 XjhU3x5u3tDYNRVVyLtZA5rjTdSkJylHQwM/EeQMG6cjtlRveEi5uDSvo6RPLbt6AGYKyDK00Orfei/7Sbvt0FXAdx1Xl/UJwjOuW5AJmUC1F5QXBySoWG9eUvn9CthiUAUS490bvI4lwXEaa9jnqCp4VfxbEWQloH2USn2LhEQKg/uCMJoW4F5OjSRPRSvgUSq/i8qW1hzqEA+b3a9bdraYVTTlCIIW1fbMbKUJEGeoOpVpvCdM/6O2rGFgedxGjvhxh0EjUEGUp8c4ImbYsNT3to5AwQ/QbD9ag0UUx17nGrjKa8cRASbC6YbXnTzsDHWrRqdWp8QAG981r9hvWo5MpCdbrDhFrMD3/FLuuS4d48hFp6/KhOzKGFfYYR9JB5i+CgpTBFY1Uzj9ivMqbV7GU5ETgkrcbYqmev/h0EAavorEgfRkmZ7uspFy7tAAIAkX/6YTMa6DG7O1f82fA2yHvUjfwuOHlEmnZubMkgBYzlAc58qE0vu8y/v0TkDxn+eO/rUMaSU4PsQ5xj4RIrYJUZq57rO6oYUlAO52EouEdN8gVCXaEWpdnfWCQuEjsJhWkUfiDsP0L20p5Gs13uSE/bK8qb7X+pFzRG4Nd91eAHPbEPI7YQ/TpqsE+3gUp6H+eX8yP/jk186j3N7RLKl6NTMOm7dLZg4TWXeyA1Fh0n5eq02TMYGLrvKbn4jwESIaOSIY5igCshLq7/RVkdww4llHn96WrsrEo0ls1dU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(56012099006)(3023799007)(4133799003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3h3OGJxR0YwanJkQ1dWdEF0Qm5EY09VK1VWY1VQcjc1Sk1ZL1NuS2VUUHIx?=
 =?utf-8?B?YmhoRGxEcjBUNzVRb283M2JYTGY2ME1HRnBQTXhVN0pYeTNVcTE3U2ROZTJS?=
 =?utf-8?B?bE8xOFc2ZUp2Z0VaS0VPRXEwaW9wcVdNV09lcnl3YmJITTN2RnlMTzdiaEor?=
 =?utf-8?B?RGhwYlE1ZGUzMmYwQUVTclRWSzF1enJFUXkwU3FyR1JYSjBCK2JiMXlaU2hU?=
 =?utf-8?B?QjlVSnUvR3BqbEdxRVNDblo4Z2cyT3BkaUhmWjF6NEplQzNibTN5Y21kM1d4?=
 =?utf-8?B?RThoNnJUVzdIQUhBY2E0WVljU0gyQWplbHYzelUwTEo4Rkd3T2MwMm5GV21J?=
 =?utf-8?B?NEJsTjNwNXVjVERJUEdlRHY4ZE5kUk1aYk5WWmkzSXRjcnRySHVUM05jTTkr?=
 =?utf-8?B?bXlPdXVjem84U21rRGVzYlV3T0phZzByZ0RsdU91UmFLL2tBN2Q0cCtISGVS?=
 =?utf-8?B?Yng2dVJ1VDQ0bndwdW5tM2o0aEZOWEpJeU5RSGgvMXFVdlB5VVBIS3BuMlhS?=
 =?utf-8?B?SXFid3FuYVN0OVN4SktXNktmSkZ3WDI3TlF6VHZQTzNuNjdKVVJGdVo3OGJM?=
 =?utf-8?B?RVN1cThHMkh4ckxBc204Z3N0U1Jrb1M0cVdpdGhDajdMYm5tS1g2UUFNeVNG?=
 =?utf-8?B?ZXdtREROaU5UK3h5Wit1Y0xCNURyMHlHbTMybFA0ckc2SmZUOEJ3a2luVk5m?=
 =?utf-8?B?ZDkzbTRidXZ0N0NwWWdTeUxKSytNQzZnM2d3c3RSMTB6Q3hJMkZmM2E3Lzdy?=
 =?utf-8?B?NGd4RFVIWnNCZUtoOUFFSVJ6WkVRaTN1ZFIybkVISVJhenlueFZRUjJaNHQ4?=
 =?utf-8?B?cVV6aFEvQmxuQS9id3VzQ01haVZ5MHZkTU1jMEl2R1g0MmxTWGU0UWg4dUk0?=
 =?utf-8?B?S09vOTBtekY1czRsYmM5TW0wUlVybVdWb05IK0k3dFVZamNsRUMyYjMrZVlz?=
 =?utf-8?B?WDc5SnVDaUl3dTc3WkJhUnlWSHJWRm81cEQ5bUNpRktCd2JaYldQdmgxS2NV?=
 =?utf-8?B?OGp3ZERCelgrYjU3ZHZ2VEw2dW1WNldZYUVYUVhuUUxJb1Z2ckRWSUlWb05n?=
 =?utf-8?B?SWM5dmpGUC9rNStLbnZ5NEVIc1ZrZ0JOUXFPUlNsb05oOFhSNzV0TStOZHhH?=
 =?utf-8?B?dnBqL09GUmhiaDFndnRicW5aOG14S0U3OEF1V2YrbGF2ZUdMZGRUUjVwYW44?=
 =?utf-8?B?ZFNZS3dvbUJQdzlaTzdpdFEzRVRkMTBwWGtuQkFyLzAvbUM5K1MyRld6aDhW?=
 =?utf-8?B?OHVzSTQ3MkNLYXpBaVJ6Zjl0eDQ5dmM0NkRBM3pSMjJIUyswU2x4aGhGSjJm?=
 =?utf-8?B?MCtMM0dYNkpadGJKWThRakg2YzRTa1hnUGd1WVUrRWk3Z3hUNm5mYkg5bmFz?=
 =?utf-8?B?OHRRNVQ2bkFrakE2aFFiTldXazIrRDc4Z0xHQ0ZpRlVwQXNBWmRTeW1SeGpP?=
 =?utf-8?B?OXRaS2VVOTMvWFl3Q3RLdGtEVlFXQ0xmQ2pDZEVNbEp4TVhsWUtaaUQ4ZFIx?=
 =?utf-8?B?T0E2UERIQjJ2dzFpUUw3U2dJOVl6TmhhSTRxakx0Tldsd3NldXMvNURYSUNi?=
 =?utf-8?B?UjVhYlVaVFlYQ3l0b2NsYVdnK3lmTTJ6cGY2NE0vQkZvdzhYSFdXRTdHYUxq?=
 =?utf-8?B?TndQWlhOaGdHL09DNVdldm5WdERFcUpqTjdkOTBYVDlnUXBObkRFNTlNeWhC?=
 =?utf-8?B?aFUyVUJjZGFWa1Z1c3Y2bFY4c3FQVEhtUWUxQ01oTjdRb0phNFFUUWtIT1gx?=
 =?utf-8?B?MDhRSlRWNGVSVHZQdmNLU3BhNmZXcUViUzFQWHM2YlpxT1R0eDVWRHJVcmR6?=
 =?utf-8?B?MHRFWmtqYnZDdFhrQW95K3libk1mUkZQUE44YXhoRUUvMzBNc05ZaUphWG1j?=
 =?utf-8?B?R0xqN0U3V2lXcTVWUHBKeU40a1grbzZESFBCb2kxY21oODhDNTBwVGF0d0Zt?=
 =?utf-8?B?V1VrU05NMDRtRDkwOFV6OVZzRk9UbFNNZG80ZnZFYWd3T2Nsa3VicWlrYTRu?=
 =?utf-8?B?TUM4Q3M1RHR6RlYrUnM2RFQvS2pjUzNOZ2l0MmNTZmE3dWhwOW1WM1RKK0h5?=
 =?utf-8?B?c3hUMjE3dWF3WTNWUjZNQTFMcGppd0RROXc2L0ZEczlvUVJyM0dZWVh4WlEr?=
 =?utf-8?B?MVYwQ3o5QXpFNjZCTTBKTk45UnVyOEpWblljK25nb2lVMzdwQmhxYk5tU2I4?=
 =?utf-8?B?NUcyMWhUNHkvK2lyTm5pajBsbFFoTTRaZXNBcTVhS2p1RDQyQ3FjZW92ZUc4?=
 =?utf-8?B?dHhHakpPTEo2RXRzRWtWMjJIU1ZRejY5SktyM0xIYWQ3Rkp6ejQydTlnemFl?=
 =?utf-8?B?L2tNRnpMYVhuN1hxVnpUVXFqTEhydGM1dUJkRVpac09SbElMR3NaZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D92C6FB5717C348B4D60FCEAB5407EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RE9Subxse+WBOgworPFwVrHmUZ0wPPvbS0x6FqsEeeoKjsO5oE1Wu7kPsnuwcbeETPXa1JtVv32VaVL+8P2zQnI3KVbn/7JQqCA8pSkd+XZ3ez8qk0ZdqkKNiu+flbwcGBW1qjdeTuMQTh1sUBjYfR4Q2kUGzCNuy9WoBG99l698iq2cDS8+v11t6ENFOCJNf1ZFfpRMJRERpLoxjYx5/AQ+SBj2EYfgcp5oObH5uVO7K66CJN5TWq1Lh5lVipYW3oduVAK9XEyV9xNeJV8E1Gdpp8fkOSxKrTnlJRhgwXuhu6H6uZxzOqaEOOK86lSoR7hARbSknLSIVbxCe0UW+g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N28YdObX+A5pkTULI8fleguunBI724TVPJ79uwqnTSFUds9447GEgcUYIQpsX/KfLeHxfy8vDem2rVZruXVLl3CFbMcQUFeYe3gJsM6s6+EX0PKoEvMXm/czq/eO+9f7GE5padlo97bl3hQLjLO+HUEN4pDqeNWSk+g+BK9DRlGCZGmcMbevWEuh81E9IglqKoCbC4Mz77VX48CYhdBXZfo18oU0tIYuffkVvTMLtal7obt3SiLXN/Ok1Q62bVL5Njg0h8eK9ikmO0+Ga8COKJPRFSa7wG5OOMqZ0Qw3I3o/J+DaenVaAaxslTiBs32pbYWY3YjnYWpdZefK4gQNfrThen5E9nrcZo8kFgAE8FtERaeGsCwzOvqx/+krntfFhON4srKeUjwmLohc5XqwUZb+ujLuMFEjCWtkpLqEWSSrsKTIvp+H4JoWcOZKERZgS3KNzHdvHxYrVw5fl7FdKXJWmUtkoKAloJsR9+5kbPeTTr7Ksyj9RurwyNsFfSzR5/oJv3IskGOgfjUiDAwSr4mZOT8RIXGZJ3lvPJF+GFZL5zcnx/5Iv/p8Iw9rp+MJIRunA0+TL2BAfNTycVX3/WUmUM2J/2orEOvxU6TpTlASkFc7HACXjG3xr2ajcz0IB1vHgttwPx42Wph5Srg0Ig==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f27cad0-9408-45f6-2122-08df030be64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 00:49:35.2510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OItkaBVlLcDiyMx2C8kZc4fSj3BtiO2HMF/TF4QRGoXNOSNr3SxojQynsleYr1TIIyFNe0+xmthptgNOUwmL8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-Proofpoint-GUID: r-zBjhOfm7j9UDXNIhYx_Drb5-mdIwSR
X-Authority-Analysis: v=2.4 cv=euvvCIpX c=1 sm=1 tr=0 ts=6a8e3830 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=fitv4BOxO1riKbimYTUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAwNCBTYWx0ZWRfX0P5bT6oei5T7
 BNzFl0MAFOoRPSTFOerraAZ/U0VwkgxG36QJYaswvg8oRcNDTRROihZoexf6gNBULKtcbLk8/pB
 FYN6myHFQAOjBYQjMI7eRkM5SMY6p1DmYDCjFDGiiBCT8L7cumCKHiSdIuefYev6S8oUlPAseCq
 tm17Hm1oa0/fd6LJWu9wD8pJa45d5gaEyZl6PG3Zb1Gh2LP9nm5F5TibsOzC7PO0i6/gmgaSNcN
 h/+wfSrukkul7KRdtwiX5aeJHxfFnTLnt7zG4r3Km6gpcv6DOuFsFEABgaF8iYGO3shaoynmwKg
 1ynlNramNXNpaS9NjMheyang60wpG++Ew7u3BJME+JdFFqWmdiNbBnvrvEpqNw6llW1aBcsHWri
 I/jDRU6xDH837Dg3P6NP1yFU4od95O2FgASXdL4Be/vpKruxRJH7Xrcck1GIiP18Fd9MJrJbn0N
 Z0qVn1ZcwfQeZ8I6Taw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAwNCBTYWx0ZWRfX4QDgOtDgf5qu
 KcXTXTlYSH9eq+JbvPl+ENcasuN72Uvyav62ZNJ2rF+g7YQd/+IIRrSA6zV98Ecxfdoxfyz2q8M
 sh31aCroz6yhIWa7NTV0cytXDOHBAr4=
X-Proofpoint-ORIG-GUID: r-zBjhOfm7j9UDXNIhYx_Drb5-mdIwSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_07,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608260004

T24gVGh1LCBBdWcgMTMsIDIwMjYsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gVGhlIGZvcmNlUk0g
Yml0IG9mIHRoZSBERVBDTUQgcmVnaXN0ZXIgY29udHJvbHMgdGhlIGJlaGF2aW9yIG9mIHRoZQ0K
PiBFbmRUcmFuc2ZlciBjb21tYW5kIHVzZWQgdG8gc3RvcCBhbiBhY3RpdmUgdHJhbnNmZXIuIE9s
ZGVyIERXQzMNCj4gcHJvZ3JhbW1pbmcgZ3VpZGUgcmV2aXNpb25zIHJlY29tbWVuZGVkIHNldHRp
bmcgZm9yY2VSTT0xIHdoZW4NCj4gaXNzdWluZyBFbmRUcmFuc2Zlci4gTmV3ZXIgcHJvZ3JhbW1p
bmcgZ3VpZGUgcmV2aXNpb25zIHJlY29tbWVuZA0KPiBpc3N1aW5nIEVuZFRyYW5zZmVyIHdpdGgg
Zm9yY2VSTSBjbGVhcmVkLg0KPiANCj4gV2l0aCBmb3JjZVJNPTEgb24gRFdDX3VzYjMxIHYyLjAw
YSBhbmQgdjIuMTBhIGNvbnRyb2xsZXJzLCBhIHRyYW5zZmVyDQo+IGFib3J0ZWQgdGhyb3VnaCB0
aGUgZXBfZGVxdWV1ZSBwYXRoIHdhcyBvYnNlcnZlZCB0byByZW1haW4gYWN0aXZlDQo+IGFmdGVy
IEVuZFRyYW5zZmVyIGNvbXBsZXRpb24uIEEgc3Vic2VxdWVudCBTdGFydFRyYW5zZmVyIGlzc3Vl
ZCBvbiB0aGUNCj4gc2FtZSBlbmRwb2ludCB0cmlnZ2VyZWQgd3JpdGVzIGFzc29jaWF0ZWQgd2l0
aCB0aGUgYWJvcnRlZCB0cmFuc2Zlci4NCj4gVGhpcyByZXN1bHRlZCBpbiBhbiBTTU1VIGZhdWx0
IGJlY2F1c2UgdGhlIHRyYW5zZmVyIGJ1ZmZlciBoYWQgYWxyZWFkeQ0KPiBiZWVuIHVubWFwcGVk
IGR1cmluZyBFbmRUcmFuc2ZlciBjb21tYW5kLWNvbXBsZXRpb24gY2xlYW51cC4NCj4gDQo+IFVz
aW5nIGZvcmNlUk09MCBlbGltaW5hdGVzIHRoZSBpc3N1ZS4gQWx0aG91Z2ggb2xkZXIgRFdDMyBw
cm9ncmFtbWluZw0KPiBndWlkZSByZXZpc2lvbnMgcmVjb21tZW5kZWQgc2V0dGluZyBmb3JjZVJN
PTEsIG5vIGlzc3VlcyBhcmUga25vd24NCj4gZnJvbSB1c2luZyBmb3JjZVJNPTAuIENsZWFyIGZv
cmNlUk0gd2hlbiBpc3N1aW5nIEVuZFRyYW5zZmVyIHRvIHByb3ZpZGUNCj4gY29uc2lzdGVudCBF
bmRUcmFuc2ZlciBiZWhhdmlvciBhbmQgYWxpZ24gd2l0aCBuZXdlciBwcm9ncmFtbWluZyBndWlk
ZQ0KPiByZWNvbW1lbmRhdGlvbnMuDQo+IA0KPiBGaXhlczogMWU0M2M4NmQ4NGZiICgidXNiOiBk
d2MzOiBjb3JlOiBBZGQgRFdDMzEgdmVyc2lvbiAyLjAwYSBjb250cm9sbGVyIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogRWxzb24gU2VycmFvIDxlbHNv
bi5zZXJyYW9Ab3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAt
IENsZWFyIGZvcmNlUk0gdW5jb25kaXRpb25hbGx5IGFuZCBkb2N1bWVudCB0aGUgcHJvZ3JhbW1p
bmcgZ3VpZGUNCj4gICAgcmVjb21tZW5kYXRpb24gKFRoaW5oKS4NCj4gIC0gTGluayB0byB2MTog
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI2MDgwNjIzNDAzNS4xMDc4NzA0LTEtZWxzb24uc2VycmFvQG9zcy5xdWFsY29tbS5jb20vX187
ISFBNEYyUjlHX3BnIWUxM09RMnIzbmlpM3F2LVZqaFY3TFEzSWNyT3dnaTJUZk9hZEpIdmk0andV
c0tUY2RVajU0V3dIajNYQ2FVY0oyQ09yQWk2dEJMemctX0cyQ1VQVVdjN05wWGhQZDJnNiQgDQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8ICAyICstDQo+ICBkcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIHwgMjEgKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gaW5k
ZXggYmZlNjE2MTk0ZGZhLi4zMTBiNWZmYjIzNmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiBAQCAtMzA0LDcg
KzMwNCw3IEBAIHZvaWQgZHdjM19lcDBfb3V0X3N0YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAN
Cj4gIAkJZHdjM19lcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RPUDsNCj4gIAkJaWYgKGR3
Yy0+Y29ubmVjdGVkKQ0KPiAtCQkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihkd2MzX2VwLCB0
cnVlLCB0cnVlKTsNCj4gKwkJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZHdjM19lcCwgZmFs
c2UsIHRydWUpOw0KPiAgCQllbHNlDQo+ICAJCQlkd2MzX3JlbW92ZV9yZXF1ZXN0cyhkd2MsIGR3
YzNfZXAsIC1FU0hVVERPV04pOw0KPiAgCX0NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IGZhMGYxNmZm
YWZlZi4uZGFkOTg2NmI5MDhlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTEwMDQsNyArMTAw
NCw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9lbmFibGUoc3RydWN0IGR3YzNfZXAg
KmRlcCwgdW5zaWduZWQgaW50IGFjdGlvbikNCj4gIAkJCSAqIGNvbnRyb2xsZXIgdG8gZ2VuZXJh
dGUgYW4gRVJEWSB0byBpbml0aWF0ZSB0aGUNCj4gIAkJCSAqIHN0cmVhbS4NCj4gIAkJCSAqLw0K
PiAtCQkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiArCQkJ
ZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIGZhbHNlLCB0cnVlKTsNCj4gIA0KPiAgCQkJ
LyoNCj4gIAkJCSAqIEFsbCBzdHJlYW0gZXBzIHdpbGwgcmVpbml0aWF0ZSBzdHJlYW0gb24gTm9T
dHJlYW0NCj4gQEAgLTEwMzIsNyArMTAzMiw3IEBAIHZvaWQgZHdjM19yZW1vdmVfcmVxdWVzdHMo
c3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCwgaW50IHN0YXR1cykNCj4gIHsN
Cj4gIAlzdHJ1Y3QgZHdjM19yZXF1ZXN0CQkqcmVxOw0KPiAgDQo+IC0JZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcihkZXAsIHRydWUsIGZhbHNlKTsNCj4gKwlkd2MzX3N0b3BfYWN0aXZlX3RyYW5z
ZmVyKGRlcCwgZmFsc2UsIGZhbHNlKTsNCj4gIA0KPiAgCS8qIElmIGVuZHhmZXIgaXMgZGVsYXll
ZCwgYXZvaWQgdW5tYXBwaW5nIHJlcXVlc3RzICovDQo+ICAJaWYgKGRlcC0+ZmxhZ3MgJiBEV0Mz
X0VQX0RFTEFZX1NUT1ApDQo+IEBAIC0xNzIwLDcgKzE3MjAsNyBAQCBzdGF0aWMgaW50IF9fZHdj
M19nYWRnZXRfa2lja190cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgCQlpZiAocmV0
ID09IC1FQUdBSU4pDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JCWR3YzNfc3RvcF9hY3Rp
dmVfdHJhbnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsNCj4gKwkJZHdjM19zdG9wX2FjdGl2ZV90cmFu
c2ZlcihkZXAsIGZhbHNlLCB0cnVlKTsNCj4gIA0KPiAgCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUocmVxLCB0bXAsICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkNCj4gIAkJCWR3YzNfZ2FkZ2V0
X21vdmVfY2FuY2VsbGVkX3JlcXVlc3QocmVxLCBEV0MzX1JFUVVFU1RfU1RBVFVTX0RFUVVFVUVE
KTsNCj4gQEAgLTE3NTcsNiArMTc1NywxMSBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZ2V0
X2ZyYW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAgKiB0aGUgY29udHJvbGxlciB3b24ndCB1cGRh
dGUgdGhlIFRSQiBwcm9ncmVzcyBvbiBjb21tYW5kDQo+ICAgKiBjb21wbGV0aW9uLiBJdCBhbHNv
IHdvbid0IGNsZWFyIHRoZSBIV08gYml0IGluIHRoZSBUUkIuDQo+ICAgKiBUaGUgY29tbWFuZCB3
aWxsIGFsc28gbm90IGNvbXBsZXRlIGltbWVkaWF0ZWx5IGluIHRoYXQgY2FzZS4NCj4gKyAqDQo+
ICsgKiBPbGRlciBwcm9ncmFtbWluZyBndWlkZSByZXZpc2lvbnMgcmVjb21tZW5kZWQgc2V0dGlu
ZyBGb3JjZVJNIHRvIDENCj4gKyAqIHdoZW4gZW5kaW5nIGEgdHJhbnNmZXIuIE5ld2VyIHByb2dy
YW1taW5nIGd1aWRlIHJldmlzaW9ucyBub3cNCj4gKyAqIHJlY29tbWVuZCBrZWVwaW5nIEZvcmNl
Uk0gY2xlYXJlZCwgYW5kIFRSQnMgYXJlIHByb3Blcmx5IHVwZGF0ZWQNCj4gKyAqIG9uIGNvbW1h
bmQgY29tcGxldGlvbi4NCj4gICAqLw0KPiAgc3RhdGljIGludCBfX2R3YzNfc3RvcF9hY3RpdmVf
dHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwgYm9vbCBpbnRlcnJ1cHQp
DQo+ICB7DQo+IEBAIC0xODgyLDcgKzE4ODcsNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3N0
YXJ0X2lzb2NfcXVpcmsoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIAkJICogdG8gd2FpdCBmb3Ig
dGhlIG5leHQgWGZlck5vdFJlYWR5IHRvIHRlc3QgdGhlIGNvbW1hbmQgYWdhaW4NCj4gIAkJICov
DQo+ICAJCWlmIChjbWRfc3RhdHVzID09IDApIHsNCj4gLQkJCWR3YzNfc3RvcF9hY3RpdmVfdHJh
bnNmZXIoZGVwLCB0cnVlLCB0cnVlKTsNCj4gKwkJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIo
ZGVwLCBmYWxzZSwgdHJ1ZSk7DQo+ICAJCQlyZXR1cm4gMDsNCj4gIAkJfQ0KPiAgCX0NCj4gQEAg
LTIxNjUsNyArMjE3MCw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZShzdHJ1
Y3QgdXNiX2VwICplcCwNCj4gIAkJCXN0cnVjdCBkd2MzX3JlcXVlc3QgKnQ7DQo+ICANCj4gIAkJ
CS8qIHdhaXQgdW50aWwgaXQgaXMgcHJvY2Vzc2VkICovDQo+IC0JCQlkd2MzX3N0b3BfYWN0aXZl
X3RyYW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1ZSk7DQo+ICsJCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5z
ZmVyKGRlcCwgZmFsc2UsIHRydWUpOw0KPiAgDQo+ICAJCQkvKg0KPiAgCQkJICogUmVtb3ZlIGFu
eSBzdGFydGVkIHJlcXVlc3QgaWYgdGhlIHRyYW5zZmVyIGlzDQo+IEBAIC0yMjQyLDcgKzIyNDcs
NyBAQCBpbnQgX19kd2MzX2dhZGdldF9lcF9zZXRfaGFsdChzdHJ1Y3QgZHdjM19lcCAqZGVwLCBp
bnQgdmFsdWUsIGludCBwcm90b2NvbCkNCj4gIAkJCXJldHVybiAwOw0KPiAgCQl9DQo+ICANCj4g
LQkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiArCQlkd2Mz
X3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgZmFsc2UsIHRydWUpOw0KPiAgDQo+ICAJCWxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShyZXEsIHRtcCwgJmRlcC0+c3RhcnRlZF9saXN0LCBsaXN0KQ0K
PiAgCQkJZHdjM19nYWRnZXRfbW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEsIERXQzNfUkVRVUVT
VF9TVEFUVVNfU1RBTExFRCk7DQo+IEBAIC0zMzY4LDcgKzMzNzMsNyBAQCBzdGF0aWMgdm9pZCBk
d2MzX25vc3RyZWFtX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCQlkd2MzX3Nl
bmRfZ2FkZ2V0X2dlbmVyaWNfY29tbWFuZChkd2MsIGNtZCwgZGVwLT5udW1iZXIpOw0KPiAgCX0g
ZWxzZSB7DQo+ICAJCWRlcC0+ZmxhZ3MgfD0gRFdDM19FUF9ERUxBWV9TVEFSVDsNCj4gLQkJZHdj
M19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiArCQlkd2MzX3N0b3Bf
YWN0aXZlX3RyYW5zZmVyKGRlcCwgZmFsc2UsIHRydWUpOw0KPiAgCQlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gQEAgLTM3
MjUsNyArMzczMCw3IEBAIHN0YXRpYyBib29sIGR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYnNfY29t
cGxldGUoc3RydWN0IGR3YzNfZXAgKmRlcCwNCj4gIAlpZiAodXNiX2VuZHBvaW50X3hmZXJfaXNv
YyhkZXAtPmVuZHBvaW50LmRlc2MpICYmDQo+ICAJCWxpc3RfZW1wdHkoJmRlcC0+c3RhcnRlZF9s
aXN0KSAmJg0KPiAgCQkobGlzdF9lbXB0eSgmZGVwLT5wZW5kaW5nX2xpc3QpIHx8IHN0YXR1cyA9
PSAtRVhERVYpKQ0KPiAtCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1
ZSk7DQo+ICsJCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVwLCBmYWxzZSwgdHJ1ZSk7DQo+
ICAJZWxzZSBpZiAoZHdjM19nYWRnZXRfZXBfc2hvdWxkX2NvbnRpbnVlKGRlcCkpDQo+ICAJCWlm
IChfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwKSA9PSAwKQ0KPiAgCQkJbm9fc3RhcnRl
ZF90cmIgPSBmYWxzZTsNCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5n
dXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=
