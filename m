Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795140444;
	b=VKumVVLxSPCRHeEoxlmPlFfDXiaqiG8BTJCnsIUQxwK7LMUA6+m6mM2/spr7T6BFrjw1
	 lWUOXkbasDBMTPEKZXUBg/oXy/Ha3ZakjCRyBvQ2AXAU8TBel9sYsueeYC7ARiQbqvKoL
	 0qR+WNwtQmUXOJxy1FlVZTSuZYyFCg54SmdJ7P8Sv1bDil+cbSvkyJpPQuG1zjbkeSo3f
	 ZH/gkm/x5UxmIGCZ/YhqjEbWcOLzxzXltMOUjH5HV3oajI9G0rzUxoBQC0ZyaL8aiA5W7
	 HQ3fwbr2jEi7EtW3w9WM0IAWlYsWJxiJE1TtdsLqUqQhOpMhfVP6Bop5T/A7iBG0KVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
	b=VVZ0nCJ8GpgTgW3biRqIf5xtGloeRhuxdiHjhUTlxC63JWtqd3oNWXpTwqGKEzb12Tl8
	 LhMvB222G+yM+d2KYNmVjSdo2pyY1rwrnk7dsDwTV7YD8bMBCvlqSr13KnXdbZdhLuKMX
	 rX+BoPFUQr//nrfmTBhXTk8St9n12nVSCvEYuUWOiSeqWEG3WXvEDCY7ofistlenpqMAK
	 7/BRIQkJet3W5K8zPHhUmwb+HhFklu7mBX0kcYltvahcGixkmAeKsvtM/JNZMvpQ+SeAE
	 v/sqSfSQeDgO3Tn4hNGoIE4CJ7ptjbwiK5ScZAHO/bOsUcUvFcWuWofgwGtkDPRQk9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zr8fkb5i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D6606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 924D6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zr8fkb5i
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92123f02faeso2933386d6.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 18:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795140442; cv=none;
        d=google.com; s=arc-20260327;
        b=PqLzgSZz4SIhSzMhysH9actVtPbHetcriGHcT7Iea6/98RZMjJbg5n3IHUmBlgxE8y
         toJkOtMj16++EFNgt7A18DQwQkvQAjl9oY/mTjesLSV5nLxT4WySev2DwDPyCZZzAMuh
         +4D1f7NAKtMsxf5jz+CF2gLNgi09zSXf3fq1Z1p5rloNM+h8FFPSZHcSBY2TR8J7/5rz
         bxhBKfSpljXPib5AHUGbWnY6j1AuP9gpefnpaREMLbz4umius4uhSev1+ZmJ9Lh4Lsw7
         QH68imRWnB3OJ4gltIN5Rr/6x4KaVxNZkF02cMwqAkkpcKEe02sTZi2Y0lkg1iAZgsQ1
         aTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
        fh=6yquyI+QS6Kw6t4FnFrq4LGXW+Chc4TMG9h4qxFqRRM=;
        b=aBPWpUF8D17ZL5m+iWcBQ8IhpEeI5zNafzyk1AvPbRO23+mPFJkhNRGM0+6aBv9QJ0
         e8ROocIonY3nyAHHeJyGwGIgv+hQCo9jyG9wNbumTQQCtJicHo43nvVvRjZgOdcDrT4K
         7oiQPLn8hG7Zmp/GLvbkmdfFmfIWm+TwW6UfTZdCC2FY4xhVBQXxxqWmHkG2ETBvZAfZ
         XiTcvfgYcnPeS17cfxFqUZ504bXm+HgiaBXH+48PFFfC47Wsl7MHWPp4nd0kixkPc6bG
         oyerd6RBgfafNfG8ff3ZI53kWYwGz+f+o/VPfHUebbkqG5OFFTzCEZrMM3tTCobPoeKa
         MQMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795140442; x=1795745242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
        b=zr8fkb5iFA5tOJKD9Rew/fwEuZfwcr9/wKTLaYKfTTh0zX5puG9AMdSy4nbvreen8f
         PZF9j8+mXU0kJLn+dFvSPZfAAjrhr9R5xC1v+ezAYo+zc56GgxP4+kr0jG+/VTTeP0jQ
         Mv3mP7HEzX86vYpUnoe5pM2UYL4juFbShSXgY00xGI9B9Ws8044ZhnGF2arKdYoBnTK6
         8OwAANa61uOQv862Ofu4zX6lhsUpr0mE8dhIiUu4fhULv6cY+uiKMiRNC/Cm84Y2BtyP
         N7YT8MgnsWJuRUqTv9Kdni+uEs7w4UnmHzqu1LsUxqqvF+l2TK5kPXphpSb0Iu/6NVSF
         exYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795140442; x=1795745242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDx+3ef29Cqeb19P1wrP4Jxu4NbJSoAn5O0Zy1TjVKI=;
        b=ONu2oqAov8NNNn5bVjeRkAdLNfEA40FtEmE61hb1WTIzwvSzIjH4kLgAfP6G1VbZ4L
         4H2A7QG/e65dA/sTxV/dlgQI+hDni2QyDekEtSKa5QfUMy+7UsIIWUrKXBc4vspA17i8
         C9k2Zo3p1UQ4+H3gllt/Muye/qASNFDxtTAoHiya7UCKU6L5ld5XLl3c4rk2O+LdNbQQ
         N9NFo8YszFcb/bJgRSkYGWG+W9EdT1AoTx4/ZZMGjM8BSdXp7NwB2frE3eWOKH/PXzYc
         rYYI6Dl5uhQ8nqyCfQ8JbnvoS/PLrVKEJxtDpYcw7VWyEuVnJY6+Pc2jMp4/aFv+Vjc2
         6Jtw==
