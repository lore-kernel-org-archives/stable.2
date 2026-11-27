Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779821;
	b=oPdQyMQaHTQz4EDccqOZod0e28M9uH6UGchOC9zhL3sqb7BUXON1jT08+KQdqj5v0P+/
	 GgvZjhJJZVQQCz8qNrT+dkZOqMB0hTAN2BMwWJ7jBNpPcFVpz9ptICRngoUR4DvjlToOn
	 9sdqnkUe+H2TffTav/MouyKUe6diIiyJXukQNvaNBKIIb0QcwQ4LxwmCf+y1O+hsNF4y5
	 Jd0K/MvCZxZDDR9rfo3jTrUA5YzMjOQByeh1kcpshHPHk7dKtikkdLBUOz4x/AKDzjauJ
	 ompDpOtWimauYUXABntZdibhFvD4+I617TotKu1C7S8vTp8QBU+5tMrcTRlNv9tfibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AECalRK44VdMHI1DCyGCv8j6AidnaiyQLrZWOxqztSk=;
	b=CH1gyKPq6L4z4RXGcMUG0ZhNOSDfnUVl//FMuO2YIOpt0tcp9aelBq0rr+LM3Hw8SJ5l
	 wSRojHGSvzC4bwoQTGo0QDvfSDqj4PTL6ZvOjuOWWJeM9TX/UzReKy4MQAsBL6hFJevCe
	 uMX/x+YNNaOZVsjtXlqNYi4T0Pz0yPPqTcC/frZ35F1Vh7qTeZQTdKkOBHrf1vuuMs1vd
	 d+a03Va6gak44RhuR1Ex8QjYWOshIAVCAetl37llL6us/+te6X/Q446p6cJIhMJuWfuL3
	 ATZq6KK112lS9oXyeR6baeLj/l7zbJXy5Rfe1S7rMhXwoU3ypY/uKpy1fJPxIRTL2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="Yy/JZIXW";
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B64606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B64606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Yy/JZIXW
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5363316fa0cso82911851cf.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795779820; x=1796384620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AECalRK44VdMHI1DCyGCv8j6AidnaiyQLrZWOxqztSk=;
        b=Yy/JZIXWughqL+85ngdXxRaRNcs2VE5jmZLE7hvVJQlTSFHZ3zNt/rti6zabMR8QrG
         nzuI51uhXzo4miM5f6ENVfGerf4tNA+yPh+F3nHOYKqAuiszj2TY0zeN9gbg30XvVB3S
         nlcBK8XTi0CG+xnfMGQ/iJYcVr2TG03+QN410=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779820; x=1796384620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AECalRK44VdMHI1DCyGCv8j6AidnaiyQLrZWOxqztSk=;
        b=hsxV4lQOi0ogRg7RZllp5MVrHViKx9AlthcX1AE7Jnp1x01lTFJ7D6tvHwoHjXGLpt
         24k8z9l/V5L/DWt3SQ33wv1QeXS+8brOUcu0fMP+1kmL3nXWD9mghJhYkseoqbak46qu
         ZUnTCS9KRo+Q5s7OHUB4Z/hQke3+H0kPOSXIyXsmgzMPIWVv31vPVzePu1ka4oelXqCE
         XcHH+NL0oZGRllUbAmhXHHEyC4QZVBU+XDEdALqBI60P7JyVnmopemCIyqkGsRqSzST9
         fckIx0hRCSJgzXmdL9s3JIhmEKZmTNxeMX7YMCKqp05y6JRC0cRiRhHdGEpu4MdlK7dY
         lRxw==
X-Forwarded-Encrypted: i=1; AL+hErHqx882fAOqb0PNNNck0o3y7c6Ho17mdmD+A2j6QLu5bc2AAUG4Apjgq+arlQJvPtcELQst+cI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MS3lPUPdmrL0GsGXd1uPVx3q3qb9yDoo672Ga1YVgZ+kWEH4K
	u6R5vCAiZ2iFYepZNb91acUBJR/ml6uL4IIrS/oYWqeiAisJvZ4Nf/RVcatv4Grz2A==
