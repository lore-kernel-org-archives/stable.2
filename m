Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087467;
	b=odsRl8wS7KmU0aTbrBjbx9XoshifiwyxfitIn9p+pD1hO0c/nhqagEzFgnm1ZQevhlit
	 kNKrvbH0i7PlC8G5BYAi8XpQtcDUW+sSRt/nn3dIuCgV5TOkFT89OVqtoLuS1ZARgramS
	 l8/Br5/K1DKzi4ss6Ky+K0ODM7FjcxQ1tzSPUSA+NkQHeyBuvXiKZDKQ1bBJ9HM/3dfth
	 c71YIFHKXRuh1ONnywjP/dqagqk+mIUfL+ybdmoCoS5Zoxnlc07I2488j3VZV2xL5mxx2
	 OCo1Sfsn87aoQ5f9U4k0dpUHyMqWMYObd5ZtH7uPkCYPVIgS39tytNuRorDlpJQe3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/1a2zhpdMOBK0mOqw/Tno4RXP4oEFs74drCisxFYseU=;
	b=BGAHC1e7XgtzH3YphPONw5FMRpiEA0rMj04nfs72bLvoEcMWfuDVonW4dRBvFFXvi/8s
	 ls2T9nfLEHZrY9u5Il6y5BRTvxEMD1/N/VEaEh0Wqlm6q4VMNubfgx4KRmICY6Fp9VstX
	 yZAQNaTgLGVHj2Ik5cZY0UMJ8Ytpl6oKq4g4yDpELqe5Rz+ObMxDTRy92NzFLdOdZymhu
	 BlJCMixZeYAZ5ZjYb8Xqs+xfr1OxpR0vdJ9CYvAvi4um1kcDn9TV1QHA1RDosD/wAYkGS
	 3HdCzNX7Fs7zC4CnyxwA3sChjA/2elzBOoDIEIfbpdEAjeTwM4yL/Y2T9dVSFOutISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ISpxDJ5D;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657B606A331
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6657B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ISpxDJ5D
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f01f296937so6352345ad.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795087466; x=1795692266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1a2zhpdMOBK0mOqw/Tno4RXP4oEFs74drCisxFYseU=;
        b=ISpxDJ5DVGF8N/aDoxpxQdXM4+cJL6qMmIH5RKsZQMoGzMcIXLk4VJfefJXnTwINzV
         4Ku7wouKuWuV0Dzw8z1IBDzEC2rtaKEJtKIj/Px36IRP/VBEOsFy7B0la+qImczYSi2u
         T/rq4CNWanmRV600ZLKCDKttYVJdniPRZ4bc2ZaJx6kfkNn7YaAYUUh3RM0sRNMapcr0
         SugVjQMLwU/9Faln1uxt/pC72FprBdrkp1SXmTJrJcdo45jpoy+FfWJVf68cwBspkjWQ
         NQgHgLIJ+USu0JknlFUXV2LIqLOWAwma8/dQm6dy9mrlGYI9qHEUABczO4OoMpuUYcgy
         PxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087466; x=1795692266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1a2zhpdMOBK0mOqw/Tno4RXP4oEFs74drCisxFYseU=;
        b=A2H2fHhF0x/fdQi41nY7uDO7nVkeKTxH5h6MQuCpz/ZUqnjWKSTrzoVjjRSICP80SS
         6J8iUiIXK79vgDMcwQqnaPRCW4y9oZ4LboMyACVajOGLRMexyxdWIMg5zPFHK68QNMXI
         Ei7fZ4+R1EEKkWCHpdr5RALbv9XRL+AfiX2ppajesbsiTKKNn6K6vTOX1OZL2LY1CQjt
         lNu50wAcmPIK7bTqCZ5uqXaR5HN3cLltaD+wjtLeRXXjY+bJeGD38RZk6HSUtyM2jsHp
         QoBE53OIUuhd761Bi8QxIzoPrKf4v9Y26M1XTCMMSPnUgGaKtE60sinW//5Xvcq02mtQ
         Omyw==
X-Forwarded-Encrypted: i=1; AL+hErGSA7cWvNIPg+BCMSq5DVz9otL/7RRptSQhemO9vfJ0sYmeYohZs8RwU52X19U6PLxf85RShqM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BY+ig6ztQ6mBVK6SCY6sGjUHFtMi6cNr2oRnd/f6hAZqyw2VO
	Be9yqjoTPLDmudEkQFL4wx40+XTZXaXgE+NFQVUYeiuZOkfeYg0HCQwa
