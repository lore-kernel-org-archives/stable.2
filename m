Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579832;
	b=qxL7NKEuFpfwtOW9+C2cQJhhTRwbkqo8DJiNN9E4WJdWxCeq93tM6CuV/5JRMOBJr2ij
	 FJr2xyafX39ql+EFpLwghOJa6csdfO3m3qE/1A2ygo03zU7jeZA5a0BZHBdT1JodaoMFn
	 hiw7gmSUPm8FPItu2Ql1OtjwHA+e0LadGMEeAbMIZIp/03+dpEefhM5wL8Ro+U0JeE543
	 jfS+V0PaKreQuwk+KXcHyR8s2i/eLf3+j2lJewfam7NpP5mKDpxFFSoaAzltXakoNoNv2
	 sGWxWgF2TpA1nPcGYKJ0hNHVg668eUFvTi7kWh8NyOOe5/mRwf8n6NDAnLNozZDJAMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IUnfnMCfJsbvpWvyHSjvGcJGybGXt1oQn5zqqiFkIO4=;
	b=znf/M+g0sFGzb8q4Cv2BWwIogD7tzRH8EF4sNNiWGUnylBUfBp+Y6+uHYWxv8Bb+YiOf
	 uFc8ZQX5jequQqoImNHze4MoPxxg1z+Oc1q9DpysE28hKAmPsoeDzI3llcHGgc4TyzGKg
	 CJI5aip2+Ssc2oYa0RazJPLPOMk0ADt7Wr92rQDOcgNvxqm34CZYBanykvyphKUecYVo1
	 fa/z6qFcqLennjSRgmiiLhVifwDpTnaTZS1/PGyaHOh1jBbhTedF90m8wv5a8lK3WxAc4
	 3dAQolqO1VrbNyqrS2h5kzOw25z0H8p3+y/umpfQFKyXxl8lm6gGSCBC9j0dtrNYvNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Eb8N64Y5;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD9606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 00:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CD9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Eb8N64Y5
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91b55859245so39500676d6.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 16:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793579831; x=1794184631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUnfnMCfJsbvpWvyHSjvGcJGybGXt1oQn5zqqiFkIO4=;
        b=Eb8N64Y5rqXemMKPCivG0+BhZ0l8xEhRnb+UBOUx7NAZ18szy4xG+lWskVUGA9ZL7a
         qw/Iy26lxR7dcQ5PM4iM0Fmss4c64hSMcN8LA30nX7cKoZrrzRaxRp0ssP7UU8cgd/AM
         OLSP2r+pEtG/bLfz0cmUtbmxk4ibNlJaToqqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793579831; x=1794184631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUnfnMCfJsbvpWvyHSjvGcJGybGXt1oQn5zqqiFkIO4=;
        b=vrJKy1Wz8QfWHxCwSsUmziAlEigpi7bMr9tbNdieD06yQOLI9sr4TndBLU29A+cK3X
         wWsKYK9uuMUmj3kEz2cgTWjXrdUbB3vPvbKwQp2UA3L2M29howSVJtPa8sp8E4EGrXXs
         tCWX8v0eJSqZHoijqq/LZt/cYHFgWPIzB15BMDSmd3nS9DFWxRgMgk0AeEh1gSXOXi/T
         4jCZ92eCL2CcX0Hqc9RhBtEXgElv/mXlEbOkOXnaQZr/KF/NCI4bnQe7foiZHNDW2aIN
         m8nZGqzosx4yELZw4ckQIu5dgsZ5SUYbFULi+IevdXjjwFGbLZB8goxILHNXkFMljio4
         dhxg==
X-Forwarded-Encrypted: i=1; AKwUvBxZEpYMwJva4qirxWdp7oLoGV2N0MApt+wSBuL4TVDR1ULAoaxFMPM92IaZ7GFR0nH8d5A6VzY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lQUK2iKID1dDhhTpLhdR/+F6amb+A7eYFnaMSe/s7ZNKkT7NP
	Tn8M04Nw7Crkb9aOROvN4GcDPg9V81inkc2eCcKl1HPG+pfeHdrhXm5BoJDnTN7yLg==
