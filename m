Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296082;
	b=y68GnzmhMu2/F54ouJ1UoN2owZlNiYHgxrHPX6QcUWBM5C0y8Lc/rIpQz1FwKM7GMm4M
	 SvVUp/Hd2NDi7CEJUE4T7UA4YKtIzEUgnbzfoAAmCE6N9p6HM5+A98nij39fkdHJI8gbJ
	 SRrGWUJdnyitytbzdUwiumqLjOGlxmpzxUn1DchJdjJTGRHvTkPm0One0nsyxaVuRe+HV
	 1vHfTHPDVCv/kTZy+7La8QO7IWdphlYprlBAM3hAbFfeAZjTDiskH9oQfSNn1mHeTyrYk
	 ZJLOMPQ/F789GgfPxIpX6BdoB6K7mXczHqEzt252gAdxa245Q001LG57NKB+mQdxrYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID;
	bh=O3ljys2G/dfGrzQSHlcDxa7rlNuO9sIfulWEdwLNsJ0=;
	b=2IWF7cEmS1OTFGIahSEXTjBnlNrhUJPAV1M1hzU9TwNMGhS8qYnBTOVFAYiBOPLQxBXN
	 T6cDiznf1ccNPJdeMCvXRR7GR8qGdFa5vuT9UGuDb26Bby+r/DJUCn2wAGW4yAaYOQkp+
	 1+P8kCde4IVLOsroETsZAQ0s9Oeeahk2R8wE0GtEyqCpBWRHjmPxa9JHyd2BglsViTnJq
	 5tXBH7NcaiuBMTBtaS5VvjA0uqN93/yxhuhNpEyHLclCUBh9b0jH9mqKArfoTZM5yaDjx
	 4Amoet/njXam7gldNIvpdwHbN9kvmybBS7m5ZJeeeLP7c7D66/i7v7jrgt4Rv0p4WXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8Rz2RMp;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA02606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA02606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8Rz2RMp
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4322d310e7so370074066b.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795296079; x=1795900879; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3ljys2G/dfGrzQSHlcDxa7rlNuO9sIfulWEdwLNsJ0=;
        b=i8Rz2RMpPmkXYItSIndpWJR63ShbcEOT18h3HDALB8+aTuOXp4xTJl0bXxP5lQ8Su3
         E382aOfjHM96onbffE4BozXFmdo5gHP3RvxEg5KXM33RJL/vSmFp16Wtjd8BBedvHhgW
         1iVU/K1qLjSptz5Yfltsg+Pudxm/+TbBWQOFPx+tVxAQhS8PMrW6XYqtk242qjuUvHGp
         qnpLBWi5bevQxy9wxEdfLIwsD/K87xZHuH9/1TudVpGLrDLz6Ir8Zzo5Fed3UlYCQpBu
         +dSqoOWTHFtfYm9IpDMTtsHZKW9o8LuBFQHc4q0zR4lsKsUGfdVGttxQSb2z0MremoYk
         he4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296079; x=1795900879;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3ljys2G/dfGrzQSHlcDxa7rlNuO9sIfulWEdwLNsJ0=;
        b=pg1GzMqRsnw7PqentyyK2codiCbh6Qaylg3fl6zZ0RNgnFyo9SWdptF9Zfp9JwZbIm
         XHcvSIkLArj9vqmTaDSqp9Zt5k0UDrkWdxpTZYwFtAUzI7oCbLxJv4iat44J7nzh9N/O
         eOLDfDHGVMdhJ/YWPEgDmfVquuUDnYXmyGuHxB4vePgAgbmOjFaW8EOR9y33d62DfRa7
         fLoE08R2mkATgd9/v8zrZal7vtFoiHSCK9VKTW0lGgZyt9LcN0I03Z1XGJZQeOGy/Fie
         3qqJA5ryj0c3bwJ6oQAhnpJVWK3Wuv7GOfe7eZg1tROd3moPpJufk9/Dk0RuSUWvgcrD
         s68Q==
X-Forwarded-Encrypted: i=1; AL+hErH9Td1fhLU8tBf13S/JcCAleOLow8YZ5HZFgKW2e268aJ2pRmTUBK5QRlwuB6P3YDz3iyBTsio=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3RyE0k12knGHnVqF2m8Vt/HjKqgiRww6QG24AXe8eHtbyLpdw
	CNmIY2xNlHnAiWWjUCikVi2vz9ceSNTQMXI1jsMWijo/ihQGgNPCXoBhNLj1BTt/zeA5kw==
