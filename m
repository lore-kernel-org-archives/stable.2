Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0738655C
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124756; cv=none; b=BpMWsbgaGK4jYEjCy3dGIWiD+XqjtZyotOL9YC+fKwIwvBuzzbnYNivIWT1m2vtbCbh1JHzTyx3yLDyoEDdn/oJnh5Gw09TDgDKvOB5R0kD1VhZuMKyowQHEoJc+l/EWVmfRaUAhn0OVYVwf6c0vFz3EsJ6a7gppq2nZGnSt7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124756; c=relaxed/simple;
	bh=3f58ui2UaAqFqyMV2EtClVFH3yRcP7QyTZuYCQDYmHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNT+GzOrvYH8dpX+Mfygymlt8f2/DVlRh278eIyajIItQujYC9q8bt4LVyZkwUrVM8tp6fspVxjaSMCOw+sZS07v9gHD7WcOY1+gs5vZw0NCeLeXpfOZK2SHmNDTAhp06ZKxk0m0uShx4GUE864L2E/RaEjuOxLdL4OIVBcsthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgncOthD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgncOthD"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ccce967aa8dso76016a12.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791124754; x=1791729554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35o3ClarjDsqmKRMmMbK/8uDTJyS4jnUyX4ib9jP+ms=;
        b=hgncOthDbuu/BNRMGtr5ARMJEJhMoEpNTtVHjYNkjpFEgGyPQbdUAeqvpSCR1lkZMl
         KqmEvy0gb7ZIFMfFR0G8dyP/1WSfSlq1ylFHoLS9zCJta+S92Z8Y2oV69eB/RVggzXSd
         gzvFDFpgRRA6IcRlmVqnfCnifSraSS+y4lm2eWi98x1G2MTmIx/+pILO0HtnZc3r0Ns5
         3UDZ082guzwNlcDaxlwWGCpYBDct50pepVdpDzzohi8WnwRsajr4BZin5lXdBdNREF24
         RPRdX71zZC3tWAXN/GnBl42mSw4oYLdEw8LB9/kOXZ1lvCGm1Rc8pXnS7jOSH2tPPnNx
         aK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791124754; x=1791729554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=35o3ClarjDsqmKRMmMbK/8uDTJyS4jnUyX4ib9jP+ms=;
        b=gDeCagp918BDBMQZYJP72eiH2FfDyUBj6GYZ/vywr5wuKIHMMAYoOVm93TeLDlKxMZ
         ph7TGQTM2rWZeiABQVrpHkmh6jcaSFctkie93SLzjciFGl9wwRb3RwPWceOgRQi3gvxE
         JsTKonHmVzrTLUU4vS+0Owr/B5yyL4khoKuKlrBu1bj8Nnw+3vg4q1PuCA6z/SPjLvFV
         A7lm3SKRzs4awM6btTrnEoVWZRqa/Hugxpq2VVhUxMpkKlJysVLKmqbBlTLdUAjPy+bX
         ArHXToZ1Y/ZCiuZ+SyCkp4n1g1/jpd4kF0u9ghE2r5YZaUJyz8V/z3IXj4U+29C8a+Tj
         W8Ag==
X-Forwarded-Encrypted: i=1; AKwUvBzWqo6K+nv8vGN7BU/CKzqpZiXeUuokoS6Ecx+Tx3tIjdtkWat8FU8kzugZ9ci05DUq3En58ng=@vger.kernel.org
X-Gm-Message-State: AFuF++kVDy9h3aX6c3AX0G7zNWbuW/+HfaJyXclY0aTc6QpvQqwVTSOk
	w9e+86PC60dkOuMK+5nDz+72A1wVAiRv6HoHf2fNhHTSn3+jdEW0Vc9bP7hVtL84
X-Gm-Gg: AYBFou3MxJgyy0hGJ1uKdMvbcVamy0EBEKRKnEvRoAbU3rWv3upay+6UqCPDM9GgMBB
	LfSst5NPBG7ZsYx4Dr2uDhnGvQ1IifFj728HbO1JVPv1K72eF3xZBD/UKONzhPAhLpsvaGFaRLc
	yOiRACyimkiBGybzXoWAiddoZpqLJjm25hyrW0RVql7yV9AnZ5w02KM3YZKrB+H46t7ev9VnVMN
	S3zzhNp/Ghg0lOfmTvtPJUvNezpZ5OPtbFeZ2Ar6VMDpWpfa7xezrDpUN94jQmrH1IN9tAV+/TW
	Wr/jPIYFhf0YytOohZz9H7wL8cNUZSKODCVALkuZKAOjnpRqsYiIQyXj9JNnyuRefYKAJ2aLCQa
	vZWYIJnpz2z9WHpIr8+yiwT20LhbEMqZPXjfXE8sHOMnRwbgptWimNXiefTt5ls5iDd7lwPYson
	AejXEPHVpgfbGz0ikrPVKafXbpbCBCEs/d6xVjtXKzDbA7hGg5wveUbiN9VW7+jj+Nv2KtAIlnN
	lMV6981
X-Received: by 2002:a05:6a21:3113:b0:3de:91a6:f7e with SMTP id adf61e73a8af0-3e0d6cedcb6mr4095555637.39.1791124754431;
        Sun, 04 Oct 2026 07:39:14 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45f:e6::17:34f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f736b20fsm2862036a12.13.2026.10.04.07.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 07:39:14 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Antti Palosaari <crope@iki.fi>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+ac020fbb657e00356ca2@syzkaller.appspotmail.com,
	syzbot+c35815bad054e6ad396e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] media: dvb-usb-v2: set active_fe before the demux goes live
Date: Sun,  4 Oct 2026 21:39:09 +0700
Message-ID: <20261004143909.120584-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927061102.47451-1-ngocthang2710.1999@gmail.com>
References: <20260927061102.47451-1-ngocthang2710.1999@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot has filed a second report for the same race, this time through
the gl861 (Friio White) driver:

  https://syzkaller.appspot.com/bug?extid=ac020fbb657e00356ca2

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000061
  KASAN: null-ptr-deref in range [0x0000000000000308-0x000000000000030f]
  RIP: 0010:friio_streaming_ctrl+0x43/0xd0 drivers/media/usb/dvb-usb-v2/gl861.c:521
   dvb_usb_start_feed+0x57a/0xc70 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:308
   dmx_section_feed_start_filtering+0x519/0x6b0
   dvb_dmxdev_filter_start+0xcdb/0x10d0
   dvb_demux_do_ioctl+0x470/0x540

The root cause is the same. The demux is registered while
adap->active_fe still holds the kzalloc'ed 0 and adap->fe[0] is NULL.
A DMX_SET_FILTER issued in that window passes the NULL frontend to
->streaming_ctrl(). In this report that is friio_streaming_ctrl(), which
dereferences fe->dvb (offset 0x308). The fault is in the core, not in
either driver, so this patch fixes both reports.

I tested this with syzbot's C reproducer, which binds a configfs
SourceSink gadget with the Friio VID/PID (0x7a69:0x0001) over dummy_hcd
while 8 threads keep opening the demux and starting section filters.
Both kernels were built from the same tree and syzbot's config, with and
without this patch:

  - without the patch: the oops above on the first Friio probe, 3/3 runs
  - with the patch:    no oops over 20 Friio probe cycles in 300s

Mauro, if you pick up v2, please add the following tags for the second
report:

Reported-by: syzbot+ac020fbb657e00356ca2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ac020fbb657e00356ca2

Thanks,
Thang
