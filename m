Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CA3DA7F2
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136241; cv=none; b=iyUrF5FmFa2zn7jr1DvJCnqbft5fI8xoLMg4i+hbVHLdJ76F3jyJMrgolSk2xMJNE7j3ZSp71yPpfu7LFZ9X2GExTDtZrCvteG6wKkBcJgAYgeGlgOhYkFkHXNv2oF93ICan1hLHbbNSuQZGgfEmvPKjFJyhzbzaggxX00yJCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136241; c=relaxed/simple;
	bh=0ajQB+hPab2vIWSNK6YjKmU3k2ZE+ruh1odyGqqOzg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USFYVRBTeeXB/uBGZ6OEm1Tb+LwM6MO0d8d+jr9+6CNt8+YOx35WEoKhijpKVOiB08PMZof2XA8g54NIprJeRZ78hcZ4sY7Bl0Q1F5OC9zKV5bmI02w79sOgxeiulNva3pr5lDgJZDKPJ10zbEN1BheQXsbQvzPc9UexdpYlt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0HC5nN0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0HC5nN0"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92ed3993c1eso129555785a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136239; x=1785741039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=H0HC5nN0Cb//8P5+s9yAaKM5b+hx6wttQWPo4zFfT0WZfS6Eh3CtPI2oOoZwsSjidm
         KvDNUcUqTihE7Sdwk6RwykZvdSMqAuzSXZo21T4kGJPlG3WjZ4m2A7BahwleIwbxkCbc
         C6xq+VjBXYDSgB5j3Rhz3PvMYOmWmheFFAuZuMT72jSOhcWwxyBD6s65xMzRcrJC0GGt
         UggHh4Qc/0fFkCkxFDNM8zcgaR7mCHtH8IMKY0ur/GUxwAWa5fICCUpugAky5R04Y7BR
         LANNKJ1Wuti/O/u41RuapEQeNiu4AP3KuhiQ2d6D2KBWS/+Bemgt5o/bfjqQqLwQRVB3
         S0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136239; x=1785741039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1OaiGLLoxTsUad13rL5qrpAU9a1lh1UZkttvZnhnlXg=;
        b=FnIMYHScVjpmQEmuhu2429rD8uKhzIGkqzrcX6v1bBBYaVsRyZjUAyuQHIzNufWXNQ
         +4Yhzv6m3ohrcOVCbBqylkF+dDL1a4x57JKhu4cWORcBPZyS96lyuW/XRbpfem8nbF/E
         1K60QYQSLrLPpsfLdS1E+fK9me0dgLX1PFlOzTy04fGthy3aNGHAy47jOENcfGFfua4j
         oXH+95KcGtHO929kiJ9WhbLsZLydG5O3Myi8guu6PfygboD8pPnk1mKvD6mmWgbRjCVm
         vJlk/s9IPvDGS9N3csABeLi8712Bv/DPAx7PFjvrH5pYf+S3kJcst0j49Xo152CMCCWm
         VVkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsFhW0qEdfksuxmG06IasvwKF4dga/VWBqmcJfMn5+uUeQ6GLcGexwxVlaDF5aprPNhdrq65Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwBvzpm7CamibRfoP1Piomk+awM7HW7s8iOqrQhlTHMdD+k33
	ADE2czR/OleUiBUv3YDKWqtz5zHxoSlNEMCnDFhjlwS/IDFlBTdryv5k
X-Gm-Gg: AR+sD12O6Ufk73nqq2G+K4kjRfWtSIbkgcrc7N0EgKuCpzh/rgmWeVubIRLvaN3yEZh
	kRit3ChEn0Vj2r7HZ28fGcgTK7MMSsg/9+8ieM3cLMWo4OgFx+HgWb9ppivOo56wOjNYlbFIKvM
	WEANIWo+wJ2Q5oSxFCDhyvb4tYwtdDJ6jwasKTl0I4wwZfTqBt/b1j8qNg/nbIDJfZTZOzm5Cww
	YEbGXAfNwWFSftzgikJU/uiL1kFVK5KOv6kwK9nZL9zh3djwJVwa8Z+9FNLiv7r3T0I4fQeHJuZ
	AE7UQG02/cwCdFhaeLYj7IYmO5oFTUYh65tuwHdhshkIzRoTotRcHjog//CgsXCcD81WIpW3mV9
	ciybgbAwC5y4gcSlIDSlTcWtZPV0nBoIquqcuEgUpqbNCrRDg9LJRvdln/7etSDaC18ID4b77CG
	DEOJWC9FmPm8kv8g==
X-Received: by 2002:a05:620a:26a5:b0:92d:a06c:de5a with SMTP id af79cd13be357-932df6e9ecamr702151285a.45.1785136238883;
        Mon, 27 Jul 2026 00:10:38 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de569a84sm557850885a.21.2026.07.27.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:10:38 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns conversion on 32-bit
Date: Mon, 27 Jul 2026 15:10:29 +0800
Message-ID: <20260727071029.1355476-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_hsmmc_prepare_data() converts the command busy timeout to nanoseconds
with:

	timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;

busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
performed in 32-bit arithmetic and wraps for busy_timeout values above
~4294 ms, before the result is assigned to the u64.

The driver does not set mmc->max_busy_timeout, so the core does not cap the
busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOUT_MS
is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapped,
much smaller ns value is then programmed via set_data_timeout(), so the data
timeout is set too short and the operation can time out prematurely.

Cast busy_timeout to u64 before the multiplication so the conversion is done
in 64-bit arithmetic.

Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value for CMD6")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..3356ac5a1fa0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
-- 
2.43.0

