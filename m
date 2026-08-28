Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965B13D891
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882617; cv=none; b=OKANarnvOCRlQXkaMwmF/P34/d/QRD60VynvrhS2bQ3CTeEmDZ0GOU0m0ukxzl7HKN6e5tImSzIg0ZgjmuAJgcknfX2bX9zFXDLhfWsNdTB4lGeFXSX2DSJ2iHzy9CNNjz+MwrBlp2YwhnPCWpps+WKU5/pHB8/C40aq3/ciK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882617; c=relaxed/simple;
	bh=o8STLy72E4h/h+IrUcxPbm4uQeT9WaWvgLAmymwuyNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3AY44wcUdXClrCCRwk+5PA8HYbUEuBhgGDL5WJWbbxvBlPPjPsK8XfM2wjn/kahHSY7ZTI57VVXZ3G81ygu42beHK8mfhsE8I0T1IryZcQ6+yABy3v+so/K9yPDUvBkOGX5R9JiVmoN+BUtk0rFyH3kbfj2ALrlC0mq8oJu4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GACq9F5r; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GACq9F5r"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so618530b6e.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1787882614; x=1788487414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5ykKG2FA8UXE/CNS1ckuIh5z7Gwn0o9g2gdMHvGoGo=;
        b=GACq9F5rTn2dpIWeJ5f0BD38lDZ9aqOZ68HYacTD4Z7FTyP8ohBi7G1Ce06gapADh6
         DJ0nimr4ojrh03mPj2Ez0hJ3YBpTfmHeX0mv+e6GmLtWNBpCQLgGd7vA7WmlVUsxx+Hj
         MQ9H6ircaXEBiElbGECGry1kf1Q+Vq8gp5Ss4paRvPhVVZtrXuuV0NiSKu0NKt0lacUB
         GV0tvQ2+Hu5Qoebsa55mQiFXvTkobKlZGw5DFBiDLGW5bjMFabb5TDMUIXTMUxXZB5dU
         RPBzI57HeUCZxzVOx+g2GeBEFbPS/iUwNc2t1q2B/+xp1NR09a4hvRys+OxfVBdocWwB
         RIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787882614; x=1788487414;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5ykKG2FA8UXE/CNS1ckuIh5z7Gwn0o9g2gdMHvGoGo=;
        b=Ks4n/dDWF647WQo4EOV9+u9Q088mOyNJ4IAX3kDojgt8YMgX7Mj/V/N9v5qbR7RsqZ
         cx0GqSVJdBZrx4JT24KJyPNEv6w1I4HlZmwM8ev3jOuMScXtzNumfFhA7uGHWn2kPneh
         sbn7R7dDCQLOZeoHXnrMFYCOURO47CeVyjiqi5eW/jVSlCSz39bsFZcqmgkbNw6f5Ky4
         anopSwkRy0np7iG5o4d3kyO+Y4D75IFkPDO89pvjVEib0uSSKs7AYFdxGRiwVFI/dLyG
         ZPQQBLf1hOu2fS+R8JQ6shl0VSydVmVDEizTAGeKjl4LTgtTnjdu80baUQ9E9fe8kbtJ
         5Iow==
X-Forwarded-Encrypted: i=1; AHgh+RqSIuTfJjX/+9wXp3NnEsucMC6frzLZOrNvtl6vOOWD9baa5RpMSTVjU8JVkLtjHelx0wdMomk=@vger.kernel.org
X-Gm-Message-State: AFuF++m9UxZgbUVDlN8aS/I/ZupI/r0KFXVrpI8DbqD3PWBkM1XqWRzA
	q28T1kQ5W8baKWyb4rInyE0vviQ2vKcKFYY1CUyvV3Ts/BTmJ9HpjNNxBYGPP6JZO3ap0LEoTSJ
	xBF6uKl0=
X-Gm-Gg: AR+sD12hsykgLIlrKyUS9OzHWGeibQ5tTf3bKwGiF74eN9sZO9zQRxKnXBCsVcdMDu9
	kCQmROZlD4DyDT+86xTKiLL957JfiKKAHjQjZtL1IBa5ZkhX/mVy+sY3KDMzdziVORQB212qsUk
	dmx3/iQTLq9d3Mxv13E2iswyDx3z04xLQZjhOV9Tx41aQgaHp5Bf9PAid6aZ7MhyR5CkxfBSXII
	IomUJE/1TAJh4N15hML6QRrLjcxx8yi/HwlakyuWUmorb7RrO8GdqA8HxD+n4/az5CvhHVn4Scv
	YbpiHyaw9NQnT4koo5Huk5PzB1jiIvuLNTX+2LZ36U8CpV4vEhz9sVhA7BLskngB6gl6HlQ9G5n
	uFTHwAhcpp2RJMwYOqtprmo6mRHz6h1fanmAAO1nSbTwO75MxXgg1X1xZ9AxJsPcDQVIIYz3WAg
	evJC3GD5K0lcOJ2280uz9/BqtIZXspR3ZUg9A87SHfVorTJxM3eV6+Op2GUbAO3pwbAnGcMWNrv
	sFh/wN74N4VBYCKa8XrQaiLEayfUaCWmiMkiWCh2cmWUoc=
X-Received: by 2002:a05:6820:188c:b0:6ac:abdb:7f99 with SMTP id 006d021491bc7-6b1c66c662emr1322604eaf.28.1787882556695;
        Thu, 27 Aug 2026 19:02:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1ce35c529sm204469eaf.13.2026.08.27.19.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 19:02:35 -0700 (PDT)
Message-ID: <ea042ae2-f3bf-4f3b-bfaa-9a7676a9b043@kernel.dk>
Date: Thu, 27 Aug 2026 20:02:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] io_uring/io-wq: fix worker accounting when
 canceling creation callbacks
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: asml.silence@gmail.com, vrazdan@openai.com, krisman@suse.de,
 io-uring@vger.kernel.org, gregkh@linuxfoundation.org,
 Vishnu Razdan via B4 Relay <devnull+vrazdan.openai.com@kernel.org>
References: <20260825-stable-io-wq-6-6-y-v1-1-c9f890168485@openai.com>
 <20260827-stable-daily-0011-io-wq-6-6@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260827-stable-daily-0011-io-wq-6-6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/26 7:46 PM, Sasha Levin wrote:
>> Decrement nr_workers only when the canceled callback is not
>> create_worker_cb(). Continuation callbacks still release their reserved
>> slot, and both callback types retain the existing running-count,
>> reference-count, and create-state cleanup.
>>
>> [ Backport: retain the existing wq->lock protecting worker accounting. ]
> 
> Queued for 6.6, thanks.
> 
> I also used this patch for 6.12.

Thanks for doing this - and I'm assuming the AUTOSEL stuff is both
adapting patches so they apply, and pulling in prerequisites? If
so, I love it, imho this is exactly what it should be doing. Helps
maintainers out a lot.

-- 
Jens Axboe

