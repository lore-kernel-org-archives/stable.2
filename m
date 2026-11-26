Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708384;
	b=SPRqEYe0lfH1Zo0knlRkozKVLagTWOH3BjLRs7YRfmhlITNgBCVT1+2dJXzwD2QNf5/h
	 JXOWcYyLRpYVYaWkZrfoziLY5SB/hWpKrnvKdtW58Xp4y8WXwf5qML/iFZlOgbQ9sDufb
	 h2z2Bil8p2hwmm3G2Tf9Z6ZKbbUqqvPZdCZfT1nkt9O+50kv5iBKp218rRq1qICU0xSdn
	 Q9zqm/4HycBoYh8zIiQx7vD97Q0IzyGKZVfpu3k40wiu0v/YOU+3MZBSwsKSaj7msu+Yq
	 kHoH+iiIBdFIM8qne4Ud9dMb08mVRtZOVQM7wh0W/WOty5DXoZxg3IkLYfDvhM/INbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=329C+ObflaGrYeJM1Uot0DWEfxpJGTZhLlPmSd8KCDM=;
	b=fVNgV9PgQHHET6NA1RZFYkd5wm/0oJcOK7uqYHW3R07wzbx98Tmq7KMOfTzuJx+wLWNw
	 cqY1eIBSbWv0xVrrR+mTEVKXRwHJ1jKPdXnfYoufchGT9TyBUd1vyeQdDv/7401K0tS+p
	 YBmbtOceOG4ZOwalQsHkYA5YXtnC5eqmRHsCRsMNs3AcvZTRbmjJ4arfxaXgx/zqgWxca
	 O4NarNqXg8WCv70By//O56vDL2WFGus06lQpIZBvCv5t3ioCA7GHGfaz1tL6XDyJgKIfL
	 02kyrTO2QZ1w3mujb32WclUj/7RtewaO9ibwWP6BzmxFU+/03z6nZMcJVLvYEx62GEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t/SoC3jt";
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D2606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t/SoC3jt
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so6543495e0c.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795708383; x=1796313183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=329C+ObflaGrYeJM1Uot0DWEfxpJGTZhLlPmSd8KCDM=;
        b=t/SoC3jtV0KvwF2cmafxNEx4F2ggLj2qXY3egSMHdzhxt++JfUQfyqDJLDX+QatAXR
         VokmzVoEZ99HAYo/6XJrFB6g5YLfAJFwZihbIFaTldkYC789NDHY075SS4xVFslGfo5z
         uzbBbPA2Er4hKhEoNP5yV8HAKjlW4wZ0bztSOc3mKI1FjX+tc8ONsx/rsDIK+6ShBijf
         Z+YDrPn4GaXlH7JUHqTj9WA8qFeSidUaigVHPZprnxesObG5P1+BTBwiwtcxR4D2/KRZ
         sSAqJO8KJW1X5p+0R+j/yC7Fxrnb/c+/tQlpDtQqvu73lnDHfNAHrJLQffl9lJ8dSlPH
         HJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795708383; x=1796313183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=329C+ObflaGrYeJM1Uot0DWEfxpJGTZhLlPmSd8KCDM=;
        b=bXuYASA/bKKrCIc0chCzHu9mUe7nBG1DZdKGl2RhbG5DJhHZvqVhCdhebKYG7DOyMG
         B8588mG/gevKYbdseFjl0OgyVgwrNS2RFhqQIlquHgVCWr/NV+sX3AmJ+EbKjL/XFFHe
         BIoGKXf01Sy6FufXQd5EIdFoBqV6uwW9txl8PFhpth2grN1P+lirVe7wSFHnXDabeF+d
         4lbo8f2Ihno8my+yFPXOfE8x/o3IMKZWe2iZ039p5CxjlQkv1DUsz4iHb+yGNWttOi/S
         UO1rsuCjjV8bWbKo0jKbKg3wAKXT/aF4Jn9Po5+AA160S4eJedrDlDC2kgqA8YnNtLLG
         7klA==
X-Gm-Message-State: APuU4Z9EIb5tQOzXVVhkxVBAVUIHCCznZSAHIo0os/jJJJIYcCZBwfvR
	mTjkNip9h/6Ey+01zUglbvpbcIKWTtDpuewdnMXhJAAR0Sg47Lv+t3JWDayVGkfON+4=
