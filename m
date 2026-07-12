Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9A2459E1
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846266; cv=fail; b=H6oEKPVUpKFJBpOD5EmVmcrMlo4txjnq/F15Y/sTryOfeSfzUy4dtBvzC8RZUoQZU+HIZHOjcZ44vkbijKkNM+I0NpP3gWQcnD3EPsMLH+qmxxsGVXj8wakUtbwuP6xPBnI8g6hPDcDTdt0a+0NvGfUC5y7lQawKIKLdekBiKNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846266; c=relaxed/simple;
	bh=1oKQ13ZRb5CXI6yCYzUFcsJmqQ4dQwEEm9GgHz543dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLM7d+FxJz7bo1gxuuQP+ySBpS5T9IEC6tjMJ7fD3jsz+HtT6lnETo0GjYghO+UMkI/DnD1biioHo9t4+NJtJUx8JLaEfS3ecc6KTlcJXc7bfMCURIsVVOphSrCKlwkSRNx0fYpna2GLp/BN0n1XXpFEgyFk1hjlS1fb8EJyLHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.han.nl; spf=pass smtp.mailfrom=student.han.nl; dkim=pass (1024-bit key) header.d=student.han.nl header.i=@student.han.nl header.b=AlKsKJSB; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.han.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.han.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=student.han.nl header.i=@student.han.nl header.b="AlKsKJSB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EawQ1ErncdQhkkjD2amdT4VURE3NGkjzZ+UfFCAdufABgntstsqQBbJIbvPETGlwhESsRpSnnzW4OnKbx+VfchE1YqfWp9Fc2FWmPekMGpp2n951cIg8c3xrYNWX20mso4x8PuCCRzre9FrYCOT5hfTxpkc1aWFmlfsiCzVY9PCKiqCEYbKoZjGFJBfu8uQ0DBvNis/vS976VZ5dWxhqeFXTkgmSXECuhc/O1LN7mfFugOZsXpJgHPohm6omBu/xJ7siQDgF65mbw7xIjSTRTeFcVQzBakhKVSG1+a8P0n3ciNGfI4dpJckBQqocPpJjn5d/NaJJjdLAedH0OnsR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBQ1mClP1TFz308/UqAJSTkUs5sx1v3Sy8wHaMj9CxE=;
 b=CxNFJ7VCvfE7jGwkx2PbIhqcVOPEGw33GNzPQqrERmYx28i+MaQsvBvzqg1S6/lJIs2BGxmbN1AXdmvANRUiqfRj/P6x3QpI1Ed/Zo2IuQbvpjCeP0kRK7KIpp7HmjXHkyISZYvKKwa5i00g0l9j5RFYJLUKzRBGEtdQr7Eje0c4atVXPCl5aDjwxJJsyTCddsFZu+RGTsJ1T3h9btPjGGwt86g0mvPsCTtV3RXHLx7rqnaGoF0Gud4p1QhfD47SpZm9qKBDD6LSxdz3fXNsnWG+UW3PDd4UxE0gDEI7d+lxhCy59kPI00N5EPvFYxuNC1m1LaUMZkQvmd8uuEgXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.han.nl; dmarc=pass action=none
 header.from=student.han.nl; dkim=pass header.d=student.han.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.han.nl;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBQ1mClP1TFz308/UqAJSTkUs5sx1v3Sy8wHaMj9CxE=;
 b=AlKsKJSBWGvoaNKG+r02HDpBGmm3uXfYPoqdfa/8bribrhqKHZn9xdMYahBEDXG7ITciwcs9562Y2KNXgp3Q1qGOn+4C1Vi6+oXNaEik+endmzmVkMfZnobCFvFrI+AVT54nBv8UubBnSZHcZCOdeHOilPBS4ttyV66NyErk4ig=
Received: from MRWPR01MB12852.eurprd01.prod.exchangelabs.com
 (2603:10a6:501:84::16) by DBBPR01MB7660.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Sun, 12 Jul
 2026 08:51:01 +0000
Received: from MRWPR01MB12852.eurprd01.prod.exchangelabs.com
 ([fe80::6185:3771:1740:81ac]) by
 MRWPR01MB12852.eurprd01.prod.exchangelabs.com ([fe80::6185:3771:1740:81ac%6])
 with mapi id 15.21.0181.008; Sun, 12 Jul 2026 08:51:01 +0000
From: "Danyil Demchenko (student)" <DO.Demchenko@student.han.nl>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jose.souza@intel.com" <jose.souza@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Thread-Topic: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+
Thread-Index: AQHdEdrEXRa6GO8CjkuHu8r6loJB9rZpkpmAgAAAJvY=
Date: Sun, 12 Jul 2026 08:51:01 +0000
Message-ID:
 <MRWPR01MB12852582A7F19653FD0425D43BBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
