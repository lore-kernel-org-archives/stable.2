Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D67408001
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096738; cv=pass; b=OXuvKP3YwOtd0Wo3phO6HY186VbT6p0+eDGmrdc8P08q2sZIKEwN5Yn4Q0q59yAxIG2CY07Sk5wUmX4IoQ5G4D+nz84mscBSAzxk5ecXv0u8MlPkISnP+VbMy61lb+aJ/o67PtB0sUyvrMUOGG8YL9UFsyqwIcVbrGEvkD+K86Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096738; c=relaxed/simple;
	bh=QHUqVSv2KaaURqb9cPHR7aND7tqFpUEAhdFRJWdcb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxWxS59LvTeTxSRbsfbFFy6HyfFjDaqYsJK7SU5X3GrBzf4j9lhjLIj4+WwaEskIXvdtrO2DyOpfUP5u4TaQNadDqpdJeem1tyK07gqEABnQDB7Ve5HkCMFVGOb6F2LcVP5bNhfdtRkvns9zT9+YtFlyCll2habCL+Sfasya4jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF1R0mNS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pbZMc/Xw; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF1R0mNS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pbZMc/Xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781096736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
	b=FF1R0mNSlAX28LC5XueCAxKk1qKP+3av8B3vRllrD5DQSJQpO1tM2ycBH3wde84PxW0INq
	/Q9EGJ27QsnYsD81eIQMUibroBql4ZNPrDloncvxnviqPlPIXhKJM2unKSohMWhE7l4ID5
	+rgmX+MnEJc/jbY9WKMV+UXzbXqIzUs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-2-s-C7GWNy6wEl44g0APRg-1; Wed, 10 Jun 2026 09:05:33 -0400
X-MC-Unique: 2-s-C7GWNy6wEl44g0APRg-1
X-Mimecast-MFC-AGG-ID: 2-s-C7GWNy6wEl44g0APRg_1781096732
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3967e27c060so31325071fa.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781096732; cv=none;
        d=google.com; s=arc-20240605;
        b=HRfv69PcDWaurr/5vfXAnRyAg85jxwNTHM0FXqv/fVrPMHaz74mPfA6FD3JLKQb/j8
         tb61TiteWZFDoOcorfJfzEsJsRKalgokJCmHRT4HRLZLeJOuCEeiz8Z+ZPXU464ncj0O
         iZQBcSCeyj9nuhCjKdHwN7aosCcVMB51RVUVlmjY3Ysch821g7jFwOOc4XD46cFRIyZT
         y0vOPTerWsie7aZXxpCh/C3knAAp7g4Tj3ZVJAUV78INVWN9Y1bwVAB8wU+25wV0TY3z
         g81b0smXyESUKgnLP3dNfHHI1xkKIo0lYI7ffpPqugBKDk/uoEgPT2AwaqJ2RQnHE5Hu
         Ql4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        fh=MyoyPxe4M70k79L86WM0Ogn4NLFgySUd982dXQwdKzA=;
        b=lp8Su4sDpRgP/6VPvURiNh8n1mfjqoMRBpjsc/SyqeRV1tbXPGDbvyDwrRVcsHB7yc
         hHHTf3V7gQbDOHoBeG9d9dMVTajcxqsR3iId97igW/7A71ibObOkVJTbvdcnXKAgUQWE
         GT3HEgQCbQNAztC5Nk5AqJMZhuGtujMuN/Z7SK+46pgHJzlPgPW04x758BcDoLo98H49
         4EwEXFKeWQUbx90wg3MRFka64gzoqSueSdhp9HHFHB8cL5Fwz5Jfm8jM6BxSdJ06z953
         MWiGyXajybfVw+zkFSempm6aWHFxnWIOrEmO5vhQbBJ4BC8KpSGd1S8t29LksEXo6+Vy
         C2JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781096732; x=1781701532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=pbZMc/Xw+cPI5jy3mjU1SS2z8qNoejkT16j3tFJa1c/2w/H79vvfg1xiLjjrsUWccp
         ivurrxwIi0A/sIfXvtKNKXHGiXqO5lBB9sOtdMSfuQ99a9A9WxDgfzC8vX3+OJEDnBhU
         2onfxob1uNwfnPDYaSzG+EVflq4NYkhGtqTMVBfS0Gp1pZftiL/AHqEFahSnBs5RBlyk
         U+YFYD11zHaj3DqbGWL/0pVotQGTgcnJTZ068WANRNl8DFO9K1DAwziGLIU1lH9BpYhp
         TQOWXU+dD/drm/4OR9zjqJkkSBXzehx1OzEcFqMurxWDwRp2OQcAoCG/fYu73sUI0+R2
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096732; x=1781701532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2D3C9qGXxnBkSiArm8IjX1qpS0bzoF+XigWv7ieCiA=;
        b=rAYHIztSguW+IDjrhZpagwpcoK1/fI1hDWjtLwAuVtTnuUJqEAJhF8j6yjsm5gr6sG
         RuCHWq/czESFIiP7oUrHwgzXtb/s7JPKGLU7WZL/JOnN+aTgiGWoB+urCFEtK3hNl5bK
         fmi8w+XqNgCEwLsb26DpvgGYLaEWV6wb/7oFlh01T2hGzcIZxA495aOCQi/X8q5F1YrJ
         CungZEpw6ieqeFntT5VsDOip2h1KpLyq7GMaeWelpA6wCuXsktbvHOCqKkHq91cKHac7
         f7bEkf0dOPuWaNYsQELg8VvTuClrYVJsynetgKxEPCUEuBuH1I9LyGfyvJoA4VyV0gje
         /Aug==
