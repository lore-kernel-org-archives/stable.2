Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9481B983F;
	Fri,  9 Oct 2026 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505050; cv=fail; b=AQsLVxQaTNOedjNfafzSMAdCHQwdpmD8cDVvZr9/A1HLOsfdfZjyGvxsc7SesH+mM/vdfEKGAzhcUm/eB0+qV6ObBh27A6q1m/Tn7cHcusWhgmvNxrodaTCF3pzfFPR9iVOg0A4/P2DDdgxdW1OYN2Y2yOnDsnPv6E/Kyq6rvc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505050; c=relaxed/simple;
	bh=OTgYBaRsiNOlZ/wQX5s8pFtUpBRgsjDjhGEOW08rYFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F2HQEHqQgth4kOrRc22zsDFBiz5dA60Y8WxYYC4kwfxLphIJiKE4nuGUP43mz0DrHLHtWSRjptrcWNhHXPygy4Ubkc+69q1+8GCKy3uYQ2l63L+NJbgFp8SlcO6AKc3cyKbPbeyuyvQJlw92PdXswvbD67QmosztX0bJmxx6cj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nEfvHeK2; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEfvHeK2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egz3Ww1tLX1Cf0cCiul8s2FfGO13vJ9h1wlwGy3Vxa02JDhs4AFZ+pSj2WTVboLWpakEuWjvbxMaHH9phFUQcncm4Uj10aqF8oTooTgcIZU6Q2ELdDA8NVSEK8ceRYGjU4EZ7IOszMse6fnJIiF1DUrvCJEsMMLed2MreJ6DkTMkMyXWur7S256zyBYG7nMRWLn5qb4GDNFaIv+fgovSPvoXewWfp6vpeF92d0kCV88r71bA8FGscAbEU2qxo97F3y8ovNBzvYlUB99Yq9qj9L3RJVehSiiENI2V859Q7+3lywsKbZeU7LGFSKvImBL6sMu4EDJ4J1eLrqpSLweAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTgYBaRsiNOlZ/wQX5s8pFtUpBRgsjDjhGEOW08rYFk=;
 b=efzcMxpFbNK2UksLUzTrHIcwsCWCkk1C+uNHmKhynwxrL8Nt2W/mhExDbr1wyxS6UKpauzg9vy3NOHsxQMGGVawB6BXqYvGqxTFG4dJbsDYG+eEBporiQmBA0+HlizEDL/DBYj2zT4YjLWaflumioBbKofYByGTKmhy5+kJbZv4++9weU/GftvIkF6SBvd4L3lHEkRJlzVEtlnPdZZRde2T4yAN42w5Bda5dYVZQVDt+opW4CsVGoJotMa0+YKYZE9gZyUHa2mtc6Z7SNbpblpWhXOJij0SaUcHAKIVgDeTnYmdSEg/lBfSNkbYA6rriHpnS/40c+qg9UoJ1elpgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTgYBaRsiNOlZ/wQX5s8pFtUpBRgsjDjhGEOW08rYFk=;
 b=nEfvHeK24mBqSW2iDtqRCQf1L3j61vucylDO5GIeu9pFkCHXAbQRSbhxx/h0xttMZBgAPaPTG4xIexsN7O3xRQ/M6iuES/AQgNXGBuUWlp2yL5OFhQDyOXUMJNhksczD2atpsapzIYdwcvcfX8PLhT8r48NFPa8se4e4xcJEOcCZfuTwOp11xjkQVqies4HemG6zbQQNEXuyHfaz/36Ny9BHm3mDxPNfYcfTdCHQ5nHiQt9bt3JTMvaQSy9sQznKI/6QRBd0Xsd1jcYR4HZpfPB+EwVDbRhM9y3OjtQBK5NrcW5mngvaDdBGwdcgrwqiP+j/NCXYvAimBoX18ftiKg==
Received: from DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 00:17:25 +0000
Received: from DS0PR12MB8787.namprd12.prod.outlook.com
 ([fe80::be69:8d60:1fcc:7027]) by DS0PR12MB8787.namprd12.prod.outlook.com
 ([fe80::be69:8d60:1fcc:7027%4]) with mapi id 15.21.0451.022; Fri, 9 Oct 2026
 00:17:25 +0000
From: Daniel Trujillo <datrujillo@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
CC: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander Duyck
	<alexander.h.duyck@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH net] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Thread-Topic: [PATCH net] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
