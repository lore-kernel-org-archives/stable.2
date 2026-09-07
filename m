Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010022.outbound.protection.outlook.com [52.103.32.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86803A3E88;
	Mon,  7 Sep 2026 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767533; cv=fail; b=NpNf4qFy+VEmFziKR2mCeWXZ4GVQoyGbQktbzvVqbPul+zrd4FKhkd7ESeN6M3bXD/e9GV4wGu7H/YvVxRgpeaV5AfUXdhAOx50AGq+vDnbyKZIpDAl0Sh/0zyG7XQGdGOHYxf0Vxs5IouLSoWbVMwiJ9542jG9mhz86pVJskXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767533; c=relaxed/simple;
	bh=Z/aosXQjlGofo2zsLKEB6qRozh9LcIl+mX8m1UCht+o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CJvgyFtI8Z7I+CRJPtn5HeQkp6a5BgyOq+1RYpkeVeu997gD57Urr7NI9+okx+yvjX94VrUR8lgG8cPH5I7zyMQlcV+R7uZV/Gab1sCzcOoaHJwVyl60col/ACabqaUF+qD3iJ5aYIUQjx3OIHBjsBW3KcJrZQnQlZroHCqGqVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=HjE4zl0v; arc=fail smtp.client-ip=52.103.32.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="HjE4zl0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqSX+nXKqWeUsxEkgWbhJ0CpaCbx2YlVdZP4eNmVYXG6/2BJd/lc5alJhoVj+z9TDEpWWn9BzLlYUM29k+4LEHvpRrBWN6fvek4kOF30GQ43Cew8XiucPGzXVkgF4kkahCtICN3vZa3CgFZFTAxCYbpGoSqdIuin+ORCgEsAcNFi3Xx5gRM3higHOrGvxpWFe/46oFFiBO0J2LhXQ5drNM2cO9RDjhCepxN3+w2JljVfWM/YvCNB+AXDjS1RmbLoxFxeRWtQmuM9guqpQVlQybhgQptrSFzZAWZdTa4o2v8yGayoDRGB8gyZUHUKIVJNwBixeXRKX/NDLBKiJCW31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaSp2gGLNlcFjqovYph1kRNdbHR2kF+LLSaNpPiIWD8=;
 b=Bg7+0y9S81CP+axNoempbXPPxKVL7H//VE1uc45D24cLSBXpxL1veijQwESF+F/ENsGe5iRMggwe+Rh5JKcg1mfixEEEuNgkaB+jvZiZUJJeZqEUE29/SLGO6VT4HXJbtn/PaYA60ZRE/HOo6nubCj9SrQckL78f7kABM/TsxSj2D4hlCb3MztwafL9qBKs+AT/WgohRX5e/+5NUCukpuqx/ecz8/EZuAdejxgGE6UoYSu82NT/DYh7qrnIA2HqGrXL5ms9/6PIFbYulkNwRJqK2Yt1Sm84MULBdnalBFokfjKHbGoTJq3JuHJ0woxrNe2TMvuyJi3f/nM6VSriPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaSp2gGLNlcFjqovYph1kRNdbHR2kF+LLSaNpPiIWD8=;
 b=HjE4zl0vbnRTAaIJgKOfpsTQWSArHLhMvES8CHg9LUb7KZIMCmFuf0IZq7kCbqyRoon0mNfV42nP8bim5jn2HRSKr8ELLcBSsOuX8nN4rbdWF6V1QlEctRUKr4uxXBAdQF1AbL7tFuS+cSbN7vtkvOiHG/9gDBqpuAcwleblSPZPFfkXqvxf9kT81eCWjZeNmUfvLvBdHb5SAkSArdNQnE7Wgg8woFikXYyknF23fwQdHCCF4Wv5KuVvBr74aYe1XBg3BVpoG1xbEw93iSSx/3vtWsV/bol4Vek0xA5mhAS09r7VAkElEDJNgDeo/vDS2BnIPnlyB1q+CV6yPVjTPA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV2PPF0D7E1E584.EURP251.PROD.OUTLOOK.COM (2603:10a6:158:401::b49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 07:52:09 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:52:08 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Peter Korsgaard <peter@korsgaard.com>,
	Dean Jenkins <Dean_Jenkins@mentor.com>,
	John Stultz <jstultz@google.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] net: usb: asix: fix off-by-one in rx_fixup bounds check
Date: Mon,  7 Sep 2026 07:52:05 +0000
Message-ID:
 <AS8P251MB00014BB4591CE6011152DB4FC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0196.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::6) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907075205.596373-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV2PPF0D7E1E584:EE_
