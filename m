Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308122;
	b=r0zJpD9z1rvIwKmhL+OaWnBPSSYmtVP+Z220FW8YsqhfOtmx9eQkZ2qMqMeEbNVU4jHq
	 QiTyQ4eYKFowkeFOdfxfG1hsWueuHDfscyt75DKBocPC/tnIlMZ5PFC5DYVA34zCh7P4b
	 8ZrKOEjzzDxLjDCILNAHhtVSjZJiIwOM7jtup2HA65yeks7dF3sBjZM0mBY7zsQGA5HcY
	 pk0WslUj+EyZQpZlPJYUPZQ0RZghENEVSzhOxLDNMjpdzLaMQgIl39pnE4/+o24T1zQ7M
	 b4gymkvqPyAf5U1O1DrtCHlN8nnpmE01gzgILlnFBRxGgmKtXg/Rtki8qmMXXJLI3Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zm0AvIJOmifRUI1enIfd/m/5IgggtCc9iLAPgeXHvVs=;
	b=ERmhVuj/DpvShK0v30NhzQCs5vjrtK6hJw0c5v10sK4vqgSv9vcXtE7SxuqnRdNuyTcf
	 b/IZ/3UxlyopDLs+1Ra/AjN5cPuwi8uFdRPjEVxMpgbokx8Onra00VbOOBj4+pbIjWB/Y
	 ZpERclBXPmyn7LJby6D6CDumFLEy/0JMtx6dRvgoudrcY3YcstSoQmlp5LQLcCAFrC9dH
	 m1hdD0M8cCHjKgus/2n9mx1b0r7/dkaPjBoyqDdW06X6WY0C06IM24XV9u3h8i8cl65/5
	 K/bKjdW7No89E2tLNumjDQkpR4pvdoIhhlskYR8/CAtGXShGqAqiWy2IXVnydyASplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M136hZAl;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288060A263A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A288060A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M136hZAl
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36dbde64409so3821842eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308121; x=1794912921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zm0AvIJOmifRUI1enIfd/m/5IgggtCc9iLAPgeXHvVs=;
        b=M136hZAlbjy3s7YeZo1K7+86Ec8kn8yxcbu1/dOGL1CUN7tX534EL7MuqNB3LkbOQU
         ZYV1mKhMazwV+tyVUu8xfIr7durTHTJSnf8L40VUlERTQ04eFnZXV1q31Fys5o02I8FL
         ybyP0HuaJPZavSsEutaRWMOGTVGHQwi4ISjB+ahMZtFbbGiO98kllAmBh8f2rMSki7rT
         UfKbfWeIvYEgsX5R8BHuiJ6fM4DCOAUT+4nqFlmYpbw1HMZ4thpTDQBlDJunkHghpmC2
         s0X6fZ9dG2jcR602sAewdaELfL+gbRiCLz5vvNh/FjmhMqMyJFfTLiv8GK7zhNNx5sUi
         jbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308121; x=1794912921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zm0AvIJOmifRUI1enIfd/m/5IgggtCc9iLAPgeXHvVs=;
        b=uvFSshybV7De5l5NWWxav1041MxjDQegvN5kWF7clZSBGep3VHJ30kNc0vZ5DVd8Az
         c6+4lsoS+y5iSzJWl5CHKMWoOtCXCHgx68X62gNoWconvILtAvG5APc8KkxKqNtPXqWV
         OdTzXLb3HYrPn3GeiNCMoloC97g43jZlPqyMftv7eIzg3TfPlRlFG2Kj8/mBh+votmhd
         il3LyDniGfQi6A08fdq5y4zgkmmIKjNCOp+YmKlsb4rsNWSJoJrcNmskXqvlSAk/okpu
         2+JHuGloRoKRi94A5DZ3jrMnN7xgsJ5ZAGVeFyVrYKmqEImHlbW7Dyh1MSu8Sf0WgJWO
         1v/g==
