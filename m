Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AD2139C9;
	Sat,  1 Aug 2026 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785564120; cv=fail; b=CrDP4WBGS8wH6/ZbCRnz8qFeuEBGPEx7eWGJrkByTlGjoeIuSrUdLXP8QFC84DLAW0rcw7oCjovBcsELIOEkAmy8gmsIV/0vji2MABwPeLEVnXbm2Om9VQPlohdSFeUWWwy3hAjB3rk1ZGW4Bjwt7qN+0rUSmZjOlT2K51P+VNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785564120; c=relaxed/simple;
	bh=wSjOFtKw1O42OjSDXPqoGpTWz35aGY78z9KyTFgMw38=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=oC4wt3TO7wSuCFEtnRxzIGOJKwPhNwur1RMGLO+zuF7HA6JT7udD7pFzDPnyxnt2kGXQi0bcuB5jbyhSiNagBomiZ9cqgImyPLGjR61OMEAHNLz5vZMyCqbP7or3puewH1ylYUnU2vFU6f4MtSCbmeBsUaIupmx8oZ1I7sIOvt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t2MJ+oMJ; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t2MJ+oMJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvDmkM/IthVPCGymD049Nuy7U+G5ePN+GdLm534pOtA02Bcc6YRsD8rVorVfWOEo1KbLSDSBPBLglO3m9bWQRcOvpx+WqCyNuWdD6oUg5OurUHTh3Z4YgOgXtt+AQ/XSev7NIVgreFfV0evdbK4wd1sRiHF6kfga9BBzUyZDOm9ebD28eOR2GyDcyTpQJ9B02zEliAz75ddPNQq1iJjwKFwXX48Ms2PNKbWCe2G+6wp08JzPnlHaVyrxELgmgGYOpRZ+wOuMmVKVHx0XFO3BvUQCOustGeolbzD6Il5DTIek3wtESjkP+nngL68783+NQJRnSH60tMrQ25rphD/aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSjOFtKw1O42OjSDXPqoGpTWz35aGY78z9KyTFgMw38=;
 b=egvP/AIWzvRpPe2V+M7Jj21obm9PkymFdrNTn9mSl/15ip1I12u0sQoxboSevUMCDG5TMatOtQnpsrxej9A/T9fHHDIandwW2Eh0N2Yzy4FTTDoXoaRponb4VKBDDtP3ZI9Y+Uze1OmSfJokKYXnUwvt5rI2TDkJbAyGGG+BHFTQ6mnTyspgjk4NUsftcxZDjaFHDLSu+BxE8mdFkSQzSJWKe+9YazwzxlMPIUCFogpW6z1XRNcjhggHoFb04H8ePpMHsx6WU8Oz2OhSwz7y3asJhNlqsaXxqIFHsH8S4xgCOoJ0NcNpqCTqgWZhkk/U7Tn4N5tigv4Vf3TWW6fFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSjOFtKw1O42OjSDXPqoGpTWz35aGY78z9KyTFgMw38=;
 b=t2MJ+oMJoXP6sDfUiSarYufGWOIG/3JuTDFKxdJJr366LxWri4T4bxv7FwQZe3QRsrUqQEiwWTgPoe2zJL83Vk7sX1fcZBt6u27qdChWKmWTy3G+1NcUQLjgKt8+Givd6pyGbiBpfOq4NR2PIh5GTjochMvbL9i2c2jPxZceu7SuGJvNF1g1OxFzefrfH+o38M02ng6EzD8i7CiebDC45uIizhZZtN74ESc7I3I5/zLBNP/QMHvvSO0JBUv6mlRO3GvslLNHIZlSKPXn/c/K5pLOOcCE6e24dOXcDYtWheAB92yf4Nl5dhKPtFwQ4H1jzJlz1Wlf1lPFabo/Oej8XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sat, 1 Aug
 2026 06:01:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 06:01:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 15:01:48 +0900
