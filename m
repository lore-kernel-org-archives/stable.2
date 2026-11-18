Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018061;
	b=zqnijU1xMchvdtX+ued5IXRiyMoAiQOAxHDX7pFpU2jumg8wK/DvbbWgcpmg/8uIzUhe
	 Qh66URwB1II4gjXqn5TW8Pu/qB5pdNnZMNiB0h49CkeYliGQeo36Tf4IUWRpMoVhrc6ei
	 mYs3k7a2RXg3gJJ1IIAj5QpXruRQy93YXo9O8/qkrLFfNEd9DUOEzUdsUn0/DXH0GDrpa
	 62ZPLjel/Xecw6MYtq5koFFXSWH/+qoB6mDWMmmjQ/gOK/6CDIgjlNAloeDa5yXzWFTP5
	 g9R8RvmRbfoncOrR1B028AgvcoQGPity9I5WZ9k6HyuWoyAIeJ/TghaCMswATNvKSbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ujkN+eC6Zu+/+obGmDVtyoxxt+WJSJZ0U/kWRfaBMgw=;
	b=mgmIZOZr9hUsf6xs5t3gaZjn5wwYD5pd463lxJQ1uFefN23OKLxHGspxbu2EG2LYf2t0
	 CauG2dvpDzc15q0m9PpV6UwtEh0EMCh21QaPliJxghBVfy5jqR5nZ9Jsv0t7uRkKKLrY5
	 Ta0Y6StKpUjDCYLo2sd76pGTvIGlUWpGGUG5+5tIDQGGpBmEjs2y6IxhUQO6EN8BafneS
	 b6RvLgMgfQItV/238XQWDX3hm3ocmlXUZugZlN9XbuwbefGD4Pf363e9NfW2Vp8k4rjVW
	 dAAIxbq9Wg3Ax187GzVowk6nf6EWGOIVUYT6kFBFRGFN0wV8z7b7zQf7xbB7GFPiJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WW6ACKA7;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B05260A260B
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B05260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WW6ACKA7
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71aea92f666so741705eaf.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018060; x=1795622860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujkN+eC6Zu+/+obGmDVtyoxxt+WJSJZ0U/kWRfaBMgw=;
        b=WW6ACKA7UVZiX0KfAzzg+edxiER4uOGUTJowPB7yetEcRNF0o4/Kgsp9BxcVCXTdif
         Tgv4mmpcq1Wmrf7KxcoFOWJZbPQfmjFqlCYt+veaAJCLfJJpjJJ0+pe+WJbg9pSpDyX4
         hEB4mBStC6AtALo5N6bjSJ5/23Si3ahmHjbu+4GyrjanqO9Z9FQL7hr4Y+i5Dj6ojLaN
         f8kgHBRGEQ82u2/SnxNtKDHtkRKPlhx5anbGuZ15xZocj+BHbgcKoOetIUpg1RZEvvJo
         MQ27KN1ViJofCC9c5ILfBA0ZvkCbNS1QGKsj6P7llq7rDd/KfASgsSuCATFnW+exUF01
         J99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018060; x=1795622860;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ujkN+eC6Zu+/+obGmDVtyoxxt+WJSJZ0U/kWRfaBMgw=;
        b=ZJHUml2xKwsFEveN4u3tMjG0OYWdaKCIpXiqB0eZlCr92rM2NkZb5TINHlcuiSKXq0
         AxwP3RuqFPPZpSE0EIoboUge/aKDB5LIHV0Nk2/f6+Hd8E/AQPKKgCAIGqkAQ9pqUIwm
         45HhnHSY6qLgIf/GfUhEiS/RX5tFJs/fiwuj25FBXNtwZlA4/NCrRi8AuqJkYeZ+Va5u
         vSv/wv7WJ+Z2lKUowLbhFPLTNIxKthTX8dMrHcpUmCa8lvi+9hSBZDQKauiIZSVYapSc
         DdWrCnJfaUosBnl89fmz5zTPhNpevMHWg+q5HSMVT/as2X3HJdLDDq8q+udWvNGpB57w
         ig9w==
