Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95154DAD1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083806; cv=none; b=XNIDi9XitsBUfwTVqD8GACj82l8Ta+310HRpInhwIE/tUmzYisnYDRVPU7uN4jgrAxt7yR9Qkt3y5OROWEqVODn/dwUJ3Pv1hKGMeX5JVnqV1LDFcngupg+d92YJZh1a9wEjWHp/+LDCf9j3STMEXSlhLfnboeeBFkh3soYmAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083806; c=relaxed/simple;
	bh=xQG4bPiB+xgCyMb7c4RiobOhzKkgomujGMD6HHMDHTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2SZBQ6WFit+yIdarSNcshIbfX6dh90ET9zy7NZs5dRrXI4UYSGaGnzDYnukgoWhvV4jmAX9f0ZInHZ8QhEJhSWImrhpjcJSvIeuLqNB2dVzzx8l9hR8TCOzLxVUOzAKf8W1GEzmiFQIDZtyijalj3qbHI9Pnmev3AZg2ldLhVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7OY81lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7OY81lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237321F000FF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083805;
	bh=xQG4bPiB+xgCyMb7c4RiobOhzKkgomujGMD6HHMDHTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=O7OY81lpJmrPi4NxDLalaUJMcbLnmKizicvNXGy4LnIOx8m0BeGORq9dlKwYWw+Bx
	 87t/c5X1ras9YJMC5hNRDl2zuiXNmCFTp/f9Ce4wjh44OHwhc+msrux19rcKX+Wbxi
	 tnd6FftJwWtetJ8/yG8zWf6GYNI6AE7O7PxpMjdUaFxjYV7DTDY6X4peirkH99RQ2B
	 J2aTXJGZHQdkdBOqb7nHIIQPtDJvBLUnB1/UBaYuO9MQqZVKBLg2SMu4055D9YIyHk
	 hjm9a4DxsDAqL4L93/KlJhVdXOb4NgopolNsn1COocb03vidl6Ug9VCMxQZ1gbAefl
	 5g3mj9iMb93FA==
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d440939e3so28316207b3.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:30:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy0IqGPThSvc33hGW84Qn8VrCWL5K5iHZ0Wb/vFjrPCzKQqAax4Y9gG0aqmtZLqTo/OZ+68jI8=@vger.kernel.org
X-Gm-Message-State: AFuF++lurS3m1OXA+7mu1+NzG2R4BqJTkaQnbjnhALc2eo3P7DUXqFAf
	6FqUGvb3A8GpIpkjA4FemUF65vD+hOJgnDCalkN42YszMoklHjQa8Iy216IORKZkXzF0LEDaRHH
	NyOrHaEr2kHtOaSiztK2wOHvACXVS+2Y=
X-Received: by 2002:a05:690c:f09:b0:873:5bb2:6c08 with SMTP id
 00721157ae682-89735a98c88mr46339977b3.50.1790083804434; Tue, 22 Sep 2026
 06:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-fix-attrlist-size-limit-v1-1-c7e10b6c5656@gmail.com>
In-Reply-To: <20260922-fix-attrlist-size-limit-v1-1-c7e10b6c5656@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 22 Sep 2026 22:29:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_V_-5mdQpL89hiwcCBofFoh5mwJdc-00DwJtDdDL_x4g@mail.gmail.com>
X-Gm-Features: AcwNN1XzLuiESKOqr34zUmvqc9y1NmRstNhlU8Vsdj6dVcI1YT_uvaSo-v4FI4c
Message-ID: <CAKYAXd_V_-5mdQpL89hiwcCBofFoh5mwJdc-00DwJtDdDL_x4g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate attribute-list sizes before allocation
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev, stable@vger.kernel.org, Robert Morris <rtm@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:19=E2=80=AFPM Hyunchul Lee <hyc.lee@gmail.com> wr=
ote:
>
> The NULL point dereference could occur when an on-disk
> $ATTRIBUTE_LIST size was truncated before it was validated and allocated.
>
> To fix this issue and prevent excessive memory allocation, limit the
> $ATTRIBUTE_LIST size to 256 KiB.
>
> The following existing implementation and Windows test provide evidence
> for this 256 KiB compatibility limit:
>
> NTFS already treats 256 KiB as the $ATTRIBUTE_LIST limit in its
> attribute-size checks and $MFT attribute list repack/expand paths.
>
> For additional Windows testing, when $MFT's attribute-list data_size was
> above 256 KiB, Windows attached the disk partition but did not mount a NT=
FS
> volume and target access failed.
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Link: https://lore.kernel.org/ntfs/88468.1790006025@30-10-12.wireless.csa=
il.mit.edu/T/#u
> Cc: stable@vger.kernel.org
> Cc: Robert Morris <rtm@mit.edu>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
