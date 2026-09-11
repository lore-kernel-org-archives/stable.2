Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011029.outbound.protection.outlook.com [52.103.33.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD14BA1E3;
	Fri, 11 Sep 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162397; cv=fail; b=CqWPHJuUpZT98iJpTpL3E70AHrcqe9v06zgHE+bE1B3aLyS7Vl8c6MvB0lng+mgAEjZ1RXJcRRXvv8r/Xf/NUvDIH75SaGiXtMj8mpL16S7wTmBrsi8odp8Nba/1w7zB3mgn8UKCyO6enpUUx8xR4uz7LZj4IEOtJvkhL6pRFw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162397; c=relaxed/simple;
	bh=KTTbLuLtwufeXp1nqF97GxpPwczm6+b4PgUhT/3EF8I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V5U64JyWbRaAs40feDIJxi6c4ZYGkLn5kk7Apz+PMlwANTxE8QDK1wXkaipWPlOzecduvrdDip9iyBK3kZ/avDqawt6IWyVa3tSpmOWWNT/3JYTlbo3KPDgzthhGL+x7ytDEK74suiUFtMWvm1i17cuaNn48nQ4ov+Eyb3VF77w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Lr/Ogn1S; arc=fail smtp.client-ip=52.103.33.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Lr/Ogn1S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTWS1RDTnmDCHaPvyNoAiPi7aUM6AGU54Q5OJBGe3qHHypnbAZhsWW/oqaeAiDYZ//wmTfLVWv9rbHC/bPoW8892qtj9QGbCF6E+UCatCFKmQNFNXiYZ2BIVowA4bKThQhoDZGt8rMXRijD5Ifh4dQLew4Piv7GjCtlb1Nrm6fzekQhfOcYTUw4HN3DiRzHUjqeCcTGfO1V+wF6h2BQcR3M/bh0VbAkSkKld8+zuuJcMoT7PnYtHfTIwaB54DpYTFXmXNIgqL3acnss4Jt1QQDwoP+Dc/SJF8Uo8xCjDRqybfAE6BKEHBiepqrztzMQcpLW5adZ9Kd2A3GIq7uddRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEvuw8k2cLL5zQ5VKO9MXJJU5UPhuS0zi+C2KdxYafE=;
 b=sRx9+lTCb1DgkKCHw/q+crhVA/Qkaelt4sf2vY7++9PsUxWF24zdqx7FQpF3/a1b3NinZqMf5vefioxKVNU11x7puvthn1cJmqIviQR5UPHhVrWdDjzuyfqtFwoZ/oY9W3k9x04J5Vc4HPaw43fGq78h3/3z3qBzFHfmiPsRRex4LTjIFNprf0iPNguN6pABiLbmwVnaeKPDp8qBBqtZsbOIX9+3jzg9iID3M+yXyzaWdutM+oC2xuOHJJDID2Y/hqicdJ7S1jpBv+RDVrLlrN8UuGmXI1FB0+vLoVJxg7GkvW5UjhB+wolYcTPYjE+MmGAYYyNuykiuztiT2heukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEvuw8k2cLL5zQ5VKO9MXJJU5UPhuS0zi+C2KdxYafE=;
 b=Lr/Ogn1SOELeyYJzKBHl2fsXwmwPwsNIRCyV9RucdJ+5aQ5xq7SUZo1DjTKX5CYnn/HJWWl605yRhSNyV6mL1i+WH0nDTxAGg4x6iHfDyhuQanG8bLWeRVSnzYG/hmJ9ii5vb0QP55zYX0w9EEGUyxIAHsEFcjC3sg8dDvUZkm8xm54ut8UJPmVnUgIV536Km2EZuSEoKg1ZVWvd2+jrakT0w0xEiX+gVB5mYFTzOwazBBq1wkwSBO+IBNPnWumIYTJ/kSC+T8q3Q40HWi2QgB1FIEN3k/Ezia3ItkqCeGOGAQ5w6mKZj4YMcYyPJMyD8n1PFb1dw8wNEs7/cNPyZA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DB9P251MB1181.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:5e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 21:33:12 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 21:33:12 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] macsec: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 11 Sep 2026 22:33:10 +0100
Message-ID:
 <AS8P251MB000176E827636EA185226908C8BE2@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260911213310.90609-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DB9P251MB1181:EE_
