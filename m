Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670043;
	b=fymDpdfyyRHQSrJW4G1uuUTIVcpA++bXZZ1pvTsFiEvXnxUJnaCI3nDzjWl7L+XWIjib
	 GKKY+XiuycEGHjm+whGsBF8GDDy0MD7/O84vwYDsUEFwW9pu1X5RJ/8jGSQ01xRYDj8bh
	 rmB9wKf+C57q3jNohEWeTpsbAKOyb81Cekx1ykWzYK3xotAVPwlA1LTvZCOm5qWRs9g/h
	 iEcnynZM1SfI53vgtYs9J9VJSh6FTHsZD85PO1WPNMrcqcKo2q7CfyxFBT2EQd6ztiL15
	 6Y2bphfmW0bslt01cYYY0smZzazb21XEcgdANf1qbhbYVPlhx4P3aS6+cy8d2fG7HMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=FyyeM869JQGmn6ws97WbWxLYVyUrdcmnI0jr9iIidxM=;
	b=t1poROiZ/npH2RmMN98TzXnEXhLdg5RykMCuC6YJdISwlj8G8D+oaap/u9UcOjC21sYN
	 dIa4UO0ZGttOXOyRE25S7TQa0YuJf6BNfO7eyk/Paq5mqERREz99F3JEs97pvckEnBKNC
	 IU92UBj2cyEkUwBDJ5UERLeWSGM9Kf26cvkZ+zSjMn9q9QmDMUFWAix6lJ5UO/b8dJzra
	 QL9mTAhzgVW3R27IRg0WU0MPSlZQRIZng8aelr6WuR30UT/eBatlUklnha2hj2f7HLgET
	 Ww56dI1lts4BLQigbBwJMB+wIMRne3Px/iw5EL2gS4T3jPJl0Z926OjD7bTgIh1rwXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l03uAgWH;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1B606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D1B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l03uAgWH
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1482439f8f.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670042; x=1793274842; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FyyeM869JQGmn6ws97WbWxLYVyUrdcmnI0jr9iIidxM=;
        b=l03uAgWHLzkTBGKztx7BzXAucj33IonfhHxCDC4LESOGhJjOOBbyKHo8DfUkN7oqs1
         KftQWIxGAHCPQRuHdaBUw6zI3BiRCjYcCFZp7DoLD2LgwYaYGOBmVDrjvHcN3yQVY/kf
         FWOtkfrXi5zrt4kpQgcUM/+Cnd2AcrINRSazztidY5aJD1tT4SKoLBXkjD+IOzGSBvNB
         S4Njq/oCAst1KImX0+1iYOs7M7oBXf+24tu6W+Rc40qJ16rbbUe5w4Tru/456waL+xG5
         zECcdPA+1BWBK6dIKl9zHUXoPoaL1Nc2M7cg33zbDv1afsG9zg1ljw+d7PED7gVTMovL
         wvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670042; x=1793274842;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FyyeM869JQGmn6ws97WbWxLYVyUrdcmnI0jr9iIidxM=;
        b=CUzgYgd5rABiZBJ9V0KGHdGdpwKTg1SHWC2NytfTvYF6i17WZ1mEACSMFhe46+JZ4E
         YsDBI0LwTVbPZ4ow9dx7sCnpb1dyAMG3xLCl+Wm4G6CNRGzr/FNp4kvfF8ox805FiTgR
         rOvlIa86gA0StfM2ZJghV7yQu1UQ9VICljA4Ooahcs1e7sIUiXcDZ2sBHj/kB5O3YQoZ
         P6SqDWg1CjLJJTu+H0EM0oHqfTUrVfFQwW8OeDnyYc+pEFH3bj2Aq2PBhDGwKfo98RXg
         5iJ12ClRkm9teFXslWgPHOvdH7lDDPJ7jmRnhFm49WBseKb+mGC95AACo6wLv2NTWexU
         +Heg==
X-Forwarded-Encrypted: i=1; AKwUvBzMmVH107JL0vypYQVqrrJjK2M5HIlKSp7WzkqsZb3E8a5oJ0kPymszaTV8CV1k4bpnPRQ9pvg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIeW6zy8rFdtlvT30HIRWMAhjdHRCbEOXyEg4z+VNwYZmzQiTEO
	Y9y/nva6lwVE2lEb+lYdcqA2qQiO/zGmfYbJ9+wSQRrZx/DbvNwvKljX
