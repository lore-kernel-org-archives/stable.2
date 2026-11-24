Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529540;
	b=3i70rsbTArmBNqVkw/Pb+U0/VgFSD+aOzuYfZkknjk+2CNL5SrGJ3xiRa7Si4znI5xyw
	 2SXQDHHYpcfUNkMMA4ROhowuHqtV9aacAA2PytwW4nv0E7tUNnjO9p1hoMVzjY/i5SOsL
	 PC/B66OuS4RxEa9Z/BRmeMoDUWvWvy5nkeoEYEXTw2sNytLxEdSmConXy4g4WnXsRA/j+
	 nX7vWjqLCx8okARBvzg/N8A/4i3iF8kcS8z3UI4V2Uw2AToCyd0YC/WosSOl3XtV8k2B3
	 h4sDbTwl4hgK99NwevRravvHuNqOP9b2+xmmVREhNkqKWrVqSMig2spto7MdxPZWtkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1xGMs6jT7TfzD1rWb/wp0MZUHeeMb6G/nblIX2zqKoc=;
	b=lnytmMvMAVF66DS0ZGvPGhGOCbWhohloXIqScU6sdy3LHf06H/Knldsd0ojb7YL5vgBQ
	 62+oqflkWQLagtjPvlONqT02yq1xUdSKQIjcYJRE/li+4RqHeau72wOLfSoD5tWWa2OSN
	 unESkx2RUQkZs31d1ekQLlfZciLxhtt7xrlItrAH/UjiZciwDaPuAZ7RKO4AfPkl2xtdH
	 1J/spQ3MPT20WNvOmo2sgXqAz08nQBZ1K2HdtIrP6ouF2V6js+USCwNR5GX/KhYAzljoN
	 d6Vdkv3xVMx1TGtmdYBTxDVrM2fnAPDX4PUOaMR7OLg1ZFupSY5Z0FBj23BTQUGYdNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=c+5KiT+9;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D0606A332
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC1D0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=c+5KiT+9
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so5224442a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795529538; x=1796134338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xGMs6jT7TfzD1rWb/wp0MZUHeeMb6G/nblIX2zqKoc=;
        b=c+5KiT+93GkBxGQDnZLhMfbzB4uOpSJpkhB557s6VSmMDjh/WdWRmKGYd9rfHEpK83
         LLjyPPVRzMGVtn/owlTnBaSun1o3TfKtlYqcIUt88P9eCh4VtBNAbSTMfk1DKYHPfoGJ
         8/U/ct1dPt4Z+AdpQeggupLl8qwi8szv+PsUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529538; x=1796134338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xGMs6jT7TfzD1rWb/wp0MZUHeeMb6G/nblIX2zqKoc=;
        b=zDP5/q1E1c/8w0OrdGhnzAhLUZHc78gdztHTTQvfx1xPlbgAsTvyuYOW8fgLozOgsv
         vKwfxVE29ya9weqBuPkM0RlMLFbdnQJk7OGVmq7dApYknOcPEt4W6zvg9yAmDpqUrE20
         wqAPsOiBNm563KDh+10djE8CWt6nhQ/XlDaA+n4zrD20wo5COWMrdQBjBZ6U1soCE9B9
         Jeb2KX/aRSSDTmEJsJnevJ+AdK1DZjNntQkOn444nedBLcM+fRdbAyD5Y0ITIRacq5Gi
         +CHQzjBxwsavllcU6WIiel2fWKTIQMyD44ewNxsIh8q99VJbUVdF0TyiU5pRzC7RSucx
         Nwww==
X-Forwarded-Encrypted: i=1; AL+hErF4FSmjyf5gSD1ASIr1noSjAiVVnQ5TvH/k74LWST3IsmBpwp+1UxSatU9oAGq+CJnfvqcxN5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KF4B8Y/BWjeY+9rnQhXMQZifkx4UgeW2XJkbA3Z91cc0JbDWJ
	bK+oTwOrksDxSBe49Yn7VjAVL6SgUIoF9Pfdvut9u4JgBJubtgnKpfupHotcVbrjpw==