References:
 <MRWPR01MB12852A981954ABE86057B04AEBBFB2@MRWPR01MB12852.eurprd01.prod.exchangelabs.com>
 <2026071225-valium-carbon-5b62@gregkh>
In-Reply-To: <2026071225-valium-carbon-5b62@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.han.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR01MB12852:EE_|DBBPR01MB7660:EE_
x-ms-office365-filtering-correlation-id: 48428951-5a1a-4cca-f9fd-08dedff2b310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|786006|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 RRpUQvOM3c0p5BFt/LoyuQV28Lz/HQgg5BnS1tRwA4IP1Qb4rpFXJGiYy6/UQMgNw4OxuDUCxiB2ss127Gpyw1mDY29YcIylZZjTQaoDBjfCI2fG8Tj1MEBe2boSyMMxME2b586C/0XukJXXEj8FXSU0Wiet5vuWOx92RLIVruzAGaychnD9TI9rPSwqSsg/I2U5qJcVyyhbNq3GDcRQqHqbiKZbD+YA/LP1tx1oBnjdK0Ulu1Stk09WxsrZEK5dFsbkAoP21rBjviasHp4SXFHULyMQzGICJBPaIK3wY+6UYWSS34VBQ5qpYJbbGQqyhVL0JRkmpjbB6E4ZJ9zhkNNNtYTKoAF0QiYzelCGcnbYi2F+VhCWUWrrnIIEGsxtHP1PfPYBLIWBigrPKXIVXtJC7NcIZH3The7kMLYhhM2QGb3OW1M4sWXbALzrLQg2ORoATD345J7UU8NVsKyaTt+2ePaCmx5jdw9zWNNgaX6DD0brFqX05VADuKsJhpoog+dWLvMl1lFsWU2N8hex1Fc6KNrUooTilrVSJaDzhTJrUacEQ7TC8/4UucgKVsS5d2oRS16p5F6mI1cus5EvjpVk/o1lo7IBQn/d0zsj0VCPvGx8XOi0rQkvqPxvhgcuS64vY+676mHZajwXsxCu8DgnxqbE2n8Ghz539ZxXS13VEYwANcBEjNISnw641H4JbmrU6/lPMqjESasjawiHJ3brDoX6U/ZCZ35OxMrAt3k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR01MB12852.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(786006)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pA6uJlYtXelehPREJxex8/JxjCRd4nxcPf9htWvj7bn5+W//bARhtNiVNTrm?=
 =?us-ascii?Q?N6AyL0ZGZjfhvEk5ik2oTCcRlm5Gp/on0ufoKevwbo+DXr2mpap6DVzfRGGI?=
 =?us-ascii?Q?Lm77/Tc1XAtPGycaHJqcEmKWYDbVhP7qG2aKPKr0uHy3lvPzLe2WxFS6nPTg?=
 =?us-ascii?Q?ePX8um+y+Bv3O903qAi5vRTXEiYuzGkyeilNfoYKvuS7MgRvxLypH29elTxh?=
 =?us-ascii?Q?Yfs2n3sPtRQZFffbvNsrWC4JuExQhL6LfZS1yey+g2qBVcWh1L6XpTUTPZ1F?=
 =?us-ascii?Q?2XRwVj4qjTRjx0zKiJ6ZCFj4YKeIiQroju2+V1u5gR8mr9YQsopTZOMGL+xA?=
 =?us-ascii?Q?Y/j+V2OKk4ZRtRMXE+fZAoUtK5aM2GcwIDf5ka9VXt+TB0GhOraQ/8yuo+ZS?=
 =?us-ascii?Q?1l8nXbMomLVcKd0R+M2SOjCU/omJ65gImdrElPC+1phfxrbb+icA1CFl3uFX?=
 =?us-ascii?Q?j5nPiTuzVjnF81PZHXoQ4Y0j+5dC2dA4ds2OvmTRXcwodrj/1X3YZx1fAjP8?=
 =?us-ascii?Q?2/dUWPSgtAe1Yh3aAAxGS4xLzD9MGCBvHqnB1bd0nctMn7Bm5a38iH8l1Knn?=
 =?us-ascii?Q?ry/uXVp/iAmo8eEGj4tXRf60JNVin6y7Af9gVNYebA2AxtfpA7C6cSonxpki?=
 =?us-ascii?Q?zS5RYxf0agHA7aDEYelb+59LpdRMVv+hrSkgxSjH32jEH+BKCGve2IXgnvIO?=
 =?us-ascii?Q?eykp+b6VZmzqcAgOsSmtA7oF5fdhBplYt9hM6qxMGCDMQA4B/1G8xiAsxe26?=
 =?us-ascii?Q?K+OKNm8xFY/0qs8k0ZRg8+Y6KYA+OGD8FFZ0hYyu8K7Ap4pVWZ/jll4IMcxz?=
 =?us-ascii?Q?/pIXU6IkvmLfq/7CwOtkUdjfBnJxAAcFaUDgnvqrE3559qKUrCZb9ZcnyfAS?=
 =?us-ascii?Q?6IrKl2s3++pHlxGmLeVV46Ryobe7fWcpi4j5PkrAji7dQZ/XakOv5Xi8jl4u?=
 =?us-ascii?Q?tjLAxi+uMK76MmP3l+noEZ/xOwk82k5alXka5fEWyXST7Qdr/7qqKjqEtqhf?=
 =?us-ascii?Q?TtgLOp0zWo9vFLhuhDdDZ8tLFvLXORMyMf9ZC+R151Sia+7RdKwi/xZlyjiD?=
 =?us-ascii?Q?vdioaKOa6CE0Wr+RjAEQqTNwR8pcZ4JMJVNi3TBr7nPgQ4I9G7NUs+pESX7w?=
 =?us-ascii?Q?Ad7Fl/C2JYIivx5x3IA20hVi/4ihBHtUk8wRlj3KbiOyMD7exzLhkjkUi7jK?=
 =?us-ascii?Q?ndNr7sVnT9nNMnaPgqlajJ+jgKvuxQFYORPDAvRTRHYwSDzNqtDPg55cGfNF?=
 =?us-ascii?Q?TNTUX5fRutl1ME/vnQyhhhStSvHkLhk04lC00ycu9vdjmACyRMvqUdWBkxSk?=
 =?us-ascii?Q?V5WBZweMpiNK44fHbWUytXh81inJ0fwu+i0Xz4+dHo6wa/AI6NZRtXAA2F1V?=
 =?us-ascii?Q?mN90+G/i4ldPw+OpuJBy0YrrPfPVn7DQu0DZC2OoYXHe3QF1yEz/Br6CSars?=
 =?us-ascii?Q?yojDX/xiGfXz7e4NWEtZembArZ+2zN2Yfh8RY23fvre8hpQ0+PbpVGTvG9+F?=
 =?us-ascii?Q?yPbmkMD42k9FrW3NfEAmO2SI/nePZMs6BHxBCR1Kv+h5ZKlD0JmC5nJYCB2s?=
 =?us-ascii?Q?8N7qoJkXZCAb3hMrcv9Lv9MlO0OQORm7dYVzvCMMS+j1hgNh2QnnmmbJuTyH?=
 =?us-ascii?Q?iZ0683hr5+iHTemW2526wEPbheRper2grRzeV6mGWn+5G4wsV4gX+DG95HTY?=
 =?us-ascii?Q?52H1Y6CA4DLAE26ewujXLyO4qHrnOl1zLrC4/ATmnCVilfDLmPyxK88QuNLF?=
 =?us-ascii?Q?Tmqyv+KN+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: student.han.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR01MB12852.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48428951-5a1a-4cca-f9fd-08dedff2b310
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2026 08:51:01.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d73e7b7-b3e1-4d00-b303-056140b2a3b4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HE/J6HJ1pWy6lnrpDvCp2sUOrO8f+MHE+ttEtUORVe0/IIDfKe+jCMzkwkw5lt8WQwJ83rpuaLsYRe/cas04izzKR2n17/5EK/AQmshJvVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR01MB7660


Yes, this issue was fixed in recent versions(or rather it never occurred th=
ere). This issue exists in 6.12.95 too.

________________________________________
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Sunday, July 12, 2026 10:48 AM
To: Danyil Demchenko (student)
Cc: jose.souza@intel.com; stable@vger.kernel.org; regressions@lists.linux.d=
ev
Subject: Re: [REGRESSION][BISECTED] drm/i915: GPU HANGs on v6.12.20+

On Sun, Jul 12, 2026 at 08:46:08AM +0000, Danyil Demchenko (student) wrote:
> TLDR: on kernels v6.12.x i915_gem_mmap_gtt_version() should return 4
>
> Hi,
>
> This patch shipped with v6.12.20 introduces GPU HANGs on Intel UHD Graphi=
cs 620
> (8gen igpu)

What is the git id?  6.12.20 was released well over a year ago, are you
sure that something newer hasn't fixed this already?  What about looking
at 7.1.3?

thanks,

greg k-h
