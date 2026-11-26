Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673224;
	b=LyF/4xZqi32FNS+KEN5j5spToIh1NAI7HvYyJhiiX8VgtqIwwwrkOT4nmHi3Lk7EMZcq
	 C+7Xvs/QwJuKaCKMc3J+ItQHgzV7wJ5S3N465qyYKH1tMIISEjEnGUnSvxhYU64+f6fgO
	 Wm8R/69KlZHisqkM/sXXj3x0+iih3wKEJ4990IyAnjAkQqfOMjOtokYh0q5kuoQs8HmNO
	 7yeEthnGdAn2lipKa7NqnGWCtV5xsdOslbfk2pXyAHovmv1IdeouV3VZGt7Yi0wU25Rhh
	 nlcyl7ylvXoqxG/q9+gYabi1UsmNO4b4sriAVkH8/7alUalJp6AobTfjDEOs/ZJ/j2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Received:Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=4vEv4zWesqwl2OdkZUsIGqo+gUaqxzOcgiEIZ0178vQ=;
	b=tqhC4eAMDHhQQsnfz8frEgTrYfv4Bd0PU1fsNpWjSHEVNNDwS1J1aYxRn95j0DMFwsrN
	 OjH9uabIyZpB06lLTsVfQHVE9tMI5u/F75eotOXPlbZqTqvIfgUm5mtA/J8EoyhzNbJr0
	 hdhS5G3D+92iRhuoLgG+92w092ZASvX4FDplc4q0Zg3Ynq468TYNtAQ5y0HOG8hmu1y9C
	 oZl5Iomsv2z9mAAsJF9oD4Ce8250KyKrqUzm+Qq1zyI4CwSxYZgu2/BvvsgKiueTvAm7T
	 et/g+meKloOTnNYccJ2ghnUnLb2UmW7sfCU/QH24QP0s8w6yt0iVj0Qgxn0Pj/dUf4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/RIFmtJ";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9A606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B9A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/RIFmtJ
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so37202525e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795673222; x=1796278022; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vEv4zWesqwl2OdkZUsIGqo+gUaqxzOcgiEIZ0178vQ=;
        b=m/RIFmtJ5wHoWDb9ay9vpzOKu2gH8VeNfvVJoCdpBOZId0ptKtXlQMdDs1XUwGxOYm
         tHjXVIjzf69xhVaJT94qXMlodAotjrfYvNUHS/qJ9tUtcOd4cvjGygIYi4m98sokLfsH
         KqvuJFfUOlA5j2U3wmQlL+5l6DCNmXlUt1SWm/hBdu0LojTmGTnf5PpmJJ3SeQrM61kJ
         a1nmzacdqb3730/apkZSn36Q0VDknHxrMb4QS20RfH4TSR/x+2db+tZ53G8z8P3gT5Fh
         cKhCFyHfbGsZgOpuA+c3hH0OKr9XrYx8DaqLDc/hmgUgqmXfMxzONxI9W0frNvaxXE10
         Ixgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795673222; x=1796278022;
        h=content-disposition:content-type:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vEv4zWesqwl2OdkZUsIGqo+gUaqxzOcgiEIZ0178vQ=;
        b=1lveRm2JzX5+Itopu5TSndwQXJ2Y5H3DNUmu8kMHA9VzJrtp3AkvqqC6HclM0kvnSj
         9yywuXzkQzMwjiZFgvbZZKsnQWjmnXoANADV2xD/LvPnItwMAWd91D1tuiN56avqyWHf
         1o9NJN+ZyPo3WjvLZhsyeRlBwOp91pp6uJVB/MZ7u2XGpyJhOiFpltjIYyMyDKDXX8cB
         NaH1lI9Lm91JneTzhqRFilLHAgXKsuyTiOu824Ck7OVjOrdiv5pkMGJX9Ujnq2u5XhpR
         dtq56UN2cDE9jtlwePCxh4Zt68bjDUo8nU4p1qodyFK6UVJfsohCoob8E3CTISAtKBfY
         XRXQ==
X-Forwarded-Encrypted: i=1; AL+hErH+Sf/7vWE0IBmbL7iBAQaxzRYFSL+mzYTliCD/4DCsiRNsJXhru5URy72/5bnlR41HZH7I47Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xLvR4DStkK+Ch2VhzCxBwbT9F37pdMKI6cwYLuBD+C5i2JnSU
	22iv0c+cGjlrvwzZJmQb4wLvoOoLFQQjfnTYOcLbLrs8rnxc/tKompjT
