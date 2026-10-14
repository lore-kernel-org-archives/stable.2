Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70F440A3D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962520; cv=none; b=oeT1iMV9moG/HyLL1O0YHkfUaogAU2hsFDjlB9iD3xycYpEHisOb4l15GWF+YUYSWrUNrRngmHQlIseU4sksznWfQGOQHhD/0T9C2PrqEVv+uuHAjyF4oNlNt1LT3Qs0JGZYf6xTh1Xgy4F7rS94N2zsmnzeSObBeMCeBv0cWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962520; c=relaxed/simple;
	bh=zadTQZuGUQjQOFd3Hn4fqClxut8Qk4I0u5+md/L+DOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IUK2vaAIMhMuBLSY6jC8icwSip/GfO9+Zx6rzv7U4wwMg5En2NzzvKN3nzZFiorctv72L9GMaqtnASbMbWZahyKujYx+yr0jST0g1IJRbDDnIA4S/e5J10biyG29vNsQFda/CqhzS06JgTb6H3aNGQHpHAmy8Adwkp+pTfvSFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so46239a91.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 00:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962517; x=1792567317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wub1+wYNKcWEuFs7ErGrCVXHpKGwuOJbWkjFl4emYD4=;
        b=OmCqxePvQkqFE0fwM2LeNJxwQ97Aukb3p8CIkZmCI9leWjOYEsCc0cpFdPVU3Q+PwS
         ciff6n6nGbxv+R1vMVOvWF6tW3MGh54igtxzug6/dsebQYGfFJNsupBMQCxivV+Qk1Hn
         dA1SdnNvHfisMWMUq8OdVZ5pvk0b0HVIpYTG4dWhMgxj2V5vQ9bjy2ME8ygA0R4VLsX5
         AB1ca6C85gT93O6qPfTFI+4DgVnC1LLzTXdpJRlBU0GG//7YJdLNCJgSJ0TCdi007Eq0
         LylKZ0+97sk9MuVeIpMQs+6XcFq3MzTX6hDgL5QI8TRskC0rLj4yzoArYDLY72jHjaKM
         9B0g==
X-Forwarded-Encrypted: i=1; AKwUvBxmYCu+PWTPXrvcLh0FmFVSfguUUJspZSyWKqXTGgUB/ryLpNiAqV3Pg2OLgvw+HpffdLIoVXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkphRQbUjgNoxmuTFK3ksj10FolBNUpWSfv5Q7ctr+PJFQxdK3
	vIPUw4jigF4RxLGSC6R49hmGu0Cg6+JbBKLTr0hCQfksBf0pCyc2wjNCIIUgYNew69Nr1Q==
X-Gm-Gg: AYBFou0sI802VlDSQULkHwxnos6DbkjC4Vm6M6Xpl4mtW51++zj6Ix8H7B32QWTGkcT
	BJTusZCp5F7GNPu3/c/alG3kP37Os4oDFUY7noh4yUjO8t7WTbsAQwwA0QF1YPMiBr8qBSoMYJP
	n7VB4LJvxctXSUtjB58tqcwge6okt1sguJoJ8NrdeT423QFd47Y5M3gVoAHaP/27MwmNYTVT5kv
	D1Xfm/fS0hzqnif5Nn+13/DxF6XWmkNcWgjFohn2jDDlBTbPty+1ZtS6OecENCsdFqx3Tg0Byfr
	jozNg6fPJcCkB5ejzOmy55/WzyWgXY2OAHRF6O3S9qt0p6k8rlDlbT/y2hoCNHH2kmZQFHCVOCQ
	8xSa6K0m/K4xuaYE4QOWc9m4vsPsPc/UIk/dJ1t9/p39pfYPvnu8S/f+UdAJvHemBso/JsEX1iA
	g67sG5VIMywVpRhU1/OW8aa+naKd7I52QHRVJZYg9DIIZku3lBmSTVD1ePxbmu3nIwk6GYghn3l
	lkzvdXyXQZYqYO3