X-Forwarded-Encrypted: i=1; AL+hErFNLIY8x42sakv7XPTw4CLxkoVcgI3lA7t1wWL2nMp6HPnrrAcCTOpjO5HojHCKaSFvLgUE0vY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zevgzM7b29AJ9Xo9TWFlfvW5itN3IbshEs6VyzwMRJV63oBe0
	SS0aAh6r2DJb3tGqafyhzxrxkTKehXzF/1cT7qClVTK56hozi05fDZMzVTsIpUEnIeBu7c3kKwR
	TGP10idnyNGe6j/4I0tOqVFlDdfM4a4c=
X-Gm-Gg: AZFdTZfyE8aGONE9BEXQ9MQ5/Kk7OpGo5X4qJSE/WkQdDi1o2Fip8PK0xeraOaZSGKc
	xUDg2ILJCRCn8N5iyQwYAL+maOFNpMsG/p4V2lkya7OOZxk5RYvnlhzGLJRPBAvVnTi3v7Jtjwp
	v8O3hOPMHjA2JBH12AKAxI+Q6IrgHOr9BR1CjgNEiWHbFJjJ6tTkcQESRnGSY9njaRk5qu2KzaY
	SDQjIF6zORLBFeba4EoZur81mAGYneIfod3SdbH9CJ14QVFt7nLQAsAaGSXsuAzB1y20mVfhJhy
	0jbpYUDz9rpPyhB05RBHb0owkmdGnSX3C43tSWp1z1gcqrya8yFuATjWZKnUqgVbyEFV7G8qhmO
	8Ak6aT7VYMxCUA6Hy/utY5BZy9iU6xLtQG+1piPEoL3T2I3eldpCZGET9iWKdbAJlqTnUvBsfny
	Jqdx1Fdi3GhrsAMcgA8A==
X-Received: by 2002:a05:6214:8605:b0:91f:808:3ca3 with SMTP id
 6a1803df08f44-9213497c81fmr31805746d6.1.1795140442286; Thu, 19 Nov 2026
 18:07:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMcAce-ytH2Xt_0+1fKXzxy+a8fi0Md-4SSoLZ1RQxKQoLq-tw@mail.gmail.com>
 <av9Wm6HQ-DIgFhfw@krava>
In-Reply-To: <av9Wm6HQ-DIgFhfw@krava>
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 21:07:10 -0500
X-Gm-Features: Aa3M54pd38stwrQ1r38JPH4RJjMwQ2y84tlYNALUI9495C_JMN3Wxjb92Ofc62I
Message-ID: <CAMcAce-LRjmaKoQcsvkU4L+JHWfoGNKx8xFsxiwEADcgQ1m6dA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Replace DECLARE_EVENT_CLASS names in raw_tp_null_args[]
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, anna@kernel.org, 
	linux-nfs@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review and corrections, Jiri.

Dropping patches 2 and 3 as requested.

(Note: Patch 1 [bpf_lsm_release_secctx] was re-submitted as a
standalone v3 and has passed CI.)

Thanks,
Yingke

