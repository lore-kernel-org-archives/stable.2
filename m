Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255303;
	b=S5SBE2huJDZj8YN6B7sc+Bqr63Lp9ZxTzabDdNSCJsqj26vm56lBQaRqaDIZsflQ+6MB
	 DWazd955+nfdUpd6CLTGSv98QTNFbkrv9YTX/Q35cMA33raLQhfsblv5FFK03HgFwp81S
	 695YiMuYHz0xLwN6HM8AGGapiGCl6qdg4q58FrhMK8fL3MKqADfL7ScD0ghQZdwUE/KNM
	 8mumiImZufJvPv/5AV2mRFHL03kzFCVwAth6MZ8cZBWV8Z1UGCMM1cNvigDv+In18nk3m
	 xyOqbdm3qhztAMrn9dWhKB89RsEtRtpFBC/Vj5Kv0M2CNt/DBTWWq5LJCq/dogZkJjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
	b=sq80FLek21dyxV9MFTv2oLjqV0lUCzPgAzRGhH6NDOaJi40fQpho/uAxN0XX2ivqFgSu
	 xRONs3nKu6aYgezMQgF4L/NkqHlCU9rBGkQ78qG+Clj7Ufff5lZRpSGhHAfTFAhruJhtD
	 mv3j85qOWDgnHGaxgqDcx2+v2buHWPAQqGHoGcXGpQeJIt0DPoP7a7JEd1lOvRDg7N8KJ
	 z1EkdR14DcT9zRgaGIguJR8n2rQHgOLxN/Q/dVrJ92opbz/lod0KwmXKIe6X/IHv540RH
	 zL1T3s/TJrYkI5oDHqpYt1fwq3l353dbkS89uhRkc2PZtEokCnCJVWpL/G259V8krmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033A606A336
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 20:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4033A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b5efadd183so591423b3a.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 12:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255303; cv=none;
        d=google.com; s=arc-20260327;
        b=gq6C4/D67h/knly0Sn80/U5fRlKUxqx4QJPyR0casC43nng9moDfnkNcrPSphyH2H2
         nPkNxMRZ6JYxvVOvKKiAKArEUAeZ4luwn3lUt51ytfwDalV6xPaAROFejEhTlQMSk7XR
         GHaj86CgxJ/m7GH3AfgcvnOi3fTXMpC/DBavWv2OT/9dR2TLXitP1ibO/DY5g9wZ7Yuw
         RI4e6CNjZVmPowUQ9O3HMc8QANGXNZtIH14myyWDw1CqiMdAgsJUiO8Dhj4ls1v3fWzV
         Wq3539oDB+uwmnIX0XYPabunAsT0ZVazudtUtWlQS25cxXfRnLsXdojf/BoMAXLhetM/
         lctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        fh=W04C360h3eHF1+36RN4t6j6EHAccy7qopFnlCAniobQ=;
        b=pjFqnGYW0QNlNKCe2wDgsbfVfXobTw4kaQ8S7IzKv+1bWjIGqeQoK1YxsB4YUP8fh/
         HXO3IO3HMTU8SpCm45WpdXvt7T4WWEA8Rc+/LFY+fInBP9qQ63bSH6vHOWFupJ6ynxm1
         5ruGY9OiwvNlIkO+yT9gwEAYQXsB3+LS6lWq4EOu8WCZNtKsu7ICrS0zvKdf90prrSRG
         ReXXlxnOp7b1ECQws8GAsyuV/msVH8H7zyYJ/AqyHdWMx3U265Qo/F/VnFu8mRAQdkc0
         nSPVTKm2w+testueziiIcUbqhQ7pqOiTMDaSV95eHRtjI/KTafco50cX+xDLxiDH+5ep
         MToQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255303; x=1794860103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=JM3aG7UDhE3ppbxcli+QQzARg2Kk347vy5ytnvpfinkJQjCez8mFUwcYs8+/PrAO8z
         qQXYwQgzy8NbHr19R7sZA4uRrRbYDLtCZTFfnP5xl9j5o2XEJs++ZuMTq6tvsc8/HEJn
         psFEtb6JYK9B1K2UCYWdaKijgaM/Sq6WoMXKjc08cwsZyhvosTpftZa2yma2RSbfY9xo
         Q3vHnPYquzJjxSmB1OqnqGohXqzBVuNzvCn+GTJhiNm7oW7SLON4wQa1VbC7cxzBbOjC
         DAXh9HTRv9+dK3JjCLtk1lYJ3Sq5ALw0klGRsuHQqUUOUkAIo4X4iR8NKPL5u45oL4wJ
         ht3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255303; x=1794860103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=f35/h37ftPz60rFsG2z5l6nO9teKFOkOTsbrnXZ81y/GuAjUoGWjCoort5IuLNtO7j
         ty6WHcrUCP30d7tBkOx5wuy0oGtggi2CtM1h/tYMONGd2PL57BwUTNDok9/e7v9L0mOz
         H4QaG1LKYa3sgfzOLkqVKtIYRuyNWIvzzXLtU2aP8SL4s7XnlGFivvyrmA79DNw6ydpt
         kPLYMys76EmM+dMJ+lClz5o0SmVYIi4zpg4mRC9/WyxReyfPYMWvuFKLwlBP86f6vEqc
         OeUlCyY7ibVFjn0HVIRwhOcSZizgKV7HsY1ev2yHJrAXWAf0rmAfAJGGXILJDUkOXMX+
         cskw==
