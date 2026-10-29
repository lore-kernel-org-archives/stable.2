Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793309465;
	b=hHNvYkASfgNM6HMynozWeWIjuoxux20dRZvH+06qMI7qioNa/ymqGUa+63UkV2Gb8JVt
	 yh/z5lqYE5qtQprxX61BQX2jsHzmEl6i81H0ysUgZHdb7hpvEjOGEWZtKGQbnxyE3pn9N
	 ehPYWGO6d6zsr0Om+mu5fNFVRo1EXyKgc2HLphGzHWxlckTyQaV/UqTmD1LTbBglbDziJ
	 c3gpWryGBMV2RpI+GldIRFNylQrmKx0RNsz6w5MXMsKYpaqqFuA8qNRBP92BCZR77rjvR
	 G/SAIE1aX3iO2KLZtLnvrZ+pg4N4pJ70ZMHCEkthzR+6ZZ0C59GNeGVsz88KSF231ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
	b=jiqtvgPpFi8s7KUSan/Ym6CnHs2nr+6SweZY5DNI4tXZM5IlQtihdQofCzIg7Z8/MnVO
	 jpxHW6MjC5CxvwDMLou/0yqk7czeGI390QbgC7hU9bssyoInIx07yQpqFWWyN0tu0RZF0
	 T9itXezsbpUdMLKl4QOlimwSHqevy/9AqfI5p/rGvnbrSfLb6DWkQawXnHMfJ3B09ZGgf
	 DpKRBsFaT4hLqLPpTF7k4QllfIbfuGm6bYiBEGhxT+Tyfj61AKwLGPcbX6RdMLvSdYFNY
	 zvGzppyIKJbrdwrVA/9guXsbdSJoi67EcAKJG0erBpTHwJ/fB2FrDYHz9tKMyVClAfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d0IwzWfv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B666606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B666606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d0IwzWfv
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1492a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309464; cv=none;
        d=google.com; s=arc-20260327;
        b=Nbd9ggvxpB9fMYCbVMzcJU5+XU3XONzbqtYUJWDjMiQae/fFQgebhdCPGPP++YbIF7
         eRbVWcj9So2dtyGVxbNP/t5FPxtAgpaIhUIcNHzDLRWP5meMzZVymTkAop7Sm7JMCMlS
         C6CFUZURRJz1+lC2Lip2JAUjg5NYVjMeT2J9x2EE6hl/3gk0OshV85XjJnIy5QM8Y9QU
         Ad+L6UfzrSNbXIg7Iro1u/FhHcG17T1G4SSviovowb6OxLq8AVL6D3h9KjfwrtwtPPx6
         MQcbYKEXwPhZ4YbiY9VPRjxCKB9najR2mEJlVAmUX9CjE98N4wOJ5tWmfuXmG26QWZZt
         fNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
        fh=z8C0bJPXptTQFZ5b7u9oTozbBmp9VE01l+vGyWcmexM=;
        b=UtK75Wj5g8oUhzxyY94PTUtZuFVwbtzK+VpmW3AaGrotBSJ2ACwLH3PvXz2uVsXXvV
         cgiE0NyYSq0MS8FIb1DZ/EENSo5XyCdGycz0Y4djWVSeLWSQL98hKeSQTzHChJGD4yWN
         lRvYOzYeSdtyt4jcdqq6b2uiWB54h1Pjz8S5TaY2xjxUXoQwtHAYx+IvlBxZQ3v2mY/x
         oL5j5+YXge9Jz3L+04pIAsdOm62Ir3juBW6P/WV58bES1rixljUpsEhNB5mgVyXJcurj
         i2EmNf+qn74EL7mFjJ8oKxrh4G5I30zyA9M0uzK8IVw0UBTTPv8GvcOH2Jxbjuq5StVT
         Nrcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793309464; x=1793914264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
        b=d0IwzWfvXP4d3zE2Zq+7oXnlNdI8Mv0zAp505O9nyaJgZXdanqRMuWEgS+guwgbMcK
         qjGNhXfRKgan5hb7y4zOFTHMbH6Tcw3jeHDOG18EY4UXb7VtigK19BYMH97KsqxkYmDL
         l+GLMbO2+BxjqzfRAywwHjEruqTIDPw7dgM4MUwiBjoIheOs8REvzs0/Y6Q6PrAFlEql
         mPWcnZ3c/XUAO1dBalQNFecjxiVLLF20SFKMC5/zsiqUBSZ/MpfhfGS8dyRM7P6QeqVU
         3ZwGSnmVJC4rb6zK5WQwPFg9MDKOMBjjRYWiRwylNoW9y9e2g6YpPOTipBjLSvUVdMlF
         6WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309464; x=1793914264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kreUdF0uNoXIPwkvrEWSR7P/OzeK9mmS/iNz6Eo8YyY=;
        b=EYmb68g9wizzNcDqSIgOuvESHPdj06XtwU3dSgOBDmtqHsMQZlJsU4j/xBzicRxF2R
         2CnaQRUk4dr3X8r1n/8ijseKocbF/RoeZJl1nBiupYcKBYHzSeP2vU4gm/Bwm1rc5vG3
         cQahxav5GMuZY1axoN0uIAWP8EwpJlRKq3tKE1neHQ++sc19aLDRQestPRiO65h92ptq
         9KA8YQg3suzCY0Y1abOTfgl4JkZBGCybdjQUrWMYLG6JI33aMsr9rygMmkL0DCOBz5fW
         aLW0knoleCsFBDZ8LaNhodgX62XWBJ9DFniT5CDbUAMP5HH/M31L1gcsYj6U4DnL5bED
         deug==
