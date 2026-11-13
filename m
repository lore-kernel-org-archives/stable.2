Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608271;
	b=vEqsLdRo0CX4Aj5xsEOmoyUOZktyQGhDD9a14ivqkkwtrF4vmcqLlRf/A5QMtnJ4V1Fv
	 CHr8HKRA0afYKpTtkHeQAH9LIpuMuxBy91cHl1w/u9f/E67IVWFjtDX8BuXtYY7rboNzz
	 m9Ecv8Spc2/uTh4u1gw3kdNg5SSShLqdYGqY+wNn1bxgro5jFuM9RLaRFPmYqa5F40c4d
	 jWgGc2ilNpUU5aVyoDqRjF16GVq1rToxZy3/d+cH/zcYZoL9MdwmZMDd2XLXeClN37v2L
	 FV1/2mXUVqIQKjk8kq0dNo/SXOU0QUZkaWs6xl9KdKVu+k++g9oadLu3WHGX5Sk/e4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RoOMKJstRsz6kzVltt6LynRLltK4wJnMWDIO5lBxAHs=;
	b=T4yA4Y9PfutwmjVmS6WApJRAknDwTukdZ6RA2HiX5Qj+988h9D36cGrAVF9a3zEK7kKE
	 viPoOgxMevpc6SOIAy8hXx4ULR7ZwOFsgz+FaSjfYxCpOlGpE0dMXHqB96j0fcGXKpCvr
	 T9bf5qmmaEIg4w3J6zY2gt7OODQuKlvQFuIXm79sLSHbU4ZiqUcWn5e/+/iaRbMUYIOyN
	 xzwD9pi+AeDCI/RLE4aXotrGLCboKUSRDU62KpO/6mWB/inno2YB0EAnTC71C5Eem7JV4
	 Hh3Px1A4/EhZ3YW+aYXitzMO6RRfJyvwhTp21bFGZTUQkDjTWN8DzcsrD58wBYdKkqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUm7RyM+;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85579606A329
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85579606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JUm7RyM+
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so578586eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794608268; x=1795213068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoOMKJstRsz6kzVltt6LynRLltK4wJnMWDIO5lBxAHs=;
        b=JUm7RyM+AXnjvlrIH2lobJSVH0t/Th2jSkDpo0OPg7nx87/mKmOc4/Y+3HOngLad3B
         O1GBloJGH/x7tNHFVTdP0y+A/2aZxz+nOV+Qy8hdKmVzwcUGBN2stSRPPaqbmvd42lyO
         v8mk3Ku0eL/v/nhnAgp5pucHc9Qk5NkSJCE5jCGtfLCI/poehuw5Z8YD5UfBdwog0rHE
         pQJeQieHsN0wksmeC2iEel4yEuYNnbUdNpAmNfOaQQ/GJ1Fjx4E7SnKu7Ezb9Fg0bS0P
         uqikaNy+J/mIloWXi+sX3FcbCuEjzNl00L3Faaz4FXfxkqQQk+kxq7wSz+XPnioI98uz
         +u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608268; x=1795213068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoOMKJstRsz6kzVltt6LynRLltK4wJnMWDIO5lBxAHs=;
        b=oDKuVJzLufuaqrbf2VCIrhYLxKWGMGTPBHLMEuKUqmjpMv4kT8VQ1nLR+VJNfPZ7Ya
         8T4U17ElLVO3AkU2DW8L0LmQw5o6EiHWV1WGtXs6gj8Z9Z3YWq0cQqAeSiRxB2EODFs5
         npeL7S537njzhQhpz5O/HUBsBRdC2pkF39s8cThv8wm4cQTnZQ1xqhYd4WtgWPYAwQvx
         czJ5wRstTqwxvf3HcVtYKH4CNDBI7AADZD9+AsI4s0UNUs5j3pjPQYcYd9KLGG7BlXiC
         BT+A1yyLF1rfUsm1nqncTTBySWuCf8vdxpNqQr3BoQtJb5YexvBIrqNlK9JmJ1nRLUGp
         Kk5A==
X-Forwarded-Encrypted: i=1; AL+hErGnKjrFltd9pDBEhhuCn3/oEjC/DlMXXwSNykP01TW6uVXt2KuH2VQ53hvJC3mxpR6XAdxQcYE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cQmne9d5UtWR3P4L74lw1m4ub0w9EUi4YdVtI/4pfAWymyYFe
	tXNLN/FYehzyPOnfqyOknJ6mXX7ZW+MFD9lHNjh2mbD2vOMLsITQS8yF
X-Gm-Gg: AYBFou2zM4wBGPRkjuezgmryu6ecB7Zr0lZfH2lnt4Aohi6DSD9L+4TxJrLeWyy849k
	2CWMIwOglOTRyCE/pR6wLe+COMARfPHieWdUg1DFwFjvk1Hn9K2MSikAzpn0QvpT0n+6mWDTNfM
	Ha+BHMrMGDj0pkkCSvEZ1hhD9p+BaKPgm/cSIs1bZwwvdjeOdF7vq3I7MoBgYLcis4bUdF/wYud
	1ZNSCv9nLiQZCHoYxdZJiw2AzO5r1Anlf8MpONajafrgrot8+qMOPpfArm9brMfX0pZ8QxJBUD8
	dRSBHSxqKV8UajXLJOP7TnUcQlHatd4qFxKYdhvDYl3gb9ZBdPAAvwQp/ZC5BMHlajUeVFVtTSa
	A3SHfN9avphQUqwSp0y5uClf7Wyqtv0v7ygcK3Z/D7oj8CapEq+qSZJxtXU2AR0E0WQQG+hHuO9
	adrePltfEDrXzCEPH+NqawCZ+TkkcnTcMo6GHWW4nX5AaYChSDmdZVKk6X9JAiouoN0gIiUgQlT
	5FqYTxPrMkhzF8ws9MrRsz9Y5vbV6v7h9gKEdrbRh9VEKXI+jRUEB9YWIfdNOMl1E4TpE+091kn
	Jgy5aVDZYRLKHfAVl6PALScnLPAYIQaQNYE+Tk4Z72sH4w9JkHZTkL6r3zRAj066EmicGYQQkzS
	8kq7+l7mkXeoDDj45gYPIFHMwjl5HwSj/GkRk3Q==
X-Received: by 2002:a05:701b:230b:b0:1b5:10cf:c458 with SMTP id a92af1059eb24-1b510cff4a1mr939693c88.23.1794608267442;
        Fri, 13 Nov 2026 14:17:47 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d8f5sm16886713c88.3.2026.11.13.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:17:47 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: qcom_battmgr: return charge threshold write errors
Date: Fri, 13 Nov 2026 22:17:32 +0000
Message-ID: <20261113221732.97506-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both charge threshold setters return success even when
qcom_battmgr_set_charge_control() fails. If the PMIC GLINK transport
returns an error or the firmware does not reply in time, the sysfs write
still reports that it consumed the input while the cached thresholds
retain their previous values.

Return the request status from both setters so userspace can detect the
failed write.

Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 636d6f6acecc..f14d731e0283 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -704,7 +704,7 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
 		battmgr->info.charge_ctrl_end = target_soc;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int end_soc)
@@ -725,7 +725,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
 		battmgr->info.charge_ctrl_end = end_soc;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int qcom_battmgr_charge_control_thresholds_init(struct qcom_battmgr *battmgr)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
