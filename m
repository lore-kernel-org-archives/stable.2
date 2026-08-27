Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05842367B72
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787807727; cv=none; b=NjQrfT57epW4dpWk2JlMVPL3sEiFMYRlJZsmLb42IwyU1TSyEB7i4KrmwRrI2mkat4tFv+jihTO/D7B6qy0n13mkKQ35Lx7z6vuMcKNVZRZ0OzgdH8OQcAJaqv2ShxSB9ZqxPRxHuAB+liYqGqlkl92vNt3JLypiVc9Y25OHoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787807727; c=relaxed/simple;
	bh=uM4ffWRXxgqJu6oQ+yqYabPlZlqlVfdb1R0U6/DgtsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIebZTegB4eJr+mUaao+KiGojl3y/Hd/7aAQ+gmQF5INzAGEtEHfMEJW1Q35meby8jlz3WQUu7kUO4xelaM6HpTY6S039GdGss1Pm/COwOEjRnwrietkc8N+OC+dHSYrM6d3naZ2RZPn0XWYJuxU/rCbducTzPSw3Oo/7cTnj3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWzX3N4s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWzX3N4s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso7406255ad.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787807725; x=1788412525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7iOkDdvwOpGToX3CuLu1TzqG3e80H5C6wqSpJxbfBo=;
        b=qWzX3N4ssA8hOX82cMRVj3LVznCWUzn7VC+Js0gAlYZWhm6V8pcHmhJPS5DL+4994a
         ZPbiRQMX4viy8QvEDNjT7moZnkqo6FtLKWMoelRbwhE+Z00cz2GEYiaO0gFnz9OfEQ4l
         VP3Ikhk7EThrbDuwR+l7Yb8lSuBw6uqLIGvJl+1qPprgthyAeSklMJXaM7hAd9Z18Ice
         NGC/e0GYavKghVXz/M7lBTJsFCChixGGIcD2qmChYTRS2BBxZA9Gzfbp8hzM20degPy5
         AWpVHI/P0zkcYmhzDlI9jGA1bSmFCqinAqHlcP0w5u+z+S5+Gk1Ms3ZvnMcwYSncqjRS
         zwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787807725; x=1788412525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7iOkDdvwOpGToX3CuLu1TzqG3e80H5C6wqSpJxbfBo=;
        b=iyFMbyR/RMyVX6Qjfy33NPt4Sa0YQjCyoA/pkUlnqLZgHnlz1JP5QIAIPWDggZnnpg
         U148/zWdwefid+7lOFSGCgo6bWScJZdLxk/CIvPmFzBu9Br91Xptoq2ToPWZiThPHKuG
         S22ICvLPKqv9q3WhtNwX7IAQV3HupLrQ/cy0RBYnIXOkA2fFylwFuOv84CKXwNvarAsG
         wzQUtd6F/fdZ23XnJSBMiW1QG/rMHDYq6JeCyaWABTzTvTzehofzfafpSQfevnyK+IQN
         +37hmaBJZMEdUorwpLN28Zz64B6LuVWDAiBJ+BM6mEEH47nKzJfB8Yo5ewfAaNJMotoj
         gsRA==
X-Forwarded-Encrypted: i=1; AHgh+Rp//IbsQneXKfAPp80Lej2wQvJeomw1/nt6Wkxl9dVdn97zUGJSpV3vuaOCwfLeMpvEt1cczfk=@vger.kernel.org
X-Gm-Message-State: AFuF++nTSlPYn53t1fdjESgghN5nN6CyGFVxED8Gz1XAFBvpYy3jzKx1
	Gbr9CkGlVyHWMNnxWBhwaKN79Q38rsrITnYieNNdHwm55NUl152MFDDt
X-Gm-Gg: AR+sD13h9E92BpTAHlbsY97Rrstd17ruJ1JYxL8633Ju9/YMI0/ImGaM4P3BzJOiQAt
	muuhwIutIQau6qDhs6/IyzGM8+I2Ys4aXJXdR1RHNGiIWxHbl4Hs+Mjz6y5Hcfjr8eruguX/j5O
	pzRGhIzCp87e4hzPC1F2LvjD3bDKfxot+ifTXpfaWgFcDyfA/a/0UjIUcP0UwErnYTURZjU6JKQ
	HSdhv/waEexGVmG8YCa3Jmno/6rkqMHTs5UjszedzQPd8sYxm6Y/2eFvbVhPLgN/YaFBTzgoE+H
	0z2vJo9YK2C03kjh+GC9O88xln0kUGzfp0w2wyeCQAfml/SbLCDMEzk95A4IrCIEyIJL9zFVG3b
	wIkSRiTbeyWBtUKY/Id1o2HSqUWYkaaB5iBVb4CEQsZpHXlXsuT4P/N9yHP4lZNi+/00pIOu0a3
	sSAPXGZrTeoPq4UU+8+e6KBlGdGrzYNZZ6PbuJzfbRmnMytbI4aZuh8ZDv22GUyKPGpkTf1lRJJ
	JXM
X-Received: by 2002:a17:902:f647:b0:2d7:1cbd:9ceb with SMTP id d9443c01a7336-2d7269d6badmr53564155ad.12.1787807725203;
        Wed, 26 Aug 2026 22:15:25 -0700 (PDT)
Received: from Default ([2409:40f4:1012:4330:756d:2890:a615:2db9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d730c3csm15176377eec.9.2026.08.26.22.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:15:24 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dwlsalmeida@gmail.com,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	stable@vger.kernel.org,
	syzbot+c7fc4794e59786f5b4dc@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] media: vidtv: fix uaf in vidtv_bridge_on_new_pkts_avail
Date: Thu, 27 Aug 2026 10:45:08 +0530
Message-ID: <20260827051508.13989-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082737-traitor-shorter-a4cc@gregkh>
References: <2026082737-traitor-shorter-a4cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 06:51:21 +0200, Greg KH wrote:

>While "fun", this is not a normal path that users ever will hit.  See
>this thread where I propose tainting the kernel if you attempt to do
>this:
>	 https://lore.kernel.org/r/20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org

Thanks for the reference. The task hang is not possible
then. However, the UAF will be triggered anyway as we are just simulating
an unbind. Even if the driver's .release is called naturally, if we are
streaming data, it could cause the UAF, no?

Thanks,
Jeffin.
