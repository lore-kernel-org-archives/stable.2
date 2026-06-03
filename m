Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020102.outbound.protection.outlook.com [52.101.84.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7962797AC;
	Wed,  3 Jun 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483427; cv=fail; b=AoDj7IXtYLvT8YAboaq5fYZJh5s6cZsI7x7NbDJ9YB04zoNuUTObLmHYA5+laTScd0Alvh/BnAS+rj+v16ov09yVxtyMVBFNxcFxKn+bshZoEFjc0/yPyFgZ4n1/m5cIykGS1L56uNHljShq93HDeUXg4fhEcng+CvGzSZQtMRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483427; c=relaxed/simple;
	bh=UxzYZtKO04jhzW4DbCAtuFtJIps9A6CCgHLSlmflwww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bu1uvp86SHFRP+8QHHDUF5jTPoBgwh7nPLLoxiOV1v2QtJyyHoatLkCvl7sfhkb2lLDlApTAefXkdCPSaUREpOVJ7HaQdV+E+gwAVCg2BCD68jaNqJhWtImjBOtnL4K6W1BSwR1ucm4I6/8uWmAKz3eLYEi7R0YG83MavhtvXJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=aR1OV5d6; arc=fail smtp.client-ip=52.101.84.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="aR1OV5d6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDPEKztfOVMUSIRaXWYm30wn3W2GJQU4ZbeLuP4WQ39W+d7FxgMi7YrI02ERkhXE1G9+X4h5Tn9Z4/veWPHf4mlUfcTJQiX7PJUYyi4GfEWz5KiWGDKvV7juOdO11i1RqwODS+hhY+JvdnA4ZNHYx98KqUVAKa9eIFqxwx+Q4WU46I7JC6oTgQd/JPU3t3s94nR4i2v5sz6F6epCNO/EffZRP4BJBG1RZdm8z7Di0CpBm4BwQLFi7UOgEYvDRYDKav55b07FVLLLPuBK1eJdMqg5IPlNX8+Gnf5vrGQjwvn4ciAciYl6eW6HGIxs0u7RG3e7RQ3DuPFHosyUsmYCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU9N7RJro1EafdxIieaP5pTIaakVSS68ZAvN4R4veso=;
 b=VEqYd/OPTF5du/WDv/NCXyFe5AS8x4NM2JHMabKzYSQvDAu5GaL/Y8jsaU6NH6ixTp2qABCo3HctKuQ6OdN8pU3BvBgL/ErOJRaNp2zn9ZUBGaZ30axR1YfGXFCf3jHTHWQYRiWgIeZMqzCSoEQABHvBadHfV/+RW71Xg9rzzvgPszQwVn1Qxs1x0FwlLOubf1hoUbuiJPuNrzlRs109Bbn+baPEpSQZmgY+HgTBvF9C1NL/9viJ8TUajSjYl3qNakdni0mE+P+H3Tnu0fOJVJFa9wit8Xxmx6PsVvDvhRgRk7CagsLNYB6EkqGpj9klQ2s8MAMhLlTn7YDe0O4HUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU9N7RJro1EafdxIieaP5pTIaakVSS68ZAvN4R4veso=;
 b=aR1OV5d6xnTIKclGmX1qczAa9MIy/goYktCX/tWZ6mtUbQkIXF7t+1yLmJi9ddyuASUbJCPw0ru8WDtacyqYhYewBSxhXZifeP2Zik97XJL2ww3CeQvYBl75zZqcCs9H8hvM7hL9rwbnvClmV3sNOHkZvc73skd0rdzI8ZWKFY0WR1cjOO51p2DE7anZFDmOlXH5+FwztpriEOAfMYRmuc5Ny9zCX7GLOMSkIPMWLnQ0a118Z1FVHKBloHv41Pj/E44xy4sXf86WQZ5mBGAeiCrOfo8SdAnnNzCg+jTGCxUNLCBkoPumSl/zL6nRV6tDROgHEUiVmoG16VtCcfLZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM7P192MB0787.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:17c::14)
 by AM9P192MB0903.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:43:42 +0000