X-Gm-Gg: AYBFou3cMkLAVrirVg4+HHu+SzGsJvG+utMaLSpqpysTobCau4sVZf/M8aEDcMt4L1K
	aelDUY1IfDphB2ksh1t8wUTNd+zUZFzVMbfXmbITChb+wGR1esggbfPi9hb96bo1Qb1mjiHRo7i
	e7i/pl20YUtz4SXPQKkXx0+2ftTOtj7F8hlktLJYCgGEKHJdDglqJMI1WkTeT79zutmA9nnCLWK
	DOcrjiyr9ch4/wBsHxD23H04NuOio15ae4i1F31LwI84CoAVMFVqJtgJSlh3jLodOSs/yxvuzMQ
	txbsahzKQOVM+c3FW0+KuFCqgnTGQCtcvhqOGlunguBF2bYAmAR23bzZ/4hybfKDTZSnuqTTRLt
	666Kt3XjdbJfKGMOl1DrvM7yEu+4eG4bBdBgGuSo8G/XSCRYk55eEhbB6adNnJeT/H7dH/gLdHA
	Fg8hVWY4qFwWtGSRVF+oWY8/C2EaQ1eiP2dqiKlHeKdTSpHgpvQHTGK35e87r0MPnfG9ZJfpHJJ
	5+zTy3aGbxWHdqOtGrliw0MBNEbYT0lglPXASxQ0eAKqx+QVx2jGrouh6r9kuOU7BeSCGFMS6i4
	j6ATfKgCzkmM0oUETwQ8GDmWTbE4uAxD+WjKuox4RhbEjtNt2Hu+FnwatZ/U0jdyphen7r4Yjs7
	Be0kbD9YdHCjIMn4=
X-Received: by 2002:a05:6214:21eb:b0:919:85a3:313e with SMTP id 6a1803df08f44-91ca4b32cb1mr132715186d6.17.1793579830838;
        Sun, 01 Nov 2026 16:37:10 -0800 (PST)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f23754sm77043066d6.9.2026.11.01.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 16:37:10 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	shaos <shawnq1@163.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Vega <vega@nebusec.ai>,
	Tom Goff <thomas.goff@boeing.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 0/4] net/sched: fix short-skb metadata and namespace boundaries
Date: Sun,  1 Nov 2026 19:37:02 -0500
Message-Id: <SER-NSBD.v2.r0.20261101171325@mojatatu.com>
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

This series fixes three independent boundary problems in net/sched, and
adds a tc-testing case for the third.

1/4 act_ife: encode a configured zero metadata value.  The u32 and u16
presence callbacks reserve an 8-byte TLV for a configured zero value, but
the encoders returned without writing it, leaking stale skb headroom bytes.

2/4 act_ife: require a full Ethernet header on egress.  An undersized
linear head can make the encoder read past the end of the skb data.

3/4 sch_teql: reject qdiscs from another network namespace.  The global
TEQL master lives in the initial netns; a qdisc created in another netns
could still mutate the master's MTU and flags.

4/4 selftests: tc-testing: cover the cross-netns attach rejection.  The
existing 124e case attaches a child qdisc from nsPlugin's namespace, so it
is answered by whichever of the two rejection checks runs first.  This case
attaches a root qdisc, so only the namespace check can refuse it.

Origins:

1/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
2/4: found by Sashiko (nipa and gemini) while reviewing Victor Nogueira's
parent act_ife patchset; independently reported by shaos
<shawnq1@163.com> with a reproducer, which was verified in our test
environment.
3/4: reported by shaos <shawnq1@163.com> with a reproducer, which was
reproduced and verified in our test environment.
4/4: follows a Sashiko (nipa) review of the repost2 posting of 3/4, which
pointed out that the new check masks what 124e asserts.

The four patches are independent.  They target net and the three fixes
carry a stable nomination; the test case does not.  They are sent together
because they share the short-skb and namespace-boundary review context.

Jamal Hadi Salim (4):
  net/sched: act_ife: encode configured zero metadata values
  net/sched: act_ife: require a full Ethernet header on egress
  net/sched: sch_teql: reject qdiscs from another network namespace
  selftests: tc-testing: teql: reject attach from another netns

 net/sched/act_ife.c                                | 13 ++++++-----
 net/sched/sch_teql.c                               |  9 ++++++--
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json | 27 ++++++++++++++++++++++
 3 files changed, 41 insertions(+), 8 deletions(-)

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

v2: considers comments from Sashiko (nipa) on the repost2 posting.  The
cross-netns check in 3/4 ran before the "teql can only be used as root"
check, so every case it did not catch was answered by that check, masking
the assertion that tc-testing case 124e makes.  The root-parent validation
now runs first and the namespace check second, and 4/4 covers the namespace
rejection on its own as suggested by sashiko-nipa.

1/4 and 2/4 are unchanged from the repost2 posting.
