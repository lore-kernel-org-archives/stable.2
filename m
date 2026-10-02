Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2820360ED1;
	Fri,  2 Oct 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790977814; cv=fail; b=eMTkP6cNlv9CCdVAnq2UBzDIexVog0RTGvZw7y6mz8OJ1ic7VaLfC4TefqGts1gzCioWC2g305PMCVKHBCAPlQ48PBVPybqJlSpScKG4C7+yv4CB9yqXbQNshLfVUYn31/MSxzDbYgOCYG+Y6FgxBobh846YmhT5zvqFESgNUJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790977814; c=relaxed/simple;
	bh=qC66aIPwo8UcMga56FS5MS3kIx5Am9/G0U7dKxc+xAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=accm46Hy3nBCSZHbyw7CT7S4s+WvfaPQouyF74lEvEAHe9LqSpsVVDNTUjq3Z1IPL6ZoAZOqiq2btWOXwbCfaG+0iKUqgxN47vmIGe9qdNYSR8QDRPkN+EPPC7ogmo+sNs9UuixbMiu1xKTL8Ib0/SjcrHmPu/O7tspOXaq+SBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Jcf4Yq4v; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cW8QzVC+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AhqapAG9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jcf4Yq4v";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cW8QzVC+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AhqapAG9"
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692L8exi710868;
	Fri, 2 Oct 2026 14:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qC66aIPwo8UcMga56FS5MS3kIx5Am9/G0U7dKxc+xAI=; b=
	Jcf4Yq4vEp7dVH60OHbnBAIuruhJXW2B4S8gu1oBCKuugKUS+m6pHJr1V31xnvPq
	NFTVK8YMtGe3+vT7VnsQBDERqahVET8FUTm/WzY15Xz038hkeS0YW+kd8aaV+G1K
	SiT9NVW9Y6eRwfwuJVD8+XukFuXrX1KDEnhjwIV8gjpX9zStFoia6oNCyUcuOw+O
	YSp1woNeB7H50117mOysU/PxJm9M3/tIqxaZ2opfE1KoQvrQxphwp72XyhxMqKKp
	Gl7cLzpgskXxYuADWX2vQuQG58puhY5FxMmN2aH3M7Sivcm0GMkiOdbTZ9Su7D2o
	AaMDaZrGrF7Q8TPLpnRSLg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4h28qymxvx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1790977800; bh=qC66aIPwo8UcMga56FS5MS3kIx5Am9/G0U7dKxc+xAI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cW8QzVC+AceRYVROp/fySI2vFCL/3E0NFi9ke3xIdU2jhgrJosroabzIDSl4+9CvA
	 2apu2rphLEnIHfZVSPKhqAdyvKIqSPJNcqtYDrsruIPd4L0kn6n8U41KV1Ab4DRSyf
	 Z67hUyVS2MeWIWCL2Irp+ziXORevqxlUZZ7azAXPJ/sVwNvB8cZLL13WTpvuYNWDFe
	 V6dIHCTBncDKEUMJJ9SWQvVwzxL6WxAqVaDEgdbekWw0z+QbVB8pSDfKJyDyZ1NHcP
	 y+jJLMFlfb9XTnCPCfrUTFOXcopV5lpIVxydu1CvCl9wV9LkYBMHp7g0yq2mfDeobz
	 1nku0LbPme9zQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B365140136;
	Fri,  2 Oct 2026 21:49:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8126AA006F;
	Fri,  2 Oct 2026 21:49:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=AhqapAG9;
	dkim-atps=neutral
