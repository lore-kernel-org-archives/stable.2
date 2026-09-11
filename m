Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D13911DD
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103776; cv=none; b=Ckk6Ej3FNd1mrtdoI6aJ1+mqie44xa3xAFySfBKlt8rGklcOEnJWe2VHCQZm5TiZMNMmMPyChLXuC404/1I4JsQFnXetJyVRI6hCpO+pLASiUUWTsSYC2cc+Aue1KNiKX27nSPvz2lAmZOT1x0YAyWIQMELPfWmUnAWQ43V4qRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103776; c=relaxed/simple;
	bh=TLAv+lITIAz9Rqr/UUY++KQ+Omu5YXiO/SRrsb8Jcls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHJkLBTPMGJsaUGSzYos/QIjb4LNBBusTkPS6/u15r0GCKQgrImmjcPmQ4XPnA11edQv7K0qOqbOguazCHofBVnyfHNi5aEOmxmyC0Oe1NEX3luCG6zAikLloOXdYwjvTZT/bODWzZTMgMqoOjlQEIQ/wN90GaqhdgBDsiWN9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDzdhdTI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDzdhdTI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so470281a91.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 22:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103775; x=1789708575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ArmzfnWDQ/PeAsKx2cuKOwfwqEy95uaVW3+H99u9LlU=;
        b=UDzdhdTI4dJCJcjELosEG6+C9av5Z+YNj0UHmVKQyaLlvE8mnMRio/hYDMA/jrgt92
         iuzsWMFoykU8+7cL5DPS6Nqg6lMxay76WEDgKVwVlN+HABrn+4/4yWRmNW+jYt3s20aK
         fZLBrSXUp/afpi9J+fzbhKelYD6+aUi+RrKS5OsUF3VDLo547fXBNN9t59+/gr7jBRGA
         3iNo1T1FaFbvrGUEvkePW53kWgY+z40a5ndoZFzysQS30v6awRZ8czcYBz27fvYZelFp
         v6SAXpsxXG1ncEGgMXhscplEYEqLX+V4LO2zVIzxqG6KAlKshPgUxXewEW14JBJScq9K
         dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103775; x=1789708575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ArmzfnWDQ/PeAsKx2cuKOwfwqEy95uaVW3+H99u9LlU=;
        b=bCCSTlfqYdhPrYRIJ6Xu5tValoF3pfII5B7pWH8c0WGlU7a/RbyXC85z6IHfFygPzW
         2vPOcqgoQW7TnR2t4aN9f5RHMZGTXWqjyWqRreGehrwNOrOhZdeo4iiSmXkkMon1+Igb
         LJatNBRdf09l6T3gDlMgj24ALihGcWW3KLeM6u5tzglwhzslS39sLoDZPkryhslbGbwJ
         tB1Rq5wm4UJbDAYmOs9UESrGxUUqWrlg6kcPZjeO41EaT974UY6Z0FmQXnk5RLFEGnrv
         fOuhUsq0K+0DcdiiCiqtFDH9tiedojQZjF0gmx4DF7tWF7KQM1etNnP7+kh77V2Lhl1q
         RH5g==
X-Forwarded-Encrypted: i=1; AKwUvBxtt67puCXwxSLOOok9A2E/l0jSizAHqF5KViJTl9tdTWZKzBEYgYkHQcfcx0sBJZR5QJdUHLo=@vger.kernel.org
X-Gm-Message-State: AFuF++khQYUe4VO/WpY63QcHOghSIKhCsOvA5NKgwRX7m+28pUyphq6D
	ovew0rs2SFJbeVunnT2367N9gS5pMLdsEYCTEJc79yXS+rRVevZicIbx
X-Gm-Gg: AYBFou1klZ3BwXiJdL5H0PA6cpwdQ97I11zPxRR43l5OUjWt7Y4OLMEea2gLorGBNwv
	VhTY9pvM2IzeAA23yUG/uNi+8galgd4jTv3zzCGyzLxtvQhYFJd+v1TIhjUKzxSWvK0y8M8NKpU
	VwRpYrlqozhoxYEI01M6Lqo9HG/5jvR+LpOrZS6C1A6JY4Gn58A4Hb+FdUgxdyoqSvW2HYRxlB0
	ev1RznHgznWjh3JaXme+oODS8IbOA9yA4NThUns+Abn973TjGYVdGx1eBOi0BQxbq40ZPKowF1J
	1akFN4LWHCfUKlNXvlSKq7T0NiNDHFkdJPDZWxViHxyHCWHB7rbHx6mkmt7xU9YAfbToJE5ewgy
	PQJfxzQQi7ovAecpjGJBBxPHJjFG/h/Sjknlys6yDu4Tuy6Ap+Edvjto176d1XyaehOhIMgCLCr
	Ezf+KUqOdJneX14d0tsjDT+lPquFh2QoFNocJEGQR8I2ppM6+ZTZ8rZhjeKjoblNLZTGOFeFW/t
	GtAy/7s8qPiDf6+b+1SIPhJXP1nQ60h4D6vlQ==
