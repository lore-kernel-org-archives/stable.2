Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF42E739F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665563; cv=none; b=APDgW+/0E2NGpYLymcYqhSM0wQI7p0UzGc0NdgxImnIKci9XSEGdb3+Y/bFzmY4aURJXuPDP20BJl4oyz3+SVYh0HmxpOMPv7Ot+J6pf8pMvr2dN4kZORDGIvEdAaaUOl/q2NofApL9V9J32iXA0c09sN8q6hL2Ws/A84Vb3tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665563; c=relaxed/simple;
	bh=yfz8vgxmmOr1tI4i2OC6lLpyXdWuyxwqMqDIJFkTrM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hF0QmkkNAlO/xI7divQgVePe+uebSmciV6TO6OFGJL2SFK8xMZjhlkeImikm7LSXfgZN2GwxwVm5My4Q93cEcQ3/opYBqmwS4vQxkE9mlY9527buS5kbRdzy59ujLh40pMZBWGe5i/EIoqp6XytosyCZNirx62kLBFmj1F4H9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx4m37m8; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx4m37m8"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307d0405e07so8071094eec.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781665561; x=1782270361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjFINYj1zMYDDcJtLNGEvT7jZIVVI6wBvhquCrpC5Lk=;
        b=Dx4m37m8WCVpjjlIGga0gv9m4e4opzCN8zGGRJc+5sHnbn/aE7/BR9bSdRjIFhzng3
         4KGzpYVPVbqa0rli3BLq0y0Tlp6pf7tLf6/6HBmFgtqTRlHSPuvyaGr8KM9XcYfFzWyL
         w5LJZ/lqrF5k5EmDpCtLQaxvZ/vK8WolDRaefJ8M/wXXYVjCrEDWCxO4wsYk4Jf3rG7E
         kFcxI8emvHBB3Pw2J5lKFX3oqKmXXacKsRBvlzBi/pHejD4ndfRo2AEYnCctLBZKzk/T
         FGVWSXO0YrwDVcsnIm/OIdsUBcJUX30GuSQd04yh/69wWeCReH84ZrZs0EqT7GIHnkvh
         JQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781665561; x=1782270361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjFINYj1zMYDDcJtLNGEvT7jZIVVI6wBvhquCrpC5Lk=;
        b=T/cHZqpVBSqE6PHxNlwLJKEIMfDLjh92of0huVKsOMLwciZiq7ke8KGOcMWP38ezZy
         UWjEFF5hPoq40ImHBY106L+uU0Backyi7+wgNi3TZp1ghuZFjWIHHdaGeJ3l7a3RxZAd
         hBNZ6bUOgp6qDZZjxLuWbQ2mv5SDE4uleOLk0pG4t+3/bTsGwAFiNAuI3N4Ojbr1rp85
         ydz/B23Uz16e4Vvy80asCsekJ6p700BwjIJJuLENyIzLH1LagiZc4Q3OlsDG4SvFXIgu
         Cf3KZ7ic8KUA64/bfLhct+1Kk29r3b0fxDWLp6RtDW06D8CgVf4yL3VDn/y2YHCbRH7G
         QVqg==
X-Forwarded-Encrypted: i=1; AFNElJ85b2rGcK/EJ2X+WHH+YicSjnDVIwbqTV2NSmLwhZ0b/3NLExsbHebP3XXTt8059NwWsR+vhgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjxva8evFihi9uuJa8Dzo+MSjq8Qu/CdXE6K9+9z94k7beYoGh
	nha8W0ttHnVRKqkOJngzsrWnNF3HxUG/uhZygpvHX3QjMb/k48oSbPLf
X-Gm-Gg: AfdE7cmYDkGu2J+Up2JDfx0uV8+zymvq85583o5o81F2W5z6VWZH+NXsKLFZbv2Eg2t
	22iC67ysD99MxHENb1EHtUGrxwboi5F0pT5A0NvYLFJAtdPJ5l4bGECwwwVx06k/X6gXEd36ttP
	YIU8/DBXrOYdLMznm1Z3gzzWZhOcvHBC0NcBVF0CQi7DmhDP7IWQBPHrUMz1aufxxd38cfePhM3
	jZw8AJvHNqJG6yrFMdWLo20EwDf4z5l3Gb7PpScaQL4qk0cK4y7KnVEBfv0q0DuwvAezulzFIJL
	2Bk5t29d0BTJ4SZTZmfZThBqTiYoktb/nc0D+K7BD9uUBiEt7BBlZADZmlYWngDKD86WPG2Lor9
	GS2bYhRYFW+2CAGwuFsdGUNqPnNjJcj+a65MOvmDBgqRSfO8YrOhqK4ce3ZQQ3g8RwaAlxFtZ8R
	h2VKNv3rMKt9ssZm7iN2XVtDgWXJENUT9YXZbW8MX4YVYJhWJ51pA=
X-Received: by 2002:a05:7301:6583:b0:304:e59a:e3d1 with SMTP id 5a478bee46e88-30bca0e2049mr1048972eec.24.1781665561156;
        Tue, 16 Jun 2026 20:06:01 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.92])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48bfa7sm21048977eec.5.2026.06.16.20.05.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Jun 2026 20:06:00 -0700 (PDT)
From: "=?UTF-8?q?=E9=93=AD=E5=AE=A3?=" <omeux327@gmail.com>
X-Google-Original-From: =?UTF-8?q?=E9=93=AD=E5=AE=A3?= <yangmingxuan.ymx@antgroup.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: security@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	eilaimemedsnaimel@gmail.com,
	MingXuan <omeux327@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf: reject percpu alloc ptr and percpu ksym convergence at same call insn
Date: Wed, 17 Jun 2026 11:05:51 +0800
Message-ID: <20260617030551.39489-1-yangmingxuan.ymx@antgroup.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MingXuan <omeux327@gmail.com>

The call_with_percpu_alloc_ptr flag is per-instruction but set
per-path. When a single bpf_this_cpu_ptr()/bpf_per_cpu_ptr() CALL
instruction is reachable via both a MEM_RCU percpu alloc path and a
non-MEM_RCU percpu ksym path, the alloc path sets the flag which
causes do_misc_fixups() to unconditionally prepend a pointer
dereference (r1 = *(u64 *)(r1 + 0)) for all paths. This dereference
is correct only for the MEM_RCU path where R1 points to a
bpf_mem_alloc wrapper.

For the percpu ksym path, this reads the percpu data content as a
pointer, producing a corrupted address that causes a kernel Oops when
the helper's return value is accessed. With a carefully chosen percpu
ksym, this can become an arbitrary kernel read primitive.

Fix by rejecting programs where a non-MEM_RCU percpu path reaches a
CALL instruction that already has call_with_percpu_alloc_ptr set from
a prior MEM_RCU path.

Fixes: 01cc55af9388 ("bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj")
Cc: stable@vger.kernel.org
Reported-by: MingXuan <omeux327@gmail.com>
Reported-by: HanQuan <eilaimemedsnaimel@gmail.com>
Signed-off-by: MingXuan <omeux327@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..c3d4308b4c6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10543,6 +10543,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			}
 			returns_cpu_specific_alloc_ptr = true;
 			env->insn_aux_data[insn_idx].call_with_percpu_alloc_ptr = true;
+		} else if (reg->type & MEM_PERCPU) {
+			if (env->insn_aux_data[insn_idx].call_with_percpu_alloc_ptr) {
+				verbose(env, "same insn cannot be used with percpu alloc ptr and percpu ksym\n");
+				return -EINVAL;
+			}
 		}
 		break;
 	}
-- 
2.50.1 (Apple Git-155)

