Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264725F99F
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155739; cv=pass; b=oyI6Hcmy7QEX0ZdHyr8PvrttdCFhdRl2hjLb0XCjOEJ1/iybk+z7QtCHYGCqCnremxr87Wyg3Fpt8dxiWJ4dLnHYr2PQweLUZ4jSxwtoYum7HaJa945YbeBkx3bBwuDvuk37SsHqQuwGSyLFtGJFcu4uStrsIpjxkHJz3eWRxSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155739; c=relaxed/simple;
	bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRD74NlUTNAN+QwX8UVGXnNW7gRd1KEdlf+V2CJ1KtkLaMMsusso9t03HlVQ/3nR8cybI7qopnKJRweRJoz5H9MxV2G6gAe3Po2m96zmDFnAOrblsiaXCaNvM29TW1W0uGjAJ6eyMJGkdQR9Srqf+1BV5ghtRB9T9vvx7qEzCc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fufsntC0; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fufsntC0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84594492c26so14287b3a.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782155737; cv=none;
        d=google.com; s=arc-20240605;
        b=b0pmkCxMUzl8FxvUcges42TyVMbCQVfw0ouyPLYZ8/e9ZvDlDM9GN98+sZ4wMCYWXg
         nf5lu3x+lfvCbW3lHv6BdcMfPCtrykhcHTNc99qmhU3LkYXboBAsgb1H7wWAn96eMmGX
         SuLjgHAJgwoICskLCMWMYbUt/RIPRQkKwQyPqSSLz+fhfHDwwsfaULCRi5HhiGXb5V8Q
         bWtj9yqyZWOgCIEjpotv1NEE7ZoPf1Mod4CyrVYReV0hoHu3/pMb0nG60u+caJaCBntI
         0va/GX9ncKWw95ExZJeGKpZfTnEfyE+vIElxIM7COgcw/NkA0YZPz1oDztoo/2lmvO0a
         XUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
        fh=QJEVFnZHB9kfNp4aBUMmZ066J2fZEib9xTpvF7X874o=;
        b=QD2KsXuWZmhCviB1NnPgzXPbUghy/s03Gr1F5uNSKq6bFIsC89hQmfkjWtHafHCCrf
         FaMhK3Z/6XLg0Dyluf8edlimU9glZa5f07PeH9fUOOF08lvDervpJ8mYKy6aUYCGMDfq
         NACq3PEBqFQDRA6XN0yQFkdBbxHervcdGh96mFtYQEUJIaUO0ZIgcSj1B98/TFOu9Z3d
         RmNrDtHSrZXTG0tM0T7Fw7L1lZ/wv9NQ8RJ90mhu/LYYDXTn27C/FzCn3sfj+4Q48oGw
         moBd8cARQRtk7Z9dWFmhASQn09MHEu7/jrQ+EOfyxQV+cwacESsYa7ZYMFn0uwba7kGf
         KQnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155737; x=1782760537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
        b=fufsntC0X69189W+9/gfHpyISQwaReXqP6/xGtzNRax4vWdhqJ2atx3XrKJpIBbTv0
         ntakxsBGJ/Sb8T4orJQZ5H7HR6Rvt9HRwPxAcSWJXwe1SraQDWw1PW5YScYaE5a1/xfO
         xFUW/uI9s9PlRkRlg+v1GBn6dVcWQls8pdk8i6Cio+RGdB0P8sU5EIQgT7KNULnfBnKq
         HX3n9eA59tJIuoCLbuEtbqGuA6iZXoEK5gGgNQA44jP8BX1hk8UNvtl2/T8IPV/jR9Gj
         kZDKYW9TluHgvQrY46yzFjD2DDG+83sj2GLzg2wC1H2/VF3vsW6RuF3HAu7vuwj4Yef2
         7J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155737; x=1782760537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+aqvG6ZhJ96ALe35bdhzLa1qKmIl6n4Tsr+ZOEf4uo=;
        b=g2QV5kyYwqI2xw9bkFvVIov1dulTylEI5k9KD1HIfjR8DzgPtHXL4U7zxKhBn7Ljfe
         5s6EqOajZLMeTeJVNMaQCnA+6+6D99nTh1cozGot+fU28NXAJ0SNZr3BCL1BxlBl8E1L
         GDMBMRMUs18/utbmJExjXeafQSb/KmI5RNYtJl57Kb2/aUDGW6fLvvqe2Y+lO3ykZary
         +d4nHnrLGvEX6G9XwiG8KiOlRbu0lau4JOTzPrfsaQEmXMQBGv5a0DLo2XeEux8Gbw4a
         Kxec9yB/8AuTWS8Tiotv2QCP/2C2DltQI7Aw1+t7uigJGvlKAVRlNzFdSRFrsL/9xh76
         zOmw==
