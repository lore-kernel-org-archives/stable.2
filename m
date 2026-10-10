Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930F38A706
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604780; cv=none; b=CzBl4gHBRef5PtKNesuBtvX1OaMAG46ZefxujZB0tO2rjkgMnwuKpRPqt7UYcxC4tOTVJxMBS1D29kgAvbsncdYo/TMM/8ILVVxnGWPoXN8qrlkUTkulWoVkj5669qSXnHfvMT/v1G1AXJoEkZJmSTIVXFfPnETqYe/+GTodD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604780; c=relaxed/simple;
	bh=9uUi7VJXnnwjCj1byg6atdUf19EY7e7jPvxXvAjDn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o78Wq8gKuiLa0xz10JIa2IadiJU7SE1usEAzjwWQdsZFO+RF5JGlqbLrAprZEOT2DId2ZxpJg6B5t3qVNlPN65lVRuln+LbdsyIyyZmVnP8Z5xx06JjdramFHMxncVD9INL9CFy3LGRMJ85THTsFMjOFFKkzaeLbsZLIh49m2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfu5+dyU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfu5+dyU"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a771ad2a9aso18988451fa.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791604777; x=1792209577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uUi7VJXnnwjCj1byg6atdUf19EY7e7jPvxXvAjDn64=;
        b=sfu5+dyUDHXDvz3azDLkeRnGDawVUJLLtp6CtzXI0ROEBzfQy50IeTJ0XSHo1r6Ygr
         wJU8fypLXpYKd3Dd2y9/JHxzmM7NjULIvA7QzWVLxmjdNIz7vyxjvupPYSM7qAZFVOeF
         yvklmdtsHLR9AGwMC/SfIU5rITyFwFuAeEaBbFLGn7113sbRAvttFIBJ20GCQrDKhueA
         yjCNkjvpNKJ1XNyn2N243Ey8M5Ygu0Wqe5G05g5twflK30ekY70X6C+8w791EgGSSxy1
         Loh3xxi3v+ouwWtc0i9D6JjIQN0N6mDjzgDDL6A4tlk1H8b+OOqTxVhfOAp0TnW+4S/A
         ZLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604777; x=1792209577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uUi7VJXnnwjCj1byg6atdUf19EY7e7jPvxXvAjDn64=;
        b=Hi7hGJHYgqgZ1zOvdjbbxIPIVO0Y9lzkQaT+rSvmDCv3W7wKwaiLheOpf9PAYdme8C
         +83Hu8St2BxQwI3FmOMEH7KQG9tjGYoWY18+moslAIDyjqsNJe2BCctQIRrB1ikfTMWY
         v4dqfCJg1c7BHT+MdfvAk3MH4BjFB0kJ4RFf+1HDFcyfZz3goQBF6KDXW8Q3lf+LhasP
         3J3JLiHDE3EPv2Cr0nHnNA/qxydhJWghrRzJndMikpzMGIkl3EdYrtVYrPIrhCd+jd0g
         XnWl5A6hDrgJMHK4C0XKao/U/XscMPWJ3Jdj0FE08w3lWj6TF7+jLxaK3dwX2/FTRR54
         9F1w==
X-Gm-Message-State: AFq9FYLOtffHb1iq/yx6sROSAOzpwr23xZ+X96FjRbNO23pVaaLVUuZe
	sUUy0CG4R0HHY8SlFaQ1o9asY2lYDVmL0EU+ysk6Bye8nYnxivsbe9Ag
