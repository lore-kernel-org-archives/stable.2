Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012010.outbound.protection.outlook.com [52.103.32.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A3480354;
	Wed, 16 Sep 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548847; cv=fail; b=ChY8bWtFBqNfIqHRN+bGoumKnioJ0cCOJnc3jP7Fm79Cxi/mDz6R++/m6vCYvxr+lvUHz0LxEmD8uovsPlrV2te/1bEv5xRjdDTfZFLsqyGXuq14cDgKmuEcpagGp9OyNxuj9NYqNDTE7+B5HnWinIGI7lkP28LggOqr4YfS5Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548847; c=relaxed/simple;
	bh=EsZP9E8J8RlCEPjFh2idwVI4/r5JpI0E+B6Rydk+5zA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HGPyEF0uiEhEWOwgT/SWYXq2+4Rypj7evZq8M3evoSAedRM6G2xYKsS/Egmd28IOVuxM4WRGpogBaNUZEvO0Glt8XQwt7Rfo8FItxCUo+f2QAwuDNut7V9idmJUgOv7r3h/zhVSZu3CqRxVuJBzdoS0a+jdr/iTAsBZUhAmJ/Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=L47bGm7g; arc=fail smtp.client-ip=52.103.32.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="L47bGm7g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4Y8POTOPwHEeu7CbTB15f/+XL4vm/yodR4kMvVIeksHmDpLQMf5TitKQrKfs8+l87xoSI6JGEdIM2sw6U2+wCZymF/6ps+QwMsaU6q0cao/FjY4hBhZbGIzqPmpknn5lwa5xdn3Wu+L3XJA5it5uR5iPoavpT9Dqfgmgz3NrlNIJAXMTBNXeSAUhhXfEfzIlJ8H3kteLYbeQKBhzRc02MRxb/PfGSv63ZjS3c5Jc6K4czyEudonrFmhVKYZjFD1luVp0YQeqAH7zJ2sOBIGEPgDDUsZvFNk/Ax4wGhes9GgrvcfSn8brdsN1lKKADwscChbcvGY9LHbtSPHqIBgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXqbQzIJzfgWyR7kifwpYBlmO3djFQ7nIlL1pkgKQj0=;
 b=kKb6nanBIstXRveRqvVu46OZUpylUFRbNopdhM4lT1wC6nYSvtWQiW/bwJpeMlPwXdlhCVa6KT/PMboY858E/875SKapVYqk0H4h8KrgbySYG3mpeD7psysdS97okc4r/SqjNvecEDckBE0DK5r/9EeouWPjR1zOU4gzBOAlDOtniQwBxgbN5WnPCljPkbgR7X6cpBcDPo/cAhqkkp6y/kzUSQJCf4AESeAbvf7xbwSVlMDYrP3M4awmk8N+GZkphBkI5I8YGn0A+4N00irx+B1yCYwJpISlyfCMoPuYnyc+QmB3TPimb1kK1h3dmChVwnwYe9A53Q7yTRXNHxkv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXqbQzIJzfgWyR7kifwpYBlmO3djFQ7nIlL1pkgKQj0=;
 b=L47bGm7gH4Oqk30qUQM51U0myjKINk+b1mMHLhvna64LC5ok6EZF7RgHy5x8yPs4btq+3I7wA8wFioEfmB2LY7KGkEc2r3pYvg8h4IP+jtaL5tELImtI2zJt4CWszZWG+5dMC+l4IReWs7rUpW2dXXiKHmyWYqJWBnp9JS99UxRDamSStCbnaHy9+7XJ0pWr0lcwiK8t7qBR3ipVtrswEYhnufG1inNCbc3w7d3d+oHSKHkkabytgvI3rAdYIO4BG4+1sozKtV5nYJnBsbwgtHBlhdG8dTs9vzY8BUYM87jRVwJmkrH7wi16QVuIiPoJkoSu+E0ucc9GbCYcZz1pUA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV2PPF8E0B748DD.EURP251.PROD.OUTLOOK.COM (2603:10a6:158:401::b5e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 08:53:53 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 08:53:53 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Alain Knaff <alain@knaff.lu>,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] lib: decompress_bunzip2: fix integer overflow in run-length decoding
Date: Wed, 16 Sep 2026 09:53:51 +0100
Message-ID:
 <AS8P251MB00010FE5E38D253CF98A652AC8B92@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0062.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::13) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260916085351.16948-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV2PPF8E0B748DD:EE_