X-Received: by 2002:a17:90b:4cce:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39d9bec4d91mr4189394a91.10.1789103774430;
        Thu, 10 Sep 2026 22:16:14 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602d8sm2541024a91.3.2026.09.10.22.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:16:13 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: pcm: Fix race between concurrent START and hw_params/hw_free
Date: Fri, 11 Sep 2026 13:15:59 +0800
Message-ID: <20260911051605.3448607-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

snd_pcm_hw_params() and snd_pcm_hw_free() validate the stream state
only once, under the stream lock at entry, and then free/realloc the
DMA buffer (snd_pcm_lib_free_pages() -> snd_pcm_set_runtime_buffer(NULL),
followed by the sleeping allocation in snd_pcm_lib_malloc_pages()) and
update the runtime fields without holding the stream lock.  The state,
however, stays SNDRV_PCM_STATE_PREPARED until the final
snd_pcm_set_state() at the very end of the operation.

A concurrent SNDRV_PCM_IOCTL_START takes only the stream lock and
merely requires state == PREPARED in snd_pcm_pre_start(), so it can
slip into that window: snd_pcm_post_start() sets the state RUNNING,
arms the driver data plane and fills the initial silence through
snd_pcm_playback_silence().  The data plane then keeps operating on
the buffer that hw_params/hw_free is tearing down concurrently; once
snd_pcm_set_runtime_buffer(NULL) has cleared runtime->dma_area, the
silence fill in fill_silence() -> get_dma_ptr() dereferences a NULL
pointer, and on real hardware the device may additionally keep
DMA-ing into the freed pages.

Close the race by leaving the PREPARED state atomically with the
entry state check, inside the same stream lock critical section: a
START that already completed makes the hw_params/hw_free state check
fail with -EBADFD, and a later START observes SETUP and fails in
snd_pcm_pre_start() with -EBADFD as well, so the data plane can never
be armed while the buffer is being freed or reallocated.  Both
functions impose SETUP as their resulting state anyway, hence this
does not change the state machine semantics visible to user space.

The buffer_mutex/buffer_accessing serialization introduced by the
earlier fixes for the prepare-vs-hw_params races cannot simply be
extended to the START path: the trigger action has to run under the
IRQ-off stream spinlock for atomic PCMs, and failing START with
-EBUSY whenever a read/write transfer is in flight would be a user
visible regression.  Transitioning the state atomically at entry
avoids both problems.

Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 sound/core/pcm_native.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 62324282fcae..6040eb752873 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -805,6 +805,17 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 			err = -EBADFD;
 			break;
 		}
+		/*
+		 * The buffer free/realloc and the runtime field updates
+		 * below run without the stream lock, while a concurrent
+		 * SNDRV_PCM_IOCTL_START only requires state == PREPARED
+		 * under that lock.  Leave the PREPARED state atomically
+		 * with the check above so that a racing START (and the
+		 * data plane it arms) can no longer slip in and operate
+		 * on the buffer while it is being freed or reallocated.
+		 */
+		if (!err && runtime->state == SNDRV_PCM_STATE_PREPARED)
+			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
 	}
 	if (err)
 		goto unlock;
@@ -966,6 +977,13 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
 			result = -EBADFD;
 			break;
 		}
+		/* Same race as in snd_pcm_hw_params(): leave the PREPARED
+		 * state atomically with the check above, so that a racing
+		 * START cannot arm the data plane while do_hw_free() tears
+		 * down the buffer without the stream lock.
+		 */
+		if (!result && runtime->state == SNDRV_PCM_STATE_PREPARED)
+			__snd_pcm_set_state(runtime, SNDRV_PCM_STATE_SETUP);
 	}
 	if (result)
 		goto unlock;
-- 
2.43.7

