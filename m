Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB62D978A
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665213; cv=none; b=Ecbr3tN/cE3x9F+nKvaosV0j9oF/nb/sJFdpqRojEvUj3dN4fXtKU4hPJpm1l2k+9o/LDXgOxjAIpVNIpdP2xc2oyaYb6ZVO+UrG7dGouar9SraJy8KO/z6F7G/hp16s1t0MxoWiTfClyF98R7vLoiMnpHFQT2WeGn0gsdKCPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665213; c=relaxed/simple;
	bh=apbt+R0cL2oOzCTPz8RaRvTNoPfeUQburZk0MbR6l7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpFGuCwnZwY0wICz5UBo6yy3Qelgj7EQ1zvKp+H6gaMG7R8O9AeENwoj1ajRJqi5Os76vWclndUYy6fmZhQjqlag2YVMaivveeT9ppbhzqslShvMfciU5VTRGTKmrJwpYOfp4cHFLkE9aUNt+cZzEdOL/CKbKp1I17U3JW+RvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJh5RiWQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJh5RiWQ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4938d60c035so9633735e9.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665211; x=1783270011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CowELyIfZDZEDORa9YyeNmFD8Qz09NjqxqPj3RI745s=;
        b=FJh5RiWQWAOaavAWRQRvrG8kEzRwVoPrUjogr4j1KkwYdy94fRxa8vrh+bRHcqz018
         tTlGks8EmTceFEWcy/UTp5Wg1rnoLNp1X/MmJQMqtEiMJYIXyA2q0aM1rysjcTgUBFti
         XS44nHj+pfs8/Q2cLvNroIAMnk7vNCRg/JL/vmE6ivIG/yyofc0AkX5wlP/oFXaX0pOv
         uocT8JtIrvyuV4oyqDgDaoiA7rc5iAUniCLtQaO0Elej6ZGUgXYU43PdiAGGnBAdJcm3
         cJOdyyuhSzaFDMLn5dU3aLAq/XUc7zh4YsGPyFazo33wo7oZCum4n+kt4IIIon7GzegT
         yL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665211; x=1783270011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CowELyIfZDZEDORa9YyeNmFD8Qz09NjqxqPj3RI745s=;
        b=WWZoim/90/B6ISB/7QSP728rIRMHobqk5BOCz+wlXK7m9uLGGWBf2qNZBzY4SuG/NG
         wjU+MIBZntAAp4MgGraJCjYL+xtjrQAc9fChfibpPptgUYKwOiJLtq5HZJuNgtGlctlL
         AyBWtTmSPRkwrqpzSR/tglp8xalGUM2/2IIjbflX9dGeBz/9hHc98HvtwoUvVfNPLy9L
         +N/f4F5Q0/FWJg+Zo87y+tdns79wjWd+q7C8jXZZFnt349pLDeY2h1Elnyvsnb2iZcM6
         j2MYwx7jbAHNQrtymJ/6+W7TPQLGNPuLaYFO6vsBxtemOCIieK5iDfP4L+EY6H3f8G2M
         PRiA==
X-Forwarded-Encrypted: i=1; AFNElJ9yybMtva4agV7spXgRrbb80SxB1HDkTKAxH0Yk6Y4LLMLKFD1S3YgCyuEUW1C96N8/85TyYjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7cUbj3OUt2XuEzIhqkSqhDKg1Txtvw5H98G8Cbfc9DwPrHVx
	+aaWR8p6dfYtHjJzgdJodglmdQH7J6bmUi1BaUUqwUVTyEod/bQG2846ns/8ulMxfxaSTg==
X-Gm-Gg: AfdE7cmV+u2yis2I0Pi8NeAG0nBp2xu1CgeSia7BgnwDu7DpY+6D+lsa4alSB85LBTe
	HQWtmwxVMte5uhKxoHOU8Hhn8obXfw8K+iVRyMrNHUidqPuA4Ou4BRmUPe6RxW+LqpGOD2y3L9A
	p8OENwKtAPxKNC0un6T69G/S1VB9X+wQDaIAmEa8hIvdIO22BINeEfsOv1kwIfWCZ8C9Qqmrzvd
	F4+qIykjfMMd9FQUB09HeL2TfYYOHOC8otrAvvZJpuGHxB41xsp2k97oCvX0qP9J1tqQ8k9tNLM
	3f7KpqL1oTXzuLmlg57BSceqdk2xL2eycjj5xW0sosq/uKr0huLcj4DDucEDwLMob2i9BZPtCUK
	E7niG8rrtBsfWr88+uN+UUXdyZc3e/RfJu6ktN5mWo4hcnkyZWsGEMRq4MMOgeCm7dggZg+UdA3
	KsalfHh3PX5efnx2rmcXCLyeV2+w==
X-Received: by 2002:a05:600c:3b24:b0:490:bd66:db49 with SMTP id 5b1f17b1804b1-49266850100mr222559125e9.12.1782665210944;
        Sun, 28 Jun 2026 09:46:50 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:49 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 2/6] HID: roccat-isku: reject short button reports
Date: Sun, 28 Jun 2026 18:46:07 +0200
Message-ID: <20260628164611.17467-2-alhouseenyousef@gmail.com>
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

The Isku raw-event path casts button reports to a five-byte structure
and reads the event payload without validating the received size. A
malformed USB device can therefore trigger out-of-bounds reads from a
short report.

Require the complete button report before updating or forwarding it.

Fixes: d41c2a7011df ("HID: roccat: Add support for Isku keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-isku.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 93a49c93ae8c..c65f414b13cd 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -411,6 +411,10 @@ static int isku_raw_event(struct hid_device *hdev,
 	if (isku == NULL)
 		return 0;
 
+	if (data[0] == ISKU_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct isku_report_button))
+		return 0;
+
 	isku_keep_values_up_to_date(isku, data);
 
 	if (isku->roccat_claimed)
-- 
2.54.0

