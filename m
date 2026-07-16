Received: from mx0b-00756801.pphosted.com (mx0b-00756801.pphosted.com [205.220.182.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D73F8224;
	Thu, 16 Jul 2026 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.182.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195214; cv=fail; b=ND0x6i7xRqZ9ekgV4YPbsmw3VDU+N5Aw/GmWYwJnPtYO/Rokk9kXwDABz1bje4Ryz7Br5ZoQIrsShy/349Eo0Ozde3CZ3c5eJMJxgVBicPB4JNF5g5SWKFxSThZLOdQn4buRmHP7OgHFb2gi+2meqvYocA8WGPVzGrzRZJ0vXqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195214; c=relaxed/simple;
	bh=n0uD1bh/Z94A8Xc1lflGqU6P75ZiH/ZK8Qrk+Cp2hr8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RIL5eykBa52dI8QyRVcC2SAovCHndvYhnkbvxQ4ebA+zYGe71u1PcnwuN/PKgtMRPAsHEU2pa7xpVRNLB62lVeoMv1b2g2upI1XAXJlcFocddLVD66zJyQxeu6GW+EWeQgT9A0Q7uYBn0op3hYF+BOb2eEKj6OvjckldlfdlGls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com; spf=pass smtp.mailfrom=nozominetworks.com; dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b=PD7io+97; arc=fail smtp.client-ip=205.220.182.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b="PD7io+97"
Received: from pps.filterd (m0297687.ppops.net [127.0.0.1])
	by mx0a-00756801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7HIVR1248865;
	Thu, 16 Jul 2026 02:46:36 -0700
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11023135.outbound.protection.outlook.com [52.101.72.135])
	by mx0a-00756801.pphosted.com (PPS) with ESMTPS id 4fbjsvd3gx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 02:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma6+5clWM9Liq7vkX3wkr9Ew9dZLEMN1Q4K6Bm3JwuwSyn9/eQjNJuwxbuzdHo7WpsyCzc0JxN4jazoIFRcyBGyxHHSg9QLzcV4URptZLH9D2yORjTM2cSs34y6lSmgYwfxCY2B702aZiv1CAIgXGtgTHGG9bzDakrLPF04kbMs9naSUEM8C7EEZYLVIRsxSCG98rDyFyaww8GHcekBmt/kCMOV5tOSb6AY9ttuneglNIkmkJfrigxmoKvywfU2ra2eLemDt6zmdRcONPTXM86LRSE+6K/N2kKDdrS/jgUW9We0IkxLELzpVh3OZ5Q82xaMxOHjrQoZAKBAAmDJYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW+g/ohPqeRyadR8ryWCp7fTGcSabXxb9+V2wLzdBq0=;
 b=yAglTehyBsF7G7RvkmLf8BROCp8m58WteeoCHn/dEIyl5NsCdRMgyTDR3yeZZsTg8ZQ5C4CzNGbPfyhwJGsaRc7ersX6K0/c/tMEyjC1hZ7f2ZwHgC3K+RER1mQR3sbsymx4+300sfeTyiJ6G/HzSPgAueqFwCrSdp40vu6Q3S9hefQVH9E6s8hknyPko5Fs07rYNNjAlteYOKllDo1Xxph+LStTH+gFdQNR3xr9nKYlB5C1/SRLgnROpdKgGwVF9L3JrQyMFW2EPSdyDY4TQ+bM9hf1JbXTfI1Y6xM9TfuzoHvT+wE3vq/Wpq81DzbnDWKZnnkNxuqtllo18Ucaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nozominetworks.com; dmarc=pass action=none
 header.from=nozominetworks.com; dkim=pass header.d=nozominetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozominetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW+g/ohPqeRyadR8ryWCp7fTGcSabXxb9+V2wLzdBq0=;
 b=PD7io+97uOhAdqVC+/N1S+GVKBJCe/EHnBn0SUR3hmot0/77knWVK9IqzJU8uUAOG/jcQ3lJiZ9IZDrjhvFIiqCD+ghJegCdYIuTxTRL6XNImfL77hLOsj2Sznyf9Z9baZGK/4JnIPUgezZhSaHm0GBC9MSYO1Hmgl1FScwStBs=
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 (2603:10a6:800:2f8::12) by AM9PR03MB7506.eurprd03.prod.outlook.com
 (2603:10a6:20b:262::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 09:46:33 +0000
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f]) by VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 09:46:33 +0000
From: =?iso-8859-1?Q?Alexandro_Cal=F2?= <alexandro.calo@nozominetworks.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "hyc.lee@gmail.com"
	<hyc.lee@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()
Thread-Topic: [PATCH] fs/ntfs: Fix index_root heap OOB write in
 ntfs_ir_to_ib()
