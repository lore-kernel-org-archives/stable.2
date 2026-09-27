Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57B38737B
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790475816; cv=none; b=fOX7GmlyvZOZVCJ9SN2lWQ8565QV4cescyo1JU4DCpt8kmk9STaFZEpQmrMPOCCY3RGFb2DyQhdaN6bdEkRgZnGYXOvlkEjR+LjakQfBbkvuSZ1gO7pMQXKUWCC+mqaI5LR5OVuhM+6RZyN0T/5r6H7lCAtvMSG5b+CTL5CEuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790475816; c=relaxed/simple;
	bh=reNeOOXVzfXPjpIbTrcp6x8zksBzEAfx0mvL56+4vj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV7UfrT0sj+KO8QOcn3D0nRbKFUPeDp602Yty9ifygv+Lmt3wCcHAY725UiH1v88g/Kq3KZ101nWDZZ6KJyK4UUNGsrOi4rXOdt8cig+QhW6gfs6XyW0/RNBPSpnUU8/cJWTjCvtulsWmEfYu782a2eb42/YnaeUGbHunzUd+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5004F1F0089D
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 02:23:35 +0000 (UTC)
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aaea178c96so2164061a12.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:23:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy5Q6RqhpGk8dsTPpru+4K0ZzFhuczk0AVJ6f6sdYmnNHOiKfHRuRJZidq/5hdBM8YcD8nOzUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkoF/LJOJpPia+begJPIkBcCRLf/LiIm6ZIwiFxjlHF3IWANuw
	yEwH7fYiO+SdRWuLrlk69xfZ24xWzszvtQJeOHppk1UeFcJ5auYjE88Tp5uTsK6kEtiJ1wfut5b
	yoprgUBE0lEeUlgbpT+tAZ4oaBdtytr8=
X-Received: by 2002:a05:6402:378e:b0:6a8:398d:f57d with SMTP id
 4fb4d7f45d1cf-6aacc83e309mr8161360a12.27.1790475813965; Sat, 26 Sep 2026
 19:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926132208.23360-1-zihanx@nebusec.ai>
In-Reply-To: <20260926132208.23360-1-zihanx@nebusec.ai>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 27 Sep 2026 11:23:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_T=r4doyNdeykejj4SsJHiK7Fv8aujt-fXACFybUr9xg@mail.gmail.com>
X-Gm-Features: AclHuK8IqYcRPOmdS5FFOdSF2W2Jugm1H1ys2DHDizlQVeQ0L2lg_0_gcJ6qYgc
Message-ID: <CAKYAXd_T=r4doyNdeykejj4SsJHiK7Fv8aujt-fXACFybUr9xg@mail.gmail.com>
Subject: Re: [PATCH] smb: client: avoid NULL resp_iov dereference
To: Zihan Xi <zihanx@nebusec.ai>
Cc: pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	tom@talpey.com, bharathsm@microsoft.com, dhowells@redhat.com, 
	stfrench@microsoft.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
	Luxing Yin <root@tr0jan.top>
Content-Type: text/plain; charset="UTF-8"

> @@ -1111,7 +1111,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
>         /*
>          * Compounding is never used during session establish.
>          */
> -       if (num_processed == num_rqst) {
> +       if (num_processed == num_rqst && resp_iov) {
Could you please explain how this code path can be reached? Earlier in
the function, if ses->ses_status == SES_NEW or optype contains
CIFS_NEG_OP or CIFS_SESS_OP, the code checks !resp_iov and returns
-EINVAL.
