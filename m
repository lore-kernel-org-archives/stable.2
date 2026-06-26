Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DF29992B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481687; cv=none; b=jsHeTX8MrNLt/eDNG3gWaqg/PSSTtA+wU0H429jIZ9rz5ulb2cJcThWz2oqsj/Z7BtHl8p91c01XKfYXhmYXp6vmYOmBEig2ODabFc1gDXDdEZyIUu2at1Q7y2uMQbiLuA1vevQN1ux9FB2lxGAzcukdK/x899ZoCRgpwwhlTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481687; c=relaxed/simple;
	bh=9ApYCd9eoUR67lFP2ZptzcWwdF+b8C4vftRHSpyKXlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVBe27pPm7/rBT2KZ/3YlcHm2DCz0N7nnFoN4e5U/UVq76d3Oyr30efolEPeAzKRciV4Z47RZTMLMvJEp3t4dlNBzeBQmkuIfYf6iRchP4azi5rC6m5eDi8To9BeHuO+q4SWi4neb+1kT2TVmjMBPWlC6dHgGpKkRq5Qq24ihbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh0zQFjB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh0zQFjB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-46cbf263113so986427f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481684; x=1783086484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+2YgZ2mqjyDlATLW5oPiZaPLYlj8ywXc3kq+B4OAO0=;
        b=Kh0zQFjBBF4vcuGktwgqDDdrSGfqzWzFpsujbVLrvlRDNx5s1gbvGbOhx8yHq5e7K1
         H16RfvSaIAqYID235Ybf/0gWLwV7WhGJYaRKFI78ZIxlzN9OeLSvOV96OXT1700vefdT
         clCX7rZlHyxbWWTUfauGC6Su9F67TtQ8CX0tdXolo+nqz7XQYyZTnMQkFrIOh3Tr3t46
         LEOQFB+mV6mwJ21OZ3ItOzVATMt8KXsRE/j5tRD6r+ht/bTOcX1j840A8SXKUlfITIzP
         e4s2pPny1HSqQq43p9w5NrZx+juFFRfJR2JNKZhd8bxSTtg0vaKt4E7YRcgzL1tuTb3c
         MkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481684; x=1783086484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+2YgZ2mqjyDlATLW5oPiZaPLYlj8ywXc3kq+B4OAO0=;
        b=pdF4AT3b1FsrfEmPKmEyrGLpj9kCrB2gikAd6EvQZalPgPH8lxWXqRrboFhH+1fWRv
         UsU9HNYW2dtTOJ6OJOhmyTaF1WN/Xos4rufVWVQXefdE5DDteWjUDURZ3ZThkt4cc/xo
         3S4DXAGn3Q1iX9XXR/ENeZWtWKeY6trRNR1jE9bJzeDg7dBZqZduzYq3KIVo3/JSr5zw
         rPHqx383CaptUqvnLEpVDxu9lCifKugSlhjc/63IHcqpSrqyxqq4YnszaC0C3hLuqcVu
         /gde5puHwhWtua/sUkIe2GggbRnEqEONrnn5kshFAlIj8B9sZ3Pnh5F2YzEbCn1Nby/m
         evUg==
X-Forwarded-Encrypted: i=1; AFNElJ+R+G8nFhttjaiC1ufkKx0yujIKO6yVbCRMdAGEP8I3mIl4iMYyZ07esbwzwsae4931S/aMgY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcK1o6zhSKLcxSTylJ9rcAsYJy6QYRH93bsO7Xd5+fxiRJbjr
	kE7WQhCwwygKO56ir3js3Ve28Nenjt9D4BaCWHPSYsoJJzGZ5xx4hJfR
X-Gm-Gg: AfdE7cmXtJPcXGMuJE6Vxl7Efp3kzzZKJeCaVFyGb/6TwMtEBzhtmlLjTMXQw27to1b
	Q75nKqhKXn5lLndExDhvAA7uvoDorFITk5NstBdjKjMTx3ociuE7edabMfzEOixtUOa0W7bWjcV
	GhPJ+XVIpBkBz3CgSzNIx8bkampnFeN1YsmPZ8Bvkd1IMB+nqaGbA4ysItBngHo4td8dHJD27uR
	XEwSbf/81PetLoSg17TsgSWy/rRtRvHex1Edl4OK87l61WxcrZx5lm16oQfP10Ic0aJkIEIJAzH
	2Zf0hi4JDL2R/4aDaCy5loJ+CqVvHZjFNRzbbiGRq3WdbyoVrd1elPUyY8KBMisAC8lKl8B+X4H
	LkmRC4EH8Ll2sB3A4mWEmIp+K+6Z58Fs2UiIuy5fChX1fZM0CLNOMuzJWmMeY1GnujhyLfOdrik
	ZFWF5UydMw+QcG7Zlzl6Tn5U39pjie15T8O/D4fAe8WMQDVPyGLPlXxQ==
X-Received: by 2002:a05:600c:6094:b0:490:da12:f1fa with SMTP id 5b1f17b1804b1-4926689343bmr104030985e9.31.1782481684099;
        Fri, 26 Jun 2026 06:48:04 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il. [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:03 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] ALSA: timer: fix lockless tu->tread read in snd_timer_user_read()
Date: Fri, 26 Jun 2026 16:47:06 +0300
Message-Id: <20260626134709.27883-4-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_timer_user_read() reads tu->tread without holding ioctl_lock to
determine the entry size (unit), then reads it again under ioctl_lock
to select the copy format.  A concurrent SNDRV_TIMER_IOCTL_TREAD64
can change tu->tread between the two reads, causing a mismatch between
the entry size used for the read loop and the format used for the
actual copy.

Move the initial tu->tread read inside the ioctl_lock and cache the
value in a local variable for consistent use throughout the function.

Fixes: d11662f4f798 ("ALSA: timer: Fix race between read and ioctl")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 51c6ac4df9f4..XXXXXXXXXXXX 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2390,12 +2390,15 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	struct snd_timer_tread32 tread32;
 	struct snd_timer_user *tu;
 	long result = 0, unit;
+	int tread_format;
 	int qhead;
 	int err = 0;

 	tu = file->private_data;
-	switch (tu->tread) {
-	case TREAD_FORMAT_TIME64:
+	mutex_lock(&tu->ioctl_lock);
+	tread_format = tu->tread;
+	switch (tread_format) {
+	case TREAD_FORMAT_TIME64:
 		unit = sizeof(struct snd_timer_tread64);
 		break;
 	case TREAD_FORMAT_TIME32:
@@ -2407,8 +2410,8 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	default:
 		WARN_ONCE(1, "Corrupt snd_timer_user\n");
+		mutex_unlock(&tu->ioctl_lock);
 		return -ENOTSUPP;
 	}

-	mutex_lock(&tu->ioctl_lock);
 	spin_lock_irq(&tu->qlock);
 	while ((long)count - result >= unit) {
@@ -2453,7 +2456,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,

 		tread = &tu->tqueue[qhead];

-		switch (tu->tread) {
+		switch (tread_format) {
 		case TREAD_FORMAT_TIME64:
 			if (copy_to_user(buffer, tread,
 					 sizeof(struct snd_timer_tread64)))
--
2.43.0