Thread-Index: AQHdFQf8pctdjMaGQUyt24yNAfW4RQ==
Date: Thu, 16 Jul 2026 09:46:33 +0000
Message-ID: <714A2D6E-5B61-4185-AD6C-328250C8E040@nozominetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR03MB11174:EE_|AM9PR03MB7506:EE_
x-ms-office365-filtering-correlation-id: 17f1209a-f82f-4cb7-8c0c-08dee31f1f23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|11063799006|56012099006|10067099003|18002099003;
x-microsoft-antispam-message-info:
 xbYwMVr2MnX62vTIRg4zsxboXYFfQ3zypnLvEknRJJUlG4ySSKFgrpA+eCmB7O/BJVb2LxSZ+WfBooRh3qXwTsrQmZJDbUfz+afvGWUVRP59RbaR5X0DzQ2vm9yWQTnX4WV0pqmQkiLT3qsjxCnOIrGzhtt+g2s4P68JpliMmt9fWln95Z2CEeAUlz4qSki1geVZihQO8UnV3QqWFBo4sMDJfgG5insct/SWCHVRhydGZ/C1WqHxpU1/00lx2xqILvQ2LEUF6sH6RaK6e8rT8m9uT53mq1cADz7PEfGnXuT6RvdOei6O35uErDnc64kY+CD2vuWJCvC6uYt8f7uo43sy4m9BiGtR/XUqi3RQkRCYW3/rMP/WSIgcse9N7q2/yz2Vxd5qvvnJJy2PJRHu0BTr7yY92neLKtrBBifHpOo18DxUMXm7vX8jSm3P7BtGDfwpR/cz+JRkfDNIEdWapbyPvoR1OGCBU6MaaU+v9LqgF0+QXXjZvSvTUVI9Y/K44erZHxvSvkHZskkMOlihMtI40jJnGKI0oDYmlZ9vRqz3E829H2HSmH9kX1B87dD4RpuRpY5ID3/U4dBWatFG6HSUrY+hya4zf8oXUBG2a6XpA08wWYRx8awmOSjZRtsKvU1NaMRXUtopRPIzjfBPHiHAAN4ZweCoVXemdK1InOR0buJ8eNRjuKRF79721k+RR4RHQvDvrxUSK+/vhZEBbVoRzMqKt7t2iLjsnroc1eE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR03MB11174.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gDRNXNBTrq3K+ViJEaWeu2hC3dE+gZwiwmiyHTbN0s1b+SQ/Pwi6sefXqg?=
 =?iso-8859-1?Q?XM3CBXQhNHKMUIab5d7vEE9u/6bvty1flDgTGAw5JukkQ4oeRMBMTeztW1?=
 =?iso-8859-1?Q?8naGAtx0YIrmSOOiP9Af4skITtwo+50t9PmNw7Ll21TvdDSaL5swnQZX7E?=
 =?iso-8859-1?Q?yspduW7H9st5p20YnGRwidj4SRu8dCXbmwYhHooHY8lS/FIk3DajScSZoz?=
 =?iso-8859-1?Q?yvwK/Z9eRRgrjiSlO/niFauPPM+J+VhDvmPTqZUgQc/BBJ6aLh0jlThi/B?=
 =?iso-8859-1?Q?vW58P53RkhNYKnr1AXD6EVSUxEWzv1PBHVbyHbrj91wvIOL7h0zbrWdKmk?=
 =?iso-8859-1?Q?S5EjpjWBb7fKw8BZ429gecmm+M6GLheZ8FQtEAHCS3KqL4QlH9rhHh99LU?=
 =?iso-8859-1?Q?NU9il9uv3wYglkDX0YU00fBl/GS6tAL0595mMxKyTCilT7/Gr7V+iteQqn?=
 =?iso-8859-1?Q?UQz/+jNUYiUE0AzcKrwW9zxvzmz3e5brh7oQo5OkT4Jp08YplhmAe+qf8E?=
 =?iso-8859-1?Q?thbH+W1T63OUt96MHto569gelhNZwVUoE3Tq0wI+TM/rVdimLuw9Q0H8m0?=
 =?iso-8859-1?Q?0EzkNqLj50jtiTZIEnLL7wrADnPNmKWbLt1m1S0ZwgzG10ZfLV88vFCWNA?=
 =?iso-8859-1?Q?uaR7SgmKumBJu72y7bt+q/s30r/3EaIDKG8z46Aq6i+iItX6jxhH9DqvXb?=
 =?iso-8859-1?Q?H5sFc4a2zK+5ztQc1fTLLSshDbVzpQBogs7VqD+EKkYcnRgw256lDNvxuZ?=
 =?iso-8859-1?Q?amYtXdslzqJeNrCvzH53ja2ppP1t5QPHVJXQr0K4myPK+AAp90Hdz8Qiy8?=
 =?iso-8859-1?Q?5yIiruGruvNB1PzV6m9KqOTEKygV06sYrxlpsRAuzQpkKK7wdXsx4Po8C3?=
 =?iso-8859-1?Q?ry03apdZ+CkLjIsCU7GQJmqFt9VYJAWRDr/71HUPhLUpAzJvr1I4VIdxAM?=
 =?iso-8859-1?Q?S7rOKyC7ye/4+jrOVenyNvF68+65WqizKWP1hIKnE7QPEb9F/r5w3sxN2A?=
 =?iso-8859-1?Q?sVp0G5DezMS7ZJQ3eTxLqmPUUy9M+8OFgGb/kD8yFJq06AhRF4c1J7OW3N?=
 =?iso-8859-1?Q?gnwZmps79OwV0dqxPl6d2cYFtl2zbLDz4KcO9Qc7f2W/09dTn01aAcW6Xz?=
 =?iso-8859-1?Q?RxgIJ6JVy5DyF/C/NzLccVUNGpHYAKI7InBe1M3+MxBqNZYq8LAZ/OirkJ?=
 =?iso-8859-1?Q?8Ep9FB8iLBe068zOCOCxgHC5QpbIJl+8u7NW0nqh+A9y6OVKHTA7NXDUkK?=
 =?iso-8859-1?Q?TkTRgRPoLd8ihQMonQreiEbZpCvaKkEmOTFW5V8e0Iv68LXg/G2hCZP5Vw?=
 =?iso-8859-1?Q?ekf0GavDfZzhUFAV33dGEOj0P9eAVpMm6LglYEUAuJwCBzchY5GnCqzd6p?=
 =?iso-8859-1?Q?RYpf7RNbwc+vlmQHRF8hZfdM9sfavGEjpEd0LuvC2Y3ncJuuelbu8/bn94?=
 =?iso-8859-1?Q?hbsKMrEhWfVRDzPCxqRrK8Lq7bqzwv6ze3gvFv7i8EmlARuzLbmQSlNHMo?=
 =?iso-8859-1?Q?vUn2s3FTGrVt1XdY4d16GOWt9SvMqI7ByWGxtCkwD4Z5nGXUvJy7aKl18o?=
 =?iso-8859-1?Q?8gQqnneDQ55oNbW6EIiDVmoIrCnU75//+PLEKPYnXbJqR5dPzRa2Mvy7iq?=
 =?iso-8859-1?Q?1YYXGb1WVnXLJS9dYZVS0wdZkU7rl+1Vvua5GAWi9Ctp10bPvfmbBzje+l?=
 =?iso-8859-1?Q?9xkXK6a9nwhwsK6Rwip4ldv4xkGBzODH4CmTWh/VaeO+IyrqeSZUeEr/TE?=
 =?iso-8859-1?Q?hJM6b46sDplveCduwON4DRzvU8QHw1KJugAClyZ3PHMZWEdr6aMHs3eATi?=
 =?iso-8859-1?Q?ekrG/t8MbTxc60wiK2WWL3400lXIWju4o7qNr60FWqZwO8ujMKSX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B2EF96EE44E130489D7C65398F55A662@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZYAz5yTvX6AY0LCzB1HPJG9jX0nyb/1dciX2ILZ70GLMMnTiYeSyLmBEX1KOqotXXCg+U5B5yNO6ruWUOp47wuO5Q+FEnEML7Y4bZGrurzl4NvQRcvtSZvWvt3VhY0RCJx/p2sqaCnbAcTFRxIZLZkkNnJ3RqeYsO7uMtX7hdIbwJeMjTcEvIIb7hV1BacEyexrqNwbjJnEfi0UbATakWd4WvXSsL1Hg1R5NcGwyMsUlWjfL/bEvPVJC/Wc4laoIW0Fsj6USKILU7P/jshiVUmifkj6B7lT+xhPb1SOBfY8vxNMg5nC4Bwd2ZhbEhz3lvBAeb8qlnEFl1OL7L0AL3Q==
