Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA36175A74
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789775026; cv=none; b=IqJaCLF93/D7MoN29E7YVxbEY5E8uFd1Jl62FutUXez13f4+4sXhRSyDkJpwpagiKJ4l7ozowsvvCJ0CanwFsqWQoLCma9Q9zE4b1+z/M7mdImlCkDNlRdTTQqN0UXEEbEjH9Nt8EYx6KD/cVclIoz9TcekpfYXtg6jBPkSiHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789775026; c=relaxed/simple;
	bh=yVjbgC4CMiNqZuadtlsece2kkWi9WaJOKCsG9Uk68RI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwXv8ztAy+Wgnp0yrw2ZBmvGbCW1F2ND8NNejUhZSS6/1cmCviQ3BodaGeDVTWFGQuisKotZGOvzScS8Tfc/bjzt2j9CwLe5YwoxZyDebZnfklQI6BBlMPZy8Ssm8KWXXkv5FVyPBIjouFdvruX9prP2SG2qBRT7ea9P0mES2bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZXMSHp8; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZXMSHp8"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f62ccdb1so442261f8f.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789775022; x=1790379822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgKahnX9yPSvT7KZdkfKMgtKpfOFWThRfybvZ/wWJSo=;
        b=NZXMSHp84YGtCFRmJFYCDqhkKxUslBDetCa5tIf4XG7TQ+1B1QCvp58Y3Iu5+1lS91
         PYbPMj2w9WdusSxKYF4dWX0ZGBrlhBbpdkQXIQm3zYT0n4y3vmCQ3Bsrh0wkMGoS1lxg
         m/exOdYTgivaMXMi8deGo+R+gYRTNRxRm77HwacrLOwGwXEhaNvipqYGb6pecKlUXMWA
         HTkldxvBnQCelRpMxive7gCjNpN63ECWIgDiaAtoKweKizKXL/O6aLWBmH+e7q59bTVb
         fkexvAMpQeUjW7sVen5rvgHRlO9XN82cnK3K0qKLbKVVEjeNa0B3uNMrnY6JOjaGn/6Y
         +/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789775022; x=1790379822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgKahnX9yPSvT7KZdkfKMgtKpfOFWThRfybvZ/wWJSo=;
        b=IGV9nynLRxsZVPdqVd+k9OlgGBnpf/8pOERXiHbJ5EIBOUhBhaGz69zPMtUKY62y1h
         tqlqwomTKgMha72nYiD04LBF7V84PpExAs4uUsCMeQjyk9LLCtv3UJI7vJGtjkJO3152
         bVpOQLZyiNaCK2I97eYXvbvCtqmBpZq8Kx85XzrrgyDFtrFL9+u5CvPsinDjiqMN5iIi
         HMyctrVakUKTjTKsSfS+Q5wHA1ZHSaYSdyDbfXnJb0CexP0H7wYqvw5WFNhe7mpSlAKc
         tshMv3oN3aiAgPz8hc8eW8Z6GwaO6y7yuIPOQePsemOEWnESUYc57LtlU57vp/1EXJtI
         OdVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwX9cZS6P/rjHOxmbHge+goQMnJ2dO7OBFlFUSNQbKwrBNDBG7/LaYkxVPfx3wHf5O/uiaFDKY=@vger.kernel.org
X-Gm-Message-State: AFuF++nx24joyzBGDjIxIae5hKNqAmz+gmwqkn5MfqqfHfMLOtEg8eqS
	umYJ41yq2zKyItssCs3YK/ZZgzvyQVxJInAQtwJFxIHCKDjG3UmWQMvs
