Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204420;
	b=hAuQm79O5m4CUXZFFKtyj0CY44rffbuyebZqffAy1pcQHyVunCglB8ZBVITcrro0WFvZ
	 rjMlX8KtduDtZJ2wHqCPXiYEgxNetyvl1zkso5ubzVXxFt5sX4opnXVl8XjJOgfGzyIHG
	 aKVyFVIiMzokaCU63OOLrrqfAgTE8ecxP4h4xnZT6AxWNwHHjutKTVB8o+8KDTQNxtRgS
	 8tLWuxlOorburfe7wAXhpqcGW5phcc7E+5Ply1QzjsYQMJIZWP0AEgHreQNch6jAfxhoa
	 aOR/dvXD2VMFghhhaAHE395zhsxGzN1QtnWDpT40Lls2ZjzpUhJmMvoNSB723MiJhuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RDa0JQRpSFd64FcDNqu+A8RXC4M3Gvi3sCFSGQLCqvI=;
	b=XKnw/sgx2S7UB5psYGJuIRZ6eB43ign7728kSYIYOI8IoLBoYbXXdUAbbzPO+Bm1r0/T
	 kUIH1ciz5ngpIn9EFzRJIpisuXWK1yaXa/wam/El+qWo9RtN0wCnbuFy4OwarURv+HqZb
	 DVO7NLsA/KoX7DSe1HwzXxkHKUUEuUTP82WYnw2qwwvQ40C16Gt5CuLyUik4ZUIyOQ5ur
	 jg4uhY5VgMu+XsgG+q/SXGn6GWS8hC6OzBEoEVxMwwwQRQh8YjqIpZq1w+VYkmU9HiUhj
	 UVwONbJjryoeNaJxBNOj7vPRw/XpD1Ymcy5cDAAGF752BpBkKVPs/pXevmhs1I7LUAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDeq9vm0;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD64606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD64606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDeq9vm0
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1225739eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204419; x=1794809219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RDa0JQRpSFd64FcDNqu+A8RXC4M3Gvi3sCFSGQLCqvI=;
        b=PDeq9vm01rgqhK9bmX/OE7GH1VuLm23QvDHZcZASR1CG5FzPfl69ejROO6OSHTh5Av
         +146DoFfzA/7XNgUDpLF/6NUKyTahSnPOykgCDIqcxGxt8mcJiZ0LPp2rpeZGlY9o1ay
         nSw1hL+32akar+tBTnv/C45ZN20l50zUOa0W5s4DIAGmRjlMAFUGJ519y1/FobQY1lIS
         OMZt32c9RwhrUG22nzMvhoGWT0mHGpfTyb2dnxNM3L1AL/qRTNDMNxPHo7EhLcGC0MAZ
         5aqyvWG8UhY+58BvW8FbrGKqJepydJpUrq7yoYvR8i9KSGbKtbJU6QHsTn6JEsci+zdG
         0iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204419; x=1794809219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RDa0JQRpSFd64FcDNqu+A8RXC4M3Gvi3sCFSGQLCqvI=;
        b=tqazhq44JPg579knpjqGZxYYuseovyNjMNiQz+HhpyJV6PqJKb+LOPBfKNx8CVeIeI
         VTmzPpCyHLFehG6xc3Skz4JFbLIUiqyKt6xvZ41+O+sKWnIglR+X6kiVoWY8Pet1lbcq
         s4PwFsFsBKh1dMBAjnUBsEBarOVTkbSVyLn/KcrCuci3wQR9ymQ+JdB4Yj4So2T6WNIa
         i3GUeGN4CXCouTjvHzYPc4th1ZvrDdBvGu5UNad59BZDOS0PUnNTcLeL7Dcnnmrdipp1
         ZplQ9fU0wBzI0GBmxm3/6ZuaQyLoTPvRfSYk4ehF0fLUFNKfzjaFWLBYLzVD9kT1ZqpO
         9tuw==
X-Forwarded-Encrypted: i=1; AL+hErHAwdnCeqvzia5UczEZA7F/FKKrWMRwKV2wsER9MIxMBNHkGS6x5kc60llVe2kWUPSdn3baMh0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AuZhtCaw4ivRFGuTwyYSMD26xp+zY2FHFAt1G8Jah8aS/mjTS
	Kolgf1T4tMEBRi4U6i93SG2S0Se77/3ie6zsN/zE9HxAeQ7X+KEnSXZE
