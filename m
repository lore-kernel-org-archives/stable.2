Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78693630AE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233750; cv=none; b=sPyfKIeaQDGegkxLCT2c0/rWETHgpcz9AIx39qIRTQkpwtdeJCW8CYMI6WdKGv68GNp4tweQtYAAFU5Qb1bxSSjnNioFI1Yz9oghPAe10JL5/3OoIZ1ji3P0guTA9yeoGn2megFvp9Lm5DudV3Reg04uikJkeLsnPT0pINl38Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233750; c=relaxed/simple;
	bh=hpBsZXNBeHPrFJK9Lbz0PnTnlPM0COJh6UkqAnbYP0Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=r9mmVeOO+/AytlWIklOgCQbSjD7crAPVLIyyqGKaj04jYctCvJTVBFy4OuPffOHV0XS2cEY04BOVWvDgAXUwJbiISvcS7TqfYASQePS8aaR9MiRzBzTsw72KOG1loGY0r8z5lyBR57qzQaCxf+kMRqeVcyT11N1JpDbP+6hlv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpuHY/I3; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpuHY/I3"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so2820205e9.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789233747; x=1789838547; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7htttlEbVC3R3ww5ajtrz8G1FuecAdq74SLVWP0a2Gw=;
        b=SpuHY/I37o4Agby3kdV7/gMwEmDJqI9wefuHljnwF4Wga8Lvg5JWgHtoselbavShMF
         GwqDp+G1MpL2eOELCN0IoEfXthWx62MegRK1lIEsLH1GjqoIusd/He/PXTY/cJrRo1n6
         468X8419rJcbXSKwnqR14+0mJ+InzxWCeAJ9hcsMrTqqn+On8xm3fK44sIYl+fMK2n6k
         OkexfbwsR+RdTQL6FRv6SmMhlkjGc3S1MHzg4chJW/438zEaYQxisiE1QhksNX833BQA
         biV/Vn36x62m5H2emHsdlU4+H+u4C6aDRlK5VR57ILTviny4HVVcrDFtq/vlnD4mEVif
         JNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789233747; x=1789838547;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7htttlEbVC3R3ww5ajtrz8G1FuecAdq74SLVWP0a2Gw=;
        b=gOJguI2F2vkK/YIy1vFDMCUy8T7EWw+slGJwP8iOtEugfcatKgO9HA5b2sxPfMcBJr
         FgI5an455qyN7b2XKzLC0VmcF0uTjrzstLiH78Zk68dYwIy+QLx9FXlhx+B2X/j2/Vir
         4B4DlNbzCJMPEeu/2K+tIltRO1W8Mt1gAUEvsWzNjc7xIl2Iutw9go0N8P3d+ND1YEWe
         3wcZmHAgbyftCpyf3uc8XtuUk0bwU3cdH2V3ibnMwdNbKfRznzMoJrj+U9hKF68h+UW/
         PkQPZQvwVNQBkWKEr2mojgY5dTFSURjcDJ7KT1VDR8bFlRYTk2gm9n/yBD4NblXDeCrH
         4gJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEvZ2l1ZUl1OdsJRh+go1h1IwPkjvy6iqKVFs7aU5gnXkjKQFKlgt3ojeIela7Hvenyi02zBY=@vger.kernel.org
X-Gm-Message-State: AFuF++ljPU7swLUnJN3Gzl2gIO6pd+yXPrxm6egOZpJA0yqePtEHkhOv
	tgPuCa7GONx/+X/4D+OMYxOOsRtaE551XOzYrup52Sbea+9yz7E97jdj+zI9ug==
X-Gm-Gg: AYBFou2X2FqmKWPKxCIctj4E3eDSKfNtiEMheiUX8+x3hPgLEy6tlMGSECBwkwSqASV
	IJXMYEvsScoZYwYQSqtt40yU10pqIZmanHEP++jwImi04fLpfdLlsZyV++usFIpBuifK5O9lUQy
	uiLEAsi+JTzMDNyzyyMdSa0gJL1WStJ4PyBBpC53tgowLOFms3VzS//IfUOcsLw1IZbbB/7ME9s
	TQFblNJL+aZDU+l1ceWjxeqQFu/bQkX9YB613IaPT2zWxY9x2UKxJhGuqJMoXcVZxwBZ4LQAeh6
	wKkys6+Xz2zl7ObzFuWAkihvJTy2FVdYgDTX9p0zkeZvKtEIoqjjz56fkuJfnIaJ+qyUOggQsnU
	8WbrByOooD5U85ELyQieiZLhZgs9SL631+idCYYr17YLhamofBj4reYX+iw9/+5Cv+RvYReJWZh
	4Qvp2rsZZveQrfYep2xQd1B3IiYtF3A1F0fh9lbTnhhUEu38msY8/waUTyUTvrWgMxAOg6NLF5f
	4ruzQ==
X-Received: by 2002:a05:600c:c490:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49e619c0423mr109285725e9.16.1789233746663;
        Sat, 12 Sep 2026 10:22:26 -0700 (PDT)
Received: from SurHub.localdomain ([102.213.68.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e81asm14491404f8f.7.2026.09.12.10.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 10:22:26 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Abdifatah Suruur <suruurism@gmail.com>
To: linkinjeon@kernel.org
Cc: sashal@kernel.org, gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.18.y] ksmbd: defer oplock break until m_lock is released
Date: Sat, 12 Sep 2026 20:22:22 +0300
Message-ID: <178923374277.30348.14595304921780051144@gmail.com>
In-Reply-To: <20260911151056.27965-1-suruurism@gmail.com>
References: <20260911151056.27965-1-suruurism@gmail.com>

Hi Namjae,

Sasha is holding this 6.18.y follow-up pending a maintainer review:

  https://lore.kernel.org/stable/20260911151056.27965-1-suruurism@gmail.com/

The 6.18.y backport of the oplock UAF fix (c8279ae8df68, shipped in
6.18.51) calls oplock_break() directly while holding ci->m_lock, and
the backported smb2_oplock_break_conn_get() takes down_read(ci->m_lock)
internally -- a self-nested read lock that deadlocks as soon as a
writer queues behind it.  The patch ports the oplock_break_add()/
oplock_break_drain() machinery you have on newer branches so the three
walks collect the breaks and drain them after releasing m_lock,
matching the 7.2.y and 6.12.y shape of the fix.

Could you give it a Reviewed-by/Ack when you get a chance?

Thanks,
Abdifatah
