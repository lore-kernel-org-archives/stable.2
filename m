Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173C47DD43
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395226; cv=pass; b=VSM7iDFTiDdJ0WzA/c8e+9rCM32FwfrPIeuFPuSuB+JSNzZ1QRmmRLzG08GxkFb/WscRD+oDrXW1EFij1rQcWRlT+KK9jfLK8K9Cd5ezJXgvSSLoUifKtXspJ9kKG0TfMfoinj5teBiR2YXZoA25AG2CuwUCjpaSAqYaaJkqysw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395226; c=relaxed/simple;
	bh=MC56LfzMCt6fRP9BGhVtIAMB79iWC8di+yYNzRqau0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyHb9bsNpRxFRCk9fDoFzbAEKFhwrtHHndnmuN/XAO0r1gzOurTCIjRVrx0VtXw9J4e6i+x1Sup5gOnJ64HupMxZuF/VEuhcQSOVBxWEKlMn/NYwkhW08MVFutV3SAjukg+wWOHSh04UTKcY2GAU1iRpNGACMABOqbMA/kS+TxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXte80Yd; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXte80Yd"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e2254dso254677b3a.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395222; cv=none;
        d=google.com; s=arc-20260327;
        b=Bkbe8TZoDwCY5hBSN2EbYonn0EMZcTosHcSpMJPmIwnvDO+QsUJ/kfCGzS+3NhaUcL
         NGITPA8nFic//Mt1b5/nAtNb03zTAr6GrHtXyCXLWIGNtpwFST3FC5jctl1LnlVSonau
         IcSDds6XposQNxRXGKXhzb6R4ZW1Ex2vFPEK/3i1CoNL9n0SeKVRAA/n8yl1pefy0+0Q
         +lWBJZKqQL+EnQANWze40iHmLZijF2Q7BKb+frkHejvs0+svdZv21iRc2wijqSsge7Q3
         7nCE9meRikQwov/X6Ecdt9qwyFpU0+z4btmtUaNsgoj8dewZrVeQMeem3pVypXA/BFnL
         yUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiYN36uVRN3S+33iMVULloRHEVKnum5eOFw9VkWTBRk=;
        fh=nS7n1x1ZsiLoV4WXCSDz9p2Kl3UKlU9ILbaIPeQo7H8=;
        b=Nk3RUuBowfuYJIuZuxiY1Od/3H945ydfo7LEO40XiuKCsTxunv3Qly8vrXTR2O/ZSe
         YTYSk2xPK9SxpqyHsNK87X3kkIJfu5/9CiSzx4pRzrqMBZpXpgGJqtjqHKSzDPOuxxXd
         eDO7tWwKJXKq2NG+U8Pgd2W80chTaCxaJl2wdErygsb+NoONG1iBsyJo4/i1WD+ipkdI
         a/zqkIgmPsV3WynYeMMtus05F/9l7h/8LtnRLXDetzGH313/dvPwMFQ2oAobCmMUla5Q
         aNeVQAkgt9MOqBPNtJ2aRdwTUNlrHWV9AiA6k1O61cHZECXteNu5D6aO+6i2pzeEOsT6
         x7KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395222; x=1790000022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiYN36uVRN3S+33iMVULloRHEVKnum5eOFw9VkWTBRk=;
        b=SXte80YdEHZ3OPCjGDoakf31K+yp+wdg+qCiVQ7q90Mm+AtReQYjnYrlHgrI9tN/QZ
         FRkAU0om1GMBDJAbnIyqHZl+UU5vnWPvTBxIQRDg4FukHTw5mDhsalRkMoUsl06kLQ2p
         a6PpAGaID7QBtNJa+3cJ2Snj0Fxa0h4NsX5rWHORNN32u0bx9OcYfQkC6z54XQz3q640
         v1mgXr/7NJv2aPH9uP87sXOhkG9LrCzOcxQiBsJ1AsZMfPmdiyWOKDBFgEjlBmvz+8b6
         DbDh4labc9HBfqG3/baHbBInsZNFFTDkPV8xXSYowhaG4NL7eWIxZ3NiKqpLbttToUD9
         z3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395222; x=1790000022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiYN36uVRN3S+33iMVULloRHEVKnum5eOFw9VkWTBRk=;
        b=Gj6MrgQ6n3fjTvwYZ0lO9n/h2xwtjnbXtVbgE7VE0RXE9Gr6J9BzplVLj5gQwEARWh
         BeYyA4RHGRx8xjlLtYPCsBzPCW9hGF2p5h8+mcdbM8fszDVpaVLbeKOSiFvk82fvPIQd
         Bb2AgY2tzSWIc6LPhJQb+DFiaeZDJu6QN14KjcGNr9WtcxocOa9YxuUGlH5DQmVBOc+X
         UnhJzeJIHnpwjD4+iIXZQ4W0Ti+Rn6XeOZwgPuP8DdG0/lAMiYWqF2jUA8rd92hOm55P
         yJdmf9cE6l6fT5iZpZj7XM+F0pAnKytNqmfzaUmWY44lqW1JG8flpDOpISJc8t0eHCbM
         sAkQ==
