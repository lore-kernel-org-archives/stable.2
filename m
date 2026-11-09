Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202157;
	b=fTju3MxxAHc4sIOxlDUqetnvvNgVIXZl+0Ik06WPURM7k50Ac2twlaIE4IQutW28oeiG
	 sRppXP3H4GyYmrunXjGUuXKAMCM+RbGaDQNPue6c5LW8po4u+X1DjHka5wSS4ggt03zD7
	 0JW6qFMplkB9hntI52tPQA8ucpaLtR8XwLQPuJlpQtVM1lgouNRaT6HRHO6dIjmVHiWKH
	 +m37kVEDTtxqdEx588zFGweozFBeM39U07Khcm71doZ3mONdnhQzvDzCRdiOBRo77bMgw
	 qQcucl3iERzGktopmWpPDff3Fx9M0brsIJJ2poz/tk0sfTLHEstxvjDOUftYXlLRIzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202157;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=xOHOxfoU7NdGlqBYsx0a6jj53KI/xIDVvNluOaCFMq0=;
	b=qi2QEEsjERz6HdtxntVomlDXsa/8LKiVBAk5wLWnZHTL+gx+y9wKVljVCUnrWkSuvmeY
	 3rxqtE2Nd9nmMkFb2G6vS3OE1K/1exzu+5i3geSO9rqpH7ympNYS7a2sCuwQWuhZPp+aX
	 jYfUxV0MtJbOcBYpYrVn73nlLXnzj5PPp1VlyuxdBNJ3GCjJGUXLllttzDY5/jXNsC+8F
	 wSYHzfBQcaKMr8SHazr9knFNIvVQ4mOu+dSqWo+BDRZZpAZS4+Gbjsa8PfLz+yu7Fpp/x
	 QvUsMhwQTNYmtrVmhNLFObjoq+G9iQQwlJ2WqXjwxEZAKDdBeyhQ9RzRAKQADCjWpnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=Jf9Dzomn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8D606D815;
	Mon,  9 Nov 2026 05:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED8D606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=Jf9Dzomn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnIFd483zervt6sMWcZScyalh8a8+vYhXutMFZk2NfuxZQJ/kz+Z72N4igTauXBqrBWIr/ZXC9k6OpWDsoKtylDRaTQgakH7HAHsNisLc155KS0wgVoajWBJb4TPRbBAd9hMUd9TKlFv5Ujl5KzEBIeaBBr91OjEcCaB7vDriGYJawuBC5rdFpmGZyRUi3v+3epEy0ZRk6JgXdCEPElhvJINOVK84kNT7Tn6uNwy/X4Uxt8SD1mNBYvahM8iKZTKzn8l7OvJK3Ny4c4jNkiqRSZzo09idaCW6yiqlK994VhE1P+trMhXKOi/PjSMzY4Yfmac1fQebWK4Cp78l5r66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOHOxfoU7NdGlqBYsx0a6jj53KI/xIDVvNluOaCFMq0=;
 b=Oh9jwdkVqBHY8N89wcG6JwHMTllLGU5evKxGQHejFbLa9vSvwjUhmRm0xgPFxvxVXo74rcmL5nVhMLI01CJdOs/6LqLowIdU0aTOo00H4bwubIzPt4Rk1NmHzBbat2UeY5SrLsIHffbYKz1md+Thb9umfsmBSkGG3tiv8gdrYoNxk/KCYsdou49pHE9EKftilq2m5MyWCc5DW5kZIKYB5KM7Fy+kF94VZWm/yDp9aD7m6FPBoQ352Asla3OIuALjKvuGUSVvIRxufodIIkUVAsmnxS0DsX7RsJo9uTql2gX610uGmdcZydss9AKgKDkXSYhaN/Ljd5zwDYpKzu0msw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOHOxfoU7NdGlqBYsx0a6jj53KI/xIDVvNluOaCFMq0=;
 b=Jf9DzomnedCcR2MBmI4iOWsGgL7h/IuQ8HpWiMeYg/GWac3uF9ZnyFW5d2OVryqUEQMwMYtEXBUJdfvMT9wxeq25hRs2KNBh98sQMFV6/BakVwnYO4q0+ckMqfi2Y8SLFCoOMMv2ZL7otMTWhfYTf/l8sbYVTWYjbAm9gcDE5/rZxJx2M3DIHaijJECFEVThTdQQMbdrRE1GZwYBwEXA5zJk+GgGtf8cfI+d3V2j7rlwQ5kONDgJcgXIPHeY2yW6j/Xf+mwU+X0+siqboP8EOQRBzuK/faHaBtQubPS1rYdLA6cSYODY6uayFYVZDGWMgo5lkSpR8sVBwGKKz+KSlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:06 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:06 +0000
