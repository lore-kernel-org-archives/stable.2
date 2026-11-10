Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285014;
	b=ZLy0I6OP1HL3WB3zdLG1LYTsB6Jr1IZxybwoI9ZJVdYSFCo73tM+p3zNOZ/zAWBblvwG
	 WFy+gdPVJqtfQjO+PTi3yB4uc3kL7Y8INn5ANJQSyI2+0W2wMhv7/HcVpLDZKAsqbDKOC
	 Jyw4VLMBH5I7UP3Gx0bRW5u/QNMR5cLKnngF3bQOD9dU6O7ZZVFmzkVDN64zkisLqpLwZ
	 1MQOHPSSjSUFKhlbd2dLN1ZqLrb4RQ7hS2JV94I0Gr/lKwAvTbcQQ3l+iq+A4xQZQcJh3
	 1WgqlDKWGmrNevTlHb4bb9ArzvC2b2H8FxHk0doLsP1z6bHxd3esFkUbUgiTMKFOF7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WsSLHGnK7HTgTyexFfYUW9M44U5fpvmPCQ/caosU9hE=;
	b=2petWsvWMI/GgyR87oqmdUSfS9sm5MNIvjuz/wY1lMDMhRoJPpCzVn5omdDrzs/MYja5
	 rREmKQlkj1s6cpWJglpXPvFFdrznwo9jBR1W4DB5F9CjnakX4Ep9Q4cEiRGnLIVrQtDv4
	 KNKTn04y8CI8KwjJfSclKuhb84dNkeeivhD2PhlM81TxAPVcMDUDQFj+6nF13x6XkCz+L
	 FbZoYR2Bo9VzyGYyI3EnUR2DvUW6R2X7VdI4JJCkMSbAr82a5rMjGRkO0cpmvK+4Wae/g
	 eqqciRYVwLlwqtYtWQx3gPNg6FGeRsUvU8BvSIDAw20ePsUD+IbplkooyaohZcc5XfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5+fZx9c;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D88606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D88606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5+fZx9c
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f2b8cf037so143531685a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285013; x=1794889813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WsSLHGnK7HTgTyexFfYUW9M44U5fpvmPCQ/caosU9hE=;
        b=W5+fZx9cVh5JpgpRFqmhQ3HMG14XtDuE9pttcjkhvhpyLGfdTvvjVe9ADn40mNYN5M
         /X1XSBiKzsql9aat5AR+ALWaLb1dCSPz18Z4MPID0OP7uYSM0U9/18sYyJQuL8n01Hmq
         dOGAOtS0jOYDMd0OTCbolo2maKz1q+XEeFdWu5H7Fgi8XFHsxK+8xSjQc8TQ9rgzpdAU
         06L5ZczAJi+gfWAS+vaahQXdUzxXzO+YWRAg0DPK8PSD8t/Klclr3/qNjLXf45idqFpW
         4VGNIVn0K4YGF0YIKzGTp/Y0IQ69vwUvpKL7xelN+NdBkZ8OO8Rs/PO/ODxWfsFsZ6jY
         XixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285013; x=1794889813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsSLHGnK7HTgTyexFfYUW9M44U5fpvmPCQ/caosU9hE=;
        b=0EdlKr7FsgiOfHpqYfsycyzIG89eimK8SXfv1fobrU7+DTTBfdmAmJdBljL62/+ECg
         ozW34cu/QsyF//86YlEd9kmoc4LV0b52a+tzonYrPlXMZbEva2xVlWMZhLQ+dkR6ol8u
         +S0n1bOHjgvOxc2U3CesJaNalPny7IulTu6zDT9Z00kwXTb/C46heTcHV47MxbD1LsKf
         TM3k22WPI9Xjc3MkajgGjU0ph0P+wJ909H1DrdqzkBQFyGrAb2gHjLIMIxzanFHvsqjZ
         zqIOpr9P3nAJ32JxAIhlo+32ATWaAvY4/vTZlnNrngK1liZLUwQFweHDOQ26HsAdDYru
         +w1g==
