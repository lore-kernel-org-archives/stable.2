Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506E2DA76C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560935; cv=none; b=VRauKgvqXcoComAs92D7SBGXr9zjcAxexTRWWZO6FsUHNFoVyz+acPHVBSmc0YXczJgtY76BPTFy2ewBRulZWkij3157zvrPnCoHcHuqR2Hj+0ZCoEchjLwDGGXXGmyPnAAoGgIVGh8riJ5DnxdQvl5Lburzels7IfVsmFTbJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560935; c=relaxed/simple;
	bh=urQbLGCXrd0ZFZeVKewiensfGBXy6svoBuruqY3dA68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUf4U7eRjGXdb6o8DEgOxUkEU5DFyqQOqfGsvBygGrUm1JQeoCjgNIey5b9awyuTIGpZ6OIRatixDmW84uyP0LWY27XXIDDTWkI2KMjAUliM3+99FgMw6sdABfkG5UbG6lZYgOc2W8u0YhZyHOKISitRN/ZtoHVMOj/KGHmXMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDS3JOxU; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDS3JOxU"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7979d1deaso465281a12.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790560933; x=1791165733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ASjAUGOmT1ysmFExBD7PO6pvYBzwb00czBt2hidD9U8=;
        b=sDS3JOxUXnhYUEQ8AWzYnafjzU5CaYdRWCy5KO7z9GP32l3d+CQ3JouXbIIaHnijmV
         ybagc3WuN7c+zt4SawiNjSPmNy0Kje7D9rUg2h17YVQDjoV+RFq+OXlljp2fYsdjI0DZ
         SMfJmOH87mNfgFqzg9nUAZaGHlkqVsi1uXWIosbiGe1H+ccbmTxp+uJQHCDt41i7eyU0
         nMP1kJEmy79W+A+m0lXhaG657Z86k51ZyWicXgmFCSMEoT7GYTOJRxvOdGNKd3UNvIpN
         w2cnNWjhh7EZ3+jkK2L9pHMED/elCkFnxF3g811t74ozGFbnaqoFE7bpa6An/XFPYOI9
         Gwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790560933; x=1791165733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASjAUGOmT1ysmFExBD7PO6pvYBzwb00czBt2hidD9U8=;
        b=cMbH3sHcAY4p6e4SH4GWrABG/BRIykV8yv53e0w59AGRe0bJh2RHnBxilZk7icpyiF
         Rse42py5wX5ezGc2u+YIdk1LxO9RPr8L3mo9WHQI4KqRFURyGSdwtMM2tRxhU0wpNsU0
         0dWh1BGEHqLu9A4sPU2cCb3uSYvIbOdOc8s7sgA03uA/nG/vl9K7Bn+3TleMLteq1ANf
         +/oncUueg8d3lDAYDnpXMX7rGkIXlA6yYc2z6NuqFFYY6AQRnc8d/dfKoJmKR3snihNU
         3xQlXbttTr5ppZQR9gl0S5xS/D9jdrnYW3mMYOW0DJ8LpYB861Rl8XjyXH0aFLGBXfEs
         NrQw==
X-Forwarded-Encrypted: i=1; AKwUvBwjUl8s+Yq3dqkRMoJCY/vz3MBLqy/2g0QBtn8u+MU+5YzdVWSW9GKp43VQNCzL75kHTc5k7ow=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCJVbOO+Mn1EKaw4n442/DoLUHWa7t4oFpkOb0WhmaZNIy+Ytj
	dqDSdKO86d9qXZAUbUfYc1JmG/WmiWokd29NkGhjMcsaJUUN6LAd0bzO
X-Gm-Gg: AYBFou0w3+yCtbYe5GFl4Zsxh+prxrCtLKZJXzGN7fcMT0frlO7UIU8vWFp5Po83cbL
	hdRgaJevgasrGokZIRtCCCXzVh+Wh/FtUhHrSlXzGXMwpNoxldm3N9Qj5L0WLyoanEvN0iRGNKf
	hSGiFEMctsiYPgg1fjELhz0w1olWN4ROFHLM5flKpIOXsYqk2RCdpxHV38QYSONDYBBFzPoHIpu
	RVCl/a5Q+NEErUqls7xHC6OgSqSWIY5XN0TEiMih0gRJ4Ld3yaLdhMUDP5fCVlCKvzPfY4vuQwr
	hoZq6NNHJ4y/rUNYwWtcrbq76Aga1dcumZQLAWWO2LgGEFU2Kye5BP88GLfeg76EypCcdJEvPME
	9z86sp6C8ZmcUtQWH7jL3C//t1H43M3zdmXYtAwSAjQ3PZ9/W+WGp/W94Pt7ps3VuExQBwrJxXY
	sJqG3yJJ0fbQah/iXXU7/Oih5cI2K6DaEj6ithaf4Xn6NcG1bpc0riDMc0QLwzm9mqpZR011Xga
	upMaoVIKzUMt1ChESE5Fw==
X-Received: by 2002:a17:90b:2b83:b0:39e:6c6a:208f with SMTP id 98e67ed59e1d1-3a09896d0aamr8645055a91.48.1790560933535;
        Sun, 27 Sep 2026 19:02:13 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e05d674dsm4631129a91.4.2026.09.27.19.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 19:02:13 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] sysctl: Two jiffies converter regressions from 2dc164a48e6f
Date: Mon, 28 Sep 2026 10:02:03 +0800
Message-ID: <20260928020206.977522-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, the fixes; the tests are already in sysctl-next.

Only the changelogs changed.  1/2 now also names
proc_dointvec_userhz_jiffies(), and 2/2 labels its reproducer with the
CONFIG_HZ it needs.  The code is identical to v1.

Based on v7.3-rc4+ (62f4c998b297); applies to sysctl-fixes as well.

Link to v1: https://lore.kernel.org/r/20260922031229.2300283-1-zhanxusheng@xiaomi.com

Zhan Xusheng (2):
  sysctl: Negate before converting in the int read path
  time/jiffies: Saturate in mult_hz() instead of wrapping

 kernel/sysctl.c       | 2 +-
 kernel/time/jiffies.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.43.0

