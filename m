Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23456409273
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244037; cv=none; b=uO7p3rCBbST4T+zsxrt+Y+SOicTMYoAufbP9gfjJgX2Jpsrq8bsnGviw3KuvJmRT//0hqPqbRmLlKz/POiXQmqI1am5+uUf6nIOPdtH4zFN+m+J7B3+SJVvABCrIe2CIj3gfmKR1uhk7o0R7ne9V8N31zOq2HDU9TXRrmpkc67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244037; c=relaxed/simple;
	bh=SLSQjZywF7+Lc6VeIM/QlV47NxBvlyxdZos75W9Su5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmOXLuUvl69RSrU+utp+MMsvutS/AGlYFJoqIh9cUHNb07oucAfbleSB7r1WMYZSpSEvehhOg9okrBGHk111JOVmZ83OhEFripA1lAWwtytIK796VBvIwr7hys9vxOs+5HxCNvlAqwsKi9CqFWL/QKMZio0M3ZTVJsn4liNxcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqWR2WZm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqWR2WZm"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd77300825so11439075ad.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790244025; x=1790848825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcRsvehqcHDvG/4dqBrJDWSUw7cpSxyb7LT/W2jFI9I=;
        b=nqWR2WZm+1anIIhyt9c86sQR4yP6s++H19IpbhvQ77KAUUBKC9u5s6OFDQEtgd8cui
         4T2nSOiHA4MEhD9TuR6xzA/F1+Y7UrwvcHt5XMbhae+hGCryxdgGdJCp80RlXoYMQQdy
         CRBsusgNH17jORom3PC5YVNSLV+RouN39aqTgtMajPnxjlHBy5GSyczRRIwNg0gOE4Hg
         mATURBX5aE/lTt1UiuEuPXsd7jRkHwFo1NfFhF8OlKksyq+WbcWa70cxCbS5MVlj03YE
         A5662iezTAoms2cY996RwVZKzXRddyX7lWBN/4x7Us+YTtrpPE7TjOIxHIB1ootbKSv0
         /8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244025; x=1790848825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bcRsvehqcHDvG/4dqBrJDWSUw7cpSxyb7LT/W2jFI9I=;
        b=K9dxYxT9OfpZWT8YISN1lQHSQvQEQKfut+bMeyB5yildUADhfVIzMc66oMlCvbyJDQ
         y6JH2xgsSGhVh8AoJVJV0vntCwvAFwOkS5+VQtrjY4F9PrQ1rnQQcLnVUx7nwjLR8Tfy
         6uW9EhsSuuQy4G25dBlAohoaIdv9Hs3VpDSHwzSJ05kXVUlEc7IWSpqMmMqzIaNk7LwO
         YvJ3KHFqeHlcpf2eCr7OmNy5aToRNvuSFmSmoeK2Wv2hQ01DsJ3VV3rrGOhm32TSb/pt
         /Jgi6DWGKmNNi46hPovrxiBinlDvoDeZaLBoi/ez6ZUpI9YR4XOkqxMSSMkAO6B4/6pU
         qdHA==
X-Forwarded-Encrypted: i=1; AKwUvBwQjA2XhfifjgxCvVKd7hXdsyCqNEeZRcuyjJqex1omdCPyk0zgle/kXcrcAQOLBVBQTp3hQek=@vger.kernel.org
X-Gm-Message-State: AFuF++nsY3mnbM5vSp7rfsNioqUr+YS1ac7yH2kyI/QhEywXQiW1dzFI
	sshbWXFzpSeMl3IDhuJIv1m+J4cKRWd94WuVZYKVCmFDSzkbRQX0ZfLB
X-Gm-Gg: AYBFou0u5FqRBNyXAKKtRvnWBSmZVBMFRsh7VsNlRYN3BZ5f0O7yUrzjD20XY+D0l9x
	Ms06jDZeKfhzhpU8tNXFlYCA4tFNQAvxyqFmBiPgRXVxY6U2Wa77DzV9wBIhN29yN7bU4s/4YVT
	GVnBamfb951PFFSKrJRJhBf3sZ2ey1PxBq1FKx9I5CS5DIessjB0wspfY/xzFjuWBZYjhs5fMIH
	O8Fz7SR8LNYyAeUyQVk8nUCT602wroOsL3OewUDR09J6Au+RgNVA4HZ3JmlAexCw9F4dDtfzy5r
	p+EXFBRcq1dmwaFo2YIqf6RuVlgKlQz9qOJhRS2bTx6EMsQJTYjcMUlnOB0NL2eZKF8a7A0AKFk
	4L492cJ+FrDaed2FHJOhPatzsNMGhW42oh4iOUugGyushq5lybWdyGxswlcwWsDjBnsQyNxxcTN
	a5i8XXrT162rbtvxGiNj5zpiNdrpqOXdO46NuIguWHq/rycL/eEpnIctn3Ow13kiOLGYJSwxwdk
	NDvsqgW/w3Q30zooIci/AVwvx5ZfXN1sHOrojtUM6tLREH4jXqQTCRBrtM7/Qfo5w5wKOTb9Qim
	t0tfate/UpU=
X-Received: by 2002:a17:903:90f:b0:2dd:c100:a5de with SMTP id d9443c01a7336-2df7dd6d6d3mr17119355ad.50.1790244021513;
        Thu, 24 Sep 2026 03:00:21 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a516d58sm24409255ad.11.2026.09.24.03.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:00:21 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	brauner@kernel.org,
	cmllamas@google.com
Cc: maco@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 0/2] binder: fix premature fd_install() and buffer leak on read -EFAULT
Date: Thu, 24 Sep 2026 10:00:17 +0000
Message-ID: <20260924100019.3389555-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260919213650.3316812-1-benquike@gmail.com>
References: <20260919213650.3316812-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two error-handling issues in binder_thread_read():

1. Defer fd_install() until after put_user() and copy_to_user() succeed,
   preventing file descriptors from being prematurely installed into the
   recipient process's file descriptor table when userspace copy fails.
2. Call binder_free_buf() on -EFAULT error paths in binder_thread_read() so
   the transaction buffer and associated node/ref references are freed.

Changes in v2:
- Split into a 2-patch series with separate single-purpose commits as
  requested by Greg Kroah-Hartman and Carlos Llamas.
- Added Reviewed-by tag from Carlos Llamas.

Hui Peng (2):
  binder: defer fd_install() until after copy_to_user() in binder_thread_read()
  binder: free transaction buffer via binder_free_buf() on read -EFAULT

 drivers/android/binder.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

