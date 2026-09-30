Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C5511E80
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780338; cv=none; b=dtRx6Q6u7ZlFbhELyJNgoTpLOPI70Mq+7CUJj5SQ9EArxBkLxTj3eyQN4fa70oqYbT5AJURPS0wtWToK3j4NjbcL74WhuaoTACgtldEDEFspVzGXfjtavKddSD0oueUKgZhYCUr0qMn6WcV+d+9C6+aI2Zuqe3hg9+TiaD3m0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780338; c=relaxed/simple;
	bh=2qdW7qPc33fgDVeHmWXq/lgAc7O3FAMhsbwbxQk6sSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAH7OqUeoWsmjsJi1LSWCVLlUAlmr8M0jdgGk9sYIcZ6d1M4NilwL0GNx826IDjagvszHIQjx75urRorro/85rc2bg16Qo9sAnqSX4ofhlnmMBxUoprskQsK00HZMWMLgQajzcIRjqvP81HXYEDfzSBXxbfPy0cxpLgbIXBrHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ0ZAEeA; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ0ZAEeA"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af4663da5so1549354f8f.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780324; x=1791385124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul4pen9AeiIUu90Z55hg1G+SFMqGb/rwLYXQ+Sr+HfU=;
        b=QZ0ZAEeAVGIoNgbYxkqO4amtVBbjKHraGACOKhRK55OWYGE5LhG87HuJEU1gFSmO7z
         EovFa+ts/lxINGQGzD1sHGjnWVe/NSfCyU3xgip8tQTE+vr2/B4rcimmuvkGQqMgm+n2
         E1RJeludAergDPXW+FcTXP02GTAohI7my7ACFTPO6xGdCULGb7XmQo9Mc4u+YT8dT1fT
         SCjZvzzwixLTKYsrBy/YSJ3tq5FidZZ7P7QrtbUww/c5T2uv7BXl/tSKGdiDtY8ZqSmP
         V+DT971+ux0PlGbZjuDr9kS78tPOaO+kNKf5BLFNc6FdtwM0mALlS+k7Hh7sG2IxPesC
         EGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780324; x=1791385124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul4pen9AeiIUu90Z55hg1G+SFMqGb/rwLYXQ+Sr+HfU=;
        b=QBMl8hjQSfU2gjewNuhT5ZyGuJOf/4RuGt0qrlS6j5NUWTq45qym1Ol9qw9y10GdNM
         NprbpXXVw3aVoWwaJbQqCFS3pANCTmA6oz5QoQ2z8kShjO4sSJZbpcBRrtleDd+9LRGD
         ByhgWsV005FfRkXQpdL14ggUo98lL9iEFx0P1O/O1EQy8UkwBxSOYlzS1iPZZGxLzGv+
         ovPLcAPfVq2dqPtTknGzq5AgsLkT5K10jzlycD7/yF0aocFwVvmMPr6SOrdkz09HTBKf
         9Oxhpx55QetRnFhcQBj+PrZKYhO70HgJIeWulngU9mBA3ST0LRuxS/n8JInuPdlLRri6
         6hJw==
X-Forwarded-Encrypted: i=1; AKwUvBxtI1rCemMfXi3mRbscBIwyPv2XzHRyZ8ycFA0u+9hmte4UWcl2afjajUhiNbiRjhY3uQr+J9k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCl2exAj6y59CdzWmp1/42J4avjq8SBZyqH94Y/y0v2iEv3TVW
	Nkvk8Z+b4QtOOxOkk+HGejwTFAl3YOHJntiLZu3MkH/RoPiZ8DNVEL6V
X-Gm-Gg: AYBFou1zcBJyLnABhQkCtIIm7A0b2O9sF/KUFpFcQkCG6N3+i1UQgth2MMp1EE316mg
	qxwi/13XqpVHetaxC+KvhnIeWn3m3duoo2lxywEh6G5jHKoYMaL38Av2mshuupfiO6/O5FGpa8x
	prNi8lcEERSALMQdo7BKRJxCEpEWOK983QLHO23DIZ/pUpFzFFS0QWHzYul7kxmBQfSxus3/D7A
	8ohixS6UTXPfFR4sxjv/rWgZlvyyuOXyVZku3X6B5d58mv70yQ4A2HJNXDG2EYGwwOLGcV2A10f
	TjLvRyo8TkUtVnjywKcgNLyH+MIvJ9cGkY75gKtnJFI8+FtaMVGjm3shBqzKmooFl7RKXjZd7Rl
	MA96OJ+91AuAL61zViJW+bQ59pHpw42TRNxsuBpPMLElA6gVCyNt8fGJQS5nTsy6NOGgn89nsKU
	R41DlqBJnHqQBw1frW32xATA2+e12sMzpZLLbtsY4iL4bWXdkJChUBJ+NYjrVuXiO9M28waOULx
	Siw
X-Received: by 2002:a05:6000:4026:b0:487:c3f:5750 with SMTP id ffacd0b85a97d-48b02528ea5mr3207236f8f.40.1790780323426;
        Wed, 30 Sep 2026 07:58:43 -0700 (PDT)
Received: from archlinux ([2a02:a31d:a2c4:f100:d7a2:6e0f:6daf:6f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b029bf85dsm4430576f8f.13.2026.09.30.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:58:43 -0700 (PDT)
From: Jakub Gawlik <jakubgawlik13@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Gawlik <jakubgawlik13@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add micmute LED quirk for Acer Swift SFG16-72
Date: Wed, 30 Sep 2026 16:58:39 +0200
Message-ID: <20260930145839.374762-1-jakubgawlik13@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Acer Swift SFG16-72 (1025:173b) uses the ALC245 codec, but its
mic-mute LED is not enabled by default. Apply the existing
ALC245_FIXUP_ACER_MICMUTE_LED quirk to enable the mic-mute LED.

Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Jakub Gawlik <jakubgawlik13@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5127a111c59c..fbfa515a6b57 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7198,6 +7198,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x171e, "Acer Nitro ANV15-51", ALC245_FIXUP_ACER_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x1731, "Acer Predator PHN16-72", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x173a, "Acer Swift SFG14-73", ALC245_FIXUP_ACER_MICMUTE_LED),
+	SND_PCI_QUIRK(0x1025, 0x173b, "Acer Swift SFG16-72", ALC245_FIXUP_ACER_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x1758, "Acer Nitro ANV15-41", ALC245_FIXUP_ACER_MICMUTE_LED),
 	SND_PCI_QUIRK(0x1025, 0x1826, "Acer Helios ZPC", ALC287_FIXUP_PREDATOR_SPK_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1025, 0x182c, "Acer Helios ZPD", ALC287_FIXUP_PREDATOR_SPK_CS35L41_I2C_2),
-- 
2.55.0

