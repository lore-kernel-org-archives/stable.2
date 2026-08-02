Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC74390601
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785659956; cv=none; b=K0UpIurmGVIxRXT9rppOX8MVJucEH6vFXq3LxZdHONasH3piAVfLGahd5qpKeE4fE1CXE3e0qHoGUBn50iCSKiCrnfR4zQvGvJ8rRYiFl0tZddR1j2X1yn6fxZk1f1qQ/GGaeIcngoBlpGwep+I3Rb675hmMh6TFj1h1kpyvbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785659956; c=relaxed/simple;
	bh=jdjGUbkBcV0dBBL5aNWg2VRyEgEe8YXwInGBRXnUr+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGLc8rRzMQ7ozCqkebbBXP2eRS6A5bx/uhULQ395AWJwYvPviLW54qwU8HPANiOwZtZOqVukqM4QxpLQcZWMEnhCwEgDxPKh/i8wjkchmRzgiQL0OmrwM2HZ6gO70dFsfY0VYKn4dOweJkeXTrgmq1jn3iGWRkx6b3adwNoSlA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MNSJJRjO; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MNSJJRjO"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so15290096d6.3
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785659953; x=1786264753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSsJZEdiBtDK2B70Vi/SVAEmECezuO0RlJM9j9BqAkc=;
        b=cCfftGhKHGcH2SRjPXQO5rXen+5ruyqMxrijTfpI8BQmAnU6AylESB8x7ttEjXVHTO
         EloK43DRaJq0liECaBHNJJMn4ePV0uc0+spRnagP5XnAzbh6JnSRYBKDsX8ZN9w89AnV
         cQsrF9jjbDLlvgfzTlts2dBKDchk1oOpa858UncZEajDP/3Sty/8GXJYpvyqGlkIm20N
         Ldg2Y3BJpJSIo2EJe3N2wQ5gDobDdvBFbVC3Q5TgPUWRxU4aELHmGzhdeNkWVIN6n9SG
         HgKg2U5A/MMqP3BP1xusfTa5Lqb1Ywy3c1vJIXnYIhQ/itauMDt1AlyZqNGA8jlQSiqd
         ebjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxxPGyQhMR57p7I/FuZlGngHnDVb0vQqjd0EaUQEgUZeaTntGWxc+li8nbA07T4oRXUfUQXUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKYHW/kZTzfgss8gznvIkQ9ptr0lDfuK5zvy5dBVh2bt9XUih
	XjOaHLS4KhijgOjuawdW54bJaKktEvyph26hRNuSUW06O1O507zP/fij2yHX0zrpQ2PqMuGnNgS
	tR5tAELbfhUB4FNgaURQr32g93L/WZxAuPJ/VEumsXxh+MkbsiZUQT/wWRBo0brxf0J/GcPZtLU
	71Xg2xAaJ3NSFKDgOb+/Yjr0xJX6mdOCo9O63fA2MN7+X8wwUUREqszIYki6bZVC2nICZJ9vGnr
	q4IhZW5XEsGKQIICA==
X-Gm-Gg: AR+sD13kuuRQjxvpBaXxWeB5GIPl+GDm+7hYHJJzTnB4VdrM9q9hOPAj/rF9Bzu4zNe
	/Qk7iFIMHt7rCdyimai/HTg1tQYhSvv7TKJfgvJDAUcuWmc4TK5p3Cq/NNUFiNtbdpKO165q1F1
	od3BOXFOnD+A0jHqpTZ7vTa2/QUFRVZvuOtE3NZdEGS7E34HQUYk7Prqm5CCx79Zq4PZ8MLRjGM
	cv2T57edloB22CpXZlBYgREN5eWsqNYiVJ8LaU5s5n0bsqC3CAqx6bu4Zws0vQMIn+TAAmsmREv
	IkZNrTAi0aGRoHCmIahVTjexA3Hheri1YvRv5tAneQfDWAGCjuE6EGmMesymP+cLn3nnIlp+sL4
	c4dpY0VL1JzM5W8HJEfqYa09Dr37jO5XO+6o/fWucEaMrc8pWgnaU54s5sS49zjV0wfYjnujyNl
	B76hQYAfd4E2XCxYSnOMFt1Qsq3QFvF5Gc+byM+eI=
X-Received: by 2002:a05:6214:20e5:b0:8a0:d08c:a720 with SMTP id 6a1803df08f44-9084960eeb5mr113284346d6.17.1785659952597;
        Sun, 02 Aug 2026 01:39:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-908435fd472sm4284196d6.25.2026.08.02.01.39.12
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2026 01:39:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f08560ea44so25705776d6.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785659952; x=1786264752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSsJZEdiBtDK2B70Vi/SVAEmECezuO0RlJM9j9BqAkc=;
        b=MNSJJRjO4AMo52+Us9XXHZHO1kqXx+FQ5hDLWNrupVBxrXPy/UFSZxEJQwMRABQTGw
         5oERSDsjiJgNnJKyCILuaDfuBFKuNl/DWhB6p0zWDPuGfnjyOijS01wDHZeJajXisfSO
         J6H4mnuYTafq2/O2UC9IsNMtiI2io6WZ4anXU=
X-Forwarded-Encrypted: i=1; AHgh+RpzzEAxG0HjAJU2s/yjyZ7iKBf8p6G+S7LZ9bsIEh7n08Hxmzn8pYTGw6Dka6zuhyshxfRle9M=@vger.kernel.org
X-Received: by 2002:a05:622a:141:b0:51c:7d0:7ed7 with SMTP id d75a77b69052e-52b567da7acmr119734361cf.39.1785659951962;
        Sun, 02 Aug 2026 01:39:11 -0700 (PDT)
X-Received: by 2002:a05:622a:141:b0:51c:7d0:7ed7 with SMTP id d75a77b69052e-52b567da7acmr119734161cf.39.1785659951525;
        Sun, 02 Aug 2026 01:39:11 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435def8fsm49457956d6.38.2026.08.02.01.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 01:39:10 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
Date: Sun,  2 Aug 2026 10:38:59 +0200
Message-ID: <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Wed, 22 Jul 2026 16:37:12 +0530, Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:
> The memory allocated for buf is not freed in some of the error paths in
> brcmf_sdio_read_control(). Fix that by adding vfree() calls.
>
> Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control frame buffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
>
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
>  1 file changed, 3 insertions(+)

To be applied to wireless tree.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
