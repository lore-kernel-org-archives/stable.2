Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039662;
	b=CIqyMFxdmt1qKYF8tzRNSy+CMxTpw2inJGcLmUgwywAW95hLA+tS14YXlH/pHmYjrMGy
	 P1ZRpyQpIiggKbYKTwB8QIm2vwjy4Q9/jHzFEd9wZgCpGZ6egFqo/Pu6sQ0J0EMEnVnPz
	 WEfpRu1ELCIZVUuViIOtl3iNxVV3cbJKGYe4M7Mgry8oRFgmovgNgx/eTFFTySL1w+8Qt
	 e8F5Jn0q7NThclF6epbJaeiYcAboXhd9cXpdEp6Ln1z4alEhGUENpphrKKAE4Tn+s7POX
	 Yn4iNt59BFV9VCvsrXJqYplgBO8emOivvKiss9DviZohhXHH3e43yz18DW9j3npVusA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mGGAH9zwZqlB4RSR5d8imk8M2AT/E+I9ZFv5C+97Tg4=;
	b=VDXi2E8VeICdlwibhX0PONXvj9wxhiaC4BMiq8Ltk8jfkOtumPj5TvdfEtohV4xFJBF6
	 iRGItcRd7drt4kQonHOyKTGtUl9BbredJC8ogsgPmZemW1Eha5hVF4RtolaUq2UFyynHY
	 hYYqfHLsOTuwIeas5pbXi7qv7LtA8WZvdv5WTaxHqsPGtB2VvTKxisetfZf/9MhkI4I0Q
	 2imMufKokALa6fGxxT2VFZyHM9UFH552pWHQ8/r1sK9xBNlR0CA83cpZY00ut/XFcBWcK
	 65lKEg4hegWnUHhiVQo8nT/D13ZoDLAf/+amVlhqNhhOQOiTXg+y9q9XM5v3oFmf8yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoX7dFU3;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A014606A33D
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 22:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A014606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoX7dFU3
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a42b34e930so1257823f8f.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795039661; x=1795644461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGGAH9zwZqlB4RSR5d8imk8M2AT/E+I9ZFv5C+97Tg4=;
        b=FoX7dFU385w67J1ryrceOj3KbgzdpkBdi6EtKp1JZT2snD+6G2ckyl76WgIkgFNUGM
         e2m6Ov41KgSqCwYGCxUY9K3CNvx+vIa/b8aDUC5MtzvNG80MLYK2IAHvCUzQgCmf6/D1
         cfSTwqX5+uJhddEUAb9pJmJzZVFINv+xbwh4dWup9bJ+2YOAYHZmnBuIszpbV06JbJfw
         WR3Ud4UJPUtS1rii8OsK4xSxhn1nOalf8ROIYJ+F1pmKXafqmtUCp81HJzhit6ywLX3y
         X7bjTAdbSSji1kI4qgkjKbxT+/krlRscab2hRBpKjaVsbP+0bhVIhluFvwpfrx3q5OuD
         /gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795039661; x=1795644461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGGAH9zwZqlB4RSR5d8imk8M2AT/E+I9ZFv5C+97Tg4=;
        b=zuZdkWno2+OcQwuxxYI9QWzzvzNgCiBqAl6GY4BaO+2ZIU2yGIXRRXg1DkxYfZ7GVv
         g8RelYtSCIA2tBiG4oPSOKMCxOoB1oYbj4FBRPslcX2SzKvW49Pgor0ICQ9En9kIokjb
         5aRep8SeIqc5kv6iuS3jxL92p64I1vqfurLvaxBG0PesSbDCrZQtDXM4kpZ6GHWqvwLK
         jnkU7XC9X4kN8nEzsbEiUI6CpkSdupZw7Tejij0FhGMW9SKPSDJ3mUfnY/UJoyc22+7D
         OaHICh1+YAl0NZg3H1wSMTQqlOb6MGVjY9TdwmKWVNta1GK2vv2PYCBe5wTdVzs0+cwp
         q9pw==
X-Forwarded-Encrypted: i=1; AL+hErE4S0/H/tgarJblCj334S8slwsyPLaLAsBKzJRd/plKtXMAWpKXmqHPTkFD0PrPJxqCWHoQQ9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eVaV5pin0Y9QEZKapEBzQxCzSyd+zp2nGxPxdWaKJJKh5FgIH
	d16W7BcCFb03vq12ZZ97ODFEmUg3WCksf+sPRldhZsS8jzLW/AwS7JK1