X-MS-Office365-Filtering-Correlation-Id: 44044529-de47-42b5-0907-08df0cb4eae9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|23021999003|25031999004|37011999003|12121999013|2604032031799003|51005399006|8060799015|19110799012|15080799012|5072599009|5062599005|25010399006|4140399003|40105399003|2607281247196008|440099028|3412199025|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?octt69tlfNiCYIwz0/vTuvbXsd9x/mRSGk3sMRE+hMYVU5I5yPwD2CWQWfVx?=
 =?us-ascii?Q?s4DqPcsh/oYc2EFDWkG/yBGQUUrEFGqj4eW19UzzY4goi8PiHMoRByONMhkD?=
 =?us-ascii?Q?Qd2737XPT+mHOE7GDZfDDq7BN/qoFJKFDuCTZQpSUvMtV6c9iY6sAJ/bG/Nb?=
 =?us-ascii?Q?Ke5RhPmOF+KAUJTLcDlbiu99CtQ0mF176V0kmHdRQmzSDN2rFWHtS/ZqxQgr?=
 =?us-ascii?Q?vpjSengG5aP2bA1M8sWQrQAaNPJ/ODQBBWO6mRDZ5LUOrHMd8gbmpcTJOsdH?=
 =?us-ascii?Q?zEUWmd6PvOl9qIon4rn6feUAZXbyr/QDeOdYeSni663IRAPf0mdq2Zurhiaa?=
 =?us-ascii?Q?Qf643UZOiKOL12zDLwO3ygntN6SbE8eLHNVUlYdJNxKkHVk+dB7covLnsa85?=
 =?us-ascii?Q?GOHrkDZ5GCOWXyvq+auLQ+vdt/CavheodzvdFBcFYgW5y6uN25qHAXx69rIA?=
 =?us-ascii?Q?+Wg5xCnqYJPOY4gEcwrVbC2cHir/rU1jh4mLUutvoPEbowsuAxMJ0gL/bKPO?=
 =?us-ascii?Q?rClJKvOGjiYVYNUzcFFN1/KvKIURVnc3xNyV27bWDNUPVDtclbEU+6Ux095G?=
 =?us-ascii?Q?MnwOa79prRd6qi2fDahaDMyvf2qszCAEP1wfhCR0XkMZyEY23ak268fAldm4?=
 =?us-ascii?Q?1Xd8bowdWq70nYXlkqaXNG5E2hhVS4xRkSRskRQHfE3eQy5s5jbfHCjltnKL?=
 =?us-ascii?Q?AWRKibbvnyzkHYFh29kyWyjRLsWZgIIH8kAew19oRfBflY/5lNb3oD0LZosZ?=
 =?us-ascii?Q?CWjoFgoirkzroO3AosLosecNSbWuYGYDsvNGrF5AsVuosveC80LPTn73cjfx?=
 =?us-ascii?Q?ELAR1Tvc35p1QaXvMgRhQfMuik2tzgZvb6PwFIraJAghusKSgVxJ95A1kc0+?=
 =?us-ascii?Q?McwSULL+Gl824c8aDtZwTr53TjdkrSAUL4qJMz/3hgAqjYs0JMm2lUXCJNQQ?=
 =?us-ascii?Q?1LuT2oMQqdGFGvAdE78CSndQHRKTonIvYwYaarX0i4ng+w+5OWgzDQn78hJi?=
 =?us-ascii?Q?qc3CsoQ+QQmzBjqCWhlkEFGV/Zt/+GzAvCsRB1sV1zBcCdraZ9J14XWK3mVc?=
 =?us-ascii?Q?a076ZklH78co23s9+ZGZla/1+aF/zbln9l5MMv7vO8h+hx/wbo76ossTLJof?=
 =?us-ascii?Q?b4fEN20qXYd/G/Sa6PQ5fH3mPBZ8r4l15I4peCcDY8RC6QM5Lu0Sn8U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DwFkAqUoDTkm8PvLtlrbjk1mB8ziBNWKgmBCySdSTyFZyekbcQaVoZPnLaGJ?=
 =?us-ascii?Q?B2TwAHpWe/g8nGQcP/Ia/sYz2fgygKV9gWcNtt1iG9hMBdJadk9j+eAS/9me?=
 =?us-ascii?Q?KsqoCYuitdqqBlt4ij30XaqWBigQ5kK33udVWpNr7lXzsqJ9+VeRLbZ1OmNW?=
 =?us-ascii?Q?/u21l7QiNGyfAt7emjgdcwdsawMO+Pj/Kw2MXDewFvSfhvUa/ujQ2CUGV3Co?=
 =?us-ascii?Q?jyso4/0kA4UmlrPfPwg+4IRSwIUrEfIAlblzZFbU9qkAgqnBn7JEgiH8JX5L?=
 =?us-ascii?Q?tHFYXqIc7l/xirgSJnxBlilio544PF5U95hz4CCrLlhjxjXTlzn5KmyiY3a/?=
 =?us-ascii?Q?X9IEC5ulUMIK9pQuSKDsV/w21bqBfbU2ifgfDxPz52ySd6+77wBhZraFysxn?=
 =?us-ascii?Q?VxDC05ssZXfEaH4o7BFX+rglKbuyjElHtlHG77/QkgB0bi1hmcf0lrxAYc8d?=
 =?us-ascii?Q?xnazHaxDRLtw1yhVu9T4aOf0M47e6sp5ihpg0XAv0/aQrPahTYiPKpYsJrLq?=
 =?us-ascii?Q?gtYKwBef+hOdgma7lE23gQCN65IDwg6hvOTGs4oTSuKeiHvFRGqm0tcZLulA?=
 =?us-ascii?Q?KcxnngwaqoMfjXg6b4PJ6VnDifA4KaIHLCi+gyYHreppkWjOApwTYDb4rBxu?=
 =?us-ascii?Q?4RPsot8yFwS6l52ZuCZ7Fb1fIfE2+KfRPCVP1feb16L+r9n+pD1SmzOD/5Ti?=
 =?us-ascii?Q?wYl3XtTuEVgegTUhvjXTzrtqQdoSNfr8dCqQykgGJLMH/MOHR3IeHt3Jwf/8?=
 =?us-ascii?Q?Yfyb7Ahbo7hwX78cKF6bkgH4SbRPYNUpqYbtOJCwmkGMVUS7m5VFEClsik/N?=
 =?us-ascii?Q?QMcqLfHU6xt+zH3dcjFKVmyIGVcqj+LHa9QHGC5aCWwMThc1bnLReAiDz8cm?=
 =?us-ascii?Q?JvvRSzwv8kGtuX24SPpRelR6TRUCKgp44pX0efBwJp2cgXLSrBSs93WNJuN8?=
 =?us-ascii?Q?IoWotq5qIfWtv4wUE2Vt9U0V8fgihVxcbzWByp/niKT2XFgeb/QRSTOpXVlK?=
 =?us-ascii?Q?U5i6fJO0QFUfsc3HwCqn1knUY4fApNn6uy3R6k+mOH0cuFfg8e751ZLK1E3h?=
 =?us-ascii?Q?snkrUGA/BpT6rSudX3rBzxgcFj9CIW6Du/cRAvBKNslHGHsHS5UqJ1CpXQv9?=
 =?us-ascii?Q?qS0cYVDWCKbEaORKcpl9MbzfmRcp9ubOPbxRGTSpDBB1v6ca94RoYY21NDA+?=
 =?us-ascii?Q?c+X9MAMZEmgs2tWvqFcbC8I3EF0KdKJf9I2+i13MuVBlWbZ8QfLaUlCjafI1?=
 =?us-ascii?Q?oCvDqfM2W+4yest2vHU66vrac7RANMjgPi2yOfyn9ynOi7GCdSa5CgUteAIN?=
 =?us-ascii?Q?Ri10kQAy94CTJHvA25XfHwPnAmN8B4oho5BpWMNwlKGQTvGYUijn/deauPuz?=
 =?us-ascii?Q?HdIa+rE7hyKR4NkWbxSRQijKOF+Xv7iGHj+tlqKCfJfo7a70dDd0lHywUFMK?=
 =?us-ascii?Q?HchkKB8w0uIP316dqK6/q9TGo/5BhwnL?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 44044529-de47-42b5-0907-08df0cb4eae9
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:52:08.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF0D7E1E584

