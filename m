Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072777;
	b=qcoalIMjmjYLN9dKdLn4B81Z6OtE0PDWHO2ESOQjEW6ELLRKMRIKaZunBaR/YtM20yDc
	 WIW3R13Baf1crfdSAHzAhNkDiic4f5NMpM8hFHvc5D2YQyeSy1YlEzjhzAglQJyRrhJrE
	 LCEIUM2/zPV7ijC57YCDMqTWQJ6dpQJD2EAomVxF901Zcs43iPnqxOGNAFZ+iWwz3+LpA
	 vz+p+75S+BRJTtMiUvt8VcAxR+uvuJwQA/cvmNpDqOE4CsKAa+dl+WXmDlh+zwaGjUG6O
	 +WfjfyLeLjIJVDEVMOdu3VAowvstBkWAuLdFkSowCW/daeeu1xID4PuEHKrmELaWFEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
	b=e5qX3LMz5aKcADUtprpYlN5+6xBGcK0Lm1ebCiMr1v++q2lzlJjVFRjG+eJWyQdkEeri
	 t5yudgJmWiiz4uD7NqAdUk5IBuUn5kUQkzho22xPPj1j5rLHGC/Nvb0jbPvdhvwvKh8yj
	 4rsyiIotcfhHt8mlacabN9tXg0ewoxuR6IhZ7LF6TnK8k84sSxE9IRj6QMlPCzhdZe2bf
	 Dt6Q7AcDUkldop4z0L+JPPhjtFbBhvw8Be2YwUnL8WO1zpZqd3/0yAjqrGUnt+QsddpRc
	 U6VqLEHb7RgVs7F5y8QQJF9twdC4rRdv9IuaKVnI1zN9mB9ZbtyV9Gdy89eDSvI2h1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipgbtKzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535E60A2601
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8535E60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipgbtKzO
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91e7af9a67fso12081336d6.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:19:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072775; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIMC7L9OH/HapS2dhamE3t1uYcCfMxsDlhNbCngZLJPIXINwJq16yRRPOV050Lpzt0
         iZkTjz4b8hscPBN0dOkQm29r9CuFOOl386JxhKaOStUDsKAumAyTXCmWcMKEieittDfj
         mSv6fSbTv65vgEXl49RrzqIVrQcqEd++z+b3iZO3qijzcKPa9e2VCKxJTLJNw/UGcvzN
         SyPMXiAmqCu6YjQuB9zMW2XO3CDoQ2ybAayhx7fWWlS1KtPZI9PTUCF2gQIXqZHbnF81
         sMnMDu/X8PdtUUJEv7c57FF1lZy/42RV9LX9vCyBgUYgRG49trtbsxeTrmrJ89PhHmRB
         6n+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        fh=wEWh4/e6Ac6Fld+unEmoSWqGOsEZJfYUn4BftsSy46Y=;
        b=IAq1xmp0uYzuEX8btu128vAyA02rXy0qJW3fQwi/iQBucbh8PR328rrYFZfYzCGQ6G
         zngxZVpC/qAxmweHZ0tsPeQKilqi8SNPh61xfn73t/9hr9rfDVqN6KiPC11ilk5iLxK2
         5R2LolqhMlQM7w1UtMUZqwAhxnFWnTKKlEayVzpgobovhJkVekjfU2CZl3y3qlmA4A1m
         qetiU6sXRveqEjVGEcP/rJV9Tfmiv1QBAv8tF9PfSghmlMKW5Qawc35i/e6zSXx/5Rpf
         Dfz+mXLPxDor0rvd2xZ7wZuDwjMPD2ytD5ki8ivV6dzYK6ATlm3DAcEYU53XErzt36Wq
         kmCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072775; x=1795677575; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        b=ipgbtKzO47kTqztaxtvQrPaEEJkMqagfg4PklqZem6C5iY8BSrJ1dqhz+10BPSuIoC
         cSZWcWhzzPX8z6eZGM7m4yZ3Foh0d6BcV3IKA74DloeR4YoLXUDaCrV5zP9Wba+hntww
         CP5YsvJMuKXaNeue5C3tkzE8PtSLDRxoENoJXzB9nm9wT7N3FS5PD2eXX55BdR7ShxO5
         dtWLJLhIeZppiht6yOQwd9ySj7byEXFmAJPJYaPsd3/qMm8k/MxhKeI8GNmGaKBHT/Ze
         kIdRNNEpVwRBA1IvUYjU1u4uAuZnf4puMJwAfuZ+kt+p2wPzHbs5cpPKg/Nmk9Ms5pLH
         NIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072775; x=1795677575;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        b=Rd0a0FhVEpDv09XFCwgmQTQsSPBbDzhjGdFPIbWiCCe7DX+UanLBbO58Aj7pY4r9RY
         +l1oUPkGlgLcGQXpLJR9KLNeXae5UMbchnA3OCwDDSzGaaFDapIXlgh+/qMSTOeJ7IWC
         Zwm2MqMltDNgQda1RLGi/fPdkMZfk57cwe76YMn+J6LpfGFJDCs6SCXfiWHEaJlfY5FP
         qpBIXkVTiHZ2G/H0X5H0R7/xQ26sszjn8fXpoQUnx5NASIgfEpT1h+F9J1lG0gs0QOsM
         5wv2Eg+UjmBvK0A7mWV0EJQkMDRrFdkNr34R7kqAee/AFio8RL+Vjz1CTMZwc63Pf2aM
         litQ==
