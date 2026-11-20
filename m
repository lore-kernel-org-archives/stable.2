Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795161663;
	b=pBrFzRneQ9OX/NZm/Jq4IlPQQCLsFTlBFHkIjGup4LpWdmMdzXGopRfpaKLMTxMgLepj
	 xZ/vbK3+v2mu4m0vqz/Ple7YZIycdRCv69/CNXr/Haz9QeB3JOy56Lg4UCXLC128Lv5mY
	 n5PfyNVvcjGh1+Ox3Ah0D1gwtqRtX33brOUixLn1/ubWOfrcuKD23v4W4P6tkCk8q+OZl
	 o4dVJEu1NlWtv9BOXnbJHr9GURjLiy4/XdIbfv4aLIMCcn7eg3iXamgiJro0cIuwvf4xv
	 XTObe7NO18+jijftpjpMSjugFhqAkELem97LMOboOl3B7KNrP7IvdP14+U8g0Co9SOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161663;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yo3chyFVbhYzN1PoeZK3Aw3KLX9Q3rSA0mqbVuoEGWk=;
	b=ROSmNS4o2SR0xGvDYvqqkn3YG0O1HPptF9U4cYs10QCbL3IR+K6cs+l0HNN0ELOEJOpj
	 XtOm+ZuqxonbQID4vA1fh4jjzVvvXDgiQqyw3p40dTHHmiCy/3D4cLZlkht/ZmSE/e6t2
	 H5I2jcRD51koRfNsUKPRdXjg7ZmeiujurMZGOE5qcL0mCS7mD0c8T81HJS+RUZywZw3LF
	 Y4C0y9ihXSLoRv5YD2DQRz+m0pFchKK4OvB/+i6ACb76hOoUcsUqr0/IoccN63HtS2Amx
	 h9LB+vkQV98bDNHdB71jJ/7QMPz1BUFoDi5fu2B1sLtvGtz6ndGNtqaa+Fi0G/M42eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b="h/oBgG6+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE592606A325;
	Fri, 20 Nov 2026 08:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE592606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=h/oBgG6+
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7gYO4684672;
	Fri, 20 Nov 2026 08:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=yo3chyFVb
	hYzN1PoeZK3Aw3KLX9Q3rSA0mqbVuoEGWk=; b=h/oBgG6+e5eJqYKL4VlWSJaS4
	j0zTWUZ2MSMEP1/RFzpwhTYG5RNgkf6InacmyYTnk1TduXrpg8sDpyKKuL3dEwOP
	nf+apafEnR0KzluaYxHpt89XBYZskA1+TRQfQtCcvWkvoHeiLacxxpRm5vKz1Qw2
	ljscVpr0SV6Yk54sseY6vmqHToQuvVuZhAdfv84Zh9oYgyv6xSTjppcr3rXnudpa
	n4oT/YTLjubvdvYWlZUdjF8DxAmcPVq6eyoL2m8tU4G6uE1hsAsdkjjir1+lYzIk
	w+rWkUe6AtmxMA66GxTe4Urrupi6PlME0HzRJdNiJ88i6DsGy2RTRMNaWizRA==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022124.outbound.protection.outlook.com [52.101.48.124])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8c60-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:00:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6MGs51mKCZnHIiJ+np8xjU8YIEMjwpi+lfe2bmPrKD7Vf+B4O5W2Jln0+7fzLgzdQ3ENx6nEv5gsavoLYw3XdhMnY2oiBDpmOQLWeLeKx7f5yIBkFPoUNHm9iMbGafoZD2/+YKUOPURmu4hjohrj97t5/RC+s50kooAa02mXcPXMmiCKbBwDno45CdHa602wKK84FaL9+8wHCJMiqWb4Al5YYvY4YEiG3ANTfhEDUYbcktiBS4F/qeoJK/3i8O7MutNPGrhCFlUfBb9l5cRUHc4NV23+a+I0A+vOzJrndAQZWJDqkkUoQqTNj9XmpGJlaw4Y7GEDAcIzX8t28sMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo3chyFVbhYzN1PoeZK3Aw3KLX9Q3rSA0mqbVuoEGWk=;
 b=vV6og+5ijuIYFgHmXMy0kv7CbwgIGBTSWg1s69p2R+GJ6b4tQlJ6KYhCS6HDClW3c4RTF+u/FtxiYKQIcZ5zuMxtUjxQUgGUPl9hndczlTaTUoC8X8eEHzZoSW+TGu8DpgyoMN92Jd6rHA9fnXTmKXXT7STitXgGJTwcgKABhk53EBd61NU5npIC2oxJ7aFM4/mOiH6istUGaB1PPyeTvg45r7KbYjXwBaSr3RQ0I92hljQ1yHE+VdjYA7BKly6k87XSrxkzKKl9BF0c9F0ydorHgD6Pu9JnHTrsRvNS1jobnsKngdNaZAeev8NGjjSkNJzEhYvUoNRUd2+g23Cklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:00:48 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 08:00:47 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <djbw@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, Alex Williamson <alex@shazbot.org>,
        Ionut Nechita <ionut.nechita@windriver.com>, stable@vger.kernel.org
