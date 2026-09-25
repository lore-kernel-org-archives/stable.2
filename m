Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD071B4223
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790294975; cv=pass; b=OBJCR3NJMy9PFlRs8r/dxycrNgqu4i9xDbeTBQJPv+ZEEkRK+yOzrxZD38GZ9ZAP9Ad/IaJdCHwbL+UUVpXcZznodocnMWPZQgP5CgJTr75AeR9o0IcxrcBeFbNnTCE6DiPvka26TnYI7gkn4jqoK5KEmUbbF/PjKAyQEtbafeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790294975; c=relaxed/simple;
	bh=iPGTdM+eHv5ZH8W6go2pTrN14Dr3emCgNgRX+uNwDgI=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7Z99lZDEhQF1EwGSBavkwg9Cj69Q5Ej2q1mLxztff/zSAFxUxwbG/rslEIvgm/s5F9bnqOsxtOLGRMhtwJOd704ypXus+Tog0lNkzKh68wRxYC/H9CRpV0+CvHeqP8x3EOo+UPs4IfBdQSLtdNW5aB9QOSENnfplw/G0vt6m9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6qH+mWx; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6qH+mWx"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f9f0b20so46871466b.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 17:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790294972; cv=none;
        d=google.com; s=arc-20260327;
        b=POSYf+FJKpp3t1kUtqzQlNoX1KhQvKVyQP8TkYuVdOT+u14i1KbiJXTazwXSM8z++A
         qK/pPDB26VrEt+rMIUqmd5SKJT5ksP/7Drm6Ns4YZGvGN9IJawsKhfmag5KrUdaYHEnW
         5vNPslKeAVwxSt0GpU5ytQmG4dNHwlhh/2SDlAX1hHk41R5eGDFzEBM61TEa1dkgfsBY
         cFBeOXu0WbQpzaE2eJmS7Tn5O94PYn65BE/uBthZfPfzSocQYL+xp1ne68G7ovqbe2bO
         3Pcfrfkqu0T81tIpp/FcTSrvxqBMNOaxaCd1ARu9vbi46xX3yccZEO68icDix7ydRwjv
         TB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=O4dAZO8mqeKSgi5fN23me6gyxeqZrfrP7G0J/UeuOtU=;
        fh=A4/6RGQjpfyNH3fngsKz0SAo4NKhuDxvMMnu1Fcwfr0=;
        b=qi4b3nDTbtyrbMyYQnGMo5hkhrhsfFmUHbverGg+PypaE+UrvJ3H0KPeNyVYQ2kHiB
         c2dOc9WBYKhC5fxgA18I3yscy0obNPUb/fiG/dOc5YJRCV+jvVM6cqkV5AGaGbOV/UiG
         yTdzzhQn6yafvMRtdNSWAXXLZNVdw3u4UydEsbMpIXjKleOwXsdh62RJvS5+wLocdH04
         uU/JgReqfL6ZEhY8W/f7H8kDZTZSXhviwOtb/8+jRaCUwGVxfWl/J5EGgX8dlh/WUhju
         gCnYQuaxbI31UO+lz7ktAMIx3xWkFyBHXYEI81ZA1hbmGJf51j9g5fcIMT5QVKwF5A5y
         edng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790294972; x=1790899772; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O4dAZO8mqeKSgi5fN23me6gyxeqZrfrP7G0J/UeuOtU=;
        b=Q6qH+mWxZJaJvAv1KW0FTxI9BCsH5OsOQ96JvEmAoR3w3vc8IQxSumZclnWkA1RP+7
         AJDXlon9ahImHv8ruO7cvK86d9m4/Ox/zZgTCcgGzmORa5Ct00FHS2Bwy6wcaw6EXlv9
         c40Ycn+5OxI67+YX/58BlFWv6DXGGvh3R+hgUZRCcMrrxrvIbU6xSEMUBU+qggGc403u
         AsThGV1i5PGJkbkKycKHmB3W7emoLC3A4GapCLJrgWYV7SlenxvbWdbcmGFXROBFh3Kr
         0M3DTw8YmCLW8syU1+OfZ7RbZDR6zs+izNzmoEl6HgwHFz2fOnw617c/CvxtpghuL6YM
         zYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790294972; x=1790899772;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O4dAZO8mqeKSgi5fN23me6gyxeqZrfrP7G0J/UeuOtU=;
        b=CroMZvXPJazMYqkZUaUEZclfl5Wn2zVLAHjt/OYzqByxEYQzJDeHWcuHO4RbTv7m5q
         hpx4kS4I5my7PQ+Q+JdQwpCJPH6BJPpOLAjyUBG7cVT6srFQWw40p/V0GHAgkc3z9CaX
         Mrguyu/qL2P9AXFn7fgZzKjoPlDKETQ8ZTv74Xyx1mAAbxYkJfTGmyhDMMJGA3QIuAfr
         Oqwdw8/t0TkIe7eaTWs3h8awzt2U6SdNeJP/9F0du4SUNt1DVXUsNf3HbUj+9Qf9T4iZ
         ldtdT6NiFESfyo4WuxxleUDx9HvdMpfd1U8FxPrsfxlcIlV5WKdF/9IepvK5ATCBGq7Y
         bWPg==
