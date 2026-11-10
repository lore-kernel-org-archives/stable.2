Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794293777;
	b=ot0ZT5tqADiMUU8kiThOB+TASbodSA4RJGGJp1bJNuGmOt1sblvGupOciH+e2Lwc7Z1V
	 naiig2qD8k+URjo7+S9KXnQ8Fb6k9NKg7UxtCg1NWp+2Z1kIk9+r8oqBFEawY/ENQdEOW
	 +H4xbjb8HjIpFunfy2VtmuAJCtTG+MCjVAmf7H6zegWBbPJtkmNN+kXJjbv95T8nHAFx4
	 7Ul73aMtEQCUiO7UoZ/qPLYabTpxz1T7oNdQcbT8oNNK5aWHyxr+zGgMpk1Qdyk10mXRq
	 22O8diPpfKztWGuXol7LZPG8cCXeIycfWuFKzFL1pDLv84jZ/qmR9Iy+CZ++ANirGDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gv29PVlI4VqmDiKhon5UhDcIb7a0X1gnIhvI6TovMh8=;
	b=aeKsylLGlkRV2brHQA/SxKWVDan10YaYbT5R9vOcunNtmPul9OY+ivh0HwJsGoTtpWmn
	 5Vnf8cXZl+5sbnYs77YNiiuNzn1xNVsf6Z9mxzafq2TCtDT3A3rhWjukRE2ONuVtcGUiS
	 anYrqHSo40WIO8Z74XMxrW+cs+RwHwSwzerWR0CoZqh23xIy+c/cX6WFX9Q4GRoALXfNj
	 B4UITwz8IjX+gIXosQGmsfyNReboZmTH24j4d59QirNp5yunyJ+X6BL9Q8xa+7rtxNWtk
	 N3ZePPPLktcm/NwokcLH0ncvATdm8TS8UiZ1bEmR7Arnt6UKYdCF0mDZxXOxz593B9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INdN09EU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4E606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INdN09EU
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3420787eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 22:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794293776; cv=none;
        d=google.com; s=arc-20260327;
        b=hCfvbHIcqRlu5bOEdWXwM2JnHQUC5REYSXdVaxVOFnGMdyZy1NMIs1gUVXbRL621FE
         2o4h+h+LrYEwp+9CAlq+ctKGDGW4/5P8XOCUjVK9VQXvLWvjD64iXkBmYcezcoZ043WQ
         YU2HoUwXLUwz3WbAjkWI3Y1xGjCn/cHjQlxCAr3dOyTliSa4CaTxrmEYC1rOxRkbKwe9
         nPqWQZzF90DxXHlSZs6uv4QVhcjm2SQUDMPrqYf64SGAomuTc8Yf3KKx747fiUbblG4L
         axvd5o9n4Rw/shGQXSG23qisuP3NMbKSDJ/eUeAskQ2BSQxlt0PjR6fpSUwIa1ksD/4P
         N2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gv29PVlI4VqmDiKhon5UhDcIb7a0X1gnIhvI6TovMh8=;
        fh=z4/tBHzxc6BHajaZyaxHQyO0qSPjAYaZAqw32SvxKJ4=;
        b=IleykjzhCTohsnVx2fWbetS2Nk9cgI1WB4iAnRjqX3IA+Lvq7zA4gZCSM5Vu6aI6cO
         MVRU5eH0bVsssKcfVoDgkUvZ8M/m7U/5t9I+jsw8eflaQmBn5SWSiJJQdHd1Evabe2OJ
         96PW30ptXXGt5W97euTtRBALiZatx6/5ZAItVx5iXhxzMg5gU4hAU+JCvujgByhDjowE
         tJ4D6we6yCLgwQwrH4IBeDDSZawa5AUmQ+ALA9HNE+p1I5CSz+cHBiEgxx1MWBLnzLFg
         ISJlfz+3TS0m83l1QobUDRQYoyXhKNwR7U6Er5ijavEhGggPL6hJujhCY0aukquQQ/X1
         CcrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794293776; x=1794898576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gv29PVlI4VqmDiKhon5UhDcIb7a0X1gnIhvI6TovMh8=;
        b=INdN09EUKAvnXut6IrHtz1ZA3BVBr9e6B+gc+BjVw2cdz0pXF2Db7DalKQlpoAatMo
         TrIc7sDgF+cmqIsTWU6zycIytSh7Tg+7F0mLcts/6UjZDwdeysRU/UJkYrgCTGNAQKsp
         vTCSDGFsS+dIpLgli2l9b+sk7Io2i2hXi473fGg0jOCCJ8IvlkiNKSjtHWP19eQ32u+1
         z073VEPcI5i0u/KLM56dnc1j692W2S+GSwEiLlG7M5oniuV+Q621Yr0j71BIYRh2p8Qe
         FtMXzJxpGWxI9m6LhaxBVUbfXmdAinIc1jjWTG2fpEZ1PljUHdNipQl39fSq99zBVvj5
         4ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794293776; x=1794898576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gv29PVlI4VqmDiKhon5UhDcIb7a0X1gnIhvI6TovMh8=;
        b=uXqgRpLLZ5ed132yOzLFb8GfWtAIwPUaAGxaiBNL5dyCyVsKPk9Wu8h0EMpgGRxXZH
         jJ+YsKhsO8Q+YXwn5nQvay5JYiZMbP24EYHYuyVl9nSs07u4N0hqAGCi0WypQnhH6Lux
         Wdsnqp2OCBPFHsqm2PA7D0q6i13y2GUzaWiyOJ37BEeBNPhX7gYfjgwOFfMDu8DTSFca
         wbZWvvMgAzjP8QzuWnJIMuUewGdQt339N6+vPYBlCLSLQVRHhUEfv2Lyw1ojesODkSI+
         7uNWlgPhvvSaYkiADZsweqzpDA4nmx6XxaTFhXAitlBREbZgz4tzb7UVwpMK5l5IonUz
         Yqmw==
