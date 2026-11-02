Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634829;
	b=UGqG84vGK6GvBUj+RCqBfEQwBJC1ilqb4aJ3h4RGjzXWp49/XIBeF3/kTLD/ad77nekP
	 df74Gnt9pgDylpaQH5e0MNnavX97tc7JR6OxvDSd48P0lywMCwrK/stZBLrFgSGSiLzNv
	 XPPYav3RGC2c8RXTbaOywG2kOdnbDbQxIMZ9QfJgGXlNm2J+Ex6Lxs/WoMyzTtWVDelIa
	 5pd+g4v4jdmwol0kFMZYyPEX9t44SZ2aucYcy6s/XXNIAL/KKEeOXSa5GcJL7INNZMHww
	 6SIkjahZRro6nQ5BMpB2x99y2xDJyx9k2iJbgPBpbD88mWx98vBB1uOtYNe4IOymEoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YUOMvaywSnfPxZ52C8XL24limR9Py8D4CfmjHsLDiqQ=;
	b=uYB8GLHtwnkulmmSpjAHP8sFU3NDFyLhbuiwIeOMI/Lmq1cPZxb/2W7REjiQIpNvsjMd
	 kEw1WEvUwqSsRlrRVtspmrMPNdoQEqf2+Dyk1OT7u21hFguRtURfPCvOl16CJDcdyAEY+
	 zYpdWXUykpdIAaqvUuCqd5k0eRkIecOJua02T2m3Ucangd89fksHBU3GEf91T5sd86GZi
	 LpSaO9TbkCTndgHZo26yFCsu+RLBvmAYgJ4K9nWp8h/cbfHC7qiGKNp+lvN6uZpp8Zv1x
	 1a8WMlw+So5RrsJQMx+2sqpovtBWWcMTcIujFC1DZ3khxr/nRKK0GDKqMphJ5DBmeDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMMEAWi8;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654C60B4254
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5654C60B4254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMMEAWi8
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so32614605e9.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634828; x=1794239628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUOMvaywSnfPxZ52C8XL24limR9Py8D4CfmjHsLDiqQ=;
        b=TMMEAWi8OpwvmknuaspJNf3sj1bU7MxlY242AWQesYlBZ/usL9Bywm5GHfkWtMROp5
         ipLMX38R/AKcGuj0K2WC4C16+/gQ1c+Z+MfJMmMoDP6lwF83DKvqMZj8oGVukOHXAb9T
         LkKj8P89txbMlyStiITy99kS2mDCIPnMsQpmvVmMbRMrObp5iYbiqXiSk4ynU9cnbQ7W
         mliwaabz80QqnFNlleAzFQiU5h0QgFTVucVWFHh7DMhecGwrj37bSeXcV+S8oJ9Y8h2E
         lLdrW/bvnvS6QskO7aL1mGOC31H3S+szj6rcqAnu/SR4MdWddbADxqgne0SGVmpKV+sw
         vfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634828; x=1794239628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUOMvaywSnfPxZ52C8XL24limR9Py8D4CfmjHsLDiqQ=;
        b=INoQq63h3QLeILFySq7PKvmK6a0IZ5UJ7RXBYhD6FS8D1nctQEsQEleROSm0gl3OZf
         N1iDXvj68QczsbCnoARoIj4TalDRzHE8TpQ010vHKsoCP+qRAZ1B6i3PqmuEDlu2P2YB
         XnXlF132kK8ONz74nbgisH8Be4EQBVPIMMprJgq0rpxSQ2PMudMa60hplDMHI4Rmj6L6
         2HXCpuadXhi26akXJnNmzBKdPH6XTlZKofy2JHSrHPV44TiDm+lu5IIrRXXuk6WlvZA5
         cNnDTVcZY0Y5Bp6O5DbeKTSLwykQ+4jkcVb7mshhYCxOtFnqOaGEP9Poex+6fBil1BIn
         T2ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxy0RAIqos/u2cd6Vouf1eRWb8VN468SbjC3wQwrmlJODEf55oFWPpnYXSzSipR6zszpVnKAC8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyI1TKdx3wbj5X/c038H4oDY4ww63jmJlidWX9/VeGPEhrHAXZ
	GTP29vdWOUFdW6AC8eMZg1T5PdESBwHV7t5CncjXVLWYCSLgetFLeXQ=
