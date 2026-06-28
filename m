Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6BF2D46A1
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665221; cv=none; b=p3TOsVLt0HTk0QcB5Z4uv+KEacgylW4G78sle0mrsN/8bA+VWxPcezIIkCqJQJ2AFOSQpitxJ8p+ALhmRcm9D6IdKKtHYZ3OsFQeJ7rGCofdI3K5fTx0dZ3SBufPgOAdf4d1fsITFZ813k1chWAsUM3SpYo+dzAeUqAp91wcGsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665221; c=relaxed/simple;
	bh=5gd6GaXYemQn3bjFuTsTrUQliIBG/SFUr2HzcpB/QMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzY+kjbJCFvEMRvO42bNGHwfj7+zqFYcjYazkuPbFVZxZkQTO1XHQSTGsdlOXyS3+7WTpqqqT8v5Uqp0hEunNxhuCpH0wFSINCU1z+ZaWc4mcNE0UGfjt6S+Cc34k+0OHJ+AzgwjTFIEFRvFTyi86ikA6U2c5T4ps7guvR2FNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUopzp+L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUopzp+L"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so7025725e9.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665217; x=1783270017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qzlkLhjbs2w3dy46vx0q5tqaHqyJ3TWxMpmHk+cSsU=;
        b=hUopzp+L3hkEALFeWCJOTh5ng/VjmJrLmrlXAzDprnEeT4x79vpZZP8iSDKgJ5+xyD
         hbdu2GIiytdDE7ZdElsghQrNAha7yIgj3fGK/2Yopv0Ah3E7ugtTM4MeM+8yXDDQWGvD
         clRtZUa74RjPukllSbByAHqE6/EUb49AfuGhd4MOC/U0qhDhUhMYTcPXt8Rw6QAub9jF
         N3mlP2PwtoGBnSpu/5rC9hmXYeg2nnp5Cxeub8QNDnTpbzOwpp+Afir7u6K+zYZqM+2a
         h74e3E04s1WT5/4Z02TYT0EHX3bvs20vczS6yg02BWKHS1gUvWl/K+gJ2fFPpNupyQpD
         JYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665217; x=1783270017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0qzlkLhjbs2w3dy46vx0q5tqaHqyJ3TWxMpmHk+cSsU=;
        b=PiQpXyuXO3pURrvSAqX3Bmo6QK9scAW0fkc6yEeJQZn8/8LWi2hmRBuF5o6fRedPEI
         aFVC9EzKz/TXPnd3KJoyD+5/ee62snRUoMDrDrhMjIw+aT90PPUFBnsfXRWoZ2QVwkZe
         Vqi+akco66E2a4pZfR0oLEaasPmUYBHl0NDSvO8mUZbiAnTW9/AF8vOQR0KQXDUYIPV1
         d79uoOayYet+WNX2czvrJs/98MLr01rd17vmuKdX9dQ7+lcVnBRPR3RZlIrUX5SeIx2X
         m4SgKaFIVGJqhfIdQEx9I62ovL8dzkN5qooGPivbUa2yGvdqa1oXqUQDma2fGP+i6CR1
         zoAA==
X-Forwarded-Encrypted: i=1; AFNElJ/QWkWDVYMvArKkLPxMcVBMQiDHfur6U0/CNHeSyKFMLZfe1s3oLqfOOsJ8kX34QQX0625xV08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNTmMhgiehLnh/2vhdD0HevVtFBJUapF0YNjLB3jASw0UU1l1
	I1ae3jwtST/TTZklqf0eGoqf1aiWBas4r+Ral8qKCylsVHe7G4EgznjlTlfbVx+eBEF5HA==
X-Gm-Gg: AfdE7ck5dPjmdrCclxPUVS6PD7nR2I1VtguxdQqdG+viJjupbuwVnWHFTXasxX/WVQF
	+n/RVQF5tHohXYLOD3VNm6Ff3WaW5G2afOkD35nf3QplOpL+Upj5udqBVPQ2chHxfyoqesySCkR
	XxfOhnGPzDYS8p9Naq3WnRY4+joObo1KRsyfqWfeqMdDP20Cy+FJzRX4fHzLfqj4QUbN74reAkL
	9K0hWxmRFV89eGjmIV6cpEWuZkBlfTSo+TG3GsRqhEGhGRazRsmb4daGhOdFDFdD/VtNPw/2KHS
	Qn19eK9aUu2F7OBVOjBwYQ1JvVzjwrGfciVbD7P5mxJh5ylDoi5kiTn1WUi5M0p9YKdrmIUXvT1
	TNFvOdjU0syByKGCkl4AvG+nc+1tLRYCX/KbFXz7yuOxqCPzQoQPqi7HLUnE4zKFmLdUhWPzr0Y
	C4ph8yzu3ZSJsMJ10DrHaXAprCew==
X-Received: by 2002:a05:600c:4fc2:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-49266423f79mr189832825e9.14.1782665217301;
        Sun, 28 Jun 2026 09:46:57 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:56 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 6/6] HID: roccat-ryos: reject short special reports
Date: Sun, 28 Jun 2026 18:46:11 +0200
Message-ID: <20260628164611.17467-6-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ryos_raw_event() forwards special reports directly to the Roccat
character-device layer, which copies the fixed five-byte report size
registered by this driver. A malformed USB device can send a shorter
report and trigger an out-of-bounds read during that copy.

Only forward complete special reports.

Fixes: 6f3a19360545 ("HID: roccat: add support for Ryos MK keyboards")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-ryos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index db83f42457da..5087defc7c37 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -189,7 +189,8 @@ static int ryos_raw_event(struct hid_device *hdev,
 			!= RYOS_USB_INTERFACE_PROTOCOL)
 		return 0;
 
-	if (data[0] != RYOS_REPORT_NUMBER_SPECIAL)
+	if (data[0] != RYOS_REPORT_NUMBER_SPECIAL ||
+	    size < sizeof(struct ryos_report_special))
 		return 0;
 
 	if (ryos != NULL && ryos->roccat_claimed)
-- 
2.54.0

