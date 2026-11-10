Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310537;
	b=UGMhrYvWRg8Qs+/0dqfqoxpz0iw6nZ9xhcLvhPXAlXYDuzCY37ewurvfLdIo8LloghWi
	 OvnNix3z3pq9M4ylqw2JDkjm4KUTYtQMfMoKgo5cp8NhfmYCWpgE03DG9Q/G4xVGOxkuS
	 VVWfiaKZ0I5D/GW7DdWM1thX+Q0NZ8XX2xQJsl7bwPZpQ8Ik/FRJYTXTZSZUaSmvvst8+
	 kSiq0sbSjrLCZWUYu/8RZRpP2MKqKAFsCnc6BBJ2XFWSUx/CLhuQUF0rEJtdwlQ3s4xDu
	 hFjXta9AWbFrJIJoV7s1SWPdvBCmcuTkt8Kfhm4wh4jBzXoogtnQMWleVehLjLPKF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hz2duDh2X9IqKj9QHw0i2rUbwpVwIMp0NVPlYZKXIes=;
	b=Tl+/zWoxLvEZHgMU5UUZ+g1ssMY/IaNSxCHsysknpzikbOfeOr4tAuS4N3opC7TQ1Lx0
	 cbkpCixTHddSPQppWLN5/sbOU8VCNv/3CPoKLphLdpNvd1xztWepeUezB0NrI+RQwp80N
	 u7zoNtkXvBHnXKp4ygTAs1SZZWL70aj4IzruB4C7PQJgOUjsAkvmuZxgcOhxuZb8fMsY5
	 tACpruvckRFZV8Q6FGfZnDt7auFs6i7PoRlhlLTF1uQb41ip5zDdgahQKuYEHdlarIw2r
	 XmaxuuYMa6fXzHH8XpXSeHHDyU7vL5sSRuErpcwrcr/DN2lAuvSPQ3IjKSoQnhRnzKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lE0qWE6r;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2F606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01A2F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lE0qWE6r
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37628596783so6164eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794310536; x=1794915336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hz2duDh2X9IqKj9QHw0i2rUbwpVwIMp0NVPlYZKXIes=;
        b=lE0qWE6rLEzHfNoA21IpOUbmmJ7E2tUdoftzBvHiwSlWedBAdOfuaIZzQyiS7ZKfBM
         k7BPoYeQ4s6Yfajesc/InpK9TbrfkTJTk4lOBh+h7z9AxaMilIfLJtH/OsSP0Gnqslzf
         gRYSfht5DQfLdZJS1/EAc+xGqXXKvNbOpsrNl4yuKM7p+NXGjERwCNvte85gdgJ35G4P
         cW2Fuozs/4KQmL26oyOVulrshCNzNzizyAlJwFUlXJzi/mBUB7jAIPc39cog06dzfPoV
         AHL4jRyPbgS9xQaJr222eTWaiez8kJt5AG++eIDCTuRY2MTNI8NRgSmPjjGMuDBTUybY
         8+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310536; x=1794915336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hz2duDh2X9IqKj9QHw0i2rUbwpVwIMp0NVPlYZKXIes=;
        b=GS3x1LVUm9c25mm2rLkSLiUuipV6DwoEytjciXNSpLPOkPbuyDLO5hSSoXhut0xciX
         MxgnfPXiaMDTF+vIeOq49+GsIrOVtiQC1osmY2v3tdM7Ho27AsmVaiPwggwHKGzNzPWO
         cN1E6+OjO0jX2Z3+isCNwYilkXzDNIxI6o0Um+Revec9hgn0TWSQmh/zfw5fcZckV96t
         bqGqowlHF+MtaH/qEHtHFfAwew5TJbiMIXz0icd56TL+iBxREWPa1BOD83Y00DU8tWgQ
         O89XsrkycwTOKPiwIqiOIFmaNkm6xq3YYQxMWZ8ax5/SQFh48TeRrUeHpCmRFYYHvKWF
         G2YQ==
