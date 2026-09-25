Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87B4CC63C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361668; cv=pass; b=HYWCM71nghUhdbpVlKxoNR1bKqqrSmFSKbDxVv6UWa1MM500CrtqIHbmS3ezCs9JJHLAxjnSVGLGqRueJaXL8ADW0Ex2JAeSRiN8mWCwkquELxl8DBxA7ZMyPd/GpPoKyIxn1fiYkwGO3ogEEy+jzDUznjwqogGFXpqP7WCE7f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361668; c=relaxed/simple;
	bh=cL1tlCa6jM/ci/rkuMQUF27PfSf78/QFN4J20M5SZcw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AuDAV4wHDrC8CiUcDY9BRsZX9UaqiyfE6eq53p1opwaUqyJGKdTW57GJbjhbrLWO+e6PR96wwB314A0zSKRaeejpJ728KSZi8Ca9PaZPRq3pruuWGh9Li4p4ZDEUeamzDIJwO16x05mDv4rZOs4Rb2VAQhFCzn2CL2Fx7SDedvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka+IyBej; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka+IyBej"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso1801126a12.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 11:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361665; cv=none;
        d=google.com; s=arc-20260327;
        b=GtVt6J8Rq3RUrw1Zqi2dr6iMkBnJSMY7ciYpI8atbVFABPzbYezPQM6fnTHBoVbnUi
         2H037Nvcla3ZfH7EqE0y78HvvZPQb1k9tjPmchuExtsVTY4TpvF8Gh9hv3hcHO2Dwygz
         gbBTNMTLMLV77BNxO6ioUN/d1VVqPGGebwTpd5zxzf+vNjFemUO8TuQfr3SD0xxFJDC1
         upUGyeQ3p6DRoEbFYnFUrusm5ZeWbBrmEPXG5RCDm/LJyd3SY7snnevnC8zv/L/enmXg
         m+G+52k6WPHMa1UZFx4Gk1ubIiDL1C2unlKIKFII2idMs+e2ei/b6M+Zw3Ry9IOd364W
         Do9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YRA6perxvKfWBMzKUqDXlzBQE/bhcqeABbzCGxoVUKY=;
        fh=K5+GGekdKd8Ny53XkxZCPcKEdT/BpX7ck2f2HzFWBhI=;
        b=VLbMmqv1FKu1046Rh3Th0LonxZwOewTpQSGa3oa3iae1nyJ+kmAPQzADFnCzICrQ8J
         xx/+0hdMJWd+m0ZglBvqgFzvTLOSnzxbazmtYxWLBK3WDoQJWlC39/1u8qmekJRaT2Xo
         Na711c7XQbWL9YM62cbblWAvGF8cKk0WO4ni53jRuhTQHkX2xtETppbtk8SlIH4GJBx0
         cQUhuGTmcylaHAjEo/VdSSo0FLXkdd3xE/QwrWkD+B2KYGrpfbAi+2szjLZjlqbel+Uc
         4VGOgt0OD3jCBbb5vENPhEiO8MfdIYooR/kr/+ZBRUyx4zcYyPKEGso6PKXZ/wZcUgYo
         nuvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790361665; x=1790966465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRA6perxvKfWBMzKUqDXlzBQE/bhcqeABbzCGxoVUKY=;
        b=Ka+IyBejgCk2bFs6c8xQWsSjm86UOePWfzA3lob1tobFGUl7ki12p3i8VjY+fDnEEf
         7Q1huwgDNNev4iDOtDHf39EwlQO2ROSxC1hayocw/RAArmdrkHb++Hvarz50QlTqYC7Q
         7/KlJVvvMVK+ll1dPT2VuxWkSihYfCtZtmR15YHeLT3C06MQMEnTtTAYJY0PgVi7pRKQ
         5NPVbCOuaebBdyX6m6fLI9sQGwZlQVfFyekoPJRB/imxP9dSMA2Q9xnddPiziWKnuXg8
         ubQA2g8gwrZwzUY2qkokBnlh/Qdv0WFyRR81PryXxqlMvfNrND8MVjVyGgElQFRgw2DM
         +PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361665; x=1790966465;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YRA6perxvKfWBMzKUqDXlzBQE/bhcqeABbzCGxoVUKY=;
        b=sQe6Sx5ay4dxYOZ6y44ziykAn4VsqRzNWPp2UPZPq4K52wRvcYQZ9czG0QBf/u2J2d
         UDo+LzNlkAC75nKbIMR6xnl7gxxnJn30ORX2nwdrevnr7CVN1ByWlgJKPK29SuRyYkii
         llnb/Ow1D1V8scc7SUBiq6NTYVNStJNBaB4ReOa4Q2msc9na7dFa8X69tPiDG0t3ahrd
         XP/SgcUiLr+v+LRqg0Mm/jKUj9DT3seEDD4hHcpsmuM4noy+eF18p3JDvx2Mbg9kznvi
         hVwPUgpnLNZplBHgdOtPRm+qYn2ml55gZlkLBm0T3xMMMG82kZOccX99Y04oLHfMbLr0
         57ew==