X-OriginatorOrg: nozominetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11174.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f1209a-f82f-4cb7-8c0c-08dee31f1f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 09:46:33.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f04d14b-0796-4b81-b7fd-779778e05341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqoot1YSjcDauZsDE9aBSFJ2aWh88PfWZmkaO+cOcCzcj1VYuUDaB2ZoZ4iA+XIl44ejfA7HqovV+sSebvChZ5hSOcPyeOkKGcWyjHDkGzG4fklR+L7U2tnMzkf3QMbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7506
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEwMCBTYWx0ZWRfX/y/d7cYsCVyX
 Gn3Lo2fG2HVlp8XsesMmcUvMEcos2qTixtgRWMS7Hk0IObYF8sqL6xHtQ4/4+HWaYAlGH0mVBiF
 T/uVsnLT1XxFSe7Ofo+S8CJj/nyzYfU6BrrSx6mEn2fzZEep0IRu
X-Authority-Analysis: v=2.4 cv=NdHWEWD4 c=1 sm=1 tr=0 ts=6a58a87c cx=c_pps
 a=zd2gtXrgLElDIDyHc0M0PA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=LLPZWm0_0O8A:10 a=nBHfkqHukZMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7VS2YgxpqphC4cixgVMD:22 a=sCtaNhFbwZJXAHy4C4eS:22
 a=GqK9ZfNKAAAA:8 a=VJParumXg7svP2lGl5kA:9 a=wPNLvfGTeEIA:10
 a=BFatPaWxP-aY11LYkd1a:22
