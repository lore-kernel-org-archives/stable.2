Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254006;
	b=sERTIqDnWmDoQ7QsAUuIkdX/cyxW2OkYP25QSaqJHHQ3T0D7Slj9x++gyQ/391IFa9sI
	 RRKyyVkaA5uyA+BkkP8+URcuMNCJE14SLZTkH7ZyWPCj63Wr7htap4aq6oQlpghK7k4TU
	 vuA7EHO/FZ4IqORwj9oUHgFxSTVB0MkPhsjg+VvsdTDapukRTEkzBFQZ/ATfcj2iSgHsb
	 f1xP+fWULpifETseRZBQCkeNxNseaUhrV2gIH7vl+/WUFua+2ASDfjP3dLcJ5djqgK/uL
	 5ndM/XHwZ4T+Yiz40eZCnv4UHpIU03ol+wQAsYTCP95VGi2xghGAOxsY86lAlD4rv/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254006;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=vSsVdXM5tCjL6k2PQkUsIrhN3dfbYKeZy3Yvzdarmw8=;
	b=SZlCQLn3jQLVwUWXhhcHfV5gpMU/hhm1q34DhO7mqLRLQ/YlX0OkQ4PFw9hKuYtqveTf
	 fpYAY+k2jVKLYTEihTlcjdxUr+JT0WKcRUp8P1Qvv1stB+PekuPxIxXHQx0WdErdrSRWK
	 pEL1i8wy2JmKTv6BfNy0FiKGl2pNovrY14kw1Cf1HE+vqGEkNTDTjc2ad7/2MzucJuaIL
	 MeZJ4yH7Svm3d6G2C0geOfP+3xfHVyTc/Bp5uTaxa/UhJK7kXgWf0Q7t+FSRix5GzEGQI
	 8DwMpKzEiE4B4FHIFwjcZIIKC1WOhdRONvOAst40Jv9WRUpc/nqCrfJPlUhc3566nGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VmozdI8c;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RrNsVDWx;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE37606A33C;
	Mon,  9 Nov 2026 19:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE37606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=VmozdI8c;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RrNsVDWx
Date: Mon, 09 Nov 2026 19:53:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794254004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSsVdXM5tCjL6k2PQkUsIrhN3dfbYKeZy3Yvzdarmw8=;
	b=VmozdI8c6l8UMk2FZZ5rDiAZKLqa4AD5Kd/MHPh9pOQaz4/JMQBOFTEKp6fee6A33Blu5N
	MlyEgS1XZ5mr40ni429HWS/VyIWWyd2kNReFBj0DRvcX3VVcG0btk5pxCHXn9+LMuruqX6
	AsOCYJoZjSBtowXg2n5Eh2HXIuKl0acG/c2ZZt15raitSMgG3CLwxD4BkOlpmsL9cEiy1a
	ko8FQ2kcUlSKXq7bqMELVrr9IZIMi85f4jWn4xyYW9fXNWwXzEi/tWyrk/B0H+QZiYkBN+
	Y7AJP8Bpx8/VTjShK6aWUuAHLuHp3ViI7Tq50QfMW4XcYWE6QlVCE4GUrukrbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794254004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSsVdXM5tCjL6k2PQkUsIrhN3dfbYKeZy3Yvzdarmw8=;
	b=RrNsVDWxyDxfXWosTvG+A2CEveMVT4svkrxTUUoB6q2WLHY7dfgfpxyYTE66xglWuHJEht
	Cojjs9eMIxVkxCAA==
From: "tip-bot2 for Shashank Mohan Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Reset the expiry time in alarm_init()
Cc: Shashank Mohan Jain <jain.sm@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261011051943.60520-2-jain.sm@gmail.com>
References: <20261011051943.60520-2-jain.sm@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179425400222.2093942.1482260333209583249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f73d1938c4415619f980328f401f7215436221df
Gitweb:        https://git.kernel.org/tip/f73d1938c4415619f980328f401f7215436=
221df
Author:        Shashank Mohan Jain <jain.sm@gmail.com>
AuthorDate:    Sun, 11 Oct 2026 10:49:41 +05:30
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 09 Nov 2026 20:50:03 +01:00

alarmtimer: Reset the expiry time in alarm_init()

timerfd_gettime() on a CLOCK_REALTIME_ALARM or CLOCK_BOOTTIME_ALARM
timerfd keeps reporting the remaining time of the previous setting
after the timer has been disarmed:

	struct itimerspec arm =3D { .it_value.tv_sec =3D 100 };
	struct itimerspec disarm =3D { }, cur;

	fd =3D timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
	timerfd_settime(fd, 0, &arm, NULL);
	timerfd_settime(fd, 0, &disarm, NULL);
	timerfd_gettime(fd, &cur);

leaves 99.99... seconds in cur.it_value, and the value counts down
until the old expiry time has passed. The same value is returned as
old_value by the next timerfd_settime() and shown as it_value in
/proc/<pid>/fdinfo/<fd>. A zero it_value is how timerfd_gettime()
tells user space that a timer is disarmed, and the timerfds on the
hrtimer based clocks report zero here.

timerfd_setup() initializes the timer again on every
timerfd_settime(). For the hrtimer based clocks hrtimer_setup() clears
the expiry time, so timerfd_get_remaining() finds an expiry time in
the past for a disarmed timer and returns 0. alarm_init() does not
touch alarm->node.expires, timerqueue_init() only clears the rbtree
node, and alarm_expires_remaining() computes the remaining time from
the expiry time of the previous setting.

Reset the expiry time in alarm_init(), like hrtimer_setup() does for
a hrtimer. The other callers of alarm_init() start the alarm, which
sets the expiry time, before anything reads it.

Tested in qemu with a program doing the above for both alarm clocks
(the VM has an RTC, which timerfd does not need for these clocks):
it_value, old_value and fdinfo are zero after the disarm with this
change.

Fixes: 11ffa9d6065f ("timerfd: Add alarm timers")
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261011051943.60520-2-jain.sm@gmail.com
---
 kernel/time/alarmtimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index ea5be58..d6dc6e8 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -316,6 +316,7 @@ __alarm_init(struct alarm *alarm, enum alarmtimer_type ty=
pe,
 	     void (*function)(struct alarm *, ktime_t))
 {
 	timerqueue_init(&alarm->node);
+	alarm->node.expires =3D 0;
 	alarm->function =3D function;
 	alarm->type =3D type;
 	alarm->state =3D ALARMTIMER_STATE_INACTIVE;
