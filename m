Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675166;
	b=PwaaZF221OhcKJtGVf+r+zSp0tk5pW0HuCE2kXQ9Y1Ar9SJTSRWLliv1LBDy1aGSMkBd
	 cj+BCtxBLJFNd0e0kW5wVntjeqTrdjdmzY2uxwr0hMf4whOCdPni3UhaCuKoOCXu07lQD
	 6aiyyNxQs/ogNZwnbDPSbACmBy2x9eL7/TdwwtgSZeQ5r6rVKc3jxJbbRoFebUZ4jpBPZ
	 3wwEjQBtcupqMFQQs9nD+dcvlSlyA68A8x/JUOyfHUnKhLMUnlos8G3UgaWuj/jDf9t3O
	 MY47yyIuOW38tp4oalUM+lDP0VJMwEl10qIlTKSo75onZeHkyf9+/qZEDh11y/E9lGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gRPsfsi93ztSCs2QSFkYBVWIi6vXulM42YvoVjjVqpE=;
	b=U6+juhoAt0kxUfMB/Qgt+956vXdOCOzWy9z/88Hcpjc1NUf9xIZHraKRdsomm5NBXPwb
	 4JzfzhxN7IjI9cpZpHeP8qOAC3a6NRqNFZHGC6M2FP090STgoZEt2SBwjBu2UvUZRfBJk
	 NQa1SDA70rFBCRr+RUy3mgQaQOS5kWT7sMSYWnCajvCLExoSZAGZUU08Xfw7DF+/EEii6
	 mo2QksZ36Bn01IJjEbV32XjxgCROZSlyT0Uu9t3H86MObsJU9lJ4X1Ab7RjfhfX4ESJOs
	 e7MONOWXcgbSXyjEItfvjILpAZ3vh+u2WCXQwC70F0InNaJ2q9IacZ5I113vfugXkVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JPMBfTF7;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A9606A329
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241A9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JPMBfTF7
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38190551625so13057049eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795675165; x=1796279965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRPsfsi93ztSCs2QSFkYBVWIi6vXulM42YvoVjjVqpE=;
        b=JPMBfTF726268NhfprvDI98BW7pD2A52FBjtdFqCxE4mQJGQpC1Ma9uScajoKPn+DD
         HIHYF8a328biIV0ACuYxOQGYu3FfBmdT5iBdjmgb26opMECZOsZRWs4M88GCQ8jtXDyF
         t7/RGiNnQnyjbEhpJQBa9IO0ZZfzCZHITdx+3Mtsel58nt0fV6eUpOGYcecZz9X06Rgj
         HIYdzWLtMFoDnazMaAVEXTLT/4fHqUwSa91eX4vEulgoy5390s/Xrb65dwI9WdW/2Ij4
         3LDZlodu4aPCXY5PKzUz/MtfZyX8TEKsjVBabyEeox+S27wmGn32IlH987LLBd9H+AOS
         6wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675165; x=1796279965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRPsfsi93ztSCs2QSFkYBVWIi6vXulM42YvoVjjVqpE=;
        b=AY7zc6QUXIWiTi/pVcXN/q/2m/Zn0TRqvLqmHAsY9mifmQKerjYsqBJ9Kx0+Q75Co+
         q202gWjcA81evKgnp66dDXVa7HV2ETZRWgMfc48iOyyLybTjlVTN8WdQxSkCYN62UwY4
         Oz61lEReh+H0mFP6lY/27snIqHyQRQZEeG1kIjVVyqSozcuwdDhmNd9KtZSKnarLFQlA
         LxwNlQqN2gqdwT8R4qK+34QRhvfOJ8Q0goxkuq1+jfjsJqc3P0wNNIWJJlDA3W4+1001
         EohqhoIBUsPu70VV4/4qCbSAd0Shc+BKP3n0KNB76cK+SPZYnba+HODJb4iTywkA+3PK
         zKOA==
X-Forwarded-Encrypted: i=1; AL+hErHlhGDpjgmubhe5BmCTanaj+HpljneMq0dKXtL5aoS+3nrpd8oO/ZlytQpGz60P9fvhSBapZmI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sKxquRNcNOs2qVc5ebMTQR+OCipDHm7zBpuPDfjRWX07njEiy
	1iXHtum5THv+KCZ+DMxgqTxqY25HJlTRdXXhgUFfsjb4w7lXW760DaEAHx+OhQJ7spjfooWdHbo
	=