X-Forwarded-Encrypted: i=1; AKwUvBxNKtKsibVuvwAyRKXlUtcAZuCiNLiaozW0lZDFaHDWYLK2hcJ/tZ6mqqBamUaVP9NZRz0fLQo=@vger.kernel.org
X-Gm-Message-State: AFuF++nwj1i9eU5+ZFxovTlckg+cDaE3nPuW37fd64pR9zODPfpqhtht
	F0MV+ZjkFn1zHUakIwdpKHq6OmrC9rtG9WBK496r/N1Q1xEQsewlTggacVAKoSZMn6kaMfKR6h9
	XI+O8ICiD0BIyWiiipCFvZgaYU4/a9JO0
X-Gm-Gg: AYBFou1zvvPKNXbZSehl4hzdDkeLEbsSAfnue2Qc75rwzcvhwiXHliN+ihuoNbEW7cG
	T1eLtDsrTZ5HvlcMPSFOtGbcrir7aWMd2qH9XrIZH8dXHrsTtUTyKu+xTPoBN2rcrlWsGWHND4K
	2Gc5/NNY0o9K/5C0sDa9sj3hSHWQYg78lf1ko/3ET4ljeYV6DVYD8eGnRyPhGgWzU1U52Mwqxk4
	VaoI/RdaMjYidI3JYPYwy6Hdx56jtFU8iibxAIGXxtfe0RowPo70rJNxfUEQFFEOwVR2+mFhQ+W
	BAhXnQgLeEBV+QthWtP/sCU5Es0ZcZS5UFKYDSeNJhU6qV4xYLNnilUqtYdl8+JJylIeQcge4al
	TwMMo2MIKxI3uQ71RB6VqcBJwgAZUPUkHsyEup6IQ/JhVMSBgoc7hONm6XNlniz9b
X-Received: by 2002:a17:906:dc90:b0:c2a:85:5c01 with SMTP id
 a640c23a62f3a-c2ac22cabd1mr365869266b.41.1790294971950; Thu, 24 Sep 2026
 17:09:31 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 00:09:31 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 00:09:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
In-Reply-To: <CAGEsz8GkK7ZZoweuoR0DwA=CaDzJtQnmTWasEW=wPRv-yBeKew@mail.gmail.com>
References: <CAGEsz8GkK7ZZoweuoR0DwA=CaDzJtQnmTWasEW=wPRv-yBeKew@mail.gmail.com>
Date: Fri, 25 Sep 2026 00:09:31 +0000
X-Gm-Features: AclHuK8Qhl5-EGC4HUcDq0yD-vI60rrYH2FFCNerdpeXKUT00izorJWy0kVNFrQ
Message-ID: <CAGEsz8ENFnYSCS3w7zLnkVbG4FEVG04WoptROY21mn+PnnJ7NQ@mail.gmail.com>
Subject: [PATCH 2/2] media: venus: disable recovery work before HFI teardown
To: vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com
Cc: bod@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhun512@gmail.com, sashiko-bot@kernel.org, stable@vger.kernel.org, 
	ae878000@gmail.com
Content-Type: text/plain; charset="UTF-8"

venus_remove() cancels core->work before the IRQ is disabled. An IRQ
thread can queue the work again after cancellation. The work can then
access HFI state after venus_hfi_destroy() frees it. The work also
requeues itself when recovery fails, so cancelling an already running
instance alone does not close the race.

Disable and drain the work at the start of remove, before other resources
are dismantled. Do the same in venus_hfi_destroy() for paths that bypass
remove, including probe unwind. Disabling the work prevents both IRQ
handlers and the work itself from requeuing it. Drain the work before
disabling the IRQ so an active recovery can finish any IRQ based
completion waits. Then synchronize the IRQ before freeing HFI state.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and
helper functions")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260730153912.BAC5E1F00A3D@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/qcom/venus/core.c      | 2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c
b/drivers/media/platform/qcom/venus/core.c
index 243e342b0ae7..94d4b8688ac2 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -538,7 +538,7 @@ static void venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;

-	cancel_delayed_work_sync(&core->work);
+	disable_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c
b/drivers/media/platform/qcom/venus/hfi_venus.c
index e7e4e78a186a..20b8ba1e62f1 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1689,6 +1689,7 @@ void venus_hfi_destroy(struct venus_core *core)
 {
 	struct venus_hfi_device *hdev = to_hfi_priv(core);

+	disable_delayed_work_sync(&core->work);
 	disable_irq(core->irq);
 	core->priv = NULL;
 	venus_interface_queues_release(hdev);
-- 
2.53.0


On Fri, 25 Sep 2026 00:09:06 +0000, mhun512@gmail.com wrote:
> As part of our ongoing static-analysis research, we reviewed the Venus
> teardown path and confirmed the race reported by Sashiko.
>
> This series fixes two HFI lifetime races during teardown. The first patch
> waits for the hard and threaded IRQ handlers before releasing HFI state.
> The second disables and drains recovery work so it cannot be requeued
> while HFI state is being torn down.
>
> The later Sashiko report also identifies a separate resource leak when IRQ
> registration fails during probe. That issue is outside this series.
>
> Myeonghun Pak (2):
>   media: venus: hfi: disable IRQ before freeing HFI device
>   media: venus: disable recovery work before HFI teardown
>
>  drivers/media/platform/qcom/venus/core.c      | 2 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.53.0
