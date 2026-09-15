Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A23D9DC8
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484612; cv=none; b=mI48mcqy3W8xSwdp0LuBaH/NsPURk17U+FP6ByTMK+idVRXGatuoeRp5ZIpC1pLZQHLf4ImTphhVErM2TXPYBfJj2MSOaoVN7UPdAk6bxAdO9m7c9x8om8/sq7gGDapLTsnss6RJDECFOaOZDd44EGrDkmHnlSLePPqxcKo5hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484612; c=relaxed/simple;
	bh=ZxcOEZm2h5gq0oopxQGQnrU+9rOuzRx+cCXYve5p7C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/ZA52zYwWdq81ANRO7diJJbphSAE0ZaT7R5KUriJl+Vyu5lFwxAmtxE8fKMkzOyCgIfgLnBr7uNUIeXqc9QxcI/3ga+ngAHY/eXuf3bJdY6oI2hfyJreIxNyCJ7Llxg9klbF47xXNTMglbE1i1mVMQAU/vszoOmQxkgGv2lZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYhj57al; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYhj57al"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so2582583a12.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789484610; x=1790089410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnoFATftpooOx4JQEkcutKyMZ8fnscChHfdP4CjfQ0g=;
        b=bYhj57almlknnku1zHJDxN6L0ktJqknCYE2luWkbj0WtkZKfchZHnaWCFYtjSVjo84
         15mCIodT7vPcKb2OzRh/z/qAGUdGMwAUFMexLSiKQtDfatMjCO60qZQ1a0ntlVLGyoP9
         C5kw1icnocUtPun0vvZrv3wO3KoOMFc4ZpGhegm5/utFnqwqUohHZJXlt5q6XZRlVTHt
         wdI/hHfN/bKucntbbMtd5z9DOsJBUrB2Qidg1Bei/VIA5XP28npgMzKvN3T+Lxr/YvCM
         Sw4RxJW3yThVYVJvMuqjyybVWE0w6WjMz+hcki/HfDCTfBYsk1Jml9jl4jx4dgf9eM1O
         znog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789484610; x=1790089410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnoFATftpooOx4JQEkcutKyMZ8fnscChHfdP4CjfQ0g=;
        b=vc74N0joY6fSdtRngZj1RozTjrC8gRfHcVa6eTRIkQ3ct3YX9DjWvT2b/HJPwJYnee
         MPjUSkvs2T9WeaHJPAACpp7Jb1x9t3DEnts8OgMaKi11TJZmY0llOSQPCR4nYmk9D6fB
         m5z7CcVZIZAl1LbK5AaZkKNzxhFkKWzslH8c9qFJHwMSGNiPWMSqdEY0UNCwO6VutKhl
         IFAwfChCArGoxddSnc9HWiiZUGUIjrRXzjJx3eGHhLFL/3tatlF+2KUswshxuysLf2pp
         nseCfGQ98K5qN5KVEHD7y/0lGSYsFqDBvucKruP1573/hQxsaN0H1lOcR2fnhTvYUPOC
         5vvw==
X-Gm-Message-State: AFuF++kB3REllbPQsHmVTAbt7Dx+EbGSDDcoVIFmVM1LLTJvXa+rkyVm
	Zh+p2V8ytb2FBbMWgydvfRXspLym2C4K5E+iw3/XodMsCI6NM8bHb5o0
X-Gm-Gg: AYBFou1IDbW0tN04nLaCPaRevSmn5oGQoUXaH32KTobnQPQzdClMr9IiphOiuxJXSh4
	egqFHChqsKZZVpQPqHujnjZCIBK3/8xygdeGcmB0wmEH7dJUSE5JUW3u2t9kT1h5/4v+oHFSJjB
	H7z+muKHV4YUptnYyDQdEqo3npHydV8Z6ou9MHZosg07TdtSnF+zBpOeLJtNBbRNRezJT4rt7zu
	CnzQezAKfnkXU33UDYt8faB8Xqc0HlL55SRmpdFzXFOlLGQHmkLOVBrUaT/sIjaSXK94QHoR5A4
	3gNDIvscwwX7W87I/uXNT0EG/D41unt+0v1V82yYT0MaLjwl0jxzEoeMSyO6UeV+3Q0rDM1g+vP
	J2b3/H5CJcFL9u3jBtntV7aISsaBjnbGh+cRfwqCsXMjGcsZvDeWcQSZU+M+thseuveiLxn8kKx
	j22zfKCDiKuEYtNeufwOedRNgTshdVXSKw2eHPjud7wgZHWCcx4GrefQre63ypnVsKMw==
X-Received: by 2002:a17:90b:2789:b0:39d:f2a1:2a with SMTP id 98e67ed59e1d1-39df2a103d6mr15547653a91.19.1789484610100;
        Tue, 15 Sep 2026 08:03:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda8bdf4sm6105716a91.12.2026.09.15.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 08:03:29 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] memstick: ms_block: destroy io_queue workqueue on removal
Date: Tue, 15 Sep 2026 23:03:17 +0800
Message-ID: <20260915150317.2444609-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msb_init_disk() allocates msb->io_queue with alloc_ordered_workqueue(),
while msb_remove() does not destroy the workqueue.

The probe failure path releases the workqueue with destroy_workqueue(),
but the normal removal path only flushes it through msb_stop(). Flushing
a workqueue does not release the workqueue itself, so each card
insert/remove cycle leaks the workqueue and its worker.

Destroy io_queue during removal after the outstanding work has been
drained.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/memstick/core/ms_block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ce33907bfc24..65154e569a9e 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2204,6 +2204,8 @@ static void msb_remove(struct memstick_dev *card)
 	msb_data_clear(msb);
 	mutex_unlock(&msb_disk_lock);
 
+	destroy_workqueue(msb->io_queue);
+
 	put_disk(msb->disk);
 	memstick_set_drvdata(card, NULL);
 }
-- 
2.43.0

