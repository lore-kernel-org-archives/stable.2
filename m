Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013074.outbound.protection.outlook.com [52.103.51.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3C418A5E;
	Mon,  7 Sep 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765942; cv=fail; b=T/bhJeO2BDRS7nFApQBFHjM4XPq5+dRAjKkh03I2bo+GhIOyVGUf2A6mVnjra9Uz9soAti4oaVsXqmlXgBU+Uu9WU6dVjRvpHky2aYVVRWcLBiReSrxu5WPzEnTMPUs6lHDamnfAybnYgfBwbCOGYgfW6M23PGRg6tdm+iNUXcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765942; c=relaxed/simple;
	bh=HYiGodGkK9xP7NFZCHsI/ZUD987RuwPEwWbhwu1WIDE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mwcl7E+bPwZ8FWkOgDfOnY46VA+BinwIzh9rOEDsuPxKu9jwQP9rtpu11WluWdf3ipSAXi2mP/sc9MxJmfqECS9j5tjXOFiJjt7woVn1nYUlGXEphN1CP5SzfagXvLQUpPSpdC044RHG2auKzqrSiDiQ4gvASbQFP+ncVuD8Ssk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Vf7cuEl1; arc=fail smtp.client-ip=52.103.51.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Vf7cuEl1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1aDLnEUc5PJQdeOaj4RBTeardKtwVqcUYggbvYTQlu+TvuTOXtv6+++ZwUgFdfV77/OAio9TwFUtzP5nsAAFc5pEl8WSbjIkbN/fufM4NJAyffSKkU3uugKeaOKIPRND4qEH0enxwbwEaaiprfOcCXM8aq8hpyjAHEWVBJtHyFmSOhqY5ID1W9FsvY7H9ghpYpX+SZYDsJcAvDyujb1y/TJAkJ1UUHYglRKf9S/MNVH+niNF5v/C9fWUI66e33Z/yr+s1NWDwm4gBZ7IiZQLwmBbsun/UmG5qn9Y3FI2/2a4psr3QvXPLOOEH0qg+bWbV4Joz14lEfQp5AQYCZF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGihvwGAIEuPP9LOZ/gNTyybVnfLzBjX8DWzkmKCHXE=;
 b=DCDP/JdfGwADjFou3bdoFYoAYqaECgB8L/bwnr9JymaJlwMa6dMkugQi1Mh4jWCxREN2M6MPRgbkv+LQYK4vfcKM6+rRkZkzUcAfwEdHv5UJ5QPVGkHocSBFoWqB9TgcDjk/5FXmFdElu4w39ff8bb0pSR6bnLyv3BMMJNXQxsVdeskm6k38AC4IRaOxH288EVnBJqTFyPhxxIibJbATTcHZfTT4RyEmxJQH5mVbWg8Lc+xITlqCAj3Ql/ggrBFaI7sP7OMiPP5pltpLqRowslk+OMx9Wm/UHbt/P8TT3BVnaAxKW8W/rN5Fijk2MfaxQVyZ7nCcMqNla1gAN83Ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGihvwGAIEuPP9LOZ/gNTyybVnfLzBjX8DWzkmKCHXE=;
 b=Vf7cuEl1xV7jaAwjc2ECvaMQHqztwmok45hncEUeKdX0zRmDKc/MA98A7VumChL0rbXc36vrpGrzwbn9GAHAAS3Poop6uG+uhBUCyxmQ0hSXxkEO7snVkkBMR1/1L0++jqsKFWXhgIn11egT/+xa4SQEwY6p0fn3Ss87ZQwatmDZp3Do2Nvp3yqyoK0VCG52ZFitBKny6016iwT7Rle9t6+iPgAJVzMq8SVqQl4B6gQU8skWJueoBqOASbGSI2DVxZaXAKdIu1Ii8wizB3sig6EQXPINXOFYGeX6ZnTBlsUXaJNuqr/JKfJMsC4CwEI/Rj4VPS2zbD5fzOaNcQSBKg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS8P251MB0136.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 07:25:38 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:25:38 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Peter Korsgaard <peter@korsgaard.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: catc: fix out-of-bounds read in catc_rx_done()
Date: Mon,  7 Sep 2026 07:25:34 +0000
Message-ID:
 <AS8P251MB00013A0DCA600A79DC58B0FEC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907072534.588817-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS8P251MB0136:EE_
X-MS-Office365-Filtering-Correlation-Id: c92f4e82-5cf0-4b63-0aae-08df0cb136e9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|51005399006|2604032031799003|23021999003|5062599005|5072599009|15080799012|37011999003|25031999004|12121999013|8060799015|19110799012|25010399006|4140399003|40105399003|2607281247196008|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oin4iOXLASh4sMWJtmvUpPC0gUsZvvjUXcPPJIeo34FSFJdBd4kAgSMYsyou?=
 =?us-ascii?Q?lj+KLDjoqssHWCk+ynLlVEyzEAqk3fIywB4Cg2nwtfdxUoIKN0Oxes4TWpFY?=
 =?us-ascii?Q?00T4GjbGJJ7XAV0DjSrK8clrUL1lfCowcDneHUsZBbLPJzAklvzgtZfyh74e?=
 =?us-ascii?Q?3z9MVwbOJaDVzXhe7f06oAjvtiWQ3uKs9MY1RbpYhV54xQA2GPf1/KL+KBJM?=
 =?us-ascii?Q?XJm5ocCWupYtKjp/eTSH3nebxKBit/1Sac35m5nHN0Lnopv0NlZB7c7Xxw5C?=
 =?us-ascii?Q?eEQ6E0DkuS64VBbtbx+hxtOljsn2s7ikmaa8ve67vJPNgAHb811+VlhgGQQP?=
 =?us-ascii?Q?TK+j5a4V1HCCqh7/uYBQhAoU+EAqdnuhUoPksmiyMZWj9z+69cyqmqS5Ijem?=
 =?us-ascii?Q?Sz8oFMy2BComc3fYzMHOPEj2IhGJllhRHSN7GQOtciTok1YLVncrfJ0Eua3d?=
 =?us-ascii?Q?81Pwr2fqAPJxLOsfdylFFhCvWAuo4dQw6pOWtmCecnT8ABc5rgMuh8sLzZAR?=
 =?us-ascii?Q?5mldhTTbdkYxUWyI9jry8yuS4FZ0AuF1/IIsRI/Jn+kq2eju6VTljhiMzxUS?=
 =?us-ascii?Q?Tu1nDaVyABrjME3MS2xB0FoeZSkt9gr0OHWf1Mdvam8RQKhIZj4TifFnUo0k?=
 =?us-ascii?Q?5MXJNb3KoQCIZxmezWVnSSEEUup5GYvtIYVLsRnxeCxa3t+YXL6aQgx/m68e?=
 =?us-ascii?Q?NCZtNOPj7noYGqFcvMlQBgFRo+i42Zz8VCLUxijjfPRCefvqlWQQn9mORqQM?=
 =?us-ascii?Q?Pzv67egy/pCd4Q9+/jRYdz67Wzb4fWrJYJY+Vczb0Tm1xoqcA1hYpdCN72Rt?=
 =?us-ascii?Q?wtIvoSBnDV/s3rPthvWaJ5xQHjafalGEmzbAGxL6DQUWTO0XOBpjj1+y0F15?=
 =?us-ascii?Q?AKrRiq/iiTvA1qK6clKJN+4yS6dFCxebmj+xsYEz5Uk/kzPScGgvDI9kn1/n?=
 =?us-ascii?Q?DOC+k1mNZWVuFVh5G4hEV9LgBP5CUvDrtP0B5z+X7czpmk8eABqIiFC21xa0?=
 =?us-ascii?Q?kkB33mPiVoys+Ley3IYkSBDvSytomgGgjVLChoj0vzrClDkUpBKBaoz68O2z?=
 =?us-ascii?Q?nXESI5lGuOSyNUOoh+6X+BOPkpfWCZ8wwCQI1jwJqR48tdnkPE38x1zeiyPg?=
 =?us-ascii?Q?pHxIysmrn59hET7OjmDbnJd93giOOTqwtcfEndWVMCPDHlqxNE1e2SY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cmaXM4g+t1XAOFgYCZA/pkPPaRK4SZC6B+AH59y2nzE3hJbPfOyimgx20kKN?=
 =?us-ascii?Q?eVXAa5EJvA8kYJn6WNaCDUhSMTC1j7FuKUusGrnNy83ZIUeeanv+iHsetUx1?=
 =?us-ascii?Q?eXIVLeRro2VSrKzzCDaBwwdJTOehhEZyc4Ospr8tXNB3FvzDADsDRaJOiSjv?=
 =?us-ascii?Q?JMrkvUw7w+g8Ux7awErO6V8JxMYXAPRo9hKNcdHitXVMDiqNvRlCR0D4oPGQ?=
 =?us-ascii?Q?gBGUbf6tvLgnYegA7fg0xBGcmALaalvHWvpaQqrzUsXn55U3wkh+kg4dFTTP?=
 =?us-ascii?Q?h39m7VhP2f0OK09Ql/GJ96kiAghITWTYu1wadMYxdVJjlWiGkAAQj8mV9qdT?=
 =?us-ascii?Q?bXMhmpLOLV0ZdZSoCjTktz0DyX/1j8TBS0BvoQuBPOxzSL/HlTmXnDwlozP6?=
 =?us-ascii?Q?iXIJ6oDmwVu83IvePRt82yUCFoqZV2dmJgfYPU+/yFPMrLjKjjFPEQiPZXLj?=
 =?us-ascii?Q?a1ZRAJfH7cMwgplI2EbaIBOKyiWT+9W+IL7N32Cw06ub+Ibf8FUnf/7cFa5t?=
 =?us-ascii?Q?UBZgK+5Rvw1iAF7RHptwiG1i1BXI66CrJT7xFOm0+tvufBCIS5XTYrvvVzZE?=
 =?us-ascii?Q?fOrzipAZc/XFJwb2W3EXLfreq8uClJJZ1bvAGhZpoPjDuuEGAoqtwFDS56AF?=
 =?us-ascii?Q?RLJBURmIwsLVpX2x3Vq7kSgHr6LZUuxb02oHgmXo60+HOkpxzlW9hlx838Rc?=
 =?us-ascii?Q?wojq0CzHPy9f0F4+UYILcbRNY5DkNewPwz8CESF60L+U82j+Vkwm3LcP/8Mn?=
 =?us-ascii?Q?q7aySh8o2oRPjf8C3WA9KUxCcfl16HGZVzq82q8c4ukt5BKu9W00OUsHkqcG?=
 =?us-ascii?Q?IdDQtLL7keKauIUtuY3cj3jF9g/Pb/bsdVZN3tRxgA3It70l2jnNLP6TIdbn?=
 =?us-ascii?Q?aPlwPqKQbd29OPOhkY5+KVTJSPRc77F7mUR57+qoNOtV92TEzN9ZbyYDMRs9?=
 =?us-ascii?Q?NTZyAaxr+Hcl+/kKHtpoaNPRdWLC7IVLu9cwJt6lOw+d0rzZ7AfUBRFHzkxb?=
 =?us-ascii?Q?zavTqK+KP3m2ktwo3fQiAM9eeQISSP/Ah0zverg5fmqzVg2QiKQyHLf0XU/5?=
 =?us-ascii?Q?xkDgXmPpi9kKZZQ8gZaqk5j1yKkNp6/k+REyuMgjnZ+c5Fje4g8VExo7u/hQ?=
 =?us-ascii?Q?1ehfodC0UdQUdDc2YLioxyno92srse7V3uwJDH5Sf5+vge0GdLmrueoz9//E?=
 =?us-ascii?Q?RGzSQc2xEGm4uiOScc+Cled78EJIqAvzOz3yei7V4CBaggyf2W6XAomCJX7h?=
 =?us-ascii?Q?9DODzve0ys4nqHd6HNqUhLW8x1mLfWLhDwRCdpcgWfhdUfVqOSQ9GkIyYPdE?=
 =?us-ascii?Q?PE7+vHI9VKdT/UNONETFftMoeS6y5I/li/16A2/7Jx0bvv7GrJxRIo1cVUil?=
 =?us-ascii?Q?JE1b/HuxCLjBauVKaFPx2eMeC+7qWxpMa03i+w8edV8zdWkF9VkjDWjnlMzR?=
 =?us-ascii?Q?DuknxLmLFxF6ku5h2sfcNXtvQ4F0pM0/?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c92f4e82-5cf0-4b63-0aae-08df0cb136e9
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:25:38.2509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P251MB0136

catc_rx_done() parses multi-packet USB transfers by iterating over the
received data. For each packet, it reads a 2-byte little-endian length
from the buffer, then copies that many bytes as the packet payload.

The bounds check "pkt_len > urb->actual_length" is insufficient:

1. It does not account for the 2-byte header offset, so the memcpy can
   read 2 bytes beyond the received data.

2. For subsequent packets in the same URB, pkt_start advances through
   the buffer but the check still compares against the total
   urb->actual_length rather than the remaining bytes, allowing reads
   well past the end.

Fix this by calculating the remaining bytes from the current pkt_start
position and checking both that enough bytes exist to read the header
and that the packet length plus header fits within the remaining data.

A malicious USB device can craft transfers that trigger the out-of-bounds
heap read.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Assisted-by: Claude (Anthropic)
---
 drivers/net/usb/catc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 96e82f94edcf8..e4f8b9a0caf19 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -234,8 +234,16 @@ static void catc_rx_done(struct urb *urb)
 
 	do {
 		if(!catc->is_f5u011) {
+			int remaining = urb->actual_length -
+					(pkt_start - (u8 *)urb->transfer_buffer);
+
+			if (remaining < pkt_offset) {
+				catc->netdev->stats.rx_length_errors++;
+				catc->netdev->stats.rx_errors++;
+				break;
+			}
 			pkt_len = le16_to_cpup((__le16*)pkt_start);
-			if (pkt_len > urb->actual_length) {
+			if (pkt_len + pkt_offset > remaining) {
 				catc->netdev->stats.rx_length_errors++;
 				catc->netdev->stats.rx_errors++;
 				break;
-- 
2.43.0

