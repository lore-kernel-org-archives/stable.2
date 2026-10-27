Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793097945;
	b=sgxwR0ktnnizYDtTtabl17Es9aGm0FGUwSViYZjX1ODIz5AmoYkhRNi/sJ5qwdSDXXsm
	 uKdqWniHkBNM8ilU2OAtTRNZOMakBYixSi4r0ylKV2GLCU6OT3WIsfbvl9mOOzMZvQtsq
	 5IKwDv8i2scfZW6PMMT4rOLLm6PPNd9UIYZ9PdGLoom3U478Opxwq9vmHam/sq3zBnmKq
	 rINe23to3U2GaukXL6eKTWo9YwXG+AvpFIX23aeyPzLBDTFVU202bMJRCcId1AJu6ErgQ
	 02foWsnnOzUZwcjPL2+C61UNq9RoqPCGxasubsiT5PPaV9iV4pJkYcBN7F8tCt2lNCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
	b=iqwjEkXRvHFK3wpO+Me70ChPFa9h9MaPZdoCbUXk8EEU0WJafbiOsP0nWqVo+Mrovrjm
	 LBzp/sfaHNdBbJqYoJYKwU8JirzbVK0nxGOJ6iHSyy3mQzF+mep8+tTVIEatf8MeBObv8
	 fcIAcQQ5f9i5GgKuBB90zV/EhWBdYR7O0rBO4mft0ZhqNJ3NdQ4XOns/5+TPpVNDdHSfu
	 gduMWqeatasdj10e2qrUo+3H7GjmogIP0ZrI3YSI1MYHirMQVi2rcZJ/iTDGnWXQUEcgu
	 LOVp5nBxsuf5IkJoNxyyFw9ddRPim42iqJtPoi8+O5ztzSomaCGycNMt0MOcN3JG56g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sogkfs8Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61605606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61605606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sogkfs8Y
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab2ac79b69so23026951fa.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 03:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793097944; cv=none;
        d=google.com; s=arc-20260327;
        b=hm402lWLssuDIc2UGwXhZQ2qbOxHR8O6Ni+UU3MkqYcctP1rmq+tfSW5pKB8jF8haC
         AYvkqusDyKjHIo3NdLfSAnwdPtF4G2FL9voNiw9ACAEHfZ7LF65TgudDR9hBeK2ryU9n
         318uP2WIEUQyxWOKUlNq1CvI79IdoBUFk7PNkZgRjss4dRwnNndNWPQ524HZw2Uw7/qo
         gyMWjRUxhNeRy5XUSCUcw5WGHKSJxMWnAJds3hs2+A2Z3bRYXP2rkFVKVwrJtJDF+WGN
         sEX/ia9hypb3MKTU5V7X7N8hBFLS+TCwluL0HlOaR9XAxtFyGd0Ec+w2VmLnJTSy3OLX
         zfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
        fh=CIZyiNZdS+RwLDSr01H+2Zaz9VlxewenhVAlLdJbiyE=;
        b=ZyZmSbpa7pv8wvA0wyNpdkITf8cfc3XzAU2JW4C7cpI615Sli1tl40gI7oDcIQoAWb
         lrSZF5urOWEkcjLGRYvSAqL7rAeLharWj1TLbs347xgwh/JvHMSnghNzMvfGQ7aCCKrt
         zI1sWMV6iVjuKGOmrSH2LXchi8Qp5qjZQMGQKJQUGcMpR9EpKtCcGzkun6IMdpvvGq6s
         6tgJOVQt+5CvIrbw3Pgyq0mWS4GUgBqG1Xy4+DlYmNudG4y5y/Cs94mwNbbAoArbn+c4
         30joq3Tf9tvKf4i/1ySrrXBwJq7XJR2drPPCDuRuC8zpn2YGcDNP9stnL4bnGZiO1CgB
         kivQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793097944; x=1793702744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
        b=sogkfs8Yj7sLD1GRZUKprdjOlswEuPvl0xyZHwAG0iwY476oBzdktP8aRfeuCj+QEU
         h6aXCTXRsU3Yh7oF6mda1jsjjtbiEku1MBHqoMyLt+I1j7oj4hgW22Z/unEMrUU2n5ts
         5kc7EptSgzWes73Knoo0y4sPi7VLDrs01ZFtI79AlzO3Wv/67i4HT2J4S0cq44Y1J2TQ
         /cmyG57cyRboHEPJ+CLmKYX8mQ/yiLCQPpDFk/JAW2KqgqQ/+3gsM5dREycEm+1tb+wz
         /OWiFY3481x0kpqQmvg6ej5GanWyR8/4rpyAb+s62N/7MBRUrG9P95ZjCVaXHuUwYrSN
         TMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097944; x=1793702744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hTokF6f/74TTsrDj3bp7weKrYI5kvTRFYSNs6uOsOws=;
        b=GmIf38yzptokTZVDb2p2hURgGi1rz10zdZWO7pxTBwPbs29E+eD+EqA5SkDqohAkwN
         0L4va8hMEzUqjcVFXYjWDBgSLD2sjrLui/DPiDmZoZ/YS2T7wHqCmDagHRNLTnh1EqWV
         MPv6u8fNFyWGSRSuRnC7QSxPqS2LpSIw9F99XRjUIDIW3GvZNzObevj0ikAtLDZO0DCR
         DVAOX1TaU9SEaf+cVKuzt+/MTK/htu5AqnlBgGmRqpaCSXQa1xfYGSlHufmKoU2zkJh7
         TFa/WyLgNquWTH+wi415/wSA/UzapRucgvAjDZ2mGHCUaUpkD4D5SAFJ0QIgmqTEIzGw
         pcOA==