X-Forwarded-Encrypted: i=1; AKwUvByGJD5+d5q9jProMg0ES6RK/tS94dnUfbZXe4k9gZQbCE6DirehG9t9OP8dZy4pVCJz+udJV8o=@vger.kernel.org
X-Gm-Message-State: AFuF++nlDGy7a910EHbkQG9nNh/enGipKY71v/Ou8INKF0odpDOWuVVd
	rUs5D7+TDiuJDUqf3q9HfhI+nDX0PaRABLo7YdqTyqRFUFVG7r78lAlmeYye3zkGnHAFBg6Wsbt
	tmyRJuCoA/Ubq6nVeKrd8znLv0S0tFWs=
X-Gm-Gg: AYBFou0cYXElAcHDLA42x0uJPxOcOJPMZDps8UCGG6l1NBdiMbh6O8oFtySFc78ZBdu
	qYd0D5rTvy5wdWfkJEMunReDIQmlQccJKbPnOfDTUHNYHZDNoyM/6P7DPSQfH3L3Mfc7p9DfBLY
	+RKMBURxM6HCdvCi0BRpEEnn/IS0ryoa6D8WqdYG5ddm7y9BUWCWrNIt/H2ryzjcz1eyMQ1BRoW
	BeAFb4S7vhQ9oEMGyoBrcY4JFkgZxG6/d/wGO8eUBweDjIjsCc/JSw3BrO2OqAjrzHyHeYdF1Gk
	Bkm7XU6v/SQiailtAtXcJniBRriBCn5Uwa6UvTNx7Ia3II/pZOotsfAJ6+9lEi6lzOzepesP+Nm
	z5d7S7E9t4NZgg4KPJjv0aV2f1xkW1pmruZSMWSzQajN3nsdZoTuyyQ==
X-Received: by 2002:a05:6a00:98e:b0:869:4ab2:8e with SMTP id
 d2e1a72fcca58-86f93cc125emr3520459b3a.7.1789395222076; Mon, 14 Sep 2026
 07:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911090039.75646-1-juny24602@gmail.com>
In-Reply-To: <20260911090039.75646-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 14 Sep 2026 10:13:30 -0400
X-Gm-Features: AcwNN1Vj8GzyWsGKCy4gSL-vBNjPpWPKXvnEtKLMrlOakSBuY2Unq606Yu3xBrE
Message-ID: <CADvbK_f=S-2waid_92PbOCh-LWjU5oiZT+__xWfttVeTHEPQTg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: keep the association alive across the
 sendmsg connect wait
To: Jun Yang <juny24602@gmail.com>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Jun Yang <junvyyang@tencent.com>, stable@vger.kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:00=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_wait_for_connect() drops the socket lock while it sleeps.  An
> out-of-the-blue ABORT can then be processed from the socket backlog and
> unlink the association.  If a concurrent shutdown(fd, SHUT_RD)
> sets RCV_SHUTDOWN, the waiter breaks with err =3D=3D 0.  Its final put ca=
n
> then free the association.  sctp_sendmsg_to_asoc() consequently continues
> with a dangling pointer.
>
> An earlier version moved the asoc->base.dead check ahead of the
> RCV_SHUTDOWN break in sctp_wait_for_connect().  That changes behavior for
> the connect() caller of the shared wait helper and reportedly breaks SCTP
> selftests.
>
> Keep the change local to the vulnerable sendmsg caller instead.  Hold an
> extra association reference across sctp_wait_for_connect(), sample
> base.dead while the socket lock is still held, and only then drop the ext=
ra
> reference.  Reject either a wait error or a dead association with the
> existing -ESRCH result.  The extra reference prevents the waiter's
> final put from freeing the object before the check, while the socket lock
> prevents a new teardown between the check and the following send path.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
> v2:
> - Leave sctp_wait_for_connect() unchanged to preserve connect() semantics=
.
> - Hold and validate the association in the sendmsg-only caller.
> - Run the in-tree SCTP VRF selftest and the original reproducer.
>
>  net/sctp/socket.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index c7b9e325e..09fd6b951 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -1842,9 +1842,14 @@ static int sctp_sendmsg_to_asoc(struct sctp_associ=
ation *asoc,
>                         goto err;
>
>                 if (asoc->ep->intl_enable) {
> +                       bool dead;
> +
>                         timeo =3D sock_sndtimeo(sk, 0);
> +                       sctp_association_hold(asoc);
>                         err =3D sctp_wait_for_connect(asoc, &timeo);
> -                       if (err) {
> +                       dead =3D asoc->base.dead;
> +                       sctp_association_put(asoc);
> +                       if (err || dead) {
>                                 err =3D -ESRCH;
>                                 goto err;
>                         }
Adding another asoc hold doesn't look nice. Could you try fixing it by
adding sk->sk_shutdown & RCV_SHUTDOWN to this error check, like:

                        err =3D sctp_wait_for_connect(asoc, &timeo);
                        if (err || sk->sk_shutdown & RCV_SHUTDOWN) {
                                err =3D -ESRCH;
                                goto err;
                        }

Thanks.
