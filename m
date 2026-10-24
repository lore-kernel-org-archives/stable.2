Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872682;
	b=uf6tTOJnaA8nE6i0rtbYh/FBw0ZBA+DxFocBKH5jCHj651wJ/849ke0DFE9ThHEh/HpP
	 p/zSRL2H1L20SqVqs+IojZyjtX/XmGXlg8h5kxIGwcNJ/EmhNKcbR7kr0mmIc12UEJv0d
	 pId05HLcDhHaJ+te4KVZyHDBncmqaSbQdYJIMK272jPi27yre3zP81drlvbEpHN3euyxA
	 QTMKpRnofFCViUefZpXNLs+g9mNiYHmKG52P6FViwR6Mygk2ZRp8owGAHj04HX/r0wIbh
	 mPmfIorAPG+tlXytFJccFEikrWF+EhrPq9mTwZPNGGPPJodzzJHegolG4a9TWAZ/Ygg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G9MfVIB8/VTUeUSkD44jq6x96PQBUH2oB2UzhxvbDoY=;
	b=p6XwGtcxIP1W/PAbu0asYcRSE9u2/Mvl5fZ570UhSjkwzP4jsiF0v4rQPunGqKM2VA93
	 4Vorsha8h5Nd3ZMRBpftZeEjcB+zrqhU5mdj9oR4mezIGkws/Dgy6av310CfMPLxo6/1T
	 yDLRcFIguygbDyNftDYSDS7f8o6WA9/J4OryoqLAfR3MErvnkYXgLKv9KTeT+rCx4hqLw
	 zMJ/kkPu6bHY3gZBuDt/lEouE7faYeaQb2JgDM4d0ZGTibjhtb/dsSs942xqfE8QHm2Ni
	 onLNCz7RPSZSSZiFsWf2JgwM9A4gP3Xc2j2K49AcN6CD9izjot20wnTgDjZXXRV+u1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icQyYuEf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F854606A31A;
	Sat, 24 Oct 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icQyYuEf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54471F01825;
	Sat, 24 Oct 2026 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872682;
	bh=G9MfVIB8/VTUeUSkD44jq6x96PQBUH2oB2UzhxvbDoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=icQyYuEf64fZ8ihChm5jkFz7qxkBTkn1RSskpXZRMK/foETRgscRAOA1TGz19LaCy
	 mId2S5NhYlPv1rPx/U+eHy2dySyIBy+GQeNEjaympMxjDttIz2bwAoHDrm4qnHo00W
	 reMrrtHgQ83fF07CoN4PPUmfqboAZohANCpFzZz1Zc4HqdK0Z6dg3FeA9ZgNL6uhy+
	 tGRjFY87kV0TIg+HOpJW9tOa1VSXAWphbKB3WQpFHCrNmRHkwODDGL2L1KEiuyMj43
	 PhthBuy9AHOCpRB438OQ3AHSHZlVr7XjBjaM4KlBQsUYdmrx6A5Dtmb/3RPsYcvg98
	 OYfcCmrokVS0g==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Erik Brangs <erik.brangs@gmx.de>,
	benh@debian.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	1149377@bugs.debian.org,
	Christoph Zwerschke <cito@online.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
Date: Sat, 24 Oct 2026 16:10:59 -0400
Message-ID: <2026-10-24-1-daily-reply-0001-bluetooth-asus-rtl8761cu-firmware@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
References: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I did meanwhile and agree, the backports of these should be reverted
> from 6.18.y and 6.12.y:
>
> * 980084de4d9b25 ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
> 8761CU") [v7.3-rc1]
> * 6f0624b4427e38 ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
> 8761CU") [v7.3-rc1]
> * 4a23ce935f74d1 ("Bluetooth: btrtl: Add the support for RTL8761CUV")
> [v6.19-rc1]

The stable trees match mainline here, so nothing is going into stable for
this. The fix has to come from the Bluetooth maintainers or Christoph: an
upstream revert of the ID commits, or a fallback to the ROM firmware when
rtl8761cu_fw.bin is missing. Stable will take either one for 7.2, 6.18 and
6.12 through the normal Cc: stable route once it is in mainline.

The other way out is on the distro side. rtl_bt/rtl8761cu_fw.bin has been in
linux-firmware since 20251111, so a newer firmware-realtek package fixes this
without any kernel change.

-- 
Thanks,
Sasha
