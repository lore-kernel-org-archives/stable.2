Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013073.outbound.protection.outlook.com [52.103.35.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05189386C08;
	Sat,  5 Sep 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643261; cv=fail; b=WGQYaytyt3gEiPZjJBbQnWKYCaLgm6xhDw+hh1Olnv95S2WIpDsUfsuS5FN1z0WrRjZpdzwvxpaz4XCfXLhn2dni6QY62olqZF37vBZzE34wdqAE1Rpg6BoGNt+oZRN2x9CCrp3rauR8MZOfH4z9zjV6hNEXaiLyKc2nL/Hq21g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643261; c=relaxed/simple;
	bh=9lcl+bAy+rkRGvE2rqNocOutMyveXctis8h5Y3VU0h0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UjmlOYT9y/YIgAj1ZxDBYuhDUHuwpCMJclLTI+VPbPRGjidCL798dJ4giszjDywga4S1jq3bsOl6kciwPCCYMpB1ky7L7idjCnr9FoxY/9CAYwnKmDZ2TzGIOL+YDz8bg7r0F8BJayykwIV0pDmqwWsNvb8nY2QipcyjqMxVHlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=DstW1UKe; arc=fail smtp.client-ip=52.103.35.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="DstW1UKe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+H+oolPDh2RerUYhAeql6usrDGRwuxs2AK0TMAMM4oynGsX0jyGD8Ms6g0kYdmCueLwNUbGmS9eO+rcKknLnsRzrEIIfilF9Zo9k32WZq7TrwYOlgg0C67MQ0adZd2OHAaWvhVb0gWcTv59P1ZATiPbUC67RNGCAL1UdV8QIHHxVxWUs6VPrqi8ZIkyPN/Y1MQcx78QARI1eXEeJZap4psTjW+eA5T8MPRXsWuNssyS0UMzbptEIWddwJqq/wXe2N2/yiDPruk58dfH1ZPblTpeWdUpVYpnIPP4bLd3qjsfkB6HIvREibhBR9N0ZsU3sgwE9gME/aBInVTUO/kkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ9JW7Mso2SmPw4zEbdc70jslHFfq0UFpeZLlVSdGAI=;
 b=J2qVV9Dq8MMVlvcJ603aHxy+1LzY9dsCRwtgR+hiru2bfk+orS28ZvS8QURKitD/i0X6dh7PTyvO6qHsiVdycTnqWrs73rqbuInF3zloT5xif2z+h4pYVPOe2fq2pVuIPM0bVTExCDAcSIFoMU6snXJGeBx12LJWXuxGgcp1urNTIu3lnrVqVITJjZe8UewIIJ9h54iCpNsx3LLGZGL40tyP8szOGghs4krzVMVid5vD7iQqPdi/CKEiKXJ1sdO/w5w31ZcXDifwmIMiOy+G5X0YKrLTfDgTfpzqWWzowlvc2lX8EQ+pHBWFRuTJgHAM2EJPkPrQoeOsjlmP5K//2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ9JW7Mso2SmPw4zEbdc70jslHFfq0UFpeZLlVSdGAI=;
 b=DstW1UKeU+LwMH0hH3rZhjOQZQt0sl+wrrXHWMDpSf+YrF19HBk+1ZX+bu70Vs/cSfFZCZCCsk5WC5nvnXS0d6XZu17kuu5HhdFBsKRDlUxpGKBF0khXgiMHMCjnDL+EMCRLw9lwXX5mon4PUH2UUVYCENJ8zstlwkGhBMwFsFxQXRkeST7iQjfoYOyVPesCmUxoO6FOoRDP/bIAGOeEOMP88ymsf8XGCD9h6U4AFl/tVQry6w3loAQMKICT65upSGZoxIlutrnbZ8f/96wgPJuSGWyNZj4cYMgcMyEO0I64cA2e7ZlVrVU2+b53zHX3Rk+BGPOVX0q2Geb/kklgHQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GVX0PFBA2CD3E2A.EURP251.PROD.OUTLOOK.COM (2603:10a6:158:401::826) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sat, 5 Sep
 2026 21:20:55 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 21:20:55 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: sd@queasysnail.net
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH net] macsec: require CAP_NET_ADMIN in the device netns for changelink
Date: Sat,  5 Sep 2026 22:20:25 +0100
Message-ID:
 <AS8P251MB000190AAD82CD30EFBC57B4DC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::19) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905212025.40883-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GVX0PFBA2CD3E2A:EE_