X-MS-Office365-Filtering-Correlation-Id: b92e6cdc-40c4-4eb8-51f5-08df13d008f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25010399006|23021999003|37011999003|15080799012|25031999004|4140399003|55001999006|41001999006|24021099003|5062599005|8060799015|19110799012|5072599009|40105399003|52005399003|2607281247196008|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/MawxVsu9XLA69lsNUKBY4MN21rh8JtB399WqmA5eOPetgVoUAlzHVfvZGv5?=
 =?us-ascii?Q?BdpzzeTPsn7wGJRdRB/u/2C9TPBkcQkeNCRPrWxYoKP7rBuBs/FXnlFxLqRG?=
 =?us-ascii?Q?lY+SJrwZP4jjbhrf8Wb+/zWpk8BNfWOCMC3diBDhPM+GzatP6hBdI0Q++PtX?=
 =?us-ascii?Q?s6kXhpNZPX4uj4xzsXyNoy7YbcXRWAIMP901jCIS2qubfMs7thF/Yyncqb8C?=
 =?us-ascii?Q?uNR2jN3neGl7UCF3ZrtB2RIn1fs+rBgQDNK7LDwa1E8aLiNFTOM7RZDa3A11?=
 =?us-ascii?Q?ZR3LkT2A/sHFNakwya+jp1cMW8unmYg9nrbK3nCvfM0opMVADpooE+93Vv6M?=
 =?us-ascii?Q?7mx6oZR4rKXx4nrRJJp9H/krCjUm8N7GS8LlvAWUxQ9tvylbCWxuuhNzJE8h?=
 =?us-ascii?Q?ZfjJhzsrh1YZxjiXIulqHZZvWSIy7RuplmaGzMcME7PEcKnjZozygFTIw0U2?=
 =?us-ascii?Q?bOXsWlDHOeKPnMmfymELwammsW/KGRdXWMTkvlR4EOPKUT4yY9gXEHsVP/iI?=
 =?us-ascii?Q?okc2sE6mr/muq41e7DfellgdJo91aYya77RVR5sVxBlRQUL0ZhtTxPzzsyp/?=
 =?us-ascii?Q?NSTAiK9hEAJmIW7ZkZd/IwrUy2kpJ2st+zcXsuhJKhm9EDAvRAYarCgOmvGf?=
 =?us-ascii?Q?6/e9bmK4VhLeVh3V4tIApW3bZ5IGFKyZadSlSH7ahNeCI40OUWyHG825CNP7?=
 =?us-ascii?Q?XP8aXyJOXU3InhC4/gywAUzI4SGJXVJ1Fc8CuYepAucywZ2aoq83k+/FjdSB?=
 =?us-ascii?Q?ZG3NnW2RYXQqSIU1sQNn+PdiT6OD32QVuc9hMsyT1C1UYQkLpZhzUfSR/Iz6?=
 =?us-ascii?Q?s0roJzgzn6AWTcJ7PSxXlrzaZH6ujEalKzUhZBCKbjaAag/umrpjdz1cHVRl?=
 =?us-ascii?Q?GOMhNN3IbkszZQiDn29y3KQ9jbX+smLgnTDcOSYPrXFoXluhlNd/lNH2kY1Q?=
 =?us-ascii?Q?CbSKp/D7mwR4VkvxHNwk+GUaemhg9VWZf9Wyrq46M+01ndomNAIWx8Hp/n+C?=
 =?us-ascii?Q?LbrXRp9dxXP9/M1pngm4TgEv0m9k/xzplBdUy8I9SDAttfBftuL4k99N9Gch?=
 =?us-ascii?Q?hu+UI3KXiWaFMgj0HuNOtmJII7fM9fHK/g9HZqzdMDFKRXAFJCU2WssKRjT0?=
 =?us-ascii?Q?8L96AbWYGoTn?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBSUxmG48pu/JnGYag3M2uyg6iTwxjYBAh1w2y41VbnbfCoW4FNWpdWYVjIc?=
 =?us-ascii?Q?Ob3rM/um0aC4RYETa0guAvWNuV2poY0K9Zy50Oh/Xq+c3XyNa7RQakz4Kc5p?=
 =?us-ascii?Q?Ht5/A6D4do7RlgHruVTRbjAKJjQOcWKKX6+RmNXO11KB/8Flw042gwYidwxv?=
 =?us-ascii?Q?oH+mDW38A9iprrHNB65y63CGGcYQq76EFcnUzs6E30hN3H4UttYi6RjaSSKn?=
 =?us-ascii?Q?usHtQi1xwThKOI+fNLdfyX/11wsCNCKnEQhyV1Hj0axNwPJvinhZNuiU+Lwd?=
 =?us-ascii?Q?9vYPH9I3rYw/r+ReKNPKMox/nP/YadHifqNHdUxXkXCVH5cK6Pj/R0XL+pUu?=
 =?us-ascii?Q?OH1Mc8hP3ZkyTml1YCM75lgcJrNPx54L4zFUiQx95ZEDH7siBax+1ittC2Vs?=
 =?us-ascii?Q?Zq2/2VuAk+By707b+GFBlttYlv/YkNd8eXvDYZBJBPcu+dVktNyPa86Hi5+d?=
 =?us-ascii?Q?coSnwhsa8zwj2EK4NU4p01vQxqxRMcOCRZAeE0varVoEPVrz38w5d00J7nlp?=
 =?us-ascii?Q?FTYt7vV8y9TTm//aUenj2sT9sUh5FwXP8JqwxaBE+LB9IjN6qdrxZFoZ1j/P?=
 =?us-ascii?Q?1XXfO5j99qMmmXxXVFtgwps0kf4wu9X64DYoVG5Ufwv4B8mi307eenNTo6pi?=
 =?us-ascii?Q?5G0hDp31oEHUm56t7WY1v2+i1WN/cqFRAm9NlpaH6m910YZVvd9UiP3Pvb9F?=
 =?us-ascii?Q?27XrqqoyKuBIv5ZHJGd+UfpeEfCQxDCJxSi2PnqWN+ySoOGuu2czJ6vijVse?=
 =?us-ascii?Q?4P1zS6xCsiWF96jvmzmhoy+x04vPEYNiG+W/G9HkINdAXOc0C1Qgj4yZc2v4?=
 =?us-ascii?Q?uMLhBZhMh8Bp5Edilu5NSnKsDhgYIJdg7WOYcukVJck3WTDCpciG6PW4X0Kx?=
 =?us-ascii?Q?NeaRKcSwJRvSjUV1O2Y+migdy5sG2aW2ECsZdBFyU5HOjepOFk1CcyL6C9TH?=
 =?us-ascii?Q?WCXxCtZMmmfoyIl99+sa7I9U0fNtSFRl6vGMlr6ESxiRp/17aankWzbyhvTK?=
 =?us-ascii?Q?2hq3rIS+XXTss0VDNv/3clHbcpSQFG7iHJ6caPMupp2ja+OfdKoWPooRCzgw?=
 =?us-ascii?Q?ZWyjRgOhvudjs14g3GSdczSG1muduiRYilovwVD7XQkDIWOqGsN2T2QyRdb7?=
 =?us-ascii?Q?g4f0aw5+QVFm0DEbLE5hYWkW/FIf7XHuGz+WzV3gByrRCmkf6SBNdKTNeE07?=
 =?us-ascii?Q?ExdSL8hCHIJlss9hQIVB0LPbo9hr3gk49wgG+yAZRvEpBHpRS7vI2mmTuyqJ?=
 =?us-ascii?Q?o9v67kCniTUrwtktL0SoZ5bvtSF93rGsQZbmd7ItF+0q6uyZksE/H9J0yduP?=
 =?us-ascii?Q?L7I6kw76u91IRrDAMoafFh5Bdv9y+i7rs6bUdYVL1GGZYWQmVJe3RdTGiI48?=
 =?us-ascii?Q?bhXZ9cBsbH1c4HXxnTldrd03lTLzXKuNZnyHteciNgrx4Uabq+UqwiYmTO00?=
 =?us-ascii?Q?Gp1ZmnDXjA21zSCFGztmZ4OgFyV8pvab?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b92e6cdc-40c4-4eb8-51f5-08df13d008f3
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:53:53.8025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF8E0B748DD