From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas.dufresne@collabora.com,
	bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	stable@vger.kernel.org
Subject: [PATCH v2 8/9] media: chips-media: wave5: restore the display flags after a flush
Date: Mon,  9 Nov 2026 14:28:52 +0900
Message-Id: <20261109052853.110-9-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0135.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::14) To SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:f::14)
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
X-MS-TrafficTypeDiagnostic: SLXP216MB1148:EE_|PUVP216MB596218:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcffdc2-e66f-42dc-8e39-08df3e225fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|56012099006|261021123027099003|261021135927099003|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6UDDxHEC1AXKpE8rXb5q4BEiSY0Rqkw+b9800TSxVpdWp8YNKS847wRrihMO9HPcmOs0cPulcDIOT9hwNs47npM4YXz6GktzSa0VBSE+uMH4P5sPrkoE0kCe3ko9g1yq4rbQjQhIMNt0NUePOW7pc7jjUh7eaabXb1WYLDUwsZLTIIe9MbvkOBltk4XQvqabk8gKmMfsaNGlq+r6cFwAy5BiDrrcFi5K0ZQy214DDvCv8JNhObhq0m19A1+lKZoRvst9C3iXqWpQexWH8IRXhj6wfLZGsNwEMeCOAZFTL62mpYZhO2qGMHugsbGoCibZWyqh2brL71E4b/6YmogW/ej7YN1HssRXOLowzt/SQwxdYhvQ9FPBawKJqUGGRz1t+JfWwkdNjXAWQD5oQXqtSF/KfavU4AlqF8qaBsZYA347F6lWdRrxNJP/rU5uok6ip/m4MZMMErHgetr/gRfqw8IpsHqWNt6QRENqRhSP2P3RypGOeolGl+WbSr6GanLx1WmQ6OBh6NpT4Lj6gwIhNL2oKyVsYusFkl0qXY0biFpVDfHuYazDxqErfzAKq+SOlBN2eEXf2mGBbzQvtw7QHG2DT7A0sdi543HOGC01nqH19EXBHrc3bCzGpt51t1U9l0PpXxNnyQEsF3CJjgCz0fZVljrvmWWOLaDfeVMEse1Koi1Ej31kJoGZ15Th5zeOxvajYHxKl+v/6WueUvyRzw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMjcZlG7Xol73GLUdZ3vIVy2eNtETi1/kJ/dZLxUy/TTjxz1Zsx+Vg2v0rD3?=
 =?us-ascii?Q?3e4a3Og6EFexhRtmJdzQTKDfASmRSeSFHsK5s2rfT7kJDB917eTpUa6SkyGi?=
 =?us-ascii?Q?z94I+sip2xBjuLKxQ/DKR5sWScvCkDuvXZXqDex/4IIsBhkaZ+HzLVs4qR5q?=
 =?us-ascii?Q?d1WTWeeTbwA0pFBLUCH/lbXuYVWHl7jOCyzAcyHLmd1YNeSa5CvgHHIqQpFl?=
 =?us-ascii?Q?3R924bYQw+kIxCuf63hTG1QdyReetZ9+BAON+fFAf0u+Z7ouoJoAk1IxIRqP?=
 =?us-ascii?Q?zlB6BMGYXh+cT02lt8NJtlqyi99Ea3iZbpaaB91bOpMQmukaPPVHYFLFCMG8?=
 =?us-ascii?Q?0rQOZZmK27pCQXeDfPKgUOGEw6tUvqcF3qn86uWs7zBxC4iJd3191WWPC6SI?=
 =?us-ascii?Q?IefzKf12hBVRA2lHs4N4EMMeXhaj/pAMpUL7dZXXrWgtjRCOa4Q7fcrovBS7?=
 =?us-ascii?Q?KlTJp2Uc2jnjqmBFythLqX94WMAF62SiGSrQrWLrPHVnO+7f1G1Morx/xfz/?=
 =?us-ascii?Q?ZIbEnEzrjOXAqSZ0mGoAmGzqDg4u0W45bZoUSxgdx794kyHM6PpKB158o4Rz?=
 =?us-ascii?Q?u4DErtJW2k09gtVGI6shppxFNptFbIfBgPoHoxsxxJzyFKLeyd/XGLNrSTWZ?=
 =?us-ascii?Q?pSiF2QX25bCD7TSjUP1Ggbf8WIq3lE95PNg1EaqbfOgfslvS5Hakj0S6Jpna?=
 =?us-ascii?Q?5Rb0d8tlqS3D9LO4UUGnyjnBmSzH0lP00EHebV7hNy7S1wxWxXmkTfOYrIn0?=
 =?us-ascii?Q?8mcA9Cygtg7rAfTlOBaOeKVdEp+WqAlghpwTYshdCO/QL0N/JoJf6ArGiGfE?=
 =?us-ascii?Q?gmLAJfi3ru5QvZiK9gEXFX3uxesmOBdcmNkj2CdyXONgCxBgAiAGnvui6e9+?=
 =?us-ascii?Q?ssjFWTKbLyIiBAQa0W5tZWFmQMDxsjHMhaWvnejlnrYQdawJMspg6AnoMHga?=
 =?us-ascii?Q?u/ams8eitNVJK3bG43RIeBYMdokLFfDxrbwGoi5z4sM5+OItCpb2NBVPy2QY?=
 =?us-ascii?Q?s8FuYsS4/2NAUe2xojvrqjGGmEFDHFACqBs2vxUU1HXRqWgoTqRpYHNd1boI?=
 =?us-ascii?Q?OTnQSgNeu6IgAMHkYHcE48uXcWJmPXK+sfDvmeQLWwfN9ffT3qnF+7EKEks0?=
 =?us-ascii?Q?JyrTTLPH5cdoIjL2Ae/aJ/Y/uhCEE3MTCQA9vB8AIK6wt1VnlArtkKoxKDwD?=
 =?us-ascii?Q?kWtua8Tbt4dRT+6BNy7cVDrl/sMK5yfVmI4I48oc9baZYdakMRht/s1H0pa1?=
 =?us-ascii?Q?94jpjN0YAFZeTXlrII7Zxl0qaD/lkw6lt8WlvBKPN9iABMvt7qpjkA7x7gQj?=
 =?us-ascii?Q?wz2NtuQIqwQNwg0kvM5L4wubdFXLwpo4XAXpt+Lg00qUdjNMdoR2qlyI3g9e?=
 =?us-ascii?Q?I2r3avAf+bRHYOotJ/CH9Um3fB5CqD8pCqi8pODxEpvpgbYTIatdUz7m9zjs?=
 =?us-ascii?Q?b4xE9W2KIi5ADZ2pKxIAfK1nh5vExKLY8LzkwI91GP0eeY6l0khphfrzpNOi?=
 =?us-ascii?Q?LSik9W6/NiW/dNlcDVBIB+6M4aE1Y7qitj54LddS2nVUpuoGLS4gVMhD592b?=
 =?us-ascii?Q?Kc7zgkdmHWCQQ6VVf8/dQtksKWCZnD9OqYE4qm1nCcQuPzODPZkNexEeJVBs?=
 =?us-ascii?Q?JFoCclslrCyb6Mf+DmOqMlQrqdL84f9ysbeII9B+u3s0IjYJhmyb9RW/b3YQ?=
 =?us-ascii?Q?8HLgqwqtqY6Q177bCA7un51jK3DGqNt/ccmy992EABN4TjClK0ioZmkCFgCa?=
 =?us-ascii?Q?AoZD5My844+UccYNtskdISWwHAaM0QM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcffdc2-e66f-42dc-8e39-08df3e225fcf
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:06.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InOxonKjCRDVt0uh0+sj5PB+6wSoE4hGTJE9KwD1U20xqzraziadgfiOPH9fhZxLIJ/O98yvQVDau0JcTD1mGT0kBbzT0yhJP1+hVtb0br4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Jackson Lee <jackson.lee@chipsnmedia.com>

