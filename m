Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579F3F12EC
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788383007; cv=none; b=W84drH+rDEmL/AJwibkxPFy2dDda7JvE1CuTaYfqaCkk08xys6vbi4c/gGsZLXYq1CmDpf8MpOgerRX43aLR7FXM3mxIeD2HSpkk3mkwiEgIBqMmHVRTCmhvla4QA+zpSIB63V2g3GnCbTOcPYwwqCZqGyXp5jlAHLpdw/TfY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788383007; c=relaxed/simple;
	bh=HCyWfdZphcYau0fYYUAqLOKget0oXna5JKrdT18pOyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjPBUbVRAZ2ESuvb9asw7EyIKTgSqmBD6KDMRWQPYlkAzTllVFDw9Ni5bYVEJnN7p2yzHmZdb7Tdp/YC10vBrYF9QZ7wslQILa5ebbks797HgkZcwnCHchoLc/bX+XmgPVJCBmJI+TT3MN2iswItV8CsfvkrsGIFTDfDgfSO7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWsA/kdV; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWsA/kdV"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a451915d8aso1083067b6e.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788382999; x=1788987799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pab9MovL5V6IqQA5mU5VDCmIqD2b0v4m2h5+1m/xuv4=;
        b=YWsA/kdVORQBYjgDdMj1Ma27h0zb35UBuoQfg9NJqeKgbCsWOV5uLZ+/hunbqgmBdK
         yQGR98oC4UXZZaydpEfvYAIvGV38Pvoa9xsaAi21hFSSHK6hLIOztLyTXVBLhBslYXYo
         NJkFhFelx6kNzWRc22H0M6GzO8K9/lHMgNeZUlUpSllOZWUToks0/gCfEBHucdffuT/8
         CWrHGOk8YxiyUfl5LH7HpD6p8Z4sXZlZJ7oURuWC0lkeiQJXBrMCSA74HGynA2UbBqp2
         Mrypk/v/hswgkesWB39mLow9wfm8WtvcVVkyf3StXM1xoqBj1819lien5LkzZt6MhK56
         WxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788382999; x=1788987799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pab9MovL5V6IqQA5mU5VDCmIqD2b0v4m2h5+1m/xuv4=;
        b=CwvPe36im3XfiOprYNoOoZERxMlLV1D1wCxpWBhE+H4uV8vTwTxaNyLkP3sMwqENF2
         DcvoccqbECPf3OKqY4hnxzuNgTC5AdOxrEphWtvjiWLzEDFg97T5OcfNjrRpawrCId2n
         wJ7l4CHBJz1pXG0ch/wX2Qhcw99UPZyB6QJpWUrR8Ra2jTK2taUHvErq1Ay2KWOY7x9p
         HlQgQpKV9VVE4aBIy/4kbKifpzikhDzFrXakzS6KMsM4h7HbFkxv8NTq1X3p8eJVqXug
         tg9i8bsFHwZHSH+Cx8+cjwFLjp/UdTYE38l151aWrQk2aRm+O4koENjsK+1QLAV+AB23
         2LJw==
X-Forwarded-Encrypted: i=1; AHgh+RpBSAEQvFLP1cZfZZ3dXwNuHtpkbQY8xtqAFasQFHq80hkl15A5ld58gczeruhbtlH4N9uFuHo=@vger.kernel.org
X-Gm-Message-State: AFuF++nDpDsq512o4+h4hbjwnoaiGKaur2DuODF7P2qIsAupIe8G3Kd+
	pBlL5838NffpfedSnUBbsglqCJFjIuONGf39qg4UpQYoowbpI7ZMIQqh
X-Gm-Gg: AR+sD11kdH9bQnSNrWU5oLZ9LxUSOUJD0ReG0Kp0t4NeAguafMV72DdH2+cVSkIzy/P
	nXIvuzyw/2jSNRWmWD9dCkAfiid+DAenoJSuGJpDdMoiRuzvDapEI/eJJmBnL3AOUmwaMgBf/8C
	HOPpff7S5eTbNgvEsHJP6h5UVO6+hyH2vOQNDaqXEXMiA2DVv0sSdyO7zxOHZ4K3JdARXCtYJvZ
	hnhi4RL7OF1Z8pyJGdpJVhEQG8+F+O5bB4UcRnFpiGs3WCobyhrc+mFuVot6tWhA2FBTzCAp6Me
	sM7rbZ9XCdTAAVO6Xy9sn6jzeOnBG0a5jyP81ODKkz4QAVK5RRd70WAZbRNMxCOGHOURcrbh5Z+
	AiWTZ2Mmrk2b7ZF8CBeLyoQ5hzz+I8YRNV900g13oZ4b7mPcDT12S9B4Z2AvVCILShacNWzNKN1
	vp+nVdbfB2gMbt7k1JmImE4HyWU0i474ybPqWc9HsUsiYx+/U/FNfm0ewu+qmgwIFkz2b+iFxxI
	cc=
X-Received: by 2002:a05:6820:200a:b0:6b0:1ba4:dcc5 with SMTP id 006d021491bc7-6b481039390mr5531478eaf.20.1788382998571;
        Wed, 02 Sep 2026 14:03:18 -0700 (PDT)
Received: from localhost ([2600:1702:2f06:6c0:72f2:e1f9:8fe4:eed8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ba648f6sm3742773eaf.2.2026.09.02.14.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:03:17 -0700 (PDT)
From: Jack Boykin <jtboykin.jb@gmail.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jack Boykin <jtboykin.jb@gmail.com>,
	stable@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: Fix power_supply refcount leak in amd_pmf_get_battery_prop()
Date: Wed,  2 Sep 2026 16:02:12 -0500
Message-ID: <20260902210217.69483-1-jtboykin.jb@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power_supply_get_by_name() takes a reference that is only dropped on
the error path. On success it leaks, five times per policy evaluation.
Unregistering the battery later trips the use_cnt WARN_ON in
power_supply_unregister() and never frees it.

While here, return -ENODEV instead of an uninitialised 'value' when
no battery matches, and stop at the first supply found rather than
letting the last one in the table win.

Found by reading the code. Fix and changelog drafted with Claude Code
(Fable 5.1) and reviewed by hand. Compile-tested only (allmodconfig,
W=1, sparse); not run on Smart PC hardware.

Fixes: f4627dfd0e19 ("platform/x86/amd/pmf: Add support to get inputs from other subsystems")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Signed-off-by: Jack Boykin <jtboykin.jb@gmail.com>
---
 drivers/platform/x86/amd/pmf/spc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
index 94355b435..ba852397c 100644
--- a/drivers/platform/x86/amd/pmf/spc.c
+++ b/drivers/platform/x86/amd/pmf/spc.c
@@ -199,13 +199,11 @@ static int amd_pmf_get_battery_prop(enum power_supply_property prop)
 			continue;
 
 		ret = power_supply_get_property(psy, prop, &value);
-		if (ret) {
-			power_supply_put(psy);
-			return ret;
-		}
+		power_supply_put(psy);
+		return ret ? ret : value.intval;
 	}
 
-	return value.intval;
+	return -ENODEV;
 }
 
 static int amd_pmf_get_battery_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in)
-- 
2.55.0