X-MS-Office365-Filtering-Correlation-Id: 467e6419-9951-4454-824f-08df104c4807
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qUreO9dOhET7cya/2blvFTRhLQ0vd0LY1wo93Enr8Vy0n/cTyvz8uov5rMbkQqe+nuDvImJP/+6VmG3Oap2k7sr5qHYy39FJXRwEcJzKLjOBCHYFm5tXJMAfkQFkBTTLeLs/2rZQYpyufrONimjMzAxbDfTQGVvOEcJgwjJJN7+bLP8B/imyirpeiz8H9f8aguA2zBKPA/mjT/sskr+dB9LMJUiVotDZEcoAWm5FwMsVIun3hwR99FiDM5zrdNbzWBBNWs91B1jBKrAawEj/ZISeEQCC/zxdWVryL+yMTKkHoLp7bhNGPiZhTT9DjPYArwUB8AyJ/S3ObfgoSpf54a24MeJJEEV3PtUesxUqE8znmBlco67FKLEkN7LJpcnyv7TDDZL0+A4FHF0GYtJPYB+QTJk+b/NbbeFJVlIgaPukKZYyPU8eO9h3HLk6ZkLrOkuoC7b9vOVwHYOb+428rzggm0Q+rio4et4QqGMI0QqTJzJsYGa6wXuM5VsxRStJ+Bm57cQQOhF+0oXPLg7q/SLLWylwPOsLs53I/a5eCs6HzxVpnNsxtkXxhKsHf7wZrjPlVvbxze/8YKVXobiHA6gVpCjm+nFGDxJHajklkd18ipzY3fJ+PUXua5pVg8vpgloDyOM5/wak/j1mPVdCt8qW/XEdYnjkTkXrQNm7xiMr7AfBJwQXbWBWwNqwyVMaCDZdeM+9LiH29yTztt1ecIBFH3TSoBs/8x3/2VopvgXtNpGp+8aNg971dvGyCfpMIW4/ZSy8D5eop3g5S/DHdwBGKgri653JS1sl+QPLio7ihUU0IJ5u4AccLpYRIgpBIupG+ud7KHj1BhGVgq2wzJM
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|41001999006|5072599009|37011999003|23021999003|25010399006|4140399003|19110799012|12121999013|8060799015|24021099003|15080799012|55001999006|5062599005|51005399006|440099028|3412199025|4302099013|26104999009|1602099012|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RrziQ/c0YfuJ8bHy89AKb+/IIupCseApZf8rYsblMDWoz8VZpK0dsp4vIncO?=
 =?us-ascii?Q?yVw1UK/g3BY9ZznIe5Wm6X2OjcSK5W5gwSpTDb3VhTE7c8LFh5JBoh+1FZWJ?=
 =?us-ascii?Q?oS/xnuDBu6aEYpcp8fZwWfkGGRzqY9yXkDaUwU4gg2kkQd13O8ZtUbkxTalv?=
 =?us-ascii?Q?OKLg8Gm5UJuLL/sr/NHuqW0LZCRfyWCYWH9C+3dbEsvh/kCcYdZGIcY2/FbU?=
 =?us-ascii?Q?X/j4sKGbQ25pAluoH4sIlqidzF03aHJGQbVTOCKFXz3Kk6KRXV8TJ4i0rpaS?=
 =?us-ascii?Q?PsYidqUwk1jetxgnqed7pQpSctRXufE/VOtJjA3p+eScf5rXn1CXrHbkXeIy?=
 =?us-ascii?Q?1gMRNwpbr98cTu9ePSgu1ALjIGTZPgtfv+olQ/cmPKtM/Dp/C54npj+tOe2Y?=
 =?us-ascii?Q?OoE8DCQqmYqygjm/wztidjf6z/4TcC6e2vJ+nOXTlElpryg2zR7Rk7avHWYg?=
 =?us-ascii?Q?NCnWSGXdL/h6ncE2wMKzfnbtOC2wf9XpEZArrjMIevzFsjiSuhcbs99rlSAv?=
 =?us-ascii?Q?aUbhhXZVi8uM7aFJvca9DQLIlExseiVPTG/RbRslqnJUQUkT/qL7Mu6/QASj?=
 =?us-ascii?Q?V+iSCrbTlC6fNwvPfj+H0z/CRvBrMEHVsN1V+Z5R6A4ZVBFDlvhO/IpiCxnG?=
 =?us-ascii?Q?RGPc6Qcg1yDr2N8l4WDr5cf39UD2z/0+NJC1wCVY46Df4NBAHmBE5ghVOJjW?=
 =?us-ascii?Q?QH0HgkiZSO2TL3eCk9mmJfpvUjMJrk9P6HD7fI45CiJMV3rSwWNVvrV0w5H6?=
 =?us-ascii?Q?F7X0nT1hqvNxxWr4x7khVAeswN6OYkYmOv0JHZuiq4kzmk4YLfzEcA/IxDho?=
 =?us-ascii?Q?yavsV3hfHmNLRu1GaHDLJEIUoDmYE7YWMYUxPoU9Vhz1C88AY2wrvpyzVDMg?=
 =?us-ascii?Q?mqQWvk+PYh2Rw0GSI/xfeH95aNuKWE0Wj6Qz/MKzHGcICIcnOfGhhv0psAFI?=
 =?us-ascii?Q?pTyyvdefTfXTZIoWsmn/vtp1tnY0DHGT1oQEpdYhWZk4mpZCudp5gRzeJk5o?=
 =?us-ascii?Q?9368WYOS4uMxZsU9v3mnA2zhw0pzFcE/qIwSSGy1r39VAiLLmpNW6ZxYQnW3?=
 =?us-ascii?Q?GiUKkBw6yVYBqNjXzXE2NFKcT5qdfYISX09EHLA179BpjbEa5KIKFczYfnVy?=
 =?us-ascii?Q?h82Kt0m0twbTTOCNIx1KXYN4EZb2L3JDCfctYRAG0yZWpFXjImZ4voD1Rchw?=
 =?us-ascii?Q?CLtwAen+1YddACPAUWkhnRuo9b1vTnKEOU5yDQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDaCuXj2CxZZr+yQY0xxwgEUikYJoh149Vnk4ZRyOcQFVGBfYbm5NTDVMMMr?=
 =?us-ascii?Q?aeX8LqUhjFjbiaD8KwtedZECP8JKWKcHzSEmiUuh0XhaaS91hgVbuxhRseXw?=
 =?us-ascii?Q?F00LDKvpL/PYEBEaFgTXXCAunxvVZbsfQUgHNoeThh9vVKhC/di4jUIaEYdj?=
 =?us-ascii?Q?Qz3l71KaRBp1gsNsCUkNUhAn6rYx3xRm71hK9b/jbvPTRmUcJHXcuVHlrYq0?=
 =?us-ascii?Q?k8JFhX94F73BZPwMqBCgtc/KWWMSBLgl17opvPbzbG6b/a536XCOeIjalNE1?=
 =?us-ascii?Q?nUBbdZUcryKDEJguuRAMTaYxNIbiNYx0hb9FRVcpyajwLehWFzZj7Rqd08G3?=
 =?us-ascii?Q?AkRKhzbYavXOVTgTxtVb5qqbqEd/74+sMOyQi98Hqah1QY4Fjm5or4vLtN7E?=
 =?us-ascii?Q?NJUSx2/IQqfN+wx+KVyJ0lURI5cSh7v/3gkyan/Ec2YcKtdCpA1gWrTUPLmg?=
 =?us-ascii?Q?FQGH6NLyUGAruLzOPbeJ2m1A43enfl3g5jc3dve65VrEVH8GF3jCsrhpybG0?=
 =?us-ascii?Q?fR/7tnF5CseLOOD6128RAcVbvRpaxdj7KpNx0nGt5O7SM5BkXgAsp+NM15Qy?=
 =?us-ascii?Q?pxVOm5r2nl8g5+3wp/H79QV4GFHuySCfhWmIqzFssaHJfPqxXCGjppb6rJtu?=
 =?us-ascii?Q?BOGu0phsMKiKlX6wSxOmvwHk79C6F1rLI/Ig9Dhheik46+0oI8Dmdj/n/Q3u?=
 =?us-ascii?Q?DD2rv9BDXZNW9mH2HZq84ibEZsKRnt+qt3hspbyzkY5Ak5LdSvC25Fj0GqpX?=
 =?us-ascii?Q?YAZqRdyZlzD7HiS209mWK8Ts6/63QWVytKxZIEj6DxcfCQ9BC73ua5ixmdyg?=
 =?us-ascii?Q?ADiWjfXRHFntefj+o0Ob9HJhTOBUPt75YT/FgLfszU424AzI/yjpHImbtueM?=
 =?us-ascii?Q?y9xye/iXa6DBmwrdGHVLuTOha17Ji9Tj9UvjjikaHwqARMCgceOhugTpXB5L?=
 =?us-ascii?Q?VxmvlFwp5wXFkH+3TVWB0jhbi2lV0nx5CWi6a2tGeUkFbhBr6pgoooroFelH?=
 =?us-ascii?Q?YuHoBNCC01qZDSFf5K1hQ+i4ezILJbZTqmxQTdbEJf5182+t4ii899WiYEKT?=
 =?us-ascii?Q?ehEtLs4G8nQfw1JdSFtz8wny8HkG4uBLfkhc585tE2V5uGpkVTcaJpFgiYer?=
 =?us-ascii?Q?tKcCNgycJ8dYfCziWgbfyvrhUslW9VmOHDPY+C/bbOtEg1XOBAuIxwc7MHVp?=
 =?us-ascii?Q?A4YLqBI6WHFMtUmNXIX5OI4xcvxP7w11zgIcoHvyAMWRFS+a19SgtuZFbCjc?=
 =?us-ascii?Q?zrrvRJHY1Pni+2cDEJl85yb95hv3ithhoiV3+Ck8q0jxNezpJEvOKgAhRqpd?=
 =?us-ascii?Q?+o/XGDMDc3oWZYH10LsT2EVnXLAoe8h/4+JoV+wIT7/fAKiGV85WUYCipwGz?=
 =?us-ascii?Q?DM2RjrKMGemJK+NGskGcywJMF9mqC34r7aLJVcqHfBY9dIiCIfNX1r7oj4Qd?=
 =?us-ascii?Q?ryJuHfvQdErdt30NRF1GU+CdDXT5D5az?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 467e6419-9951-4454-824f-08df104c4807
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 21:33:12.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB1181

