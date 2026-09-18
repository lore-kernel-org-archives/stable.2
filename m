Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010002.outbound.protection.outlook.com [52.103.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC34F393C;
	Fri, 18 Sep 2026 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749577; cv=fail; b=mwDZYMFTw3Hf3QVIPA9c1kHLSmcpIIvd2pCw7YfXy17sRlDWwhP9wI0lCuIngv1W03guebkGUsXKYl+GoGiruH7gXUBXtia4lsrH4AZoiRJjYwyYVG4orcPGEu5T4sPqJF54JGt/o29qU1XHEX4oQtgcI/aWk3enfHGWUBfLiX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749577; c=relaxed/simple;
	bh=C0Psxn3ERVueUYW5sFqBVKjiN4/dQE3IKwSI70aVK+c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UfyUB80XVzoV45uZyT7Eqp6T3x9zoTiCCNYrTB74Ax+i0o5Ca5n15cnlz+4pybgWr/4SYGZ4adLZjSJtK7ee/DMz082ktfDCV1sLXBk0j2e1dWBZmiId7wzSvBSKPOuwp3wA+1CLaTXVmhiHh3MUSuj5hRyd48h5ohdUsN46lh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Md2401vA; arc=fail smtp.client-ip=52.103.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Md2401vA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ervQvWhnHKqsTiJnC5F+zgJ3ly99hV4ojvo9KDGyAI8WWupzt4sDwjpmOnd8hSRXwVISBrQT8Sc/7cJ3vRtrD8eaJuXHjWU6AhvJ8yXEyIS1xI1fPkx5509B+f1Tbw0kIP+K5i1H3XDDcIVJnHYfQGad61bEd64dfBAN76bwYvFryAsd0a79m9N6YQw1DDybP//QCSht4kwOgFTe+PC16uv1L8BXYPOyTI73zvp1fJelsVRCKUWgXu8pAVTyIsA5/7yfaaiXKO/Zr0Qm1hkyM9MYSjiTeKSUl2OhBtRI39zKEjfiwUrjVYQx6iJDsri/PXZKWbTIbzuhEVGwUDsyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qNz3k/WWYHM4HwgpsZl8txOuh4grJtpZF81jSpSuQk=;
 b=siPzTyANjWvQibxx2GJWRvq4H5iXw3gOA4BlUTTVzRhLZKo7K5ZqDhhsk3BPJ1AXy9QMs+WXB2up77+a0X4wZTO4bSiM0AreIkztYcO0hsWQyc5Ic4nDrNVqnlV0r0EPEPVJEzs2PykCg6A/0h057SQtfYYYN8o/joHbuJiwwVkjg5KV4aC7rEMqv/yLH6IzAokS1wq1lTM+zm3kCtB1qMsC4MGfa0Q/MyCl5Eakgcc1P1TIC0sGVBSMEK/x4IlEapHDcjAihCfeCZ8KaMU9ZyiPwD8znBnj2ZSkjRVquQ4bsTJOHroHgfl3GBwJPRYIx4PBgKP0U0yuOnXWcu5ruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qNz3k/WWYHM4HwgpsZl8txOuh4grJtpZF81jSpSuQk=;
 b=Md2401vAs2YFPkQazEf8JZbuuyHcWGXbzX0obwAlF+MP08Lstqo/PKJc2PA/HSKqAQw71sDqLu/FbasCM9IoPvV2r3eEEm4x6pBw5EKcEiJ0/k5zio6gBkj/8ioow8hsrtc0d8POa0PdP6yAGLP5b+5jkEwLxXfbxF0KhyYYKaA3whdIyB71L9CEB7ci20NCgRj00YsFEUnBKaOP3OyK5d5lStDnwTNfnrKmjbguA5LCQrf7Ooxi0w9MMbfObDqbV+8/gZW+dqYA1cS4mq/3z/nGV+WwiMEH1nhdusRdv1bSFb3YFba+DTOvBzpL18Vx0KmHyTa17aE0cB7ZFRZUsg==
Received: from OSZPR01MB8140.jpnprd01.prod.outlook.com (2603:1096:604:1a5::10)
 by OS3PR01MB6965.jpnprd01.prod.outlook.com (2603:1096:604:12c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 16:39:27 +0000
Received: from OSZPR01MB8140.jpnprd01.prod.outlook.com
 ([fe80::91ec:49f5:d743:6d5b]) by OSZPR01MB8140.jpnprd01.prod.outlook.com
 ([fe80::91ec:49f5:d743:6d5b%6]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 16:39:27 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [net PATCH] net: ethernet: mediatek: only enable WED for ARM64 architecture
Date: Sat, 19 Sep 2026 00:38:30 +0800
Message-ID:
 <OSZPR01MB8140B889AD227E0B547F5F87BC872@OSZPR01MB8140.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To OSZPR01MB8140.jpnprd01.prod.outlook.com
 (2603:1096:604:1a5::10)
X-Microsoft-Original-Message-ID:
 <20260918163830.297803-1-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZPR01MB8140:EE_|OS3PR01MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 950d61ec-0455-4c92-7589-08df15a3674f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|5062599005|15080799012|51005399006|25010399006|19110799012|8060799015|4140399003|24021099003|22091999003|24121999003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dwbkueh3wqoiDEsDyL5+TQcn88IUhxT5bbkYNv/h3kwF7E7TJ2jmXBkeNO0f?=
 =?us-ascii?Q?BLMLyG02lAAwffyzztkDwmXCwTNTbrLC2If4LtDGPbvqFWWCRkTDg6mRlcRC?=
 =?us-ascii?Q?4FiOM530Jl8Fd9wbWrb9V7WgcR626dzYh73ganooBjFcVMs9fWEUT40anJE9?=
 =?us-ascii?Q?6kV/f4H2XDL2LTo8sC/9MbUJKEQRV2mQ/z9V3KTQjfCQHvBQznk8wFmVg3f+?=
 =?us-ascii?Q?ocJ8t00CQRChTKl++4xDYijLlIVIH4DxJKj8TDbsgSdH5sAMTtSbwVNFm80O?=
 =?us-ascii?Q?ikbcvOk1xtWXkw81gASP91UOyb8MP61p3zhvBqWRtoT1VZyouBqyxrBFRDWW?=
 =?us-ascii?Q?nl5YefBvIKe5oW7+ZTcm6lb78w5BQeyK5ZNYB7ujTHgsyA2ZtXA5nNWJdCh0?=
 =?us-ascii?Q?T4jlR+80TxHjFTHUXqyOEEfXnpYG+2mrOFmx3hvlRRLFhwCi54aUxslh3euB?=
 =?us-ascii?Q?0ZnOtIdMgmcOiUJi7PGQRL8WSMKvLpe69U3Yxwu6ghmarKuRIB38HUN5hkwe?=
 =?us-ascii?Q?e0qnpQiag1i6gJwcf9CKrT/2rJnBRmFkUaw+Thf1y3wSEwfY6zPljfxBrEiE?=
 =?us-ascii?Q?LFtFBQJckYy2aX+jkUmKZZY84dkstjlXN1vMneTCey6Lse1HuCq4+1X6xrps?=
 =?us-ascii?Q?ZimyoNdffIZSTS3I1FiUrtB6L+M78fTJ2b0ke7mcj2BeLBzV1Oc0LqPZkrst?=
 =?us-ascii?Q?BLAlxLXXVy9GnQLx7IispvU03GSYYkkMzcPTZaixOjvv1cmpW7dBJBcY8+V6?=
 =?us-ascii?Q?vD/mzGAczKL7MJUfxjYOm0mxirOIVH9a2StOF334vnmF8LR5Zkyk8hC9ngNG?=
 =?us-ascii?Q?zFFJ08rfJFcO84T+7dDZZBPk8SUX5nTQFwNzcEdDjHeASmVELLCJVn7QXJ4J?=
 =?us-ascii?Q?RpfouYiOGS9mRF2rduC9rn3VwrechluMcpupCR+DquOxxrI0KtnJF+euXKTj?=
 =?us-ascii?Q?8YYv3wOCnw3yBmBAyJEXD83rW2rh3q5Fyw2v8041LM9nQtTnaIbwp4GLCGuY?=
 =?us-ascii?Q?L+QE/7B0MaEdu0mvzz5wZBsQjgZnfurDTQ9hWrN5QTJzllAbIbD9+28bocJx?=
 =?us-ascii?Q?tdAG3WN9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sEjT1Xu4x0jMSNgEo2Maf8Xvgaz9J5WsoIZ/rSsQ97/WnPTZK3kL6CsPG03o?=
 =?us-ascii?Q?5SmTxB2stgg1yOK9gkJliAc2mdWHCckzjVsb9KmKGCNbUb97yZOaCkxwOyIQ?=
 =?us-ascii?Q?bt5+RLEmqgmIxWLCskzEtk8pjerRpfwq/JahPgaNu3FCsQrLD0hWq/aNpf6f?=
 =?us-ascii?Q?At8N0pNwc8X8JuIPos66M7zU2w895M8+HbhfHdyhy1nuhDG7U0bV101yAlNd?=
 =?us-ascii?Q?lUELN9pT9RCA6Fz1hqDXMRWKL5kzjrZybEBi6Ftfhc+HGznm1LDQrZWzprvU?=
 =?us-ascii?Q?Ea71ImUa195hzfAA0hkot9el8ZGBhHXiRmw5g8HRljZzl1zTkpbkclQ9zRR7?=
 =?us-ascii?Q?hCpg9xsQdUv7eSJShYH5UNYIIs16str3wkoT3cvczzkviwgf+z4FTWqeY5vE?=
 =?us-ascii?Q?gbhtQ1pDPnS9NWMjtXYp1p/snW2lsXo9Kav8LZkuUWLQVS5Y+ZDGCUYdwYbQ?=
 =?us-ascii?Q?6NFsD0SPIUIZfX9tbBD/WfVeqr6OUzbcN+TRJmP1xQqr6DO4StE7Ifsw4XFI?=
 =?us-ascii?Q?cVQABFXIZZt7MBmINbBLnM+SpjKolPWriZ/FYYJedJ4RkffzuqTdp52tTc0e?=
 =?us-ascii?Q?oy5qlYArNmv+mLRLsZWqQ9d+Eo50LDXq8jCJkUNLQ/P45O7MKPTMB90Abd0L?=
 =?us-ascii?Q?EnQPpbUEbQo4xeObbJQthHfKv8+zQyU273t9z57fiy2rNQlUjnhTKJ4QUNc2?=
 =?us-ascii?Q?R6uIMlzf3rO69Aj/b1wn+3wQ/ZX8753u5jpUoOZbGsIOs8rK+i+mQUz3GqZz?=
 =?us-ascii?Q?vYJA9Ytg3FZijc+yIPEkxxZHR06AfHeabasZeqfHZ6Mg2KN/zVi/xas8Fn9o?=
 =?us-ascii?Q?eHXZWZXCrdBVvG2omo2dBx/wBe5QO6m/Vl/u1y4v83kXWQMXFjB/CC0d8osQ?=
 =?us-ascii?Q?T7SzvwpgmBqiAbRp4ruSxLo2/MqFZALACqKGWgMQGb7c50D0Pr9nkZEg6MsN?=
 =?us-ascii?Q?kETbT4RArjAh1xXU0Kmn8HSjTYbqmlqqN64THbhlBgCGXMOD7TDCbvBqq/ol?=
 =?us-ascii?Q?DMvnCe/hHmFqVxFPw0qeWABv6+MLoojz+scwhLHE5bvQAhBkK1dcue3dYBc/?=
 =?us-ascii?Q?Ud2SOUT//98b7M0YFhSVr1bc6KugrTD9Jvvx5wF/fWy2y6Aox4M7nkcHtOgH?=
 =?us-ascii?Q?Qq4VZ6PSAAvE2MNJBLuwA6fgs1geOfEcBu1Kd11seqs1yAq0jtGAt/QUh00/?=
 =?us-ascii?Q?47VIbkKg8NVlxS9uTsE3VSYLgNJh/IMKHmaZ5opetzOQkC2JBg0AZgHUy7uq?=
 =?us-ascii?Q?xT4ZCYJ7sXBY6RUs8PTpulSS6c9CjTCjsOixFhPRxPeFqZpI1uCcVUKJCiLg?=
 =?us-ascii?Q?fPz8nDxhELJTkoDn+nXsyHRj7vOneCGzuxh2WuCdIvQAG5qsELrDMvfFVOuc?=
 =?us-ascii?Q?cq8nGdHGKjOeYKKcH6GjX6pR/FJQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950d61ec-0455-4c92-7589-08df15a3674f
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8140.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:39:26.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6965

Currently, only MT7622 and MT798x SoCs support WED features. They
are all ARM64 platforms. And it is unlikely that MediaTek will
release a new net chip based on ARM32 architecture in the future.

Fixes: 804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/net/ethernet/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index 2ba361f8ce7d..7737f2f15478 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -8,7 +8,7 @@ config NET_VENDOR_MEDIATEK
 if NET_VENDOR_MEDIATEK
 
 config NET_MEDIATEK_SOC_WED
-	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	def_bool NET_MEDIATEK_SOC != n
 
 config NET_MEDIATEK_SOC
-- 
2.53.0

