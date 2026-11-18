Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033487;
	b=l7hEDtWOU0TMEtZmT2uec4hGBE/G6jgu36eECmaY6xe6YlVQZIq9b8DQHRQdSoflHhgo
	 c16Imv46Am+GiMtpurbPFR+toKedYNchxxVwU174clE2ghnG6TgL4/7AQaCKiioGvOvs1
	 0HPk/DqHZpzKjDUW4V9zmiEe0TMxrFrYWNJ3HsALOOdUh/1McIr776P9PAYsHE3z/BK3j
	 S1sifCS47ZRtY2JuMzqWD00ksIevldTdGh2+RRGh0cFbq8YFTqb/jh9gv7bjN9hTTjJtB
	 nyXNSQXVLuUSGrxlD8pJ+6f5GmvjTTkXByTftRT9jnmfFFjgZe7JJeg6BdL0+5IUbxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033487;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-exchange-messagesentrepresentingtype:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
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
	bh=ezoyfoqwKtNl8XeMnaX5iryFEuvqK/igwUSAlPuYMog=;
	b=V5v9JRmvkFQ3nfBcm3I4jsRIeKzzxKM+Qu+HonUOc87sLT8FCSTKx686mgj9vFKZCEuv
	 sQR/OQhREoSMd58MQQWLGByLVF664/nuAmJsSmKpj8wwanx7Ak3yXmHUOpiXmVYQ/6gIz
	 ezRC0qnr6IPzJdgiWnGNrC2FA9IwOfSZLZ3kb9vOtJyzikxwZqoIHs5f3cQaxmP/a0Igg
	 watNK5/nqA4zH68CcAlhEh0TocGKuMIPqfSKBlG0MfDv6m+D1z1PQlcO+Glv+VyfvtJTQ
	 ofmQaJxJlreoPjaC5OExEP5lXt4Km/Vewoct1lGDohLVqg+e3NyJe8L1OW/zwEQ/POw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mMJWOzGL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.3
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010003.outbound.protection.outlook.com [52.103.33.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AA606A325;
	Wed, 18 Nov 2026 20:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8AA606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=mMJWOzGL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tq7HzMDxFT/z2FhZTz3vMF9a8gti3Mr5EWosBNQP7T0z8OuawU2eBAGrcqRaoTpKPsYUcnn+YEE+WJ+8saoZUugVARD1IMzt4Vph8sGh5ta9r2XE5Y8o0z+KM/p8eVK8P5sq+g/tZmPOLFVQhpvORByEtzjO6dlWdRf9EK7IFmEFgpVlT5yKrsFID9z7uwt1khE0Q+GQgxOPcI+HNlkbZRm3dB1QlG754r4r/h3fylP+R7PPgCfBviBRCtEw7ZaDc5rGYFpNybXIMa97b3YZ2q8gQB4lhhyUdn0nZ9W7xSUtPKdHxgRJvDYWi5bvK1eksDfupcpoX9t4/PTGGvNvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezoyfoqwKtNl8XeMnaX5iryFEuvqK/igwUSAlPuYMog=;
 b=aNtsXdPMxdMD88xJEr8seXX+OabuEtBtvFQ1nYeosWtKOcdHi5IJ9z1dER4vJG13WubxkYWnaicUi84hGAB5j9JkdWIMU26lGj9augXPj6g8mMq5i5fZ+nQ2vhbnKdMIOiFns52ibEgFdEfexUiM8KcnnLBblIMfFKJ5gYGNst12r67huKJq5hKtmw3sr52OxMJ4hx2mFny+unHJIVC+KA2dWOaMiXnYz2qaDpTamYJ85eZVhfMW9rCd5hYigXjL9po6ylCKQ7MG4F48l2DO72BZqZ+tsh10IbiAlvEDdeow5XnDT7MG8iUMEexxqnMHjIxMwhqsYWHMu3OnBw5S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezoyfoqwKtNl8XeMnaX5iryFEuvqK/igwUSAlPuYMog=;
 b=mMJWOzGL9ISsB9wej1H0L+veEmDlgWd8ld6qfYe1pizHnaR/Pga6weQUe2t+H10OHNNTGTgUyIUfmDG9H3Hb7sV1tOddumDcKAF1SxDfAh8CZDyqUvMlhu8I4KfsKkZk14hT1LvB9qlZOdB+c1uGQXmvCShUhVps0dbMqcF2SaCa+4NV7BeEoCxomYqnoAsJEtbP54UsG6RMHpnJ/W0nJyWvWVqvbNlty4ic500cmuYfts3lIAxODM9874MQDQG7QE9igWPL+gh1+ej5ilGknAAxbHcqoa30YiXBdB7KYcvxQ4pFVmfzLJbQY5HcO5HbGBwEWm5o51aGGxI8JhEj4g==
Received: from DU4P194MB2971.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:641::19)
 by AM9P194MB1345.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:24:44 +0000
