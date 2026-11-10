Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333246;
	b=U5nMlL5wpFaCiNX0Q2tb93kGP8mxDNXwWu6xbiVbn6BIgNpGHKs7tnc98w0Qv8RKb603
	 k0Qv+ZiHY9EBnwg4oVuBP4fP9k53cBtRoLsLOF9KHQzcK6X7Eip03QbhxoQN+1kVXF1of
	 EbjEy37ElYNYKAXnXvRYQ1B4XjUW1TRaQMd3q5n3BWTd9LwL7aw4UzowfBgD0vYv6mBVF
	 8Um5IXYaYlNyaJc7Oko6jCYqZpk/XJQc6RiJQeFp6raSBKYaBfuZpPmd+ZZRlQzoQLOhx
	 VKrSc4ICm27b7ZoGXwoQsKqsFx/eGKeOPNEF70z5xCUdB5YHYfQoIAkIMTRuF1rD3Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EWyUegrb38WBeDiaL/HzG3HTGpRVVOl2V2uFzvvGvWE=;
	b=cP4IQ5cZ/YJX5OdVZRe7aSxwIdrVD2+/YLBv7bNyojdaRLQsvDcKIu3AY4O0S5hWlt8r
	 v9jRaLTTRUw033JEFyUHnePEtRT5z12O94xPme9YbsWOsOlpH4Uwg4ecZCqQn39U91qDX
	 47gVq5RrW5IwKKqg7dYh+yXtp4llr9zvY7JEyCZCDa+9LMUnOHTeK6jWjkGYac6H3oKZD
	 tKtWFquUvX+wt4ytBOiGvKITDcPQdhdeAYErM1OHZZNvTKg5HJ4GCfI3kbqeJoUPGAPy+
	 mrYtVw2PTjEv4R546xN5aMLDThdLqFgXOjzjH6rUztoeAnnNj6Qw2gxDMS/L01EVu8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=MMzEiEXv;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A8606A223
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 383A8606A223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=MMzEiEXv
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so2483291c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794333242; x=1794938042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWyUegrb38WBeDiaL/HzG3HTGpRVVOl2V2uFzvvGvWE=;
        b=MMzEiEXvFOif7JcyED/VTrHGWAmrz9sVbe2WvjhdzoUO06U9CnL9Z4HXaF94yk4AFO
         EkVh+Qo3VL9XZrinppLR8Q6yIMdYa8PmKRg7Emkkpbh1d0Z/JoR5rNW9hUTMtOzza8tr
         zP7lfFDfShQl8QLZMfsrjAbiXcbj12PVGdaGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333242; x=1794938042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWyUegrb38WBeDiaL/HzG3HTGpRVVOl2V2uFzvvGvWE=;
        b=Vk2kvuTZddgYT9f7iYZm+x/G3Fx9eOJUU0m6KIMdaSq8p8OzkDeqA7A2SNske0Lxiq
         Tu+2Vgey0uwAAQnAMXFmizyxrqSNHw4gxmQ3jLCxvTq8kiKgmeZBoni34r8Zg34jU6o4
         t5xJwY5/2G3mR2lPmA4BCvmNsKESX6+cQ0aHfsauV6ZaRra0KFMXPAbOlWrwv/2s5Kug
         TEK7S0rOSy3as/zTSFZcceESO+uXQIzuZyAXXuqWvtZJ/BHSFlqfEFVPJabnrnQKCulF
         NhETZqgfj1I6utKyRpNhAmbNp6a2UZ2c8Hb9wCri2325o+vOCroAnQsRdIbGIm54GF2K
         zpfA==
X-Forwarded-Encrypted: i=1; AL+hErF8v1faR7zKPTiiWWCcDxe3FnmQbnfMJh0AsDegPXRnpCoQp/7/4mGtIfNiqoE2RBBoB42ShZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tMwKa3rDk0XaKKVVgOgoUkQhzcRju+1pRODQEgHLOZJdoryuu
	caciz5SW0T4uZHBEowgmtPzkcYYRu+FiFVufP3OKRmy5ksOzinWDnlQEnpK1+pNp3BE=
X-Gm-Gg: AYBFou2mpEhWiz3ZAd7dzC99h4cBsVDMntG+cJa1YxDiEJSD0TYhqCA6J/4FSm2KISv
	w/scKcAvFdWBqf0LkpXvYJ9XmuywtIGe6npqbNs+I8sTtB9/qu7wX4Fm761LMGQX61HHGR/foAz
	NVpyxExv4N1gR2V95Mc3rGkjH8c5R35PrXBu+p8rIUQ+UjghbWdc/x+YIzWWtrBCd322yiAJZWg
	Ywmn+sHLaalnlc/jv156ppUvAIhiCXoggoeL1Byq+IuL486FAVmY2q7iEN7ti9KJqxIwBGSwI1M
	HvFfehpBYJ5jUdBu6avzPL4cAVMygCF5evj1UVE2oiCscXsCdFMQ5UmvB3/sFJapB2gonWzE5cw
	d+Zqok0gGTaDpuYx7wJj7Pu5vXaxwqVEOeSXSeDm5CYCtE/TdQ2CHe5FE63DvyuSGcD6hRZ+ift
	1c+cmWfZqVZY12/c/XmHBUngyowH7C8+t57maWRtfJ7zoA97QkZ3tSlhZN0sjgg89HivRzt86Kd
	0z2+o007cWHRl4S0tY/aZZYXgBWhvFfI9tEZS6m8grfkfQZk3Ijy1KnwapK/aTfywoDCG1r5yaK
	HnGy4KQEGSUlwAFt92Msf4bIVr3Pcd0chjF2Pul8uEdiiOM9JV2CqsBS7mgvvI3WluE60+tHvWT
	c9LZAM/NX/t6CZZX7RnVqvUt+c9GZXZ7MZYIme1+QvEPHp6/QI/E5uVWTS61rW4GK
