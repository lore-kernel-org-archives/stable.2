Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012017.outbound.protection.outlook.com [52.103.10.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4528E0;
	Tue, 22 Sep 2026 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036050; cv=fail; b=CUjrAiMf0lWBRhrmYkjWLcQC+3jzdvL6kjxFL7C9DiOxAs/j1+7Pcxc4xSsotmJK1Uz7Qm0fNX1fyqKHOpde+C/Ms5RFsDbFXlyf6DCvlmTWIQ+m8kePkqCzMigs9IjJflwo9OcmFxoFl/m29L82ZnPonavtlSC7df4F+7jXtAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036050; c=relaxed/simple;
	bh=gNerFCc0+33I+TNEm77LlTzzol7q7ryJ7Gtn7sGJ1Qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pnG7NT4ZPtRlzzPN0e2T3rmlG9ocWJNVKzf4rLxgLcogtn7gqD4x/aemyogxLm4nrAOcYo5tKljCKddeirOF8TiEUvP++v+ngtTq8DAmstyNNNP5IHazrLrE+K3ISFmUjNAvYnSYcBGN99zeAnzTw/b31VAiX+JN/K5kMVeFaGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CRbat4L5; arc=fail smtp.client-ip=52.103.10.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CRbat4L5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipO0kF67mYjmqs1INHylnCiGTBDMt/4pSeyyq+T2E9ISyvov+L1s5gaBSbL6Ld8KyFSXlEe1mW/8Qm3rhJq7HVYV/vNORmL8B+s08kG9DQRHAibsdcH2kdmsZyqba7LH2Y54cdNzHH6YTMyv332sPP4q4vCU5mni7zqhyBe9xuvMb8X8TR5oeGRp9aJX0BsaljXJ3GzEhcJf/T5ssg2GBLawL+ZMKEFoFkkPmiU2x5iEzriWVfhAHhkuChMOQX+xO36bhLZjO1yERWHhKtA6r9DTBuDj27btzr2I64yPCrorztxz+KSSXE3FMhe/sM7DcW7UJlAve4bTOTItTxDqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWbvNFaHcSRhPt85ka6FkzXn2Kxfpa6Ficmd1/1cVd0=;
 b=vQRgF7gCI1vxd0E7js7y8z4V/GJLcCLDRIo3IBKcQZfSHHJtHjwFhB70EvhJPvoW/RNPBlVXzVNqK+aRXwFfpIgDXiXJj+8Puujt+NpVT4vSWYYQam4NoQlqFULpgAhCAgtnmm/bcYqrW+CZjDj5yCj5C3AbOJITrDuVUXuz8of9bgDeFxBmkl1Dw6vQ68c+LtUwmpMetd0IwYoyU+m280enAMTCKMBMKmVxsdA0W9Z4XKYg/RC4bMNHVRcALDLeA42wO3IO6j4kLQL8IItWlUlTDY8uCvyLp6B/v957zUV/b4s+09XvqOZka6LIm1EvH3GacM8K1cKtex8LzOi7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWbvNFaHcSRhPt85ka6FkzXn2Kxfpa6Ficmd1/1cVd0=;
 b=CRbat4L5TnP7vKiSO4J1vx3wKKgxtVZ2zHLznOwH8Mp+tjaYzag91ZNfr3Rd8okWqo7yWpf8q2u3v5+lYykoWm05ofTXmv/2mDb/u2kE499ms8EeVDm8GZ7t00eSBI3ZuH0QyMt+sI4hyUQwe6WlGNY+hIkon7Df3DVOc7rukRLKRp1PE1LD3QXysbDRGAJPn0ZCSViXOYS5TrvcnIqywSGKEg7+WC6SYLUn9NKttxUJF6CvGlltzTeBySlq29+hq2LgWrLbbj8RjzzaPrKvBKrVmcBU/BxrAfX42lW8vfAaa7EDtXA+dXkv+p/jdoi/Rbz60xy14AibD/jH314F5w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6826.namprd02.prod.outlook.com (2603:10b6:5:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 00:14:07 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 00:14:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Hardik Garg <hargar@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>
CC: "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mshv_vtl: Check per-CPU register page before mmap
Thread-Topic: [PATCH] mshv_vtl: Check per-CPU register page before mmap
Thread-Index: AQHdQhY+bZ9UmMFCREyi3nJJGfUaJbbZylqA
Date: Tue, 22 Sep 2026 00:14:06 +0000
Message-ID:
 <SN6PR02MB4157E82658A24F00691EEC8BD4832@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
In-Reply-To: <20260911175146.1370148-1-hargar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6826:EE_
x-ms-office365-filtering-correlation-id: f82f5e41-43ed-4c9a-a17f-08df183e6ad1
x-ms-exchange-slblob-mailprops:
 laRBL560oLSPhlJ95/U7v6W/AahuugGaA6DS7CV7lVaouR2Jc2kkZCRTtbjnqGh5ovd05Wp2JmT7J5LQuXmL4FG3u6OJkn3JC6Ai4mddc4JsZMCnXMTQ4ZgI9KZCW8N9caJHCSOubLCStgJNAY7YCJnl4neyebtjEGDlwR5xS+DMKFmaTslokGJhaPyMrxtyy0pF03l36VqQar6VzkHKtsBQItPnr1DvAv+7B/s3nmJ3J4ct7aAHxww3s4VDqXTz1LRz3pxsZQGpm0t85cEZMav5y1ew/sSs13R7Ewp9J7DLvDAOHUDu9wrDvH6/OHieTuuxNV2A37j7Nr2iHKwUCcH1KW9N6J1C6oWMIrrm6dMxx8UnnP7uAQWHZrFnDB8FMPQEHATNGNvuLpoouw14fmoRhD5QSI7/+7sP8rgWBnKjkD+verI5SMtNTLLZjGTO0d9Jm9xkMW6b/w+lKMbVyNpa7VjGkItDiEJwpLMBk54SVKes8gvD4rRFlTYLV8ge9HdLQ5wl/HZDvvTBBhe2b3QDGqFWAnl2iIPElj2ZqtfMLbcCfQlXzd/13fuhxC03V8MB2EVV1mMxgMUNqKvx5ymu7j/G5HLAkUajkmQ0dfxaYbgckn6DYBS4kjA+lhU/M3KhfyqirjS5xQsoTESNu7DMhEl2l6mss9nDUP4CADnqhvGjG/JIkkrY/6XTng0iPEjPqQmRRHyXBEYtHvRtE2SCKHCwOsgA0bfA96/799EEqY5ObLS5YP/T8J/j4/JaaJP8XzizsrwUu3ppzhaAU2BG4EBg0EXr
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|15080799012|2604032031799003|24021099003|51005399006|12121999013|19110799012|8060799015|8062599012|31061999003|25010399006|41001999006|37011999003|55001999006|102099032|440099028|4302099013|3412199025|1602099012|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iy37h+McsmKqARQFusjh6y4O/2oCXwKnFz0UxNeQ0KZdu76G38UX8XDwXJ8K?=
 =?us-ascii?Q?pxuCDkDKdWR/VfnODI+hw19QNlQ/unLDV7kIWBXbwHkUgw+h8kMLfk/Hy0n9?=
 =?us-ascii?Q?2+t1ANLfYe7lbyHUDHwa9x+ONjaqJ6ZM+9dHC3fpBWSf1/jLiK1kdEg29kAM?=
 =?us-ascii?Q?/1hoA6re5+M8q8efO+EUgoJ3EjDzIHlu8elCE9AEHWHXmB+RllU5Fv5uoXjI?=
 =?us-ascii?Q?qXL5HFsRC9iE5OZ8jlVEeodJ5YtorlZGcibrHfwVgXdAsVljLhCZ/eGSr+lI?=
 =?us-ascii?Q?OFTLYFcFybn3/8ZPMe0LekceKn2ZcHbGWkzTN/4rxK8myFM+SrnuzLO9ZLcO?=
 =?us-ascii?Q?DY/i5Wos8o8AA5WJdRYAVYeOQefZj8quOy9JjtuOeHglwNDoQ7AlxjO6ZCB8?=
 =?us-ascii?Q?iQKxtIOvWl0uu0uqK0dkLDqyZXZhA83ACG+LinJn2FmNpeKNIT4ZEWN/oVT4?=
 =?us-ascii?Q?23F4vlFSrSPc9vdQDqyWUNxWaSnE8sQEmGh+7i+P6EqLCOoGkBXfeLVvyMz+?=
 =?us-ascii?Q?C/CXMYpO6dEwwjoiyd32U6FPR1xvWb6WST7HnEsg3k5gyOjq403GB3tEZtws?=
 =?us-ascii?Q?+DuCKSnBt1eVNin7S1K3tzf6c0s1+fUWoN28Op++smz7PJosnocjefMR8ao7?=
 =?us-ascii?Q?QV0y8LUrdL5R0BS7kMfqjQOPS7AqKW1Dh15OfPL+sPtNXczxQ+BcWpifw/6e?=
 =?us-ascii?Q?REVAILstTo1jHah35WTvYoup8xFyQR4tLDKYPCg7ZtrOkxTg1spJFn1g2Kxa?=
 =?us-ascii?Q?9tcOMvbu3517W2oBKxpyw6BSox5EOkQAXFkOPI8Ha5vF8lcEMpXeISaRxHVe?=
 =?us-ascii?Q?2jT6FUCR3x8kzbgn6xidTbT3Glcevv8ZT7wa8lbTvcLCMQsfL0AoHAYcmNQZ?=
 =?us-ascii?Q?DDi825C7pobfChPml+tDyhyVULrYD+nVOpFbC+BpyJTRO6wPtN9jVBodsgEW?=
 =?us-ascii?Q?3uLy632w6JhfVwY8wGvQCdF7b7zBELc+uSLaet+ZI+7eJpM5BQKaJhTnhCC4?=
 =?us-ascii?Q?li51pQAxltvmDKWjD9DQ7Gqg6lncqhioFVsHAImRXU5NqlSVRAfkUKILK8nv?=
 =?us-ascii?Q?3TOy7tk77MB4Brhvr1E5ZQMq7zlYPN7uVrrAcbPEsAMBwhNp/bepb8+KbiHL?=
 =?us-ascii?Q?W7bXXrbrQAafec/PWNfqvvEcJdEkS8/iifvtlsUIfAsAf2YsPGfhSMGIbUnb?=
 =?us-ascii?Q?RNmYPI/GUplDiWq5?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IzTVuXe/PyO68VwKwo1NpzFGZwEObLk89JmO248RRtcsXUkQQYkGM5GJoaZy?=
 =?us-ascii?Q?xNYmuKZIGwq56XfSe7dxnwsIVID9kGcZxdD4aSj3m+nSZlh0922BCzo+X9zL?=
 =?us-ascii?Q?Gcy1EYNz7DkNIiI/0cYUdOjlLENu8662yL3v7KN6F4T+apJvBoPA831K7us2?=
 =?us-ascii?Q?L+1LtG8s0I1PaKrd2xT1cEvbm8QYl7RYozph5Zwq1FUW45IMF4hWFuT+EPDi?=
 =?us-ascii?Q?Hmpu7Zp4LbcuBq8ryLRw9UWCSspy2QgGVUPhm+8f0lWihSI+nP2KKfxabPxb?=
 =?us-ascii?Q?T8OGthuAyNhwqJlCZCjeL0jAkHKF2D2cttlsZeDbcm/N7u0/Y/kXDmRQxhL+?=
 =?us-ascii?Q?E3qzeDk6Lsqimc7zGZksaXUGptCauUxlUsR64Z2F41tCn1rqe5/zwXfiLHtg?=
 =?us-ascii?Q?NS1bPTavtt8sZJMd84sNtLkSCHSroAcin8WcBKxxoQOxNWPxbQlThSXxAQtq?=
 =?us-ascii?Q?cxcITqJtXfYDfmc+6XWWtCvI+TBJ5EI4egjiQgHUubmY56TtxUyaQGl4xbA6?=
 =?us-ascii?Q?Ibt2jyMS1a0Qip+osMiJrnfyzc3gMbBow5yRQe8BBRZwg3jV1zt+loLYeq/b?=
 =?us-ascii?Q?hic8WMLweLr07c5Izhb8szdMO2GmoQzITQiIm+y7vW2s6RympvIJJ1Xd7kcf?=
 =?us-ascii?Q?iAjWavMcKnUaKyyfimVXw77K7DEm7kCLEspDZLmu8FCWZt3D7n9vc0elUv2I?=
 =?us-ascii?Q?n57FgvvKkmg2T6TsZ1YlOJatRrhAOSc2zGkaariFqm+ChDQPVo+jP7l0mjmV?=
 =?us-ascii?Q?m2HcoAn24zdfpcNekMEIzhlI8oCLCTMSwnjhYkTm/LDmB+UkMX9ZhdFivgWl?=
 =?us-ascii?Q?llOZuJY/I+1r3Ush6RUwyj/9jnhnUtyH6Hd1Pd5nF0+RG2X1mPaK8GwXT7Ca?=
 =?us-ascii?Q?6UmDNrQvbv5VUrtXvqikgV4XxwJbIbASDYqJK16C9tf2MRfUpJCR535xowzv?=
 =?us-ascii?Q?tDBqdOK6hm/zm3lUFL2TNkGnIu5ULmCuoI9j+ViBKOzkDRsDKlmMm3D5rpXw?=
 =?us-ascii?Q?sTGpb/sT1WvMFdU1FfZqXxMvwjEcspSOSbAyfolWJLsJ8l7Y6n1hZ3NCjYP4?=
 =?us-ascii?Q?0aBwHDyFBCvuXu7BIjHZkZyPWEC4df9i4aw8HkBms2t6fsfCVtQz4i0nle35?=
 =?us-ascii?Q?mF+qg5h/sTjtbXQEC921OfNZtTAxXvi4ihZpMQjqNzWQMBzRa7eSk5HhUwlZ?=
 =?us-ascii?Q?xqptBXMH5Z7RrNWV72Ma0lkYhQNEx9uvm9KcvWSmX3TBA8SJpaJXFbdlZOus?=
 =?us-ascii?Q?lVySe229F47dFx07adXOMu/tBrFRHsBlXIbP9GU7KciNoiHeOXYD5V71Rts7?=
 =?us-ascii?Q?amRTXG1BY//+fBhGJ6K0XGfC6OU7D4qm/4ONYSM+w24FsCAHxRXV6cw/QwaN?=
 =?us-ascii?Q?VnjNpAw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f82f5e41-43ed-4c9a-a17f-08df183e6ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 00:14:06.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6826

From: Hardik Garg <hargar@linux.microsoft.com>
>=20
> Register-page setup is optional for each CPU. If allocation or
> registration fails, mshv_vtl_configure_reg_page() warns and leaves that
> CPU's reg_page NULL, but initial context setup continues successfully.
> Meanwhile, successful setup on another CPU sets the global
> mshv_has_reg_page flag.
>=20
> mshv_vtl_fault() checks this global flag before selecting the requested
> CPU's register page. With mixed setup results across online CPUs, the
> check passes even for a CPU with no register page, reaching
> get_page(NULL) when userspace faults in that mapping.

I'm a bit late in reviewing this because I was travelling all last week.

This patch seems like it is just papering over the real problem, which
is that a global variable like mshv_has_reg_page can't represent the
status of an operation that may succeed or fail on a per-cpu basis.
I pointed this out (as did Sashiko) in review comments back in
April [1].

The only other place mshv_has_reg_page is used is in=20
mshv_ioctl_check_extensions() where its value is returned from an
ioctl() system call made by user space. That's a questionable practice
since ioctl() usually returns 0 on success, though the man page for
ioctl() does admit that some ioctls use the return value as an output
parameter and return a non-negative value on success. But even
then, a single value can't accurately reflect the status of an
operation that may succeed or fail on a per-cpu basis. User
space would presumably have a similar problem to what is
being fixed by this patch.

Is there any reason that the real problem couldn't be fixed
instead of doing this fix on top of something that is fundamentally
broken?

Michael

[1] https://lore.kernel.org/linux-hyperv/SN6PR02MB4157CF364DA2C0CC657A6DCBD=
450A@SN6PR02MB4157.namprd02.prod.outlook.com/

>=20
> Check the selected per-CPU register page before taking its reference and
> return VM_FAULT_SIGBUS if it is absent.
>=20
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>  drivers/hv/mshv_vtl_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index fc993560a45c..3296ab5c0243 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -912,6 +912,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf=
)
>  		return VM_FAULT_NOPAGE;
>  	}
>=20
> +	if (!page)
> +		return VM_FAULT_SIGBUS;
> +
>  	get_page(page);
>  	vmf->page =3D page;
>=20
