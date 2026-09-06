Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010019.outbound.protection.outlook.com [52.103.33.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A613B6C14;
	Sun,  6 Sep 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695593; cv=fail; b=hWzZ/NmY4dA5zFmQxrENPK7jC5U0ttPncasGYuJc7S+noLose/zOgYuU9CWHeg7HpVW/lFyNgCqN5JtStYQbfnvAgUdTjJII7H42c1urjkMuFP33+SQn/98g/26Ss0irGYvDP09Vf4r9GqATZZF9nmOz/K2FfGvi8v9sWIScS4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695593; c=relaxed/simple;
	bh=DHOwshrRYixRKpz+bYlTExQ9kugFiuwOzlwNXfdIgk8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dcNtNB88ly5ZsVUyc8sgQEhysQzzf72yeg5e5d+p2gUGGEcw28LrlewiXmKWK0i20FvLfpLEmT1nLlO/rLXIW51LTu8s00GevVjK4+S2/tWlH9jh11yystv0Z2FrFw8uR59fzfCHKvkZVdh1ADsZK4JFCNc3dncjY3/ST/Yinz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=MZ0Ty7Rp; arc=fail smtp.client-ip=52.103.33.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="MZ0Ty7Rp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxpDlWuanClLESWvLsyJ06F1RqDdYR8m6BgGj6Uk6LwNa9T/EbtMBnSMMyH3kLm23tRzWNuYSs1DKQY6++j0RtZdksRWyrLkT3VMCi3SxnotbD1qX+nsnTGqEQMDzpkYMbpb8KbjOzBV2Xb7Hljtz2XtmlaLPYo1mCS9stno3PLFTh4tgVDLwYybAQV8c2GfpfKSfXhJN4l/DQib4pSY8YEqsdjqvGYmANg6ZW65vksEQBmuP7na38fSb0rNvNhIKwTllQOw5CDTgu4PP0PphMU1mxQjC2ScjfAjEsjaFNtnrgNsf0I0fzG3csQVgG3NvMWQlyxnJlTvjwoKM0vwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ays0d/R+JL4f0TyhCfjs5TvnrkKUMAP/ywO7OePAsI4=;
 b=FrDCFu+dYSfJLZDp1JWYTSKls394yRyzGUdjX8J5QyxoNyUXUv5vhGSS4pqQKQW3IkepFZZrMpLKEuo0MKWTy/6XT2Q7j2/1V+1U6WmWv6Lxm6S4oeada/lgpbZPs7Sb0RpVfwoCq3tttpzvcfkYOfHYwPCDOI/yUie1kh23ZVY4vEBk+97HJ9Bs0ud304QC11g2aud74rTMekeCO9TCOErBSpPC37iMOwY6hAPx12hn7f3XaW3wLoQrsAtDAPFLkI6WNTr1TKsuuzN9Dlb/aDbzSA+NtDmA3AWxYh0lPjRczXef1Q73nkYl0+B7ck6L/ZlHhW0OIeBFxZsVMgSWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ays0d/R+JL4f0TyhCfjs5TvnrkKUMAP/ywO7OePAsI4=;
 b=MZ0Ty7RpTMxmO6C6JZJXNfRoxFEB6hFcn5dho0EdC+CiyQlrOiV0g8BWZuTTd9WDeCDVwpQLf3h/nyQwgiNlA7lFxQNsjVzXuWJ5znO1ocjt48xKJu4H3mAs1dwoxtLzAFHzdCM00QGjtn2iJoRVTXDfG6q04NErbgjlTXgHxHPG5aQ47sH1w0pbsm7vGgs6/jq86paZVvrMfyhgTL5LXxDOXAxjQlBsE4XH/xxGh1lDVqEUXunEvoOw9bJ7vTlVUiAaNeq81angOlB0CIMQPmWaqhZyxgQQxznBXmENMhp9zNLlY1fxMIZ3YB2zxbw4V4ETcs7dFa0cOOFd8JZAwg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS4P251MB0588.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:4bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 6 Sep
 2026 11:53:08 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 11:53:08 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Jeff Chen <jeff.chen_1@nxp.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: nxpwifi: validate variable IE lengths in beacon parser
Date: Sun,  6 Sep 2026 12:53:05 +0100
Message-ID:
 <AS8P251MB00017FB955BDEFEEA1EA579BC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906115305.91286-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS4P251MB0588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0da223-a22d-491b-a660-08df0c0d6b32
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnrlC5lHdFGci+YUsdS3F/CIaI/OiEJJA0cReoxYX0vRmZoU+n+oVPme1CNbOlEa1yn3G+xiYLbam2me/1tgzwG1qf5UPG5KcJMwY2D+2Ln+mlPMgTHYzWH94l69sDTxvf54GNPm5TmVc1ElCjYxQJgPpuBP0GSHds8IZxhfFADqA7EoLzHtm79eB5VxjHaCLRvkUZjlP7b40HucFcmOffz4TdTJ0zMnLIImLtKK1k6JjRcBCAARkZQRy7zmPahM0h3ZBtl3bnflDgKi30Ye6639grud9BlGZetveS3qlaqRb1odDFYij4Web+pSOhLHM8JM/oPyw4TPmyDfXU/2dVXlVEdXYso5pGbc4UUFzwmeeiDNN97YKNvlYEGaqN4yV8Y0TVzfzdvtGn4xw1G3QjL6vnPixVhAKcRiBS/b6BrJyKjMBW1jEaxhO7vT0NXUv7KBKLJ1K41CEQCL6OqnphdGCJUn4jN+he7s6ildHaYMXvazaDQ68dyFxRCVMNAuJwAoE/8MhX75obaBRDaKn8pvgoTlRpQHhkGSFgCod3741GJi6fp4Nf2RQCPKJKLtQVTVAhxh8jNfCWic9IXkCsP0LbJ9wYUJIOB/Wt8ZVGNYB/ZuawL1Ze0+MqyRlo0Lw/gck1Dfnmm1FmcKDmXS6SYHj9FmvHrM+B/KQ69JmSmDU4q22521nE/YfCOE5j4J636aKqMExhZbtsrS26XFvVUPZ78PIr3f4/x601EGMrvXjAAsnnJ0QL4ldrbbknUTg0o=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|5072599009|5062599005|24021099003|25010399006|4140399003|25031999004|8060799015|23021999003|19110799012|12121999013|37011999003|15080799012|440099028|3412199025|26104999009|40105399003|53005399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cWEN7O+EDVKPrD01Xt/ClNR6nA+PEY6CfHqwk6Vamg1/quca1hpRL4rVRspR?=
 =?us-ascii?Q?nJ/mOflOPV74l5EYfpzwzTzIPyEPeplz+DWbpvQ2CqW+lWTsafmIKQ3/7ewe?=
 =?us-ascii?Q?og+/yKjr9VrTMilQ206PQjUEzGzKYFEyYTHwFKucLm8y9QEDYNnfO3X6ZyvZ?=
 =?us-ascii?Q?uAm6i4CZ3t+T6cUbvyE9EukMhmP7/BL20JIaK3Q73tnZBX7ZS97FSL/agK/Q?=
 =?us-ascii?Q?3xHEj0BdJtredfiOwb7Aek9/U9a7gYF9n24BMXeDi7CKW5fOJfWtQWc3aCZ1?=
 =?us-ascii?Q?enzqLNEDkGYI2mRQd7cuOThQm4X7IhWLCQFIV7ukEuu0guDfh85QoVujSvg2?=
 =?us-ascii?Q?qf+db8ev0McyY26Pxppkz4o5nxYCOcAUO02vzWO27HYdVby67x1nMQpTXYzj?=
 =?us-ascii?Q?Rcn0fsApQfRvdqvEO5IG31OxjMIpyhReYdACa9KOnfKAfFmqlbhN6eSGO9Fg?=
 =?us-ascii?Q?YA6vQG+YPDbN08XtKXvQA3pa2S7BSVxU3/uLA/IGdFh+ISCtGSAVUePpSU+J?=
 =?us-ascii?Q?/dv0mh+yAEdax21kFrvpqnDO9kyT26QsTdxJqkkWzSaszaStWERnou3q3QlE?=
 =?us-ascii?Q?vD/BNsdUKUvswhufrUvRb0iEtLEvHg6AS/5jHTivoZGxkSW/BaAT/CdNuc+h?=
 =?us-ascii?Q?+/MXC6Ulmirh5vMCVA+G6BrNEz3v2vODfKBTKhCg5qTRdyVp5fvVfhjSzOkc?=
 =?us-ascii?Q?qy1e6ZtxI1bia6uGyQj98/+MAAhirtGufygBGK29uNMHmOfTCaNloTmjC10K?=
 =?us-ascii?Q?ALGwSy/oNhS9DSmfTTu7EvwLEcvESNiHGAPVnP65ktcnxRZwFIw3GE1eFP2d?=
 =?us-ascii?Q?4XSTczRYSe01vqxtYh4b69Y8EuUJJgw5rSOcdNsvjWh/mRVmi3Q7o8AR94Nq?=
 =?us-ascii?Q?JvKVqpARhxllmfUhd1zO71OgOY0jSGhvN75JX+zPbfoumDLbME/f6oWs6pbt?=
 =?us-ascii?Q?oAJNrIMCy+KhvknwcoJFXhrdefZ03ihV/B5nRfAOnUwZZg30dHPx7cTamOcD?=
 =?us-ascii?Q?zbTN5ACA2VttyMIFOdDKcC8J+ZEGl5xLYpQ2mno8g85Gt8sR8WdaUWrBYXbb?=
 =?us-ascii?Q?BqFTDY+XDy49VNe3Iv2wb+98UMNQhjt505lkgen0IYSR88dP17wLekpvAEf7?=
 =?us-ascii?Q?xzfkYIOlNQHg?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/Ru7JtDwl8QjNLi3P7mwwcXmCZeIkcHxAtW6z4tyjMNI+xQIZ2GGqpBNsrf?=
 =?us-ascii?Q?UfMCRKb6xCibMF03M+QoqJd8gXrMOfde8jzMg0ToXFzeQl/dkwzcuM57IVSA?=
 =?us-ascii?Q?ptAhptavBm2BRWplB+LP7OcuGsk0jHbmq7TxvMUCNNk/o2T55NgjJCsQ7x//?=
 =?us-ascii?Q?AJt0kFsjZu8eY/1hfBGvWOAolBlYM4dYku+Y5uUmh3yhB5xro/4sLoI4gHMz?=
 =?us-ascii?Q?kKGZxD7tontKIHQpCpO9VCA0FkMMiwCv6UrRX4LrHOdc3ZG5/VNQdgmMDFv0?=
 =?us-ascii?Q?9rRVJclVHQr0ip4zdoF7hiyc+Jev5h6fmIHvMbKAXt0Vjw6tx3YFrcTtuhiq?=
 =?us-ascii?Q?XoBTq4PlNdqEMN3qsOHH+dFLl1hGjIBtnscj9ETZr2h77i6k948vEyVGaFNs?=
 =?us-ascii?Q?V1FqcdkYI7jcegA+3sHVRkdksAUoS0SYp7xQqPV+/xqiNdJNdSy2qQGpUwcb?=
 =?us-ascii?Q?f19X2gByILHOl8MFYvuUcWExEIHp6d9DF3gAb92i2gtjbRTSYfeggEEDfIr4?=
 =?us-ascii?Q?aK092qF3KMHGjt5PW6ixTNv5Jhb0I0Z6PTFbf+TjVtSv0KRlYL48dZ5pBFB/?=
 =?us-ascii?Q?DwFlrfuTkcmppi2vrpw0e6fsBuTibuRb7mlh2e0PRJ79XVSpwYSKMwjttzlT?=
 =?us-ascii?Q?MuLI+Wtz7UfXU1KoWxWU5KTgfMPp9zFC5tUkBhPcxWk3QzGXaPV9n3TMHBCw?=
 =?us-ascii?Q?4zenneOnLHu4JyC33Il9xHGvisCrLGu3Yp3F8Ym/e0WXDq4osSsWFGxGFSk4?=
 =?us-ascii?Q?NGPaueAAjahpWzvX4tsBbiulQbtBWq3usE2ZIBL4hRD9NfK7G9zQT155+8qT?=
 =?us-ascii?Q?JZ5YmYHVLFgUhRdsIb0aP+o8mm1/pxgxnoi85QqcumIDWngsOgdslcSa5jDS?=
 =?us-ascii?Q?fUKDjWDSBYfur/MN0A5ke5HqmikD0+Xuqbp0ZuEhcAFhmYsGCYAMt8jOF+kS?=
 =?us-ascii?Q?UOt+hhbi5YFiZenAy9rCPV5zZGf0vq5NfZ+pl+MIXv/+ixsHlnjfEgWRKHmv?=
 =?us-ascii?Q?VA4an/uv9fTiFgQ9lPFFdCzLYJ/zWqThxfP8aA5ixRltfDX7Q4MYApio0npK?=
 =?us-ascii?Q?zOjFu/4WaCaOlmN/4u9sNgQ9XPwlSOxcor1UMJsVh/LHXecRj7Z4lcwKuVVH?=
 =?us-ascii?Q?QFIVxFK7Tfq3JVvQX/uKuaWpaK9GqbR3tuv6f2HAs6o72EKnSlmGfRNfiu/K?=
 =?us-ascii?Q?jMIF+oXI8HmafQiVgVfopcJq8+bzt6cfquyD3GKL07amNJMO4DbGD/wFP0HQ?=
 =?us-ascii?Q?EP13LC1u36aWOpJ6zGQ1lS4caAv98pVki8jv+FlgjxnmCaytUlXikyFjAdBG?=
 =?us-ascii?Q?rhIK5+PXjFK9rQncXlTAynsu533jeT4TQ54wh/ZjGlVr9+SB17+09Y/gwnlX?=
 =?us-ascii?Q?LzB+bVnsKRBTMtLZsXPpYNuAUOANXURMzmnwkl+GPhOaNXvIhClUz9MfXYz5?=
 =?us-ascii?Q?D62ZtV3GWe/Q27igAvoeqHxAihS0nMsb?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0da223-a22d-491b-a660-08df0c0d6b32
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 11:53:08.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0588

nxpwifi_update_bss_desc_with_ie() stores pointers to the HT, VHT and HE
capability and operation elements, to the operating mode notification
and to the 20/40 BSS coexistence element, taken from a beacon or probe
response, without checking that each element is long enough for the
fixed size structure or field the driver later dereferences it as.

bss_desc->beacon_buf is a tight kmemdup() of the on-air elements in
nxpwifi_fill_new_bss_desc(), so a truncated element leaves the stored
pointer short of the structure and the consumers read past the end of
that allocation when the descriptor is used at association time:

  nxpwifi_cmd_append_11n_tlv() memcpy()s sizeof(struct ieee80211_ht_cap)
  from bcn_ht_cap, reads bcn_ht_oper->ht_param and ->primary_chan, and
  memcpy()s one byte from bcn_bss_co_2040 + sizeof(struct element);
  nxpwifi_cmd_append_11ac_tlv() memcpy()s from bcn_vht_cap and
  bcn_vht_oper and reads oper_mode->oper_mode;
  nxpwifi_is_ap_11ax_twt_supported() reads bcn_he_cap->mac_cap_info[0]
  and bcn_ext_cap->data[9].

An element carrying a zero length placed last in the frame leaves the
stored pointer at the end of the allocation, so the read is entirely out
of bounds. The bytes read for the HT and VHT capabilities and for the
20/40 coexistence element are also copied into the association request,
so they are disclosed to the AP that supplied the frame. A rogue access
point in radio range can trigger this when the victim associates.

Reject the frame with -EINVAL when any of these elements is shorter than
the structure the driver reads, matching the length validation the FH,
DS and CF parameter set cases in the same parser already perform. The
operating mode notification pointer includes the element header, so it
is checked against total_ie_len. The HT and VHT pointers skip the header
and the HE pointers additionally skip the extension ID, so those are
checked against element_len.

Commit 8e4f5ca8bf67 ("wifi: nxpwifi: reject zero-length extension
elements in beacon IEs") made the extension ID itself safe to read, but
the fixed size structures behind these pointers are still unchecked.

Feeding an eight byte element stream ending in a zero length HT
capability element to nxpwifi_update_bss_desc_with_ie() and then copying
from bcn_ht_cap as the association path does gives, on a KASAN kernel:

  BUG: KASAN: slab-out-of-bounds in nxpwifi_oob_repro+0x133/0x180
  Read of size 1 at addr ffff88800716c308 by task swapper/0/1
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1 #1
  Call Trace:
   dump_stack_lvl+0x53/0x70
   print_report+0xd0/0x630
   kasan_report+0xce/0x100
   nxpwifi_oob_repro+0x133/0x180
   do_one_initcall+0x9a/0x2e0
   kernel_init_freeable+0x294/0x460

With this patch the parser rejects the frame with -EINVAL, bcn_ht_cap
stays NULL, and KASAN is silent.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Assisted-by: LLM (Claude Code)
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Found by auditing the drivers merged this cycle.
nxpwifi_update_bss_desc_with_ie() already rejects short FH, DS, CF and
IBSS parameter sets and short vendor elements by length, but it stores
the HT, VHT and HE capability and operation pointers, the operating mode
notification and the 20/40 BSS coexistence pointer without the same
check. This patch adds the missing checks in the same style. I used the
sizeof(*ptr) form so a check cannot drift from the type the pointer is
later dereferenced as.

The equivalent parser in the sibling marvell/mwifiex driver
(mwifiex_update_bss_desc_with_ie()) has the same missing checks in
mainline today, so this is a driver-family pattern rather than an
nxpwifi-only slip; a matching mwifiex fix would be a separate change.

The cases guarded in the parser are HT/VHT/HE capability and operation,
dereferenced as fixed structs; the operating mode notification; and the
20/40 coexistence element, from which nxpwifi_cmd_append_11n_tlv()
copies one byte into the association request. The extended capabilities
consumer nxpwifi_is_ap_11ax_twt_supported() reads bcn_ext_cap->data[9]
at a fixed offset that has no single struct size, so it is guarded at
the consumer with an explicit datalen check rather than in the parser.

Reproducer: I built 7.3-rc1 with CONFIG_KASAN=y and CONFIG_NXPWIFI=y and
added a late_initcall to scan.c that kmemdups a short element stream
ending in a zero-length HT capability element into bss->beacon_buf,
calls nxpwifi_update_bss_desc_with_ie(), and copies sizeof(struct
ieee80211_ht_cap) from bcn_ht_cap as nxpwifi_cmd_append_11n_tlv() does.
Booted under QEMU the unpatched parser accepts the frame and the copy
trips the KASAN slab-out-of-bounds read quoted above; with this patch
the parser returns -EINVAL, bcn_ht_cap stays NULL and KASAN is silent.
The other element cases were confirmed by reading the same pattern in
the source rather than a separate splat. The harness is not part of this
patch; I can post it if useful.

The access point path is not affected: nxpwifi_uap_set_sta_ht_cap()
takes its HT capabilities from params->link_sta_params.ht_capa, which
nl80211 has already validated, rather than from a raw element stream.

I do not have IW61x hardware, so the full over-the-air association was
not exercised on a real device; the reproducer drives the parser and the
copy directly. nxpwifi is fullmac with no software-simulatable MAC, so a
parser-level reproducer is the strongest software evidence available.
The audit, the fix and this changelog were drafted with an LLM assistant
and reviewed by hand.

 drivers/net/wireless/nxp/nxpwifi/11ax.c |  2 ++
 drivers/net/wireless/nxp/nxpwifi/scan.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/11ax.c b/drivers/net/wireless/nxp/nxpwifi/11ax.c
index 96540914f3c..dc1e747383e 100644
--- a/drivers/net/wireless/nxp/nxpwifi/11ax.c
+++ b/drivers/net/wireless/nxp/nxpwifi/11ax.c
@@ -402,6 +402,8 @@ static u8 nxpwifi_is_ap_11ax_twt_supported(struct nxpwifi_bssdescriptor *bss_des
 		return false;
 	ext_cap = (struct element *)bss_desc->bcn_ext_cap;
 
+	if (ext_cap->datalen < 10)
+		return false;
 	if (!(ext_cap->data[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
 		return false;
 	return true;
diff --git a/drivers/net/wireless/nxp/nxpwifi/scan.c b/drivers/net/wireless/nxp/nxpwifi/scan.c
index b77056983e8..d82ee8e502f 100644
--- a/drivers/net/wireless/nxp/nxpwifi/scan.c
+++ b/drivers/net/wireless/nxp/nxpwifi/scan.c
@@ -1209,6 +1209,8 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 				(u16)(current_ptr - bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_CAPABILITY:
+			if (element_len < sizeof(*bss_entry->bcn_ht_cap))
+				return -EINVAL;
 			bss_entry->bcn_ht_cap =
 				(struct ieee80211_ht_cap *)(current_ptr +
 							    elem_size);
@@ -1217,6 +1219,8 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 				      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_HT_OPERATION:
+			if (element_len < sizeof(*bss_entry->bcn_ht_oper))
+				return -EINVAL;
 			bss_entry->bcn_ht_oper =
 				(struct ieee80211_ht_operation *)(current_ptr +
 								  elem_size);
@@ -1225,6 +1229,8 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 				      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_CAPABILITY:
+			if (element_len < sizeof(*bss_entry->bcn_vht_cap))
+				return -EINVAL;
 			bss_entry->disable_11ac = false;
 			bss_entry->bcn_vht_cap = (void *)(current_ptr +
 							  elem_size);
@@ -1233,6 +1239,8 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 				      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_VHT_OPERATION:
+			if (element_len < sizeof(*bss_entry->bcn_vht_oper))
+				return -EINVAL;
 			bss_entry->bcn_vht_oper =
 				(void *)(current_ptr + elem_size);
 			bss_entry->vht_info_offset =
@@ -1240,6 +1248,8 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 				      bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_BSS_COEX_2040:
+			if (!element_len)
+				return -EINVAL;
 			bss_entry->bcn_bss_co_2040 = current_ptr;
 			bss_entry->bss_co_2040_offset =
 				(u16)(current_ptr - bss_entry->beacon_buf);
@@ -1250,6 +1260,8 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 				(u16)(current_ptr - bss_entry->beacon_buf);
 			break;
 		case WLAN_EID_OPMODE_NOTIF:
+			if (total_ie_len < sizeof(*bss_entry->oper_mode))
+				return -EINVAL;
 			bss_entry->oper_mode = (void *)current_ptr;
 			bss_entry->oper_mode_offset =
 				(u16)(current_ptr - bss_entry->beacon_buf);
@@ -1262,6 +1274,9 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 
 			switch (elem->data[0]) {
 			case WLAN_EID_EXT_HE_CAPABILITY:
+				if (element_len <
+				    1 + sizeof(*bss_entry->bcn_he_cap))
+					return -EINVAL;
 				bss_entry->disable_11ax = false;
 				bss_entry->bcn_he_cap =
 					(void *)(current_ptr + elem_size + 1);
@@ -1270,6 +1285,9 @@ int nxpwifi_update_bss_desc_with_ie(struct nxpwifi_adapter *adapter,
 					      bss_entry->beacon_buf);
 				break;
 			case WLAN_EID_EXT_HE_OPERATION:
+				if (element_len <
+				    1 + sizeof(*bss_entry->bcn_he_oper))
+					return -EINVAL;
 				bss_entry->bcn_he_oper =
 					(void *)(current_ptr + elem_size + 1);
 				bss_entry->he_info_offset =

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

