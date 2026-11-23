Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795434185;
	b=exq52cmFQ4U8dkuH43GGnJveJoSQ7STADIv/mvvHAvQOezEM3DnGI1LaeNVvewiGdEMb
	 CDTviVEhGg+Khjj6BQhSR6ajdlfZO8n/E6oy0x3n+bjb94F1MIPCxTMP8XdWkE4ekYiJF
	 EERNxgp/O1udr7i8YTkB1He+pOnJ9I6iwsz9WIiiRLoG2GJl6SI8jw2r7HgLszQ0BXyvM
	 6iLWztaNgH4xzqjAhZn4ZfAV+BmXWvjGQfOOK52RUXAJ3A2W76m0Uf3WbPNO5B9krlUlE
	 fHENoq5xVHQ/g0O3hIyNKKRYlo40RpenYvzVUX1KiVG+aL+XXmjIyFnVaZESKye7uvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434185;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5yVPR0wfwDZHaupqj3JXKa/OEwANoDB64wR5inFjnHA=;
	b=blE1HEH8wt8BmaTuxuO0s8I3Jfl7o2x1I779yWYschsLZHQIPbiFxS8PAUVm8/ozY8+X
	 RANdPCNregrfg4cq9uD3qzGmjd8fmeL5ljFRKUrZvXTIiMAp2pO+V3BLhhT0xafllu4IR
	 CQsRlk3wIBAhTDdXiNvVWAvz6sYtBZXbXos8x9ay34GALz2aJJj7vmAlkzkBMUoPx53ex
	 RvsUMmAytosbh9IcYpS+2FrZxCdk/FrFI0GFAtMvr5Iupym/TpxD4XyAfNtiWhrmEjkdk
	 DlHvTnDYn0rG6LDC+rsCs+q+TrX7xXuY9JyhaP4gJ2hqpXbrTN0NwVqYT19zp8h3nwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JyrY3i1A;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SnjPwmF2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF645606A31A;
	Mon, 23 Nov 2026 11:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF645606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=JyrY3i1A;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=SnjPwmF2
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9GRiQ379221;
	Mon, 23 Nov 2026 06:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=5yVPR0wfwDZHaupqj3JXKa/OEwANoDB64wR5inFjnHA=; b=JyrY3i1
	AaBdiJsppc//BhvwUQRqHnBTKPHgPRdk64lJaiaHvUO5Szi7zhVRViCIS0tbPjSw
	dizdcUsnESS5RG11Ve4oBGsKRcgwFHq6v3emCFLJwyu08FKbe0oDTqGOskqbioSf
	OyhG1j9ad9aQ0meYnWbqzmOffhRfgXRVn8QZzl2OITnV+5YIWKdUt0JHZS4aasa4
	3cfgjF13Yo8TaYMnPOr/zNy7QNXtirjdp7wnnfUnWF5ifOJ4JBBcmQCQkpl0HZuN
	Re2yftgpzODOlqHmA6Leo64yzl1zeON2y7NdoNcLPf/t+iFvwD7yh1Bgv1uN6faq
	Amvhctn8HzfZmTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5yVPR
	0wfwDZHaupqj3JXKa/OEwANoDB64wR5inFjnHA=; b=SnjPwmF2GkxzOK+0kRQls
	WEyKupnbb/W8winncuQLv088SQrh7zFyJnEVm6zos1wX4MZUCRV99dmPXB9aU2YL
	3tZ/m+xEIEFETJsm1b79UQ1Qzelird3eD4isOX0KBvgsH9gIdF1JhojCuZYDdtul
	DsvZ4F3TWqeywgPWE000LKkD5KIJA7X3cUbKHDvqRGPaA0iqXTMY5B5OjruJblNW
	tLzSFTiYeH1yO1ERu1v8F6DHsdvCDhn5h9ngNp4AbhOapiTFO2WuobyrzlyYrEgb
	vd5NCi0qYxssAJklyGNaqY+CzKqC1kcWISLMTkLthl4yuLJduXUipp/38pxolS/f
	A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j4cb9t8sg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 06:42:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFZtYhGbhYcFmVbhHUa8QEwp2J/JbrjNCX8XhFekDDfyaP8i74S8qofxpr+ZnurFmCJN8CwNvT81114QJipBRgbobZRWbmhq69NHODGV6t4ccTPNU32XuyLOGyYrCqZynHJF4a0Ctg8foSAVwS/A4w6I+MRceC8gRrWKYDn5cgiOSxhKQEZYIBQs7NWO1yvQF1Q5Svs6wYyt7iUPYxJm8hBB1C10LDhjOXASCFkO50gQ6JFRxleBUAArZsxGX/qx0zK3N5wgLtmvJX+JC6pZs7TPTsOxVJL1YoAfjMTrCVWfSuacdXDaAX7PzDaVR4AnsUBBxqcqoCwfqspODTpDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yVPR0wfwDZHaupqj3JXKa/OEwANoDB64wR5inFjnHA=;
 b=WAYaaT2CLUiiBHDl4nTwqjs5DW8S+6TgtkWlBYhgiJNstYPzdFsVBS0KfQwBh3Id54fnpB6CXKDbPqPIkDPy4/Yp2fnd82oNtLEDCtqzWK6f9IBYDbgnJkDVkyeWK1J6oCiyekMAJh2N/7H3y0QtEe8ke8fCr6hFGTJZ+aCA0kzvweI6bcXni2B2ZBjlhR1Iy8AyAgRipTdSGZp0gNudtrsQmAnF5REJHp3gFnO49lD2Kh5T0hf4a74wl0xMsNsHSWJ7/Weta+SYIkG81udfNX8K3yYnl1bUgYQme/O4UZlEj3VyZcszFO6iW4FgV5JIeoEmfPas1BygMytSLqCGWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by IA5PR03MB989676.namprd03.prod.outlook.com (2603:10b6:208:609::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 11:42:36 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%2]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 11:42:36 +0000
