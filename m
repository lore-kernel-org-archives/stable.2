Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86113493D34;
	Thu,  8 Oct 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455760; cv=fail; b=NK8P9AB/cPu4gceFCWxCGtRkvnwTFfW+B/huZrucREwFPsPRJLj+d06ETLJJLyHnv5Cy3ZOFYNeNU4im2f0H1wO5tH2bW5FL2wdr/epq1OqfMSCKIjJNttemoFtz6U9aWfibUrdW7mr+NGpwmaoBgQ6cvjd96oCNBYHrgPdzy6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455760; c=relaxed/simple;
	bh=T6z4xyDdovDrURIAOWSoFeVKScDKBhwcB0p6dRtlwtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXW0Ho2N8EAFIdAG5lmF33g4w4h5yyMnyTSNK5JKwXTYsp/jR6Z1hzXxPQXAmOGJ2hS4Eg2WbvXR6mysxuOlv3DyXfKNNxUEd7qXgaXcOXQmxnqQL6l9jnuliFaC8uw8fodZQKQY/koUWekAajXLZQhZeOXwgIzAIHl3R4Du2tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rV4Q9Jjy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AyVdFE8+; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rV4Q9Jjy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AyVdFE8+"
X-UUID: 08d3a0b4c30411f18dc8c9802ae25ab1-20261008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=T6z4xyDdovDrURIAOWSoFeVKScDKBhwcB0p6dRtlwtk=;
	b=rV4Q9Jjy8azGocvszsejrsQoSdkQsKK/mhej9CXtTnFfbj3Lh2eyOoBCdU8ODsDIqjjCX/7zPO2TVyGw9ZsrRQqhLPwROqBI/cNg2RMy/wS27AKgMpx2rx7e8Xk0uYNz2l+qjGpCyaR764Zcgjvy7aqXlKM8ArpIeGesTS63JGI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:92748952-f301-4d4f-9d5b-d67a8cb4605e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:291e20b,CLOUDID:b34bdcb8-514b-419b-be8a-53f1868a3ee6,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 08d3a0b4c30411f18dc8c9802ae25ab1-20261008
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1319455706; Thu, 08 Oct 2026 18:35:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Oct 2026 18:35:50 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 8 Oct 2026 18:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyxQHI7yGxmt8qrtuSWAMARmJMFjHnCD9fBFbm1PYXMyfYlrloFIgXd0EEkXas97bvuaiF0pJQECeyRA7Jyw0B6/db5hbFdzrmrZwPLAfh7mbCwOi2t/BWS2y6pwiNXP10q+Jo8HGNq+lzmu6fsoiaGZjFKzsMjWdL6MUFf+ZvjC8zfVegGZDXtQCzUFPDSuRGASqOc0bDRzCmTeGeHrX2i/6vIbcoJFGpzW0brBDbM8Nq7OEMLFz6xHAu7E91v9VhZSFgRXFV6DEPBKkJwTieFpE9ArStuj4x2dTirqnZCZx75GKy9FErWH7fJNNgFI5IciPrWYR5xLNC7PEnvdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6z4xyDdovDrURIAOWSoFeVKScDKBhwcB0p6dRtlwtk=;
 b=d4izAX/czO6a/LDXJFd2+BkO5LmhXdZLfsKXVPTNDV+xxhRR8VKdMt36h5RiNnj1nkdG4n9xDq6O9MHj7Swc49JH01+Jn6kcYXMz70ihyG/zVj6VzHcDIkbwiLwAjMfv3evawKiCGEfkQLasThPTYcPTbQUDJSTYzW4TMtZIIrNqIXd9qLmiCGN+z35chmr311lD09KFtHhak0f8HtyEj8T5mHFB2N5MNVrFxwUP5btDVNwGg8kjtWP6mGQd51/I8/4wrzf0joayWnj3twb3b9eD7C+J/2Q3o6KY879gEnG4wOFSOGKzbq9pbhkkwTx2wC1GVn166bxPXOdCA0zWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6z4xyDdovDrURIAOWSoFeVKScDKBhwcB0p6dRtlwtk=;
 b=AyVdFE8+bUmmn4Mmx07lOhoRcaRJZ6eIoyCISgC8T61od3XeBV4sjKNC3p20NpSb3sKYn6zfyEqkFiI1Keug0zduoO7AulGi5riCh+8fktabZx4ogTkCY6zUTWBofPxI3BPkDUE0ZDhRTgU5fa9wY+lhjW5AgBVyldwJRb+A4Nw=
