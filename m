Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285024;
	b=cQn5fcMm0yJ1nmh/RvcUp/xbfluzpF4PWa+vJAvltSzATHEp9fTuEsbLqE7NVk91021m
	 6DByDvpvEE7wxjsAFLfSLKW0ZZx9kuAKFVK7Uuq5eGkAck3ZQdBcewRQVHFuPhBVKF42m
	 qsrccHdeqSsDAmovoQu77RgLsc2+elzn1phmFSk2MwQL14XYmCmjk1uCWf/St1hFicReW
	 Dj3Vb2n1zue0DokYaEvYsWOy06MnJeSSouMm7lnrBGrH3KpyPeaAscSKBKCTJYMEOS+NQ
	 HFvBUQRO5Zxuz+1Qh4opzERw/mUIz2ihe3sOy6Hif9278jC3MHHBG4dNjnhx70nr26A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gK3Zj5SmalpyUjC8K4zZ6GNOQeTZ+/I1kE1Ho+gmUJM=;
	b=0ErQQYSZqquKhQUva4eMlmgxhq878xlD9lTAyKQvz03uASwQKKDZHqXNU3pockk6k3v9
	 J3oj2mA+eJv7229qMjPeFAVt/N+hdOEl7XvZdVBTc9e2fRPLkHt9U4h6VqW1dByqeY99y
	 PP/+0bLKMwD4tXSSXhX/kt20sZ3EbkagyReCIa2TFvdVE+c8vfPPPF3vK1AADJU7ApgBj
	 9+G4O63USDp1G28dmJUnvR6fRKgzSxq9VNTf84sPx3fP88zNGF0L9eKmrF7fAb6H+o9LC
	 W3rnC4osZGP65ouPoATmkFcTHCHCpEvJNidM0iVwlWRPtriKl8cM+ctpemSOSy7rXKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vz0trkts;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AA60A262A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B6AA60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vz0trkts
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c6ce60697so20296666d6.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285022; x=1794889822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gK3Zj5SmalpyUjC8K4zZ6GNOQeTZ+/I1kE1Ho+gmUJM=;
        b=vz0trktsq1aT9H/o832KAsK8TjpLXaB37e3Tbl5/h5ULmGLqz9U8OnzqTvfOMAXJpe
         aDmTxinoNBcv4jZMDsh1Ckzrxl2/Mz2/f13oLekQXxqgrwgZWsq6dSK2aIGcnxNUXCxh
         +PStX9QgrLyg85NMBP4C7yCwZ13POsurl1BPs+mI5WDaX/qfXccrc34aTDqsnF477jN2
         HIAgNkOveiV2sH+19CXrR0NjOfRqLbkSNynCSP3tZu47BZxV9FAh3mvzA/IAhn00z5Tm
         8RqVZUAOOX6UY5FdQMBYxHbNzB7hRlvIgSWlqoxv84CGMZ4NaWhAFVJLZGtQKpbRJBcs
         hXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285022; x=1794889822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gK3Zj5SmalpyUjC8K4zZ6GNOQeTZ+/I1kE1Ho+gmUJM=;
        b=zz4w+55yToWyIkJeDNOjL3UJHnW3HwMnBKrefCyaUgVN9nDvplggnO6O5Z1Q5Jm/Sy
         bhlW2I0R458FZKjuDwSIhDUFyOBL0S6g87jZQJ0kktrGOUelDZ/eHWeLqEkwd7QBNF+j
         MaTg4PZPNRiGYa8kLMFRItqH6JqNMQu5DeY8cEzZ/NibDn+TMHUEuMsNepmjwcznpNcZ
         ho0jLYUJZS35YCMwqGbyq3J1ca7Xo+fjOstQ/A1mUOXbcIuYQSFGsr+FD8pChZDfR1TK
         JpIlKp5JSX50jEIj8UfpLrCNf6Er2wWNmRBh5g/1XzQ0FrEOMu0lhzdzdq2t2vJn5iX8
         5OSg==
X-Forwarded-Encrypted: i=1; AL+hErE+moe/tXNDRbeAF7nHNjWwfEIhZBf/LdvS1YoL6G3reGFai7ycpd55sHi+LgE37FpBrmZCYGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e6pvcxxp1vjXfH55pzIYe35rR3hU7z2TQNrlLQ4CMCpnHicz3
	cVKx3/6XIx6ng2xblyAsvO82kZykaA3tiP/6O5Qtn7P3DLpy6u/Q7ns=
X-Gm-Gg: AYBFou0SYsnxD7czT7cjWQiux+imsZCDEpMxoORfTrfc791KfQb3SHjxUMVLjF8PSCn
	rBdw2KfMNGhBigrKIYyWKK+kMpaLW1R/G97exvnbb/3AJlKn4nyrKjnoRnJ427zPJIovdVmfoqR
	70/FCfno5LY5uWTqFSwbS5/+en3sjfkMyRrwe6hIstKag292lO8E6NV2nKh/A3/5taLoWYm56x6
	VxiPf6cweNEEejT/sl6NNfn2w3S18kKkdfKBuQBF7032DmcMWejIjbaYyIIS7hPM+84cZF9t9xv
	mF+5V0HANYc3U0Apc/HhHNpTaRevyPtO0bYlvWOFxv7pfWzt59FN6p5M1RzVMCBTpNby38HjPSC
	YEkWQ4PRp4Kt0o0ljFOGNt2utEzzQAe2nuqG6FwwQTZDLrlFSzlD1wB7rICIxKlcsCt4Fr+H8Wq
	MMn9QzhnnVDESr1nKf9vlXqK9JuQzWKUuDg3FYEcVeIeXG1ijEKRfv9GQ/OeBmdr75FO3Y1df98
	FV0mq2LZsaaJ+YwRcZN73oN8STGYg1TLyekX6Opz1sn5IIURDhy8GIURzNxOj6eUdm8R9Pmh6vT
	QIWpW6VCIY6dxWlB1LaTS5gP2MPEorqmOVa01uX76xHDeG0qGKfn8QRQxV0EpthMHiZtQYKqmNr
	MfujAYv/JbvYeSvvWTsVXvUQ7TTmObRj7XA3fw+RASHadYo3mMP9ED7qLMB3i6kDKOg==
X-Received: by 2002:ad4:574d:0:b0:91e:a16d:7a30 with SMTP id 6a1803df08f44-91eef808c9emr28829176d6.21.1794285022140;
        Mon, 09 Nov 2026 20:30:22 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef05493desm12012326d6.45.2026.11.09.20.30.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:21 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] memstick: rtsx_usb_ms: disable poll_card work on removal
Date: Mon,  9 Nov 2026 23:30:20 -0500
Message-ID: <20261110043020.57040-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

rtsx_usb_ms_drv_remove() sets host->eject and cancels poll_card, but a
concurrent rtsx_usb_ms_set_param() that already read eject as false
can queue the work after the cancel. Its callers, memstick_check() and
ms_block error recovery, are stopped only by the later
memstick_remove_host(). The delayed work can therefore run after
memstick_free_host() frees the host.

Use disable_delayed_work_sync() to drain the work and reject later
queueing. Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 4676741a3464 ("memstick: rtsx_usb_ms: Fix slab-use-after-free in rtsx_usb_ms_drv_remove")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index d5b3a96fc609..85a681e4664b 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -820,7 +820,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	host->eject = true;
 	msh->removing = true;
 	flush_work(&host->handle_req);
-	cancel_delayed_work_sync(&host->poll_card);
+	disable_delayed_work_sync(&host->poll_card);
 
 	/* Balance possible unbalanced usage count
 	 * e.g. unconditional module removal

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

