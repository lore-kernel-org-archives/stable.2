Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011029.outbound.protection.outlook.com [52.103.32.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40300366546;
	Sun,  6 Sep 2026 23:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737821; cv=fail; b=JuxqWb7hMqEaGa1HqZEYhiWBkSHtzWG/S0MRRLnqBhLiraYz+3/Z9xBg3VbkQl6qA0uLQSrd7WWblBx8/O35NNYI1pv1b+IJ52iQ8pBWDOLcJNBlISuU/2bJZVLsoHJO+QtDU5Iff5DlUSTDGe37+jbTb9feT4wb730mb5Ah5HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737821; c=relaxed/simple;
	bh=4AJcHqt3VonKZqH+4RUEuNc/EDWcMcJy2iPljTXz6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DgQPnCZvwxA+1xQXBGeYHAX2NfZZnRe3ggM57pttHsb2TJ2/bEdjxLnfxAEhC8rwQ9WKQx5+d3rHEZMd2v7xz9jeTaMevZ9u92Y/ILeypUK2hFbwnITJV2lWiPYgdzcPd5W3j/7lK7HOjhBcrB4TFR17Ht+ei6sdCTxqLXqTLO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=DQbqzYQf; arc=fail smtp.client-ip=52.103.32.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="DQbqzYQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4gbr+au75RPfPxS205Wn2ZrZ3aLZsDGbtGwtDz1cMAUHoLw/4xaMBp2XeLlv7c5nHiHd3pOmwEVuLkP7DhoLI14BRPR+yMglSsHCpDup0S5TL1SmfClOnHtyJKjggno5UBf7a03kWIONePFoXF7hIo0kvaKJavkOlCK8rlkgj2tf0ipwAJm2j3TUr0GJ7IT8S42ZsUQUcnthigWVhW67WnacVQITT8E8ONhDu5VBLK///d9MAXv0VRcaFPl66mfZeJa7WpP+RiU0fITNvK/VJVi2xPsmEwE2XPNPuho+v0/M868+TPUMf89ad7W3DKqOY8/T9zW1i6dcQXxxqdqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev8gbeuZKsEJ/gis2er2YJHgMzFWJ5Nno+Cq+rD/oBc=;
 b=PhPVAS3PzfRUxatzCFpF1pIIw53GtX0/FDaftbz5N1NxgJcoHzAGm48iBRvIPyPxuRVHspcfK4jMjGiQBzh8mt0T/otORjXyMTS1etxdUIMPZ6FoMhAyOh3g3iEj2aqUn3tkwElJHOn8CwP+d+HIDAajwCpRBzngPDbGe7sZ8+cTReJuQDpYi0am/2HQMs0ECxj0cqu7LQl2h0boMxAi0oTkoNeWnt1HyT3g7o7pMk35QtZaK5BASJmvapkFl55aOyTq9tBbaan1P+s1ENxpVDjz3YPoloiaITGizjtJojIYMOtRODpiLrAb3aOsCtPeH4aCguAc9VzVz/T7mxvAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev8gbeuZKsEJ/gis2er2YJHgMzFWJ5Nno+Cq+rD/oBc=;
 b=DQbqzYQf5tMGXFipG8m99suNhJfioEK+eSLoPIWq/GgL5JfLMV64lRhTCJeSdGXjfGuJdU2XPL7WI4XJIDGgXxcIBbjnbVcjcCHqiXmZfyry/mt1zis7oj8hMY4HAFzNWjYYXC+mWMUJFftSy78Oyd2ukSyaA7GZL43CsBI4jMy5ytYNcZ0vWyeYtwBkYw64bgBK1M/MF5ZJhT6gKBSEvZ4J+2TiukJho0fKsw/yLV2pef4zXtvrZv59U23r+6fnGRtkQTD7eJjAFIZ3K9m+tnOzRzSdBkmS7SADHGWzhrfFYUk4fu93jVof7V1WBnoLHHKbso/hK9VoOFR3QqEKWg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:36:58 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:36:58 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>
Cc: linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nfc: digital: check DEP_REQ length before reading DID byte
Date: Mon,  7 Sep 2026 00:36:54 +0100
Message-ID:
 <AS8P251MB000196084524EB27D62162B8C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0129.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::8) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233654.87695-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: aef30c1c-c16c-4a72-3c31-08df0c6fbe12
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|15080799012|25010399006|51005399006|23021999003|25031999004|37011999003|19110799012|8060799015|41001999006|12121999013|440099028|3412199025|26104999009|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ag+Ybh644lErJAgf9Al1oHFk5dpDF2kZQ6AW+CJQcNpcevdXFc0FyVV72Km?=
 =?us-ascii?Q?2JmY9yCpVP2pS9AFhqxZIgCqfAcG2Mf2uk/NuoRveLH5dN3IZZjjdrqtR/Vw?=
 =?us-ascii?Q?RR9gl4zmOHObOMzLmdQ1NF2FJDwAYmCtq7PSAQuQa0chL6TnzuIqDDbcAnzQ?=
 =?us-ascii?Q?uUQmf2qhpcJYAvPdx5SF/DP9R3SYbfOe2JN7P0+cJbV5zNmwY0xFICkXvM/N?=
 =?us-ascii?Q?tP1OgHbTSu5qXLSxPKmGHTzjli+w0n15FLgvqcqXm7F6xn6C0SDuMbWaq5pk?=
 =?us-ascii?Q?2CyhoQAte7EdvuDkpd/OemVVGVzjOnVU16MlFuAgcd864Fj57ZFaeWqf2QBP?=
 =?us-ascii?Q?fjpa8msZ7xfqwuEaw66Wba/yTC+8tNMtzQY786mz1iThhulfZrGLczsNQ2Fc?=
 =?us-ascii?Q?4nEpS79Fs9AS6UhDHwn5KjJYckcXBqTShqvPYmVAohMfZDa2PjUgTkNNJkc0?=
 =?us-ascii?Q?lPI1TJJbZFTAx/3zbnqotSKWZwRNYWCrUb7bIUanTB2fs4Ie19PuFpXC50O5?=
 =?us-ascii?Q?ZiYy8DNlTTNtXk9cGbOxmxYEBCyLMWP+TBsHQuyT4iLKg8+VosvYwFU0p1Ev?=
 =?us-ascii?Q?tG4gxsgpOrQ2LeCDMroswVUHHBJ+QSbNtF8Zj8sYltn9Xd/qcI7gTGpE+oBs?=
 =?us-ascii?Q?oNByiXKlVwVxxh5mMhbRxc6Uc3AG4O9g/wZneUUA5WbwinNz5fESFwY+7Li0?=
 =?us-ascii?Q?5+HwkhKRSiYwVHeb7qVR82r79QFt0kn3FIsO0SKHFubD/TxaBrepeC2XScCz?=
 =?us-ascii?Q?V57ZKmVzHEc1JUeghPJfewXE4YF7aqt1SpyfyqGiWslRy66ECfo17SfoZrRg?=
 =?us-ascii?Q?9HPL83MPx5Oc+haeyw9qpX5rbfhEuS846WVZ5yJfJ4sXAOh5WltjBiATnd1U?=
 =?us-ascii?Q?fWIC73Z7IiA6XN/teBcycSEfz9soh98c+gKGgJbsdKo0SFgdDUO3YfGpHxKM?=
 =?us-ascii?Q?VW3JxUiSJQGqAdCCNkRUvOUhkDXz8/avIcjaNksHZhhzFkuwN6s529beRxNf?=
 =?us-ascii?Q?7hidoZC4PP9lDBJqdMmMVhMtLurmJqWfGbjJIwAO32Oi/vOdFTZsBL6bM2Dk?=
 =?us-ascii?Q?7Hfa40Ijh7/eYg2Ik7+wKwkPLsfgdEmanx02ZsY5KDheLd57bh5suvDIAxO9?=
 =?us-ascii?Q?dtod5TTyrjNZ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bS0sII7hWph0ka761Z6MdbmiQpWrnS2E1FdooaqAxCQeHxvbJ1rvbr8yJtKI?=
 =?us-ascii?Q?gcOf0nPTp38IM4KYOwvk+l4GvM+6rFhuLffvpubUR3aa7+8ez99opHCnVU9E?=
 =?us-ascii?Q?DdTNG+iLLx1TPJcAO7R4U/03Ur5QX7VWhemw1wjAOkZ2EkiInLPqyppXAMya?=
 =?us-ascii?Q?jHrUgKZx283WgRds4lRBDMJefsURiT8/o4yLSxDNWV0yrixvwrjL8lIAgd2z?=
 =?us-ascii?Q?PH9ICRwLzn+LlM/HjIjReu0ROhELy+bisPu0qcPs3PPojbivcFEAFYw7XSl6?=
 =?us-ascii?Q?C8C7myhRb9Bi1iuQdtH/jHs9dCenEUoO8/hJZli7vcAuCvh5EjzCmxzBaUX/?=
 =?us-ascii?Q?lk16kz9xNfmBN1RGcE0o5p4Z/sIMddC37b7Nkv6ASWqDmZ4G3ggVvQLdj9Ji?=
 =?us-ascii?Q?z3X1skNmnwiNcyYXS/T7cJOHkIWYAZhvYqLD7O7we+ruO7KHZ8o6qFgRTZu2?=
 =?us-ascii?Q?H/xAzkw9pn42GywAHhbI4G1JrhkSsRIw45xK3fndUumfc45iAHTiM8LyfFgT?=
 =?us-ascii?Q?JEojtFJLTcXEXFH6eb8TUYmAG2994KllZ51xf1I4RcGMtOMcVqNHqj7ktgQc?=
 =?us-ascii?Q?9vr8yIN6IAaBk2tba9OdTf8yXduNeq3JkSlWKIOMpCsb+mW8Dc49c/L98vuz?=
 =?us-ascii?Q?BvF9gkHHczvgdX+tyaFMMX+oH2Hi/92H8KLKehWA7QElBCGvttEkFgzTfFXC?=
 =?us-ascii?Q?gS87hczclzlv17O90+utEePkszJtNQ5F6TuL5a4rmGOn1k4kCkMVYj9/rUov?=
 =?us-ascii?Q?i4WLEaLnI/+EBmcyZfp13M0CtDCDi9t71CZR67k1Yo2HWTcpB43x3Gori/S3?=
 =?us-ascii?Q?arPe+K5mL8/af44XE77Oz7CpojtLVpfPlg0vfaul1g5McJhJwsMdUQ/NKRmJ?=
 =?us-ascii?Q?NRwObx3h8HhMSZB2CRULQN0Wr6Y23f+uZLbgPlQr1FVHBgq7SAMOWIRvs+Sw?=
 =?us-ascii?Q?eqUuzUZ00jEuRW+E2tCq7r5ZS/TD3RHNh6NINZcGV/bCSIyuckVgZ++8rKEA?=
 =?us-ascii?Q?yAlhD+h/wwL/jPP4U631S06DusYs5j7S9rFjJyBLY4tN/UQbqfitDmW1TNC5?=
 =?us-ascii?Q?xlC4w5cPRKR5lcpdQ9479yOMdFT5I1PmXT/ohZviU1ZyVlVYEpTynwde9SDG?=
 =?us-ascii?Q?vOupJy0DDEcm/3fC7TJFC0TW0FT4aOCg0gf1q3kgvVm74N3xLObfh9vb/Tup?=
 =?us-ascii?Q?O+b7YRoHIG7cik8UBX6IBIJC4V/th5aYtLtDXK7mPZTSq6wm1f0nNT+PeOTD?=
 =?us-ascii?Q?czkQLYhqgau2eaw+AMVfuqGS+Lhk/7qNbaj8uSOOXNL51PMZJyNbEMoSg14o?=
 =?us-ascii?Q?3GdzlpTeEJAec2wDmSBw72LO0Wi4p66nShGU4aWyQZTLwF54On11uyX9+Eap?=
 =?us-ascii?Q?NTyhNxH4ZJFXMgoREGkem2kYNxLpmSJxY+QBPvGvincEimLwbSLicf81Bwkr?=
 =?us-ascii?Q?NM0DAzWeF7o6DLgyhC+EbmoEdsjMPaf/?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aef30c1c-c16c-4a72-3c31-08df0c6fbe12
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:36:58.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