X-Forwarded-Encrypted: i=1; AL+hErG3qUHdMM9Mx0MFGO7rkvvflNbl79oCin5Uy+t6ItJan1naOozlWX1DKNDaf/TEEuFMw3+x+Kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c4wP16J1+9FatQ0lL69GiqbBOn5ibJoQFIVNX+N2I0Qb5joU9
	5iQ7OmmI/QHxinhNDfLpDMroS+83PAjth4yN5Ene606Mbq7w2sjwe7b0ofaRHlqLORduYaXF+OA
	XrM3nnudIbATg7s/U7KYVv3OU0xD+3KE=
X-Gm-Gg: AZFdTZfd9L7IWMmmrZEcEzQn7ckDV2/9q0vguCbIv5r/VQxBKehBQO8WcyxLID4Sd+s
	cTNe3vMYoQW79yn2AJ5I6P+MuYSKn9GPmj5lmOTUI4fA1wuqJ6oAfYfpVmN6lePjxd9t2aClQeM
	HWYqIAK4R2iS0hk1C1gQWQ/LiKK7sMFcI33vxBI1g7oTRFf8T4n9Jm2CwplQ2XhEREabYNBOqNC
	J6MBC5GiJYIgjLBE5GIhI3OSBYZsrwqr1f/UKeiqyVxQajEZDEbgjDDGYIYf4CxcA+82iuVAhBL
	dWi84v1DkBdAKVl5Q3jvVfLKNk/dX8i9RHG04SuRKdFOewf3romWYdt9mSB0/2n4Lvnyve2qys4
	jU0Hyuy0S8+hbxzdGeEbFNviPk/jq9QecmEv8SlGE3vpWIRLay413zOaltjmIXIj7ItXiyldWpe
	0kLiaKJcp1GBFv1pwJpg==
X-Received: by 2002:a05:6214:4784:b0:921:1cc7:80c with SMTP id
 6a1803df08f44-9211cc71c9emr52693146d6.34.1795072775342; Wed, 18 Nov 2026
 23:19:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 02:19:24 -0500
X-Gm-Features: Aa3M54qXFrwgtFLlrgRKJFJJgccYJHjtkJLvYiWNUjzb-GPFdVBg-cmr6Ghvh1E
Message-ID: <CAMcAce_827HxqEcwcN9Pp9n1J_vRb15qGaKC-U+ERtQgoKn2Ow@mail.gmail.com>
Subject: [PATCH bpf v2 3/3] bpf: Add missing raw_tp_null_args entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Multiple VFS and filesystem tracepoints pass NULL pointer arguments
under valid error or uninitialized conditions:

  1. fsnotify_destroy_event (fs/notify/notification.c:82) passes NULL for
     arg 1 (struct fsnotify_group *group) during queue cleanup.
  2. vfs_open (fs/open.c:1012) passes NULL for arg 2 (const struct path *path)
     when opening anonymous files or unnamed sockets.

Add raw_tp_null_args[] entries to enforce null checks on raw tracepoint
BPF programs attaching to these hooks. Verified on x86_64 7.4.0-rc3 and
6.12.118 LTS.

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c345678..d456789 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6604,6 +6604,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "sunrpc_task_run_action", 0x20 },
  { "bcache_journal_entry_close", 0x20 },
  { "bch2_journal_entry_close", 0x20 },
+ { "fsnotify_destroy_event", 0x20 },
+ { "vfs_open", 0x200 },
  { "fsnotify_bump_event_seq", 0x20 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
-- 
2.43.0