X-Gm-Gg: AYBFou25x1F75o2HxY5c2JbkEF7rp9fcZ/BQXWzEHFM2VBmOHmqO/c7D1Vg/S8z1s3m
	bRHYqFUF3vb2CkhpS6ExfQHiWNnmv/oZTptnAJ8i57EdfMrvkQrnH82eeY5yw4o8woBlEowwTIt
	xqZUx5Vur4NGfIdBz1/ugsZpKsUDzDG6SxvD9830g+kMc/jlUmpHpCNljqdS3Jj+6griBx5wg3z
	ASaYKEkAjQlZZXf9G4HBPhLC2oHQjycMAVGWUBj+J7gk0hHYZCQdJlI7Lavh4nlq/VNgp6FT0dg
	L0jsrmgpKn9cemGnAjZqZsiSNzFESYmJwEfpdoycI8BFb+jRcdjunFtNpCARMHjuBizs6BBvzMz
	V9/C22ujZ99XoL6mnMbBrejoiMPTMmaiAeYPEFQHhYObGgQCHXRtrXbcbIYw3r5v4cmEG1KDsVm
	YPaeKa1WKKyvOijJe8IitYgPRamS5EmozXREt9r9F1BXHJWDwx1aHWstt+Ji/QnfwuVm4xYEAk2
	OuBgsISh+Q+jldN60UydpyGtpdwuSN2BGXYYWYPDscbHu3Zw/lPbnAxADwdSw4hz/d9IQ9moyqg
	0cmKclqEZTQRQKYHTbPqv9DeghInw1xrWsWUZsSQn24ndzzD
X-Received: by 2002:a05:7300:6a9c:b0:358:3426:d601 with SMTP id 5a478bee46e88-3725b461998mr5714163eec.2.1794204418800;
        Sun, 08 Nov 2026 22:06:58 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10754270eec.4.2026.11.08.22.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:06:58 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v3] HID: microsoft: fix use-after-free of ff_worker on teardown
Date: Mon,  9 Nov 2026 15:06:33 +0900
Message-ID: <20261109060633.1231417-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

ms_play_effect() schedules ms->ff_worker to send the force-feedback
report; ms (and ms->output_report_dmabuf) is devm-allocated and freed
after ms_remove() returns, and the work was never cancelled on teardown,
so ms_ff_worker() could run against freed memory.

hid_hw_stop() in ms_remove() unregisters the input device, whose teardown
(input_ff_flush() -> ms_play_effect()) re-queues ff_worker, and a work
left running after ll_driver->stop() would also issue an output report on
an already-stopped transport. Disable the work with disable_work_sync()
*before* hid_hw_stop(), so it is drained while the transport is still live
and cannot be re-queued during teardown.

ff_worker was only INIT_WORK()'d in ms_input_configured() for
force-feedback devices, so initialise it unconditionally in ms_probe()
(making disable_work_sync() always valid) and also disable it on the
hid_hw_start() error path, whose unwind can likewise schedule it.

Not runtime-tested (requires MS force-feedback hardware).

Fixes: 1cfc77a64b71 ("HID: microsoft: move FF initialization to .input_configured()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index a7d3493a6141..5e4218beec92 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -335,7 +335,6 @@ static int ms_input_configured(struct hid_device *hdev, struct hid_input *hidinp
 		return 0;
 
 	ms->hdev = hdev;
-	INIT_WORK(&ms->ff_worker, ms_ff_worker);
 
 	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
 						sizeof(struct xb1s_ff_report),
@@ -361,6 +360,13 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hid_set_drvdata(hdev, ms);
 
+	/* ff_worker can be scheduled from input_ff_flush() during a failed
+	 * hid_hw_start() unwind and on removal, so initialise it
+	 * unconditionally before hid_hw_start() rather than only for
+	 * force-feedback devices in ms_input_configured().
+	 */
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
+
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
 
@@ -377,6 +383,7 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				HID_CONNECT_HIDINPUT_FORCE : 0));
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
+		disable_work_sync(&ms->ff_worker);
 		return ret;
 	}
 
@@ -384,6 +391,16 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 static void ms_remove(struct hid_device *hdev)
 {
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	/*
+	 * hid_hw_stop() tears down the input device, whose input_ff_flush()
+	 * -> ms_play_effect() path re-queues ff_worker, and a work still
+	 * running after ll_driver->stop() would issue an output report on a
+	 * stopped transport.  Disable the work first so it is drained while
+	 * the transport is live and cannot be re-queued during teardown.
+	 */
+	disable_work_sync(&ms->ff_worker);
 	hid_hw_stop(hdev);
 }
 
-- 
2.43.0

