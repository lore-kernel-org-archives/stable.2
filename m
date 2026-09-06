Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BE310784
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788664002; cv=none; b=odTOZRnpcQvpEhEl9Fllo6HaFhnIwFFU350J37gmJ0elhDsicfKa1wBiTLP71/T/KB0T0rxozzBicvG5luikhQtrvy/fuEzRXvBXiLV+wSvx6czzrKOfWxzpNgFIsYhtX2E/IjFASdjuhtmbwqI4RGBvSMjoDgbfhajAIC8lvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788664002; c=relaxed/simple;
	bh=Hvx+9JZ4ePYhNTGhRqrsylIrQD05mwHvL5EVPtd5fjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5P7qS7FxsiDsqLXLS/a3PprKeSxr+B9yaUjRnA+edquWA/spLqPMRX8whz2zbATHxdVKr2d8jX99Zzm4sM0i4jn/EFD+yotTdw0T3Xh56JBi0B1Y9rmuOJXoK5dFIvVwJuMe4vq4OCtC+JzQ7fKsALoDZhDbMAiNOTJ1EX354I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=U3yWHqpX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="U3yWHqpX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1655944a12.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788663995; x=1789268795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slMBf8woxA+Cbw5IGupKjQ19fNZHNRpLBB0KCp8IbAc=;
        b=U3yWHqpX5+YnV1TysmbYM0t7kEQpJY/iJtvE9IJ7lmYo43o0JtdwZM4EHwzAlnxzxZ
         ZWqnq/2kUWu/dpHl22wttiwIwzROHkpxfc8RJEjbH9OqKtnKybHnUTNK4uFVtlzhhqbk
         BDSJUZFMP71MGyxQP+9ck9h/+55PDY2nmuznU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788663995; x=1789268795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=slMBf8woxA+Cbw5IGupKjQ19fNZHNRpLBB0KCp8IbAc=;
        b=b4+gtOrwq/fKPGiejLUSn14Jq5ghAycU6ElGgtv6gQeQxAAIerFgpzVsjMjf15e00Q
         x3iqplXJftdRCdRZdJUe0JMflBW3kNioapBfMkrgDiqAJbxvfVwPCKSUeP721T9k4Po1
         ChXxc7qgCAn7PA8JZGNm29oflBCwSo9FA03SrgfIS0d/RgENxD5CJzfyFKLelSJCOSY9
         FOY1kxmNRK9KPdWucqb25sYgLtbZ2YY5LqSqu+mbbYxLVGzzcm+RArm4jpIMXvSj8Snx
         iKEbe2DskrDu0Q9M5HvBYUc0mLKa0lFkPxv8zrxGKi8TWx9t7asKI2S8Omp5Q2Eu0zS1
         jYNA==
X-Gm-Message-State: AFuF++mUZnvqpzIK63T6FF21/UZp2yra53NP2hzdDir0K8BAJT3nv2GK
	U+A87+kieX2md0mZFEv+EFymcLK+k76C4zuKbySpdlIkXCIzMw2FBHyMCvH4UewXfWNLXEeb//N
	ITHBaYsY=
X-Gm-Gg: AYBFou0KEC6DNHSXX9cB9gdsG0iBfDnHJqCP9lMukyKL8Xxry0Mqm3T5l1tDR6ADDow
	kN0OLpr/qKRb3siWJDf2pJ52DyeaSf0/ernAGPcfC+xRcvTR8K9ZHxuotFOUVBMEMyeyM1NAbYC
	WNDmu3bKYyLwsHazS5L+PhLrV30fwQila5l2yKgGXv5/WlgROk1nFgLnl0r2mNmSef54wer68Cm
	owLdcNwVr2TRG9S0FNo7gS8It31tHAPIINkaaHzmpdAaZxakSLKQ4PG33ZdgkSn/QhDamhOxtHN
	IVoqZTAQyZq7iXh0zgc3EyIQsZeTFyGXN2z/rebbeGcJ+G6vJu6CsAIXErNcaNB4OUQ00XCtTDA
	h4sdwiaaeXbhuZ8a+Dk0X4iq3Oivi3aXOJ1WUt3PH91JAnwf+rDHD50Yd2AGqpvEm95NlHyunT3
	uNR/8J0yPLXcRVRKSxC0/lT6cZwCX81qfodjdvAGT95j7XWcoCqc2+pN7MmnzT06J6uPOV3/ysk
	6UdYo0I5M8=
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr24234868a91.17.1788663994686;
        Sat, 05 Sep 2026 20:06:34 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm19392252a91.17.2026.09.05.20.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:06:33 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>
Subject: [PATCH 6.12.y v2 1/2] fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()
Date: Sun,  6 Sep 2026 12:03:44 +0900
Message-ID: <20260906030345.3332040-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAOQ4uxj0rAj+8S+E=fxiTxym5dRdEJgk9NHE=wJcancfnxLBLA@mail.gmail.com>
References: <CAOQ4uxj0rAj+8S+E=fxiTxym5dRdEJgk9NHE=wJcancfnxLBLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sun Jian <sun.jian.kdev@gmail.com>

[ Upstream commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e ]

fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
instead to avoid sparse "different address spaces" warnings.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Link: https://patch.msgid.link/20260214051217.1381363-1-sun.jian.kdev@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
(cherry picked from commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e)
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
 fs/notify/inotify/inotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 0ea4e99dc449..657fc36df7ce 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -573,7 +573,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 
 		/* update the inode with this new fsn_mark */
 		if (dropped || do_inode)
-			fsnotify_recalc_mask(inode->i_fsnotify_marks);
+			fsnotify_recalc_mask(fsn_mark->connector);
 
 	}
 
-- 
2.50.1

