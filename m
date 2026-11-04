Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.149.154
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793777932;
	b=QiifIMVUC4KliQdyRW8KG2tYAhbrQO48Xh8erzXDtYq2fVlHcwsnR4He5fLK/Fr3E9qo
	 dkXQna5jz8NqG1iwnL9e0h89zqkEboNATOR1dLWZgj4y4Fh5uMrG/T6xJIzeTVzyN8Pcn
	 zqdvlKTTAwiQfYqtXpdAK0WL4mavTeaeuh8MhTLRFQJ8ak7eazQHlqX7ijgJ60URF0HoN
	 74b9AvrySFRZAce1ZxJl3QOfBkByK3GD/FJEIlaHZjWs+jbccQy4AQa54iek+dxudAjM2
	 9w8fY/9IFrcjfZe3RkDQjC+XifR/wBIwP3QofUJ9yUcRvVbgblE63Segi1ETCJJPrwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777932;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:Organization:
	 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/y4q2y+2dYtRzm5w43JBO7/Jq6aQD3JRyJHTMXtl/M0=;
	b=Qx5h9rB/T36KVdtm+YPQCpoxXzJWRTAeXYpdilFzeci9MSeImNuPRBzS8THcvHi1z52f
	 xLxvjzrn9u9hK/JouNkDoj6rMfZaiJkdRRhBihO55Aj3y4elwRUeklFwgDyzG1fa+A2uM
	 qwbSH8rCsjkeMditVVSLBUkFYIoPWkZT44VYWQKY/uWkG7y2h30Uj9ac/fa3zfQM7FElM
	 93N4ixj0iYKVLex9AJNehYnaOrV5g8eNlkWsER/4y4dzwIKc0lONS2nU7J+Y2FgRapoHk
	 saiJVacsRAeUiPM2PSWzk3bc79yLufMeNz5lNKu5vqQRSILFPGH44yWppHEvbAJ5R+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=silabs.com;
	spf=pass smtp.mailfrom=silabs.com;
	dkim=pass header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=pps12202023 header.b=JXp2u8sx;
	dkim=pass header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=selector1 header.b=ITqTwiye;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.149.154
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059C606A332;
	Wed,  4 Nov 2026 07:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B059C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=pps12202023 header.b=JXp2u8sx;
	dkim=pass (1024-bit key, unprotected) header.d=silabs.com header.i=@silabs.com header.a=rsa-sha256 header.s=selector1 header.b=ITqTwiye
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40mdMX1029187;
	Wed, 4 Nov 2026 01:38:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=/y4q2y+2dYtRzm5w43JBO7/Jq6aQD3JRyJHTMXtl/M0=; b=JXp2u8sxS6ES
	rxYQqTsM4gcEe76suLKD8mTYd5gZq7JJVr9DEOE938DONKxcrUlqvtoKYbXsyjId
	qB9/Igk/T2jwanmNHwng66oyM6m35X0EF/KyKD1T5TDX7vNQS8gz6+/IhOw4rY0z
	o9ETjyQO7usSgju3+TIlkTaFruJ1Hd14a94m/P/a0T6AiiMEfWRKXLg5rWwmtfsH
	+288iVGLkQLvQiFF9EWk5X99YHgToXLHaIm0PU17ZR96kM9APMWDrAP4lS9mr+dK
	tQ7c6YbaslGOpsG+8BRdCyWdO3Ztdwkkyc6UuwYqowUJRB3vgkuleFI83VelByPz
	vNHT0ERTbQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020114.outbound.protection.outlook.com [52.101.201.114])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4hncna1e7q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 01:38:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEuCdc8zUoG+4b30Em1BtP8A2nCz5O4MQb8g0hHN2uoTkJE12J6gCFotrrSFJH0TYDzLRx+gUlA1QHWSGO+sX6AeubBnVQVHNa8JRkvbSJ9RWdfsNJbGCGLFqW8UUPbOkAw8ecmXMD0DLhuxiC5dITA64bhXP0fOCqZ1zlix1jVv7/QXl2ZhUVVOwZFTeMGoVdoC3UeAUc3ZUpU9rG1JUtKQh9TGkmrsUnCLcRVt6buQRzCQoX+32Rzj+E12vQfUDfRevhKM5gN3sPVGPh3a7zg+aYxF2HIiBgA5fr8f7t0fyEWZoqxOgS1EKGqV4JeziuvAHzZSVt66wAW/rxCt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y4q2y+2dYtRzm5w43JBO7/Jq6aQD3JRyJHTMXtl/M0=;
 b=BU6jL9s6wntY2EMp8Q1gAVLXMNtA4J7hfwWqhYoSi8/QE2hKyBIggxZ64sr9yVfJTWZW0PjWT/9cNfzoREPXFDRtbg2kjrkkSAUSUGt0G0J9/yGayk88eIogbzef+R7xShZ3QgF3qkR6fCqMmmFZsJf/EfSPn/NxKTbAEv4aJTPvYfRYTIfhOw6TetMR0N9TvSn+9qGrYRQsfNy0trfRu79KmZp9UpKeF2L7iCJUlRzRCe/RLy0ufrVw0k+kUSQSgNWlP/8Ry70Ajkz+V7/UwUu/2Qp823m2vW7vHQ8FKp1ZTmjCbAi/H/WMCbe6Dd01W1jiW/GoOMw/HQcV0Rszrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y4q2y+2dYtRzm5w43JBO7/Jq6aQD3JRyJHTMXtl/M0=;
 b=ITqTwiyemfh8cpGwAEPlONqdl6zwVHKR8SEaILM9+Ge/Umow2J6JGt4KqOwf7RsKknf2olHDKPsAlEl9fli24B2ImNgBX5h+gp0iPw2J42UnMcu04ff8OMSe/skzxdgYhUpKf0QA9pFX/P8tpuXnGrthVkntu6nCxgWRl3DqwCU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 07:38:30 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::acd3:fd18:5809:64c4%4]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 07:38:30 +0000
