Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244925;
	b=wn3cVDibiqP4VZPLz0V6pk8UloNK4l+15RO/djBHonhOt5hrZ9Is3XNv2c1ICtAuhN67
	 4lV+woywLBELm1d1gWx7caUAlFE+RGV7L25d9b+897Frnkv/wyUBLTU+34oXHNS8bA5af
	 od2gEKVBFqOuZvL+SKj9WRhsrwaQPwBu5BUJSc1+jdB60eD8ugRcXGNZv9+bqcj67o4ka
	 gnG3VG/VTzvlCuYw702JRd82oGKVncG8HzEKTDz8zRRsPAEbejjkpj2xSyHHrYbilmzQZ
	 ayxzxJ5/dMSqbd+640qKxBiDPOLbYr9Cx74TL/BJDocqQnaLnLs5RR42j/4l07t2CDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5LpgpL2Vm/swkS7qZWB8wOpeYfhvv54g4ZTTBda+f2A=;
	b=nHMR1UlfnRficlqSknvVrPlqjXY7z1Sjeyk3NJvMtjSpSj3rvQxN+eFsmrnl+P4B6FnU
	 y/hzvUTknrBh6PsPbDYua/IqgDUoqU/AoYzZhRp5NEFpdp2pOuwyr64WsOWYvBimw3jze
	 9njcF1qL58jTE0wUrtXNeQr6RlHZGGT6b3dYgMb9JQ7RDg+2ziy5SFTANm7y64sMrNGH0
	 /o14ddmE+R9UPEnjxkvh9eAbcf7pH+fNVPlgCh3o+Ur7cljeV9/Yvlpt6Meowp0rqRwq3
	 jMyjXMRp/W4b6u+v8P1zmho0kTEFsT1YkrELpoQCI+bqx6x2fsdGTtdHpVcF31w4OXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnCtOysC;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAF606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 17:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CBAF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qnCtOysC
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3ada81853so869630c88.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244924; x=1794849724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5LpgpL2Vm/swkS7qZWB8wOpeYfhvv54g4ZTTBda+f2A=;
        b=qnCtOysCu33I0l52a/q/vUnN8e5/1zgL//hKB8axZuVQzgUN6DsejxbLfEXNQAOcRf
         fFp77Lrtvx75fLUGAYXKOnOd8/5FUoavr3Gb+V/c1B+kAjIwfDYrtB2uZVX6fbW4+2+A
         4ObxNM3cl9ALgwQBTkKPvu9gbWiLjPzt7hvi6aO3/ePOgLQZaSu7ZxII4TLTiPY5OtCf
         nhnGmWGJf3a9twzDffAFrnxwwi5/e0k8VltJ0PqVL7+jNRirikmb7XInS2G+s0R1j145
         Ny65dFX0Qrzr0LKmKlKoOAAok5m5GXnQjPJ09GgHMQjKDMZDAVntkZWM4DkLVZ4ciWZZ
         X55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244924; x=1794849724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5LpgpL2Vm/swkS7qZWB8wOpeYfhvv54g4ZTTBda+f2A=;
        b=qrTlEw6aqPE1iQVr6ZscScKA7rBD62efKQRTkML6bLY56WEj2Gw5oCcwInl4dQkYu6
         +HeSJtGTHGhNaC7HXJjCqQW2rxJteUzwlyKoMx5n6XrwJALbFRU3mhKJKtvUZWVTwc9p
         2tSQ1CgW+pBQLZUM/Bc7FakXIdKfB3fAeool9UoPijcdioSq1gxZFt32tn6UxRxZjKcK
         orwWLoPQjLpaoYlX1rKwK/9xjuru2L81gMxT5FH8ee0o0U+FA6lddUlVV4oFmji6ARfn
         yM42MKf/f/A7oXMxENp8G8szvxFu7AVGl0hieYwtUGQWBbUCQwrJMkjEGXNrtAfMCZDP
         nXFg==
