Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795846154;
	b=DbKPlT2HzkrBv/yqCjelLmNGl37NP8nPYwRTzuCsk5GO1bcpVf4cFUTwqpigxJkLmGp0
	 zJlMPZkUerhLxShW+HU1jpQaZYqe/ypa+TmxlP6r7UFZxScDDg3v5ZAai/Ep8oy8o4G97
	 ypg1I7UFba7a6AfBxM9xZpqU9uPtYcL3LmyjHVwju+tfMzM19Kgd1WJC9oXvhTu79udxi
	 YngovG+4QYJ6lkFM52IxvluwgXAtG5WJPeT2sskrkYDypb0tu93ObahTRC1YHmn863F5t
	 PaHjvJr6b6WnejjaesmEYGdyhZN3+wE/Qk1JX+PV5QeGVUMjgPBN0k3jQ9pmNV+FZww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795846154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nQ2O6ohYt8StqDgtNbo2hP/n3Jenud58IIFUvX2imSg=;
	b=UvNi7duczt+L/KzZxyDEbHntA/ZdOeOxlhmg38kPjoGntgbh4GZGfR1idNeMBYGZab2m
	 HaE/4V6yIFUrhimHzeB4vuNAE4fG+BOqOKHJPHceavVVxxZv4KB2PyoCCZ1B+o5L2m71G
	 6vwwRT6cuZWDe4F6kDimp9YsZESp5p6j+EMffAUKRN13jOZXBj7rg92/EOe29PyF+yStg
	 sFL9/yXpXrP+9XOCh7zRpaU3HZ65ndVWxjat2+b7WblzRqf7T99ePBWVet58nyz7U22/t
	 ankjbz0RMfvvlYYXtzTmkzBWzmdo+mAUNQ1pOFWFQCnLFUj8q2vB9sh8uvZeFKlHUeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hpeu6/EH";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA990606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 06:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA990606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hpeu6/EH
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386c71feeeaso5375358eec.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 22:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795846153; x=1796450953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nQ2O6ohYt8StqDgtNbo2hP/n3Jenud58IIFUvX2imSg=;
        b=hpeu6/EH1AuoMfRw2oJ6yRS0XG3jb8g7+4INvymDZDTO786NoYh0nYs5X7nkugYLZJ
         7jlFYhQl8Z+w2GGBQ+/FXkUxEZaOUQ4j20E03Zrs+4WauRDRGOjSpM+7u885W9UXMeGv
         4ojNOZ0yGsu8BF/7iHPP8VKZ8brkhe/TCvjE0RgTHiksbrTkDNdVnMRunY04himK9uAR
         LuW2vOtyR2uQWqpBKgc8qRdDyEU63S+5hNui5CI+qoMBCfxqgyUhk444O1PKE0MYrGGf
         FM4EucSA5FUL2NS8rpTIDVdg70ZpZAZYdbm/Phw/N1JBmJeRGRYdyBh0G5FtSY9Km5ZD
         my8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795846153; x=1796450953;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQ2O6ohYt8StqDgtNbo2hP/n3Jenud58IIFUvX2imSg=;
        b=IzvAQdWPlgujogXL+2c8GCSHRTIc7vL6+oq2dhbLCyuNavsrZRnf3i1ANeautEo4t9
         ue3XRJzoevBrgkZ48GtJFgGvfq3+jV3ak1cAYubBk2KqmdhDLWqem98XsIKsrZxYCrdt
         KrgjfJ9kGLiK47VmfaIrpYFslPFG12iGRgzkWAsoJlCkn8mT3EWqLG5/Qu28cmWBM3Ug
         9Z6jj6IBQweJx5/ORvg2RPEpU8pMrwIC8S89PLbBuT5mm1dwuYSE4QDNc1MVrAMjzk/l
         g8B8DA8WVBBECKik85z82cKiINnJmB/kc5gz2aXpPfpsqilYbXqi/M6Puvc0hp25WT4w
         fT4w==
X-Forwarded-Encrypted: i=1; AL+hErFlhTdhzsjne3ZqskRod9a8Hl3qaNba+vECUBCjBj4adGq4p2D6FzFXooR84zUmBlfz9OToa8k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0IBhouyTwIov4GyZ9kgu9ZT91JTm82lN8WyfseWUNiFMoI1J6
	M8ww6oUJg/0fCRdygc56h2jfBQWbLlwLbBNXRcDP2QuJirckscmCAYBb
X-Gm-Gg: AZFdTZfU6k96Mao4kx7zqM6R7zgernH5OxkDekaYvan2mSdnAXkt2jXzuxVVJCS6vG7
	BLyYrpr1CRzzQOCBoAhFBl/LnUTssDZGvf8tKyolzgJIqxvnaBM2eyY4vNYipq2Jl/PlFhRUidv
	HTdi3Q8FD3wE6RR7YRa0rORFx/2peuyncoFw9fFubo4JVtMKCpgLihBehtK8ZERbu/XAt7Vzhij
	Sj3b2yEU9H2DN7im8AaoqP48JncxVyyr4INJOlps5d8CrKToVx8xJtRyq2OslfPLH8Qbuw2LQAT
	ezQCR4TFAem5Zbhs5MUIhtuhuITm1CNBmVSZ9n18sli/ijRXP1kfIesfu4ZYhzhCSM6T7rjKIxZ
	CRHP0Zt2RC/tXEhBZT8BWdl9jy9emIqXHoXUnfgRIzVBRO6q664+lcJ9YqXgAuCmipHxtRwlW6M
	CAYhdmF9gv6ZeknYqh3+xHeY+HBNyv42LGxrBvBSWdvoheaLupr/KEFWCHNtJa4wfY/BEgng1n/
	wQA/FMZSjE++64yBissa5k6G8fwiGT7Xo07OCuwhaQVRd6/GWXO1gPUSEuzUAxGKhm7Khq/0Y8A
	vNr5H68XTYsNj59nZl0gUaCpLE3lIdWeH2Wz2xrEmKCirCvKH2WztYd47X5RTa3iLAhyyy3bjAX
	3IV5WlEa6vVzJI6U=
X-Received: by 2002:a05:693c:87d8:b0:386:b896:319c with SMTP id 5a478bee46e88-386b8963d3amr15639221eec.35.1795846152934;
        Fri, 27 Nov 2026 22:09:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:aaa:5a07:6335:86c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm83886487eec.14.2026.11.27.22.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:09:12 -0800 (PST)
Date: Fri, 27 Nov 2026 22:09:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, David Heidelberg <david@ixit.cz>, Andi Shyti <andi@etezian.org>, 
	Rob Herring <robh@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/10] Input: stmfts - fix
 i2c_smbus_read_i2c_block_data() check in status sysfs
Message-ID: <awpwAc8i8VE29tt7@google.com>
References: <20261127201050.3532488-1-lee@kernel.org>
 <20261127201050.3532488-6-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127201050.3532488-6-lee@kernel.org>

On Fri, Nov 27, 2026 at 08:09:59PM +0000, Lee Jones wrote:
> i2c_smbus_read_i2c_block_data() returns the positive byte count on
> success or a negative error code on failure.  stmfts_sysfs_read_status()
> checks if (err) and returns err directly, so a normal 4-byte read
> returns 4 without formatting buf (exposing unpopulated sysfs buffer
> bytes), while a 0-byte read formats uninitialised stack memory.
> 
> Return negative errors immediately and require sizeof(status) bytes to
> be read, matching stmfts_read_system_info().
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Closes: https://sashiko.dev/#/bug/linux-bd87edf0-6f79-4318-8780-d69205787e7d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
