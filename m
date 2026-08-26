Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C34389459
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731592; cv=none; b=I+vWQZL0iL9FDtyjSVfHGM5ErQd+0IHwXyGHpPjWkWVXj8ufx5PjhQl+/Hv4cjhuYmzZUMmVfrcugwhgwMXHvHRyKZZ4CmKl0Yu5Lr5KxkGWI7CR7BYJhI7gwXUI5x2+PEOyNRAuUcYD7mRuWfrGD9el1U9OzDo+9H+S0u+kFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731592; c=relaxed/simple;
	bh=mIVc+27luKXxYN8m1A9ZFRB4DjjTlFOX4P5cdCWbcDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nfdcOUMwDcFVobOFfUWhY86KEvq+7oY0IjzyCCdvpF/eyjDQmp6WNflBnxT6xQEqA2jWrPsc5gnVAmh5gWYtTBPuyEBHQR5qUNPDylYln/SQhoJtpma2mk4ByhYea1NcP3gzgpOiMZrCOgmcyMMVOAQs4MB+ZY+U2jWlLJePhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6qD9Ml6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6qD9Ml6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c169ae1cb26so352117966b.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731589; x=1788336389; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJAve/ikP1v0T3xdVPEDONKs2L7oCeoGp7TwH3nXlKo=;
        b=Z6qD9Ml6fxhQ0tSavrm7YKBR0XMzgMM6n2MPe2SVDLAAiYJ+NA5kh9qchfsZRdUut0
         sOE4Fg+iVY+Ss3ZizsNnG51xMTjvgtWmrPl+tom8SqVZti1kNZMb5M9p1/0gJymAAxbM
         wzhOCjodQd9zT8L2kJY0bwA1oY4l2DsX/ogHYwfMYmCljx5q13bjRgbtuzv1CnpvyT3X
         Txxpt2WETp2u6rdQd2ebxNzYQUQ9KnKtH0OFN808W+BIVYDI4aA3hkMgyliAJ5W4oJ+T
         cHP9W7VuJGHLlqvtI35VdvZXePxUyFAybw3kMu1el0F7xpqufd3wKbL7ck+g0pwUvO00
         SArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731589; x=1788336389;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJAve/ikP1v0T3xdVPEDONKs2L7oCeoGp7TwH3nXlKo=;
        b=dLSZNUfYR5gkSbG2PKPqMm7grx486GssQomVsP5sPt5LzNKrmI87adaEoK+azbSQt+
         60c/O0xagaWn/IfvVDgZwq05QhBm3uSTSNvqzKllkUie3epI6DDy5C6m0RhBQCrJvSHo
         vzxoQfRxmqhzD+w3YziRfWL0qN9OiZu0vuyK2gCXOqHueQdoVH/iMz4mZxEuS0IwuvYy
         wMJU+Y7ySwexnerJWG0awRdS76tZm0TJxbZUnxuMhKBdPaOR1UMAFN7YF85FzhUpUV6I
         fch4AzxTDS6pCTUvROMy4UGdzUOcxPGx6Wkbb/kjbQXvi43oByvasDmOu31CEqp0pK5o
         pKXg==
X-Forwarded-Encrypted: i=1; AHgh+RrOmckw3pdkanIinwCVrGwpV1mNMSkDSLRjeyWvcdv2X7zhYxONoKjSS8/X+T9V2PWmu8wQZdI=@vger.kernel.org
X-Gm-Message-State: AFuF++nas9ADrHUuPow13EM3kItSESg3OAX2urwYeMA/0cDdIYZKzql8
	8G1hEhbVOzJA4gNJ6iGgdgIpXSZ65UQyPgOLWSe65vrQyNWeuz4vQGDD
X-Gm-Gg: AR+sD11o4Zwf2dtWrgf59sfAcVFRBM88VcyMhoYAylDiiDvHWOhbgqqWv6l2w1rzTri
	VGvE0SxDTwbsUUJ9QwUFGltakv894pqpFwluI8ywIb3ZH4SJPlk3zP+OJNAaNbI86MZz9sM+zu6
	oYhxkt6eyQX7FzDKY3KxCXimX8ZX5j/bCPYDC8EmQzHfwkESv5H2i8S6JiaknBDOhtpxXVxkj4O
	1UQels7ZFKzGxo/0Qe3CulBcJZ0aiEswEygv097t5p2KG7nnzo/5DaE61Qaoqnk94luBdQ7EhFQ
	7188SWtSrQfhhz2W0B7up+1XwDfzHWPNN6IoLZClKHnGJMB0gpEasf+RY2cEGitGeElszMr8z0o
	PHT1VUUc6ZuCR6DyJ/murdpprJlqfeU3LivsgAvlAbFLwc2MOwUooY+ypBIquPdJEKZLjQPNPdv
	kBEn8Lv2jDZLfoiML3wpq9e/P7MepnmWWnKZP3evXl3YcuLgQXMjt/6BkER2kH8nmC4w==
X-Received: by 2002:a17:907:844:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c24e2aa48bemr1491171966b.2.1787731588513;
        Wed, 26 Aug 2026 01:06:28 -0700 (PDT)
Received: from [127.0.1.1] ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b10cesm364143066b.48.2026.08.26.01.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:06:28 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 John Ogness <john.ogness@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
 Gerhard Engleder <eg@keba.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()
Date: Wed, 26 Aug 2026 10:06:26 +0200
Message-ID: <178773158689.1384029.3121943722878545406@gmail.com>
In-Reply-To: <2026082645-stench-backpack-6e07@gregkh>
References: <20260826073237.1377668-1-linuxoid@gmail.com>
 <2026082645-stench-backpack-6e07@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Aug 26, 2026 at 09:53:34AM +0200, Greg Kroah-Hartman wrote:
> It's an invalid syzbot reproducer, if root tells the kernel to unbind
> from a device when it is being used, it gets to keep the pieces when
> things break :(
>
> Let me go polish off my "taint the kernel if bind/unbind runs" patch to
> keep this from happening...

Understood, thanks for looking at it so quickly. I'll drop the patch.

> Did you forget an Assisted-by: tag?

Yes. The patch was AI-assisted and should have included

  Assisted-by: Claude:claude-opus-5
  Assisted-by: Codex:gpt-5.6-sol

I worked from submitting-patches.rst for the tag order and did not read
coding-assistants.rst. My mistake, and it will be on anything I send in future.

Thanks,
Ruslan
