Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612854;
	b=NSul/cgx4DS5/5An1Sp7HogLakoRnJpD+weZS6PwXZ4YJ9InN+ruL+3ApVh699EJYrP1
	 8E2CuHlcaft9TttGPxktSKGOKZfTGemyfEMiDfiuDULE5HWeNSnlBxFwhRAs+orBSdiWS
	 6fE+S5ww20oq1NAR9ze24Bg7aqO9pYGqWA+r7ox2bD6Hs+oT09k+e4EULIdMcnwnH2UJz
	 q+8/2afqCMglmMrUvoj10X+cdePZzi0MvR4pdHl7t/FswoaSJPUlU0vG6Aa2GZOo0+qb2
	 4WbM5FAfUlEiryeUH0Clk1ZwI6/AifhU28kMkTJ7vFRmELDKwbCzKnMzwHhYbgQyhvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=it6Vu4qt3zaK7MGxxtPRg8P0zTaXMG2Fc9lz6FZfK90=;
	b=Sb//ORU/K9EUDOkERI7rAI2uBBQg9bwMIE0AMZwXeHl0A5siHJXgqmIcYAvolRDbqEts
	 Y/AOHbVKvXT+m6DO37eANUaGPj7F9hN/eSUFX9coeY3uL1cCmzWjCrEkfnyKiBixXygvA
	 /mhbOWbnkl/u6PXKCRd1wTuVWe/3iETQbDw9+fRUsUTWqsVmLdCjnfIT0nVX2SQD7yamg
	 E02vsZIzoSZ88I5efjZKKQ1IB/F7LSOmFVuB5B/I0Gf33xlfCPFelUcgWFOkUVkoL5EcM
	 sNxPPWdm8Smw/oyKW3ojGgIMykCyemEszISse8b4aaeogCTSjlDuwWJmq7kREPbVLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K0NFfgmA;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982660A260F
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0982660A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K0NFfgmA
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1106799b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793612853; x=1794217653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=it6Vu4qt3zaK7MGxxtPRg8P0zTaXMG2Fc9lz6FZfK90=;
        b=K0NFfgmAD1BkLg8Vt/1M9Vxej+O0L822wWuMB4YB4Y1hQQRNjtgQcrsP58wumtCELx
         SpieaXvvYyuxNDJEGYbpN7EyvRifFgu0dKpJ0pjVLHLFDBy9RfAhvTtnTAlvhXgkFNCF
         M+rCjjH572pyOW7iatpV+x5NgSO3sWLEqBthReSwYWQMH2k9NV0hV6SopvX2MVlfCqPm
         5sUEd87mQHEV0JN+mNP8yspBh1t1yg4TA4JxyGhqTK3tt7up252c3aRkxPAwh5VEdJN3
         m82Rw+PVNSFxv3kCIk0oFLkiBdwvSjx1Av2b5OVnPhD+uvZ3Z+pxFDaUTZm7Cg/CM2EH
         0Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612853; x=1794217653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=it6Vu4qt3zaK7MGxxtPRg8P0zTaXMG2Fc9lz6FZfK90=;
        b=LzW9vWNTUAgjk+VRBmScpXs5c5kBQ6Yfwx7TH8+hL48RjsHMA1Wj1ELO+jN6HiymZS
         RAo7eC0+3LoAIgLh0WWNY+D6U0NPogb93EtdhJwK8JP6M3XfA1s0eZdfp4HzRzfg6Kff
         BRFUX1FRXjDZierbIYH3P4ikTljUWNhRux91uY131dkbsKD/wVbPoxQxyUzCFtc4ceSM
         JOXzD6V6+Jqb/+fJv+yDeDEABmJE6pu/6q73y5WgAr9ebFqrXvs5KUFVYfLVSgBEn9tK
         yFNYz1jv4nJq+od2g5DfDnYJvyQIQ+DsQtm+JMPSKcBfLs8iZ4DN2EhvlajX4aXpw1Vi
         2TKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBtkCaXX9T2jkGFFzeQDXJcL933Nt0PssD0PKbcFVYAMaxrviN//Ir3EjvFKHfR2ZxGNPXlS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IiqpDzCWP7zhG1IZBEm3wTv49b/jw4riMXDDAzKlrzQWZZODZ
	7R/EQNFNUl7nxb5F8qEiwhqw2TieCbVcpbSeqUNDX4ELi1PY8qzMEXzc6gbnkSKsqlwURA==
