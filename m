Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991255;
	b=RoRfdGvBZzFu4u2UdZubr9VT7VB6oJykcpvDG3j16BSd6sxRTLW2zGhXM5ADaOKzKH55
	 cOqOntXvg/34TwmzruIoiauzlDfxc/rcDWmeg8601qQbuYARFrCcEmPzhG4MtJsUf0+bF
	 ywXS+0RpGaZvxwjqHsGIg0i3SjN9ABMB6KPRZ/sCwIz0cS/arLHkNUHAlW0omn13DqlvK
	 3LzUtAWS9981sDxJ3SmDuGDvPBlTM4XqYcF27VkQFQXyaDhv7rvGv/G0OB+wDOGQ8ZH6j
	 rNNkJNDXbQrdG6FMQmB1FrlJqw0je0vfruOcZ8LhmPuGh3AzIfkT2Vy/rfl/96SjbjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qeGlqVH5MhUCNQ0F6mtAxIbc+A9NtKYDR+yZ3OWP3Kc=;
	b=vTTP/I/uVLoxxlK6GF8Mw/bVSaamvJitIiF8H3ZG78l8SmzN7WBHbShmFyeSU744wseu
	 cALwQBF2ciakUYqCSZk61USbnI5ly8mWTCwBVODdISFQRAv0313UEi9nBsddLxtfZK9kr
	 EHdw+3V3aN+sVqZNirJupQYuETMmvmK4pUwRMw7typLU3a8yx/G/R+uPsv2st7EPYsfd8
	 bfGFgg3wo96xCFM6LbTnz+4jb6nr4dullQoi1GRPCGG7AmXIz1L4qvaGXbxABR0YZEK4C
	 9d5DsvREj5E+Ftwtk8UtKhViGt2Rg0Sm2DV44l5c5U81/MhJmiEgNQPLCZzJ8RkWhBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVhfqmF4;
	arc=none smtp.remote-ip=74.125.231.138
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com [74.125.231.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D97606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D97606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVhfqmF4
Received: by mail-oo2-f10.google.com with SMTP id 46e09a7af769-85e1040ca0dso431864a34.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991253; x=1794596053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qeGlqVH5MhUCNQ0F6mtAxIbc+A9NtKYDR+yZ3OWP3Kc=;
        b=IVhfqmF4RKEln+uHmglFlblQIElDPe7IjKKUpOh6vJbnFTomdzbuBCuN/pU/swFIX1
         +w0DHeDLmrtDOYC7YHQkuccQDTWs87hkzppBwsNKlZ5sNsRmW6Zk91Y/CjsjQ5fQXjFn
         1pPP3bqOyjWQfmPvZiqIfHp8vLcY+Roelfc3zJ5uAivAQReKvrJKgEtpuEN77vKCSKE5
         KOO+lYhDUGgoRV3WhZruxHqikILXp/K0iPrUa4Zfx9j31zN+QipV95xorFquuf651OMa
         mpiqtVE9o98H0Sxdt8CM8Ah7y8+CsOI+mJQxCERc8uIHzIBj2Lj9SRj8mPlQ7CdnBW79
         jP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991253; x=1794596053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qeGlqVH5MhUCNQ0F6mtAxIbc+A9NtKYDR+yZ3OWP3Kc=;
        b=FUF+yFRqWsrP2ra2h+XLpJeb2A+szxNfNzKedZg7phYWYeSSl4+bs/gK60bgGmdrM+
         TLMtGGt9boB++//AwW6yAL6f8D1+Yp9d53Hw0lRANqnHu/B6++Ies9ieVZ5ZBDOKLKkJ
         jSBGdSJ7QWLMn+RWHI6YJJrmnlLLL3/rjUAbQSytXmx0P/aseZr/Y5VS4Q8Ialy7/aF7
         oHq1Y6McWEc7cT3Na6wYpEGaOP0RMXgvASgJ2WlKi0edWPWRDnHD1zBAhPu5lYeCTFHX
         CP0N8cmy64dnznsa29nTvS/dbw9j6HganLPCq07WtcsmnzZJu++wXZJ0edHNofMNlBML
         vozA==
X-Forwarded-Encrypted: i=1; AKwUvBwq1Vu0SEaPmG4TooNPwMsi64d88RPb4rDQuRKaXOuBTMOQwaq5JnVpdGhDZnLKkVxPGIMestw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pgBNMaTTRlxCgBk7o1VaqsoHG5pSii+idbLy8M93+hhgkAY+6
	pRdhjjcIwhPTQ+yG7TNpjbVKnUPgAo4iY8lg68232fCGALbkNdJeki8s
X-Gm-Gg: AYBFou0Xqt5JkKgTB3nTijdrcajrS/lLtc8JIABehP6hvEz/4McV7MA2XsOkGx6+XAE
	NsTks8tbarcu6v4DthisLGJj4NapTFT4xrhM8msTsZl78vXk09RHWKuplGiL5iglfqDGFAelt8B
	ylZPwWbBTNzlrdEFEaaqzx5nOkVksLyJBcNtKhSMMttiWAE0pa+tNafGejfxLjIMaIqGPwAZ9hI
	f7zXVaLti3B5o4pkgiPPBu6Sm/+h9MnLPM915o2N6Oa8ywlBmRraoK3UtvfdEKDUc/hKLgZ0E/0
	zIjPgR3pUIxcYDK9kyGE84picUyVPkTvo9k1JGRWMkyCX/xxEqDLQRW2s3o+2IUgn9CDzAy6bGv
	oquvOGHuvwC0B6I76mwB0rghc96x9ypwGVlDA4ncKiwVR1eflxuvxaSldmx++BsxA3BjRnhMN5h
	AswaOPD6N5ckNFws4jkY13Thrmd4PRfS6xUazdNtStpl91oBzLNMemlAcEWddh9w160o7Qq4HTS
	IW9lkNls9mQkAMcd6yHWAZtg8u7KVmDFHh7FnpJsHdH/VJnteBXUrkjfoLIdxyQYddCImem9ATD
	InULWEx8ZnXZtZ4Z7+C8MnHWFzd7jR4VYVf+FnlTwisI+MJEclgspsud4uiy3OgZjrlY
X-Received: by 2002:a05:6830:b13:b0:81b:ac5b:ea17 with SMTP id 46e09a7af769-85f1cfa0bbbmr3686468a34.16.1793991253299;
        Fri, 06 Nov 2026 10:54:13 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbef224sm2504620a34.12.2026.11.06.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:54:12 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: john.johansen@canonical.com,
	john@apparmor.net,
	georgia.garcia@canonical.com
Cc: apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: fix out-of-bounds read of xmatch perms during exec attachment
Date: Sat,  7 Nov 2026 02:54:06 +0800
Message-ID: <20261106185406.3332779-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

verify_profile() validates the accept table indexes of the file
and policy dfas, but never of the attach xmatch dfa. When a policy
carries an explicit xmatch perms table, the blob accept values are
used as indexes into that table unchecked. At exec time,
aa_lookup_perms() uses one as an index into the xmatch perms array
with no bounds check.

The index is a full 32-bit value from the blob, so the read can be
placed gigabytes past the table, across the entire direct map. The
bytes read are interpreted as the allow/deny bits of the exec
request, and the transition outcome is observable by the task,
turning the bug into a bit-per-query read oracle over kernel
memory. An index pointing at unmapped memory oopses in
find_attach() at exec time. E.g. on mainline v7.4-rc1 (KASAN
build):

    BUG: KASAN: slab-out-of-bounds in find_attach+0xc50/0xfe0
    Read of size 4 at addr ffff88810fb2f934 by task su/495
    CPU: 5 UID: 1000 PID: 495 Comm: su
    Call Trace:
     kasan_report
     find_attach
     profile_transition
     apparmor_bprm_creds_for_exec
     bprm_execve
     __x64_sys_execve

Run verify_dfa_accept_index() on the attach xmatch dfa in
verify_profile(), the same check the file and policy dfas already
get.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 6f442d42c0d89 ("apparmor: fix profile verification and enable it")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/apparmor/policy_unpack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 35dfa3b451f39..054aad13f5e48 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -1593,6 +1593,15 @@ static int verify_profile(struct aa_profile *profile)
 		return -EPROTO;
 	}
 
+	if (profile->attach.xmatch->dfa &&
+	    !verify_dfa_accept_index(profile->attach.xmatch->dfa,
+				     profile->attach.xmatch->size)) {
+		audit_iface(profile, NULL, NULL,
+			    "Unpack: xmatch Invalid named transition", NULL,
+			    -EPROTO);
+		return -EPROTO;
+	}
+
 	if (!verify_perms(rules->file)) {
 		audit_iface(profile, NULL, NULL,
 			    "Unpack: Invalid perm index", NULL, -EPROTO);
-- 
2.43.7

