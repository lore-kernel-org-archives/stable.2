Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816410;
	b=ce5x1ot5wtGDfw2e1L8PYx7beZ4i4JhHBcQODgX4OTWBFRBId0OEE0kw1VVpQF0uKtf7
	 mflVk3dH14bZxQZ3KuOXPLfU843xLTDttCeYkx3w2P1EqrHg3zRSiRShcABajXQNhame1
	 WJ3Xzp+l/7uQ+1zr6TV+ciNKAv3rkZKK+eIYp3Uj+OKXsqaPEFZLf+LuLnnW/QY6wj7lM
	 VVDTCxFxE0Skn3sAt/A5aOzbl1y+ErtaoKD/ZrzzCfOKQPQOLostgmVRBn0s9JAqL4Ksj
	 OXLTE7OclMU3vqzHn23075XQGEzkmDjOUUa707PIb4aEo0Fj9o/DXYw+8cb5Ak9jW/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816410;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pld8MUtfE9x7fKuBO7ByUdxnI+IzRdEiddoWCInoXqc=;
	b=IGOnE4rJfApHibf1nIbnWY5yHADa0OsE+oGnBBHhnhzOvhuqfpRk82AnueMbeyOPdIao
	 j6Md6laRKigpomYfCS0W087ajxd5Ur5Ive4d3xFBhyqUZ2zV2dlxZtS4xeV4Up8zeHQ22
	 VlE2fll0MB3xCGr97rsoytgAZcEl9gOsmp+zIG5IscVIrS6Ag3rZCyv+MgIzxwD7VGYoA
	 LqZ3U449efF+ywKvAfu57YgSgBGrKgVA1ITmN/VxISvLDL3gydvMm6dm8nQMn18yR4/Yg
	 IHrLvXIU4/fMc/IWSXZD+20kE8DX2GUM/rHIwNdhSWFeITD5hHj3kskA9nuKWLtslDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=tpc+Im8J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.89
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023089.outbound.protection.outlook.com [40.107.162.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF9606A337;
	Mon, 16 Nov 2026 08:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EF9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=tpc+Im8J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouVjeGSFyzJN2f1TVI6id7sbBc5H8Rg6faHaNet1nsjxTwCGdYip1gFkREa76f9wttNAl9rI79h2ojOiqGNwkw1uLppAPnGsyoGSBwcN8Bmbr1vK5PkMT7D2oB/GoXxFeP1eFKUo0kqMQq5rlrCG+yVzkMOkOAr39lhJparzYOb20qNBt3YWEBE7519Z5aiiU6TlRjbv46P63cK0URwncGeKQEASyYa0qduzlJEjRRbUbQBfpj0PaF8/yUGcN2VCcyDmV109k1AsfV1QPJLYBohVWTuc8Y/EtwRv6o5ILoMXixf6RFoi8zysViGgJ/alb02DGo20jHg+UL1/0dWVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pld8MUtfE9x7fKuBO7ByUdxnI+IzRdEiddoWCInoXqc=;
 b=S7r1nIs8zyGFpjy2RDmBzTaiQSjxLRRX58E5t86or+tNP3iO4F4P1FHSNmEsEgzWoAHGHGBml+pJFA99R5v8w3dahj69QcMdGaAqkmnge380mCVRJbBYjKvXiMQoXcVdHY87ZEmvdd0Qq2kcCzf8kRFhUHmzsde2D+3TdwivlzcGRXdHirKVbekNWPruEsAmr+IXOyrQ1OuuWtjBC3DFOkVUHVjGmZorNbk7hOVEbxR09HYCmVXHLI1LBgIfNfqroZcSJQBtB9OLfbswE+xf84mY6jgRx6n+z8leSexWIKAzf7AKFjrL34l+XhDNcn0o8mbLPq34ylNF5LBASiENYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pld8MUtfE9x7fKuBO7ByUdxnI+IzRdEiddoWCInoXqc=;
 b=tpc+Im8JcAzfcjxwuz2k7mWw/ed1WROWmOS8/DPoeAwWF8cbEKn9aiqYoNYpLYS2UG/yNcNUMm54K+3I5gqYhgb3OvxuWZNXwr48HFTyv7w2Z0uAQdjIDaGPWQoB2wLYq/MK/brLUkwXXaVe5sDntUp07usira8ZnihbmJ5DCgK0BW4UuVE1/fVu8kFk2sHeuV6sFsmUu3nOxDDSe5SyZjsColZssbjfNI46TTTiwhpPWwnsPVermr/z3/VITzt46M9yG0jnZONeVCIellwwCkB2lNrGDWQgsIZ2L+7itgZx8srWIws+ojZytqBco+PWDXE7DWKbp1uXLMh4Vu312Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by GV2PR06MB10207.eurprd06.prod.outlook.com (2603:10a6:150:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:06:38 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:06:38 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v3 0/2] serial: core: two fixes for the port removal path
Date: Mon, 16 Nov 2026 08:06:27 +0000
Message-Id: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIO5+moC/33NywrCMBCF4VcpWTuSSy/oyvcQF9PJ1AZbI4kEp
 fTdTQuCbrr8D8M3k4gcHEdxLCYROLno/D2H2RWCerxfGZzNLbTUtVLSwHKPA5APDIFHnxgsox0
 83UAaJduWsKqqUmThEbhzr1U/X3L3Lj59eK/PklrWr1tuukmBhBqNrA4NWmq7U0IXccA9+VEsc
 tI/mtLbms6aNcwlEZNp8F+b5/kDWhr1GxYBAAA=
X-Change-ID: 20261103-serial-core-remove-deadlock-0310bbca5554
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794816397; l=3043;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=/SvatwvEimnHNxz6C+7YLwm9dzK0/1o8tCZBo0NFAtg=;
 b=X1Vzf3FKerTT8z7A9DUbuXhKP1gIRb3k0OEFO/iorSMaRRchNAeikkHzdi/zDto3DnecnLZyn
 lTcolsy3xoNDXvwzre+jgj47inR7lSVq/tLdp7Cv5QVtw3f42EKFhOs
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0145.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::19) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|GV2PR06MB10207:EE_
X-MS-Office365-Filtering-Correlation-Id: ae944ba0-8996-4401-766a-08df43b88a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|11063799006|5023799004|56012099006|261021123027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|261009221227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A2ZD1Rfu5HBVeB0Fw9ARDJSdc4lsfUgaludoGsXedf00X6xFUnZhgaiprrm6zy4AiL4yzeeh3roZqjuWjCr0XqwccL3uWwuM+WdppSsR0SbaCizC3E2Xyp0AzQ3XcHUkYE0CPV7HuE16/sFw5PkSbk1UM5GMxCAShQpzMs3kzM2zFtaPcq5ualS1/e2P4uortFP/666OzvFm7kcS+SLAQFsTazOCSDMUj43M/IJjXgRBZnJ2WkHVPiFeBG8L8N0dOzV0UKoGkND521xcWJojOsCzJEvBFxPyXujTTJhsDiABM2NUDhxVjBzHbGnbMt53dZaECRClqI3DE3Mxk3yhmrIf1vGDSpAhUFWjA74qV0sos7CcT31xQuYbF6p0gC3UxhNbPir+ZcxeTZsnHNgudKgjGR3AeE9vYv6BLhTAf+KCLoT5EgbMKFTribEkvloNIdwr+tGA+pbbdClOz3WQ+Dn4fhmrAOc2yw4BXvksgVs2n8OsDxZ/6F9YRT8xVpv6uODpJPZ7z7+IPdDtO6oZpSR3VvL8E7cmJPtRpB1GruN++TjJAqoFObrn0bXOcYmuw3cgnbY/9oD34UtVVQqt2S8LVESbLwBmzsEIEW8FjQk49ji8AGMSBBpsmQEZtj/H8PUvdvMQdrL4GUmQ8/E9G9nG/72mRIY0tKhxQ9CmWLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZOWXZmRXB3TkIrMFQvODJHUTg1Yis2b0REZHNzOEZ3S2ZEL1B5OHltWm1p?=
 =?utf-8?B?UDl1bGs2ekhmVzJHdjBZdHN6L2o0S1RzMWcvVkpRY1FuQXRzVG52MFFQWWU0?=
 =?utf-8?B?L1ZrNWV4R3YzS0hDako0dUZVN1BYVmJ3WW9rWm4vaXoxa0Q4Y1A2eGhib2ZC?=
 =?utf-8?B?K2NMNkVteEJLZDkyZHJ3cGtFN0dOSGF5enpBalUya3A0ZnlWY1JxWDNVTkZM?=
 =?utf-8?B?RVJ4WERqNExHM0ZtUVRhRy9xUWxxbnkzaENMcDBMQ3diSXhTdFlKNVJmSFAz?=
 =?utf-8?B?cUVHNWtlWHI0TTIwNk5nOEhxU3Rna3pOQlRRR0pyamlwWEMvRldMZEcxaGM1?=
 =?utf-8?B?MmFKT3FTQzZUSTZ3ZnBtdE9iZXRaNnJNTGVITTJFSFBpRyt0a3RYNVFHNC9r?=
 =?utf-8?B?YlBDZjJVN25GT3pJaFNYTzArR1ZoQmpWcjZsaVVITXNrQTRGcHNtOGtGQkVL?=
 =?utf-8?B?d1ZBbW11ZW0waDcySm5scm9CdjhLQXpQR1crVTFhSVdlZmlhaFJZME5lZ1Uw?=
 =?utf-8?B?RHFhcXYyaStQeDRoMVU1aVFzODR4eVZSYUxXUDhmSy92eTNHQTdYREdBL2d0?=
 =?utf-8?B?VjFaQlBudEYrT0ZpSGNaRFVmbzNWTTF3Yng2ZzR1VUZ6a09sMTV3QkduOEMy?=
 =?utf-8?B?NndCb05QYkxPRWhoNlM0UzkzSVJObEVRREw5eHBCbk1tdGtqRUF6WXU1cnZZ?=
 =?utf-8?B?MGZSM25vVzFPRDZSQjZ6UUY4a3U4cFBtWVpnZkdoZE1lRzR0UE1JeDJEMmhZ?=
 =?utf-8?B?YVlEdlBHa2VYdEdWYmhzNnpvYm1KcWJlb2V5VWhocy82OE9oMjVDdlI3QjJt?=
 =?utf-8?B?T2dKS0E3ajhRRTJKcTJZRDFpNEt3cU9QK0owUTZMMk1WUmpwZlMzOCthQlE5?=
 =?utf-8?B?Nnp0K3hCY0tsQklyS09lYkZTaGw3NHE5UjVjMDZTaVV3VnpIcUdFNWpyWWN4?=
 =?utf-8?B?U1RrYVJURFdrQytDZGx2bDJwWUgrN2EwNWlFKzU3ZXFUUWx2b3NpU2k5dlpn?=
 =?utf-8?B?bmJyOW1Ma3BkMWlVSWhYZkpKdzVuNWxHQnNSdlF0SDc5K2RZU3lVUjBxRWQ2?=
 =?utf-8?B?aDVPS05GdTNOVURieTVtS1B6T2ZqTTQ4OG9Ya2JnaE56VXFVVVVlMlpkdGkx?=
 =?utf-8?B?dFRVSGx5RmJTZVovY29GZDNFRDdPK1QrR1U5U2dBVEhmRWU4SkdWNXkwekZE?=
 =?utf-8?B?VE1XU1loaTNST3hJRmpnVmo4clRBOER5dmx4YlBUUjVjSmo5MXZndUJWbWxX?=
 =?utf-8?B?MXVVdG9jNVNaVUJLNkRhMXVvS1RUQ2VhN0ROUDZPbFlxd0J5Uk5YSWlmNG1V?=
 =?utf-8?B?T1dNUFE4anAzWGZhTVVZMVd5eWhzTVhLWnNheitjRjFVVHRZZlY1cFkrQ0VJ?=
 =?utf-8?B?UFhsYS9tWE5VV0lWdUFlUHdpOG41TkZLZEtDbjgzcm85aERYczEvS2VhWkRK?=
 =?utf-8?B?ZEw3d0NmNzFrWXYvWWhvQWczenRTSGRDSG5wYzRaM25oS2Q4SEU0RWlhQkxJ?=
 =?utf-8?B?M3FMdUtLNDFYRVVzaDY4UEhBVE9wTE1TSjJvdUlDWE1hQ0E5ZEMyZE1HS3d6?=
 =?utf-8?B?VHQxVlFFRGNTWEpHZ2dZS3orbC8rVGxJTVpDUDZzcE1BYzM3UUt1ZVJCUFk4?=
 =?utf-8?B?UkowQ25BWVFwNTlJbm9aaHEzSWtUL0xrVFNyUTFheDZJR3dTdGo4cGlQVFRE?=
 =?utf-8?B?a2d4T0NValptTHFzZVFrK1p3c0JXRGk1OEN3UHh2b2JuNVpGOTlORlVvYkMr?=
 =?utf-8?B?cFRFWGRyemZ1ZUJkNjF3aFJKWExYTHJXcktqOUgzMlVlakdLc1dQVWNxYjdW?=
 =?utf-8?B?QmtLT0JJWmp3Z2xlVmlnU3lVc0FTdzUzbVVZSjRDT3l6aG40cmJja3FUNFd5?=
 =?utf-8?B?OEZDVys2MU1RUnhHbFhWdUV1YXlIbFpxYXoxMWJBU2YrcWtkMmlFVTBNSnBD?=
 =?utf-8?B?c2FqYXVNcXNMQ21abDhGbEZFbGFCSkIwd3JJTVoxS0sxdGRaMTFJa3lVbW4x?=
 =?utf-8?B?YU9wQXhVTW1PS0d2RkhnYmNkN3hLSmhEd3VNSE1HTkpXSlNmZ2lSZHN4cUJs?=
 =?utf-8?B?SnJxQ3Y4YVo2Y2tBRy9KeDVUNkY0MEdkamNJSGF1cjB3aVltbENad1B1WFJM?=
 =?utf-8?B?N29XeE1jV3E5ZmFlME1oaXd6dUR5VUlySU5HUnNiZnRDS3BEbWNFV2lHaGo4?=
 =?utf-8?B?eUVETjIrVVBWYmYraXdoVHM0ZHhQcXlKdWxKajZsa2xIUnNUdDIvNG0xZXJW?=
 =?utf-8?B?YUp2VnNlSDR4QUJ6aENMektiUzFDRmVNSlFySmRTc3NqSEd1a2hXbHNYNDAr?=
 =?utf-8?B?MDRFWEJjZThmQTg0QWxEV0h1MEpoZ0UyRXBncmhmS2xQanJJQVhlS21vd0hV?=
 =?utf-8?Q?eDce/9KHnDKWFtjo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae944ba0-8996-4401-766a-08df43b88a44
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:06:38.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC07sCEMtSrol15KctCaCSD7ciWRJBbFdKgHf27nGWJiBAhlIjLVymai+PhkEDVuBsyX8mqSF9uk7uJQZhE0D9mxdcuBu5/g0Hew8Cp6Kdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10207

