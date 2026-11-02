Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610857;
	b=cDFvNcNrov8OIVlujy+ES6BP3+4hsg4WEuiWDQ+/E70sNY6xfHHoC0lzHGoGTCb7+31Z
	 NXjc+ogiV1cfmD7c9LQ7sSYA5H89/fIM160C+7CqOCiOmMA2zpoUuZCfmcDOxq42v0+tr
	 NSmWgkCZFB4EbRd+zUG6xf3c3CXzYaKMB7di7IG1rCqbnwlvTSaV62y+cm4Wt+ADpQx9o
	 aVWDBtaoCs/kYUHO6r3slw3lzYU2TzjF50zybxlCLCSTiRhhoD1znyAN6XQ8VqwMHd6vm
	 /8rcvpYFXyW5aSZxWDHnS8oO2n+BFp64F9e+yGcgkjL9167gGxPAkkrhCcYQCX+rqEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9l2X88+Cluso3aHhPPG2aCJ5eE8RQhXDwPSZjiqGEds=;
	b=KLCn5leHI5f6mWz7y1fVaghKp/HJx79M96fQuZ3qV2e01YkPxTG4P52Pb/PkAOAeSsa6
	 ILWOTxm1y0FL7GNPD54JVZ5fKjtpC4nnDpQFhdKfSimy7FiyRJyRn3KNAUt9OEQXHIjxA
	 t1CNrbNOKykGCK9H31c+7zlaUJ4knQqb7c6Z90pw/NBZ+nQsdJFJvL45KG+GbNTk/AXow
	 NBB90mlbwx2+wKVNblltK2m8Y31Duk7KrsK1nUPJMxEBdb37eQ9OhisCdh7fFjaCDi1yD
	 jofSbQFnSqqFffC7XRB6aDcAB9O0x476HvlDL5Krx6ILINNLyFr8UXE6g7kclXtq+WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0oM6kP4;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF9606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EABF9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0oM6kP4
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so4317444eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793610856; x=1794215656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9l2X88+Cluso3aHhPPG2aCJ5eE8RQhXDwPSZjiqGEds=;
        b=f0oM6kP46WR4dmdZu0WgAUymTn0f6gib7tq7NgaNKpL1x0Ew3T/uU7llBroJvV+Yqp
         y9gsrGBzR3LkTSLRZp46b8lxFfMlMOAKf/ikLXnN66MyNxKes3Ib9LG0MaFOEHmIqMLL
         jcIuhkf6+bP2mMn71EwG9UxoY8z8eFMvLsjKzZ7F/uUBGZAvqdc1tJn4wRXfGS8iuVf6
         FHz3yQ080CjY6zSiAJlgzJ31TMCBWKgmsOUOAQBC3DIaPjlpT21EKOQKJeeq4OV2ViCJ
         9dZmIBxc+L4u2wvrHmf0J/f7k0tquIUphnL0xZrN0tr5yNNRJM48bFmq6yvFjIBYQnqV
         M7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610856; x=1794215656;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9l2X88+Cluso3aHhPPG2aCJ5eE8RQhXDwPSZjiqGEds=;
        b=VGsE3aTnnGXXTtL6kNrchjERSfx5KkecPllJ3OANwKZhLKAOPCXQzuIOONDClZFe5h
         fS+Kbzmif47cgd+oEnhqdopw1plc9NWMc2L/iBtK7J2Xziuhn87c9QLjjkvPt7Fz3Qtp
         k/Km3EZHj+k4btZxxpHIzsDpa+ol6ZAGST4gMJcc0rkWplDPQGxMDbNiw9VYim2KmtFu
         hdmBaZfSXhz48PV2pFhccgElUZxp2/pN5kA4mtw50mVLueefI2aCG/yREHoCrSbcUGKQ
         9ViSwpWACitTfcGXBPS9LMgpq6sfrTHgm3me1rU+G2/Bpk8eWxnuKOyxHfNRwSKskiQ8
         QnpA==