X-Gm-Gg: AYBFou0WQK2Y3rdB/LHBP7dxa7gpqaqdWZBQPs2p2QtQmwWPZSbjS5fVwq4Z4oY0rFS
	3CZ4KiiDiPqLPQddfQ9cMlV7Oi5XdU/TW1uCNYmzFo8tC8sQGjRLS3oBn8TcCKpmgpNr90GRFeD
	ITFPEMKG4oP1lDfoCNmy0GINOW3y2lFfQfToqb3F8dqRy14U8iZwhoWl49bkCpmtz4R/e+8aXWw
	RyuOAyJA3IXli/tidHyhHlYSBWCMmE/wyRHR0QSI5u4ZhRY7gBeDzl5LBlFW0dUsSfC0fnp9EG4
	ywKEwkJHce1xokjSJ28SWV+Z2PkfcrYo5s0W9FbD1sixiwcpsaQFTUsI80Qw+qsZUPML5lNz3VU
	qfhDCgYjJsgxMswOhgNUh2DLk0onm0kfQr8DMeA+vzI4Tt6KgEqwjQc/eYYSXJzKc3BcyLfBwCA
	6yqJCDYwCuo6njTflaiX6AhXaoUpSr79AGubiZTka3zXAK5z2Z++LSOtMeBgeY8bEEBo9sWgfVs
	ZBZ6j9wH7yynmJ1JXJHGGymrznEhAw2kfPieUJ69oU=
X-Received: by 2002:a05:6512:2315:b0:5b8:f955:29e9 with SMTP id 2adb3069b0e04-5bce01aacaemr904126e87.7.1791604776835;
        Fri, 09 Oct 2026 20:59:36 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.131.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde91281sm1164909e87.19.2026.10.09.20.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:59:35 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: Rachel Menge <rachelmenge@linux.microsoft.com>
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Request backport of bf5a54bc0e3d to 6.18.y
Date: Sat, 10 Oct 2026 06:59:27 +0300
Message-ID: <20261010035930.579535-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
References: <899bd843-fd19-418e-8913-91bfb6e760a2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 03:36:42PM -0700, Rachel Menge wrote:
> Please consider applying the following upstream commit to 6.18.y:
>
> bf5a54bc0e3d8962474fcd611f1266eba036232f
> doc/netlink: netlink-raw: Add max check

I see the same on v6.18.55: rt-link-user.h fails since 6.18.53 and
rt-neigh-user.h since 6.18.54, and the in-tree cli.py fails the same
way for both families. With bf5a54bc0e3d on top, make -C tools/net/ynl
passes, and the generated rt-link and rt-neigh code is byte-identical
to a build of the same tree with the two checks hunks dropped.

> I also checked 6.1.y, 6.6.y, 6.12.y, and 6.19.y. Those branches do not
> contain the rt-link.yaml and rt-neigh.yaml checks.max additions that create
> this mismatch, so this request is limited to 6.18.y.

6.12.y is affected too. Since 6.12.111 it carries 45ca9f59b6c7 ("net:
reject oversized tx_queue_len at netlink parse time"), which adds
checks.max to rt_link.yaml (the file name has an underscore there).
6.12.y does not generate C code for netlink-raw specs, so the build is
not affected by this one, but cli.py --spec rt_link.yaml fails with
the same ValidationError.

bf5a54bc0e3d applies to 6.12.y as well. The 6.12.y YNL build has been
broken since 6.12.93 by handshake.yaml, so I sent a 6.12.y series that
fixes that and includes bf5a54bc0e3d:

https://lore.kernel.org/netdev/20261010035116.578385-1-littlesmilingcloud@gmail.com/

One more thing for 6.18.y, not a regression: conntrack.yaml and
nftables.yaml fail the schema check since v6.18 itself ('labels mask'
and 'set id' do not match the attribute name pattern), so cli.py fails
for these two families. Upstream fixed that in 1adc241f3940 ("ynl: fix
schema check errors"), which renames the two attributes to labels-mask
and set-id. It applies cleanly to 6.18.55, and with it and bf5a54bc0e3d
all specs in 6.18.55 pass the schema check. The C build is not affected,
these two families are not generated there.

Tested-by: Anton Danilov <littlesmilingcloud@gmail.com> # v6.18.55

---

Anton Danilov
