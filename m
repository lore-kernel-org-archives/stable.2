Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C625B099
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791769026; cv=pass; b=ZX2vsixnpmk20VhnQ6d+IRLA5Wvc0bBLpfe6c5jXs0TnRolEoiwpKnnnLbNV8vQEc4vjfSAqgdpogGIjB0rYMzvI/DCylEFT+kwyIhcfDCgZm96VoVR9LMH9cmJuGdKDMK1xuPnGmefCp8y7m2cpLhuIFf2dZSDiS/oPV1OrvQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791769026; c=relaxed/simple;
	bh=23Lw7vM4wP52T5CZZzj5VSVp9TctYmvu/KUZ9CKSfFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnIb+9AUjEoQLyFbLC0+4gKZmbXQE8VN/t2wG/2rMCHstrMyfEFnJzQ5uZ9rNJErXbs5dfQlEoo3QKWE6aSya2ZPC076mEidGwAGQib6kGNVjN9QOhcm5wQ4IjTjh8uFDp+V95zmXi6CLdMEz/48tbPjiBM6DSY1l53nk4yk4gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcNmOjgX; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcNmOjgX"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso1391786a12.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 18:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791769023; cv=none;
        d=google.com; s=arc-20260327;
        b=ErsF91+fE5dBTxvcxEWm9miLMeu4isyOvC570RG2wrmMpwAava2SrKkxcpT/M18GIj
         m1R3ntAgbo3ZWOWIAmUk+yaCuXmKOnUCPjDJhwiGDcc3zkfSRAnZTIhMcUa1XNYYhVkl
         PQOZFfm69mMGSTI21JmgCVq1V4HaEGRep3X/S+rXn3yXr6KggyqBpcCp+KF9RUHlwXxR
         A5y7CkenggGFxoFIWt+59gsz+f2L1g9YS/CipRYpHXM9gCb8t0Xhq8DMwCn1wlCiKMFV
         1vvXPxFbkF79/n78zJcfeggAF9U+aA2owSRbr3OKtpJlcuSch1HoBujHEZ9V304C9de5
         UVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kIt1CS5cV077Iep8QC6bTj/foPl01OdYIeRJxdNPDpM=;
        fh=hkiKojPskn9/efPPxdBHJ/DJfBHdHO3F+vC0pKnwcjw=;
        b=hyFB3zFw53D8YB9AH8S5/nJ+jklJVdGQNDBzQH+6EM7/3sU8Mnq0aeJ1FkG+01BAex
         AGRt4989m8XVm1XGXreJGcqzzd/myoNdT362hgK0uP9APrxFH3/7VuTxSMWV0os/rfzh
         6wPT20c7CcBvHt2a7+zv55Q0ZyBobv5Nzo/jkuex8vsnGc8VW224k9RlcKTGKsXOKdjW
         yP7mIittWByQs/L/8rRYsxne2dHkgSSoJFProMoKAP8ui0zYSAlfwvmOLBeKYQvwW5l2
         jagM+X6FPMo5D4CYCe/bQg9DluuD1ZLyFthC73mPe/TNA0jSuL6piQENjeCmc9R9rsgi
         iVxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791769023; x=1792373823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kIt1CS5cV077Iep8QC6bTj/foPl01OdYIeRJxdNPDpM=;
        b=UcNmOjgXlPQMd1zO0rW4fso00eY7TnU0dd6c1bPHO3qs33uILAgn8qiwjkCIs/CRiK
         QcFqdlFhb+K4R1xgjWj9wAod5CspNT4H49FSTu7fICel2+4jVtzdBITP0YdkX28hAxq0
         CM9wtkn9yDRd11qQlYRSat1iwxVng3HptbE7Cp62kRBF376OGf7WRn42Gsnvy65IsW2F
         k3IzhfvMiLMTR9avLfZOuiBuTWm7y1eooBblrhBCu5am/2U4xAEwH/QluAd66aOoDs/H
         yUGz8xErzfv5eOU8jdzwyEvOkZu3kA2nUVgzB1E+LRZPRs+qCFINnabgKoLbU5GiBsUN
         jdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791769023; x=1792373823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIt1CS5cV077Iep8QC6bTj/foPl01OdYIeRJxdNPDpM=;
        b=lqtipKv7CxSd6g14SEDQQAyEG3OEVNcB1dCLsvCqdCdsjegLWyVW79G3MG+nDosxCD
         hK0WynaAsB25AlvgCfcPe2JaG49gta8N5kWn2DMRsh35o6c0VszqElQzB7XBceQBT4KT
         1duvfuu0gAq/5H89ovDZfHKDvHAUIwTaBOQkH0TRnovn/uT0b/vC2TT8tsBjpnO8QcW2
         /F69t+X1GpJhTcBBX/73eOzZw5o09HC/GvNfq9Fq/AFdldvX6/EknLiAtFKdfc9S0qs2
         PRgrCqwhgEYjzu87HD6H1HZql6a+3jVSWUOH+aFPN+T55ixiCq+jmy8Y8+lDTNF3IGi6
         La7g==
