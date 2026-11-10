Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294830;
	b=yEDD7kkxE1K0kzv388qgwMqjSzf3U5I7mzEWpZITSO/wh1Dzrjty7zb7bJAuvSv7enEr
	 4FmLuEMKqsdLGubGGuWmBu/57SoqaxTJWVpwzH/mLZ1+aZNmCN5rfFvuciMVH9U82O4uZ
	 Zthj/ilVrmY+bJ668uhAdsSNdpC3Qlo43GgwbsDpx9KaNSIX/+1DMoj0ztk3oVUK4bwsw
	 OwNwMDwoIdHvHJV/tpq9Ut1qj5KJP7t30ViEcFmunEMcdb0+VA98q+8SpWjTcLNPbCk8r
	 M/kQ/ZnJ++/gHgGBtAsS5eoL3646hVEare05p8QtLzubzKr+r7gtvEIP1qUt+VRiBgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294830;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SDBSF1CPeygm0VdecI9guopnBcw61ly6rjuYP2l/6b4=;
	b=u2lDfFZY8Ix6Fjo3MsSZk1JsqHMtLjREYVU94WJVvxhmQJQS+cGhxjA5ta3wYVu8fD7o
	 XfhW74K9aL+UIL7Bgt1Iw3+RcAAoF7lbmaSURqCIEHMlPR5pdDWxn+PumEjjpItHqqC4M
	 uE5ZyRqPEI7vdg3vbc1qAa6rOuSvd0HhS3WHCgurs5mAdrBRRrT3Njdq9elprrmIiRy84
	 AILE4OKgDrpRJhM5dElbh3hMSOvXGOkgmZ0/d/6DkQ6B3qqlmtwhfFDW260ts1maTLIut
	 SOkA/aXsNo+1GRzn2uKlF7na3w81bUhZ5inMCsniT2nQiD14exWqDkgL52DtBR6tH2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2T+UH8i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAE606A31C;
	Tue, 10 Nov 2026 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2T+UH8i
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294829;
	b=wfJOruME3eAuQjTlRp+QD43tR8O4SXp8KN/YAR1HpFjpZUBZ6z54LjcZoaZe/U+04/Ex
	 t80yZ4kKYxVvu5ZXwK6ed5qpNFzPAIoMI72k8bFSoudjmgU7+G1iFQxi2AfpdzP3VIfyy
	 3ep9mIEqEpJ92B+Ol1F0MvLm8q4ztF3bVtLbUDI64qHOojrS8lBUdLlCDt2xS7gL2CbV0
	 xCDLElER/pmVtBhNwtL5A2G761W84gC24WmU4LZgPlgBuuqkkvXbNiCCBBx+zfEJ7H6yP
	 aag3Emwma6y8apVl1MACv1JrGw695HaoRFyKl/pwRfPMd3DyoDSMINrs9suuNPcm1AQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294829;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SDBSF1CPeygm0VdecI9guopnBcw61ly6rjuYP2l/6b4=;
	b=e7Xv3WWfijGO0TC4OPHA7VCC8LcLlpgkHirsjyTLw3jTvVmxyeo2CAJE77kHL8tg44Gt
	 rTMi/5BsSlX4ErC/ed3WLMMCwTJuIeiBsWG68XnNwoE/2KBl/FlFLQ21/O02gJPZTbk9l
	 U+EjQ8xLytBkooR+IKmIdIIOQ9XDBrHkzgjvn8WgUvYb7JxMIwBNg70f9/FHwJ0S4lyTw
	 wJpcXhLcTgCk4G9NRma0/Led0uPZeTVPsGyBzGmKrmA6cOlAOPJPlFiMflSwtoDDddS15
	 GEqauHQ+cHcBGpJlrww/N8N35CssF6PoA7Tz79Kv3N3Qez0wRQa04XQktFRCXshvRZw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3227C1F008A2;
	Tue, 10 Nov 2026 07:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294829;
	bh=SDBSF1CPeygm0VdecI9guopnBcw61ly6rjuYP2l/6b4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=a2T+UH8igbONT9THktJjVMmWqd5md7tj8RDkHrejbwHuZenxEhXZsO6HIVsj3sYpN
	 ZBQJBis/iYEpnWf2YhKlOWDIaOZZjPE6AE1auQW8PdqUOqIV5Fh6oBKpLG+3XCT/O2
	 N23mpDNSItIhr42k6fXNjMvjKBHYtW7djsu6Cl/NNO+HaiOl/ROhCMbLGvqGTZJVXO
	 KGltMWA5v99YFJwRFTvDMFtMQieutD2lN6sayxAWRWmauNLxp9cu2OrWo15nD6jrDw
	 0BSeZ/8txSvt7TOxsYFLYP1/J8yZvWw6+FdnGt8pZBISOHlg/9ATEQECxFynUZv4Vv
	 UFsCSbL+NoQ3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A53EA488E6;
	Tue, 10 Nov 2026 07:13:46 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:13:47 +0000
