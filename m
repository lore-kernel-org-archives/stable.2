Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449176;
	b=xN50i/zrzC+kMj5X46dMiiRLywkSqJcue8CjaL0YoBjvpB24pzOFCxW3G8PgX2j/ZNgX
	 zUOaxJ0RHMVlkYe4bB+2Z5r4p/wcX9oopyyh94tjyVn797dECKfaemV4GjjgzRe4TAYGr
	 h8F3yXTd1si6YJCDBAmlrj5nm7MqPiDrniTzXk6Uia80+1r2UUbs+EZPiSj9YX2HfX+PX
	 k0VXTRZrCVXdxfJJWD7FGTtFfLIk7rZwwhA2hf0Q8OJCsfbbiiSXaHlcsSOIIEEEfc6fk
	 sr+WACz0KG8koklAWQWd3E1rn6BZhda1ZtN7uViqwIxwdvASB3ZCQipyv7QsC33yw3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rego61X+kBXgvVSw6zGhoYRzdWoWEeeW0NKh/UNNEsU=;
	b=C8SL5KfXLHnkh6jTBRRBpzWnq2qcTVYEussB4iVFhhpy6MOw1Rd3A/aJMkBknkPyj6JM
	 e75S0q8/DLUbkIhlM+9fDcw1HsGJBSXG6oXZwcyHbpQiImy5FPXlKhj5NBNZcuDGJy/j4
	 ztZNeE53bJ2wCZCYp2f0y3Yg9noX6c+OWpfig+A2AEJzEeo3KwkLP+FjpG1KEjIZTCasN
	 LAvRPUHQm2769mOb27Vmr/5S/U/+JYGAfj7MKaeewSbaNdlIl4isbl1XOyvkez2KnN2C7
	 Gx1kJx4+E1fF77gwRSJ/XskrJgaEC1NscbRNuvWVGyMeaq+6ZQgFqEgPMHp/bruYDug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NePt3kPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CAF606A32E;
	Mon, 23 Nov 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NePt3kPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871BC1F000EB;
	Mon, 23 Nov 2026 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449175;
	bh=rego61X+kBXgvVSw6zGhoYRzdWoWEeeW0NKh/UNNEsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NePt3kPLBKV8lmRLvwh7GBZecDc4/fvcHS4oQqLSYoAtHW7r9C95K7VI8Mv0HbLir
	 ppC787LsGH44Lk3eLqGHZQ3wL57yTwGNBDXC9ZYHQE9r5WghX4iFHO85ShSWEFesPI
	 0ItHsCknQE6D1N5VuOJqwAfTQxmm/495CbzQf7hGqoRMrL2Zo3H8AJDp1TI0/viydj
	 oqOsep+Se6uRZ8BR2YF0EWMwFZmKWAnxygCLIFDOMFz5yoBZ5vGw6JVyhp4TXlgF65
	 9nx2cIuXwF3OWovY15Nvrj+D0Sv8tPJToBu20xlqvEbTdzeyio2AuPdiPctXAGKlYj
	 HvF0LLFBeo1Mg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] HID: playstation: Cancel DualSense output worker on create failure
Date: Mon, 23 Nov 2026 15:50:54 +0000
Message-ID: <20261123155138.2907049-11-lee@kernel.org>
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

dualsense_create() schedules ds->output_worker via
dualsense_set_lightbar() before registering player LEDs and assigning a
player ID.  If either step fails, the error path returns without
cancelling ds->output_worker, leaving queued or running work accessing
ds after devres frees it in hid_device_probe().

Call dualsense_remove() in the dualsense_create() error path to disable
further scheduling and cancel ds->output_worker synchronously.

Fixes: 949aaccda019 ("HID: playstation: add DualSense player LED support.")
Fixes: 182934a1e93b ("HID: playstation: stop DualSense output work on remove.")
Closes: https://sashiko.dev/#/bug/linux-b657d8df-afc1-429c-9bf5-b2583501dedd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-playstation.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 143eb891e4a1..1113294f4add 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -1905,6 +1905,7 @@ static struct ps_device *dualsense_create(struct hid_device *hdev)
 	return &ds->base;
 
 err:
+	dualsense_remove(ps_dev);
 	ps_devices_list_remove(ps_dev);
 	return ERR_PTR(ret);
 }
-- 
2.56.1.750.gf70dc682cf-goog

