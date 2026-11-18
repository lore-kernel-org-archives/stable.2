Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995186;
	b=khmVDfKDuQCuT5t6Q7+rAc3G3pNQp8uBIzCudsbpSmv+cwTzQoH3Ahw85zKa9lvDg83d
	 exyE+LoQq8hLkTpQfOUstVdCTjZL9SFc3vYo6Gu/DlHZNVBo0Q3fTlRCkpP+AHzODNFzB
	 k3nhYQuV00sc551zholk7BLfbmxSI0PH6Z5rNtcm91iv6RvXKoqtjf/Obs8T7Ah3Xwm+S
	 QTHB7rBae25jZzD8RW4BrR9nqDnaYnv9HpwDL/ez/comY4EI+8PdqGtSJjZK+xEsnhR6G
	 /WL/ZrFdMZZUQM1eVw5ps4cKaLEb0DgDeCQktOxl91GnWNeUNlMZDsjW8TOFzZ/LtfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995186;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wt8+KMB765b7GYSUtiacsq5XR7qsSeCZZHAe4LgX0wM=;
	b=kI2XQmoSn8WaiGmGxbu0/DIEX/IfMsKpXoESv4m12QNTvFSVAqsMRflukLwUWXkYcKsV
	 NL/vZoeXrE2TidDaAvuUarKY5QwwHAUkK370lGMiBStyRVP6qyV9W9ghWZvniRoV9rgRE
	 wUYXoTafpzM4nAxXzDojbZP1cJpCbr0s3CZO/U3o2TGzMBjrUNhTGTWjBTxGv13IQTdob
	 ckZ03s+mFKG5ntN5qAvPt6fM9KgZ78ofWgwHsbBdoDw+vUhPk8094DicFozy8UZ2LlnAD
	 4yFFWafkrs3kVNTRqQv9T99njwsRWvMit53efH49LBU9GGxKYgp/r+AXkM0oDwaqDAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mzVG4ECt;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7A606A31C;
	Wed, 18 Nov 2026 09:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mzVG4ECt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mzVG4ECtWyqsSqZjE2nIz3CBjNgp7RutH/lpkQQroferzMZWFAMw6T5cMqrhD3fk0g0K20hd4TAVw
	 yupRoh0vprSE/0Clm9dzkZer8WGOjd8A9TAI4EVheoE/rMpxkyKz7WhliUe91P30B8CVZAfnXa2Og6
	 PPW/DD4brO3Ltz7A=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56afd73e9c4d-10772;
	Wed, 18 Nov 2026 17:46:22 +0800 (CST)
X-RM-TRANSID:2ee56afd73e9c4d-10772
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66afd73eb0b5-d28a3;
	Wed, 18 Nov 2026 17:46:22 +0800 (CST)
X-RM-TRANSID:2ee66afd73eb0b5-d28a3
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: tglx@kernel.org
Cc: frederic@kernel.org,
	brauner@kernel.org,
	john.stultz@linaro.org,
	toddpoynor@google.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] fs/timerfd: fix stale remaining time after disarming an alarm timerfd
Date: Wed, 18 Nov 2026 17:46:12 +0800
Message-ID: <20261118094613.1799-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

timerfd_setup() reinitializes the timer on every timerfd_settime()
invocation.  For the hrtimer based clockids this goes through
hrtimer_setup(), which zeroes the whole hrtimer including the expiry
time which is stored in the embedded timerqueue node.

For the alarm based clockids (CLOCK_REALTIME_ALARM and
CLOCK_BOOTTIME_ALARM) timerfd_setup() uses alarm_init(), which only
reinitializes the timerqueue node linkage and the alarm state.  The
expiry time, which alarm_start_timer() stores in alarm->node.expires,
survives that reinitialization.

As a consequence, disarming an alarm timerfd with timerfd_settime()
and an all zero it_value leaves the expiry time of the previous
arming in place.  The remaining time of a timerfd is reported by
timerfd_gettime(), by the old_value copyout of a subsequent
timerfd_settime() and by the fdinfo file.  A disarmed alarm timerfd
therefore keeps reporting a non-zero it_value until the stale expiry
time has passed, while the hrtimer based clockids correctly report
zero as required by POSIX.

Reset the expiry time when disarming an alarm based timerfd, which
matches what the memset() in hrtimer_setup() establishes for the
hrtimer based clockids.

Fixes: 11ffa9d6065f ("timerfd: Add alarm timers")
Cc: Todd Poynor <toddpoynor@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 fs/timerfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index fe845af0b74e..d7cc704e4afa 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -247,6 +247,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 			   ctx->clockid == CLOCK_REALTIME_ALARM ?
 			   ALARM_REALTIME : ALARM_BOOTTIME,
 			   timerfd_alarmproc);
+		if (!texp)
+			ctx->t.alarm.node.expires = 0;
 	} else {
 		hrtimer_setup(&ctx->t.tmr, timerfd_tmrproc, clockid, htmode);
 	}
-- 
2.33.0



