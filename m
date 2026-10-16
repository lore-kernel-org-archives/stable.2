Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB637C10A
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134411; cv=none; b=Of1PzzKCFrJNNpPmBQUpRy5pRVGYB49oVNuuioxzGB9ryUIsa40noMbbkHgMQkqjTrbJI79aHkxS/IfnHsPRkGehgii/qF2qk3oIi90AppFgNzTTNsJRrKEl+FqH81jeXOBYJ36ZWgtyV1evXoDAVnQJNrMfpxkkdkJcGpUjveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134411; c=relaxed/simple;
	bh=USn6w+07pq189JJfQZSEywdO98S2dAszzeqvb9TXxqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdeNH98AsNbwYWeQedKNcSyyLsfV/zjuRmciQktBbONQfkeY/8ugrCupUyo1caSaATZWt1ixjqFUO0kK806tIJBhZUvf9n0DdPBTZC3QbDiDRzyOB93QFj9Kes1OE+eF0ORwQJRsFyWcsEknNpJ5Os4zduxnLJGK2uiYmujc46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km+ZU3If; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km+ZU3If"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so6435162eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792134408; x=1792739208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFiWoYztjzXHZLP55NqN/1kpppjMYdgZZKZWx6u33J0=;
        b=km+ZU3IfUpD4aGLtwUfJgHJkXvXQotBXzQVplB1FmpJpNUBjgNCwJphkPMWpoelFFo
         bJBsrXkIGFS8r7blZvmf/cxOCv3831xXw4pLStv1eGD0J9qkJnhgfMixj82eMVLvD4QN
         689g+hZfhzU1qrcBEGzgj0EoULMdFUgL7y4posnF4owhwn0hSC1MssSAo8GNf8X6TzEc
         apSF6CjhJSwJAyOz3Q1jZTXKHGtJLw3IsP5iGsprDk9CQdlwV3brQDdm535e7zJBlM+y
         8Z6dxzdqb5UoCJMuu4xgM/VcRtMDQJFwdHABU+8SlzDAX0nJt2kuJYNldok04fsdXmAF
         Hx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792134408; x=1792739208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFiWoYztjzXHZLP55NqN/1kpppjMYdgZZKZWx6u33J0=;
        b=XmvrfgC4vuOnwSQcNqgElmneXLOX2Loojp08kJwQfDAWJtf0tn+zM3RoG6Uv+N9+W7
         M1hZ9hZ7IkYNColGDoPGRnb56yxI0a52y1EadAsn5ZvCJTAmhaCuQIrd5C2S8NtU80xb
         wt6heJy43ZMdjvS3rXu8fFM1WlfiAAevCLmww6SPQ5ZQsVCtULXMltvfH3YGURvgZ2kE
         cwljd156CaAm7pupKURkcP9NuOLqgpXEX5xWCk50JVypXyqnX/kEBBX5mDppOZHnCwwZ
         e67LoDUsedyR/y1d09uv0dhbxordBWJfgTAMZVoC3LxGFLHch57p1sco4yfChDnRRvRh
         qc9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwTq+GB+zHwCWE8EyefKId1Ykw9pA3BXLcoSRFnH5k3D0pDPdGYpB79XQQmTZ2dxqMop9CrvNQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoIV2tzDvff6cTpH16KXYjdPSRa4k8yS/LgdSpSGWMdebw23KU
	QKAGHqlYK3GSecPlwWhOwRmlmk0jiD2b1Oyg34T5wjdUKVH1/xTzJF4R
X-Gm-Gg: AYBFou0+L/eCosX5B3nvqC/SkfuO0+ajk2rdJor3DeUcmsKBf8PIdeIsm8B9C9AHwwr
	+uhaA4otxJjfCnzNdfK5re79uQKBrHKFg19aInbn4hsOal5+TBjoDxd/bceorY81+KTAI4OQqLd
	HwQvZdOovY91umb2JD/FshEvkSUU4J4Q+wPcJXkbGKCCbZ9njUSsF/s2MqVE0DVJ1YZ2AXLmI8D
	UfS08hOG4OMY3W/+lpeKcQbCjRmq+3jR74ZZY+26fOlvwH42IoWAPTJg5stDLqgfJVmYRicas11
	rAiCy2Bc1W/sYrDqjkmFmnXN8MDnzhQNAbCgAvZlePBuVVd8ORAcgvd1sk/sIYkrBHNhLVfvlHT
	8m0OvpO4k6xx88Q/cru2LFAQmdqaECfntwZSlEk132q6Gc5bpvgmNkBCQbIbj7JDVXdoDNhkn61
	RMEvPELXhGjLlxFRdsxlWAv0JgVylgRPYMoPqnFWlfeXcmfvYi8+Iy3vvNrPX/0kXll/yAfJ7dI
	4ZKoOf6uZI=
X-Received: by 2002:a05:693c:88c9:20b0:34c:79d4:ba0d with SMTP id 5a478bee46e88-3537dffd5b2mr31110310eec.14.1792134407688;
        Fri, 16 Oct 2026 00:06:47 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm5005237eec.3.2026.10.16.00.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:06:47 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	stable@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH v2] tty: sysrq: reset the per-device key state when reparsing reset_seq
Date: Fri, 16 Oct 2026 15:06:36 +0800
Message-ID: <20261016070636.2559899-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
only ever __set_bit() and reset_seq_len only ever incremented, and
nothing else clears either.  struct sysrq_state is allocated once per
input device in sysrq_connect() and lives until the device goes away, so
both accumulate every time the sequence is reparsed, which happens
whenever the reset_seq module parameter is written:

  # echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq
  # echo 59,60     > /sys/module/sysrq/parameters/reset_seq

After the second write reset_keybit holds all five keys and reset_seq_len
is 5, so the combination that resets the machine is the union of the old
and the new one.  Holding just 59+60 counts 2 of 5 and does nothing.
Releasing one of the stale keys decrements reset_seq_cnt below zero.

Clear both along with reset_seq_cnt.

Doing only that would drop a cancellation the stale bits were providing
by accident: with sysrq_downtime_ms set, holding a full sequence arms
keyreset_timer, and the timer is only deleted on a press outside the
sequence or a release inside it.  With the old keys gone from
reset_keybit their release matches neither, and the armed reset survives
into orderly_reboot().  Delete the timer as well, since it belongs to the
sequence being replaced.

The boot paths are unaffected: the command line and
sysrq_of_get_keyreset_config() leave sysrq_reset_seq_version at 1, so a
freshly kzalloc'd state parses once with both fields already zero.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v1: https://lore.kernel.org/all/20261016032732.2328852-1-zhanxusheng@xiaomi.com/

v1 -> v2:
 - Retitle from "Input:" to "tty: sysrq:" and add Cc: stable, per Greg KH.
 - Delete keyreset_timer when the sequence is redefined.  Clearing
   reset_keybit removes a cancellation the stale bits were providing by
   accident, so without this an armed reset would survive the release of
   the old keys.  Reported by the Sashiko bot.
 - Fix the description of the breakage.  reset_seq_cnt does reach
   reset_seq_len once every accumulated key is held, so the reset
   combination becomes the union of the old and the new sequence rather
   than stopping working.
 drivers/tty/sysrq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index c2e4b31b699aa..013ad3a500703 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -689,6 +689,15 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	/*
+	 * An armed reset belongs to the sequence being replaced: once the
+	 * old keys are gone from reset_keybit their release no longer
+	 * cancels it.
+	 */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < sysrq_reset_seq_len; i++) {

base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.43.0

