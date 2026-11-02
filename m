Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622202;
	b=c62uuzXgTekcdDzkUHM2LZqSjOfjbDf4U6wVPmDc5IfA4fc0Rwz2NMcYm8OU9S3yuIDc
	 +gTQcP4drD3X9Wn/aQiHXRBHsi1n5UTYs0fO+uJmLVaS3iLXcNitbDPCcPMWAPxCUoHRf
	 j/KndaNZXkF48jGaSj4B7AysTU0VCbxeN6UvgDkTHpjXr2z7lUIjdNC/oF4KLQ18Btay1
	 vc3PHzpdOzAA8urco3MNUJ6/S9qQdZrU8a1V/W4EYNGDL/hsrszWffIs6QlsIsHWe+x8O
	 y/KQ0b4aUUqKnjYGR4lMz/88PrDqwygAP8QJIfJnc5RVhZGppHjfSlsebuZim8zmUeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GO0eQoXsdHBDsAY8r5qLcEfQWImjpXMenyB3OyA2xhU=;
	b=LNzUj5O2PSkPBpnQK/yzcWzz4i2cs+4tYrD44RVzizXx7AjBp6+wxiAM7azUCJnb33WW
	 amWxhZ+q6/WeNnmhWk2vpTUnaNXuyZPJxmN6wpD+4Pw+7DN15dL0EJq9XmPcPradnY2UQ
	 vbT4rvDsWBGG/mqi6XN3MOM62Ycjezuy8KgJ84BQukDIG20Y1pKTulNYqfrsKwk7lHPE+
	 FEumSsRreiEvxHSFT+JBkYSPjfisgyRTtjxBMjkqOTh7HThCu0MjmJheV+qBnuMfIYpLz
	 v7935jRGbyteXPwUK1+U2ZCjSLvlCXr/vbRvhUSmtis6BOfUe3LwCW0nwq4OBUhzuUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oeIIAX4p;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AE60A6F4A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A17AE60A6F4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oeIIAX4p
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so31060205e9.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622200; x=1794227000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GO0eQoXsdHBDsAY8r5qLcEfQWImjpXMenyB3OyA2xhU=;
        b=oeIIAX4pm2Ytu8HtJCliysszXx2L+ft1QWG6iYQQAJNhrx9G4v6CElDYaCW92uxUgQ
         PbcDRqjrGRfgtFHy03UVVHpCY4ePzARb20txTsium7zzi9mAPT/4uPGtFJGEbr7q4TWs
         Nj52mspXoZ80PZVZyWvoqFbT6bPBBGoJgHHhI/HPY2mnO2Ueqyf9YqQMitNYWXaAso4y
         7X72JBKP2aqjgJ2foNDEdhTgFLRx6hUS1sOCDrzayACksxscB+qleHmjUkfkcY1YogoQ
         YbKLFJfnRcBnUa9f/oZjQNwWoIGtLKrna9SAz6t39+meWa/qfXAgOGPakFgSVqVw4ach
         h7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622200; x=1794227000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GO0eQoXsdHBDsAY8r5qLcEfQWImjpXMenyB3OyA2xhU=;
        b=OyyP31cOXXi8xeYsUHYUHj5oyMwLKUGXanVJJyCuLSg4JaEFUlYmSVUJwwBYsQ+fNs
         BSQQ1HgEAu0lZoxFZlNIwVYP9UKwoRWFoPAw0b0XcgUHrrPrIjjGbgqbZHvGaDW7vKOs
         2RgG5zcbk9H6YfnS6GhTJZZP7s9Wch0SEVDiK9s002g3p370HOzNOFcdr6UNm/Nyi248
         1gqlwzIFOBdXefHRxgHdbRii62cmKtUbvjUQzumQ9YZlLHwWiywQDEyq7e3ijM5dIo8g
         RcX0d+78HHqTsRVXK1h5y1jnrctZRoUrxyLOE/5CsrRzxsFB88K0NYnaW3/CsiDkMO4T
         b50A==
X-Forwarded-Encrypted: i=1; AKwUvBxbe0QXrSKjkH3BsNhtYMGZKYjBfESG2pSzfggP+hs82XzZGpEd5FYH3DoafkgnZqQN2c21eiE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJILzRgTVtqxvqeWD8TFIubXdAy8pTT0Mn7r3WOTnwhJg3763+y
	xZkmifDrEhdfb/WEacrhv7MA2RDgh0V8SHbPJNximTDt3tJUTfiBbg0=
X-Gm-Gg: AYBFou3H8sGnklUselFcM3HPQw4Udjyf9Y7pEwE7p+KuLJUE6unMaMOkTbZPWBE1NId
	Kq4WV5Ywj2/QdLRYA+7OegYfwpZqlyb2AXWnkUDeEFbqzH5+5WIbw67TtklPIB0T8Dp/g6k+FV/
	dDSsxs2/cBacCqkhF9wJdZ6mf7CojnptgfKexVspkkMdgNryuQuCsYGH73QctYyfCJqGM6XBGL+
	9F11Nz9XcVuiCbEmGe8NMPe2K3jDD3XALe+A1G/xrq23dil43gZ2EqJBCUT03lvqYHbUgmUYM5l
	2zS+G3q5TfbSTPAAyg+Stn7un6VHiJ97DUGlwjbF3a2lfQH4b790AP7YJEEjOiBAw1Ge9YQGvC7
	SB8s/6JsasTx5ssxGUH4vLHO5+f0ZiTGsHQxnudeyFK8gNfq2cwiQm7aVmCgpSrFyu1EFBliVwx
	1/XG6RUjfeDM2rtUauXcvJmAgRX85xkFBBXkM0Mfb0horg40SnU7iClX/2Rb0aYbTdHUmJqGm8L
	dVrx/cy8B2oGywWwX/gSKHXJhk564iuYBnJYadxdbhpHI5VLv8y+lXvL9eH0IGHxyvmgA0m2Q==
X-Received: by 2002:a05:600c:c48e:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ac16bc47f8mr229484545e9.11.1793622199807;
        Mon, 02 Nov 2026 04:23:19 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf67aa704sm255490595e9.8.2026.11.02.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:23:18 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: arend.vanspriel@broadcom.com,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	fariyaf@gmail.com,
	linville@tuxdriver.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless 1/2] wifi: brcmfmac: zero-pad SDIO write to 4-byte boundary
Date: Mon,  2 Nov 2026 12:23:10 +0000
Message-ID: <20261102122311.181075-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102122311.181075-1-tristmd@gmail.com>
References: <20261102122311.181075-1-tristmd@gmail.com>
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

From: Tristan Madani <tristan@talencesecurity.com>

brcmf_sdiod_skbuff_write() rounds skb->len up to the next 4-byte
boundary and passes the larger size to sdio_memcpy_toio().  The 1-3
extra bytes come from heap memory past skb->data, leaking stale kernel
data to the wireless device.

Zero-fill the padding before the SDIO write.

Fixes: 8f13c87ccc49 ("brcmfmac: Split brcmf_sdiod_buffrw function up.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 71c2f99cdb711..c6dd4148a44ce 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -323,6 +323,9 @@ static int brcmf_sdiod_skbuff_write(struct brcmf_sdio_dev *sdiodev,
 	req_sz = skb->len + 3;
 	req_sz &= (uint)~3;
 
+	if (req_sz > skb->len)
+		memset(skb->data + skb->len, 0, req_sz - skb->len);
+
 	err = sdio_memcpy_toio(func, addr, ((u8 *)(skb->data)), req_sz);
 
 	if (err == -ENOMEDIUM)
-- 
2.47.3