Message-Id: <DKDDNF6TGYFH.2HGW4GZM9CY6Y@nvidia.com>
Cc: <git@younes.io>, "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Timur Tabi" <ttabi@nvidia.com>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] rust: dma: return zero for Coherent reads past EOF
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Younes Akhouayri via B4 Relay" <devnull+git.younes.io@kernel.org>
References: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io>
In-Reply-To: <20260730-fix-dma-coherent-eof-v2-1-8aff21054afa@younes.io>
X-ClientProxiedBy: TY4P286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ea0768-7a5f-4ae0-e409-08deef926181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vL0YqCYOP/IO/ovLL4QIqnJqYbCnXrCbsegr+gOG8lREicVOXRO8jHM8NGQ5j2P8JvLT1iY/5tUHRTCiqkHDFeUxZDCW8BV5vBOnj00lOaAGX7VXiJoLLYZ7D3c+qPo0EWoc0LbxI4jmEgSd6cwFFE8Wb7btJQeAtXIgYmFz+FPMmSZ0P4XSpDgZWEekK37tlv/iVSio8KgjOOHnGoXf+cSxeA773RfDcTlYXhlum/S6NMM4r2gmxc3RC/4rzV4ts1ddYkwec/ExTIl/iNPL2rrF7mMaag+8O1t+dBEfTDaAhvWdLWVAk/KAd6AJtjW564dbogscpOAIr18T7IjHau4A0adU0Swznm3HSVr++oAQ9RVd5Q9mmO7ReCeqHonveVrx+yywJWRtzUCpGPFTkMS6Fyom/8vg+lAA/XI4KPs27KxcbM2IWZb0g0ISkEv9UvXPabgNnCY9FA8yNmKnbMeQ++UWKHwnTty9HBYvC/Lq9Dl/uWdJAKO/rIl4ARaFbMWJqwmT2V9AiYjLIOjBYiC2J70i3Mrdd+1mBNCovkcSq8QLnxaSjmwFtaP/boli/qBKbZAc+Yx+1VTf3+83ePgTM/91JsJ2n+d0IIjb7B0kSwFyBpdL2d+z2ovzYNYvrl3pgig/t/Dqb84pMXdc/w8bR08nMVjiuZ6VEEmSzFk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE1aSTNocVh3d0Jid2RwaG5uTVZmOS9kOWtaUUlTR21MZGdWcElJM05odHNk?=
 =?utf-8?B?V2Myb2IreG5aQ2o4SFk4cm5PUnFVSkVCMmtoWW5yaFpHcFZoeHVYaFBnNjFJ?=
 =?utf-8?B?aW5KWXpuMHEyQ0J2Z292YzhHendYN0J3K3VTbE8yQnFQY2h0M2NPVTBNNlVt?=
 =?utf-8?B?YmdxNVZQUHdYYTZFclJhSDl0cWxsTXQ2QlpyVU5FWXVEdUJ1K2tFSGU4VFcz?=
 =?utf-8?B?VjVUSkVtL2FQSkloLzBVRnIydXI1S3p5WS9yWDl6WDFZUFZuanBldWh3SUd2?=
 =?utf-8?B?Q2tKMEN6Y3pQa3d1WXVZeWhwNkNxVzJTVEhHSjBUSmZaVDdab2h0NkFNN21t?=
 =?utf-8?B?dzM5d0RtR0FUUlhFQitxZVpnVEwwMS8zb2tCcTVQMUlYSmtWajdVOWtlVHlW?=
 =?utf-8?B?TVZjQ3RUTHl5WGpSVkdBb290L01rQkZXd05zaGZtUXFqdllJUHVRU3NRa1Zm?=
 =?utf-8?B?V2hxVnp4LytkTENxV1cyVkhVK2tGY3plQVUzWW1mSHVGMUFZenJIL3NYeGM4?=
 =?utf-8?B?RGtWS0pLOVJLRXBYK0RmY3lZS2NGTHpqOVZrcWtEY2dBdVVLVHpFRnB3ZlZR?=
 =?utf-8?B?dGtRdUExd1VEWGUrTzZoV3Q1VEJmZmZZTi9tNEFCNStQREFyR1dIVnVyOUg1?=
 =?utf-8?B?cVdRSWZ1dTRzVVFjYTZIZDB6bURlLzlmdzF0aUVObTRTMXZRTVI4WUZYbmZJ?=
 =?utf-8?B?TGFXRDhkWmVYRW1ERjJkMzhETE1kclBLMEsxYW5Hc2tMU3JndlppdGVIcFNP?=
 =?utf-8?B?T0dlMkR3ZmlETmpFTE1ueDJ3YWhFaHZ6NncxMHpUenBNV0xXWjF6Rmc1N1Zh?=
 =?utf-8?B?ZTZaM0VoeFhCSTFZQmpKUm5hVlBEWnN0U3l4WS9ISURnblpLc3BQbi9DaEZ2?=
 =?utf-8?B?aUc3bHNYZFlHK2k5Y3JpSWliSXJVdTE5OWhZZVQyb2pJY1RReU1pT3RnT1hH?=
 =?utf-8?B?cjNvMlVMclZPWGpBaG5lK2lNUTNuTWZYbTh6WTVWdFJYbVVreVQ3YVdjM1Ar?=
 =?utf-8?B?SW5RcUFTTUFDeTlUTWZiOEt2clJBU1NjcWl0Q2QrVEJDdjUwRGtaZ2MwdFpp?=
 =?utf-8?B?aCtsUE5HZUw3OVVocDVveVM5MkQ4Z0ROeUh1UDJ5ZTNxQW1wT2c3MGJkTHgv?=
 =?utf-8?B?azhjYXd4M0doS2JWQ2xGYmtZKytOYTcvT3hiNFFzellMckkrem1TVDh2YTE3?=
 =?utf-8?B?eW4wV3JEOWl1bFFJdHRsMU94LzcvOGV1Z0xWb1VMaGtCaTNxd3JaL3BtZVU0?=
 =?utf-8?B?MnI3UjdWUEVlQmJQZE1yNkJ5aEZSMWtXMTlTS1ZDVUN4cE9KZWNwWUNEanpr?=
 =?utf-8?B?V1J6cXBjSVZveU55MzJkcnBoKzVxWklEeVFXOWIza0gyMDNoR3JLU3hJWTha?=
 =?utf-8?B?OWlXNTlhRiszM2VYNXg3azg4YzI3OU1WdXZoNXdOQ0tpenBzankzVVlEbHdS?=
 =?utf-8?B?VGQzY3JsSXN6UnIxSERNeisxejBuRlh0MDM0ek9meXhCRVcxaG5ENklyWHNQ?=
 =?utf-8?B?dExkVnM2OTNWZkdJZDNOQVEwNHRzcEx3RTBNQkxpYk1iOUtYSnNtaDhjVjJT?=
 =?utf-8?B?NDZROFNuRnlOYlVEWFBKT2xQOTRSNWJPVnQ5UENGZlFPaWlDZVBTbGJiR25o?=
 =?utf-8?B?YlQ3S2FyL29DNFpZQVB4eENJWC9xdktOd1ZuTVF2WWJ1ck96aHNWWHNDTUsx?=
 =?utf-8?B?aTIyWDJBSkdnemEyVWI5T2RkcWdqYlFrclJiSS9DYXNQakxpUDlaVUlkT0ZG?=
 =?utf-8?B?c3UrUC9scXlESkxPeHFwRENqQWpkOTVFSTV4RW9nZlI0a1U3WHdFd3M2cnE0?=
 =?utf-8?B?dkt3UG1tYnJqN2hVdXVNS1ovbzdOK0FRTFRTY1pXekw4UG5xd1oxeDErdEh6?=
 =?utf-8?B?bE9QMDd6Q0libERUdWV4c2VYUFBaUmQzZTVmSnN5NDJKZ0ZBRUtKcUtDQndV?=
 =?utf-8?B?aExadnBVaHBCYUxiM1VBeFhNa1FuaHltaTJQM0NzR2hDMGMzSm03RHJuRHJs?=
 =?utf-8?B?bHJuTTZTeFdKZDkyaVR1RkVHbzdzRTMyTkI5MFBtaWNpelE1WW05RHlTaVlk?=
 =?utf-8?B?MFhYT2NQYTlrMVpxWnRyNEV5blBqTUtPUlJmdGMxQUFKUUNpNi9rR3FodFAv?=
 =?utf-8?B?SVhXN3A4cjJvZ2c1Z3RDY0E1c1V0WWYzcUVqS0dqaGMvZDJXSmMxT2xtSndF?=
 =?utf-8?B?akJBMUFHcU9tQnhkMjMwdkZ6R1lXamh5cXpvV1RhUU5uRE1kNlhjVEhjMGt2?=
 =?utf-8?B?NjhpVGh5c2NNYW42a0ZqMDl4UmdvSXZHc0RMZXVqSjRYcjVhaWxuQ0d3cjFm?=
 =?utf-8?B?dUNZN2xROFJtQTB4WEFVNHZpWmZGSytDN08yUWp5bThvelBiN05ubnN6SDRo?=
 =?utf-8?Q?AURTsx4ehzeRgmegxzmvMbO2/JOC3i03LHqrgXl6zPJDX?=
