Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792476416;
	b=H2WjxeaOcL4okOTLtBTEbSECsRDuE9PGcjREiKBLQvj0QyxkqouhXqnaXydRpBdzLdwk
	 c6aYowGDs9+aARKGxmof6tmfPLjfE6tAu/X4nqVtmCGU7v6G+FUsr/AF6CZb4anKTPqpC
	 B0oVlTrsLbrM+7RrmZSW59v5lun589KPVGAa2tTgNNeL1D3k90I18q7d4JgbJpkpkJKZE
	 MzPiYG4WxL4aK3gudBG8Rg37zIamC+QNdhh6oKHPm4MIYRV6B1r0Bwvj+YldnY9Nsb4NE
	 Uis++aTorMb5q4NcoRzpwxEKMzPHbhIUlmFjz1cix4XuSBUhe13D7Yo1CyjnlpBfHRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476416;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ou8BIdP9qebQ4+xOOMXEDLhaQg4O1pDabtUOyosu1xw=;
	b=VzsgGEYOTRtHmGDQCI1YCTV/Gpsw5KqaiPlOS3McxQmxqL0FJ7Dyr/V3Ce7vDrT5A320
	 e+oF7u79wbFhtF8V80/HGoaZ1P29dZtI3bS5nkjnVNbw4W0xpzzn52siLu+coawmbgtW4
	 PNHntZSUT78o3N1v7VhSiiDm3mvOythSPpUv815dhy8cnZmYuXGtWvqqIJ0XU7joe6EzM
	 ZiejsOdVqGwh5tsTEXmGxPU9PkQ5SrutMXrbVCgh4PBz4Iv2sCr10Mdv4mfk8L9zjyk2K
	 42qC3Fq1SrigTivcXugaw1PqH0YWN7o4ikKmiJS/d4oAXJ63bCCGm8GIC8Kk2vmP5cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bDbNV0l9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.58
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C62606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bDbNV0l9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknodtlNzxMOk+GufnKcSSZKhgMGEq6+hb9Jh762pcKI4ioU6OGDsVM6/L+Cg61FN9tI1asdeMs/uPAmUZ3px1ES+vpy32McfkApZfIUPIyRfZw0r1OFr11f0Is5rSd3IhPoCQ9C93JMWTSrIEHdAYR8p+NY7zUZBqz9l1dZClNNABiJbaxs35ocGXiRHJLDPGWG9HVJGlP2n/6f1vGJZuzTGLBuG04wjgD1yKzOo6f1XJksvtwMuXDoUw13awQVayfnv99OFw0NAaC9X10FCYFYPnWGh2UkkFEi91s7aTOSNGvNA5H315+DIGUA1srFPW2CBFfhGXXOtplodXtFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou8BIdP9qebQ4+xOOMXEDLhaQg4O1pDabtUOyosu1xw=;
 b=rt82VHo0kmIEm2/VL8HGEVMQdoM2PVHIn+QuoUkAxdmyVYjsb8fgYT4JVcVKfcRznPBAICx01iqYXE7J5Vu3KXeSquX0XlTQlQMaW0zfMUIJeC9g+eHpHFuJdi//u46g8j7NZDQsN8FU8YJ3DmomalGeWbPKF7SyQc/nxtUfVen1uUCKNAe/fQc1W+kv8pGB2pAED6jlHYcxmNOOlYOv9beWvCMHGsdwwdmEoKb39jzSjWlbHVxvDIImL/C+IHEHkiiCCI1A5UtMmStuUzRgbjgLJriGxJokdU3r0ASWAvJ5dI28KBquebB87AYPxeh9o+hT6BjppXs8sm1acVy4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou8BIdP9qebQ4+xOOMXEDLhaQg4O1pDabtUOyosu1xw=;
 b=bDbNV0l9umlV0i6aZ2kKfevCL/q0SlunajTsYddDkQoWHvrySwyOP74hz1jERlVzMblWtn2wm4EENfGXhd5cE4TbLPrED7eW5W4yij8q6A7T/Xe3f3+iuiVTJ+5c/0xMNFqB4YoEiG2DmfGzoEFwen7IErJUEplAyKqysjzYI5Y=
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by IA6PR12MB765073.namprd12.prod.outlook.com (2603:10b6:208:5fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:06:53 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:06:53 +0000
From: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
To: Matthew Auld <matthew.auld@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Shashiko <sashiko-bot@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] gpu/buddy: do not pass caller list to
 __alloc_contig_try_harder()