Received: from BYAPR08CU003.outbound.protection.outlook.com (mail-byapr08cu00300.outbound.protection.outlook.com [40.93.1.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert SHA2 Secure Server CA" (not verified))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 53E204011D;
	Fri,  2 Oct 2026 21:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BodaAWXhSFp6xWSoiglTOH0+Vu6y6jn+8oWfx1Jaf16IMjF7ygiVCUM/9cs5s2W5H8IqRiDySfBvhDj+NyToYqm2RHcC7FS80qGZzP+4/noFiF251sxo1W0H0oH03yonkN63uJOz94+I9wW7HbMSjS2nlOTGBcro2JvPlXOSgmwNafZ17dSp57qmifN/+J8qmLicZNaIbeshsr10b/O+rv5gkVd6dJy0IAEGGooU9RjcMpZ3Udx0m0s71N8XnH0u6/uN1t4zctIqY1wytmUuRZG7fNDXbJwJtOkuVcb2eJ1XsCm46ViKq6CXOQeQ0kgjl0fL79JyxAcYpb6O8eaCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC66aIPwo8UcMga56FS5MS3kIx5Am9/G0U7dKxc+xAI=;
 b=Kt1QSTWCm+bx9HzLrT7A/bFiBHCvtvxGsG9BL7nRVFxlFZZJzxjuZWulYEQJtUKyJ9JtmKX1mC8xJ2sHeDHPM06jIeVkX2WILNK0cClGLwMpPGGq6pdWyfdRZtxMtS6DhIpdsTF/RQd6EckgUyjheuYcfeCE5PQuNQrgFs/xRWTndNH8hGf5czunIRdahoshIq+CU9gJpemwtU/WCRbXtW1rpGEYEfV6OFxfeyBNS1O06+8qxdUjyhGQZmZg6cdk6XQ+yXWKSrUopwVkVCSwQJyeyKJ0kxURyG2xVARetjb8/WW+frvrgem2g3/sb0+PxFnLXaIu4rdk0npscKqFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC66aIPwo8UcMga56FS5MS3kIx5Am9/G0U7dKxc+xAI=;
 b=AhqapAG91Zzu03gpPMgjzRy8Lxi7jLglVgSgJfwm0gvIZaRPutQsRys2S3ql39zLNjvRe/pnYl489r2aal3/zFcAl94rwBz0VJCtJYeeyQChcF2YOiexHrgEGomKl3+nuqk1iHy9nsEyVh2eBxjC1UpsDsCL5DyyHHBf5HhSLco=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 21:49:50 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 21:49:50 +0000
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
Subject: Re: [PATCH v3 1/3] usb: dwc3: xilinx: fix system suspend and resume
 PHY handling
Thread-Topic: [PATCH v3 1/3] usb: dwc3: xilinx: fix system suspend and resume
 PHY handling
Thread-Index: AQHdT0EQzgnoCUj84EeyE8J0VwsHtLbq0SoA
Date: Fri, 2 Oct 2026 21:49:50 +0000
Message-ID: <asAhqc7JqwugJkp3@vbox>
References: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
 <20260928120015.3152461-2-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260928120015.3152461-2-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|PH8PR12MB7157:EE_
x-ms-office365-filtering-correlation-id: c5ce90fb-71c3-43a9-5100-08df20cf15d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 y+hOYB3cHMoqbTSnZ2vlLUXsIuKn9OmdvMHPd8Nl1fa69OTFokHokuMjxZIyC/+NznQNXbuBFPphjVgGkp1fx8k2LTt7OfF0pJyBd3GYXiKif+ixYVMIOLN3iL4kfkd6APyaiUaTFFLRxOAPB4TDeuL+Ynju5vhIC9YAdoVELGxN6dUwQAbyri9QVuXj+XU4xc1bkcjAKCmg46kPSNZCyV9Wml3ZMyY8LrZcj+k+T9WpCAH45do+SALtNJGFzS9ttfSlMshdUzZl4o3490F+ZMrGOb/7Bf2PLd+RSoKmTuccdJdJd4UIb8fjxXC9Zn9dlk0B/m27+RRwrh+ljppX8HCnkv7lDy5jdIJpORle0QJpqcVZph/pEeuMgJRsGXwIS2RBermTqI6Awrjaax9PW+5s8wtBZjnH9TuFsqDCYXCyvtLLE3YWOksShpWQHvhEtwo15pNJDJrVSlo9slBvAmWJHR/fW6QzaNUx1ZwTbhqA18PBAyI8pcGR8rzguqlgLnjK5b0MSTI8YE8VbdxDAORz/yFpVNEFBNCdynHd9vhx+J8ah30Ho7qtRfs+czyEMTMoPQgJtcwr2pRRC3esFijIQt150VmxQuX174+YZqf8/mGOrSsCoSb2+cPF82mGcA26+cr6RtnnqE+4beD5zot5ZEY7fgjjufhkTBODFVVvuAeYzIMCFEMMOL2gNhY6pjR59Ch56I6xZvhWFX7F0zpDxNgI1EjCWuGugGBpWEk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEc1Y1RlNWtiQkJxTlVEdnJ3dW13VDUvYmt1MFVjWTMxN2J2QlpyMlFZdXl0?=
 =?utf-8?B?dWhhZmcyKzJGaTA3eTFUNEFrb0FEMy9qa0thdEJKV3o1cVByT3l1Z2xKRFJr?=
 =?utf-8?B?K0doTkRMd1IvdlFjM1ZpUDBaNXEybGl0UzFSL0cwMmEvZkpjU1VZUE5uOUhr?=
 =?utf-8?B?VFdrR0kvdytVemhzWGg1Unp5dzhDa2pGYTNNTkV6Ykh6WlpqVXhzOTFESitu?=
 =?utf-8?B?d1RRNkhNOWhaYWV5bmJGOXdJK3hQa1B3OG5GT2c3QzRKUHovQ1JXN2cvUTFG?=
 =?utf-8?B?QWxBdDV2UGdEcDRlK296OTFPaGJLYWhYWHRpWmZIYzNoQTNJMzlzLytqN2JW?=
 =?utf-8?B?RVYza3l2R1FYbzcyZmxmQjZsU1ZNalc3M2RSNDRJWXJsaytYZzRRbnkzTnc2?=
 =?utf-8?B?b2xPVk5NVC9VaUNna0pISzVGcEdIUHNkV2pic09OM3k4ek5RcUM1NWV0ZGox?=
 =?utf-8?B?ZEkxQ3pSVFBSVEFWR2dTdDd4aDd4cWZmb3c4M0VhNXpDUXdIaFIxU1VGWG9h?=
 =?utf-8?B?R0tEYlVyWmZUdmVuY1dkM0l6WS9walVlYkR6U1Z6N2xzUGxrM1VnZnExazlW?=
 =?utf-8?B?NE43MC9GeTZPOHl3clg0QU96Mjc4TU9uVHRwVWNFaEpkd1ArSEpNZ2grVHk0?=
 =?utf-8?B?a3dEcG9UUzhEOExMYmMraCtQQjRhMjV5ckFRRDVieklsb0ljMVBpSm9jUzdo?=
 =?utf-8?B?UkNDY2JNU0hIcGFPZVZOT0dYbzg2VjdQYVlqRGRTcUV2RDFqOVA2N3pJdkYy?=
 =?utf-8?B?b1psSWo5ZFRLNEc3UWMreFJ6STJzOG5ZQUJJQ2JVWjlzR1dGZHFaMEVPQndJ?=
 =?utf-8?B?VzRidVRBOWpVRFBMaFdtSHJIRjlBYjdRcHh4UXRtQVg4VkJRNmdXaHRvZFB2?=
 =?utf-8?B?MWFBdWdtcXpXNDZjK1I3RXdSOWRwZDhDS1AvN0ZtL05YMUdNaE84ZFhoSk8w?=
 =?utf-8?B?b1draGFNZ09TTnE4Wm1iaHQ3aWxRclMyczNVZDlTUGpHUXhTT3VGUDBBNDJ1?=
 =?utf-8?B?cnQ1SFNabGVMemJaQUM5T3VmOHFEUHBPeWhjaEVQQUxDWGt5TWhwcVN6dWtW?=
 =?utf-8?B?aFh2Y0dOYTlPQnh5SE9Pbkx4TEk2QmNVSCswL0g1THJDVkh6UXVxeTVCT05I?=
 =?utf-8?B?c0VDeGI0SDdpbDQxWjZadUxCTEwzc1N1WjZ1YzlmVVlTUGRYSjk0NXpiTGxJ?=
 =?utf-8?B?T1U2Q05acTZyYU9Kc1JwdE1pZ0QxSVVrZExBWXZJb2lBeDFXOXFDUVk1WFF6?=
 =?utf-8?B?TDdWVVVSTXRGUll1cnl6UlRkWnptRlBPdFJsT2hLQWlZTit3ditnd0RCRFdJ?=
 =?utf-8?B?OUVYaURDKy9aZ1lXYTQvd2k4QUREbWdVRjB2dkZSZG4xYzlhZ3lMcmppL1pS?=
 =?utf-8?B?Y3BySnYxL1BOVlFaUnQzSXl1TW9FQ1BFNklaRmpobkpjN01EaUF3OGkreW9F?=
 =?utf-8?B?TExjYVBEMm9KNlM3NXB4OUtZZ0RlRkdKeHJhTm8yb2E0SEZ1U1pXbjZqanJF?=
 =?utf-8?B?ajFrK3pKeFNrdmxwRnd0QkkzQlhGRGEwWDNnSGhLMDJDTlZkNzF4T0JKYVpn?=
 =?utf-8?B?UXBmcTBNMXBFNGo5NDFpak1lQzB5dzYyazUrUnczSjJVVDExbTNqd3BVRGNq?=
 =?utf-8?B?eG51RHB4VlVVVDJVcHZlSmk2Y1pSTjByZVhJeU1PNWcwTDFCWkNadVBiczJI?=
 =?utf-8?B?aWhyWkNER1JsWTFOMU5GN1U1ZmQ0YTZ2anAyL3FybGtFckgxeGVoaVlkd0xT?=
 =?utf-8?B?dUZZcDcrempoVTBKTjd0WjJsZnNRenpMcHdRVVk1eXBTM2QvMlFsSksrU1FP?=
 =?utf-8?B?T3dxYitZZWRXSVluaFRnLy9KSmNOc3dTZGRKcHhVSGUrakFwZWlmNURVeW92?=
 =?utf-8?B?R2dwbGtlbUs0RDh4dlBDUFFVK3R5NU92b1EwY1BDSTFXVFAwTFVrUGZDVjhB?=
 =?utf-8?B?M1czUXFKRlhCQ2RGODIvckk3SE9BMWY4ZmZnbGxHOGZWbWlrNTNCQ2lwSnpU?=
 =?utf-8?B?N2NWeitoMGpKQ0JXQVpJMlMzQnRKVXMwb2xtWlppaFNOWkQ1MDZDaGwyVGNa?=
 =?utf-8?B?Rjh0YXVLL3k0azJaeGNpaSt2ZFozZzZkMjFaT1FqOU51WUxMQ2F0RTlYNkdW?=
 =?utf-8?B?OHVlWjBnYmFLTDJJei8zWU9qdkUyMHJ3YjBkcEltUkZTNjlBYWJzclZ2YlRM?=
 =?utf-8?B?RCtubHlMMkN6QmFnR1VrdnNvMG5vRzc2L1JkQXo5Z3hMdDJyVEZqcUVWNkxS?=
 =?utf-8?B?NUdIT0pKTDJKL29sUUlrb20vU2JlZFQ1Q1VHTlFGSytJZkwxRTFqZmExNW81?=
 =?utf-8?B?QUFBOXNxMWtVb1ZWYVVqTC90eG9CNjdjby9VVTVpdGgrS3gxUzIvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <939755ADA5DF9440A1AA819E2EBFD2E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dRbcm/dBAjgEUOeGZ0/+hgl8TXQTo7x/ygpv8SkvJ4zkIcLxTCYcvAAVU+SfcZfxzgFdSjkr8AadQtNypmg4FDOBMaj4R++KIQ+PapDY6BZZnJJ7t4J7wzFkMUQA9ezxDlaUFPcKO4sGNHPanvPQia/wVMzuYPYGDsA80Htsr0jpz2rLpTaDyT434PTTw/9EThXcIbrqOIQP7xo+mD1+G5Yyqtk2QdAUIVW+0PVeY8umCe5+tWlJblWYg6oiH5nJ9VxZ1gqr/qCbQbo5Hp7nI+6fbVY33WQGe0iKyVFXp9w3GaFw3amTgXx/OUNBltzkHgakXcncSfYEmKGD1kjVkA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CY7pkPSYBLXwLzZtSF0yfbTYHaorySPyQjPaeg3hOKvSdGhs8bklkw7xlMk7M2L9X6CXv+nHYj16LXFLwPw/IYq5tJQ+fFOmB/0kZ/TGh7txUmWWAJ4Uw40Z1mfv3o2zRktQ0EsOvk4iLVJ8tlap0uezSgHDTllmD9JvImopyjUbl2sJF4pDZI2KLYmQD/PbwFYCHdPHwSWL7Oc0J56IG+Z39REnoVQSBijVs48+3tKNiKy1baNuRffzUy1hE6UIQHVnjzNMK6a/uYY1pXVeBgUa5lmEfpCBngwzAoSdYmuiawAJGQL3ZW3/B9MfxOXINDw/tevqN8MVStjH/RqiJVowdxpXQole/c/MkF2JcS0jzxp/vC3DG0W/IQ+0VQ4do2AnWoMYAyeeWaso3o1J3hdNN6V+LnJn1+9AXqvpY1sBNrn3V/umc1CCA3Wwy5tt0RVsJqAZZe51bPsHyE6iCvv4PqpVlUACOjOH/5aGrnSvYO2LvKHc2adA+XZKfywRKTctVduvFK+m7b5VywhcDOFpvLZZ7YUYLpS/bX4e5fQttP3lVg3ZgzT/I9fNLFi2fLgvBVlG0BR1ciU3epgS6EJEUztXqhpr/aSdECSfQcIfISDzC8yt1ZhFcuM1vf7N448b0aA6Uu0pypXijRoOJQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ce90fb-71c3-43a9-5100-08df20cf15d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 21:49:50.6070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84P5VVpo/LM9cHaKiZ6/rzfEn5NzrFyZusvkfA0ygg5rc8OLqCIrwglf+LBR8Ftorf9zmCjBxB9SF6j4qQm3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA4NyBTYWx0ZWRfX0wEaFAEk9Ibw
 wuxFc1USAETXlX1A0+QNKAHzkNf3uwKUYmIQIAOxzwViVvmBDpB0UOobAxHnQ5VyZclXv7NmUer
 /4HX5X9sVfZHqAxMT8DbKKsqBdB3kps=
X-Proofpoint-ORIG-GUID: tnqm2R2-eDE_Bkbjyomct-5waNmTl8fS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA4NyBTYWx0ZWRfX/VUzmFoDQ4Ns
 BCZfiT9axFjQM3VkcULtTvGlDX2BNL6fw/U4A6/qAAiN90mFBtmQBBGVIcO6GAB2CEuluR3t1Sa
 jOsjhwNPL0velp1GofADxZdYnUWrbBN5pNpXIhiJx4aJ9JGT+nMcnPVgqLRzPLmOm+pHp16sRnR
 EfTgCDlkzF3Rqx3wcblCxvinUHjjpeXulKYTPIBK519q+J6PqEBG5/v7MxybD6Hw7KfXcIferXU
 EbZLnkBuWdt3bLAQ7MADU5u1QK0dODCOn+g3J/SmUpXnAeWGfOR3zocc/cfLGfXtnjIhXIuNubS
 eyT/77YFGJa71BXPrKPqOfoSyqxLDPpdHbitaZTbec5Q1GVF0rpQ24AN0y4urE9u1Rr6sKuVA06
 uHqzLqwQBPG2eTSPbg3iecspWjSkJzkNyLKoxXtJiYiupiJzq0P+AQubYIZ8Hi6eNvVxRyZruIS
 A3m/x5NQ3h+lDBK/w2A==
X-Authority-Analysis: v=2.4 cv=Vrm2kO2n c=1 sm=1 tr=0 ts=6ac02709 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=jIQo8A4GAAAA:8 a=LCXRTY2cuyGu7DlhGkIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tnqm2R2-eDE_Bkbjyomct-5waNmTl8fS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_06,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2610020087

T24gTW9uLCBTZXAgMjgsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IFN5c3Rl
bSBzdXNwZW5kIGFuZCByZXN1bWUgZXJyb3IgcGF0aHMgZG8gbm90IGhhbmRsZSBQSFkgYW5kIGNs
b2NrDQo+IHJlc291cmNlcyBjb3JyZWN0bHkuIFN1c3BlbmQgY2FsbHMgcGh5X2V4aXQoKSB3aXRo
b3V0IGZpcnN0IHBvd2VyaW5nDQo+IG9mZiB0aGUgUEhZIGFuZCBpZ25vcmVzIGZhaWx1cmVzLCB3
aGlsZSByZXN1bWUgY2FuIGxlYXZlIGNsb2Nrcw0KPiBlbmFibGVkIGlmIFBIWSByZWluaXRpYWxp
emF0aW9uIGZhaWxzLg0KPiANCj4gUHJvcGFnYXRlIGVycm9ycyB0byB0aGUgUE0gY29yZSBhbmQg
dW53aW5kIHJlc291cmNlcyB0byBlbnN1cmUgYQ0KPiBjb25zaXN0ZW50IHN0YXRlIG9uIHN1c3Bl
bmQgYW5kIHJlc3VtZSBmYWlsdXJlcy4NCj4gDQo+IEZpeGVzOiBkNmVkY2RjMWVmMDYgKCJ1c2I6
IGR3YzM6IHhpbGlueDogZml4IHVzYjMgbm9uLXdha2V1cCBzb3VyY2UgcmVzdW1lIGZhaWx1cmUi
KQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUNCj4gU2lnbmVkLW9mZi1ieTogUmFkaGV5IFNoeWFtIFBhbmRleSA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBOb25l
DQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFNwbGl0IG91dCBvZiB0aGUgY29tYmluZWQgZml2
ZSBwYXRjaCBzZXJpZXMgc28gdGhlIGZpeGVzIGNhbiBiZSBzZW50DQo+ICAgYW5kIGJhY2twb3J0
ZWQgb24gdGhlaXIgb3duLCBwZXIgcmV2aWV3IGZlZWRiYWNrLg0KPiAtIFJlb3JkZXJlZCBhaGVh
ZCBvZiB0aGUgcGxhdGZvcm0tZGF0YSBjbGVhbnVwcy4NCj4gLSBMb2cgYSBmYWlsdXJlIG9mIHRo
ZSBwaHlfcG93ZXJfb24oKSByb2xsYmFjay4gIHBoeV9leGl0KCkgbGVhdmVzDQo+ICAgaW5pdF9j
b3VudCB1bnRvdWNoZWQgd2hlbiBpdCBmYWlscywgc28gaWYgdGhlIHJvbGxiYWNrIGFsc28gZmFp
bHMgdGhlDQo+ICAgUEhZIGlzIGxlZnQgd2l0aCBwb3dlcl9jb3VudCBhbmQgaW5pdF9jb3VudCBv
dXQgb2Ygc3RlcDsgdGhhdCBpcyBub3cNCj4gICBhdCBsZWFzdCB2aXNpYmxlIGluIHRoZSBsb2cu
DQo+IC0gQWRkZWQgQ2M6IHN0YWJsZS4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMt
eGlsaW54LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy14aWxpbnguYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy14aWxp
bnguYw0KPiBpbmRleCBiODMyNTA1ZTFiMDQuLjhjNjNlMDI1NzVmMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXhpbGlueC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy14aWxpbnguYw0KPiBAQCAtMzgzLDEzICszODMsMjYgQEAgc3RhdGljIGludCBfX21heWJl
X3VudXNlZCBkd2MzX3hsbnhfcnVudGltZV9pZGxlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHN0
YXRpYyBpbnQgX19tYXliZV91bnVzZWQgZHdjM194bG54X3N1c3BlbmQoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiArCWludCByZXQ7DQo+ICANCj4gLQlwaHlfZXhpdChwcml2X2RhdGEtPnVz
YjNfcGh5KTsNCj4gKwlyZXQgPSBwaHlfcG93ZXJfb2ZmKHByaXZfZGF0YS0+dXNiM19waHkpOw0K
PiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJcmV0ID0gcGh5X2V4
aXQocHJpdl9kYXRhLT51c2IzX3BoeSk7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCWdvdG8gZXJy
X3BoeV9wb3dlcl9vbjsNCj4gIA0KPiAgCS8qIERpc2FibGUgdGhlIGNsb2NrcyAqLw0KPiAgCWNs
a19idWxrX2Rpc2FibGUocHJpdl9kYXRhLT5udW1fY2xvY2tzLCBwcml2X2RhdGEtPmNsa3MpOw0K
PiAgDQo+ICAJcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9waHlfcG93ZXJfb246DQo+ICsJaWYgKHBo
eV9wb3dlcl9vbihwcml2X2RhdGEtPnVzYjNfcGh5KSkNCj4gKwkJZGV2X2VycihkZXYsICJmYWls
ZWQgdG8gcmVzdG9yZSBQSFkgcG93ZXIgYWZ0ZXIgc3VzcGVuZCBlcnJvclxuIik7DQo+ICsNCj4g
KwlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGR3
YzNfeGxueF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiBAQCAtNDAzLDE1ICs0MTYsMjAg
QEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBkd2MzX3hsbnhfcmVzdW1lKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gIA0KPiAgCXJldCA9IHBoeV9pbml0KHByaXZfZGF0YS0+dXNiM19waHkpOw0K
PiAgCWlmIChyZXQgPCAwKQ0KPiAtCQlyZXR1cm4gcmV0Ow0KPiArCQlnb3RvIGVycl9jbGtfZGlz
YWJsZTsNCj4gIA0KPiAgCXJldCA9IHBoeV9wb3dlcl9vbihwcml2X2RhdGEtPnVzYjNfcGh5KTsN
Cj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlwaHlfZXhpdChwcml2X2RhdGEtPnVzYjNfcGh5KTsN
Cj4gLQkJcmV0dXJuIHJldDsNCj4gKwkJZ290byBlcnJfY2xrX2Rpc2FibGU7DQo+ICAJfQ0KPiAg
DQo+ICAJcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9jbGtfZGlzYWJsZToNCj4gKwljbGtfYnVsa19k
aXNhYmxlKHByaXZfZGF0YS0+bnVtX2Nsb2NrcywgcHJpdl9kYXRhLT5jbGtzKTsNCj4gKw0KPiAr
CXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBkd2MzX3hsbnhfZGV2X3BtX29wcyA9IHsNCj4gLS0gDQo+IDIuNDQuNA0KPiANCg0KQWNrZWQt
Ynk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0K
VGhpbmg=
