Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349935C687
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570589; cv=none; b=dNRTi/9PYpox3AbiaZH6QDhEOgS9l9tXDrCxRXkujIf0TFN5x9VkbMsZHMHe297BVBf4HWB+K4qkJ9uJG77Zipvbao7DprN/smtteCoHwf1/xJRW+FdwU86MuppnEFtBQv5JpTaXzAJgqpXJsH5tVirH4NpZsGk6juDbi8JpofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570589; c=relaxed/simple;
	bh=w5hmfYQd5qS6jmp5if4MTfMkG4gKJAqCpM+ctVlrJx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRMGE5DH2m8DblVR0BOAOYSXquYVRGZp7U7CYAyV6Q74sLhYgWXlkATeRktiYXDzB7udRvz+LLTsNIb0OcovTMwqjoena2DNHj+nfGDe7Z9QOq1xtuAggSssoHlUOzvuh62JP3UUfjerqGq+1aVbjApkVPYDf6GbDJgasjWiIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpsB+0pX; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpsB+0pX"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d9004a1ac0so7645175ad.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789570587; x=1790175387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fOtt4epAjEgetEW4Rf7UpxEkjN1u8RJ270fhKCbRhRQ=;
        b=gpsB+0pXhV5Fpk8oz8ZAIm1e0F4oG/SJmYb8KutcgEoeU5P5gRBEKrOTTOmuVSszWx
         /sgU9r4nBZP6Ne3OZjTW0ZJNsMaGgR3HYblsJ8JyO9V/bcATeox1PrPLWL6XihGJ12Xo
         U0gemKPW3fIh5pvfnbrYk9orM+IzDKn3hN/2A8Luoc73QZpAITuQ/U+Lyp6AghAt13P9
         323JOe8rt8BB0Q+5IpCDQnnVOJFFN83tHNSt4D2xayA7VQCOxZOiMEpijOypzwSjrMRu
         CV0YVG+9j8Y507nBIm4Hp1LmqNh9sKlMnulMvMb1wWKZlzj0Bhg/MU8TkUgHnkhDvyYw
         YQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570587; x=1790175387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOtt4epAjEgetEW4Rf7UpxEkjN1u8RJ270fhKCbRhRQ=;
        b=qbuznsiDsV96UQeZ808S1u9VogSTXrhGMUsfjrEOoXSOCaYtpq6F0lVh8rol6+k/bh
         WHrGS20eDAGsuSrhDh4ydmVzBjIXKzeNb4f4V39jB60LcIdMUddxPm/wnCOus7OGwyZU
         uxBWx6ix75wPIoIQQrv9JbV5/yzr5s+JsqR+nT/fELxR32K2cKyF7ILlH8y6Sd2dyKSm
         Qt81UkI7f7FpXeLljqAF5gyc1cVHBY0OsdX9Gcwper85FvoV8Sn0rqydkJJoAhYPk+SU
         X9Yz30rN3/H55UkcNqhkdbUuxY3gEKooWH1n0HYydd4e297xjFK/1bRFofSHIhM3u0EH
         eiRw==
X-Forwarded-Encrypted: i=1; AKwUvBzN5gChkLVr/jWlJnsnDAyBXxBPLgeZL7CRLRUs/TmW4i8uMEZiphjDxQjZtgbr8+ZhyEPXdlw=@vger.kernel.org
X-Gm-Message-State: AFuF++mZxgSNRN/A9wOD1H98EPItwrYxGQBGGNJ8lPX7AH1RhYvvtKEL
	HoRQ/KjPg21QdpG4UheI1Lvm6v4Ot2xEQIOXqFmUxgQNXmhgchXuaKUPPbWDIiqk
X-Gm-Gg: AYBFou0s2vSxu15Nd7gpi9M/UpRm+K1o3PY8gSOQU9NvaX3Jw5lY14MLW0RY82pPoE/
	ZO/m/mDBhUpLBBunzZQblTevTZdETGDX53cUP1DTyz18pWBB/PgodYwJYMcVU6ahqDzMySUI/ee
	bxV52E0Ipz7SZO27bOPU6DLuEkp5C0WJx59o1Zg5ifT42KnwdLiOwhzFzVDFiZfhEXrIGhWY1+O
	3738LDmyC7JJCjzevif44PSefPMizKOaMP2s3csVC63gUzaXfmZYLnzEep1PIV2xvZ2BzBM+TLy
	JfIcN1NLFc/yj4gDvtHnpK8gefqycjZPSNIv+UXuLnJNfXmimoTjjE/E+zcNtKK4C4Djkpnhb5h
	V/FC+kVW+n51Vzv2FM0QNobwmz1niMYffFBQWCRvtwC52NRzQ0raHxyjnTiFeFrWml9zsd2H0VG
	0a90DLVIsaShy2ZpbkVmTo3ErNxwgP2b5+yPne/30i3hucVG5RCQZ1GzAcSnGCaoXHV7sMvz2w8
	X21SNyFt/jM
X-Received: by 2002:a17:902:d588:b0:2dd:7593:8634 with SMTP id d9443c01a7336-2dd8e412565mr65993445ad.13.1789570586585;
        Wed, 16 Sep 2026 07:56:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d8fe00sm13413325ad.12.2026.09.16.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 07:56:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 07:56:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] hwmon: (pmbus/tps53679) Fix TPS53676 phase page
 decoding
Message-ID: <c0a3c877-eeab-4cff-ab2a-bb567f0dc3d1@roeck-us.net>
References: <20260915164823.160977-1-sanman.pradhan@hpe.com>
 <20260915164823.160977-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915164823.160977-2-sanman.pradhan@hpe.com>

On Tue, Sep 15, 2026 at 04:48:35PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> tps53676_identify() reads the USER_DATA_03 phase configuration to count
> the phases assigned to each channel and derive the number of PMBus pages.
> In each 16-bit phase descriptor the channel (PAGE) is encoded in bit 4 and
> the firing order in bits 3:0, but the code tested bit 3 (0x08), which is
> part of the firing-order field.
> 
> TPS53676 supports up to seven phases, so firing-order bit 3 is never set.
> As a result the existing test classifies every enabled phase as channel A.
> On a dual-channel configuration the phases assigned to channel B are
> therefore miscounted as channel A and page 1 is not exposed.
> 
> Test the PAGE field (bit 4) instead.
> 
> Fixes: cb3d37b59012 ("hwmon: (pmbus/tps53679) Add support for TI TPS53676")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

I'll fix the other problem separately.

Thanks,
Guenter