X-Forwarded-Encrypted: i=1; AL+hErGwbTIdjyWZoi213aadsTKNA9xVON1e4c+mM4d1b+VPTCWR4pJVIRS4weJHZWjtp3fiH0alA0U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fDaILfS+3YYYPDBCK4RLVfUcWilqK/MVXyVC5VLh9yikV/LXW
	oKplGHtxE6RbdzYlRuTCL7iEaEgDq4sIDmLN4ilsWgcRYrhlpXupOFM=
X-Gm-Gg: AYBFou1p6tomBPmv9+BQ4fCBEwWDvudOxn0El84VeNDG4vPHlHWuanWseOx82kO03MJ
	AlFC6drDGYhr4X1TqfKmzgJHgqM/0D/7bNqttCEu9GE7jwUb04r/NiGlYUP3kbjAZ9bVP+OFRV4
	6HchM5ZAO+zMioQtWXVsQcZOlNfgvJ0FM6jkQfcN9fX6zA8wXn6Hvy+gfbTTkL6DZzUPq30ebGy
	se5ovJdycG/dG17cMAvhttZskGPQDt5xYpAJ9odtRi9zg1vUl4CND6gb/pdX0YLYh6H0bEqm9aj
	BWGyNvAPhQA/Wom6cxNNRBaFINPUgYI8e0szC5HQ/aJ2AqJQ5UaBwBf5JWvKc8r6qsGNATLSmzc
	Pcm1L/Rz2Z4wBryfL8K6+u7sb7kVK0BN4MAeppHZQu8YiEk8Vm6NXTfywRpBSuy9MobvrkqLACO
	EBI9QSUEb9mHQIDE2qkT81v4hhBrbPdx8zWMcO+2ASm8HD5CAoj+k8z2BoxLU1TdNi5HKd6mOzc
	U6zEmOx9KOIbcZdWosNCzqwxyv2uTyhFUATwBZk03ymLR/b7I8it2UVsYL0HYnQG6EJuQTVrJRT
	HZ89MK/8yHORmV4LGQeeXPpQC0BlVrBo8j+Nb1TJKsHRedALeQZwdREU7dD8myEJKH90BvNSJb0
	AopFzDSE4XH8XE2XbNDJPbfEZO2x19aHoUqrGLaFlcj7GOTPP7Rf6GKzOZzVwDNCm
X-Received: by 2002:a05:620a:6c84:b0:93a:14c:32ad with SMTP id af79cd13be357-9479f09bf6fmr258929185a.0.1794285013134;
        Mon, 09 Nov 2026 20:30:13 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e9b4bsm134049385a.39.2026.11.09.20.30.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:11 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] memstick: r592: shut down the detect timer on removal
Date: Mon,  9 Nov 2026 23:30:08 -0500
Message-ID: <20261110043008.56716-1-mhun512@gmail.com>
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

r592_remove() deletes detect_timer before freeing the interrupt.
A card insertion or removal interrupt can re-arm it in between,
allowing r592_detect_timer() to access unmapped registers and queue
media_checker work on the freed host.

Use timer_shutdown_sync() to wait for the callback and prevent
re-arming. Keep timer_delete_sync() in r592_suspend(), since the
timer is needed again after resume.

Found by a static analysis tool under development.

Fixes: 632644227850 ("memstick: r592: Fix UAF bug in r592_remove due to race condition")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

 drivers/memstick/host/r592.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index dc3de63901be..399873a61d1b 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -827,7 +827,7 @@ static void r592_remove(struct pci_dev *pdev)
 	/* Stop the processing thread.
 	That ensures that we won't take any more requests */
 	kthread_stop(dev->io_thread);
-	timer_delete_sync(&dev->detect_timer);
+	timer_shutdown_sync(&dev->detect_timer);
 	r592_enable_device(dev, false);
 
 	while (!error && dev->req) {

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