X-MS-Exchange-AntiSpam-MessageData-1: iErC778wH8EqIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ea0768-7a5f-4ae0-e409-08deef926181
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 06:01:51.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YU2SQgJuW0nQjKUqp80WGPS57gVwNbWxEWSfQMrJYXVrvycYwzI8Eddk4uK1XHBS5UTAHVHMV+OFpIQzFkD3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

On Fri Jul 31, 2026 at 1:34 AM JST, Younes Akhouayri via B4 Relay wrote:
> From: Younes Akhouayri <git@younes.io>
>
> Coherent<T>::write_to_slice() calculates a zero-byte copy when the file
> offset is beyond the allocation, but still calls
> UserSliceWriter::write_dma(). The latter rejects offsets beyond the
> allocation even when the copy length is zero, so a debugfs read past EOF
> returns -ERANGE.
>
> Return before calling write_dma() when the offset is at or beyond the
> allocation, matching simple_read_from_buffer() EOF semantics.
>
> Fixes: 016818513936 ("rust: dma: implement BinaryWriter for Coherent<[u8]=
>")
> Cc: stable@vger.kernel.org
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library=
/topic/.E2.9C.94.20Possible.20past-EOF.20bug.20in.20Coherent.3CT.3E.3A.3Awr=
ite_to_slice/near/611677095
> Signed-off-by: Younes Akhouayri <git@younes.io>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
