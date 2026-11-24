Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542193;
	b=Qe74rGOt7eaA6gkQcPz7kBJqc3adoQUPzeJyzCrU6wZYl6yXqQJO/SZduGuBXsz9pXd/
	 Wne7sVbCEUvFQvVyzrXSM2eOP3kzRLL2sggUqpOQq3LYaRBrsjrS+FcKnoEUdZu+gi3lT
	 uN8SL5TfkZz0SFVAQRQT7LaKSR5sSChssgsIxiyaLNd9E26G0PH81ZTW/PTI0xemoA0LL
	 L1KVKVXw2hrLUujLKuU8XfNat7rmWH6Z3xTfPDsp88RKmhieuGMziDMdAEKVS7caQqWOR
	 qC5Co+IW7E7NuSXKzudjVRuDpZARfCuoIX3/H1QANIaee9xCJHfEN1337D+uEd9JZyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=sGwL+rAjN7ROYVGUA8Ywk3WhpiIIp3H2Jwa6afAFCVc=;
	b=ehE85RUV28vKpzKtufdlYuqUH8TK7BPFNcs4hKx/NTJ6+52/VhT0AiLzH/HzLRqEFBgm
	 2OlP+CtpevBRK+n/mVNvPAMHLFkLKxJLZnoYxlIA0O5U/5cTR08Qg2JAfBnmnGpYVKl9v
	 QwtyXQ8//Hcv+f62x8ZiZ05/uWdrrvC2PQfJ8cXzI/th4rSkSM2eMmRLTJgEr/YgR7wTJ
	 rYVe5zgb2bKTvS+GuEEKmdrRWQ/ZO1MdXviNSMXkWFXpZw4YHvKjPGS0mwwv3tscQwe/j
	 +Q8sYHpiE2AMm2i42Ycf93sW9uUl3WLba3QI+R51sapF031nd3CRyFw4USB8qzvnMcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KMMLETkZ;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E25606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56E25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KMMLETkZ
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso5623480a12.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795542192; x=1796146992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGwL+rAjN7ROYVGUA8Ywk3WhpiIIp3H2Jwa6afAFCVc=;
        b=KMMLETkZ4BGYa+5B7Cf3aD+4pEtmzCxPaAyGY+dPo+iSjpJLp0P41pL7E9fy0WGHUv
         jVKfKPyV/Lz5NdM2ljPtHojff8LDblbCTBKn+2GPBSkFxcvjp/0LM/iV0HpG9SPVMAZv
         H2KoRggIWqVq4HZRKVuGcWfEZ38caB2gGG8jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542192; x=1796146992;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sGwL+rAjN7ROYVGUA8Ywk3WhpiIIp3H2Jwa6afAFCVc=;
        b=xxW8jRmEDajvjb+O1qaUR6y2+ohAhcSAEiv41Dir8EULZUR+VRw3kTtoYp2ZNZkQt6
         CktyjQZqsxs67klPjg1b75IzEY7R8N1dIMTIqxo9ScCJbOdWshKWvhCvASWCQtKXBtys
         EUgVo5/agzZlr9ToWr8wB4/CHtHHcb2kw3w8SyHLqQUlDhQcUfoSbmb0BwiUe65VQzui
         +/d7n6JMCTqnOQCytDjLtfuCXlfEZnW3exRWLBiFS3uAe6sLkPJvGBlY4xisho9flhab
         qq8Xfo+QY8HtlhB5B39mhRCC8XOPyglO5f2na5QpKP3zQvl6WPOxPCwV20S8O5dRQGlB
         Z75Q==
X-Forwarded-Encrypted: i=1; AL+hErH90pzkK6WRWajxOzVTVX62hXFyiHDfsgiNsbODLGjeu1dPcGb2HDXgixV5uQh2EbdwUsetsos=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F54fYL1fmZyvbwHwak1fJirKV1p2kXxzkuyqM7v/Ed5Yfp+Jq
	VOzjcxU5ZkXDaTqjl295merV2N+djlggLKHZ1emH80b1w25+tSRUYNerwi4zk7m3JFlibPUzzQ9
	VgZtzrEpI9A==
