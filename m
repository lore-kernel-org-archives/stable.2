Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221B3EFFA5;
	Fri, 17 Jul 2026 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.180.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287401; cv=fail; b=rWiWYxOemdKC+UMPXjrCJ1udGsP0NPrdAyHbGs0qETF+Bm3SGznFPwY5vXqnMo084cNPbwu34KP2RX39c4ckACyZjxW3ljtf+el15cO7nP6but3VL4XbFivnGU1MI8RkhsxPx6mcPHO+MD+AVmuxCcsI5Lvb07SPavrCB/6ATAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287401; c=relaxed/simple;
	bh=SilItjuY2QQpC22pZBdzphQeQh9DgL7Q7tHsUBPaeoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQht/oNnX1/qaowl6tBRktFXjXlroNMJL3ZAbwEX3VQd6PkYpzx6clH/iVT+4XKOMRzLr62vrAzPQtVW0R7re4Y7z22ppNHYzxRJXCyVXjIQG3y4T9hu/OZJ+W6u01FRZ+MUQ5mJefEL3GoTyFPAQ6B2tpy7wTdkCyrYOE5TtJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=nutso9iY; dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b=kZVHzMQV; arc=fail smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="nutso9iY";
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="kZVHzMQV"
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HAR3eW3253664;
	Fri, 17 Jul 2026 12:14:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	dk201812; bh=SilItjuY2QQpC22pZBdzphQeQh9DgL7Q7tHsUBPaeoI=; b=nut
	so9iYr4B2wK/h9ujBfhF4XVBRubfx0fGUax9YZW6aUK4JsRWGB+i4qTL+Sdnz/7u
	ULKf4AlV6AIUe28Lu6NGbl8Jdwa0z5B+krHY44eZSfLqJ93vnUN8FS8kKib3KZ6A
	XXMJufhyxOL8fY6Azt6dShYX8qibv3jK/JLUECGf4bAIthcVkYZbRwIfphDxzpMQ
	z1r0CuuuxC8GFfQaKcgGgm9H7FzBXw07xJFwT0u7jdPcimyXx0NQ/IUE0r5pYNxu
	TmPkM/COzfMWRgCI7KGzMxSPlsq8xNqT4A/aWB9DcCfzUDA/e6OzVJXlZmS93sP7
	Ss1CgLzAFNHPBfn1rGQ==
Received: from lo3p265cu004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fbdwsnnf5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 12:14:55 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeQ/uPHDhl9/5oW5jzSH6zK9e+xIKhfXRW25+WUDnAB8rD2gBPBG+p08zFuJMlg6BV4nrmriGKFx6+00s2AhR4m7oD+mcj8IYiIqEWIryGYSgnSyEkNW14T+aHsRyr6jX3goJSaqHorknaku9OyzhBYTRv1Io7wTP1l736SRvUWYslVvD7GMqia90Ci/dA0Oy8HuLyVdvRe8UrCFDqFTXh1ktb3uqEPMgSUDhp0p4v2BA57jIfwRcOI3RPab2Ugkb6L8FvLSClOUkJ/sP+0c8KhIHuYYBmzxrBldB89gJoDj46ln9tnoTC/D9SpLzdsAJiZf2dOuqs2goSwyxkonGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SilItjuY2QQpC22pZBdzphQeQh9DgL7Q7tHsUBPaeoI=;
 b=UhZK50Po2IXMvejFe1Eg8NvdM9qcWP/vdzTQ3s37iuXKR5DT69qT2GIHPjbtCbHgZzQIs9pmlHg4RShAuUKDK/RCdt+zYAFsaxMlqah/6/M5D4JJuyCDyjKaF2s4K0HN5SHujySTgrBaSjXok4FrmZsNyZj+ysRsU6bqUXmf37+buh9Fcndefnh4lqMMNj1OgkvnRaeP6/i70nGHwmZPKF6jYCSa2M4199f1jZ6/eUKP4A75JBQNNGg2GJMDY52z8n9XsHstVPzKl2K3QIlfg8BDwqolePgZdgT3p6HPkRSWdO1T1Gkd66od8KQQgnNSAp7+cnWrFJoNkvOnRNrsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SilItjuY2QQpC22pZBdzphQeQh9DgL7Q7tHsUBPaeoI=;
 b=kZVHzMQVxGAvO6dPCLrXl7BZc8i1Giy7pnwQYkdiUrjunIgKBvrlBE67EjFmgX2/JiTVaHNbFLoV2KnKO3mG8k3j1g5N9q0XvUmXhHTWdm0tO3ymuHUwZnNS0t9Y2m9twzNiaWh30kafy+4HB9LcsGAKw8Tmx8p6KLugSwh8gvY=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO0P302MB1110.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:428::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:14:53 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 11:14:53 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "zhengxingda@iscas.ac.cn" <zhengxingda@iscas.ac.cn>