X-Gm-Gg: AYBFou0jsu59iLjKP6vbDtJgOf1xf58JQFjIypyA6oC7cG3q86KM0nsqUz7j5d0/GyD
	mXZ8rSGqR+mBmi1HAjNNi+xYzgUlJHtbWoAqjactXRpVg22X+PxQwjc96EYsm03RUUnVr4tpBYL
	FgIURZFRBu00AekXLZetjs45g+WSnrMAhcophC7qZV+h3lcv0VJQBuXNctqgcwbk4FPf1Wdp0j9
	5pyh+5+IkWCIuuoiPoEdg1zCjx4Cff+MF2ynlK+Sa9giuQU3KVvTM2lYLP5Y6d3yrgeafWQew8+
	Hw2+lt9aB06R5sHt6JsydslJopEYZrV31rVHGfVczE3pX65F/6N4Fy3TaxFb92A+d1ZTV7kCqz5
	hni8eorGkCjMHUeDNYd6CxJpFcE3hKgvqkfL8yuBq3wVzlg5PYdxIBcPGbfof0Et9om2PpJd1sI
	UcBR78WbDHDj8iPathqP/eQyK7RQq7utaF9MtLj++iFz0QrTqnla9SUaroQ4lAtJIe1i9dcH3fQ
	/VitFB22XfJmS9oL5GjuH4Sln7bDW3Sis8fegS/EGXBkroA5yvdwgn/cL1B9yHzDiEu3Ou+Zx/W
	lzKftMlgPLBPJP1YM/uuo6cs1OvAESUsDtKlciYXHb9OGTj5xXV5cmo=
X-Received: by 2002:a05:6a00:3a21:b0:8a0:7677:c8c9 with SMTP id d2e1a72fcca58-8a9bfde052fmr8075185b3a.51.1793612853308;
        Mon, 02 Nov 2026 01:47:33 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d479dsm1802116b3a.39.2026.11.02.01.47.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:47:32 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: mhklinux@outlook.com,
	stephen@networkplumber.org,
	linmq006@gmail.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Drivers: hv: vmbus: Do not remove the channel when device registration fails
Date: Mon,  2 Nov 2026 17:47:19 +0800
Message-ID: <20261102094719.35760-3-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102094719.35760-1-izaiahsun@gmail.com>
References: <20261102094719.35760-1-izaiahsun@gmail.com>
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

When vmbus_device_register() fails, it drops the device it was setting
up, and the device's release, vmbus_device_release(), calls
hv_process_channel_removal() on the channel. That function is for
channels the host has rescinded and starts with
BUG_ON(!channel->rescind), so the kernel stops there. Without the
BUG_ON, it would unmap and release the relid, unlink the channel and
free it, and then the error path of vmbus_add_channel_work() would do
all of that again.

Leave the channel to vmbus_add_channel_work(): clear the device's
channel pointer before dropping the device on the error paths of
vmbus_device_register(), and only remove the channel in
vmbus_device_release() if there is one. If a driver was bound, its
remove callback runs in device_del() and still sees the channel.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Cc: stable@vger.kernel.org
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---

Notes:
    The bug was found with kbound, a research static analysis prototype.
    The patch, the changelog and the test setup were written with the help
    of an AI coding assistant (Claude); I have reviewed them and tested them
    as described in the cover letter.

 drivers/hv/vmbus_drv.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index fc0f16f51266..e8fb0c4c4f5e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -979,9 +979,15 @@ static void vmbus_device_release(struct device *device)
 
 	hv_debug_rm_dev_dir(hv_dev);
 
-	mutex_lock(&vmbus_connection.channel_mutex);
-	hv_process_channel_removal(channel);
-	mutex_unlock(&vmbus_connection.channel_mutex);
+	/*
+	 * No channel if vmbus_device_register() failed: the channel was not
+	 * rescinded, and vmbus_add_channel_work() cleans it up.
+	 */
+	if (channel) {
+		mutex_lock(&vmbus_connection.channel_mutex);
+		hv_process_channel_removal(channel);
+		mutex_unlock(&vmbus_connection.channel_mutex);
+	}
 	kfree(hv_dev);
 }
 
@@ -2189,6 +2195,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	ret = device_register(&child_device_obj->device);
 	if (ret) {
 		pr_err("Unable to register child device\n");
+		child_device_obj->channel = NULL;
 		put_device(&child_device_obj->device);
 		return ret;
 	}
@@ -2228,7 +2235,10 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 	kset_unregister(child_device_obj->channels_kset);
 
 err_dev_unregister:
-	device_unregister(&child_device_obj->device);
+	/* The driver's remove, if one was bound, still needs the channel */
+	device_del(&child_device_obj->device);
+	child_device_obj->channel = NULL;
+	put_device(&child_device_obj->device);
 	return ret;
 }
 
-- 
2.53.0

