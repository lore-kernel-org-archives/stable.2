Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815746;
	b=v1iHUPufoTPLhvewTYQKRssOcnBmPzjs2RUel4/MgynsL1UDZtX/Z5/E3shPd/85gEEX
	 0OQospOY2UgoC7+G20ykfV8qAI53+VocBScvK4njNUZhGvM/yJ6q/kXszVbHKFJEdUSRY
	 JsO4QYYAxOBWOHwfHO3ICyHmft6vHpRGRglVLlqiF4GwmqSNEZezSwr8HeFi+oF4LLZFf
	 XSArMBdfP6yv2BvdMCyP1hX8ogiJymKoXkY/aldZ/pJFXybV4CLY/Mcz9h98f63BG0SKg
	 nFQqtoQu+AlnvEHirhMw+aZ2M/om0T/50sDqBwpOJEXkk5CUccLp2tJYRjtKDlKzZTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815746;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
	b=yByDtirfIYH5rOpGhGKSVUd9lxQ603iq5rjs3gfl/kT+3rF90C5pZT8/sl8UgemkGUBg
	 TjTsFJbWmDz3BjBOUewS54mpHCbYFw4yy58cpUOt/ssQ00Zdor88Xp6qScpMCij1cWS3d
	 adsVOaOID4Erhts4XhaXBP1O1ZIM7TNSzdPlfC68OgnZ4jk0vy+Q7+Ryp3exwHPr3yJNW
	 /VJIX8rdk9lSH0HJk14SAWY+rTxHgd35ThUwbVBo37hGgN3S0WpTHL0y7uuzV3BKCZr3t
	 YiRJAili1Cc3kO+z4iSGpGH8VMAC7HS/BmpbvPLFzC95k+LzQ98OqYyauKtiQE9KnQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hnhh8CrP;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gLGXZISn;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DEB606A7F8
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DEB606A7F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hnhh8CrP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gLGXZISn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793815745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
	b=Hnhh8CrPG7/VVlWxdqmyYCqsxNQOFkRv0wOGunekk9hZCPiKVib37U9Oe2nEb1V+CsqzLK
	NWI2NA9j5n0gVaA+d8nFl81o/cj1xm4V7q3V3b03fOODchMyuEVmJX3YrDJWIjIloS1sa/
	giqCX27AIrXzUdGmuSGHmDF45M3+zLU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-VULQ8rfANLynRLseLDFL3Q-1; Wed, 04 Nov 2026 13:09:00 -0500
X-MC-Unique: VULQ8rfANLynRLseLDFL3Q-1
X-Mimecast-MFC-AGG-ID: VULQ8rfANLynRLseLDFL3Q_1793815740
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so8155935e9.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793815739; x=1794420539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
        b=gLGXZISn1+kwWvX8eRNdotsXcBNA8ij7HAxNesYBTl1YtBzTyLCzmVUoElEU8sFZfS
         s2Z8dPs55FiKCUAS0LIP2n9wSPRa1HTLA/zKppb6G5CqlC0eKxpHU69r+nKcKkjutQhl
         Bo1PnkoKy8rs50T8W6OPvcORQVFV0ZenlkRrbzFPe/wRSqrKSYACvydJAx3bWGosfzjr
         aG9PJOZyS7sao4EksbVNThAbU8CO55NO/hUQZg//4AFh021VF0XS7IpqGVMzhzeJH1GI
         N5Ew93Mbi262kwj6uSC++BY5GIejf/gPXQegeFOrQR8Qr8/fUyfmQOdmdScz0SYRAhiQ
         ed/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815739; x=1794420539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CVsLTmxNWfxUI2tna4xY+A80o8Oxx2HIRrZYrtR1B4I=;
        b=HQ5pSwdmeb+rdT0CnQk7ObVJe4hQS+4Mc32yfcsNv2VNVOUl4QNcNhPLTeeIVkcikt
         oEbehz4vFGVpyrM1wucI/XS8IbxlRhNulub9a9Gn5srCBl4dweUO8fkGNrvBFqmadRp3
         mheXLuTo/EUVA0MMVFaUm7wCy7HflwZDeKUIOeNfS0CBWHFChtCIiWnK1Qt1bcEjINJR
         ZvURV7FyeHVYPFyl/npQv7EX21iZUNqjDnVA05LGU5GvLD95bO/UTm2PeBcaWUZVAjNH
         2r9XAc95qtKkV0n2Agbs6EpED6KPIbuAobRSMneJEAqt8N3rZwn22ooCsEUFGjmHoQ8P
         MkUg==