X-Gm-Gg: AZFdTZf9Hgg4m2qAYdPtmh7TtZLhA1+dZvfjCLQry99HurEQjkhAhtEeOFIqeV49z23
	60qlhaL5TG1iugocpVXGMU6p4kbvyeg82EHh75X3+U7bdMgyjSmRgvote8nF4BpZr5N/2YIPLH2
	RFxwqobdNtay6EFwNE1/CzoM9uLkaovDKRhWbfDW9yqJf7yx9DKxeO5Q2oqTHDqCcknYHDC/XA9
	JZZID1kpzRD8psRKqwgksdPNpUZ7YyUc9TdV8ILmrjJ8UOlJ+lxKNAviH8+OMqh2NbWyVtWS3dF
	xy97KMh3d2cuY+Vv8rFRWU/f4AA/dLF9eypWh9bEpc5YqohyXJ1fb8pfEZAOO7W1d649QGOXVcu
	1niqr3qE3QMJKfsqL9slmkW6Nt4W2nGpIVb1XONAkgeNcxKAG96veekNQM8FpvcLRVCk7Tl7zbk
	9oPIWF5IIUQPT/qEgWZUJUwyFebogbehQtl3gZ4gFr6z3pQMvjI3C0lA7s2NjpN3fsh17atFWy7
	xqAxNlJ5q6JbwUhVSEGoVnkz+JQQ9ZHcKIHyUawYIxiWycmzU0PigkkNTc0Kz2g0y+2x8Ra20Gd
	9SaHpy6AGa6r88+9SbPGZ7GPHjvC1dJyRyE8HV7Ivz131d/wwaz0CPakdtmD/8zKIRZA1K0lcO2
	laCQucz4iXCLpBj6ethOK
X-Received: by 2002:a05:6402:1596:b0:6bb:6c8:c4d2 with SMTP id 4fb4d7f45d1cf-6bb06c8ce30mr1085338a12.31.1795529537654;
        Tue, 24 Nov 2026 06:12:17 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm5032739a12.36.2026.11.24.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:12:17 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-rt-devel@lists.linux.dev,
	Victor Nogueira <victor@mojatatu.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Po Liu <Po.Liu@nxp.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	shaos <shawnq1@163.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 0/3] net/sched: act_gate: bound the cycle time and refuse schedule entries shorter than 10 us
Date: Tue, 24 Nov 2026 09:12:07 -0500
Message-Id: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

An act_gate schedule is armed from TCA_GATE_BASE_TIME and
TCA_GATE_CYCLE_TIME, both unchecked u64 attributes that are read into a
signed ktime_t.  A cycle time above S64_MAX turns negative on that read
and the cycle arithmetic that follows wraps.

That arms the timer in the past.  Every expiry then recomputes the same
past time, so the timer softirq never finishes and the task that
installed the action spins until the watchdog reports a soft lockup.

A schedule entry of a few nanoseconds reaches the same state from the
other direction: the entry interval is the period the hrtimer runs at, so
the handler is always behind its own next expiry and the action holds a
core for as long as it exists.

  1/3  cap base_time and cycle_time at KTIME_MAX, and make every
       start-time computation saturate instead of wrapping.
  2/3  require at least 10 us per schedule entry.
  3/3  cover the refusals, the largest accepted base time and cycle time,
       and both sides of the interval boundary in the tdc action tests.

Edward Adam Davis posted a v3 that capped cycle_time at S64_MAX and moved
the attribute to NLA_S64.  That refuses the reported value but leaves the
invariant to the wrap: base_time is read the same way into the same
arithmetic and stays unbounded, so an accepted pair can still compute a
start the timer was never meant to take.  The type change is also
unnecessary; S64_MAX is a fine range for NLA_U64.

Alexei Starovoitov traced the stall to this action on the syzbot thread
and sketched the saturating arithmetic used here:
https://lore.kernel.org/netdev/DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com/

This series keeps NLA_U64 for both attributes and bounds the computed
start time rather than one input's value.  cycle_time = 0 stays accepted:
it means "derive the cycle from the entry intervals".

The 10 us entry floor comes from the measured cost of one expiry rather
than a device's frame time, and 2/3 states the margin it leaves.  The
100 us floor proposed for taprio was withdrawn for narrowing working uAPI
and for a margin it never explained; this floor answers both.

Changes in v4:
- Reworked as a three-patch series on the current net tree.
- Bound base_time and cycle_time at KTIME_MAX, keeping NLA_U64.
- Saturating start-time arithmetic, shared with the catch-up path.
- Minimum entry interval, with its measured cost and its tdc coverage.

v1 -> v2: reject an out-of-range cycletime instead of clamping it.
v2 -> v3: move the range check into the netlink policy.

Jamal Hadi Salim (3):
  net/sched: act_gate: bound the cycle time and start time arithmetic
  net/sched: act_gate: refuse schedule entries shorter than 10 us
  selftests: tc-testing: act_gate: cover the new cycle time and interval
    limits

 net/sched/act_gate.c                          |  45 +++--
 .../tc-testing/tc-tests/actions/gate.json     | 189 ++++++++++++++++++
 2 files changed, 217 insertions(+), 17 deletions(-)

-- 
2.43.0

