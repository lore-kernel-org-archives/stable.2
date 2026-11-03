Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742196;
	b=l2feUl7OW1bpnIlJCUYdOmpsjgvHTF3w+Fn9ARVeOXQk+4qVyhBshtNp1/FESwod1+1R
	 lPcFMXc439hx/nsirzBKSJAcd4lYkLrVtn1IXxkP3ey16yRS2+hepRcYP0mR6XmRKEZ5n
	 jSTA5Ookcrb1e+nvyxT+2FafLysZkfE53DP6aviXukD8JOTUMKoQdoTeEKWKS06y/nSaG
	 BfvNxEsCMC8Oe09nCmCsc8Y7uyR8N2EdKZkCZQQeIkoKWvjTTeZCF6sWVC4fm0g1KsyZj
	 LJNnG62fDh2xCLKKiG0/n34dHj9Pg6en/RwajvmmUFjYUsk48gxresKZbYLMzFLFc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wiixacI9+OIBzgiEEn6eKWz0f2j1hW6VMWT9Hic5AQo=;
	b=ZGJH57IwWeR0swEayDYhEIypxQKok8zqXuPA4494lP9vuwV1AUm0ajFJUcNvi0s553rK
	 GYP0mSAdVeh7mFZcmkkch4EqaFLyFLmpl1ymoBJInfkVbeNirXYYhnZMZq2vPJVOOUTTd
	 GxJo2fXTBAJRz2lj8y3f7pBV2N5ZQ2ZsWVQk8TswOJs2nHK+ONSLwYFyok3b6LdsVE49Y
	 lp8EcpqC8EQ5TnIKv+0M6v9DdnsInQbbLBYWFXK0QcJreGWHaEUAGsGiPNn9IlB9JceC/
	 AY9PMuA12Vg3a/zD9ceZ8DV/zsXy+hO6yzvWJgBvBWjUmYsjoZkVWIC1H68yXaiKt+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQSKpPpr;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEF606A33D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FCEF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQSKpPpr
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b4a13789b0so1757872a12.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742195; x=1794346995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiixacI9+OIBzgiEEn6eKWz0f2j1hW6VMWT9Hic5AQo=;
        b=FQSKpPprvEMgZOOhUwG4A8mNt7T8IA3bh9a/h2e9b4PmWfSRZ3cM+us2pjyqaahOG0
         Ywdz4gayJ9EjYXZF4En96C9RLaYXV0MAZvK0B8D0mVT1hoEze6ClqEuHkEIdmubu+/SD
         Q9ZXz0ooOaDkVjj/SFmG87ovZ1PEDGqPIJ24Kd50nT0c3Mfv+lIW9gpa457oJDhGhfGC
         TpgaXbrwBl5RZLpONNJ+JW5QJpWzhKbDB4KPpuvWgJ7wJaO8Qw8TQ/toRmlLVDtvqOqv
         xXTSqDljfdrt/4kO5xYaGGLZwhVh9/HGyAdp5mQ6mTOJOuoHBlysQJHsjuxXW2f+AK2A
         e3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742195; x=1794346995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wiixacI9+OIBzgiEEn6eKWz0f2j1hW6VMWT9Hic5AQo=;
        b=N06CB9q0t690gcGDL8cuFwddRqDeAZqLDqb3kFA9XG6DDi4MFXLZtsaeKxLaeByKJ8
         NI6tA6tHeQpeH0xrkF4IAkKTojf3e4MhfnkaX/KbVpNABQZFAtzNSgH42STu2HKQD9jJ
         QsHt3Ubw23O2dHFcVlIfUsbmVKEOtqLm6gZoi5mNpTr6c/FzWdTu+ya9PWOjecud0ugX
         e2woDs2wLj4j4Xnv42el6Ix8g1gMHkEYt1Cqfwag1tzZVc7nhFih1e3U3I+ZYqvfBfx5
         jRv8DWUMyjIhFGvrilGVt5JbPpXUu53sHI7nlIabNSKO2Y3AATcxfLpfOZuOMVFRaamm
         XfWg==
