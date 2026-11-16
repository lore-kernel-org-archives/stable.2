Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794815395;
	b=4o9B3itpAqj4N1YPUTS28miEmN/RcncdoLhPz31xPOww0P0lFaBg3MFHxGspoclvmzkt
	 94IinK/kwrvaaq7+swa8XCDvqJpshtcSAztdwXSw3ok1f5zOPI1q6aWJDhhZHXoXx+dX2
	 W4OagMejM3u+lhU5XQo+iTvlO0vKDNS10QJMMI4RB0tTc5lwnbuwOW9xvkEdV7alvRvle
	 w+uwgV7u3wHNZ1tIvF4ym5kZhmq7H1Mal+W1F2NBJXIeHQ6UYWEBbPaF4ibD6j32ibi3M
	 mDaqr+oqF1KQvTs9iNCcPH5H4XqeQ4gnjoG1eA/fGawPUbwAHRP5QbzEbSQs6Fa1wJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815395;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ptb79H7NnHqDgXgBzBkoGDfz7LVGTssqEFe27NfLkIM=;
	b=KjyE3PVANO4Q2K9fqln+4bvs1eTb6XPM3lB3fMylJkq99dTsw8GzJWLZ67jbp70fF+JP
	 7LSHwltTPaNI9yxN67JLyLljAjOcNQnPQUN0MhoN5cBZwAnPI+DjBNBplSKPhMcR4a/Dm
	 JP4hQEpYBtagpBjLxpj/sOiXrZI90oLZmuO4ofJOj8GyD6cJWzbZftrWCLREcSnDphNeM
	 HfwtBIKTFJ5Z1R5uH8fdQxT7XZkrk+MRkkUylR87ba61hGFC45EFVoAQQIkDZX5Slz8LO
	 Bh42rutnExp3tx6KJyOuOgHUhU9PyGJhvDj7LOY8HZFB4PeA8G1nZbYUHfYJl/j3QDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=qAW8Zb9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.85
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020085.outbound.protection.outlook.com [52.101.84.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008C606A329;
	Mon, 16 Nov 2026 07:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C008C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=qAW8Zb9e
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKLX/rsOh6ES8xvp/RIMECZNrb9t8gkS27bpvKvuG3EETMBziLi6WfYPs4swXzz094dHpBbOE3pQJENSR3lV5lMAUZo6/iBI5zBUFSe6vmyRW7SHPx/kUqWWOumh5WfpUihBiK3JHMKGC9rmukD+DDVyGUdpZ1++M/+OebCEP7f/SOXua6nQPrkzC8NYo7VMr59e3Ms5lB+HRK9xHeqbVhk8ESotX7q8253Q+EqqFberfZOQXjcE6Np+zBLJDlfu/30KvPqemBqE/lY/vxYAYoUY5Bs8JM8DFvyWz0wKcuFgRLX5RH2Hl+u637gWAagwi+ryWuTvncUmLlzjyCZ5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptb79H7NnHqDgXgBzBkoGDfz7LVGTssqEFe27NfLkIM=;
 b=a1YTqaZC4Foafh4wpgloTq2w6KNO2CUFqlNNdlPUWshW43UcSZUwMdcqGRb+cVtQyN7GUYR5uP7FF4Huvlsxbzrv5szbtd7DIL4yA/1JQqz7pKHH6XtMt1ewQy79EMJ8FlOk1CBrmIyWZ2v863g8L66BROiD3TJ1MeoFb/Jla4CjXalMs6dM3AUsJTrg2BZQQMWgAMkunaeUTI5yAxJNejNkCq6nMrTYIhpMN5zN3q8HGR4aEeLr4JGLyGkeYAyieu8IINbRcvDMCCSMH6ZuUa1hPrUcXDNL8B5eW4CE+utR9tqfhSLT8O5AWS3IH2s23JrQTaNYP4zFj18WyF11oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptb79H7NnHqDgXgBzBkoGDfz7LVGTssqEFe27NfLkIM=;
 b=qAW8Zb9eTdsj40xsVUQE6V/Jk9qxOMerwchj6B3fkjoNN/R+8q+ZGLeZdEs4N6CnUsAEKVNuJH0xzylTR71FUv+8Dx63isslbQW2r7gR34CM+cOetK6BBhJEbLt4vXH2Ix4OpK+Pb/wllX0DU9AfRdnqw3JrEYAtut3wt9h5deFOVFT/+TC67+f08WB1DcRX/2SHEzUHe9Gpa6UfDzqZyw4WVxjeJFCKhQ4aDXk4dJYDmS+LRGPn3GdUYjLXi3ZQrqZUHiohb2FyoSUzmxknDPhavB0ztsn4EXJKHQ2WQ1hDBwLB37B1TRGSX3MHB9tOED+N2JZM2uwT8RrV7wnqzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by MI7PR06MB334843.eurprd06.prod.outlook.com (2603:10a6:290:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 07:49:47 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 07:49:47 +0000
Message-ID: <4038c504-0f04-49a5-a9ef-2dd881b7d653@vaisala.com>
Date: Mon, 16 Nov 2026 09:49:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] serial: core: do not touch the port after dropping
 the last reference
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
 <20261112-serial-core-remove-deadlock-v2-2-d3ee4ccec37a@vaisala.com>
 <avXOArIk9Cep-rCI@hovoldconsulting.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <avXOArIk9Cep-rCI@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0149.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::6) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|MI7PR06MB334843:EE_
