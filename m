Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BEA2F363F
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783845078; cv=none; b=OeYAIf1SoEsNiYsOv0HUlat7J/simmBwVmxTEtPsTSqZxZblKerd3zYW8UDUhkoio6TdMxHKljoomw8tPVYOjbLv+yZ+xqNx7HpfPbIIFCDnWFV8pipGJmnRbJswoPXg0KXamL5wvZvVBBF5/Oq21gNZO0gsvEWk3Mrc1nB0qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783845078; c=relaxed/simple;
	bh=qZZDoRccRriO9uv7+G0TDUWo85TZUmIAExHMsIW0gvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdhCOTOniu1e7kxOstIJlr+2JS//fAYiVWSiev/4ex+ysDJVVp9Qr6Y28WmEifYqL2KtRU7ObZPj4FSaBUH1HMXBfrEao4zSGNljuGJmu7oPaXMfGmZkwO0FpIJGux8S5fjviJc8/KFAAv3kOgWNbuwZNJhOPUuucjl3nebWgc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqpFkF3p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqpFkF3p"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceaf8a1265so7005555ad.2
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783845077; x=1784449877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qwVPE/TFDEf5PRXk0sV1x1p53OMgZZvm6Y22zC3WyOg=;
        b=LqpFkF3pExO/2x5sP0tVFVuqoApHQEeARbW2B8W9auWXMHQy7CytKG7wVvSqBvOcUU
         aDX7VGJpha0+lqdIoQNDLNh3Pw//tKVz2evwPLVZmp8icA0D0ZQSL9b73kNmy/2nrswl
         paG3wKdA1Q/lvbT2bwqHGw2fRsIiK5HYJabpzWpipLFOp6pyhT2Us2Sfr9XuftjrEHOB
         XUv655SL+EfNC9zpKVwJVt+/PQJJRYl7OERhorCIz/5nAyXxP+7wd1KaiCiFwZcv1Hns
         zjy9QFfV1Siv9uup7PVjqPEiZQAm4tbMWFmK8EN2KW0qa4WueDqF6J4eWy7A2VSduIW8
         UHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783845077; x=1784449877;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qwVPE/TFDEf5PRXk0sV1x1p53OMgZZvm6Y22zC3WyOg=;
        b=Z9Psr5YYTHH/Pr8ZMm4tsc4UC7bM9YtThlGLrgQHCvXl59hv5FtHHe13/7gywW7Xp8
         braFsKUc2tjO3cnmHfocYRWrb0OLSOnSzppJ30lWi22bKRIcb3AVBlXDC206qeTFWpZL
         Uvnn3KPMlNljjjrWlkE2VP44ffjc9uwokOZ+jD/GKcEOMoeCooLq5yWhJE8wJz58jr5z
         a87z4SZWb76awikWOzGqVBhnVjlLfrzSpCA7PKv1c9eCU0CLgMlRK9d+FhvqwyqxwE6a
         4/21x25E6/WUUuPeFjgkujITzl4eJHT/xa4YULTTuqJGsSOGJ4O8arjHYnpX1jWIzlS+
         lpaw==
X-Forwarded-Encrypted: i=1; AHgh+RouHthWekrA77rkkkLhQMgHgmO+FswgOG9wbbKaYHLkXgmHtwilr0Ob/a2deGfUxbkKrWm71t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9B2arnsNVxwx65FE4Kq5akLKVKzICTUvSgE/3JJLgXruKBcfO
	JC76pvUX1xwNnUIQsaAcEIDaJlfIn8mLmTQ6wMp7oKxiw8qjEPYEtaxO
X-Gm-Gg: AfdE7cntkqDF7PxjhVPG/+TmVGQy4Y+5ujp8Hr96aeX3ssNn8/0cTh/7/vJOu5BQN1m
	cQUHaGQpKFGNN+D8KKUtj0frJm2AVQxne5ZUGJdL5iOnnMpioI98FkvTHJKV8jspJhydWUxNSUi
	gC6kEIjvbJTaUUYNmfxcuB2r1GDpGL1HswuSV0eAq0EFX6wk7P5aX4JAjgtpV/5NqToTZctsVGh
	pBBhfRpYKIpU/h2Dc7835mJFvSYehmnDEc2sCUs2SUis5z+xptcCm81gSabWJJGyxUIXaMCKWqa
	+t6z/s3wYlc5VnDNBOdZ4vJXz69viuJ93gCRVgIdCWFSQHwYpX32zmAbhoM/gWTHHmAdinK+2LD
	aYQlEs8jFTF2O9Dp2H5296Cw5vs1/8wiiTmGLCAPmd4siAxHnCdwFZn9rozS+lppPl9bC1Zk/9e
	Sc+QEACPT+bRsET+NpfAj6ydnf7HkDjDfxuXpIDMqorTY=
X-Received: by 2002:a05:6a20:12cf:b0:3bf:6c08:fb9d with SMTP id adf61e73a8af0-3c110b4561amr5540581637.49.1783845076933;
        Sun, 12 Jul 2026 01:31:16 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm100968646c88.14.2026.07.12.01.31.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Jul 2026 01:31:16 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] iio: accel: kxsd9: fix runtime PM leak in write_raw
Date: Sun, 12 Jul 2026 14:01:06 +0530
Message-ID: <20260712083106.97429-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kxsd9 driver previously used manual pm_runtime_get_sync() and
pm_runtime_put_autosuspend() calls around the entire kxsd9_write_raw()
function. If the user provides a non-zero integer component for scale,
the function returned -EINVAL directly, leaking the runtime PM usage
counter.

Move the mask and value validation checks before pm_runtime_get_sync()
to ensure the early -EINVAL returns do not leak the usage counter.

Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
Changes since the reviewed version:
- Reduced to the minimal write_raw() leak fix. Dropped the remove()
  rework (no underflow is possible — pm_runtime_put_noidle() floors at 0)
  and deferred the PM-macro conversion and style cleanup to a follow-up
  series, per Jonathan Cameron and Andy Shevchenko.
 drivers/iio/accel/kxsd9.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24af..1af04cb4bf86a 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -139,18 +139,18 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 			   int val2,
 			   long mask)
 {
-	int ret = -EINVAL;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	int ret;
 
-	pm_runtime_get_sync(st->dev);
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
 
-	if (mask == IIO_CHAN_INFO_SCALE) {
-		/* Check no integer component */
-		if (val)
-			return -EINVAL;
-		ret = kxsd9_write_scale(indio_dev, val2);
-	}
+	/* Check no integer component */
+	if (val)
+		return -EINVAL;
 
+	pm_runtime_get_sync(st->dev);
+	ret = kxsd9_write_scale(indio_dev, val2);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return ret;
-- 
2.50.1 (Apple Git-155)