Jiri Olsa <olsajiri@gmail.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=8819=E6=97=A5=
=E5=91=A8=E5=9B=9B 15:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Nov 19, 2026 at 02:18:29AM -0500, Yingke Xiao wrote:
> > btf_ctx_access() strips the "btf_trace_" prefix from attach_btf_id
> > and matches tname with strcmp(tname, raw_tp_null_args[i].func). Because
> > each attachable tracepoint typedef corresponds to a DEFINE_EVENT() name
> > rather than its DECLARE_EVENT_CLASS() template, three existing entries
> > in raw_tp_null_args[] never match any program:
> >
> >   1. "nfs4_inode_callback_event" and "nfs4_inode_stateid_callback_event=
"
> >      are DECLARE_EVENT_CLASS templates in fs/nfs/nfs4trace.h whose
> >      DEFINE_EVENT instances are nfs4_cb_getattr (:1455) and
> >      nfs4_cb_recall (:1518). fs/nfs/callback_proc.c:50,106 pass literal
> >      NULL for arg 2 (const struct inode *inode), and TP_fast_assign
> >      (:1424, :1481) checks !IS_ERR_OR_NULL(inode). Keeping 0x200
> >      (0x2ULL << (2 * 4)) sets ptr_err_raw_tp =3D true so btf_ctx_access=
()
> >      assigns SCALAR_VALUE to ctx[2], rejecting any pointer dereference
> >      even under if (inode) and matching existing raw_tp_null_args[]
> >      0x2-nibble convention (0x300 yields the identical SCALAR_VALUE).
> >
> >   2. "iptfs_ingress_postq_event" is the DECLARE_EVENT_CLASS template in
> >      net/xfrm/trace_iptfs.h:108 whose DEFINE_EVENT instances (:130-148)
> >      are iptfs_first_dequeue, iptfs_first_fragmenting,
> >      iptfs_first_final_fragment, and iptfs_first_toobig.
> >      net/xfrm/xfrm_iptfs.c:2025 and :2051 pass literal NULL for arg 3
> >      (struct iphdr *iph), requiring mask 0x1000 (PTR_MAYBE_NULL).
> >
> > Replace these dead template names with their DEFINE_EVENT tracepoints.
> > Verified in QEMU on x86_64 7.4.0-rc3 (iptfs_first_{fragmenting,
> > final_fragment} and nfs4_cb_{getattr,recall} flip from LOADED to
> > REJECTED) and 6.12.118 (nfs4_cb_{getattr,recall} flip from LOADED to
> > REJECTED; iptfs_first_* absent in 6.12).
> >
> > Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> > Cc: stable@vger.kernel.org # 6.12+ (nfs4_cb_*)
> > Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
> > ---
> > v1 -> v2:
> >   - Correct sender identity and Signed-off-by with real legal name per =
DCO.
> >   - Remove drafting notes.
> >   - No functional code changes.
> >
> >  kernel/bpf/btf.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
>
> patch is mangled/broken, can't apply it (check Documentation/process/emai=
l-clients.rst)
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index a123456..b234567 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6605,10 +6605,13 @@ static const struct bpf_raw_tp_null_args
> > raw_tp_null_args[] =3D {
> >   { "bcache_journal_entry_close", 0x20 },
> >   { "bch2_journal_entry_close", 0x20 },
> >   { "fsnotify_bump_event_seq", 0x20 },
> > - { "nfs4_inode_callback_event", 0x200 },
> > - { "nfs4_inode_stateid_callback_event", 0x200 },
> > + { "nfs4_cb_getattr", 0x200 },
> > + { "nfs4_cb_recall", 0x200 },
>
> seems correct
>
> >   { "nilfs2_transaction_entry", 0x4 },
> > - { "iptfs_ingress_postq_event", 0x1000 },
> > + { "iptfs_first_dequeue", 0x1000 },
> > + { "iptfs_first_fragmenting", 0x1000 },
> > + { "iptfs_first_final_fragment", 0x1000 },
> > + { "iptfs_first_toobig", 0x1000 },
>
> llm says:
>
>   =E2=96=8E Only iptfs_first_fragmenting and iptfs_first_final_fragment p=
ass NULL
>   =E2=96=8E for iph (net/xfrm/xfrm_iptfs.c:2024, :2050). iptfs_first_dequ=
eue and
>   =E2=96=8E iptfs_first_toobig always pass ip_hdr(skb). Since the old cla=
ss entry
>   =E2=96=8E never matched, adding those two would start rejecting existin=
g
>   =E2=96=8E programs that use iph without a NULL check, even though it ca=
n't be
>   =E2=96=8E NULL there. Should we add only the two NULL-passing events?
>
> jirka
>
> >  };
> >
> >  static bool is_raw_tp_null_arg(const struct bpf_raw_tp_null_args *entr=
y,
> > --
> > 2.43.0
> >
