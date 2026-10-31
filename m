Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793476603;
	b=iqOD9zDOusCvfkxCsSgDh7bVxd9qeAz4a1qKQ0w38tC0ZoF7nl+1k/zKlvzFlkW6eKOL
	 UVBiqhC/SrIi2Qjn7MS+3/CVKQldmm1XgLxX0HnsBgzdJmd4aa2RPV7RDW4l240EXLgNB
	 sI/Jn7IGgwPRJmmpyNiGGiNKWTF++pPTSn+jij7F+y3xOmjCweMzy2Wke0mbWJxoo/Lki
	 6EaG1PD6eeZ1lWe2uFdxwuHm60ivmNKKXQIRjQY1DT+J911axqPHCkxQ+Jjh86R4fyyg5
	 lAiOHAE250fO82R91dS4imcNdT2Vgo0qpgDy7tj/HblYK0dZwYYeEoQ3ApeJX9ajMDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793476603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
	b=hoKTwOI5C6X+PLh++TfzpNuyRJdeNpLlZ5/pFpjdgYmA7kjkOz5kl6/B1OODc1xp4DZ2
	 zNawgrBS7xKe6G+ti6Pw//rlCMxX7fn9tVoQTW5re3Qc4oP7NBOAt0Jwf5imTDPmg0Bp3
	 GBd8PAvwuBA8ijuiTh6aK+Xqn9kVt3Uy9I7V4/G7pjuphCRwfPCkjP3BpkUFS+dOt2Y2D
	 sTwcUe/Y+8wHSF95EKrNmUw15M046Ovbdz0hgcpuq3c5A876Ity8JeTHFCZ9/hKDKskv6
	 LW/vRkRqjniSjjZhjFBWkDnN/BmhZ7JHSZpSTj/QhM0pwAMU2TOhdZCF9LAQCl+Y2jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EQWy5YnJ;
	arc=fail smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F292606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F292606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EQWy5YnJ
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso1232437b3a.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793476603; cv=none;
        d=google.com; s=arc-20260327;
        b=HWS+I0Cm15K+k/3rKSgdPePFMegLx5bgh/RaMgo1ES0fWL78iKuCH2yCZ1sLK6TKcg
         QRnZYEEc3kwhy8xK/P7TgmtlEUGhHH8GThyxALzB0cmVNj8w1ksDosSu660zwmxZ1RUZ
         6Kk4gtVutCFHqHvbp/jyMkd+PcD2GOcYKsPk5tJp/JHobfQKyBkoW139EKkb7EiVkNfP
         jN4UeuuRlUWaW5QcauDKWI8djLXtbrcAwb8C0HPV3dLp9p2ORMLvTRKbYVI2O/VZzM3N
         SrSIRCFpXFKVRmPQGV4QP1QoGj49r08+vybg9rvUYjShM5Rvhl3DB2Ob9lSNK32VYVix
         sTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
        fh=B5iBFtXI11SCovLbAfqDo5uelFKmfXu4lylYV6otXSk=;
        b=VZ+Wn63vZr8cuCwUbqKc0uVvxF/XG1sJk+euCmqetxj0gQkWWJw81wkVqgVL/sMoms
         nUq5iWU+0xJiGB29AWt3rAbtW3CeSI4fa+H2fTAOON0Zu5YlmHiFhBtaNuOk3BSxUSbK
         iRr5xZe538xHOL9vlgLpAu44jfFYkqqDPnDzSyU+WoHD8Kbpt7TgzSjR3gAloPLW2xUG
         zpT+3PJ/IVnV6s9J3aj1lSScllh/Uy9HYvNZmGwfeN8r+JpHbMuI0HDpkWDzpGxqANLn
         jWt1UNAx+c2A6NaanH1BokLT/OJhHp7kS7s8ij3yW7pFpHs72ESeF0/2hBOThNkWa6Qd
         HOww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793476603; x=1794081403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
        b=EQWy5YnJ+StRsCRsI3UjqxM6NhG3RkxbsEiIF6b8lmVFWqJXaFe6EEgM1DxxMYqrhY
         meISUh1+N863oX0Wmij8QpfEC/9bR3Nkxdso0Ckso2XgF24pONCldB3yk4PH9i45tBe9
         lvUPBLjXhNSX2MP+GH8ZuCTIxCkhPe8vYbgDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793476603; x=1794081403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
        b=dUQ//pfW9pRQFj6VmkgRurvK0CiKkzv5srW3FqYS2q9ChPh4RnkNu7yeDebMMK6bY0
         MoHKLdoK91ntZu3L2kIrkCgTzYbUpf1aHWWODwRGzZdqXpO34hkHqv/gJO5F0n1suhUu
         WoyAcUF5TRL+IV51na9hruik3xH7/m2QJa3eeMZAiLpRuAkoqRqISNmQXB/oHs+YgOCj
         18kIVB7p+wYOxSPlsGnFNFpUEcj1dWVV39F1TQcYdT/8lDmRLgoohkVOphQli5psqTde
         H1iFsjDl2UcLPaOYsyx5pYzcxk9va93vbNDiuhfkXj8fKKM1P2BUdJo4Lnz39SxCE7r6
         BHTA==
