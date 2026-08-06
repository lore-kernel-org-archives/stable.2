Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3E494822
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045306; cv=none; b=TgcpDP8N9MLzv9Xju12pEuHYjnhHZYL0U5Mojl6IWWwG+TeqJde8krYs2bVW1r+BSTA19l93uWEaFOJ+dK9tdeydqPaBbTPTgS+4/kCueOA+fm5SoSPi/4WGEcm+XC6BpBFrs/iwyZqrw1whGBIzz/Q5HmdePMlTHVuAAfupk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045306; c=relaxed/simple;
	bh=sSboF3nOx5Fbmhas6I6ey9seACJAKplyQAcNHv1o0WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cLjgZcT4dJfPHP254Ra8SDHZQihG1p/cRtfu2f0MO0MYxwuOb8MnFCwveX5DdVwlqdUfnuJ5+JIQz+pV4i+iI5oCLKv4zlBMPUzp7mwLKJnxW66U6m/fJq0NujWuWVZ/PAW/xqV/FMcPjoVU2BNq/JAXRdMZ1N+4SC/kubatBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLnF48e8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLnF48e8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-498012a61f6so11955e9.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786045302; x=1786650102; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0MZnaKjwN+F5O6KUpqyw6XaSkX7zjUg5vy7iF6PcqM0=;
        b=cLnF48e8QSTFGt1K+YFVIkyy3bIzeGUQgxhDPem3MaR2XIgTEYLCDYNhK6v9o85YUF
         t3plAcfgHmxoDb54d2uXc1k6PqtAA1PCYXSbKC+1ijpTvzILm8BUfY237YBf0C2rEGE8
         XDE2M9FOEN/PR9vc6g+ow0IiOHH0c7Q9nrLNL2UpI+UtnYyhma3jYF52A6NQ5wM0pbi1
         S18nGzAVh1xQpopUu7xDpkKTEqU19RP33W91ZegVk6MsGVIf7y8W8pSciA9mR/ISL3qW
         78jPbF22RcBV8cIOHkQijMP8m+7/+d6QB899zbSDTq7RYC52gNlAmFT3xs6SH2KVZj4k
         5sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045302; x=1786650102;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0MZnaKjwN+F5O6KUpqyw6XaSkX7zjUg5vy7iF6PcqM0=;
        b=cU7MtP2A8ioUoZhpl4sXs2H57pN+zc5W4qrqW+q5YQHCWEgA8LXClcljBaYHtus2vL
         wnZqBe4Lirnrkyc04b9897R1Ve/81NLxcOa+AWJq7owX6+/GYvfYYZVMOR56I5znvSVW
         bJb9tIXBnFxaov0RRlsRHLzxs8+cNwNK7jiJgat244U0pIUozk1tZxQHqappT+EW2V4R
         Ysk1MqFzkP/k0oru844estnmDx02+l8lEtmK0Vf6LD30DjmQfTagPsNcTMDeN+xzyTQD
         3U7KyUxHzDIvbT3/F8K8PkPnSJluimKxHsYW8cmm1TJCliUW8aVzXSs4y2Tftfgqau2k
         Kgog==
X-Forwarded-Encrypted: i=1; AHgh+RpLVYlDVzw9EGUo6A2/ZSkxvaBJbVHUjZIg+5Wd7Ti/NkldiDudKrb5+AqrCqwFDyFEsby+yZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MkfmPh5m0LwUV8IX22u8DO3DMF4JwH7ptXaANdoVQtCx7PND
	SVsbvIkurdv151E/obEjmed6g77gCJi/ag6P3VJUFxif90/Dls8ejT+jnxmnWwkCPA==
X-Gm-Gg: AR+sD12tzdn7eR4aC00dw9ftdCRpapOpn1/oW2rPmvjz81DXsBuAdkmncdT9lo9bObU
	WQy4BtBgw2InsGI5MoqpIw4VWniX+7B36r/ii5gweEdGIMHDgcoj2QMDwMLtLbR8VDku0TM9Z/P
	dku6Mj+i6KCvFL22G4DKUOH1giP/DqO3ZQ802Q4c2v6bTDSEf9dGbFCFUDcOpVfPi9gpHKGCnzs
	Wdat54KrQmzwcPdxKWojbGID3K88YdB2liAXKF9xMpn0e4EeCIq0yteBXvs18cP0u9EHy7Rex5P
	IhTx1txcxEUDDkO5dNo+EZpAYFPUpFI1rw9qTrLqm2AJwMRLthDPasvOCLUh/ZIyKoSPcrfZzxA
	bH7OVWTvLpqEQLeL+AF1UOtmFnF7lPO1du5hpaB5Xqu1IGKfN7BGaSjazXCYB7uF6C/Ee6fi5bx
	WQ1AUbsqBr+R5mbxJ6wZ/pAYybkVnkN1BrBaGxUjMpHOXuXDiMwyoyNKN5pOCs9fAHM3CGiKMKO
	M1ixD8dyOePJV97f8ipw/H7/Fs9VwoRYbm365voSHI5RPkL
X-Received: by 2002:a05:600c:6c09:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-4995c06a0ccmr235105e9.4.1786045301935;
        Thu, 06 Aug 2026 12:41:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:8b80:1ac5:3668:4014])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b18368sm7435085f8f.20.2026.08.06.12.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:41:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 06 Aug 2026 21:41:35 +0200
Subject: [PATCH] smack: fix cred UAF in smack_file_send_sigiotask()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-smack-uaf-fix-v1-1-26426d389a26@google.com>
X-B4-Tracking: v=1; b=H4sIAG/jdGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMz3eLcxORs3dLENN20zApd47TUVFOLVNMUS6NUJaCegqJUoDDYvOh
 YCL+4NCkrNbkEZIhSbS0AMjQdG3EAAAA=
X-Change-ID: 20260806-smack-uaf-fix-3fee58e5d92e
To: Casey Schaufler <casey@schaufler-ca.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786045297; l=1537;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=sSboF3nOx5Fbmhas6I6ey9seACJAKplyQAcNHv1o0WI=;
 b=I3ZfOezORja7D3V6dZUdiOZdMsOVgRHOaFgYMog5MQ+JKbSUKi8qBVN8gs4ATCd4kyTU6RByA
 TJxQfddNyziBOrMkSnfmhsvKOl5JJFPhifWoQZnk9iiFV8xSYex7hDN
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When inspecting the credentials of another task, objective credentials
(->real_cred, accessed with __task_cred()) must always be used.

Accessing ->cred on a non-current task is forbidden unless that task is
being created or destroyed; a task is allowed to change its own ->cred
pointer with no synchronization, and changing ->cred should only affect the
current syscall.

smack_file_send_sigiotask() was accessing both sets of credentials: First
tsk->cred, then __task_cred(tsk).

Fix it, always access the objective credentials here.

I have tested that this bug can lead to a KASAN-reported UAF of struct cred
in smack_file_send_sigiotask(), and that this fix prevents the race.

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..bbe6cd6b03f7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1964,7 +1964,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 {
 	struct smack_known **blob;
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
+	struct smack_known *tkp = smk_of_task_struct_obj(tsk);
 	const struct cred *tcred;
 	struct file *file;
 	int rc;

---
base-commit: fcaeecb8b0cd44f77d03b28de0671258d4db18f8
change-id: 20260806-smack-uaf-fix-3fee58e5d92e

Best regards,
--  
Jann Horn <jannh@google.com>

