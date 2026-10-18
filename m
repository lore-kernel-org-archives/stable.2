Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20110392C20
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336428; cv=none; b=sqch6doAzI/gGgvgKDj8EQTBJY2J2tpLg3Ij362YX3XFnxLSt7I3UftJoOV2miAPJ2OhUhUkgf7WZuA+6a6wVcCj8xcw7NsGMS29GOQsfMF2x6sBLxvY6026No3QiYJxPQmLeH7XIYqj0lqFhqS+5WRkIdkFyyRRUfU44uaUAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336428; c=relaxed/simple;
	bh=S+/0tcEKKdrXeIQTgc8jjWpMxaWk3VsQ3zD2AttTCIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2L4BkvVJmno0fSDAe/W61t0dQprUTPWMpUGI9Ydjl1kE/+ltAzFiSZQJaHO5Ee2arnKB1qJ5FoUIMIS935LUGRkKnyyl8M2fJ8xSFF99GW6TDNyUUXbvZRpXBb9hAFEF3+b3TtqB+t3IKLpZm/5iHirgu/8uP8pNr0fhcC1/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssg5gPvH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssg5gPvH"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1068143a12.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336426; x=1792941226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w07ISDjcbJ69iMy+sD/nm3wBXdPIm8JCD28Dr+Nv/oM=;
        b=ssg5gPvH0+++bq5RaJU7eI1WTIg3zkLK/h9Jrdk4GoCdMrpgXNQe3jYK/KPfwhXJpp
         4xJ0KGp6BtFPweh107iDaQp69xtORq/7U1Rd3Y/YuUaT16xBKtnQID1uCOk1ApcWeSP2
         OPS+TUfZ/LtEI4NHeKxjWZoISeWqKNyr0zfIYPLVXtlRDTDzMN7nLZ04/ljT2+6zPGsO
         bshNGkTXPFAUC0eVeobmIAgmIgYTILUvMM2Z6OTEd4Pl3oMxSEK1U4C5eTwROKeWW6ET
         fphqNc5SxxTQqbWyx1DbKndSTbj8hxJ7oowuovvfI+0LCtUCOd0+5SVHIXcojI3OI2EA
         8lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336426; x=1792941226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w07ISDjcbJ69iMy+sD/nm3wBXdPIm8JCD28Dr+Nv/oM=;
        b=kOxadCXxlRtJ61KJ6J4/HUUbsF8RSWC23vy/ntf5cyizJVbIS5Kq811o+HmZ6+D3qS
         UYDBodFrOBjSDXARX+Yz+B7dxPKQNrV9E1qA2DR/ipZadiQaLGbxVLQ4BL2p/NZQexiW
         qApCK1fjBX1tedg6Xxhb6tgpDeSsf1L5S/YkF6gV4zKadpz4f1PUcW1SFAOsY6ucMIDa
         2aRQ2QBWpt6hiEJ08YgK8iLm/C4jACcZrZyt5Wa+UIrADdqATd60JXpRJqEEoLN0kzTV
         JIfwmJcdbI+kn78K78+gEVWgyEL0CVVQtfA0UOtBUtgowuaiHrV/HqpSG8Y9sLTSUW5x
         XWzw==
X-Forwarded-Encrypted: i=1; AKwUvBxIEWnVGQS3oa4+t6OQksbd7B1IPvbqc2+DcHaZ6puRQ+8Z5X2kfcvQk5ml+Oy0xzSmbmblTpI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu47Ew2cwJfqtqYBi4/DsRBmcmkZx65DfBS4GnQuIzOkK0XHYY
	0I8s9dqHYS1+1o0bPL/SjlXLD/YSp4a1tc1aYI+uPZhL6hKVtmhTngIZ