Subject: [PATCH] PCI: Don't block config access while waiting for device locks in bus reset
Date: Fri, 20 Nov 2026 10:00:31 +0200
Message-ID: <20261120080031.56565-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0039.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: d44a697b-b264-4895-4e89-08df46dc62df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|52116014|366016|1800799024|261022105027099003|10067099003|261022075727099003|11063799006|56012099006|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sS6IZ2gO797s3ffAW52dAXUoSTUlqIgu6wpxDEv+7ZCW5m3LxuIqQM1jZhuBPWP4qrWCGTgj0tqXDCFr5xWQnxSJC5kGUyGeRVA+zOqBfdHY+CM0y/pNzRk+ZAA/9KsNqx66zKhBnuE19jcOCN2kAnpXmITfq6sYJEUz5nrxe64LOien0+ZbVKNMAl1Ag6n5Ma6BQe8N8ejy6lbgYp+HUzDj0BfdFKDyVjy8R9WeEF8dii0/k8TvME5mk1tXLH52pEkegfqbaOphqn/fMivDVW7MpqQ8tFD04j8K+AI/oNr9FQVSZT95fiq1xHaVYoEYDwtzva0zdg/O3i7v27gNMfNv7Ne4mPxFlnC9UvYOKfPYjE8Tqk4qtqqXUt8LuIZ272QprbDx+2xSscj4RHFrez0y0x7uTV6UlD4fOEgey52MLhRFtgJg/W8RvNI8rIoAjclviPIKZrH0LVQ/HmGEVu7WoCsoQfI+b4u6Seunn5GJzOpC6zNNBoS7ZWF+GK+csZLsNHeC8LjVEl9dmjV21gZ2JkaibM/go18ENnVEJDtSy1Z8GOauSRqp0SSlnrZiJ9ktk5OYVFx0wRw/+Oox5FZ2XBtva3kIadk+pdz7oFgdMWFXW85GF42NygzQIYT9zLDXFxBcXDHZZ7mP9qnEpyam2cxLf7hw0JAOwNNM4MM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(52116014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?piu8sJPJ/UvVe96bHcwpEfpolBfbuHo1h0JcfCSu3ha/5OWG8ENWJWkw4hSq?=
 =?us-ascii?Q?d2WhbTLeC/VQo9QFzlkF4aEMcXM6ll/lxttV3VkpA/gWBQXhjGg2YJqh7+9G?=
 =?us-ascii?Q?4BPu5wllsmkmk1ILBTcDrtbXpkjPZfe/zCUzXBRGkmecSfVdPuTCbRzZbnBN?=
 =?us-ascii?Q?D802k03mRJfHy3tmphj0yA2i8CjFpxUF4puvpdijU4RbUOrojC9+jMogvk+n?=
 =?us-ascii?Q?kaz2EM9qoowtaKUjNX8z1Ntu8ecX3ALC66HBjZ3IMJIb3uFQbm3poURGwD3a?=
 =?us-ascii?Q?qJOG8UEK4ViiC/eFJKp0T9M4TbbFdS1xgUNzVNbhrSfluM6KXzbUdXGip9Ud?=
 =?us-ascii?Q?P5KaRy4y+DvxtmxX0B/gT6J7Z9sfnrpsL/NMnxi0fYuqMNJTOCmAkqFyuGTn?=
 =?us-ascii?Q?qCLiEcKs67nxpCbE9TBUfANPo99dYUd7g+we+i1jhYZWb36BoxZZ2mWp1aI4?=
 =?us-ascii?Q?5w9z7wV1qty5TBuk6Ti1blZVAOoXg7fV8QJzfPm3sQL5XWP5kyY8ZXBYxO2j?=
 =?us-ascii?Q?G5pjZtWVHCVj4Zbg/Zsoe5X5hSOdQE6ZqI1GVVlZF7yjUrDNyFgUysGnV6yt?=
 =?us-ascii?Q?TqZu7ebXuOcX18ZpChlKE9gut/q44eeYG9YRrFmFR0QrIlOUSrCZxHKiwFl0?=
 =?us-ascii?Q?qkbuLpQ7790B91neiKLgT0A5p2K8iv5WSoB2ceqfFMXnInFXjd1hH/MQfQEr?=
 =?us-ascii?Q?SFf316yGoVCWij24/9LZvahUMBwJxRhAlPa4ew3tkU2ayk8GrfOjSY68+qMG?=
 =?us-ascii?Q?3rUmcZQD5pjJd2vbY4XTvJxRUGua1nAZ5Xl/kzsjNCQg8qeMd3FV1GDHb0NC?=
 =?us-ascii?Q?7TrvLAnthOLO1MNrQXh9+BMgFnd9SAVBGnsV8PODlWN5DhFfHDdC43FThxkC?=
 =?us-ascii?Q?ouvzKbtApz15UI28KAxwg/XtWt9Si3rMWoGQiVmQd8dit+fPOFn4+PvSyocJ?=
 =?us-ascii?Q?Na7NXb8olwKEU1+miVPEphmjsjoXOhqxlysimQ29tvcv0deBLMA8rg+LNDuz?=
 =?us-ascii?Q?xGUXrQra6TBCgwy3akKzlqeb5XkLE3y0sQMZ/I2ToHGM3KA1FSvFV4013JuN?=
 =?us-ascii?Q?ULzwGr+GFfv2CmCXgI3uT2urjkG2SD62r/B/DWFx/9uvlB/i+zRHtJ2mB/LA?=
 =?us-ascii?Q?d6GdKSW+l00GafRpNoUBogzfG8SbHqc71DgxW7zLsr99Jm/wb9nySTGudSDe?=
 =?us-ascii?Q?C8aHtZuVWglJmyVvBsQ/AJI73YO0LHoal+Fb7uB+FLWHMyxH4zR07ue1UvCp?=
 =?us-ascii?Q?n7xAhOx2sYOkXABO+iSN8ljj94GmnFu2dAgPofsaAaq2UrlWbLoNUtTKB1ej?=
 =?us-ascii?Q?Xz79sUHjTZIw1ojw2jaW+5j7LOIpR3Ms1Gq6UM9kcK7Wg8spxOHnFbdGJl8o?=
 =?us-ascii?Q?UMqZia/wKCN8uIAL5h/8TharoX1pysaoQ4htiaueuPlRvJNbKqpv6DpTY0XJ?=
 =?us-ascii?Q?OdDSPk07av6CjZJO3scetFqUP3nKHbHkSNxtA0eIXAiqwz8FoGSgHp1fIigR?=
 =?us-ascii?Q?OdJguqevfmTCnIeftWVj1zremTJN0ZfYXcytypsG4QDCc2xUosB1vWEOIaYk?=
 =?us-ascii?Q?jPIIhFj1QC6VDjb3ojMbCDZ+RYo43Qt46tVO8RSkYkj8tHvcKfotCvwdVIEK?=
 =?us-ascii?Q?h6oc9G1UoWLtN33kb9Tk53Tlr3fgjhCNrChkPnJ0oVHbH8SHvLgKvKmkG25I?=
 =?us-ascii?Q?WH6La9TjpeDxKtpkvJvmbgqzpFhqPBVARHV1q4q+CEa5Pf+fD0gnjL5u9yjT?=
 =?us-ascii?Q?j/0wj5M5/l4cGwSaW2JtNsU4/aQPjBFS2KBf5k4EA9oDd5IXn1rQoQVNLNOa?=
X-MS-Exchange-AntiSpam-MessageData-1: h1SZVauuRpBnDKvxwSu3Qh1vN99k2s2rZIA=
X-Exchange-RoutingPolicyChecked:
	KlcJ/TRK4Fef+rxbSgXZWOz4ONSOnJZ6AcHQV1877+WZCY59Wk+6BWh1Y11ezY4c+fMaVwhKoB7pSrINqU/lYCLDRZcPgFnp6VdUVrfgsb/lsvojtHuWWqBiIOZBpYH0x+yJuMHutqzIr2r/7ns9E5/Z1tJMVlGs0bJfq9qQC1iAH7y9oIlRBoNIzUDnFsNg0aaYKRDiwPx6ge1D6OdJsNeBgfjZoJRAtKsoZvPA7kf2T2tFI4jwZkbqJz9GrOsf53MBHCH8GG6dDTehfcLzcJkVwjV59hUeB7YYGufwdZOOUhP8fieeaMl5LhutMlWzPL6hoo6JNOydvooU5nXX8g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a697b-b264-4895-4e89-08df46dc62df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:00:47.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1AOm7b0ZPoiS2PeRGRs/r2LyndYEXBS2995nOA6cXbNuhyH58p2VUHZ0OfctnA94wJ0aVr2pYODK9Gj3Lz2uwbCfffNHYp2oSZI2biWvoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
X-Proofpoint-GUID: YYVX7pan449rA_aItFq5T_TtxF5TWlzZ
X-Proofpoint-ORIG-GUID: YYVX7pan449rA_aItFq5T_TtxF5TWlzZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfX5oTsPgiuZDJF
 /pTKFpfaEV1CwY+tWAkW5Gj/UkmDJiadhUIGyTl0GyJ3k2tLY9P3LbUt6kaMkpr445ZyseKDkjE
 CquoZLzPd/kdd73X1p6WiMty+JZLwwvVX0CQO316Nq29Tlid5WSfzqzpj2XQKm2+rHMUbygEt3F
 1Yltby87MDXlOaZwlNZKBvUXLd8p+zH95ZmW2JGpPMnrel9l8gI5EgM/rRyq4DiY5fRyyteWuFA
 F08GL2Uuzs10EpLl3o/4iwSlGj8fUOrtfHkrKZ2Ivm6hgMwST+PyxivhPy+Otd0PXsOR66NtHDD
 m9cC7EopxPurE4bo3SegYi1mcukWLVq0bqWAnUFuekbdiFbReRysq1sogV28KvZNS23468jKN9D
 Pf8z/rwLAqW70wtlrZ+Oe1tyVV0lPAp2zbZn/tZUz0xo7mU33eTmzznqnWjD5hfBx1RTjNkK240
 i+G8WKAZ37RM1RAXU2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMSBTYWx0ZWRfX6mVDe0qGFx1Z
 pM1dayxtyQPJULNg8J10z9u0qhEFnBda4rw3Wcp4eNigvP3PTypErl93LXd9F79HqzektK5B/1A
 xEu1eXYm8Qdwb4xiiuq6VEY1TCSC2oUL0vqns9In5mRCuzuNxLmU
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afffe34 cx=c_pps
 a=XxbkB/xl5Oo2uV1ivtvLFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=3cG76KC3p2bVIlBHU9wA:9 a=O8hF6Hzn-FEA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200031

From: Ionut Nechita <ionut.nechita@windriver.com>

__pci_bus_lock(), used by bus and slot resets, locks the bridge and every
device below it with pci_dev_lock(), one device after the other.  Each
pci_dev_lock() takes the device lock and then blocks config access to the
device.  If another task holds the device lock of a device further down
the list, the reset sleeps with config access already blocked to the
bridge and to every device locked before it, and every user config read
of those devices sleeps in pci_wait_cfg() for as long.

This is the same problem as the one fixed for pci_reset_function(): a
driver unbind of a function held open by a vfio user waits in
vfio_unregister_group_dev() with the device lock held until the user
releases the device.  A bus or slot reset that reaches that device during
error recovery (pci_bus_error_reset()) keeps config access to the bridge
blocked meanwhile, and lspci hangs in D state.

Take all device locks first, from the top of the tree down as before, and
block config access to the bridge and the devices only once all of them
are held.  The order in which the device locks are taken is unchanged.

The trylock variant does not sleep on a device lock, and the unlock path
releases each device's config access and device lock together, as
before, so neither is changed.

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/pci.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d35741eb3..ffeeef045 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5432,28 +5432,63 @@ static bool pci_bus_resettable(struct pci_bus *bus)
 	return true;
 }
 