X-Proofpoint-ORIG-GUID: uWTeURwEYw0T7hEQT15oHCrze-m7Huq8
X-Proofpoint-GUID: uWTeURwEYw0T7hEQT15oHCrze-m7Huq8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEwMCBTYWx0ZWRfXwpev884aaZ4Z
 YTzwuLlwIfnlqFmEgKLp299CSgGL8PUacpH9J4T4FTatAcnJD3wEaQyzlHmzjdDfMwVzgcvIEH8
 aqyH2u9MPtUlhCECXlgS5NDxyptIfRl815HbHAO3z0+orUkfXJO+o1X6Sh9KBNiZjYvuB4ytl70
 v61iFDjuEUgrot0qp+FTj3JLeyWr4kZC2jHsJJNBx1QPb8dp3aSvbbxAFwc4pJ+WNa1ZDkuJihs
 O3r1mCHguRmr2xqvbGnswii8+tpZHLWnry+XvO1LlfYxrXc8MQHnZO1X2pxTUlz0VsFoGtrFn+s
 l5rCmZSo0feYjWxT2Ufubr6Ooepjx1LgBBiazyP3gARNTpMuovrYixy2rmJuJfTulGcQLdPpqWc
 kWAAcu20EJxs9VMyTLLuikaBfZOcKruSblNCpXkyxrNmBy3Z7w+Tk3/HF4Itc2r3X9jfkZmYlq2
 +cTgDbVkn3URoHQUeYA==

From: Alexandro Calo <alexandro.calo@nozominetworks.com>
Date: Thu, 16 Jul 2026 11:30:04 +0200
Subject: [PATCH] fs/ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()

ntfs_ir_to_ib copies all entries from index_root into a freshly allocated
index_block_size-byte buffer without verifying that the entries fit in the=
=20
available space. The entries in index_root may be larger than the usable
entry space in the index block.

This can cause OOB writes past the end of the allocation.

The validator ntfs_index_root_inconsistent() checks that entries are
self-consistent within the IR value, but never cross-checks them against
index_block_size. There is no bounds check in ntfs_ir_to_ib() before the
memcpy.

Fixing this at the sink in ntfs_ir_to_ib() since=20
ntfs_index_root_inconsistent() validates the logical consistency of
index_root as a structure and a root with large entries is a structurally=20
valid root. The bug is a size conflict of ntfs_ir_to_ib().
Also, the validator is called once per inode load in
ntfs_read_locked_inode() while ntfs_ir_to_ib() is only called during a
reparent, a check there adds no overhead to the common path.
Moreover, even a future call path that bypasses the validator would still
be protected.=20

This heap out-of-bounds write is triggered by a crafted filesystem image,
which is not in the kernel threat model, anyway, fixing memory errors would
be nice to keep  things secure.

Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
---
 fs/ntfs/index.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index faa7ee920a3a..529697b5891e 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1112,6 +1112,7 @@ static struct index_block *ntfs_ir_to_ib(struct index=
_root *ir, s64 ib_vcn)
 	struct index_entry *ie_last;
 	char *ies_start, *ies_end;
 	int i;
+	u32 ib_cap;
=20
 	ntfs_debug("Entering\n");
=20
@@ -1127,6 +1128,15 @@ static struct index_block *ntfs_ir_to_ib(struct inde=
x_root *ir, s64 ib_vcn)
 	 * as well, which can never have any data.
 	 */
 	i =3D (char *)ie_last - ies_start + le16_to_cpu(ie_last->length);
+
+	/* Entries must fit in the allocated index block */
+	ib_cap =3D le32_to_cpu(ib->index.allocated_size)
+		- le32_to_cpu(ib->index.entries_offset);
+	if ((u32)i > ib_cap) {
+		kvfree(ib);
+		return NULL;
+	}
+
 	memcpy(ntfs_ie_get_first(&ib->index), ies_start, i);
=20
 	ib->index.flags =3D ir->index.flags;

base-commit: 37e2f878a7a660a216cc7a60459995fefd150f25
--=20
2.47.3

