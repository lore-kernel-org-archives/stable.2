Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6C368D4C;
	Thu, 27 Aug 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853925; cv=none; b=YRlLOuWK1d3g0aIxQ+zmy6VdtVEXMWEojfagMbdenbcJ1B9bFoz3OB9Ifa1YekOXu3nuf5z5naDZ5gr5iFyHYdvF5aRETZIQCR0GMU1ChRHRlkl069I4s+lir44wvnAtFOaClY14au5KJWWuyI6NVP4PDI68H4rWvm3NSfUJpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853925; c=relaxed/simple;
	bh=39xHH2vSkwxps+NccOz6k0tJCTNnVs/T6Y2fM6jJYRs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=o2EMyI/8Qk5SnfOkqnylDYUae3YI0CeGQgoErJ+D0+1JPgFcD0Tp9pq4AeyA36C2KLeGwxhh9iAuNHu2za4N/AP4niX6PDGaXlkl5FhJrKocIA15jOlg4i4zX12dGgoaC+0f0EHGd7IEpEyPNzrYrRc+XpM4EK6TvVeM+Fonsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Fsio+jNz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Fsio+jNz"
Received: from ehlo.thunderbird.net (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id E7C211FCB8;
	Thu, 27 Aug 2026 20:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1787853920;
	bh=39xHH2vSkwxps+NccOz6k0tJCTNnVs/T6Y2fM6jJYRs=; h=From:To:Subject;
	b=Fsio+jNzaXaB/awgLvrTU3AWTs7NhEG6KhTQkrhZ+LXqh9Dg93laXFvMyWGiOxKyI
	 fjUE1tV7bmgfoPR1/009476IlemlpIF8Pc5fw4d+9dTz1cYRHi2zPmi4R1l6VNKLse
	 TMYTQoEyjRdjWjBFTk1vyV2U1BV9N6HfC3wHwnIClMs9Z6ai5vY4Sb4k5s3UTydlAP
	 96nzYP4VuYFuCDzRX3Yu9vygq7NXZ8/Zb/LwKqTMbpUWHy52yTGtqFXosEfoZWPJCe
	 CpqHeiP2j/D9/EkhL8vsPjJNglj/d5JRf83hF6i4XvD9aDzFdpOWi3dJutVdPN+lG2
	 FUBSP+1TYUO5A==
Date: Thu, 27 Aug 2026 20:05:17 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: George Valkov <gvalkov@gmail.com>
CC: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch,
 krzk+dt@kernel.org, johannes.berg@intel.com, kees@kernel.org,
 miriam.rachel.korenblit@intel.com, rongqianfeng@vivo.com, wenst@chromium.org,
 rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com,
 s.kerkmann@pengutronix.de, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@nxp.com, chunfan.chen@gmail.com, arend.vanspriel@broadcom.com,
 peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_3/3=5D_ARM=3A_dts=3A_armada=3A_WRT32?=
 =?US-ASCII?Q?00ACM=3A_add_marvell=2Cinvalid-reg-hint-in-rom?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CADOrJmae24XCgxFwtHssdoWc4rv1Q743hfgjG=kUrVPgf6urmw@mail.gmail.com>
References: <20260827171937.28878-1-gvalkov@gmail.com> <20260827171937.28878-3-gvalkov@gmail.com> <15F55ACD-E206-4B79-9E8D-1ED24427BB19@dolcini.it> <CADOrJmae24XCgxFwtHssdoWc4rv1Q743hfgjG=kUrVPgf6urmw@mail.gmail.com>
Message-ID: <A7FBAD8C-3AAD-4268-9BBC-3BDE071481E1@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27 August 2026 20:02:27 CEST, George Valkov <gvalkov@gmail=2Ecom> wrote=
:
>On Thu, 27 Aug 2026 at 20:40, Francesco Dolcini <francesco@dolcini=2Eit> =
wrote:
>>
>>
>>
>> On 27 August 2026 19:19:37 CEST, Georgi Valkov <gvalkov@gmail=2Ecom> wr=
ote:
>> >WRT3200ACM and WRT32x routers always report a fixed US regulatory doma=
in
>> >from the mwifiex ROM, which conflicts with the platform regulatory
>> >configuration on units sold outside the US market=2E For example:
>> >- phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
>> >- phy1 mwlwifi 2=2E4 GHz, hard-coded region 98 EU mapped to FR
>> >- phy2 mwifiex 2=2E4 and 5 GHz, hard-coded region US
>> >
>> >When the system boots, it detects a conflict between the user selected
>> >region and the radios, e=2Eg=2E BG FR US, and applies extreme restrict=
ions,
>> >preventing phy0 from starting on any DFS channel=2E phy2 works=2E
>> >
>> >Add node wifi@1 with a flag marvell,invalid-reg-hint-in-rom to the
>> >WRT3200ACM device-tree, which signals mwifiex that its regulatory
>> >hint from ROM conflicts with the platform and should be ignored, so th=
e
>> >platform regulatory domain can be used=2E This does not allow the user=
 to
>> >change the regulatory config of any radio=2E It only allows phy0 to st=
art
>> >and operate according to its certified configuration=2E All radios in
>> >WRT3200ACM/WRT32x are locked to the hard-coded configuration for which
>> >they are certified=2E
>> >
>> >On WRT3200ACM, the platform configuration is stored on the devinfo mtd=
3
>> >partition, which is read-only: cert_region=3DEU modelNumber=3DWRT3200A=
CM-EU
>> >
>> >The Linux kernel sources do not have support for WRT32x=2E An equivale=
nt
>> >patch for these routers has to be sent to OpenWrt=2E
>> >
>> >[1] https://github=2Ecom/kaloz/mwlwifi/issues/173#issuecomment-3078796=
99
>> >[2] https://github=2Ecom/openwrt/openwrt/issues/9956
>> >
>> >Cc: stable@vger=2Ekernel=2Eorg
>>
>> This whole series is not material for stable=2E Please drop thia tag fr=
om all the patches=2E
>
>Dropped CC: stable from all patches, and sent v9:
>https://lore=2Ekernel=2Eorg/linux-wireless/20260827175850=2E89395-1-gvalk=
ov@gmail=2Ecom/T/#t

Please, you are not supposed to send a new patch series revision every tim=
e you get a single comment and you did send the previous version just 2 hou=
rs ago=2E

It does not work like that, you just create additional overhead=2E

I assume this is all documented, please look into the Documentation direct=
ory=2E