Two fixes in serial_core_remove_one_port() and its reference counting.

Patch 1 fixes a deadlock between port removal and a tcdrain() in
flight, present since 8ca59f7baee7 ("serial: fix ioctl hangup race").
Patch 2 fixes a read of the port after its last reference was dropped,
found by review of the same path and not reproduced.

Reproduced on a MAX14830 (max310x) board, on v7.4-rc1 plus the board
support, by unbinding the driver while four processes drained a few
kilobytes each at 300 baud: the first unbind never returned, and the
hung-task detector reported the unbind in wait_event() and a drain in
mutex_lock(), with the drain "blocked on a mutex likely owned by" the
unbind; a power cycle was needed. With the two patches the same test
completed 46 of 46 unbinds with blocked tcdrain() waiters, each unbind
taking 2 to 3.5 s, the time for the drains to be hung up. A two-hour
soak with lockdep and kmemleak enabled, 1472 unbind and rebind cycles
every 3 s while other ports of the same driver carried full traffic,
completed with nothing reported. The change is independent of the
driver: it only moves the wait for the reference holders out from under
the mutex those holders need.

Tool use: Claude Code (Anthropic) was used throughout. It analysed the
hung-task reports and the /proc stacks from the stress bench, located
the lock order between serial_core_remove_one_port() and
uart_wait_until_sent(), drafted this change and the commit message, and
wrote and drove the test harness that reproduced the deadlock and
verified the fix. I reviewed the locking argument against the code,
decided the shape of the change, ran the hardware tests and read every
result. The code and the message are mine to defend.

8ca59f7baee7 is in v7.3 and is tagged for stable back to 2.6.26, so
patch 1 has to follow it into every tree that takes it. I will send
backports for the stable trees where the patches do not apply.

---
Changes in v3:
- Patch 2: read the state pointer with READ_ONCE(), so that the
  compiler cannot load it again after the decrement (Johan).
- Patch 1 is unchanged.
- Link to v2: https://lore.kernel.org/r/20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com

Changes in v2:
- Patch 1: dropped the paragraph on stable backports and the comment on
  the Cc: stable line (Johan).
- Added Johan's Reviewed-by on both patches and Tested-by on patch 1.
- No code changes.
- Link to v1: https://lore.kernel.org/r/20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com

---
Tapio Reijonen (2):
      serial: core: do not hold the port mutex while waiting for references
      serial: core: do not touch the port after dropping the last reference

 drivers/tty/serial/serial_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-serial-core-remove-deadlock-0310bbca5554

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