The sync check in asix_rx_fixup_internal() validates:

  rx->remaining + sizeof(u32) <= skb->len

then reads at:

  offset = ((rx->remaining + 1) & 0xfffe);
  rx->header = get_unaligned_le32(skb->data + offset);

When rx->remaining is odd, the alignment rounding makes offset larger
than rx->remaining. For example with rx->remaining=3 and skb->len=7:
check passes (3+4<=7) but offset becomes ((3+1)&0xfffe)=4, and the
4-byte read at offset 4 needs 8 bytes total, causing a 1-byte
heap OOB read.

Fix the bounds check to use the actual aligned offset that will be
used for the read.

Fixes: 3f30b158eba5 ("asix: On RX avoid creating bad Ethernet frames")
Cc: stable@vger.kernel.org
Assisted-by: Claude (Anthropic)
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/usb/asix_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 4f03f4e57655d..c50646ea35c7e 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -148,7 +148,7 @@ int asix_rx_fixup_internal(struct usbnet *dev, struct sk_buff *skb,
 	 * Also avoid unnecessarily discarding a good current netdev socket
 	 * buffer.
 	 */
-	if (rx->remaining && (rx->remaining + sizeof(u32) <= skb->len)) {
+	if (rx->remaining && (((rx->remaining + 1) & 0xfffe) + sizeof(u32) <= skb->len)) {
 		offset = ((rx->remaining + 1) & 0xfffe);
 		rx->header = get_unaligned_le32(skb->data + offset);
 		offset = 0;
-- 
2.43.0