Received: from AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 ([fe80::c1d1:f20d:9fb5:72d3]) by AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 ([fe80::c1d1:f20d:9fb5:72d3%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 10:43:42 +0000
From: Chris Gellermann <christian.gellermann@codasip.com>
To: akpm@linux-foundation.org
Cc: brauner@kernel.org,
	christian.gellermann@codasip.com,
	david@kernel.org,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/clone3: Fix wild pointer access of getline due to missing init
Date: Wed,  3 Jun 2026 12:43:09 +0200
Message-ID: <20260603104310.936706-1-christian.gellermann@codasip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113409.ea65314eb1da831de7c90ca6@linux-foundation.org>
References: <20260526113409.ea65314eb1da831de7c90ca6@linux-foundation.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0213.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::34) To AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:17c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P192MB0787:EE_|AM9P192MB0903:EE_
X-MS-Office365-Filtering-Correlation-Id: ebac0e32-cb2d-4afc-0ede-08dec15cfaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X9AmayHZdvYjQhkc9HCXfgp48h8c2w3CB2+sY4OPbBDtl/Jh3w0hh0KeuDAHOpuCC0hzF2pBLX0NFXVImd9Xl1MMGtJSj9wjVYPJ/eoMfFDOQAan0MVJnROMy58FtiTwH+XGr5z45ShQT05ruMBJc/5LQ+AKRKk7wcWukJq1ukVkT9WygMomDyG7xl0T7O2gNy7f51qeXHReupI37MSsTjUbOZXlucUtGVPe9N+JPCttQJuGJeU6jw1opy5QV/x80aRxYoBX1ABDVEixvBw0p2Yz5M+IAhapw94jBoYgppFtlTzj8MWIF4xq61yzM/GgB2fX0EYf00ghDDggBz+XqOd5Su/prlTOdYF+iIGg6JMBSpUYAx/7/pxaCNBRjQSrotELc5KyZLx+nssbN/y7Ntla6cwyslPs7WAfOLKMAR9zawgShLpXPYFaYv++uHmSsHpbqkdQAuJ1yui7s3DoTsyWrL9hWLlugm4YwlGuW2H9cPkpr4ZXaAYAR+xEzijXv2K4F6hbBDRR522kXdELx6kx2+5O5ZjerYJVsFLURibZ6QlO/KWi7TlBdb+XiM8BeSplO6me4n+vHDq9IMzyGXjp7X3WtrU4Z13PdlI0DtcfU8PTv0xgwSAtuT7mjKq38fx03maHMBqrk7FT+JnfEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P192MB0787.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqdFRWIGkqF5+puDZVsEgHtU33UZUnvIp/Fy2QlyGVwZZotSWb+CGioLWfig?=
 =?us-ascii?Q?l02AO2e+sBjkQdW8h4vprf0EPwxtx7vgp2JjvVn21VI3bAOeoRGXeCSjjRxl?=
 =?us-ascii?Q?0JDC6MEgHR1IQ/WjNJ8omAojg5bFfzK1i56Ga1biEFNLMrgLF73HOjFcUhwC?=
 =?us-ascii?Q?KbKJo0jDzW5Otep/jeM+QGGMdf3hPMXsVR+We37wVN2Yrr+3/XZ8B3ezSj5Q?=
 =?us-ascii?Q?sAJufWkPLJVGDaMOnYelZ/pQIidLlxUZzpxOwm33ELm+E9UAkcTIma8rZ0p0?=
 =?us-ascii?Q?eWuuSBsJ6NQX/tazQtl3EyxUW8+sL2X7aVrzgfk/OJ+wm4fWyadHDuGCiYIq?=
 =?us-ascii?Q?a59rUZy3vgJApo9Yo5HS/CdU77AECkROkgHVcmf6CbaiNA/ffa0eosXZ+9XT?=
 =?us-ascii?Q?/vzq/PRI4XO/GdFXqf2gP+R8cMr2uH3Z6/REVq9pPaY7q/YK22NRCuIsTHZ4?=
 =?us-ascii?Q?5Qqm19tidAk7n84CumCKaIRSBW6d5dGHTti4MBXNCe0MTBL5uhfc80014KJH?=
 =?us-ascii?Q?33+kqkUhz276qjt8VVawMCmEIUn52Dpz4YlizHMeGSjEE447724odF98SZAO?=
 =?us-ascii?Q?4YO3Jhdf5zdMtHKhHCsKIP9vrTLUn4sCK0Z9I74cpa9Taw+5EmHMSTPtboGm?=
 =?us-ascii?Q?ImJayFU6n1tUdZ71kiMneFl3LcnZvg0VxAUWDAgaYOEooR+XyZYTD8m8Wk2l?=
 =?us-ascii?Q?BN9WM31EBXY3a0S8BHvTqnfeuHDv3aRo4FVjz5rPpjAtQotz3evGShWKj51C?=
 =?us-ascii?Q?WvV4DDphGgtIFUJmpLrF6v8VNa3f8aaZxmXoFZ9hMz9FNoOcGDZ3whDiIvjh?=
 =?us-ascii?Q?+b15aQxvQ+b2cYubZbNHFrtvpr34upv5Rz4DVRNCVHlwMxKz0qwdIKxy3hVb?=
 =?us-ascii?Q?VkThIU65KfLM+TCW3j50/jNArhoblcV+VnJyTrKvI008+b4dDQsVGa92XN49?=
 =?us-ascii?Q?VngRqItfO1trCiaignhetPhLvzUtTvaqOuDXJLA+KFVNN041hAyEpxooBpeN?=
 =?us-ascii?Q?etDcE3NCcCfIb07KfsyfuxjoFOObijpsgQiP2vOQPNGGTJtmiPBMVGyrjAYe?=
 =?us-ascii?Q?gBiohHcX/HYKiGZZeeqMVKR7KPngFc8ihEgYzbbiJkZIi7DPaUIHRjlCAM1Z?=
 =?us-ascii?Q?xa5jYyGcXv+fahF6d4aRoAV2SsiFJlfdwQGpcUQyXdOWusgRfaA4ynZp706r?=
 =?us-ascii?Q?TjIKOL9Z6gYvZ80qVksXbQ5arK2+iVbdHme0qykB9IisktKZqGApoUl8Rn+n?=
 =?us-ascii?Q?9y0hz/eEfIBPKWvWSVixXSAqb7AygTuscryUTYfeZfiW3R1iacVmKf/R2ybD?=
 =?us-ascii?Q?aAZbbfdvw4A46CA/JMaVks2b10XSBzoxDC43cHz0b4zwJvnrmK4YqNKTt88W?=
 =?us-ascii?Q?QUg4jcGibDOyLAfuF713ER30WUEijhOT+KXSQpLbmI6Dwkk0rRAwGuBX6JWf?=
 =?us-ascii?Q?IQMyrzGWi+tejDKbChhqqBhRWNyl8bS1YlBgjZdRiCrAMa8sBeJYMm8HjfMd?=
 =?us-ascii?Q?n9IhFFciJZpmrBAV9vsgR1xjHMIfOS0XPSORPr4gLnpuY1wS8PbsVQFzAwgm?=
 =?us-ascii?Q?1wMD/+U2Wz0QwAdvwMGnb0wVHqQaOcYg5PTTDyHFdfga/m216qarAlyWgzvI?=
 =?us-ascii?Q?lVTR59kdRpKUJk7WSK6iXtX9jhnAVLlcqOcmD4iIQA0G9GZs9JAVRg9uRXFu?=
 =?us-ascii?Q?Q/vNgN9sP4OZEmFSiPEJxzGyRupoCYXLxuMW0SmVrq+jejmR0rYwnpTi0R+U?=
 =?us-ascii?Q?3eHw3vDxt1jldAaI7u754ZIXNDjN6aVgA4iwsqSbgVxxv9j+ZUbf?=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebac0e32-cb2d-4afc-0ede-08dec15cfaf1
X-MS-Exchange-CrossTenant-AuthSource: AM7P192MB0787.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:43:42.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnpBax25h4mBr7kwUd07a12xs7PHvthgm7iz5htUYJbtrd9FO5MqoLBR5IjpeFNK+60XgmpLFog09nbmg+UfBsbJ7xKcOW6tqX3BjiDj01iYi0OUR5bWL1b0kz1S1ckz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0903

Clone3_set_tid uses getline(&line, ...) in a loop to read the child's
process status. The code expects that getline allocates the buffer for
the line on the first loop iteration. According to the Open Group
Spec[1], char *line has to be null pointer for this:

> ssize_t getline(char **restrict lineptr, ...);
> If *lineptr is a null pointer or if the object pointed to by *lineptr
> is of insufficient size, an object shall be allocated as if by
malloc()
> or the object shall be reallocated as if by realloc()[...].

However, char *line is only declared, leading to an undefined value
that is potentially non-null. In an example run with Musl v1.2.6, the
realloc call[2] of getdelim, which implements getline, triggers a
segfault:

./run_kselftest.sh --test clone3:clone3_set_tid
[ 1366.165898] kselftest: Running tests in clone3
...
[ 1367.799244] clone3_set_tid[811]: unhandled signal 11 code 0x1 at
0x0000000000000000 in libc.so[68184,3fbf69f000+4c000]
[ 1367.802808] CPU: 0 UID: 0 PID: 811 Comm: clone3_set_tid Not tainted
..
[ 1367.804188]  epc: 0x0000003fbf6b0184
[ 1367.804188]  ra : 0x0000003fbf6d4664
[ 1367.804188]  sp : 0x0000003fce5f2e40
[ 1367.805314]  gp : 0x0000002aaab0dfb8
[ 1367.805314]  tp : 0x0000003fbf6f14a8
[ 1367.805314]  t0 : 0x0000003fbf63d000
...

Looking at the realloc implementation, Musl mallocs for a null pointer
memory. But for a non-null pointer, it assumes it's passed a valid
pointer to the heap and tries to access its meta-data. This leads to the
segfault we see:

void *realloc(void *p, size_t n)
{
        if (!p) return malloc(n);
        if (size_overflows(n)) return 0;

        struct meta *g = get_meta(p);
        ...
}

Fix this by properly initializing the line pointer to NULL.

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/getline.html
[2] https://git.musl-libc.org/cgit/musl/tree/src/stdio/getdelim.c#n38

Fixes: 41585bbeeef9 ("selftests: add tests for clone3() with *set_tid")
Cc: stable@vger.kernel.org
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>
---
 tools/testing/selftests/clone3/clone3_set_tid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 5c944aee6b41..485efa7c9eed 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -141,7 +141,7 @@ int main(int argc, char *argv[])
 {
 	FILE *f;
 	char buf;
-	char *line;
+	char *line = NULL;
 	int status;
 	int ret = -1;
 	size_t len = 0;
-- 
2.47.3

