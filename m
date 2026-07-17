Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF03AF65F;
	Fri, 17 Jul 2026 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274876; cv=none; b=U/NSPCTmE3aSYR73ysNHjKZ0q+vOzLZQMeRcLCmNi8jAYhc8cAs3d8+pFhGTD2rGSKPHt+pCWSQaMd/FU73Z8ZSMn4uYc35Qo3fUAgkJOeiyUByBEn6z8/gM9sMfgKnUQ0HBfcjKj8wGQ/cIOeACJ8DZKbLO9HJwH+JQSiLQqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274876; c=relaxed/simple;
	bh=WsP30KAFEJ+qcG/zhU2jgpPp/t1beHgxrTAyeST3kSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZsx1XHor/PJnlgePVTY6anicVtZchrlpCWyL2JF70t5/N9NVub+x8YLoLyTQXSIUGsCWryW/TGOmE280mDOuIkE05Tl5XeyBERwGh7HeOqtH5zTXt6GpYr5UXgEoxxo7LgR3+owlO3AG7pMpw9RbXiEgCOOSAczw1+C4HeF2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=nQF9XBBr; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="nQF9XBBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784274862; x=1784879662; i=smoch@web.de;
	bh=MigHTOds7D7N1IpWdhIGfmpNkDbNAMOil7JP4NziY8o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nQF9XBBrciKoTqgtiPeMp8GbC+zF+psJLIeNFPvmDc7OfJq9UbFluCSo+qtYzXXh
	 Qq5xtX2VaiWXLZZg/u1TXvGghk3xFNU64HBbJgZ6Tow3xbgcgrww4Af+iVijdbtZm
	 AFLcwTSdnvKrtJSrSGxP2m9KVZCHNQKQlFHhhOmG5TFmPYMidvCxBjEx4I3JlWqNV
	 l6+9UnRK1UhO0HM1hWzRsLH79TnZJt6i80u2whmNgGNRUct5rRcvSdu0LW+IFVcpo
	 YACdqSFeo8FsJ6o2K+ztLhNk2rjibeLOnhTRL2uw2wQrNyfydgVzLEF/x/frf9g4S
	 9qb+Jjku34tJjncHWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP3CA-1wNRBJ3b3c-00WalI; Fri, 17
 Jul 2026 09:54:21 +0200