Received: from PUZPR03MB5880.apcprd03.prod.outlook.com (2603:1096:301:b0::11)
 by SEYPR03MB8361.apcprd03.prod.outlook.com (2603:1096:101:1a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 10:35:41 +0000
Received: from PUZPR03MB5880.apcprd03.prod.outlook.com
 ([fe80::d3d:8e21:3044:afce]) by PUZPR03MB5880.apcprd03.prod.outlook.com
 ([fe80::d3d:8e21:3044:afce%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 10:35:41 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "valentin.haudiquet@canonical.com" <valentin.haudiquet@canonical.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"krzk@kernel.org" <krzk@kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jian Hui Lee <jianhui.lee@canonical.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] memory: mtk-smi: fail larb runtime resume until
 component bind
Thread-Topic: [PATCH v2] memory: mtk-smi: fail larb runtime resume until
 component bind
Thread-Index: AQHdTezF1bQKohNrCk+rpHrmL4uqR7bzhayA
Date: Thu, 8 Oct 2026 10:35:40 +0000
Message-ID: <adb82cfed14bb682fe3250d22bee806bf35b4a78.camel@mediatek.com>
References: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
In-Reply-To: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5880:EE_|SEYPR03MB8361:EE_
x-ms-office365-filtering-correlation-id: fdadd0c3-e7bb-4237-05fa-08df2527e684
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|6133799003|38070700021|18002099003|22082099003|56012099006|10067099003|11063799006|5023799004;
x-microsoft-antispam-message-info: +cAwtC7L/fwqHHkGm/le5LUIj/aEPbOwsOUHcNBiR7qycPMczovHWX4l0xZhcRA4HnAnuEjXUpg15S+cqz5reCU8Btof1hbLcVb/IGUC0t9R0MbQWgtKRSXXnH8Pf4+4i8WEBs4U7lTS4tEbxgl0JgQ5LNPn17K4PF3qv8t+kzYJfElCtEPXuvul68VQQN//qbqC1dCdOe1+W0j3QN6kFmFAp1riHUs3kV83IqRgsxXm+K8p4OuVNZ9GmUqbt3DhqJUKiIrwNj817kENGvzeWEpXNGfKwSRS/LfEBxzCLXRU0AQHO5fqxnUj9OP+Qh/e/r98KFbCMfIt3CbW152Zpk7uepJKlz/2TS2xVXNsnqRAIVVVZnilWTQAvPyl+grKxRTP3PeZQa9srcylCaPs6ZP9N4qO3NM4nyTZ1YazKHVUjig8NSLzL+f6euCZ42ER+V6v2RSta8hCUud2zfNBWw2p/mPxai0++6q8T76k/pWIWzJHiuJzxqvrINBXqHZM7eMDXkqf7QOMfH9HoAJYjPWM8kwJe4vnJuXEghu2Rk+BVNqgleO6GTntRZvTylCYVWd2oJPVbVmpgKY/zXdRmm2W0Z1BydDOJceGKCgaHIniEAJddnVpvYmw3Uzmp4xJWg1RIdJRdgmoei59mdhAKEZdv6o0YkRFZPQTyaUUUlM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5880.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(6133799003)(38070700021)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1JZR0dqZjRvNHFiaVdiLzlTbjBYNzJpQWR0Nm1UbU1QZmxWUTFLMytRbmE1?=
 =?utf-8?B?Mmw4ZUJuNXNPaEdGK010QXQvQVRhQ0xHNHZCY1g1V1BXZmNHSDNqS1B6R0RP?=
 =?utf-8?B?aHNtRGNJay9PalJUUTVhV0VIRU1Ic3V1c1RUZWFqVFVPSlFmUzZlYlJ4NWxh?=
 =?utf-8?B?MkljMGJJQW9OVmQwR0krVE92dTNFcWJNb2VKTnBDUWpvTzNHSDlrZ1ErRUkz?=
 =?utf-8?B?YUNQL25sY2lRT1JTNzQyUDBJSHdPbTVPUXNQMlpyS3BLSHZXQUhzMUU5Q2xI?=
 =?utf-8?B?MWtMQjU4VXoycitHRTF3NFJIMzVtWFBMMGNlbTRCczBabUNYY3ArS2w1cmtF?=
 =?utf-8?B?Nmp0WFhLOGJrcFFRZnRVdFZadnZFME1KTWpIRHVTbDBnVzVyM2I0NkFVdVpn?=
 =?utf-8?B?U1E1YWdxbmVmVDBZWVBWbkJvZitaMmVvUlJjKzV2ZDFBVWxzd20wZE1XT2V1?=
 =?utf-8?B?RmVOS0JUVXFzWUhUdEtINWFjdFBJSWhXN3dObE14THdhM1JGQnJjeFVKc2pJ?=
 =?utf-8?B?R0xwNkRXaWxwNlIrM3FHWU1SbW9GcktnREUvcDJWRTV6dUFlNkQ4c2YwbkN0?=
 =?utf-8?B?bDA1K2tJLzNlMytEL1dzOUNnZExyVmZ6Y1BleGZZSHZ3SmU3SjhyMTBwdkJZ?=
 =?utf-8?B?NWNXb3JUcVNkVU0rT2F0WFV3Si9FTk1nVUVCQVdka1U2N1I1WStLNER0eXVs?=
 =?utf-8?B?eDFicml4Q2dBVFZXWXJmT3BhM3RDYnRDMWUyR0M3aVhCMC9TUGcxTDR0TCtY?=
 =?utf-8?B?WUxyRDdra24zVXpUa2lzR09JUWEzZmRzZ0tMRjJuMHlzVllYUTllQ1JjTlYw?=
 =?utf-8?B?Y05iS21TdnJoRnFJeWhoL1dsQjNxb0l4Y2pRdlBQby9vamRhUGpMamZQaUVh?=
 =?utf-8?B?K1k1Zy93RDNJVUZ4N1BtSVJmc0taYXR3OGJpd09DMCtjV3MxbmVjMSttaU9o?=
 =?utf-8?B?bytnbGo1RWRZNUZSNmtENUVCTmxTVWs5aHc2K1cyZlo3SW5ncUNTOTJUc0I0?=
 =?utf-8?B?TGpRL3E5dmNxZ2trSzg0SjJHZlU5V1kzVnQxMFZGNTZlTmJ5TUhVYXNuUkRI?=
 =?utf-8?B?WkpIRDRYUkU0bXcyck16MXVlNjNPZUR5ZE13UG9nREJHYk13UWRQSDZUdlhL?=
 =?utf-8?B?OHJRVy9kc0V5cDExSGtaRlJBc2NQdTNKZ3VIdENjMjJFSTZldS95S1JCL2xQ?=
 =?utf-8?B?dTNWOHVUNnRuaDJlcDFwS3VNZ3Nmc1ZnRkkzVDg2eFRxbW9FT1Q4dnYxMmE2?=
 =?utf-8?B?OHhSdG1rYUlDWkkvd3hQYW9sVFR2MGovaGpQZEhzK1YvcU8ybUZEdlV6VFpD?=
 =?utf-8?B?VmFNWmc2K2ViN2xMZGdQb3JTMTlkUHVzbWc0ZUE2anFRT3BjVG9OKzVNN0FL?=
 =?utf-8?B?bFptY1QwY3loM0VtQm9QS1AwSEt1cVN1QzBPbnlxTUtHYlRPVHNPUmRNWVUx?=
 =?utf-8?B?MWVEZm5XREpvMzgzaXFQZTQwZ3g1Nnp5cGEzZXRYdzlqOFJDbXhNVk5KSVlh?=
 =?utf-8?B?cE5UUmEwVEVzemZsSjY0ZWszN0d2Z0JPaDllcnJhb2huWm9CcXY2aWtyZnZF?=
 =?utf-8?B?bHpsb3BzRyt2NGJYWHNpdEtjYlN6ek9hMWxONnN5OUNnTWFVRHY2bzIzMU9w?=
 =?utf-8?B?dnZaWHlGZDB5WDZFa0Y5NDAyTUNVOVF2M21uMldDSkJmZ3VTUjZWY0N0by9Q?=
 =?utf-8?B?ODlnM0xBM1JuTEl4R3hjNTdVQ1hGYWgyVHhmMHUzQnNMam1FTFE5UmlyNUkr?=
 =?utf-8?B?dnhCZUNwckJMYnlyczZxaXZ0R1k4aXFqSnh6TGJvdjhHczhZVjQyUlZOeWt1?=
 =?utf-8?B?SGd4ZW8rbU90d05XTnlXZjZIdG5EbFM5cnZFdGJ1YWhTSWFKSEU0dFQ2MWFr?=
 =?utf-8?B?bXlvbDlxZGUyQlFDb3MrZ3lIaHFNR1oxNCt6bEd5NnZoZTl4MTZGRE5VVFZY?=
 =?utf-8?B?a3A5RVpGQWZ5Rno5Tk9saXNWdkpNT2NuaDRhMEFBTnYrTzI1aytUWVk2RjB5?=
 =?utf-8?B?ZExSRDhPT1dKU1ZQWTlWcUduMjNMU25nb0xjcVZ5QmovM1pOWlZWeVpLRE1J?=
 =?utf-8?B?bU9OWWEvMUNUeGZ3Z1E4blpRN1VMbDRLZENiaGxITHJiVzQrK1BsNWVpa3Zj?=
 =?utf-8?B?NlJDZHZQc1RIQk94VE5QWjQ0NEd0YlVYUG5tNUttZ2hQcjlGSkNLTUpKUWts?=
 =?utf-8?B?Q1V4cnU3TEhSS1M0RWRUck9CY2NJN00yTFJXeGg3MWFCMklFeVJuS1c0eGcx?=
 =?utf-8?B?OENDUjRPSlIrRHk1OE9YcngxN0FwWUtZSStnbVU4RHJ6SnExUlBrWGsxY3l1?=
 =?utf-8?B?Y0xsMG5Qc1NoWEQvQTRXQVNaNGRma3dNTytuQmhGVWM0ckRPMFN2UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2399F236AD35646B12BB426E02E989C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rUG7z+FSD36I7iX3Efqb9Tm9BzIST0gxUfnNadaPvkaRpRKGszenXPWZJoG+ojHDUUkjb8C+9Jx8ejYtZdYDINNPlY4/ONA9bJGuDgXTT4JO9nqumRFbFAwWJcbSMPxtQ6CirG2EJSvYMxIEZghB4NsRjq0y3n6fawYwVAuDhVx5ApikzKHdw4sDRSrjHkqxJ8XPwp07B0utCjBMQkQVQ6DN06kaZZfm/Tu3pazAoP99wD3SuEfZDMiixcBtet3rJYf4U6kd8ASVm8uyOgUZX5yWFoAj0zvJ+IoQGCHvIcqfaQQU2maEOnWShAMzX5cmN1vRKSDryp0oqv3zjjIXNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5880.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadd0c3-e7bb-4237-05fa-08df2527e684
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 10:35:41.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76xg+m76vK4TYQkezzr2pDylTchm/StQKee0ovxg14WTVsMCdIuZWot0cq0L5tIRIwm/bB4mSrhSlM2Uq7QVkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8361
X-MTK: N

T24gU2F0LCAyMDI2LTA5LTI2IGF0IDIxOjI0ICswMjAwLCBWYWxlbnRpbiBIYXVkaXF1ZXQgd3Jv
dGU6DQo+IFdpdGggdGhlIG10ay1zbWkgYW5kIG10ay1pb21tdSBkcml2ZXJzIGJ1aWx0IGFzIG1v
ZHVsZXMsIGEgY29uc3VtZXINCj4gZGV2aWNlIHByb2JlIChlLmcuIG1lZGlhdGVrLWRybSBvbiBN
VDgxODMpIGNhbiByYWNlIHRoZSBpb21tdSdzDQo+IGNvbXBvbmVudCBtYXN0ZXIgYmluZC4gIFRo
ZSBjb25zdW1lcidzIHByb2JlIHBhdGggcnVudGltZS1yZXN1bWVzIGl0cw0KPiBzbWktbGFyYiBz
dXBwbGllcnMsIGFuZCB0aGUgbGFyYidzIHJ1bnRpbWUgcmVzdW1lIHRoZW4gcnVucw0KPiBtdGtf
c21pX2xhcmJfY29uZmlnX3BvcnRfZ2VuMl9nZW5lcmFsKCksIHdoaWNoIGRlcmVmZXJlbmNlcw0K
PiBsYXJiLT5tbXUgYW5kIGxhcmItPmJhbmsuICBUaG9zZSBwb2ludGVycyBhcmUgb25seSBwb3B1
bGF0ZWQgYnkNCj4gbXRrX3NtaV9sYXJiX2JpbmQoKSB3aGVuIHRoZSBjb21wb25lbnQgbWFzdGVy
IGNvbXBsZXRlcywgc28gYSBsYXJiDQo+IHJlc3VtZWQgaW5zaWRlIHRoZSB3aW5kb3cgZGVyZWZl
cmVuY2VzIE5VTEwgYW5kIG9vcHNlcyBpbiB0aGUgbW9kdWxlDQo+IGxvYWRlcidzIGluaXRjYWxs
IGNvbnRleHQuICBUaGUgbW9kdWxlIGxvYWRlciBpcyB0aGVuIHN0dWNrIGFuZCB0aGUNCj4gcmVz
dCBvZiB0aGUgYm9vdCBkaWVzLiAgT24gTVQ4MTgzIChrcmFuZSksIG1lZGlhdGVrLWRybSBtb2R1
bGUgaW5pdA0KPiBoaXRzIHRoaXM6DQo+IA0KPiAgIEludGVybmFsIGVycm9yOiBPb3BzOiAwMDAw
MDAwMDk2MDAwMDA0IFsjMV0gU01QDQo+ICAgQ1BVOiA0IFVJRDogMCBQSUQ6IDI3MCBDb21tOiAo
dWRldi13b3JrZXIpIFRhaW50ZWQ6IEcgVw0KPiAgIHBjIDogbXRrX3NtaV9sYXJiX2NvbmZpZ19w
b3J0X2dlbjJfZ2VuZXJhbCsweGUwLzB4NjYwIFttdGtfc21pXQ0KPiAgIGxyIDogbXRrX3NtaV9s
YXJiX3Jlc3VtZSsweGI4LzB4MWI4IFttdGtfc21pXQ0KPiAgIENhbGwgdHJhY2U6DQo+ICAgIG10
a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dlbmVyYWwrMHhlMC8weDY2MCBbbXRrX3NtaV0g
KFApDQo+ICAgIG10a19zbWlfbGFyYl9yZXN1bWUrMHhiOC8weDFiOCBbbXRrX3NtaV0NCj4gICAg
cG1fZ2VuZXJpY19ydW50aW1lX3Jlc3VtZSsweDM4LzB4ODANCj4gICAgZ2VucGRfcnVudGltZV9y
ZXN1bWUrMHgxMTgvMHgzMjANCj4gICAgcnBtX2NhbGxiYWNrKzB4OGMvMHhjOA0KPiAgICBycG1f
cmVzdW1lKzB4NTU4LzB4NzU4DQo+ICAgIF9fcG1fcnVudGltZV9yZXN1bWUrMHg2NC8weGQ4DQo+
ICAgIHBtX3J1bnRpbWVfZ2V0X3N1cHBsaWVycysweDZjLzB4YjgNCj4gICAgX19kcml2ZXJfcHJv
YmVfZGV2aWNlKzB4NjgvMHgyMzANCj4gICAgZHJpdmVyX3Byb2JlX2RldmljZSsweGRjLzB4MWIw
DQo+ICAgIF9fZHJpdmVyX2F0dGFjaCsweDEwYy8weDJjOA0KPiAgICBidXNfYWRkX2RyaXZlcisw
eDE3Yy8weDJlMA0KPiAgICBfX3BsYXRmb3JtX3JlZ2lzdGVyX2RyaXZlcnMrMHg3Yy8weDFjMA0K
PiAgICBtdGtfZHJtX2luaXQrMHgzOC8weGZkMCBbbWVkaWF0ZWtfZHJtXQ0KPiAgICBkb19vbmVf
aW5pdGNhbGwrMHg2MC8weDRlMA0KPiAgICBkb19pbml0X21vZHVsZSsweGEwLzB4MzA4DQo+ICAg
IGluaXRfbW9kdWxlX2Zyb21fZmlsZSsweDEwYy8weDE4MA0KPiAgICBpZGVtcG90ZW50X2luaXRf
bW9kdWxlKzB4MWY4LzB4MmYwDQo+ICAgIF9fYXJtNjRfc3lzX2Zpbml0X21vZHVsZSsweDc0LzB4
MTIwDQo+IA0KPiBUaGUgb29wc2luZyB1ZGV2IHdvcmtlciBleGl0cyBob2xkaW5nIHRoZSBtb2R1
bGUgbG9hZGVyJ3MgbG9ja3MsIHNvDQo+IGV2ZXJ5IGxhdGVyIG1vZHVsZSBsb2FkIHNvZnQtbG9j
a3MgYW5kIHRoZSBib290IGRpZXMgaW4gdGhlIGluaXRyZC4NCj4gVGhlIHNhbWUgb29wcyB3YXMg
cmVwb3J0ZWQgb24gTVQ4MTg4IChHZW5pbyA3MDAgRVZLKSBmcm9tIG10a19tZHAzDQo+IG1vZHVs
ZSBpbml0Lg0KPiANCj4gUHVibGlzaCB0aGUgYmluZCBzdGF0ZSB3aXRoIHNtcF9zdG9yZV9yZWxl
YXNlKCkgYW5kIGNoZWNrIGl0IHdpdGgNCj4gc21wX2xvYWRfYWNxdWlyZSgpIGluIG10a19zbWlf
bGFyYl9yZXN1bWUoKTsgdGhhdCBhbnN3ZXJzIGhvdyB0aGUNCj4gY2hlY2sgc3luY2hyb25pemVz
IGJldHdlZW4gQ1BVcy4gIEZhaWwgdGhlIHJlc3VtZSB3aXRoIC1FQUdBSU46IHRoZQ0KPiBsYXJi
IHN0YXlzIFJQTV9TVVNQRU5ERUQgYW5kIHJldHJ5YWJsZSwgdGhlIGVycm9yIGlzIGRyb3BwZWQg
YnkNCj4gcG1fcnVudGltZV9nZXRfc3VwcGxpZXJzKCkgb24gdGhlIGRyaXZlci1jb3JlIHByb2Jl
IHBhdGgsIGFuZCB0aGUNCj4gY29uc3VtZXIncyBmaXJzdCBydW50aW1lIHJlc3VtZSBhZnRlciB0
aGUgYmluZCAoYXQgZGlzcGxheSBlbmFibGUsDQo+IG10a19jcnRjX2F0b21pY19lbmFibGUoKSkg
cmUtcnVucyB0aGUgY2FsbGJhY2ssIHdoaWNoIGNvbmZpZ3VyZXMgdGhlDQo+IGxhcmIgcG9ydHMg
dGhlbi4gIEZhaWxpbmcgcmF0aGVyIHRoYW4gc2tpcHBpbmcga2VlcHMgdGhlIGxhcmINCj4gc3Vz
cGVuZGVkIGluc3RlYWQgb2YgbWFya2luZyBpdCBhY3RpdmUgd2l0aCB1bmNvbmZpZ3VyZWQgTU1V
IHBvcnRzLA0KPiB3aGljaCB3b3VsZCBvbmx5IHR1cm4gdGhlIGNyYXNoIGludG8gc2lsZW50IGlv
bW11IGZhdWx0cy4NCj4gDQo+IEEgZmFpbGVkIHN1cHBsaWVyIHJlc3VtZSBkb2VzIG5vdCBicmVh
ayB0aGUgY29uc3VtZXIncyBwcm9iZS4NCj4gcG1fcnVudGltZV9nZXRfc3VwcGxpZXJzKCkgaXMg
dm9pZCBhbmQgZHJvcHMgdGhlIGVycm9yLCBzbyBhIHByb2JlDQo+IGluc2lkZSB0aGUgd2luZG93
IGp1c3QgcHJvY2VlZHMuICBUaGUgZGlzcGxheSBjb21wb25lbnRzIGRvIG5vdCB0b3VjaA0KPiB0
aGUgbGFyYiBpbiBwcm9iZTogbXRrX2Rpc3Bfb3ZsX3Byb2JlKCkgYW5kIGl0cyBzaWJsaW5ncyBv
bmx5IGNhbGwNCj4gcG1fcnVudGltZV9lbmFibGUoKSwgYW5kIG1kcDMgb25seSBlbmFibGVzIHJ1
bnRpbWUgUE0gZm9yIGl0cw0KPiBETUEtY2FwYWJsZSBjb21wb25lbnRzIChtdGstbWRwMy1jb21w
LmMpLiAgVGhlIGZpcnN0IHJlYWwgcnVudGltZQ0KPiByZXN1bWUgaGFwcGVucyBsYXRlciwgYXQg
ZGlzcGxheSBlbmFibGU6IG10a19jcnRjX2F0b21pY19lbmFibGUoKQ0KPiBkb2VzIHBtX3J1bnRp
bWVfcmVzdW1lX2FuZF9nZXQoKSBhbmQgdGhlIGRldmljZSBsaW5rcyByZXN1bWUgdGhlDQo+IGxh
cmIgZmlyc3QuICBCeSB0aGVuIHRoZSBjb21wb25lbnQgbWFzdGVyIGJpbmQgaGFzIGNvbXBsZXRl
ZCwgc28gdGhlDQo+IGxhcmIgY29uZmlndXJlcyBpdHMgcG9ydHMgYW5kIHRoZSByZXN1bWUgc3Vj
Y2VlZHMuICBUaGVyZSBpcyBubw0KPiBkZWFkbG9jayBlaXRoZXI6IHRoZSBiaW5kIG9ubHkgcmVj
b3JkcyB0aGUgbGFyYiBwb2ludGVycywgaXQgZG9lcyBub3QNCj4gcmVzdW1lIHRoZSBsYXJiLCBz
byB0aGUgd2luZG93IGNsb3NlcyB3aGVuIHRoZSBiaW5kIGNvbXBsZXRlcw0KPiByZWdhcmRsZXNz
IG9mIHdoYXQgY29uc3VtZXJzIGRvLiAgLUVOT0RFViBpcyBub3QgYW4gYWx0ZXJuYXRpdmU7DQo+
IGxpa2UgLUVQUk9CRV9ERUZFUiBpdCBpcyByZWNvcmRlZCBpbiBkZXYtPnBvd2VyLnJ1bnRpbWVf
ZXJyb3INCj4gaW5zdGVhZCBvZiBiZWluZyBleGVtcHRlZC4NCj4gDQo+IFRoZSBiaW5kIHN0YXRl
IGlzIGEgc2VwYXJhdGUgZmxhZyByYXRoZXIgdGhhbiBhIE5VTEwgdGVzdCBvbg0KPiBsYXJiLT5t
bXUgc28gdGhhdCB0aGUgcHVibGljYXRpb24gZXhwbGljaXRseSBjb3ZlcnMgYm90aCBsYXJiLT5t
bXUNCj4gYW5kIGxhcmItPmJhbmsuICBtdGtfc21pX2xhcmJfdW5iaW5kKCkgY2xlYXJzIGl0IGFn
YWluIHdpdGgNCj4gV1JJVEVfT05DRSgpLCB3aGljaCBpcyBhbGwgdGhlIGNsZWFyIHNpZGUgbmVl
ZHMgc2luY2UgaXQgcHVibGlzaGVzDQo+IG5vdGhpbmcsIHNvIGFuIGlvbW11IHJlbW92YWwgb3Ig
bW9kdWxlIHVubG9hZCBjYW4gbm90IGxlYXZlIGEgc3RhbGUNCj4gYm91bmQgc3RhdGUgcG9pbnRp
bmcgYXQgdGhlIGZyZWVkIGlvbW11IGRhdGEuICBBIHJlc3VtZSBpbiBmbGlnaHQNCj4gd2hpbGUg
dGhlIGlvbW11IGdvZXMgYXdheSBpcyBhIHByZS1leGlzdGluZyB0ZWFyZG93biBoYXphcmQgKHRo
ZQ0KPiBkYXRhIGl0IHJlYWRzIGJlbG9uZ3MgdG8gdGhlIGlvbW11IGRldmljZSwgd2hvc2UgcmVt
b3ZhbCBicmVha3MNCj4gYm91bmQgY29uc3VtZXJzIGFueXdheSk7IGNsZWFyaW5nIHRoZSBmbGFn
IG1ha2VzIGV2ZXJ5IHJlc3VtZSB0aGF0DQo+IHN0YXJ0cyBhZnRlciB0aGUgY2xlYXIgZmFpbCBz
YWZlbHkgaW5zdGVhZC4NCj4gDQo+IFRlc3RlZCBvbiBNVDgxODMgKGtyYW5lKSB3aXRoIHRoZSBm
dWxsIE1USyBzdGFjayBidWlsdCBhcyBtb2R1bGVzOg0KPiB3aXRoIHRoaXMgY2hhbmdlIGFwcGxp
ZWQgdGhlIG1hY2hpbmUgYm9vdHMgcmVsaWFibHksIHRoZSBpb21tdQ0KPiBwcm9iZXMgYW5kIGJp
bmRzIGFsbCBsYXJicywgYW5kIHRoZSBkaXNwbGF5IHN0YWNrIGNvbWVzIHVwIGZ1bGx5DQo+IGZ1
bmN0aW9uYWwuDQo+IA0KPiBUaGUgRml4ZXM6IHRhZyBwb2ludHMgYXQgNGYwYTFhMWFlMzUxLCB3
aGljaCBtb3ZlZCB0aGUgcG9ydA0KPiBjb25maWd1cmF0aW9uIGludG8gdGhlIHJ1bnRpbWUgcmVz
dW1lLiAgVGhlIGRldmljZSBsaW5rcyB0aGF0IG9wZW4NCj4gdGhlIHJhY2Ugd2luZG93IGFyZSBh
ZGRlZCBvbiB0aGUgbXRrLWlvbW11IHNpZGUsIGJ1dCB0aGUgZGVyZWZlcmVuY2UNCj4gZ3VhcmRl
ZCBoZXJlIGlzIHRoZSBvbmUgdGhhdCBjb21taXQgaW50cm9kdWNlZC4NCj4gDQo+IEZpeGVzOiA0
ZjBhMWExYWUzNTEgKCJtZW1vcnk6IG10ay1zbWk6IEludm9rZSBwbSBydW50aW1lX2NhbGxiYWNr
IHRvDQo+IGVuYWJsZSBjbG9ja3MiKQ0KPiBSZXBvcnRlZC1ieTogSmlhbiBIdWkgTGVlIDxqaWFu
aHVpLmxlZUBjYW5vbmljYWwuY29tPg0KPiBDbG9zZXM6IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1hcm0ta2VybmVsLzIwMjUxMTExMTI0ODUzLjI5MTY4ODktMS1qaWFuaHVpLmxl
ZUBjYW5vbmljYWwuY29tLw0KPiAgDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IENjOiBZb25nIFd1IDx5
b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gQ2M6IEppYW4gSHVpIExlZSA8amlhbmh1aS5sZWVAY2Fu
b25pY2FsLmNvbT4NCj4gQ2M6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5j
b20+DQo+IENjOiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZh
ZWxAa2VybmVsLm9yZz4NCj4gQ2M6IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Pg0KPiBDYzogbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogVmFsZW50aW4gSGF1ZGlxdWV0IDx2YWxlbnRpbi5oYXVkaXF1ZXRAY2Fub25pY2FsLmNvbT4N
Cj4gLS0tDQo+IA0KPiBBIGZpeCBmb3IgdGhpcyB3YXMgcG9zdGVkIGJ5IEppYW4gSHVpIExlZSBp
biBOb3ZlbWJlciAyMDI1LCBidXQgdGhlDQo+IHRocmVhZCB3ZW50IHF1aWV0IGFmdGVyIHJldmll
dy4gIFRoaXMgcmV2aXNpb24gaXMgbm90IGZyb20gdGhlDQo+IG9yaWdpbmFsIHBvc3RlcjogaXQg
aXMgYW4gaW5kZXBlbmRlbnQgcmV3b3JrIG9mIHRoZSBzYW1lIGZpeCwNCj4gc3VibWl0dGVkIGJl
Y2F1c2UgdGhlIHNhbWUgcHJvYmxlbSB3YXMgaGl0IG9uIGtyYW5lIGFuZCB0aGUgbWFjaGluZQ0K
PiBuZWVkZWQgYSB3b3JraW5nIGtlcm5lbC4NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAtIHB1
Ymxpc2ggdGhlIGJpbmQgc3RhdGUgd2l0aCBzbXBfc3RvcmVfcmVsZWFzZSgpL3NtcF9sb2FkX2Fj
cXVpcmUoKQ0KPiAgICBpbnN0ZWFkIG9mIGEgYmFyZSBOVUxMIGNoZWNrLCBhbnN3ZXJpbmcgdGhl
ICJob3cgZG9lcyB0aGlzDQo+ICAgIHN5bmNocm9uaXplIGJldHdlZW4gQ1BVcyIgcXVlc3Rpb24g
ZnJvbSB0aGUgdjEgcmV2aWV3DQo+ICAtIGZhaWwgdGhlIHJlc3VtZSB3aXRoIC1FQUdBSU4gaW5z
dGVhZCBvZiBzaWxlbnRseSBza2lwcGluZyB0aGUgcG9ydA0KPiAgICBjb25maWd1cmF0aW9uOyB0
aGUgbGFyYiBzdGF5cyBSUE1fU1VTUEVOREVEIGFuZCB0aGUgcmV0cnkgaXMNCj4gICAgZGVtYW5k
LWRyaXZlbiAodGhlIGNvbnN1bWVyJ3MgbmV4dCBydW50aW1lIHJlc3VtZSwgYWZ0ZXIgdGhlIGJp
bmQpDQo+ICAtIGNsZWFyIHRoZSBmbGFnIGluIG10a19zbWlfbGFyYl91bmJpbmQoKSBzbyBhbiBp
b21tdSByZW1vdmFsIGNhbg0KPiBub3QNCj4gICAgbGVhdmUgYSBzdGFsZSBib3VuZCBzdGF0ZSBw
b2ludGluZyBhdCB0aGUgZnJlZWQgaW9tbXUgZGF0YQ0KPiAgLSBxdW90ZSB0aGUgb29wcyBiYWNr
dHJhY2UgYW5kIGFkZCBwcm9wZXIgdGFncw0KPiAgZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIHwg
MjcgKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoZSBwYXRjaC4NCg==
