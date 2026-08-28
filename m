Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C643935C
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916628; cv=pass; b=N6CqTYjDdAqaihtJVhIyuEYnA6FJqOM7NcPCeG+goGeSAlbP6pY4VgUn4rl1/UOa91aiOCjGZZ/BKBU6iHqTOlcXwfUxOKIC8uCLJkREZ9Rnr4sXv5622gRTRq9CNhQ+FAqs6EerEI1Ux5je4RI6ghTJ7XJTHvKfp1GuJU7W8Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916628; c=relaxed/simple;
	bh=E9IzD8tLZ4atOCJiLq5vH4xKm19d5mbqDq35ouwu4+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9xB1S6/qs2+y5KwmvTdrBdx1o6rc8BvvHjAdGIZYRdnb40YEtuadShDiVa2y+qe4vfGsIyQo/eIDNRMKdwHVQZJBo0VCR/Zbl1WCQaeeHaQ29sWhy4Ga9g8MvHRp13AcnbG3IDLmtS4L+YdrFmu+luxfKh1A2iupI7M1au023o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=BLK0hS8k; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="BLK0hS8k"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2532639d10so8193366b.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 04:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787916625; cv=none;
        d=google.com; s=arc-20260327;
        b=bL2QWdtoej+4wJKku4NP8nIXDW9wHG5F42YRxh2c9E5+wz/8gPxXBSBRaTX3+uK5EJ
         AQt4JhbrXE3szCpPF2KpmiGvzGtXOWnqdOHr8U+ySMYppC49AhZCvmrsr6XXggVlMepr
         g4mY8qglApr605ZDgV064gih4LzM56bq0uxdtVfJi4KreExZtiC+9Fhk3j4fWnaaEfuD
         epsF7GZQ+5eTJLE9pe2BWJQGFRPlC4fehymhFEGjvV9/OSQtKXqaEsjCeJOQt1QF/boo
         rMTBhv5z4P7hLrlXmZxQG14KBQ7EKxbYimjrqbWY8W2oqVOgOQ0Ee+nFbKngr1U9zLLN
         wDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UKuFtJJZMcXxiN1w0UPs9tMckP3rl1Ohl3fu+26vt3I=;
        fh=WDr7lzyFROKfw1sKvV3QJ46pM+Dp+GINy0/Zmqr8ejA=;
        b=hV4VZI/Col1odYll90Rt1bCQWrwJAp3ZJgJNPvnVMv5N9uAg9q1eqCjcd6VsQkzfTw
         +6YOer6egzUML0e2QHAxMjUQMUUUYcleGpqHwygEpJLNyGOuXCf5sEXX/b8BkBpG1aGD
         /lXFmkUpp1eH1s9K7plzWQMhRZkp8B4Jvaak0n4demQ51HHWAkSWUri0Tu/dfYAYQ41L
         dzxH4BVws5F/CrA+lCufU2kRBEt+z6EIB8lebgq2/ymeiWVXzv2KMpR49/2pzSk78FPL
         bMM8dIhF5JlkrIHW9STUHnmI/Ixqhxc5UoklS8G7Zy3yBXeiz7YNMwjH4iDTAOavG5tk
         nxhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1787916625; x=1788521425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UKuFtJJZMcXxiN1w0UPs9tMckP3rl1Ohl3fu+26vt3I=;
        b=BLK0hS8kVJye5XRrkt2Z4E6/5xNXz+iq8v98f5KTVhvD1PZg62ofolFxRM7lp0kaDa
         GErxSSEiGSXLbslkgZF0dXlIGyAvtf6B8ly43bGNpcyu3WQh1RU3uM9ULN1q03+gByNi
         +8do3gfX+6kjMThUPr5TaA5QV5/J8L1INJBMmGOWb/wKguepM5Q/fRXtseeFeSJBkh5v
         71klXPE4Rr2/XPlCrkqJVRDm+GrKYe76uXmpQADTUc2EoX8DBhCHxkAr5moPa3JnmK29
         ASiPW8Clry9kiHgh4A8MTPBi75RE9P7RjZr3Z1BcetNxCuWazcUXY7Dorqw3kSYDzWq5
         rZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787916625; x=1788521425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UKuFtJJZMcXxiN1w0UPs9tMckP3rl1Ohl3fu+26vt3I=;
        b=NGhXsjRHxLvHV/82yBgYEP2p2BvNHrm3WA7vTBRA9VDdNbWfxb55TEifybM+G96Pnp
         wmgqUlY/95bqm9I0i/0aiqoR7NZiyZKeUK1cHOAXPvlp9Z9yygJeADvlEaJalSfMcLPU
         uC4WDPIELxgd6LJbISGY5KDLx07/1itvEkT7SIrpaST4wSpQ9zhcyGkHE5nPJ5U/4MYY
         JNwNnaeRs2DvQ6nUeNsqpqUg0JS3bCGApm5zh0I1Vxx+9HhUpjVH1xoQKrMTm08dG7Ny
         UGWJz/TRuTXb68UkrHg1s4yef8eONMLVx+PGpL/vlNVsmX66RfjsL9D9vQfA9nfnsUqV
         qpbg==
