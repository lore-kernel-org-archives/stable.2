Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5373DA7C4
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395289; cv=none; b=eXwL7RXGT4riV76rY6Z1VVOuLDBG9Y2zg5A1ljEsGu8LsHar5w2aGMRJ79ktPbjV04v/WVGRI0mhWLSRUWZ9QYAu02Yr4byEIB3lJGT8hwSgk+HqvIHFBbAIGtpj+eCR5yOlgD4OMixyi6OJVOuau+jxIYeOECC6g92LN/5/t5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395289; c=relaxed/simple;
	bh=EP3PPgE1+iPaVn/VB9tLZjMBu7ttoKeoWajGHIzWCWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itu6T9ODEDrHjDaq5NZ1iBC/azlM+fMBDMcvJXr44uVnwEJvknaGVYlntaZysgH3v8SbtW1OZs1OU9SGIuFL4BqvGgWhFWFywKAN3xv/Ms7T9nNRM4WCZ7u7WJ2aBvLCNNkf7QZYlM4qFR62MbxGQ1TcUypEkBD3Iahm+LVT8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qS0L+gm+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS0L+gm+"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1743610a91.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395287; x=1790000087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iowTzUN7eF2XmcFkQ3hjfDXclmIIX6foUfmhSB0uTUM=;
        b=qS0L+gm+B5k16XMJhWq/B9qpMgihVtGHokJs+iM53Dqnv1TQqlMVS2+3+VNvrC5F7a
         9eEAlvxFBq8hdcg79t0Dm4A42FxWUAGAGXEsiFdfw4k9bXEGPdFspaaqrDRQ8I1DD1rz
         zyEuSSO6Q6ps7dR5DB5O1qXYV1a84ZIVgofq3/oqHIdlgVFAGtogiBI/filkfT7ncO9f
         QxQgGgCq14Wj0f1U+QDHk7Lp8Lj1pacn12JcbnIzKRk+dnUl77/yGak+rZpl1Un2u+co
         VKwoTkJQJXs+5UKbe2z9+VyxOt0aUSMvs5SMM06ocMs6ni5BniKh0ycRuIFmkJVo+U03
         M7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395287; x=1790000087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iowTzUN7eF2XmcFkQ3hjfDXclmIIX6foUfmhSB0uTUM=;
        b=rBrQLtEY/YfwsleGDtniiY1JMhsogghwHHztQsHWYDx2rffFTBl0vx1llNul+H8XHU
         V7YV1SfUwbrcjG4Xr7kO9gGH0AgT1bo/JEaZQd/wTPzGMZS40kKgy9mFNcF1aArbBc6O
         Q2SpYlPI1kd+YPKxtz8fzMfAZ59BiJc0CXK1jUMi5a/ES8vgXscJW78nACY34SGATK1z
         CEzbK5rBm66lca6ZiM+v0BxAekGV+FJrpsQuLbIHU6mf5NFZKgCTFhfB5vIKJQrTBuTj
         VM78rB1N9a7siY9T+TK6eDyHWqnU5XxQLSGO0isKtrn63Xa6IRAut6jv35ebltavM0sL
         BWqw==
X-Gm-Message-State: AFuF++mMf+050JjM1imGj/8OmJDqfTvgkR+kMofwAenNs6VD4sw2n+Wq
	I5bY6GLgyBFRMYG+ocXRbq+mwR928R15knZOq2cHFpDux1gVuioMxXCY
X-Gm-Gg: AYBFou0GwvboGZAO3uDzaMI01PX3ayaYgyB2h6B1bioRoroC23w6irjRoC7jaOO0S4A
	aMHspyNxeI+kLt5MeLBkfr+32qFRe3Ye4baqdesrTq3c75Jbh4y+hcyPz8lq8U0idDFdreBkvMi
	IgNgHEAvZSA3kEm+SQeYA5bYuxdBQLZ7bRNOQAXWIy5sKCTSI3GAp2S2sFq5ZjqzvtuXaT3TMFT
	XEH3+ih4JALdVUkviAiMAaqnOiVSmjqpcg10tSFNCAvdOo9AjyH8ReenXRxYd2qxp5WWLy7f0Lj
	GbS2RZfIKLC8OwcMQPCkoB+HpHNaWVO7zu4TFUocbrPenFUvCmELG3xUYGCEoRX2TL9xdFGHfXi
	r5K6OFNkQd5CETHJ/uk/HLXxYoBH2VZleyDnwJG6R+szLw8PureS3umafs6DF+6vbaq/sq4UlKA
	z+6t1QqWrQUueqs40S35d6CZTqVZjc0YV1/MQJJzXopRcqiKRaa5dRCQ==
X-Received: by 2002:a17:90b:2809:b0:39d:f2b0:5afd with SMTP id 98e67ed59e1d1-39df2b05b4emr3473390a91.2.1789395287409;
        Mon, 14 Sep 2026 07:14:47 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6549ec0sm5166288a12.15.2026.09.14.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:14:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] macintosh: rack-meter: fix i2s device node reference leak
Date: Mon, 14 Sep 2026 22:14:36 +0800
Message-ID: <20260914141436.1745138-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rackmeter_probe() obtains a reference to the i2s-a child node while
iterating over the device tree children. Since the loop exits with
break when the matching node is found, the reference to i2s remains
held by the caller.

The probe error paths correctly release both i2s and np, but the
successful probe path only releases np. This leaks the i2s device node
reference each time the driver is successfully bound.

The i2s node is only needed during probe, including by
rackmeter_setup_i2s(), and is not used after initialization has
completed. Drop its reference before returning successfully from
probe.

This issue was found by manual code inspection.

Fixes: 3e00a5aec3d6 ("[POWERPC] Xserve cpu-meter driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/macintosh/rack-meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 26cb93191ede..c1c6d97d5013 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -496,6 +496,7 @@ static int rackmeter_probe(struct macio_dev* mdev,
 		goto bail_stop_dma;
 	}
 	of_node_put(np);
+	of_node_put(i2s);
 	return 0;
 
  bail_stop_dma:
-- 
2.43.0