Flushing an instance clears the display flags, so every frame buffer looks
free again -- including the ones userspace is still holding.
streamoff_output() marks only the buffers that happen to be queued when it
runs, and userspace clears those as it re-queues them, so the buffers it
kept end up unmarked.

The next pictures are then decoded straight into buffers the application
owns. finish_decode() cannot find them in the queue and warns:

  wave5_vpu_dec_finish_decode: invalid display frame index N

A trace of the flags across a seek shows it plainly: at streamoff the flags
are 0x73, only the two queued buffers are marked again, userspace re-queues
five of seven buffers and the flags reach 0 -- and the two it kept are
decoded into 8 and 12 ms later.

Re-establish the flags once the flush is done, from the buffers' own
states: mark everything the driver does not own, hand back only what it
does.

Derive that from the vb2 buffers rather than from the m2m ready queue. The
earlier per-buffer loops walked that list with v4l2_m2m_for_each_dst_buf(),
which takes no lock, while the interrupt thread unlinks entries from it in
v4l2_m2m_dst_buf_remove_by_idx(); walking it here oopsed on a poisoned list
pointer:

  Unable to handle kernel paging request at virtual address
  deacfffffffffcd8
  pc : streamoff_output+0xe4/0x294 [wave5]
  Call trace:
   streamoff_output+0xe4/0x294 [wave5]
   wave5_vpu_dec_stop_streaming+0x244/0x2b4 [wave5]
   __vb2_queue_cancel+0x30/0x278 [videobuf2_common]