X-Gm-Gg: AZFdTZfV05S2THXE4lCQkCdYgJy1ZBA+VgU/in/40mOsqsqm90gwhClTkQzs5oqFuOf
	on97AGD/E4xJZyAFmzl4UyDw7j25WDAS9fWSCuYUmSwx1t+0zgL4HBlbZpNa1n7BDR7N6C08Khs
	aEushoT0vSr83mqNr/YhWPqgOHWaUb03PlI9jVGr/+6KATtLllRhD8gGEKTVyIYjwvWgEEyC85R
	6GFTf9wDQg+PM+R4S0it8awninxh2HvFGA+/90fMBPoQjYEEjjiw6Yqk3RIN8l8JJKfOO2KHDom
	w+/3MKeYeLX7d1n/5LSUDhqVqEyTyH6GfyDyblQ8qMEFG1DwWFiU3r/0iVpDmlevdlgzH6UNUk6
	EfLK2LgV/i6g/VSnLI3F1zHnHR0F5UjCvxeiLSbqYHTbC8HighN7sj39LyrX0aEK3iEuN5Ojh4+
	D9DlUw+1ygOPxop+mWoMAbSEbqO5oL3s6POdEn/XaWQFjEGiD/tZsOt1KG5aDqPlC7g+upBjqWj
	8JmqD5XBKDz6aYIHCCzbtRGDSujbFVC3A/k4T2EkekdeGN3QAzn5jworor16maRRID3q/L9Tijk
	rzZ5HJXSxq0GpTsGaP28U8n5qsDwr2qwIY/D/n0lV89wWZjKw8wca2L59HZOZngT3YYRrg8U133
	AutK7VGLIj6JMPd3rnvRKIxFpdEK2GceQi3o8O5NMlcILOXiIh8gmb8N+/VU/pdnPVt+glnuJpx
	XLbHA6+KQm03fW6+5AWwa8ndV7mklp/EiGO3NyfxfU
X-Received: by 2002:a05:693c:41cb:10b0:386:cef4:1ffc with SMTP id 5a478bee46e88-386cef43e87mr4363755eec.12.1795675165132;
        Wed, 25 Nov 2026 22:39:25 -0800 (PST)
Received: from LAPTOP-3B99V33A (ec2-3-38-183-164.ap-northeast-2.compute.amazonaws.com. [3.38.183.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm55404015eec.13.2026.11.25.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 22:39:24 -0800 (PST)
From: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
To: oe-linux-nfc@lists.linux.dev
Cc: johan@kernel.org,
	david@ixit.cz,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] nfc: preserve NCI data status error codes
Date: Thu, 26 Nov 2026 14:39:11 +0800
Message-ID: <20261126063911.353-3-luob87709@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20261126063911.353-1-luob87709@gmail.com>
References: <20261126063911.353-1-luob87709@gmail.com>
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

nci_to_errno() returns negative errno values for nonzero data-status
bytes. Passing that value to nci_add_rx_data_frag() through a __u8
parameter truncates the signed errno into an unrelated positive value
before the completion callback receives it.

For userspace AF_NFC raw sockets, this corrupts the reported error: for
example, an NCI status error mapped to -EBUSY (-16) is truncated to
240 and negated to SO_ERROR=-240 instead of reporting EBUSY (16).

Keep the error parameter as int so the original errno reaches the
completion path and userspace unchanged.

Fixes: 98ff416f97c5 ("NFC: nci: Add status byte management in case of error.")
Cc: stable@vger.kernel.org
Signed-off-by: Bin Luo (University of Electronic Science and Technology of China) <luob87709@gmail.com>
---
 net/nfc/nci/data.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 3bbebb9..4a2326a 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -213,13 +213,11 @@ EXPORT_SYMBOL(nci_send_data);
 
 static void nci_add_rx_data_frag(struct nci_dev *ndev,
 				 struct sk_buff *skb,
-				 __u8 pbf, __u8 conn_id, __u8 status)
+				 __u8 pbf, __u8 conn_id, int err)
 {
 	int reassembly_len;
-	int err = 0;
 
-	if (status) {
-		err = status;
+	if (err) {
 		kfree_skb(ndev->rx_data_reassembly);
 		ndev->rx_data_reassembly = NULL;
 		goto exit;
-- 
2.43.0