From: =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
To: linux-wireless@vger.kernel.org, Tristan Madani <tristmd@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
Subject:
 Re: [PATCH wireless] wifi: wfx: validate num_tx_confs against message length
Date: Wed, 04 Nov 2026 08:38:26 +0100
Message-ID: <6204727.CvnuH1ECHv@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20261103232650.13350-1-tristmd@gmail.com>
References: <20261103232650.13350-1-tristmd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: PA7P264CA0350.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 62560604-1457-43d8-bb95-08df3a469f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|38350700014|18002099003|22082099003|261102123227099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	AX4GcLp50N5WRPON+UjRHhGYwS2k1qQAXpMarc0xBElooP19CzVwAtIiIs3uVf+BaATVIeA/clvpzm0dLBCh1JQBU4H8c4rcjgYgQHC0+Ubga3C50t+VfAIYoIGedMSNaImPrW+jRVn31BXny16A4u+avR6y8XoLKO2MOXtzgVMTTz7M6l7f2OVdGOlCpLCaSfHiZ7ZX1xX4UA0jfN3PQ9q/8fD3ZbGzoB7J5fzIjksJHhOjl9nXlTqkhf2RFjk9SR3LWL3aLj/aP2HpQzHL3TA6136hERd2xz5ZhVv1i5GmGhIHXbRbifEDWRFaAHWotu8b1dup6KDHArTeNySC9emrssCwteKJCsXVYUijUCVK5C8h7M5RLyLN2SPdfYAd1H6AY4PgIPqeYCjY5Vvdg7BrWESRxC5hERj1rjImVTPi5BZ0lzHmJ0qN/khTa9zKUwPH8MM12dCtzi3y/3dEKsKgJMGoVihKy+aw37eeEpq5dP5E3m7OWl8DZ8nQ8K+jhCi4KrOzzvaJXrauqlzKlSkcW0yy7u+rJwlgjp7NefKD8H0ZTuOPZ0xSbUBC7JrBlqTgVaCgD3Qw98tRF8TABrwEFAJ71SEi355JQUc99aPUWuvuC0cTsGOQNpDAuAkrKRyxMfDLv0DAR8aDmJdTK4ozQza9DTqWKT79Otxm+ZUdIKn3+oTLC4c8K8riGok+3yuBGiE6qpEuJGmU1ngUf3PfXZRsA0260u4mwy3hFBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(38350700014)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2ZiUHdwek5QNVh5dkNqRlhWNHZadEtWTER2bzFES2UyWk81QWozUE9UbmJC?=
 =?utf-8?B?NzMyZFRJck93dTZKNzJESHRuS1I3N2FmSjNtOVU3d1Z6YkduemZhNnZUekYy?=
 =?utf-8?B?RmtUNHVLODJmeVVvcGRRNXNOMUJRTVA5c0x1MGFJMERZVU93elVxTE0vQnhh?=
 =?utf-8?B?cUw3cXhUVHlnU09YUTcydURjcUMxNzVuSDFGWXppb25tN2FpQzN3bFZLUUlv?=
 =?utf-8?B?QllVSHA4R3Z3bEhDWXRQUWN1eUdzeUhLWWRVV3VuQ1NOV3ZEL1NlWWhwOFFi?=
 =?utf-8?B?YW4xMmpGTzdzZGR4VUJZSWFVaDBLUytWMFpkL1ArUkxaQmJ2bkc4enNiQlhl?=
 =?utf-8?B?NmlOZTRLbzlGOS8xUmxGb2h3WFRmc2RpYkREQUg0VGphYUszcDQrd2lCYk1X?=
 =?utf-8?B?KzZab0MzNmxmTjdUVW9XRUREUG5WRVU2WjdNUUZpWk9BY2dZUWszRWM3MEtO?=
 =?utf-8?B?L1Z1bDI1RXI1VldmemJuVjRFdGRFbUNYWkdPT1VWWlN6UUV2Ny9PVStWNnhZ?=
 =?utf-8?B?ZU9La2w0aUtOL21mRVA3VHN0SjlLM3JpZklPcEVUTlUzem5RdVlra1dRVnJF?=
 =?utf-8?B?NGFWbmhvVFRxc1gzaDZQRCsxQzRZaCs0WVNRVFBuVHk4NkVLRzhZY1R6bndh?=
 =?utf-8?B?OUd3dXphOGZpdnVGM2UyN2RKbzBPdGIrWUZ5VjdNVFhaRmxlYVZ1OW1nSFo5?=
 =?utf-8?B?cFdTZDJlb0NRdEE1MmkzQUtNcjduWkRXdjdhQm00cjZiNVl1MndxaFlHczR2?=
 =?utf-8?B?cVd5YWdDRVVLV09iWndxYm9EYTdCWGN2cSs0SmpMZUZGS2JRNlluNUVIN0VH?=
 =?utf-8?B?WkJJRWNXcHZUQ2FYMjdBRUltOWlITGNVVHgrLzExN01BUFZyd1pXN0JiR3pH?=
 =?utf-8?B?aU9KU29uWlplWS9CWTNIVTdMZHZjSWhlVjI5Y2JhRlp1NWlSRFlKd0E2UE5y?=
 =?utf-8?B?MkZGWWNhckNKVUhFenZLL1h1bWtjSEdHd05SSm1rZ0EzdVV2NnA1bFNFQjJl?=
 =?utf-8?B?ckV4YzJnRjBHcmt0VWhGVGY4ZTl0Y1VBZG1WTTRMd2FsdkYxL1VMa21JUmtp?=
 =?utf-8?B?VE1ZQVR0Z0dGdlo1U1NoOHJ1V0k4azJHcEtxV3hjczRWS0tVbU5CcGhtRXV4?=
 =?utf-8?B?ODB2WWFJYlU1VFQ3MVFoQXJNcmZWSFpKNzZJMDJzcDIvUFpxUllSN2hRMU1s?=
 =?utf-8?B?YnJkMTQ2c0FsZTcyT1d4M0dkUTlqc1JOdU81clltT0dvVkE3cVpRckdBek5a?=
 =?utf-8?B?ZmpvWFZidk0wa2tHeGZHT1ZkaE1RaU5UMndNRGpiaHRrUS84VUdkdHRwbW4w?=
 =?utf-8?B?cDlDQ1FVakpiZVR2VUdROG54YXR6MkZtRks4cUxMQmdBL1I5R3lRdC9GWE5S?=
 =?utf-8?B?d1REdFhQcVZqcWpsa0dsVnhJUHpkdlZFNnZNeEMwWlFVd3puV2hMT2QvUngx?=
 =?utf-8?B?eDJ0d1V2SWQ1bjFRU2tENVZWMDFmQ3dIRzRqV2dnb21MelUrQnpISEQybDJK?=
 =?utf-8?B?SFVDN2hvWWZLOVplSkFicnd6MmhvQ0dvdU1FMnU5Sm9VaFM4WTR4QlpQNitG?=
 =?utf-8?B?UldMWi9mc0xTY3ZBQkMvazdIQUM3WDFqdnFsZGdodEt4RzMxTmdNUjRxWXZJ?=
 =?utf-8?B?b0F4VjRjSUdYckZHZS9GS2laeUdsWUU4T2N6Ykd2a2xkakk4bUh6dXJjYWNk?=
 =?utf-8?B?bm5VNisvSFN5U2FEb3ZydDFCRk5HRnlaRGRyemwwR3BQV3FnN203UEE5bExN?=
 =?utf-8?B?NUtSNmJWUVdWZm9qQ0pUc2tqN1dteDRKWDNFcUtXZ0grcUdrbFNkK2FBUk15?=
 =?utf-8?B?c3lsZzczKytqV1YwVkRveG1ZQUh0N2hJU3hDOVRFcHh1R2VaNFdJbFY3RmNi?=
 =?utf-8?B?MjcrcnFDY0syWEI2RHVVdCtDdDVKZXBNVWc0RHU0WGRaU1g1c1piak1TcUE4?=
 =?utf-8?B?dVV3d1RCeTAybnh2V1NZSVdVQ05KU01lVmwxbmV2YkNhYkNmcFlDTW4vaFlh?=
 =?utf-8?B?TlNrUHZOWGRnaFhsZEpKaE8wb2NCNjNPS25yaDI1eCtVZ2tSY2NkRSs4R3pG?=
 =?utf-8?B?S1M4NlpiUTVsRDltV0pSS0g4aW5tMHdZVDVPa255VlV4eEhRSTByV3YvZDlP?=
 =?utf-8?B?bHU5UmYvWUhWUTFWaVlBR2QwTW1qbWZ1cTcwODZwck9UU2hyTGEwMmZweE1q?=
 =?utf-8?B?bEUwd1l2THRhSDZkVmVxcm5BL01YbTA0UnFtT0xpUW1ZRFMxYlExYjU3Q1NX?=
 =?utf-8?B?VGMrM0JBcUNTNi9aN3F4YnBaaWFyNHp5YlZGbHdabENFd3FRd2lGQllyamxr?=
 =?utf-8?B?UFMzQ3hOTWozTzRyQ2VhVUF5RVZ5NUdPYnRXSGpnQ2x1L1RBUnN5QT09?=
