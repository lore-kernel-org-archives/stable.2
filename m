Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F331F99F
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282169; cv=none; b=De6BdCjXCEKTqvf8wM0Fz0WaYSgWQ3cK9VW12O/Ju25eCEKmcHpXq0SzYORzBQcro2DR1b/XenRztri3qrZAfEPcYAwxMz9sOWlptO8g7XQE8V5vzlNKg+xVTZ86cWL41vMG4BR+4Zz2uxJGeUy5JhKyMttvA0+9PPFtW8FaUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282169; c=relaxed/simple;
	bh=4UMJY/XqjesJPz0LD2+Zpg7YYQMhj6htdO1rzR6ZIrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzHqVn2RyFY4MeFk/v55Y0+Fuvg/d7+rzPpXiYz3UkkGI1yC1G52ynogaL2SgUxc2peO+cu5xfZKm1/rh4KhVqjTd5dM1qB8Y7mrL1rUcOAf2qTBoyAjAyIpZKlWX6OJnvCjYaBA3WYM4XUl4v/vlXh0fhGXApr9HqooT1nhKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vlp6m3lE; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vlp6m3lE"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso4160385e9.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782282166; x=1782886966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj/92CaBdTIG4k88Avh122fV2bK4mXqDyX6lPzZHuMA=;
        b=Vlp6m3lEfwgYibLPjiZzl1ETQqr4Xue5ksTtWw+GnDyJPzLy4gqmq7FlN+fmHS/2ko
         SWdESQnIYbdxm61WAGm0I+hTCQ6nh1U38jfYi4MdahNJHtFy02oAWSSRdsykL62QOok7
         FYtQXQujU+qw0qkTkyJmrd9/SoIUGJ+vfqlsDdxsTUVk/CxRQOi+T/RAfE9dkLlIbKbV
         ddkISlrXlKnbjkxDqST9IsQmsLaHjYQgg+FHi5+8lfMtm60Ux8+bBqQPlExGhYC6fHDv
         FjYPelpWHGrxYEzQtws+LwAc5pXD8SxAENIhlp+tnP3p6sj6tXDrAfihDRZQ5HslQXxL
         9GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782282166; x=1782886966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj/92CaBdTIG4k88Avh122fV2bK4mXqDyX6lPzZHuMA=;
        b=S/CqgWztjqO458QZR2qtYDGkja9a/EWSFNTXewFaCuHnOzjuz9fE827tdh0wyruxtt
         YyJVMJl8WUK6F+ls1+SHGzLP/M01/F9rDZU3BwmDfqSl0YDQ5Eby6QRAo2vvQ/qhdDAS
         BoiQVnccCukPtJeYBlp3id4yF/BaoK4/CNtjw/LXbNButHyT/PNRf5RCukP7+JTIZ++7
         cI9QYa0LPDqo19zmsfz2AMlT0+ZhZ8XZcKwsik01X41qZJFRC8RPHLJcF5WuDyVqgqzP
         9XQuPrF6FmSe4TVFOtZlVGSilFu5DeEELRleq8j/Flj0Rmy26zhYcZxLF3miAPOfkWfJ
         QKMg==
X-Gm-Message-State: AOJu0YwRB0Q+FGIGOltGFWrWYokXaFnialbHSQi3s4qre5KHM+p12viz
	lLCMfifclKLgv+/h7q4ExCkBVnYdMe5MJvcnJ9RXy4YmT2+n6svMWm7hsx4TrgDLqvNcHDfzyET
	lySX7BCl5Mfxp
X-Gm-Gg: AfdE7ckFj+uWHaQXuOmIkWmdTvZi562cTLNSyIa4nlqUhEVDpwpAqmOJMVoQnQq+oKC
	7mGlOu4DIFeAPndkHbYT8eR+fx4yw8lvnPCamL/mFV5ffSRy/Tu+nrBUt5kvW0MntZRCs7MNWC1
	dUq7kxusPxFgl/mfow+5N98N5wIPJUk3piZsg46/u410BvdWyRLUA0i0klkXwk361JMsxnW7QBZ
	BlcCh1EXnf5LeDOjnXHtKAB/cGm7I8wXuP1lT1nXripWwInF6VQJQMGUHQ5u0DTkaqDn+efJzkC
	65JyIl6gYmyAe2bLsDKXBy0T8/zZSwtz1e77dbUAD5GsC+AzUKLWQ+qY0BJaZvQ7O6Ee7ZF0Y6H
	GDqd/F9sRAeCnoq9dj6CcKniBjMgNsd/OmwX2D+JLNIEgQm91gz81dUGPuAMEeXgs6XbDdPeBAc
	jVFWmh/iv4uFeXepkhku6kn25Vr13e2KiKjnh3gig=
X-Received: by 2002:a05:600c:584a:b0:492:32a0:7f92 with SMTP id 5b1f17b1804b1-4926084848bmr16832505e9.12.1782282165986;
        Tue, 23 Jun 2026 23:22:45 -0700 (PDT)
Received: from localhost (110-28-2-172.adsl.fetnet.net. [110.28.2.172])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0464a6sm9658968fac.15.2026.06.23.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:22:44 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Wed, 24 Jun 2026 14:22:31 +0800
Message-ID: <20260624062235.21002-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Varun R Mallya <varunrmallya@gmail.com>

commit eb7024bfcc5f68ed11ed9dd4891a3073c15f04a8 upstream.

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20260401191126.440683-1-varunrmallya@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Checked that test_verifier and all flavors of test_progs in BPF
selftests still passes on x86_64 with the patchset applied[1].

1: https://github.com/kernel-patches/linux-stable/actions/runs/28078688463/job/83128410301
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4a44451efbcc..41c874fbd6fa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2943,6 +2943,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	flags = attr->link_create.kprobe_multi.flags;
 	if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
 		return -EINVAL;
-- 
2.54.0

