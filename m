Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523169;
	b=g2rBxx7T/+pcGDMzaI5VSmPE1L/3XvVRQOPIH7rA3rqFgBeCIQ49J/Rz6ComqahsgBPo
	 M3E14Z6UKSILQJX4eNu3CaJcieQUk8PiEgMhsr47UizHKVz6lyLttZq75sIj1DB1PFehJ
	 Z3Ho4anqCodLwPoFowFxPA36TzBqrDK6hQoIlTGiImNY1Q0+AQHNbmmnqYwFFwIixWfrM
	 sBSKH5kZUB+K3T26SZKKacfFmxZZEj0Os2633mAqAqkfhjLLzEtZeXPzEjKOglFG7l8yC
	 vf+RponxWpP6100gn/CjzQSeQXJu4nhEY2ncgehHoMzcnCUQ/TloT6OUSSDDpW4RfCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nKW0ygY+ZRbJKMAuc0hDt6Xe++SkVaN6uVm3JumCZoM=;
	b=LoDPd6+rOGMeBfyYKVRcLDtgUcnXnlV0KzmQjJVJO3IMtqvxUnkqrFRHM2WedqVKBNrm
	 MLL3cmYkuF9nE2dCnuePwh0Htsy0iA2HFZa/FXyRs0CA3vUfK1fVdfeeT6ZXAAx/5xcFW
	 MH44M9lt39PDTwm7v+hsEuisN+OW5G1lU0D374KM9VKo2AEScvXC3/0XQi+jqv+r2pLKB
	 879acYeDyrHlxzVNLiH+B3wRfJXGahwEsl9SDSSzDfkblEzGTb5cOQ5nZbbkN5yrV1NCb
	 9VOVrekkq4ZTlKqRFNO77MCcK9QOPPLTyi1nMM2VMHVCGKPMsguL7OnOvYousfvOHsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvz.org;
	spf=pass smtp.mailfrom=openvz.org;
	dkim=pass header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=tKsozG3D;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0639606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0639606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=tKsozG3D
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so46270055e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 04:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1795523167; x=1796127967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKW0ygY+ZRbJKMAuc0hDt6Xe++SkVaN6uVm3JumCZoM=;
        b=tKsozG3DPZnKEC8C1kLIQLx5+q/vUa30SOR5/TtDRKjHzULqVm+dWBpaXWQ825sQPQ
         kOzqAR091dtWkeFbNfLi+ssmxomoV9XQbNS7DXVH0/Gs3ErF35lDjVQ6Y94czOVOGT45
         FrJ6UXXPL+C2FEC7dVL+4vh0A4T/B1F1GzK+kKt3tOTNeTE/BKHHDsfSgOxCYBp9Dt7+
         BIeoASMRWi5wR8DcfM2/Hi5XGRhNR50Hrqy26saV3McDJzdzETW4iOCUhFjJY5r8VPJ8
         teU10v15potRLzyAM4KI1WYU5kwoBoii2ZvAkyvYJCnOZG+DLIVeipMpw+lQJIdfr5f3
         j4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795523167; x=1796127967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKW0ygY+ZRbJKMAuc0hDt6Xe++SkVaN6uVm3JumCZoM=;
        b=GMFK1vl2YAN5Of/Hdi/fV5o4ND4S7qw2VflhKCcdIG8sMVrtGs2TOmnXkjO/p7GI/t
         eV6zDM+KZgkNwFZ/SAikz9BBUnA3f5ohwHgGLvYX9AI3ebv9DuxjtYushmcoc/Wxjx5x
         LjCxfyfZ9W9AfHgGVVrUsoLtm7L/ZyXKCaDMrGU6ItnWN8ub/OqHEfMTqIqaf0NLBjrt
         3XyE4K0ygZqyJXGFnXICV/y6S/k02Yb6xTfAxSPC+E05bBsguiprJeUxXeIoyrP/frrL
         y8slifT9qI6vF3Pq7xS4R8bQeWGcl+HguB7L9DyElxr/DMzOc5mIBnXMkO+jRt75VjrM
         sFlg==