Thread-Index: AQHdV3HjjFPqvrTdGEGss0JX+ciP0Lb0OQWAgAAehMc=
Date: Fri, 9 Oct 2026 00:17:25 +0000
Message-ID:
 <DS0PR12MB87874D402A9852C9FD64E3C1B2922@DS0PR12MB8787.namprd12.prod.outlook.com>
References: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
 <CAL4WiiqO2C0cVQBdDJWrGYCczB0JRMXJUjsUq7uYPjfNL34q7g@mail.gmail.com>
In-Reply-To:
 <CAL4WiiqO2C0cVQBdDJWrGYCczB0JRMXJUjsUq7uYPjfNL34q7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8787:EE_|MW4PR12MB6682:EE_
x-ms-office365-filtering-correlation-id: d6659f5a-8472-494b-7217-08df259ab21c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|3023799007|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 puh0hUm+CYkZbxx4QU7JJZqDdTq2Rbts9QPme31N0/yeKscMr1dU6mSt2psegAdWnZr4yvycCh+tGppFPYhHAhiPHenMfN8g1wzuy/7NeFehsP0yVFBBHyKj4YxiDg2+1rrXVQo5kfWjJxlt3NSHkINz9G6f3YzNIk72vPa82TVrdP6l8V2BqLEDjYf+FkrJL2yg/oT6TxTo3zh5qrG1DrrqyyQuXIRoyow3iGHaT+/rgXSTbu5klc9UHa3iFAd+eMGomjBi4XzmMMICj6pqTnh1e8EKt16fJRL+0OsEwnNDC8uvxQ4+tyYpTY0Yzea93/d5VRAye+GB1Ij5s8KEkxGMq/wKS3JxgkkNNNlhLppikckxWByIehi7ujKxeMEfW8dBsZFiWabLdwD0ICAf5eAssxqUDqSwd0/mcDGS9UYQ/eamCOEoc0S0Cc08hybXH+CMM3eUoEAxcFmxsZ2xr4BqrU0adkL/6ZswCqQ/H5oZ91oKJ7dLBcy0t7qgKHj5mM7p3L1WYP0MRJdqU8XnPGQaI7YLfDEallrK4oDlDgaVV17qkdBznqQzSt/tJzzL+3nuolbUxG4eMRPxwudo8x6E1FE15qCyy8ipAFprGrDEZaFTx4oam+wJQIlbbcbLFoIbJRpX7oZEsbmKm1xZDfxxXIVnmnIJ8NpJTL9AwDdulLTc/afVqvLfpZCvRU6NcFg4T5tm8nQJlyvmtErdTHNI7LRGXv+MrR8UA/w7NmI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CwacVWKQCt8eaZqCbEG2DYR+mhqOA/fCS3OdW4GGXcQrBl5oupg3Uf29ti?=
 =?iso-8859-1?Q?Vl52km4FwDZf3UnTXaZmHoU0RdSF6gtfywYs3Ll9MXjNJQ5YezZewvM4Rc?=
 =?iso-8859-1?Q?NflFIwq0Nui2HINIkIxoPUOyPSLykPE6L+iW3qScwYjbCgYLjCf1lNDzEs?=
 =?iso-8859-1?Q?JBDmHb8PsS8VmfkEEGQmZ/A87yRCwQLqHyH8zESTuZIPmBT2sQUsHUkEJN?=
 =?iso-8859-1?Q?UHJFdrjfO9P735Qbn3bEAg1bnFABA8TQJ5xarlCkOwaOAq7uZcP5ckiKXk?=
 =?iso-8859-1?Q?njKDDiYuVOdfYcmCBLUgYIKKgeebRX9M8YpFgAJyEI3cvl4hBCVG0auFk5?=
 =?iso-8859-1?Q?kOWcCcGRUFZL36pM0OOBQar3ugE17IK5fV8sIDyXvrLmrvLYHN9ccoyM80?=
 =?iso-8859-1?Q?434xlmKMyLoBlB6ootgOsp+DaiZyXFhOshM2V3KD0B+kOGj2IswrzmxpRz?=
 =?iso-8859-1?Q?LgkzK2zVT7+jOo62HeixPxMmi7O8wj2n3PyxmSAnHBHL69d8s2Kc6xdW2R?=
 =?iso-8859-1?Q?99rSS3WTPltBrLhbE63XjuWBTx6+0nFHZsGe1YKn6ymABEBTJONpfwZDNO?=
 =?iso-8859-1?Q?6wWqLLMPxttNP33mlvT0n20iA4RdVjEKf66jiRM2eUJ4pSs/naf6LctDvU?=
 =?iso-8859-1?Q?7JZa3FADQJFcldlTHcLiRbe9N/nwwfd2AbhHxh9b4m5IDaseNMpSllCaSB?=
 =?iso-8859-1?Q?VmTZh7BMAwN5j0n0QYQCFdO3sfxDbyRkGiYehgKVIlm9wZHD1ddmdPrALx?=
 =?iso-8859-1?Q?FtIsG4ISMvnr4wLzxMFeob0sQ/fKrZL2khoA680hyXA+tk6g1SecMtouEZ?=
 =?iso-8859-1?Q?aRRrry2av8rZDvlhN47dZYBKGQD+o4H2peifcYPlN5qOeMEpjKQp7b8izB?=
 =?iso-8859-1?Q?mVIns/MQbvIhirbNN1oQz/NtT7EhB12gjzwDCIdtgO+WMNTBo7O2NDTzKt?=
 =?iso-8859-1?Q?9nZ68/9Lwlq1khwG+pAA0qqBnaW/gTY6Ls9bLCUdSRMXc7RGXi1e0Jlfr0?=
 =?iso-8859-1?Q?Kn3MbaymRK1XOZampxNxrMMQNdBkm+opwWb8UO+45VMWpuakoQpss8rHO/?=
 =?iso-8859-1?Q?p4n0GoWASJ8Ce9lBUam8ygc0eCp2JOGSIb1ptrER3YI1k2bQiCE+mqntBA?=
 =?iso-8859-1?Q?26EXv2WG9rwOYOEjl+ygT2eMHQ5ZR2lqUyWOIcpBX1FNwbhM5G7GiFtyMu?=
 =?iso-8859-1?Q?57W7EvkULdsabHEzHK9rr14/Nhjij1kEuH/JlOnhFjla6bSApVONB+LnNB?=
 =?iso-8859-1?Q?QfhcgH3jAPJEza+K6FhozLrJKM/AA5KCfHq8ETpMgDhi8WJjNviiKRubDw?=
 =?iso-8859-1?Q?3y0Sb671e3Feiiyb5Kkp3oCGn8mO0u48Uycq3vg6UJiDBFKVjuEqyrouOx?=
 =?iso-8859-1?Q?9PP7W5K/IwRPEzSQ0Dsaz41ELNT4Sa5vgzvvLAOL31V0+Bx1w1Mfvub5QW?=
 =?iso-8859-1?Q?wAtspAYgnPha6zldg1Rw1d6IPXXvqkxsz8cjeZ+Imh8L4SGg1+WWGmDJgV?=
 =?iso-8859-1?Q?qo4TsqvBRQQG/ZDrbPPG7SWehngdZmZvgS1CNC06+pwWHLkwbQm7usiFUg?=
 =?iso-8859-1?Q?yjHjTcMLauiNMjYiAjShzoZVcMVsdkMHP7OEKV0o6k4jSWQ/1N3G39+0sm?=
 =?iso-8859-1?Q?tpYudNL9g0kgfzRY6v0xEi7w7iQQBSqOfJUwtqYNxSevRizhIdgBdNulcE?=
 =?iso-8859-1?Q?I1gvt3ugmPEISxq7HSrwNtPLcyviiJ7dpJkLZQHUJbxMgd6Gl0uepvO2Rz?=
 =?iso-8859-1?Q?tb3gEHZj2h0RdybbGdQ0N0OcoZltipX9cO1mBOB1DPt8sCYgWR40hrMiQi?=
 =?iso-8859-1?Q?uEESQXPd8A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6659f5a-8472-494b-7217-08df259ab21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 00:17:25.3147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIArUAC2RUgqX+gpCpC5TcHTjm8cfc+2B9H9HoINM5XIfr5ENuCWugZiFyhjpEBVEM6DU4Sx+YwSdobJMXaOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