Subject: [PATCH] rtc: Don't lose a minute-resolution alarm that rounds down
 into the past
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-rtc-minute-alarm-v1-1-be9d7c5227a1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1wUhD1KsVFTEY7RdMyiVIQ7
 26qy7f4f4fIKhyhK3ZQ3iTKJ2RQWYB72TAxis8GU5maiCrU5HCRsCZGO1tdkHxjx7ZuWm8ekLO
 v8ii/a/nsb8d1eLNL/w8cxwmebj5FdAAAAA==
X-Change-ID: 20261110-rtc-minute-alarm-1d8af9689d23
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294826; l=3842;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=hx7EEY3IfQIk7dUR86H3++IsY8ALA3UcN3TSCzhHjd0=;
 b=jsAqaqf+rioQFbEmgC1MQTpbqOEw0nvDj0vKgQlAUhFxbXy8FVL42jE+0/0dIMuRh6fr1HkQO
 am01n5PFKwOBB5dwYkgDj/243VL/DH6EvsecEk05+o3OeEOoJZMcA9t
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

For an RTC with RTC_FEATURE_ALARM_RES_MINUTE, rtc_set_alarm() rounds the
alarm down to the start of its minute, so that it never fires late. When
the alarm is less than a minute away and in the same minute as the
current time, the rounded time is already in the past.
rtc_timer_enqueue() then gets -ETIME from __rtc_set_alarm() and expires
the timer from the irq work right away, and the hardware alarm is never
armed.

That loses every short wake alarm. With a HYM8563, which has minute
resolution, "rtcwake -m freeze -s 15" sets an alarm that expires in
software before the system suspends, so nothing wakes it: with the
alarm set at 17:55:00 for 17:55:17, /proc/driver/rtc reads back
"alrm_time: 17:55:00, alarm_IRQ: no", and the system stays in
suspend-to-idle until something else wakes it.

Round the alarm up to the next minute when rounding down would put an
alarm that is still in the future into the past. It then fires at most
59 seconds late instead of never. Alarms that are already in the past,
or that round down to a time still in the future, are handled as before.

Fixes: d87f741dddab ("rtc: handle alarms with a minute resolution")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on an Orange Pi 5 (RK3588S) with a HYM8563: "rtcwake -m no -s 15"
now reads back the alarm at the next full minute with "alarm_IRQ: yes",
and 47 consecutive "rtcwake -m freeze -s 15" cycles all woke from the
RTC interrupt. Before the fix the alarm was lost whenever the 15 s
stayed inside the current minute, and the system never woke.

This patch was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit message, and I reviewed and tested it
as described above.
---
 drivers/rtc/interface.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 96626f8068f9..004819c9a846 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -535,18 +535,39 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		rtc_timer_remove(rtc, &rtc->aie_timer);
 
 	alarm_time = rtc_tm_to_ktime(alarm->time);
-	/*
-	 * Round down so we never miss a deadline, checking for past deadline is
-	 * done in __rtc_set_alarm
-	 */
-	if (test_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features))
-		alarm_time = ktime_sub_ns(alarm_time, (u64)alarm->time.tm_sec * NSEC_PER_SEC);
+	if (test_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features) &&
+	    alarm->time.tm_sec) {
+		ktime_t down = ktime_sub_ns(alarm_time,
+					    (u64)alarm->time.tm_sec * NSEC_PER_SEC);
+		struct rtc_time tm;
+		ktime_t now;
+
+		err = __rtc_read_time(rtc, &tm);
+		if (err)
+			goto unlock;
+		now = rtc_tm_to_ktime(tm);
+
+		/*
+		 * Round down so we never miss a deadline. If that puts an alarm
+		 * that is still in the future into the past, the timer would
+		 * expire right away and the hardware alarm would never be
+		 * armed: whoever relies on it, e.g. to wake the system from
+		 * suspend, would wait forever. Round up to the next minute
+		 * instead. An alarm already in the past is left alone, it is
+		 * handled by __rtc_set_alarm.
+		 */
+		if (ktime_after(down, now) || !ktime_after(alarm_time, now))
+			alarm_time = down;
+		else
+			alarm_time = ktime_add_ns(down, 60 * NSEC_PER_SEC);
+	}
 
 	rtc->aie_timer.node.expires = alarm_time;
 	rtc->aie_timer.period = 0;
 	if (alarm->enabled)
 		err = rtc_timer_enqueue(rtc, &rtc->aie_timer);
 
+unlock:
 	mutex_unlock(&rtc->ops_lock);
 
 	return err;

---
base-commit: 7485659ecb81d5fce3a3edf2cae9fcb29c17b1cd
change-id: 20261110-rtc-minute-alarm-1d8af9689d23

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


