Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036358;
	b=eJAGNXldww8gPyjHQAG3QNeu484OozRLTxbZbQ8hIVpTa/Tm6BXvHVpa73PqQXV4PFLV
	 k0q+dBIMnVVgy+eqQ6zfXyA8j6kk1PZGct5gIM6dfHO6OJUfnBRYM3LQYiZ98514Ej+Dt
	 3R1fLNtjrug3PWd8bUk4ZB2er3bY+ou6ewILC6ZQrLaiKwx+oHzOAdoBOvofvaBGRsAQr
	 FZPmtKRSy78mPw7Jy+zc/Ub14iA0/SLE/9iIFKyqnq2uBbIjIp6NvFd9eGEcFAaRTtF4R
	 dqmJc1fjUR1C2zUr6qIMP8qOwfd/WmxNwpf8f9dTa3ibjfX7IBtaDInQNIX1uLsf34w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PnSIBEinvI0aWOXfbfSxdS14sk+hrl90vzujOjLWDnE=;
	b=foWHCVXansNQrQx4rN7yEE+WpU9mxUX46SCojjIWiJXZ6DYSErW4d6uJ3Nc9SFjFGuDC
	 caiP8YRzXFPosowrmIexgddVJX7a7ydteyK4vz/rxvna3oL9GRysEuUOPXVx5E7uLSA0O
	 ygg6cEUr34VyHoWMrPq+T/okswiOCtdotmr8qSSF7NKv/TosbHC/0xizZf0BLP8s2VuYu
	 mEYBcdfudsBPl0hLxDVsVY/4A+k1+qwuCmC3i+AznlCpS2vuIHJDZYzbo2kZzerWFM0sT
	 W6DMsVfUpFosd5el55vEgd/xMjk58VPpkPpnhFxj4C3S3POlyl3pXsxEOw27W9uMouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KWNTyjiS;
	arc=none smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140F606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 17:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E140F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KWNTyjiS
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso2762390e87.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036356; x=1793641156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PnSIBEinvI0aWOXfbfSxdS14sk+hrl90vzujOjLWDnE=;
        b=KWNTyjiSseh8CRmBtZ2wrSmoout5WMIyNVt4NfUzr7M4iL6TvFU4puGMODBpTeXLjc
         KdwxAfOs3VOMlLGb/XiRW30VSo82DUb5vdDcZ4xFHAFAXFrHjJ6tlPjYs0CjuTOIv3ux
         HrDTjiVgs8bWoKoUT5px1oVEBL9dBP0uBhSomaaF94k0MkMe7ygEGLb4XyVFkQe5xCS4
         y9DMI4KAZolgfSwuZuX8Zvy2yEd/cizD6XPGDxOxOLGy0Z/C9+J7rF/UN9RPEX4bX9SJ
         B8BVl/hfCRyhHL8j7PR00Y1MFK3Gas/14IeU5PjShFWvSJmWi9BwPrLWZ6lZssF9IR/h
         N9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036356; x=1793641156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PnSIBEinvI0aWOXfbfSxdS14sk+hrl90vzujOjLWDnE=;
        b=21/vfiPsw0g+Y6bUTwGAijeNS3mUtAMVlpqdQcZ8H4aGeyTXuHorRGlpVdz8pO4qy9
         xXD2v4V2ZMPPPLZR4LeRYJi7oNj0AEYvx/WfQdP6QskARbLKIkhPQ73HWZRO/M6mAQE/
         WlZZYfDQqNufYr6w3fViO3iUJ5Y1wHxzmYQsAwoIk1oIRhstDvBBYiyXgQrLddeTjCy0
         KB7x74eUinjA0KP2ThcoAEZx6wr9eSDHhHsmE7m3o9Pe1kAvPAEm6FB/WeaMaQSVz8/I
         p/rCfGKKJQj3nA9QS7YnUexcopffpsF4+kGSfHGlEMfqITMSagjEgxG76wlgDfoEKy0M
         UtQA==
X-Forwarded-Encrypted: i=1; AKwUvBzh3liv45rBXR46g/BAODQddP3Jar4cUwJUFkcQD4UpVU3Le/wxOH5JltDO1bF/khKGp+c7T5c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEaayd9n4rb/8ejgdQl3BlthNZmWmwTunwE9XdYXXta0+axZDh
	aF69nmS6UPPB38QumrJZmPVCR5hF9iBYcMLHBi5QE+wIyttx0AS61VHu
X-Gm-Gg: AYBFou1x/S6Vv2NAz3tGC0kbAyj52aB+a4yYJSmUhUe+n6QrMrphV3dnQkrglpnMoCc
	mNMVWICv0L7ynNplTviB8nz586EzAT7gS3NMNeOi2nkkj2UgBMLd3Cjpe+c0zxDfd3r4ehFwsDv
	J/nP+OH+dPZx9zSw1tQBNL9QXyuSG/sBtouBi6qvT1Ba892vkvCSGDKr+aghgBOcGDb5/9bSplG
	eY9yITuwYZo58Bg0pAWDPWQU2fZyYDWw4FPoo7c0NwZv6zdXXPIAY8UcCyKVTkYmQSyrVeGVQwA
	NqwmEVZ20j/7gn36A9qsggYbneestPxefFri1glXBdqr3fmXiCu6CN+3UgEsTnmnQ5t0SPpjUgz
	yDe5kS1CzRWGFiCl3UECOdq8vQcZuNuzLMpObfXsWfJATMjONkqXom2j44prJDGXUMLj+lCa8Yb
	isNY0YZDNNFJuEEINrAVXZl/hSuJz2gICZsqt1h4Tf2qQ7942Y4zAXYKf/y3M9hx2vKBS9ZlZLO
	DZ8b29AGTPcMymThS0sy94gwdN/ackqeTFZgsCVnNfZWd3NBZWIHZDtX3nB/TENefRqPs6s4tFK
	f3SRptsZkezxEQosNBxB07CmWj/67k6rUUNO0Kj8Z1ox2S0fvwVTWP0PkUvgNV/Y
X-Received: by 2002:a05:6512:b8c:b0:5be:4386:806d with SMTP id 2adb3069b0e04-5bfb71eeac7mr2553829e87.53.1793036355836;
        Mon, 26 Oct 2026 10:39:15 -0700 (PDT)
Received: from yantra.. (nekmmqua92iezg7lpcf-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:9332:cc42:ba9d:ca8f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a950b9sm1685199e87.63.2026.10.26.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:39:15 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: wait for a new sample after a ratio change
Date: Mon, 26 Oct 2026 19:39:10 +0200
Message-ID: <20261026173910.23788-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <at8X810dwa98w9iL@ashevche-desk.local>
References: <20261019153328.80739-1-zoone.rupert@gmail.com> <atZqSXI14WojGso5@ashevche-desk.local> <20261026024605.3286702f@jic23-hlaptop> <at8X810dwa98w9iL@ashevche-desk.local>
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

On Mon, Oct 26, 2026 at 11:05:55AM +0200, Andy Shevchenko wrote:
> If Rupesh is going to add the patch to clean up that (before or after this patch)
> I wouldn't be triggered.

It's ready. It turns the 30000 into 30 * USEC_PER_MSEC and does the same
for the other sleeps in the driver. It is in a small cleanup series that
I'll send once the dps310 patches already in flight have landed.