X-Forwarded-Encrypted: i=1; AKwUvByHRPcWSwCtqByVZGvwgaY7AjTqJiAEq7HmKtYJiLsmXjULFwQ11nnWLsNC2gePYvxtmmrTUQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKb8LiCpSdiXzZFYSBTZggCJcLEavENDt+5+UElFeamWJszxLD3
	1HYAaNkEOLR+PXgNiP7Xac1gSdbiuCyYuwz9oVeZVoPWHJ0Exiz2KjJ9f+t3bGheL3VngnidSXy
	qti8tNH5bXUvi+rLVFG4z2vN5fJ8Y1sw=
X-Gm-Gg: AYBFou24pPeke4p6CqbaAwlJP23E5P00wJUmmC94QEiLKFE1W4sXwkVbhaN/BKUuGTZ
	I9woehnTaFbt5MByb27YNrw8JgSldaI6XoyXl2ZacQLqBVHD4sEwEpVmVaoN48/9LT3Ja/v9zvW
	GmeBWhE8A0iQHA66LaqhsDx8tq04r9YX3fkXOparWrbpIgbeH6A1zI6HsKu7rPneTURA/ojSfc8
	39QXXOo6QQTJS+xDea/AaiyD2gfnCph6VPH9WTepz2rt+TON41cfo5ZPp2Rr3WLSj50R2pcJvdD
	duTgadkrwe4bSfDW8+PSlHt55kzItstUUqYljyPyqOc/GtCKWzZa+ZM=
X-Received: by 2002:a05:6402:1ecd:b0:6ac:8ef4:177d with SMTP id
 4fb4d7f45d1cf-6b17c244847mr7817735a12.20.1791769023054; Sun, 11 Oct 2026
 18:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-b4-ipcc_send_data_null_check_upstream-v1-1-bfc61f5056a3@oss.qualcomm.com>
In-Reply-To: <20260916-b4-ipcc_send_data_null_check_upstream-v1-1-bfc61f5056a3@oss.qualcomm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 11 Oct 2026 20:36:47 -0500
X-Gm-Features: AclHuK_9kqp9LiaECpF6jdko0DVDOwODce2xY8QZwz01sjZXIAlcS2lK4ydkNvI
Message-ID: <CABb+yY2TGZX37Ketsx33Q93wWLSw1LP9+auTHywmb9-GrBd2-A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: qcom-ipcc: Guard against NULL con_priv in send_data()
To: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 4:57=E2=80=AFAM Anup Vishwakarma
<anup.vishwakarma@oss.qualcomm.com> wrote:
>
> qcom_ipcc_mbox_shutdown() clears chan->con_priv with no locking.
> qcom_ipcc_mbox_send_data() dereferences the same field without
> checking for NULL first, so a send racing a concurrent shutdown can
> crash:
>
>   mchan =3D chan->con_priv;
>   ...
>   hwirq =3D qcom_ipcc_get_hwirq(mchan->client_id, mchan->signal_id);
>
> Add the same NULL guard mbox_send_message() already uses for
> chan->cl, and bail out before dereferencing a cleared con_priv.
>
> To close the remaining race where send_data() reads con_priv a moment
> before a concurrent shutdown clears it, acquire the spinlock in
> qcom_ipcc_mbox_shutdown() using the modern guard(spinlock_irqsave)
> primitive before setting con_priv to NULL.
>
> Fixes: d6fbfdbc1274 ("mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustio=
n")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
> ---
>  drivers/mailbox/qcom-ipcc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 185b63f724d4..387aa72aeedf 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -10,6 +10,7 @@
>  #include <linux/mailbox_controller.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/spinlock.h>
>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>
> @@ -151,6 +152,9 @@ static int qcom_ipcc_mbox_send_data(struct mbox_chan =
*chan, void *data)
>         struct qcom_ipcc_chan_info *mchan =3D chan->con_priv;
>         u32 hwirq;
>
> +       if (!mchan)
> +               return -EINVAL;
> +
>         hwirq =3D qcom_ipcc_get_hwirq(mchan->client_id, mchan->signal_id)=
;
>         writel(hwirq, ipcc->base + IPCC_REG_SEND_ID);
>
> @@ -159,6 +163,8 @@ static int qcom_ipcc_mbox_send_data(struct mbox_chan =
*chan, void *data)
>
>  static void qcom_ipcc_mbox_shutdown(struct mbox_chan *chan)
>  {
> +       guard(spinlock_irqsave)(&chan->lock);
> +
>         chan->con_priv =3D NULL;
>  }
>
>
> ---
> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
> change-id: 20260916-b4-ipcc_send_data_null_check_upstream-072b8856680f
>
> Best regards,
> --
> Anup Vishwakarma <anup.vishwakarma@oss.qualcomm.com>
>
Applied to mailbox/for-next

Thanks
Jassi
