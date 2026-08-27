Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574E499F3A;
	Thu, 27 Aug 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787852458; cv=none; b=RbxSUTY+Ty+GJPNObXtKoh/+Qz8cUlGOtGJd685ladD7fqPG1RwpnLO7gkZNljg8dikedW6WJkyu1t2msv7vZRHSBc/GeKP9ZXxf9opCh6R4XTZh7IxLqxls8iUHcTW9aVvmIeLBfwGLLX/afUPGuyVDaJ8c04cxw3TQi2uC2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787852458; c=relaxed/simple;
	bh=Hg55+g+2sDxRj0S/u4Rec3c5AtKBMNduDaEDI/9xCII=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZI/LqtiKyfjyG4cnUjJzNxv0b5PgEE0w6hJJSTnAIPWw0O5UkxJP3TiYD1EAquPOz065PEgp5TmwL4OkdE5TTs++Krq0lfKVSyCeUDrkdoLi82pyIl0aLRGmCuDuz25IX6synqwc1Q5QfbH5LZQIl8n6Xie9ioo4RpDAirhDsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rtPCcZtZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rtPCcZtZ"
Received: from ehlo.thunderbird.net (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id D45DB1F8DA;
	Thu, 27 Aug 2026 19:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1787852445;
	bh=Hg55+g+2sDxRj0S/u4Rec3c5AtKBMNduDaEDI/9xCII=; h=From:To:Subject;
	b=rtPCcZtZZLMg2hlmuRelXiAc9nkNWnlk+KZ/tNxhU9gp5XfzD64NF844FzFHh+mo2
	 eSPRF3GmpK1FQcWOs3xdzcU4P/+MY+f8C3hboy4tUQUjVnk/JQnXblCyl7Iuvc+yZB
	 yilCfKzwO2OgHaz/Tnsi8xdf9V14bstx1vqWQXB05SRwytH4uELlpHWVqCMtvlL9nz
	 iP1QNwR2z8jpUOTv9M02XNAbHPbBcG8H1HrG+j7QHvwUOhmITFErOHTzbEOAbGkAS6
	 WgRiTIn6k8CEMmPpPkX9ln+JDsv8un5A5cVQqyoiFXZxvkxV228eI9qK56nzi/6xCI
	 zrwCc2KFJ1izw==
Date: Thu, 27 Aug 2026 19:40:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Georgi Valkov <gvalkov@gmail.com>, briannorris@chromium.org,
 johannes@sipsolutions.net, andrew@lunn.ch, krzk+dt@kernel.org
CC: johannes.berg@intel.com, kees@kernel.org, miriam.rachel.korenblit@intel.com,
 rongqianfeng@vivo.com, wenst@chromium.org, rafael.beims@toradex.com,
 avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de,
 gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 chunfan.chen@gmail.com, arend.vanspriel@broadcom.com,
 peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org, gvalkov@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_3/3=5D_ARM=3A_dts=3A_armada=3A_WRT32?=
 =?US-ASCII?Q?00ACM=3A_add_marvell=2Cinvalid-reg-hint-in-rom?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260827171937.28878-3-gvalkov@gmail.com>
References: <20260827171937.28878-1-gvalkov@gmail.com> <20260827171937.28878-3-gvalkov@gmail.com>
Message-ID: <15F55ACD-E206-4B79-9E8D-1ED24427BB19@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27 August 2026 19:19:37 CEST, Georgi Valkov <gvalkov@gmail=2Ecom> wrote=
:
>WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
>from the mwifiex ROM, which conflicts with the platform regulatory
>configuration on units sold outside the US market=2E For example:
>- phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
>- phy1 mwlwifi 2=2E4 GHz, hard-coded region 98 EU mapped to FR
>- phy2 mwifiex 2=2E4 and 5 GHz, hard-coded region US
>
>When the system boots, it detects a conflict between the user selected
>region and the radios, e=2Eg=2E BG FR US, and applies extreme restriction=
s,
>preventing phy0 from starting on any DFS channel=2E phy2 works=2E
>
>Add node wifi@1 with a flag marvell,invalid-reg-hint-in-rom to the
>WRT3200ACM device-tree, which signals mwifiex that its regulatory
>hint from ROM conflicts with the platform and should be ignored, so the
>platform regulatory domain can be used=2E This does not allow the user to
>change the regulatory config of any radio=2E It only allows phy0 to start
>and operate according to its certified configuration=2E All radios in
>WRT3200ACM/WRT32x are locked to the hard-coded configuration for which
>they are certified=2E
>
>On WRT3200ACM, the platform configuration is stored on the devinfo mtd3
>partition, which is read-only: cert_region=3DEU modelNumber=3DWRT3200ACM-=
EU
>
>The Linux kernel sources do not have support for WRT32x=2E An equivalent
>patch for these routers has to be sent to OpenWrt=2E
>
>[1] https://github=2Ecom/kaloz/mwlwifi/issues/173#issuecomment-307879699
>[2] https://github=2Ecom/openwrt/openwrt/issues/9956
>
>Cc: stable@vger=2Ekernel=2Eorg

This whole series is not material for stable=2E Please drop thia tag from =
all the patches=2E


