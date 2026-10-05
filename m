Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AD2E173D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178586; cv=pass; b=ivLgpSkibLoXhJ9I82tBf5XIBtCO5+n9AWatc/LY4XsYn98J+xsSTMkyZFztEO2vu2A+9fcnn8JdNi8MlXxcvzOQ/EB1xHoXvJRow4jm0x3B7jgSb6+oIwbwwdJRMHgO5CrO5rLFoXufou6BJ1yfg4jC7vQ9YqV9upHP8rD9v0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178586; c=relaxed/simple;
	bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbCouNyYiGu79326zF8ksIcCMrR6tmN8v1JnbVtd6h8bsjndrMX+60HKjsx2ALVT4QM8gSZhcM6ELVT6b9fFyR9b3xs4RjyAyiR9KJT1keGhTFh6vWaTeDhCb9Eg7umZcne/3mm0MFnHOOepb3FtHH/F5LHYUEWwCwbb+mpKyyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy0koghN; arc=pass smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy0koghN"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2e8fb5c331so7133566b.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 22:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791178583; cv=none;
        d=google.com; s=arc-20260327;
        b=g5CVWb/ORCdU12iTM86KzURF3KkFv6l8J3/+jBQC2yI253B3wurnZ6ngU6gSglybLN
         KaXX/HbPmNzfd+yuRJsavBB69f8DWrEN91fhkjD9iVWNZC0A801wByWjb34B4rDD67fH
         q5+bkAIy4WvNDEZ1WccgoKxXjA1BBtCfpj9sgBsBw6E+pziMjfv3jRoxFxQD44HhvAz9
         KXz4PUTTVQlGso2twcLBfbp+hilQBuwOynDIxmwjab2HUedTjk4AVxgJILlEi+MAKUM+
         nT0Lt72m6WLslfiFyxtil9KTa6mxx2Mz2MZnVX0BgeLvL69UFjDUQRXUkVEgG7YsjZZ1
         YlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
        fh=FNw4+rGK0LioXrT38NtWfmUsk3aOoCFShH4qfpY1p3k=;
        b=CuyHaia6o4vdo1q1XAMpO9qr3BeuE3Q4aikrTR7Sp2c4DB5+I1ORaXIVLXljLkD/lb
         i6PFTOZH9FsMMqkwyKqJhgSufz62zUw1aiFIXdmVjLxq/PvSm3A6qazfueXXMWNtgBWF
         Vf7ebDUdpDqosRhPX2PasKfwxNQCGTG9izEVVl/HSgGViKlqqVMKGJ9qdI+w146aQtRJ
         Hg9Y+UohE8xBG+2DeJ1rSXnG8+wl4ZZ8E/oSnD7A7jE1qckbzF2YCmdDy7QVkXlYu1NL
         3sgzLUnBIQNGk/IEk02T1Q9q+clgWE+T4cAquek/8woI8OVXWBXSeYRW8JQSlEBN9o8F
         Agtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791178583; x=1791783383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
        b=Sy0koghN9HrqAdBi0waqOhWkjHJaM7e2TwA+032M+AXUB43q/37pA06hC4BpZshCgq
         TikkJYWDi6dxkfl+VguwZPtYVT6E3rj9bS3ZdXaSgu7tyPZfB6rCIpX3Z+dHQ3WyNmlc
         +bwYZFrkVHC8cwYBNnQIeCM12xqDeNMhl+VHUkZsH8RJxmf1noLCO6g5nSvtvoKHYOIK
         94wqkKjM8q0wsrCsQszssSGavnHXdqxwejQnamwQ2ZGL9CBVzvb+bsRZPvSvSMDcaw1T
         qNJmg0/fEg/5a/Y1pCjhzczdwi8LpVZEt8xvJCx6bmfGRs63Ka78vmIedC4EcO3KXqr1
         MMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178583; x=1791783383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
        b=D4TL7aFu8HehE03K0cjDAuoAmwao4Iy1UNCIhw6nklphBYYN+sN20EIR3E61STO1Da
         9VC4lWpl656nX7se1jcrB4tTrCj1vtdSpFZWDrF3BLGUbcwU+glpMgUsUAvpPPv4Ws85
         fdrt0IVFpx1GWPQ6NiFtKu9oLuVF3SG0+qDzpnsIoqNoVrmHJ9y1YNpNMc6kqEqvNmxO
         IARaHQ3kwNh+8lpyjidKLkx8aEgx+Jc0J2AQkaLgR1ne4nRKf4vejrpQkZY1i+OviWxn
         1rUaTllh5IQMXzENDSWSeGfz2ncYWyAIC5HBW3naYnbBS58vQzfDMM5I7Yqs1AHDPgKW
         dM3w==
