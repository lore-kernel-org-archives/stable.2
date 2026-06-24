Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B573B2D8DCA
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302089; cv=none; b=LKxwVYfPm7oaUxWAnx4QQ5ZsVhhRHFkUp/kUipus+QgVaImi+9AS3kKPZVvYg+AMjDAF7aM3rVQeNRFOxrODFXA3hTzMu6guayvx/+dsWobSvEwp/AkXmUyFXMAjeOZ0mivf86g+sjryB+Qsq6/D2kxJ6ppBq3FjqszSvBczsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302089; c=relaxed/simple;
	bh=NJIUWSJ2/5oDMgmPZyUjT8tDUusKNoorVLMnWl2KDBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JtKaDGfnnnTd3EK1lxuxtcBf0XJ6J82b+AN1LoZRd/BTY2Z0v2A6Xx9YBf+IMMwySgLzMonvQHeQ3MfX9mCLxVKZllSYUhkTVRfv2RbqlsqEUJrpVItmIr9d+juzTjihI2f/HUDcYjAUWWBP/Gp0Y+OCS0znPX6qmGBl+WNlgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoOVIkaA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoOVIkaA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so1056041a91.3
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 04:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782302087; x=1782906887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fLb/Hu2mPOrI011yJ3nUBFQGzs37RCJxz/GfG5VFFBE=;
        b=aoOVIkaALslTqjLFx46D8tono8mk+5wj8B7VAE1FMVOeDFt4T8aiTOVwjqxulZETli
         Jc/D+LSeic/KiSPbc3D/O8e7yEXgsC3REclumPOkFnjjzXrRYiDnt3B/UO2LT1lX6Tax
         M3hxUmDjSxzV7GlFRwaWmF/bWE+DitCG0F+2qaOuaHZItc/KRP8u67LasoynheyBv3xL
         B0SI3Phe0LfPnSu8ikvWl/ITxdwXOA8LxoB1Kb2mKg8+BmYMjohu4yXZT9fPUL2+SEVh
         TjSXxUGEc79O4FT8tUre9DaKu0HM/t4yE3bNdecEPwd7WqkndxByv2SZ4eiKiGX4QBKG
         7j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782302087; x=1782906887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLb/Hu2mPOrI011yJ3nUBFQGzs37RCJxz/GfG5VFFBE=;
        b=TdsDbSkhTWIMVJpNyXC089rVcAyoMyIZ8xwYk+gCZkG/+jE8pifflJ04xf/zLf5eq9
         FfRJ4Aua/pUa4SmAMvu0REr+FuD/SXyHRv2JafK9RxwtnLrTuFF1lSKVm0HyIZTT2kUl
         P0nYQrFu5m3GXsTehiRpiWhD4R34EDtlsoh00TzHFGyw0ujBxS5eA0OIpNHoRHk+1lkV
         JSiPWQ50j8p5V9jbvYTt3nXpxPWFSip/owggTW//CKp2h1o8UKPwSVvMKoiTkfaxIntw
         AL3aWv/bJxHa0QADbac5YpgeWbkNugRebKDlSczDjfbK1VDhrj0Q1w4sizd0+oQzq6X4
         lrKg==
X-Forwarded-Encrypted: i=1; AHgh+RojZdTULEJ3WkfNVa07mXn2cZxGXPf8xtVCflbDjVLsiLjdYEQusml/9xhWoOFWSbM2c4T8nDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDIRwFO3ijeYt2ZibvE8hmIlNiPKkooAj8IsFrbqj66JI2u2F
	nC0Jdef60fE07EXI3Ujx/FLq5YU0hUZmfJwUXJFa6IdfC8hZLdAdRI3O
X-Gm-Gg: AfdE7cmiPcUAPDVYwnt0ynMXxLeOr9pV73dZiwLd/NAVwvPOP4J5ylMP/6xGiBiFvkD
	ZYU0wszHqGEIgyH6ldS1l3WdbueWFg4oKzt/mZaIgqoHNUPz+qTIz/gR28upTr5WnqHSC/OqSyT
	V11k7vTISgzSRE/4n6sw8sHdaRlYbN0fm/8VDQN3+hPcRKOUAz8qCG1IqBOvxYmFHaL2jZpSOEd
	LJCmciBWgR8ZGgZm8kc8/oPDW3d5qsOmtOz/ogoawvbtobP+7umaR8xcNEuKxZUPt9bpjA8+AXO
	t5NRre8DebEacy8cJMF08U8JcKlatF/cIUtJImQGopaLO3NX9VB5XgluRNutOX8aYvKzLiFh1J4
	/h7utc+9aXthj9Jqt+7cWj8QFJBRUrv8l/+J/YqbiA866L0H8M5245EIZ/fyliwi+KQ5NquNv0a
	yV5ESn4iZTk8o3YwLRdfYbMWjlu391KMEJNnlPWh9xQCh45xkQN4ieVDn5tIi+wlXj9rG1rfraY
	eAOzQ==
X-Received: by 2002:a17:90b:3c41:b0:36d:7a76:827b with SMTP id 98e67ed59e1d1-37de4668d5bmr3113121a91.14.1782302086811;
        Wed, 24 Jun 2026 04:54:46 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3a843fcsm2359422a91.3.2026.06.24.04.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:54:46 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: eir: Fix OOB read in eir_get_service_data()
Date: Wed, 24 Jun 2026 20:54:39 +0900
Message-ID: <20260624115439.868817-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eir_get_service_data() walks the advertising data looking for a Service
Data field with a matching UUID.  eir_get_data() returns a pointer to the
matched field's data (field + 2) and reports dlen = field_len - 1 (the
data length only), while the field actually spans field_len + 1 = dlen + 2
bytes once its length and type bytes are counted.

On a UUID mismatch the loop advances:

	eir += dlen;
	eir_len -= dlen;

The pointer advance is correct, but eir_len is decremented by only dlen --
2 less than the bytes the field really spans (and less still when
eir_get_data() skipped preceding non-Service-Data fields).  eir_len thus
over-counts the remaining buffer, and the error compounds across fields.
As eir_get_data() bounds its walk by this inflated eir_len, it ends up
reading the length/type bytes of a "field" past the end of the buffer.

For an ISO broadcast sink the buffer is hcon->le_per_adv_data[], filled
from the periodic-advertising reports of a remote broadcaster and parsed
by eir_get_service_data() in net/bluetooth/iso.c.  A crafted PA payload
packed with mismatching Service Data fields drives the walk past the
array into adjacent struct hci_conn memory -- a remotely triggerable
out-of-bounds read; when a drifted field happens to match the BAA UUID
the out-of-bounds bytes are copied into iso_pi(sk)->base and become
readable from user space via getsockopt(BT_ISO_BASE).

Keep eir_len in sync with the pointer by recomputing it from the end of
the buffer on each iteration.

Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 net/bluetooth/eir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 1de5f9df6eec..a55696820b22 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -369,6 +369,7 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 {
+	const u8 *eir_end = eir + eir_len;
 	size_t dlen;
 
 	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, &dlen))) {
@@ -381,7 +382,7 @@ void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 		}
 
 		eir += dlen;
-		eir_len -= dlen;
+		eir_len = eir_end - eir;
 	}
 
 	return NULL;
-- 
2.43.0