X-Forwarded-Encrypted: i=1; AKwUvBzgDB7TAKr1IsMhuFhQb56h31hPZK/A5jBAcBq6MnZjxOR1laZSW2UGS0QiHMRnrCP0sg5bjGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e/AXw2TznJEPEwS1oYVrUJdpYWTN7XQTXO0njM7WvChmWR8nF
	KSbDzC9MJZH7daWzEzBL8thEZdDmOyUyFHsGpWAvzLjP0TZyeSGfKEqj
X-Gm-Gg: AYBFou01Ly+SxE7Q3NZRY+zK/GvxHQM4CVdruaEw1p9i5Y8hRDo9nfkX5IPCRO/Y2Kn
	TVPTkOmL0Ex6JnM8741hjuI5HX8QB1YiLIMqxNeuBAp8GXy5RVpk/P8RLpr2xt58eAZdXNLgvtv
	zVwr1q1zrDF/SSxZBw+KQ1drl7cUtu+bq5HqNLbE8JyQj1qgRQxhkN89aMrO+lUZQRLi4zv1o9y
	NOh1nwJr4QGflM410S3vc12OjnsSWqNLoaHkE93LAN8gu+6n7gQFD3U0PEBeNgFOh7bRv7MP8g/
	/Rp0pyHSiPR5feGMj2N3ePS8IMwG+UD/YtwtZbStrGXgWhP+d3jj58JF1FBClhNyacbtFC3p2+C
	x/gqMSQeZ9u3vegJNoVHsMvZ18Igjh1nE1whEnQOYfnMSEf1MfiP1v74zQBjCdS1UWIJ/DhNu6D
	ZbrOlaMFHlFH5cuDi4TcGb5Z8WiiNuKOi7LKEDDcaAv0PT2Sqxp62Ergbk2NT0BOlE4bLWHe7fY
	SLrYmAgHU0Fx/l2rsKYnapsgEfvijLHlJ8Nofw1bsrS8emGKq1tMH/MsgRFY3t3tBOABoYZpYZz
	jbgHpQs0ZYkMcmIw439WwSJRBcrXIXwGEFmKwlwYh+M3yLoWd9KIoPsqq+NIzKIzF+ZNeac=
X-Received: by 2002:aa7:c418:0:b0:6ae:16f5:5be9 with SMTP id 4fb4d7f45d1cf-6b4d4c78d8fmr7236202a12.7.1793742194559;
        Tue, 03 Nov 2026 13:43:14 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac5a2a6sm40550a12.16.2026.11.03.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:43:13 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 02/14] alpha: report syscall errors correctly to audit
Date: Tue,  3 Nov 2026 22:35:08 +0100
Message-ID: <20261103214120.1099893-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103214120.1099893-1-linmag7@gmail.com>
References: <20261103214120.1099893-1-linmag7@gmail.com>
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

Use a3 to distinguish errors from successful return values and negate
error codes for audit. Failed syscalls otherwise appear successful with
a positive errno. Keep raw r0 for kernel-mode frames.

Fixes: a9302e843944 ("alpha: Enable system-call auditing support.")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/ptrace.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 45d1229344b6f848eb930917bf50ba759da99beb..c933c8805eedd91e3845bb4b46588974258398c2 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -21,9 +21,18 @@
 	(current_thread_info()->syscall_meta \
 	|= ALPHA_SYSCALL_META_FORCE_SUCCESS)
 
-static inline unsigned long regs_return_value(struct pt_regs *regs)
+#define is_syscall_success is_syscall_success
+static inline int is_syscall_success(struct pt_regs *regs)
 {
-	return regs->r0;
+	return !regs->r19;
+}
+
+static inline long regs_return_value(struct pt_regs *regs)
+{
+	/* For user-mode registers, a3 is an error flag only at syscall exit. */
+	if (is_syscall_success(regs) || !user_mode(regs))
+		return regs->r0;
+	return -regs->r0;
 }
 
 unsigned long user_stack_pointer(struct pt_regs *regs);
-- 
2.43.0

