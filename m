Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626225;
	b=x1ZVN3r8zfrSH0R9lUflL1qD2RySgKAtA+1FrFad+zpjAkk6Mn/zdVDUjV8nAOJERmof
	 nO7zfxAyiyY+/nvH4AxmEzqwf1Tmr/UcADRWzJpgvSrW3piTShqvCdCSd9Jb+GCPkdGUB
	 xfRj6r7QufY5Zmh3YuqaFm3gAVAxrL/VC8iKzeYO7CSiTCynUPErPuRD55QPWAG9NxABH
	 hU8YKuFUMKQWTr83AS9qktTNu+28wO+xJbSRE7mGm0aFOnpekgeX4hZyOuWV8aDnmv209
	 2MTzgU7iIsaN1En7YjldWWIdPfq0me/dhrCy0367Ww55DSP9dpnqn0tjIvOeEAu+haA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MbpiROGQuzVONeXp96zntA9ceKse3+uC6QJ979xAbqY=;
	b=G9IIzBoyRtLhvZbyigXvydvmdYvWxePxU+8743DtNODyTGnQ+H8im8/1kLY3HnlVQFmF
	 L1SH2UgW8plENDDTiz9gL22KNh2mSau2PJPNs64CE+GheI0IDplZ1MsPxzET84KcnVjBa
	 BMo+ITUzcZWVguqgS64HF+iSojC9DOMfVvtPb/+FUILgcKXeZ1wmfvGnF9djv/xviAi7+
	 g+ARY9vbaI8NNksS1S1o518VGDrtTWE4U/ft89RZY+zp4A7ysV0Rajg2/axxkNmpeL/rf
	 eB6v4KXyeOXG8GbwgStr39w05HSAWegRth9z0BWVui6HD4BeF87NKtRHxmDaHbTXacQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEHxRY4+;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7346606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7346606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEHxRY4+
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so24192655e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793626223; x=1794231023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbpiROGQuzVONeXp96zntA9ceKse3+uC6QJ979xAbqY=;
        b=SEHxRY4+KzlF6m4DVJJmK2js3aghhM7f1F1OLGzNkF2qUc2JiYeZdUC3SuJ3sQU9mH
         Qz7RC7owoB94WsmcCfeMS9/XimsNpNLyiqSf7k3BNTheWNaIjWmDWBzwUnIepRbv+Fut
         62wV+WS7tAy8GNU9nrQE2RfIbb+24NgGwcJar9KYvzjgklgf8ZzfD/pw1hPlFKyCra6s
         VNrhdpF5JwOjkv00Hb5XLGT5Xr/RFQw9tpzU5x7aJSNtdhkfrgdWY+Zm9yHPXow0H/dx
         rNwrnT24YmA5cFx59Dc7n2V7+NuFCNhWwzwvtkxs1O1ufTmdgpOOf4Bn3GzkQ9nRsfLX
         Kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626223; x=1794231023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbpiROGQuzVONeXp96zntA9ceKse3+uC6QJ979xAbqY=;
        b=BFvez6xXW7Y8j0/uJsJleU3/z7H0H1+93r65rqKzG8yqi5qsqhHNSJaCtEWuqvw9Am
         ooaYrSJ/2OWd5ueTv4l9mJ6g+SWIMt4pAkOnj9QbRFTeanhJ0WyVj+Ew+pOVQmot4xu/
         2tZYnNTFx5Nwx5JbL2bEko0ARZ1Of7i347dIxTKTs76gVsGPS8PVnvzT+zZe+dIblLac
         NtiKjlzgrzcx/Dl4YrSk765HkEv2YRDT21BQglBPd4B8gkosym61ofP3rjepRD7scAzh
         q6gQfnpwBgF2c11BtQStLB0knBNRLCd5tGzwqa3x+GDjf3ceneJJ96K3tWFA8JODB6MA
         C0yw==
X-Forwarded-Encrypted: i=1; AKwUvBxCnUqX2rsSPvH6gBL0woORRl1mHvzRexzNs9QqY8FZ2Zo33RHkGcJD2FQrLwsv2AwoQFG29m4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVENpYmENYN00H/Qc8tdp5ZqEcO0MuoIHEp/7HJeL2PZjvQ274
	Xc1iCkqnt0xuay7apwMnhwaa9wAC7V9WhrDThD3UTngP4Gj54bBD66KJ
X-Gm-Gg: AYBFou3PG9XzbTqzBnPGNiX9TtCOUUwHEaK4bmReVUpHVkOB0rgOSq0asjBhoXSsKJk
	0iyxHZd4IgQiydu/P567MxB5WtZ9ol9fhIZorgX5bW+UoW/vNTIa/wLx0x202067f/UbYYXvJOx
	mo2ldz2rO3TdoGQ2YjB0Dy1EWh+iqr0tG2pxeFvZJlZVWMV4OUo6OzRuJTcmvNeKYnV/U4BgkaT
	DbsfHTCWcYnWLdOT6kpZFgBx+GAk6rTfCWQnedFF6nnwGQWTr87eKyZbwLAs+uYxfFwHb9Sz2fJ
	p7xv7Mq+1F181VMuPJ/dJ+gJ5UtIspjivynkorbNzG3Sa9anXC4s2mwZfyafmEhvbVjTSBkTPv6
	2o8L3zamzvKPrHBgbVl5POgEoURr7eM3A5C+IwzIdlgSm+FAOlkk21/fTHKdvb6j9B3aaROY65n
	fdmgFhNd7E3gvw+OzCv4yGq2ht/WzoliAtTI6k1dNVeS7TsLS9NcW6yqgPHaZAv26eMxRHTVWpk
	qOqHsaWOKkjxEOljUXpT49d0yaqy0bAgL8+fHJcMiKuxExKThTm0DTcE4ym5mPascSDcSs6EBQu
	ZI9rlcFU+nbo+jeBcQps3hc4Jq2KZJppZEftjRCtxIdE35zm9+YGYyGSHUL+e9Wv2BzaQQSJIdk
	l7IHkEQa3XquH
X-Received: by 2002:a05:600c:870f:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4ac185bcf74mr220454775e9.15.1793626223025;
        Mon, 02 Nov 2026 05:30:23 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm291182855e9.6.2026.11.02.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:30:21 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kernel test robot <yi1.lai@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] selftests/fscontext_ns: expect EINVAL for overlay descendant userns create
Date: Mon,  2 Nov 2026 14:30:20 +0100
Message-ID: <20261102133020.3341462-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Commit a518e63c3775 ("ovl: return EINVAL instead of EIO in case of
mismatched user_ns") changed the errno for completing an overlay
fscontext from another user namespace. Update the overlay test variant
to match binfmt_misc.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202611020115.2281e158-lkp@intel.com
Fixes: a518e63c3775 ("ovl: return EINVAL instead of EIO in case of mismatched user_ns")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../selftests/filesystems/fscontext_ns/fscontext_ns_test.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c b/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
index 0f30a3e6e197d..535bf1f4e1a30 100644
--- a/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
+++ b/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
@@ -193,7 +193,7 @@ FIXTURE_VARIANT_ADD(fscontext_ns, binfmt_misc) {
 
 FIXTURE_VARIANT_ADD(fscontext_ns, overlay) {
 	.fsname = "overlay",
-	.expected_errno = EIO,
+	.expected_errno = EINVAL,
 };
 
 TEST_F(fscontext_ns, create_from_descendant_userns)
-- 
2.55.0

