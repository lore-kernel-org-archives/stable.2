Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10037B3FD
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791947290; cv=pass; b=UUEdd+B4Tcy2qDQAW0PktjUB4A3qcenchpg0T4Glt24+qz+4c3Yf+IVcabhLalutjGfNnBugO4ct2TT4Po5iFipeTKJedjnPF0JY33bjpsVhAB1N8J8fi2gDQLZ7u6YlwdIeTGq+vEvEsROsTYYqLL7/+ighpw5h1bH03uVjIu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791947290; c=relaxed/simple;
	bh=uSCQoYpzjWFeo1wHrvvzz7nrDX04om5nCgnCg/UJRJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrufDmuMYLYMmgRMJKOMUgm45RGIrDCXBP+bv2vbrQIpcEkb+pRFBHqmvMwpykKhmMR4vG5XbuvFWn97B7QNaX4mxlENwzKp3H1Q2+lLq9wzMXZg5I7NYd7Ni7FASiekKkHIxg+7k1K9piKA7IMvrPh/6aazQWFLmGeKPZ0mwkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeWh+tc4; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeWh+tc4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c262f1186f0so479562466b.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791947287; cv=none;
        d=google.com; s=arc-20260327;
        b=XPPoX9kpPvlkZgUgXlEdo8pvTdPgea0CQFEYsJb+pn5hSaELy+UDe6Bu4RXuL9E4eU
         a1ZeCdS87hrWrz+91YNa9w4KaVPtUMUdGQJdF+DbRsjvZNb8pLH2V4qoCsA6vtdZGXux
         Zduu4cX8+MZZbACERpfRTJqwG9GvnMf9UNnWP1NN/NotVqHSXLxRtpuJzADwfXlCQ2CF
         qMOA3Fy/PhvQJtvN3BseybvmxVbAoOfUIPTx/4Pk47HRBt4FMiMrNt52/oqjJGMX17r0
         GlIiV77ko3J4Yk7J+ENSmBBEy6TSORRHpj40+AXsL96334cFCGrkBmtjCjNNjwQson8C
         zXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aa4Yr7SwreeKDT4ivX8qB2f4mW+4V99pbNocmP3LRcY=;
        fh=vnJJnRymG7rJqmTpEerGfrwn3blLw1MHNZ7MCAmyGJ8=;
        b=ss2t4QxWbVN7dTGQt7bld+f3i39P6yqvI+twI7GenEjvW+qA1yeIJV7roDe1Td1MhE
         HeJp6CDplMul6XtQsrSxd13S+tzlc3gxA+ivNNcUKvXILWk2Zf9UJjFbdCqMhifO4CFa
         grqxonSXi/IpxMhaAF37Bu1612uHcjGXmaO9sSFsFchxtDr8+f340D4h5Th6uAWw/ncN
         mwv23EC6Cj+h8IHfwjQGrs44GCn7d/4Ml9pbAoIAgZLhuc8kBc5cfytQUMBP6SlLuJiU
         s/2mug4h/8stQEU+moda5BsqEM42ODArH0H1R+fhpaYzzRwJi4xXY4bkRnQRRdE7trY7
         aLSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791947287; x=1792552087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aa4Yr7SwreeKDT4ivX8qB2f4mW+4V99pbNocmP3LRcY=;
        b=AeWh+tc4jiOr10euWKCqzxOKp0eyOxAwqxjPynb2G0VRQJ1DzJKgarn2zHwUUdWc0D
         zGaFYBCIsHRRtNRbbRjdabW2KMN2fUH7mA+vMtT0aalcLv1NeqRtxzUth15JMasbDx9q
         qhbMRK06glIfiVan5hAQSpRnnJha5TInp69ts3cCTgbYcYpoO93g9H9V7gm0FalJwvHI
         GzlqOKRjtNQlN4WDnfFpQQY/KKKo62Z07AuMEvW9h3AlyLYOVobk4jtBouDd7L7l9/Gl
         Mx8CpHXaYJ3Q7vf83QjtcLr79GIjqRdOMWsdVHlSMxgsYYOvMqJdaCrtdWFZfZ0YuRJT
         1+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791947287; x=1792552087;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aa4Yr7SwreeKDT4ivX8qB2f4mW+4V99pbNocmP3LRcY=;
        b=LpuqZp7ib5Eyy2Qch6iPTmuVF1sQPNgyZDC+ATsSUO4DNOh/VbzpgaEpg7z1oNRlHl
         uOkCUD0BO1+etnApwm4kBlmFeMvt7rqIHZjoGHfrNwhVtKLqnSvFmKGr1c1Ski4HNB3k
         Kf0naSCaf4eoRrdIinb05n+GGmtbB0JG5fFiZ8/giBOARjLAJYtoHUcGcZ3iKJ1PtUNZ
         Q5JLCvoHBSnwrdmKw2BunZlUWg00UGlL+WhD3EJ9fvxidvxJouaj83dNnvk4oQKf2ixr
         p+F8izqfaeVSG5tUTznDuMgXUaeAPTgRagAXHxnKEfLBFOdrHA+YyxU7zkIOmqxcpWrl
         JREA==