X-Gm-Gg: AYBFou2+/6rensT8CQShIaDhILTTpzEpnA1ib/smYVgPQ9aX1yjPfs0pB/bgrq6Siz7
	UrA3p4YoNzTxbkDVhfjOUF4nH56JHixl4v/np+YBSpGhqRmy/fUDVq+lkuYrPsIn24jBDoLMhfN
	9KLnpdw8K1aMAPncX5mQAShSveXo0tb/IO64vcczkePhzLI2CL+1/5cvryzVg8EcAe7BAxlZaR9
	LHsL/9NfBXF+HW1bDkDClEq6EX9Y6w5cGoxmhqG7ZBiY75wt57TfcN0SfyDNkguePqytslQ+SFi
	7Jc1FhH5QPPn6pt486R6NoAdDOwfd23wC95wSsYJ//fay9DWJtIFzP5bJ+KUrOwWCEX0G3v7Kgs
	S21gucSjEFUj3W5JJe7k7O2Zzb80KVYkeEVlgVq+ZD6ikIgZp3OHv5bIv6APRlBP6zjaUdfthoR
	BGWHbnB43HCZzN/sFT7xjEU5WXa2sHEMtDwE3uLsUIjSQd/hcwVS9hCfOWl6w5n/BnRPdZTuxb+
	PZcZTDj43JboNqrRbaMj3B4JmF4Ri3IbsUYmxY8IDZjF2VyYaMUy02ZFvZKcCwFADFh0bxJ7ddb
	cTb473WzP/c=
X-Received: by 2002:a05:600c:19d2:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4ac1932a12fmr235060725e9.31.1793634827520;
        Mon, 02 Nov 2026 07:53:47 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b286a0sm234689275e9.4.2026.11.02.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:46 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] can: j1939: fix skb refcount underflow in session teardown paths
Date: Mon,  2 Nov 2026 15:53:45 +0000
Message-ID: <20261102155345.1267524-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

j1939_session_destroy() and j1939_session_skb_drop_old() both call
skb_unref() followed by kfree_skb() on session-queued skbs. Since
kfree_skb() already handles the refcount decrement internally via
skb_unref(), the preceding explicit skb_unref() causes a double
decrement, triggering a refcount underflow warning on every session
teardown.

The extra skb_get() reference taken in j1939_session_skb_queue() needs
exactly one corresponding release. kfree_skb() provides that single
release by decrementing the refcount and freeing the skb when it reaches
zero. Remove the redundant skb_unref() calls in both teardown paths.

Fixes: 8c21c54a53ab ("can: j1939: j1939_session_destroy(): fix memory leak of skbs")
Fixes: 2030043e616c ("can: j1939: fix Use-after-Free, hold skb ref while in use")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/can/j1939/transport.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..3173936bd6f6e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -277,11 +277,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 	WARN_ON_ONCE(!list_empty(&session->sk_session_queue_entry));
 	WARN_ON_ONCE(!list_empty(&session->active_session_list_entry));
 
-	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
-		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(skb);
+	while ((skb = skb_dequeue(&session->skb_queue)) != NULL)
 		kfree_skb(skb);
-	}
 	__j1939_session_drop(session);
 	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
 	j1939_priv_put(session->priv);
@@ -342,8 +339,6 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 
 	if ((do_skcb->offset + do_skb->len) < offset_start) {
 		__skb_unlink(do_skb, &session->skb_queue);
-		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(do_skb);
 		spin_unlock_irqrestore(&session->skb_queue.lock, flags);
 
 		kfree_skb(do_skb);
-- 
2.47.3

