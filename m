Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011035.outbound.protection.outlook.com [40.107.130.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBE40B0EA
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897894; cv=fail; b=cjrnHYWRNEuYo8SSUER5XBFHMSULDiH39dba2b1iJSbDUnDrFPf/H2ZtVupVhbQpoXcr0FscnKNn0K2svN+Gxk5uOScY1gKlYm13hcp06AMvjwrfSY9ZfqdTD/2DQ7hYyrWm0HMkEBCLZq0xY+D9Yay78tZ3OBWN9LXjjm563s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897894; c=relaxed/simple;
	bh=ht6xAUa61UZLyp3vfBo9TDEnZ542fTP9tdYHxJDAaaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dh3SRmoVBV9+BFn8Rbsvg7hiw+ehfDXOSgO8mYRIj7K3I5GbBz6za8wJtcjZQtTVh6IIxBuq8ypeHLvJgPY+CBqscCPjWyRiRhF+M3GX4u7P4VmZmBzaXacJB4ecVJmN5gl84lV6bJQq9/6cdsinx/BLZNNok1tvHm/4JnsrVI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=lKGIYrt/; arc=fail smtp.client-ip=40.107.130.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="lKGIYrt/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYgOSY//mG7SnUdn26fWU4AB7fepSb6RY5wLBrItj4V4CADzGWPJh0XbSLQ1Q7/BrUVePXrjRFnhTGxRgcjU0A0QxYRnXkksTea0LvA+33RSUxz+rxXiNdBRC7rcxLaJcEyMlHF0cYRDXjUkEB0yxwh8QgxVMGgPHgGv8MV5mGtgY0OBzSCypAZ83g5isLZKm3xFvvSaof4n/xt09HFA8fi6h7GJRiWzRdyk6mrdFMifBKhPmWI6plXrFYR3MoijKa+h4HQzyqgT1ev5nB47a2CInfcbLBuhB9NLphWwJi3zhGZANqJLq60EGCInb4JikZMtjsxpHHZUWEYTfe8EqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn15FPAdVf2Qj4B3PMdrrt3990bQhnzlG2I7sWVq6S8=;
 b=ClYcdS4xuU7V93//Ceaq6IMZUiSPtbM2eRrrwRraQ7FcmMxeVaAiyM/k3H+COPMC1xIp+O4n47VSrcGASfo2QHsP0GN/0YwTI0qhsgjH9tTS8P3fD3n83vsA/DwoWCf3MdbdvTlWIcRC/Y6JsUiYrRw0qdlNAtcT5pR/5brLrK8AfvT/BaaZcVtDQIWAnT1rtOJGhJwpB5pHGDXjJKH6Tu5m6pmDlKXfGI3qy/N3oRCnbIk4ZdIpYON6Xom5ODrMLmB6osMiv4LNq/WxpjGI5vv0TqfRfirsA8MDpnonHyksyz4rzAgrF5r1r5PvpMinEf5AhQJiFxAe6+iQIYBspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn15FPAdVf2Qj4B3PMdrrt3990bQhnzlG2I7sWVq6S8=;
 b=lKGIYrt/f7RiKKJ25wRGSoLmZXtKQERpifea9YDFCGEdClowBxpMlJG4d1Daiq7d1AHK4YCl0N5+c/qXxNoNuIDhRUJ37MKCrbH9U4+rERjypAoglz8PA7o+igqYwEJ/nxHBwueDaXTAxOtwWk79wYNcNNV4k1ITszoCE1w94Hs3rLNmS+CavRrM9fNwBWPEV8poDWfkoEd59Smmk05oAo83eK34OIb/V/HNleXCyqVXAQgrAeeGnyF1MRq/YgVGDrtMwJCP80/h/PJ/7eWIQeBCUcPcMAwwJMwikgXzVY5uILR6yVErnC1xLwT2ROuHgdV9W8cFlmJyxXRdkUyxig==
Received: from PAWPR07MB10071.eurprd07.prod.outlook.com
 (2603:10a6:102:382::17) by VI0PR07MB10224.eurprd07.prod.outlook.com
 (2603:10a6:800:25b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.4; Fri, 24 Jul
 2026 12:58:04 +0000
Received: from PAWPR07MB10071.eurprd07.prod.outlook.com
 ([fe80::1dcd:8631:dd7c:f813]) by PAWPR07MB10071.eurprd07.prod.outlook.com
 ([fe80::1dcd:8631:dd7c:f813%6]) with mapi id 15.21.0270.005; Fri, 24 Jul 2026
 12:58:04 +0000
From: "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Please backport 101f3498b4bd to 6.18.y
Thread-Topic: Please backport 101f3498b4bd to 6.18.y
Thread-Index: AQHdGnEWTqj4qCpD9kasF8HeqNc6+bZ8iJOAgAATGvE=
Date: Fri, 24 Jul 2026 12:58:04 +0000
Message-ID:
 <PAWPR07MB100712177EB29A65F4385E4C29ACF2@PAWPR07MB10071.eurprd07.prod.outlook.com>
References:
 <PAWPR07MB100715EA5D8FCEB34B9987DF69AC02@PAWPR07MB10071.eurprd07.prod.outlook.com>
 <20260724105500.stable-0005@kernel.org>
In-Reply-To: <20260724105500.stable-0005@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR07MB10071:EE_|VI0PR07MB10224:EE_
x-ms-office365-filtering-correlation-id: 784b0a3a-cd1d-4ba3-4f4c-08dee9833378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 RuYVwALB6juAURNenRoYVFxNasTi8Icxe8IYrbU3qxQrCsM/W4F84+nk0/EFYkq9b6sDxyYKplihIdRCObq2o0ezdGQzGeVL/itZ640jU31B2plH2d4vnccbPv9apwE7ws2GZPCe9sa5VUUZEkxTW4D1taUAj+ZPlT/1dUZwHUaLwYSbpM72NC3jy3h3ZpFwKAX0Td7gIreBdDAhWIznBh6pXGKAYbJonmK6QkNt6cCHO7kz/LZ5rChr6CT3MPo7bNJrtu3XFOvI4YApLiKhwJBjbHvBbbToRygQ7pHT70bal8JtOzdfjiAGyHJHflNHGXLfaykCwylt2kdgxFBNFZIp5+M9HW+NfGTO84NA7wC28Dp7EhjIdlNF5lsuRvLrTZ3uRktbPCB558I3OfdFFJ6bmh50ORPll0AIIQHIp2GbhdjvKW221O66R69bzb4s+UJXpilFXq8y/oZrn/ePPNSEQkjWCOrJrR3/RyYZ/9Rb9/vYS8RT+6VlYtsM4BebUbg/Lqeb6P50mAmnhrc0pkjG+3juG0HpNstL+MP/pPdfzKS6+HH8PDiTwE5SvNANYliBIbuL8HJcrjNShaSLJnUKavSpBS+UY666LJSthebEw4ZfviDo4yxQ7V1JM89N+zFqAhxlOL2uGFAL+UqiX4ZuLIPaSm9M1KVqofdrPBsKAPhbBv7WXCQHssuQknN65NxvE+fy3vH6gACZaoggqKpjCYRNwAf6iucjgr3C8Ts=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB10071.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Fl4Ks3qAHHRWjB+OR33TwjrhhyLR6soUeQidECkv8DyiXS4taSIyvmjhFI?=
 =?iso-8859-1?Q?fhLiVPt7F3EqKk61l4euBZ/N4Wq59raEYJIx989AEZzYkszauRdDHoW+PL?=
 =?iso-8859-1?Q?t/Edbw5oBNiKIs8oU9gVlY4i5CoSjnMbscPZQQst4aPvUlon15fTjlLNfz?=
 =?iso-8859-1?Q?QWXy0xLVxksEhhuZCuAcbzMf4PliQFYZTXcp0Po8/Kt6+FWtuJq2mR8TBz?=
 =?iso-8859-1?Q?PMDiwGVjq3SZBGolZiuj8h26xQF4buaPmnQoUtuoZnqiJLFE4rSnw75cWy?=
 =?iso-8859-1?Q?qrKX9WCAjr5bPBE9IVpV7auYFL1h9QNvOPoRZmKQVB487wKnMOjU9K8Pkc?=
 =?iso-8859-1?Q?J8FCi36RXUuHMZPb+o9RFvIziS/9djRkoOciNKVgvtDXAocUOgMe56btEN?=
 =?iso-8859-1?Q?wQck2IU7gZpHjgtL0Ujf5DUctZh7SK2MIGm32l0eO4hvXvJLtG12/X2DfX?=
 =?iso-8859-1?Q?xy0dg6OBMmvatJDQGF7MqkomBVsshT/SS1Ca8rBQ+h5GQFsnb84OwRbk4W?=
 =?iso-8859-1?Q?OGkkVpsMlXT3bhe7+BOYhIw4yTk6a6vjI8O/zWiGyJfmPz9Y6leeMT6EYk?=
 =?iso-8859-1?Q?WYXhDAz0fDmYpbU4NsJkdIJY2u4dxjSzclx3sCvuYo0VAlaM+lAx8RRjQ8?=
 =?iso-8859-1?Q?DpsumzivTZl5MJAbwoMdYvWJUr26mhhM2V3BdmwlVSOTJRoqB4BbaVS5rU?=
 =?iso-8859-1?Q?YCaKgOz1m5wl+PHycXNKf9B5Dt7e+LXLhSeoFZGTYMv6LB59s8/qbc0KRd?=
 =?iso-8859-1?Q?YCurbmKZsyBWuoGKvmzqew0wp6hTFoA8OztA0W9e7Hv9tz4mRK9qLUYUaT?=
 =?iso-8859-1?Q?OfkEuxgyPXXavUdq9i0lL/5K5akkxLziOcl8xhnVhCHhQHtV2BW2sVQAGL?=
 =?iso-8859-1?Q?9d3h0vNnfwOZQXPUj2XSFWcetzGCcHyUAaC51jOwQ3JgyN3e+NaVAcL+hC?=
 =?iso-8859-1?Q?tEhECrgh2VX3n4gh1lZCKX8zxOf45W3/k7AP13kRsClYxLXblrNrqaQnuO?=
 =?iso-8859-1?Q?AhpyyHKYlJi4X4DZW3aGLuHb4ONgpcN9a0nQCWo6clQev8eeifBJCULhao?=
 =?iso-8859-1?Q?wCanwdcc8Z0RuXJfqmk1tJpY1CZatc8qd+i4tdj8hi/YKx6D8YVJWKhoim?=
 =?iso-8859-1?Q?M20RTkal4GZ0ljp4Ov6tSPEPHLxP0fUS5GM74kXAsqyKgt/W0ZX5MuGeUF?=
 =?iso-8859-1?Q?CEBjL5r/lUzp8PMWQWF+h8Xn/0+b3PN6fJUFeq7vT3LFkQI9qxKlYVaqmy?=
 =?iso-8859-1?Q?whvt3e6i+sK5PqdJygLZbfjsV0GKtHb8LWdfeQxFHiufAbzIp/LD0dq63d?=
 =?iso-8859-1?Q?bzlaR/Vjbs1sepxxridJV1dfaf7VfqyvKqJ6NK/jehdcet0vDLdU9c4JD4?=
 =?iso-8859-1?Q?f/AVrElC6BOVB1hJZjj8puBIybh8CO2oCaNSky96nnr7C2GjZVqDVZ/zMd?=
 =?iso-8859-1?Q?UBRR1ivFx8gRdTDy/O/Dm+mtRbHkpbrqtHQ9yvSxcVwXzctuYGWJUDmbU2?=
 =?iso-8859-1?Q?rs4QWtxH0qcDnGoKcHE/PCFVpGIzNzpv6p/hjhAU7OHV64W5zddkmJ4nlG?=
 =?iso-8859-1?Q?9tjGLvdxMCd5KT9CRc+vcfWoIROVkgg+R1uMf0hFRJnOp49j/P2jtlgHmN?=
 =?iso-8859-1?Q?Dd8G8Cy5oKddvcp5wWV01YcSW9PaSxL1Sa2gPDxpGk3pNvKL4EjuHsrqVq?=
 =?iso-8859-1?Q?kj+fzWlqzTYBxGAoFi1++IGD6AN1U1qtpt7D9ZNFHsCiAZ2js3Y2SHZWo/?=
 =?iso-8859-1?Q?cztTzoMBGgS2laF48jGX1PliRu7iZGeqNGAgXmhfHbI/WsV+sxacXrn5bZ?=
 =?iso-8859-1?Q?Bx0x4CGlHw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB10071.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 784b0a3a-cd1d-4ba3-4f4c-08dee9833378
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 12:58:04.6538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2cYuRMTIrRMJja1CesnXjROrbzM8pjJHUr87gmYN8rHrCBKpLGsTBifXw9F9P8V38JTPydxJd2Z1R8w2Tq9UniZmwUISStGmJDz/nH6IVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10224

> It doesn't backport cleanly. Could you please send a tested backport?=0A=
=0A=
My attempt at a backport is below. Apologies in advance if the mail=0A=
system mangles it. The only real diff between this and the original=0A=
should be the use use of div_s64 vs div64_long + maybe tiny bit of=0A=
patch context. I leave it to the real experts to say which divide is=0A=
correct, but at least this applies, seems to fix the issue and we=0A=
haven't observed it to cause any new problems. It has been running on=0A=
the affected servers a few weeks now. It must be admitted though that=0A=
if this would somehow for example make the CPU shares incorrect, we=0A=
wouldn't necessarily notice it. We just noticed when some operations=0A=
got totally stuck before this backport.=0A=
=0A=
=0A=
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c=0A=
index 7e0e2044d840..6bf765c8b6c3 100644=0A=
--- a/kernel/sched/fair.c=0A=
+++ b/kernel/sched/fair.c=0A=
@@ -764,17 +764,22 @@ static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs=
_rq);=0A=
  *=0A=
  *   -r_max < lag < max(r_max, q)=0A=
  */=0A=
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *=
se)=0A=
+static s64 entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, u64 =
avruntime)=0A=
 {=0A=
 	u64 max_slice =3D cfs_rq_max_slice(cfs_rq) + TICK_NSEC;=0A=
 	s64 vlag, limit;=0A=
 =0A=
-	WARN_ON_ONCE(!se->on_rq);=0A=
-=0A=
-	vlag =3D avg_vruntime(cfs_rq) - se->vruntime;=0A=
+	vlag =3D avruntime - se->vruntime;=0A=
 	limit =3D calc_delta_fair(max_slice, se);=0A=
 =0A=
-	se->vlag =3D clamp(vlag, -limit, limit);=0A=
+	return clamp(vlag, -limit, limit);=0A=
+}=0A=
+=0A=
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *=
se)=0A=
+{=0A=
+	WARN_ON_ONCE(!se->on_rq);=0A=
+=0A=
+	se->vlag =3D entity_lag(cfs_rq, se, avg_vruntime(cfs_rq));=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -3838,23 +3843,125 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sch=
ed_entity *se)=0A=
 					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);=0A=
 }=0A=
 =0A=
-static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, i=
nt flags);=0A=
+static void=0A=
+rescale_entity(struct sched_entity *se, unsigned long weight, bool rel_vpr=
ot)=0A=
+{=0A=
+	unsigned long old_weight =3D se->load.weight;=0A=
+=0A=
+	/*=0A=
+	 * VRUNTIME=0A=
+	 * --------=0A=
+	 *=0A=
+	 * COROLLARY #1: The virtual runtime of the entity needs to be=0A=
+	 * adjusted if re-weight at !0-lag point.=0A=
+	 *=0A=
+	 * Proof: For contradiction assume this is not true, so we can=0A=
+	 * re-weight without changing vruntime at !0-lag point.=0A=
+	 *=0A=
+	 *             Weight	VRuntime   Avg-VRuntime=0A=
+	 *     before    w          v            V=0A=
+	 *      after    w'         v'           V'=0A=
+	 *=0A=
+	 * Since lag needs to be preserved through re-weight:=0A=
+	 *=0A=
+	 *	lag =3D (V - v)*w =3D (V'- v')*w', where v =3D v'=0A=
+	 *	=3D=3D>	V' =3D (V - v)*w/w' + v		(1)=0A=
+	 *=0A=
+	 * Let W be the total weight of the entities before reweight,=0A=
+	 * since V' is the new weighted average of entities:=0A=
+	 *=0A=
+	 *	V' =3D (WV + w'v - wv) / (W + w' - w)	(2)=0A=
+	 *=0A=
+	 * by using (1) & (2) we obtain:=0A=
+	 *=0A=
+	 *	(WV + w'v - wv) / (W + w' - w) =3D (V - v)*w/w' + v=0A=
+	 *	=3D=3D> (WV-Wv+Wv+w'v-wv)/(W+w'-w) =3D (V - v)*w/w' + v=0A=
+	 *	=3D=3D> (WV - Wv)/(W + w' - w) + v =3D (V - v)*w/w' + v=0A=
+	 *	=3D=3D>	(V - v)*W/(W + w' - w) =3D (V - v)*w/w' (3)=0A=
+	 *=0A=
+	 * Since we are doing at !0-lag point which means V !=3D v, we=0A=
+	 * can simplify (3):=0A=
+	 *=0A=
+	 *	=3D=3D>	W / (W + w' - w) =3D w / w'=0A=
+	 *	=3D=3D>	Ww' =3D Ww + ww' - ww=0A=
+	 *	=3D=3D>	W * (w' - w) =3D w * (w' - w)=0A=
+	 *	=3D=3D>	W =3D w	(re-weight indicates w' !=3D w)=0A=
+	 *=0A=
+	 * So the cfs_rq contains only one entity, hence vruntime of=0A=
+	 * the entity @v should always equal to the cfs_rq's weighted=0A=
+	 * average vruntime @V, which means we will always re-weight=0A=
+	 * at 0-lag point, thus breach assumption. Proof completed.=0A=
+	 *=0A=
+	 *=0A=
+	 * COROLLARY #2: Re-weight does NOT affect weighted average=0A=
+	 * vruntime of all the entities.=0A=
+	 *=0A=
+	 * Proof: According to corollary #1, Eq. (1) should be:=0A=
+	 *=0A=
+	 *	(V - v)*w =3D (V' - v')*w'=0A=
+	 *	=3D=3D>    v' =3D V' - (V - v)*w/w'		(4)=0A=
+	 *=0A=
+	 * According to the weighted average formula, we have:=0A=
+	 *=0A=
+	 *	V' =3D (WV - wv + w'v') / (W - w + w')=0A=
+	 *	   =3D (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')=0A=
+	 *	   =3D (WV - wv + w'V' - Vw + wv) / (W - w + w')=0A=
+	 *	   =3D (WV + w'V' - Vw) / (W - w + w')=0A=
+	 *=0A=
+	 *	=3D=3D>  V'*(W - w + w') =3D WV + w'V' - Vw=0A=
+	 *	=3D=3D>	V' * (W - w) =3D (W - w) * V	(5)=0A=
+	 *=0A=
+	 * If the entity is the only one in the cfs_rq, then reweight=0A=
+	 * always occurs at 0-lag point, so V won't change. Or else=0A=
+	 * there are other entities, hence W !=3D w, then Eq. (5) turns=0A=
+	 * into V' =3D V. So V won't change in either case, proof done.=0A=
+	 *=0A=
+	 *=0A=
+	 * So according to corollary #1 & #2, the effect of re-weight=0A=
+	 * on vruntime should be:=0A=
+	 *=0A=
+	 *	v' =3D V' - (V - v) * w / w'		(4)=0A=
+	 *	   =3D V  - (V - v) * w / w'=0A=
+	 *	   =3D V  - vl * w / w'=0A=
+	 *	   =3D V  - vl'=0A=
+	 */=0A=
+	se->vlag =3D div_s64(se->vlag * old_weight, weight);=0A=
+=0A=
+	/*=0A=
+	 * DEADLINE=0A=
+	 * --------=0A=
+	 *=0A=
+	 * When the weight changes, the virtual time slope changes and=0A=
+	 * we should adjust the relative virtual deadline accordingly.=0A=
+	 *=0A=
+	 *	d' =3D v' + (d - v)*w/w'=0A=
+	 *	   =3D V' - (V - v)*w/w' + (d - v)*w/w'=0A=
+	 *	   =3D V  - (V - v)*w/w' + (d - v)*w/w'=0A=
+	 *	   =3D V  + (d - V)*w/w'=0A=
+	 */=0A=
+	if (se->rel_deadline)=0A=
+		se->deadline =3D div_s64(se->deadline * old_weight, weight);=0A=
+=0A=
+	if (rel_vprot)=0A=
+		se->vprot =3D div_s64(se->vprot * old_weight, weight);=0A=
+}=0A=
 =0A=
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se=
,=0A=
 			    unsigned long weight)=0A=
 {=0A=
 	bool curr =3D cfs_rq->curr =3D=3D se;=0A=
 	bool rel_vprot =3D false;=0A=
-	u64 vprot;=0A=
+	u64 avruntime =3D 0;=0A=
 =0A=
 	if (se->on_rq) {=0A=
 		/* commit outstanding execution time */=0A=
 		update_curr(cfs_rq);=0A=
-		update_entity_lag(cfs_rq, se);=0A=
-		se->deadline -=3D se->vruntime;=0A=
+		avruntime =3D avg_vruntime(cfs_rq);=0A=
+		se->vlag =3D entity_lag(cfs_rq, se, avruntime);=0A=
+		se->deadline -=3D avruntime;=0A=
 		se->rel_deadline =3D 1;=0A=
 		if (curr && protect_slice(se)) {=0A=
-			vprot =3D se->vprot - se->vruntime;=0A=
+			se->vprot -=3D avruntime;=0A=
 			rel_vprot =3D true;=0A=
 		}=0A=
 =0A=
@@ -3865,30 +3972,23 @@ static void reweight_entity(struct cfs_rq *cfs_rq, =
struct sched_entity *se,=0A=
 	}=0A=
 	dequeue_load_avg(cfs_rq, se);=0A=
 =0A=
-	/*=0A=
-	 * Because we keep se->vlag =3D V - v_i, while: lag_i =3D w_i*(V - v_i),=
=0A=
-	 * we need to scale se->vlag when w_i changes.=0A=
-	 */=0A=
-	se->vlag =3D div_s64(se->vlag * se->load.weight, weight);=0A=
-	if (se->rel_deadline)=0A=
-		se->deadline =3D div_s64(se->deadline * se->load.weight, weight);=0A=
-=0A=
-	if (rel_vprot)=0A=
-		vprot =3D div_s64(vprot * se->load.weight, weight);=0A=
+	rescale_entity(se, weight, rel_vprot);=0A=
 =0A=
 	update_load_set(&se->load, weight);=0A=
 =0A=
 	do {=0A=
 		u32 divider =3D get_pelt_divider(&se->avg);=0A=
-=0A=
 		se->avg.load_avg =3D div_u64(se_weight(se) * se->avg.load_sum, divider);=
=0A=
 	} while (0);=0A=
 =0A=
 	enqueue_load_avg(cfs_rq, se);=0A=
 	if (se->on_rq) {=0A=
-		place_entity(cfs_rq, se, 0);=0A=
 		if (rel_vprot)=0A=
-			se->vprot =3D se->vruntime + vprot;=0A=
+			se->vprot +=3D avruntime;=0A=
+		se->deadline +=3D avruntime;=0A=
+		se->rel_deadline =3D 0;=0A=
+		se->vruntime =3D avruntime - se->vlag;=0A=
+=0A=
 		update_load_add(&cfs_rq->load, se->load.weight);=0A=
 		if (!curr)=0A=
 			__enqueue_entity(cfs_rq, se);=0A=
@@ -5288,7 +5388,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)=0A=
 =0A=
 	se->vruntime =3D vruntime - lag;=0A=
 =0A=
-	if (se->rel_deadline) {=0A=
+	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {=0A=
 		se->deadline +=3D se->vruntime;=0A=
 		se->rel_deadline =3D 0;=0A=
 		return;=0A=
