Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013081.outbound.protection.outlook.com [52.103.33.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376533537C8;
	Mon,  7 Sep 2026 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788771652; cv=fail; b=DBU7dGtPu6Hp3kVO8g15aJu1fvHSr91A0K+maXdM4jjMF284ynxRLHVFhANGaHlB3ejUDqP+KWw/SeS6i/Bw87kj/kJGUFMK880oDBP5HKdJV+2+nj5udsHnfG6VRnrptiP3pNPzvHGUMh6bcyqtlUwE/ImQc7yOrbJbG2FBh1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788771652; c=relaxed/simple;
	bh=nN/HkifnOUI5iCtFEmHtzHVFSsmxsXN4R5dOm4sIRjU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wbm0V+2/kAr/SDfUS/5TmGp2nW19lgjbVlwnAz8QIsGx4SC99wRK0bTjpbR8S3GnpA4u2ijuz78Ixrx9Aw3HylreER07XDOgHKxcpBYXh+MQ5F1Um+RcoKPSTAEBH+2IXc/ApUsFoknkT0sTnkxKJVHBs7fhjiGYmIOOgMTWLGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=X/FkSa10; arc=fail smtp.client-ip=52.103.33.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="X/FkSa10"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYvsjto+qbnBxAWWbMzcoffJQq+ep6IG8wGUpx/Gnb1YCuUGX+F4Zz4U9ssyVVapCjB0ZkEuzIlID9CdWWSMoSolu9PAJOKsDW9ikcC1MIz/+JF3REMhn/HOcjPzAhhZuBI1bM0SkiIwM6xz557q3ZzuTTnWVjKfWS1v86vJXAgnhZADUWA+JF0hS425a2Piqe+RzX4m03plWVP5HYwEtuSpENLkd0xBULU3WqbnDu7H2e8RSlgGgutZsOQIHh+DE2EamfOyneH2aDBEACU+R0uFBfJQZ5jOoKOsCR0hV7QTwhquqSg62UyS0HuusDdi4x/C+WuGnlLwmKuJlSPsSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LREua/zl4h+1727b+KTmu7UFdfu/s3OdC0zba5X84YQ=;
 b=GsVljbz1B5GjoxZEmW9WKj9kzB0Gomd3qltLUkZ/o8Zhs9yZo6FYBvHikxR204yq2niWltQ7M6mljbz1O4E1sUuwihUm1SOzQXUUZ+a1KMnmeZiNQ7G13iEgy04yXvp+9j0SEu1meJLGhSiH6lNQxwRmcjYvswGuOd/fl6eDrcJnMZV924wmleW0zhKOOr3mMvgAV/qAFVAdBSaUJoL0IEd+SNwdw54TZmyVFigQwKRHD/ltKSbiIaVCPV52biUkD2r0e46Ui4nEJhYBL9BslX15obiy3Onv4dBwUJl6CAR66lyqr9yZil4+Htz8DE7EyjUa7+2alonK9IxorcRI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LREua/zl4h+1727b+KTmu7UFdfu/s3OdC0zba5X84YQ=;
 b=X/FkSa10L4TzkMFdQYWd4iVNsc6Sp1jxbEmseKOSCObXqjh0nftEv7QHUatShlIxW1fwQqcYg7phTUr9lvNAN9uDhpfxcxB3cRkQS+8Fnz+ReisXbL5yTO7GY5nezS2mDyiGfT568Kq7CgqKgG/0/X+TNi3VTVvAJz4BRohwgNr6fveH/F88BgdRnCJHV2BjJ+zF3lGaKS3AicEJs/fhOkFWxKNW5QsCYExknwtrJr/jAPvDlXptjhRL3PIUlBIxCl5E+4l2nIXuO8MTw0uPygnBess8ixi0XwTCpvikmrYEF6O6EKc5lkYNobwxHbnLe1+mxP3TrcX+DnMj9a+3NQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GVXP251MB0766.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:00:43 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 09:00:43 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: validate TLV length in mt7996_mcu_ie_countdown()
Date: Mon,  7 Sep 2026 09:00:39 +0000
Message-ID:
 <AS8P251MB0001CCE8D1BEE1F330D9E57AC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907090039.617311-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GVXP251MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ac7c52-6cd8-493d-b7a8-08df0cbe7fb1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|5062599005|5072599009|4140399003|25010399006|25031999004|15080799012|19110799012|23021999003|2604032031799003|16041099003|55001999006|24021099003|37011999003|440099028|3412199025|26104999009|40105399003|53005399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ENyVKO3Ha8Ojy8wqaNmdT3pvUnZSDK41g/lzgT0axEx5kgoeochQpjxq1KJv?=
 =?us-ascii?Q?1AqWoBBDM/rVn6kegVmcravUbRAupYFXrEm5YFWbSO/vyzK3+0FxJqIjt1yr?=
 =?us-ascii?Q?zg0TwjWlNVNLAwBCKVh6iBRtsjBE2YPkl6ZrHknOoQo90AQlDwQqUXQKX9qN?=
 =?us-ascii?Q?SgZRUqc1CSid/Lv+Bq3Rtm7VMeX3Adn51GKuce8mg4+W1xpYn5rtpLezlkK1?=
 =?us-ascii?Q?YA5GjjdH7roR2DrYqppV2lQzR2kWGIuiNgdmntgCg5uKRyUnswwbVyCk72Ts?=
 =?us-ascii?Q?CO+ubdpkfCsfDLeegthNkbEIYUefd7Y9SP7WLS22DhH/Ou1PxPiHlDGwOq1k?=
 =?us-ascii?Q?w1OQjkmcd2iHHAK9d3NLtJvr1u3a5RQLGhywVMevJvo7v3Dhm9O3jBxWcLHl?=
 =?us-ascii?Q?E1Yl0S5kyThsZ50wzN7V5TWB7ptxjbRd4gG6n8IUVge194cflq1iGwjqUf8j?=
 =?us-ascii?Q?E/ZVRlYsPrh2zQbNSme4V5BqOWBiJcijOuJNNqjRitdXfBVoKLWIjJKZSp5Q?=
 =?us-ascii?Q?+Muckzy6PgmvpomUupkgbgREvisanmPaCn5PuzyodcOd5Jlg0tTqPZCuPl5P?=
 =?us-ascii?Q?x2t/7jOEyJXdZhhAkIS9BMWUtpOJ2EL+V+CuNJ396NvnxXKSvvO9jcR6QWgb?=
 =?us-ascii?Q?Wlq7oUOsUQTmjAtRg1GEsumZ6SMEg8DrHUTgkSOrBOtjpSCgVg266z1VBDk7?=
 =?us-ascii?Q?94Y/W1/BhTNgpiWY4HB383JXbnLCC+Kadm3hDnIaJKd05eU3tCtd5+tHR0zv?=
 =?us-ascii?Q?Sybov0lWnbCGl1D1IvtBNGSFcMCA4fMslqNbKb9QOBs/n7D/5sL4D+gdD3C6?=
 =?us-ascii?Q?pwN1gFFmv39Wdfypa4PzFVhzzJqU45trxjQu3yAe+8mHRk7+fEfOKXqx5sT+?=
 =?us-ascii?Q?ILLCiQ1YSwLY6Uk8rcDAbmtWVRk9NYNeztVObozfoRXzox88Ues5aHCQNkeY?=
 =?us-ascii?Q?cjaiECKQSTP9WL3Ye87+sEYLGwjem0aGX1MN4lxZ9Qhd7SA5nJTevlOnVns1?=
 =?us-ascii?Q?PxTnJ5juPEWqDYYbw4dh9ScpT/Fg69ziOWi2V/0A+5C5b1wDA9P2+we2J9Yl?=
 =?us-ascii?Q?FmyOi6cNgMjwc6g8uyTjQf0VIhzYxXux/D+t1iwEILT2RunFEaK14eBFrYeR?=
 =?us-ascii?Q?W8AoKXm5rrATd7OoobX60aAvTKq4NjJcvg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6Pa0r40BVhw4oA8K58lfjGHZ6Jlct93fCNhrOs1ROh1s1C//fYdmXY/xFy1?=
 =?us-ascii?Q?9jTCCk/L29HfTMd1Q/+X8LRocm6TeCrj5J8MBk9nSPHtG5utycRdPgKZ2xIZ?=
 =?us-ascii?Q?WD57Pl6QeBpcmgXF0JXdM7Q0wSVbjB1nNJFcO5cNzChUr1yG/m8yoB9jBRem?=
 =?us-ascii?Q?rEubxj/MTF+/r/pYSpSr4hMyGK6Jet2WXyTA4jw61fBkGCwF38kD/AVxpgKy?=
 =?us-ascii?Q?9k3MuQFwwILWR2uy/Y9jhuv5JqTYz87jNZqGMrJkH0ZFXm7RwY3yxJs+qgdV?=
 =?us-ascii?Q?0gSS9KO/O/1RBBcmIK748tc9HEQgHPToQ0kls8oSfqc+er65x/ugm/73VBZ3?=
 =?us-ascii?Q?/pgKd4nUhLw37+D1D2z6FSisqYUqhhB8HnS+hCs7mt11sah3/BiUG9wRXYWX?=
 =?us-ascii?Q?1wz+xJi1SE4eCf3ehzbDjJpKO0eVJHAJhW7XCNWZo6YIotqB2MOdkphbAYZH?=
 =?us-ascii?Q?gfrHhCUad5D9YAgW4cUb/OfNzopoA0mQMWsPYWU+CbZeBkfmTLSxt/GrdCJL?=
 =?us-ascii?Q?XLT/i6zTdN2vr/zStmj867GQVBID4O86HFinunAn/qlgdfgAkUPRUfa4Zrrn?=
 =?us-ascii?Q?itnablZlLENeXo6EUtvgfQnmxi5euktJvoVaNlMCFxb1OWP0hkyFtZhKxlRZ?=
 =?us-ascii?Q?GpHHwJH/DU1z5Tg7NPN3usFvsXztbXv1H1qpZXg0aofPfCIzVhgYFSHpWP0m?=
 =?us-ascii?Q?AQ0bhhs0WqprPt3Y9r+NguEI3UOehESoB2c2YTuu4vJxa3pvl1digF2aAQJA?=
 =?us-ascii?Q?k8pEBxp3Z3EwjReyUpU5hGM3M6qgLOpoDjULK37vUgwTVv6sDcgeinmrk5TY?=
 =?us-ascii?Q?7gnAPZFRtDBX3+1bYAz3ZooMcUuvS83hOjn2sFp1Pf7rb1Ejrf71LopXjvJJ?=
 =?us-ascii?Q?tc117Ej81YCcnr7AzBnmoV4puk3sWu443cuBY+KJq2PFBtoVbXczA4Iar3lu?=
 =?us-ascii?Q?LzSd2YOwk77qZuiUv8u5lOc5XCxVTUEWf8VLEEyU+aFvkNVNQ0CTT32Z5xjs?=
 =?us-ascii?Q?cuSYp3MFyLPjQskZu8AAN+/xqqFVBIezGaW7r2WwbahhSHhaGAvjaluEiz/b?=
 =?us-ascii?Q?25vXX5WSbQiMFWGroKlzXYyuYwbvBG+x3WrwgbCDjJzBHy5HsLbyHLpdrcN8?=
 =?us-ascii?Q?A0bCMosQgwvK4M22+rq/UltqykEX++ODNFo6HiLtV4YWzEfSf2Otw9OtPbZx?=
 =?us-ascii?Q?nPabNts1pscP3K39Jxwe1ctkX0A6IcjCRaAVGfbBgMsQcOc9m4MaKJi37zzp?=
 =?us-ascii?Q?sOiTXeAAJrB6bivU6MwJ7DcvqdCQnykRaxcclpFtlo40zGX3NjpPOX3LXYvf?=
 =?us-ascii?Q?SG/BiQoEbidirXPHg2KZW9t3jEywtUASKa2HS4jdhd2q9PjAOrI7fzFN8kTf?=
 =?us-ascii?Q?GABOoaK6a6XACCS2IJxo59T1lYkN768cgXpCZDb7HrFB9pi9gdyCJa2IQ1BE?=
 =?us-ascii?Q?S2vYAVuZPCljzofFOQ45JFLZSro9zwBy?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ac7c52-6cd8-493d-b7a8-08df0cbe7fb1
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 09:00:43.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP251MB0766

mt7996_mcu_ie_countdown() iterates over TLV entries in the countdown
event but only checks for a non-zero tlv->len.  A malformed event with
a TLV length smaller than the 4-byte TLV header advances the cursor by
less than a header size, causing misaligned reads on subsequent
iterations.  A TLV whose declared length exceeds the remaining buffer
is also not caught, so the cursor can overshoot the end.

This is the same class of bug fixed for mt7925 in
commit fc7801b7f11d ("wifi: mt76: mt7925: fix infinite loop in UNI
event TLV parsing").

Fix by validating that each TLV length is at least sizeof(*tlv) and
does not exceed the remaining buffer, and that it is large enough to
contain the countdown notify payload before dereferencing.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Assisted-by: Claude (Anthropic)
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index cd7587ce5b8a6..f74c4b0bda3c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -497,10 +497,18 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
 
 	tail = skb->data + skb->len;
 	data += sizeof(*hdr);
-	while (data + sizeof(*tlv) < tail && le16_to_cpu(tlv->len)) {
+	while (data + sizeof(*tlv) <= tail) {
+		u16 tag_len = le16_to_cpu(tlv->len);
+
+		if (tag_len < sizeof(*tlv) || data + tag_len > tail)
+			break;
+
 		event = (struct mt7996_mcu_countdown_notify *)tlv->data;
 
-		cdata.omac_idx = event->omac_idx;
+		if (tag_len >= sizeof(*tlv) + sizeof(*event))
+			cdata.omac_idx = event->omac_idx;
+		else
+			break;
 
 		switch (le16_to_cpu(tlv->tag)) {
 		case UNI_EVENT_IE_COUNTDOWN_CSA:
@@ -517,7 +525,7 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
 			break;
 		}
 
-		data += le16_to_cpu(tlv->len);
+		data += tag_len;
 		tlv = (struct tlv *)data;
 	}
 }
-- 
2.43.0

