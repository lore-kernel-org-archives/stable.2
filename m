Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1E519937
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860541; cv=none; b=OttOr9xNRBs3eehuIyyYSA85AXPYBsG0RAiBzs1Rg18FrOqGfm5V/WPyprzzyX5cJszgeVdlBtt5C6HQFG1HXHAQhD9d/1viaKFIus6+Ho8Xd7T03YYRitaMIN7YNp/gkqaMwz5AMUsIA5a0bnixzVlEHM5hfdRHLu49Ij8Yx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860541; c=relaxed/simple;
	bh=4mrNDgy6AMSKjtPprwZWZ7OJTzobbZjA2LIfx+rptdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQCosn3etN84O6ClkafjMM0aVArwZ4r0Ktt+td3yjGbj4XnqEq6Q+3VnsUxVe/v/zJ/w0heEp1XBL3hWNQMtnGSBpXvs85K+Yi38d+qDTWUodE13bB+AWVLpMLo34fAcCOA4k6A7TFEC3+uEKtSA4QN1q/lKkFQZRh/XmBlyoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDd7gsss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDd7gsss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1222B1F00A3A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860540;
	bh=aupG1zdrXQoxXyLvplWPXti+Kkhol8td9bfr4ziccWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PDd7gsssYjhU/OcvRxGowMudct9MWAZuybwOlAHg7zZ8qtW20aIgzkf5pbEn1xFoG
	 kKLPiVABaN2af87j1T1p2bHvmQDmuAx6waocTE6SNHQdXfsCMi64iECqKqEofEBZke
	 zMdZW9KjEZyHUh1fgmRTPYyiq7FThViwThI6nyveUcERGEXvg6ufIOmPXhwTEBvD9y
	 pGCYYkhvUWb9wxJOnfqqScvV5521fJdwcwTFiU9bDOtTEIt3jbmwps//c6UQuvpfkU
	 XdzBlhNwt3Lx9IJhpDBi1Mx5hl6GgfW3wKeqh+yewHjRboSBzxni+034X2FnHTT8gP
	 gJuIrMattyr3g==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c263110a8cdso351136366b.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 02:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwW4S7LDBBsSWIkU9iFIqrUqR3c7PRVUtn30jE9ADRenAJ+NifTxQ121zqfXQ7w3p08vkCumPY=@vger.kernel.org
X-Gm-Message-State: AFuF++kWFB9MHI2WL/h5hQgJXdzHjq0mg2ewxn2Sk4kVNOkDt5yHJXIu
	INelFv2muEWQ3ia+LPEnX8evjuVTXDxwPNwpx6CQKo8yNCgT0FcdfMnWoSB4R4H+PQ2FIzZ+9lb
	bTNFEZT/xoLq8suzyZ/1UCNjX7z/2fKU=
X-Received: by 2002:a17:907:c5c5:b0:c26:19e3:e983 with SMTP id
 a640c23a62f3a-c2619e3ef06mr929376466b.35.1788860533346; Tue, 08 Sep 2026
 02:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907070852.291323-1-zenghongling@kylinos.cn> <20260907070852.291323-4-zenghongling@kylinos.cn>
In-Reply-To: <20260907070852.291323-4-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 8 Sep 2026 18:42:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9gJLgGkMfnZHoXAYibn3f8N2JnRkTB8rtvw9-ag-OJNQ@mail.gmail.com>
X-Gm-Features: AcwNN1W9IzQSzR6_c1WN9casCEjIBxK59Aqdd_IE_CafvM5McrSP169ltZY9jNI
Message-ID: <CAKYAXd9gJLgGkMfnZHoXAYibn3f8N2JnRkTB8rtvw9-ag-OJNQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ntfs: NULL vol->vol_ino in the load_system_files()
 error teardown
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 4:09=E2=80=AFPM Hongling Zeng <zenghongling@kylinos.=
cn> wrote:
>
> The error unwind of load_system_files() drops vol->vol_ino on two
> paths but leaves the stale pointer in place while it keeps iput()ing
> the remaining system inodes ($Bitmap, $MFT bitmap, $MFTMirr; $MFT
> itself is dropped by the caller, ntfs_fill_super()).  A third path
> carried an iput() that can never execute: it sits inside the
> IS_ERR(vol->vol_ino) branch guarded by !IS_ERR(vol->vol_ino), and is
> removed along with the stale pointers.  Nothing in the teardown
> dereferences vol_ino today, so this is pure hygiene, but a stale
> pointer to a freed inode surviving the unwind is a trap for any
> future code walking the volume during teardown.
>
> ntfs_put_super() and the ntfs_fill_super() error path already NULL it
> after their iput(); do the same here.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
