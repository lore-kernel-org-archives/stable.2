Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54532695F
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795752; cv=none; b=AjgMg/5+Ei8GlRH11azrPa+AE5lNSKie7QaOCkT3OFUhNvOsDoLhR/NrjXwT/lUKkmUAR6hK/h4U9mibjKP144guta0dEimcRtnc40AI1eJMXuHw9nioxCbU9dRdtpY88xQvKlYf2r8ssPnOLALNmjODfXX79JlYl67bfr4eKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795752; c=relaxed/simple;
	bh=ekSDbC6S/5AfZ2Iah9TGW0ydX/g6qRFKlYWSxfRX59A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIwvkcHMD+/v+jsgan2LAxgpquULd0CmT8Fe0WdGalSJxm2yqurNt2cSv+VURZAUIxJUfN1S3cRB8bWAhSGS+m+wDRDIIH74rJZX7ymkzuhQytxh5qbK9VBswBmiULT7mu2nPdT2MAzUE+ERuAC9gsWmx2Ukdjq29AS7cxwtLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJKLTzOY; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJKLTzOY"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccff31419so11723995e9.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789795749; x=1790400549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ekSDbC6S/5AfZ2Iah9TGW0ydX/g6qRFKlYWSxfRX59A=;
        b=IJKLTzOYSCrsRRFWzva18ymo0fxc8p23icvyB41lEzhUTKksA+L3AZuA4HqgINmgku
         mBdabaHYIXe5mMVok9iRle8X/tCJIakd+3sDgTz6DBPtvuo9I4zXvtl+kQ66SoWv49Y+
         CnC3C5iY+I2Rg7Pm9AECE4h1mF8wD1XD10PxuUE+u9QRWDVFkTk5C1Ex/opZm94/K7To
         9TTpJALXzSvetc4K2Pg/1rrJzidDIQLasisu1KZPVnaH4Zaxvfd5qaekNbS2EzZAxozQ
         luDjGOXZaSwBdtYBwr9uHN9Zt59gUKt87JCSkdLHn6dmERiLktz8Bg4fcO1uU3qgLaOV
         4Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789795749; x=1790400549;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekSDbC6S/5AfZ2Iah9TGW0ydX/g6qRFKlYWSxfRX59A=;
        b=pAXbzxm6IGvPWXtAvINSJHfqDU/fXERzooEHOxjqwwVImrILgPhY/SHoiKIjrgF7O8
         YbMDhDeuBU7EJis16OxaR7xitNeruuPgPEkpmdHL9kZf/SLFH5n3cFg8ZfRuhA+OQHCT
         EZ/5b5GvV0RcuKyGF39JDW5UPeRKjH0BUh/XGHxtKcsTCWCjEaUnQqJh46lmnOWT5lKk
         JMCT4nou37btu2qGKPdCsilAzuLnWL67RxL7lBtl/emmixMS4KH0snXrMu4CrT4rIkm+
         3NGA3xbeYAYPirh/eYgu4PRjWP/VfbFs6nPoXIjADQcUxvi5zMpzywPwjs0UpweFtvAD
         KysQ==
X-Forwarded-Encrypted: i=1; AKwUvByc9ct1NkbafBAUGLG7+EZBEzSN0TsYSwBSibxFXYMvzI+6N5Zs/U4LgbNQKrMSJaB0tuP2CmM=@vger.kernel.org
X-Gm-Message-State: AFuF++nLTdtYP++3IqZhd5YN+U3MBotD2oH3xQOlJgawHFDaEm7Vy5UB
	zP49heGbM4IcWQgsBWcCumEaoBViCdS598anwbaoX9aMQ7vxtYy7dbR/HvSTB68Z
X-Gm-Gg: AYBFou3oahvanYZzA/grnqPeymjDax183JWzqPE8WD4FxtbzEf738Xgqsin3N23Ku4B
	FAz6QVePhc36lQPkKgiJi4Ib+cjtawaGQL0BI4T8GHda5ZUPEiDSXjrLrkyqfTyEIqVd9FJXydd
	34AxEGCGpP6WoIgPBJizlfT5f7T+1zLb1JQL3leuPr7Q0ixfrX4xdJ8eDGjRob4wVnAcrKalJn1
	CFfk+YzSNLwbtBzCStwSazpDwaaUWDRF8+Gc2W8OfOMYGeM0HuhvBUOd4t9PUW7hsiR5QciDsje
	Cw5husguqeMcJY5tHdza2q2pm/B6/vmrjlTQSvzIu3+tC7g4BrMxxCHC81v9WpkfHx3yZc7WViA
	LWmWt5FgSdYSwsPsEbi5IW+FmmXuU8Fd7+tT+6FqvL35uhht7Clo+DWSY4HhGAUm9rqOF2xo0oh
	OsxxSGjZyz9KnrrCf0KYOaepb+uw2+pH2rjK09WsDsd0k3BvbzIjm95mCCBhSIj1wpJafurakfq
	FmKz7qA+jcPR8qdP+XQz+A4OHTb+FWB77buJXW5YPgtKOx207MLs+HI0yVG3hgy12qZKMrOjsT9
	ZQ8z0TpUz5r8k3pIDsztF2GLAoXjiPT3yRKV5Ywc/n/aQRgQilsfDSp7vLPf7PnazEsyZe+CKAU
	XU9VRa2EnIDlNn4mk
X-Received: by 2002:a05:600c:3b05:b0:49f:c196:47b9 with SMTP id 5b1f17b1804b1-49fc567318bmr60705515e9.4.1789795749070;
        Fri, 18 Sep 2026 22:29:09 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459d409sm4258691f8f.33.2026.09.18.22.29.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 22:29:08 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	=?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/vc4: hdmi: Unregister the ASoC card on unbind
Date: Sat, 19 Sep 2026 07:29:05 +0200
Message-Id: <20260919052905.26038-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260825063735.14676-1-kmehltretter@gmail.com>
References: <20260825063735.14676-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 08:37:35 +0200, I wrote:
> Register the card without devm and unregister it from the component unbind
> callback, where both the HDMI device resources and vc4_hdmi are alive. This
> makes the card lifetime independent of when the final DRM reference is
> dropped.

Friendly ping on v3. Is anything else needed from my side before this
can be picked up?

Thanks,
Karl
