Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285003;
	b=iZ2cUG3ajwxSxl1EWxyxuNlkt6bQPCRLvrF5zqB7LlhCxDnM+2LY/ldJIo+xQJi/7Qdt
	 N+3IVSiOoWNEkwsKsnXSIMWb2iFIDhsTYXqqm2tWY6sPWpZl34ZyIO71WUeo5RohNLS27
	 CzoYbf+X4a4c2X+3/r2BPK//D2MLClSd+Kn9R3gr1YK5S+UZ7ke5bXnXjoFlxr56xMHmZ
	 bPW0jIIvvljustZSQJ1dcU79c+01rh2MDqDKDPG4iP41mzgz9gg8oecqSiXjfdEreQxeu
	 pOtsnXKFp00J83GAfuzUSTV+hWoGreFD/wmY13EUp4rJuRWurIGpbO9A5busLoWmBXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6C4Hx+d91lAlBeJL9YUS6/bLXYWsvtNC9yUrV7CQ+/A=;
	b=AnP9+XCNO25UFGNZ7czm+6Za719XQ0ZG7TiAZjuadHMU6ycMANmJrLQMgJrRNCPMH+VV
	 ukERvo5NHO8S6ydWcPLChFgGgQeUUE61h4+Lf0e+eS/bZM1uo3GYnm3idM1tpMKJj0Iuq
	 XvLmzZ6C943lRb5OFwkGrpNo+X3VP/ztBRt5Tbwa9e7ul7Foo3V9tgAfZT9Q73eQsSe9P
	 35/umK1Dj9P73DJCWUS53zohiiD+A8kgSfAf/Te+0LiSA/LvSfPAQoU5xkeybf0E1k4gM
	 kNKHCwmG4UDiLUAQ/m5+81frI7A/wFLfv2s7M4Jje1jLZoxq5TEsJOUFoWa8PTlGVDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKMimoi2;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9717A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qKMimoi2
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53639b8903bso20606811cf.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285001; x=1794889801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6C4Hx+d91lAlBeJL9YUS6/bLXYWsvtNC9yUrV7CQ+/A=;
        b=qKMimoi2WwX+SyhMQxEZ/A8E7WOVc4jK6OM/paMrW9cxqwQKtdUaEzopcFxUdfmjoo
         yNLSNWzb/qnzfuGpBNJvSS/7kSCxqaZZmiYJik80BFqptkdukXkK6DnKieeMGzXc9Uho
         ncHtTawsMd0nkoIbZYzF8YPxsenWvUQBoHxzoPs+fl6RaSErbHyTJJ55X6xqg6qx9fg1
         7ZJSULe3zJA5/0h55py4WiBqqLjw6hgVYXV0dOeS1N1myr/g0HxiaIAQulMcJayJiG3u
         3P82hnMrO4nYgQ6bwtIyhW+mzgAHh6Ep4TNWqd4egv+suOX/k02bJABGnTrX4d+Jb45R
         49bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285001; x=1794889801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6C4Hx+d91lAlBeJL9YUS6/bLXYWsvtNC9yUrV7CQ+/A=;
        b=abr6zS7ScdRay3/tQpX+Ap4xkLh0LVW1BRbH7+jDDqxW1vgcwdG+zKyNQjmqAaRhi/
         1V8g9GL36IWvQSqbLdHxCHcab5oiMw332um+qnEk0MhpzxcUtGvBfAhvevLhqoZqTnOK
         kRMxJIhIDx0gLE60dd2MDaium+7vaSVGrJFdX5WEY14A+pvOt6fzRJUrUaYS1XRC2eTZ
         ov+KWT12LKEr1qWrmjZRZVmVVHnhHoYWO9xA/kylGAL96QJ/6gf+3PNPrlp+V816hMZ+
         UoWvKYUzRAYJuL5dO7j7N6Ie6uuKWlR+f2DrZPkN/gMLwemhyOU/wvYnX0CXZCFAcoL3
         9BkA==
X-Forwarded-Encrypted: i=1; AL+hErH7EZOvqSO4qdqvP6dqKw2PXJTl/xqgAIjyV75x04vfgGjjd0QncUWfVNhEv6lzkVSxe/3jRwI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F3ZlpU+Xlv4Uat24N5VZckpRDhAWLb3vyN1C368/ok2kQywHD
	nG7QuKijesTthjyGRQY4991K79dxNWhvcqW3Uc1G5Fm4ZsuM3yXEVNEuI3SS
X-Gm-Gg: AYBFou2Kz1NktV68+ZpOnARygBzWC16tEZf6OwNve5iCpjEtjZEAuWHAODdpU8SGRRV
	NUVYmTBlRjDZfQaaQggIhInMUWcJFbjAlI8PrLS+T/x/u2JQ0wbqS1CQ+G4BfxaTrX9R09aXb53
	h36wUi3CwlPUEpnAtYHMz285g7mp10vZMbu6Axs7FygPaU/wul0d9qzvQ2swBNpncAPM1k6zkyb
	atymQg+wxWfttCzuTTnVdewkWmG1MK6lUEDSgWKreIyqMNo3SCrrCRmm/cEr4BTSl3xVM85G7as
	nFS6mhf7SRJ9U415t/ORXkGJQizdPVZ1S5dr9Due8i/vHAY5BnbUpKKt24pU0MHzZPISO5ZIh79
	AnsqEHPGxd92RQpPFvRSOLf1f/021E3HiTaljSSNfJPCP5EYZWjZdmcuGAUZOxjyKg1snM/zXCS
	QuSXmSViintzHrtjBjgOgop1u+rmn3n3JYtQp5Qwv4kpKl0J2YvWBXlVn6+Rj0WlP5HIZG5HHhR
	rCxtSRbTqHj67xgdcuB0z+HlirSnfGk/cJWGyZ6KyUHT/b+cLuusEhpqBTy4vrfVVBDnXV15v45
	jHPDcW8H4PulwYBcU7EvlSDBPSd1H+bsDF6CrkVs+NhoQjTJNLLjkZcsfRxmpgnqc4WJrCI15s6
	41Ag2FkGnnfKE90q+nNpf9azVN0H30rgLcjSoPku1vuHdD2BZ5s/W7lzByQOw3tCM
X-Received: by 2002:a05:622a:1e11:b0:547:d087:543d with SMTP id d75a77b69052e-5551667e38cmr23347151cf.3.1794285001514;
        Mon, 09 Nov 2026 20:30:01 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555065e4ad7sm14643351cf.0.2026.11.09.20.30.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:00 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] Bluetooth: btsdio: disable the TX work on removal
Date: Mon,  9 Nov 2026 23:29:59 -0500
Message-ID: <20261110042959.56583-1-mhun512@gmail.com>
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

btsdio_remove() cancels data->work before hci_unregister_dev() stops
the HCI command and TX workers. They can still call btsdio_send_frame()
and queue it again, allowing it to run after hci_free_dev() or release
of the devm-allocated driver data.

Use disable_work_sync() to drain the work and reject later queueing.
Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 73f7b171b7c0 ("Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/bluetooth/btsdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index a194fc85abfb..680965e74bcc 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -350,7 +350,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
-	cancel_work_sync(&data->work);
+	disable_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

