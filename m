Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F89417BE5;
	Tue, 22 Sep 2026 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065014; cv=none; b=Fz5MgyYeMfpAdpngM2D5ztaIErL8H/r8p1Z28XRuFa/kfBvdlv+ErLkLhrm3LQGMWK8vIyw/2RCLnvoyrs7bseEBQVei/fxMb3jsUjIJ1ejvFS3VnUAAIDOlEYv3H+sz4frIroCvvXNuuV/9MLG0v7Lw7tUKLiB7WNgCKbDELYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065014; c=relaxed/simple;
	bh=E/NM8T2KZwfRLcR8J/ahxLOTQw75jP+6cRmozKelcwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2VnQqkPMOoYMD157oBpwE/12wvodEqEs36/VaLhD6jPSB+ncBJuV69pTRY+foMtET747/HF14wrQMUJEvXWugOd96j64emPfLJtAnHjxojsVCAmt0cX80UwouB3GcNmwOlf+xNy7OSSc7Vm+vbjltFnx3//bD/xVnbRvZ4negM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WccxMrOh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WccxMrOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D351F000FF;
	Tue, 22 Sep 2026 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065013;
	bh=I0h+rOyBFje8okjVnSY4zQj1qK4Lape+dWJDy8+Uol4=;
	h=From:To:Cc:Subject:Date;
	b=WccxMrOhps3DHgdoVs4eDAbIVvyC0q/AV6g/sFX7bApeX2XMnDvgocyfnD+R6INI7
	 D7QNVhii6KBbMilScrhOsoFzzfaLH8LsDmucEmGJRlGK1fL+9zwnauUM/d/VYvQknB
	 OPq62+lDdwg5TmX+1SpxKlDvjZmBT1RzHdLC8ZWylxp1EuxdvFNrbvZ7mAi/IHB+MB
	 O9BbdKfR3r3q1uJn6d7lIwUrHr9X8a8doM5tBg2iBNLaEQSgUUo+W4JUiQSdSgQ43S
	 BL4clA90GSCVQqehGsvBwbyQ2d/1UtVxofXxx1AW46c5VXWIXpbh5tGW5g0Wrkv0ea
	 Gy4v5+23ULrcw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.1-v5.10 1/1] HID: logitech-hidpp: fix race condition when accessing stale stack pointer
Date: Tue, 22 Sep 2026 08:16:14 +0000
Message-ID: <20260922081615.821827-1-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Benoît Sevens <bsevens@google.com>

commit e2aaf2d3ad92ac4a8afa6b69ad4c38e7747d3d6e upstream.

The driver uses hidpp->send_receive_buf to point to a stack-allocated
buffer in the synchronous command path (__do_hidpp_send_message_sync).
However, this pointer is not cleared when the function returns.

If an event is processed (e.g. by a different thread) while the
send_mutex is held by a new command, but before that command has
updated send_receive_buf, the handler (hidpp_raw_hidpp_event) will
observe that the mutex is locked and dereference the stale pointer.

This results in an out-of-bounds access on a different thread's kernel
stack (or a NULL pointer dereference on the very first command).

Fix this by:
1. Clearing hidpp->send_receive_buf to NULL before releasing the mutex
   in the synchronous command path.
2. Moving the assignment of the local 'question' and 'answer' pointers
   inside the mutex_is_locked() block in the handler, and adding
   a NULL check before dereferencing.

Fixes: 2f31c5252910 ("HID: Introduce hidpp, a module to handle Logitech hid++ devices")
Cc: stable@vger.kernel.org
Signed-off-by: Benoît Sevens <bsevens@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Clear hidpp->send_receive_buf at exit label in hidpp_send_message_sync()
      as __do_hidpp_send_message_sync() was split out later in 60165ab774cb]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c65b5f004bac..4f597804c551 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -316,6 +316,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	}
 
 exit:
+	hidpp->send_receive_buf = NULL;
 	mutex_unlock(&hidpp->send_mutex);
 	return ret;
 
@@ -3621,8 +3622,7 @@ static int hidpp_input_configured(struct hid_device *hdev,
 static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		int size)
 {
-	struct hidpp_report *question = hidpp->send_receive_buf;
-	struct hidpp_report *answer = hidpp->send_receive_buf;
+	struct hidpp_report *question, *answer;
 	struct hidpp_report *report = (struct hidpp_report *)data;
 	int ret;
 
@@ -3631,6 +3631,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	 * previously sent command.
 	 */
 	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
+		question = hidpp->send_receive_buf;
+		answer = hidpp->send_receive_buf;
+
+		if (!question)
+			return 0;
+
 		/*
 		 * Check for a correct hidpp20 answer or the corresponding
 		 * error
-- 
2.55.0.1082.g2b9226bbc0-goog

