Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859791;
	b=w7uXC+nxchoJ4ywPzP2WylRp3/5tG0vSZq1Fu5AIHRWmnPAy8/NeCqMBxl1N4/nbGLgQ
	 XNJkwU1V3Y1l+bO2AFoH9bkYiKSPjupqiKcO+HaEirrUkcUi8jPp4a3/9SiQdT6UZjkJ5
	 Ax6yDCTzuIv/tdEbamlw8gECY3CFKGGwCzBPw1Hw/1zTV1xf6FHPxOFiOsjrOvD3vXhZF
	 bfhkUcaEzsixFeZgCn1Ks5S1AfOKamAg1PMh2TJ3j3SKO8WHZHekL3tymI72nf8oRD2Oe
	 rlqEePMUdaGUTKNeoZHILLd0PjvECWRNyoGBBWa+LvkkcADN2pNSjx6Csxt9Dubai3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859791;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=2B25+wnVPJcXu/9HzjnfC6KHhZGgpfc/3lc1JiQ3Z5A=;
	b=Y04WyS2JwPpz+QMsw1CdS7ISF3FeHae6c5UMaDImpG5OTGJK9pNgPfab6KRewxSb46XM
	 d6t757GsGknvMtwB7rlfehRJqyK8yfVMNIPu2X6uL39l64h4YkvruuC86oUB43I8G0U5j
	 wmQYIzVjuVHaZ3qHCXmLIAT2vXXpKK2NfUzfobmOqWAWFhahJorpspYzT+2kJgpXPdqsg
	 vBx2rAaL4EfYWIy+9yBvWJVbU2k/ISyXnWaKybnKH4Gkezg/IXIR4x8g+napPqj23HWz/
	 wRo/ZswELPGNDVGLmSm5SLPJiZ41W1YV25sallF2v8Wr8v6Q5RlpDrcapm6ibgdmybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=NrJHe3tH;
	arc=none smtp.remote-ip=185.70.43.97
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77EE606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B77EE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=NrJHe3tH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794859788; x=1795118988;
	bh=2B25+wnVPJcXu/9HzjnfC6KHhZGgpfc/3lc1JiQ3Z5A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NrJHe3tHBNMKOEc+MO7WI9m9on98H9lShQTPo7oeTjw37fIxJpvcCuAh+cNdYsG9B
	 jjb9TzNu1qCvHmP3fpqsnJrBQ3NGVnZtOE/DkPn36p2vdAG/a0k+KtoXr5mMmN+ugA
	 dgJ51k5Ify+kqkexJs1LUUOqQBm98+HD3IjE9NETCyHRDpCVsnJq07ELgDCgKdQOis
	 qfkQXWJZFE9VLnVovA9sefXhGNbM/onB3zoj8DhL25V5tKAxuB7p3DpkWY9LC8swVB
	 Hd/TXpAMrbb+pfyXGSP7Nh9eTjJDt9V8+LgCmdI5JAdk9W3cNWjRpKTUwsivm/4fZ9
	 mWr9is3Sq7rgg==
Date: Mon, 16 Nov 2026 20:09:43 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: pfr_telemetry: keep the state until the last file is closed
Message-ID: <20261116200935.2464922-2-ca@modelmiser.com>
In-Reply-To: <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com>
References: <20261110144436.1529000-2-ca@modelmiser.com> <CAJZ5v0jTHbr2KD3PXMdcOCs+QUrGrjGGuxOH7cbOe4kEF77d-A@mail.gmail.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 22a8e2365a91d688f9c376356b62f0bc1eede34c
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

On Fri, 13 Nov 2026, Rafael J. Wysocki wrote:
> Applied as 7.5 material, thanks!

Thanks. Two small things in the applied commits, in case they are
still easy to change:

1. Shuangpeng Bai reported the pfr_telemetry use-after-free in June. I
   posted the tags on v1, but v2 did not carry them, so e788ea48810f
   has none:

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.3508974301899957212@=
gmail.com/

2. The message of dacb7cef6f32 ("ACPI: pfr_update: keep the state until
   the last file is closed") also contains my notes from below the ---
   line and the diffstat. Two sentences there no longer match the
   commit: "kzalloc() rather than kzalloc_obj() ... for the stable
   trees" (the code uses kzalloc_obj()), and "No lock is added. A call
   that passed the removed check can run during the unbind ..." (fixed
   by c0ab3714e87a). Deleting everything after your second [ rjw: ]
   line up to the patch.msgid.link Link: tag would drop them.

If neither is worth a rebase, no problem.

Chad

This reply was drafted with an AI assistant (Claude Opus 5.5).