X-Gm-Gg: AZFdTZcGE0oeq21M+Z2pL5YWNd3GckCVss9uKq1KHKI0PA/oprDya1Hd+vz5RDsISNr
	hzMabmTHgrSlfdFV4aaNDw7VdT68/gs+UAtuAwFxelewAabCUHfvL5X+q/BhsybT3/Ll3nP3Tde
	JRluwj0AuYNhvlTNDHusQIVuHre0aA+/Cx0hUWC87wffXdDJOFGgNqCTAKMz4Dg7kj0jLQnBH4P
	Pf2GVOGR46l2HUtDTI9dSzDyDUWKLkPRHPPAvr12nxNrmGznM9DvBEKzGjbAB9gkitbZ9VbCf4n
	rsuFNoVMIqgnBZGUkQtzZ/gNbd/trFMNSfbzWd4/wunSarNY3V8PryAW+QCjWXkGgVUIehA5myH
	+8+FQqSeAtcEGK/W9WMqcaVdXmm1rRcKYzWPPgIngPSGnEy01VkGFtjKmy8/1el8v4tSg8yNOuJ
	wiTu6ztqyRvO5s7JeUCxhryHB/7CKj2fWtMut3ROGmSVrJgsPv72MfLaJsOePsmlqctdrEdgk2w
	c3F+9lNwo5LY6vPK6I4TMpqFz17+MA8O69q0H2b4JPc7v6yZjKcLe1uMQOSsBjc6LactNtIrRiv
	Cgt1ty4Z2lR006Bqn2v+cdfUccb61jV/ccVW+0JrIzPk8bUCAuXCGxOOtfYVTTnwBlZjb6CRevl
	MuDF8MKXYM67KpJ7Ykg==
X-Received: by 2002:a05:6000:220f:b0:49f:800e:aefc with SMTP id ffacd0b85a97d-4a639475777mr9194709f8f.14.1795039660723;
        Wed, 18 Nov 2026 14:07:40 -0800 (PST)
Received: from Enricos-MacBook-Pro ([2a01:4b00:b82b:de00:c5e0:cc6:391:83e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3f7sm7541073f8f.24.2026.11.18.14.07.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 14:07:40 -0800 (PST)
From: Enrico Lorenzoni <enricolorenzoni59@gmail.com>
To: linux-media@vger.kernel.org,
	Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-kernel@vger.kernel.org,
	Enrico Lorenzoni <enricolorenzoni59@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] media: cxd2880-spi: keep the TS thread alive until kthread_stop()
Date: Wed, 18 Nov 2026 22:07:31 +0000
Message-ID: <20261118220732.29246-3-enricolorenzoni59@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118220732.29246-1-enricolorenzoni59@gmail.com>
References: <20261118220732.29246-1-enricolorenzoni59@gmail.com>
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

cxd2880_ts_read() is started with kthread_run() when the first feed is
started, and cxd2880_stop_feed() calls kthread_stop() on it when the last
feed goes away. The thread, however, returns as soon as an SPI command
fails, both for the initial TS buffer clear and for the buffer info read
in the main loop.

Returning from the thread function ends the task just as kthread_exit()
does, and the task can be freed before cxd2880_stop_feed() runs; the
kthread_stop() call then uses a task_struct that may no longer exist.
The kthread_stop() documentation asks the caller to make sure the
task_struct cannot go away if the thread may exit by itself, and this
driver does not hold a reference to it.

Keep the thread in its loop until kthread_should_stop() is true: report
SPI errors with a rate-limited message, wait for the same 10 ms that the
loop uses when no data is ready, and retry.

A change with the same loop behaviour (plus extra locking and counters
not included here) has been running in an out-of-tree build of this
driver on Raspberry Pi systems with TV HATs for several weeks; a 60 s
full-mux stream (19.5 Mbit/s) with concurrent register reads showed no
continuity errors. I do not have a reproducer for the use-after-free
itself, which needs an SPI error at the right time; this fix is from code
inspection.

The change and this changelog were prepared with the help of an AI coding
assistant (Anthropic Claude). I have reviewed them.

Fixes: bd24fcddf6b8 ("media: cxd2880-spi: Add support for CXD2880 SPI interface")
Cc: stable@vger.kernel.org
Signed-off-by: Enrico Lorenzoni <enricolorenzoni59@gmail.com> 
---
 drivers/media/spi/cxd2880-spi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index 36207940b..8e31771ac 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -278,18 +278,17 @@ static int cxd2880_ts_read(void *arg)
 	}
 
 	ret = cxd2880_spi_clear_ts_buffer(dvb_spi->spi);
-	if (ret) {
+	if (ret)
 		pr_err("set_clear_ts_buffer failed\n");
-		return ret;
-	}
 
 	start = ktime_get();
 	while (!kthread_should_stop()) {
 		ret = cxd2880_spi_read_ts_buffer_info(dvb_spi->spi,
 						      &info);
 		if (ret) {
-			pr_err("spi_read_ts_buffer_info error\n");
-			return ret;
+			pr_err_ratelimited("spi_read_ts_buffer_info error\n");
+			usleep_range(10000, 11000);
+			continue;
 		}
 
 		if (info.pkt_num > MAX_TRANS_PKT) {
-- 
2.47.3