X-Forwarded-Encrypted: i=1; AL+hErHuda8jAeQPBj8xrqIfl/IQSj9+3JFNxvlfoBJ+rwY/4w8C9ExBF0cwf7eX+LzhL0JjqFw9eNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vaprp9z/UaIJptrvV28iaTGtQPAmNCWFqGmY3WSOWM1Q7R4/n
	j8hjqplGaxfkIODLWClRVbEGDvayOUOvdh7k/3KLqAr3AsYsuVcoY1KQ
X-Gm-Gg: AYBFou0KBJaVWU7tyeGyv4P5ReUK9rRBAhi6pUR201AyC/gc1oywm31jrA/M6BHAv4a
	zOh1cK9iudnY4HFcC20NqtdCHLWL+kVbF+Q19PbQJKFVU0DyO+iGteARo3MYxKRDHk8EhoG+vVs
	fmOaIl3ifDta8XydCX+32FAaXTojX0ZPl4JZzE1bdqR3ErFW27cQpQRw8G9AGqpMSAEAR8n8MRj
	dcwWjqcDehMiUqdswGp6BO4r1VU3no8fqHHwrqxwyFbeFUV+dHK52mk1WtQAGB++C74A6/K57Zw
	fjV4ElMK49tC1RZVi0zF1xN5qjB6YjfG2w0Ly4vS08pZrF5RD96CwaE26Me8DIGLPPG5Wg4p/8y
	DmQD+YR6tzI89jwyo53X8F4rtKKx6Dn5/keb8FExVhBCADbqOt5BPm2d8j5XMH1geKitTsje8FA
	u2NBffM/K76tFBG3CiL7IWHHo2lMv/uvEozP6KR2GCb0dJwCUEGu13JDvDEPe6ZQ6Xo2S1a5rZP
	1GewmTP/sFle5L6XQ9PTzUABNkh4RZcJoyq5vlpsVjf+X6O70tpdUlP1NA2G2L3ORmNBxOzrY06
	94b5sQFEEp6cEnk4xTJNZwWMxKF5EG59rLH8s+k0SBCcpLGv
X-Received: by 2002:a05:7300:54b:b0:36f:350b:3838 with SMTP id 5a478bee46e88-3751fa3d477mr4851767eec.31.1794310535882;
        Tue, 10 Nov 2026 03:35:35 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520512ec1sm6098205eec.12.2026.11.10.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:35:35 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-usb@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] usb: gadget: aspeed_udc: cancel wake work on device removal
Date: Tue, 10 Nov 2026 20:35:23 +0900
Message-ID: <20261110113523.2517891-1-hj351016@gmail.com>
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

ast_udc_wakeup() schedules udc->wake_work to drive remote wakeup from
process context. The work handler ast_udc_wake_work() dereferences udc and
takes udc->lock.

udc is allocated with devm_kzalloc(), so devres frees it after
ast_udc_remove() returns. Removal never cancels wake_work, so a work queued
by a remote-wakeup request just before unbind can run after udc has been
freed and dereference freed memory -- a use-after-free.

Cancel wake_work in ast_udc_remove(), after the gadget is unregistered so
no new work can be queued, before the devm-allocated udc is freed.

Found by static analysis; not runtime-reproduced (needs Aspeed ast_udc
gadget hardware issuing a remote wakeup that races unbind).

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 81fa495..20dcbd9 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1460,6 +1460,14 @@ static void ast_udc_remove(struct platform_device *pdev)
 	struct ast_udc_dev *udc = platform_get_drvdata(pdev);

 	usb_del_gadget_udc(&udc->gadget);
+
+	/*
+	 * ast_udc_wakeup() schedules wake_work, whose handler dereferences udc.
+	 * The gadget is unregistered above, so no new work is queued; drain a
+	 * pending one before the devm-allocated udc is freed.
+	 */
+	cancel_work_sync(&udc->wake_work);
+
 	if (udc->driver) {
 		/*
 		 * This is broken as only some cleanup is skipped, *udev is
--
2.43.0
