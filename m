Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793777964;
	b=MHPU/VFY4yyN8KACmZXGl7C4ilei4CUDNjZoxgapbDJ0+bTb1u/JyEobq+AcY8rSnxYT
	 LgxetPCa3ihOxnN4q4+OW2me/r0EsYS9Zx95BWL91gmC3Ze1OvS8Fv0yKA+r1P0GnjYYW
	 U/wQSt2RCfaMlWqt5l5VScX2V9XnOA5KjCo2gc+RLkgVzcHLuVXKgKGQ5QUBiFLIoh+hZ
	 umjXdvFDOGXngswDReIeGQc0Aiir+CDu74pMj4QY89iaTBfmdpT5cQOYb74zVotB4MVIq
	 lB9Ljbkgn3y9EimtuLfr31wg5PbSCG+mOJWrDlt32TAGVSobw+2voy8e3TH9SOSh10w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793777964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=siWU9HM2qbRbWZV4CvMwdmGRzsKBMI32Ha2fsv+L+xE=;
	b=Anl6dtcsRPzYH7eflM4slLEUaHHhUQRfYBwhdSrkXK/WEWicVASrWcviPnHIYtWzMBeA
	 seXdI4/vZqeMbhkq4hT8Ge6IKoO1Sfnda586znoy5qZRsXTdT5ZT1sD2QZ6adOezR6BPr
	 mxeJW7CYu0HR6GcnG0GrD6eT/FLUH/tqxxifIMKC+Hjt5zryA9iKcbC7KSMMHL+/YKLM7
	 sOSOuLGT4SsD4zSEJfP9grbjPmOZ86i3HvvNS7ufkXYWQvomtFA+RO/b5rZvbARyLWE7W
	 6f048c1QWSOOd11xRg3ycEkFWK4x1QVV4XXxzeSEwigUwsgIoaLx8f+FJDb9SCDszlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At4LbaYQ;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2E606EE8F
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C2E606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=At4LbaYQ
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06b27bf9bso191741b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 23:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793777963; x=1794382763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siWU9HM2qbRbWZV4CvMwdmGRzsKBMI32Ha2fsv+L+xE=;
        b=At4LbaYQAeXdYiJeFFtgJLN7xypecI5bSn1fPH7MOMfUivowUxA/aw3ybq75wKzNhQ
         fCxhpYoTtBwL//aIUXN8ksH/+eyP+FW9b27uaZZZ/IAfujp8hSOi5EViow8TGiDqesHZ
         0RkaPpaY2CAK3gtg3wBOLNAEXi7tTI7E9ZK8KnbjImnA1ukjWf0PdizDpxXAUtom8A1q
         Z+0ZT7SN0X5U3Ygh3xby23DLPfCbFyHFi+WV+yWCfBsrMVfvgYEvMPO5NR1zAmQy2WSy
         kKrPsIDp/rIFVphRprqodjxZLll95ywot6zC+NRoaT12NdSwgoGcKHemx+5sUQwjc7Mk
         nt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793777963; x=1794382763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=siWU9HM2qbRbWZV4CvMwdmGRzsKBMI32Ha2fsv+L+xE=;
        b=EPdhwvIBIc6YgSYYW8njPXAayAG0JylO753elV0CjdEuByErYCZMSoq3fVN/6x56yg
         XfXvaQLt+xeoFjyIGFIiRThBZG9pW002tFNT7yUoPESXXNZb0gUCUUYSm5g9uZy9Pdkt
         ZP2Xf7ToQkAUXUQxCC7+ZyNu9tyTaX2HcMrG68hgCYSpVQTbEMw1euDE/0eKSHutryBz
         p5p/9lmvP0n5gPGswvGiIsjulXGuYZeClA+/sjZZ6vwc+R3yNoudPgu2N5+6FTKFeDH1
         oB/tLyXJXpvAwC+EUe/BRcf6QBKzP8AW/h74mdkgIf2SJXu1D2Fbm6bQmYi0QJxkuTvv
         0jLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwADe7Fp4odzLSYpuo1+w5lFiNraZiW8co8kNaNBUvGBDIUgZd/HtwqyGPUKGvUc1gcyJcZKcA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h2xote4VC1vWRcST7B1NwUf5V3rRdFwz6yM4wTVNQ3QqxYCct
	q0gGKoSQAR45U1Ecc1gdzAOIWn4uVVrtRYQr+9EsS0QHPR1FqJD2aIRx