X-Forwarded-Encrypted: i=1; AFNElJ82KR1WtcymswwH3NAXKU7GhsnePWQMFe8V++6igTMO7smLSkHZ0W7DGOEQlAiuOXzhwL1y9Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdhzoc7/t4ixwteuVeVbhpdad3icWNMbUaNHMzB1uRpeZmYR03
	AB7EJiRb3x5LZDuFYuZg5zrlSMbAnlZ5jtJZArXIOcQPzyV9jv1UMvGslANC6fXMrkdB2iDhz6h
	82wPE1XWViDWJybANVoeNN4yGdwH7PfP8PGSDAUKym1CR0GC0W0pYSnZOMzDPBoOZDI/aVYR0eo
	baVao5xww7ICSILOARhQ+5IqimIJ69H/Jr
X-Gm-Gg: Acq92OE0a1pTXJQDBguLwi4gbP+oEXFN9byjKyYlZ53NTA1lvPdYUDOQEZYDwquH5xU
	QKGSvfndyBdUBXz4kugiyyLJtVN4pq5cr36I1MlxV1LD62Yybm8Bx4tY+ND6mhf/4GhOkwoXowv
	mOTzQDSvY+C37pL3+NL2VYGhclcWR6AA0MsA4Zh1Tez0lEgWYczTUFzYyP/e+LTYD9ch8bThWUm
	10f8/V9Wq37EX2vpQr7sGWKdNK/mPN7yCkBWlU02pXmhGTJ
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id 38308e7fff4ca-397f76b9dcamr15845941fa.1.1781096731797;
        Wed, 10 Jun 2026 06:05:31 -0700 (PDT)
X-Received: by 2002:a05:651c:30e2:b0:394:987:945e with SMTP id
 38308e7fff4ca-397f76b9dcamr15845841fa.1.1781096731250; Wed, 10 Jun 2026
 06:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 10 Jun 2026 09:05:20 -0400
X-Gm-Features: AVVi8CdjmsGRE34cD71VHNMaCGfKHZ-mvsXk7Qa_Y4MIS1SxRudAtkLHluKhK4k
Message-ID: <CAK-6q+jL4D6cCwJYr3AMb_h_gVxCamNrG=bRrEczhN8PVRVPOg@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: fix NHC entry use-after-free on error path
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, 
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, 
	Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 9, 2026 at 4:03=E2=80=AFAM Yizhou Zhao
<zhaoyz24@mails.tsinghua.edu.cn> wrote:
>
> lowpan_nhc_do_uncompression() looks up an NHC descriptor while holding
> lowpan_nhc_lock.  If the descriptor has no uncompress callback, the error
> path drops the lock before printing nhc->name.
>
> lowpan_nhc_del() removes descriptors under the same lock and then relies
> on synchronize_net() before the owning module can be unloaded.  That only
> waits for net RX RCU readers.  lowpan_header_decompress() is also exporte=
d
> and can be reached from callers that are not necessarily covered by the n=
et
> core RX critical section, for example the Bluetooth 6LoWPAN L2CAP receive
> path.
>
> This leaves a race where one task drops lowpan_nhc_lock in the error path=
,
> another task unregisters and frees the matching descriptor after
> synchronize_net() returns, and the first task then dereferences nhc->name
> for the warning.
>
> With the post-unlock window widened, KASAN reports:
>
>   BUG: KASAN: slab-use-after-free in lowpan_nhc_do_uncompression+0x1f4/0x=
220
>   Read of size 8
>   lowpan_nhc_do_uncompression
>   lowpan_header_decompress
>
> Fix this by printing the warning before dropping lowpan_nhc_lock, so the
> descriptor name is read while unregister is still excluded.  The malforme=
d
> packet is still rejected with -ENOTSUPP.
>
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

looks good. Thanks.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex

