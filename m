Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792535632;
	b=ehHiSupH/086Vb8dF24Gl1ilpriC79cXA9TEC9T0b58uHC2LyUN3nYm7b3lmTXzht43/
	 8p4uxoBDtXcPpTBYpP0C8jQ3KTbwh099BWWdLKowKsr9NUWw2ZyHsJWwYb6fFsVeqJgwS
	 B5IMKeXQpOGbgKBD6vlzmuJ/YERXvfrHXJWwweMAjQ4gwTne0jzZwKFN7/XjWItLSgoXP
	 AoekLCnZcI3USQYnvwQ7V+3UD8iYfo20dVzI25Y3s90sGZ1yDwtGWHzJxtVNuDraITc7U
	 SQbm/+4CuSn5ONPqUwXLqZPjoqQ8lPNlEgwg6++4HqQDJjMsQ6kg4Zi/V1Ng0RkHsNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535632;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BlQYdDCgFztQYGy+CQ0Alx7Ye2xhzuka8lvfPbfMkfo=;
	b=NZIve6VWTay15J8/cRnJIopdBPIzKphy62CnJWMoZkkIGwHcprZTkCrpwtpAf//r7t2L
	 eO/AR+PzuwdavADld637ecBK29Ms7+P8i2fAhkgbxPayxWXFr2JcMj1O5KY4M4gqRGPcd
	 Q6rclOyXB7YvrFt1HF5UQxQhnGqrjvHBwyKY8IbfKQBGsWVsnJ3ouZAyvNW2QayoXacza
	 DsV9cHqUboegKgSkofiH0UBbh7WzWW11ncYuruu7LJXs34NEsrPeSSpNoviJE+0G+c/u3
	 uyJK/SxNmdBAJ6wa3MfxxsSHder90Tsh3tr6CDzZWVhim5dqI/X/cp5Lg8Vw597syuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.co.uk;
	spf=pass smtp.mailfrom=hotmail.co.uk;
	dkim=pass header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=iZ22OjXG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.80
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013080.outbound.protection.outlook.com [52.103.33.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C2F606A319;
	Tue, 20 Oct 2026 22:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C2F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.a=rsa-sha256 header.s=selector1 header.b=iZ22OjXG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/NLkMkQFuNQx8a6vCoTAcmi4DNDqTQaLV+tqinA7UP1uFKuHReb1SY7EfX7Syh63mbFT5FQdEahq5e9rNODuK8uP5igcUHMwx0aZ7njrnOl4jyrSql4dClnSrpZDX65/FluF3knJCb569iz6gsNF0KNH/kILJQhSqU1yoV7GaflGBG3hVOwZB2JMvygSjKO5hra+ajbujvpK8gKQUx1J1AyaH4rOQdwZwuT983pRaWYE6mi5PmdjnhpTHRJ+eqNYsP6TQwcYRuBi5cVCe+Hi4fkXWXkSwNcDpLuebLXBN6GzSLB4bQMMzknzfP819QYr7x8RHMxZ8ldKv2LKci0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlQYdDCgFztQYGy+CQ0Alx7Ye2xhzuka8lvfPbfMkfo=;
 b=b+XHDdbn/ZLyooGl4p6HdK9TJNHApoGyWAym2O9NjNM5KB2bbFVbAOaZa68foWn2ouMIgxLpY9BDhoIP8PVzSXXQ80OxBYOpPj18cHnLoyz/Y+S4Lsv+Tzs+jw7J41lDlAA0RPQkLCu/HNQJrn9ng/EUMTWpBbGo4A+Fd6OLtv8laVvaZE5GCyg4nr0oy23j1t1gQ6veYfJbI8Mk+moDWfLbXm5SHLyH4k3c1mKl6tvcRx0PuLX+vLN68nGvnUNLs+8+iP9ogtaPSgmhX2k/PW42XEHo3/1LalIP3OkiQnb64VWpSTxy0mS7xi36kBe84h2ZW9ucY8JlxNTJSW+wOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlQYdDCgFztQYGy+CQ0Alx7Ye2xhzuka8lvfPbfMkfo=;
 b=iZ22OjXGHDSNQRCF2VtSoCzObiWoIgka3KFQnH1RY6v46c2pEVJs87Fo3dj68dMaKFohrqZdtafDlbr9f938IFETxaboX9Un7+/bbtly5VUmkEEw/OxD0xTYXNavvln6RIrt6IaNZZ0nrWpLN3fD5X65Fe3HQAlEI0T4Yo0ZtQ1wgZBL6tzDxH1Xy9h1nQLTioMXQRdOx3Q9EJ91uD8gkjzFRGC2pRaoBk/KH50LMtulFKj0IisnqsqGSMevveR7tNamjv6GoH6fY/ADKcqEk0zH0KXtunznbNYBe5OL8GZv3rTAfFFNgx9nGfBznnnOM3m8EGKM9IlrXb7Y8y665g==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0132.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 22:33:49 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 22:33:48 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: netdev@vger.kernel.org
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] gve: fix out-of-bounds read in gve_get_flow_rule_entry()
Date: Tue, 20 Oct 2026 23:33:46 +0100
Message-ID:
 <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::14) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20261020223346.94622-1-elb12345@hotmail.co.uk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fecb2b5-7f03-4fcd-6440-08df2efa3567
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|8060799015|260925184616899003|19110799012|25010399006|4140399003|55001999006|24021099003|15080799012|5072599009|37011999003|25031999004|23021999003|5062599005|41001999006|40105399003|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HSSvRs4eVp5JAK5I62ZVjg3/vWbSJrOVjBqeZsX7Whq79GOqs7komKYXUWgX?=
 =?us-ascii?Q?xA0rMZoUhdsMnQ/7a3nimQWnHDucmK4Rb+lEnDULU8Gsi0l9VitzbASAwkN+?=
 =?us-ascii?Q?4ySKnguMNbCrobvvXOUU158PNscWTyBwUgiQMs+Zidl6Z6ogM0nU0/J93B9E?=
 =?us-ascii?Q?NJ9KX9mroNrX74el/iSwRst9lvmvRQG5r9CzU1Ixui2g4Sp+3rAc2YMPCkJb?=
 =?us-ascii?Q?MASlMe96oRutOr8vESgXE6gwS3qQL+uvSzM6+Kwx26am5jC3HBIWahfZs+iS?=
 =?us-ascii?Q?zdPwGrF8zuDDj+LWKGmv42gKrHe4uWgtyC170Fv8eSLnqgJvw8oFjwtCvOux?=
 =?us-ascii?Q?5ajULGHH13jL5JQBC0IY/GZo+OtA7191TW3XAq2oEOT/wd10ZEhKJsDxq+Sl?=
 =?us-ascii?Q?PAkgcvnltxGMq+/29DHqw+NdKpXbSd9cXeYULpLv6F6A2LqpdSyXQam5P9rE?=
 =?us-ascii?Q?CsaHLuCW9wPBKZnF5AVSXW+nwZXtAqtGGzGXh6stHYmLQxubVKgjB9Zoz+Ql?=
 =?us-ascii?Q?Gx8O+OKQaPpuAZ/eByFZqCfjoxxQI2cKlDqDsdms+pjf0CuwlFJoMwQp1CBH?=
 =?us-ascii?Q?xlFm5ymCwifmubS7mwqGOXbS1kPN1VPemextUlhOZphLv7QINo6fldAeSEFQ?=
 =?us-ascii?Q?hnxsPTcxRETs3I5XciKTPMQPtwyyOgw5nr8fvirylkSuxcMPbLWUWaXds3Pz?=
 =?us-ascii?Q?ootCI78xlTFLilT31Zaqe3gjYw9gMoP+KlyBF/PEe4qnLi5TcZMqpOKlyTOv?=
 =?us-ascii?Q?y22uEeQ1Jef9qFXqm2btHYZpvs+xMd7uY/dhkNTdCeMNEFt2w/uUdACdFi8F?=
 =?us-ascii?Q?2fTuIs78RS0hcGMWs1gsfBeuB7hZ5b9+K6S6cFBnfjzyg1aHURE6NLpWCg8N?=
 =?us-ascii?Q?kMKi1ahEQ12VW211Dzor4+oI12ws4rsDS09tqSUBIL20pSulZIsSNHiHJDu+?=
 =?us-ascii?Q?5PRpbiut7M91ReNJWNA8OY14/CgYPc+l5E6GBt85XmORSev3psoiCB8QCkzq?=
 =?us-ascii?Q?0DnEgZjqDqgz135Kn8GYf61DiS5sV9RH2SU76DrEI3aGPQHB/rJdYyuoquvN?=
 =?us-ascii?Q?X8SWkKA2oayUHvMQntsZR8qwtBi0ZfSPdYISvtIZAZ2UiIIhqA6ovc1vrluy?=
 =?us-ascii?Q?OB6bCJYPqCBR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIUD1yKtP1jKy/dQmQMVwmmTE8Zrz4MdUuTUqwmFkpz11qc+6bGAjF5OumaP?=
 =?us-ascii?Q?ccHpAc0lWHzXKKjjwyku6VvecSd/FTmxsfn/eXtPB2DD2NSTXb+RQFi5w6/5?=
 =?us-ascii?Q?/FZ9klIohunCHx8fLQ+vBqAOexkEgUaypCfrpiFpJHQO1lBA4gmkeilPSFVh?=
 =?us-ascii?Q?bzer1nqmbLXePl84CxxYG52T8a1huH853hNuslL3PYks5uoXmdxpL7epY8pM?=
 =?us-ascii?Q?hPoag3uz51/Bf2m4yuACpvgnQEpIk1wQCm9dt2fAvWZGSAcfjZuuCtrgXMi2?=
 =?us-ascii?Q?KB7WkraN2oZ+rgPhv9N5m/1jzioLei0HS9GeGvPlbeBIBKK5QYvz/08/ntLZ?=
 =?us-ascii?Q?VQnNoF9ry7gATv8FLvG4JK7GLmpX7iaFUpKZxlhs4i8B53lB95fv3W90NsVz?=
 =?us-ascii?Q?YaxD0AoGVwxZalksNLlXvkw6rg7Wi1pa22jL6M9jghjXELyj2gDPfA9jGaLo?=
 =?us-ascii?Q?i1PgpCPeC0UOm38pB4eNSD9L1xb/ZZsgX/Hj0v0yIYLDOPIM8Bsakg1LHKfR?=
 =?us-ascii?Q?Z2prBJ1LEjPwuAGZj4M/a9cRhiPMSl5bXSp18m3efcPYBMnGIyORTNmbhRm+?=
 =?us-ascii?Q?YqPlrOk0NkcQi/5gTwZnskHjVtHUy5Bg/GWLjy1lEDCNibOX1tsPxpze1+pr?=
 =?us-ascii?Q?r4Oq1Gx4bJwbqycMym4bq6Ytfi/ucjZd1lkN3FAlSRfTR89QIcCdk4f0DD7Q?=
 =?us-ascii?Q?V02yfSj08sqdo+xpjTghJ0+Y8OMyFzX9P4yknYswjxg1LUpxhJX0byMb1QHx?=
 =?us-ascii?Q?Ws5Patqcx2E+TGKm0/vE/yPbeyHrgUjugJVE2cjjQB5j3r9BAu+KPQ8YrcbD?=
 =?us-ascii?Q?hHhN855s+Xvm5/pp2wZvEjQcOzrrulBhJBlyzapGNjvebLvqN9ILPjH1ftte?=
 =?us-ascii?Q?gA1aCSZh+XklkiVdDjggda8DAqC0wR6e/8j/bBP9DaDIHFNBjAm37qaHHANV?=
 =?us-ascii?Q?I+G2dqVBH4D1GEA8zrdt9VSjFYgUZwm9gu0Ij/wbnR1toiIgdGSgnIPdjBCe?=
 =?us-ascii?Q?y9zMxJD+oKOaMH4Qf9gbcWqoQUlyRjV2TaUC+0uy1h959XcY8FRf/dDkUhUt?=
 =?us-ascii?Q?VgMbzBvBzbtwKkMafFVyobQ93RnC4f1VUq7Tz884R8QYuHxrmD2e23woORAM?=
 =?us-ascii?Q?O0Ok+9x+YWkPD1XjauouJZedbM+uxA2GAmAnZzK6aT5k4SvQaf8RQC+kb0AQ?=
 =?us-ascii?Q?TSgRUZS5GkE+C+UuEb6vH9wrQReIFeA5pmTkv6xRiI279XkTvfwFap1IQWrD?=
 =?us-ascii?Q?uHGoknTja0wO8wKtrWIybVuT8xcMf4Z25/cZ/Qo+oFGZeg6rbaEJqAzIXF8i?=
 =?us-ascii?Q?n4BOp1lE8SHLIj26gUgD/yKwMEtn+uvW6ymJ2dfL7hmSQ0XaEtRmnnnZDZEu?=
 =?us-ascii?Q?ZwSEBQ3Rsnvqg2oxZgpKuDIlvK5DOchCOyvorMjslga5xFCzQi7th9ocVexS?=
 =?us-ascii?Q?+IucOH1NAHMgN386qCGW9Z0moOcZAo9i?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fecb2b5-7f03-4fcd-6440-08df2efa3567
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 22:33:48.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0132

