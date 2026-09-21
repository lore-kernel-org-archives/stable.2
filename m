Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD243DEB8
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022214; cv=none; b=Yh3QjbkCJOkTQ5K/YDyNHKZcXQshMdojdM5311b3kgc9/4gQF068Lv+/FIBq5U7Swb58TReE3QR5O2uQH0NOgbZVYbB7vvimmG5p1DhVCZVZ6Fw9PWZ9y501Hj9nUXIBAU28AxVQ4nkXcTGz8rJPrrqMWpLrTbyRElA0ys6vEeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022214; c=relaxed/simple;
	bh=Dh7CzGb94lePskG4vTzYDyEDmz7SMmw+hT34PxFpDdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLlW+zDnWMJf8CjU+FIInCHiQL9W0FYadBsXdH1IvABoxSOCECpqppjlKZ6hlGZ4ii5QUZrOY17PvRPL0QtTc1+xUW05MQpJjznQ1KFpqRiIV76X6owpMH5ZsM18+M9mCmx5P++pjxGLJnnwQrmQPI1LWfqdVjzXyeGKTCkWiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNXQaDrE; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNXQaDrE"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so18088075e9.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022211; x=1790627011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SoS0Ep5+r4z4YlTt627EYalzOk4+5qRc8xeZyDmWhG4=;
        b=JNXQaDrEwTsTj3S02egIwaKaQBDA4kG1RBmJUxjgHUR82C2mhewhaBo23SomLx7e7U
         sLORm5iHW4EeFk75ukIEYrj8elIk1IM4ckeem5gnb4SUFpOEatDAXCVLI1D7L+02pYIC
         B1grYdPkMnwW04HCSSjUJLXsyP4cne7OI05sI8WnTdyPeI7mN9ndNqy/+nJrOjShYcCq
         mXbGItkFdtcm8rrGP//w9JgKFm2p19qePgKSDGGOs4/4Ql8OY1cyXDL7NZgZ21SgcKoT
         gKpLlJFD3SroGQbcY/yiOPhty5/NUsqS4AFgJQqhffgd3bQdMnbdSxwI4vWnRdsQLean
         dhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022211; x=1790627011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SoS0Ep5+r4z4YlTt627EYalzOk4+5qRc8xeZyDmWhG4=;
        b=GrCmorjYk6p7bbhKX9SfyRGb0gOUewNFCXenc2Gg8GdfqyXDAkgGoqbAgyMa9otmfa
         d9wZPrVw14AP/HBjn7+r+I+sxRqUpnxv4q8XtbVMdDuQc+lLKP/xCZzpFwyCjOFU5c8f
         iPPBtP2rlZZ8aSRm4j85/5MWayBKZWdsKUuPTZVInWEwY0LI4pnXeRIUPNGHH1LuDx/r
         621Y2CggLh+xROKQdW1GBqUJ27HvWVY9xoRnVevcVGcxMUVbtUpJrIoXprlq9sJpz96h
         rTDejGyfw+1hk0j31WmorYDqFgYZXRx07olc773vWZxU/sLFcOloT5yxAIByktSgiT5y
         K7yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQC0jITB2zivtBqwMqnMGeAmyfV8ueIWhoUsd3x47wHmOM0tKhybxY+qFdBMzDD9HjNpHopIQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m35BjgDthCcUgonvdjOmRsXEjqfx84r47vfWkLd0RgJqIlPutM
	pXoNdRkfc3nJ/sECi9Q7q8iKiA4rRhUmdyyjVepMh0c3PBXCD3Wqabqo
X-Gm-Gg: AYBFou3EOGf3g484KU7Ec0sPUCOS12MsTYPGN1vOuNCJG1yiYjAQ/3G0hhucm1xL1M0
	0IPgP3ZxgndyE4YYTwAQ1kV4iUWG1ms7798EtjSjJaTH6I2bpXe/JPebwkPPE1QTpiGAZCWGAcz
	aE3iUaBGz8uJ4Tmtqt4S76RFJrNZEXYVt2RaKhvj32Gbd/KP5qbKvbJQ1ZYFPA/u8Y/2G3+jl+a
	f1zFXqEreRM/xg/+P/IK7V5asUK3zzkTxGFGcymMQ9ZS/nbj60bMpSKinqnmGF3CXM0HWe34uHP
	pqS4Ekh6LB0bMAYre9hO5NHOeGl7jn5ELf95Q5hD4X6a4Y14sWR2Fckg89UXr6X71qGKcMMjkAh
	swl3xSyowp64fY5Pu7EI9fkrS9TYrl5SHMASGeCN+JcokYRjQYRQc53lXV4PSlUe0cDqA1urWUw
	rST3GxeFSmpwniuIAEm4vJT8REvkUeZKr3htNrNROLuUyQHR9hscLqax5NPes2PCzTkZagH13z2
	EEwdHhNsNVzbZv7PAXd/HhG5jpGIDKKIxx5xrOCn5eDfg==
X-Received: by 2002:a05:600c:46cf:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49fc5687b6cmr180052805e9.2.1790022211319;
        Mon, 21 Sep 2026 13:23:31 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cd5214sm17778875e9.9.2026.09.21.13.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:23:31 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Colin Cross <ccross@android.com>,
	John Stultz <john.stultz@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pstore: don't leave an ERR_PTR in the ramoops zone pointer
Date: Mon, 21 Sep 2026 22:23:15 +0200
Message-ID: <20260921202317.70595-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921202317.70595-1-parri.andrea@gmail.com>
References: <20260921202317.70595-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ramoops_init_prz() stores the result of persistent_ram_new() in *prz and
returns the error without clearing it when initialization fails.
ramoops_probe() then cleans up through ramoops_free_przs(), which hands
*prz to persistent_ram_free(); that treats the ERR_PTR as a valid zone
and dereferences it, crashing the kernel.

Clear *prz before returning so that cleanup sees a NULL zone.

Fixes: b5d38e9bf1b0c ("pstore/ram: Add console messages handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/pstore/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 2eb0d4fa21869..aa056d0395a4d 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -604,6 +604,7 @@ static int ramoops_init_prz(const char *name,
 	if (IS_ERR(*prz)) {
 		int err = PTR_ERR(*prz);
 
+		*prz = NULL;
 		dev_err(dev, "failed to request %s mem region (0x%zx@0x%llx): %d\n",
 			name, sz, (unsigned long long)*paddr, err);
 		return err;
-- 
2.53.0

