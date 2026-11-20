Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795202977;
	b=Ezs3l/0fUhYsTTXScOfS2GjPCK77sHy8ZGwuP1PYOf2IyQDMCCNYBw2qwiZmnuZa3kzK
	 ocmCGOxw+E6jvuBQd8azp3xYSYO3h84Y+WkZxSSskhtP2CAnLkabrpwmCyLfglDv379QJ
	 4gpdlkt4h3fryb+DnLz0bmkgORmce3gEkHvnmadVSUTI7JiPB0C797A7PeHkzad/XtKoC
	 flY/zGB6ukEBtAM6tqDGNY73OwLaRwpzcRwXng9fiFMDKp7GjnwU0jWMQLvQYG3E7wH8U
	 migzp5whzmPiYK6KqnIu99voLajh9xmyVAYgi5aga30GjN8Oqk2E1iL/ALzS4k1A3nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202977;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-exchange-messagesentrepresentingtype:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PQWPF8RWBgEdZE6zv5GWAE5HWlwM5WpkQICwcPSXW0I=;
	b=Ubl0ifRKCO/dMhaJVOjheMsFWrhWEFqcvaseJr123RnKavZwwf3TjbFqtjGOQfhZAVcE
	 /MB9Cp7URWVUonn8MHAAbwHHGFlSRXMewQKuA1Lg2dje8N5oMseP94i/sGU33XESRD3A1
	 vBSTrIkQigJ/KUaTQqz7E1Dvh0cd7XHl7HKnwWDh+PdKLO/3sH6Rp2X765uHRRwPTOOPM
	 IyrqPO3mqBJIPp47Pc0wic0nn8/tEau0oRhwKEwFZD9eZNBg8vtSQbrJIRQY/agopCyd6
	 DZoYSKdqf1PMjrNp34SDgpv65OMBcSLu4Z13onbw7rlXPqXUQqTLKFWcUC+11b/TC+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JAhEm1vu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.46.77
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013077.outbound.protection.outlook.com [52.103.46.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7060A3835;
	Fri, 20 Nov 2026 19:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F7060A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=JAhEm1vu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGZUyrapzscVd8N6IGPMPiUDAsaQ1fObLWNuoF6ACXpT76EBgSuVnTAk+J8ZAlg+fQn0nUU/+L1+ZDn8gpAR/CwnpWunAmdhCTwuNN7RDd+MvAw487Mz1o+yETiofKBC8fvdR4dZq/ze02sOxPF3kVvyUnFp+Bgxv9Z2BzWk7zncuzlgYZL06PwLxmn8c6eqeUGEdzinkKWuIWi3QWINeDcak0ZVy6E09Vl/SuZ9URu5MSWChVdUrL9r7wwRLDschxm2kewwPkcoQNJOBTZYHeLi8VpQF4wcyg8KoWX1ZAHYGWFZOypqZFHcXgt6qqNJ2/PSpnFwrJhXB4GkmKRdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQWPF8RWBgEdZE6zv5GWAE5HWlwM5WpkQICwcPSXW0I=;
 b=cgwlrIsuT2+gD+agCyQXCoZDDcGTDQn/oBmjYWVjwgEU+4t+zAxUlWIUhMft4qKgY36D9bfjKlnB3t7+ZYjfkUxoz4+2X9WZRyrBd5XhO0ACwJ7IFIsvmdcZ+CUyFtvHPmCRmdru6zKcbic9Ss+JH7rjRQX68JEMzfSLhngUaw0/BRQk6VNaOQ6uvjSBBRyFLYLbeWMuHRk9aiiC5fhhg6Zfs//HqOk/fY7rXfHSfvOennDC0a7uh8W8GvuMgoDuwoPhe2GSae/OBORFzFO+nEw37SYchJGp5zT3WYvfM+0yTF4Nd90Vszjk/OJxmmJkOF9It8vG1zX8e5SxUw6QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQWPF8RWBgEdZE6zv5GWAE5HWlwM5WpkQICwcPSXW0I=;
 b=JAhEm1vu9nzn2FZZiN8UOdxa6M2/39+SkPlPVSmlqj9wu1AHS3psXLmGOHvy77DS0Zuti4dZHTV2D+RZlrV4wFzbJOlXcPEshIHExLalRqkqFr9Te8pQCJe30vjzlC4/b5u9EIAjh+fN3QF6Qgslybpic8T06Iw9lUJn5M+9tHU+3uOYF/KWlI8bUNmNpZ+G5ibvp2zPqjZ6WhQbDkaXXwHIk7dKTDZLcFbOtxNo9QbMNPALJ8zK8FOUsfAhS1AF9KTvTRiSK/+695MkVGTmFjt/seT+41J23fC3mk4wRkt+yeeIZcoAVVbFGEIV0AdxHun4p5DWJAWmLdqlMgdFUw==
Received: from DU4P194MB2971.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:641::19)
 by VI6PPFBDD9B6FEA.EURP194.PROD.OUTLOOK.COM (2603:10a6:808:1::1e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 19:29:33 +0000
Received: from DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
 ([fe80::e38e:ed60:52c6:4554]) by DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
 ([fe80::e38e:ed60:52c6:4554%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 19:29:33 +0000
From: James Sawyer <jamessawyer@outlook.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Alexander Lobakin <alobakin@pm.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v4] xsk: set network header on skb at generic transmit
Thread-Topic: [PATCH net v4] xsk: set network header on skb at generic
 transmit
Thread-Index: AQHdeMJYm6rj8qjagECM0thQDki24Lc3WWxg
Date: Fri, 20 Nov 2026 19:29:33 +0000
Message-ID:
 <DU4P194MB2971430F94C6FC2060BD5128A7782@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
References: <20261120073917.63158-1-kerneljasonxing@gmail.com>
In-Reply-To: <20261120073917.63158-1-kerneljasonxing@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P194MB2971:EE_|VI6PPFBDD9B6FEA:EE_
x-ms-office365-filtering-correlation-id: f97b5794-992a-43e0-59cd-08df473c9b31
x-microsoft-antispam:
 BCL:0;ARA:14566002|25031999004|22091999003|24121999003|37011999003|31061999003|38102599003|41001999006|8060799015|8062599012|19110799012|15080799012|4140399003|51005399006|55001999006|24021099003|25010399006|440099028|3412199025|102099032|260806224601699006|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pTxNRvXp9J0IBunvUHHCslcLQTEHO/3sLtvNrd8W+u39ELcK6wAJ4ksWu9A1?=
 =?us-ascii?Q?x+vig+NmgJGlz/Frw42sMFQhLpBKnuxAq0+55xj03hyfta5rWcpgCJpKhpdZ?=
 =?us-ascii?Q?PFyeKJzv+kN8fX/o+uiFUycqEvfFRKcEwBepMQtXXgdMB2R/VdNmMCXNah3P?=
 =?us-ascii?Q?PRejaCzUiLtHR6ja2n9VoA26TP0gvc25VHg25n3GnEiI8MOeLykLuyS1khGa?=
 =?us-ascii?Q?nX5LkPxk8sZYb56zmyoK7vHLnDqS2FjpzJWmAPUhvGC9TW5W+7ypuz1r9cfa?=
 =?us-ascii?Q?2TwMFkx2AJ5iEp4q0nZhH7cwgVrU533BlQ5Ev7RpGVvx+bdtU2gAOkTHhzEW?=
 =?us-ascii?Q?cdX+WKIv+ElKWnAmKR86AcuRdoc0JPhZuS/Y7tbk7DJpdCg0l49pHcU3L07a?=
 =?us-ascii?Q?B3URvqQm6YILUDzh+azvXiscmgh9/0d1YFHuxdsfG16pEy9zwX0znrasB1AZ?=
 =?us-ascii?Q?KwrtwNIZoqkMNE5S002QVBP8BZNBEczYWPI/ESnDx4NivJTpdsilo2/Bx1sa?=
 =?us-ascii?Q?mSFN+f32lR912IUKTdmRIbpc+6mjYMML0NyzSDxpZgR5+fFn6Kjecnvjlz5R?=
 =?us-ascii?Q?7hdGbeO/Tj5XXjNkg9YySLo3Opusq7CYzh9VY4jIfT8t9v9NeSqtDbCX2yPP?=
 =?us-ascii?Q?HydjtT9mkX3c/+AB4t4vIT69k2oxXX5X+MWsDwUsvBH5UH0PfGbCY4QqyQT5?=
 =?us-ascii?Q?GWwuee74+U+ePo/BJnENo2wdMBB+B7tl0Msli8r47BWWsB/+nPR4Gh3bfcQ+?=
 =?us-ascii?Q?uFmpBXYIhbec89vLauGZ3R0ZQpEjs7UqYWZ8yoAgtoapndduv2p2A82SUVwQ?=
 =?us-ascii?Q?l6vxFRyjwozE9MK2moRvjbV4/cMrCABdVWq+2Yk9MareBuQlbWxGFEmKAnMo?=
 =?us-ascii?Q?Fwr6bO/WuRCdGPCS3w2JZHGkHYWAM0C9Fy8WAOCLKog3OVAYW/E0obvlkl0I?=
 =?us-ascii?Q?L6PabWqDPPAvr9L9+PnNTImUij4x5LJUH3OrC1cXZRYSvQ9V83keQuCmvjEM?=
 =?us-ascii?Q?rdeC99x8BTsd2zwtuUN+26ABnaZEsWou7BrwFBkEcwEnjkfwtsUHZln44V21?=
 =?us-ascii?Q?pt0yALXeeMFw4+LWHL+OrZUlC6Ln9imDLVnDczD1cYLNUCUTWp/1NEvYRlOg?=
 =?us-ascii?Q?pCsYlTGNGjUYTzWyiAqzA54NsQmNuO8vkjUmqJX/Ihl+xyEyzXxg57Nmnkhs?=
 =?us-ascii?Q?mTYnpED3YrKLz2LaEBbdZEQVf98HrBgmZIugGg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QOmHlmP6oQC0zgxOgT5g6rA5ms+OaiVJlP+OmL25Qso457hNOKk86UH3cIjl?=
 =?us-ascii?Q?DXCrjMfN+Y3ErpbSj14ZytqFVCd0LXMBogHGPqWCfAZp6g8abkgpO76EKufm?=
 =?us-ascii?Q?lbeJ+gyGaWL3jXN9wCXw5unKW92l/4maSVEGXtOiu73Mdy1kHZi7yizI3es5?=
 =?us-ascii?Q?bbO7/K6gxBWLPFnfUbNs34dglOMgaEsBAGNnKJKdP5eVaEGTYTbTbACgfogj?=
 =?us-ascii?Q?TraeWddj+ngrATmh4Qhyhc6f2+tQmxrY/jqWepGkxEOyoib893svCTuB7D7S?=
 =?us-ascii?Q?FcQ8it3X4iIiJ/gRK29QYZU6QCW0rf/yUX8YgPAXC9iiXUrgzxebdXwS/9Vu?=
 =?us-ascii?Q?GxnHn2AEobuk7Uu+Hru1/UxTDb8HkNxEpRr6ymYd3SA7b+NX9augPmMiVfiJ?=
 =?us-ascii?Q?O8NxwVeCJ0lW2zRbxxunXpVZ9tkpjQHDeX/14E1cKPG/G+GgQIDWMVvoptq3?=
 =?us-ascii?Q?RgNZ+CgXcXl8TK4dpYTK9zOTPmilnwSp/EbnV81NDbH+lN5gsOoLHTvl6Zrn?=
 =?us-ascii?Q?bZrpXlSHhkSn4HPBOGHQTOd3WDPWDMJhZnoBH/tgSGMVfj/CcwZGXSySz8T9?=
 =?us-ascii?Q?QwjTHNmO896WBSiPzbHEVNZq50bTHr2gkBCMBXA+PSJSWi8zDUG7Cwn5kMo/?=
 =?us-ascii?Q?chHel2ya1a8GgX2ObYqya2KbjnHfjzeWdh6v4obkYnlZ9/drsBcmJnahmcRw?=
 =?us-ascii?Q?6I1LqYPxcqc6pNqWJRbFuHpRonM1OP8PmlwOv4w54wijNVLj2QFEN6chzwXL?=
 =?us-ascii?Q?KtXnicvhYreGXZkXogNNVEX08LuzL6cPziidY6bYt5cHbogyXMvLAkMMbN9t?=
 =?us-ascii?Q?p2LxY0NJbqdr0/DsRnP5P1Kca6jp0Vxh2eGD7lXNsTssBYAIKAOxuS1zJgvn?=
 =?us-ascii?Q?ELbHGNmIbaD4NEGKysHywUMbq4AU18XGFv8D6zbCJfgTpepytDsG69SXWgs+?=
 =?us-ascii?Q?Jk0+JzQgpG8mAJwydS5lSuYgH0fq/D+oY5m4pcXxi/fHITNgwbUmQL8abJd1?=
 =?us-ascii?Q?YBmB11dRn6CffnYGYyOVY0Gh7t9+R2qIP8ro238TtO9M4ep6FFHAzE+Hk6DW?=
 =?us-ascii?Q?AC9VcC9sZKFjLGVqUr7SpkB/5wyFYxj+NkQe4Ghh/FeI2O15+dB282Tihnc2?=
 =?us-ascii?Q?ebK0/EKzCs5cD5bkgfEFWjDXs+yrFr/ZRr4DAzKyvxuz4IjAbABIsU2dwFH8?=
 =?us-ascii?Q?givd/0Q4XoiGSmLuHXe3MynMl0I6c1eCAlOHuKLM9MFonIlGEh+4zz7dXV9Y?=
 =?us-ascii?Q?F+TC+CVNSZbev7zUqEjhn8Zop5F1aXhDoFC4w/AnfUseiKlxnerSL+VYbrUP?=
 =?us-ascii?Q?od2WMM5IvP/Ms0bXCOyY6jCIkhd+UHunEfe2cB3HMRN+W6fpxiAG1zz0RKCo?=
 =?us-ascii?Q?lOQNLkhUt037Sr/O1KXKcnLqT1no?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f97b5794-992a-43e0-59cd-08df473c9b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 19:29:33.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI6PPFBDD9B6FEA

On Fri, Nov 20, 2026, Jason Xing wrote:=0A=
> Reset the network header so skb_network_offset() is valid (0).=0A=
=0A=
Hi Jason,=0A=
=0A=
I tested v4 on net main (d7f2d9b6c), comparing the same commit with and=0A=
without the patch on arm64 and x86_64.=0A=
=0A=
Without the patch, an AF_XDP copy-mode skb sent through a macvlan reaches=
=0A=
the lower device's netfilter egress hook with skb_network_offset() equal to=
=0A=
-hr, and @nh reads return stale headroom, including another user's data.=0A=
With the patch, @nh starts at the frame on every packet (300,000 per run).=
=0A=
The same test returned only the frame's own bytes, and the issue I=0A=
reported no longer reproduces.=0A=
=0A=
Tested-by: James Sawyer <jamessawyer@outlook.com>=0A=
=0A=
Thanks for the quick turnaround.=0A=
=0A=
James=0A=
