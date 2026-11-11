Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380184;
	b=Q7TPDC1kMzoSwiglxFsxA1VN4tO+IInb8PygnZO4xv2D88z0BnCao99rCCOjPGI6aMCe
	 2nf3+HO04vVesMnM6IQAxwbc/n74mapMnppq4ApSf2Wtyjil20easuvZft+1AGY3zBsNr
	 ESkhOA59GQzEGgjBo8m5uVIsrOX6BhumuK9Kevfhyagf3ShnNVPWIPuWo1cMAAMkRC73/
	 iW6qWvSONnvq1zgt9SlAnIt+E0UsEA/SvDR+0HzJRSV1Y4NIULQGWSgEmrQLPudPVxvSK
	 bfkJqp1hNqBrJiWmJaldgpJC5IviNP1K3hzjYa7fI1eLwkhU15WwI7wndwEcDY269LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=3WwYpXODrollnKl9doC+Ig4NeUhbbvobPTJNo/DEkIA=;
	b=JZwzShZWqPSwFvnBuEKeXE8+qM547akZ3OHvRA3fW6yKuarI5wgUTy7DhADXwsk8jibE
	 y9UviftOzpQP37NGTmzPkRVBIiOeQZwln0Y4hs4tRC/CbPLI4Adk7Pd/67LlFoZ+ftM4a
	 YVbtq7jrJjuUrIe31Ro+YevTZRyGJPgALGZegOMexsQBsbSDJnrfIWyXt75L8Oq7GlLsM
	 tT7nF1rOhF36LlQXlYvihgYzMiBAO/T7kZ4rSW/S3ZAqcJ6dDdMiULjR+Q5Ccap4TVoAa
	 T8D7qkG9y+ciZU+yYXOThKnUv/tbMbf58xFJ65KvAXrj0bCqjYRdPGv6vUeLvqRXKzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXCoiDdt;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181F60A260D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5181F60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tXCoiDdt
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1aefd1bf74aso2393500c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380183; x=1794984983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WwYpXODrollnKl9doC+Ig4NeUhbbvobPTJNo/DEkIA=;
        b=tXCoiDdtwAe6e5LUqM+TZ75gFQdHTToiQ+MlZ0X2R+n8axPdUzIfrYICPYBEEI6OwY
         CZbY7ZHZ/KgvSJA5pGAueBmb2KzqNqDz1pp3hENzwfIfifPAoXrTciODGpLS7xmM+AHJ
         7VneEbNUUO1V0bglyx8EQgypDS79Bn+T/5h1MdqOUmst/q1mnAJEd7FkuJgJpU5oEbga
         oY+fGaVQg9cRGjfjJXyIjYC4EphH55Hx/JYpas2S/KXUsR0CsM23QL6D9I9T8OiDRPYD
         DQNNhVg1Kem98rXutd/TcsMs7TDhabTrhtwVL9MW/GOP3XYPAE098HPv6HqZbD6GAbA7
         z+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380183; x=1794984983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WwYpXODrollnKl9doC+Ig4NeUhbbvobPTJNo/DEkIA=;
        b=ni4GHbJV2pqNvJVCadSAi7wo79ubwAmCSqdqp7ghz8Lt9GljiXKCOBT9ZdheovOUzs
         kfZ0KtViRYGnWG4rqGLUGnV3d8PR4oMKHQnK6uNsc/dkqiz0DsTHJeeWGqvkdSLfxZQh
         ft8GDIfXTWxn6F9nxB/r9fKFUBMLF9giS5u44GU90FUdC5xI5AewRujm9KiVXOPfiWVm
         aMNp5N5ArDV5nZp/lb0sVmH1dnr6DGtHKym0LO4RS5nixky/HLPCHykap5+HtORNQ5gM
         ERKFbz8R5DI2fqObw+8homs7u5wQegwF5TbEaBDJHDEyDJl7qhNvzLbbhHq8mt12Tj+3
         tPYw==
X-Forwarded-Encrypted: i=1; AL+hErGSXkYsE9DeQJYfBt0DGBsuBP4sDwWC9qfouK5O6MXt6+4z4iRt5OAE6QSHI74NzmswFMCNjgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2p8bxGjo0MBwHJO4gwck1yJ5HGu/R5YbjxKAj8JXGUSBNLpLc
	aakV1QF8dILcaPgqPF36QtcIW6a0IJHzTBB9Nmx+W93LM9sRIGsVJ4Yj
X-Gm-Gg: AYBFou2SdL5qs++QRO7q0tP09aCzcO1Ncyek3Ey5xOO64eynZ35A65hslPJNdK4jr2Q
	Lb/WzlHAo6UMIow3iEM21nx+u0l5TcLLeZ63hitfDXiyCREl5nrIdNSyh4QvXdFUwT9KX1SHxjj
	VGnLXKVp+Zh18azgG6RSfG2fnYrmyGs2oQUC8pho3KUzru9DSeaApSdw40iYHhNLIhVul85DlDQ
	FcxuYKI3d4nf3+y3fTJ9HrKCRGXa0stqmI9IG9XT+AvD8/ALdgu7mGWWSPTEsVhRMV2ZSGEmCjU
	RDAmbDlHXyDMZYZjwAs6koi054goatR5ywhV338QR4pnNh1EJm3N+QnO6HE74CL3EI172kKwesS
	NtFMfwX+0YAbuY6gZrYjZdG5/T21IIoKnnOt6ouCAmjUD/5vfYPjezZcB7POkwkJ0hGzbA5GIOv
	tXAzHSBFSvMlB2id5apBBDFZuggS9WhATd+cYEoWQSP/mkhNgRrIDVlZI6A9ZW/uIZ/SRdF2j18
	U4Zusi6xU36agXlKurDXxsbocZsDhJwO/QpzP7DSMEdfMDG3K4SiYssVY8fu7fxjBZYpDOL/YDY
	LzOkUnnJBmpD/jq5Q92iflFckQ0z/09+LF4b9XnafDEECpKmakp2qJGu5SffS2nnpbqLelJngPp
	OqZiG5kZBOIFaAHY6Tg==
X-Received: by 2002:a05:7023:e41:10b0:19f:cc98:f603 with SMTP id a92af1059eb24-1b3bee81671mr2167785c88.1.1794380183087;
        Tue, 10 Nov 2026 22:56:23 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:22 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:00 -0800
Subject: [PATCH v2 02/33] HID: logitech-hidpp: use GFP_ATOMIC in
 hidpp_ff_queue_work()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-2-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Force-feedback playback, gain, and autocenter updates are invoked by the
input force-feedback core while holding the input device event spinlock
with interrupts disabled. Allocating work items with GFP_KERNEL in
hidpp_ff_queue_work() can therefore sleep in atomic context.

Allocate work items with GFP_ATOMIC instead so force-feedback commands
can be queued safely while event locks are held.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 85d8d168ff15..d9342a3e8122 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2542,9 +2542,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 
 static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
 {
-	struct hidpp_ff_work_data *wd = kzalloc_obj(*wd);
+	struct hidpp_ff_work_data *wd;
 	int s;
 
+	wd = kzalloc_obj(*wd, GFP_ATOMIC);
 	if (!wd)
 		return -ENOMEM;
 

-- 
2.56.0.542.g3ef89b7020-goog