From: "Sabau, Radu bogdan" <radu.sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>
CC: "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        linux
	<linux@analog.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 01/10] iio: imu: adis: Clear pointers after freeing in
 adis_update_scan_mode()
Thread-Topic: [PATCH 01/10] iio: imu: adis: Clear pointers after freeing in
 adis_update_scan_mode()
Thread-Index: AQHdegd61SQQYvgK+0Sw1aWtUTmD8rc7ioyA
Date: Mon, 23 Nov 2026 11:42:36 +0000
Message-ID:
 <LV9PR03MB84143639E37408B29B8A1935F7452@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20261119153151.1397003-1-lee@kernel.org>
	<20261119153151.1397003-2-lee@kernel.org>
 <20261121222710.526017ac@jic23-hlaptop>
In-Reply-To: <20261121222710.526017ac@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|IA5PR03MB989676:EE_
x-ms-office365-filtering-correlation-id: 012a00e8-6bfb-40e8-85cf-08df4956decb
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261102123227099003|261026140227099003|261026121527099003|261026135527099003|261026130827099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261021133027099003|261021130227099003|261021135927099003|38070700021|11063799006|4143699003|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003|4133799003;
x-microsoft-antispam-message-info:
 9OBHUQrCEokvWUegWIGYhF9y74ABwnc/jCauMHcriFCg/0G7JMpwrQVVvYMYOyYK6G09rDsS9P+6tqbWeGbyicjk0u9uPGXil4yqKwQnxCReysYAxeOQR9PGzYRiNa/F/4oEvX0s7qKm//xx6dlgxtFcYA0mr3dRs9XZE8ce4K9B7eMoAE/qDN+xynd+7GyUHePHJU4CxIL3X2VFUyg7HmPprBtvyW4CA4cUyFchbhO4E/0tQ1rsEsF30QoBJappo0Vt5TYkv0Ncwfci0Caa+ZZ8g7/HG0TgwyjSiOKY7T51wDiL3A9hLGOS+hnFTEHWYQqWxDFWRi19p4DZfJxAjA+aQq50zXNOwRJT0dmUUa4EDpCmdf787k+OIAOin65aUcBZqRsjPWfJxFkC8gFTbw6LjKMmHZ4pzLMEu5Fc5tfqm+v0mGgLDx2PwrPD5ub3LDR6Dyil2iwUKi0njoQ5vZa/k3ysE2FW6IUzaHiJ2fVE6qmOB+ZdSX+0PBFcwjtLjZyok5227oc4E+6FQoKxQ688iUub9Z60CyhweZfaA4IY8vfnB6E5AABUmXQF5CyTnr77PckfbLkcq72sXg85KTxWOdP6wjINzru+OWD4eLFj7YqzStGV/7BjIeT4luGH71d9BrysTXXw8+DWERcIQlpK+pc1jNxWFmkfY/gY7Mw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261102123227099003)(261026140227099003)(261026121527099003)(261026135527099003)(261026130827099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261021133027099003)(261021130227099003)(261021135927099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s5yWHXOKSuKf8FgHOGhKA3xG4404uWEdoBa506IMS6jBSP3P+5iYKpYMXJMc?=
 =?us-ascii?Q?+FHOsveOf5q7ugMElsIuSbgT53x8iSX6yZzkEVC68b2rOxiUP41hJ78H7Rad?=
 =?us-ascii?Q?R73L+bgCX1zoq92ZABHrN7q8gDa/eN3lmPGWaRETCPYplpC+4FqJjLYC+aLo?=
 =?us-ascii?Q?y2ZRCgmv8YrwE4ZMUiP2EPixSRcS5o+ctBLtTF+mIwQ+Esci5TPNaWHg+Fg6?=
 =?us-ascii?Q?W0lmWxwdkWkqe9Fbw4Ro8gdB0ZX7Oti608yN8lv8t40uxPWhssm+a+n9TuDv?=
 =?us-ascii?Q?8X85bzkZyCGQV1dyCmMDYpfAMKIEmXILWGMNJapmsOqe70r1AF5UWkJbAcbc?=
 =?us-ascii?Q?OpUneMtXbyd4+pNlqe7ND1xT/etJfJV07ks5JT5ltzEnKW45Fk0Jakz92KAN?=
 =?us-ascii?Q?s+LeaYx/y26C/hSlfUgEfgjDdwsSBU+kpMI+LPNcrFWfFhVjY/n5XZ1+mBrq?=
 =?us-ascii?Q?a6K3SE7J+DeKfpfEAsFghXosYpIz2SP8tCA7zsvwVBn09arHETCeMKZY72XL?=
 =?us-ascii?Q?2b1++Y+91K67DW8/U5JNKdeHQA+7T0fRwzNY382Val7M1NmWo/eUP5z22xoy?=
 =?us-ascii?Q?xY02xfGEG3+StOLkitBBlSqVmpkjcgzOFRmM00KGPFrKh3SCuA8sjmNTJYEs?=
 =?us-ascii?Q?r6uRcFlGH3tTApNVc+Gs48LtEi9MBTJiH+h6dxFrKsoagjFJCrWGCWz4asCI?=
 =?us-ascii?Q?M/xE8lqa2CogkHrP3Xznn+5W75Vbo1RqEJWXStcwD/MyUzhq5DEUEx3v2mO5?=
 =?us-ascii?Q?zELgdVt1bNi4uQOVwndIAizaU0OKh8yFvwe/WndYAH68bxyXzYFXBxcgz/Ow?=
 =?us-ascii?Q?3A+cJkrtzdY5HKDeQ1ijPjgUCKa9bRQ57h4hg75O9HQfdkDRxF0nDNfVNyPD?=
 =?us-ascii?Q?vNLrHsiXXdtXLBIzTJxJyfpddhUGo8WhsZt23W4xcZZ3z1eIgabDni23qSLx?=
 =?us-ascii?Q?cSKb9fvuPAA+OAtzXqyqvoH1I95mvaZ+G9Jpk9wS9bv6HijYcVFSc4PKVMr4?=
 =?us-ascii?Q?JKVZrSwKJRew3yXHDJEbJDAigQzuoKCfTdhlrqM/Ov3IU8vEPTqRGTXPaB12?=
 =?us-ascii?Q?yNLf3Kya1PwQ/3bS0KJZtsHvRe57x7SRHqcQwZkcS4ecBAxd247vHGbvZ99q?=
 =?us-ascii?Q?9gU9CoWzD/iblqjfP6G+1bVZ+fz8BJyypD9fife7kHxfkwXLYQhFVmosDB0J?=
 =?us-ascii?Q?zWajLgi+Kf/Q4E646Xakm3jbp5xReh3dpWmSARYe53ks+gpn9Qc1h5QaJWlX?=
 =?us-ascii?Q?cOrnV3J0Ft2F1EHELfVlnM65x/geJVZbhbEj0BDXOZMEGW/TJ3MQJgEPR7Yl?=
 =?us-ascii?Q?HLXxk9KE1nv1LYBEN6MXSN1k46lcAR8xbwnt0tcXgGlRJ+uJAzTUmR3pSysX?=
 =?us-ascii?Q?cM2/6jkiezIW/wZ39E5US+22Qa3WYVfnfq4V+fstMseG2DH/Qw5/s9Fkyhhm?=
 =?us-ascii?Q?4OCFjNb8PzYqrEqWyZK5ApVtlusxLYfi32UjfKU+AQb8DVYLrfQi/3Q3MDyg?=
 =?us-ascii?Q?R99mEagbo+lCAT7KXyR4wCH/0y2a6WTiPI+456aWpi2hcGIG6SJDRWQzHZCF?=
 =?us-ascii?Q?dnK95RQ+GxKoYGgq7lHY/i9hDIE6FGiLKLaHn6cI0BUfWMV7K4h4M0hYWx+6?=
 =?us-ascii?Q?jVkM2mChO8BDiTfPzSi/MwbwV9iBLAPN+G20Sh8XR4YvMJIUtXM6RhxJmqzy?=
 =?us-ascii?Q?sOLCrv1HBsLjy7nH0tTzVEj/OOJ/m7L6/F0Yrh3hvubdSsOv+/PnS6+5PPmf?=
 =?us-ascii?Q?2KmHop0isA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lgyMVNracC6hyoVA0eRMmWR3N5ruySRUxFFkjQrNBQ75Oh9gWTtDzztAqINlqpX1ssCV/cd7X+5J0yLw9yqMywmUc2So1MhC5wwduNCXFG+g/k7li4xxUeawrJl1KFf8v/HHMtGkhPQ+9uSuDIO7hH2OKaqCQuLFQ38C/yLApctENzjbjxX09Ks3zppEweupm7FCuWQnVFkT8QXkxYh/8AH4BTyB1KDlu5HSSbyRabxqQL1TrfMCRsvEEwEA3gHKIaLag2kAkXT7eKqkKJ+51+NsO/+ORnB/BUX1dZLTAwWA9OMuz36d2kAxUcPivkFBh5qvmttpO4jJ6DsL+C7NUQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012a00e8-6bfb-40e8-85cf-08df4956decb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 11:42:36.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMI2UImbcKLfJs8XaZkTkfzwPtBcRgNLhzXsnfNqkbWyW+GIa2ajn/ysOQHgpjtOww5XW/hpQ3ekh9W2saw06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR03MB989676
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0NiBTYWx0ZWRfX427ujTKiF4z/
 nI5wdY2W9gYNylqTrSVjxvX503qTDXPTfb01IUIHeDJpo+jzXPrXLYCBeMqe36j051XvP4v1z1V
 GIzktVJ172USU8mYIs1bgJjm4zEOlYxio7h9dY3+2zeeGlZZ4W6dUICk1DHDsXJ8jIzPPT2wcdB
 5/x9IgFn0pZ4GEhiRfGEWLyvM2ppZxnJEhZPUnjmcxXd1RdFnnmgbtATQ0+3PIyT6T6zxRlWWo/
 AWYATSvjQ6V5K/ZkLc0flV7gbME0oXLJ+I3vAXRA6blTlskf9TTfoc8R9rd9SgbPTYVNSgmeSXQ
 rQrWS4nytfjJKBIJYqf9AklaHr7HIZljJpJRS0GAU1NI4JxD+16nOlvNBqMOQs4fuXq9bZxV6U1
 9M/eJMNEvMRKrvOKo/wt/D1SkaVhR3KFYPoR87qXIXW0qAjtoozA97k4c6zjyrIYXYpDO2Ub5p6
 5Ep4IhZUzs2KS4BlX6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0NiBTYWx0ZWRfX4hyjCW8AcneI
 /tX1+dxYziYB64LOBoF9HOSGReg92oQKmDrtyxAb/y8+YU4ZRXMeMEE2JNh26zzYx03i88xXo7E
 2A7C8BDy486S/VrQkWrcUgO4G9zGIHxRpMiPMzt7XdIbjJrSIFSU
