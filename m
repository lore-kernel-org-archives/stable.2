Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922636;
	b=qklMY/iQt52+k6aRGG8PrxhBRlwh03aEGSFAOIRn/7smA20NEAO+jCOTLBv+UoDqLguy
	 mHvJrhum+OGFpQLugIj/QXHXhkwF0IPoiyNYlfmghLjN5E5w8Md+b30C2WqSKqXXp61VF
	 0fDORkr1Bm4aYiz8OdrIzWC19EYNOsS9IvGgXp9Kx/QlBpD5TbYK6Q4uKm/kr2DgCyCam
	 Rr1UnzGg/HreO3I7ULLuxmyMQzyD+Gp8/MCURpA5oWwgqHLoP7jAc5VSzJrzsdUK0YZsA
	 VR0U1llgVpC9U76vVvxeorPVLYGs0ZY5wWfcWR7fwhg+uJl0IfNMrdZXKAx9FAnxqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922636;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=xEFuU2qKV+v5WtO97lVqT1rvBSUmDGK6lfnCTwEgqX8=;
	b=Ni4hqltK/IppVPfCz1YPERIdF+qt357flWX87mpKgia7rzMAZTQwgUD/DwS3RW0nIwEu
	 37Tqg6DbSSyyaRNlbx7xGofRS8l3gptIheA7pFSwqbflMfwHR86Mh/YghB9d99ndTY3A8
	 Ov78Z8ElhlNXmokDqzxEBe5OGncnqpWMepEj6zphBJ//zIRZ5pvTJJRDeU5rf0a7b9100
	 2QdsdthrGBoa6pnDDzj+xOp8duP6IYAH5OKZFqAkK42n8dNTZOU0UO23czXdWgQBmza+B
	 oCbqGeHFqiSbueSlTDYlBxs87KYZe8TydYYrdrrpzqGWYh3ibRsyUCOHzjqP7cqy7/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WDICBJN3;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0207F606A31C;
	Tue, 17 Nov 2026 13:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0207F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WDICBJN3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 46BBAC79A97;
	Tue, 17 Nov 2026 13:37:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D97505FC81;
	Tue, 17 Nov 2026 13:37:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 65FF911BC0024;
	Tue, 17 Nov 2026 14:37:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794922629; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xEFuU2qKV+v5WtO97lVqT1rvBSUmDGK6lfnCTwEgqX8=;
	b=WDICBJN3kRw4+uumCgAT0kHX5Ps8gFDMmX4/WlFuqgKgNrKYw7plz2du8wU1V02YlcUtKX
	z5efsHsoPvaevgEJmw9ICVgyguG2AM6BHF88/nbuCIQl8r92d8UtM5QBxeeyWbC+sNMfqV
	t/M7QmsnT9/I1c5GNkeGD/3teAzJyxDKBcAhgoGuPNCGdUoKE7tO3Incj+zrgn4vVFBteP
	pHXNfQUOXh8HAHZ7n/Av2eNJrQKDIU30wXsoIMije55ovhn8TpQkI2L0obohKYKuA3PK0o
	TNxGJ8nfsXZQr/2zswVUsbl81LvX26k7sTVKFCteVuZuKzJZ+Y8Ra3wHw9YAWw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: joern@lazybastard.org, richard@nod.at, vigneshr@ti.com, 
 Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 shuah@kernel.org, me@brighamcampbell.com, 
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org, 
 syzbot+c9d8bc9f8ccc03799e1f@syzkaller.appspotmail.com
In-Reply-To: <20261017235733.14667-1-raghunathpalla.0209@gmail.com>
References: <20261017235733.14667-1-raghunathpalla.0209@gmail.com>
Subject: Re: [PATCH] mtd: phram: fix name leak when phram_setup() fails
Message-Id: <179492262721.2237190.13662832198672004023.b4-ty@bootlin.com>
Date: Tue, 17 Nov 2026 14:37:07 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

On Sun, 18 Oct 2026 00:57:33 +0100, Palla Raghunath wrote:
> parse_err() is a macro that prints the message and then does "return 1".
> phram_setup() still uses it after parse_name() has allocated the device
> name, with a "goto error" right after each call. That goto is never
> reached, so the kfree(name) under the error label never runs and the
> name leaks every time one of these checks fails.
> 
> syzbot hit this by writing "p0,0x8000000000000000,0" to
> /sys/module/phram/parameters/phram. The zero length fails the
> erasesize/len check and the "p0" string is leaked.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: phram: fix name leak when phram_setup() fails
      commit: 705a7ed4cc921060854da406a803d688c8aaa52c

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl

