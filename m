Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1DA4E3252
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408519; cv=none; b=H+5y6pd3Wlvz+xyT0uOUwZd+WU3IXkuWeyaUbyGX5Iqy5XoKqHJc44/V+57xAFL35ZkC3b/IomlrG70cLVL1VTcW5ZHjf8IiHLZQw1WH3hdrzscBx0T3sokf+K54Qru6+xh4dvCofokVpzc+3BVKuc0PnHVSM0wikdmJ58V+izA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408519; c=relaxed/simple;
	bh=n4FqSLmVAEsXOHXlDEkGaq3c/eruqmAn//5DvPsyRXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fS453HmZZMreA5rWh/5xjJsBxQQFQ8SJdhNbsassGDSGEWIcBiD5YQjd3DBWUk9JV4QYnuHYyS9bppbZU57HEheMG5F6zTzJ4vXOVtLt6Qd3etQCwgb954nmJQU2jcYu93lMybTb/KA8T6njzC1adt95gd47v5baPRH/NAqAN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1814701a91.3
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 04:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408516; x=1793013316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=59Dzn78qm0Ddey/ClDGdUsV3GOFiBhJV+gV58rFFcGc=;
        b=2Qiif42NI5TpN+zZqix0JFbHEFGmsnMkemQd0i7sgCVOFLk30iqO9WuGyCYsKq1/hT
         fnRMb+cEVnkLWVtpf6DULLAI79ktFY1M6nfRb32OBmBmP+g0U7DyjBlP7dT/M5kukAYv
         vrvvGBiYrbX3wGcNTQvynTSVbtkLy9IWAG0B9asP7dN60hBwj8CCpfZjTru56vqI0LkH
         ajjhJXOV9bjS8TYLPYAgTuXFVCQWIzgf9hEm2mjzg7y86DovWPr7nMd1nGuqGV+xViSl
         sUdw1mXhYomum2o3tPruAQQR4SpWxkDBEMe5m0l8JcH3Xa1b24UwhSYMxpBi/3xMxqWG
         wQgg==
X-Forwarded-Encrypted: i=1; AKwUvBxSkg9hh1X/yh3H69K01xnZFqUBnRmeh1B1QzLJO/MEa1OxGise2RWbNa15XS9kyu8cEXszB+Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWGPxgFqC+KCtPj8yLz4NpNmVDMk4bJgyYfeaq5h07+kwEz/DN
	Z9rwpon1lVi7y/qXz98ihzdb/os7ITZAFKTqIOd9CO27vz/ll2mn1R51
X-Gm-Gg: AYBFou0t8pV9WrMThoHjZY7+VFDbxnb/VvP0ig+F3b1SytpbYBuKk2+Cxbif/BHcDZv
	HHmQTWDcFSFzd6Y0c7posQgyIJYhJifv6JT3cADJ7b7BpmzkJh8i3HvVdeF99eFRPTHosot3nzW
	34Kuj8RUqpR+WFu4T3xbcc2EK5bn4DnmSreGTfes3tTI6h8mozH4i/sAERwB4LzeMf5bOHpa/YG
	WK25pvMKNhb4b2XUFW1H7qwV8JwGbB7+w+LYX9dHrF1HJgGGjiR3AEevXmaajtm5OeWOyS67Imj
	Z3TlPqoVVG6q2+EFU5kwSoURgmc9KlRStwDTAXrEJs5gcRnWINp9HqfGhWArYnBq6rTLk98t9vA
	zcfkYl+rtiT40N0mHGMENngIwmar1oALgl4k7eBSi94ZXgzE5G9MhZdhPVqxmwe3Nf0x0//AA3V
	DEp3Eq6pGJtSb/P3rl/hKH6J90gIValIJULt6xzpcHmMML2xnbSqs6w9N7FGpaTBzgSoG638HZq
	E4LNrZMM3gMhfMnBSX6JA==
X-Received: by 2002:a17:90b:2e45:b0:3a6:dc51:cce9 with SMTP id 98e67ed59e1d1-3acef10a75fmr6456476a91.57.1792408515890;
        Mon, 19 Oct 2026 04:15:15 -0700 (PDT)
Received: from localhost.localdomain ([116.162.92.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a3a592sm3907989a12.30.2026.10.19.04.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:15:15 -0700 (PDT)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	chris@the-brannons.com,
	kirk@reisers.ca,
	w.d.hubbs@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] speakup: Do not hold spk_mutex across catch_up()
Date: Mon, 19 Oct 2026 19:15:05 +0800
Message-Id: <20261019111505.2048-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <atUPbjRxDtzBZ4Vc@end>
References: <atUPbjRxDtzBZ4Vc@end>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Samuel,

Thanks for reviewing the series.

You asked whether the blocking this patch removes is really a problem,
since an operator who loads/unloads/switches a synth knows speech is
being played and can stop it first.  The report that motivated this
series is a case where that cannot happen: it comes from automated
module load/unload testing on arm64 boards that have a serial port but
no synthesizer attached.  The sequence is:

    modprobe speakup
    modprobe speakup_acntsa
    modprobe -r speakup_acntsa

speakup_acntsa attaches to the serial port and becomes the active
synth, but nothing on the other end of the port consumes the output,
so the tty write never makes progress and catch_up() keeps looping
while holding spk_mutex.  modprobe -r never returns - the original
report is a hung task warning on a stock 6.6 distro kernel.  The trace
below is from a qemu reproduction of the same sequence with the serial
port backpressured:

    INFO: task rmmod:84 blocked for more than 10 seconds.
    task:rmmod   state:D
    Call Trace:
     __mutex_lock
     synth_remove+0x16/0x60 [speakup]
     __x64_sys_delete_module

    INFO: task rmmod:84 is blocked on a mutex likely owned by task speakup:76.
    task:speakup   state:S
    Call Trace:
     schedule_timeout
     _spk_do_catch_up+0x1d4/0x2d0 [speakup]
     speakup_thread+0xd6/0x240 [speakup]
    locks held by speakup/76:
     #0: (spk_mutex){+.+.}, at: speakup_thread+0x1b8/0x240 [speakup]

There is nobody at these machines to stop speech first: they are
headless test boxes, and no speech is being produced at all - there is
no synthesizer connected, the port simply never drains.  The same
mutex hold also blocks loading another synth module (synth_add) and
any synth switch, which is how the load-side variant of the test hangs
as well.

The "stop it manually first" route itself hangs the same way, because
the synth sysfs store handler takes spk_mutex too:

    echo none > /sys/accessibility/speakup/synth

reproduces the identical D state on the same mutex:

    INFO: task sh:79 is blocked on a mutex likely owned by task speakup:73.
    locks held by sh/79:
     #3: (spk_mutex){+.+.}, at: synth_init+0xab/0xe0 [speakup]

and a task in D state ignores SIGTERM, so even timeout(1) cannot get
the shell back.

Patch 1 alone does not unblock this sequence: it adds the loop exit on
!synth->alive, but in this scenario nothing ever clears synth->alive -
the port stays open, the synth stays alive, its output just never
drains.  It is synth_release() in patch 2 that clears ->alive and
waits for the in-flight catch_up() to leave before releasing the
resources, so the unload terminates the loop instead of waiting for
output that will never complete.  As the cover letter says, patch 1
provides the loop exit, patch 2 provides the deactivation and the
drain.

For real hardware the same holds with a finite per-utterance but
unbounded aggregate wait: /dev/synth accepts arbitrary amounts of text
and with the current code a switch or unload first waits for all
queued text to be spoken.  Patch 2 does not add locking on the read
paths - it drops the mutex from the longest-held path and replaces it
with a catch-up counter plus a drain wait in synth_release(), so the
synth structures stay valid for the whole call without holding
spk_mutex.

Hongyu