X-Gm-Gg: AZFdTZdVXhDORmFjqQQJy/SanMnSFbZsjXstYMNSGfBRu5Zyf1mAeHPmB6dBH7PYMnO
	IGQO1XSUiMZayOdhBGCDv9RJyXJIxykERHL9o4wjAM0bdIswKb12LXjg9/1UsN69q6lTsUrzBMV
	a4plPFAaMd0zp+F4uIIXxwSLieg2koLLJ7OswoCkEDDwglPIric/L4W/Q4x7Mq61mSYkasFXbPN
	nP1YOSD+9uu7fj528yejHY3RUBYy3sBMk8q9c+fEFcipiS7DF4HEsT9aAyZTD3/BbXc9i6PjMAw
	qk3FvZRB93Ud8y5Gbnone3V3uBnYyOTnK2LWF3FgsYDLXviD+DP2AKNf62GGl3pQyAuUaobFbBx
	DbPg0B4vArM4JBeHVSfV90i8i8rDJdTVWlaEUR9cxBHzLwkDbrWXnfAyD2lnQzXtdR0XocTBUrG
	xZzrdrrwegnwPUUvlpcZ4AxunnXoBz1Knhn7FhpoMy0gQ75+iPXnMH0LpLJglPVP5TWoEVA3kN6
	8GEjlxhsC0XCDMeXm9c2eUUD90ip5Qlyqo3Tyk4YbQedapYrjut/0DXkWLR9BYHU+Tw0Q9UhAQQ
	upPbQSd4nvksIapsy5f8rQihEp9exJGYqNnVxYJSQGPG7p9i46PCmGG1q1vVw2nWWRc03vYMzW0
	KOeU=
X-Received: by 2002:a05:6402:210e:b0:6aa:f0e:a15f with SMTP id 4fb4d7f45d1cf-6ba37ec43c0mr12116937a12.38.1795542191704;
        Tue, 24 Nov 2026 09:43:11 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb07844211sm738266a12.6.2026.11.24.09.43.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 09:43:10 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d581da0aaso673706466b.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:43:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE7aPR20yc44U4rimVuFJApqmg8ov8GC8DqoAt8pZiJYFY6p1JRtV3qVdBMQYfKIycCSRU5O+M=@vger.kernel.org
X-Received: by 2002:a17:907:a88e:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c513ab0e03fmr1346144566b.25.1795542189561; Tue, 24 Nov 2026
 09:43:09 -0800 (PST)
Received: from 425495914135 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Nov 2026 09:43:09 -0800
From: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 09:43:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBBNtcLyu2fq47oXi-v2hX02m2=xFiG7tNa_hssaMNTw@mail.gmail.com>
X-Gm-Features: Aa3M54qKnfQZwxI-mjKB8QHeQk1--kc11z_QwsMG6NLOaQrTy8GdH9me-KahpT4
Message-ID: <CAHk-=wiBBNtcLyu2fq47oXi-v2hX02m2=xFiG7tNa_hssaMNTw@mail.gmail.com>
Subject: [PATCH 1/7] sctp: don't let a blocked reader take write-space wakeups
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Nov 2026 17:33:14 -0800
Subject: [PATCH 1/7] sctp: don't let a blocked reader take write-space wakeups

sctp_wait_for_packet() waits exclusively on sk_sleep() with the default
autoremove wake function, so it accepts any wakeup and consumes it.

Then __sctp_write_space() sends EPOLLOUT with a wake-one wakeup:
sctp_wait_for_packet() wakes up, finds no data, goes back to sleep, and
the walk stops.

End result: anybody else queued behind it that was waiting for EPOLLOUT
will never see it.

Filter on EPOLLIN | EPOLLERR like receiver_wake_function() in
net/core/datagram.c.  State changes (using sock_def_wakeup()) use an
unkeyed wake-all and still get through and will ignore the exclusive
nature of sctp_wait_for_packet().

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 net/sctp/socket.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index bc68af88e271..85ac4952e9cb 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9070,6 +9070,15 @@ static int sctp_msghdr_parse(const struct
msghdr *msg, struct sctp_cmsgs *cmsgs)
 	return 0;
 }

+/* Don't take wakeups for other events, e.g. EPOLLOUT from write space. */
+static int sctp_receiver_wake_function(wait_queue_entry_t *wait,
+				       unsigned int mode, int sync, void *key)
+{
+	if (key && !(key_to_poll(key) & (EPOLLIN | EPOLLERR)))
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
 /*
  * Wait for a packet..
  * Note: This function is the same function as in core/datagram.c
@@ -9078,7 +9087,7 @@ static int sctp_msghdr_parse(const struct msghdr
*msg, struct sctp_cmsgs *cmsgs)
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p)
 {
 	int error;
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_FUNC(wait, sctp_receiver_wake_function);

 	prepare_to_wait_exclusive(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);

-- 
2.56.0.313.g975a75ca90
