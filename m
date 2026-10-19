Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720B379C5D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378606; cv=pass; b=pjNL4a9t4wM+MUicZZ5la/U/vsxin8nBnAHSsKmOjXkD0x7tOPbxoYJAw90IV1LuS1q0Wg06xYE+0zpKROls+t0QJm5JoIgY0NjTvO/aG3l5cq2ZuGmYVVdeW/A6l0PQisU4YoAd9pyniEqWCBwdaZfUP+1MOnQfrXX4y3lZo6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378606; c=relaxed/simple;
	bh=10plZnvJMhdXNsmI90PPzAB9gg2/WU+vKhsLPvgRwP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TomoIGD9UATWOw7Vi/qJTKxgjG/djJ6VuqUFAjuvRKAgG5yeh9EEN8dzasNcvWq8haWKrpXyVjb0KzfoAbn7sanMVTJfflYQyDXEXpCyCjsiJwoH98WeaGYDmkj+J6J9fpsafv52r4MhOKROGc0nvbeKyKj7QpNLjhuCJJjW0Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGXZ1ekT; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGXZ1ekT"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a808f09021so9880191fa.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 19:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792378603; cv=none;
        d=google.com; s=arc-20260327;
        b=JUbU9hmuDlNmvRUAP148JzQMf2dcRgLQ+HwKaASsPROAhvIvV22YuzAA8WtRPBqlwh
         sC8xlurZijUjGmlQpxXKngLG2xNDMQTFhgMkJazCH21eKLBNXcL4n+tTHwYMAaQBr/08
         ISMer85ymfBBY0aTwwNdEU9x6GM8hSyY8WiRrLFyuVjWbq25VfNos0XOwlX1ObbYlvki
         fD009D8G9i9vLQC+uD7lulT/M7uBQot9oEluxdxR444896I1lIFjmR8rEXvLxzm6WUgl
         YXa6edBbUIe/rFkgngesWVMZyJTfB+GGvZ8zcpe1ciG7spJ4TAcwbJ+eeOHPQghtXqaE
         B4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rEXy3zJHTBuMv4/u8qe2uCzOwS6GppmHMS1cvnhJedQ=;
        fh=LPvEZxAYYXj250vjXZJWdj/29PHYITJeBGvKqyYDglc=;
        b=eGchn2qtlrlQtGieFqi3sR9IAoQ3/DOszigZEgiRro9IEyWHTQQKolqf6Y/fLiaLZq
         0LUiD66pBpiNwHu3YkiBhev0pZ3Zf2aOxTdWuzNwuthFi7arIUI8jLeWiAkOtce2qLcx
         OHBA0NBjxtenX1rJuiuUNSoiJskfQxX0FeWn/LGM9eSgquIZa/pATN+AMEYW8FkP7VDR
         YTP9R2Udmhywv0qFGyhbMCFEmUK2bTxcmwxhnUU/kJLNqxwrzKWJeZ2U4bYpR4REuMOw
         9lj6cqxNY0ZS4NuHrk4zgiIacK68jeXIbT2KPQDcB4ZsfJe1t/SfUqux07wuHfFJkfAh
         4Wzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792378603; x=1792983403; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEXy3zJHTBuMv4/u8qe2uCzOwS6GppmHMS1cvnhJedQ=;
        b=lGXZ1ekTbDPnyPV9bWbgEY7WSAOZSj0yf8B73tH3lAqV5YoFq2jjHP5YmMOa2StNn1
         8gBOBxVUQirlG1RIZ+7iHlrmwlM7lU77s4Hf4YiJSrT7beAIuwUprymPVkNIK1Ij+VjR
         u1cbHQeDFpb79/AW5eGRcurcP2LsUYuJTyi9l8WbX2NkyB75Q68x06YweCloQYxWzDn6
         wC9D7JFoLBQWJFOhHosfANk/g3SOAtO5WWbmLLBcCykaomHjkV8yw+Y8JkqAKxeebH/h
         KHZwASl052Fqk8M73bJS/T5GyUhVLnkYW+StI14+mBfh/uFMuAmhapIHQfa5ExIyr9H+
         yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792378603; x=1792983403;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rEXy3zJHTBuMv4/u8qe2uCzOwS6GppmHMS1cvnhJedQ=;
        b=N6VW0cyHj31kJxc7qBuBsVCljEUguzS8ULuKw3iqMnPdzy1C0gMuaiLOl0IQ6fCIlw
         EkuYZveyZyOVJW6WPUrW8103ytCh3EBuEBI8W34fQ5F4+EldvFUvbSs2iNXmZBcMYxF/
         l+fIe9bJ6l1tC198mwxUeQCKNXW347ThyHfl/YeanxfDf7aqUOgGjWMMsedZCwU7rNmO
         /Gd2ll0EKnpRP6+Qk815lJczV5knicCqAXNuvKmsvkUdKc0cpa/FXMJDoiD25fqqMeGf
         7nEqyPRjm3P1hP/0XXlKYQfmhtHaNmk7LoQnfYWUqj5X3GVqq0j11JP2HFS/PG0yAn2B
         iBdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTibFOwxbbYiFh/Ad0yHwsgS03NRO3r4yvYH5SqJzWegz/1T4EybeTJT/pnV1c1TXAKwobFuw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGMx94foylFl9qcHtfX+hhkogd4ID4e9g1DKB/fGWgw/3s4jof
	0jdVBePHo6NaO3x3QOTa5dyQNrIZcFa5wNkzc8JqpBDsp5d6g8ieT3wn9YQjWAbnV8fm0j7zJLi
	mBUse7QuMD3qUtSVSl8tnmtJLHm3opXNlX7BF