macsec_changelink() operates on two netns: dev_net(dev) and the netns
of macsec->real_dev. They differ once the macsec device is created in
or moved to a netns other than the one holding the real device. The
rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev), so
a caller privileged there but not in dev_net(real_dev) can reach
real_dev's driver:

  - IFLA_MACSEC_OFFLOAD -> macsec_update_offload(), which calls
    ops->mdo_add_secy() / mdo_del_secy() on real_dev.
  - the tail "propagate to the device" block, which calls
    ops->mdo_upd_secy() on real_dev for any request against an already
    offloaded device that does not change the offload mode. This one
    needs no IFLA_MACSEC_OFFLOAD attribute at all.

Gate both with rtnl_dev_link_net_capable(), as the tunnel, geneve,
vxlan and macvlan handlers already do. It fires only when the request
would reach real_dev: when IFLA_MACSEC_OFFLOAD asks for a mode other
than the current one, or when the device is already offloaded. The
local attributes of a non-offloaded device stay configurable from its
own netns.

The check is in the changelink handler rather than in
macsec_update_offload(), because the mdo_upd_secy() propagation does
not go through that function. Its other caller, macsec_upd_offload()
for MACSEC_CMD_UPD_OFFLOAD, is GENL_ADMIN_PERM. The ndo and dellink
paths that reach real_dev's driver as a side effect of operating the
macsec device itself (open/stop, set_mac_address, dellink) are
unchanged here.

