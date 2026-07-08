Received: from mx0b-00756801.pphosted.com (mx0b-00756801.pphosted.com [205.220.182.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380D2F7F17;
	Wed,  8 Jul 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.182.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511823; cv=fail; b=UtdYWdsxVcsRDCAP5NRWaRueS2yqhnUzfR6MipbbanD+iRnlxVC8YCN/U5g7DclLNuEZ13LhJtTxOE6jJt3cC9x5y9y+NsI5hzNhoRZAChxsHrXIybuDdr3mwNbbp506O6iq0NFTnqgIgVVbos37pjx6nxu7+dGSkuyvF3+6iUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511823; c=relaxed/simple;
	bh=PnzbXsHAnQhU5CiDy68dtMqg7fFwVRueG6bQvDf6qQU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ka+M6pG4XimdkcybXwGHtHGV3LvVsdfVw1RkmD/ULRFMV5PIt/3PuyEBVRM26c1rX4zlkC49/I/X0+dvzr7z2nVnoW6XneIqhYQ3/2WFanmcKYADEqM/3iZrpYfa7sNJ0hgKaLC76DsSs+UvE77kfSJsOLBtCkK/sBF12bBHDDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com; spf=pass smtp.mailfrom=nozominetworks.com; dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b=YryG5jQQ; arc=fail smtp.client-ip=205.220.182.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozominetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nozominetworks.com header.i=@nozominetworks.com header.b="YryG5jQQ"
Received: from pps.filterd (m0297687.ppops.net [127.0.0.1])
	by mx0a-00756801.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668BSlJo1759966;
	Wed, 8 Jul 2026 04:30:08 -0700
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	by mx0a-00756801.pphosted.com (PPS) with ESMTPS id 4f8t6bs7ne-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 04:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+/3ehRVda7XLZ75hnjL9jhZMS4+Fj6tEIeQUpLp0EPzw9rWajRLFtyogyuhegM7Q44C1mcX6FtVl+eiR50nDC8Hf5R9m7wQ5CIzGAOE9FUXo16J92GLmVdbg0RDLqtlcsDRLSw0iRmIdDoBbL+q2/LeIpRvrc+NgKwfJ4fdGGBfkbmRDXldrAZOqdCyH3CsBQ7Tc6ZSJNYljEEQsgT9/weth8Oze1/pZLaqmd5hAumJLVGzyPk+M0vHq74XTak6L61LopGTdrvGiVaNnok12OSA6VLv6Xi9wxRZCqNJxjO3DvrE7r3np+BkZ7QOzpMv/Xx6D9vy3gDImC4S8RZ/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t32MwEa3iLAUYD7Eqgyga2OuCkhRZqSR0GGCoSjK1fs=;
 b=jNGFbSA5SwW+9L23qEUiRbv45DmH7XF66qyLmYo5jk9l5gtjG8EC43jSCHvixzQKnaACeJHyD/k7eNCwRtAIDtvW17MoTESwAYupI0GcI9dGFmWKOyIsyuLR2x24JhHHihJDFk2R2XYYM9OX6EyPWglwKJRD2A3Jbcc1GDhJWf3vMJvW2E3AwQkgxzpati99cgqsILlywWonu5eEUkrKW4kqhFlcLEXe3PqgRoH5XPQ9dNUsHzwbEVUDAb9PSilzJR8pIMdQtsP7nys+on/AEd7fpQdmGOHL13i5vvSBTY3r1P4ttAvyOCI8foedSOvCbGdpwIb2/hWKJqeoEvHg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nozominetworks.com; dmarc=pass action=none
 header.from=nozominetworks.com; dkim=pass header.d=nozominetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozominetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t32MwEa3iLAUYD7Eqgyga2OuCkhRZqSR0GGCoSjK1fs=;
 b=YryG5jQQDaogcZWsn/ibpCXdiKJ7COd0ROoCvzMl/czSfZ0jIKJPziVZtP984NC56QdfmDkIpK4qPcRXM4wUKE9Lf/ciwtdR+TufXpc0kIfa262EdM2xTSyFe3wg/hPBzcUe2/tODlV7t99D8rDRTNuRrwkJfWdRnlBlUpaty4Y=
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 (2603:10a6:800:2f8::12) by GV2PR03MB11502.eurprd03.prod.outlook.com
 (2603:10a6:150:308::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 8 Jul
 2026 11:30:04 +0000
Received: from VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f]) by VI0PR03MB11174.eurprd03.prod.outlook.com
 ([fe80::478a:c992:bbc3:ca3f%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 11:30:04 +0000
From: =?iso-8859-1?Q?Alexandro_Cal=F2?= <alexandro.calo@nozominetworks.com>
To: "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>
CC: "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] Fix OOB write if err == buflen in ntfs_readlink_hlp()
Thread-Topic: [PATCH] Fix OOB write if err == buflen in ntfs_readlink_hlp()
Thread-Index: AQHdDs0ey77EyoZpZ0udjOJnIiDi3g==
Date: Wed, 8 Jul 2026 11:30:04 +0000
Message-ID: <029C54CF-FC6C-4BFA-854C-847F8E656626@nozominetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR03MB11174:EE_|GV2PR03MB11502:EE_
x-ms-office365-filtering-correlation-id: 949c35ef-0bb9-4e34-df7a-08dedce44174
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|11063799006|56012099006|38070700021|18002099003;
x-microsoft-antispam-message-info:
 5MX+j+PfIs3QRi8kfb3j/OYUWmniRKMsQzuvYPKqDpWbVxxYFD3l86r7bL9NQGNJWcbahAC1Ym3/BY6tMhmceMKhtDH/pKVRfcdJ8+x852ieE69VVG6fzZh/rH1+BgJnpv2e74dMb04LxQorOs/BBNZb1qqOBtC2sqs1GiBmVCB/HZkyV+7q+zobypYYz6/JPoLtJnRTsajqGp2vskk1ZuP/qilW9eNYvn0LTE1hO6rl3J6GuKHCysdnXuTbVFqe4EUVgEDuzE0A/Hyxq79wy0lA3Eo5OCa3XTrRH1Juh752f33FzWeCP6Vb8Lxz1aCmOWLHVIBWYdvFLnW3bRof+d5ecLzpWaBHT29W7wytFatOE2zD8DYUEZeUJPsFpJwWR2Qsb8ZkeJqyldDaUOvVnj4/2XdTXKv821wS8YQ1CpUG7ZII68e4mnyMN5p+BcpLVrUA0SCcPqCtAZeLxq0N3HsRnskuskI5h7YYGJeNbxzFaHwILiYyvLbnJ6UZJk0UDlbX66aDFh5gh4U8uhbgBQoKASdpjLXGDtiPznACyRdNHKAFclsNRAeNCnRoD6MiPsEg3cHMyIS2rT2ptvD4PoHYKbt5CKa7eC0GMC0PGDAHexppQch09c6mT/GtnoSClztlnZAd9YouFp6/3DE59kNzGXgZSVzja4g4NoYtKi7jhXdEKh0j3suG5mMVSOV2qw0OYvYH5VG+Q4ZADLVgtA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR03MB11174.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(11063799006)(56012099006)(38070700021)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?dKOq3a5pRP28RpS11G8hvT3PgYAZ81Du7NlK0PzI1eFid89NM7cwBgKbmm?=
 =?iso-8859-1?Q?c6k4pfvJW7Gk2d0AykW50p+OxOWO9eFcB0CjE7RAibTQPahoJUZrngiwvD?=
 =?iso-8859-1?Q?KPgHH03VHmuA9nggOm5vGo66ijnc4rCHYUbetmqde7RyyncaG5peNCm+OL?=
 =?iso-8859-1?Q?x+ESF7eY1tePL5i3cpwQn82+9iZsGIX9glRkq61EgfSE9Ns7bE+mYlXatX?=
 =?iso-8859-1?Q?T1rs4PQj1LxNKTVF7Vah/30zatFG6eLsgNAAwpfOGtem6SZMqBlPheZSQD?=
 =?iso-8859-1?Q?Jb37U0zvSfwdVFXJ3vbPRdvtSFDV6zD5Ssa7bVVPT9tx79lFIEmC4O5Ia2?=
 =?iso-8859-1?Q?d0RLHglCgkjGlQdjh0qBNNj0+wZZmmLocgUF78IZThtIXW96RhBNR5X1mY?=
 =?iso-8859-1?Q?mTVON4GI9gsSJY3V/iks+5vsv6mroA8ehJCaBV/4I4Onley3yi8K1YIJhY?=
 =?iso-8859-1?Q?rDP/nefZ5tBq+qS14ccaX5vflQQLyknCnhYzaRBtZGLpvFkRvrTxKkFNa2?=
 =?iso-8859-1?Q?gJ6TKxkrba7dfI17CwcCpzpx8UlxL6fNTNiI4q0f5HWmKc7A4nM8H0r6RA?=
 =?iso-8859-1?Q?Z9m1ajuYInpp1tbv+N7oTc5KwsvRmToiRouHLtB8olX0jqxWb3SgINJMyM?=
 =?iso-8859-1?Q?g78DiknGIInHRZSWtyTJVSTLvwuiKzh2H453V8N94mNtZMFhI21uv1+dKL?=
 =?iso-8859-1?Q?I8/ncjgSg4SE3e0nkKoNalTjSM8Q5K18vuMIcVXfgYxtEabVd1sOk9mK01?=
 =?iso-8859-1?Q?u4Ph07f8bfb0L0HjkjBOXNfFKtVdJpwTGD3Oy15haySM1kshLNjZLFKvJR?=
 =?iso-8859-1?Q?dB3+9RdSsC+qqSE8Px86kthDvPZmIX8QOIDyMO4lyBgO5gzHGOYKVYMYrH?=
 =?iso-8859-1?Q?FZC0OkeeGXMDVivV2NclI1kLjdo8nvZiadcngFCwaKKNkCmSkzZMPyiVQT?=
 =?iso-8859-1?Q?ZfMZ0UjyG4XqbU3PByM9pLnPt0T2fGG1M6kFWLuj0EIzBiY2G0cFjK/2jt?=
 =?iso-8859-1?Q?jZLy3RbX78tcIBd15ksj2VtSpkrWtpBMB4Djc4oZfURe9YjfP30MFHtsCV?=
 =?iso-8859-1?Q?7kAPOSFH9s9oVBUlhtl2mUehBmye5oa03dExgmcaXvqZ6uZAf120XlyzBb?=
 =?iso-8859-1?Q?W8aZTdCX4vmgmRLfxn12TQDEMI3P5MmUP2ZslJJIbTBlagy4OZft8ZITqG?=
 =?iso-8859-1?Q?bL+JgtzmmYF7TNfAjFly0GEJzm7mBUap689oD99tXPbFu+JgmgGgWEwa7i?=
 =?iso-8859-1?Q?czbnU3qKKlar2qCVaLLtJirxXsNTCNEOub84WFDhsW+RNmZr1BCrHzm+Ov?=
 =?iso-8859-1?Q?XTrldkH5BREy7aEKZJBpjLlW95HP5FiqKXwmTuxqhj8LW9EX93Wj/LHwNz?=
 =?iso-8859-1?Q?2Rua1K/+qwPXdGO9kbe0eFqnPUmYts0H4nGb36xilYBvu9b2CoHilM43Ma?=
 =?iso-8859-1?Q?o+9o4vvFEPDbJWhoeNDVzl+0kdrXEbX3UMiAdIi3VQX1pgwjQoPGuq6K4W?=
 =?iso-8859-1?Q?zaPVqXhHxFYRXGt+LFzVycc/7ykEbQnKIR0DjiYlH2+W9bAMwlbNitKk5S?=
 =?iso-8859-1?Q?Y+KSURkKLmrYefDY94sEPdyrZytSVm6/INuNjSAphFdA1A4FWIQZM0fiU6?=
 =?iso-8859-1?Q?GMXKQlqGGf3xzRNTUssGZGW07SItXyaa64T9M9yiJ2Hvcsg3FA9jtisa+t?=
 =?iso-8859-1?Q?BldeqKmwXnme4Z30wbA1eVjtZI4VP0/QvktzbrURqMjljlY2rGlt5wzfCW?=
 =?iso-8859-1?Q?5k1OZbg0OQu3512eegqJa04zstIkuv/1MvdQRyV8zMNCtOkcjqG3/IMgaW?=
 =?iso-8859-1?Q?h+USSaxagy+HpWLlTLiGRqKWq4BA624l0AqTvaOCgcFXjgxDiX8G?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4A74EB78FA139B45B71866ABFA847754@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ibveVpWRuOh1cn2lXYj5UQKTBPfV0iWJHoz16SHmO3Mk0OYES0m5wpfzIBrWABcQouRTJKlV/cjWXVGLctcLwdsph3CUwZtOq/gaVMIOYpV0PDHIPEpH7s/8mkZvBgTODUZNlvxHq5rvzq6kXnGVbI6UZ3tWmhzRLlkbjL/Px4I/xIAtFAmaVLo+6FhRpb7dknNlNJE7MstLG6QpUjkbq4X+uFgAUJPldEuavwBRbtnXOeUctcOMRLBfdRZyiWhO9eU0+Z9/Rj7xLKpTkMRyc/mXADkYH5wWXdjNM0snQzPf0UEcgteqSTraVZNXEjWIdGSNaMr6GaQGuEbMLUy3xA==
X-OriginatorOrg: nozominetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11174.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949c35ef-0bb9-4e34-df7a-08dedce44174
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 11:30:04.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f04d14b-0796-4b81-b7fd-779778e05341
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JclKRV54PX2tgyusX179HCzYJeY336awA0abeA5e9xw3WjOQ/bFtROBU5SCIYiJKbwZq+SHP/hiEetL31KUCQj1g8u+eEYcUouID4jD7wAwTveI6Pqf2LpOFRro0OXnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11502
X-Proofpoint-GUID: 1clKPubvGzKajjheKyxG3O-s4W6D1pjk
X-Authority-Analysis: v=2.4 cv=AsveGu9P c=1 sm=1 tr=0 ts=6a4e34c0 cx=c_pps
 a=cTo37xHf579LWbJR8qDnOA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=LLPZWm0_0O8A:10 a=nBHfkqHukZMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7VS2YgxpqphC4cixgVMD:22 a=sCtaNhFbwZJXAHy4C4eS:22
 a=GqK9ZfNKAAAA:8 a=KYO6sTkJ-abX9nsMJ4IA:9 a=wPNLvfGTeEIA:10
 a=BFatPaWxP-aY11LYkd1a:22
X-Proofpoint-ORIG-GUID: 1clKPubvGzKajjheKyxG3O-s4W6D1pjk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMSBTYWx0ZWRfX1vIXDScBisrd
 mh10yM9OeitHeWIjdiD/YyF2yKWJclH2dGreTJwa9AxmvmQKCDp3hQd78xTTtuEBHbacR3fOR1X
 Era0Cw9JhorFPStzj6uQPf379t1EaXpUHxvv+/glkkInTkPS0+ORudBcbirjTkQOZSO33+JX4+j
 kx3vNXOtBKC+HdXCqhrngtfQr+9azJN6cdWh/OJBZNl9Cd1D0C71RJjQvRN8YzDDUi2iHZ6kEoH
 UGZa84j7EeWNx72z5S9a2tpIza8o8HMKU23x/z4WstoiQ7t7S6c3j1FkZB/9uCiZK9Xdy6xslUl
 Aib0vAjwqXI59cHfcPRNHdsjy3it4KZP8S8lhkWN4xzonoMrrpiHGLvfIrvX527Z3nutYl2qphs
 m+iVz8kB5/4O8QW4U+UJH+FEHUxY11l697Ih0u1t80TIiDXg2aouloj5jJjKkNmDqLHvvSocR8I
 Ir2uenF9iPEu5o/p4KQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMSBTYWx0ZWRfX6NHqr6n9jazA
 hQKO57LLyecYp/eXsYvpmpyW8FTIA+/cvceWS5TQCv0eYGi3YIkHDlCo38dXnOZUphHz3O3WQia
 oYNhX6zXLO++13tODmJjKC8GhB2habIZQUkGT44VAHwNZ5d/cUPI

From 64361f8e12081dc8828480588bc48c2c931ffc91 Mon Sep 17 00:00:00 2001
From: Alexandro Calo <alexandro.calo@nozominetworks.com>
Date: Wed, 8 Jul 2026 12:04:37 +0200
Subject: [PATCH] Fix OOB write if err =3D=3D buflen in ntfs_readlink_hlp()

ntfs_utf16_to_nls() may return buflen. The caller later uses the returned
length as the index for writing the trailing NUL byte,
so err =3D=3D buflen writes one byte past the end of buffer.

Fix this by limiting err to the last valid buffer index before writing
NUL.

ntfs_utf16_to_nls() returning a negative value is already handled by
if (err < 0) goto out;
As long as buflen is guaranteed to be nonzero the patch is fine.
As a defensive fix if(buflen=3D=3D0) could be added.

This heap out-of-bounds write requires a crafted filesystem image,
which is not in the kernel threat model, but fixing memory errors would
be nice to keep things secure.

Signed-off-by: Alexandro Calo <alexandro.calo@nozominetworks.com>
---
 fs/ntfs3/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0c9bd669117d..d4803e1625fe 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2029,6 +2029,9 @@ static noinline int ntfs_readlink_hlp(const struct de=
ntry *link_de,
 	if (err < 0)
 		goto out;
=20
+	if (err >=3D buflen)
+		err =3D buflen - 1;
+
 	/* Translate Windows '\' into Linux '/'. */
 	for (i =3D 0; i < err; i++) {
 		if (buffer[i] =3D=3D '\\')

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
--=20
2.47.3

