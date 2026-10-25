Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792931719;
	b=qVHbUQRI4Glnd1PoIVeo53yoUw+H3PCSWxkINtFGKQhZgLI2581eL+jBNcKC5dsNV1dz
	 S8ZQKFxfCDUwvSk3+roqeXSnGDTMYIsWSVfbOSGtT0TBI6TOeFD4eTJzdDyNfsuQIpSv9
	 7SaaHTmIxdmQeqx/G0eFtNKux4D4oD0M+K+EObt7swINXvVZQ75iVkDiJg+quTyFOfILZ
	 o5A/pUZz1gZLD7Wwcm8Dj63intyMuw3ZGUBBH8WtfvTZ7jSHGe83cPH10jFgzVToovmd3
	 UzUhau6QJpDKQyUNMoDbYyrNTCs8MHXe5hLEDfUAtjgRBxpnTEv7YfsyUc0eAf8Ns4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792931719;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-META:X-MBO-RS-ID;
	bh=oBuC068MUwpWG5fByXD4atUYxCsnN+0yKtSP2Vaiqro=;
	b=shnJ7fvaJbb/9BSAB7I6l6KD5uWhMti6Yz8nind2wwZwjJT7XdfHwEB7xzVEShQtgrE4
	 NNLXuz9ujLv1vLMyIPooP7C0B89TQ6czbRTp5jO/OepsAtwB3ZRItcKdZIcpzl3ETOIUD
	 spICg2ekrcyxfvgKsCOeInvGGWEMvjOsZjNktgYXkKGW0nMMmKoLRdEUAgXH/he7mLG8h
	 /mN3TjMxG9pRPnO4GPMkUNnSDjOr0gKMZ9sF1FjQSOPzZ5CcNFmJnFh09va0S9vn6gMsp
	 09qjje3UcMkn1/OMRoKmQQgb5zrVW9wFKQqGwuABUn3j/yKedeY+iw7znpvJSFqWk8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4B606A31B;
	Sun, 25 Oct 2026 12:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC4B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jCGRq3HQbzKn84;
	Sun, 25 Oct 2026 13:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792931703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBuC068MUwpWG5fByXD4atUYxCsnN+0yKtSP2Vaiqro=;
	b=XjSvr+4SWWPY9WhYWldhLZeCf5v9+7+QYJ9TEsThQdibTYZh7F8KVlID1eRl5rdVVXK+kq
	7sEkdUVP4bNzx6VIJkmKaIQ/DC2608LP9MNf0yRMyiVhXtJMHuAx8rZsEJesl1bgVCQcTL
	i0yE6Ej2/eaBVVOqjzQiBmbJqd2eemoTW9TIwnv8qHqXMwNzuwEspAVZoHf5Y+fsSkvtRD
	0KyiOyoSL6NCQ9+FQI8jFrd74aX9RXIeJx3xJmE6lV4Xt462OEYW5MkeRKyH6ISKTvOfV3
	FpMGzMAIBWLjwdeQBc3YvxFe7+U3dgA8LQYDDYIr630D/9FF7lR0YBVA93MocA==
Date: Sun, 25 Oct 2026 13:35:00 +0100
From: Benjamin Boortz <bennib@mailbox.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.2 000/243] 7.2.13-rc2 review
Message-ID: <at3xpGSor_VQBC9Q@bb-82jq>
References: <20261024064731.125251200@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261024064731.125251200@linuxfoundation.org>
X-MBO-RS-META: bh4cjay8u7dkqhxo7fp3anfkur1w3orr
X-MBO-RS-ID: 0f742de3b2c5a8e70cf

On Sat, Oct 24, 2026 at 08:59:39AM +0200, Greg Kroah-Hartman wrote:

>This is the start of the stable review cycle for the 7.2.13 release.
>There are 243 patches in this series, all will be posted as a response
>to this one.  If anyone has any issues with these being applied, please
>let me know.

QEMU tests pass: Build and boot tested for x86_64, i386, arm64, and riscv
across multiple configurations.
But on Lenovo IdeaPad, AMD Ryzen 7 5800H, it breaks firmware loading.


7.2.13-rc2 stable-rc (broken):
   Linux bb-82jq 7.2.13-rc2-localconfig+ #37 SMP PREEMPT_DYNAMIC 2026-10-25T10:58:13Z x86_64 GNU/Linux
   [    4.115429] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
   [    4.247951] nvidia 0000:01:00.0: Direct firmware load for nvidia/610.57.04/gsp_ga10x.bin failed with error -2
   [    4.293594] mt7921e 0000:04:00.0: Direct firmware load for mediatek/WIFI_RAM_CODE_MT7961_1.bin failed with error -2
   [    5.270053] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin failed with error -2
   [    5.270059] Bluetooth: hci0: Failed to set up firmware (-2)
   [    5.285865] mt7921e 0000:04:00.0: hardware init failed
   [    6.777226] r8169 0000:03:00.0: Unable to load firmware rtl_nic/rtl8168h-2.fw (-2)

   dmesg: https://benni.tech/pub/2026-10-25-354214524bc50442-linux_7.2.13-rc2_dmesg.out

7.2.12 stable (working):
   Linux bb-82jq 7.2.12-localconfig #15 SMP PREEMPT_DYNAMIC 2026-10-25T11:34:55Z x86_64 GNU/Linux
   [    4.187538] r8169 0000:03:00.0 eth0: RTL8168h/8111h, 90:2e:16:f4:c1:ac, XID 541, IRQ 99
   [    4.317243] mt7921e 0000:04:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260224110909a
   [    4.329703] mt7921e 0000:04:00.0: WM Firmware Version: ____010000, Build Time: 20260224110949
   [    5.209980] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224111243
   [    5.363124] Bluetooth: hci0: Device setup in 152450 usecs

   dmesg: https://benni.tech/pub/2026-10-25-741af2903c635793-linux_7.2.12-stable_dmesg.out


The firmware files on my system exist:
-rw-r--r-- 1 root root   382295 14. Aug 17:40 /lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.zst
-rw-r--r-- 1 root root    48310 14. Aug 17:40 /lib/firmware/mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin.zst
-rw-r--r-- 1 root root   359887 14. Aug 17:40 /lib/firmware/mediatek/WIFI_RAM_CODE_MT7961_1.bin.zst
-rw-r--r-- 1 root root 84310168  3. Aug 19:30 /lib/firmware/nvidia/610.57.04/gsp_ga10x.bin
-rw-r--r-- 1 root root     6380 31. Mai 10:41 /lib/firmware/regulatory.db
-rw-r--r-- 1 root root      762 14. Aug 17:40 /lib/firmware/rtl_nic/rtl8168h-2.fw.zst

Regards,
Benjamin Boortz <bennib@mailbox.org>