X-Gm-Gg: AYBFou20LDB6ZSPUOQk6dvYRcba9sAfRTN1kNMz6DcF8DCaQ4p4HqlJ9F/h5WClf2T+
	p/anXpwK2PVw1lkUoKxgOy5AsC3+FMT0RN8jpclruticHRL8ffhHh56YMGKtyfK6g1jAAi8xUJN
	8O4OkwwaN8PYE8EkDggxSDOJXSbK5Vi/5p+0kvdUzrHWOuTqm37gc+WCUfQ30k75i5H1meGNjMm
	/b28rVfaDN2srMZipl61rSqY2dhd8VD0iIm++5TB4AvIB8GJoYcHAt0zSOumxAwSPHSlQVvmcjr
	7CLaMTXImTGqxu0B6sPIsFpohlKmtrz5dAdptSXAYEUkPNUKxfWV5Cjsw+klqEkR+sCqzbDkv7O
	LbD5Jv+CPlgEylo+FiYRnavmVkYL/tr/RQTs6t4RbzQd+pZ6cf1cJ8pvDktRW/ly07UhOicJA/J
	H0EZhlxVNC2hDFv1ZG5Vd94NabygW0VvSgpoCCCc/DhWLgvbzPirYtwZ6x9opF0gsXMtbE76+BK
	vfipLj/z6mxV1v6bo7muOmgu5EukqPUtLrqtTo4ctI5KQK3k1S2lK5wz910Zm/Epl15J5DrgZwv
	al5EwFBg6T4l9jtf/FUb8zECJQZ54QvsYdrgD2Tr/ktIp7NyjhNZDxugTfTTjVTjESK1EegGLYw
	QuYQv26dzwmPvlWEKs8upK0g=
X-Received: by 2002:a05:6a00:bd02:b0:89f:d620:226 with SMTP id d2e1a72fcca58-8a9bea66f1emr10716702b3a.24.1793777963298;
        Tue, 03 Nov 2026 23:39:23 -0800 (PST)
Received: from localhost ([103.109.144.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09af91d32sm543783b3a.25.2026.11.03.23.39.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 23:39:22 -0800 (PST)
From: Zhiqi Zhang <zhiqizhangg@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zhiqi Zhang <zhiqizhangg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] bootconfig: Allow keys with the maximum supported depth
Date: Wed,  4 Nov 2026 15:37:41 +0800
Message-ID: <20261104073742.21202-2-zhiqizhangg@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104073742.21202-1-zhiqizhangg@gmail.com>
References: <20261104073742.21202-1-zhiqizhangg@gmail.com>
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

xbc_verify_tree() accepts keys with XBC_DEPTH_MAX (16) components,
but xbc_node_compose_key_after() returns -ERANGE immediately after
storing the sixteenth component. It rejects the key before discovering
that there are no more ancestors to collect.

For example, a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p = value can be attached
to an initrd successfully. However, bootconfig -l stops listing and
prints "Failed to compose key -34". In the kernel, the same error
propagates through copy_xbc_key_value_list() during its length probe,
so proc_boot_config_init() returns before creating /proc/bootconfig.

Check the array capacity before storing the next component. This lets
exactly XBC_DEPTH_MAX components be composed while retaining the check
before any out-of-bounds store.

I found this issue while reviewing bootconfig's depth handling and used
OpenAI Codex to verify the failure and develop the fix. I reviewed the
change and wrote and ran the regression tests.

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 819685d6c68d..a4aae9a9abca 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -428,9 +428,9 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 		node = xbc_node_get_parent(node);
 
 	while (node && node != root) {
-		keys[depth++] = xbc_node_index(node);
 		if (depth == XBC_DEPTH_MAX)
 			return -ERANGE;
+		keys[depth++] = xbc_node_index(node);
 		node = xbc_node_get_parent(node);
 	}
 	if (!node && root)
-- 
2.54.0 (Apple Git-157)