X-Exchange-RoutingPolicyChecked:
	oRyf/jrYl7jtLKHmxcJ6f5y0kMgVeYYDdB+x6ZQHplyz6GRPiLQ+M83VMcRVTk7KfMsS2HUUamEXqASSzNVQc1uNkQmGagtDu+T4TaeWUJr3JoZIq7JcqhoyqoAfiGSkgIKP/rJQ+sGoDLoi50MgBDqbD3eqS9PXiEhCQIhuWOJieMvSFkvQ4mkLj44Majdc+Qyk0ffXILe6AFgMW0PuxdktkhVatLc0DeHh3mg/K9d0M6V58B168ocybKrZb6JKwVYUbV+PK6MWLiIcmL1+D6qUckfuI3pDLlUqjjReGd6TxEjW0ReNVfbkxUOZyDJn/XXyKgPujO/OIAqVC1qBZA==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62560604-1457-43d8-bb95-08df3a469f02
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 07:38:30.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1a9Ae4/RJfFACwh1tUOHYQ+Ay/p2/4PRc1OCFlYq6kiDCEGpHJSj5YFENsE3b+f2xT/6n0ZTEExFumfFP3R2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
X-Authority-Analysis: v=2.4 cv=OKKyTiaB c=1 sm=1 tr=0 ts=6aeae0fa cx=c_pps
 a=b+YkWSWpBA3VYLEuQ6BQHg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=i1IsUcr2s-wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gIHJBl62Mt9vjvfn7G3b:22
 a=6KgOrB_2K63Cyhqxo4vW:22 a=J_-Nd1mkAAAA:8 a=VwQbUJbxAAAA:8
 a=0K6fgVflpJQ6qp6Tg3UA:9 a=QEXdDO2ut3YA:10 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-ORIG-GUID: 0CMhD46KOFPqW1pJaPbijyRknEfDUxiO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX2XSL+PGc3K0I
 dscbYBxss8FnHkdI1vNeF1tyc2uuCRa7a+6EvTGvZATla3TM8H0/hfM/y/W0wBZo5mGj/kU7viR
 Ojl5OwuPRLzour2z3iF0eF4SE3GnjNCvkA6cj1STfeJupFKBFP2hBaY/v7P+8PiSA5ZhunflLuY
 SB+c3Q+yV7FVhsIAnRMmkwy+Lax8PoioG9/GCMVCShA1BbxHNsZZu1wih5dHu/sHVjO8NN2kDF5
 XAaPHiP+GpkAPCSOBUm8z7eQ9HBhS49bus3EBePFTe0dX8rraM/Nx+1SrknQCxjum0twzfZ68LP
 +yHMAoD72TEuUq8YYjmr2Hrw4mgl86UFX8u4WCg/jvImeKGup4Ri6aPl1jz4Whpy/nV2qqmyrKA
 y/5zP1rFRvGugUAVFiKq1eR1u/hoK2LYomfYbAS/MoCMYY7PanqAigY9K7ujiUmOv4NIRA3LOTp
 jmpZ3DRL5SdCvoJwDFg==
