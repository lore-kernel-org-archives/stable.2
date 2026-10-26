Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024445;
	b=40bv5ZbWhpu2fPb0Sai/FHjJjjfi+IMAi37xNSAqg7PF5Vrd8Ifp7aigzP++Elemr/Ar
	 7xabJFKH9QxrzStsc+lt4/LYldDNDHnbhkKaniYaMXHMvZbi9S0gR4mEYr3VFJAlflbxI
	 zrKUQMpmu6qZv38QBbDJui1LM76AzKlXL5cs6FiNjbmnJ79RpMfU2l4M2PlPurTRRLoPD
	 d3Th9kz4LQODRwmFz6kUlBaBFxlcmSxgICSRWI2zfhkmc2oeyYldIl/qRys3Nr7beQyGd
	 wWWsgKYsgonGIILtGTNUjSLpqWv9Xi4wjxoEpioU6lHhmypiqrln3rfzvb/RK92AwZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gZsq+xXtHizaLpzo1tER32r/t6mRAs6VUf47ZcMCllc=;
	b=OBUAWw1EBK+jxHcRaTJaoucBmjoB81Ob3txxFZLjcp+es9OtbVaBJYtaBgEZasR3MNqF
	 J+g9ifkbDjOqjcv2i1Z9Zzx0zrb5bUGacdnwXFFJL7Eh6og3ekUxXJWwv9nSfPfmiGWfx
	 nJ2FGg0wekxMmDKIZoHWsV1EEllP0jPq1v0kUkOMXaHsRMXOlDGC/d9CEOPIliQoeN3RV
	 cppAnBru/2TuG6qr6Sz2RrvpESDQh5r210XWincYkgUGeUrNX9jVI8WOC0Sv8m6E97l2e
	 n/xxGgMFZToQjGuvlvK8HCpOTROfKt0C39MOgGI31qm8Iwqqni6Fzaj2R626r7/Yj3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PiF1ICPh;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A24606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2A24606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PiF1ICPh
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so2955062f8f.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024443; x=1793629243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gZsq+xXtHizaLpzo1tER32r/t6mRAs6VUf47ZcMCllc=;
        b=PiF1ICPhsZXEQPej5refTiirqNLb6J2mK+PQpmijJDAQZIHVYPOgPgdiMURTByH7ET
         UBkXeOTqyfsvCJLtcrfBSA6rP9+aNOb0g240XThoIqfIJiiaop7HmgnaypCcuWf1s4p2
         ytFIjBB0+KKOuEFkH3avHr4KEUN2uajL0N6Z6jIP81H6TuImv3TO6aK2QNR7vOIWp5BJ
         aBd20eMJyrW5n6WWmWVwLYHdhj1eoq8KizhzKESpCDQxIfPoqJzFjqcomM+uMMMKPgms
         yRTZdmZNEUfzyrBNHKBR1AfCCpvDbO9xOA015wRMWC1U7kjfDDjpHVEjoiN7cOPujFxT
         Ko3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024443; x=1793629243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gZsq+xXtHizaLpzo1tER32r/t6mRAs6VUf47ZcMCllc=;
        b=KWehXo81U+yuRXiJ/WRk5iADe0VQ2x2KC5NrVnWk1vKoW21Z+CF/EzZdMR5e7STfGj
         oSgJu/QdpTzUvSE65OUXbo6n47xhh8K9Y+hCZLrYzn/xGasMJFLjCpfQlOFvrk+0sUc5
         q9sEDbi0qq7OZswPRrLf1WGEG7d+huj5H/2L4CykpMfHd2/oy4rwsdkq7UpeuZbyjHkg
         ESoG5p4TsCiZU26W2QSeih0jYoGNo+h4xC5jaG/VWxeTyrdS4tJdFeJlStJDjdzQHlEF
         HgjPi5pEc+NsiQKNZTi9SWDJDZUKi6XrRNi4l1jFaLWS7NCKCLZopqLCTQymqg0wFEl4
         WfBg==
X-Forwarded-Encrypted: i=1; AKwUvBzxwQoz1YGfm//xAS82V0wEofkIF/noYZNPR/lzSZ99Z/5HDq7YH4/jymGGREL1+D6afCHrx7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5wfNiP9JSlr/TRdkqtuB10cSKzx+d7G1XxH2J92NqA+50p5qt
	yZ86jkXsUBF7PB3rZWO4PH7t4EH/ic7mN0pC0MxC1Pt3m88f/2qJSYk=
X-Gm-Gg: AYBFou2/KSB2Ze0zN0ijE+SN0Kh0pmDWO7qOcADiDxGWnYtWedx6GQvZ95tcGpVUhpD
	S4PJGmEvZeUN35UaKbFQmq+k93YfKArt4xSP59cCFSB2M6vVURvCBLdUjxAKrawLjPs4ZMO7Lth
	T/K/VSu9GkYaz6A99Kq4yvEKzOPNXA157wVZROlmrweffEZMDOj6jHZIzYFA4zY0sVJ1Jwcrl8K
	9w+8ITkM+CatII8+hJRd4X3ozI4VEm/f0jH4DMPxt6co+7Tywb41qQN1VxsDY50R5jVtld3/ifO
	Y6Cxx+hqmhl9Zue957B/lp9/su1yGiSU1cce/LkfA2wpzHqrr5qcsuu2QUO8X09+qO8Cu8B5ZQE
	uCjhEottHBy3JnVPoCNUZsJzpv8JSuZcYPQdgXYJs7R6M17cpI+HkIh95hAmpuRHxgi2d9lzctb
	idgmWpdoUcwdwwy5hz/cc+5wMBoSvVUznxh66SkMp4b6wZww7bf7U3Fpth/JqF0YOnNUfpvE2oZ
	6ivodqSduh0uDd7l40kTsJU
X-Received: by 2002:a05:6000:2881:b0:48d:f1ab:faf9 with SMTP id ffacd0b85a97d-48e3ed2c7a8mr13855318f8f.16.1793024442950;
        Mon, 26 Oct 2026 07:20:42 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm17484186f8f.28.2026.10.26.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:20:41 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 0/2] iio: validate ACPI object types before package access
Date: Mon, 26 Oct 2026 14:20:37 +0000
Message-ID: <20261026142040.62383-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Two IIO drivers access ACPI package members without validating the
returned object type.  Use acpi_evaluate_object_typed() to request
ACPI_TYPE_PACKAGE at evaluation time, and replace kfree() with
ACPI_FREE() for ACPI-allocated buffers.

Changes in v2:
- Use acpi_evaluate_object_typed() instead of manual post-eval type
  check, as suggested by Jonathan Cameron
- Replace kfree() with ACPI_FREE() for ACPI-allocated buffers

Tristan Madani (2):
  iio: light: cm32181: validate ACPI object type in
    cm32181_acpi_get_cpm()
  iio: imu: inv_mpu6050: validate ACPI object types in
    asus_acpi_get_sensor_info()

 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 7 +++++--
 drivers/iio/light/cm32181.c                | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.47.3

