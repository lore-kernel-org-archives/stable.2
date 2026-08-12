Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948D314D1A;
	Wed, 12 Aug 2026 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538053; cv=none; b=hKlyMHLhc+O00JJ8bWGH/IK/ZsizICBH4LEvjy/v0QEZumnx4TAa39IiQppAPwu0di0V5vqOaF8rhqdroHAqYay8ZvefJQY6n+n2ewcsnQMwlV2aNXx8zV2rRBw03PYR4YHTCETKHsqcA0srg4/qQJsBvfwz/1MfCJdfhHCcGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538053; c=relaxed/simple;
	bh=N7fYohwigC5KlmiAySRrMwHm1iWi1Do7/uPuKk7Sw2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdT57kgtDh2UI8UNwext8vXcoaLyr/EmJGP0RvbgIfbHbim6vJJkUXq47MTMTNHwJxQAuFX6gynQyaUoe/5FSTM4nlLn8BvCQOegIpj9GBDbf+6Fc5TIu7ivjBkuu2dKEZmdaVtd7tWKcP+m8Aas4Gmh7bmSrPPcUctGhiR5Mh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YyhxBNCp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YyhxBNCp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 77FE44E411CE;
	Wed, 12 Aug 2026 12:34:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 395236045E;
	Wed, 12 Aug 2026 12:34:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DDE511C48FB2;
	Wed, 12 Aug 2026 14:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786538048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xuFjDi+sqwOiT9DOGhyCDzTUfQjl1AKPwxZGlAghHCs=;
	b=YyhxBNCpAmrz7AsVZImu0Omgf9G2QK4rQCmlcz+11OnuKSb2zuruJNwhBDkxYtbx0f99V4
	nutTl3TxMuC+RQpOBwMXfLIHVtW6bXNW0YVWxPTWFh6hprgvtnlsvJAi9oWTnE2OjF5UOs
	AtUpHKS4Kl73uV5sWtJ1OPOBgReV4s83WUm5q7qS+s8rL1rAsJmzSG540NN3eMQP1O9MQY
	neBGMDtYRAKPeZcMpVyZ46VHh7DI8ypQ9pbVicVcoeMKio6zXsHmokpQD29YSLdgA7xmf6
	djdU59My1IqW/n0idurHxu0aAbE+UyA7a72NEFm2oKEckvmoaLwEat2QJxOhOg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: joern@lazybastard.org,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,  =?utf-8?Q?J?=
 =?utf-8?Q?=C3=B6rn?= Engel
 <joern@barelysecure.org>,  stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: block2mtd: Fix divide error when erase_size is
 zero
In-Reply-To: <48230456575d27aa83ce8640de8fc07cc62e8efb.1786499433.git.xiaopei01@kylinos.cn>
	(Pei Xiao's message of "Wed, 12 Aug 2026 09:52:42 +0800")
References: <48230456575d27aa83ce8640de8fc07cc62e8efb.1786499433.git.xiaopei01@kylinos.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 12 Aug 2026 14:34:04 +0200
Message-ID: <871pc3msar.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 12/08/2026 at 09:52:42 +08, Pei Xiao <xiaopei01@kylinos.cn> wrote:

> The erase size is parsed from the "block2mtd" module parameter and can
> be set to zero. add_device() then evaluates
>
>         if (size % erase_size)
>
> with a zero divisor, which triggers a divide error:
>
>         divide error: 0000 [#1] PREEMPT SMP PTI
>         RIP: 0010:add_device drivers/mtd/devices/block2mtd.c:296 [inline]
>         RIP: 0010:block2mtd_setup2+0x592/0xda0 drivers/mtd/devices/block2=
mtd.c:459
>         Call Trace:
>          block2mtd_setup+0x27/0xe0 drivers/mtd/devices/block2mtd.c:476
>          param_attr_store+0x214/0x310 kernel/params.c:589
>          module_attr_store+0x65/0x90 kernel/params.c:904
>          kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
>          ...
>
> Reject a zero erase size before performing the modulo operation so the
> existing "erasesize must be a divisor of device size" error path
> reports the invalid argument and frees the device.
>
> While at it, drop the unnecessary (long) cast from the size operand of
> the modulo.
>
> Fixes: ea6d833a3fdd ("mtd: block2mtd: check device size")
> Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/6a7b58ba.ac361c09.22ff0a.0045.GAE@go=
ogle.com/
> Suggested-by: J=C3=B6rn Engel <joern@barelysecure.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Apparently, removing the cast leads to an unsupported operation with a
64-bit operand on 32-bit architectures (See Sashiko report).

I guess it is best to keep that cast in the end.

Sorry for the changes back-and-forth.

Miqu=C3=A8l