On Fri, Oct 09, 2026 at 12:25:43AM +0200, Eric Dumazet wrote:=0A=
> Le ven. 9 oct. 2026 =E0 00:10, Dani=EBl Trujillo via B4 Relay=0A=
> <devnull+datrujillo.nvidia.com@kernel.org> a =E9crit :=0A=
> >=0A=
> > From: Dani=EBl Trujillo <datrujillo@nvidia.com>=0A=
> >=0A=
> > fib_table_lookup() checks the child index against the bounds before=0A=
> > passing it to get_child_rcu().=0A=
> >=0A=
> > The index is derived from the lookup key, which in turn is derived from=
=0A=
> > flp->daddr. A userspace process can therefore influence the index by=0A=
> > triggering lookups for chosen destination IPv4 addresses.=0A=
> >=0A=
> > If this bounds check is mispredicted as in-bounds, an out-of-bounds ind=
ex=0A=
> > can be transiently passed to get_child_rcu(). The value loaded beyond t=
he=0A=
> > child array is then treated as a node pointer. The next loop iteration=
=0A=
> > dereferences that transient pointer through get_cindex(), causing a=0A=
> > page-table walk whose cache footprint can leak (parts of) the pointer.=
=0A=
>=A0=0A=
> Has this been demonstrated, or is it the output of a static tool ?=0A=
>=A0=0A=
> key, pos and bits all live in the first 8 bytes of struct key_vector,=0A=
> so the bound can not be made slow relative to the index by evicting=0A=
> a cache line. The conditional branch should resolve a couple of cycles=0A=
> after the out-of-bounds load is issued, before a dependent dereference=0A=
> can start.=0A=
>=A0=0A=
> For a patch targeting net and stable, in the IPv4 lookup fast path,=0A=
> we would like the changelog to say what was actually observed.=0A=
=0A=
This was not the output of a static analysis tool. The gadget was found=0A=
during Spectre-v1 research, and its exploitability was assessed using a=0A=
test harness for potential gadgets.=0A=
=0A=
Leakage was demonstrated using instrumentation that delays branch=0A=
resolution through a CLFLUSH before the mispredicted branch. In that=0A=
setup, a userspace-controlled IPv4 lookup key was able to transiently=0A=
load out-of-bounds memory. The transient use of the loaded value as a=0A=
pointer caused a data-dependent cache footprint that was recoverable=0A=
from userspace using Prime+Probe. Adding=0A=
array_index_nospec() removed the observed signal.=0A=
=0A=
Simply evicting the cache line before the lookup is indeed not=0A=
sufficient to widen the speculation window naturally, since=0A=
get_cindex(key, n) brings n->bits into the cache. An attacker would=0A=
therefore need to delay branch resolution some other way, for example=0A=
through a precisely timed eviction after get_cindex(key, n), or by=0A=
otherwise creating contention that delays branch resolution. I have not=0A=
demonstrated this end-to-end without instrumentation.=0A=
=0A=
> This is not complete.=0A=
>=A0=0A=
> cindex has been set from the unclamped index just above. If the=0A=
> (!n) branch is predicted taken under the same mispredicted bounds=0A=
> check, the backtrace path does :=0A=
>=A0=0A=
> cindex &=3D cindex - 1;=0A=
> cptr =3D &pn->tnode[cindex];=0A=
> ...=0A=
> n =3D rcu_dereference(*cptr);=0A=
>=A0=0A=
> and the result is dereferenced at the top of step 2=0A=
> (prefix_mismatch(key, n), n->slen, n->pos).=0A=
>=A0=0A=
> This is the same pattern you describe : one out-of-bounds load, then=0A=
> a dereference of the loaded value.=0A=
>=A0=0A=
> The clamp needs to be done before cindex is recorded, and can stay=0A=
> after the IS_LEAF() test so that leaf hits do not pay for it :=0A=
>=A0=0A=
> @@ -1465,7 +1466,9 @@ int fib_table_lookup(struct fib_table *tb, const=0A=
> struct flowi4 *flp,=0A=
> =A0 /* we have found a leaf. Prefixes have already been compared */=0A=
> =A0 if (IS_LEAF(n))=0A=
> =A0 goto found;=0A=
>=A0=0A=
> + index =3D array_index_nospec(index, 1ul << n->bits);=0A=
> +=0A=
> =A0 /* only record pn and cindex if we are going to be chopping=0A=
> =A0 * bits later. =A0Otherwise we are just wasting cycles.=0A=
> =A0 */=0A=
=0A=
Thanks for pointing this out. I will send a v2 after the 24h wait that=0A=
moves array_index_nospec() before cindex is set.=0A=
=0A=
> Also, fib_find_node() has the exact same construct (same bounds check,=0A=
> then get_child_rcu(n, index) on the next iteration), and is called=0A=
> with a user provided key from fib_table_insert() and fib_table_delete().=
=0A=
> RTM_NEWROUTE / RTM_DELROUTE only need CAP_NET_ADMIN in the netns owner=0A=
> user namespace. This runs under RTNL, there is no performance concern=0A=
> there.=0A=
>=A0=0A=
> Please also take a look at leaf_walk_rcu() (cindex >> pn->bits), and=0A=
> say in the changelog why it is or is not affected.=0A=
=0A=
Will do and address both in v2.=