X-Received: by 2002:a05:7022:e1c:b0:150:c9c5:1ca1 with SMTP id a92af1059eb24-1b3b5fe3b41mr6356459c88.18.1794333241526;
        Tue, 10 Nov 2026 09:54:01 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm11875452c88.5.2026.11.10.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:54:01 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kapil Vaswani <kapil@presceralabs.ai>,
	Piyus Kedia <piyus@iiitd.ac.in>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: hci_sync: drop adv instances the controller cannot carry
Date: Tue, 10 Nov 2026 23:23:34 +0530
Message-Id: <20261110175334.676816-2-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110175334.676816-1-piyus@iiitd.ac.in>
References: <20261110175334.676816-1-piyus@iiitd.ac.in>
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

An advertising instance stores up to HCI_MAX_EXT_AD_LENGTH (251) bytes
in adv_info. How much of that is accepted when the instance is added is
decided by max_adv_len(), which depends on a feature bit in the
controller's LE Extended Advertising support:

  ext_adv_capable(dev) ? HCI_MAX_EXT_AD_LENGTH : HCI_MAX_AD_LENGTH

ext_adv_capable() reads hdev->le_features[1], which is re-read from the
controller on every bring-up, while the instance list is only freed in
hci_release_dev(). Instances therefore outlive a power cycle, and an
instance added while the controller reported LE Extended Advertising
can be far larger than the capability now allows.

hci_update_adv_data_sync() picks the writing path by that same bit.
Without it the legacy path runs, and hci_set_adv_data_sync() writes
into struct hci_cp_le_set_adv_data, whose data[] is HCI_MAX_AD_LENGTH
(31) bytes on the stack, while eir_create_adv_data() copies
adv->adv_data_len bytes into it. A controller that reports the feature
on one bring-up and not on the next overflows that buffer. This can
happen when, for example, a USB dongle answers LE Read Local Features
differently after a reset. scan_rsp_len has the same problem against
hci_cp_le_set_scan_rsp_data.

  BUG: KASAN: stack-out-of-bounds in eir_create_adv_data+0x2ab/0x440
  Write of size 220 at addr ffffc90006b679c1 by task syz-executor

  BUG: KASAN: stack-out-of-bounds in eir_create_scan_rsp+0x119/0x1a0
  Write of size 220 at addr ffffc90006ca79c1 by task syz-executor

Both are reached from HCIDEVUP by way of hci_powered_update_adv_sync()
re-arming a stored instance.

Bounding the copy in eir.c would leave the instance registered and
unusable, to be retried on every bring-up. Unregister it instead, once
the features have been re-read and before anything is scheduled, and
report it with MGMT_EV_ADVERTISING_REMOVED. Userspace can add the
instance again at a size this controller will accept. Dropping the
instances before the list_empty() test below also lets the default
instance be set up.

The removal is under hci_dev_lock() because
hci_schedule_adv_instance_sync() sends commands, which cannot be done
with the lock held.

Fixes: 112b5090c219 ("Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH")
Cc: stable@vger.kernel.org
Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
 net/bluetooth/hci_sync.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9213e3ef9f26..ee8b1cd9dee5 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3608,6 +3608,34 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
+	/* An instance's data was accepted against max_adv_len() as it was
+	 * when the instance was added, and that is a branch on a controller
+	 * feature which has just been re-read. Anything too large for the
+	 * current capability can no longer be rendered: drop it and tell
+	 * userspace, so it can add the instance again at a size this
+	 * controller will take.
+	 *
+	 * This is safe as long as there is no command send while the lock is
+	 * held.
+	 */
+	hci_dev_lock(hdev);
+
+	list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
+		u8 instance = adv->instance;
+
+		if (adv->adv_data_len <= max_adv_len(hdev) &&
+		    adv->scan_rsp_len <= max_adv_len(hdev))
+			continue;
+
+		bt_dev_warn(hdev, "instance %u too large for this controller",
+			    instance);
+
+		if (!hci_remove_adv_instance(hdev, instance))
+			mgmt_advertising_removed(NULL, hdev, instance);
+	}
+
+	hci_dev_unlock(hdev);
+
 	/* If RPA Resolution has not been enable yet it means the
 	 * resolving list is empty and we should attempt to program the
 	 * local IRK in order to support using own_addr_type
-- 
2.34.1

