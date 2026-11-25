Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645020;
	b=c/6VkBEKrkIADuSKzmydZ4dda3EQ213e75ZIczXAlifePv0m9GEBjAhP2eXs8vKqrXUg
	 wO3O+pZ2ycvFFCAUam+45oIVlVDtw4qQrv/8P47lpX1nlQ0XDcrNANA2HSkTq+b8fXn0s
	 rXJSAlqgXTlrrSRBGQF26o2oY/e6+fDsgQ277zNC5XuUcAsY4EPNFalWuxYJr2jzsrbcy
	 u985Qo6far1349Ax0cG7Hmz//8TPyWZtktyurI98cMLKBtIJjmnE9uhBQmCqXrZ1b62GJ
	 uvbKG/0Xwda4IL1TcqSKsGj9Cl5nMLUckmHBbcBvktwar07gRN1QXRXe8YxqGgpfpOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=81UweMnintdLpa4xhqWOsmoebWo8cnvUdLQSh95F9E8=;
	b=K8FWx61hlJ5DIX3ikNvLHEuogvjDnTtdHMxwc3P87nDy+jJIspE9pPn3n67opzu60H30
	 tlK4vR2hSIso0RWa621I2f/bJqxFlzJaIzBUD6vohVcxLZHsS98aItZgzP4viwgsnyqp4
	 whn0T+AxODZtMdirRAFDkNpvfRTo91NpVID8Pui5JwmZ/88bM76oNUQ6iqOe2gNkCrXeB
	 a9qkaIy61LyxVBlaFdmEzPJZcdeHuUjQx8RJVtcDJPXKx5eImT/h4lAGhDpTPlA6hAZ5b
	 5M7ddkRI/Qf8r4Or8+X/kamjqnkGtvJ7FP4yzGs8kLrceRuIlMVTtlj7qk4tXQuIPuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="C/m8qY2H";
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEB606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47FEB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C/m8qY2H
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3b45597c7so1882594c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645018; x=1796249818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81UweMnintdLpa4xhqWOsmoebWo8cnvUdLQSh95F9E8=;
        b=C/m8qY2HyaEZyw8rv5fW4LH8uDfYlgA4ICxEnS2Q2UnJS4c85gab/ALWXagjK/igjI
         zlLbcVbjx2/gMZt2MyllXmHu9u0NPpPSdWPPfLse8iWgQaKVNyXxfWeGkUxw9zgL/mLH
         oLBtnBV3Ym/xuyZrb0dOU3bqK8U1lPlCud9lXWJYiiRUmnUKf0lV4HmgNeAJzeXEprQE
         4eYHIAtwyoWxnIS3QRdbHtqL4uudJiqeCEG5deuNErvQTRWyZB4me6fqKaJdfVFzZYQA
         D1nUl52DhQWmQ9TXo5hPvkWgi7ttgvxGgCPH1nu7dzQcQ/qnIFuFx2VUFXtwvw1T3AdR
         prDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645018; x=1796249818;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81UweMnintdLpa4xhqWOsmoebWo8cnvUdLQSh95F9E8=;
        b=ydITjqcgXAGq1nRYsFtF4AIwag4esi7yiX4XP5LQMhqerRPO5ymREzkZ6Su7rIPhPH
         o61NaVXgc/2+2nHcEeA10Sw3/8OVC/OjFxTcgW7pL4k7R1jd9zSBSq4GiPFGbd4WfxNo
         o/PZ9QzHpC8p9kf/gmAnSf1o336vs8dlNEFWKWBcghGWp0ejwb1rtVO9cyunN6MGS9uI
         eWdzyNhaa8V6NHtfiYthMq7Fw6LJo2hBthjk+knUCfgC25Bdij5ImzFCLSzWbio+xYSM
         DmUT89zDif7rJLsW4jud6gVRxwrbkEC9S/KoxpAtA9LLoMlIfwDZNum9L0IYvzmfqnyj
         ltTw==
X-Forwarded-Encrypted: i=1; AL+hErERqK0BxxkP/yOqTWnSXVtKk2Z+Hkq5NJQVb1lTReUxbZYFHiQlasJFNv45Li7BG4izuBGSR8s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dxsA96szAncJ0uoEB104sm7ZebMtaNDj7NY7Oyk2W4ozAQKaU
	CInvhyd9CRu4FI0E5x6txvMUNu4MXCINapTQQZycA0zayTUOagW7u4Rgqt6Y9uflz9rrExvsghr
	SVg==
X-Received: from dlbtx1.prod.google.com ([2002:a05:7022:fc01:b0:1a7:58c6:c957])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:231a:b0:1b3:a927:f17a
 with SMTP id a92af1059eb24-1b5567a950fmr17469563c88.5.1795645017932; Wed, 25
 Nov 2026 14:16:57 -0800 (PST)
Date: Wed, 25 Nov 2026 22:16:34 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221635.1419707-1-elkin@google.com>
Subject: [PATCH wireless] rfkill: initialize work items before publishing
 rfkill device
From: Elkin Cruz <elkin@google.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

rfkill_register() added the device to rfkill_list, called device_add(),
and set rfkill->registered = true before initializing poll_work,
uevent_work, and sync_work. Because rfkill_set_states() and
rfkill_set_hw_state_reason() only serialize on rfkill->lock and schedule
uevent_work once rfkill->registered is true, a concurrent state update
can race with INIT_WORK().

Initialize all three work structs prior to publishing the device.

Fixes: 19d337dff95c ("rfkill: rewrite")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 net/rfkill/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 9e143c4bfe6a..071beb249b4c 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1095,6 +1095,10 @@ int __must_check rfkill_register(struct rfkill *rfkill)
 	dev_set_name(dev, "rfkill%lu", rfkill_no);
 	rfkill_no++;
 
+	INIT_DELAYED_WORK(&rfkill->poll_work, rfkill_poll);
+	INIT_WORK(&rfkill->uevent_work, rfkill_uevent_work);
+	INIT_WORK(&rfkill->sync_work, rfkill_sync_work);
+
 	list_add_tail(&rfkill->node, &rfkill_list);
 
 	error = device_add(dev);
@@ -1107,10 +1111,6 @@ int __must_check rfkill_register(struct rfkill *rfkill)
 
 	rfkill->registered = true;
 
-	INIT_DELAYED_WORK(&rfkill->poll_work, rfkill_poll);
-	INIT_WORK(&rfkill->uevent_work, rfkill_uevent_work);
-	INIT_WORK(&rfkill->sync_work, rfkill_sync_work);
-
 	if (rfkill->ops->poll)
 		queue_delayed_work(system_power_efficient_wq,
 			&rfkill->poll_work,
-- 
2.56.1.839.g22a8290db9-goog