X-Gm-Gg: AZFdTZcSAVXYNU5V64ZLZHTLvKD8ob59Q5TSO4v6yQPq5dYxydBTJMX6yWGXdQq/KAS
	OKcO3VKytPh1Qw7VdKimB0pa2ckGelYVR/5tBpKoQzrZPwiirN1VZ1KPVcNlGnzFr2HJCcnxNj3
	+Eg8yiynlRxPorObAzOHvJ+OWxTHvUiUwqHY8wxiGZC4C+fz4pCpZZq6Xu0Fx4gGHra67y0Nsd1
	X/gi7L4T2Wvz3eh5DmUkS0CL1HXP2Evl5A9qlEU9szUygEgTwPPQvUxt8/aPjaQ4jkSgoOjj/3U
	nYSx4RVA4dYzDLuGQQb6pippBSsUDQSOSgkuJqYBBZziYCDWMHFqhw//19ccS9C9kGCqk30WnQ5
	mJwAjQjWZbOm5ShPIpX4YmeVCJpWpDMWRvecLKsJAKBsL4DMItDrNR9UROdj2fqufw0wJ5CgAWL
	7hsbEnQBfZkla0GYiVdWEJSDv7bu1g3P+zmaKirkKpY5U3UDZCgMK00w75AqCQwZpcItlwW7M56
	aNbCrfcCRylDlVYBIx02tCCbA5ZfcXjV+8jC+dwkkVt/g5ImeFRPjrKuTXOoq/gvgjZWe/+m8Px
	tYa77XNSCjEQy6yPKRwRrXAoiPg=
X-Received: by 2002:a17:906:7f01:b0:c4d:2867:281c with SMTP id a640c23a62f3a-c513a89466dmr477367466b.1.1795296079086;
        Sat, 21 Nov 2026 13:21:19 -0800 (PST)
Received: from [172.17.0.1] ([2a0c:db40:0:80df::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad010a6sm243362266b.7.2026.11.21.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:21:17 -0800 (PST)
From: Konstantin Nikiforov <helllamer@gmail.com>
To: linux-raid@vger.kernel.org
Cc: linux-bcache@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yu Kuai <yukuai@fygo.io>, Song Liu <song@kernel.org>,
 Coly Li <colyli@fygo.io>, Kent Overstreet <kent.overstreet@linux.dev>,
 magiclinan@didiglobal.com, xiao@kernel.org
Subject: Re: [PATCH] md/raid5: complete unsupported discards successfully
In-Reply-To: <179299857972.12222.2729359466842183358@gmail.com>
References:
 <CAO96y0V6oncv54ihXnHfJMYiG_QAQ-NM8BOdqPDXKL8r8-kR9Q@mail.gmail.com>
 <179299857972.12222.2729359466842183358@gmail.com>
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
Date: Sun, 22 Nov 2026 00:21:15 +0300
Message-ID: <179529607529.5.3302391929789139470@gmail.com>

Hi Kuai,

I built and tested md-7.5 with b964c9240a37 on the machine from the
regression report.  The reproducer passes and the machine runs without
backing-device errors.

Tested tree
-----------
md-7.5 tip c526b7cd32f7, based on v7.4-rc2, with b964c9240a37 applied.
Built as 7.4.0-rc2-md75+ (x86_64, Arch config, gcc 16.2.1) and booted
on the affected machine.

Reproducer
----------
Three 256M loop files -> raid5 (64K chunk, metadata 1.2) -> bcache
backing device.  devices_handle_discard_safely is left at its default
(N), so the array takes the raid5_discard_limits() path changed by the
patch.

  md125: discard_max_bytes=2199023255040, discard_granularity=131072
  blkdiscard 8M on md125: exit 0
  bcache1 over md125: discard_max_bytes=2199023255040
  4x blkdiscard 8M on bcache1: io_errors=0, no
  bch_count_backing_io_errors lines in dmesg

The same reproducer gave io_errors=4 with the unpatched 7.2.11 module.
With the patched 7.2.11 module, and now with this kernel, it stays 0.

Affected machine
----------------
3x ST1000DM010 (no TRIM) -> md126 raid5 -> bcache0 (NVMe cache
attached, writethrough) -> LVM -> ext4/btrfs root.

Since booting 7.4.0-rc2-md75+, md126 and md127 are [UUU],
/sys/block/bcache0/bcache/io_errors is 0, and dmesg has no
bch_count_backing_io_errors or md/bcache I/O errors.

Caveat: the local workaround (udev rule zeroing discard_max_bytes on
md*/bcache*, plus nodiscard mounts) is still in the initramfs, so the
HDD-backed array has not received discards on this boot.  The loop
reproducer is what exercises the changed code path.  I can do a
no-workaround boot and a scratch-LV discard test if you want that
before this goes to stable.

Note: 7.2.y is EOL (7.2.15, 2026-11-01), so the "Cc: stable # 7.2" is
stale; v7.3.5 still has the old code, so the fix is needed in 7.3.y
once this reaches mainline.

Tested-by: Konstantin Nikiforov <helllamer@gmail.com>

#regzbot fix: md/raid5: complete unsupported discards successfully

Thanks,
Konstantin
DeepSeek Harness 0.2.2-rc.5; model: deepseek-flash
