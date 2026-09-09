Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF33E16B2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940862; cv=pass; b=EMaWAj5W4MOE/XI8burvYWv8QuElD4SRXN7N5DL0pu/ugiHM3patL1wYPwDvdTlm7G+R9W2g9SylQBGUumvfNW2qq6Ty/q60uO3k0bed+WkMWK5kHfAYglDD2LWkZoJeDeLYZOkGIddb0LC3afhKdbSV0bijgu/qu96MiszcJc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940862; c=relaxed/simple;
	bh=3ucIodV25H4f/E3Otu92DPDMc08uUsFK0OMoN1m35TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teCWXPUH99rFZ9Tph8MQhAoaOrOXKTgRxYhLHJnF30FENjV/opfmo7zio7Suu+kJpaqpxh6ku7+yFarFVYdNmqpBkycBcAe9xrQXN22hWT88HamcexbszDOVN86HrPpUiEkySyCqQAo1dWnkD576A8vLseqIkW55IWI3tuDdN8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAaBaJqV; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAaBaJqV"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b1b9c3af5cso4484658eaf.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 01:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788940859; cv=none;
        d=google.com; s=arc-20260327;
        b=LXXB6nOUQF0Se06CgKr39p2LD9OfO6LOm21DLjE6HRkLc7Ka9StPFM7S0ziFjklx6A
         ILsJAa31Ky7bktizLY7dqo67i2L2/5loCaJ4SrZfb+bMoH6z+WoR9AgbZnuMbtjcyeu1
         kCygvBdGladczZXmUxOiNBVOQFBPKB6JfwtQIXODIYmgPYrvzb/rhSuOSJvKOWTG/pY/
         4bErQ/ubs+6HivIoi4bF362xf+Dk6qTuq3JlfFPsALJKaLQaII0BB5TN6HYNwu8MTuw9
         bGDiw8WF8oJWIketwmAw3XTdtQZ6/GtotU38U9NV2GiDK7R14YVyJqDjNkk1hcoUlTiF
         j2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r6ojG7KkisYtK+a5wUQDcdWxUyw918+UeZlJ6dvtgzc=;
        fh=7m7ioAUZcp1u2kTUiC2y+5u3rDoBpYs7JFe6OQN0vGg=;
        b=noR0Ji4izm5T8JnlbTL5iFbvc6wfORywTPZbMrEFP3d8p21TlB4SWNynzDCKKYoNrv
         zOLxA726+1SwIiEZXLhCFh2XjTnwp+75Shs7P2RholXCbuDFcW9slgEuuzPyxsLYNHqI
         KqeQ8bcdcdNZIbvV3NHmYknFgeTumtOIX/VKKVCn2d2yZ3zD/8VbOK81pA5myCZ6eYKd
         W89rEI+qYIIEcEStzO/fjoQgfAcGOuocjHa99L+B4pbhTJnAzfjlPDSYq/9MfyMfEnAi
         IqCAUvD2z9YOtf9xVv1TAHhDA7k+o5SuPQb3yUBCZLqIhmpr8RId9GMXDvNxm/FgXLUJ
         ZLGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940859; x=1789545659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r6ojG7KkisYtK+a5wUQDcdWxUyw918+UeZlJ6dvtgzc=;
        b=lAaBaJqVFwbtvNU1Rpl1bxMI2XLo0Vl5xuppeTvGKoDuJ5gg4ffjEYkdMmv3db4bLf
         Fis2oWvBJddUyzFSamIMiTkFA9CWuoVECRCQ7uCqMVtyzUyYsuGm5SPp5eoXorenNYzO
         FFGrkL2lrcLhrafn1d5oxJjA5obKhqF1ouCj35qxH5nE9hpqkFzTiIVIyh+kDePGTSes
         wgcg3SFKpmrEUkaaqNr5rfzdKT5XktHi6MjoWBq2nz40bVXFYPeNwUYKKoDIVwLRYHbt
         uHlLfVmKQ9Yoth6pZL/RoOiV62PchVianvM3gK//4xohZLHQSY40rv23dW6ltPKH2Y9m
         xMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940859; x=1789545659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6ojG7KkisYtK+a5wUQDcdWxUyw918+UeZlJ6dvtgzc=;
        b=cW2n0oCde2XDDT6VvxwnmGt6QBurORzRf1MqmZXWoH+HroWR7yDs0KqG/ddZnLVfTP
         HESu2YIq9Jfqi8/PlX0MS9GMMco3YIl5khZd/OJLU6oYk1n2+gZivOBzByoaez0bAcNJ
         uwvmHOc3oCMc0dib/TaYVU95SvvLfghoy4VbeR0u5eB9JSRuRJFEfqyaWhFpitFC9i4Q
         ScoHRCDjHANvhnwMDalVf8dAGRo9XUku9EZBZonPt+hVj8lw1Vbnht7NNwsg6IpXGvOy
         u0AZV/S105v0WKTNGH6w8P37OBI9zxQmjqsP9D+1ilUpmcHi6bnUaGxCQXabGHYMNcBP
         5NOw==
