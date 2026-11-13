Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555410;
	b=oSSk30uzXfxfDaiCWRXFWRtRdqP8cIQaP//Y16aqQyZNSZpcKY7BG5UxzmBUqtcgywLl
	 AD/vrSO7UHaLYJKimcOUecQaC7kV93Ue5xTG1miCszgJoQIIOcZBcrzWsHQAnLoR34zGX
	 FLEELY0k+xYvioVJ3r6vpkU9XxvisyqbJPtCelk4zZcKYlS+2MGHi/nHHzLKZNg8NLw9t
	 IPu3bW7Q1Ytjjwv8FiVxJuzt9SZ/fPJbLGiYmLP0u4o/th66fClic40suBttW6957Df3z
	 UD2LygFvT6okjyi7vOSuPkfQnzVd8Hii92tzAvE2CBmrirVBQauzcXsPIVQNRQ2c3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555410;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kvL7LISW/1hXrYXeyGM8qT4qenPvB8Dmix98oXakbm4=;
	b=WRBYVHsieBFjSBQGvhG9t5cbHLxEj8V+7LzZYUypMquUCdmZz3vC6uT8Fs46R35QaCUk
	 nFcHBeQpDmwBzBOKQ+9od9ncfFUBs2Av+s9oroZAfwyyKMiqfqrqlqadF0tv3H/mKCr88
	 8d8g19d0jcl+/Ur4ViScOMRTxAcHZYhIhXsuor3V+xA5Qf1FVrJLY9AlzKRpbHo4zLkCd
	 FxIV5FzRHU82ugNTA74+BlI4iuDxcF28m7C417th9DZIsVKrnawQ/iu0Z10swnSKteu1I
	 f8vNBbbbQL3TcK/Higr//cugHl+jq5Ow8nESEQvU3V7ZtvFMBfuMi5Suu1o2V71uQyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00F606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D00F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b179528d56so254776a91.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555409; x=1795160209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvL7LISW/1hXrYXeyGM8qT4qenPvB8Dmix98oXakbm4=;
        b=OVUwocIHab4ZHPeulILPn38iao4SXn0nv1shoSWzBY1hMQXCSolRSTjKrASGhau6BI
         lDDL0Vpt93oDwGWEscfO0uNfPoe+6cDrd9rsfqGjsSOVNsz67DW3jj7xisSpqc+7Yw6N
         B7E2Qv03r/Oo7YRVip1eO4CIF4GIdhZrWajaeQ5nP8JNDaB9bofNQxo3U7ax5tVCD62Z
         l46HBSuy9KSdKMvHqsY/DPoHrRCergybkbc160UMF5l/O+eSuixkA3+P6d8o6SvOvKJK
         Z8MOPQ6LvM28LQXVx89/U9BYwdnpPdicnooWteZd3gSSZFn9gY/O1gARczvROxfMIXQm
         ZPvQ==
X-Forwarded-Encrypted: i=1; AL+hErFLHeLrhTNAT93ZF2buPyKu7wEhWZM7SOXiPR6rBSsLWQQYrJgcuY/T5rrAXmv7aZXhD2k84SY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5p0bC4MMcqklCgVs7rn9CNNy0gYvICrYOFt38BuXFlVSAcVxv
	ukKHCyS3j+cJpT0KQPqeHgbRHw4I5SPN+RO6k2Y9iFrWyj03lDV50Rft
X-Gm-Gg: AYBFou3ya587Wu/R6hBMXuRfbm7WSqMrswlrxTvA96yHFnM9nZM4VTE44yqSU4e887r
	WV6XC9g33HF84SBKystyPEfSGQBy1rrt+6HwOdsXoEQAHlvRhBKAadA+UZEu4npyfsJkxkIN3t7
	VZxGcqEZT8hl1pJGKu1vE5TzdICMrhabB5/+dCQAHYzcPptLJzo5d5/l7TtNsk0831629WcnsKm
	ion59hkNNYQ/+PvaQUeCZOdTdkQngLuSfZoacgK8YCXp8yMJKyUi9GAVzlZ7qn3ZykFqnGbQzNQ
	AqTBrT/zvGcBEJWcjHkNwVFehrlDD+Xy/jC6kDujA8t6utqZA84IUhjNih1W9OlnJiqWLUNYBV+
	cy/2d9UpQw/jczvDSBga+6sPTRh+mSbZ91DwqpTp36XKa0cxhesmNqfhZBeHtRHOVSApXiFKdhL
	VIyX0Gmoy0uWenPZAtJMrzYNcIzW7vXouqdxMNIqzJTF6S9DDdPS2SrAtIdM36ZiPVn38llz5VH
	rLK3mGRg1lzYIjQr+6byBqyT6v5oFY1/qvvr/B07whPVmPUeOvlxqG46/uAIyPG0SlQz65JPdj5
	keFQgBrU6RW0Ri3PgYzftdaSPOt0OnAsP3OrNOh2bMieVA==
X-Received: by 2002:a17:90b:3f46:b0:3b1:8301:95c0 with SMTP id 98e67ed59e1d1-3b1b0b95db4mr1239712a91.61.1794555408847;
        Thu, 12 Nov 2026 23:36:48 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm3205009a91.4.2026.11.12.23.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:36:48 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	Liu Qi <liuqi@longcheer.com>,
	stable@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v5 0/2] usb-storage: bound the ene_ub6250 probe-time card-type query
Date: Fri, 13 Nov 2026 15:36:36 +0800
Message-Id: <20261113073638.1225998-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b07b5f5b-4722-4f1c-84b9-205ba9b8943f@rowland.harvard.edu>
References: <b07b5f5b-4722-4f1c-84b9-205ba9b8943f@rowland.harvard.edu>
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

This is v5 of the fix for the ene_ub6250 card-type probe hang.  Changes
since v4, following Alan's review:

 - Split the series: the transport helper comes first, the driver change
   second.
 - Drop the shared 10-second budget.  Each transfer now gets the full
   timeout; a timeout at any stage fails the query immediately and the
   query is bounded to about 50 seconds at most (five transfers),
   without the remaining-time bookkeeping.
 - Shorten the comment above ENE_PROBE_TIMEOUT, as the reasoning is in
   ene_ub6250_init().
 - Drop the unused initializer of the bulk pipe variable.

The transport helper is recorded as a stable prerequisite, so the
dependency is available when the fix is backported.

The forward declaration of ene_ub6250_init() is still needed: the
unusual-device table is generated by including unusual_ene_ub6250.h
before the function definition and takes its address, so removing the
declaration breaks the build ("'ene_ub6250_init' undeclared here").
realtek_cr.c uses the same declaration for init_realtek_cr().

Testing: with the syzbot C reproducer, the unpatched kernel blocks in
the probe for more than 143 seconds and the shutdown hangs; with the fix
the probe fails after about 10 seconds with -EIO, before the SCSI host
and the scan work exist, and the system shuts down cleanly.

Hongyu Xie (2):
  usb-storage: add usb_stor_bulk_transfer_buf_timeout()
  usb-storage: ene_ub6250: don't let the card-type probe hang forever

 drivers/usb/storage/ene_ub6250.c         | 110 +++++++++++++++--------
 drivers/usb/storage/transport.c          |  31 +++++--
 drivers/usb/storage/transport.h          |   5 ++
 drivers/usb/storage/unusual_ene_ub6250.h |   2 +-
 4 files changed, 102 insertions(+), 46 deletions(-)

-- 
2.25.1