X-Received: by 2002:a17:90b:268f:b0:3a4:6e84:e7f6 with SMTP id 98e67ed59e1d1-3ab3a32cbadmr12633673a91.5.1791962517039;
        Wed, 14 Oct 2026 00:21:57 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac604b2f7csm2997758a91.10.2026.10.14.00.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:21:56 -0700 (PDT)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: samuel.thibault@ens-lyon.org,
	speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	chris@the-brannons.com,
	kirk@reisers.ca,
	w.d.hubbs@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 3/4] speakup: Guard late sysfs operations on speakup_kobj
Date: Wed, 14 Oct 2026 15:17:12 +0800
Message-Id: <20261014071713.321914-4-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

speakup_kobj_init() drops the kobject on its error path and
speakup_kobj_exit() drops it on removal, but neither clears the
global pointer.  When built-in speakup fails late in speakup_init()
(e.g. a kthread_create() failure, whose error path runs
speakup_kobj_exit()), or when the kobject setup itself fails, the
dangling speakup_kobj stays behind: a later insmod of a synth driver
then reaches sysfs_create_group() through synth_add()->
do_synth_init() and dereferences the freed kobject:

    boot (built-in speakup)         later insmod (synth driver)
    --------------------------      ---------------------------
    speakup_init() fails late:
      err_speakup:
        kobject_put(speakup_kobj);
        /* speakup_kobj stays set */

                                    synth_add() -> do_synth_init()
                                      sysfs_create_group(speakup_kobj,
                                                         &attributes)
                                      /* freed kobject: UAF */

Clear the pointer right after kobject_put() so the late
sysfs_create_group() fails cleanly on the NULL check instead of
touching freed memory:

      err_speakup:
        kobject_put(speakup_kobj);
        speakup_kobj = NULL;

                                    sysfs_create_group(NULL, ...)
                                      /* fails cleanly: the NULL
                                         check is sysfs's own */

The removal side needs the same guard: when the kobject setup
failed, a first insmod of a synth driver fails in do_synth_init()
(synth stays set because that error path does not roll it back),
and a second insmod then goes through synth_release(), whose
sysfs_remove_group() would now meet speakup_kobj == NULL and crash
on the NULL kobject:

    first insmod                    second insmod
    -----------                     ------------
    do_synth_init():
      synth = in_synth;
      probe() fails                 synth_release():
      /* no rollback:                sysfs_remove_group(
         synth stays set */            speakup_kobj == NULL, ...)
                                      /* NULL kobject: the crash
                                         the NULL clear above would
                                         itself introduce without
                                         the guard below */

Skip the group removal when the kobject is gone, mirroring the
NULL check that sysfs_create_group() already performs on its own:

                                    if (synth->attributes.name &&
                                        speakup_kobj)
                                      sysfs_remove_group(...)
                                      /* skipped: the kobject is
                                         gone */

Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
Cc: stable@vger.kernel.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/accessibility/speakup/kobjects.c | 2 ++
 drivers/accessibility/speakup/synth.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index a73b478e06de0..e1860f8d9d422 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -1041,6 +1041,7 @@ int speakup_kobj_init(void)
 	sysfs_remove_group(speakup_kobj, &main_attr_group);
 err_speakup:
 	kobject_put(speakup_kobj);
+	speakup_kobj = NULL;
 err_acc:
 	kobject_put(accessibility_kobj);
 out:
@@ -1052,5 +1053,6 @@ void speakup_kobj_exit(void)
 	sysfs_remove_group(speakup_kobj, &i18n_attr_group);
 	sysfs_remove_group(speakup_kobj, &main_attr_group);
 	kobject_put(speakup_kobj);
+	speakup_kobj = NULL;
 	kobject_put(accessibility_kobj);
 }
diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index 40870949b3c6b..1af80eb116af6 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -580,7 +580,7 @@ void synth_release(void)
 		wake_up_process(task);
 	rcu_read_unlock();
 	wait_event(synth_catch_up_waitq, !atomic_read(&synth_catch_up_count));
-	if (synth->attributes.name)
+	if (synth->attributes.name && speakup_kobj)
 		sysfs_remove_group(speakup_kobj, &synth->attributes);
 	for (var = synth->vars; var->var_id != MAXVARS; var++)
 		speakup_unregister_var(var->var_id);
-- 
2.25.1

