Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360749B21E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050351; cv=none; b=XaZtdn4bFpGsQzI500dAB2sW0wn00r2L8DEJ4uPkZz2i5uQGNWddE1+/x16SlbFa7hnCbVTbkCuDimfryBOea1bCtc4n8TURoAr4hP9yRjrRyBLZ7vkhExQgdITgOywhuGfwhB9iVOc33jqIRRYU+9Cpk7qxGfEhp3IVKw5A0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050351; c=relaxed/simple;
	bh=GbzbfXdIPVJnGozDhXJM7uFtsEn1WNvKI9fq6la9D5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxhqwLFQMuZpd48TV2xJ8QgJU/HPydZa0mDr0B6MccKvFnI3TJRGYlW6aw4IofDBerarOZrxPCSUJUK9YeLOjTXWM1gqh+7UQfBNH0KLVDfU1O2Z2sh6tJO06bkyz/IbBuJRhBP/napmqhqcw5mxKG2jGMEu1iECyS+QIB1HKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huT1p+0Q; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huT1p+0Q"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so408361666b.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789050348; x=1789655148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EmCbLYEUB7kSZyxwCycLxp9L3iLwlal6dc4efBNBV4M=;
        b=huT1p+0QSo+DSdrA1ejCOp3UfS33hpr98szjxoqbBT0i6u/s0CM2u3QV7zj11t1nt+
         NRcGjWFUkbuJPZPInjBlSyixTYMsQEQyqF1c9kr07N6yxZ04gtFC5sI18kvRJVnshYoR
         PTw+GkYIA4uC5rZ1fy97XcUqNfsq0TpD0XYzDDVLpcCeQAfWdvp8CrPZ2288MkIiAduI
         ogTy0SFnmEGyeRrZ+ha2SZkzmznUUmEg9ZsoBMNuZM27k15dzvdltfhJv2YcLBQVKecT
         gAhc+jDeQbLpyX6GghQ0At47kkYCsh5c124ZCBFjN++f6YrGSZOs1gG66+sEGqZ6KY2h
         9bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050348; x=1789655148;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmCbLYEUB7kSZyxwCycLxp9L3iLwlal6dc4efBNBV4M=;
        b=PGxcgJliLvwZDd9T7+G7GvasVd/yuR1j6ncTB94BoQH39J4L9yQ6jmbKEJY5M1whHF
         RiZhbrStIuv9e05a507XeVRlp7MNAo5y4jScZ1YRW1k/+x/MmUBpt+HTlLhMf9m64t4z
         miaFuJLDM2fWUB1RA0iqMg6KwcCPKOoYzYY9cejYhjtWJKdCanPgf1V0F7iQMeqQxDVe
         6UBUViUMoL9BruMOWuVJ+hH8DA8EtJqVq3o+DF/kQRh0SHrpob+B3tUN+nPVJ2tWpVDs
         mGJ/xf8C86RyL9djvBXsQV2Oy6yev68jwMGmi2uxmUeiKl5aoMqTPP5YmSYI5tDn2mmV
         HJbA==
X-Gm-Message-State: AFuF++kMynkwcc8ZLsSEqwIyjdwYaWj6LOh7A8BoSf23+EYSdrU7/jR3
	cdxFl/JsNKp+KK0AIjG7kHpkXHFEwZMTBPH0pUeqEK+c9j/G9MKbktpw
X-Gm-Gg: AYBFou2kF/7cJUPQ5aVkW7ym25vzM+wRZesjCgcblvqJGxb/jOr1gvYT99j5crLjSdt
	DhE1Levv9XXOpVUhadTKc8Qbk4bTLr04w2xGZ9CljcEbT6zSmWv4j4NZ8Jr1caQXpt7KhDQixI5
	IqA1TS/rkOrKl6i+M+cdWJ42DE8e5u1//DECd3k0SbIWpFtA5pDuMS/RNF/0L1wV/nhd69hoECv
	h/GFXGEGWix6VisEQlVwGZrajOimJGLBisGrmsMPI79fP0jiLS7/hwkwddBiF1TZS4CtTWh82/M
	TqjSTKFPZ3GNZpag4VLsPDFlnG2XGSaTmmknU6yQ4NhIqfAbyz8VdfuuXmn7zgPUL+dS3yO7Ujx
	aQ368QrkuYm2fx74FR2sCo8eFjUIp2soqtAiLgR8kHEAdVJX6Op3RKufmsDUXuSBTJkk0/nmEqD
	Qc/lKfMFsafrG9vENzg8MNTBT/eA16RgQz/LdLZSP5Wzh8GXWQNaeEE7Ji3Cbcnl1pfTy7E8W2d
	TWdmZ9+
X-Received: by 2002:a17:907:9620:b0:c29:462b:f917 with SMTP id a640c23a62f3a-c29462c1f75mr494346666b.14.1789050348235;
        Thu, 10 Sep 2026 07:25:48 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2951217d12sm84606066b.44.2026.09.10.07.25.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Sep 2026 07:25:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:25:43 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y 2/4] usb: xhci: Fix sum_trb_lengths()
Message-ID: <20260910162543.2d3894a4.michal.pecio@gmail.com>
In-Reply-To: <20260910110830.4144529-2-sashal@kernel.org>
References: <2026090811-curler-hatchet-10b9@gregkh>
	<20260910110830.4144529-1-sashal@kernel.org>
	<20260910110830.4144529-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:08:28 -0400, Sasha Levin wrote:
> From: Michal Pecio <michal.pecio@gmail.com>
> 
> [ Upstream commit ae71f9b88e5a15fed17a432e21c30ee9463ed1a4 ]
> 
> This function is supposed to sum the lengths of all transfer TRBs in
> a TD up to a point, but it starts summing at the current dequeue since
> it only ever gets called on the first pending TD.
> 
> This won't work when there are cancelled TDs at the beginning of the
> ring. The function tries to exclude No-Ops from the count, but not all
> cancelled TDs are No-Op'ed - not those the HW stopped on.
> 
> The absolutely obvious fix is to start counting at the TD's first TRB.
> And remove the now-useless 'ring' parameter, and 'xhci' too.
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Link: https://lore.kernel.org/r/20241106101459.775897-4-mathias.nyman@linux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Stable-dep-of: ff44dfb03a29 ("xhci: fix lost bounce buffers on TDs spanning several ring segments")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

grep Stable-dep-of -r Documentation/process comes empty,
is this tag supposed to mean what it seems to mean?

If so, I don't think it's true.

Regards,
Michal

