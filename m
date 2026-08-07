Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F17315D5D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111546; cv=none; b=O9lsWAVgriWPK7amH+Y0i/T5X8jzrGMooyBx6K+MixxQzV8R5AJ9zf9wALXbWR1GvOWOLRoD3W+JHLk7w8ZTWhutL+2iLtXh/D6r2lq/q8DOnZBHoK9aw2AJNiqJFeeXJJS2jhQ0naKkS34aF5SF7S0pmpyD3fdXiyXOEHRF/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111546; c=relaxed/simple;
	bh=jOE25a+w9wYKvrhCgqchsJBaX3amaUvnxDiUcBBLTQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8OJ/CPKAen9x+QaDQtMfga5Mg58QQctY4uGMVKL+VYblAzJHfUS4Mne9lLx8NfjzXeZ2WPlS66cUH/5c4auDZ4CfDp+lN3kF1rXg6t1tRonzbrGN8H9nmFqCrQI8zqMhbXbvW/c00W3/527J6Oyo1YtiVg5sds02MDZ10DHAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlbVTkD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlbVTkD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053601F00A3D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111545;
	bh=lBAaiV71VWDTlmRQ0ipKm1krl3BhYMW9W1U2aVPf4zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WlbVTkD+vMu9ayRu57eBmwyu2JLtYw8F0nqyghfMFxc/JVL9rM03RiuRRFCtpqYZ7
	 MJXWHJFNZ3agQa1huX2EDFG96xLTp98j9eRXYC3/sZ+tiKpFezu8H0JdsxUtUu3JzZ
	 vRrkpzmQNnZLerGpvq8m6sbGJ3EUdBClnyAuDZqZpky42r/m67nuMbO4TW/g5Fi7zI
	 8Ng8tzQpzbX98km5ZK+afFI6PmeDwd6Ih8Whd7BwJ2WfU3tdKRSXnxQKpwwgz4ad+s
	 IUuPfNtILUOt2IHrFSB5sxqX0vOJujho+vt6hih+7/FKMmAthmihV8r/MGIw2vFSho
	 0+l9tDXKEXW/Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c74722e27so26987381fa.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:05:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RokqeTnFOsx1ekTaTM0q7D4p/9Xufsj5FQRnmUJeaUqioeLxFgbof9pP3QRxsCZ4xJNUu25RVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTrF6LXfpprJLOGW0hpBHm5hmYGlJ7ShS7Gr0OVK+Vkx1xadK
	M0Z4qXzCafJ2o9sZj3xqDUUh5/Q+pTfn/Ykq4tuet/+xH1IJ+6ALanF4iOV+VyIvpZQGFP6tWcY
	NUnpdqAAZ/96m4RRLaYAiKibQ0A2M/nQ=
X-Received: by 2002:a2e:be1d:0:b0:39a:c1dd:5399 with SMTP id
 38308e7fff4ca-39fe672a836mr276691fa.7.1786111543476; Fri, 07 Aug 2026
 07:05:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806010944.32384-1-kensanya@163.com>
In-Reply-To: <20260806010944.32384-1-kensanya@163.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 7 Aug 2026 16:05:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hi7q6cO09qrqtJXExs5pv2r24BbZF4geC2mACddxLL8g@mail.gmail.com>
X-Gm-Features: AUfX_mz9uCWGwnJCrQFO102VGbvQ4VSAjyNt12qFXZDBT56UWQZrpRj4TawiZ84
Message-ID: <CAJZ5v0hi7q6cO09qrqtJXExs5pv2r24BbZF4geC2mACddxLL8g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: GHES: fix ARM section length accounting
 after header
To: kensanya@163.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	TanZheng <tanzheng@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 3:10=E2=80=AFAM <kensanya@163.com> wrote:
>
> From: TanZheng <tanzheng@kylinos.cn>
>
> In ghes_handle_arm_hw_error(), after skipping the cper_sec_proc_arm
> header with (err + 1), the remaining length was reduced by sizeof(err)
> (pointer size) instead of sizeof(*err) (structure size).
>
> That overestimates the bytes left for cper_arm_err_info records and can
> let the parser read past the CPER section when err_info_num is large
> enough relative to error_data_length.
>
> Use sizeof(*err) so the length accounting matches the pointer advance
> and the earlier sizeof(*err) size check.
>
> Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past alloc=
ated memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: TanZheng <tanzheng@kylinos.cn>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
> v2:
> - add Cc: stable@vger.kernel.org
>
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6..e6362da72d15 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -576,7 +576,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest=
_generic_data *gdata,
>                 return false;
>
>         p =3D (char *)(err + 1);
> -       length -=3D sizeof(err);
> +       length -=3D sizeof(*err);
>
>         for (i =3D 0; i < err->err_info_num; i++) {
>                 struct cper_arm_err_info *err_info;
> --

Applied as 7.3 material, thanks!
