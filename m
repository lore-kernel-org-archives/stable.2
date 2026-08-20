Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0546341660
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787194191; cv=pass; b=qSHQx4u+c+1nlJKE9UXmSU5iGCQw5edZbshgOtLG4T4cBTNUZnWdKX5Tei0Zl8IOXK4h6vPgQkvQuABDP76KF+qklVm3FacRjoraWj18sGp40p3otGp+cEzcfMjzcyoA+wSPw5W41QftzdFP+1LeDerYJyxUh7pFqrtLWfPri2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787194191; c=relaxed/simple;
	bh=uLQMpCgvNQT6u8o3sYbGoMAuGk4Q75uyM7cKvkGYx4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=addaUhcNGwoS9eGm9O6nSqbCJXf6V1g3zC+ALT+5Yu4nu9b+FzoRLS4Q2ftVmT+MNKPTMt307UbnAhAW/mhdCQOg16GWYCRh1fNree/HQJ33ajxwC2mML3qEdPDgUqjRC7KF54FgN8UiCxrNVJ6qUY54saeSjaIY/AHmyBO+JD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB87ODFA; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB87ODFA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1433063f8f.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787194188; cv=none;
        d=google.com; s=arc-20260327;
        b=QTPStyX3vgpDY+YwQzXmOHVx+3VSE7aMYwWYNv4rio+0GMeVx+gUSrWyl1ZJ5cRUf8
         W0frY68Y6htTA1TCmnS65x5MPKjvpn/BBS34Pmc4HFljnuE/lV1+fmOfzh82wsmJj1q6
         vaVnpC617V4UmZXlkzqMm+JtcXYWKtcbcrEzmQqkcEQlClVSTkz/DoWtGMe9IjQRmg/Q
         LLXMoAPc54f0v5nvm7h/KQZtdkCSQegFV0Eksesy6I19O0Oi4KVSxeTARVsXZL4nuAei
         hcF0zWBh5hzz9HmN/O6wRSvkSGe5Cirn71OnC/hDy3NXI3bX+Sy0iACGpgbv3+gfzEah
         O63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YjNmQZYAyRysXhmwM6mRYoKV8JMLaurjh7mibsD17wg=;
        fh=IN7egZaXYaUiWPpUbj3vLQjtStyrlwCEooflBjB5jNA=;
        b=EepXpLRv5Nry7q8duzVH2tOmv9aJ3LjWHjHwfyBdrkptDeU2fWfRmmeHQGNy29Cxl9
         OSxtZjK1NLGVKbf2Cn+egphQt/msbjibmgXC4xih/4hLUd4Lqp9oMjv1GxNA4lNo4k8F
         IM5vOxXtjouDs3jloiQxaRYEpNQ2JNAxeqmvxXh7CyyRsQk7++RQTzXyrBbFa0TVx8og
         dCThihupRkwfsEbGlhcTp3QkLpWCY0p6nRQ+DRuaHmwkqZTX5P9bZgKOgGaDSqKcx8Nc
         ZhwsT4hMuXokZV41QRT5pdkD1GArTBPFwDswJEPebAva00gyJmvxOi5cd9Cda3hCIQur
         B1Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787194188; x=1787798988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YjNmQZYAyRysXhmwM6mRYoKV8JMLaurjh7mibsD17wg=;
        b=gB87ODFAiekpGSLtddWdaUdwXpMTmndqQLOpNImKtbN7uLw7It0EztFVs6A+k5dF/Y
         pRBfBHwzg/SEXjSOF1kUNCWvGnYHCj7mEfwF+KONs5mPa3svYJb7lYz09z49j5IEUOtD
         zga/KVC8TdpXgTFE6jW0OdwLSFhzj/okaFFh3cL9MRHNt/t+c/KpUCw6PWIrRfRvcq7i
         pgCIMbwXfUKHTK00EmngpW/t38UcUfehICuuJJUwKhYZnNmM+3fJv0oet1fRkpsNOWHL
         aLwqpNLXtV2nUIvwpzP070IUYcNBFxW+qV0fXDADnh/5djbd+GVkD+1TKk8w77uwgwz3
         dy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787194188; x=1787798988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YjNmQZYAyRysXhmwM6mRYoKV8JMLaurjh7mibsD17wg=;
        b=hJJgVd8qbObbYWVZPUZ+r4i8EWr+21xX8LTgX1fzigLE0Rjfj1sUIDzc6cQ9ZxAQv6
         hXtOkW0CotPflzezpOoalGX1/sfdvA0IpF4kwOz8b4OYfMnjA2J9UtDu8liVpxVjTlyc
         0ZNiQQGAwTA5+0ptYjxAuCFI8sRqscjidfiRp2WIaboXkBq+uyqAhbJCcn/IUBCY4mt4
         Vcdc31rV85UgdV1EY3eZzGOiA8FcBBtR4H3RylDqZbB5GWH75ZsOgKk3zcnEq0bzAFqd
         +9AS/CjVoPgBWxY2mo4W4+EANhzfPIrDkWz24WInzXaR6i4Te5K23NUngaKKZ5UGYVJF
         KDUw==
