Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296667;
	b=2PgUQKJt+Z9/59IPVFPPKKdn4MbBKU0J9C+9B6a9yIjydQetYe49I6E+oSpvHM0dAlNT
	 7dyIeT7RPzjbzoEAO9oybZhKeofgm8zm8a27scGRfTPNA0cO5R3IiqkoiXEFFrZu62fCK
	 BAdLc0KTsVTJLXmrlFfp5VpQ0k+hqhZq0MkCSyQ92ViI/H0ujo4lmxeEhpGN88lmAQdo4
	 tgBvDDJV2iZ9Fo18TJpqTDZ56JF3ue9guE2qi6SAP+meRmqaPhGRMVvoBnsPEO2ZRQX/q
	 w9Q7OFOcb5CfeCA9L3MeLpq7KyEBzv7u7pPWoPZlmAnF8szx2WcWP/eElz/SrFbPIaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LKjFiLYzQVurg+NPHsyxsXIes7kFfNR3qOZzicg0ALU=;
	b=AfUyCb+wE+s3dKVEgRwi+DoEyhRwMGHfFG6hT7F5jt4xKsLD9Ad9uYS2GECJQGnCAhVc
	 KT1KC30/2vK4t7gm4IupNdF2GLhZrdECTFI8cl+2gj6HY0Cuml3LoXB54IB3fjBIP0eBl
	 8p/gHIBwEh41SBQLJiQ0JQPUwXQY0icn4K2fkwkfxqfQyditVCHpg5xUP/zQqP5fakw7+
	 210IN7R8n6swP1f/dlVdc8o08qbHfkb159rNIIReWhC8dMU4rgbMSBmq9i/uzdyeAweoI
	 AhK+09YTqPye/HNBsZsjuyg8CafCJVjgOGVsQHh6UdLq0HJJ0oqsb/JmWnwOfJ0b5CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=wFa82v11;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935D606A33D
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1935D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=wFa82v11
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df5e315bd1so1778334eaf.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296666; x=1795901466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LKjFiLYzQVurg+NPHsyxsXIes7kFfNR3qOZzicg0ALU=;
        b=wFa82v11mpVx15x12ijEOlVL6l8/cckC+sSmYYJ6s/3IITHdTNCV8Jb6DvIdsOxLbj
         tC5McCE1HWbHl+VPgxhis4sxmoAywfTTyjaxpdwshyAl2W2dYDSpRE8LYq6drguEXgBu
         XW2s41ST4qGHTSf3CZsG2MCUojMXgpORqFLv5QR5Q0v0BxqRvL2OYEb9/3j6bJwrxfXr
         dajwj2Nf9b/+kkVT9Bj9h+RLB+spvmnFKpNdkRao9+WEoW1zjtxguED8+TUocuorBcbW
         jRnUXivIkrsYvUU6Bu54jG4S1Uix1Ojyq1NlzwyhG6uFosr7gxgANN29Nw1d2j1rYaPs
         q6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296666; x=1795901466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LKjFiLYzQVurg+NPHsyxsXIes7kFfNR3qOZzicg0ALU=;
        b=f6ajrYSEZC8hFlYE4CrkLfDBOdFi6uG17T90E0GY/0RryC3cVMlV+uVbcBf1umFLiF
         HiTReMuFR9r9WjaG7uM2r7s9XMgXA7iJGo+iGZ/x2sTPh5b5AT13M5/b4KLKU467EnU5
         lQR4Pm7BE2/hZwlkyy5ZIjVI7JMjZxEQqM/xTCIoOZtaXXoBx6tavUk2ljAWrJtGS55C
         NwdhGoOi12bTpva9GHD34wX80S301b33VbjwNeDdk99bWaQjKNIhZ22a8kkcnJi3WcW9
         FuQrHmk6ZVLa1NPZxTruMQdS1EOVAaoSyR4EwnRqASlujegQDH4zQfs3MgKDUtFaLbh6
         E59w==
X-Gm-Message-State: APuU4Z92qufbKBk086Qxznvvl5Hl3YWjpX1sfBXnvuNEoCwfNrLMOlpp
	/1km7d8EJmo92cYABhhOVsll6F5uSEHcsWNekN9ZR6FdNAgKYwxqmETCEkQccE7wmDNWdut3www
	dM2lPJpk=
X-Gm-Gg: AZFdTZedFUGgL5GUrBb0bAugoFLUkseaYmzsLDZfc1Qmqx3YgDJExH33+C/5SYhdxaG
	qgkLrMJLA1TqoZGtzWrpNVovDXx17rUgvWxetYHZY5tQFsoMy7QGrccwTp943rFRu+Q/xteNB41
	zY2NZD4gJIpV61pqRXLyWqs7VA8UOFkeeI+Kw34SqqApzbBXax2Kao3DxuyybQkSvCbjPD9P8La
	fJj9b8pyqiW5vaQmPks/ezM+g9xHmISpjkdsOiykwToPJM6K1ZY38EpGsB8+6dAvC+IW+BPWIN7
	iNMmD67TF51aON1ZTFB4ELEdINPOaj5Iz0Q1iJ+kIBHTQkGMoEiE12TNF17l773Hl31svezBwbW
	SvHOl6Qk98LuRurEZB7Wukycnftiz15S6Z+bQeMU1RlIfRxIiN6k4BR0L+m6A0JhlpVgahrPc8x
	I96dbsrW2rlaLC93VRpR2JGAWAceEDqBu7L1711cZsDn1OWR/mTOu2hshkGwX+OLT11Vl+CpSYL
	w0JMIga7PE8HS9jCvEvqR3jqQ+TC45fSzAnACZhNTYshPYCEdNbTTCTUMu7Vo6ixBdJOv66LlHI
	4RiZYMLlU/wjaa+t/OvyfjODhm5lfkO5UsBQS5T1PbWWhnISE3/DyxJAwj6x9yV3FTqDn3y/ia7
	gkQoCc0X+GfdnTvu4rg7uHqH3/pldtOfPoTwW
X-Received: by 2002:a05:6820:a114:b0:71b:1653:93c9 with SMTP id 006d021491bc7-71b394d8611mr5068684eaf.19.1795296665968;
        Sat, 21 Nov 2026 13:31:05 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.31.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 11/19] io_uring/sqpoll: early exit thread if task_context wasn't allocated
Date: Sat, 21 Nov 2026 21:30:41 +0000
Message-ID: <20261121213049.1788332-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit 1251d2025c3e1bcf1f17ec0f3c0dfae5e5bbb146 upstream.

Ideally we'd want to simply kill the task rather than wake it, but for
now let's just add a startup check that causes the thread to exit.
This can only happen if io_uring_alloc_task_context() fails, which
generally requires fault injection.

Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 has no sqd->exited, the thread drops its sqd reference with
io_sq_data_release() on exit, so put err_out before that]
---
 io_uring/sqpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index ecd336c373b1..3849252f6135 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -277,6 +277,10 @@ static int io_sq_thread(void *data)
 	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
+	/* offload context creation failed, just exit */
+	if (!current->io_uring)
+		goto err_out;
+
 	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
 	set_task_comm(current, buf);
 
@@ -393,7 +397,7 @@ static int io_sq_thread(void *data)
 		atomic_or(IORING_SQ_NEED_WAKEUP, &ctx->rings->sq_flags);
 	io_run_task_work();
 	mutex_unlock(&sqd->lock);
-
+err_out:
 	io_sq_data_release(sqd);
 	do_exit(0);
 }
-- 
2.55.0

