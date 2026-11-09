Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204670;
	b=oWGMrqEVxVELgMNtiCv/XAh72tC4QIoM8WRLGk1Y5kicXxGpUqKA9kuzsuv/5ddR/Dyb
	 O1Q8P2+QMJELK/tutRW0hfEa7aQyZ75nSD9oV+pdMLmPeiX1RTAnhSWZspjcX3kZJ97z3
	 7UBra2gbeLoHaxSt4Utd2NBInrFiEUGizHWYy5pnHZ8az2wzajbWvjv2C1mN8pAR/hJjN
	 TIAslQBINv/z76B5rtYsdTvDykUFlG+4RfbxNbn/BCZAFjbVziA6MiYBlE/69JuATdMtr
	 mky4YH8/hlQmpWc506QZhQJKgnRcGYuZULZizMKg1boPEWdcSb3D1JPFN1rCyzUSR6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SHjqr5HyPYfvrMsyfIovF4S0TyQhn6m/GOYAgfH2pZs=;
	b=dUi+f0TNnt0s8OrXzH3Yg5AvlRdBmhSOL1Q/eMQAKQC+hW/yQqO0j694lVSJEf9ahNrB
	 zPoj1Xlqo6hcN4vmMofWEMf5nvhq+fW6jGDxA2j2rxrE+Di5l/yivTyLnKTYWnAmrK+Kz
	 DbjtAPdOjFjJaqQRPX+QqxPH6H0BJcj8cPST45X7DEAvdcNS1WCAR1VBksHhIOIAS9M6w
	 iRrwricFNdN40cNA6QYBKRYkIOFRgPpsm20AbELo3zA91hzfaXAXosm52SJr5AWrA6y8P
	 LvKYwq2e1L2YGxOeZi6sac1mcZWDkUiTj2iFbx3ZrYYyXyek/JG1hagUtD+hdcpb0Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q08c1eXv;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164CB606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164CB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q08c1eXv
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36f6295304dso560255eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204669; x=1794809469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHjqr5HyPYfvrMsyfIovF4S0TyQhn6m/GOYAgfH2pZs=;
        b=q08c1eXvQtmYgarguocZ7+LNJOMZe8a9nkncbRV01G4Bd6itebPqLXWs2rz9Z+aE4J
         mNYn91zQNXGndloIFG+FUOJdsHcBwfugOFQxt1IjXNiSJzDkaG7GB7uqWmt760hl2sEV
         xs3eBk/FxIq3qytUXlj2gB4mh91Tljvw1RLk2q/+W3y94BozIjvGhDesvMVe14/x6LOJ
         XKbQJAXYMWx+D1o1eHioZlvnzyjynWdZa3ds6AKKP59AioigfP/if+TYKROPzVU0THKf
         ++jH3GMYmkRR7Pxtkot1go1t0MhKFIDH1jn+ADwwTlH7BhJRO/azo+qOkDvLxYMAfYU8
         9ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204669; x=1794809469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHjqr5HyPYfvrMsyfIovF4S0TyQhn6m/GOYAgfH2pZs=;
        b=DtDXTFViSdhJKk3fhi+6VPR1tgMn6KdnQ6odMBI/TQQK5YyZc3melnKW5b6QhTDtfU
         B5KtmKLRjdjM9Fmup2DNh3UIk9YdbQwFwNI3qu32GIW3n9f6FCTmVPZdfRxTKYNpdjO/
         Sruq13PuFJDjEXerY8aKUHX9uwoRy9iL7fF7sKHowRkVJu9HIEzQPyEPhjIpP+41A4ke
         Jg9K45Tx2Mq9u7LQHwswAxJWSQTIONHayo9E5XYq9oDSgg+BPhMiK9LjRko/16h4sri2
         +dFxYI4J/iixcolxZ/sjcZaTQKw+MYHJDI7ufyH4Amhu33WiyZIyqiWffJwUW9xcev7H
         xXiQ==
X-Forwarded-Encrypted: i=1; AL+hErFk/HkkNT/ZzNiZ0kGrTkvKFPEz3VKENcqcCFHxmjA8G9JumJjXzk1Op5fd4xyDRBi5qkbAf9c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8k+PMs/5nWwxep5D2xr2C47dhLtwKP0GUxAFJ/jKNpdl+8DYJE
	SadeC71wwukGO8mhurjty0SfSBVAmB25XR3A7R0yVllN8bNETtw75mWW
X-Gm-Gg: AYBFou3bNS7cvslVjY8o7T9zNmOegzPEoAoKP3jYjhoLjUUwCEcboxGPo4MKCVdEHJu
	8mOFLa5m4dOwut9Et/jYr3sIYKOKjIUaU8e/eCdK+E/02raDt51Hau9is9rRmEyzHOvNZN4Ybjv
	3zAqrXr/TR63LZCGqCrtfrUShlfggymlg9w6obs5tiSMtyPKi5LOkUsShYMZxMkcJsL3Hh28dMy
	kxeey9lBTFG5J7cXGKTHRm4dYRA1LLC8OhLS0iU8wmSFZ/mKFZAmxgpb4WvF1vbDizB7ZOQOm77
	bgDSS8JoxxPzpZPlxuVHMngZOjyKSqCv+EBPWusYvG0K5akrUaaRGkRFch7AGVLHqX0LZWT2VnI
	1wc2nSJbgl52+Tqq4GK6XtaemhCcUNuLM5mQs9dinWYqM3mNhfGR81O3CA5vGu1bMb4FFP3NwFN
	mXyTKo7nkwd+7a1auuAtUEWmwtktrldELSq8GlWwE+bzG5qv4A6ArSgeD7IC1AmzWUsuEYh1X2w
	Ow9lKk0XUVUtSllWS1kl9vTIJxU+oI6EKoUonY91vh6+z9R3gcZovM4kMmvOJALtIE+m+tvz60a
	QdJgLMGInj7q8x7D5CQcaPu5hwsiUFWBGVD4NuZiAJMhh/TK5RHVeWBvOgHA24bVD+Jap7rmU8i
	2N8lHOaTbbRk7yhxA
X-Received: by 2002:a05:7301:fd04:b0:36e:c07a:426f with SMTP id 5a478bee46e88-37257aa83eemr5915584eec.39.1794204668922;
        Sun, 08 Nov 2026 22:11:08 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:08 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 01/18] HID: logitech-hidpp: fix G920 force-feedback initialization timeout
Date: Sun,  8 Nov 2026 22:10:45 -0800
Message-ID: <20261109061103.2887636-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Commit 544315e40172 ("HID: logitech-hidpp: move FF initialization to
.input_configured()") moved Logitech G920 force-feedback querying and
initialization into hidpp_input_configured(), which runs during
hid_connect(). Because hidpp_probe() calls hid_device_io_stop() across
hid_connect(), incoming HID++ responses from the device are blocked
and g920_get_config() times out with -ETIMEDOUT.

Temporarily re-enable HID device I/O around g920_get_config() in
hidpp_input_configured() so the hardware configuration queries receive
their replies during input setup.

Fixes: 544315e40172 ("HID: logitech-hidpp: move FF initialization to .input_configured()")
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Closes: https://lore.kernel.org/r/CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9646380febac..6b1f55483385 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4098,7 +4098,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 
-- 
2.56.0.506.g506a7eabc5-goog

