Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661896;
	b=nqWkKyefkHy1NJyWvkZgPyR9sdOrTJUNiUBghyMKFTjspOtm3M8dT5ORIRWTeUvwMQkI
	 MH2OYW8vcapVxGwFfa3vA9oNhf6yXpKpl1042UpUW8PuruE0rqNLYivStaIEoOGKLNidw
	 bbQvMJIfUfGYg355naqE6ssfPK5MeS66znroBUMMrdd45lBfuSVNIXht+VEjFiXnrIVzG
	 CWC6K2ntDdfRi6M+3fIogQ62L8j5si+mDhudUs2uXNKiqLgqtFoOXsOmUkhrBuERuBbH6
	 cCpwGIR1RITZ+XHlblx3c8ugMzukkY7J1MSWP3SqjigMqtwOBUNmgEeGsLki6IYn9cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
	b=5qUqzcSnXfNPs7X9UQLqWYLh8SBm+8NTedXPOGekIEL9vH0Bp//23+s1Gcx1t2vzLAbR
	 of8TzYiN6keYi+0gxBZbfap6fKPzcki0a5T++rgLClhUxc6DW0T18NWjUcgIJ1JwVKom4
	 25WhUlk9c46n1TM7K+7aZQXttQ8SyQvWGHHMKhW/LoxjnF0HeLP4Xj1tYC1RBf1cv7EoZ
	 nDX9RbyU3EUtZgD23LZzSqomPsBUE+Pu0PaQKI0+pPlJqFNLb7nbJE28Rq5SuydJAxYCO
	 Ktyadm6p8kjiG9UUORKrwDUkUeR2oVTX4XKwHmcS29z4M0gfPigTctAsCcifIuHI/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jahs.net;
	spf=pass smtp.mailfrom=jahs.net;
	dkim=pass header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=E5jX6Pp1;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1FD606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1FD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jahs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jahs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=E5jX6Pp1
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so2844835f8f.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jahs-net.20260707.gappssmtp.com; s=20260707; t=1793661894; x=1794266694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
        b=E5jX6Pp1CpWESJbBoS4MeQfTF6H57JCrBvaFR9LvoumWAfIZy4/jMBF/CG8hOba01n
         K91I3YI8q6/j55mmYVH1qnt/2dAcEta3ygjMHYAJgHsuW6lp7EIsLphkPRtlA3Tn3Waq
         WxRk02uNCfTrfNTsKHwL7PqNHo9OaldRWSZ8ih4eHELqaiiMdf+1s+QOUHpY8/WVdOyh
         3yH6W6EHaIx1DISF5JSRR/1mYAJs8Y+Z+75pON69C53d/70UgNOCXM4EKBjseqqaDCpA
         P3qhydxBAfcObM4D/XbxqnuBh/fveSJFadsIKJzKiPCqgHJYBTit1z8KNuYybckJprvH
         3aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661894; x=1794266694;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
        b=hKI2VdYm0hi/lgSpCzb+vJzfgpzBpLfhxT+A21v5UiC8KL/GWMYH/M5236hJI6yY13
         70OBiTnLl2EJNti4HuzI6J9Bukmoh4XSVgWh4fZ8kTHFv+0qtwamfXQt0ih+YwVVMKIr
         Whf9ZTPUkNp92ZclbgBL5WIbhTX8ffZqLTaEh4lLDIxZQ56JRKiFH0+J5QUgxvXmKy3p
         5rpYqzVFZhgsr3kCuQTzD7UTcbJ8OAlRZRlK/6LG+B+X7ThS57c0YdQuof0fKbaPxxpD
         fRGmB/dr5yotDHckIwcSvPX6lZZsEoyY5ThHTuuW4P0Mf3spvCEzk1ibTMKf/xSPwne3
         1qLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZa9PkwidTraz5nOx4P4OBCZzf/no+27eMj2ESvZaS1LBLlCWV5Vz4qlUtgJ9asOSkQi3mjtU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CYMAGLf7hyvSj/FQ9PMJ5NoaVkh8sloOGOAqfhd4Ito911pvi
	Vba5OyU3WHwYuxqQFRcf0+6bqnwYKVzGecDEsuZZkrhFAW9wPGGHFpwa/gmWEJX7iA==
