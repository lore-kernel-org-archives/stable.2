Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576878;
	b=xkNVTFBp0bWZ06xM/3y7pony9pZp1Ul/+bona/qmQbZ08M859AbFkeQ6cmy+hlD2LdBR
	 eE+jmwOte8OgbhsBZGtLCqpyjB652LI8ITZFsd792iBsF4+dU3C2aB5uITBuPU59/o2sa
	 q190E/oUtkWoHTQiU0HhibGSTI4QFiWZqjUvVmPfPJYQEXRmYx8F26vD9/YJpGA8Nc2xn
	 K7XTZQJSvLpxKgfRaA/Fo2hyIh+jQN4Nnr00xpg1B0BwA+YqH1/MoYcAQO2JNi4ZGwWFD
	 Cs7sb5hS0U+1BQ3sHwo9O2aIQV0rCky504iRJtempAF42BXe0nttmbngvSzvnSI4G4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RVJTwN159znt8hJRBq+zKCr4Hg7h2qirYM0EqJu+lc4=;
	b=YQSXZP9gHvZiR4H7NxOERSnbIJpmk/myJFqecMH7gRbkdh9jFiwxbvb6peIsLz1WUp/h
	 JcFbs1rJL77XGRUqw5WQWj4BsEFWmxtPbcXE3baz1unU252O1Xe8EpCG/6eka4yzGLuJ7
	 9CO7f0Qfqv9EvDW3z21cgbsE6dD5S3Ud33za9g2KxBLsK1I7Cwdeau/J/kkPHRmz/Mady
	 ud+o8N+i4xAPeZdK3QzHaA0l5tSPf4iQ3ZBHEMB8zhDgUISUN3oEhMSLbzT0hWxEa68pl
	 DO4L3jKOX/ULZvWMxV+s4s/RMf7pdY7SsL9B70fekbkn52OG3fTRhKE33hSyiDfTm/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Md4AJRPq;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013E606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3013E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Md4AJRPq
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5e7834687easo91982e0c.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792576877; x=1793181677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RVJTwN159znt8hJRBq+zKCr4Hg7h2qirYM0EqJu+lc4=;
        b=Md4AJRPqTd6XcyhcJr0pjgBw3QByVzkZMaaXLEPVkqMKkphH/Oj9O3NJ63bJBVmpo/
         qJRSZEaID43R45Hdf4XmuYpAMYDJyyHWnspl0iDU2+gmgsn2rDOrjfwpMTYXt35dyxsO
         nxhdY7dWusvN7DYJS31pRMSVD/wdEY9PooJyKK3mbgniTD+liPMz7cIqZfrWRZKKVXoP
         9yl1oKHb5UCCJP7oNistdgdGWN3RQrmEE8HCVHJILFjwBn+1rrTSBX1haazi8cPI0VaF
         M43WpJVIYk1LHGfTUFBWuxEHtB9U9CUyq4OYukx31lPRUYLTu7qv4n6TF4qpN5rLmiG9
         //IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576877; x=1793181677;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVJTwN159znt8hJRBq+zKCr4Hg7h2qirYM0EqJu+lc4=;
        b=fnwLBKPhzUPKGN/Tz6MqQjWVCgk8O9oCj7a3h9fJKZ8dDePUU4+PwwankhC984w1Sn
         wzdtZttMix9HTruuH6O7vFhWvg0G9x4WYBAh68my2Ftu46NEqZITysBPqgeKMJPI2cS1
         RUY12d8SaVnvr9Ry0TqrICO4inG03bL3PHwkLcRwxd9ELeun/qGvT95AkZaksDkuHPIC
         VQ9QZ7tcAo4q0MvgPZXt+2X2jmGRpHYkPkeA2OoAKR1aSdGSoJnZoljJEVcp8jSWhtmF
         SXtL4+onas6I8dtUlTXaw6kJKM3opZiR5eGVg6SIWxQX1HwjAhag3BFDQBXuKKmILvwP
         raWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxH2+V6TLeqK/nD7U2rnxYs0FT7w440XAvS58PBcA7JOswKEYRgCVu7hCf146e6A9SggL6nyNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeoQRiOnlratYkkjs5KGbP+cotqqGcvySkiYA7rvho64h70u+r
	Ui0WoHhwRlyCxOFmsDgJYV4r/J5VLFffcCkWrLTWVkwIEUXnqOFy7euk
X-Gm-Gg: AYBFou0CwBhwiFltm/lLcrBxnO8Nn7sN4npncB+uZCRmZTj/DTbNo0i1acWiuzFYFy4
	y0ioBPy3BsojUThrNk41ymWB9+qed+ncn8h38ixYlNYULRv6G30hJqpeoPChsEjSoE8nbUsgRqv
	BQ4pj4MH7/iFlKd7Qg5xM89tocCHwVJU/cgEW5de6ohi5BMZjbs9/3iersXFPftedZXe60bZfZB
	5MT2b2iOU5TLtlIIUFQGJY55sKtAuUoYmz62bGE0rbF+GKGbHW+X/WcE3hOelbQnS9omjJ2c1jJ
	/MXJ+jFciQID3UReC7dXmDdM0JxwV3vvStG3kppeiJf2oVu8Ebl5NQAQniJLNMFw6kmQOS3WBfw
	KBEQfGsJx8r9h6k6OLdwPBQzgNew8ZE3l4nMIRWBXknLJmHnDssHSUXjXe++rsfzBC8bdftqs9t
	IBcbq1w+rBBTa2hIxpXkb29Tz4daH7gwL5dbyTX6kXIUP1nK6tM0xc+WyE/m5GZOAlNKhMESS7x
	4OTeKGhiVbknqhSMA3o1KhF6KRA/AycFvNHsAV74csVwMcfcDkRgewib1kSTeniTpVAlFdPtasn
	M87pY8qTigdiWXc8ClSPkkzK8L6dpvGHVXJGTLe+ZSYpFzI7cXvI2V7Hyv17IyM=
X-Received: by 2002:a05:6102:4187:b0:7cc:776:6c41 with SMTP id ada2fe7eead31-7cc9273dca8mr461720137.22.1792576872539;
        Wed, 21 Oct 2026 03:01:12 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d118d522sm2526812241.10.2026.10.21.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:01:11 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Wed, 21 Oct 2026 07:00:49 -0300
Message-ID: <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <athe0QikG2mzCAtd@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> Right, but have you read my second question in the above paragraph?

Sorry, I missed the second part of your question.

If I understand you correctly, since 8250_dw.c already has the BUSY-safe
set_divisor, you're suggesting that it should have the matching
get_divisor as well, instead of pairing it with the dwlib getter.

The dwlib getter would stay for the other users of dw8250_setup_port(),
like 8250_lpss. Is that the structure you had in mind?

Thanks,
Vinicius