Message-ID: <12e68e09-d123-467a-8058-2ff02ae24880@web.de>
Date: Fri, 17 Jul 2026 09:54:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for
 i.MX6Q
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
 Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260716222704.GA240248@bhelgaas>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20260716222704.GA240248@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gcQA79xf+XIhmEg2GzU17lTN4hc4sofqw9NvP3Mb79oOkV+yWmK
 wkDnUfa+QzADfkPP0JenW5lHGUgnuFr/s/fZ13BfbI47NZWBpPC3nm7fjt3ntU7IKvlUrUe
 Zs8u3qJajewKY5Z1BM+3Qke/JB7+5x0+UaAOeDwwUcOQbkdOs7x/+8fzoiOpX0whPuJIEmn
 JReFgVbJdZgNelL2qS3QQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VvT2jkzoaBE=;RscoxlYH/5jS9LelJ2xLHV/+nrL
 q35lSFKOMZxeZZKmWT20h9FbxJchiACH26mhLi6UXSo99MYN7jkjvCSZQKqeYy6gHWm20QnDY
 LNHvYdugLJhpZMjo17DtPjef7Q4hG+GLeREL8OtBAN2oACWR+fA7NG2u714dUyqLWjAdGFeJI
 olxNfNgbbL0o1bGmbR4b5TPE2RmJ4cESfJTgjXVAEYbx0Rz85O+ZKO6tFv4LXq2SPk3ZGLoCx
 wEBrTDHJwM+EgeYXDGP8firncwV+WFcjD46mJz230kBpc8qaXVqZiOvjCXj7IySUT4UwmAZGF
 YRFdMAwu90GWweP0w2+9GAi2CpB5sSCucnwhqYrma/NI24GeLF1lh8QOXFu60XhDzCFgEgMX/
 rE3Dom2OYATJpaL011MT4ebDuVp6V9+zj6AIl5TD6bR7aVb8Sayaa5Rrfbz6ji1muUHA8su3X
 YnD8DuC4uf0POpt3Luk4QGcSm2YF7fAhvyq1LysB6epDDVySiLIJCRR6+jtALFMTdYV7TNDP6
 QoZcdFZm26wSZeG11U/wQEW/sSg225mz3ZtabhK9HvD/8LLkj9f3EA07HvwViqu0N9oZIqFmh
 AjmxeN7fqKZ0qdtzb8/JvnVS2aaxVgLPeK1xS6xyL2LRHSEUeyOs9x3IOhzibGo74zSwZnTfa
 IDNCrorFoojm4wUEqm+r5SA+reNqKa2aLT61tXaK9xAB7EniV6LF1bIYLdesg9x1tQyPFU3kI
 BAZiMURXySw2Cf907CzaMXLBmxp9KU9rK/a0HzzfzVtlERSQz+Z3sui3GVD9kLu7Gg7ycx6F4
 nkvAktzTAejYn7E3X4nG4V4SMBCOc00JRz4rJ+SRFgPMC3GKhFirp+Ej3Kbjxdpk6ywCfstpv
 bDPqZpJ4FmMnzvuUfAjxlsVOYZRDPLBsOZzKpT7TO7k7a+3Pem6qn2Fy9IKcXlxzVlC8jCKnF
 nCGQ5YCuYGXFx6HdiEJFT/Zpiv9yPwGnu/KKxTiusJiT2OBQk8Ju0SnIuRgymFbMzXxxuxtJY
 tAE1KUdPqKpkekoUT999SHfMhkovD0Q9Js9ATAizA4U09sRr5er96Fsu4bYQO7qfao4E5WfHX
 tSxB3TJ92ql4NkAiEuvNigwOTSrpmNfWPVjsZ3cV1C3jLtgOXfITpuWvlsid3lqKtEeCTF5Tg
 QO/oVzMVfvEL6slrZNJ8rcYxukc2JnVBrdNFAOvhfSek+Ti/4JJjKnNTo5YRRWABJ0Zz3/A89
 0AORovah1tG6JhY90lMpAobLUe+cDC+CqwnUM2Ub7aBTTnPMWeFSJZT4yPNH7iZXLY5tzGDPF
 DKD1AIsHvqBKhy872kIJs+hpLJQho/X7qHTcfgTz2GMpdJ2oXjSChYhKFrla7GL0IKQVHdHRB
 HGJ8iJlZM9Ahh+SoMbSK8LjeMDBuBeGwjvguRSibtk3boUNahuowlBFpqG2iYVAkU8cMYzuNz
 my9QwlM0hWlUzU53rRWa4vJXpPLZIXITCHgwc+1W0d2ejC2TyvP6yb7lt295IVL2Kb4zT8MkU
 P0sRlnOrVdGxaKUTZauy2Dd4A1AvxykIXQB6Tb1EPPYldr8qBrzSg2rR2ktBq3CNZe7NHQp9p
 s6pD9NgM59x4YaEbEE/2FGZ6dT8iqNtQ52qG0mCreZ0Tfhs+Yof/E8pu6QLfx/0OrpEDFmzhh
 9PN9zB+LaWRVyqZ6zFX8NjTzryhAFHWHO6gR92qwKnKZPMh/ZDOIKwIywy57NvGBkY1Vw9Ffx
 yXdC3OK1Vw6HQW6DOqI+eI0CWtcVrULVRtQjU4nfl3KwRRXbsaLM9eHl9H/Pzq+yKjy76AhuR
 NosEFEydBl2Vv3rCu1gh/LEODeyaqmkaSQw8tbvZB3rMoWtn01v8U8iWhAxumk76jF79YoYeS
 ObTovwU3e56GT4yF+usf6VoVFX9jBwdC3Ui6R70WxxuquZJTszTnkMMPNnQ9FyUbwQ0gUNS73
 cZOlqTB2apS0GCYQYLGuGJi4fg/MfKEtsK9VU2EquSdgs+5iw7bRrJvB3sdIgY/v47osl/lrk
 xaqwFVVWcfk8Vsmti3CT9wEheH3lNAjBygMjYgBr6PIFiK/2vf8qKqf/7YobYoRweokv/mJu0
 j31HsidJSxGCeJcHMd97/4zQ3ZtvKI/cXqJG0fIbKBl/96Ch0eSCejzENfvO8f//1dx+S9l/s
 cdl3Iem3VTz6YhIL9Kr9sNb5BfkMPeQeMtzQ20TRxN/0NpDM511j4IW9zbIxvkRdMX7WYPvtZ
 ay4axYPuBk4ZKrqxV6ToOB/8cgj3rKKMgt8c+lkVK2HVIHRTDENvN+r3SXFVUDBlucpc91IYM
 kMaaZFb7ukpYGeDk6U5alRqX4Bc35o3ti4jcZ0yHFai5W6Eb+PyIoeqqUTe83BdaLNhea5xYG
 2uvnBoiG+iqliQUf3Vex6AurDahair8+4mhkXTyHM5UimoLdHXdRj4UaGKH/KFInrgtVPIJlI
 O0iEDKTDuuWspdX3XjFFZaS3jH+lW0+SfhJi8Qvx8dkfYQ11l8G/jZCPnClDTZKgwFF5IPoX7
 F8QLMP3uU/VVKuNRtvetX/klKSkQVX1P7jJbm7X47yTOHhsc4cu3AdUUqIDX8KBxH4AYa4bzj
 CmQlBUaXh0JXvRbvFRZBRy/ICQ9ohQaUHFtbbARBXydODGbrZh/TSfIkSQqAXGDxjTkJe/LIG
 NctDBU9EYin2Dr6jJlsSPPfAbUeWCN900ewT3JhuvdTkqZRX1YStPs73vddXhpE1SLGuwRiQC
 R+yyfAd9nUPZ3xPuLnmczS6EV2Jbo4OE8Cw4h/sE2ofQTXr9rLlkCSbevo/FIDa2ASG4SNJFC
 hfXELieGCaD5Ly0HMzH3QZV+Xog8ZV3X/JBCTeNpiS2JTOwp8gSFzYDdoj81xEYicHApS1LPw
 KvdLFs1WrdWWDc6EZ5WNN4s2jwCIeQH9TQmJzdVqLUYCdEyJHJLNMlS08PGtcP5IGfA9c1Fhg
 gUngRTSA/W8qMScMvy014tP5oyijqLUIJKEsoJa/n5RO4q6MtiaeylcM3bZQz/3kImT1kQaPR
 Ozm0mxtt2xWtjC1vC+GAyvrBEqG+mYogRJaDgxcRJvAfr6DpabFmNSmPvIIvKG24ZoZhfa0S1
 2R3L67QX+Z/Qt3U6R9a+70jupW7vhbUbeMg5OSVT153ZsS/1/BascN39ikPPwoouQsKeg/wY0
 t1IIfYNk2LkZxTrmmScqHN6gVD1GQeUj2z+Ak74ujOJct/bQ6qlT5+pDwpsy1fJASYynCjeuZ
 irVAHFdF/NlDVBIrU/rYvXJYGxtgAnjY5hgDglvTfU8Yn5faMiF/o+x6fvwmtPUd/tClatiIx
 mC93u7btFCM5NkUMMHf5QsFRVtiblANKPf0Jcqp6Qeht9hIznWW6bfjPGuLChlq8cxyU7kiF4
 zqfWQu/tAZ6EneKhn7EmL546iz01FrRF2ZKQ+w3sdLWGUtRITj6t+JbvYWiOBGVzjt4poxhZ+
 k4jlSphJ7OAHUzbVgeLmTWskPdCTd1GFS5A4JlyI/edNldpy/BZDt4jcfRT64e0XTIN3IZPEs
 0Ke7q66U/SyrVHxobKzTlCHdewsJz5g7MVYvAo+tKvZ+yHFeb5uCz6QXzqoDhamPx8ZvY5ocB
 kIGKIy5s1hlJmiVWC3oIOhALlRoN0y2h3YL7Z8VPv/H9PUOVXUt70apqwlWSrNjzYo3eAFka5
 O/R9YJkuInZzQeOJEvW+FebTMR0ZoQBQVxu9plC8yWnzK4amsLFvlimk0y5z0KngqUqU+GcOB
 Jlt5Psy3MuEU5fheDagV2KrvT4Y3Zl7Li3yCuwuX+gn/RnOovmSvBsXjAPZ+fcmszpgYPYyaZ
 /+oE3TRjxpUlCpHMfPeoi8vMGMNsJC+CPPjh+EYmZpNOI+X8qcz+GHvSnsfR59D+mMNb7VU8U
 eXcssJIrOP6062o8u6oF8i605lrKgP1gyw1isrwXhOdQjiU5exyR01LHwEngqx16WMzSLwYsJ
 6YDHt0MI0h6Hmdk4I59UJSMndLgaK8P8pfnBO7jWtQFKFDJ8NCipyGSO4NoZtnh8QF8YRWBwv
 uSad9WFrV8LVAabdumfyi8b7P0gK2XhJvm5d2BSgf+06l1D27IHJVeBXisZ1+MKzPcgqdGyxd
 kptr06EkATo3zpw3IEiOFpW31eUyKxTaQkMY7ySL0CqyttvsVHrHrhtVNWhtGQDvxmjvyu8EU
 Jmw2teJTTC4PS75HzBTnj5c7hkPMRDzNnhoRMg/Wgb6LdlqALFXqK1i6bny01HAxuPEw/zU8W
 lA4aZuQLxVAeaFXa/VOa1JE5tF+/BCB6Zict2VDTRmtW0aOyJWD1fFCTulm1ijgMHk5D7Qynh
 DH/oXc2WUqVKxR50RuS6DEmjR24W8vQyuAkErxZ+chONY0yOFWHfQMOOkQAE9xouwLKtqT0nF
 jcCLRZCBrW8huTvaPpVYP2JfEnYo13EFz2y/IOeArZEaWzr9Yy1EVmTOHh0+MAjZIyOaHcNCo
 gpJDy4WcaaXvNKrxULtqZJrbu8HMpL7h2PdDfRJU7koZVXJjLVk0EHHxHh+Cvug7foymIr4y3
 FKPATGd6Swew61ZZsTjpSzzk8XUmBAbUPmMpkRzit7SHjdbuVCSVPEbEvI5S5QnezPH9GhiWj
 DiaRQfxFoneH9bj0PHf/oiskItqXmBxs7KCyaANg3yUL6Eq9tje2cCwErWfyEmqT+AOlVW6yn
 gNLVWmXDYETYS/BHC7RjVRGmwkfuX5K+9JNUZjtnF31hKvd1OuWXpcyV4KuqAsMW+huXe3Lwc
 IGAqEL5vScMUXixjUdTYdXpRR5YtDzCMRpwKsjzW2gZR36TYmCl+TFeyEMgV6Yv6LNbDwYEm2
 wEUPzEgBoRjDSCGSSwX2HTx/GNiXBzABwqBZJD8Coby51UwQ8uySBDU4jmbzufI9FZ8T1Pw4e
 1xp2D/gwHyVZSXEzKV0n8qmBNb1TQ6EnqyFpZU3Wfe0+pWR77FnxURX/X5hh0CpWAwuMdftmT
 irf+J6gzv8czeh/7oPf0nTW2yYkqgWTC/LmUDZxJGAQ+IciPiN4UBO2siAlbuozVePo2+RX3b
 Y0dj1bAx9ktqiQfwBL+cwUk99h7SnArw+qm062xvE040l60JMw7XDJIwIS8E7rvCaVwl2p3bq
 GYN/RD45XSnjNQG94Fj1MJPuzILMDE5j+k/rhd5s8TrA/xFNQJaSxYPAJNPTQm58cMtTGcm02
 lYM0I3XLPhkF/KTvdfF50L4nqzU+Z9fQvdTP4wiPOzp0jsUXHnUvwkq7lVu3zx41Qz14R8now
 EL4Khd/4hv8bCkeDnW6J+na6MlRbPIl12Z8IXMaycDV3BW20XWtAmvxmt0X6Or+9l951SDFTe
 0ROy50eaE17RotZNhyPe0LmzyqiVU1TiC3EIHjdAc/0lCyarLH9xTKtFTQrNVomnKZ1a794iq
 OAr/klqSZKEIOlj1e3Rlf5Nrj5DMyauWiMQElqjtbScpqEsiW0UWFvRb1sU0+IrFV1c6ZVFO4
 j9nKTjwNUbsSCLTHejrLDwymmtL/bWinNXwZ9NQscSrc98VxafA5O72gNs7pdH0Vl4UgHNskL
 E3KlEAB1Yu602nR3LasLrpJijlMZg/piu2YXAD8w7WSGDONYXeIh8sC29ayDzt6GXXNuslQMB
 9G6d5yiLtdA7aEKSrEan5jfdGVFf6BKzvScxFbTOThKw5ERAspArCtZkTx/bet+qOD4OrqXeT
 63XmoSBs07R+J+lidHS8ZjWv9F1KbNk+GqTMJvcEcKfdmxXkwXHD/EuVsCN6pZ5OeiSw1nSd/
 bFAuHmPygba8AgcLwXWY0IJcLBk2Z1C8fVtNnJNP+mjsWeRUC1gdbCEA8+leoMpZ/8Dt7PIAm
 DaXDNfXFIsJU



