Received: from mail.darthm.de (darthm.de [178.208.186.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2344483A8
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.208.186.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772990; cv=none; b=OksJ6fymtKBoqkcggWRFLAXwoh0PaNA0Vi0FTwkMv3Yd+vsCcmrPhlpDKQTNetR3fRMODfFoUow77CV5Tkb/Ia1Uk0Czl5KT6egR6nq90TALjzLtUXj94kDb+NX5iRCZqasnEMZJuNH9v22/9zINIMSlCnAiHLSLAodosfMBsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772990; c=relaxed/simple;
	bh=HEKfZWjfc/r/rC2E/6E/6nLcnnZlG59QVNsoFtiPTTM=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=umTRiHv9u+3zzf3drLTQe34x2Vw75NIGHkx4u5OHIfeV2gsjtYRmeaBJx2m/MGfAhC39jcq/81vilvJ5GOWPrGdS6T1S5rzCN5xMpEzicXGWTnhIVqHUJ0ucag6bdMKlRT0Ev+od1irweiX8cnd6j1T19YVTgkDjhknEYl0dbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=darthm.de; spf=pass smtp.mailfrom=darthm.de; dkim=pass (2048-bit key) header.d=darthm.de header.i=@darthm.de header.b=V8AixOaG; arc=none smtp.client-ip=178.208.186.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=darthm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darthm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darthm.de header.i=@darthm.de header.b="V8AixOaG"
Received: from www.darthm.de (p508a63bf.dip0.t-ipconnect.de [80.138.99.191])
	by mail.darthm.de (Postfix) with ESMTPSA id BD969320002
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 11:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=darthm.de; s=mail;
	t=1788772481; bh=HEKfZWjfc/r/rC2E/6E/6nLcnnZlG59QVNsoFtiPTTM=;
	h=From:To:Date:Subject;
	b=V8AixOaGccLzOmzJ9enPjmJMcakigLk2N7Rtwjh1rf8fvBirvKGmbSTI/i+1Kw5yX
	 EA/Yi/cVNIEC3NdE+5A4ahjAv/489M4/Lcg3aZKtuMe7QJCXlLsNzRw69dLdApJW3Y
	 bWwlSma+JnYkp5UOPiRj1H300d8zpcOssySfM544toLFKDa54DBn8fCmsjlsXnHFgo
	 FshbpgXzfuVv4N3sNiHaYDDkrm3Lo1hTmD/dIQZ83dEqbB78dc+eaKh8wouvWCZ4Q4
	 zBAMYRSNUXD+7D+soRkU/BY9gtQn+h3ETqUwsPleQAzz+M5Zo7p5rsX/7dOpOxRQnR
	 EXupZ3JMKMLqw==
Received: from www.darthm.de (www.darthm.de [127.0.0.1])
	by www.darthm.de (Postfix) with ESMTP id 0CD0C190672
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 11:14:41 +0200 (CEST)
From: "Matthias" <darthm.linuxkernel@darthm.de>
To: stable@vger.kernel.org
User-Agent: SOGoMail 5.12.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Sep 2026 11:14:40 +0200
Subject: Bug - Kernel =?utf-8?q?6=2E6=2E(148+)?= - PINCTRL - Missing DEP/Selection 
 (GPIOLIB) - Build Fail
Message-ID: <feaca654-9ec1-a606-6ac0-4170d2b97c37@darthm.de>
X-Forward: 192.168.5.11
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I already opened a bug report ( https://bugzilla.kernel.org/show=5Fbug.=
cgi?id=3D221960 ), but was told there to send a mail.

I found a bug while updating kernel 6.6.144 to 6.6.155 with a custom co=
nfig were PINCTRL
was automatically selected by X86=5FINTEL=5FLPSS (don't know why it was=
 seletected in my config).
But the kernel couldn't build because PINCTRL depends on GPIOLIB but is=
 not automatically selected by PINCTRL.

I found through the mail search this one: https://lore.kernel.org/all/D=
KXAKNXPFUD7.12UEBJYNWJU49@smile.fr/
which also mentions this bug.
It seems this upstream commit: https://git.kernel.org/pub/scm/linux/ker=
nel/git/stable/linux.git/commit/?id=3D45d2055b0067739253883dc541f37c86a=
ad45c92
is the reason for this bug.
This commit was merged in 6.6.148.=20

I think the important part from the first mail is that part:
>     Include <linux/gpio/driver.h> directly so struct gpio=5Fchip is a=
lways a complete
>     type, matching how mainline core.c has included it since commit e=
c963d04ca865
>     ("pinctrl: provide new GPIO-to-pinctrl glue helpers"), present in=
 6.12/6.18 but
>     not 6.6.

If you also select GPIOLIB it will build just fine.=20
But I decided to deselect X86=5FINTEL=5FLPSS and PINCTRL at all.

This is my first bug report here and hopefully everything I gathered to=
gether wasn't mixed up and is correct.

Greetings
Matthias