X-Gm-Message-State: AFq9FYL+XqTDbxytpfIJC+McbC49BjAwQMQ9dj5MYluJBCt6mKbUVP+C
	QdOkkXo6q9UHEN7eDU1DawU1+G1kNDDD2GP2eW6YPLCbu9OQloCsVC+mh9Og2hYCFayNYXcSJXD
	vJPw6HmLhf+oHOB/aoENKhj25W0PjVOxEduYGU1JS
X-Gm-Gg: AYBFou1FyIrfbaqruEM0HYYDfj+6QlVmM6xB43987yKG9HZIgT0zQhV6SedDs3h1ywn
	TAe9cydTRVKeW1J5h4YTtgarLSaAXiPwOmy5rGrv2DJNSDXu5BMrJBEOsDeqxC5/VnBFRQbp38R
	eP4Aaxr2VJxfXa9cgnyvbced2ZLtwdVoz1ytxy4DVDXb2RxyL8xq3Em02vhAR0nZTOilMLLttRV
	2iVGsS+NXp8GKpAx5/gf+DA7EOWrxVToIOpR8l3yATdkgpkFPxl3/GAEmQVLO3Rx/7qZzmf+uPO
	3mUex1mt7unXRCQ8Ol0wm1e7eyZ9ZNB11HC54T8blWoHcYrRVZg+opMl5NCW/S9TEEf1R05AjfO
	NSO0311DwokRBt3/kZabohuxzrfmtfDgeFqAY2usB2Ea1y3V8bHPzo2BDHDwnWeX/FOqqqnJVZD
	+9Pofabs3hZTFea9U=
X-Received: by 2002:a05:6a00:181b:b0:89d:eb23:4e83 with SMTP id
 d2e1a72fcca58-8a9beb67de4mr4983680b3a.30.1793476602669; Sat, 31 Oct 2026
 12:56:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com> <SER-NSBD.v1.r1.20261030042947-3@mojatatu.com>
In-Reply-To: <SER-NSBD.v1.r1.20261030042947-3@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 15:56:31 -0400
X-Gm-Features: AclHuK_5FcR14Te-KF0vKW6H2qH3L3t-X26CkMjnn0VEbpmmZR6cMUtExiAwJbk
Message-ID: <CAM0EoMnHR61Z2cW2+x-4Jeaz_mjdCfh8ieYJVZJu3ak5YDkRjQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3 repost1] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, shaos <shawnq1@163.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Tom Goff <thomas.goff@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 3:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Reported by shaos <shawnq1@163.com> with a reproducer, which was
> reproduced and verified in our test environment.
>
> The issue:
> The teql master devices are created once in the initial network
> namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
> teql_master embedded in the registered sch->ops and uses it without
> checking whether the new qdisc's device lives in the same network
> namespace as the master. A qdisc created in another netns can therefore
> attach to the init-net master and change its MTU and flags.
>
> The Fix:
> Reject a teql qdisc whose device is not in the master's network
> namespace with -EOPNOTSUPP and an extack message; same-netns teql still
> works.
>
> Initialize the private skb queue before any validation so every
> constructor failure path, including qdisc_create_dflt(), which resets the
> qdisc before destroying it, sees an initialized empty queue.
>
> Conditions to recreate the bug:
> CONFIG_NET_SCH_TEQL=3Dy, CONFIG_DUMMY=3Dy, CONFIG_USER_NS=3Dy, CONFIG_NET=
_NS=3Dy.
> As an unprivileged UID, unshare a user and network namespace, create a
> dummy device, set its MTU to 60000, and add a root teql0 qdisc:
>
>   unshare -Urn
>   ip link add dummy0 type dummy
>   ip link set dummy0 mtu 60000
>   tc qdisc add dev dummy0 root teql0
>
> The init-net teql0 device changes from MTU 1500 to 60000. A pfifo control
> on the same device leaves the MTU unchanged, and a direct MTU change on
> init-net teql0 is denied. The namespace needs CAP_NET_ADMIN; no init-net
> privilege is required. With the fix the attach fails with
> "Operation not supported" and the init-net MTU stays 1500.
>
> Fixes: 7316ae88c43d ("net_sched: make traffic control network namespace a=
ware")
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.c=
om/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Argh, sorry - this patch 3 is not properly rebased. I will send a
repost 2. Ive fixed it so it doesnt happen again.

pw-bot:cr

cheers,
jamal

> ---
>  net/sched/sch_teql.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 409ce50cc0db..55f9944ca47d 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -188,12 +188,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struc=
t nlattr *opt,
>         struct teql_sched_data *q =3D qdisc_priv(sch);
>         struct Qdisc *first;
>
> +       skb_queue_head_init(&q->q);
> +
>         if (dev->hard_header_len > m->dev->hard_header_len)
>                 return -EINVAL;
>
>         if (m->dev =3D=3D dev)
>                 return -ELOOP;
>
> +       if (dev_net(dev) !=3D dev_net(m->dev)) {
> +               NL_SET_ERR_MSG_MOD(extack, "teql master is in a different=
 network namespace");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (sch->parent !=3D TC_H_ROOT) {
>                 NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root=
");
>                 return -EOPNOTSUPP;
> @@ -201,8 +208,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct =
nlattr *opt,
>
>         q->m =3D m;
>
> -       skb_queue_head_init(&q->q);
> -
>         spin_lock_bh(&m->slaves_lock);
>         first =3D rcu_dereference_protected(m->slaves, lockdep_is_held(&m=
->slaves_lock));
>         if (first) {
> --
> 2.34.1
>
