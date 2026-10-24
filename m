Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852395;
	b=JJTadq1e9K3fFaNRJn1ba2T8RQAiwr7EgaxKm5EMS+FfWIgqVx7CAtPq9eX98A0FKgPY
	 S6r0knUBwyHmGFk7dWy1WCNAfiJn5lZ8/8umww/Da9yL/kZ7dvqrHQ62t6A1E7OxZNzVk
	 go/wGyFafKBAIwTE9R+MxG/evP/Sc8zsrfwpr3q6U32F46+I8dWgz5hwREKRJp95gdbmR
	 ywHiHThOHyhYJ6pxwCKeI0n4N62H6BB6DwW+lhy/yvdzF7dfBJ0TTYOlAmOb23oIiTbwB
	 QyBAtGD+2iRAyTBzhTKgW0RwG7htNizbwZCdvFiOSu4YiYWqxFzMcFYPseAF+CMxoRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852395;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=62C/WGQ9szz/+3dIDMXojHN4CIzM2zakryFUy7peba8=;
	b=mFvNJTNGT/GxNTy2R/yE4hLcroP2zAOiSG+5vUTFghXBorEqFnmTdFZRU1zAVJojNPP8
	 NDH5AbotHaVJkrS5AJKKghC5qNLycYzni9rD2gzosfIrZfmLsW3XfD5J3LWMK8gi4zV9+
	 tFia+XzocGBwVyVUeLq39PBBR7HxLAQvPgCSbKVi5KQxeJU8BBfMlPJe5S89nqJFT6fwz
	 4kMcdO9MTXXt43J9jLjcG/6PnYtNsZMqxWBVd5v4X2zHlY5XF2Ns8F6yhRBgOcX0AD+gs
	 F7twg6SATSJDQ5M4+vLZtI9DipX3/WQXuPPE8FbDrX17tRLS2Tm1sHhn2WK0F3V1H0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=erik.brangs@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=p2VXvdvi;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A0606A31A;
	Sat, 24 Oct 2026 14:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C95A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=erik.brangs@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=p2VXvdvi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792852380; x=1793457180; i=erik.brangs@gmx.de;
	bh=62C/WGQ9szz/+3dIDMXojHN4CIzM2zakryFUy7peba8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p2VXvdvi0wgTwfi6aiVh7pLVAkDlevA09POQCOYkdSxa68Qa+hsu7cJnTmAS+Pun
	 NSyA9Ibb9bdvCzfkccwVub2NFG9FaB4dJnS1v96hOuJ5eAkvgSCuZbaAyUQEQV226
	 eh6trHUD232scKw0zslw/xir5JE5AFcwCZy3wZBAaifJ/Vc+fj882J9LwzHRU4mGc
	 xxy8bfuROIQT4Dmt5hOPN5q73jUR6s82amORXYzZWUZF07Gz/lyoC7rXRxPhJYOwH
	 GD61lDIOPH1AESwSZu+EXIu2viL5PfFFvQ9/ag8yjku2Xg4KFr01G7srpQF1DvUK/
	 iigpBZ6h+vaRsjd2mQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1x5lmY1GgM-00IkWo; Sat, 24
 Oct 2026 16:33:00 +0200
Message-ID: <95737f03-b31b-46d4-9157-b6f81941f42b@gmx.de>
Date: Sat, 24 Oct 2026 16:32:54 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore working
 on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests firmware)
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, benh@debian.org,
 stable@vger.kernel.org, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org,
 Christoph Zwerschke <cito@online.de>
References: <179104011040.2214689.5921682013387867802@eldamar.lan>
 <2026-10-04-1-daily-reply-0007-bt540-asus-firmware@kernel.org>
 <24ce058a-28b5-4499-9ded-eec9544b80ec@leemhuis.info>
 <as0YtvgukA-Gp-D-@eldamar.lan>
 <3c931ea6-b325-4338-acdb-4f6eec9d204f@leemhuis.info>
 <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
Content-Language: en-US
From: Erik Brangs <erik.brangs@gmx.de>
In-Reply-To: <8aa88f3e-2dd7-4bfe-a0f3-e5ecbbade84f@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uJcEiteeB/8uYC363xYa22uBm7j7A8C8uXEvzu+4PnI1+IIYenA
 Z3a4AVoNt9z6FevwlGknHwuaCORgl+En0x8PLs1xzZ1fjJVo/90Mk0cKiPDIJyTIq84a+PL
 Fl070aIgCZ6Bri2ycvG6okisI8veE2PSCoCx/Wr3bDmmJ2HjPKN93yC9CVB+9KelDb2hja2
 4bIYVMVD7ZTXmCFBMrtyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+YlGUr/bu/Y=;ffI7g34cuyPxLljCeiF6szdbUUr
 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
 XZ4bkUao5uY/iWB+G66Eqg9V4csv2OHgrk

Hi,

On 23.10.26 15:43, Thorsten Leemhuis wrote:
> I did meanwhile and agree, the backports of these should be reverted
> from 6.18.y and 6.12.y:
>=20
> * 980084de4d9b25 ("Bluetooth: btusb: Add ASUS USB-BT540 for Realtek
> 8761CU") [v7.3-rc1]
> * 6f0624b4427e38 ("Bluetooth: btusb: Add ASUS USB-BT600 for Realtek
> 8761CU") [v7.3-rc1]
> * 4a23ce935f74d1 ("Bluetooth: btrtl: Add the support for RTL8761CUV")
> [v6.19-rc1]
>=20
> At least if the problem wasn't resolved meanwhile, but that wasn't the
> case afaics -- or did I miss it? Salvatore, Erik, or Christoph? Or was
> it meanwhile agree on to fix this differently, for example by including
> that file in a linux-firmware update maybe?
> Ciao, Thorsten

The problem has not been resolved yet AFAICT.

Kind regards,

Erik Brangs
