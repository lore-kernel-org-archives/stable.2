Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799293;
	b=TvKweL0av99rLTD+4yWVMpEvN6gse7eFWxlIQxCfGeMmRrGjNO5mFody0f3IaRVtpcsl
	 4Sn7LZklnKy69SODBq3fvgl21WBci/DhZGfQISP5YC7542Q317x68DwlboDo3tPdAJMZP
	 cIzQLdhNr/J7soEUcdt5NJh80Y0wtUTPD7OoKEaXWSB9fUmoEfOdMznoabWFXsiGJu2SX
	 hL6YRmzU4/5EBET2A4zOptxAi7mElxcdKeXzEuUOCbg9DxAVyjC9c/uat07DLLmLvcW5v
	 2vreizBKhHr8sZL/VVTQe+ycVD09Di1WZLQFmdYsXXjPPdsFn0WgXuhbiJnaehm7nFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uDkX0blzb3c3DaHz8+BDDCXmBzy3/6GBFnnOUYBXO+M=;
	b=QyonWIrya6rzOhWwyH9g5JQv/iS50eiTPYTCnie6QFh1/Ykm7m5+wgMaJvHK+6N5O/b9
	 miHpC6osuGcOFH409E8TE8VRz7xmLVVYxLIj7od0+nqFiNeytAZInthxsIKcGAnObTcB7
	 gOhzkDYvZ+MIoOT/1HKBEbSXBAJWaBXoaynQ9gzBbLmlzyhwwAQhEcY7GvD8EPVvxYW9R
	 qI6NYcxgBuQkNU3GqHxSucplZd9OYqyiQ0wjSkvhXuxMSTLJiakmSfPSo/hDreLvCdjfl
	 /NnPMluXBnbG0K+lY+1fJwH62c7PBhszTF9Y84ISMzDPIC/B8eDDVknt18Io00WGzrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAQUHT2w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B48606A31E;
	Fri, 27 Nov 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAQUHT2w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE91F00893;
	Fri, 27 Nov 2026 17:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799293;
	bh=uDkX0blzb3c3DaHz8+BDDCXmBzy3/6GBFnnOUYBXO+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cAQUHT2wEzZD7W+Bn23DX5a1OR77ecP4VG5rrthc9hOR/dATZb6tnjBaQ5Um6Xzwr
	 lFBdWoSee7MyshZCMsa6bNMdauMR+bui6NXGjcyKWZCE92otPhTb3DWjhOh6g9sNaT
	 P+7oqHaDOyDXKLGD3MesV1k+59N0wnQzqb1sf65LsklOahLgQg1bIk89Wh79r3fLUi
	 I+lWT1+gPILdQGXbZbI6kerHtYt0WD2rMMd0INDPiur2ES7KujPlupEIvMzH6H9h+0
	 c6Xi5QzaenizqGAtJd+akefJtpmYyV+c3riArlPqgvmYVBDcTJukFIZdfvcuplh8rA
	 45zIad5+cJ11Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 08/10] HID: wacom: Stop HID hardware before releasing resources on mode change
Date: Fri, 27 Nov 2026 17:06:26 +0000
Message-ID: <20261127170712.3163443-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Add Reviewed-by and Tested-by tags from Ping Cheng.

 drivers/hid/wacom_sys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2e3ce9b63d7a..5bacd016c686 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2890,16 +2890,16 @@ static void wacom_mode_change_work(struct work_struct *work)
 
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
2.56.1.839.g22a8290db9-goog