Indexing the vb2 queue directly avoids the list entirely.

With a flushing seek every 2 s for 180 s through glimagesink, three runs
each: 4, 4, 4 of those warnings before and 0, 0, 0 after, with no oops.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Tested-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 77 +++++++++++++++----
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index e351a86528bd..102c07979d08 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1087,6 +1087,45 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 	return 0;
 }
 
+/*
+ * Re-establish the display flags from the buffers' own states: the VPU may only
+ * write into a frame buffer the driver owns. Everything else -- above all the
+ * buffers userspace is holding -- has to stay marked.
+ *
+ * Walk the vb2 buffers rather than the m2m ready queue. That list is modified
+ * from the interrupt thread (v4l2_m2m_dst_buf_remove_by_idx() in
+ * finish_decode()) and v4l2_m2m_for_each_dst_buf() takes no lock, so iterating
+ * it here can land on an entry that was just unlinked.
+ */
+static void wave5_dec_sync_disp_flags(struct vpu_instance *inst, bool mark_all)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
+	struct vb2_queue *dst_vq = v4l2_m2m_get_dst_vq(m2m_ctx);
+	unsigned int i;
+
+	for (i = 0; i < vb2_get_num_buffers(dst_vq); i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(dst_vq, i);
+		bool driver_owns;
+		int ret;
+
+		if (!vb)
+			continue;
+
+		driver_owns = !mark_all &&
+			      (vb->state == VB2_BUF_STATE_QUEUED ||
+			       vb->state == VB2_BUF_STATE_ACTIVE);
+
+		if (driver_owns)
+			ret = wave5_vpu_dec_clr_disp_flag(inst, vb->index);
+		else
+			ret = wave5_vpu_dec_set_disp_flag(inst, vb->index);
+		if (ret)
+			dev_dbg(inst->dev->dev,
+				"%s: %s display flag of buf index: %u, fail: %d\n",
+				__func__, driver_owns ? "Clearing" : "Setting", i, ret);
+	}
+}
+
 static int wave5_prepare_fb(struct vpu_instance *inst)
 {
 	int linear_num;
@@ -1541,7 +1580,6 @@ static int streamoff_output(struct vb2_queue *q)
 	int ret;
 	dma_addr_t new_rd_ptr;
 	struct dec_output_info dec_info;
-	unsigned int i;
 	struct vpu_src_buffer *vpu_buf, *tmp;
 
 	inst->retry = false;
@@ -1550,14 +1588,6 @@ static int streamoff_output(struct vb2_queue *q)
 	list_for_each_entry_safe(vpu_buf, tmp, &inst->avail_src_bufs, list)
 		list_del_init(&vpu_buf->list);
 
-	for (i = 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
-		ret = wave5_vpu_dec_set_disp_flag(inst, i);
-		if (ret)
-			dev_dbg(inst->dev->dev,
-				"%s: Setting display flag of buf index: %u, fail: %d\n",
-				__func__, i, ret);
-	}
-
 	while ((buf = v4l2_m2m_src_buf_remove(m2m_ctx))) {
 		dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4u | index %4u\n",
 			__func__, buf->vb2_buf.type, buf->vb2_buf.index);
@@ -1574,6 +1604,20 @@ static int streamoff_output(struct vb2_queue *q)
 	if (ret)
 		return ret;
 
+	/*
+	 * The flush clears the display flags, so every frame buffer now looks
+	 * free -- including the ones userspace is still holding. Only the
+	 * buffers that happened to be queued when the flush ran were marked
+	 * again, and userspace clears those as it re-queues them, which leaves
+	 * the ones it kept unmarked: the next pictures are decoded straight
+	 * into buffers the application owns and finish_decode() cannot find
+	 * them in the queue any more.
+	 *
+	 * Mark everything, then hand back just what is queued, the same way
+	 * wave5_prepare_fb() establishes the flags in the first place.
+	 */
+	wave5_dec_sync_disp_flags(inst, false);
+
 	/* Reset the ring buffer information */
 	new_rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
 	inst->last_rd_ptr = new_rd_ptr;
@@ -1614,16 +1658,15 @@ static int streamoff_capture(struct vb2_queue *q)
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	struct vb2_v4l2_buffer *buf;
-	unsigned int i;
 	int ret = 0;
 
-	for (i = 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
-		ret = wave5_vpu_dec_set_disp_flag(inst, i);
-		if (ret)
-			dev_dbg(inst->dev->dev,
-				"%s: Setting display flag of buf index: %u, fail: %d\n",
-				__func__, i, ret);
-	}
+	/*
+	 * Every CAPTURE buffer is about to go back to userspace, so none of them
+	 * may be decoded into until it is queued again. wave5_prepare_fb() only
+	 * re-establishes the flags on the INIT_SEQ -> PIC_RUN transition, which a
+	 * plain streamoff/streamon of this queue does not go through.
+	 */
+	wave5_dec_sync_disp_flags(inst, true);
 
 	while ((buf = v4l2_m2m_dst_buf_remove(m2m_ctx))) {
 		u32 plane;
-- 
2.43.0