X-Gm-Gg: AYBFou2/q7NZ3cW2tcGdzsl0uKxM6Dckk2J55Ji04MHhugpa4EGYoMJ2DgyK1yzgd3f
	dJ6gRUkyRKHlM5xMB6UfbcDtGi24kJ/BeA34svS3uPBu7FCvftqZqQYAM2oxvw5TCV51NJSLWPq
	+fPnUp9qdPSPNe/5k7Ud9DAlJGM7VgbvdSgPlTIapzHHiAeE6fmIl1G9UpIuswHf7EKEJAfhu30
	DecL7PthH67Giub1XvpolsV8ARgghwPJVwQs2JPxSxq2Q+sjN/jNTBwPqyf037Xue0VHolNU4sv
	6dVoLMpS+fI3farWUtlXC7b/aZRJ47nULFEo8Z7oYvsNdSiEP8m/UJg=
X-Received: by 2002:a05:651c:19a4:b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3ab29121df4mr16100801fa.9.1792378602626; Sun, 18 Oct 2026
 19:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016035851.771496-1-oss.patchbox@gmail.com> <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
In-Reply-To: <a7ed450b-5dce-4485-b4a0-9349e75e4c52@nvidia.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Sun, 18 Oct 2026 22:56:31 -0400
X-Gm-Features: AclHuK-33whnZxqMRpG7_qtTL-IVLp_9OZjQHscnm4NOXyKbUUtioZXEGPyA0lc
Message-ID: <CAGG=RgB2NYmjugQrVOiKyfPF=_aU47CY_JXGmCLQ-kOe4Cxp0A@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] vdpa/mlx5: Don't free QP buffers if destroying
 the QP fails
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 12:01, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> This commit message is long and hard to read. Could you make it
> shorter and more readable please?
>
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Cc: stable@vger.kernel.org
> Nothing against the change. But it does not deserve a fixes tag.
>
> > +             /* The QP still owns its buffers */
> >               mlx5_vdpa_warn(&ndev->mvdev, "destroy qp 0x%x\n", vqp->mqp.qpn);
> While here, could you improve the error message please?
> mlx5_vdpa_warn(..., "destroy %s qp 0x%x failed %s\n", vqp->fw ? "fw" : "sw");

Thanks for the review, Dragos. I'll send a v2 with a shorter commit
message, the improved warning, and without the Fixes and stable tags.