X-Gm-Gg: AZFdTZduh56iy9A06fErvrx6X1TYtK47RczyLReiwb71fcY64Xvsd4P7Mz6hDOgknP3
	pmoJNWmbVdCn8XWlBx6fkU9X6pEjqeuEWr/YjMjDun6lr3jY2lC5CKy/xyLExhFBXyiQjLwCjyT
	7oTYWwro4D00cVasjAk4dB18DonE+WAMGsWiThpKXFv/QwDH74H0QgaXg85X+hranNo+dTl6ncf
	rkH/LKRn0r5SvqNMBFfYgoOtIov1mhnOjJtH8IA8KoPB2VHapl6h+qs8JUraOFDRAuAyenq1sgQ
	ZbMwaaijiooIJ7wnZPKc73PHDl6HtoZjBlrCIAnkM4TKfLV87SB7670ExJb3fvFV4DmYFmedHv9
	u3hVX9y0rG2E32nCK6g6vpJfW8MEWD1/X1oxsnaVIYA/k0t3ZlRSuaTz1I9ZgvWc8UhZ65z52Yn
	shEcdoIAJWundWKmr1ECiqqnxHSDsvPM6qzCh/WKmRDw89vqyqh0/3P+gDRL1yeIRxiIivne/g3
	C9fPIDXWjTg4VUDtGblixA+iAxYfkOx+AbKVthpemWzHsFUxn4xKg2LF6K1nJI2ucLc+JT06WY7
	21jiYeh46lSt1QEPGzRSEBJ7hqyWOInmq/DOBDsH8tFdV0j6JjeG6ZFIn79IoPeGC/XIHGp45pB
	rbYfn2xElBA==
X-Received: by 2002:a05:600c:4f50:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4bb888063f3mr499671215e9.16.1795673222070;
        Wed, 25 Nov 2026 22:07:02 -0800 (PST)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f148aasm228217135e9.0.2026.11.25.22.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:07:01 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6B47ADC05F6; Thu, 26 Nov 2026 07:06:59 +0100 (CET)
Date: Thu, 26 Nov 2026 07:06:59 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Edward Adam Davis <eadavis@qq.com>, Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org,
	"W. John White" <whitewj-debian-bugreport@outlook.com>,
	=?iso-8859-1?Q?P=E9ter_B=E1tori?= <batori.peter@gmail.com>,
	Mael Bras <mael.bras.ext@idnow.io>, tycho673 <tycho673@gmail.com>,
	hanta <hantahrabal@disroot.org>, skiwithme <skiwithme@optimum.net>,
	Suvam Sen <suvamsen2004@gmail.com>, Celimar <celimarj@gmail.com>
Subject: [regression 6.1.y] 967473b1e8bb ("Bluetooth: L2CAP: Fix
 slab-use-after-free Read in l2cap_send_cmd") causes backtraces and
 non-working bluetooth
Message-ID: <179567271700.947722.15185762256491350563@eldamar.lan>
Mail-Followup-To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Edward Adam Davis <eadavis@qq.com>, Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org,
	"W. John White" <whitewj-debian-bugreport@outlook.com>,
	=?iso-8859-1?Q?P=E9ter_B=E1tori?= <batori.peter@gmail.com>,
	Mael Bras <mael.bras.ext@idnow.io>, tycho673 <tycho673@gmail.com>,
	hanta <hantahrabal@disroot.org>, skiwithme <skiwithme@optimum.net>,
	Suvam Sen <suvamsen2004@gmail.com>, Celimar <celimarj@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Control: forwarded -1 https://lore.kernel.org/regressions/179567271700.947722.15185762256491350563@eldamar.lan

Hi

In Debian we got a series of regression reports with after updating
the 6.1.y kernel to 6.1.192, the bugreports are bit hard to follow to
the amount of people contributing, they are right now:

https://bugs.debian.org/1154123
https://bugs.debian.org/1154206
https://bugs.debian.org/1154212
https://bugs.debian.org/1154648
https://bugs.debian.org/1154673
https://bugs.debian.org/1154866
https://bugs.debian.org/1154879
https://bugs.debian.org/1155192

The issue appers to be introduced by the backport of b4f82f9ed43a
("Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd")
to 6.1.y which landed at 967473b1e8bb6d941e034ec1f76de40ccf54a8cf. The
backtrace shown is involving:

[   40.687744] list_del corruption, ffff8a27c10efe80->prev is LIST_POISON2 (dead000000000122)
[   40.687829] kernel BUG at lib/list_debug.c:56!
[   40.687865] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   40.687900] CPU: 2 PID: 893 Comm: bluetoothd Kdump: loaded Tainted: G           I        6.1.0-55-amd64 #1  Debian 6.1.192-1
[   40.687960] Hardware name: /NUC6i7KYB, BIOS KYSKLi70.86A.0051.2018.0110.1800 01/10/2018
[   40.688002] RIP: 0010:__list_del_entry_valid.cold+0x4b/0x6f
[   40.688574] Call Trace:
[   40.688594]  <TASK>
[   40.688614]  hci_chan_del+0x18/0x90 [bluetooth]
[   40.688745]  l2cap_chan_put+0x106/0x130 [bluetooth]
[   40.688890]  l2cap_sock_release+0xca/0x100 [bluetooth]
[   40.689038]  __sock_release+0x3a/0xb0
[   40.689070]  sock_close+0x11/0x20
[   40.689096]  __fput+0x90/0x250
[   40.689124]  task_work_run+0x56/0x90
[   40.689154]  exit_to_user_mode_prepare+0x23d/0x240
[   40.689191]  syscall_exit_to_user_mode+0x17/0x40
[   40.689226]  do_syscall_64+0x69/0xb0
[   40.689452]  entry_SYSCALL_64_after_hwframe+0x6e/0xdb
[   40.689845]  </TASK>

But reverting the commit does not immediately seem to be an option as
this is as well the fix for CVE-2025-21969. Is there something broken
in the backport or a missing requisite?

Regards,
Salvatore
