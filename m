Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911725;
	b=uvS2D+AzcvGZgQnZJhX8yL4ykVeJdOcdHASJIiATdeG54O4JS0ci5p7+KsaTzHiVoxcg
	 q2k/O9yXiKi2jboHj1l7JFsaiPWd3veG6fk/56/wWJgS5TW8OjTB4+lNxDzjhZvPuYoBZ
	 7IfE6F5lVfnef3k9LBH/e8xgSxrPuYO0wsRFaqrkdELAmzkieSoa00ON98D6ngryrZPZ4
	 TAx4RoSp1gM8udzTULJtuGCqcPd29DyAZ/NrK7q5dhEl4LZa1srbfwt9yuCzzug6nBvTa
	 btlbeOdXgqHpcU6vT9vAtoztXqp0IZDsou2i/JcFjjd7BosC2+RjigYeREwWlVH8AHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RuyZ4/NgPAofSNXbBjGZkZZB9QA0/aMDca1cWrs9WFg=;
	b=DvlbUp3LX5ua9w33fPWmfns4PD60kb3Zyp7wWaqQHqEQLTNuBhbjiPxhNu6o2kOA9uYN
	 iljT9Gquo6etGWUwCwr6Xao0f9mZgLNuzUA2x67q/h39xMbit6I1ksZdJGa35oAoytKNI
	 UCuicxLxVoMg3Cyz0Y8yMgc7h2KHwXEixXQl1rrFFwBs+5KTARwzwvM8OiqL5gkZ3aG6i
	 fBW+mtU0tvcz9oh1XqLUPrQ42ICStTnOH2TkCdAjDcKFV1KxrGlGxUT7eL/R3xbvjWU7J
	 bjYpNxYdGUfA2VaRQeDbKtpH5JHLxb+dEQiY9oOvQwx972S8Rpj+qfbgGOoGOskWh1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RvFXG8Wj;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B1606A898
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 10:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6B1606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RvFXG8Wj
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc751eddf25so3472295a12.3
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911725; x=1795516525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RuyZ4/NgPAofSNXbBjGZkZZB9QA0/aMDca1cWrs9WFg=;
        b=RvFXG8WjjKnTMy0oENVxlESIdVeF6WKEdiNDXunqUUCkkvQvKrb1EXZV9xmGB08fS3
         GKBazE4QO+VsYoH2bZHPTRAvxGv4vB31iiEM/JNLZ+0ti7GUimE9nOHnUyWU5J+oxavn
         Usr7arx6vVCNPU0a0O/knm5dDC0CPAlKkRY+lI4/OwzgM+9n7B61/hvjrn9xMv/3vf41
         MaBmT7CMkPOuR1+8iWIJEUqhi1dzJ4sKDGGwtXG7WmbGSjsvwMs5u+yaDQ6lUdy31rP6
         SPBda7tpj6zYniwGPOHetVokVPwpScwCsEiYqFE0y6oRJCAuK3KxHcP9sXQUmXeWuTBZ
         3neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911725; x=1795516525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RuyZ4/NgPAofSNXbBjGZkZZB9QA0/aMDca1cWrs9WFg=;
        b=2ytNPAjcGARmDJCAVny7His5Ev8UaYtWnevFfabDtJhYrgpD4HnWNQo4OMM54+2qVg
         Yp0bZ7Up0DEEcSxWkMROh53EqJD/Q6A0urjyCQPhekbakhPpliaTNIqZojPWg553taGH
         4WG6EOD+BxZ2Y3XFCl6VgL8oOzueE3uzerhX5OJaTVI9oBGziIhJD6gMW2wa4Ev+CVj7
         HKnvynZm9P4udFF7Z7pBwrCv68dbblUX1kp4iIu/VwnASBZqovVXwJvEdIJZCz6XRwgM
         Nm/QBo8BXuZR3bU3Lb9O+gyY3WNQO94pARr0m2ENLFsodZF3bZbJ7wUHV1jXnvopgnLy
         iybw==
X-Forwarded-Encrypted: i=1; AL+hErGSnXvqUKV6B+KlCa5j0yO6Wmw8fbDnvEglqDO6CF9OOJZ7U2wBm2lcZ6VFMm4nF4TEEsUwPBA=@vger.kernel.org
X-Gm-Message-State: APuU4Z84l7MqbOlFElvAXDIO0izyhaURxl2cze87EJLjfeiZCFiTjSkH
	BL7ikyYFaDDq0jxNim0rwqJ6pjyNdz/msImz23B/U2NVl9TqKE3avqq7