X-MS-Office365-Filtering-Correlation-Id: da230748-eac1-46af-6587-08df0b939242
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|25010399006|5062599005|5072599009|4140399003|15080799012|12121999013|25031999004|19110799012|8060799015|22121099003|23021999003|16051099003|24021099003|37011999003|39105399006|440099028|3412199025|26104999009|53005399003|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aRXIh0OPR7OTZzAOPAYwYwZQCcuVF6uhCrLZN7ZpgOOCQehXgJqlbxz4x9aX?=
 =?us-ascii?Q?2SUhe8le+5bBdGKdFLU1f7yDxFaJKt2N8/kRfHKJiCSYvhkMYYggZC7VwfHQ?=
 =?us-ascii?Q?HXemWZ4A0jCXIwTWXDvySneujOtlGvLH498bw4uOvotOD1LyQIVPWFJl5/+h?=
 =?us-ascii?Q?Miyak7KzskGpNQqqw2VVjuZFiWcBaB8etIR1YHlC35wifXU9n4hGxFRn1VL1?=
 =?us-ascii?Q?Y+pjzLIaYrL+iaRz4dmn9E2Fv6kGffXHFk2DuDr2nGSQXgvuA9LHb7gY2W46?=
 =?us-ascii?Q?JqrX0cOqhyGDo+EyLzDEn5FqbGLABkuNAZId9Mis70+eLHTNSsYOeoDImOBY?=
 =?us-ascii?Q?X78fo7GBwa7HaMgay0U6o0fU7eSMjarf421gvvHgTfbMenSmxyhO42MDNZOr?=
 =?us-ascii?Q?hlMelt6hadtzfMWeS7numAyfmGuYnGaqURfoDyB8G6/G/p1WFNL14lqaxn1G?=
 =?us-ascii?Q?7KruPaKakbGzXiyUhK2oLlISNov2TjOXs8UNVDlqalipKqd24/nS8i0efa41?=
 =?us-ascii?Q?KpWLPY0h/tefa0y8FxYNtdLd+1Phu4k12fk/prERB3zBK+RniYCquHkT1HKQ?=
 =?us-ascii?Q?YT2xXZIBV66f2K43nCik0cdAY0h2B8yqIgkqzyzoa4XP9mB2oa+jkRniQSkj?=
 =?us-ascii?Q?KIMy/gF7yxlUa99XL4necafE3MYUNpnI5NiSezR7xuyA9rZtt41jqpcZDdsB?=
 =?us-ascii?Q?lcTsik6E7Zj4A5eorKY+qJN/S+LGb6I2mKGGF7RrS9BBf61fEcauJkBWCQiv?=
 =?us-ascii?Q?UEVLsLkX9Yr5Vv0dPCtQDVflMq9LuuUpu8A7NzT4Y0kIkuCIEl6ft3a4f0qt?=
 =?us-ascii?Q?fP4Gh5fuNXQW1m7OyxFmA0TUzeJ/nvcM+GapG1oi2uZjQqNgkbMjAZ0BymZt?=
 =?us-ascii?Q?EDHERgqj9cR4B4i3Op75lD8EroS5JWNd9PaVVord8cfghKyVVpQOHpHxp9Nb?=
 =?us-ascii?Q?XDhVWoCbSUm+os08AHsqK/ejiQqxAutw0F7x0QFgjOUkcmmPUchpgFbXLorW?=
 =?us-ascii?Q?XHOKYOVl3OgStLIdHFx1nCW7vBo3q+jaS+dzZAJwHS+c72GC4lTokahF9BSy?=
 =?us-ascii?Q?lpx8Hahmz6RBDg3DDr+qFjH3DPvWjmqjoaYPNymZPOeDoPbAlmXpBuVKS3nN?=
 =?us-ascii?Q?rNYylFGSAf8jrYwQMANqx2Iz3SkjEVFNC7R/PGTdIybV+gOTAzwLtko9xfXz?=
 =?us-ascii?Q?kcH1dyC8nuQ7skrcO2DhCCq5hQLwBkKTExM+sg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTJNZb7nR1bES0sFHE7pkIhmQ7z99AJsJGNxwWy0AvFG3Xy9SB8q2Remvt0L?=
 =?us-ascii?Q?v11M/uZO77Uw25juMfOE69u/NHaPm8yt4hzjIe6w2T+HXm2oWYHu0MK2nTsK?=
 =?us-ascii?Q?PadkvTNEvWwCiJOqCPCfh9n0FC8iX+AHT9gE9l/cQi0odJ/Okg0GwB0VUPLg?=
 =?us-ascii?Q?DSg9xNCEG5f8k3BqyEyFWAsJRAyCUAqReuxRCeVH2GroX7FHnBfttEtzsZBK?=
 =?us-ascii?Q?Chati/E3wyzZxd5OAqO63ngMZd7q7eg+At7kpcub1vFiFaF403qXce5Kg6+/?=
 =?us-ascii?Q?pjt+Y2gX6+MBMQsUxZry3uq+ktkCWroAC3urghcRzuYBc9WAJNYu/wvcUq/U?=
 =?us-ascii?Q?+kkNwzwhcaHCPxPSosMXyt/uT5QBp+9QU97u5h4k255EYw7oZdnrNeeF1Yhs?=
 =?us-ascii?Q?3+kfjn4v08K6IqXcXahYq1ayC3Q/yBe+CcKQHwk0txC05TkStbGRkB6X4STQ?=
 =?us-ascii?Q?AbaCrOjOIcKVzfp9md53pqFzBa8YwCUeoo5rfRDj7KCI7g5LiYE2IwYQyBeC?=
 =?us-ascii?Q?soFIJkdkk4nlGdO+srhsq7lB7AWm0l1TyAk0aiAnhCVPNDkcdJEBISnfcSVn?=
 =?us-ascii?Q?gPLPkNWV0j6+npBdcjNsabHpVKAY6koaikPPW7Z4gcRPIgjDXcr9KeqMTu5/?=
 =?us-ascii?Q?jm5uKDTrAHsRSik5f/Gtam9TozWf6oC+EKne2fqMOnpTAUizD6/nJoZqDMQE?=
 =?us-ascii?Q?Mw8AgmiP2RkL0n+trNYVEMIoxo/rqBNRFC7niQ0ji/fbEaMB+8pRnX8zDMV0?=
 =?us-ascii?Q?oZp1Mv7OpCDWYo8EoaZdz6uXrHb/iNOlibCqrbMlVdhHb1tmsXVpCnUb+i8b?=
 =?us-ascii?Q?FHfCqWSZCzD4BNSk4pBM5Xrq9oVR5LeiiqMrr4/RPID6T4vCm97XBpSmq8WV?=
 =?us-ascii?Q?ll9RYMkb68vtqHYvHdUHuFw3rENgDd/1m2xJng5utiDRXSxrhLfgcch7pPK2?=
 =?us-ascii?Q?LnpxEIl7gNqoDvfXNFw8oDll+ZF4kLo4AHdm7QFnhmoHZCIr+8oiapPz8vgt?=
 =?us-ascii?Q?SqYCcIfibPquzwb/tddAkVDVpVXh+0rtzWWcxjt2sMasgpBaw8n5QFpNFUH2?=
 =?us-ascii?Q?KN/u8JNEkqmwSaoADFVkeMnSxw3FhXMCSeN1Yh6EJ5JB+YZ5kTWq/z3U900q?=
 =?us-ascii?Q?YqLQhYqjCa1+Jsdzex4/Nc/1s0IeYC3E1R9iHHtBFV7A7oulbhXKKm2PFN8D?=
 =?us-ascii?Q?faeKlrJUrDSogWwxF8RhFEUhwXBuRfJtqGE/wEgeV8Duw8dhhWOfDgyHq8qe?=
 =?us-ascii?Q?bA6OCTDd6ouZd2vl29hxIkH7mKD6EslggaVL+yWdHoazQx09GvNklI3O56ZX?=
 =?us-ascii?Q?4y4prKUhEAbUVaxNvZvcN+62ovxymHMsSbUyaAftXhZORCZfL7bm+1GnijPd?=
 =?us-ascii?Q?02VUkhP45pbkEWZSKaEpesLsDYro/wQBFBC1wLS26A1wavIUMIDOeDWT4QIz?=
 =?us-ascii?Q?wY28URhlFns6B1GkdQCsE1OjClS1N5XF?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: da230748-eac1-46af-6587-08df0b939242
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 21:20:55.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PFBA2CD3E2A