X-Gm-Gg: AYBFou16tSlHfmGVH9YsE8Gh0AEaI2SO2bcWVBJ+BkcOvHSzXBkaK7rkUTiSTrEljNc
	kf75dphJEJyOnfOeetkMWgOzSpa0k71wxqzGwvrwOXVYbK8b/SclsaBl8ZaLSh7uhtdWEJxTXHF
	fFfVipExf6cMIbPJI13mCuioUFI0M52D1FLeHhgGSrHJvgShvMB8KVwcF274+tKtsIlkfr/U4E4
	jh507W4b1QDjGUyZDUZQ7iPTWKu2PepA2s84JIw0b22XiwzBOgliA+0fyFmTKmhzc9JX/Jv2fK+
	qp9Bz0ZGB+DpDBKFm4rzel/Wcd64QOOho4npKdzPIZN6WuRrsTmPYRZWnbmtW2iOWtfll/9Y/rQ
	70aZMTrj2klpLuZaxuMwdFS98l1zGWPrIFE4QWHW/IT/g4n+BjBblYlILNn/YMGAC8trPR9Hmqo
	ybse/mTrAvbIwRLJLEgNR1EbLPX0aHaliswUOzbDo5Hsr06rB/hN7iEtlJm6CTiTk8d1QEi62G8
	GLlIHtASzMHcjwgIWKpBXdQn0/8IjFZrVB30EoiWQwxD2hsxSOxU0P/iC0B8cUuj5hTPO/WXn25
	eiBIoQm5+wWWRRxMzbgldlfYYrhZL0aqcLBI40uUgsvwHN3PFgDEGb6s6UFclw==
X-Received: by 2002:adf:e19d:0:b0:48d:ffcb:28e1 with SMTP id ffacd0b85a97d-48e6e4f570dmr26032786f8f.11.1793661893544;
        Mon, 02 Nov 2026 15:24:53 -0800 (PST)
Received: from mbp2019.tail53dac2.ts.net ([2a00:23cc:b5dc:701:a5b4:75a8:ede:9f7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d4f9sm22522868f8f.2.2026.11.02.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:24:52 -0800 (PST)
From: James Skillen <jahs@jahs.net>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the MacBookPro16,1
Date: Mon,  2 Nov 2026 23:24:50 +0000
Message-ID: <20261102232450.61301-1-jahs@jahs.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024162109.307247-1-dev@deq.rocks>
References: <20261024162109.307247-1-dev@deq.rocks>
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

On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
> The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
> 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU messages
> as soon as UCLK switches into its third level.

This is the hang reported in drm/amd issue 6005, which has the
umc_info analysis and test results from both boards:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/6005

Could v2 carry a Closes: tag for it?

I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
userspace pp_table upload from the issue was disabled for these boots,
so the corrected levels came from the patch alone.

All at DPM auto unless noted:

 - both "UCLK level ..." lines at boot and again after every resume,
   pp_dpm_mclk 95/496/598/736
 - forced pp_dpm_mclk switches through every level transition, idle
   and under memtest_vulkan load (57 switches, every 3 s): all landed
 - UCLK pinned at level 2 (598 MHz): llama.cpp benchmark and 180 s of
   memtest_vulkan, no errors
 - 60 min soak of llama.cpp runs with idle gaps, and 30 min of normal
   desktop use with the soak running
 - 8 deep suspend/resume cycles (rtcwake, lid, systemctl suspend)

I ran these with the internal panel on the iGPU and again with the
Radeon driving it (apple-gmux force_igd=n). No "SMU: No response", GPU
reset, ring timeout or DC errors in any of them. With the stock driver,
level 2 hung within seconds.

For the runs with the Radeon on the panel I also had
amdgpu.dcdebugmask=0x1. That is for a separate DC issue (the MPC pipe
split on the 3072x1920 eDP plane makes DRAM clock change unsupported,
so UCLK stays at the top level). It is not related to this patch and
I will report it separately.

Tested-by: James Skillen <jahs@jahs.net> # MacBookPro16,1, Pro 5300M (106b:0210)

The testing above and this reply were prepared with help from
claude-opus-5-5; I have checked the results and the text.

Thanks,
James