CC: "airlied@gmail.com" <airlied@gmail.com>,
        "tzimmermann@suse.de"
	<tzimmermann@suse.de>,
        "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
        "simona@ffwll.ch" <simona@ffwll.ch>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "uwu@icenowy.me" <uwu@icenowy.me>,
        Brendan
 King <Brendan.King@imgtec.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Frank Binns <Frank.Binns@imgtec.com>,
        Brajesh
 Gupta <Brajesh.Gupta@imgtec.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "dakr@kernel.org" <dakr@kernel.org>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
Thread-Topic: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping
 memory to GPU VM
Thread-Index: AQHdFd19mNJ7VUcYJkG1BIlpX5pejw==
Date: Fri, 17 Jul 2026 11:14:52 +0000
Message-ID: <164ad51d357350cde4e9e84cbe1ebc970c871af7.camel@imgtec.com>
References: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO0P302MB1110:EE_
x-ms-office365-filtering-correlation-id: 7c94d714-8e57-415e-25c1-08dee3f49ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info:
 U09TMoPNqo8Y5NrO3h7ItTxVzlENMHWdSvCPsSFGxjO2cWykFuFOXsmj5JsX1sJPR7wKP7hF9+eA7KDyAMnu4z/+EdNnvVaNNSz3Ke/xQcI9sSlioo5A8s0VI2BB08iog+ZOPu8BbKJr4szEalBTJpoTfcsi/9wl30suuQ2x0vzHVzhFoaeYkAaq2eHXZw9Wv89KoXMaPUnzAcnHkdMznou/EtNT/84g7bG4GsWpubLcx1WgOuStvU4e5xa6p2u8qVMTUdb+woZS9z7WdVYpp5X5vKJAlwQh+uICcZHBMLgaj8nS10ab8pZYpb2x3WhuhTjKvfBRa+dP/5//hgTW43moIDvrNL6pVMlULO1q1lNz0xU55SkS9KpRZ6C4B5wd9IT6e0UtalzACykaGHa+LWlUGQr6CudNBslrnB/uTQtw3jig/17hvfx2ATZrYjZ/gXuYKFqrTkYVkf6/2LROdZU0mAJTHsMnEHoutGWQsX5uXSkYIqCvXco4weo7xuAFYSQUzWv/Q1Xie4eQrbQiZ4mzNeL6BBNQCa8LRA0MU4qNKePdOh1FUPOHZFnNLu64oOS3tXLuJ39GQXr2q7qm2PL8sm82PN0FW+IbxV8RToQHbacjlWUre6dyFSy3YNDm3XSg8AG3a5cy8cdLLuhJVNAivKTtXpSyJ4UXcAUUIek74yiuhIzv9kKIqrhim87/rLiifxPFSTngCsizt7DCl62XsmWm/ryf6p8kIKgK/JE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk9oWXoxd2RQNWhDS1hDazZwVUlGUEJoWkZOQnJYb1ZZSFR3MW1XcU5qdXAx?=
 =?utf-8?B?Q094ZG1wQTJFR2RlcTJXQWpDTk8yY0piSEwxUWQ2THlySzc2b0NzbWdUa2Yz?=
 =?utf-8?B?OUpJb0xZQng3U09VTjhiUW9NUCtlY0dMeFN2RVVmRVlRcHJ4N2FmNWJnWndB?=
 =?utf-8?B?ZVMyYmFGZGFlUHYwT2FmUytsQU1ySUdJTG8xZWpmNTQ5bVY2bE1UNUoySUpw?=
 =?utf-8?B?UTZwaGkxQU0wcXJ3aUN3THVSQ05iQ3lHTFlnQmo2cVBENC9hUkRvRDhVL05N?=
 =?utf-8?B?THEvQUhndEJOL1NxT2R6STRONjAzZmtXV0tSaWd5M0ovZHZ3eEZLU1dNNlE2?=
 =?utf-8?B?M2s3NjMycjh3d294SGpvSU5Va3ZHWjBKZjJQdDNHd3U2VzdsQlFPUk16K1FP?=
 =?utf-8?B?YnBpZko2c0k0ZXd2K2d2QmpkbDNSRlN6U2dlSHo3aGZ0dEdJNHNaTXNRKzkx?=
 =?utf-8?B?SU95c2dKdFVhNDQvSGhpRG5QbGl4S3VDblZDTDJSZkdXM0hLM0RFRGVXSTYw?=
 =?utf-8?B?K0RCdG9CRWxUY2Z4bGdkM0w5T0xRSmVNUXgxM3Faak5SNVQrVndKcVBva1V2?=
 =?utf-8?B?Nllxbzh3YTVYd3haYXY5N1JIZm9ZU1BhL0VDQzVOakljSDRjaVJTTXdxQVpx?=
 =?utf-8?B?ZHNqOTE3YWF4TEdlbDRYWHdaSndhTWM0eTRmaW5KWDN0YmtVUmZOa1hDNmZT?=
 =?utf-8?B?OVBRVllZRWVJZ3Z2TlpmSVhRNk5EU0JFVGdnMC9ORnFiVUtsdm9Jekw0cmlF?=
 =?utf-8?B?ZnBib2w1Tkt0aFplaFJieFJOZjl1cExtOW5rcnRpSW5PK2N0NnpHNjhwVjI5?=
 =?utf-8?B?eTFQbzJGb0xOMWowemVaaTJ2WmNPT0NOdEtjYWsyak42U3JxdThteXJycVdp?=
 =?utf-8?B?RkdKbFVJM3NMdEVQKzd0bThvaXlYeFFsWkN3dXppNXVlblV5bTErM1ZKNlho?=
 =?utf-8?B?OTM3d0krN1l4c0lwS3ArZ3k2MURCUTh3K0Ewcys5UGZCQTY0eW5FM0lDdWta?=
 =?utf-8?B?enU2NzBia1p2YXkwY0ZHVmNXK0w5NFplUFc0aGtRazJuMkVUcEZMVXVuTU9V?=
 =?utf-8?B?Q3NHYjc5V2dWelJGSTVwS0J0MHVrWUJpNXdWK1M0K2xJaDJ3OTlHc0w5NHdX?=
 =?utf-8?B?eEc5a3pJY1hrMU9DS24vMEhDYVFweERkTjQ3Ni9Mays5aTROZzgxQ0RPZ2pv?=
 =?utf-8?B?MVdic1N5MGt6UitWOW1EOEhNSkZNMjNZeloycXlINENhbWg1dEtTZjZjd0R0?=
 =?utf-8?B?MHpNVE5qS3FFVnJMZHVwVjZrRnhpS2dpblNBVEw4YmJhN1dqa2FNbTlTRXpu?=
 =?utf-8?B?eFhuQUx6ZXJGeDRxdGlVcjBHMGEzRzRpaDE4TmQxWVVNNXFaU1I4KzhPSURO?=
 =?utf-8?B?RFZ4cjQ3SmRLWGxzUzdCV2RpT2p1eEI5ZHpaUE04MFF3TW1GZ2lwaXJnS1Jj?=
 =?utf-8?B?WjVWREVjU3NkSkJSQS84YjJ2cWlsTkhKakMvRG5GZ0Y4Rk4wTnRZdWhoV3Jx?=
 =?utf-8?B?dVBESGhHOVRjQUZ4Ry9reHZBMlM4SkxReW5SN2NtQTJ1L0g5TmFEeWdMam1l?=
 =?utf-8?B?bEwxYmdydHZFNE9icVIyQlNxNG5lNzlEbkFXNkVrUE1IaHVscDFDRWpnOGVn?=
 =?utf-8?B?UGp0eGRTOW1IYVQ3L09SaDM1VFhINzhvOXFLWFp1cDhCaGliUUxEYUJjdXBp?=
 =?utf-8?B?YWwyMEJLci9vZnVkNVRuQlVFYW5rMTJRcVhBdmw2MVZ6ZDJGTEgvV0s2UTY1?=
 =?utf-8?B?NVdRUzFzbUxYOE16bTZuYzFyZEVuN2c0NmQyMGRYQWNpRGF5UHFvYUdPSlB5?=
 =?utf-8?B?NjFmWitzR1NDaDJzUXJOQW0yc2FGcDVMQUtPUDYzV0FDRHlRQUtKbGp1Sk9x?=
 =?utf-8?B?YVF5R3Y3SHNqNTFzU2ppdENRempQU1J5eWxOenRjN2dlVzZpMW10Q0IwSHBz?=
 =?utf-8?B?bWRHVlZTbitFSEpOcnVqelpEc01nMGJ3QmM4NW1QTFM3QmVYamtDbzBCaGZT?=
 =?utf-8?B?TFVYdGwrZkdGd0tPV3hqd2cveTM4VjZRcDdCL1VlNW5ncG1seWJIaWJwTm1J?=
 =?utf-8?B?ck1nNHJCQW5SRDBndHZLcmlSOU5EajJmQzc3NHNVajNvNld1N3hNZWw4ajJa?=
 =?utf-8?B?QUZmdTJFQW12cUpCVUo5Wk1Jbm5RL2ZwSnpIMUNVTzFwekVtMlhGN0VGZ1lm?=
 =?utf-8?B?eTA2Znh1NnVReWYwSFJsbkFuc3ZnbG15WGNpNmNEcC9PRDlNNmFZdjZFeC9z?=
 =?utf-8?B?bFIvYTlpdC90ZjQ0SlU0cHFQMzkzd3puYU5YQnZRZmlRZkNPN1dZbER5bDJO?=
 =?utf-8?B?TWd4aVBtVTFYbXRRMUc2ano2dmNsNlhjdWtoeUN2MktJbWk3TVRUUE1heity?=
 =?utf-8?Q?yTFyMwAbHBCajlSs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B13B6B64F15F7B47B7F500B1B9296226@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PGMXcDjCy1pvgaQ2x8jew0HkU7GYo1ia9MQIdxa6OoOqfA5B90Y9ACPLqu0aJsrC6pXHMiRYP+rxZ9I/nzJvaN7LQL5TRWk9VWvaipdy/TqzoPAOpl6LSVSENrkF15XkfOzxT3u+3vngok8t+GcGB1x51gIkd8It4enkbfpQ81MxwvYKQolKee4qL1Wz5/7mXPZuRcufAWC4xmnuODIGrdpAQw0aSOsaRZ9ZlZMJNJb5ewPt8lhWxAqWqOZWFv5TQ7WtOm1FaDkgIT1B+U+UnTGR2or8h0NZ1ysAoV5EeUC2uIgndU0g533grRErGsf2sDoDXYnZg1cTw/pGf1D57g==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c94d714-8e57-415e-25c1-08dee3f49ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 11:14:52.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IzsE+VGzhggZr+pQPxdD+GgIoGUbos4+IqS5HHuW2a5oorI7H9ITmNF1Gfjr/1013FsYyXPVzz+zAd/OVOEuwAT01GJtN9zEhlsNtCf5no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P302MB1110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExMyBTYWx0ZWRfX12aZ5yALp0VP
 UV+aR1kEJfgXb5bToA14pRkN8LskEELU15UU8kv3Yq/BP1LiSrfVjtTwYVTVQb658RqUu0YpEdi
 JtOb9jSBiivVlY+5ZErZ43bsUkFvDUdNiv+QwYWbRWJUbIEefgb+0i2Xih1IfGWO7lRkOfIyS6B
 4XPlrBLxUiD7sM+E2/27Jk/s0EahXhOEiN21QKndn5iQYOxCqsDCDDzk1bk8CwQnvJQnOIIwvuY
 WSXI7GPOALNLFdwl8EBcuB7fy5aj5hZm8lkqWAohD2nIDbdvYxHvwwUbpMRqYxNrwnQnyWC40ql
 eX7zZa6aIQ1wQliXcxLT9ocJUR0RRuRxSdObpBDyZwxkhbyytsXAgdpp71rsJO37l4iI28RmCuY
 lQypu9USCwQ/4lJQtDd/zLiX4WmYRP5LHkL3+b10P1cQ5q4QG2LKDoGSKpMfnIBJjcSFcIc6Dqs
 IpKXnswX65fKOWCxlew==
