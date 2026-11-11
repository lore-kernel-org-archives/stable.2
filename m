Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380195;
	b=G6PwuedeGRWdZw80kTQtH3uU+QerQzxH2T1Yrre9XXpQMyV18FFkaOuaw8tK2gu5fehj
	 ydkTVgOIjEZty1SvKgSJDeelJZcn+poxEXgvNkEymkkI1yrtmcjBx8ddIbmucOTAPwQoe
	 2+OmYBHsFfCiLEmu2bYPH7UhDlnabcL+G6nWnVk3pRWvb2sbb78h/APkh1N+LxGRWH86p
	 GyrKAfbnPK4oqs+4pFrnCM34LVJOnnutOE5e4k8ko2WBcUmisx0MK/7S/y3n7UqbB5AAH
	 wt51kH/3I/HuznEC4ZlCILP8MTRh+/Ma9sB+gK+eYi0xVo6J28Kve3ILP52M+DVsG3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Z9ELgWrnKOJFPKZ1wGUXM5KOsvAyrSgvZfnwz6BGKEA=;
	b=uosylqlc+9cJSrPSAprnf/eUlJC4GJn65ajrYqJyhrZFy4kxnNzC1AqASHmHLFRJcbdl
	 Q60Hq44A3uNN1IdVsBfqfyaf6u5RlBwwfUm4sEABjnJTF6OKn356VxGfNlkaXVbeKi0Bv
	 52urpLVIyOu6x0k9oRjOZir0JtdT996pOyWRlYMeW+cnyL87O6surLp8Lvz5Q3VkDtPql
	 QQ7R/ET3iE0YIV9oaUvrmEuRhxeuLoTmb+jYUsU/INubMjHHc5O1v1gPjN00sgp8AXXQm
	 vJ4BWpcCw/qCm+nERXeKGYfDUO4elSusIhvxDjs/8wys7C0D5RyU04Mh15w5xG0ft5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alDg0Nkw;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7160A260F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5E7160A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alDg0Nkw
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37628596783so1711812eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380194; x=1794984994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9ELgWrnKOJFPKZ1wGUXM5KOsvAyrSgvZfnwz6BGKEA=;
        b=alDg0Nkw/Goh7tkzFfaMY2tWf9hxbbeUgJuknoJjkC9RHcCOsi5Tj4OduEHh6okdZe
         vQbUMgqpB9uKGBfVWNE9LREmlO4f33LRHjpnqPi3qFC9JmEfWxgDvuDuqkZA6di5HG2L
         +XO5DJhq+GlPLq9OoJy4HkCPEJu1rDsMTT8ADXuAw2sZZ71R+UUxOmvJtYukgcvrwLYA
         +4LZE8ZjATIpClxMTVruGIbHi5XV6yvTCDQYdhFswqf2ThdZ3kudeOWsGRDqCPsdymHq
         38Qdz9UkFc0eLh3anBhNHh3UX51cV/efXNIjlLckYBYw3e0OF2jsaQPfpHGBzWe2NwAH
         m48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380194; x=1794984994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9ELgWrnKOJFPKZ1wGUXM5KOsvAyrSgvZfnwz6BGKEA=;
        b=aANs8NgHaC7ieGaZwL+e81sm/oeLgv0fkgqRBh6iOT5WjvNqPaUdFOSHgz7143x4kY
         fkDpZ5UodklzZ6gplstNLL9+57Fkp1hlcgV+/2QGtgx0WPFFhYM/FJn6Wfi38LBN7Izy
         r81YP1yrp7rUF+00pIpBeBxe+JdeiID/9I9IZIWyCQeUho17SMsXCZJxMSWsu0NYA9v6
         NSV4Sy/1OiUAYECWtoaezlgFzr7KnaSnLqd63tr/Pbui3wyirNaSdtXSRC+WstOOE1D9
         YfGtN19kOTWHc+TuFV/3SumB2TyUTdz4EagUXq+ZxG8EIUys7dntL+VjZXuwmX6FVXb3
         w+cQ==
X-Forwarded-Encrypted: i=1; AL+hErEhP07pdVLkhnCMdHPOpC4+/k+XgIlwUWYFAUmzg7rX4Ibi6H7s020vIOL6hzT+w2LY3gZizAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U1v3ujsTj21R11gpYe+ZccMfk1MDbqsQyIgm1QiEbzsDsZ0B3
	IH2oggHDWSam6RW5uxllJuh7EhBl3tdKTo4i4rrWApXudIn+3TPrOJ6N
X-Gm-Gg: AYBFou1c4ojYWCgrWW4pRQf8k9sxeCr0P7IXTnsDpJ9D+yh/Q6GdgzuVPLWoGmRu0Uu
	KNgIJk5jVMoqjCABQRnYpGT/5gxPnX6oGx/HqIQAYgZkmRRbA+da44B+s1kI8STZMXUjtsu1Kne
	6GTe6oO9aRunQgcu/p5mWXPBBEZfVEvQmke/ViiPeHuLvjUyv4igVSuxT56stKri0F2HVjqaYkV
	g3a3csUioYNrNh8yaMB7+KagjGy1RPXtYk3NNjwxoyew+vdS+B3tJLqoQ75Ac5GwpNE5GJlyYdS
	mrN5zicILqdZdZThZsoSfcKINOxqWbm+TTFKjdu8YaIKLHCCoccHEcu1Png1Z9huMclz59Go/17
	/4WZpQbNx997CLmmakDlEzam84HGWMz8SbAp4aFYtxgQA8B2QytSAHtCUo2nJcewdb44jcPKMRy
	A3dMJRBIP/lPp1rzvh35DhMgxUAdMeM+HE1e1LPYQQksrT+fiz7ZtcUSKtJhSH/LFdLRM+GP/Oc
	ulcSIx75wC3KaCgwLVu2ra2Gk0ShPZKBfW/Y+HRRp0ymts8WJ0fLbnuYcP73ULbihd3zalXCHnq
	5OB30rwG1H0BtnvCIvZ4nT8nyS50YzPHlN3BKxVF0kZcq5U/PyqiQFHR4IeNpaUtaDMgVvGouHv
	uhcz8XU1kFPVs/gclCw==
X-Received: by 2002:a05:7022:e805:b0:1b2:558a:d769 with SMTP id a92af1059eb24-1b3c024e6f5mr1663279c88.4.1794380193835;
        Tue, 10 Nov 2026 22:56:33 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:33 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:06 -0800
Subject: [PATCH v2 08/33] HID: logitech-hidpp: do not retry timeouts and
 transport errors in hidpp_send_message_sync()
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
Message-Id: <20261110-hid-logitech-hidpp-v2-8-30743e91d83b@gmail.com>
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

When a transport failure or timeout occurs, the synchronous send helper
clears the response buffer, setting its report ID to zero. Because the
retry loop only inspects valid HID++ short, long, and very long report
IDs to decide whether to return, a cleared buffer misses both checks and
falls through to the busy-retry path. Every transport error and timeout
is therefore misidentified as a busy error and retried three times while
holding the send mutex.

Return immediately when the low-level helper reports success or a
negative error code, and only retry when the device responds with an
explicit busy protocol error.

Fixes: aba7963544d4 ("HID: logitech-hidpp: Do not assume FAP in hidpp_send_message_sync()")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0264e4541edf..c486488efe99 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -364,6 +364,9 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 
 	do {
 		ret = __do_hidpp_send_message_sync(hidpp, message, response);
+		if (ret <= 0)
+			break;
+
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 		    ret != HIDPP_ERROR_BUSY)
 			break;

-- 
2.56.0.542.g3ef89b7020-goog