X-Forwarded-Encrypted: i=1; AKwUvBwFDeGC43F8Eyhw/ShhR4fSdg45NSu1tfMGJdB3GpYeKG8J2HTNhgZSyszM58mvwoScw68kWCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LhiMta6rdSHTkY9aqpm41GcxzYcrsGwVA0k/Y+kZpRaZeebla
	nqRJWIdDVFcAeFdzKAXbcnk2C+Ka/3L5uhtH+dtOo3M6bQwB2tVOr+Sp
X-Gm-Gg: AYBFou15xYDpLaxB/nMwG05I7pq0gnKbRFqfSDbGuNHey0PAw62WdmawAseeAhESCU2
	3IXnIKdv8kkgOZLXru9sCZTCTzvX+XgWuthn3owNK8V+C0ir0ovvhqt8FC1bMF5LpjuZFjYcRjG
	Xdb1EUW3wRM7Ef5Ka+vV6ESXUFgmVRZ1SLtK487IxrFNIHLHMnZIQYRPsk9BA3DzlvoZvO43w4b
	tcKRsTzGK51KmrL/CxPLCp4M1RzBd7MUQ0Y4lGXlqaEn+dP8aKyG0+Cyx3m7dX8B/qp8+nVWPRL
	4MskXj2v1WrXBlLB2MI/yfFgZOePyYpSs1Sjq6xNwmP2hLA9i0he7XaHMPN1vEpX/CmA7RyGbza
	goHIVdfQDMwFZlotVuLp/11rlzCflyZAeJ6KT4/71awgajfKA8UxhtD2EjmCe0OGcby2ooTL0aX
	W+T2BpHTTVWfT+w7dk8PJXsuVKMTKm4iWfqpL4OFVSB4FSYnlk4fUCOh6PsaBgO/r0Y16vI//pm
	yjhjw3ODB2RzTumgeMA5/1qDFtZVTEtisdUEDyAj7kqnP7qv2Sc4GnaL2ID/s1nz0hJ0tH04Aoa
	pxibAzZf57VKRQm3Cdqn1hPFFBIDhckcfudCVBzjIvxmxFQKGqfmV4DhpAixGjuWhtfQSm7NBfB
	97UM7zpmx0Ov7Z8UGkDtsgUIk8Aee7VDu6DD4G/PUgnS+XREsoEeuP9+ZmwwsXTTHZGFHjYbn0X
	/YUMrYXNGwtomt10GcPQ8ZXfIEmiAL8CtEG9dt1ok8BA==
X-Received: by 2002:a05:7301:d198:b0:360:db68:3264 with SMTP id 5a478bee46e88-36a42340756mr15320792eec.6.1793610855684;
        Mon, 02 Nov 2026 01:14:15 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm41886949eec.25.2026.11.02.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:14:15 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Mon,  2 Nov 2026 14:44:08 +0530
Message-ID: <20261102091408.246416-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <108cf042-5f7f-4b1e-9656-3193744e8043@amd.com>
References: <20261023185652.195025-1-kapoorarnav43@gmail.com> <108cf042-5f7f-4b1e-9656-3193744e8043@amd.com>
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

On Mon, Nov 02, 2026 at 12:41:59PM +0530, Sai Krishna Potthuri wrote:
> ams_init_module() already copies ams_pl_channels[0..9] as the 10 fixed
> channels. Inside ams_get_ext_chan(), since ext_chan = reg - 20, DT
> entries with reg = 20..29 map to the same entries and it create
> duplicates.
>
> DT binding requires update to allow 30..50 for external channels. This
> gives a maximum of 10 fixed + 21 external = 31 PL channels, matching
> ARRAY_SIZE(ams_pl_channels).
> Please let us know if you plan to include the binding change, otherwise,
> we can handle it separately.

Thanks for the review, you're right. Channels 20 to 29 are the fixed
ones in the binding's own table, so a node for any of them only adds a
duplicate, and that is also where the extra 10 channels in my overflow
came from.

I'll include the binding change. v3 will be a two-patch series: the
binding limited to channel@30..50 with your Suggested-by, and the driver
only accepting 30 to 50, keeping the capacity checks from v2 so a device
tree that repeats a reg value can't overflow the buffer either.

Thanks,
Arnav
