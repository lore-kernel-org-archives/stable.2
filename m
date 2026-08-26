Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91A3E5EFD
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743812; cv=none; b=MBrpGpiJ6L6xZDaC3jRiS8fwr8Cv9nrmtyV/1VB1szTN2Cd5ytvCGh8z5OkVDuWw2W4tKv16ehuuGjTNUxKcu50UuKBE5NgewPf4hjBlAr5u5a88UlJj7SJU/Yt6d++2WzzNS8ZWouz5GTbTta6jPu0TnmlhqIdlxI2LXo5ngag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743812; c=relaxed/simple;
	bh=5cJffYrbzvlLTLs/MGEVbZcRNd+BMA0Y9cIfNr/ZVHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fus8bFdzWZdV0JBcOECfyD35eA8ZPzA1OIUx0GH25CpKXQTPzd7nTB07gZYZvX5gFT+gc4xFLyIQq28XsEv0fuHojFlXKvIG5NFJhS5/kEogU6k8ULrSJyvMShJK3d7A9uClkdBMOY92MI2eUQj0MpiBho8VUzuzaRizS3o1jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Url3wdI9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Url3wdI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650D61F00A3D
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743811;
	bh=5cJffYrbzvlLTLs/MGEVbZcRNd+BMA0Y9cIfNr/ZVHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Url3wdI9jGBf11dykA+qqN+TfAZTqfEF/iD2ASdB/sBdHT1Wity+DNZAO+Vi+/Fh1
	 P6L8zIB7a+86vWF4R+WjBMyLtCws24e/mVQvZWYIS2raGbUT7fseEkcmnosvVGHwHX
	 akpJSZtI4n0eD4oxy0CKk6yOdhwmyx/VZ3Gc4t4WL/ILpDySd3vHihqIztASn6ZdBx
	 9qMgitsTxSXHuypr9WGRt6gEHtoLZkJQhCRKQd85lKBJtggExcQynAKILwYHMOSV2C
	 jqtO/Iyeck8HzXxpQ7OXAfociHvJ4FRuZHJ2DF4NVGY/cckcweRZ8bC5sa3eNtmB6H
	 ATeDxQRabd+3g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1671ec8692so117742266b.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 04:30:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrMnSFSl5QUURhaWfRYzE8sIGUZttL7YTUyecpZXIPn1Ry0E0583AwZ/JM+hMn8gUmSgu5Tslo=@vger.kernel.org
X-Gm-Message-State: AFuF++m9AWJEIIukdEZieqBkXwHWlUIkZVUQMG6I9lrFnpmANy3FWOW7
	/lNHuvVJqyUsmOvr75ohVkp/nsaRtTuondPywnY5XhKIyrSDcXuPxJU69tja5qV1DUswLEXH2Zf
	FG8W6UCtp7pxkRdNwgdhMcNtMKaGw+kU=
X-Received: by 2002:a17:906:fe0c:b0:c21:382e:9a38 with SMTP id
 a640c23a62f3a-c250c449b9fmr764484466b.2.1787743810078; Wed, 26 Aug 2026
 04:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825095405.858623-1-zenghongling@kylinos.cn>
In-Reply-To: <20260825095405.858623-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 26 Aug 2026 20:29:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Vso+9+w2Dr7+vCSvRiHs0YPFz=Gk0Er1U6SJVG84H7A@mail.gmail.com>
X-Gm-Features: AcwNN1WrBSfwzM2PN0UKTrEZYMyN8MA4TywdX16d31u7gFDR-wvU_LF3q0CbisE
Message-ID: <CAKYAXd8Vso+9+w2Dr7+vCSvRiHs0YPFz=Gk0Er1U6SJVG84H7A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix undefined behavior in mft/index record size calculation
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:54=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> The boot sector validation allows clusters_per_mft_record and
> clusters_per_index_record to range from 0xE1 (-31) to 0xF7 (-9) when
> interpreted as signed values. When these are used as negative shift
> counts in expressions like `1 << -clusters_per_mft_record`, values
> like 0xE1 cause `1 << 31`, which shifts into the sign bit of a 32-bit
> signed integer, resulting in undefined behavior.
>
> Fix by using unsigned shift (1U << ...) instead of signed shift.
> This prevents undefined behavior while preserving the full valid
> range of negative values (-31 to -9) that may appear in NTFS boot
> sectors.
>
> The encoding scheme uses negative values to represent record sizes
> smaller than cluster_size: -log2(record_size). Common values include
> -10 (1024 bytes) for mft_record_size and -12 (4096 bytes) for
> index_record_size.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next with Baolin's reviewed-by tag.
Thanks!