X-Forwarded-Encrypted: i=1; AKwUvBxU1IUFqmlhKsAJ/Sg3Q2Ye+VDlQGDvH1a1D+CoFxcuqNGqM2c1yeyms8/6zHbzc7RNZRgxqAc=@vger.kernel.org
X-Gm-Message-State: AFuF++mFgc3FyUO0X8NfMd1CkvBVBZG8ZHm+lx8VpnbxFzCcKPaYO5Ln
	TPq+wxhYWXjZjIPqvb2zPE1uYhAZACM5FzSPnKGhYCPcHEwwlu8rMr8peIHkrCYh31FP7tbxdbU
	e7npBgAMdrUDOOcMlUR3STb3o5o5RFc4=
X-Gm-Gg: AYBFou3JISdZkLgOD8RWbgFbDeTQcc9evGg2asl3Pqv771uufPX/dr7ZDw+j5lavosH
	FSPZOPpko3klQwnxBofua+wWhGJz5iIFxzGb7QpCamrI7Bij+0meOkI1s6kSJ41jpEETLRY224e
	6o3ogw8AXEVw5dcPaU+8CzTd4K+L5yyohBlCRExDuU/GrPwVwvmwd+vTv0U2D+d5LdgciwHNO9k
	CqrTvZmL+vmpfjU2WdWs90Up+xSTxCg7Vr/41vwjFbDsS3Rt6feA1jq9pHM4URLoFAAd40JUAvp
	j4X1pZuDuim/gdLTtFvhtZwv2PxkM8m9Nx0kGObWmDUWxc0FmzGrZow=
X-Received: by 2002:a05:6820:2004:b0:6b9:2d62:960c with SMTP id
 006d021491bc7-6b92d629902mr12360812eaf.68.1788940859557; Wed, 09 Sep 2026
 01:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820123512.87236-1-duankeqiangcym@gmail.com> <CAMd06XfsK+X1xVX7=nW+U572OxnZp1vFyYjBNdr2AMtb2zgYXg@mail.gmail.com>
In-Reply-To: <CAMd06XfsK+X1xVX7=nW+U572OxnZp1vFyYjBNdr2AMtb2zgYXg@mail.gmail.com>
From: keqiang duan <duankeqiangcym@gmail.com>
Date: Wed, 9 Sep 2026 16:00:47 +0800
X-Gm-Features: AcwNN1UAqaMukPjOzxIcxUWiOmebC4V-Yq3pNFBbnlgQ8z-xNu3lccJjr6eb_88
Message-ID: <CAMd06XcQEv2ezDzRWcgccw53eXVcMPBqjGh--qZ5xFo0FA_pJQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Clear hardware HLT state when userspace
 makes a vCPU not-halted
To: seanjc@google.com
Cc: pbonzini@redhat.com, Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Qinguang Chen <chenqinguang@kuaishou.com>, Zhiping Du <duzhiping@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

The patch still applies cleanly to the latest kvm-x86/next and builds
with KVM_INTEL=3Dm KVM_AMD=3Dm KVM_WERROR=3Dy.

No rush given where we are in the cycle -- I just want to make sure
this hasn't fallen through the cracks.  Please let me know if you'd
like any changes, or if I should respin on top of the latest tree.

Thanks!

keqiang duan <duankeqiangcym@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 20:44=E5=86=99=E9=81=93=EF=BC=9A
>
> +Cc Chao Gao
>
> Sorry for the missed Cc.  The patch is at
>
> https://lore.kernel.org/kvm/20260820123512.87236-1-duankeqiangcym@gmail.c=
om/