Thread-Topic: [PATCH] gpu/buddy: do not pass caller list to
 __alloc_contig_try_harder()
Thread-Index: AQHdVYLzrOiuonmVP0iIadzHhmsTCrcGBunQ
Date: Tue, 20 Oct 2026 06:06:53 +0000
Message-ID:
 <DM4PR12MB5039955C1A48C78942896415E4672@DM4PR12MB5039.namprd12.prod.outlook.com>
References: <20261006110706.1636971-2-matthew.auld@intel.com>
In-Reply-To: <20261006110706.1636971-2-matthew.auld@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-20T06:05:11.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5039:EE_|IA6PR12MB765073:EE_
x-ms-office365-filtering-correlation-id: b61f1abb-74c7-49a4-7a05-08df2e705686
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|261009223027099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 JlCHkCdt267Mn2oPNlTHjcihWHPFk50B7R+bb6toyBXbp+4IdaFCEzQ+pBT3zNCnYQz2D7pMR+aiEdXE+sw8tTaK7g75l468WefFifsK0mGzP6wmHdLeR2grzB0/fHKaTiQC1lKQpzMMaNQcsTMgzwm08dhwodzFDftkcSxIT79ZRfCHC/rRUP/JUW/K9F48Uw9mozMvG1gWH27A0EL7eTn6I3yyJzWOcjEAGDBjtaTfuCz3a0T+RhpAHqmw+847bV9vplHPATXaHB5/aTwbZwLEhdYqJrNHFbb+mGJmYtXDQKa6Sg/pogARriHieM8q9EswOkkvfTx3ay0KvpwtfW+cs8Vc6GyCyaPwVQFUoCqrE54jB8AvkVJ/uVGA0tiTEyc12cF21gqD1PixgdeooOMeyONvSqSimJognK0/P8ZA3NhqJpuuOr3mBsM+5ocLgtpn7C2GE3o9mmHtpOp/VzLwQN2JvnNCdthkqbPcdk+HgLHwaR1+iyegLfAFvANmsaY5b+81oTcrIKSxI7bF0fYto8crNSk6cTF7U76jU/pHFJFVAWGXeSRanXU9QzSqygcqKM1P+8OASYTFZAOsx6xhMJneBPXEPM4qd3t4heOh3PNtD9yMk2EDyR53fqWliEQbMbF9ucRvzu5XRroJ9grrzQRNcmwBXV2/xjl1EQw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(261009223027099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9O9uYAVgI0P4weKl4OF3mjWWkDG0cRjpFTOacFUhcVYUVTqOwPkdw5GFMD7U?=
 =?us-ascii?Q?YkQOcxY4h1uKNfgpmjmwpS3iHj8uIFcEOttHxMrJ47C0Ibe9/NoyLx14nvU3?=
 =?us-ascii?Q?a/2asCwGqTvHltP5RMefJ8bcubh/TPXTeIkldvRMGF0pWJ3tuDL0U8rBTlof?=
 =?us-ascii?Q?+iIlY2JTBuxWVKKfNEWTb9hWae6S9ErjG9OPRnxM+YxpTOshry4s8dLov4lD?=
 =?us-ascii?Q?dgvR7/FDZgZ7YhHF6jIegTRt6kSA7NSh2avywEAu3msPFi29BL5tpTh0WQaG?=
 =?us-ascii?Q?eHHl3HlvOSlr3jd9+U2gu9hp4PWceKI35cHgDqrLAEAK3CsiAX5tAaWgGxHA?=
 =?us-ascii?Q?beFC0eK7RCebZyn9nxcZf5JkxIoXaylC1QhPh4PidVA6CXK78QrOgGzahxK6?=
 =?us-ascii?Q?UYYXI7DYHbiaNfBvOeC3zG8e3PDKOiISOviM8pfaS0wt4xrC0hj2BID94Yug?=
 =?us-ascii?Q?CDf2VWPfu8pk/JylRNlqWapXrMEj6U1c3eZ5rfeyDHier/1OA8++QgxUVZIh?=
 =?us-ascii?Q?/kj4LnMIa4Ug7ZPl1VCQXlW0c5qaDCV3Ry23jRMPdzHusuwb9cdZ30hZb5v5?=
 =?us-ascii?Q?l8lKW5LDA03RxXTZtUT3obV/ZJ8sVq5cwfb94psF8/twgNbzLz20r2EZaQUk?=
 =?us-ascii?Q?o5hNto8lTQr/O2131BJlNWGt3BNXA+Tk2PA5jL5TmnFYPmROcTt/x9vVz3sC?=
 =?us-ascii?Q?xHrooHeeVoNd5OKkRe9UB7jHPwK7mj0In2Lj9Hqal48tmUcuztdHZmUXlqpc?=
 =?us-ascii?Q?tbU7pxofK5Rf9zdccpRa3r+qoIXJ2kre/CsyoA2R45VjWODbmbrDflXCCktG?=
 =?us-ascii?Q?7v6bO+LnuKty+9ixD7tmeR9xQ99xffv1xrnU9/hfu28Cmn1ibwYPajnu+G9m?=
 =?us-ascii?Q?kNGoGH1CeCC7Z4hs04Znsff3HfHaG4JkWRwzkf84eQ7w71yCFRsXi2T3FqVZ?=
 =?us-ascii?Q?864e1y4VZYKsl68T/yKO3lbi/3ENWLkkNnysCZ8cOZulJ9Xp5bKMchSgP0C3?=
 =?us-ascii?Q?nM0VsIAzkgIfpX7jin7Oi5NI2U3cdfZVjkf0amKe0D2QKlF9WqvuFXhoKqUX?=
 =?us-ascii?Q?RYE14NMSYOYwxJCsO3yYYQJR9nGxbfnQdrxy195pMojBn6euW+UMyh+byO/D?=
 =?us-ascii?Q?73yad0PwD8IdGgJSMRoFKCqpHE0O3OvM/K5Z7enphFA286adb3EHKPjU3vFn?=
 =?us-ascii?Q?pBQ6xriiHVf916ZMWESBp3cZn9M/Jt36sMtShh4cjKXtRSYayDDo6VCk5Uei?=
 =?us-ascii?Q?zFC9+MkNXRTfguAdT5DSVkmveaVfVrwHCMbDmhzLDAIPNVlXvH28Wg1KaUV8?=
 =?us-ascii?Q?jqXKNuZsChwWi3Kn4n/E3ObX8D8VTKD713dJoAKoHZoanTOGB/2Rv9MeLtVA?=
 =?us-ascii?Q?2WPsJoo1yH4YNx3t+Hc7PMF6w1RY1V9m8EbWWHZSgivWJRuv5DqNGfAONehV?=
 =?us-ascii?Q?GXFKAdkhL3lH9a5Av9iFxgZ5BC4uJkPJ+oQ/34NQToGo0czwbtpBYJGSdCy0?=
 =?us-ascii?Q?0PGQyVDk/sZ4OOziIG/uZS/CzoLhUX5R06mQ/fE3k03Zt60hlGIMWX8I6lcT?=
 =?us-ascii?Q?cgBihXja+RSmm9Zg2c6UEBMYWxviVsUVpIhwxKE1oyE8ms+1cmIbIrt6fy2F?=
 =?us-ascii?Q?XaOWp7sqRWMKybWrZVxifYgEdB4PM06E86xiYVOGOiZX9skXy7g/trVwPdes?=
 =?us-ascii?Q?ZCOpxVe40ewkvd/VRjIpHc/DJ4JafwE1S6YTkk1q5v/80KJ8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61f1abb-74c7-49a4-7a05-08df2e705686
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 06:06:53.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kj1tjg7yGo/y6QN8SJmXlreF+i8lpuVY0vgg7hp2aRyeNhcsvzejWTROTPU5gd4NA52ZdbitW9cOSORDaAzKgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB765073

AMD General

Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

-----Original Message-----
From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Matt=
hew Auld
Sent: Tuesday, October 6, 2026 4:37 PM
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org; Shashiko <sashiko-bot@kernel.org>; Pan=
eer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; Joel Fernandes <j=
oelagnelf@nvidia.com>; stable@vger.kernel.org
Subject: [PATCH] gpu/buddy: do not pass caller list to __alloc_contig_try_h=
arder()

If the caller passes a non-empty blocks list, __alloc_contig_try_harder() u=
nconditionally frees it on failure or during retry.

Pass the local allocated list instead and only splice it onto the caller's =
list upon success.

Assisted-by: LLM
Reported-by: Shashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fa721daf-7333-48b5-a26b-624c7f5791d=
7
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/buddy.c                | 20 ++++++++++++++------
 drivers/gpu/tests/gpu_buddy_test.c |  9 +++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c index 2f2aaadafe35..=
a86f454fbb40 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -2022,10 +2022,16 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,

        if (order > mm->max_order || size > mm->size) {
                if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
-                   !(flags & GPU_BUDDY_RANGE_ALLOCATION))
-                       return __alloc_contig_try_harder(mm, original_size,
-                                                        original_min_size,
-                                                        flags, blocks);
+                   !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
+                       err =3D __alloc_contig_try_harder(mm, original_size=
,
+                                                       original_min_size,
+                                                       flags, &allocated);
+                       if (err)
+                               return err;
+
+                       list_splice_tail(&allocated, blocks);
+                       return 0;
+               }

                return -EINVAL;
        }
