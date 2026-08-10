Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934C3630A0
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379183; cv=none; b=bbnwgZSLu9g7BDxy5jkhPtViErA5v4hkDaxkzLGzuEccVyXiygBbbG6upT5AvA0ohnKETd/cqfptsTwlhbD3oraLgeMbpDaM81NO8cfiCenhOGiZ+6BHUFAfh2ykQyawrxdgGbNrM2uaw49lNwhy+d4sIUx1sTV0OKHU7r+Id74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379183; c=relaxed/simple;
	bh=t8E5gQQ01457+bCBT4QBHsxttb1UN0ky60dtyBwh3nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXaAl+E7anSO7M9YvcexFJT5QioXhtdHj+SqIGVOwg3WydLy3s05+EJTQILZj3kzDmyXG6PnGbcTHKTlYV2Ojb+XbGvDdz+VksRNYr51S97hpgHsYYFuduqFvXxK3CSTBzoY4RqKLbO6jzvCBdx4UPlb5WmDZ5aa3T1Tc+i0DsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeFVEd7X; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeFVEd7X"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38101f85591so68356a91.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786379174; x=1786983974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Np/evzwwro5HL67wM3SgJ7mXafU0epyrD8Tg6dJk+p4=;
        b=CeFVEd7XKvJY8JK5zZymtmDVUg5myYxB5onv6prgwSLDpNF/CHYAERplZA4s5RZO4J
         jKlEEdKXQ/NZJhbScBvdA+AYZlfIZ5Ov2vniAS5DPnR7NpZ8c74VJuBPlRkY25YMJU+A
         tP/Ys2/UzCOtD7hcrFfKoTSs7fqkPjGEe+8SU5aGSZtQEU7l9iisB94+I6vJpue9rpqg
         2O0eidmVXvaamAm/Pas3QghuOZ/MRroyvi96my4X12aqi+85NMfWK9DVK3foYMxfGKwC
         rUIOpEatIsG6tmOjaCdo7bXSwcQXLDDV84ubMK3Ez46aDSv1+JAyphbYjd5ZcG2frXN8
         BVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379174; x=1786983974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Np/evzwwro5HL67wM3SgJ7mXafU0epyrD8Tg6dJk+p4=;
        b=RurpHBKGlq/TWcBgcRc1XUKFzdqWRpp8zu6kquyH+h3BtDtMc7iYnvJvkxdSvGBW1q
         S5Zm8nKf9PkBnHPDSueGXtAF09y8yMzJC1UKanCnEg7H4qGl1L3em8l4ChFHXRHXUMtM
         KxJtEVcpFilmTSnzIcwvTaMcVYNiyha3JN3Q+wLrYGd57iwebekWpn+w9L5bpPhNkzWh
         Ot0oRKgirV4jfzWjdW8iOQMr3Az6UM2oKu5bpQS7WSnZmkwalNMTex9MevkwpeR5seSU
         4H06K543iFsz0Usj0bDJL+5fow1+F/Fw3wS7zsvMZYPskZCGkL4P7w5op0NVPi0Akn2q
         6IRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfjQmhnMXM/OFlelF7IO/Y++NALE2q9Ia820sRlZaeXTabFyToDlflpi3Bub/Ox46Ttr9cesk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0iV8ATu/aK1CDB9AiOJVq2+P18rAbBqmEAGX9Bg2Uk/ThCBk
	Ct1IDpGVPJah/o/+26N5n+mlnN2rJeTbsYx28LTAhbDh+IW3RMJcxaR1
X-Gm-Gg: AR+sD11obPvd7/fjvrvSwIRPDPpiI66wVzyS57kSaIgQQeKYY/wds1ySKs0z0GsIiAa
	gmOhrZtopKDkhwT668A7KqFp8odWQpBne0i8kHhwC8MiH9tbSS0/ofw2xbcGoaPqcQmduKEJv7a
	t12mL84udzAAgTNab/vuw49GGrfdxAVk/35XceglmmkOiZBl+2PKMWpWu0nzo+lV621KMI1m1a9
	manTCIcFMZDCNsqVPkGAbx5c2JIwIcIxJi/i0/G+9Q2J5q0ebe6m8kddUdQSpp3oaHqyqNwK8g8
	yhDghGPMopiJlv1a5PXiPpXSdWjt9SOoNO+n6WacBjWt08nHmPmPdEyQpHgluEWWSI7XQ4pbcEZ
	QONHwZNhsIplZfaPr4kCTknlUZtMYEEmNBGt1WCRZOgrmQn3RdWhcFps0386WYpNJEN9JJS4s50
	I3YAksKpLsCM/Tuq1RpVa7YdQs7/XyH8K/BwmB6JiaJl+HGAFbuDtmCWcvmBNudNw+8YOPtf0OP
	5JfiF/QEk/K
X-Received: by 2002:a17:90b:55c8:b0:387:d5bd:6231 with SMTP id 98e67ed59e1d1-3928479c13bmr8512895a91.20.1786379173993;
        Mon, 10 Aug 2026 09:26:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5195a4dsm206563a91.4.2026.08.10.09.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:26:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 09:26:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (max6621) fix negative temperature offset
 and crit readings
Message-ID: <fd46ef36-9e91-4e26-bd65-a75c7e4036f6@roeck-us.net>
References: <9d3a4f1895a47794bb359a2a32fb1ccd6a15812c.1786334038.git.congnt264@gmail.com>
 <ad0baddbd6163cf73545c8e9273258136718585c.1786334038.git.congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0baddbd6163cf73545c8e9273258136718585c.1786334038.git.congnt264@gmail.com>

On Mon, Aug 10, 2026 at 11:28:39AM +0700, Cong Nguyen wrote:
> max6621_read() reads the CONFIG2 offset and the critical alert threshold
> registers into a u32 and scales them without sign extension:
> 
> 	/* offset */ *val = (regval >> MAX6621_REG_TEMP_SHIFT) * 1000L;
> 	/* crit   */ *val = regval * 1000L;
> 
> Both attributes are writable and their write paths clamp to a negative
> minimum and encode negative values, so a value written as negative is read
> back as a large positive number. For example, writing a -10 degrees C
> offset stores max6621_temp_mc2reg(-10000) = (-10 << 6) = 0xfd80; the read
> then computes 0xfd80 >> 6 = 1014 -> 1014000 instead of -10000.
> 
> Cast the register value to s16 before scaling so the read preserves the
> sign the write path encodes. The temperature input path already uses an s8
> intermediate and is left unchanged.
> 
> Fixes: 92b64580f14b ("hwmon: (max6621) Add support for Maxim MAX6621 temperature sensor")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Applied.

Thanks,
Guenter