X-Gm-Gg: AYBFou0xv93Aiu8oTAurxUKuWIVPttgjEMfG+xBROuevf1O0NLZOVds8DH/l5pi14mV
	uNyrvQfVgJNDWyRcvh1b6ZOfFrYHcO0KtecvyrmCx/uMG2AVXLPQiQU+zlHPKrUT+tjtdgWg4FH
	6IS6wAr93EphQOHYiuWIVTyl0BiFFBBNpYwg6fUuN1vy9FyBEeBclSZKxnc72K8MUpzgajaOZ7h
	dUwJWKmiIWhP35g0FgS0nxxfrxVW6+JRB4AS83FOSX/aTNoGxR3jVu1hzKvRo8Du1uj9PKfX7Hv
	AZEMqYZuLkbL0DTZege0N6tkomj3Ocdj7BVvz/XPIoVH+0fpmz2PIzLdgd4fKdouJNpVelVloyz
	XirN8VW5Ou3b6qbchJWYZHwHqUus+Rb7nSQ5tbjrJx+j27LcPwzqXlolNLtHyCGfZMa4bFKzgXO
	lXCLzVog8NcgpzupGslnBTRRJqd6f/qFZShTx8QeXo8NuzO7PR3QCIZtOodsL5XCbnp06iCA==
X-Received: by 2002:a17:90b:1c8d:b0:3a4:7195:ecba with SMTP id 98e67ed59e1d1-3acef13e5e4mr3123588a91.20.1792336426423;
        Sun, 18 Oct 2026 08:13:46 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7aa0:50::245:a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm16878400a91.0.2026.10.18.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:13:45 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	stable@vger.kernel.org,
	syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com
Subject: [PATCH v2] greybus: operation: arm the timeout timer before sending the request
Date: Sun, 18 Oct 2026 22:13:40 +0700
Message-ID: <20261018151340.62626-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gb_operation_request_send() sends the request message and only then arms
the operation timer. The host driver can complete the operation before
add_timer() runs, e.g. when the transfer fails right away. The completion
work then calls timer_delete_sync() on a timer that is not armed yet,
the synchronous caller wakes up and drops the last reference, and
the operation is freed while the timer is still pending:

  ODEBUG: free active (active state 0) object type: timer_list
          hint: gb_operation_timeout+0x0/0xc0
  WARNING: lib/debugobjects.c:629 at debug_print_object+0x198/0x2b0
   kmem_cache_free+0xfd/0x6d0
   gb_operation_sync_timeout+0x1c7/0x270
   gb_svc_process_deferred_request+0x5f3/0x1150

Arm the timer before the message is sent. If sending fails, delete the
timer again. If it has already fired, its work is queued and drops the
active and operation references itself, so the error path must not drop
them a second time.

Fixes: dbec27298b0d ("staging: greybus: operation: add generic timeout support")
Cc: stable@vger.kernel.org
Reported-by: syzbot+a2e50fb40695811c2dab@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a2e50fb40695811c2dab
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2: drop the now-unused err_put_active label (-Wunused-label, reported by the
    kernel test robot). The error path still falls through to it, so the
    behaviour is unchanged.

 drivers/greybus/operation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 7e12ffb2dd60..968a4da5d1d4 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -766,18 +766,22 @@ int gb_operation_request_send(struct gb_operation *operation,
 	if (ret)
 		goto err_put;
 
-	ret = gb_message_send(operation->request, gfp);
-	if (ret)
-		goto err_put_active;
-
+	/* Arm before sending, as the response may complete the operation at once. */
 	if (timeout) {
 		operation->timer.expires = jiffies + msecs_to_jiffies(timeout);
 		add_timer(&operation->timer);
 	}
 
+	ret = gb_message_send(operation->request, gfp);
+	if (ret)
+		goto err_del_timer;
+
 	return 0;
 
-err_put_active:
+err_del_timer:
+	/* A timer that already fired has queued work which drops our references. */
+	if (timeout && !timer_delete_sync(&operation->timer))
+		return ret;
 	gb_operation_put_active(operation);
 err_put:
 	gb_operation_put(operation);
-- 
2.43.0

