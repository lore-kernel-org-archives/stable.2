Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9342FB965
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814924; cv=none; b=MsztpoW27ZmvNHoyMacurtXrG0mJseGYfoSw9iArQYmHl5824VEAPGRzJGR/wWwsLmOiVh4TRNLr+gNx0Yj7ojCQA0BFR58MNGsaqhyRJ8WH06WNko7hPRmvHrXZbT1hwCwjod8QleFBGUfyttGA/UJIc+wEdgB4c5O3EX2iGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814924; c=relaxed/simple;
	bh=uY7iuDW2cKbgN2Qgeq/4H/Jy5sfRAkMU9qPuKO3jeq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeNjk7InUIOGEdC5ILd33gGNou0W7IHgOZU7IsSTxolMoUWPYFm69kdNxSDWsUhMRqd3HxNnkczqTVooySxv/ZqmGW01O40jSgJug/5dHflDdc8CB0UDOwSmeI42yYIOHRCQrjjmAEJW6L/+gZ0+w3r+8mLJIkXkmusbPH4uqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KJQpHvC/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KJQpHvC/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a76757e5so8981715e9.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781814921; x=1782419721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ErDVMMnCJh8AXl29GXVD3LL5ghXN42O3QGPzibnYxw=;
        b=KJQpHvC/gO/25pMFVIIKd7HtvYJUe89CYBtO/i0afUDPu4O7qS+6Lf+/hZZG4uF2qh
         FIbc3HGB0vuzWDLw3BsIiCmopgM2YC/HNqzb9tgYcGnjpv/3ND6xSi9/PrrI/4IY26dX
         eMiMmPPadlTjgM4fg6iUWWG1DN9bDV2Kp9q2vVIQQR/yezaGn+suDlFMd0sN6Y0cl3Sl
         7gR/qcLw/V7rMUw2P3G6YV+zLkrOA1cOSCzNiG2v/NzkKm1khrwv8k1dbyg0xR8mTegB
         UbKOJtm+7qR7TNsPIwApjV0b9CF3jbKPyYn2GFQNcBa5ybM12j+diFOyvLrhpcDUtxpT
         WUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814921; x=1782419721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ErDVMMnCJh8AXl29GXVD3LL5ghXN42O3QGPzibnYxw=;
        b=d240dFD7FnN6dIK+OwPH1OJXKunvb/CQC3o6K2pt6/mqS1NGLDzkP+UQsG5rOK0WXk
         QA0fSmH7KFrocuHMOKg9fzFkvCtNB7iAuBiuOAMicibS7t/RU5HHOdiVQyiLJBwDNo2g
         9tcBOtQCrSigBxt1uQf4yNI5wRxku8ZDjY1Rcv/hr4S2CIZVrIGpzfur4huWec7dYmC7
         MM75DC1v3DUtwD58XdXorra2MBf5TVC1SCDk2wuedQlEGF6hNiMMEFDx2VXx89kIo2SM
         qSMpaGgBWzTm7221hpJpkhwLmHqZ8M35d/mSGk/ADEkLdFd8Hsulf83qa6FsAdMaUee2
         YDjA==
X-Forwarded-Encrypted: i=1; AFNElJ8XRIwsmyBMKJK+oJllYHRnXBhxmhamTJOYVKgZ/dTg5nZow4H+juHATnjJZ5KFPkcnZrirodQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VqiBauNcSzIUjtOpnU6WHt2U255HabQ2L3ooWGfD1cZ+v0yg
	yyw8dars62tXIfqQnYe1+BTxebcwJbMeldGSECq15APnGVOzq8sDzRFVLRJuuksbQe0=
X-Gm-Gg: AfdE7clJUUawW9P+PJ5xTie2lJkJ9ZPA3X5vVCQTjglBG2W/nczknNZQiTwTNKTuBG9
	qgg9smTQRSCOMLvpISn4Ie5gLBLxo/JFi73QDGtJMGTjCMmwrnTn7IRoqwHJTwUK29gu/MGV6QD
	cibXkJLvcaEE+oTt+lEJ2rMwpqVACCYTeVv8JwkaNZCtnwKtoK2TzR9dOVNpgZGZaWOuhX8Gx2G
	jRE6uVYjXd+2iQaNgCGYgm0Parl7/2rXrFw8qlDK233NgW4qoDfk7Ktmglak4zL1TU9oRzkGXod
	oB7jC4XO98fZj89QPNqbbj9zT8fsT99k9rR2Jwr5r/DaUk8h4baW9dZeEryJWWGiz45rqwNX/0k
	/QxQPa55Qj9oyhIGgzMqUt/ry9mPF5oagqsEE2wtx983TPjz5oez+3Y9CAw7uOy6fso/LTFWbJ4
	5TlZSgjUJTUCv/l9fL6ikQ
X-Received: by 2002:a05:600c:c48e:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-4923f5a8fd6mr17674955e9.33.1781814921011;
        Thu, 18 Jun 2026 13:35:21 -0700 (PDT)
Received: from precision ([2804:7f0:6401:b508:d1d9:f1f3:d91c:79af])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966fc32849fsm439109241.5.2026.06.18.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:35:20 -0700 (PDT)
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	ematsumiya@suse.de,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/6] smb: client: fix query_info() replay double-free
Date: Thu, 18 Jun 2026 17:34:36 -0300
Message-ID: <20260618203438.667881-4-henrique.carvalho@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618203438.667881-1-henrique.carvalho@suse.com>
References: <20260618203438.667881-1-henrique.carvalho@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A response-bearing attempt can return a replayable error and free its
response buffer. If SMB2_query_info_init() fails before the next send,
cleanup retains the previous buffer type and frees that response again.

Reset response bookkeeping before each attempt to prevent the stale free.

Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
Cc: stable@vger.kernel.org
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
---
 fs/smb/client/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a7b1fbe28a2d..6e6aed87ab0a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3942,6 +3942,8 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 replay_again:
 	/* reinitialize for possible replay */
+	resp_buftype = CIFS_NO_BUFFER;
+	memset(&rsp_iov, 0, sizeof(rsp_iov));
 	flags = 0;
 	allocated = false;
 	server = cifs_pick_channel(ses);
-- 
2.54.0