The RUNA/RUNB decoder in get_next_block() accumulates a run length into
the signed int t with no bound.  runPos doubles per symbol, so t grows as
at least 2^n-1 and reaches INT_MAX after 31 RUNA symbols.  The guard that
follows, dbufCount+t >= dbufSize, is itself a signed addition, and as the
kernel builds with -fno-strict-overflow it wraps negative once dbufCount
is nonzero, so the guard is skipped.  while (t--) dbuf[dbufCount++] = uc
then writes INT_MAX entries into a buffer holding at most 900000.  One
literal symbol ahead of the run is enough to make dbufCount nonzero.

Bound t to the block size as it is accumulated.  t only grows within a
run, so the value tested never exceeds the final run length; any stream
that decodes today satisfies dbufCount+t < dbufSize at the flush, hence
t < dbufSize throughout, and no such stream is rejected.  Because t grows
as at least 2^n-1 the bound trips by the 20th symbol, leaving runPos at
most 2^19, so the following runPos <<= 1 cannot overflow either.

Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Triggering this requires control of the initramfs or the compressed
kernel image, so it is not reachable remotely or by an unprivileged
local user.

Tested in userspace under ASan with -fno-strict-overflow: a crafted
31-RUNA stream reports a heap-buffer-overflow at the dbuf[] write
without the patch and returns RETVAL_DATA_ERROR with it.  Valid bzip2
streams still decompress byte-identically.

 lib/decompress_bunzip2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 1288f146661f..c4e84dd55770 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -428,6 +428,10 @@ static int INIT get_next_block(struct bunzip_data *bd)
 			t += (runPos << nextSym);
 			/* +runPos if RUNA; +2*runPos if RUNB */
 
+			/* Bound the run so t and runPos cannot overflow. */
+			if (t >= dbufSize)
+				return RETVAL_DATA_ERROR;
+
 			runPos <<= 1;
 			continue;
 		}

base-commit: 9b87fdc9af2fbfcdb5c24a64139685ef80f6573f
-- 
2.43.0