X-Gm-Gg: AZFdTZd4uQvNzFoRhKTtfa0MO4hyVYFCLgp6s6XUYa/+6i7Pqq8VWPvyOUyjOaXfEJD
	mSblzQF2kEf/q55gz/q4qWSFR+ajhvO327voFBDsIgqHjqgbGKLdZQWnPWARX6Wm+X17Gn0T5rT
	ddO/8NLwBvuEJRmtB0pSuT4Jf3npmMUHaZ9JVhJH3it7DFE8BRG/HtrHZlAgJxGsc/7JIbfs2i/
	S51Dnt6yE4utjjqjNufTEv6DbNZ1GW4R3aqHafmv9DqAq4B3UsCGw+2h66fqxwwvef1HIVQeFyl
	wEDMvvViBMvDfuMEhpvrJp63A2P/XoypjP+QqP0GLPWf/Ha+tReYHPTjYrlgkiPhZguBPpwWtFK
	1FE8X8qWIaqhh8IEXNHwOlwjdAsH1pkpqIpLNFHVaD9PeMg8KkdDd4UhTuikWFbZbqq5XKEDJ00
	SNmp1igAIXLDI17XLKyPUhRDVQF1Ynz7h80M8ohmSM1nWe1i6B+I9IGbl2aU64wj+tURO4gF0O2
	tLFjlCRQ9pXJMwNlxjvEy3TZK6x9burhWk27mr7MFQW5ewiHoIF/zZ0DQ9C4amxqZ2QKWrxuof/
	Ye15VnXv0a74ceI+xvqIKrFjPVsDH3PTscaPBAloGnyh
X-Received: by 2002:a17:90b:1f86:b0:3ac:7556:8ee0 with SMTP id 98e67ed59e1d1-3b1b0b666c5mr13803607a91.19.1794911724811;
        Tue, 17 Nov 2026 02:35:24 -0800 (PST)
Received: from gmail.com ([116.162.234.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abeaf532sm3518806a91.14.2026.11.17.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:35:24 -0800 (PST)
From: Xue Boyang <fuchen.dust@gmail.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] can: j1939: fix null-ptr-deref in j1939_session_completed()
Date: Tue, 17 Nov 2026 04:35:15 -0600
Message-ID: <20261117103516.535910-1-fuchen.dust@gmail.com>
X-Mailer: git-send-email 2.53.0
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

j1939_session_completed() looks up the receive skb using the session's
current data packet offset and passes the result to j1939_sk_recv()
without checking it. If no queued skb covers that offset, the lookup
returns NULL and receive-side processing can dereference it.

An inconsistent ETP session offset can leave the receive buffer lookup
unsatisfied when the session completes. The DPO receive path does not
validate the offset against the receive buffer, so completion cannot
assume that the lookup always succeeds.

Check the returned skb before distributing the message and releasing
the lookup reference. Keep session deactivation and activation of the
next queued session unconditional, so a missing receive buffer does
not leave the completed session active. This also matches the NULL
handling already used by j1939_simple_txnext().

AI assistance was used to analyze the bug and prepare this patch.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Xue Boyang <fuchen.dust@gmail.com>
---

Notes (j1939-null-submit):
    Based on mainline commit 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4.
    The affected transport.c and socket.c are unchanged from the original
    local report baseline daf677c2c6449011ee695d55b48b5b2977a36f88.
    
    Validation:
    - Built net/can/j1939/ with W=1 on x86_64, CONFIG_CAN_J1939=m,
      CONFIG_KASAN=y and CONFIG_WERROR=y; no build warnings or errors.
    - A temporary userspace harness executed the extracted completion
      function with stubbed dependencies. It checked missing-buffer receive,
      normal receive reference balancing, and transmit completion. The old
      function passed NULL to the delivery stub; the patched function did
      not, while retaining the completion-helper call.
    - This revision has not been boot-tested or run against a CAN interface.
      The harness is not an end-to-end kernel regression test.
    
    AI assistance (OpenAI coding assistant) was used for source analysis,
    commit-message preparation, and build and isolated-function checks.
    No packet-level reproducer or triggering sequence is included.

 net/can/j1939/transport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..ecf7f245f8378 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1244,8 +1244,10 @@ static void j1939_session_completed(struct j1939_session *session)
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
 		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
