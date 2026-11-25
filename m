Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627701;
	b=OSYYXFNVVlRaTc9/POloureda+v0mKbcjwsQJR3L3LY5n2J6eqOo4ojm2p/kN8cHGBIz
	 ZSi7aIFX+Vn9JgcBH4MggCjYjsQXUp/ROBhLH85ikIoGOYrrHC23heFuZwzBZqOH/wcgf
	 EQFYst3XezaqY39AqFM4Sv2eIRzPo04A90MU9kNajbyT0u3jORGH7ULglyc3eY5AgG7R7
	 OjovE8HDX3tZX9ob8nsZIWicmbZ5Xl76V6qdcWKDlbZYG6urW/G+SY5Po8dFJYVL+evEz
	 G8HEPUf/IwlclTqzYvtGeQzOkbsMJOIWmIb7l3gkOpJWYbWc5ILUSAZ0XSZ1zsExekw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627701;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=8h+5RP3U69j/2zVa78nMDxtSxC8teTp19AawwGi4kIQ=;
	b=py7DQZJ5klwfOZnbHVBBZTyyTyBy1nREEdYsf9vSPtrFFZZubASPbD/F6RuELYlSFYRT
	 kOpDQ1dkyY9x5IE8pod4Y4FppAK7I1SRVQK559CXH6hkIpIf1sdUMBzf8a6BmWSUlH2U3
	 +uxTdSnPiN/8G7Jlj+gMBIFQLR1e9L9GGKezXCG1TG9z0wQQUNrVsAqkSFhKR66DLAuWk
	 /jfzlaGJ4YugRjM3odQnmGX/WzB/p1bIhZHGuatz81/lD30NfKUKyOwofzIsnvoI0ZrGe
	 LEwblsqnI3YL2NOd9lJNhN70IDjfOiy2t+jWaY+ptSAeCOEfaY5Pl3Fmci1pa9wX05A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=7pkihfhpavb6lakjq6iwx2lajy.protonmail2 header.b=sf1UmTjD;
	arc=none smtp.remote-ip=79.135.106.30
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65B606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D65B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=7pkihfhpavb6lakjq6iwx2lajy.protonmail2 header.b=sf1UmTjD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7pkihfhpavb6lakjq6iwx2lajy.protonmail2; t=1795627696;
	x=1795886896; bh=8h+5RP3U69j/2zVa78nMDxtSxC8teTp19AawwGi4kIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sf1UmTjDLv4YsCNMdfqb07AcxEvjQqTnf78UV9m6esbU+KPDbYMpmQ2w8PPS7qQiR
	 +HkInoSZ0cpDAaE93ACbTVMoHmYTP8PqjeTugss7kLN8+kZSh8IlmlQ3eS3AjL1xmB
	 PpkGDCexGQDBx91Ky8OfOrvAcLzYJ4Ro70E9dGRjWRSXMyRdHzBLinUxybkbV/Liq/
	 idR83VE8yUhI76cRQfVBTcJlmI+vn0ctXeCkrKpJSRH/KxrbJX0YM/1O3/U37eoVzy
	 /lGuwP4lpozc8k3//nMeny7Rcl4zEt6ORR5lRo2N2H2EDS4QyxEIINU72Hl97FsVRp
	 27IvN+7GA1rYg==
Date: Wed, 25 Nov 2026 17:28:10 +0000
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
From: Norman Herms <dockseed@proton.me>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: use the of_xlate() result when hogging lines
Message-ID: <BdH-hgvZ3U7zGjPx0kKM-7SsjsgE-wN0wU4lbJykbkgUKvCLypS_PZUJBgCenst9JO7_MNMjyE6bqMmWzIsXfZIVPeoO8BQktyyEsCt1HCY=@proton.me>
In-Reply-To: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
References: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
Feedback-ID: 144388465:user:proton
X-Pm-Message-ID: 96744d9a3f8539d847b1326d39c57efcaaee3a47
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

thanks for the quick fix.

Tested on a Radxa Cubie A7S (Allwinner A733) with v7.3.6 plus our
out-of-tree A733 support patches (none of them touches gpiolib or the
sunxi of_xlate()), with this patch backported (context adjusted, the
+/- lines unchanged). Test DT: a hog on the r_pio with
gpios =3D <1 4 0> (PM4, input).

With the patch the hog is on line 36 (PM4) in /sys/kernel/debug/gpio
and PM4's function field reads 0 (input). Without it, same tree and
config otherwise, the hog is on line 1 (PL1) and PM4 stays at its
reset value 0xf. In both cases PL1 ends up with the R_I2C0 controller
and the PMIC on that bus probes.

Tested-by: Norman Herms <dockseed@proton.me>

The kernels were built and the measurements taken by an AI agent
(Claude) on my board.
