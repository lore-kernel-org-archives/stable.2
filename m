Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B219367F36
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915973; cv=none; b=VDSiNcP5L78UNcuk9PYxG7BFS/jOWruPJslOdkJ6zu94wrCDe3p/WlwtB5Ir7h+8UpW1BswxZ4i+V8F4aFj4AldUlM7TUsQmRqCXCgtsd0oWRIcbXLCOQmtVK9IGQJXFPC6uw1AkQ9LN72B/bvfqcJ3rEMTHYoA6ti4Be+L/WfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915973; c=relaxed/simple;
	bh=LH0cre7tbNznI97NpetgP7082ANkOnYKNe1B/cTlZIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVklfbQVcazuSxQDhS9rFUNWMS7xWdcFuDQxMLRPFlfeOLErc18xfWJ67Er9dVqwp9w0Oz7kOshO5eH5WbPYURCcKNTvY0sK6uZLGzbP5OG6TPK0DMSBVOscNKP4MGoXnq3khUgZQzq7vEpBJlmUpW51F8VJ08vkpPELNfQoO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=F7R0tooi; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="F7R0tooi"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e6f2ee60bso14336607b3.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784915970; x=1785520770; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5LJ6OcJsLdNztGOsxSUblIxSQsg3tRm97yPkBJXrpU=;
        b=F7R0tooiq1jqNDLs3WNjd+mXT2LV9L1FX7wuzFEmhybLkP3nRFEggMu9vmbRcU/ook
         WXauBT+eRCkSjkXaXoE1TItcC59x2EE4psr6GAQFVN2MAR/OtFC704IwmLdW55SXEJq1
         KwWMT8fgF/3o07dckHaXdDVCBo/PWP3wNHxIIL+ekxJCTFbW71/x5558MCYlW1gxI5HY
         OGkRblkw5lpJ/QtSxy/SRa3t7qyJZsXM3gAx5v/j4SM+M0LB/g8v2D/Bj+E3O4Vbs05+
         yUBf2UQZHl1p7V9j1iZiRE5F+a+Y8tP58VgIte/AMftfJWZooHRbfTYHDGuARjpn7rYC
         tLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915970; x=1785520770;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r5LJ6OcJsLdNztGOsxSUblIxSQsg3tRm97yPkBJXrpU=;
        b=DWNb04rgpwN5KR/cIdNH9+Ihzm1enpkZLn45YgUouofUdSrhykln2ASJYw+zgZMhAq
         8ykT28GZSStstjMnID2vhgIVfjQqVc57TK98eujRbnE9ctPmgynBtFpW7yULcoPF1TSf
         WQdTQ4cLsCVF3srNfGzxOzhzA9w/5fIZl5+JIH90WKCpARLo/6BTCHLFRQA5nIlYgQpE
         Fp+NY8A8QpfsH+RIR4bclovaS1J8DWSpU5aUCqUG8qQ7iCS/Al5EQe1ALwboP/yXwF9u
         8Q1VnwL5ud+BzwUmRtZS+d1GZWxt14D0WBUfKFoUO/8T9T3AEbc3yHWWeV/Amz/Zc/4T
         9fIg==
X-Forwarded-Encrypted: i=1; AHgh+RqAAzOcd1UXYdw3DM/DZBPczASGLqsO31Ipo6tHdpd8eWMr+XMrQhfEil+qYBE+Uixe0uEbJQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFU0RSbw3k5zZ5l+s8y8n154+xikhmsqcJx9c3pFbluRcPZXHq
	RioaqS7jqn7EkBSk5aWcaEGzW7Mi3yw2VMFndCSLW+Pjdxaq1x49NE+vcOkcB/eAUGc=
X-Gm-Gg: AR+sD13RLkJtfmEw4gux/Awh7IyqVMN8/B7/yHSMycCHcVSmJbFo+K1hDcanOsOCdYt
	lvcDaqiVg/uak/gZsq/hLWQnYgm/35ZjLnByLYt34Yu0VgfBhBQWVZab68S1MzAjd7gaRKBHpnP
	eozP5LOsO4lhlqZEXL55NfqwKAJOZj+fdRLNpJg9Xgu2X9NGaUlYH7Pq/XakCtB7dUpZ/EnzLvf
	J1S7H106K5mbw6tZI1LjEBeKdOtVrmDUI/0T9bot87feRJbqSvTpChJjtt9NxE/zKNafldbu/1S
	Wp3SGcz9hx5tKk1/xZhC+1cLwwqQgeQAjtHrTeMSUEyCV89MRzn0Z+qn8w/jxybawP+ydj72L47
	NFXFD/0tSABpoph0Ou6dYVU7NXiKvNyoc5PMGNlXPU25K3zmLuKp6JcK3HSgA6X9VUC8lBKpYFM
	h5bWo/EO+cv8mqrCM6okoJ2klTpnwqjb42jDfyqwWOEwHSJzRGd7yMQCyxpDLoOezcBmLLHeSff
	pqfe4VJ9pdQyuV26Vnn6G8EW1FraiZwWTm0/Ku8Tvk2sWInidPXgxorGYr1B98OSi+nH5Vfac/L
	TE7Fvg==
X-Received: by 2002:a05:690c:e647:b0:80d:ec6:ea1d with SMTP id 00721157ae682-81f63f22625mr3164197b3.7.1784915970131;
        Fri, 24 Jul 2026 10:59:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6590119asm3503177b3.37.2026.07.24.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:59:29 -0700 (PDT)
Message-ID: <103949f23bb3169381422344cd924d6897171e71.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: fix mds random selection readiness predicate
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?=E6=9C=B1=E4=B8=80=E9=B8=A3?= <zhuyiming@kuaishou.com>, 
 "xiubli@redhat.com"
	 <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
 "amarkuze@redhat.com"
	 <amarkuze@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Date: Fri, 24 Jul 2026 10:59:26 -0700
In-Reply-To: <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
References: <20260724104920.6493-1-zhuyiming@kuaishou.com>
	 <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 11:40 +0000, =E6=9C=B1=E4=B8=80=E9=B8=A3 wrote:
> Adding the current Ceph client maintainer list
>=20
> > On Jul 24, 2026, at 18:49, =E6=9C=B1=E4=B8=80=E9=B8=A3 <zhuyiming@kuais=
hou.com> wrote:
> >=20
> > CEPH_MDS_IS_READY() is parsed so that the ternary expression can
> > return true for an MDS entry with state 0 when it is not laggy.
> > This
> > allows the random selector to choose a down/DNE rank.
> >=20
> > Group the ternary expression under the state check so zero-state
> > ranks
> > are not treated as ready.
> >=20
> > Fixes: b38c9eb4757d ("ceph: allow choose random mds")
> > Cc: stable@vger.kernel.org
> > Link: https://tracker.ceph.com/issues/78648
> > Signed-off-by: Yiming Zhu <zhuyiming@kuaishou.com>
> > ---
> > fs/ceph/mdsmap.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index d8e46eb7e5eb..450a4dc9662e 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -15,7 +15,7 @@
> > #include "super.h"
> >=20
> > #define CEPH_MDS_IS_READY(i, ignore_laggy) \
> > -	(m->m_info[i].state > 0 && ignore_laggy ? true : !m-
> > >m_info[i].laggy)
> > +	(m->m_info[i].state > 0 && (ignore_laggy ? true : !m-
> > >m_info[i].laggy))
> >=20
> > static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool
> > ignore_laggy)
> > {
> >=20
> > base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
> > --=20
> > 2.55.0
> >=20

Good catch.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