X-Forwarded-Encrypted: i=1; AL+hErGLAmqpglq3HK6MiLB8R3m1zm3B5VfM4aTHYTcxiPmECzvYY3Y5LcAitk0/O2gmU3OHeJmlozA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+okObeOUIBZOiTGy0yvW8H9p7waXNsDosMWWHSukHh6o19SefJ
	qnrmd2DA92oMGZamDdm40xW/4sjGEV7g44vg0XtMNdvL0ckpGS5POblm
X-Gm-Gg: AYBFou2HH7jRH8AaxiwIDT14O2kNDVepws6nTzvsHhOzuX8SGXdZw9O1ygmN1v3GUmH
	Bv04PIQslLrUJgpaCft8LyWnvkNYDtgvTxTxrOqBjybhpKvrV6nC0XMroGtcs1S9FxJXT/mGV+Q
	0Sa5uWQHIoI7t7RgtQavEXnYebhjKtD1xlHQAVivO5jPrdcdU8jb9NyGRcpU8Bqm9ntG7+dT9FS
	7UQ2Xiasu3z6zPGiA9Bpn0GRuJ5Dn8q7ddmTHD/1qUzlyq2kT0cgkuvTk6Qabt1oxdcPPIMZ2oo
	z2a063zKvWDbgj93QFT9jEbsC/nWSJcOvLDRcLIB0kFvP/ASJYx6KWC79fdIEmvN7AM3B3KDnPQ
	sVFNQPjKV2LQA6OVa9ErGCtz+mIIm2ASexYmvXNhggWGcEyjMCzAMcmHgGfZ9zjOHCf4D1V4ut1
	zawjRyH2VFfUCQShPt6t7XewxrOt9Q5TUCWQSZ7w1uBByk132SHeMot/H7ErrJjKRaT/FIPXYdM
	0zUn/2W49FMoMESGKpZhtflcxkz3A/1xvqG6I6uVK+lR/eBGtQeN3RRw+489RlHViH8JMaFw8/5
	jRmfQp0VP1voV+zFum3al3PPaXOKZwPGdAQoy9WsmH/Z5J4x
X-Received: by 2002:a05:7300:d20d:b0:369:f9da:a70f with SMTP id 5a478bee46e88-37520120294mr3038993eec.17.1794308120201;
        Tue, 10 Nov 2026 02:55:20 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm6358690eec.15.2026.11.10.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:55:19 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] intel_th: msu: drain the window-switch work on removal
Date: Tue, 10 Nov 2026 19:55:11 +0900
Message-ID: <20261110105511.2488300-1-hj351016@gmail.com>
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

msc->work (msc_work) is scheduled from intel_th_msc_interrupt() when the
next window is locked and the trace has to be stopped from process
context; the handler dereferences msc and calls intel_th_msc_deactivate().

msc is allocated with devm_kzalloc(), so devres frees it after
intel_th_msc_remove() returns. remove() deactivates the trace (so no new
work is queued) but never drains a msc->work that the interrupt has
already queued. That pending work can then run after msc has been freed
and dereference freed memory (msc->buf_mutex) -- a use-after-free.

Cancel the work in intel_th_msc_remove(), after the trace is deactivated
so it cannot be re-queued, before the device is torn down.

Found by static analysis; not runtime-reproduced (needs an Intel Trace Hub
with the MSU in stop-on-full mode and a window-full interrupt racing
removal).

Fixes: 615c164da0eb ("intel_th: msu: Introduce buffer interface")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/hwtracing/intel_th/msu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 84d99d7..902e7d2 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -2174,6 +2174,14 @@ static void intel_th_msc_remove(struct intel_th_device *thdev)
 	intel_th_msc_deactivate(thdev);

 	/*
+	 * msc->work (msc_work) is scheduled from the window-switch interrupt
+	 * when stop_on_full is set and dereferences msc; deactivate has stopped
+	 * the trace so no new work is queued, drain a pending one before the
+	 * devm-allocated msc is freed.
+	 */
+	cancel_work_sync(&msc->work);
+
+	/*
 	 * Buffers should not be used at this point except if the
 	 * output character device is still open and the parent
 	 * device gets detached from its bus, which is a FIXME.
--
2.43.0
