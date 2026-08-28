Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA73164B4
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959089; cv=none; b=lhO+rKzVhGrab3jmglPQgYHqyTcsM9rLb6KndTStlGa0US01lZzMBswX1/DLyoe69DXw6U6PNjiLziMgeATQnOY9PguHnEy+sf8D/LvkmEUv/BxugNc5qDNgbJm4t4pZFWvRtKSN7nwm3SDHxrScKUajSBZ1h/YO4Qv72AxH/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959089; c=relaxed/simple;
	bh=2Lq50lUytrmm+S28IHrLjU1z+wrPGA3wstjnNQ2ei3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSGJ2nuf+2eWIjklTu0vbrTuYdKbOagsGAj0htr2QDaQZgJGMfoqrRJwJl91cAl4qSbv1lj7eHNaqI6zDVBEeWQtwdQYesB5iGMUJTE5w3AXxLHT1Em2GX6cPAg2he6nRDgg3kDMolKQty5HOv5iBaqi/FL8gQePUkUOFHWr8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLnoBw8A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLnoBw8A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso18615585e9.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787959085; x=1788563885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3a//jCzePczEVRzcT1fYsbmZwFdKhukTh22rftAVB94=;
        b=kLnoBw8A2SE1sEizMYuYmnNmzWB9eRQAznDLYbnzLbCQRWzN+yytbcOpBJV2VE8fua
         uoXPNGmdKEwmg7oE6O27cR0xN7lSeuQ23B4LBwTtORyf5ELazXk9wKP6MNwR3UhEzo9C
         w0B9OstTDgTqDAdZ9yXK8PfF4945YJQ2+Fus3/L533LYXhH6K8KtcO5CJXPIlCmsrfJL
         6BQKL5CEOWuz9ta3pjn4H/awJWkfDE0UG9jItlmCf6O8s+V7YJimjtHXeg8/n6wiYSDe
         i2+ntCivSImVglN04yEQrgTCjzOXmFTwmf5JfaDtk8qoRXedbz9boACIpcxBlAilJsxm
         O/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787959085; x=1788563885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3a//jCzePczEVRzcT1fYsbmZwFdKhukTh22rftAVB94=;
        b=qSXoKd03N5hm2XsXHK6cjuGbTCM81nPNd/XF8B+YGgxAfhyvGGsZH5q9QrsvxoSbhc
         z8qSyz7tizgZwf6+OL8bK8KiBvEF2x3aGeLLiOIzT52wLmNpmt1dAyT8o8JazyYGwQb5
         2eq4iZrptNGk/OH6txf3QYjSrDDf6YHT89pNSgMwzl6pvz4hRB5I4C6W0tW5Adxoy3hZ
         3FW+REsacOnbz59lHzk7pjjKO4bkS5RHBr6Z0HwV2EK656d+3a+ROq3z2LFfk3qk57GK
         o+lhFjEe3D3ff4NApnlbityiKrPJmkNgkS47qhbmLBiNf4IooAWNFYIhNMKA8OR//XUI
         bREw==
X-Forwarded-Encrypted: i=1; AHgh+RoLXhZ/EIuySLboepJKMfuLqE3Zr0q4GAfEmx2pyq26Yw/AH7phMfbKFFf2t5SGtexUpqvv3F8=@vger.kernel.org
X-Gm-Message-State: AFuF++l6DpkTrNxY82cumrLo+/S7WEXjMu8CAmfpBj43Rv0GOIFqBPS8
	JXW+gJ557MgDk2M0NKP/ksQWsRxc/7hq/JS7es+fwmgtXzBNANsMayr+7oi6t0mq/iba
X-Gm-Gg: AR+sD10Btb7GTVywU0PyNfC43SvI2xMqN5IOw0m52BGXhLkg8o1UaIGK2Cf7bK2TFEp
	3gN1RS8T4EYt3AZFnAIsqB0qP7NGcHNzqfxNLrZFsrYhVnov89SXjGfIDBUvDBkZQOLZDiE+TiX
	wIyPC2G+BbJ86emFKxhavyn9KwR7t/YBgs7e6fdKdYRNOap+wrt5x7jUPqyoT7gn35/EYNww/xE
	ISqt20oUy1LFPFoGUYCKdd2+5d6MACHrFVzP7+HQupXMvIKy3SBPZnB5GF5KFqrmq/uvrgUkYCi
	shJaHrwBUbzv2o1nOBkErtxGwoBIvd5LP95cphsg/xWTZgMcXpEpxzBAUR9j8Psyi+WeGwXXLN1
	SnHx5+MLIU9dSWt9OEQz39zueRLLb6e/ksss5L/3LnXzqSC4YhFb0MFOkRNtDXPXKp6TT50B/mH
	LQAtnMphANRK3A8wSYyym7z9+Y0c61RElGqfKLdLL5B0Eb/cojfaffm5jDOb4IAnuCLdi108I+5
	43r9RBn5C78
X-Received: by 2002:a05:600c:4514:b0:499:900c:9c68 with SMTP id 5b1f17b1804b1-49b91c1f2a2mr158027275e9.6.1787959084902;
        Fri, 28 Aug 2026 16:18:04 -0700 (PDT)
Received: from surface.. ([217.61.227.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4942298fsm164518155e9.1.2026.08.28.16.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 16:18:04 -0700 (PDT)
From: "D. Manresa" <dmanresa@gmail.com>
To: Jakob Berg Jespersen <dev@berg.pm>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	=?UTF-8?q?K=C3=A9vin=20L=27h=C3=B4pital?= <kevin.lhopital@bootlin.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"D . Manresa" <dmanresa@gmail.com>
Subject: Re: [PATCH v2 1/2] media: i2c: ov8865: fix horizontal flip control polarity
Date: Sat, 29 Aug 2026 01:18:02 +0200
Message-ID: <20260828231803.29776-1-dmanresa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729-sp7plus-ov-flips-v2-1-91884b81a8f5@berg.pm>
References: <20260729-sp7plus-ov-flips-v2-0-91884b81a8f5@berg.pm> <20260729-sp7plus-ov-flips-v2-1-91884b81a8f5@berg.pm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026, Jakob Berg Jespersen wrote:
> The sensor's native readout is horizontally mirrored and the FORMAT2
> FLIP_HORZ bits (reg 0x3821) un-mirror it. The driver sets those bits for
> V4L2_CID_HFLIP=1, so the control is inverted: HFLIP=1 yields the
> un-mirrored image and HFLIP=0 the mirrored one, the opposite of what is
> requested.

Tested on the rear camera of a Surface Pro 7+ (OV8865 behind an IPU6,
patch applied on v6.19 sources, module built out of tree and loaded on a
linux-surface 6.19.8 kernel). Verified from raw captures at 3264x2448 and
1632x1224:

- HFLIP now toggles the horizontal mirror as requested (verified against a
  fixed scene landmark and by column-profile reversal of the raw frames);

- the Bayer order stays BGGR, matching the reported SBGGR10, in every flip
  state I could produce (HFLIP/VFLIP 0/0, 1/0, 0/1, 1/1, both readout
  sizes) - so no phase compensation is needed on this sensor and existing
  colour tunings are unaffected;

- with the fix, libcamera's HFLIP=1 + VFLIP=1 correction for the 180
  degree SSDB mount now yields a true 180 degree rotation: the raw frame in
  that state is an exact point rotation of the HFLIP=0/VFLIP=0 frame,
  where before the series the same request produced the horizontally
  mirrored image.

Tested-by: D. Manresa <dmanresa@gmail.com>
