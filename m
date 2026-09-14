Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3793E8685;
	Mon, 14 Sep 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389281; cv=none; b=OrkbkWVlOqYY0BjJyuq+l14DyQffnYwA13QQCi5UiJ6UUZRn8amCVKMVIeoNWPqrp//AHat+SyEjZ72NyQ7E2YtNKr+S4HV7K8GfmIw/aWgqiSiJwFpId/t8f2B56Dlbsna892oxJwgsiwcTfU8u2P8qd5VltSlnbIZwjiwoXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389281; c=relaxed/simple;
	bh=6JNz5SnaTf+EKri56sx5gL/eZWOe6uWaInB9WB7P5mE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhWea+pk6YAiWTq1twAm62KgG9TaiVooPuVOfuZ09RARaLTRZhSJTB6wdhV1VP0qsmPYdSfXGtevdXYXPVmSFGX+aRTWyrVJ6BMfNhbOjFyZykIgtni6u31WBPJo3/oo+3lhy6Vya2f/6QSaeba/MeMMZn/n84jRDZqpgqKP+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lb9xdF2P; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lb9xdF2P"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7DC8C1A05F2;
	Mon, 14 Sep 2026 12:34:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45E8660323;
	Mon, 14 Sep 2026 12:34:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4189511C7AFD6;
	Mon, 14 Sep 2026 14:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789389275; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6JNz5SnaTf+EKri56sx5gL/eZWOe6uWaInB9WB7P5mE=;
	b=lb9xdF2PC/WbAqGedrO5iI0eCjgOQk+pBMSr5TiHwhqWO+l62wwNf8wZ/4/FbHvYYVoF6S
	Wj6fp9gZwE03jdrsIV25aPwhaRFaMpLrEpLIRSOlsdqRpEwpc4XV+a7CLvauAyly+66Zd5
	/3Jl1EFf6EhFuXS2g4iVMAPL8mbHqG9iTwH5KhaerNoUtSPWEigfME7690lWFSIde/BZnw
	rjk9MA4jea79jr6nlNWSjW6ceSZYHtiPrErbcX5KxKkaMt2l7pzDIkAmLTO73wPpiuzFVy
	ehaySykzRUYAvHSnBFpfrQ+PT37pvZEGCFxWa8H/JWdlpdLqBEnqMejY0gdr3A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Itai Handler" <itai.handler@gmail.com>,  <pratyush@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <vigneshr@ti.com>,  <richard@nod.at>,  <takahiro.kuwano@infineon.com>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: fix the lock left held by
 spi_nor_rww_start_exclusive()
In-Reply-To: <DLF191CC4QMM.1SNYEHUFJ9GK2@kernel.org> (Michael Walle's message
	of "Mon, 14 Sep 2026 14:20:05 +0200")
References: <20260914081149.1916589-1-itai.handler@gmail.com>
	<20260914081149.1916589-2-itai.handler@gmail.com>
	<87ld94owzj.fsf@bootlin.com> <DLF191CC4QMM.1SNYEHUFJ9GK2@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 14 Sep 2026 14:34:32 +0200
Message-ID: <874ifsovtz.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/09/2026 at 14:20:05 +02, "Michael Walle" <mwalle@kernel.org> wrote:

>> Michael, since we already got a cycle with AI walls of text just to tell
>> "fix that damn conversion", can I (or you) apply that other patch, so we
>> can get rid of these? Let me know what you prefer, although I don't
>> remember where that thread is.
>
> It's already in spi-nor/next since last friday.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=3Dsp=
i-nor/next
> https://lore.kernel.org/linux-mtd/178913311701.1915651.479162421578739618=
7.b4-ty@b4/T/#me3b51a242469a4d9722089e18547e87fdc65d7c9
>
> -michael

Since that one is "big" I would have merged it through a fixes PR. I
usually send one around -rc4. So either you push the patch to mtd/fixes
(or I do it) and drop it from the spi-nor/next branch, or we keep things
like this, which is also kind of ok.

Regarding the use of `git push -f`, I know Richard, Pratyush & Tudor
highly dislike it and avoid to use it. I find this tool pretty useful on
branches like ours and prefer to drop a patch rather than carrying its
revert, or messing around with merges. I prefer a clean history rather
than the absolute lack of -f. We already have the (Linus) master branch
milestone which is set in stone, I don't get the need to create one
ourselves.

So, up to you ;)

Miqu=C3=A8l