rtnl_dev_link_net_capable() was added by commit 8165f7ff57d9 ("net:
ip_gre: require CAP_NET_ADMIN in the device netns for changelink"); a
stable tree without it needs that first.

Fixes: 3cf3227a21d1 ("net: macsec: hardware offloading infrastructure")
Cc: <stable@vger.kernel.org> # see patch description
Cc: Antoine Tenart <atenart@kernel.org>
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
v2:
  - factor the check out into macsec_changelink_check_netns() (Jakub)
  - fire the offload term only on an actual transition, so restating
    the current mode on a non-offloaded device is still allowed
    (Sashiko, Jakub)
  - commit message: say why the check stays in the changelink handler
    (Sashiko)
  - Cc Antoine Tenart, author of the Fixes: commit (netdev CI)
  - add the Assisted-by: LLM trailer
v1: https://lore.kernel.org/netdev/AS8P251MB000190AAD82CD30EFBC57B4DC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM/

Found and tested with LLM assistance, by auditing rtnl_link_ops
changelink handlers for this check. The helper and the changelog were
reviewed by hand.

Where 8165f7ff57d9 is missing, the call can be open-coded as
  net_eq(dev_net(dev), dev_net(macsec->real_dev)) ||
  ns_capable(dev_net(macsec->real_dev)->user_ns, CAP_NET_ADMIN)

Tested on the base-commit below against three kernels - unpatched, v1
and this v2 - with netdevsim as the offload-capable NIC, and macsec0
(offload mac) and macsec1 (no offload) moved into an unshare -Urn
namespace; the netdevsim port and an offloaded macsec2 (row 7) stayed
in init_net. ftrace on nsim_macsec_* showed rows 1, 2, 3 and 6 reaching
real_dev's driver unpatched (upd_secy, upd_secy, del_secy, add_secy)
and no row reaching it on v1 or v2 except rows 7 and 8. Every EPERM
carried the new extack.

                                                  unpatched  v1     v2
 1 offloaded  + unpriv "encrypt off"              ok         EPERM  EPERM
 2 offloaded  + unpriv "offload mac encrypt off"  ok         EPERM  EPERM
 3 offloaded  + unpriv "offload off"              ok         EPERM  EPERM
 4 !offloaded + unpriv "encrypt off"              ok         ok     ok
 5 !offloaded + unpriv "offload off encrypt off"  ok         EPERM  ok
 6 !offloaded + unpriv "offload mac"              ok         EPERM  EPERM
 7 same-netns privileged "encrypt off"            ok         ok     ok
 8 privileged cross-netns "offload off"           ok         ok     ok

Rows 1, 2, 3 and 6 unpatched are the bug; row 5 is what v1 wrongly refused.

 drivers/net/macsec.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 6f9f3acef..e019e7a25 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -19,6 +19,7 @@
 #include <net/gro_cells.h>
 #include <net/macsec.h>
 #include <net/dst_metadata.h>
+#include <net/rtnetlink.h>
 #include <net/netdev_lock.h>
 #include <linux/phy.h>
 #include <linux/byteorder/generic.h>
@@ -3945,6 +3946,33 @@ static int macsec_changelink_common(struct net_device *dev,
 	return 0;
 }
 
+/* Both a change of the offload state (mdo_add_secy()/mdo_del_secy()) and
+ * any request against an already offloaded device (mdo_upd_secy()) reach
+ * the driver of real_dev, which may live in a different network namespace
+ * from the macsec device. Require CAP_NET_ADMIN over real_dev's namespace
+ * for those; local attributes of a non-offloaded device are unaffected.
+ */
+static int macsec_changelink_check_netns(struct net_device *dev,
+					 struct nlattr *data[],
+					 struct netlink_ext_ack *extack)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	bool reaches_real_dev;
+
+	reaches_real_dev = macsec_is_offloaded(macsec);
+	if (data[IFLA_MACSEC_OFFLOAD] &&
+	    nla_get_u8(data[IFLA_MACSEC_OFFLOAD]) != macsec->offload)
+		reaches_real_dev = true;
+
+	if (!reaches_real_dev ||
+	    rtnl_dev_link_net_capable(dev, dev_net(macsec->real_dev)))
+		return 0;
+
+	NL_SET_ERR_MSG(extack,
+		       "Changing a MACsec device whose real device is in another network namespace requires CAP_NET_ADMIN in that namespace");
+	return -EPERM;
+}
+
 static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
 			     struct nlattr *data[],
 			     struct netlink_ext_ack *extack)
@@ -3959,6 +3987,10 @@ static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!data)
 		return 0;
 
+	ret = macsec_changelink_check_netns(dev, data, extack);
+	if (ret)
+		return ret;
+
 	if (data[IFLA_MACSEC_CIPHER_SUITE] ||
 	    data[IFLA_MACSEC_ICV_LEN] ||
 	    data[IFLA_MACSEC_SCI] ||

base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
-- 
2.43.0