X-Forwarded-Encrypted: i=1; AHgh+Rrqx04cJcgqQm8w5hqwC1sD7hhhakA4QhPBNJBZcq2P7ZCv4cpAkaTybmr3U4HvcnbbLXRCJnE=@vger.kernel.org
X-Gm-Message-State: AFuF++lj+m2djMYQBU5LnxPbaO3yHW40QQC6QQi2vAOhCnjwFOJsGa1f
	AjHxEnaFu8JT4ese79onW1I32GvhaDoWUgtuomNeAFV9VSkrjjoynysNpoGx44acLc0L/t41SOm
	+1lyqsVRLi6UkmL4knl2+iKU9fxNurOI=
X-Gm-Gg: AR+sD11TL02rUQdGP+BgC5cBH2CC9CfNgGHg+MhWeW34BlVu87dLUmCEKw8/V0A0gPC
	1Y6IxyA8MGJrc6lB0FTrnqjz2A7laa/BTxe2/OuakkQqpDjlSKqSIDvy+4Ly2RE0o/vbLtir2Fd
	UMwBct3ioC2AhRthX340SR+Bfmv/bY3crNIQQ6aCSDH/BHaVKcO5zXftm56ib8nCn7ryduvbPaO
	7xBOv5Z8AflOvQmcpqL/5I+sla268YwGfH2U/gCkkJsxESOERLPFpQJ+gdfV1RqbCT/iiccGgu7
	OAIKYH04tyoSAoi6SzttMnHF0LOBDvCvo9nAD1XXeD88cGnu/clPWghM8NsnQS+LvWTysU0nJDe
	J3g==
X-Received: by 2002:a05:6000:2605:b0:481:4f9b:282b with SMTP id
 ffacd0b85a97d-482b1ff75bcmr15946767f8f.21.1787194187872; Wed, 19 Aug 2026
 19:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724025322.2341205-1-sammiee5311@gmail.com>
 <CANLsYkz+h6ONmvhgdfGLNu21J+LrMSySFw9sxRcR4ZxLwPfbsg@mail.gmail.com>
 <CAJciObG2OahhKz+t9pbA1yCHz4pFQLK6EKmZMwY2zxqD33SgQg@mail.gmail.com> <aoXdbENOmRRx2o6l@p14s>
In-Reply-To: <aoXdbENOmRRx2o6l@p14s>
From: HyeongJun An <sammiee5311@gmail.com>
Date: Thu, 20 Aug 2026 11:49:35 +0900
X-Gm-Features: AcwNN1WJqBXTwpFIPKhmgdYqdGaXO0a_j5pDFwI-7i8pt0LLpaEeILUKM4l4EAM
Message-ID: <CAJciObH1ER73km1sf5RtjjoD+1cvcmxt4DsgX-n++=juDmo2Ow@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: elf_loader: bound the section header table
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:44=E2=80=AFAM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> I would assume that if e_shnum is 0, then e_shstrndx would also be 0.

They are independent.  e_shnum goes to 0 when the section count reaches
SHN_LORESERVE.  e_shstrndx goes to SHN_XINDEX when the string table's own
index reaches SHN_LORESERVE.  One keys off the total, the other off one
section's index, so a conforming image with many sections and its name
string table at a low index has e_shnum 0 and a small e_shstrndx.

scripts/recordmcount.h:219 set_shnum() zeroes e_shnum from the count alone
and never touches e_shstrndx.

Thanks.
