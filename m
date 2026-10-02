Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485F3D25A2;
	Fri,  2 Oct 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978149; cv=fail; b=WVOjx8G0U1A3mFmK3PDR/qWZlKcDetQgTGyE3CHqeUaGkY4DPkNKafjT8pJGLfEh2uE2S/oeOfDoaNbwgfnDYidCXpWwUTiviR1yKFmfN3jayCsPt/1v9uX3RKXXkVapt0FXwqounuVRei1AUusuTuxNqHkz89OgbnbEwr3XDio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978149; c=relaxed/simple;
	bh=hMy2tYTFBMMvlSL6mTPvH3OmHKuRsMkJlP+A8UEk66c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2QxxjQn/0Q711wkDGadrFGUcbpEd+kctKdN8FGygQoM/RtaSkieVx+sF+D6+tswfEz9uBaTsjsEvZYwVEe/qNCWUOmsTgIpvv+PvxLulgoGx0dB8L3k6zLDXfMuJiHEzzmSt4PUrKfD+qtOha3iKZpnmTx+vCC/J3dvQAtku1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=F43HLylo; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PWR6tNyP; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rOWbQFAy reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F43HLylo";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PWR6tNyP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rOWbQFAy"
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692L8Xql2860789;
	Fri, 2 Oct 2026 14:55:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=hMy2tYTFBMMvlSL6mTPvH3OmHKuRsMkJlP+A8UEk66c=; b=
	F43HLyloDUV8v0b3MKlWVos4yhSpkW3njYniNH2GCBQdFcbT3AXx5Qbc61fxqPEJ
	uhbYmev4jjjHyQ3MHIP+vkRyf6H4xIjD/DoWW4wD9Rnh/trn7zjIlCbZbmlvvwMB
	PcdepYrCjaqaz4abrA8I+3RHqSGYgDbaks55V0FuMYhsrGWt7s5hz6QbeXhSGMFj
	a4e+eHmXRBtzsTU4OIaTpi48lh8FG/XtDmtW8Dg5S6zHRuEfPbgpjueyVm98EBjM
	J98qQMwrOUMNuJFQZHKbArlBNSAq4kwVLTSHMrRbBo5ImWofPoIhnQuSQQWA0h/2
	zGnYcLG4EWEkcWDH3YVliA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4h246k697d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790978133; bh=hMy2tYTFBMMvlSL6mTPvH3OmHKuRsMkJlP+A8UEk66c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=PWR6tNyPf4v1QB8GqYyfbRIZVniZajLWzY1W3xHqUVY5JSz2n57I6zVgi2Br7a6V5
	 artWAELwcWKlGoZH71l8BEZc8RNj/Kkyqbs6cn/Y5Kwl5pdKh0ao1DR4fmnL/Ux5lZ
	 owhMf/5+E7TKXSuFemoB+b+yeYW0Dvs9cmJEiwBUwWXrhvwzjQ2XlCzKq+C1mVz2Oc
	 bToBBaz5NfOtJvTLcIIGCkLEUFRBM2+qtuZmhNe0zPul/xXE7kJJ9PAUf4L9lfs51v
	 S5eMQx6wcYts/uP/IK5C9Lr8xYBpUaXwFyV6QbyQnrpjpYcY/v1IXuR7N7GPjSub79
	 CVAbG6ELl/Vmg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BEBC640142;
	Fri,  2 Oct 2026 21:55:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4081DA0073;
	Fri,  2 Oct 2026 21:55:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rOWbQFAy;
	dkim-atps=neutral