X-Forwarded-Encrypted: i=1; AL+hErEzUppTAiHa2DiN4lljcdvRTRrVYoPNX/lNwhoRXmJs83Q7Mbru7f/xME7zJxsFWVCnONNW4d0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y1ViBLcOJNsP+2emDfDv4m5KfdfELUV7NAa5U2aC7Jp05OdV8
	7FHeZ7vqx9ukmzEZl5rK1vtb67WKw2/8CYYmBMls2a/VK4RCJEdtpaXFe3GulVVdR+J3sX32qf/
	6My+KQ4EDzNd3XHswyW0/pDPw5dDwO2w=
X-Gm-Gg: AYBFou1ubgBT+qEKQ65ysjHKtRSW3cGPreQDGrYXc2/itdA7xbtjV0zezT5i/SZzQav
	8hbQ76RnvM+LQq5cOYU6K07gxZStBEZwMiCRNU561XMgyYokzaJqF6NNtwBjp+8plqBeHPBiuQ7
	oQ/dISf8OOYY7t/TlJNZDOGWNyPBtvEvidvjxk1/x80oj9uBOAfAiKgxdt8OfXL7Kkj7zn5cxfH
	twv2DNxLBsQQFEPO7XVAL4n1CFjKOmfBOsxRlcmKMiLUXo7iUG0O81ozTkWbamotQmOZ4G5GMNv
	jzqk1zGYziYeknC4mbv8rM0e0BZ3n4U0oBaCEhYY2XMKbAhLw9h1n5vTL+s3CEqen7PaRc29GUU
	esBiUXgto9i1dU7+MZZve7Bb2nZNsy5gY2t1NiBI40xeM1DV2OhbiZj3PHYfIFfuDV3Uw
X-Received: by 2002:a05:7301:18ad:b0:36a:1294:59e0 with SMTP id
 5a478bee46e88-3751f462675mr2049626eec.24.1794293775810; Mon, 09 Nov 2026
 22:56:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109045307.1167784-1-hj351016@gmail.com>
In-Reply-To: <20261109045307.1167784-1-hj351016@gmail.com>
From: khj <hj351016@gmail.com>
Date: Tue, 10 Nov 2026 15:56:04 +0900
X-Gm-Features: AclHuK-sqbPvnKyMJ84OYA3XkEoK-7U1o08imiJGCwa7o_TRyFoPrgq9Cv4NOyQ
Message-ID: <CAGr5VtOXSDR+ZAHy-e+baVjvWSeUCrShdaAF23zLRfbwiJ7W3w@mail.gmail.com>
Subject: Re: [PATCH] media: mgb4: cancel err_work on teardown to avoid use-after-free
To: Martin Tuma <martin.tuma@digiteqautomotive.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please disregard this patch -- it is an accidental duplicate of

  [PATCH] media: mgb4: cancel err_work before freeing the vin device
  https://lore.kernel.org/linux-media/20261106043541.1902730-1-hj351016@gma=
il.com/

which is the same one-line fix and already carries

  Reviewed-by: Martin T=C5=AFma <martin.tuma@digiteqautomotive.com>

Please apply that reviewed version instead; sorry for the noise.

Thanks,
Hyunjung

2026=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:53, h=
yunjungg <hj351016@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Hyunjung Ko <hj351016@gmail.com>
>
> The err IRQ handler (err_handler) schedules vindev->err_work
> (signal_change), which dereferences vindev (vindev->mgbdev, vindev->vdev,
> vindev->queue). mgb4_vin_free() disables and frees the err IRQ, so no new
> err_work is scheduled, but it never cancels an err_work that was already
> queued by the last interrupt before kfree(vindev). As err_work runs on
> the system workqueue with no timing bound, it can execute after vindev is
> freed, dereferencing freed memory -- a use-after-free.
>
> Cancel err_work after the interrupts are freed (so it cannot be
> re-queued) and before vindev is freed, mirroring the existing
> cancel_work_sync(&vindev->dma_work) in stop_streaming().
>
> Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 dri=
ver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>  drivers/media/pci/mgb4/mgb4_vin.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/m=
gb4_vin.c
> index b247854..64b7a9b 100644
> --- a/drivers/media/pci/mgb4/mgb4_vin.c
> +++ b/drivers/media/pci/mgb4/mgb4_vin.c
> @@ -1068,6 +1068,8 @@ void mgb4_vin_free(struct mgb4_vin_dev *vindev)
>         free_irq(vin_irq, vindev);
>         free_irq(err_irq, vindev);
>
> +       cancel_work_sync(&vindev->err_work);
> +
>         device_remove_groups(&vindev->vdev.dev, module_groups(vindev->mgb=
dev));
>
>         mgb4_i2c_free(&vindev->deser);
> --
> 2.43.0
>
