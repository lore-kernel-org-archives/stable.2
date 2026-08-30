Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F542E7378
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123083; cv=pass; b=OKUPeQbDvZFJeK/7krGZOA2HpVlu/g5dHtSHt9zo+tpnoCAjswuDIUuS0JUUvE6YlbNpwfY3bAlqdePO3selYvQYCBmn8Z3HLaMsHF5bOPxbizRHeSr7op/ABRKjqGBExsEDlsgATJ7WJEoe/C78uBMBvn9InyERUY3wDEXKsQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123083; c=relaxed/simple;
	bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egfh9hCTDXPBkMr5Hbj5elZ5nguyF2JcCQtidBzBVBNJ0hXUZbf18oIOmcvw1g42w0MDqhYRyo5iD2s+k24UJjMZ/IHNqpwG4dsgos+eKDiGsFyNG06/nakEgkgAO243+lfTajKiJ0uya68IfcfFDFySnxk+nJ/c9ITgH/k+QCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRf2eHh7; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRf2eHh7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so6940a12.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 13:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788123080; cv=none;
        d=google.com; s=arc-20260327;
        b=Q3va/r0e0FWQKsMeaimXDYq2qiWoSFu874Pazn3H96XwJF0ADK4XFdE70Lprvq2+Fd
         CXF0xQRQvh4tVvUpR83AGePuQ9aIzoEFwb2V1vLwJQzQhjFiBnkRxpZcWaWAK+VUpmqN
         tSVRtvOPeusCH5Z9JZPeAw8mMO5PVYkEJ10+0WQQYAcZL0E8O71TXThJxPBWBiO7Qnaq
         rY+pYWSUvl0tACW47jWzfAnmKhRzMILFWT30Ge9V2eE71gwEDCphVACsUASouDTDD0oI
         h/ayGSrQDUG7vBSVDncMuK7puboZyEoc4KNGm8meAnVbeELhltzlbAT3FeexZNGClt5o
         h+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
        fh=DmZbsrD/j1+f+igrYt7qPc24tzc7Eno6LTdbssKGq+g=;
        b=qyovZRm+M4J3g25yfPUgD4l6jkc7CQ2Uqz3KgCahkvOs3eLh19YjfShyc2AUxEF/ZS
         Qh7/hqjxUG0EEChgGSqYVGlgbHEGoJKGNH+XkOUN0zYjyitJp+BoMQX5lB3SeQMaxwFf
         en/JKfewSu/xKIO00MQJArleB5hkcSu50TByehpNLEagU1NIf5+Wh7CNnzlsnZj1dEjM
         9NLisoXoiQ5PzL+wCg56IrgibT1kxI4KP9I+914HCb2WXM8MSoB5LC1qCo5OCtfQqUao
         3G7PLRMsilWVpwIszwCboJdWk6kTsEjzHjbfS+PIDb7fho121kA5HX7i+tKhuAmEyBXB
         785A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788123080; x=1788727880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
        b=mRf2eHh7xq3mfglMpCNgppOLgsMfs4A3lP90nnTODkYvC2RP5NhGW84NrP8Fqsl6n8
         rojL7epCf+x9i8Alzn7FviGBIfmkVxGR0b5JgtfsKkkxoaf1jYge8qgMzUhOWHfD/xUP
         tBeik8mb/8U25jvfImn6yki/9o1O0z3znmwDj1VYxL+RCTuXXYhLbri3ngOrme8JNt/m
         VvO2qCumj8SVAVT3INA2PR/gr0OBW6ephRUiPxBZV0jyfdE6iPms7U690jHSb7tBfcEE
         m/GDa2oSJo4B3SXoJGVY1caoJVwWd741/gc1Tp6CG/EM52kBtg094APKLvybZAJCKuR7
         HyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123080; x=1788727880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51qPjagGnK9IkgpUmhvIHxYp8R8l8qOTFkMoSuBy/7w=;
        b=qDgfv9I/+goOE5PQaFOGG0tbsemqsd35ac1296B0zNkrJrBXbu4R4ItFgYBNOu/4Ay
         BMQLVvsdfD4HcebSh61OPDancGjGFwIX8de1WmvKFuQgFfJ1L4Rp0bnG2Td1xDbC/M3L
         iILHExaBOCgTDizXrVN0bs6rtP/6jE1XOK8z86ckO/47ZFnvBFRYaNmkBSRFRwat3Ch8
         jLBSEs6/jRRDDGB25sb6B63nP1hjm7wtRJ9JjjwcGQ5WVWu2VF4gmQ9MT/GNZ+GV7Jhy
         bjFUy3OAHAdEydvj/nQaVyJ5M+9KUvhTUIxyStCrnbJyMOm9QSL9VF4OfhQq3LqJA09w
         S4lw==