digital_tg_recv_dep_req() reads resp->data[3] when the DID bit is set
in the PFB, but only sizeof(struct digital_dep_req_res) bytes (3) are
guaranteed by the preceding length check.  A crafted DEP_REQ that is
exactly 3 bytes long with the DID bit set causes an out-of-bounds read
past the valid skb data.

This read can happen on every DEP_REQ from a malicious NFC initiator
when the target device has a non-zero DID.  The stale byte is compared
against ddev->did, so in practice the mismatch causes an -EIO return,
but the read itself is undefined behavior and accesses data past the
buffer.

Reorder the condition so that the length check (resp->len < size + 1)
comes first and short-circuits before resp->data[size] is accessed.
The existing fallthrough to the later "size > resp->len" check is
preserved for the NAD case.

Fixes: 1c7a4c24fbfd ("NFC Digital: Add target NFC-DEP support")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 net/nfc/digital_dep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index 3982fa084737..ae5407fca12d 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1117,12 +1117,12 @@ static void digital_tg_recv_dep_req(struct nfc_digital_dev *ddev, void *arg,
 	pfb = dep_req->pfb;
 
 	if (DIGITAL_NFC_DEP_DID_BIT_SET(pfb)) {
-		if (ddev->did && (ddev->did == resp->data[3])) {
-			size++;
-		} else {
+		if (resp->len < size + 1 || !ddev->did ||
+		    ddev->did != resp->data[size]) {
 			rc = -EIO;
 			goto exit;
 		}
+		size++;
 	} else if (ddev->did) {
 		rc = -EIO;
 		goto exit;
-- 
2.43.0

