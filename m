Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3042D5432
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650687; cv=none; b=svFkodnbZVobHeX4x/5E/VUm7VcJFUs/3g7XeMoe7Dk0u6jSamCjD9HBiKujMT+JGlzVOYqMil753Von8WEYO8V5FgIWEiJ9jjxkIh+zvMsjom6qLXrGec69AzMXfmJzE9PJiITvLrwZ+42mMcHkb4GKKuGAPOVHjFVNqac1k60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650687; c=relaxed/simple;
	bh=HiyZ/mRGbDtTQ4KM/8YUsOii48kY/vlJSMg+C6ZlMpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rag+jmygTB4NbJOGGkK/DFnmq4N32Iq800pY7pcSieDIj+rkrOBdVIAATjW7vulkfAkgXRNxab4js/y7T2SbUpi0YNMgZPnq3jg8/FTE4fX7Kf9CCzBr/vz0Kin4jzqeWABnc/18XIxfIE3M3CBuCBzSChdS+bsrnYW3XWm/qPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMI+3FPd; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMI+3FPd"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ee88fce572so5241006d6.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650685; x=1784255485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkeC7bWqSkFNiKhrvAzXsbJK3S43VOw0XA5kqChV70M=;
        b=XMI+3FPdhSfIqINUPkr0pZN+lPKeL42DfwPpKFt6fixKZOy1ziY2t2KLbyhkQLEBEC
         +UVaPKuYcCAwdlD9uXcu6LEE5GMH9S334+ZojQITGxuc9uaJ6kuaMAuCXwThRK630HRk
         i3mheq6bVvEqb244eNQZr7+el2VagCGH6gu7r1Ifm03k/nDmibb3T5cLt2a+AxJMfhUg
         Rfp/kB6eygjhHdmTHOKZZ0a2RBtMgDL1J6J7OFDFeFxeMN60/Ok+e0u3/QYkGUhRyJRO
         pgKns9DGwzxMm6ay8F7nqqL4Ma8fsSILrTCE5YW6oizu+KjQ9BU+1swwnPDZthuCwZE7
         WGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650685; x=1784255485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkeC7bWqSkFNiKhrvAzXsbJK3S43VOw0XA5kqChV70M=;
        b=Aqt9Fbjj0tYzoBf8DTchI5m5vDld1c+6LhlpQBbIIY2OLOxGtFOnGnelvXkqPC5NwP
         Kp85EDpdFnVYzu/Tgk7VGwhtPrlxt6HTO+yiTqwP6b76fvThhIE/MTHpnZihJiSfPM+D
         dL2kFkHgXL8CmhR7HZqRyvucD4z13UdBNW0wCgCB86eW1KMJboK1a7y5BAIV9Dmvfy7l
         JPpVt6EHsjNsFiIda1dn6fOJXjedZWtcfFhs2XclJtajQ6fl2WncExZE7c2FIBv3B1RP
         phNL10R9iNRfhchPx7ojBVl4GIHRKCubS8Dzf5ztMbSTnycp9DplUotgK3WVuoJKbisy
         bv5g==
X-Gm-Message-State: AOJu0YxcDwmqXzgdqHaxRlxGfSlwbUQ657HlHN+fIuuvh7kVR9GWTeTv
	jHaoIC1qZBUSbgpCTZzKAazVBH/Ky/PEy9v4R57PGa/eP9sRH1SmwpLruzx386fRFDs=
X-Gm-Gg: AfdE7clXw/hLhyH16Gs4o3wNi1sbt+dd4LyYHNxtfa89q6EoNgUP07l9MakyZhpU6eu
	71nnwct3Y6WoUcv5nucHBUAYPkny/HWL3vwmGE+uTBDwMsK6Lb0yYvGuCe6VZKRzA4+zty4R0f8
	hrZxO8/GMEqukwCEqfgS9K+WeQ0fbEFmvfF9W77TVD5V0BzBEcq+PUy0C4L1hkVGZC9HNJ+uluS
	csbmJIRMRLp3PbvmvcBfBFk/eAvU5q468LDjjal1Xt1421l0bzXO6g5KP8eLBBAHD4D2UEhLRBA
	4x1XSHpIuP2b5q29bE+xkiw6XeMDSMjt0R1XznQS3NMAnSs/6b/yMQ1rUVl5K1ucf5RQG8kDhWD
	Gh0WqnbuJMjp+vhJXDFUrXNDERfinl2Dakj9QE/da1xXuIa1sqBYlE5ZVyXr+9EV8QwKByURZcU
	y3b0XrsMAxFphYolsWWjIPkvClg51NFzvewblVs8jkBSun7wps0lIPwMF2DyMxJ8Bdw41+J/C+S
	5kBc2cwnccY42ic2Xxft59no7BaRNQY