X-Forwarded-Encrypted: i=1; AL+hErHcPsh1dntmiLk++4PXPqmHZl1g9eJKCHSEpZWIrQX2Sc4S5M1HWjG0+G883onViiywFwmFe9Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TH3kwAVBRkrmQLIWq4AcTOGtIRBQobQBznahlTNn0cIhow24v
	BtIwRgj9LK7F0DlWyzVjgTN5F+NGlBy4Ps0DFfA4AxHv+oMWelNMnYw1tQxj9ufIqVJcn4vY3+E
	hkaZut/rxkzfOFUv4JVQzRbge1bLVmMYt+XgUX6zg
X-Gm-Gg: AYBFou0XgFe8rltIz48j+lXusLz/Nj26McEib7/e3rhcirbEHYI4hiH6BMhNAo7REj2
	EixVQNdBXAcmO9Dz0QlsV3Tu+fWylz0HQdj2wkA7JUYWk9372H1FjEQ7xbcJYaPNmSGhlSjPJWW
	0qSmtew9xb7Zughe5XIyWXNHOCpRtVJf5mljaWyby/5KMz+PlsXh0WAsR+AD2e34/8gxabLoMDz
	SkrDizDYtwrjEpXV8Xyf29/sfAHbgWEs7IlQsGWwGXfXirYjgCgoC1XVGa2d4IeFdai8pJ3G/8s
	ytlQQ8j4d98ZyMu41MZEpmUjbx+Idx0vaUtf8NezkHoYqrKWxeUhYi3RXYCR90zaLFpeXpZwqgi
	XlVJd2AH5ged5mPJCFGC7n3e2GRrO6/jToQoDm7lzmeaOR5BqhPePRbmzxrbkXe74C+e/
X-Received: by 2002:a05:6a21:62c4:b0:3e1:4e53:4e7f with SMTP id
 adf61e73a8af0-3f18f4ac9aamr162563637.27.1794255302075; Mon, 09 Nov 2026
 12:15:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
In-Reply-To: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:14:48 -0500
X-Gm-Features: AclHuK-R76EHDsnszW-O6Vgi4DzxwqLyNag33759siqThBnXu2JAqQRN94reBA4
Message-ID: <CAHC9VhQGms7L3EL19tB+TRKvNP3ttSumHOdWcNM2377-fQiEOA@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Jann Horn <jannh@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:06=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
> Le ven. 6 nov. 2026 =C3=A0 22:40, Jann Horn <jannh@google.com> a =C3=A9cr=
it :
> >
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I've sent a separate mail with a reproducer to Paul Moore.
>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> Side note, not for this patch: Smack calls netlbl_sock_delattr()
> and netlbl_sock_setattr() under bh_lock_sock_nested() only, which does
> not exclude a concurrent lock_sock() owner such as
> setsockopt(IP_OPTIONS). Both sides can then kfree_rcu() the same
> old inet_opt. This already exists in the "cipso only" branch of
> cipso_v4_delopt() and in cipso_v4_sock_setattr(), and with this patch
> the copy branch has the same issue.
>
> The rcu_dereference_protected(*opt_ptr, 1) in cipso_v4_delopt() hides
> this from lockdep. Smack should probably use lock_sock() like
> SELinux does in selinux_netlbl_socket_connect().

Casey?

--=20
paul-moore.com