@@ -2064,9 +2070,11 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
                                                                original_si=
ze,
                                                                original_mi=
n_size,
                                                                flags,
-                                                               blocks);
-                               if (!err)
+                                                               &allocated)=
;
+                               if (!err) {
+                                       list_splice_tail(&allocated, blocks=
);
                                        return 0;
+                               }
                                if (err !=3D -ENOSPC)
                                        return err;
                                goto err_free;
diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_bud=
dy_test.c
index b75d32ca6ca0..2c6f1da1a6d1 100644
--- a/drivers/gpu/tests/gpu_buddy_test.c
+++ b/drivers/gpu/tests/gpu_buddy_test.c
@@ -1235,6 +1235,15 @@ static void gpu_test_buddy_alloc_contiguous(struct k=
unit *test)
                                                            GPU_BUDDY_CONTI=
GUOUS_ALLOCATION),
                               "buddy_alloc hit an error size=3D%lu\n", 2 *=
 ps);

+       /*
+        * A failed contiguous allocation with a non-empty blocks list
+        * must NOT corrupt or free pre-existing blocks.
+        */
+       KUNIT_EXPECT_TRUE(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
+                                                      3 * ps, ps, &allocat=
ed,
+                                                      GPU_BUDDY_CONTIGUOUS=
_ALLOCATION));
+       KUNIT_EXPECT_FALSE(test, list_empty(&allocated));
+
        gpu_buddy_free_list(&mm, &left, 0);
        KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size=
,
                                                            3 * ps, ps, &al=
located,
--
2.55.0

