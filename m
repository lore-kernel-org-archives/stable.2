Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600997;
	b=OyimK8uSOQV8UnTZqqL1SSraJHeWlzidlYDTrbSQC0NbRdMttHdE/Q28nN9stm5Wj9Ie
	 1wKwBBGcKk+RbzUDHF2KLKvA71ewh2xCNZ0beD1giS9bQ0sWoC0uVSsjWUYeIfr1YPp3j
	 TQMRWh5ROuz2IKgD7z/i5wkOmCeco2raYqihtFPBSwfr2lDvTNb2AuftTCIx8msl7WJKu
	 LgdtDse39z1dEjSXMkyFVPK3Ahpuwu07CpWp8iubDZXD/oEyC8yz6m28T3kUKHQE/PYe+
	 460HdiIPGkyS2wugPoq+s+032ieMO72u96FIagAyR4gX+YX8Bvk6fYECnOt0FEXAeqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=yvdKJNv8V04CuNvtL9/ky27CXMTr7ydOzimWcL7zjCc=;
	b=NzVqOIHATXaQ6EyK64hY88KQfNrIx9SWHVSsjEak7Z0flpft3L6hsrdcwjfvDs2kvjKj
	 vQMxAo33xdD7qVRJzsMKE/bQVkeOcEJoXyUyWC+Lo9Pxwzv4V7qHzVJGj87PFQDX7f6em
	 wfYc0AySKqH35CjVa4904VdQkBeuJa+5yxkyeNARAip5NTXbKkDIMOaPRGdSIjtUU/jci
	 P1ETcoP0NKSZ5zFeasdr1lLYW5gKkckGOs/4GF6PoLEUSAE5BOr/keel/rDgDUFK/0aSi
	 hxnuAWrGMVSsPfp6V4PvvfG8LBFnImkqJ9H5LCawOCZiCzHmtKfrv4cFWZsX6CZJVzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggbFz86P;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480C606A880
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4480C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ggbFz86P
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so21357145e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794600996; x=1795205796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yvdKJNv8V04CuNvtL9/ky27CXMTr7ydOzimWcL7zjCc=;
        b=ggbFz86PZ19pd6a8yEtWjlR23GMGBo70CPaecmEpktaYZ7ejxop4ikBV5MVOgkRHMB
         VVB0Bin4edGKZ5WBgJloEF18Eft0y2T1hL9bil0mEcjQCetqmBvXjwneWo0rpK7/ly/w
         EO9QR/VTRQp9ZvlvfZUL/oxz4QPXafAQsvJnj7ahdmhRN9dwG7iX9rfW3dF6DwLP/wF2
         u7UNZkhV77CvP7IPQZ3EKgqzJTpwhWrXNjODTjkVY4sw8kDX5rFVYaemcHt082sC7zE5
         QNangEb7P+jmxxIwub/uQIm/2urZf+bEeeQbAwecFBVvsrOi1Sl5P5/+BZSPBzVnzh06
         r9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794600996; x=1795205796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yvdKJNv8V04CuNvtL9/ky27CXMTr7ydOzimWcL7zjCc=;
        b=btrijtiLfAZWp9QqWv7BSk8u5irNYqSgqydhWAnlZ5RFvB/fTY6I8MaHpkRmMBzbq0
         XuODkXo3RRqukOdkuZvEKBBRmQ+c5WajyJ1bWqRbgYn7Jf6gZBdSySpDM54dkHfamo2z
         WXgQpUT3fJNvOZfetmqFoGobyeH4E3HuQiEY4Z9PpM5dns2cdH4JWeATjFwPYGPj2VFU
         dZYeMY1QxM49l5vlJJm2XPqWi3imqWwm1N0R2G3+5YwfYxPmGBk7r87U/SVhCaMg2ifP
         dpOREfXKhCgCbm/lafdIuHWYlROnY6UepY0pE3bTgmtEXhyPgHFDBP9ZYNPkvAv9RgI6
         TXIA==
X-Forwarded-Encrypted: i=1; AL+hErHtuweDiG5XfxnBpGpKZB38cGuVOffHhFiKQ5r/BilAxCVdaug3q+xwOE5tEvCO59beqFRtugc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RxUDrf6J+ZtzgqSGE3zoGwmkgkpr67fwt1UO4P2+arxrff3M3
	gwYd0QgYcWn3WnWh6hBBS78YwHR8G48qDDZa9hAK71DHBDd5dEkvzJQYIAa3d09J
X-Gm-Gg: AYBFou2dLr63TUQY7O2Fry7dwD9T5kIIwci9bik5wERo6Pox9XLYOgpImTu7sEbDVYL
	aiEz6RKCPKB36MZzZBNnHRTfoScSWmYE06XylPl9zHyKojVLkMVShpPlGVo4Rcplo2+YOeiX7Pq
	dHhQXJgrulBx5zFs7U3O8rJuMUywfB3WNEQm9EEvDnpo/o5mbjAsOfy9HVvWZ2krpc7k/l1QWuB
	dcJuVmUvi5nuJE6utxxSm+XA2DUhRuNcVoTvQ0j5UuxdoEoSYNKXgp/bRLAPrsfFstdQ4XmGxg4
	rvYy1IB6Dnf3c/edGr1+HUDcQes9vKNCf7QsIvNNap8gM54l61ao6gd5rW0PnWSzBVNr7HBY7zH
	VkuPjDFE1Uo4Gsnh/I/LvCYFikLS0cG/85p9+0z8xNOlh1Vhk9cNO2rU0zMfHuBusx2DFFdsLF2
	UD1+OZMuTL+Bx83LL7SuUpnM6Uy7GmGqPJ+DugUypNFqerQBmPdcwAvhF1htRF4rXePDs20goc7
	tAvXAEH4W4bwVGSwYdi7T+8azbm5jairHKoY9RH+C2ZOMhqaO1gCs92HZp+HaRw0zjm5AOp23Cd
	vv+BzookEYwQBTBsNlck3xM6HRDZD+t4/TeVhN4TzQrPyMCF9ntG0Q==
X-Received: by 2002:a05:600c:1f96:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4bb55a4ea81mr74860855e9.14.1794600995421;
        Fri, 13 Nov 2026 12:16:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e293540sm178215465e9.8.2026.11.13.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:16:35 -0800 (PST)
Date: Fri, 13 Nov 2026 21:16:33 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] landlock: Fix REFER in layered domains
Message-ID: <20261113.3fa14baa784d@gnoack.org>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261113.eiChee8pohch@digikod.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113.eiChee8pohch@digikod.net>

On Fri, Nov 13, 2026 at 12:24:52AM +0100, Mickaël Salaün wrote:
> On Sun, Nov 08, 2026 at 09:23:47PM +0100, Günther Noack wrote:
> > This patchset
> > =============
> > 
> > This patchset fixes the issue in three commits:
> 
> Four patches now.

Five patches now; updated :)

–Günther
