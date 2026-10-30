Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363807;
	b=U9EVhgYosSWNxfqLaT6m9eiSU+HgpLnB2eyLF+qNoHYxo1LwnRLyqM3m0NHMuy6V2Wct
	 ntRHUjcewyJoNDb8HOfyrtFxR1Nd6rLvmYqPbwT4284orM+69bUMD8tJDsAy+cpltdm0I
	 f2k+nZ5avtcU9qhR58TktmyeueloHhW2pV8RB9ECtn9tRNvKYfaDlpFHth+QiMg+PR4XN
	 ES/HThrCTS/Rvx8OI43ngD8g8349oiSKIa1N6HbJXT/6XrE3hHVXFALdo9NW3PluoqwOp
	 5B5PhIIwNY/JdFRVbUvTdEEWmLGTbEJGRS6yFU4XaXp6kNpv8zQxbLzlATnELEkIIJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
	b=H3ex4J8FJFV4s3XHmCk64l0uhzAI/YCRYJa9Lr0BxN+B1WaYtiZw1QcK1ev/XjoW4TsB
	 J6aa9LIwBAEXDWzTvUUlmhfhpcuPbfEAJc7ySRw+23Ys6AABTh5CPdb9O9Ktjeu9iNzqS
	 V5whiScKUXzeD8bAyxwixSO/SL4khpbNWwXHz4YZUEboTdnHvCMtprgn7F47MyeFA9tvT
	 /2LisE5tals9uZcxX/3ErLdSUtCmTjbv85osmLfdPRcwk4Ro1JRA6SOwKkor+28s+wLNx
	 K04eeTzPjBswhAm+WugFHNulSLmwIxYhl15fEtT+xCCLZIoJV769I2irqaKL2w1469w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj3ZP9Cf;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FF606A31D
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675FF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj3ZP9Cf
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1702812eec.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363806; x=1793968606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
        b=fj3ZP9Cf5Y+e7SRaimUSFagvNtkpeoPKFhmaUN/TOWxv6iWzE/oJaP4Li4NwNzjOSF
         YwditmzupbjQkaHhRBJK9P642j5o13rhvL2p2Xmh/RysNjrrSRaHtVDudU528cNZNRzm
         ndAZVJ9IrDhDAlLg07xslGNbl/1VLsnxzZ/jlRAKdsFsth8qhq0p8IZq+vACSXKox5oZ
         blxBPKgiWHn/p0w5vxI+udQejA6fBo6JKV7jdXSromfqxshAuHWOZB20pnGBOowFX1lT
         YFSb1tsVgw/XP/alZzIfMOkIetsIXRWL2AO6Ob3Aemg3ByvLsDjGHUKqICWJB5JF1me/
         AkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363806; x=1793968606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
        b=v/7rw1G3CsWYgCyunWvWRaxUEcLTGcFvY78hyFveIdcertE4UOERmSIbT2vIh6Ou/U
         OBhoI133cGLZkR+Uk8X9pCg0JolGITCS0XdFNwaVgzzmpPEpUGMIz9zaKNh0rQQsOdBM
         8EXrqBfWdsPr31647B3W4lXx5WBW2HYPVAm5T/68adnNydwiWlCNXVOpASAJT6qyWvC5
         +msUikK4/3bTDaOhZy2jh3kVAxLbouvv06K6oPKd0vVSIlwo0uLysw2vHGFO1Y2VSbXo
         3jvYpX0FiJhoVWIBw/eQ6TRcSo8RfPAwrlp4QFLYlGwjHpA3SElplI5VMxqDY9ghDB6W
         8o7g==
X-Forwarded-Encrypted: i=1; AKwUvBz17C8X2VFB+JS08FLhVzj8SvHrfpZmf8EpNiTav5IdX22LjaI2jTc/SioJyjkC8ndiBAI3Dp8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWq9LGPw9zVxXV+asVwzXL3oZ7PNW0/U7MHsrMf4cSwJ+PM75O
	RaULhNPbwyaosRaobUCX3olAqakmYFAB0inglvxdFSV4IN9Xhj2BhwEz
X-Gm-Gg: AYBFou33M5djX8z+6MG6by1r1JYt9HvazAcA9B12ZG8D4kga6vWknzhfhzShfnaeIar
	BMfu1e0IBDmqJzI/KjeoOGQ6fxj24bjEWfcEik6IbnBvsi0v8QDKrVQiVvCOyQA4lcTAn7kV+QU
	SNHyo/KvDxwm6iSYqo+VJzlBh+Fci/Gfp9EDUoXda2GvMpwIaqHHGZxqO1BuHcoMvc0vU4+DUOP
	TjHFNjRKeXxFoL0U/83+cWfbqr2PvR17nk1gkDvJmvCFaxZe95o5xAWERdXHR9OErIJ4NzsT7HP
	SF8sE4w/YRx3cloGUlckl00cmh41bN/P8LiZPSCIyE+CSGL9uh7fDuWFEPoeiic3xWjU9vKC0oI
	Q3INsyR1m2jbVcPPDHwMq4F6K5yKsL5aOPyqlwv3w/kmtITYGYDRH4+F9cjoaahvU17NMp+bSML
	mPkh57qwV52i5eSnX3Wo4oTe1hhIo1Tu/07ickJWDv1c4IFs/8ihhqZuiR8G+RqoihFeBd0X3qT
	BaR35Ks25TSOBDRF1b7n9MLjQuHnTsakylFrOvuogw+0jXp5EIJJ8OF5RBzTS26XPg+4iqmrtX1
	JLDNG++PZ80Ob4lDjbK+Vc5+IJsCVDTr4TlBQ+mZGztScWyGv6SZ+2JUvhqsq0osjbQ=
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr4018459eec.27.1793363806237;
        Fri, 30 Oct 2026 05:36:46 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm6382373eec.4.2026.10.30.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:36:45 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v5] tty: sysrq: clear the old reset sequence when reset_seq changes
Date: Fri, 30 Oct 2026 20:36:40 +0800
Message-ID: <20261030123640.263164-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Changing reset_seq at runtime does not work on a keyboard that already
used the old value, because each keyboard adds the new keys to its own
copy instead of replacing it:

  echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
  (press any key)
  echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2

F1+F2 then does nothing; only all five keys together reset.

Clear the old keys when the copy is rebuilt.  If sysrq_downtime_ms is
set, also stop a reset the old keys already started, since releasing
them no longer cancels it.

A key pressed while reset_seq is being written can see a partial
sequence.  With this change that can happen on any keyboard, not only
on ones that never used a sequence, but the window is a few
microseconds and not worth closing.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5.5
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v5: Dropped v4 1/2 and rewrote the changelog.  Tested in QEMU with a
uinput keyboard: the new sequence resets, while the old one and a reset
armed before the rewrite do not.

v4: https://lore.kernel.org/all/20261030045854.153556-1-zhanxusheng1024@gmail.com/

 drivers/tty/sysrq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b496..a90e97a6d7aa 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -689,6 +689,11 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	/* A reset armed by the old sequence must not outlive it */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < sysrq_reset_seq_len; i++) {

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

