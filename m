Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CB423EB9
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970491; cv=none; b=Wrk+05u5nlkscJZj3AywQBlrBLp42HJZdIqcIq16p//oLO93ykVNySQybhbhcbDMscOvHqL34ySU4KOM6GYmltxugBjPnQeB4hOIjG8kwVnVsgKTOpAyhRF+dlE/XfImcV90f6yab1NX1iFRs4/Hdt3hpQrU/0a38Nb5TfiZm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970491; c=relaxed/simple;
	bh=uVgA8Jj+858NUjqFixCzSRT/djaE0C2Wg9YqoiGWV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3muLajzyPY9yuj+41j5p4rFpZyTjCX70rn9y2EcDj8dv1PRhMiGG7ovdo1IITUqTRD1FpxT3UVQUAKwZBf6e5EqIJdDeSdSiA8qqIgVcjBMk/D4+5Os9bNyTDJTYYoIIkdzBDCkpJSAsuU7HF+oPjJZ+89OmHouF3dMMMQE6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIYFrnje; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIYFrnje"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93cbee4b010so12550185a.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790970486; x=1791575286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=doS8d5OZpw1xxXeF9uWp+A9weIfqE/dyEXBrkjrl1wA=;
        b=SIYFrnjebN6i2h8BV0w4ipVJsn3/C8A6j4N/VObrU0vndp/0abYyQYmDME2Gxu1t8o
         j5+PmtrAoq7y4Oiiw4yrXu5qF4v3cvSE1wzwN1v0xjg9SEf49u4o1CerJFD2kJlYIzXS
         B2fxTjC38Y4BipERY0AiQm7tc2AQLGQATITtVzrKKJU3pKtK4p67nhMs/r9FHBz2SR5D
         /JhDAfFVXyK0/ZEOxmMHv73/cCyxA9JYqyIpyDfbw1vmmEjcy0sij+2polc+/DrVC5uT
         if5Voa/lVaEkNvg7oOPJb9gdOo1uObsNMuq3Ka8KM7CSDfgaSepI+IpaBisA7AfVoLZ1
         Vcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970486; x=1791575286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=doS8d5OZpw1xxXeF9uWp+A9weIfqE/dyEXBrkjrl1wA=;
        b=g+BHubQV+vzLLdr/eC9P584PcaoapYJjjw15iFNjpvaplbh63AF6ZU1y5MHvTDcoNv
         S6ZgVGDBumelO4uswuuebaRXe1mBlDMw9yH6MEoJTeXJqGI4CgTOD5xzlt6dbxNkpISi
         q8ypSWjDtvXIDF/1EO0w2b7rPN7Nwa4EvDwTf7+TuT6qdFD4SVgzPDd8D+ietZCdJTT8
         veph08p1EXCi5ZABdsDX397TXJj2g0OpPzhrlofBJZBQTLgy0wKmHerlxjNn9VF3dI8j
         7D1Oqxj0g7h1EYIb6gSF92g/1ReTd7bqaT7ftws0gbxCvaxpdxskK1ULCSPJpfiaV+NH
         X8HA==
X-Forwarded-Encrypted: i=1; AKwUvBzfNdPBXypgpSVsaptTS9vJFyD8DRT6rQHMrhNqBYNKsMEMybnKZTrfeQlsLxocIiWOCH97mUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nOP7HJUjzCXwO2Xd+LhmJsYw+TJueS/Vld5NuBnqtB/KuGE+TM
	WBbCvShprpkReDOnsuWF0iugSJCXIVWvTg97u/wMYaLsdsZ3OyxA2LGY/hkkna0=
X-Gm-Gg: AYBFou1Iwp1EFJPbrv7cTJXUTcje45wsUFeeQa3R1T21aDiXZ53Ft4APlLlwQYx7aYi
	InBkDiSzTtStKR7VDgTdHgdYtZHIV78JBaHlp197uPYCoLuNB5+Pi4CeNTi53AdDLRq5+FbOPTa
	mnp0/CxKmpbuK5mV8EPpvqNhoHAGNZLrJei27yi9k8AYGVrjz91jYQFG6AOnJJuOzT6b044VTOA
	i+Y7owKC+t3q37qo9zzX2yxdQ6qMgEy4XWte8O3XtqrDgQTM/BwXcZ4m82meNGq0uG9rBdrwkD9
	x4FkNHO+W9Xq7ttNrmjr965eyJCIMbJiezDp37XfhCVlkhzfQ+E2M7Gimm80nERFOtKgkZWzFhJ
	tQq3NfGC3hNFLnr1SI+bN7sCBmPR9tW57peKAOPJMtjRMyRhVxlyRwiHTFqUtbKpYoWJ5yI0TWb
	iVYvQzhccnbPMz5nQ/mLNfeV2GClk3XylMiSCmHX4KZtxBP6MTjQiHjpD+4noIV2N1fJGua+Ue1
	MpYiCHb7ZuYM9yZo6AomXBhcLxbPqgtUmNpUpx60r/wE8ibrpUejp96XPjbBbNhu9zNMBUSl7iF
	4jmHqk/mk80W1FY4b+ltugQ1ROwQ
X-Received: by 2002:a05:620a:404c:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-93e51081bbcmr76979085a.45.1790970486211;
        Fri, 02 Oct 2026 12:48:06 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca2ed5e2sm296846985a.47.2026.10.02.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:48:05 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ijae Kim <ae878000@gmail.com>,
	mhun512@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] soc: fsl: dpio: Fix IRQ cleanup during probe and removal
Date: Fri,  2 Oct 2026 15:48:00 -0400
Message-ID: <20261002194802.375497-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two DPIO I/O object lifetime issues during probe
failure and device removal.

Patch 1 releases the I/O object when IRQ registration fails and removes
the unnecessary unregister call from the probe error path. Patch 2 frees
the managed IRQ before returning its resource to the MC pool and before
releasing the I/O object during removal.

Both patches carry their respective Fixes tags and are marked for stable
backporting. Patch 2 is based on patch 1, which removes the probe error
path call to unregister_dpio_irq_handlers() before that helper starts
freeing the managed IRQ.

Changes in v2:
- Present the two previously separate patches as a series.
- Remove the unnecessary unregister call from the probe error path, as
  suggested by Ioana Ciornei.
- Move devm_free_irq() into unregister_dpio_irq_handlers(), as suggested
  by Ioana Ciornei, to keep registration and unregistration in sync.
- Add Cc: stable@vger.kernel.org to both patches.

Based on Linux 7.3-rc3 (fd73f4a6659897191fa0d40695fe370925dd3780).

Myeonghun Pak (2):
  soc: fsl: dpio: Fix cleanup on IRQ registration failure
  soc: fsl: dpio: Free the IRQ before releasing the I/O object

 drivers/soc/fsl/dpio/dpio-driver.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.53.0