macsec_changelink() can reach the driver of macsec->real_dev, but the
rtnl changelink path only checks CAP_NET_ADMIN against dev_net(dev), the
macsec device's own netns. That differs from dev_net(macsec->real_dev)
once the macsec device has been moved into another network namespace,
which is the ordinary way of handing a virtual interface to a container
while the real NIC stays behind.

Two paths in macsec_changelink() cross that boundary:

  - IFLA_MACSEC_OFFLOAD -> macsec_update_offload(), which calls
    ops->mdo_add_secy() / mdo_del_secy() on macsec->real_dev.
  - the tail "propagate to the device" block, which calls
    ops->mdo_upd_secy() on macsec->real_dev whenever the device is
    already offloaded and any other attribute changed. This one needs
    no IFLA_MACSEC_OFFLOAD attribute at all.

So a network namespace administrator with no capability in the real
device's namespace can toggle the real device's MACsec offload state and
push SecY parameters into its driver.

Reproduced with netdevsim, which implements NETIF_F_HW_MACSEC:

  # privileged setup in the initial netns
  echo "0 1" > /sys/bus/netdevsim/new_device
  ip link add link eni0np1 name macsec0 type macsec offload mac
  # macsec0 is then handed to a container: moved into an unprivileged
  # user+net namespace, while eni0np1 stays in the initial netns.

  # from inside that container, with no capability in the initial netns
  ip link set macsec0 type macsec offload off     # mdo_del_secy
  ip link set macsec0 type macsec encrypt off     # mdo_upd_secy