X-Forwarded-Encrypted: i=1; AHgh+Rq70d9G9fIhMJuQ/FnlYKAmWgRERj5lEoIjiuLCvMNX09MAcPf/2uBJtubj9P0zbtcw9zt/bA0=@vger.kernel.org
X-Gm-Message-State: AFuF++lGrkBbFV18FBoNVnYy3kpr/iHo9hUWsX0XjLaLqVxdBofGJVU9
	NqTbTuc8vNi0+Gz9+5RfTjBvPAGuB3YG9cGlX8+yXp3otRtiUD0ArWNt3pViEcq/zZ4gbULOQGT
	5OOKJEVx4XeHXvzkTGbEzGiYTwFNuP/3Sl9RXthJkuA==
X-Gm-Gg: AR+sD10RYNQA+EnEW5X1BZXBcat2RmsXYZ96/MMnEntFT5pO7o8MSxbLQaelBNNe2On
	504g8VpKBx7h90814gYpjXvvlPLhQcNbg5qNqjFu6cF3ExOJekiQTUotNlbRz5+7BwrZVWX0ZJr
	M3pLYeK/JrE+wgcKsNfo13vVS8mvyBRzpimBlI73oAnVKzJI0ExjWi7AUyP3c4NT8/RUoBFalxx
	yzUZJaXDc9bDJlVn9KroTsuoRb24FRooQyXLMmneuDJDI41MrSdK/44k1E7qeMSs2m+ViB1S4WH
	hgCo/zHT1giBrPgbnL5bemBbKHFnIZW0qdtsYrO97f+5Tgqi2Fi6Ntcvg6yv+tHMfO/s94TU4TO
	0KQ==
X-Received: by 2002:a17:906:ef05:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c2557464543mr209561966b.4.1787916624371; Fri, 28 Aug 2026
 04:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824113618.2239100-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260824113618.2239100-1-runyu.xiao@seu.edu.cn>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Fri, 28 Aug 2026 13:30:13 +0200
X-Gm-Features: AcwNN1Xb1tEMQdHfmnOobPQMaAG_j21-E4c60KKb3LfDE3LUDihv3S84LK9hgZM
Message-ID: <CAMGffEkZNCjOskmQ+0gXs3Ezw-q3jAxiBeaJUN2t4nhrnUHw4w@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: use rollback index when freeing MSI-X vectors
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:36=E2=80=AFPM Runyu Xiao <runyu.xiao@seu.edu.cn> =
wrote:
>
> pm8001_request_msix() unwinds previously registered handlers with
> free_irq() when request_irq() fails. The rollback loop uses the
> failing index i for every iteration instead of the already
> registered vector index j.
>
> That passes the wrong IRQ/dev_id pair to free_irq() and leaves the
> earlier handlers installed. Use j for both pci_irq_vector() and the
> matching irq_vector entry in the rollback loop.
>
> Fixes: a76037ff3479 ("scsi: pm8001: switch to pci_irq_alloc_vectors")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm80=
01_init.c
> index e93ea76b565e..21419e46c16d 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -1029,8 +1029,8 @@ static u32 pm8001_request_msix(struct pm8001_hba_in=
fo *pm8001_ha)
>                         &(pm8001_ha->irq_vector[i]));
>                 if (rc) {
>                         for (j =3D 0; j < i; j++) {
> -                               free_irq(pci_irq_vector(pm8001_ha->pdev, =
i),
> -                                       &(pm8001_ha->irq_vector[i]));
> +                               free_irq(pci_irq_vector(pm8001_ha->pdev, =
j),
> +                                        &pm8001_ha->irq_vector[j]);
>                         }
>                         pci_free_irq_vectors(pm8001_ha->pdev);
>                         break;
> --
> 2.34.1