X-Forwarded-Encrypted: i=1; AKwUvBzNlxlcOsK2MmykvLM315XUkd1h1Sz7Nl0KExuNU8jCSkuH4v+KUk0MJtH/Hw17ml9vxzqb7EQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lVBQjmC/VeZ2hEpwnNv7OAbUAMHQOCaGQNJMLkF+RCogHgZ7ch
	71GfHCiRCA7yu9iBklZjpsOJ+T+y4U3eJunQNNuPr3GxTf1831BAseX3uT8+xk1my0cUxz/tWe7
	O3o+or4nIhZGU0N3AfNkL/fIV/6Nkpg==
X-Gm-Gg: AYBFou0dSLkXDKVdSp/CVRaOo2BWT7Qa7b+ouBN19s6QS5Ara3Sc6jagG4260nV/Y5q
	vp1X9C5tSl59bSvFKPG7wymXkH6xrdGDZyeerZKzh1RtaW7nc/U08wbuBtrdW/EGbGbMT4xZt1J
	JTNai7pjAVJzyNW5SCjK4N0iR0R1L/QoSpiFGCef8n3Qpy66CYw1RlX8HEVpxMpeUVe9EKPZEM4
	xLpkGsMsWDg3nnRuZoCUOERyw6BsAWubaU8PciJdpOZ0lVul/TjvYv6sC7kO+JA7HONu2G4vcq6
	EaVS4O91aqQDpn4vCasra2nDFWJ1f4rbVyS2alak1e5lIX4Jc0pzopHpVxYetCv+NUVqBW4tF7m
	jlEBCwrh7OXOi2nsMiCTCfXr1ozLx/76iDUddJwFf6bQIucXozqvvMvW91+iaqzreXXByaFFF2/
	Q=
X-Received: by 2002:a05:6402:4395:b0:6aa:a328:5179 with SMTP id
 4fb4d7f45d1cf-6aac8ed1fc0mr5053304a12.9.1790361664525; Fri, 25 Sep 2026
 11:41:04 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 11:41:01 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 13:40:21 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 25 Sep 2026 11:41:01 -0700
X-Gm-Features: AclHuK8EO0nk_ovuHYZ2MiM2V_OO_n8lIvu_WfCVj09L4gss1xu1pphbhqJqk4w
Message-ID: <CAGEsz8Hurq=5MJXLD5uA-+uPJdMp55auATafawac1_3mpv65PA@mail.gmail.com>
Subject: [PATCH v3 0/2] media: amphion: fix VPU core lifetime during teardown
To: Ming Qian <ming.qian@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vpu_core_unregister() releases the message FIFO buffer and VPU reference
before draining queued message work. An open video instance can also keep
a pointer to devm-allocated core state while sysfs unbind removes the core
or its parent.

The first patch drains message work before releasing core state. The
second prevents manual unbind on both platform drivers and warns if core
removal encounters a live instance.

Changes in v3:
- Resend with intact diff headers after the v2 mail submission wrapped
  the diff --git lines. No code changes.

Changes in v2:
- Move vpu_core_put_vpu() after the work drain.
- Keep runtime PM and mailbox teardown unchanged.
- Address sysfs unbind in a separate patch.

Myeonghun Pak (2):
  media: amphion: drain message work before releasing core state
  media: amphion: prevent unbind while video instances are open

 drivers/media/platform/amphion/vpu_core.c | 18 +++++++++++-------
 drivers/media/platform/amphion/vpu_drv.c  |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)


base-commit: 4efa625593e1e9c76346232413997556dea1d89f
-- 
2.53.0