X-Forwarded-Encrypted: i=1; AL+hErHkp2QFcLfxj9hIqWtqrNRbTCMQzs9hC1US2l2FIMJO2qgrtxpCyym5ybjLmpSjeW/aiQicI5M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9T4aeja4bV99gdXb2yaS1VnC0itL+w+WldDYBUl8qhwFE3/li
	5zPy0gfLQOuyfOoUSm35+DjhUHMuy2/6Nd3bGgAM3lcImTDEEmMQXnOrijRF3ToI2y4=
X-Gm-Gg: AYBFou3gy9WqIJv1BCJO7DaSgcy/W94KcfP8V/mXhmNdZF65HQf18Q/81gVa7Vth2ZW
	BNuD0V9J9kPbkbTYKrjxyvhVOhRloHNEDhS0BKneB3iO/z3cHU1KMLcA37fYjB80m2SFVAXcfYN
	Gd4bHyeB73rvCqmJIaxGKGyf2B0zqKFhflPlzAoIgPKkxg6IYYiNCg1rVbp9jF39Yp8VvzqNR3X
	mbdwlmkdKGTz0POInviuzY/MR6gajEqHKv+3CAFyNnqpTjDNfQOaVdXfLAG0YVD5fRgk9OTcMqr
	rOoYvfk+htYnNR4gmvOEPKDN87oOhbqtYSjXwKyensHuPaXpSu6qQOZuf+r4kzEMFlsAT3b7uCR
	jb9SPGETtQpgtVsLUJEnkqo3wygFmFCNQwWWbOxa/eAEJMwGQOsRLf8PpLO1icylQNeKMm4fZI6
	vG3u4aA2SlmDght9NGGkZVAUYl6BSxGQNRjSIWFqJBDFSWplz1NObeTg/cceKIPQsLCoEf2Dx9x
	GOXnL2YuW49+AH+ok4iB3zRpVjxP8xt9awWNtU8U6vtOHD6WQO+ZCga8DiGI+Pz7I9e3jlZ+3ZY
	ie16s+esmfoXZNiYlB1qBfrbzmTjF/GH/oInKNpn6JDUS+O+Kct0dsqo19HExsF9O61UVnaLxSn
	S3scpeR7qycXs4p1yYXCaByiz7Wz7hMxEMWd14r908JTOmm8Sj9czm1xcdQBFI7M9DVdiuJUK
X-Received: by 2002:a05:6820:807:b0:71a:fa06:4dd7 with SMTP id 006d021491bc7-71b18454b50mr2463359eaf.28.1795018060423;
        Wed, 18 Nov 2026 08:07:40 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tom.leiming@gmail.com, shuah@kernel.org, linux-block@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
Subject: Re: [PATCH 0/4] ublk: report recovery test failures and fix the
 exposed defects
Message-Id: <179501805884.17649.3891543607346842206.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:38 -0700
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
X-Mailer: b4 0.15.2


On Wed, 11 Nov 2026 22:57:52 +0800, shao.mingyin@zte.com.cn wrote:
> The four patches make the ublk recovery tests report failures from their
> workers, and then fix the two defects that the stricter tests exposed.
> They are one series because the later work came out of the earlier
> patches: patch 2 applies on top of patch 1, and patches 3 and 4 are the
> two independent fixes that patch 2's testing uncovered.
> 
> Patch 1 waits for the recorded recovery worker PIDs and reports their
> status from the parent, so a failed worker no longer ends in PASS.  It is
> a v2 of the patch posted separately on 11-09; the only change is the
> simplified wait loop Ming Lei asked for, and his Reviewed-by is kept.
> 
> [...]

Applied, thanks!

[1/4] selftests: ublk: propagate recovery worker failures
      commit: 6f3393515ee6526cf66175a85f3327899db765e3
[2/4] selftests: ublk: propagate stress worker failures
      commit: 01fe9c1894fc4cce7b04cdae5522c86519ba835e
[3/4] ublk: cancel commits arriving after the quiesce scan
      commit: b79225a8965f80b448dcdd236da2e1ca0690238e
[4/4] selftests: ublk: clear reused batch SQE command flags
      commit: 73f6a1d93040ac8cbdb03b3702a66e6a14773d02

Best regards,
-- 
Jens Axboe