X-Gm-Gg: AZFdTZc7O/TC2GmEE2NSe4v+tF8iHAHf+w+c6+lDcXllgLDUamUrx8zQyr6KcwuQvgC
	z9OS0PCOo9feftyHKxkMaM5CuRBAvg78BzOQgP48pmi094IxRGqn9qXX9lJGpyRP+JlBcZro8q4
	FL0rUMzMQ2uM2ViaKV0XJc0TmdITkz7hZiKoI+/QbJStmZAnEXK07TNiqfduUQx0nbZJ0I63gah
	Xrp16j7DC4nOy6bMOR7YOqdPbJs+Vxwy88HmdP/XW0laqrQmCfSl0KJPnWJy7FqyU2iEaeEScjm
	ZhRbDuXc3Ub7aLFrwHJR7BqUlE4/mBgEj3qZX81OTpROM0hXy22fgd+kId9dToTl4MFE/aN/Lw+
	0NZvW5/U8mtZoTAsx7Ni80nV+TJbi9ONGBHSQ17rKoqjFUEw6gAXN9/JxbtdRpx1MCXYdlW6y7h
	H+1YZugVfTXvgBBTzWXXh/+BmKnfHq64uuhyDaetlurfBrwlUu5ZbtQYJel1eC6Rh4jAag3BU06
	SlmD53QiTtSiCzinuvXmqHsa62Yi6vy5jXfIoye+dxEvOyEo6eZsJVIUUlrE/0Tal66dcSEs2tY
	7TxysUnk9ofqoyhMyt7+fuDyV5wQtmUa12dcoT61p5IyFSN957BSTrlDO/XYSD5ZVyt6QOUPDHH
	JQ1J4Hvr1eIDtbIQUr8DsRQ==
X-Received: by 2002:a05:6123:4204:10b0:5ea:bc01:a2f9 with SMTP id 71dfb90a1353d-5ee81fe07f8mr7007269e0c.0.1795708383219;
        Thu, 26 Nov 2026 07:53:03 -0800 (PST)
Received: from localhost.localdomain ([207.174.22.68])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5bb61asm20980341e0c.10.2026.11.26.07.52.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 07:53:03 -0800 (PST)
From: Yingke Xiao <inkxiao12@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	bpf@vger.kernel.org,
	Yingke Xiao <inkxiao12@gmail.com>
Subject: [PATCH 6.6.y] bpf: Drop inet_conn_established from lsm sleepable hooks
Date: Thu, 26 Nov 2026 23:52:48 +0800
Message-ID: <20261126155248.56002-1-inkxiao12@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <2026112616-garden-overfeed-1512@gregkh>
References: <2026112616-garden-overfeed-1512@gregkh>
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

The backport of upstream commit beaf0e96b1da ("bpf: Drop task_to_inode and
inet_conn_established from lsm sleepable hooks") to linux-6.6.y (commit
26b380a3ca0b) removed only bpf_lsm_task_to_inode from
sleepable_lsm_hooks.

bpf_lsm_inet_conn_established is still listed in sleepable_lsm_hooks in
kernel/bpf/bpf_lsm.c, even though security_inet_conn_established() is
called from softirq context in tcp_finish_connect() (net/ipv4/tcp_input.c)
and cannot be used by sleepable LSM programs (CVE-2026-63865).

Remove bpf_lsm_inet_conn_established from sleepable_lsm_hooks to complete
the backport on linux-6.6.y.

Fixes: 26b380a3ca0b ("bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks")
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
Tested on linux-6.6.y (v6.6.163, x86_64 QEMU with CONFIG_BPF_LSM=y,
CONFIG_DEBUG_INFO_BTF=y, CONFIG_SECURITY_NETWORK=y):
- Pre-patch: BPF_PROG_LOAD for SEC("lsm.s/inet_conn_established") with
  BPF_F_SLEEPABLE (calling bpf_copy_from_user) succeeded (prog_fd >= 0).
- Post-patch: BPF_PROG_LOAD rejected with -EINVAL
  ("bpf_lsm_inet_conn_established is not sleepable").

 kernel/bpf/bpf_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 790451337..411622162 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -305,10 +305,6 @@ BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
 BTF_ID(func, bpf_lsm_file_receive)
 
-#ifdef CONFIG_SECURITY_NETWORK
-BTF_ID(func, bpf_lsm_inet_conn_established)
-#endif /* CONFIG_SECURITY_NETWORK */
-
 BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
-- 
2.25.1