-static void pci_bus_lock(struct pci_bus *bus);
 static void pci_bus_unlock(struct pci_bus *bus);
 static int pci_bus_trylock(struct pci_bus *bus);
 
-/* Lock devices from the top of the tree down */
-static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
+/* Take the device locks from the top of the tree down */
+static void __pci_bus_device_lock(struct pci_bus *bus, struct pci_slot *slot)
+{
+	struct pci_dev *dev, *bridge = bus->self;
+
+	if (bridge)
+		device_lock(&bridge->dev);
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
+		if (dev->subordinate)
+			__pci_bus_device_lock(dev->subordinate, NULL);
+		else
+			device_lock(&dev->dev);
+	}
+}
+
+/* Block config access from the top of the tree down */
+static void __pci_bus_cfg_access_lock(struct pci_bus *bus,
+				      struct pci_slot *slot)
 {
 	struct pci_dev *dev, *bridge = bus->self;
 
 	if (bridge)
-		pci_dev_lock(bridge);
+		pci_cfg_access_lock(bridge);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (slot && (!dev->slot || dev->slot != slot))
 			continue;
 		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
+			__pci_bus_cfg_access_lock(dev->subordinate, NULL);
 		else
-			pci_dev_lock(dev);
+			pci_cfg_access_lock(dev);
 	}
 }
 
+/*
+ * Lock devices from the top of the tree down.
+ *
+ * Take all device locks before blocking config access to any device.
+ * device_lock() can sleep for as long as another task holds it, e.g. a
+ * driver unbind waiting for a vfio user to release the device.  If config
+ * access to the bridge and the devices locked so far were already blocked
+ * at that point, every config read of them (lspci, sysfs "config") would
+ * sleep in pci_wait_cfg() for the same time.  The order in which the
+ * device locks are taken is unchanged.
+ */
+static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
+{
+	__pci_bus_device_lock(bus, slot);
+	__pci_bus_cfg_access_lock(bus, slot);
+}
+
 /* Unlock devices from the bottom of the tree up */
 static void __pci_bus_unlock(struct pci_bus *bus, struct pci_slot *slot)
 {
-- 
2.56.0

