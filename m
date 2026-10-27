Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097422;
	b=t2efpgvUXCBqGnpp3nAzgQYSpmFoyETvIdvw7CEfWk171JFSv6XXJ7P20KaR4OplHRWW
	 YuD71kGH5W/IultN1sY9KodlVENVoQuikO4sGOOxrbWuS9IQyk8+niP8HMvfcmdow0l+O
	 0YuILbJQB/Amask+SliduHnLHkmZXgNbW5Uu7IrDv3P5du74ID0OhaOtaXBFo+q1tKPTV
	 eBkZZOmLYHH8eQvzCCxZu6h0CFFIXedkZXOY9KfR5sVIUHIhNZierp7ww9tvLAsdbDzFG
	 tdmwF4SiQqSjcnYJAGoHp8sRyV8d/D1dkxv5XuYW17ppnyBG8kNz8cEGra/CX3L+unw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ckYp1oZE/nINvTOKIarWFZT5ZHmdM6ZJXgA+bxu9+tk=;
	b=ED4xT0UCBjy4tCeMGBNZllCquI0NA704QBrzYz+QQM6Kj6o/tHdujUikCrErfgF8OFCp
	 xyniFSDD7yRqFA0mkkPlnNEwhdo3ksOl2VQK4Oj9HowvKhkNJ1OY7IH/6WkEvAYQkKf4f
	 RCGqwuslYx2EhADdNPez/1QkLj+ERDe5I6c9v7lcdZRO+VoHNR6/71HrCEXUShrqy6wSz
	 tYdPHYP1vFAyy8LKsi9vxPZHf0hjO2PBnk1JRrnQZjPOtp0tLZe4w09OB4TqxHf5YVtl+
	 oxfiYCFWb9M3nq6FVqcG7M/2VGBdOErXRnoiejzem9pPCZxkfSSQaOZyAhYh/nlWgNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V45VRmxC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B5A606A31B;
	Tue, 27 Oct 2026 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V45VRmxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF691F031E3;
	Tue, 27 Oct 2026 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097421;
	bh=ckYp1oZE/nINvTOKIarWFZT5ZHmdM6ZJXgA+bxu9+tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V45VRmxCO2A19BOHLwd0g5vZlcK+Zg+DWrDPKwGWcAic9Kn8mcp4/lIszKcqIj38y
	 1vVzRSrmtO9tXDlfd+5e3khRq1OEOij+fhFDcOT9Hl+tmPP7D5IGDHjQ/qf8RUVfTl
	 p03s9CiccD77PEkydEEtVtARqm84tFwIA6MH2Z8IIbeScuHY2h17rZPVTAmJg3pZwJ
	 zi5vf7NOutMGXZvnRZRPmZMI+snKV+XbDgKqr8wjx1Ub5y9yydmyGx27PTCUXJXG3f
	 tT1tQKjDYm8JYIozoSh1eQ3uLxIE6AhCwAio++BAe8980gyhQrk0XHvJe7qLExhxjH
	 TGHbxTYgj61tA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ming Yu <tmyu0@nuvoton.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 08/27] mfd: nct6694: Do not resubmit interrupt URB on endpoint stall (-EPIPE)
Date: Tue, 27 Oct 2026 09:30:37 +0000
Message-ID: <20261027093306.2812695-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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

If the USB interrupt IN endpoint stalls (-EPIPE), usb_int_callback()
falls through to the default case and immediately resubmits the URB from
atomic completion context.  Because a stalled endpoint completes newly
submitted URBs immediately with -EPIPE, this triggers a tight infinite
resubmission loop.

Treat -EPIPE as a terminal URB status in usb_int_callback() alongside
the existing teardown status codes, matching other USB MFD drivers.

Fixes: 51dad33ede63 ("mfd: Add core driver for Nuvoton NCT6694")
Closes: https://sashiko.dev/#/bug/linux-9d8d1902-140d-4559-b604-76ba76e778a2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/nct6694.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/nct6694.c b/drivers/mfd/nct6694.c
index e2957e587d1b..40a29f8e0ff6 100644
--- a/drivers/mfd/nct6694.c
+++ b/drivers/mfd/nct6694.c
@@ -201,6 +201,7 @@ static void usb_int_callback(struct urb *urb)
 		break;
 	case -ECONNRESET:
 	case -ENOENT:
+	case -EPIPE:
 	case -ESHUTDOWN:
 		return;
 	default:
-- 
2.56.0.307.g5fe7bd680c-goog