Received: from DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
 ([fe80::e38e:ed60:52c6:4554]) by DU4P194MB2971.EURP194.PROD.OUTLOOK.COM
 ([fe80::e38e:ed60:52c6:4554%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:24:43 +0000
From: James Sawyer <jamessawyer@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Request: 44378d02c5aa and 73e08d50eb13 (virtio UDP tunnel GSO
 validation) for 6.18.y and 7.3.y
Thread-Topic: Request: 44378d02c5aa and 73e08d50eb13 (virtio UDP tunnel GSO
 validation) for 6.18.y and 7.3.y
Thread-Index: AQHdd5rYWajl7rMZw0S6o8aNdwebOw==
Date: Wed, 18 Nov 2026 20:24:43 +0000
Message-ID:
 <DU4P194MB2971D02EB218B47CFBC82525A77A2@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P194MB2971:EE_|AM9P194MB1345:EE_
x-ms-office365-filtering-correlation-id: de9cb1b0-8af6-4161-2f21-08df45b1fb62
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/DsDs4Pc2LXzQYTWBm0VGheo0ltdYoP7FDpRAMrdVAc3g4veroqo2QLzHLiRapd6gHrGyzhagiGme7m/lul8vTcEKDrko3rbOg8ZphzCm7WI1C9+yhdHNps8/U9u52Qgl1LRyM8V7zEkGyloBikCXWCrwc+EV5T4SE1qNbb//ZrZxJci2NoE5LXTPtPGe/utFDeOOYAF2SvvWkzpkp8UxnZ6lYlc4SkGt3yadZUv4vbDrIZmsKkVAGQH1rUEsXyYomg6WJPF+F+xkWH79XWw5AXtr+4KcHbW2LnaANs1n3X0ZDDgZ6xWWKd5+yOPd9OXqvkCDn3pFYNYEBuYgI+6iOtNHwlsHH9xnh3uFOP5FFBfE+WW4nLRylY3nghjqnDE8xmIVnF/MTpJ7VeDlr3cJuIculaDI1qBwfYxw54xmU72ZghB0p9KAQMon8Bl9ULFHYVmcH/1+dGGnyrf673SXqv5Z3RdCPTD/H/XjxX3bqKNCXEJL4xuXdqFpdLkd1EX/5nH2Qbcg+mqcFUuTzcOgHQbqeX3TphJX2f8W3cv7zbX/Tzxwt2CJcqVISFZPih/YX3y8bYjrqPZar7nHyFthe306o4mO9K+iQuAPU70sHi5qJORefs/EIN6LhMPsdAF4IAYcas91Ih6pioJ02cHdUu4LgUZHq35L+1prZrD7I4SqzZf9LuW+MlDprkaf4OLehXQfj5HQgpEZXIaQVzaV1DoJ84HuUC06
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|22091999003|8060799015|8062599012|19110799012|25031999004|24121999003|24021099003|25010399006|55001999006|15080799012|4140399003|38102599003|31061999003|37011999003|102099032|3412199025|440099028|260806224601699006|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5wYkN/dO+NKdEDAfmjGv9ohMMorxdbArBs4WTOfzH0qc9EEVxMwhK+6CfYQg?=
 =?us-ascii?Q?1NouLyQHyN4FnOvTrEie9KHQKNr0uiWnX+R/a8zvL5YW0S+aqeQiNz8Fb8wI?=
 =?us-ascii?Q?dFoG8OIaB0vioydK2R2l8bn3Y0J4CqVSe5Ck8ttppT4j0xOjp16caiFFxnZc?=
 =?us-ascii?Q?VYHLMbDNaKmtZElDZRL8MugGi9mwLsEOLz1G3nGzSXOBmtcBQgxWca96wLJb?=
 =?us-ascii?Q?JG4s5ncVdKNRhIt6m4oAUanX12SVkRaDaLXFEnEbPvocGBPrlel+xCXIjKs/?=
 =?us-ascii?Q?+D+LThvb4bmdtaCTzfWKRNQQZzK5XUDix9gKS+fo8IU+RZmAIeyAyo8WJSLJ?=
 =?us-ascii?Q?zGt/47evoOCbTxO1Sgcs1e7QCS/E/5V2FaLmtyD/87k0UM8pmAuOkVrVggrY?=
 =?us-ascii?Q?Qv4ImW0I6is6KLZc3BQh2nUzYVksocBe5h8kHd5iNz+T1qgmm0r1zIHsxYJH?=
 =?us-ascii?Q?uR8YFSUYkTLZdQkLyQaL8maVBKIiU/Egtp48vvVjahHNQcv1KaMn40zd31gj?=
 =?us-ascii?Q?VB9DoN26dts+qqYyoho4j5KOKIGO0gC+BM9ic2++BwwfCRcEIF0mgBQRdf0R?=
 =?us-ascii?Q?hgCAdVr+k5J5V43zvtzKFF8H43GCRJuyJ966IVo4J666XZ+z4oIW8QS+h9Nj?=
 =?us-ascii?Q?TYXWHuDkBm7Eku+HaTKi8Vsw6fLrVfch0zfi7s++r7UMd8rJSl9k8BsvuOMw?=
 =?us-ascii?Q?CIkMpsgIyzLVWsSU8PTKGutMc6SuIkLLTpV7sBIdqJC1zmUpQ8BEPRNPZqSH?=
 =?us-ascii?Q?rYNQdjNjVarWf13uJd1goobSY1MTD6RdUWM4ozVl8cqfJyAI+SQY/Wsw8wDG?=
 =?us-ascii?Q?u7iEOiULTT2NGpe5TUfOh9RTtygvNxWj95QfzWa8FSu6UgLcz7YTnDNyRSIF?=
 =?us-ascii?Q?HzpeOAbs0p0q2l4O1TZ+5PDb5LK5/rQjo3QIPsW3mDIUGNDRqtjI19OkQ6G0?=
 =?us-ascii?Q?FfdOHxynsXLoMkquKDOdI96d2IzfoqlxgllGanZJYNjjnaD9xWc3QHubxpv/?=
 =?us-ascii?Q?4ihAhmA32wHg5hZiJObhkPgSZR4yrVDWZqgjMk1YVyxMVvPijRKk8ieSAQSW?=
 =?us-ascii?Q?osbcz7THL7KGtAAb1ZJANJZR9Lk2pHKsgRyla2+4e2EfmOW8htCQyJW88vnc?=
 =?us-ascii?Q?wZ6oknoO/XWZcVcQjCiVaGLgYa+CPgpZCGvaxsNqCRBbzvPPIteLVhE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pLODaobCRfZ700BaZBClZra7RGQWoCL5y+Fj3APccRxH7CXRwfITC7vTZ5I/?=
 =?us-ascii?Q?bxUiV5pJzz8e5Vpy3FuT1mna0j32UWonHws6NYVZLghlnJcl56AbAWwHZi/r?=
 =?us-ascii?Q?9ApbIHAgh9/GFuUXMr7VKvWv0tIOWhkYD+Xc5A5tNAPjQmzvhHHMygPzul8S?=
 =?us-ascii?Q?dZOD/uJCt6k1917AsAF1mRqmDeTl63x6dpaYEv8ADXc5+DAu6o0AejKilYvc?=
 =?us-ascii?Q?4QnrbCdTZ9yGbALWuq1e7bFa2UunIwPHDcXbYg+mqENSJqbudZCSD/xRHGYS?=
 =?us-ascii?Q?oJ5VUZrAa0z3xfnTyvDvJD+VuM5iXDaUsGWSqijP4daeP23b/YSq9KJ6Sjxm?=
 =?us-ascii?Q?qxXhdZL4ywVTCKpf35QWEw8gASlxMLf+dz9n2MZt4PV8xDDUN5PrrPVeFU5x?=
 =?us-ascii?Q?gp0r5etwphURXI/U284UFxgq+jIA77Kc15yiQpsY+2GcWHFAL/wjSe5PrFYk?=
 =?us-ascii?Q?Fxc0IAgS0OYmrxqoOvIvg0eQrdsU7Lm8n/OBXhYMB8tNgAaPWEoh8+99U/JN?=
 =?us-ascii?Q?t/cux7C+p94RFAbZkAV2L5u9/1qARWrIHgCuZCwT8605dix7M2D4aTsC8fnk?=
 =?us-ascii?Q?84DdqeJ+vcrcjLKsrOa/ooznh00KSUC6FIPJdqK/0ncHTwC7uFG7q4Pj9234?=
 =?us-ascii?Q?74AVS6fHTCV3vJ2jUVhwSw2xGm4QcsxH7le9F/8FZQPKo09chxZ+HQUQFP/x?=
 =?us-ascii?Q?sL/bYBVZ+tnbcF0qw/5Fkt53T60OnoNMma5M2PxaNPHCTA28AUf7grRzK+jf?=
 =?us-ascii?Q?FqIB1522/zOYDfJe6pZkQ3GwqFfAofwiU35sBwKvS4hr9ZUFBf8/oBKR6+XX?=
 =?us-ascii?Q?Cl5QtiJVmbZJIdGAwYjtS5wtUjfxE5MUNg1eYe1w+Yr6F2cXPPT99zTDxR2u?=
 =?us-ascii?Q?7igxOuqZ+VBsI4Qf3rEHGqRDyx4Zk6CI/vmKo2bUqutcWO+9Ih5yjDBGBx5F?=
 =?us-ascii?Q?VZ64h0vFKh0pnrnSnFZI57KI+PzQ36rIEqKuMx5x516WOChVD161hI+LC+u+?=
 =?us-ascii?Q?/1KvllGOXkzLxUqhvkfB/hKnDAr+BDnJ1FeMbIgoT3SdcFDn8X6LjiVgE2yi?=
 =?us-ascii?Q?EFpjzpXf9hzseeXPnYlIYv7E1e5XqWrNTiszg28HZbCnOR2WL5jL4vJXjCCC?=
 =?us-ascii?Q?7ieSnI53fg9F5vocpBcsh45cYzaOdvqNLyKEGC4bfkaXFhgvWjdx0rDst+XM?=
 =?us-ascii?Q?FzuNly2xzko97uHqCZoDql12ipFhiF+NMgsksLj8zNxt60DCxXvs6zICV1Xs?=
 =?us-ascii?Q?CuHoKmZSc+XasmAkhiUE1c/YbB2ZsjLCxt5Ifk6G6S2qAMI40M2hloVkUw9+?=
 =?us-ascii?Q?4MC8xU1TDRGxz/J4ib5o8uPRn6ALXIKpuDEkwa5sEzCGt5dqcI9aUeSiAbPc?=
 =?us-ascii?Q?NeOVNNPbj0tH104xtmY7/sA5Is7n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de9cb1b0-8af6-4161-2f21-08df45b1fb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 20:24:43.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P194MB1345

Hi,

Please consider these two mainline commits for 6.18.y and 7.3.y, in
this order:

  44378d02c5aa ("net: always dissect GSO packets in __virtio_net_hdr_to_skb=
()")
  73e08d50eb13 ("net: virtio: validate outer protocol of UDP tunnel GSO pac=
kets")

73e08d50eb13 is in v7.4-rc3. It fixes a2fb4bc4e2a6 ("net: implement
virtio helpers to handle UDP GSO tunneling."), first released in v6.17.
It has a Fixes: tag but no Cc: stable. 44378d02c5aa is CVE-2026-98954.

Neither is in 6.18.64 or 7.3.5, and I did not find them in stable-queue.

Why: tun accepts a UDP-tunnel GSO virtio-net header without checking
the frame's outer headers, so a VM guest (through vhost) can make the
host build its segments at the wrong offset. On an unpatched v7.0-based
distro kernel I reproduced a full host panic (skb_under_panic, "Fatal
exception in interrupt") when the frame is bridged out through a GRE or
VXLAN port. Without a header push I saw an out-of-bounds read that
hardened usercopy stops in the receiving guest's vhost worker. Details
went to the patch authors privately.

Dry-run apply against the current trees:

  7.3.y (7.3.5):   73e08d50eb13 applies cleanly
  6.18.y (6.18.64): 73e08d50eb13 does not apply on its own; with
                    44378d02c5aa applied first, both apply cleanly
  7.2.y:           already has 44378d02c5aa; 73e08d50eb13 applies
                    cleanly, if 7.2.y is still maintained

I have only checked that they apply, not built or boot-tested the
stable trees.

Thanks,
James Sawyer