X-Forwarded-Encrypted: i=1; AKwUvBzqGJIHVjAOY1tCv9xRLxNenj5BNudlCndPbO1xBLBJnSgWIrdppXe3NyaiLjQRvnCF+d7nmfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Dbt01GdIrIyIWN5NUzhjdfQmC3raP7iSZNHy7iMVxBi/a2eqX
	9NAqdwxn4GH0R0CoXS12BMlVNruq/jY2uWAWSgWCB2dAhAmWVeY0qWnNQa+nBf2gBCDciE6WgSX
	FQT8hcfNcKmIuo4wDP1zAjMn3e3/ajNxVCSlQm58xukpmTNQv0FYYTJm/9g==
X-Gm-Gg: AYBFou0CHgEohqc6V9GddRLukoN3LVKuh1SvrD8Np7FBSjUld/P81+WnCLSQZ0IZoMj
	NXyHWiQ5/bLBA9/8fS7N2HP5BDDTaGyC200Gnznf9A3f5PS4ByPPp9wnDi86/DaeSLmh/DLpULf
	zPXYvBZIhhDOifzBfAasL7I5ovM2IO2qmJoS7zShzxDDDtraM16W35Cc4h/5RDrpFvSLFW2LeZb
	fTyXgBeSX7EyNYf6aY1BjSt+o7a4vspHxalXAL26BvXGbs+iT46FmvOFremg0B/gAyzI4XrTHn4
	NDGPlPEwPas1cfDy0Bjx7A2FJTzjuqggfk8ujPZsQN8mFg3AjQ9+OMHGnDLW3CiDddPD9Hwswyn
	A/rQ909cLqRRY0Hnk6dEgkt5hxeA5rs/0Eba8Sq2y1T7zcdjI4EYRUAkeZz6VBAmL4U/43sLgz+
	MGPFgWSeCCJrxsURgW1ZwQevclDg==
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr382690255e9.27.1793815739715;
        Wed, 04 Nov 2026 10:08:59 -0800 (PST)
X-Received: by 2002:a05:600c:3d05:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4ac187a6960mr382689845e9.27.1793815739327;
        Wed, 04 Nov 2026 10:08:59 -0800 (PST)
Received: from debian (2a01cb05923c9a00ac19e47fa8c3a9d7.ipv6.abo.wanadoo.fr. [2a01:cb05:923c:9a00:ac19:e47f:a8c3:a9d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm2041325e9.1.2026.11.04.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:08:57 -0800 (PST)
Date: Wed, 4 Nov 2026 19:08:55 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	jchapman@katalix.com, tparkin@katalix.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
Message-ID: <aut0txiHZnAZjad8@debian>
References: <20261030032617.4065353-1-hengyul@cs.unc.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030032617.4065353-1-hengyul@cs.unc.edu>

On Thu, Oct 29, 2026 at 11:26:17PM -0400, Hengyu Liang wrote:
> Commit 5f77c18ea556 ("l2tp: use IDR for all session lookups") made
> pppol2tp_connect() and the netlink session commands find sessions with
> l2tp_session_get(), passing the socket of the tunnel they name.
> 
> L2TPv3 session IDs are unique per network namespace, except that
> sessions carried over UDP are only unique per UDP socket, the socket of
> their tunnel. However, l2tp_v3_session_get() only checks the socket when
> another session has the same session ID. Otherwise it returns the
> session, whichever tunnel it belongs to. As of now, a session command
> that names the wrong tunnel acts on a session of another tunnel, and a
> PPPoL2TP socket for a second L2TPv3 tunnel fails with EEXIST, because it
> finds session 0 of the first tunnel.
> 
> The issue can be reproduced with:
> 
>     ip l2tp add tunnel tunnel_id 3 peer_tunnel_id 3 encap udp \
>         local 127.0.0.1 remote 127.0.0.1 udp_sport 5003 udp_dport 6003
>     ip l2tp add tunnel tunnel_id 4 peer_tunnel_id 4 encap udp \
>         local 127.0.0.1 remote 127.0.0.1 udp_sport 5004 udp_dport 6004
>     ip l2tp add session tunnel_id 3 session_id 7 peer_session_id 7
>     ip l2tp del session tunnel_id 4 session_id 7
>     ip l2tp show session
> 
> Before that commit, the delete fails with "No such device", and session
> 7 of tunnel 3 is still listed. After that commit, the delete succeeds,
> and session 7 of tunnel 3 is gone.
> 
> This patch will make l2tp_session_get() return NULL when the L2TPv3
> session it finds does not belong to the given socket. The receive path
> calls l2tp_v3_session_get() directly and is not changed.
> 

Acked-by: Guillaume Nault <gnault@redhat.com>

