Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF612B143
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524219; cv=none; b=H2comPuD3tPyYuKFjKa6CJazAdkPycsKqG5fqqOcY/Xok55cprSEiAJd+HS5fXEeUfli3K+yVhyRZzBbVHskC0HndsAoVK5hz+LgY7IlE+MMZYpWml13a0f9tB3SkQdc/TV8N9Ok5QyqQHtuCVYNHJMvivGZ1fSG8Od3nJHwUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524219; c=relaxed/simple;
	bh=vzEInW3AILDtlCuTp6PU+V5lfdFdMa8AXK+R69RJOuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCdBRzRvEEcdv1oeB8nsPJP1lk5S1SOiP9LaObmf9pkgmHqZqF27pPcEvjDdQ5sqNdsXz6+x4c9ZMnlG4p3iDD8sBoR9Y4sOJyaDXlSMmS4TquH2XPbx/EYm/kYi13olccWOskxC0jvWHiFDbn9MGbFh1UhkgKM6I6NYNDtIUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkp2oKW0; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkp2oKW0"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so298030a91.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789524202; x=1790129002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2boQb5kVerPgWQfFRWhmiEpNAxPJICHNL8sN5LeSsMw=;
        b=dkp2oKW0igKNZ4jxqOti1XEs3CjRTJxnxLYZZfYFMQd9WEiZHAOVUhw2MafMnur0/V
         Ur+sIj3kNH9CiHoyEWnYFF1viiQNX8g7l7+j8j2/iFqAM7SIvBbwG9NRTkvY9I/E1VjH
         qGZEVVZPYnGU26v3dtn5Nvtrpd0rq78dd9ku6KT3mFGUqKkauwu2R1ApmMEGANWtzDB6
         ssr15dfDm38Sr9q0GDkOFiQTSULPUksH+fn/XmP2aGuDRDTknoj7qWnSfQE6JgMw4k06
         SaOuMUh0veHj101UiAn+Y2ko32JCzk63xSB2XNYTdAjMwGLx34mIbePN6w+86m3mrzZ/
         K15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524202; x=1790129002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2boQb5kVerPgWQfFRWhmiEpNAxPJICHNL8sN5LeSsMw=;
        b=QMOEr+rDPin57NiIvIJzvSjAu53xjaq94c8eYk0v8RV+SH6Q2Q6dqNPM5pCCqEAs/g
         FVZQuDIKSSlNL5Jw7J7lt4BNuGEhSMmdwB41WLpRkq8ztqhJDbrgZi0gfS2hu2TkltKA
         o9YKlNjfiq0tqff3zeGWHIpPcDA4mPhyUCoeZx6OZdgnclab9+2G/HZx4GLVxeo0fqXy
         LzcQY6sHKJjMHR+Sapq0N0mA9ysnjYUACgYYlj5iMtqUTueS29YiuTwkjZJmXL+JItDF
         YXCKdeUs9XutwPN0h0dqfb4Li6dXzd2YbRxkH6WU27C6tfO+1CZN0jfJAswo7SMHwLXp
         qDKQ==
X-Gm-Message-State: AFuF++lHtfM2Tcjw7QWYirvaTH2jyPEkusosNYpa2bxECumXv05sXJy/
	srysbPxKq/oT1rVfH4J9yfjtZ+Xg1CIVa4g4tWkm8Du5NWgP5s1y1c0N
X-Gm-Gg: AYBFou2ONqv1otln62kmCeJ7XsCvUHbiseXNXM2GFXQ9tzH03tJhAxE7whckAcAdJak
	4XQF7V2BebWjkoYd6NdSUyGIe7Sl4Y295lYpLUnxzySAkcR41qqyows1rGZOaM6JlH/7iH8mc9S
	QWuZK9+QrDRrEUzBRL1G3EkPEzUEjb1MFdIqDd1Wthn+9HXTHTByMFSduLtRr/0Pip4HwOWvRf2
	Juu55i6dz5zkMIuRdPrwvu6CGmW5UMidpicsDH2On6U1TO855XWyBVzaoXNkRdf4TkPZeUUstzc
	FAFM0d9i/MDE//JOW694VrgZB8Hja9gz0nptKJeXEX7xdr9OL7zWE7ZsmqOKrIUXeUIawH4eWXD
	b/M8YFDJihPBtZI4MeuO64pdjDuNeIJGTfUBUe6IbQxNZyqWboAkx5wm7fIWnE/QpJt7iq5KDzp
	13MbEhmSr/IoXqi9QF9fyYQbO0lueWV4ZWJ5BeJE8GRWg12UufNtmG2CZ8f0yf1ihFZTnB
X-Received: by 2002:a17:90a:d650:b0:39d:f7dd:4e4f with SMTP id 98e67ed59e1d1-39e1e300ab8mr1990954a91.10.1789524202169;
        Tue, 15 Sep 2026 19:03:22 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:83e3:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b3dcf6dsm1505898a91.1.2026.09.15.19.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:03:21 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 1/2] Write shared touch initial status only once
Date: Tue, 15 Sep 2026 19:03:01 -0700
Message-ID: <20260916020301.24188-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

To match the same logic as with other shared data during registeration,
use WRITE_ONCE for is_touch_on too.

Cc: stable@vger.kernel.org
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
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