On 17.07.26 00:27, Bjorn Helgaas wrote:
> On Thu, Jul 16, 2026 at 11:40:54PM +0200, Soeren Moch wrote:
>> On the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
>> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>>
>> Even though the Root Port MSIs won't be received by the iMSI-RX control=
ler
>> due to design, this chipset has some weird hardware bug that prevents
>> the endpoint MSIs from reaching when the Root Port MSI capability is
>> disabled.
>>
>> Hence, always keep the Root Port MSI capability for this chipset.
>>
>> Note that by keeping Root Port MSI capability, Root Port MSIs such as A=
ER,
>> PME and others won't be received by default. So users need to use
>> workarounds such as passing 'pcie_pme=3Dnomsi' cmdline param.
> I'd like to align the subject a little more with 3a4e8302e72f and
> avoid repeating the ".. from reaching when the Root Port MSI ..." part
> of the commit log, which seems to be missing a word.  So I propose the
> following (if you think it's accurate):
Your proposed new patch subject and commit message is totally fine for me.

Thanks,
Soeren
>
>    PCI: imx6: Keep i.MX6Q Root Port MSI capability with iMSI-RX to work =
around hardware bug
>
>    On some NXP chipsets, disabling Root Port MSI/MSI-X Capabilities bloc=
ks
>    MSIs originating from Endpoints from reaching the iMSI-RX controller.
>
>    To address this hardware bug, 3a4e8302e72f ("PCI: imx6: Keep Root Por=
t MSI
>    capability with iMSI-RX to work around hardware bug") preserves Root =
Port
>    MSI and MSI-X Capabilities on i.MX7D, i.MX8MM, and i.MX8MQ when iMSI-=
RX is
>    in use.
>
>    The same applies to i.MX6Q, so preserve Root Port MSI/MSI-X Capabilit=
ies
>    there as well.
>
>    Note that preserving these Capabilities means Root Port-originated MS=
Is
>    such as AER and PME won't be received due to separate hardware limita=
tions.
>    Users may need to use workarounds such as passing the 'pcie_pme=3Dnom=
si'
>    command-line parameter.
>
> Also, we need to resolve the Sashiko question about whether IMX6QP and
> IMX6SX also need this.  NXP folks, can you verify?
>
>> Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Po=
rt if iMSI-RX is used as MSI controller")
>> Cc: <stable@vger.kernel.org> # 7.0+
>> Signed-off-by: Soeren Moch <smoch@web.de>
>> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> ---
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Frank Li <Frank.Li@nxp.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: imx@lists.linux.dev
>> Cc: linux-kernel@vger.kernel.org
>>
>> This patch is similar to
>> 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to=
 work around hardware bug")
>>
>> Tested on a tbs2910 board [1]
>> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
>>
>> changes in v2:
>> - collect a-b and r-b tags
>> - use correct fixes tag (Manivannan)
>>    (reference commit that introduced the bug, not the incomplete fix)
>>
>> Since this is a fix for a regression in linux-7.0+, can this still be m=
erged for 7.2-rcS ?
>> ---
>>   drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
>> index 98e1db751132..8130cf93c2bb 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] =
=3D {
>>   		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>>   			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>>   			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
>> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>>   		.dbi_length =3D 0x200,
>>   		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>>   		.ltssm_off =3D IOMUXC_GPR12,
>> --=20
>> 2.43.0
>>