X-Proofpoint-ORIG-GUID: 1_PzCC_kqnWzOdBhKF2_hxtsYAEecIWd
X-Proofpoint-GUID: 1_PzCC_kqnWzOdBhKF2_hxtsYAEecIWd
X-Authority-Analysis: v=2.4 cv=Tu5zFzXh c=1 sm=1 tr=0 ts=6b0426af cx=c_pps
 a=k4cRz1n5LqTufC1gTxF42g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=XBVza_uN10kc0CfHGLsA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230046

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, November 22, 2026 12:27 AM

...

> > adis_update_scan_mode() frees both adis->xfer and adis->buffer at the
> > start of a scan mode update without clearing either pointer to NULL.
> >
> > In both adis_update_scan_mode_burst() and the non-burst path, adis->xfe=
r
> > is allocated before adis->buffer.  If the adis->xfer allocation fails,
> > the function returns -ENOMEM while adis->buffer still holds the freed
> > pointer from the previous scan configuration, causing a double-free on
> > the next scan mode update or during device teardown in
> > adis_buffer_cleanup().
> >
> > Clear both pointers immediately after freeing them.
> >
> > Fixes: aacff892cbd5 ("staging:iio:adis: Preallocate transfer message")
> > Closes: https://urldefense.com/v3/__https://sashiko.dev/*/bug/linux-
> 966f0cd4-488a-4d69-b8a5-
> 449c751365d2__;Iw!!A3Ni8CS0y2Y!4i5qWTMsElPdtLCR9XOmFReBGPm1E4-
> QuiQgnUxmuWq60Jc8yaSFDtSw9P02GhSGKQANu9d92G3pXg$
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
>=20
> Seems good to me. Given Radu has a bunch of work in flight on around
> the adis drivers and lib. +CC Radu to take a look before I pick this up.

Hi Jonathan, Lee,

The change looks good to me.

I tested it on an ADIS16577-2 (adis16475 driver) on a RPi4, since I have
the setup for testing those FIFO patches, too. Repeated buffer enable/disab=
le
with different channel masks, and unbind/rebind of the device with a captur=
e
after each rebind. No errors or warnings in the kernel log.

Reviewed-by: Radu Sabau <radu.sabau@analog.com>

Thanks,
Radu