X-Forwarded-Encrypted: i=1; AHgh+RqrJmTAY0mdFaf7MG3Yui3mM60dTlrfVwItbQLmzDGi/uoCMADFlaP5O6dvXfdUChm1YBYO7QU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvtbfm4mJSp5HhibeQHOkQOl5Kyfh5Kydxs4C+XCQLgUIXpxEr
	rt1Hj/Pq+fhQnorvPa05hX+g1VasRu4JLYjw/xFnB25Hm12MzsFzFlZbMZVI3lAzFQsRtK7ONim
	ObBjiAjKrHj8RbZPjYp3Q8viFeQekxgA=
X-Gm-Gg: AfdE7cm71a0++OTqX1ZEE41vav4i8WXQYdAs43sxuuBXDBfB4qDSeo0M4gtdzJie4PO
	3JE9zBdk6EnH3LlUJCWORbdHEs9cN2ROU6slfAbXEyu7/JYhACsfEvejWEJFMcTIX26DRI/vjmQ
	VKUVpAGncfoiHrd3VNayHbcivupQTK0GPaqhzB/L6+40IcSNHjhL4CiQJtWgCuvc1PZY8PHcn1N
	ZExizXGq4AmGcc5uUyUnoj1Cum7AgMWOTzLb2ybyX2niQJveMyaGEDSF+bS41HG6BaS+yVgaw4x
	neGmArg=
X-Received: by 2002:aa7:9062:0:b0:842:4982:81c with SMTP id
 d2e1a72fcca58-845560b04d0mr17038645b3a.20.1782155737031; Mon, 22 Jun 2026
 12:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618232149.1780219-1-tristmd@gmail.com> <CAEjxPJ40fKJbDFobsxoos0CvWqi0FfL6Sd5xkpRY=g5Ukyfnag@mail.gmail.com>
 <178215477740.1641401.9370300196381074566@gmail.com>
In-Reply-To: <178215477740.1641401.9370300196381074566@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:15:25 -0400
X-Gm-Features: AVVi8Cc-vA_wYwpGNsHgXqsrUabXDiRVPaAt-UWVI9LkOiJj9jyeujf3StAkcW4
Message-ID: <CAEjxPJ6zrqBR1jXWgCJs0e+7qPnonhWHXUMomDT8gbz4Rm8yXg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix NULL pointer dereference in selinux_sctp_bind_connect()
To: Tristan Madani <tristmd@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:59=E2=80=AFPM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> On 2026/06/22 10:12, Stephen Smalley wrote:
> > Is this sufficient, or can the sk_socket be freed under us after the
> > assignment?
>
> The assignment is safe. sock_orphan() only NULLs sk->sk_socket -- the
> struct socket is freed later in __sock_release(), after inet_release()
> returns. That path goes through sctp_close() -> lock_sock(), which
> serializes with the ASCONF softirq path (bh_lock_sock). So once we
> read a non-NULL pointer into the local variable, the socket is
> guaranteed to remain alive for the duration of the function.
>
> > Do different callers of this hook provide different guarantees
> > regarding sk_socket or are they all the same?
>
> They differ. The setsockopt callers (bindx, connectx, set_primary,
> sendmsg connect) run in process context with a file reference, so
> sk_socket is guaranteed non-NULL. The ASCONF softirq path
> (sctp_process_asconf) has no file reference and can race with socket
> close -- that is the only caller that can hit the NULL.

Thank you for clarifying. It might be good to add some or all of the
above to the patch description and/or
a comment in the code to make it clear going forward.
