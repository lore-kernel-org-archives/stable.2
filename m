Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAA3806D7
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410434; cv=none; b=UbsWfwjBHi/ff25WWb/KfYO8XOJ5leTCZYE6gOsBaO5ZcrrxeK7QUrAY/1ZuS1EsFNfmJM2rhQL1iKwKLr7Zz5I0jNT64/WR4IQl2jrBUKtls/9QN9/3lYNWQs56WvxsElUSJ/lXbywVlRUKIr1cCismpoO2USIhgopPP7Cd6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410434; c=relaxed/simple;
	bh=Ct68b+rCLNKPhle3WjAX2nOyAsy3vaqQllFLahN6aWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTXVZNbW3S/ou3wa7fHJwA9MJMyQHDV4QedJeD1vTHc52oWAmgZMjL6QtfEhEMPhSa5TOlRX7fcy9AbNh1PxhE9pG95iqJMz/K9A3sC3TydRzywesviYWU4wKicoROgK2VBcuOgwr0xxGkmte0YFALu/tKsIHHv4gQMR6ywpABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgKbGZHP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgKbGZHP"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso3136604a12.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410433; x=1792015233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9w+vTKEC67XaJ90lkJm0RhINu8lEfisoCkmy2OaUF0=;
        b=LgKbGZHP3N3kBb0Vry8HCwWJLCaPf5cKMlCsqXEBBLulGdDEMlNh06+YWFle9EgKNL
         JZzMOC8pxjhfwuQPmRhiS9XO83jgp/fVXCfSpjswnRoJ1k7fkWhw8cLv8yRSTemuBLUE
         15bCnrmRpfANjwoezUK58NqYuG+mExxYuF/bMf9tFZEJ0dIv0pjkcsEoQlLBl2TQdLwc
         pl5N1SFBMEq67X/xc92De8i8bAfH9gI8l3jvjRHVqMEW7TWzDN5Y9oFunqKZhU/6mwVy
         nLH01Y3BB9y3ruaMoVrPRe4D+hWQ5h08SwzrPVFJXCZIlFJrZfyWHUA5b1seiKQTE7OE
         z0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410433; x=1792015233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9w+vTKEC67XaJ90lkJm0RhINu8lEfisoCkmy2OaUF0=;
        b=X37XB5Y/6+C3WEUm+GwsO2nbg69uXKoymUmnbpahwX9iLR7KLIjtNgzqA3Zbq553sJ
         kMqac1NTcoa6IxWxGu4MQBQDagugIhmm0/LSCmGxM8tNCIw+4v+hkedd0RQEFNuURPq4
         L1cyKiczS/pBjJ36+yMmcnYjTDxHD6zqiyuRxQCbjNBzwT368LugoH3PlCUkjOm7i9Ae
         piJV20whIBGPfnhFOfj8XLlrZvfcSZbqx9QUNYQQdAtFpm3wxlJZoGAQpZRNqFd17j3H
         vk7Xy0kaqht/hMq1gFRv7pgmrVvCsk8a2LnvBZwyz86njKHcuYHJ4bRF6eRenoWvFDOb
         jFSA==
X-Gm-Message-State: AFq9FYISAk8yA3BHaRkbIApjbrcdtvkzcHo9SRS+JqW3x9jjZfrxJq9I
	zs1Dq76QYtRMJ99s6GAT+6yjzjKYP5nYiYpX7kHrPmXbqRehQEUbz323
X-Gm-Gg: AYBFou1/nzTovtyng6bHPPKASXUxAijy70ZeH9PMoD7hFzxTMNdnogbKEBK5rSAo/9e
	IjY9mvo17eIXbyTnS0S44LsEjGyZ7loLBFYtZMNHwZp4uwo3GMp2TrtoEtxSjYjNwnHC14JRd1J
	S+rA7wXx7MGuckaX+6H6LrwisRn45aL203GUO4+x/8AMS2dy+sEZyAAONjxbaNG/9Ev+iPYd279
	+aWjmkMCpuQXDxOLrUhYPnw9P/9ezviNkzbNxgsj1XuqT9z9/se/hC9ryYR9sEjh4MxeePpilPK
	3t4JF1FOb+IYK1UrYfEWlYrvVeTipKyJFKkiMpJo0RdYbbC81cap/4Auou6uhN2fao5vv1/xliN
	ueDt0JMSzz45b3qcHyrakak2JjvDHN4VPlnrEfgSk4sSquPcVwd7PJgpzh5XcsCiQtJxJeN5tcv
	vSH+5y1Xw+5uES61ZLUPIstrbLWFSdz5IA2M7devN6HKfsUR8gAdJmHDwq6Gvv03NsuGxm
X-Received: by 2002:a17:90b:1c0a:b0:3a8:7fa3:fd6e with SMTP id 98e67ed59e1d1-3a8a1b40063mr3443846a91.47.1791410432505;
        Wed, 07 Oct 2026 15:00:32 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:b51c:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cc1fbb2sm1151256a91.17.2026.10.07.15.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 15:00:31 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2 RESEND] HID: wacom: Write shared touch initial status only once
Date: Wed,  7 Oct 2026 15:00:27 -0700
Message-ID: <20261007220027.6449-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

For consistency with how the shared has_mute_touch_switch is handled
during registration, let's apply WRITE_ONCE to is_touch_on too.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
Note: no code change. Just commit comments and code comments change to the existing patchset

 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 8dc7aa1c0a26..33fa491fba92 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2386,7 +2386,7 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		 * match historic default.
 		 */
 		if (wacom_wac->is_soft_touch_switch)
-			wacom_wac->shared->is_touch_on = true;
+			WRITE_ONCE(wacom_wac->shared->is_touch_on, true);
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-- 
2.55.0