X-Gm-Gg: AZFdTZeBxZ7EsyNMcck35BmC/LZFaG8RsZszmUO70N9kkyRdMbB5P2Rf1+/Nd8liRvj
	uwpEXVN5bu5+hKo+7werFdGGW/KyG2gY6Hi1s/FeIp5h2Pj4uRhox8bCo/iCDWVuNpDyFjl144B
	J7X+wc3yr5fBeXkN2AH6nDsmBBfQZIdNxIGkf+Jq0QiEpBkZhtYPS21NquzYEaOoetWxKxjBrfS
	ugN9BorQUG+ymEol2qtqJMhXCznOjz8qVjOBjA+bx29blgNgal3D9FRQ1xX+jB3859DDyeNrp5Q
	Srp/92Wwt+o0C9f0UsMHcMV/IS4uxG+DS1/qUT3D+8350JTf+AW15SBd0Ee0TphkCWt/VNDRrRV
	ATHDb69y2uFvX7FhLmqvO0afBjE/+8AzLRwcCtWtuSKf75WG+ktmE/JzaAVfpda7xTLcP/w2d8G
	DVHAKJfBuWRKmsd4/UEb6BV9mMA07NjNSMTu7Fd4Uy2Z54vy2YOD6On9GWNYSoeUQCxd/UFSI9j
	nwA2aLnkJQxvhugoGGM6+pI/nYsT4wpltk1df28rzU74pRmMfKKOM1SKf+Y1v6eA760M3tjd79o
	XiDbtxKK8RiDZ24FbVA2+Fhrqo/tuOcdZvz6antNFmXyiHu7HvhShYJry8MqLm/5ws5Yhqwqw4/
	cddgNkK/n3I7miw==
X-Received: by 2002:a05:622a:258a:b0:55c:7f3d:260f with SMTP id d75a77b69052e-55d76a882demr428968481cf.63.1795779820213;
        Fri, 27 Nov 2026 03:43:40 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dcdd1a2c6sm16652551cf.20.2026.11.27.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:43:39 -0800 (PST)
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
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	shaos <shawnq1@163.com>
Subject: [PATCH net v5 0/2] net/sched: act_gate: bound the cycle time and start time arithmetic
Date: Fri, 27 Nov 2026 06:43:33 -0500
Message-Id: <ACT-WEXM.v5.r0.20261127063407@mojatatu.com>
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

The cycle time and the base time are read from u64 attributes into a
signed ktime_t, and the cycle arithmetic built on them wraps when either
value is above S64_MAX.  With base_time = 1 and cycle_time = all ones the
timer is armed in the past on every expiry, so the softirq never finishes
and the installing task soft-locks the CPU.

Neither attribute has been bounded since the action was introduced, so one
request is enough to stall a CPU on any kernel that has it.

Patch 1 bounds both attributes at KTIME_MAX and computes the next
boundary with ktime_add_safe(), so an unrepresentable expiry saturates in
the far future.  Patch 2 covers the accepted upper bound and both refusals
in tc-testing.

The 10 us schedule-entry floor from the previous posting is a policy
change and moves to net-next; it follows once this series lands, and is not
part of this series.

Changes since v4:
- Split: only the regression fix and its tests are here; the entry
  interval floor and its test cases move to net-next.
- Conditions states the user-namespace route through a filter, which is
  the minimum privilege that reaches the code (reported on the list).
- The test cases match the kernel's own message on a libmnl build as
  well as the strerror text, use deterministic signed values instead of a
  2^63 decimal whose conversion is architecture dependent, and assert
  the stored value instead of only the index.

Jamal Hadi Salim (2):
  net/sched: act_gate: bound the cycle time and start time arithmetic
  selftests: tc-testing: act_gate: cover the cycle time and base time
    bounds

 net/sched/act_gate.c                          |  34 +++---
 .../tc-testing/tc-tests/actions/gate.json     | 108 ++++++++++++++++++
 2 files changed, 127 insertions(+), 15 deletions(-)

-- 
2.34.1