X-Forwarded-Encrypted: i=1; AKwUvBxUOr7KPwSkvVI8nt7qa67Xo569jCfbpgb7xjkcKnireAH/TLImQ3pXFWH8RnI+uzN16MeSKT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+dqx6fI9opURh4rT1XpLHOjSKEmw0OvkRtST1O+btOMpRCcXq
	vsve5kA4jW4jTWcULQl/jtQ14lWmbS7ywgdl7IiWY32yGdPJiLj5iH9mA02CO3CmPs3p8lYZpTs
	9nUOR1Md723/wb5QSZIWMWnnh1u+BtLUIvjo6Qf1y
X-Gm-Gg: AYBFou23ofJC9nFjFihgNaaMxyiFMAhvFS3MecxxOlopz9YyFlNcBbXNmdVivsVDzZz
	wS+4LxkSL0ZzWZmw3DWETsGN+BlsK6jmJxOKZxd4PjRHI2mGY2Q3zlk4OOV+yU9z1gI5ub807c+
	coePj2ti+1Thw2zFnW4nclR2rS3yKiMAazjhj/2aYpafFRU0NWod2Lz5RyJNwOPMN7q1w0ChVbm
	JTecGuq+gqlY2vZyS7NpIxW5Q045wXihPmW5qDq+HIUfBUd0UWsXyUW4ZG2KZ28TnNnKqO1mnf9
	xXCZoFlPhD4ZSFKktOaw2fHzkqz3bLPA1Mi6C6c+4qnGlCeBjwnjLnfHZO7Kd5biqXhuBLNEPxv
	5gBomWrU8Ec1XP4jBkYVs8FwMxLdNlhO0NoL6l7JxVAMx6X+hdK7/eFH69jym5cKaEOs=
X-Received: by 2002:aa7:dd17:0:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b4b40b8186mr104372a12.14.1793309463143; Thu, 29 Oct 2026
 14:31:03 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029145844.231018-1-omermetekaya0@gmail.com>
In-Reply-To: <20261029145844.231018-1-omermetekaya0@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 29 Oct 2026 14:30:51 -0700
X-Gm-Features: AclHuK9vwMToW08OTMztQpW3bR5sve3bLoPc_H7WIharriRZuH5COTSWDbQX4kE
Message-ID: <CAHS8izORg8OR8TyWBHmZsgFBtM3+qh7gXCJxifk1QGs13Q=ygw@mail.gmail.com>
Subject: Re: [PATCH net] netdevsim: reject port addition and clean up ports
 after a failed reload
To: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abini <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	syzbot+88435e204734072bf39a@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 8:02=E2=80=AFAM =C3=96mer Mete Kaya <omermetekaya0@=
gmail.com> wrote:
>
> nsim_drv_port_add() does not check devlink_is_reload_failed(), so ports
> can be added via new_port after a failed reload.  nsim_dev_reload_destroy=
()
> returns early in that state, leaving them behind.  nsim_drv_remove() then
> hits WARN_ON in bpf_offload_dev_destroy() and a subsequent use-after-free=
.
>
> Block port creation with -EIO when reload has failed, and delete any
> leftover ports on the early-return path as a safety net.
>
> Fixes: 75ba029f3c07 ("netdevsim: implement proper devlink reload")
> Reported-by: syzbot+88435e204734072bf39a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D88435e204734072bf39a
> Cc: stable@vger.kernel.org
> Signed-off-by: =C3=96mer Mete Kaya <omermetekaya0@gmail.com>
> ---
> Tested with syzbot C reproducer.
>  drivers/net/netdevsim/dev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index feb88ccbbced..61f0824ce4d3 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -1697,8 +1697,10 @@ static void nsim_dev_reload_destroy(struct nsim_de=
v *nsim_dev)
>  {
>         struct devlink *devlink =3D priv_to_devlink(nsim_dev);
>
> -       if (devlink_is_reload_failed(devlink))
> +       if (devlink_is_reload_failed(devlink)) {
> +               nsim_dev_port_del_all(nsim_dev);
>                 return;
> +       }
>         debugfs_remove(nsim_dev->take_snapshot);
>
>         if (nsim_dev_get_vfs(nsim_dev)) {
> @@ -1758,7 +1760,9 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus=
_dev, enum nsim_dev_port_type
>         int err;
>
>         devl_lock(priv_to_devlink(nsim_dev));
> -       if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
> +       if (devlink_is_reload_failed(priv_to_devlink(nsim_dev)))
> +               err =3D -EIO;
> +       else if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
>                 err =3D -EEXIST;
>         else
>                 err =3D __nsim_dev_port_add(nsim_dev, type, port_index, p=
erm_addr);
> --
> 2.56.0
>
>

net and CC stable for a netdev sim bug is extremely overkill. move to
net-next with the AI-review comments fixed, if any. Thanks!

--=20
Thanks,
Mina