X-Gm-Gg: AYBFou2bF1gfO7HGK+aGuBHxXJR3f4yi3WTBIu3gY2E8uQijog5BMRpA9QZwupu43Mf
	hAh5BhDKNkDR4tNNQls3R2HPqS/WLYgTAdx4Nb0hf2rNEwP7eYM26p+E2JY3iEJIVb+hNhFF9HZ
	eZ2O/kiaKPCs+3HHCRUJfhweUJQhkVYTTUuXGgGW6CJUKg90QjiwT4KMOYBOrOPTMxbIaBVAdQe
	Ibs8Z7K+ElOLt6vsfFstGUEsjkEL9HJhWDUWXKMWbbMBs/bSo/nOKOp7ZDwBp3WALa+3PTSljM5
	t0jhSCnDZSBH8vOSHyIQwjvXKOBVok+R7xMxo/w8FfEmFIERiVTBk8iET09gLlugvQbidOUIv14
	eBL9VcgqYGRkXIrF7Bspa5Qxc0hS9Os8CtZedMv/A9dBfrwyCyhuXLZQCw2kmjPFvqOxe7om7+X
	u0+7eE5U8Zwj/aFzQHEDmbya7AaJSyNqPzpRLxaclLTAqu0/06KMd8C3T9ipHOKV53liTsO3NYw
	MnZvrjGbqSTJrsQyew0Dz0NOz3QAyTpy93MamBHSvJp+CpBn6bd2/Dwbw7ZAoHPpZWwXkDYNl/q
	WJ7uFk4GuA==
X-Received: by 2002:a05:6000:1184:b0:488:8384:c382 with SMTP id ffacd0b85a97d-48e264de064mr7813323f8f.49.1792670041474;
        Thu, 22 Oct 2026 04:54:01 -0700 (PDT)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm11720004f8f.23.2026.10.22.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:54:01 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Subject: [PATCH v3 0/4] iio: light: tsl2591: fix lux calculation and
 precision, add I2C ID table, report saturation
Date: Thu, 22 Oct 2026 13:53:56 +0200
Message-Id: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2NzQqDMBCEX0X23EhcayA99T2Kh22MZlv/SFJpE
 d+90UKZ0wcz36wQrGcb4JKt4O3CgacxQXnKwDgaOyu4SQwoURWyOIuWfYhipmicwFJqbZSU2BC
 kxexty+/Ddqt/HF73hzVxV+wNxyFO/nPcLbj3/uYUVckcK61Ri0IYpudC/bUbiPvcTAPU27Z9A
 ZOB7EOxAAAA
X-Change-ID: 20261014-first-patch-23099c6002da
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>, 
 stable@vger.kernel.org, Martin Triska <martin.triska@mycroftmind.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.16.0

This series fixes several issues found while using the TSL2591 in
company products (Raspberry Pi CM5) and when testing (x86_64 laptops
with MCP2221 USB-I2C bridge).

The original field report found that the illumination value has always
been 0.0 (caused by division by zero on ARM).

Patch 1 fixes divisions by zero in the lux calculation, which occur with
LOW gain and short integration times, or in darkness when CH0 = 0.

Patch 2 adds an i2c_device_id table so the driver can be matched by name
(e.g. via sysfs new_device) on kernels without CONFIG_OF.

Patch 3 makes the driver return an error instead of a bogus value when the
sensor is saturated.

Patch 4 improves the formula for calculating lux values to make the
returned value more accurate.

Patches 3 and 4 change existing behavior, I am OK with splitting the
series into two, if that makes things better.

AI assistance: Claude Code (Claude Opus 5.5) was used for research on
sensor behavior, datasheets and Adafruit library, to compare results
produced by old and new formula, to draft some code for patches 1 and 4.
I reviewed all of it and tested it on x86_64.

Changes in v3:
- Patch 2: Fix commit message, OF-only drivers can still be enumerated via
  DT or ACPI (PRP0001), only matching by name needs the I2C ID table (Andy)
- Patch 2: Drop Andy's Reviewed-by
- Rebase on current iio/testing
- Link to v2: https://patch.msgid.link/20261014141650.259929-1-ciakval@gmail.com

Changes in v2 (thanks to Andy Shevchenko for review):
- Patch 2: Use C99 initializers
- Patch 4: Keep variables in reversed xmas tree order
- Link to v1: https://lore.kernel.org/r/20261013143943.436816-1-ciakval@gmail.com/

Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
Jan Remes (4):
      iio: light: tsl2591: don't divide by zero
      iio: light: tsl2591: add I2C device ID table
      iio: light: tsl2591: report saturation
      iio: light: tsl2591: improve lux calculation precision

 drivers/iio/light/tsl2591.c | 58 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)
---
base-commit: 87e28db23d0384f3995c43ecc5ae2118b371edb5
change-id: 20261014-first-patch-23099c6002da

Best regards,
--  
Jan Remes <jan.remes@mycroftmind.com>