X-Gm-Gg: AYBFou0fHUmHlfQkHaUncs5IaEJl4Od6nvWqs8h6KvWb7J3Ul/rnpRNklYjDQ2/8+NS
	FcJRbUx8EJGLQy5WyZjMRwFQPi538Ibtx8HsT13Dljl9Nh2wM18jPMitZkPYZ3ZLOICdwUiIwgh
	EE3MKjLXCBXXHK2D4oqY0Bu6XenmZQ5lUqt61WGgJ+zkkydzbNykgZqLDq51im0rlkrCMKV7EUk
	q9XCU5lJb65PI4qjKOn5ft7VFmeUYEvUhKta5OPj2dhrcr00mXKx8FgDemfUzQJTfYHyPNCmznS
	nNmHTwtolKVcm2CrfY2CODrUthPwvlLX83udz/XQ19Vwx5UDJ4FE7Lx6thH29fLJC/GnOPypIHQ
	PiHPgCwfIZsOEEvGpcfFPhfnjKfVK2b5ouhQCkZjPVAIqnXdFtW79mWbL2EMEQZlDSHluoJr/vT
	e3905UY0U7cv/FsJiiioGe2kTR1AHKZJT/hNhtgBm5uxJvIRF1yToweH8m9ZGHu2t1JlMPqUyOT
	XRuqxpkbH/3PJRN+OtGMg8o3ARbmhxZlQXi1gWYoNsrvwnDmy/hPnOAti4oO5RdPN0=
X-Received: by 2002:a05:6000:2688:b0:487:146f:7c88 with SMTP id ffacd0b85a97d-4871d98cdcfmr6375274f8f.4.1789775021601;
        Fri, 18 Sep 2026 16:43:41 -0700 (PDT)
Received: from Raghu007.. (sgyl-44-b2-v4wan-174108-cust110.vm6.cable.virginm.net. [80.1.81.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487243cede9sm2482874f8f.0.2026.09.18.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 16:43:41 -0700 (PDT)
From: Palla Raghunath <raghunathpalla.0209@gmail.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
	Milan Broz <mbroz@redhat.com>,
	dm-devel@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	raghunathpalla.0209@gmail.com,
	syzbot+48d935cf48a4a76be346@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] dm ioctl: don't let data_start run past the buffer
Date: Sat, 19 Sep 2026 00:43:39 +0100
Message-Id: <20260918234339.54105-1-raghunathpalla.0209@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct dm_ioctl has seven bytes of trailing padding, so the smallest
buffer userspace is allowed to ask for, offsetof(struct dm_ioctl, data),
is seven bytes shorter than sizeof(struct dm_ioctl).

get_result_buffer() sets data_start to sizeof(struct dm_ioctl) without
looking at how big the buffer actually is. Ask for the minimum and
data_start ends up seven bytes past the end. Callers add it to
data_size, and ctl_ioctl() copies that much back to userspace:

  BUG: KASAN: slab-out-of-bounds in _copy_to_user+0xad/0xd0
  Read of size 312 at addr ffff8880169e4c00 by task repro-dm/140
   ctl_ioctl+0x5e3/0xcb0
   dm_ctl_ioctl+0x25/0x40
  allocated 305-byte region [ffff8880169e4c00, ffff8880169e4d31)

A DM_LIST_DEVICES with data_size set to 305 is enough to hit it, and the
seven bytes that leak are whatever sat next to the allocation.

Clamp data_start to the buffer size.

Reported-by: syzbot+48d935cf48a4a76be346@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48d935cf48a4a76be346
Fixes: 76c072b48e39 ("dm ioctl: move compat code")
Cc: stable@vger.kernel.org
Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>
---
 drivers/md/dm-ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index a6b8e97755cd..211569dd3c54 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -656,6 +656,13 @@ static void *get_result_buffer(struct dm_ioctl *param, size_t param_size,
 {
 	param->data_start = align_ptr(param + 1) - (void *) param;
 
+	/*
+	 * The buffer can be as small as offsetof(*param, data), which is
+	 * less than sizeof(*param), so don't run off the end of it.
+	 */
+	if (param->data_start > param_size)
+		param->data_start = param_size;
+
 	if (param->data_start < param_size)
 		*len = param_size - param->data_start;
 	else
-- 
2.34.1