X-Forwarded-Encrypted: i=1; AKwUvBwOsHNHDri1lCprbhcMlI05YeQg+TbKTy7+lK2+UF/7f5HUnTYCcXdMzZ6GsrYl7Np3eSUV0vE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvkQ3UzOwj7c8CN21sfSjnuH6sAC6jrzhcQRFyA/XVX3zemCWi
	+wD/a4q6fkXAse32Vv/0EIRuGgIOa858/7YU6+e0SCsSbe72eSlGT3/cn6Sef87zeAxamCzx8pN
	OOfQiiH5NRUrwMxcR8jFXPhYZxA5h5ns=
X-Gm-Gg: AYBFou2E3OKS2EiY+YUfntGyFgvcxL6y//RatW5LD2u2jlQjr2J9tm8OkWCTqk82UXM
	AZ1blcKbTe9U6sDXlbUlGejGUt3vSGVp8nnNgmq0S1wZDb2mBmRR/TJk/xaLenI76Z0CeMTz38s
	R2s1+ULLQmZWRspQaPeyvE9TcOUq2PzWhskxckSdE/ml9MiC+up9QDO7j+E+HLlQ0htQs1SvFB7
	aecNoDxIoQP3TViQO5aTmVqtV1WQ5ud1N60t/1LwKl9gfEdmVF9LnQ48Cq1UrKre35eczFN2lG/
	JyvZBah/Vetq8ejgeddGcwl1hRLQvt40kIRn2BaiDjaq3n78gw3dtL22+Pk5zWMasjOJnU+p+Gp
	vBs3oP+j3v4A=
X-Received: by 2002:a05:6402:50d2:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6af9e2e7068mr8641383a12.2.1791178583097; Sun, 04 Oct 2026
 22:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-1-nicoyip.dev@gmail.com> <20261001182924.3928331-2-nicoyip.dev@gmail.com>
 <DU4P189MB375033B6F5978460BB988D89C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DU4P189MB375033B6F5978460BB988D89C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 13:36:11 +0800
X-Gm-Features: AclHuK8fAsMrI3qzzV8uWswviu1Yxpd03vOYqXZXhNud5CFUwzH2-M436KXUFEc
Message-ID: <CAAo+4rXFxvqNvo8BOsX5gDScidFfk-aq1oZeakXw=_Ufk-41Pw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tipc: unlink publications without a node lookup
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:08=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> >Subject: [PATCH net v2 1/2] tipc: unlink publications without a node loo=
kup
> >
> >The two remote-publication removal paths remove a publication from the
> >name table and call tipc_node_unsubscribe() before scheduling it for fre=
eing.
> >
> >tipc_node_unsubscribe() looks up the publishing node by address and retu=
rns
> >without unlinking when the node has already disappeared from the hash. T=
he
> >publication is then freed while its binding_node remains linked, so a la=
ter
> >publication-list traversal can access freed memory.
> >
> >Both paths already run under nametbl_lock. Unlink binding_node directly
> >under that lock instead of performing another node lookup. For a valid r=
emote
> >publication, binding_node is either on the node publication list or is i=
nitialized
> >as an empty list when subscription failed. Remove the now-unused helper =
and
> >address arguments.
> >
>
> This does not fix the root cause of this issue: Not holding proper lock i=
n tipc_node_write_unlock().
> I will post fix for this issue. Thanks for your report.

Thanks for your help on it.

Best regards,
Chengfeng