Both succeed, and the netdevsim driver in the initial netns logs the
corresponding SecY calls.

Gate the two boundary-crossing paths with rtnl_dev_link_net_capable(),
matching the "require CAP_NET_ADMIN in the device netns for changelink"
series applied to ip_gre, ip6_gre, ipip, ip_vti, ip6_vti, ip6_tunnel,
sit, xfrm_interface, geneve, vxlan and macvlan.

The macsec_is_offloaded() term is required: without it the mdo_upd_secy
path above stays open. The check is deliberately not applied to every
attribute, so that an administrator of the macsec device's own namespace
can still configure a non-offloaded device, whose attributes are local to
it; this follows macvlan, which likewise gates only the settings that
reach the lower device.

Scope: this closes the changelink vector only, which is the sole way to
turn the real device's MACsec offload on or off, and the only way to push
changed SecY parameters to it. Several ndo paths also reach real_dev's
driver as a side effect of the container operating its own device, and
remain gated only by CAP_NET_ADMIN in dev_net(dev), as they do for the
drivers in the series above: macsec_dev_open() / macsec_dev_stop(),
macsec_common_dellink(), and macsec_set_mac_address(), which calls
mdo_upd_secy() because the SCI is derived from the MAC. Those are a
separate question.

Fixes: 3cf3227a21d1 ("net: macsec: hardware offloading infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Found and tested with AI assistance (Claude Code). The bug was located by
auditing rtnl_link_ops.changelink handlers for the netns capability check
that ip_gre, ip6_gre, ipip, ip_vti, ip6_vti, ip6_tunnel, sit,
xfrm_interface, geneve, vxlan and macvlan recently gained; macsec and vlan
were the two that did not have it. The reproducer, the fix and the
before/after measurements below were run on a KASAN kernel under virtme-ng
with netdevsim as the offload-capable NIC.

Notes (not part of the commit message):

* Verified on netdevsim across three kernels (vulnerable / unconditional
  gate / this patch), with these cases:

    offloaded  + unpriv cross-netns "offload off"   -> denied
    offloaded  + unpriv cross-netns "encrypt off"   -> denied  (mdo_upd_secy)
    !offloaded + unpriv cross-netns "encrypt off"   -> allowed (local only)
    !offloaded + unpriv cross-netns "offload mac"   -> denied
    same-netns privileged "encrypt off"             -> allowed (no regression)
    privileged cross-netns offload toggle           -> allowed (no regression)

  An unconditional gate also denies the third case, which is a needless
  uAPI change; hence the narrower condition.

* rtnl_dev_link_net_capable() was introduced by the tunnel changelink
  series. Older stable trees may need that helper backported first, or
  the check open-coded as
    net_eq(dev_net(dev), dev_net(macsec->real_dev)) ||
    ns_capable(dev_net(macsec->real_dev)->user_ns, CAP_NET_ADMIN)

* VLAN has the same gap and is the last one in this class. Toggling
  VLAN_FLAG_GVRP/MVRP runs the GARP/MRP applicant on vlan->real_dev and
  transmits PDUs out of it. No driver callback is involved, so the impact
  is lower, but there the mutator is also reachable from the SIOCSIFVLAN
  SET_VLAN_FLAG_CMD ioctl, so the check has to go in
  vlan_dev_change_flags() rather than in the changelink handler. Sent
  separately so that the two can be reviewed independently.

  drivers/net/macsec.c | 8 ++++++++
  1 file changed, 8 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 6f9f3aceff..0f351e839f 100644
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
@@ -3959,6 +3960,13 @@ static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!data)
 		return 0;
 
+	if ((data[IFLA_MACSEC_OFFLOAD] || macsec_is_offloaded(macsec)) &&
+	    !rtnl_dev_link_net_capable(dev, dev_net(macsec->real_dev))) {
+		NL_SET_ERR_MSG(extack,
+			       "Changing a MACsec device whose real device is in another network namespace requires CAP_NET_ADMIN in that namespace");
+		return -EPERM;
+	}
+
 	if (data[IFLA_MACSEC_CIPHER_SUITE] ||
 	    data[IFLA_MACSEC_ICV_LEN] ||
 	    data[IFLA_MACSEC_SCI] ||