X-Gm-Gg: AZFdTZcJ2e+yGtAabmiBhKdfRfuOakf0czLX2Pa59wlKUdqMBG5THbVovcEOjsc/weE
	idQrmGj+btWZerFlQY/Mzg6Od3wVFH0oJ51V+U0fyPv3k8DBQQtfs3SMya6thKI5bNV+HxeqTTc
	OCVlMdNFCuHRCqOfwtmvWkKz5GsoZJPaGx3TpvEHTEdPNvmJsXu9i5Q1O1S7pC9xTPULSpbU90C
	7yYKgN6qQpC4BsDsK9rFRhbOCUIrRuXZbLYtfllPmFgbci9T44UbuCe/T0amnBjH1Qxqyqw9uv2
	yKtkFXs+Z/wp3wzHBqw3GcoptgfclcL7crfQqedsuJc8fnqJZjKI17++ftIe3YdkNr2w9kan9no
	axEdwWU7Hedz+kV2pMQGeXBO7wRBUAIMJsUJECLfUmSuDgdTOD0ZIbRnDXDQpxvAHvXadDaj4HI
	glm6fJx+5QKxqGjPs5CRrsBK1wNQsmiiWW6fT4vtcyVmhfyQi6bNeq7w2PpbOgtsvpw5N1Zjok+
	bn5SwkKTr/bpCQmGah4JFAbNaMnI2bLg62sIsj1/E2/VOs2sJE0dFg3LlrtIGyQwWMX6ZGmIi1T
	EvmjflXTTDy3fM2eE5Nor9UAeb2yAQFAtkQnM50O7nHKWHar5DHB/uSaegEqDjmJ3+534nnRvIA
	c
X-Received: by 2002:a17:902:d2c7:b0:2ed:2305:5244 with SMTP id d9443c01a7336-2eff752ec1dmr60082795ad.46.1795087465193;
        Thu, 19 Nov 2026 03:24:25 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:84c0:a687:3d35:47b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62876a6sm28540805ad.63.2026.11.19.03.24.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 03:24:24 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Retain the selected legacy advertising schedule ID
Date: Thu, 19 Nov 2026 19:23:59 +0800
Message-ID: <20261119112359.34543-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Updating the currently advertised legacy instance can schedule that same
instance again instead of the next selected instance. Add Advertising
stores the selected ID in the original request after mgmt_pending_new() has
copied it, so the queued callback still reads the requested ID. Add
Extended Advertising Data never passes the selected ID to its callback.

Pass the selected ID to both callbacks in the pending command's user
data, and keep the request ID for the replies and completion cleanup.
Extended advertising controllers do not rotate instances in software, so
keep scheduling the requested instance there, as both callbacks do now,
without cancelling the rotation timeout or looking up the next one.

Found by code review.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.5
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Tested in QEMU on bluetooth-next f42f5cae154b with vhci controllers and
four new mgmt-tester cases. On an LE-only controller with instances 1
and 2, updating the advertised instance 1 through Add Advertising or
Add Extended Advertising Data now makes the next LE Set Advertising Data
carry instance 2's data; without this patch it carries instance 1's new
data again. On an extended advertising controller, updating the current
instance 2 sends LE Set Extended Advertising Data for handle 2 with the
new data, with and without this patch. The rest of the mgmt-tester suite
shows no difference beyond one LL Privacy case that times out
intermittently on both kernels.

No new W=1, sparse or smatch warnings.

AI assistance was used.

 net/bluetooth/mgmt.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f1738..075252d72cbb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9099,9 +9099,9 @@ static void add_advertising_complete(struct hci_dev *hdev, void *data, int err)
 static int add_advertising_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_add_advertising *cp = cmd->param;
+	u8 instance = PTR_UINT(cmd->user_data);
 
-	return hci_schedule_adv_instance_sync(hdev, cp->instance, true);
+	return hci_schedule_adv_instance_sync(hdev, instance, true);
 }
 
 static int add_advertising(struct sock *sk, struct hci_dev *hdev,
@@ -9185,7 +9185,9 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (hdev->adv_instance_cnt > prev_instance_cnt)
 		mgmt_advertising_added(sk, hdev, cp->instance);
 
-	if (hdev->cur_adv_instance == cp->instance) {
+	if (ext_adv_capable(hdev)) {
+		schedule_instance = cp->instance;
+	} else if (hdev->cur_adv_instance == cp->instance) {
 		/* If the currently advertised instance is being changed then
 		 * cancel the current advertising and schedule the next
 		 * instance. If there is only one instance then the overridden
@@ -9232,7 +9234,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	cp->instance = schedule_instance;
+	cmd->user_data = UINT_PTR(schedule_instance);
 
 	err = hci_cmd_sync_queue(hdev, add_advertising_sync, cmd,
 				 add_advertising_complete);
@@ -9461,6 +9463,7 @@ static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_add_ext_adv_data *cp = cmd->param;
+	u8 instance = PTR_UINT(cmd->user_data);
 	int err;
 
 	if (ext_adv_capable(hdev)) {
@@ -9475,7 +9478,7 @@ static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
 		return hci_enable_ext_advertising_sync(hdev, cp->instance);
 	}
 
-	return hci_schedule_adv_instance_sync(hdev, cp->instance, true);
+	return hci_schedule_adv_instance_sync(hdev, instance, true);
 }
 
 static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -9537,7 +9540,9 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 				  cp->data + cp->adv_data_len);
 
 	/* If using software rotation, determine next instance to use */
-	if (hdev->cur_adv_instance == cp->instance) {
+	if (ext_adv_capable(hdev)) {
+		schedule_instance = cp->instance;
+	} else if (hdev->cur_adv_instance == cp->instance) {
 		/* If the currently advertised instance is being changed
 		 * then cancel the current advertising and schedule the
 		 * next instance. If there is only one instance then the
@@ -9579,6 +9584,8 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto clear_new_instance;
 	}
 
+	cmd->user_data = UINT_PTR(schedule_instance);
+
 	err = hci_cmd_sync_queue(hdev, add_ext_adv_data_sync, cmd,
 				 add_ext_adv_data_complete);
 	if (err < 0) {

base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.1