X-Gm-Message-State: AFq9FYKrn/F8HJI6qrZdIeUxXIy4JUmS/wrtOehratAzDJiX87LCHoQL
	vOsnK+fuHr1Z5hyO0MBMTqTogDpXBSYLQy//XSEPw+IJZ0+7mepRzvRRtMRzX+cdTq+Qj93ShcM
	un1xq5B/qPo9N06KlS77fHMbzvvs/oTM=
X-Gm-Gg: AYBFou3s/BuNgR8+b+8tfTcuI8aWrhf30o5GIBu+8pUg/APibmxgOXjPNdAkIbqVlL8
	fSxVmquYIcx33Z0M0ezOvRQJ/nQ/3fPj0kybkB3kfQR069ydR8p/cM3BoftfXzFVQH65oNxV1TP
	hefZIdvyX4EsbXoe8+8XEkSUeSAuOsDkvF9GiECusK+C6SQnGiph23BGPXbWdXr9TijykWQauxv
	7Tn42AVe93G35qt8Ksg9ssy13Obwugpe58C20oZVmxuwlwgnjwiGtzcy9nGt/u0EtF7mPTMOTC5
	OMxJIEOwqRr2fMeqTGVycLErbzJCN75CILmKGyhjV2rgbMzsP3/Q8vaMN+U9S3OFHTE=
X-Received: by 2002:a17:907:2d94:b0:c2e:8eb7:53e8 with SMTP id
 a640c23a62f3a-c31aa03cd11mr1407785566b.30.1791947287125; Tue, 13 Oct 2026
 20:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008184328.2857037-1-andrey.misyrov@gmail.com>
In-Reply-To: <20261008184328.2857037-1-andrey.misyrov@gmail.com>
From: Nigel Kirkland <nkirkland2304@gmail.com>
Date: Tue, 13 Oct 2026 20:07:53 -0700
X-Gm-Features: AclHuK-8V7o1mkWksypfs34fZk2Yx_H-EjQzA4IbedsxqhKr1LVaSdFzy0NwxQg
Message-ID: <CACnqm7_5nvH18EGCdW=VZy3bLJUG7geaeTDezG9AvAmjGPnF2A@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] scsi: lpfc: Fix use-after-free of mboxq in lpfc_sli4_driver_resource_setup()
To: Andrey Misiurov <andrey.misyrov@gmail.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, 
	paul.ely@broadcom.com, martin.petersen@oracle.com, nihaal@cse.iitm.ac.in, 
	linux-scsi@vger.kernel.org, nigel.kirkland@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 11:46=E2=80=AFAM Andrey Misiurov
<andrey.misyrov@gmail.com> wrote:
>
> The 6.1.y backport of upstream commit 1bd28625e25b ("scsi: lpfc: Fix
> memory leak in lpfc_sli4_driver_resource_setup()") added the new
> mempool_free() of mboxq in the wrong place. Upstream frees mboxq after
> the error handling of lpfc_get_sli4_parameters(). In 6.1.y the hunk
> landed before that call, right after the NVMET WWN loop:
>
>         mempool_free(mboxq, phba->mbox_mem_pool);
>         lpfc_nvme_mod_param_dep(phba);
>         rc =3D lpfc_get_sli4_parameters(phba, mboxq);
>
> mbox_mem_pool is created a few lines earlier in the same function, so
> the pool is full and mempool_free() really kfree()s mboxq.
> lpfc_get_sli4_parameters() then builds and issues a mailbox command in
> freed memory. This happens on every SLI4 probe. Its error paths also
> free mboxq a second time.
>
> Move the mempool_free() to where upstream and the other stable trees
> have it.
>
> Fixes: 299f5baa1321 ("scsi: lpfc: Fix memory leak in lpfc_sli4_driver_res=
ource_setup()")
> Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.=
c
> index 13ebbe4..fc5a640 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -8175,7 +8175,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *ph=
ba)
>                         }
>                 }
>         }
> -       mempool_free(mboxq, phba->mbox_mem_pool);
>
>         lpfc_nvme_mod_param_dep(phba);
>
> @@ -8209,6 +8208,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *ph=
ba)
>                         goto out_free_bsmbx;
>                 }
>         }
> +       mempool_free(mboxq, phba->mbox_mem_pool);
>
>         /*
>          * 1 for cmd, 1 for rsp, NVME adds an extra one
> --
> 2.43.7
>
>

Looks good, thank you

Reviewed-by: Nigel Kirkland <nkirkland2304@gmail.com>