X-Forwarded-Encrypted: i=1; AL+hErEIu6L2tZf8/kB9o9THjx1d7C8WIJsX5pGUNbhSWhf7ZhvsPi23u50A24zz29kTITbI8rnlr4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vxxo9uqt/pY3HGVS+eSrfQB2XjOonxxofkPXQ7JzyF0QKZGnJ
	S0OR3xVCcA245n4+JNfBxqmJAHJ2SaayvY7MHo6Poqei2I/4m0i2UFJ8
X-Gm-Gg: AYBFou20VY+78ZXA02hBXEx8OlIFQ6pmI9jmkHf7doNX/K1BDYGwVXy5B0Xo0dTyX1n
	0TXveNlKvIUe+I6HCwUirGZwxBzyB8PejEbeVs+3sp/1axTXytL2cStTDGQ/FR2NP9XyJGC2mFW
	OajBKg6iRSyDP1wFD/QYo7wTKVCiUCFIe893QBopINlRh0fpciJ6XoOg12b75/67cpuMylT3TbT
	t939ebvmiuFsCkf9kbVANgQZu+aFHuXN/Z1CVSURZjAW72qKPR7sOjN9M90Hk+uBOIUojaLteyN
	Jvk77SHYIgI3P3+i5TZU5ufqzwOz6MU+458ebG6uZRwJVRTynigVG81S+thf5Rm1yn3G7CprMxs
	ij7rB6Uy0Xmb+bYKjA8HoNHSSpUNVp3g2bfJ4KcAPozbJ8a8HvQDuhJCTkUWKy7XQlQ3vqJqpc1
	JLiSuLaUHY+/R1GqV+1L5+gNWZQ8iAMby4Fx8gaKZvRQfD2bTDq1UAmBojesD3m/ErhjbE19+kE
	4zfLdFwaYOfZ+GMdlu9HTqENmyg8ALgOhEQKFsj4FGFm/Aug68fZ1ld94jCnnGTqPOlkPYkngmP
	93W7FvGHDICMgnd7WalgGPyWf7ZkSwKIp99xHpGx5nVekfI2
X-Received: by 2002:a05:7022:b047:20b0:1b2:6855:997b with SMTP id a92af1059eb24-1b3b5ff8c21mr129142c88.25.1794244924205;
        Mon, 09 Nov 2026 09:22:04 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b54431sm285869c88.17.2026.11.09.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:22:03 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH] ASoC: rt5659: cancel jack detect work on removal to avoid use-after-free
Date: Tue, 10 Nov 2026 02:21:55 +0900
Message-ID: <20261109172155.1851386-1-hj351016@gmail.com>
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

rt5659_jack_detect_work() runs from the delayed work jack_detect_work,
which is queued from the jack IRQ handler and from the jack-detect setup,
and dereferences the driver data via container_of().

struct rt5659_priv and the jack IRQ are both allocated with devm against
the i2c device. The i2c driver has no .remove callback, and the component
.remove and the .shutdown callback only reset the chip; neither disables
the IRQ nor cancels the delayed work. On unbind devres frees the IRQ and
rt5659_priv while jack_detect_work can still be queued, so the pending
work then runs against freed memory (use-after-free).

Disable the IRQ and cancel the delayed work before the chip reset, and
wire that teardown into a new i2c .remove callback so it runs on unbind,
mirroring the sibling rt5682 driver.

Found by static analysis and code review; not runtime-reproduced (needs
RT5658/RT5659 hardware).

Fixes: d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 sound/soc/codecs/rt5659.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 0000000..0000000 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4319,9 +4319,18 @@ static void rt5659_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5659_priv *rt5659 = i2c_get_clientdata(client);

+	if (client->irq)
+		disable_irq(client->irq);
+	cancel_delayed_work_sync(&rt5659->jack_detect_work);
+
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
 }

+static void rt5659_i2c_remove(struct i2c_client *client)
+{
+	rt5659_i2c_shutdown(client);
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id rt5659_of_match[] = {
 	{ .compatible = "realtek,rt5658", },
@@ -4347,6 +4356,7 @@ static struct i2c_driver rt5659_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
 	},
 	.probe = rt5659_i2c_probe,
+	.remove = rt5659_i2c_remove,
 	.shutdown = rt5659_i2c_shutdown,
 	.id_table = rt5659_i2c_id,
 };
--
2.43.0