X-MS-Office365-Filtering-Correlation-Id: adab8142-10b2-470e-3c80-08df43b62fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|5023799004|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BQaA513Pt8Kcq9RfmjDFVTXZQsksRR+xN+3IG22xD7wOfnlpCNMM7cNM4WRd1TCjBkf6P1WGWSp4cayYeYhkN5q8JgrzeBHXyvomiVFRu0xlcBPvk5xJ3hrG+xjlhovrMj9gUjvEemsxqn0ndj9MLCi5fQZMPOMhTT5kHnzIT8DCQSBkBCZQobsEOVmFWL/PES6H0fplmBzjfmQ4ANkNl6CS+kWSmHFWGaj31lhqT1jUZN0XwZoVti48bp5fxQ246QYXCmrsL3AbrbU+HTCdrE1vR9UZ36Rl1ONJbiqZ72ceApSp6sZ/BhmZ+qKlDaoAB7mvI2a/lXbBkox5ntNZvgKWJ30sdQcezQw27MXSGt18c0RPgK/Bre1KqS198aeORKZWjPkY1XBTduHQYCT923tapHfTC+9uai18EaY7Y9rfOMnnar4qlMwJrxBFsorF1pjOXwzgBcQWGpzDm0pu8ql1e7mSYC9OleUkD5hvhbxGnDpLEhTZmr/+3rTEtuGzRb4bBR6on2oTEvgqeoSwmIyU7qXSzfoEYXRp9l00RIRfT75DHrU+7+ImRdI8Cy65tXp6HpE5q5qvmWL2nXN0kdQHhD9l09Xeqwajind8b2S90CJbl70MB7m0zjWQVhIFWhv3jrEh9dexvRqx7if3HdqtFrf0ubiHikAL4F7157g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzMrak5meHRHM0p6Q3J5R1d6OGFFQ1FpM0JZdTFINkV3bXE3SzVxSG9vdEh5?=
 =?utf-8?B?ZnROUFhPZEtmVWp6UFFxMlF4ZUowZGxZdDBmRzhjTVZVZFhEL2V3cmlyNTAx?=
 =?utf-8?B?Q1JucWQ0aldrZTBHMklBZUY3cENDR2pqbkkwSjQ2c1NManZCMkRMd25BTVVy?=
 =?utf-8?B?VzJUV29EeUlqVWVNYnFERC9hWVJWSElDK0RzUUdYWDhzd0FxTVB1blIyWHBR?=
 =?utf-8?B?VEhiL1pmVHdKMjg5M2Ruby90MWdYZ215TEFET2lWd3A1eTlWdFNVemFkSTda?=
 =?utf-8?B?bW1JQ0ZrQVZQT21kSmtGcE9YcE9zSWxMMks3NFZ3YXNnQjc4UzE4NEhJRVhx?=
 =?utf-8?B?b01LVFZhQk9BZFc5Z2hZdncrUUlHeVhOL3ozRVZTdFRPdk5QTTFoZ1Z3UUxo?=
 =?utf-8?B?QzBrSnlqbGo4N2VOWHFSK1R0L0VCUHZzY0JjWStEOW1xazJLQnlkRCttQ2Rr?=
 =?utf-8?B?UjJ1NTlKZDVIMW9hNEZkOExoaC9KczVNVTA2bFhDMDE1VmFRbFY5enNnRllK?=
 =?utf-8?B?M3BjWUZRRC9PUnRkcHd5cnhpakV3aWYwRVZwcVkzT3RaTlJnWk9MN2tVS1hq?=
 =?utf-8?B?a0xDK1NFK0I1MnRmVUJkYXg5UE91b3c5WWppQ2RPQU5Kd3d1N1l0S0tGeCtV?=
 =?utf-8?B?cHJGTUdnL2xIa05vM3ZjcGU4S2dVWVBKTXBXOXl0cU50aEM5NWJhcDgzdGtv?=
 =?utf-8?B?bkpjelB5Vkk0UzBmMkJ2ZFVya3hDZzFmMW4vUGRvTVY3S2tIRkZ2L0NDUXcr?=
 =?utf-8?B?YUlldDNxRjN3ZFFGUHdVMGVhVlJHVVZENEovOGIwK1lUeXV5WktlMXRVVXJF?=
 =?utf-8?B?RXVLRlpjdHM2KzluZ3RHcTNFdnFFNGsrTm5VNUpnakN3TkladDJPc3Bicmhk?=
 =?utf-8?B?SUV2eFlUaHdqQzZpN1NJMjYvYXA1RmV6SnhkODFCUHZ3SHcvREl1aG91N2Ev?=
 =?utf-8?B?bmVncU95YVlwMjdsSzBxWjFIOExqeXdRbWNGaUdVZ0dkSjU5eUhTZkJuZFha?=
 =?utf-8?B?VWwzM2tVS3ZhMVVDcVBkb3hJM05hcE5kVTdLbUp2dU9TaWVjQnlWY3g1ZzVG?=
 =?utf-8?B?UDVkYnpmRTRIYkdscmRLV3cyY0VBYndVSDl1dXdaOVBTT0h1N0Q2RFVOeXI4?=
 =?utf-8?B?bnJPMnFodEk0QlBLd0lxWHVGOWdDbzNIVk9YVi9aOGZma0NsKytYdkZRd21R?=
 =?utf-8?B?Tm14ZlpZRzdhK2RsMCtTcjFUaDFRK3NUOXdQajlHR0ZEMGUxZVJpR2hlWnZv?=
 =?utf-8?B?RGpDMlVrUGVpSlU0V0toUUdsV2g1ejc2RkErSExTYkYrUklPTC94MWYyTjJ6?=
 =?utf-8?B?Uk5JRjF4MlhHWU9WNElxNW5qeXNLVzJiK0s1WDY4STZWano2dzZDYTV4aWJI?=
 =?utf-8?B?TW9zWUpOZXBvaituTWNHTVVKRG13QzFDQ0NxVUhDaEZvd2hkckk0UC9CUHhp?=
 =?utf-8?B?NVE1L3JvTkZVZ2VvV25ndVZRdXFhdWlIVW9mWWQ4WXN3RjB0cUdYdGphSTA3?=
 =?utf-8?B?Ym9hRlUvdDBzRzVzVnorb2dkZlhlb2Q1KzRudnJVMmdsZ01weS9WRkFqeTcx?=
 =?utf-8?B?dVpCc0xOR3JESHhlSDNRY1hUcS9sVnQxVlBvYjNFM2NoSWhndkRBUVpDeEdn?=
 =?utf-8?B?cTBWcnlDNWh6UlFER241WUd3bk5Tb2dUZm84YmhiUUF3Vk1ueVdxcWY0VUxB?=
 =?utf-8?B?akVOVWNMaFNaeWt0NThJek1UNXhPTDU3UUlJRU8vYVdpOUhLOS9YaVI4Mmll?=
 =?utf-8?B?STN4eTBPK2YyNG5td1N3aTMzL3g3TEplTHZWTHJFRHpmczltWTlKVGU3eFJG?=
 =?utf-8?B?OG5lTmZnRjBsTUloeW1NNWZpS3hrSk5aSEJBYTFNTjVMdGJDVnowYi91VFQr?=
 =?utf-8?B?ei9hcVdlN2wzVXVxNDlNeEhZSGhIL01Zd2U4SWNvUEtVcVRzME9hVXNwbFlv?=
 =?utf-8?B?bmtMcGg5ZWpJeldPWHAyU1JVTHFsYTZXNXh2Y202U1hPT3Q4QW1DQ0FOMUta?=
 =?utf-8?B?b1V0NjRwRDlUVk1mRzIrOTIyK05yN3lsVmFHbVpibnJOajczQ1JIOXQ1dW9h?=
 =?utf-8?B?SW9IelNRd1JTZ3VvY1lSWTJpaWJBR1V1ZkFOSlNXMEs3UHZGcW10Y1lLZGFQ?=
 =?utf-8?B?SnJyaVZscCtXMUcyKzBhbzE5aUk4NFpvblhyUkxPY1RkK0pYKzVyUEh6TjdV?=
 =?utf-8?B?Q3hmelNQVmdndStVYUVTaHRGQ2pxWlBtdDFKSnFjbEhpK2h0eGRhUFNrUnl2?=
 =?utf-8?B?c25VS0hWTnZKYXQ3VFJJVkY5d2JRTGJaYTMycTRYWVF2M0JPVjV4MnJyZlM3?=
 =?utf-8?B?ODREODRBdU5hSkNqaU5ZYmd1NE9hdGMxUGRRS1orakZjb3U5MmhPenNBSDl4?=
 =?utf-8?Q?TWNJJRYZeEcLsDQg=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adab8142-10b2-470e-3c80-08df43b62fb0
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 07:49:47.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uN1h2TJQDRF77K/LJYkR6cg3MdRszpE1QgHD3tfmsjx5DxV75KwT9y+J1E3xCYIPu2yCOu0qL0RDJerViYweiSUc6sRG9tOV5n+Qi8HZA6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR06MB334843

On Thu, Nov 12, 2026 at 03:32:34PM +0100, Johan Hovold wrote:
> On Thu, Nov 12, 2026 at 04:37:28AM +0000, Tapio Reijonen wrote:
> >  static inline void uart_port_deref(struct uart_port *uport)
> >  {
> > -	if (atomic_dec_and_test(&uport->state->refcount))
> > -		wake_up(&uport->state->remove_wait);
> > +	struct uart_state *state = uport->state;
>
> Hmm. Don't we also need a READ_ONCE() here to prevent the compiler
> from doing something silly?

Yes. Nothing writes uport->state once the port has been added, so I
wrote it as a plain load. But the point of the patch is that the load
must not happen after the decrement, and only READ_ONCE() rules out a
reload there. I'll send a v3 with

	struct uart_state *state = READ_ONCE(uport->state);

and keep your Reviewed-by unless you object.

Tapio
