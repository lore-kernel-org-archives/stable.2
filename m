Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E93D1ABA
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464385; cv=none; b=pAVt5sqGbKoLmDLlqp8Ka0lu0i3e/JKx65L5wZ0xK/bbAM2zePVxHUVLQ5OGW6xYmAtyuQ9JNSYLoTg4MPHhjan0XtW51jH/J179TT/+yMLrnUmFfoD8oopMBmmg1fx5KMOTyKAJ76flCMZRFoA1xaR20SzxHpIobTmTUssJoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464385; c=relaxed/simple;
	bh=Q11AFmutljWK/xSGy1F4WCSSPG4F+Gb0p9DCwWyBxSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVuI/qemJouiO9EKJlS4VOP+AoR8NePn54tfrr7HSQdZhry+8j/DKQ0GGCWFM5Ods8HUHnTE9GKImkx3jUZ7P8Z4BlmWoTRTNmWCRgfN7C2/16onED9ecc4+hB1utK/blO9LieX9SFWjsgoyZ3HcuAWbkPhHRGt2lTlFO3xnJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJr3yVMw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJr3yVMw"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1953342a12.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786464383; x=1787069183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWLUXRAB0ac5pRSFO1pHnYmTLRg2ASj9kBuww6heBRs=;
        b=HJr3yVMwkECAmO1iz1t/HLWlS/+K62XmH2IGww4q672QC/tadQQ+FP++AsOwnauEKG
         PuOKx8P+Ievr8SOQoV7f+8RcQ98+ANdZhMpYas81kEM8vqzOKKPKCN34diiTk187MYdi
         UFtJRp52xgeL2WDXwKjKWA1JKdRlvhHfZVSPapYX3axpOUtDRcXpP16vPKJs44Y+KSWs
         wPVk795szMRuRuL7gGCK+fl1cEeU8bjch83jHIVx1zFANOzi/rK2+r9Am2z5nhXXsPfv
         HOJvLjthDtcCqdcuQCKmICRpR4taNlNxwp898Rq/y+Ka2ZS5rTSk6av86XBtBdx/z7sg
         mR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464383; x=1787069183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWLUXRAB0ac5pRSFO1pHnYmTLRg2ASj9kBuww6heBRs=;
        b=TI02hJxwQ6t+wCMR4UqkVt3S2q3mSUHdNp4fN6ivPmUE9P9u0raXLnxD7qRWeKGETa
         yUywGGk1qxm3ltqFcDad7o2YgT/Ym+F3xCmjhnYQGif9cfrSY6L7VdBdM+/ai2Gl7bu+
         arVdhwyFUERB2yn9q+BXUPNiQKAoXUyoWfh0ev651N/WdaJ9kD0Y6X2PmSbTT1Y/9Z37
         6FvqW/g2qh9kPibFcKKH2Fkac/nsktHwwF5GRjWKdjEXsEW64qfLnx7GD29V2gKkoRpp
         9jX8yEK6/c3OTaKW6kQF/qajLb58JlPEo5nDHceFKY6Kq5MK9SGv9N6WcgOV8q1eBoTc
         ebaw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1ipCXzziUPdodGo+slO6MVotN0V+aCNvF6nj0hf1FR6a/rH3AREbyUbmDRAkcn9JL3SpYFpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEIjUg29M5I4gG8AA4P1Jt9qIiRvLGGoJEW2+b75lsQ9BkAoi
	gnjp9ed+W2zGVVCbGe/FCYyiwj4eeUZnZ67nZbCkmhEJA6DgjibP+k/2
X-Gm-Gg: AR+sD12tBoN9EFhWgrYGHpwHym60m66nch6ZQC5Et+xZjjfbAgcuzSh1y2ChSYqbWwB
	IcUHCwSQTtvNrD7H1BO/LgaHm4zYojRqsVsRJIDunOksqFGzzk7hJkGJslzrj0JWtqnmvZ5dVDT
	9LvJB/yo3NfkRQAabEWeWcCUT7OAS6dEA+SiqSzBzaol4PT0uwmOWiMMqmJJC1Bhitv+r2+SZdl
	91hvVcbqkfnPvoF2HfXM0mXgrTksWZawL1Yimn49FBsAPLCZkjmfOnU7nA8k/whT8u4DpeJmxjA
	lx/Pc5pc098eMZWcNjvBGykGC1ri3nVMug75w/l+eR+tq5/1Od0c9/Ayb0AGWpC58I2u2ixQoNN
	z/DFL9cmPl65+WGOwuC7ldYP15CWc+dtx9z2H1jUWqEt147PxkFia6gg5Cgusgd6qkYC5D5e58I
	T03m1OfT2bjw6mIgQciUq2JTgYKkl82IsdZJT/Mw56Nm74Xh3JcfWUgl8fjmgsDfauMHm631NQU
	HTP
X-Received: by 2002:a05:6a21:e0a6:b0:3c3:7481:7a03 with SMTP id adf61e73a8af0-3cc2baff4acmr6296784637.34.1786464382690;
        Tue, 11 Aug 2026 09:06:22 -0700 (PDT)
Received: from Default ([2409:40f4:1011:30f7:310c:32cf:5ea7:7043])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3624c08sm916149eec.5.2026.08.11.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:06:21 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	gregkh@linuxfoundation.org
Cc: i@zenithal.me,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	Jeffin Philip <jeffinphilip14@gmail.com>
Subject: [PATCH v3 2/2] usbip: tools: replace faulty rebind_store with drivers_probe
Date: Tue, 11 Aug 2026 21:35:41 +0530
Message-ID: <20260811160541.29461-3-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811160541.29461-1-jeffinphilip14@gmail.com>
References: <20260811160541.29461-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unbind_device() currently unbinds and then uses rebind_store
to rebind the device back to the usb driver. This is already
possible with the safer drivers_probe rather than the faulty
rebind_store. Fix this by referencing drivers_probe rather
than rebind_store.

Fixes: a46034ca57ed ("staging: usbip: trigger driver probing after unbinding from usbip-host")
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 tools/usb/usbip/src/usbip_unbind.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/usb/usbip/src/usbip_unbind.c b/tools/usb/usbip/src/usbip_unbind.c
index 66a44d4a0d56..242280cec452 100644
--- a/tools/usb/usbip/src/usbip_unbind.c
+++ b/tools/usb/usbip/src/usbip_unbind.c
@@ -34,7 +34,7 @@ static int unbind_device(char *busid)
 
 	char unbind_attr_name[] = "unbind";
 	char unbind_attr_path[SYSFS_PATH_MAX];
-	char rebind_attr_name[] = "rebind";
+	char rebind_attr_name[] = "drivers_probe";
 	char rebind_attr_path[SYSFS_PATH_MAX];
 
 	struct udev *udev;
@@ -77,9 +77,8 @@ static int unbind_device(char *busid)
 	}
 
 	/* Trigger new probing. */
-	snprintf(rebind_attr_path, sizeof(unbind_attr_path), "%s/%s/%s/%s/%s/%s",
-			SYSFS_MNT_PATH, SYSFS_BUS_NAME, bus_type, SYSFS_DRIVERS_NAME,
-			USBIP_HOST_DRV_NAME, rebind_attr_name);
+	snprintf(rebind_attr_path, sizeof(rebind_attr_path), "%s/%s/%s/%s",
+			SYSFS_MNT_PATH, SYSFS_BUS_NAME, bus_type, rebind_attr_name);
 
 	rc = write_sysfs_attribute(rebind_attr_path, busid, strlen(busid));
 	if (rc < 0) {
--
2.55.0