X-Forwarded-Encrypted: i=1; AKwUvBzdKL+qpiEnKRBd1t7oJ9n4iw8BxqXHk1v65H5ocH4vjDJFH/+xeha23cXCaRnwC8DVa87ZNXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIr4Xs4sP9P0XdhrZN+mXAHB+q3DQ4PxGB5G/Otno21U7+kXcw2
	DJdbtIP8LcuYaUx8hUyYfXNzO2TTzdeS+btrK27EF96oTeZJp4BUc5qZaFq/CftpKOlyYjbJ2fT
	Eq6M9Cdh/F+4o1boVoAC9wwp0OsWh1VE=
X-Gm-Gg: AYBFou0RaoOh95q56zlo74ztnjC/z4iwfvPjTZGG5AZSX7XCT74HpR6gswuo9HZwpjf
	rrGNAdH1ozyIshvZTT7i+xuytC8Pc7n4CMGZcfunOdVMt81E27mQrDKUgGtHkftN0S5Tk7RRzYc
	+0yEoGnCGOAOoPe/HfM/AUiQ7T4JuTDoDHANSh1DkkCkft5UkonQBEZ5GALIvT8CyVzo+rdqUEq
	+Jc2n9zk5V2+H7yJ4zEUonDlVg5ti1F9CDG96y40UF8P0cEjOKMLeY9a2JOzfrzD1CV/zzoOlc8
	CWjyFpzXSfyf8NP1I0XCB2bjvbFHfRzQ9JbLIg1hJF8IqU99jF+5GAQNa45IySIu6wptBWYtZmD
	/hyPt36iGxMd/uOC3BpBgrOPBRtZ1EPs9UwG9Rw==
X-Received: by 2002:a2e:8a88:0:b0:3a6:636b:63c5 with SMTP id
 38308e7fff4ca-3ac6fd3b986mr20717081fa.16.1793097943292; Tue, 27 Oct 2026
 03:45:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020034531.1420194-1-bsdhenrymartin@gmail.com> <20261021102614.GA3351287@shredder>
In-Reply-To: <20261021102614.GA3351287@shredder>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Tue, 27 Oct 2026 18:45:31 +0800
X-Gm-Features: AclHuK8Zgr31J_CCsucf-oYLGgEzAL6MqaaFwHvcjtoZy3YHWAsoUhYfxrWtFnQ
Message-ID: <CAEnQdOoQRuH8A=HnJqruN_kp5exzTwV7bK-LZUVo=LGuSMmgNA@mail.gmail.com>
Subject: Re: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb entry
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Petr Machata <petrm@nvidia.com>, 
	Ferruh Yigit <ferruh.yigit@amd.com>, Antoine Tenart <atenart@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Seungwon Bae <qotmddnjs@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

No crash and no leak: the appended vxlan_rdst is freed with the
entry, and vxlan_xmit() follows the nexthop whenever f->nh is set.
What breaks is state consistency:

- vxlan_fdb_notify(), RTM_GETNEIGH dumps and the switchdev FDB
  programming all prefer the remote list over the nexthop, so user
  space is told traffic goes to the appended remote while the
  datapath follows the nexthop group.

- Once a stray remote is attached to an all-zeros nexthop entry,
  __vxlan_fdb_delete() destroys the whole entry when the matched
  remote is the only one on the list, so a dst-scoped "bridge fdb
  del ..." or "ip link set ... remote 0.0.0.0" tears down the
  nexthop entry, not just the stray remote.  Same class of
  inconsistency as commit 98fc57d16744.

Test cases added to fib_nexthops.sh in both ipv4_fdb_grp_fcnal() and
ipv6_fdb_grp_fcnal(), mirroring 98fc57d16744's style (rejected
append and rejected non-unicast replace on a nexthop entry).

A sashiko pass on v2 also caught that the rejection would leave
"bridge vni add" half-installed, so v4 is a 2-patch series: [1/2]
the fdb guard with the above message and tests, [2/2] a pre-install
rejection in vxlan_vni_add().  If the consequence description still
reads as net-next-only to you, I will re-send there once it reopens.

pw-bot: cr

Regards,
Henry

Ido Schimmel <idosch@nvidia.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 18:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 20, 2026 at 11:45:31AM +0800, Henry Martin wrote:
> > FDB entries backed by a nexthop group must not carry a remote
> > destination list.  vxlan_fdb_update_existing() currently appends a
> > remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
> > multicast or zero MAC even when the entry is backed by a nexthop,
> > breaking that invariant through three different callers:
> >
> > - "bridge fdb append" with a dst on a nexthop entry;
> > - "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
> > - "bridge vni add/change ... group <mcast>" on a vnifilter device
> >   (vxlan_update_default_fdb_entry()).
> >
> > All three reach the append block with nhid =3D=3D 0 and a PERMANENT
> > state, so they pass the earlier nexthop checks.
> >
> > Reject the combination at the top of vxlan_fdb_update_existing(),
> > next to the existing nexthop guards, so a refused request has no
> > side effects: placing the check in the append block instead would
> > return -EOPNOTSUPP only after the entry state and flags have been
> > rewritten, skipping both the notification pass and the err_notify
> > rollback.
> >
> > Note the resulting behavior change for the two rtnetlink callers:
> > operations that previously succeeded while silently attaching an
> > unused remote to a nexthop entry now fail with extack
> > "Cannot add a remote to a nexthop fdb entry".
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>
> I agree that it doesn't make sense to append a remote to an FDB entry
> that points to a nexthop, but what are the consequences of allowing it?
> Does this patch fix a crash / memory leak? If so, the commit message
> should describe it. Otherwise, this looks like net-next material
> (currently closed).
>
> Also, please add a test case in fib_nexthops.sh, in a similar fashion to
> commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
> nexthop id").