X-Forwarded-Encrypted: i=1; AL+hErFJiGLKiPSXSnkKkPdUSVMIKNS5CR5go6aSIPW7Eh3okgzaTkiTg19jBQhnfWzTxlsKe/ue8FU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Hl8V422RxzhQe1RMg3N0M5Kd/J9UBHgkN8eE6jNusujrHpUWb
	kQoNVuuh+7HtjQU1cztm9R0lNCcXuDgUJh46hfoYqlcJTd1D3zibnEeXTfIN+GDLeo8=
X-Gm-Gg: AZFdTZeR8UzN+zsh6l02pYDI4+UZBvkMaFURXwQLcQE5fybaDGs6oh4bQfvefqumkeM
	T6WUSf7LOFrSPxUjwUacKplJpEP7DKgLtsZ7w7xUJKQy68K2edgCdwpNHMYeejQUHzvKq0xvKVS
	y5l5M/LcewNLDbCpuk+5RaT5bS0EoGfDQ2WU2SIE3vmIcmvcCPRzZaQnu/PKX3uayqPwevSuYal
	g+yST1xXuJRIljUZO3vny6FNSG/ndQwn2SxSyIGUT55zc9YqaDcNCiD35hhv8N99T0g91CwNyKz
	uIDeyIfCR6YpXiIL1JmVyavlpo+YXjPtAWIqAF3MDvwz247yhSRi0ngYft9cwvbES3zgjlhtg/P
	GaUbDEws1ZOUuCqAueAfQX7NwlxxTMn+iqZdXezzg40+jphGK/TuzPneME69OUYTCuXN2zDotIq
	VWfCZ0hLsshcGBMFFFmNHHuGgPTNZW+l2gouvXy6a3X3tHyUkf8R4HMtOpq//ZhSQwom28OcwwC
	w7IdErT19JyDZ8BqWx2UUVt1l6PtGuNaezMEHz4OFUudPMaNFjlx4qMHskGSxCwaXarsya+tSR/
	0p8C3uDhSsB4g0FacY3c1iFyrq4=
X-Received: by 2002:a05:600c:1549:b0:4bb:6a2d:b440 with SMTP id 5b1f17b1804b1-4bb887e0699mr301232885e9.2.1795523167182;
        Tue, 24 Nov 2026 04:26:07 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:8dcd:31dc:bf64:9564])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm423615975e9.15.2026.11.24.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:26:06 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev
Cc: bmarzins@redhat.com,
	thornber@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	den@openvz.org
Subject: [PATCH v2 3/3] dm era: construct the target suspended
Date: Tue, 24 Nov 2026 13:26:01 +0100
Message-ID: <20261124122601.436965-4-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124122601.436965-1-den@openvz.org>
References: <20261124122601.436965-1-den@openvz.org>
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

From: Denis V. Lunev <den@openvz.org>

era_preresume() resizes the era array and commits the metadata in the
thread that resumes the device, and starts the worker only once that is
done. That is safe only while the worker cannot run, and nothing makes
it so: struct era is zeroed, so era->suspended reads as running from
the moment the target is constructed, and an rpc arriving before the
resume wakes the worker alongside the resize. Both allocate from the
same space map and take the same metadata block, which corrupts it:

 device-mapper: block manager: validator mismatch (old=array vs new=index)
 device-mapper: space map common: unable to decrement block
 device-mapper: era: metadata_commit: pre commit failed

Every commit after that fails the same way, the target reports "era
Error", and the writes it tracks fail, which takes the workload's
filesystem read-only.

Userspace gets there without trying. multipathd asks every
device-mapper target appearing on the node for its status, over its own
uevent socket, to learn whether the target is a multipath map, so a
target is asked exactly while it resumes.

Mark the target suspended when it is constructed, which is the state
start_worker() already assumes it is leaving. The resize and the commit
then run with the worker held back, as they must, and a status query in
that window is reported busy rather than served beside them.

Fixes: cca2c6aebe86 ("dm era: only resize metadata in preresume")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/md/dm-era-target.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-era-target.c b/drivers/md/dm-era-target.c
index 29b0602e7849..d40a98169b04 100644
--- a/drivers/md/dm-era-target.c
+++ b/drivers/md/dm-era-target.c
@@ -1557,6 +1557,7 @@ static int era_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	spin_lock_init(&era->rpc_lock);
 	INIT_LIST_HEAD(&era->rpc_calls);
+	atomic_set(&era->suspended, 1);
 
 	ti->private = era;
 	ti->num_flush_bios = 1;
-- 
2.55.0

