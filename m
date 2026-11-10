Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794282943;
	b=Hy4oIg5i68H/Cih0fmVS6nNr2IYS7Kehn74wLRaJbPLy/R2LNv4/kYc+PLjG4pb7jrrE
	 mLURyMepmLpuF9Qh/BTt4K3XTmTM+VPKMqOP+n+UxuGfUKHWOhn+lKoyI0sqQU0PBpeUb
	 gtmzOUCVDl//d6CZe5bDHZh0Nxh9i5k49Yh0UimM2wdQ9rPrbi+r5c1FXQmGtzavrX6oZ
	 5ZeajDDO9pEV9svbFZvX1IKxZfgSxX1I7s/JK1hAL08bgqXzxZyQbVdvocGgFEnv0knjh
	 O2YQnbKVTrEu+nDT8QAdo4GrlGIQnWxbllVkg1s8l9hwlKO8QO+dQGeMc3VTsenPohw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282943;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YM46cmKg9s3YMEAaiIHDnNhKJyqPOgcuT8k4grYpNuM=;
	b=qx3FkxuZSbYVgK6TC3uzXVbu9G/01tiv9Ge51Zdw18Zyun4ZvlLqXgVqzmTIOwoxj04o
	 469yiXbbBaSgYjBgsBwkGlQ/0fUgZfmd0tKGlVUfy7e8+MXwrRpgEDlqNflvcXQxMd3GY
	 IYhLDZkGlDKnOndkpyZlIRjZgzpCxWhFH4nice3uBUG0Q+W/22jCbO5nhfMABm56PKYLe
	 gtLR6sHclEx6bVM9DgBu8u5I3doey+mytPwY6wvFHA+UCSfA4SOonKz/t9SOby+LPNyT3
	 uLtO7wQMp8qxx0KnZeVe1wgxBLphzsMfBlYT5gGVI7smcp/pZaNwEKKXXsKW30GW7uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3Uhkn7N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72AD606A31C;
	Tue, 10 Nov 2026 03:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3Uhkn7N
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794282942;
	b=u/21lKxZz18xYlz9mV2rL8vJSfB3Pdk3/bz7QPLfrWMQOpMd/Rd2U2RBHlXrMCIi8Rhc
	 Pa2mDt4O5+1diVJwaEKNinjmlJ+R7DxmuP26ZSoTt9+CQlQkM9PLafJy0yCgZR4q7HMOv
	 URW4d+UJkNT5en/TuNI1InGyGNfli0PHjFwNq4xx8IUieYlqLpn+OcvzgXqLNcnlWgGwi
	 K0JFe2T0PNUfgGwu2+5XcT75yGbDBDUKX/IaB4gigvcqHw9mOUupuS1W0gME0IGbU3sWg
	 83wGkicGI1vsk3O/rJPnx0Ke5C8+GbuY/yvI3ouiDm0eFEvn0TFturd6/FhWQkz9+8Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794282942;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=YM46cmKg9s3YMEAaiIHDnNhKJyqPOgcuT8k4grYpNuM=;
	b=df6PtDjcPRwffKkVksGuTSHTh266YdkX+ooEQ/50O3se4ZgctmtzrBTf9v9eU1xSF5On
	 IMm0Eouo3Je9TYpzeAadnuAFHZ52/zkW/GKh48Sz9mlOAbpp68gULmb4jXw1YOHPRvElN
	 EwZmjtkfjnau5sX4wXhwDnII2+kgFXNN59somfVjFKNR0kfd+RvH/rrcWwOA/ZBWzIQYq
	 YbogC+cMjMNDPtplMubz8eSMbEtDnnn5rTndS9CKkWrFtT92AQD8AenQ8r7F/lIYKP8mi
	 6CXdpVqzHt7LbPPMpBengKE9q+xj+DUMZYU4bpQzPxPhm5VSS8Of1CiHnR53rWaqVPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DCF321F0089F;
	Tue, 10 Nov 2026 03:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282942;
	bh=YM46cmKg9s3YMEAaiIHDnNhKJyqPOgcuT8k4grYpNuM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=j3Uhkn7NJ/ZWfTH0wPV/TQqHgTwAjKwHPMdtOOEn+TcvgHHFceAbTe2R4NQcgBXHm
	 mbsuy2/MoK1h6JuCO8aIo5PjXO3e4m4UVpG641J4NjbmEfkmH4vCqBd4pNiRU1zpph
	 Wf108gWLpgM8Z1NOSWBf8g3fAbV4QkDYO7DUjNX2+3y1T8BssfxZbHM4RjzEcY/1pT
	 VbVGajAJECH5rsO8QlR9zxX13ZPAVO+T0hY5VJX6NFuSokrgBYThxdYg0J8PjSCqJa
	 P58Sjv2JxPi9dbf8bSWwTMsKcE0u53tr8lSq6XO1dz0URb14uCHhn2HqYRH7meNuxe
	 tSTEkhpPS0gAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 354AE487DE;
	Tue, 10 Nov 2026 03:55:41 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:55:41 +0000
Subject: [PATCH] Bluetooth: hci_qca: clear qca_memdump when discarding dump
 packets
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-hci-qca-memdump-v1-1-239974fc4944@gmail.com>
X-B4-Tracking: v=1; b=H4sIALyV8moC/x3MQQqAIBBA0avErBtoLAS7SrQIHWsWWilFIN09a
 fkW/xfInIQzjE2BxLdk2WMFtQ3YbYkro7hqUJ3SRNThZgVPu2Dg4K5woCKrlRnYm95BrY7EXp7
 /OM3v+wF0cY9HYQAAAA==
To: joasantonio108@gmail.com, luiz.dentz@gmail.com, marcel@holtmann.org, 
 brgl@kernel.org
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794282940; l=2103;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=ky0Z69/8Hiei/KREhnhz5BrjI36LiqN/BL+G9cWkhts=;
 b=Fpp9qgn9mgLlNK8HTfX9YFADJ3oNpTU9aMYUE6TkfR7/SmBCR29YJY1ZwfuE+IeXPLxNF7zeA
 xU6DViEJ2pNC2WD2lAApbQcTEuNXi2db+N5cKpP+9tn3kngR6z0bPlH
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

qca_controller_memdump() frees qca_memdump when a memdump packet with a
non-zero sequence number arrives while QCA_MEMDUMP_COLLECTION is not
set, but leaves qca->qca_memdump pointing at the freed object.

The next run of the work reads the stale pointer into its local
variable, skips the allocation and uses the freed memory.  Another
packet with a non-zero sequence number frees it a second time, and a
packet with sequence number 0 writes ram_dump_size, current_seq_no and
received_dump into it.

The original code cleared the pointer here; the assignment was dropped
when the condition was changed to test QCA_MEMDUMP_COLLECTION.  All
other places that free the structure clear the pointer.

A controller that sends two memdump events without a leading sequence
number 0 can trigger a use-after-free or double free of a kmalloc
object.

Found by LLM-assisted source review.

Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e480d38109cf..9dd8aa0ca8b1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1127,6 +1127,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		if (!test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
 			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
 			kfree(qca_memdump);
+			qca->qca_memdump = NULL;
 			kfree_skb(skb);
 			mutex_unlock(&qca->hci_memdump_lock);
 			return;

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-hci-qca-memdump-21c6294ef93d

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


