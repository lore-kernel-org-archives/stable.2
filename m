Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CB2DB7B4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 02:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996158; cv=none; b=qJfxdCEFMDeaC76Y5UqEosh/YnXRIbIa+UqR7e+pSenNredZR6eXylzxJLd6GJPlyYtHtWWglRU8X2SvyAwySQpnMDJ8wHK2iDpq20J+tD+lzRZQ4KHdQDdi6/zs/IC3FZ6q0toOOnXyZJeIGbvEpfhIcaCU5qnn1pBBCPOfKOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996158; c=relaxed/simple;
	bh=Ogf0c96gmvFtj7+Kg/2HQ2FnTL8f6Vlo1YUm+lu9MPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6FHqxeBu0XvZIwHCbJoiigrC6h8xs/le1QktubPjAu834fk83UQMp6/WymMEAAuSpzm7cqXHTHetsbTmJKbfpw2QPYSebLDi4IF5YAm/1xu9Jv/79J8P+4ynp9AnKMrWnBJhB9wnEVL4U5HBuNj5YV6gzvSrbmkpUyBjDRKtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2IenEL6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2IenEL6"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848643382fcso4208076b3a.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783996156; x=1784600956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5bPrUfoJACi9BYyW8xq/jkNYTvoED+3Sp0FVeU/kPo=;
        b=X2IenEL6rOnBCMe76aNVjAf0lPtXZKyRuO6SqQCI+m1Sf6jY7gYYl+qMgYFSK4NQul
         sENfPtVcQf+9QHlf2LX2yynU1D6FUH5eUoCPJfBQg8D5LTcXfFsomPcqdF/Yu71CAgiZ
         YbFjDI3gavQbAFHO3W+6Tv80URMX67MsRT4vP06rUvauT+mn3UweQUCqbC4PFSd4A5VP
         bxtKulGcnqeiiSlJjap57i2W+vfU5UhnFf05pIm3w36iq578S6ma+gDQsq5azAKYleye
         HB3BwRHhe662RVWkSSnB+6A9oSPBh+8hbAL55FSxisrMXgXJQpLUUHl938uEtjrVYOrP
         tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783996156; x=1784600956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5bPrUfoJACi9BYyW8xq/jkNYTvoED+3Sp0FVeU/kPo=;
        b=sfWpsqG7r9XOliZNApI1rCWBhv7DrMvCkHoifpkFPmZZWS3e/P1FW8sGHhGXarCi6m
         A9wgtSbEuP9gfhPtkqT1bJjhfee7+s7+5c2hPZ2JvpKgSPDVXqiFeiXqKBzGsMOPro7B
         1/oAKL2UUPVX3SvwDQlQkqQIRbYrrnW1DOWuXQX+FzTy7Je09JSoJVFpQmvFyKmWI5t8
         ddDRe1fXGPLH6q3Pz29RVIgipiW5xX2yamgLQ2mHeSUqGDsxXLntxvs9xbeyE8+YkZTC
         H3dHJLcUr1pLkf63TRyUmlApg0evdLHIDoMPAfcSIwivQtNF7d2ELei9tZRBa+doD4zV
         L5LQ==
X-Forwarded-Encrypted: i=1; AHgh+RrO5u4Cd2No4D14hGLRUxIeOQxWFHgN42Z5nA5GR+OsmBY2qY6L8L6wwcREcnC6cbxxogAy0uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUxf3hQsiZ0UX5Ut/0TgdZMLuIsYs9pJpgItE9R5OysgNrXba
	fVmA2kbEQGZE2Ih8fN55N6TTLUEZwz+yI3hb2XDZvztK2PbDgkC2i8XQ
X-Gm-Gg: AfdE7cnKjgEyT51ilgM7UsBeMu1E2FtmIBDyFIfQdFw5Eqmr2KJwhcnluf4fFCnBeUu
	SDdUYyNeXx3T2vZL4Nnq4+O/ZBLiv30eCXnEsCxXK383fP1WXJPYVEW8ZfB9M2zc7GZ1jcEHU3z
	/xSKGF33mTjPH+nqfGLOToXOZybmsy2GgabWIZ1SDg3paNaVAy7pKb68mIe3LEZX3AbSPuWYWBP
	i1wdN36QvPWTobAD8P6km8HKVdqESi2Pwt6OOv86h6u3nCL5j2rAhaa8oZqIr80489R+eZY3yDR
	VLYQsmh/Hu+v8eIpXDEKYvIMqLK2REEGEgFxjUbpKh3Bdq9FyOdkEsVThEh8hUyM+C6fN0FZC9D
	wh9ZXLWzPlq1fzyVMXlSGDpAw0qotLiyJPGAAlG0V+AS5JZvIEWPtpSvdFHqjw89vIMhqr6qWYF
	MmhHJ72ZSI5OAjg0Jgq66Y+M613zRVIcjdwJ0Z2w6HTxKz8jfWF2i8XT4uDjCB+vfcALJ73ULVY
	z7VsioTAEP8Yw9TkXUIpTWa
X-Received: by 2002:a05:6a00:4f8c:b0:848:7835:bbac with SMTP id d2e1a72fcca58-84a516307aemr1475965b3a.65.1783996156182;
        Mon, 13 Jul 2026 19:29:16 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238f75sm664039b3a.9.2026.07.13.19.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:29:15 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: LiangCheng Wang <zaq14760@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Angus Ainslie <angus@akkea.ca>,
	Wig Cheng <onlywig@gmail.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	wlan-kernel-dev-list@infineon.com
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Date: Tue, 14 Jul 2026 10:28:59 +0800
Message-Id: <20260714022859.1849447-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com> <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arend,

On 13/07/2026 12:51, Arend van Spriel wrote:
> Looks good to me but the stable instruction looks confusion. What do you
> mean. If there is no 43752 support there is no need for this patch, right?

Thank you for the review, and thanks Gokul for the detailed
explanation - that is exactly what I meant, and sorry the annotation
was not clearer. To summarize: 43752 support has been present since
v5.15 (commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and
initialization")), under the SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752 id
name. Commit 74e2ef72bd4b ("wifi: brcmfmac: fix 43752 SDIO FWVID
incorrectly labelled as Cypress (CYW)"), which landed in v6.18,
renamed it to SDIO_DEVICE_ID_BROADCOM_43752.

I also have to correct myself here: the boundary in the annotation
should have been "<= 6.17" rather than "<= 6.16", since the rename
only landed in v6.18. Apologies for the extra confusion.

Gokul's suggestion of cherry-picking the rename patch together with
this one into the stable trees sounds cleaner to me than editing the
id name while backporting, so I would be glad to go with that.

If it helps, I would be happy to send a v2 with the stable annotation
in the prerequisite format from
Documentation/process/stable-kernel-rules.rst:

  Cc: <stable@vger.kernel.org> # 74e2ef72bd4b: wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Please let me know if you would prefer that, or if the patch is fine
to take as is.

Best regards,
LiangCheng