Received: from CO1PR08CU001.outbound.protection.outlook.com (mail-co1pr08cu00106.outbound.protection.outlook.com [40.93.10.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6428240578;
	Fri,  2 Oct 2026 21:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6H5jUh3HOQGH7AHEprscoTew3ivzlEtpYEM/KxASbwBypVU0AMPZDe+cyWKEowHMXtHC+pz9QHf4W8ElWjcdvQYYmBJcsFNOIjTlT4MTswcF4WRnYpoi88WKs5I9LQlUvZYPvJ6jaf7LHyjd/QdTMxuqZ3S39ASBCMNmVnCzX9pt91TVMwZh6Bhp9qJz+xZVTYYl6U5PC1lXco81quO/O7HnCUbeIvdUr+EYSrPtCHd0ys3B9QG3UffHi9m8lucjLVpD1PTunKhNckXPINqwmodxfQAzZTzpzZzBN8GN/5D0/nhB/waVurxBqnow759ns14mcFmv15vmzczUPffYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMy2tYTFBMMvlSL6mTPvH3OmHKuRsMkJlP+A8UEk66c=;
 b=g0rDGkJ0QcTgYJctlRV31SkSv4kiH1i3OsNfNlpH5Ryc6PGqwIswq4y+sKUrsg1d1EIrRnjIKIHEzeTcU/VgZyeil4wcT8AqfSSOvYyQBkfaxgT/EWgefoAseWQBtglWawBgIjn40iQTtpveX9v1FWUSJtZIMPnpd5x4Nl5z0CHcN9VHZsB0R1MheaLI6qcUtnfo0/uRNSuakbynbmS3n3qOkGheu2SEslbyrzZEqOX7GHrEPpuJmSrgljGQ+6iF2dt17DfEk1UASLicwJLnsadux/cyZH67SwLJ1wF40b/HO2DGLUFzDSiNm+MJTftCdKVj0Wt8VMS9g+h/5iFREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMy2tYTFBMMvlSL6mTPvH3OmHKuRsMkJlP+A8UEk66c=;
 b=rOWbQFAy9pWpu2nWUnzZCbW94OGqsD7fm4MXrQDuBpfPnz4WcePtssWRc307SvjzE9QuDjtmqE/f3THhH+uUQNmJPCMYOwAxu+qkDUHeHNtBorx/mLWqyZ1AsAYvadGj+slM/a1sRDa14x9aMHkUeEImJ026WRZ09SZ/Ey1I6GM=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 21:55:24 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 21:55:20 +0000
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
Subject: Re: [PATCH v3 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP init
 error paths
Thread-Topic: [PATCH v3 2/3] usb: dwc3: xilinx: re-assert resets on ZynqMP
 init error paths
Thread-Index: AQHdT0EOPv1VOlEm+kWtWYaFdRUqYLbq0rWA
Date: Fri, 2 Oct 2026 21:55:20 +0000
Message-ID: <asAnAGfEqs0IF_xb@vbox>
References: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
 <20260928120015.3152461-3-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260928120015.3152461-3-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH8PR12MB7157:EE_
x-ms-office365-filtering-correlation-id: 0ea6b936-445d-43d7-b390-08df20cfdaab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|5023799004|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 4cgfT6hQVXQXNO+2BB3DhIv+rAafIl8Np6gSQYZoKRbg7hcMesksk6DiIe38KgoLTGUcQEr7/Ypcjp5HL5YjV8Lktpwy8tBqW7EmrRsG+wIUy5LGfiOawG73A2sjNAruud6MBBtjnAnSTP2DesbaOD0lZjHS5iCSMfkWqd60LM/SV50Mv2TkB1zyZ5SzrAh31pFiDtS1swBnz3W0AxQZXdE/YBPrKfT2ET2phlG300arfyOyWr3MyynvzWRuUEM9LEZ1ySDjCuUtj1kO1Vq2brXqbmGptPc7hJpwceyaXemMtRGWFcmG4/a7lB+7N1+TFWsUqnbhj6JS5m4gVtsK+RlQtMqdu6YgLt2de71tGynIH/9Rlq/MgwU/nVrJyKEpFmCS6ItSxeTLLByzui+oOJvAwx9sirJA8UKLD3BOgHiyopyST5t1XoSEJdmhHlhb/BxVgqTrtOy8oX96pyNnxcngRHFaF+0HGKe2zXaXnzn7phXmy5/8ZDEjlfrBBUgXsVOWv7I2wQVNMwo/AgCoGU0eDCMjSom7v4iEtT1xRNr6zEQMa3k5gc8kF1UtcGHX6BERBBLb9QqKqr6JD5VZ/ExZP/ABtWg/225kxgDvDTDYGSNyviyUMPOjQfCmJlFPsswyUIIbfWI4EFp2yjKd3maoK4kb07vx8Ig/GmXKhYykHpr1TiXUao09hhRN8ukQQZjzc/nfBfwqQ1pkGxnAwZXTbhLdmCy9ZpHYfHIqEQ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(5023799004)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWErVEFSd25ZTGt1T0pUQ3ZHRWZscTJtTEk0OTVIb0ZuejdwbzVOSEQzSzdx?=
 =?utf-8?B?dFlHNGpleHpsVWhFeDRGL2J1SUg3WlFhS2lQSXFLK1I1M0ZQbXMzb2N5NmYy?=
 =?utf-8?B?VENueTNlSUxwZmtBNXA3VXN2VHJ0ck1XVFFEWnVLM0ZsdFdxSmdOdk1jd2Vq?=
 =?utf-8?B?MTMwc3lveWRyNHRSQUF5cnpDUnQ1RnN0eTFmSGJ4M3U3STB0T2xBc29CNjFi?=
 =?utf-8?B?TzhsUTdQWWxlSWwvUGNCMWdnb2xVWS9SRUt1K2tTZXYwcXVLOGJUelNFTVhM?=
 =?utf-8?B?bWRYY0dEUUR3V3ZnbTJweHJRbitzZUdUakJMSXRVS1pjdDB0ZFJONzZXejFV?=
 =?utf-8?B?MitnOUxsczBvL0tJK3hVc2pSZDBYV0tYUytCaURRd1lXaWpWQ3RpZnpGTDdB?=
 =?utf-8?B?OTQzM3BaTWFrcU1aYktXam8vUkZhZ3I3T0x1SENVRkdlblloeVpJVkpJYm1v?=
 =?utf-8?B?djJrN3Nqckk1bDdFdVBkR29iRHNrbWJvaUhWS1VFR1NnV0pldEluN3BwaFBS?=
 =?utf-8?B?WXFUVkxjaEx4ZFgzV0x1WVllZE9IaUVtTlF0L3dJeW5HdjZxU2xOaVVMNU16?=
 =?utf-8?B?eXhjWHVGV2R3bDFOL2htd1ZkQnV5VUEyMVBUU0ROalI1SmJLRllkZjlzYWRI?=
 =?utf-8?B?RjRJRFY3ZlhRaGdHU3ovL3FyeDFQRGs2bk1mWW1JK0pMQlRWT2tFVk9VUFF0?=
 =?utf-8?B?TkN5RTMranNzb2VKSkJ5UmltcDVENnJvN29VVElGSGptK0dCTjlPb3ArTWFt?=
 =?utf-8?B?VGoxUVZpRUV3N2V4MWg0YkR1T1dpN3owSW9RZGxuTVFsbXJuc3lQVTI1YmpF?=
 =?utf-8?B?dVR0K1YxdW5zZEUzcEtMZ0t2allFbnI4bFRva09USFRhaTgwZUxPbXlIRlgv?=
 =?utf-8?B?dWpCWEV3QldTcnBuME9jYS8vallDTUhNTnpiZnNsdnorOG9JYUttcmovWkov?=
 =?utf-8?B?SFNCMGg4SDFWNUI3Z3l2WjBMZytYL2lobXRkSnF4aCs1SytiRlpuZ0hvWWdu?=
 =?utf-8?B?VGdTZ1c4M3RqTi9ZeHU4SFpCQkpzMit5RGRCb2JTTmhrWi8xYzZkQlA1VDRN?=
 =?utf-8?B?M3lYaFRDNzFnRVJuWWRmaXZUakJSSTZXUUhOcGdNR0x0bmNDNENsZ3Ava2FC?=
 =?utf-8?B?SjVPSEZyVUU2NGhSS3ZIM0g2RkU0U1Z6MU8xa29kMzFoaCswY1VmYWpsazhw?=
 =?utf-8?B?MXVhdk41d0hKb0pmT1FicVE1RHhCdE91cUIrczVsVjdHbkVUU0plc0xhRDlq?=
 =?utf-8?B?MlE0bFhJTGVsYzByRWJ6c2V2bHZudTAreU9INVFrUWM4QTJWMDVNYjF2b2Nq?=
 =?utf-8?B?Vmc0Z0ZlWTFFaVMwTStWODF4SkRzR2E0MjEydlFLSkJWcHVYMWx2K0MyNzFx?=
 =?utf-8?B?ek5rdXNjdHpKekJtTjRJV3huVUNXc0hPb3kxNldWd1dhSmg0TENPVlJ0VTJk?=
 =?utf-8?B?cjFXSk9Ub1hHWm9TQlFSREMvNnp4bHcyMk5IZEpqU1BFaUZHUEpRblZOc3F6?=
 =?utf-8?B?SzBndC9nc2swL0k5SU85MGRvTU5GVkZBai9QMm02dndJdFJGSUNzOExtUGgw?=
 =?utf-8?B?K0FGRzVaNHBuelUvMGtHMUlUamhWZG1iWExHYWtlMjBGeUpNYVZuMllQQzNr?=
 =?utf-8?B?SU9ORzBTckFrK3FpU1R5U3dacFFlUDQwSFNHaWpHUjVPdkIvVlVlZVFRS0xt?=
 =?utf-8?B?SDgwbC9TYXhiUys1cjFWbGRtTmMwRks0RE5xSm9FMGQxRDJFNWdJQWpDN3RK?=
 =?utf-8?B?MTZsVzFsZ2ttdGJEMGJuZGFkdlFCVDZWNkRRUVVVOXkydEJnaVRlMnplNXB3?=
 =?utf-8?B?LzlFcU45cHFiTTVncDQrelFtYmZNQlp6MG5YTm1UUENZOThQTTU0UC9XZW80?=
 =?utf-8?B?VTRFNmlGSFJPZFJlRGZreWFnNSt1TlE1YkVZb05iUmV0SytQS0pIWEtkcHBv?=
 =?utf-8?B?Z1Y0RW40eWJoTU1DRWJsQ1pvQjYwV3lkaWdKSzlWQUtUeXN2c3BHQXQwUzJL?=
 =?utf-8?B?M2hkSklCWlgyQnFpa01QMmVsam90MUVNenlHMDl3bzJESzVSUTkxb2o4Q1Rm?=
 =?utf-8?B?Y1hCUHZadDJXdzRkaWt2VUpZZmV5WTMyblNZV0N4Q1MwdXRqOUJuVzZrU2Zq?=
 =?utf-8?B?ckRkMzYzSEU5WjRUK2wxWUV0OUc5ei9VQnNnS0JPME44MlB5Q1htYUhpVVRL?=
 =?utf-8?B?c29XL0g4Rm5COElGem9mcU44SlhEUDkyYWNCaFI4K0U1a2xlMmNrMlN0ZVBY?=
 =?utf-8?B?c2ZQT3ZKUVQ4RUgrQmF6MklObjNBbmRRbWxIQm5ZYlJHUE5lNGV3UGQ0VkRP?=
 =?utf-8?B?MTJkWE92S2Y4MVVsbTNZR0hUNmoyUFFML1l6UzhpdFZFakFBcnJYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <892471C3B40D244F96F6C7F99D11AB13@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	3n7F5/LsHx4SuDASnFLTzDdd8pD8Kl7c65u9rSLvFXv4w1nQ37Eyu0dMp98Cay07lXGobtN0VgBgPWjpGilipj5mLk8v6Ty8wabEyoeZ+33/fB7fSxHRcbOT74fhOy6by5jvCBAfc7x3EKLASLeaPgyivJueSrbjiVRSAOKIvjdoBvrw95EMhcI9Xx8vqzeFPA1kVA0CV6/2LuGL51pg/KpYZEVE7tlU57eoB+f/OOQFE4vp8INjCPTOsZ9tKyRFUkLuDIkl5A2vI3NPEFsTq3fcGgKp+cll82cyrPEgCzrJDCtMeZ+lqDVi23wI8CPik1i1y6CXFuxfV4LpGzBz7A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1REZlX1BC5DEVtmPNnEcWKmD8R0eOOe0KFhVV8zM1xpbFlkZVwdbcki8SZxnWgwC5YVjL1rhnbm13bC00QpE16Q8jdWxDcMPqlR3rw8aSukVPJ2o2I1OSj5vOwbSXGypWyeHZgynmgQEvW3l05BUpS2QvUiqs7dn56IJJV+smNZ9H6yJrBmHqgSBCORZ4N54KNdUzs7LaoXGm3TjbLxvI5k0Uw3dgC5Ry8ki2SlXCVkUjNVhtRzQONr9uyNenT1iO+JKFn6qq29n2DFjKdRDL1mfZrM7B3j8eZiHJp1yLdiDE2y5ELigBw65uE437nhgjycR7z6NOh/kVWvQAjSlGg8PD+51lWK5psxkY9002Xn5XDWJ0183R22oGptLwl0ANpPzn3p9UvYq7oghBFmcTOBPf1gk1PYQSDEqKoN68gzV3ccENT/l2n5CVdVP8Tgn4JTIxpI8ZG87YYaW8sX6Q/g5a52Axet7upWK/cMscV2BtdHWLo8SvJpEc6lgyv0gYdDVpZjdGWLLQI8ywHDjBPn2hbxJmC9xJU/Tkbogqz5cpQelr5HhE8XRiZx6yof57zSoNEthIYmo1hG68X01wLA5D3rvi0i4VFovoHK5kmUgYan57h6qEpjvF+mLA/wHpuwkIeQ7dDJidtXdvT6Lbg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea6b936-445d-43d7-b390-08df20cfdaab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 21:55:20.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux2CwYZiK73y/jvIDNYzh60lrJHrgU6vJtL9UMyVI1DbL8afo8MDUqxU4kV57BsSQ3RXvBM+2Uv6PCocGkm9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Authority-Analysis: v=2.4 cv=d4ZgWhjE c=1 sm=1 tr=0 ts=6ac02856 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=Z1axvqkba8fCgk5pgvQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C8izP-N34bUDRBJIsx0bK1HmV92bEIto
X-Proofpoint-ORIG-GUID: C8izP-N34bUDRBJIsx0bK1HmV92bEIto
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4NyBTYWx0ZWRfX9LQdZhx8HOO/
 cNPzQBWQpxpllSBsVlu7O8nDycQM2//AdPa2yTaj2zU2vOXLZyh25ijLfFG5CuXqnevMU/3ocW2
 5q63Ayx5c+p79Gywp2XJCUwKGG0RQUw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4NyBTYWx0ZWRfX26+XZySU+UiF
 ugPpzI/jkhPh57egZZtwOFh2wVoJBEIFPuhW2jLKXeOB9mW9kQoFFtjGJjRfdANzedPLtGytF8Z
 zhc4g/h4JJ8X8rhbv+2KMq9KUyor/l5kGUWX1Xk9QpHVuui1Wu3+LSUJ8UHiMKLCtFlqCuuJ/UC
 mRN1nEj+EPm1MWDqlf+gl43z4rSzXgSr1Hrm+Npz2OF+I4GE1Cso9dSje326EgdfVXPoqUeMb7b
 wbvywoaddM1IseDmFBbrTiIM6KRaBIO4jqKs4YWHfI0GX4AJBAuqxrcICt3306JDu2TjR8L4f6y
 t3afJchrQk/o6E4pOeRJpnDwunCybEFvZ6QLqCTU6BIQIDcAtFn9OtI9sXLeZfD1aGuLwll8laN
 bjKUIVS9/ddNAydhfW8X4WXIa6GHqxxxunLz1zNzC/fu+P9IizHcO8pgioGF8j+FedAT2MgJu1D
 X3tYzqAaAWF/1i8F0vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610020087

T24gTW9uLCBTZXAgMjgsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IElmIHJl
c2V0IGRlYXNzZXJ0IG9yIFBIWSBzZXR1cCBmYWlscyBwYXJ0d2F5IHRocm91Z2gNCj4gZHdjM194
bG54X2luaXRfenlucW1wKCksIHJlLWFzc2VydCB0aGUgcmVzZXRzIHRoYXQgd2VyZSBhbHJlYWR5
DQo+IHJlbGVhc2VkIGJlZm9yZSB1bndpbmRpbmcgdGhlIFBIWS4NCj4gDQo+IE9ubHkgdW5kbyB0
aGUgcmVzZXQgY3ljbGUgdGhlIGZ1bmN0aW9uIGFjdHVhbGx5IHBlcmZvcm1lZC4gVGhlIGN5Y2xl
IGlzDQo+IHNraXBwZWQgd2hlbiBubyB1c2IzLXBoeSBpcyBwcmVzZW50LCBiZWNhdXNlIGFzc2Vy
dGluZyB0aGUgY29yZSByZXNldHMNCj4gY2FuIGJyZWFrIGEgVVNCMyBjb25maWd1cmF0aW9uIHRo
YXQgaXMgbGl2ZSBidXQgbWlzc2luZyBmcm9tIHRoZSBkZXZpY2UNCj4gdHJlZSwgc28gdGhlIGVy
cm9yIHBhdGggc2tpcHMgaXQgZm9yIHRoZSBzYW1lIHJlYXNvbi4gQXNzZXJ0aW5nIGFuDQo+IGFs
cmVhZHkgYXNzZXJ0ZWQgcmVzZXQgaXMgaGFybWxlc3MsIHNvIG9uZSBibG9jayBjb3ZlcnMgaG93
ZXZlciBmYXIgdGhlDQo+IGRlYXNzZXJ0cyBwcm9ncmVzc2VkLg0KPiANCj4gU2F2ZSB0aGUgWnlu
cU1QIHJlc2V0IGhhbmRsZXMgaW4gZHJpdmVyIHByaXZhdGUgZGF0YSBzbyBsYXRlciBwcm9iZQ0K
PiB0ZWFyZG93biBjYW4gcmUtYXNzZXJ0IHJlbGVhc2VkIHJlc2V0cy4NCj4gDQo+IEZpeGVzOiA4
NDc3MGYwMjhmYWIgKCJ1c2I6IGR3YzM6IEFkZCBkcml2ZXIgZm9yIFhpbGlueCBwbGF0Zm9ybXMi
KQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUNCj4gU2lnbmVkLW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBEcm9w
cGVkIHRoZSB1c2JfcmVzZXRzX3JlbGVhc2VkIGZpZWxkLiAgTm90aGluZyBpbiB0aGlzIHBhdGNo
IHJlYWQgaXQ7DQo+ICAgaXQgb25seSBleGlzdGVkIGZvciB0aGUgY29uZGl0aW9uYWwgdGVhcmRv
d24gaW4gcGF0Y2ggMywgd2hpY2ggbm8NCj4gICBsb25nZXIgbmVlZHMgaXQuDQo+IC0gQ29sbGFw
c2VkIHRoZSB0aHJlZSBjYXNjYWRpbmcgYXNzZXJ0IGxhYmVscyBpbnRvIG9uZSBlcnJfcmVzZXRf
YXNzZXJ0DQo+ICAgYmxvY2sgZ3VhcmRlZCBvbiBwcml2X2RhdGEtPnVzYjNfcGh5LiAgdjIgYXNz
ZXJ0ZWQgdW5jb25kaXRpb25hbGx5LA0KPiAgIHdoaWNoIHdvdWxkIGhhdmUgcHV0IGEgbm8tUEhZ
IGJvYXJkIGludG8gcmVzZXQgdGhhdCBpbml0IG5ldmVyDQo+ICAgYXNzZXJ0ZWQ7IHRoZSBndWFy
ZCBub3cgbWF0Y2hlcyB0aGUgaW5pdC10aW1lIGN5Y2xlLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBTcGxpdCBvdXQgb2YgdGhlIGNvbWJpbmVkIGZpdmUgcGF0Y2ggc2VyaWVzOyBzZWUgcGF0
Y2ggMS4NCj4gLSBSZW9yZGVyZWQgYWhlYWQgb2YgdGhlIHBsYXRmb3JtLWRhdGEgY2xlYW51cHMu
DQo+IC0gQWRkZWQgQ2M6IHN0YWJsZS4NCj4gLSBObyBmdW5jdGlvbmFsIGNoYW5nZSB0byB0aGUg
cGF0Y2ggaXRzZWxmLg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYyB8
IDU1ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGls
aW54LmMNCj4gaW5kZXggOGM2M2UwMjU3NWYxLi5kMjMxNTU3M2IzZDMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMteGlsaW54LmMNCj4gQEAgLTQ4LDYgKzQ4LDkgQEAgc3RydWN0IGR3YzNfeGxueCB7DQo+
ICAJdm9pZCBfX2lvbWVtCQkJKnJlZ3M7DQo+ICAJaW50CQkJCSgqcGx0Zm1faW5pdCkoc3RydWN0
IGR3YzNfeGxueCAqZGF0YSk7DQo+ICAJc3RydWN0IHBoeQkJCSp1c2IzX3BoeTsNCj4gKwlzdHJ1
Y3QgcmVzZXRfY29udHJvbAkJKnVzYl9jcnN0Ow0KPiArCXN0cnVjdCByZXNldF9jb250cm9sCQkq
dXNiX2hpYnJzdDsNCj4gKwlzdHJ1Y3QgcmVzZXRfY29udHJvbAkJKnVzYl9hcGJyc3Q7DQo+ICB9
Ow0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX3hsbnhfbWFza19waHlfcnN0KHN0cnVjdCBkd2Mz
X3hsbnggKnByaXZfZGF0YSwgYm9vbCBtYXNrKQ0KPiBAQCAtMTEyLDcgKzExNSw2IEBAIHN0YXRp
YyBpbnQgZHdjM194bG54X2luaXRfdmVyc2FsKHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkN
Cj4gIHN0YXRpYyBpbnQgZHdjM194bG54X2luaXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbnggKnBy
aXZfZGF0YSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2ID0gcHJpdl9kYXRhLT5kZXY7
DQo+IC0Jc3RydWN0IHJlc2V0X2NvbnRyb2wJKmNyc3QsICpoaWJyc3QsICphcGJyc3Q7DQo+ICAJ
c3RydWN0IGdwaW9fZGVzYwkqcmVzZXRfZ3BpbzsNCj4gIAlpbnQJCQlyZXQgPSAwOw0KPiAgDQo+
IEBAIC0xMjQsMjUgKzEyNiwyNSBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChz
dHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICAJCWdvdG8gZXJyOw0KPiAgCX0NCj4gIA0K
PiAtCWNyc3QgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X2V4Y2x1c2l2ZShkZXYsICJ1c2JfY3Jz
dCIpOw0KPiAtCWlmIChJU19FUlIoY3JzdCkpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihjcnN0KTsN
Cj4gKwlwcml2X2RhdGEtPnVzYl9jcnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNp
dmUoZGV2LCAidXNiX2Nyc3QiKTsNCj4gKwlpZiAoSVNfRVJSKHByaXZfZGF0YS0+dXNiX2Nyc3Qp
KSB7DQo+ICsJCXJldCA9IFBUUl9FUlIocHJpdl9kYXRhLT51c2JfY3JzdCk7DQo+ICAJCWRldl9l
cnJfcHJvYmUoZGV2LCByZXQsDQo+ICAJCQkgICAgICAiZmFpbGVkIHRvIGdldCBjb3JlIHJlc2V0
IHNpZ25hbFxuIik7DQo+ICAJCWdvdG8gZXJyOw0KPiAgCX0NCj4gIA0KPiAtCWhpYnJzdCA9IGRl
dm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgInVzYl9oaWJyc3QiKTsNCj4gLQlp
ZiAoSVNfRVJSKGhpYnJzdCkpIHsNCj4gLQkJcmV0ID0gUFRSX0VSUihoaWJyc3QpOw0KPiArCXBy
aXZfZGF0YS0+dXNiX2hpYnJzdCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfZXhjbHVzaXZlKGRl
diwgInVzYl9oaWJyc3QiKTsNCj4gKwlpZiAoSVNfRVJSKHByaXZfZGF0YS0+dXNiX2hpYnJzdCkp
IHsNCj4gKwkJcmV0ID0gUFRSX0VSUihwcml2X2RhdGEtPnVzYl9oaWJyc3QpOw0KPiAgCQlkZXZf
ZXJyX3Byb2JlKGRldiwgcmV0LA0KPiAgCQkJICAgICAgImZhaWxlZCB0byBnZXQgaGliZXJuYXRp
b24gcmVzZXQgc2lnbmFsXG4iKTsNCj4gIAkJZ290byBlcnI7DQo+ICAJfQ0KPiAgDQo+IC0JYXBi
cnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNsdXNpdmUoZGV2LCAidXNiX2FwYnJzdCIp
Ow0KPiAtCWlmIChJU19FUlIoYXBicnN0KSkgew0KPiAtCQlyZXQgPSBQVFJfRVJSKGFwYnJzdCk7
DQo+ICsJcHJpdl9kYXRhLT51c2JfYXBicnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9leGNs
dXNpdmUoZGV2LCAidXNiX2FwYnJzdCIpOw0KPiArCWlmIChJU19FUlIocHJpdl9kYXRhLT51c2Jf
YXBicnN0KSkgew0KPiArCQlyZXQgPSBQVFJfRVJSKHByaXZfZGF0YS0+dXNiX2FwYnJzdCk7DQo+
ICAJCWRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+ICAJCQkgICAgICAiZmFpbGVkIHRvIGdldCBB
UEIgcmVzZXQgc2lnbmFsXG4iKTsNCj4gIAkJZ290byBlcnI7DQo+IEBAIC0xNTYsMTkgKzE1OCwx
OSBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpw
cml2X2RhdGEpDQo+ICAJICogYWJzZW50Lg0KPiAgCSAqLw0KPiAgCWlmIChwcml2X2RhdGEtPnVz
YjNfcGh5KSB7DQo+IC0JCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGNyc3QpOw0KPiArCQly
ZXQgPSByZXNldF9jb250cm9sX2Fzc2VydChwcml2X2RhdGEtPnVzYl9jcnN0KTsNCj4gIAkJaWYg
KHJldCA8IDApIHsNCj4gIAkJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFzc2VydCBjb3JlIHJl
c2V0XG4iKTsNCj4gIAkJCWdvdG8gZXJyOw0KPiAgCQl9DQo+ICANCj4gLQkJcmV0ID0gcmVzZXRf
Y29udHJvbF9hc3NlcnQoaGlicnN0KTsNCj4gKwkJcmV0ID0gcmVzZXRfY29udHJvbF9hc3NlcnQo
cHJpdl9kYXRhLT51c2JfaGlicnN0KTsNCj4gIAkJaWYgKHJldCA8IDApIHsNCj4gIAkJCWRldl9l
cnIoZGV2LCAiRmFpbGVkIHRvIGFzc2VydCBoaWJlcm5hdGlvbiByZXNldFxuIik7DQo+ICAJCQln
b3RvIGVycjsNCj4gIAkJfQ0KPiAgDQo+IC0JCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGFw
YnJzdCk7DQo+ICsJCXJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHByaXZfZGF0YS0+dXNiX2Fw
YnJzdCk7DQo+ICAJCWlmIChyZXQgPCAwKSB7DQo+ICAJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0
byBhc3NlcnQgQVBCIHJlc2V0XG4iKTsNCj4gIAkJCWdvdG8gZXJyOw0KPiBAQCAtMTc5LDcgKzE4
MSw3IEBAIHN0YXRpYyBpbnQgZHdjM194bG54X2luaXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbngg
KnByaXZfZGF0YSkNCj4gIAlpZiAocmV0IDwgMCkNCj4gIAkJZ290byBlcnI7DQo+ICANCj4gLQly
ZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KGFwYnJzdCk7DQo+ICsJcmV0ID0gcmVzZXRfY29u
dHJvbF9kZWFzc2VydChwcml2X2RhdGEtPnVzYl9hcGJyc3QpOw0KPiAgCWlmIChyZXQgPCAwKSB7
DQo+ICAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlbGVhc2UgQVBCIHJlc2V0XG4iKTsNCj4g
IAkJZ290byBlcnJfcGh5X2V4aXQ7DQo+IEBAIC0xOTUsMjEgKzE5NywyMSBAQCBzdGF0aWMgaW50
IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICAJ
CXdyaXRlbChQSVBFX0NMS19ERVNFTEVDVCwgcHJpdl9kYXRhLT5yZWdzICsgWExOWF9VU0JfRlBE
X1BJUEVfQ0xLKTsNCj4gIAl9DQo+ICANCj4gLQlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0
KGNyc3QpOw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocHJpdl9kYXRhLT51c2Jf
Y3JzdCk7DQo+ICAJaWYgKHJldCA8IDApIHsNCj4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8g
cmVsZWFzZSBjb3JlIHJlc2V0XG4iKTsNCj4gLQkJZ290byBlcnJfcGh5X2V4aXQ7DQo+ICsJCWdv
dG8gZXJyX3Jlc2V0X2Fzc2VydDsNCj4gIAl9DQo+ICANCj4gLQlyZXQgPSByZXNldF9jb250cm9s
X2RlYXNzZXJ0KGhpYnJzdCk7DQo+ICsJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChwcml2
X2RhdGEtPnVzYl9oaWJyc3QpOw0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIHJlbGVhc2UgaGliZXJuYXRpb24gcmVzZXRcbiIpOw0KPiAtCQlnb3RvIGVy
cl9waHlfZXhpdDsNCj4gKwkJZ290byBlcnJfcmVzZXRfYXNzZXJ0Ow0KPiAgCX0NCj4gIA0KPiAg
CXJldCA9IHBoeV9wb3dlcl9vbihwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gIAlpZiAocmV0IDwg
MCkNCj4gLQkJZ290byBlcnJfcGh5X2V4aXQ7DQo+ICsJCWdvdG8gZXJyX3Jlc2V0X2Fzc2VydDsN
Cj4gIA0KPiAgCS8qIHVscGkgcmVzZXQgdmlhIGdwaW8tbW9kZXBpbiBvciBncGlvLWZyYW1ld29y
ayBkcml2ZXIgKi8NCj4gIAlyZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2
LCAicmVzZXQiLCBHUElPRF9PVVRfSElHSCk7DQo+IEBAIC0yMzAsNiArMjMyLDIxIEBAIHN0YXRp
YyBpbnQgZHdjM194bG54X2luaXRfenlucW1wKHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkN
Cj4gIA0KPiAgZXJyX3BoeV9wb3dlcl9vZmY6DQo+ICAJcGh5X3Bvd2VyX29mZihwcml2X2RhdGEt
PnVzYjNfcGh5KTsNCj4gK2Vycl9yZXNldF9hc3NlcnQ6DQo+ICsJLyoNCj4gKwkgKiBVbmRvIG9u
bHkgdGhlIHJlc2V0IGN5Y2xlIHBlcmZvcm1lZCBhYm92ZS4gIFRoYXQgY3ljbGUgaXMgc2tpcHBl
ZA0KPiArCSAqIHdoZW4gdGhlcmUgaXMgbm8gdXNiMy1waHkuICBUaGUgZGVhc3NlcnRzIHN0YXkg
dW5jb25kaXRpb25hbCBzbyBhDQo+ICsJICogY29yZSB0aGUgYm9vdGxvYWRlciBsZWZ0IGluIHJl
c2V0IHN0aWxsIGNvbWVzIHVwLCBidXQgdGhleSBhcmUNCj4gKwkgKiBkZWxpYmVyYXRlbHkgbm90
IHBhaXJlZCB3aXRoIGFuIGFzc2VydCBoZXJlOiByZXNldHRpbmcgYSBVU0IzDQo+ICsJICogY29u
ZmlndXJhdGlvbiB0aGF0IGlzIGxpdmUgYnV0IG1pc3NpbmcgZnJvbSB0aGUgZGV2aWNlIHRyZWUg
Y291bGQNCj4gKwkgKiBicmVhayBpdC4gIEFzc2VydGluZyBhbiBhbHJlYWR5IGFzc2VydGVkIHJl
c2V0IGlzIGhhcm1sZXNzLCBzbyBvbmUNCj4gKwkgKiBibG9jayBjb3ZlcnMgaG93ZXZlciBmYXIg
dGhlIGN5Y2xlJ3MgZGVhc3NlcnRzIGdvdC4NCj4gKwkgKi8NCg0KVGhpcyBpcyBvdmVybHkgdmVy
Ym9zZS4gSSdkIHJlc2VydmUgdGhlIGNvbW1lbnQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlDQpvbmx5
LCBhbHRob3VnaCBJIHN1cHBvc2UgaGF2aW5nIGl0IGRvZXNuJ3QgaHVydC4uDQoNCj4gKwlpZiAo
cHJpdl9kYXRhLT51c2IzX3BoeSkgew0KPiArCQlyZXNldF9jb250cm9sX2Fzc2VydChwcml2X2Rh
dGEtPnVzYl9oaWJyc3QpOw0KPiArCQlyZXNldF9jb250cm9sX2Fzc2VydChwcml2X2RhdGEtPnVz
Yl9jcnN0KTsNCj4gKwkJcmVzZXRfY29udHJvbF9hc3NlcnQocHJpdl9kYXRhLT51c2JfYXBicnN0
KTsNCj4gKwl9DQo+ICBlcnJfcGh5X2V4aXQ6DQo+ICAJcGh5X2V4aXQocHJpdl9kYXRhLT51c2Iz
X3BoeSk7DQo+ICBlcnI6DQo+IC0tIA0KPiAyLjQ0LjQNCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBO
Z3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNCkJSLA0KVGhpbmg=
