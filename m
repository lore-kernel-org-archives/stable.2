Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048745;
	b=mrAccsdXVBOyrJEL8C0zELn1YfntCQFPcKOUUW18fekshh90CZN01v358PGwm15/kHjy
	 oL2LuNVqRnWw1uoVbs0wLmBOkSI42HfrD1oVDI4DIuBLbFzfyd8swKF5XhVZ0KZw8FlB1
	 CjPFd/O9MfbAq5D82NZ8Oufsi/gBaCU33133H5+2z00Wh1gh9T/FpADaBNS42f4ujEIr8
	 xD0cA/834yRbxJlKLnGhdDAz5Eg/nctKEKkra+lWvE0ekhC608GVDiiWSv+muKXk3R3gV
	 K29ynyPDzep6hYq1uRg4me6cgZZBdPWgEWrhxs8aXsAULbTb4MQNJe1p1UZIuW8+wuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rD32K7ekISuMljF5aUzSzqVha+tq2S5F0ssjFpcpNiU=;
	b=niJ7HWuCJxZCmZcTJ0OhNCTq8D2Da1hEVYcJxuXEWLulStbPVq6fTe4SSf8Jo8b9jRrl
	 Ncu0GuL/mnZnC6Q1VcgsvGGWuT2u5otld+l6g6GK3uQ+wmg0Dr7yvlZ2G6+ZaAWqjMcxn
	 EbJUDK09zKg52c20KVc40s4sKYEq+aswwKe1gJm0vz8+aFFn7qq/8zmQCpbRU57eXi+xp
	 jEdzAAnNXXeqbAg6tZ2FjE+7Q7cWsmlpiyB5WLAvdDejFVOIBdqq2v3QrsnGOTd0lYcdq
	 QJTsRmnDb9H+T8hIVpZRwwJ4diYiMzaF5CLAs9RUEsxbdU9w/g4AQjbMYAKKN4lB07g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="x/O1osm5";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE1606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FAE1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=x/O1osm5
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso31091765e9.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1793048743; x=1793653543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rD32K7ekISuMljF5aUzSzqVha+tq2S5F0ssjFpcpNiU=;
        b=x/O1osm5M7zxTA9jZpysosF+ofFJypdYJ1I154osDWAjKnFrYbUbVVNIvJGGGKAcC2
         In0OXi44NjS3dGcRnDU0whIn+6EZR/bQz0DDCiPpWnkBnrmwKu+yLlf2i765eSxk7t2+
         IvNVOfNN/tpz7PoFpKap5Zk/YOyaSnEp2YjoSxsu5guic+vpAou1T5ajAGW2TqWBUW+5
         OVp2DSxhu9xgSSBJB7r2mxQrM62IXSAf9i/dahZ0qh8bZ18Sj9L5FnA0JGltkWcSfEnj
         Tl1/BvDhhVig8/XdIUgu3ceScuqAvT1KSRZtHBUSlq5/JzFG3p5V9adFW46sMwtBhNdY
         bEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793048743; x=1793653543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rD32K7ekISuMljF5aUzSzqVha+tq2S5F0ssjFpcpNiU=;
        b=o0QxgrvP2wvwiO0ldpZoqjjVdyZU1hHB/s3RT9AKJ5wL7AGJ4Tc3bdaEKU9S/sGdLz
         t5nBWLPnBgkafTmFQuuw0r0BE8i9dpuzD57k4Pw8hv09BLV8y8q3Auv/OGUNPMO7PvbK
         G2ZWALr4v2VKBMNHc5Vhzjo0ZINjFm6sD7H5dQUOSUghEA3tSUxrPces9vTQEki6Q409
         ufZ1c03mJK2WONY2sPgKn5UBgQN3KXuYvwLemIim/Kj2DPoBEEbPlkEVl/mNlCTjqZzW
         rI2gMv+C7Jn8yDig6yf1wrSZTb9ewHWm/urQAdUOP6GTB+B/Zkg3OKL6uyKTQ+9btHfH
         sH9A==
X-Forwarded-Encrypted: i=1; AKwUvBwOEHXtcj2BpXpZO+dSFvjSzYEJMNHpOpWxtcRaIGPQG3rdiwq/4ES8RSMwkVHZ91rQz1wCbfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZvqtYuLZyVwEGoUli9q0o5DLZSB0p6dkJOgkd4bHFsn+aVfKB
	qzddsjHt4V++f9H6/NqHU2wiBMC8PNyXQw9jeO6XN0wTFYIhVMwMmEp+FlWvkZu2ihQ=
X-Gm-Gg: AYBFou2qkQaSUQnmiPRoTZsjeWZopX9Sjj0zKqWt2fsibjIddgYfZy4dbm1O6+eyino
	U0a8yF/h/oAUgAS6050a5kmgmzR9+ran+BtHr5Y2I4y8eNyBm7dT0TpG5M5bGM972chC0kldVKw
	JI6l/14Ln32BE5gmXW5C/5f9bcidhNDOXpRR/uMKQ0AwYSzptJPBZmhTcPl7HEH1WpIirXTfkfQ
	a1XpgyMBkxuI/4rLt6Wiz6cVoAjMumhmng+5iI7OIhZ2srtlL0kGS3ihgH5BrLGWIGHm+Qn5mnA
	7lpcvjxcf/IV538CR0k9LRpAJm1H7jSxUPV9+vTKz3QON2thiOSJHFGqoZXcfxMrZOdsBdSVGAL
	CVjUl43AMqn3QT/JyACLmIFd/0jx0Kz2FtEi9kw0zfssAhp91uzN5Om/3tXPdFjhpnRtA1bB2oH
	1sRZPqkv8x8rH1VwBzI58m4p5e0p3GPzZ+91cNpiC+zq6c6L4xUJcjclzCjNFbaIYy/QNtgY/Bd
	N5xQ/FU5yaeOSkK+EobpKojlY8Vh3Zx9elcfccgbQHm+/2mi1tcs+2d1R9hXDm5GDYCORwS/jEG
	R/ASBh47srkb
X-Received: by 2002:a05:600c:3114:b0:49d:34:420d with SMTP id 5b1f17b1804b1-4a35acc7716mr138556935e9.20.1793048743445;
        Mon, 26 Oct 2026 14:05:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:258e:715a:5648:ed59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm258646975e9.1.2026.10.26.14.05.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 14:05:42 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Paul Cercueil <paul@crapouillou.net>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Matt Fleming <matt@console-pimps.org>,
	stable@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: jz4740: Remove the host before resetting the controller
Date: Mon, 26 Oct 2026 22:04:27 +0100
Message-ID: <20261026210427.14728-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <48976ce134e26877200e8e1ef8d3f5c66f4fdcf6.camel@crapouillou.net>
References: <20261026083323.12301-1-olivier@mgcrea.io> <48976ce134e26877200e8e1ef8d3f5c66f4fdcf6.camel@crapouillou.net>
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

Hi Paul,

Right, my miss, adding stable now.

Ulf, could you add

Cc: stable@vger.kernel.org

when applying? Or I can send a v2 with it after -rc1 if you prefer,

Thanks,
Olivier