X-Proofpoint-ORIG-GUID: irVPaPqBG8ZDrj92X3l9_jYkzzxW0D0Q
X-Proofpoint-GUID: irVPaPqBG8ZDrj92X3l9_jYkzzxW0D0Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExMyBTYWx0ZWRfXxVUBcAk0ppX8
 pIwo1aq1TeaUVb47ARpaAStfR6ZNIaCADICZDnqs064Qqv2RYOshBgAtVDD3eNg521TTEos0+oZ
 B8hUuxSmr6wHm/u8Oz5uE3vF/dXlLxw=
X-Authority-Analysis: v=2.4 cv=QbVWeMbv c=1 sm=1 tr=0 ts=6a5a0eaf cx=c_pps
 a=zaz7LV2gsAqesGY8YBE9ng==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=NXQmOgsqWFUszKTETD8A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDE1OjM2ICswODAwLCBJY2Vub3d5IFpoZW5nIHdyb3RlOg0K
PiBUaGUgZHJtIGdwdXZtIGNvZGUgZG9lc24ndCBwcm90ZWN0IGZpbmQgb3BlcmF0aW9uIGFnYWlu
c3QgbWFwIG9wZXJhdGlvbiwNCj4gYW5kIHRoZSBkcml2ZXIgbmVlZHMgdG8gZW5zdXJlIGEgbWFw
IG9wZXJhdGlvbiBzaG91bGRuJ3QgaGFwcGVuIHdoZW4gYQ0KPiBmaW5kIG9wZXJhdGlvbiBpcyBp
biBwcm9ncmVzcy4NCj4gDQo+IEluIHNvbWUgY2FzZXMgYSBmaW5kIG9wZXJhdGlvbiB3aWxsIGJl
IGluIHByb2dyZXNzIHdoZW4gZG9pbmcgbWFwL3VubWFwDQo+IG9wZXJhdGlvbnMsIGFuZCB0aGUg
ZmluZCBvcGVyYXRpb24gd2lsbCBkbyBhIE5VTEwgcG9pbnRlciBkZWZlcmVuY2UuDQo+IA0KPiBB
biBleGFtcGxlIG9mIHRoZSBzdGFjayB0cmFjZSBvZiBzdWNoIE5VTEwgZGVmZXJlbmNlIGlzIHNo
b3duIGJlbG93Og0KPiANCj4gYGBgDQo+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIGFjY2VzcyB0
byB1c2VyIG1lbW9yeSB3aXRob3V0IHVhY2Nlc3Mgcm91dGluZXMgYXQNCj4gdmlydHVhbCBhZGRy
ZXNzIDAwMDAwMDAwMDAwMDAwMTANCj4gDQo+IFs8ZmZmZmZmZmYwMWU5ODlkND5dIGRybV9ncHV2
YV9maW5kKzB4MjgvMHg2YyBbZHJtX2dwdXZtXQ0KPiBbPGZmZmZmZmZmMDFlZDNhNDA+XSBwdnJf
dm1fdW5tYXArMHgzNC8weDY4IFtwb3dlcnZyXQ0KPiBbPGZmZmZmZmZmMDFlYzY5ZGE+XSBwdnJf
aW9jdGxfdm1fdW5tYXArMHgyZS8weDUwIFtwb3dlcnZyXQ0KPiBbPGZmZmZmZmZmODA4MGNlMGE+
XSBkcm1faW9jdGxfa2VybmVsKzB4OGUvMHhkYw0KPiBbPGZmZmZmZmZmODA4MGQwMTY+XSBkcm1f
aW9jdGwrMHgxYmUvMHgzZTANCj4gWzxmZmZmZmZmZjgwMmJlYzNlPl0gX19yaXNjdl9zeXNfaW9j
dGwrMHhiYS8weGM0DQo+IFs8ZmZmZmZmZmY4MGQ4NThiMj5dIGRvX3RyYXBfZWNhbGxfdSsweDIz
ZS8weDNmNA0KPiBbPGZmZmZmZmZmODBkOTIyODg+XSBoYW5kbGVfZXhjZXB0aW9uKzB4MTY4LzB4
MTc0DQo+IGBgYA0KPiANCj4gQXMgYWxsIG9jY3VyZW5jZXMgb2YgZHJtX2dwdXZhX2ZpbmQqKCkg
YXJlIGFscmVhZHkgZ3VhcmRlZCBieQ0KPiB2bV9jdHgtPmxvY2ssIG1ha2UgcHZyX3ZtX21hcCgp
IHRvIGFjcXVpcmUgdGhpcyBsb2NrIHRvIHByZXZlbnQNCj4gZGlzdHVyYmluZyBhbnkgZmluZCBv
cGVyYXRpb24uIFRoaXMgZml4ZXMgdGhlIE5VTEwgZGVmZXJlbmNlIHByb2JsZW0gaW4NCj4gZHJt
X2dwdXZhX2ZpbmQqKCkuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhl
czogZmY1ZjY0M2RlMGJmICgiZHJtL2ltYWdpbmF0aW9uOiBBZGQgR0VNIGFuZCBWTSByZWxhdGVk
IGNvZGUiKQ0KPiBGaXhlczogNGJjNzM2Zjg5MGNlICgiZHJtL2ltYWdpbmF0aW9uOiB2bTogbWFr
ZSB1c2Ugb2YgR1BVVk0ncyBkcm1fZXhlYyBoZWxwZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBJY2Vu
b3d5IFpoZW5nIDx6aGVuZ3hpbmdkYUBpc2Nhcy5hYy5jbj4NCg0KUmV2aWV3ZWQtYnk6IEFsZXNz
aW8gQmVsbGUgPGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KcC5zLiB0aGVyZSdzIGEgZG91
YmxlIHR5cG8gZGVmZXJlbmNlIC0+IGRlcmVmZXJlbmNlIHRoYXQgSSBjYW4gZml4IGJlZm9yZQ0K
YXBwbHlpbmcgdGhpcyBlYXJseSBuZXh0IHdlZWsuDQoNClRoYW5rcywNCkFsZXNzaW8NCg0KPiAt
LS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBEcm9wcGVkIHdyb25nbHkgZHVwbGljYXRlZCBtdXRl
eF91bmxvY2soKSBjYWxsIGFuZCByZW9yZGVyZWQgaXQgdG8NCj4gICBiZWZvcmUgcHZyX3ZtX2Jp
bmRfb3BfZmluaSgpICh0aGUgbG9jayBpcyBhY3F1aXJlZCBhZnRlcg0KPiAgIHB2cl92bV9iaW5k
X29wX21hcF9pbml0KCkgY2FsbCkuIChUaGFua3MgdG8gQnJhamVzaCkNCj4gLSBBZGRlZCBhIGV4
dHJhIEZpeGVzIHBvaW50aW5nIHRvIHRoZSBvcmlnaW5hbCBicm9rZW4gY29kZSB0aGF0IHdhcw0K
PiAgIHJlZmFjdG9yZWQgYnkgdGhlIG9yaWdpbmFsIEZpeGVzIChidXQgc3RpbGwgYnJva2VuKS4g
KFRoYW5rcyB0bw0KPiAgIEFsZXNzaW8pDQo+IC0gRml4ZWQgc29tZSB0eXBvcyBpbiBjb21taXQg
bWVzc2FnZS4gKFRoYW5rcyB0byBBbGVzc2lvKQ0KPiAtIEFkZGVkIGEgc3RhY2t0cmFjZSBvZiB0
aGUgb29wcyB0aGF0IG9jY3VyZWQgb24gbXkgYm9hcmQuIChBcyBzdWdnZXN0ZWQNCj4gICBieSBB
bGVzc2lvKQ0KPiANCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYyB8IDIg
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
aW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gaW5kZXggMzk2ZDM0OWZiNmNlNC4uY2ViNzg2OTRjZDk4
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm0uYw0KPiBAQCAtNzQ3LDYg
Kzc0Nyw3IEBAIHB2cl92bV9tYXAoc3RydWN0IHB2cl92bV9jb250ZXh0ICp2bV9jdHgsIHN0cnVj
dCBwdnJfZ2VtX29iamVjdCAqcHZyX29iaiwNCj4gIA0KPiAgCXB2cl9nZW1fb2JqZWN0X2dldChw
dnJfb2JqKTsNCj4gIA0KPiArCW11dGV4X2xvY2soJnZtX2N0eC0+bG9jayk7DQo+ICAJZXJyID0g
ZHJtX2dwdXZtX2V4ZWNfbG9jaygmdm1fZXhlYyk7DQo+ICAJaWYgKGVycikNCj4gIAkJZ290byBl
cnJfY2xlYW51cDsNCj4gQEAgLTc1Niw2ICs3NTcsNyBAQCBwdnJfdm1fbWFwKHN0cnVjdCBwdnJf
dm1fY29udGV4dCAqdm1fY3R4LCBzdHJ1Y3QgcHZyX2dlbV9vYmplY3QgKnB2cl9vYmosDQo+ICAJ
ZHJtX2dwdXZtX2V4ZWNfdW5sb2NrKCZ2bV9leGVjKTsNCj4gIA0KPiAgZXJyX2NsZWFudXA6DQo+
ICsJbXV0ZXhfdW5sb2NrKCZ2bV9jdHgtPmxvY2spOw0KPiAgCXB2cl92bV9iaW5kX29wX2Zpbmko
JmJpbmRfb3ApOw0KPiAgDQo+ICAJcmV0dXJuIGVycjsNCg0K