X-Forwarded-Encrypted: i=1; AKwUvBwEMw+1VDU5NGvW2RMvRgCC1ZWaH1zVAgvxcChcY5IbIBaAolefp+CVHekhlnI+cm037vO5qIs=@vger.kernel.org
X-Gm-Message-State: AFuF++m5UqfrNYoMrNQwAZ3EmHQzxFYI6gE5dCsmfnrKhrp1+jH5j3iP
	sGNCHdXNI3h2NqT5xNzrtQoqaSIWGxMjoNYaqE/CyDwfuu/DahOJSFjYG1whLhjNr6BLN6l59hw
	MBlPinKfT5zW+fhJKoTu9MuRYHsyPbFHrOlhfMtVl
X-Gm-Gg: AYBFou1cBJWm/6tzij5llo7JNfjNdiLxOY8qup2ou+tdiXRgSwP9ur1HWytCpg+9y0m
	2P9YGdk8X/PZVCO/99EHc54z8W/NGzJFKTlEBwE4rjCAD1EzmIxFMXIhh2K5Tdek0ywQ9hQEXfC
	62JT0xUPkKN5lSPlF8vc0ugWPcUHi5QHSjATII8wTl6a5c+SkeznRMjMGnQ7yLRTQYfToWtq058
	LHSAyiap21IwqhgCYslakRDIIeUcLHGjYxUHhdKwLgK27ywUmOzX4ew8ZdU3pEbzeE6Lcog5EeZ
	1f2nySDaLvDC3bh6bSUSe43L8I4RRZzYt/we2mfv6S4=
X-Received: by 2002:a05:6402:5052:b0:6a6:32f5:b172 with SMTP id
 4fb4d7f45d1cf-6a633634602mr29431a12.16.1788123079816; Sun, 30 Aug 2026
 13:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830142333.1741155-1-tristmd@gmail.com>
In-Reply-To: <20260830142333.1741155-1-tristmd@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 30 Aug 2026 13:51:08 -0700
X-Gm-Features: AcwNN1Xm1QyezA-JkdWtSZwOXWMjI9Yt2s6qRIxGaQ-qmcEpa_70-3k-yXY5nmg
Message-ID: <CAHS8izPvuOBx08kGEp+sFR-VjCa=Ta4Ub=EVb1kBP+ROZOMYnQ@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: add missing permission check for bind-tx
To: Tristan Madani <tristmd@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 7:23=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The bind-tx netlink command (NETDEV_CMD_BIND_TX) was introduced in commit
> 8802087d20c0 ("net: devmem: TCP tx netlink api") without any permission
> flags in the netlink spec. As a result, the generated genl code does not
> enforce any capability check, allowing unprivileged users to bind
> DMA-BUFs to network devices that support TX netmem.
>
> In contrast, the bind-rx command (NETDEV_CMD_BIND_RX) correctly requires
> GENL_UNS_ADMIN_PERM (CAP_NET_ADMIN in the namespace's owning user
> namespace). Both operations perform the same class of privileged DMA-BUF
> binding, and bind-tx should require the same level of authorization.
>
> Add the uns-admin-perm flag to the bind-tx command in the netlink spec
> and update the generated C code to enforce CAP_NET_ADMIN.
>
> Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

This is the second time some AI finds this 'bug'. It's intentional
that rx needs permissions, and tx doesn't. rx bind takes ownership of
an rx queue. tx does not.

--=20
Thanks,
Mina
