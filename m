Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449162;
	b=4vN2YntxEn1/B7StkZX3RqWY8KoRewE0PyK8OFWm7bL3jFwcfh4yBnDvmrEylRJXoh5v
	 i5h8JmcQIgVsDHS97kgdb4eA094bxmeKbKsfR6335zduFwgAL4+ZRJ3x5VT2YY0+lGn17
	 v7qvks/CDsP9ZhdnATL7OC51d5PUFAQoMGGmKvdXIyyubNF20Qa4fjAbGxOouktCPx8pT
	 NumsjR49K8hwtzW44jsnDIvETTF12pTnaK7nh0qjjwB6lFqM0UlillI9N8Eb8RdURaxup
	 nw3g0s6II1sRmCZ3b/+WJxsquAbQeer9l3ercEBNvxTW2eK/RWH1r7rp8cGPONIXpMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449162;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=sc+ivLwWPtxR3Xcq0ZU6l0mcJ2oMHmzXpJiBhJN1g/s=;
	b=hUU+HQlpwAp7uDgt0hK4X0cBjrgryLf+HFQS6yRN4YcA/47o4j9g1SAenOSmWOxtTykb
	 APrc2bOQ/QI7wstgfMr59ZRbqyUtLkPpPeBUVT6RRr/yRCTA8TMe6jKifda32px2AYAhD
	 Zz+Dr1sxZ2uIzQ6Aw6096ZhqWta/1vuQBtHqIzzPVJEjrC9xxWtowH8C91a+7GP+qbXma
	 NtTTPNbsntWxb4vXQxbpmPCdFQCCZwzqHstUK1wZUHLIPHftBRiy/4GqsVKqGNXQxSn66
	 9JpuDY4FVpLAta1kZJ4+dsODgSqsNbxJ3gPwiDnuReel67F49fiIFqyxsOa2KB5HSaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiNK9RbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FB606A682;
	Mon, 23 Nov 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiNK9RbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150A31F000C0;
	Mon, 23 Nov 2026 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449162;
	bh=sc+ivLwWPtxR3Xcq0ZU6l0mcJ2oMHmzXpJiBhJN1g/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WiNK9RbJs0WHWl44oZT+HN+xKS6dmj+3Qm4sRtHHm9p2wn0b4KEZJ8JZyVyjOBKks
	 D4KBx6Y6hpUfb8nNjZg2JVkBw1TqI0tJbtyLlEg6DEoCI1fMh9LGpr+HVkoPQI+RZJ
	 FmWBmokoc9UgRJNq0fqwtUjX0SMhcLmTEY0sF1/YydmHzgbNfh76yMDJmRViCzAoUZ
	 C3tf7zHRLbYnHHqQyjLihE4qGWfXZ6XFXWM8hIBlDI0uoIBwuFZplt8SVkZXFRTTq2
	 t9d4rXvl6w0vigCHlhoqpYxDqWtrOnO8TVF6zP7u+u8JLpf1hpND3n76FSR8KQuwET
	 NQujqarXrvmHg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] HID: wacom: Stop HID hardware before releasing resources on mode change
Date: Mon, 23 Nov 2026 15:50:52 +0000
Message-ID: <20261123155138.2907049-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

wacom_mode_change_work() runs asynchronously on the system workqueue
without holding driver_input_lock and calls wacom_release_resources()
before hid_hw_stop() on both the pen and touch interfaces.  Because
wacom_release_resources() releases the devres group containing
pen_fifo, input devices, and shared tablet state while USB URBs and HID
transport remain active, a concurrent wacom_raw_event() triggers a
use-after-free.

Call hid_hw_stop() before wacom_release_resources() for both interfaces
to match the teardown order in wacom_remove().

Fixes: 4082da80f46a ("HID: wacom: generic: add mode change touch key")
Closes: https://sashiko.dev/#/bug/linux-e62a8e78-c17f-491a-849b-0690087100f2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2d2a4d56a8da..121bead90147 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2887,16 +2887,16 @@ static void wacom_mode_change_work(struct work_struct *work)
 
 	if (pen) {
 		wacom1 = hid_get_drvdata(pen);
-		wacom_release_resources(wacom1);
 		hid_hw_stop(wacom1->hdev);
+		wacom_release_resources(wacom1);
 		wacom1->wacom_wac.has_mode_change = true;
 		wacom1->wacom_wac.is_direct_mode = is_direct;
 	}
 
 	if (touch) {
 		wacom2 = hid_get_drvdata(touch);
-		wacom_release_resources(wacom2);
 		hid_hw_stop(wacom2->hdev);
+		wacom_release_resources(wacom2);
 		wacom2->wacom_wac.has_mode_change = true;
 		wacom2->wacom_wac.is_direct_mode = is_direct;
 	}
-- 
2.56.1.750.gf70dc682cf-goog