X-Proofpoint-GUID: 0CMhD46KOFPqW1pJaPbijyRknEfDUxiO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX4F20EkeQZYLz
 b0mSkv/6kgEs9ZCwH4IWGPJBM+ojSS4pPDyVPtiWW8llXPl2j+OPzJZevRj94sud4Co7f1kgzhV
 AsVlhB05b5rtSFWpbVp6ePCbwxEklqA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040030

On Wednesday 4 November 2026 00:26:50 Central European Standard Time Trista=
n Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> wfx_hif_multi_tx_confirm() iterates over the tx_conf_payload flexible
> array based on body->num_tx_confs, but does not check that the message
> is actually large enough to contain that many entries. Add a check
> comparing num_tx_confs against the available message payload before
> iterating.
>=20
> Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/net/wireless/silabs/wfx/hif_rx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/wireless/silabs/wfx/hif_rx.c b/drivers/net/wirel=
ess/silabs/wfx/hif_rx.c
> index 64ca8acb8e4f2..42417db66c128 100644
> --- a/drivers/net/wireless/silabs/wfx/hif_rx.c
> +++ b/drivers/net/wireless/silabs/wfx/hif_rx.c
> @@ -62,8 +62,17 @@ static int wfx_hif_multi_tx_confirm(struct wfx_dev *wd=
ev,
>                                     const struct wfx_hif_msg *hif, const =
void *buf)
>  {
>         const struct wfx_hif_cnf_multi_transmit *body =3D buf;
> +       size_t needed;
>         int i;
>=20
> +       needed =3D sizeof(*body) +
> +                body->num_tx_confs * sizeof(body->tx_conf_payload[0]);
> +       if (le16_to_cpu(hif->len) < sizeof(*hif) + needed) {
> +               dev_warn(wdev->dev, "invalid num_tx_confs %d for msg leng=
th %d\n",
> +                        body->num_tx_confs, le16_to_cpu(hif->len));
> +               return -EINVAL;
> +       }
> +
[...]

body->num_tx_confs is already used in rx_helper(). So, the
error detection happens to late.

--=20
J=C3=A9r=C3=B4me Pouiller