gve_get_flow_rule_entry() checks the requested location against the
first and last cached rules, but rules_cache_num can be 0 while
rules_cache_synced is true: GVE_FLOW_RULE_QUERY_RULES returns the rules
from the requested location onwards, so a request past the last
installed rule - or any request when no rules are installed - returns
zero rules, which the driver accepts and marks as synced.

The next query evaluates rules_cache[*cache_num - 1] with
*cache_num == 0. The zero-initialised cache does not trip the earlier
comparison, *cache_num - 1 wraps to 0xFFFFFFFF in u32, and the read
faults about 352 GiB past the cache. ETHTOOL_GRXCLSRULE needs no
capability, so an unprivileged user can trigger it:

    BUG: unable to handle page fault for address: ff240996c4c64fa8
    #PF: supervisor read access in kernel mode
    RIP: gve_get_flow_rule_entry+0xd4/0x110 [gve]

Treat an empty cache as a cache miss and re-query.

Fixes: 6f3bc487565d ("gve: Add flow steering ethtool support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Reproducer available on request.

 drivers/net/ethernet/google/gve/gve_flow_rule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/net/ethernet/google/gve/gve_flow_rule.c
index 2c80cda..db8b9a3 100644
--- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
+++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
@@ -206,6 +206,7 @@ int gve_get_flow_rule_entry(struct gve_priv *priv, struct ethtool_rxnfc *cmd)
 		return -EOPNOTSUPP;
 
 	if (!priv->flow_rules_cache.rules_cache_synced ||
+	    !*cache_num ||
 	    fsp->location < be32_to_cpu(rules_cache[0].location) ||
 	    fsp->location > be32_to_cpu(rules_cache[*cache_num - 1].location)) {
 		err = gve_adminq_query_flow_rules(priv, GVE_FLOW_RULE_QUERY_RULES, fsp->location);
-- 
2.55.0