X-Received: by 2002:a05:6214:3d8a:b0:8f3:7d39:90f1 with SMTP id 6a1803df08f44-8fec2275179mr115256856d6.37.1783650685212;
        Thu, 09 Jul 2026 19:31:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm31121066d6.29.2026.07.09.19.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:31:24 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Please consider fb3bbcfe344e ("exit: change the release_task() paths to call flush_sigqueue() lockless") for 5.10.y, 5.15.y, 6.1.y, 6.6.y, and 6.12.y
Date: Thu,  9 Jul 2026 22:31:20 -0400
Message-ID: <20260710023120.3747693-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Please consider the following already-mainlined fix for the stable
series listed below.

Upstream commit: fb3bbcfe344e64a46574a638b051ffd78762c12d
Subject: exit: change the release_task() paths to call flush_sigqueue() lockless

This is a stable option-2 request for an already-mainlined fix. The
patch fixes a security-relevant bug pattern that remains present in the
listed stable branches in my current review.

Why this belongs in stable:
__exit_signal() calls flush_sigqueue(&tsk->pending) (and shared_pending)
under siglock with irqs disabled. A local unprivileged task can block an
RT signal, queue signal instances to itself up to its inherited hard
RLIMIT_SIGPENDING, and then exit, making the kernel drain the queue with
interrupts disabled. Raising the hard limit requires CAP_SYS_RESOURCE,
so the highest-impact case depends on a high inherited/system-managed
limit rather than arbitrary unprivileged limit raising.

Requested stable series:
- 5.10.y
- 5.15.y
- 6.1.y
- 6.6.y
- 6.12.y

Fresh stable check (2026-07-08):
- 5.10.y: 738ac465e4e9
  fix shape: absent; upstream diff: applies-cleanly
- 5.15.y: c86c4726e7f0
  fix shape: absent; upstream diff: applies-cleanly
- 6.1.y: 090666d3cc90
  fix shape: absent; upstream diff: applies-cleanly
- 6.6.y: da47cbc25466
  fix shape: absent; upstream diff: applies-cleanly
- 6.12.y: 296aabce4594
  fix shape: absent; upstream diff: applies-cleanly
- 6.15.y and newer checked branches already have the fixed shape

Backport note:
The mechanical check above reports whether the upstream diff applies to
each listed branch as-is. In this refresh, the upstream diff applies
cleanly to the file snapshots for all requested series.

Impact context:
- current CVSS estimate: 4.7
- vector: CVSS:3.1/AV:L/AC:H/PR:L/UI:N/S:U/C:N/I:N/A:H
- direct-tracking exposure: Debian 11/12/13 and Android 13/14/15/16 GKI
- primary touched file: kernel/exit.c

Impact: local availability only. My saved v6.1.173 test at this host's
normal pending-signal hard limit (450505) produced a 1.035s clocksource
long-readout gap. With a high inherited hard limit, a v6.1.173/QEMU run
that queued 6M RT signals hit a softlockup watchdog panic in
release_task() at _raw_write_unlock_irq(); the same 6M target on
v6.1.173 plus fb3bbcfe completed with no lockup signal. The fatal case
therefore remains AC:H because it depends on a high inherited or
system-managed hard limit rather than arbitrary unprivileged limit
raising. I do not have evidence for privilege escalation, code
execution, confidentiality impact, integrity impact, NMI-hardlockup
proof, or a default-limit fatal panic.

No reproducer is included in this public stable request. I can provide
additional details privately if needed.
