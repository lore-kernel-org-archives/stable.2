Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594867;
	b=akdkMIQULk30VIa9MrVj/f8/Nrqn9iQtdyEIZxlIZp9xId+BnhUFe5JyLyvgW8whxIl+
	 qRNvRRs84aaIJsi7uCWZbWhFhQEhVm0tjcvZWtbdrdk97MOCfI6b4PEHztDNYaV2+ZtHV
	 KQTYa/gar8uZqhA+F9ayRTsTvMwmw9troDCgNTGrfsvwipwYCaiCEtnARKXT9zaqMrjWg
	 dHEE0SRGA05Vma3pN5rkvjd0tPTj08aLHbiTkkUJsjI5w5qwaAW+BM1E5uTb1Dh3dmIpR
	 Y5+fEtct2fcLdfgykS/c29oovJQy/czqpo3VkwhGtTDA0H7MnwIi3U7nEW7ThCrU8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594867;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zJPBRQPiHFcfBA13Lo3t3rJjzvO/5xG6cqVTkAXN8VA=;
	b=12dPiykE3pbtPaAma20v8Z9lHaP7c+JSZWC5xS9gy3tiNIqjtLe+23vugDV1I+iGGi3e
	 phY8Y3LPpqyKkKuWxQgh+BaQ+nDNHCzYEmf7KIXDc4IkdxUL6+5XmskexwT+jiRUKVpVA
	 zf5PjTSW1GwG97zt0dHATRVaD3CS+7cB//PDVDJ0DCePXDGzYXoEAu37gynNwUr/6Y9of
	 MFw1P4UAtsYB5LPo8RPGFFb0r2AHDhJUBoWuACOKZCjnLRi4WFQ/VEAuF4wD83d/CPU0/
	 JPVLNhw58O4M2aEJxbe1lHdLsIxbaiVf66opBALgmXOYoe7D4yPdZ/UVhVwvYKIDdZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O86CAjfC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=m7f2rGml;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D1606A328
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09D1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O86CAjfC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=m7f2rGml
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792594865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJPBRQPiHFcfBA13Lo3t3rJjzvO/5xG6cqVTkAXN8VA=;
	b=O86CAjfCbt/4QZ6ZFfu8GsBjlnqQNVNyA1XMMVKb5JHRuokyTWaGoOkxSV4QVBXH1oYqzH
	BfZ9UEGYEJmR0uSjgjbGDwZu/chc+1OkV4zZPUDsKC8XPw/763GZJzkNE8auH4gOXr574L
	XBdtvLCYE7m4ogdKYxFQPx/7V34JlVg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-q1ymLe5_P76V7RWj20Q-Yg-1; Wed, 21 Oct 2026 15:00:57 +0000
X-MC-Unique: q1ymLe5_P76V7RWj20Q-Yg-1
X-Mimecast-MFC-AGG-ID: q1ymLe5_P76V7RWj20Q-Yg_1792594857
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-836c416b236so12420237b3.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792594857; x=1793199657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zJPBRQPiHFcfBA13Lo3t3rJjzvO/5xG6cqVTkAXN8VA=;
        b=m7f2rGml43s8VfGPFbLWVCfVBsnFYsMQDuByaMQlxDyLJFFI3TZ2f/M3if+qH3HnT1
         7x1GPwxU9eqdZg9pxl6ITgw5LhD9werT1gBVHvpt27B/uOIJUdQiAei0j9JN6QX404PB
         YvRdYRKJ4fk2hSGQIp3Bk+e+mdwLJnd3YX/om9Rd3AUkPXsfCawrmAc9odWHCP5hpCeg
         1VMR5xUrccEa8Uqwx1Ma0eND/mohHNccI0QKFFoB/eM4QJ/xLy1P0obdqPSgx9z/0RKq
         CRL5NAIpdTe/vTJtSs3ffR9W27Qhv9JyNzn4soP/0J6g8NnkiX9f42u3RxneDbihs2AQ
         mBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792594857; x=1793199657;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJPBRQPiHFcfBA13Lo3t3rJjzvO/5xG6cqVTkAXN8VA=;
        b=PYxj+jxbPMho9N6s3+fu5JFANoqQtkKn5mDfT/GLRE/kOY/9FqxrfNWIGBT4NeAD+6
         2hkh32vjOSEGMjSSwi7rXVMXWEiAx+Ib6b9NjbyKlZUJgImoKUivbiCkIBM6RUdz5YsS
         B5NGZJgXN9KdtY8R3ad4LgxSmRqHoSfJocF12k60fU3ySTueBeIxiZeUqUgJTk2DWGP9
         3mBSofDmtnjOo/cVkorlfk8fX2CgVU9SvaebRP9EAju33Ry3rogCbfuK5iSElqk9OMOh
         pPMxoDF+ojbRn2OfcegJJi3hvgJXYfmnzrGODXzn0pF8IoaDJedvnU6F4L43yNG333tb
         OZtw==
X-Gm-Message-State: AFq9FYLiidTnhoql3mTAWiWCzzbJoo+b9x6cr9BTfeCDw+7DBullon4R
	J+UatqyPt7Nq1gHoXi1TWfEfFmI0hCOOVll+6tqkHLi9Tm2oPUnYcLRWvSCrfTjSCGemjAhIFeP
	tpaKwBmzZN6lYHoPu2TP3cGiVagZeNnwHMau3pTEE6exsryB5hAPvFoCBUQ==
X-Gm-Gg: AYBFou0Pf8ccUcKRDA4BpyKKHiTUBxb9KjjknwQ5GomWwLAc+zb6hfugK68FBdtQbEy
	d9P2dKI4p+IcAlGd+I6ubCsZZXYtg0Gl4I5JTEFMN3JDeTrKYXb538ozKWyAdWHDQFSeuv6wUjV
	BpCiob/sTYvBkGkLkGso0jMo1m9C++yOxQ3jMv4LjgD3cR9ofToS8+ELoA405oljC+Vev/eTWuw
	hpChASffL7NjPz/4HjJmjaY870Iht580sZSPUheov5PLMmThZmlWUc2XR2LezjCSyVTwUzPP8yF
	ghCx8cMKzxbZVERq0RwsaK9MQLTgNZrUhJY0xS8wZcj9rOb3SDZ/VzjPTAGx1n9xksjhRWCDBV9
	wCv91PKJsCrWQMECCa8xawrDpNVqb6RUGOOQ8
X-Received: by 2002:a05:690c:60c6:b0:8ac:927:f7ef with SMTP id 00721157ae682-8b13432ccdbmr10840607b3.57.1792594857102;
        Wed, 21 Oct 2026 08:00:57 -0700 (PDT)
X-Received: by 2002:a05:690c:60c6:b0:8ac:927:f7ef with SMTP id 00721157ae682-8b13432ccdbmr10839567b3.57.1792594855244;
        Wed, 21 Oct 2026 08:00:55 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b13012425asm12303197b3.32.2026.10.21.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:00:53 -0700 (PDT)
Message-ID: <3766e42e73b6e1d25ed43f1bfff6f911b4157fcd.camel@redhat.com>
Subject: Re: FAILED: patch "[PATCH] scsi: st: Fix use-after-free race
 between st_remove() and" failed to apply to 6.18-stable tree
From: Laurence Oberman <loberman@redhat.com>
To: gregkh@linuxfoundation.org, dingiso.kernel@gmail.com, mkp@kernel.org
Cc: stable@vger.kernel.org
Date: Wed, 21 Oct 2026 11:00:52 -0400
In-Reply-To: <2026102128-conjoined-uncoiled-3c92@gregkh>
References: <2026102128-conjoined-uncoiled-3c92@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-21 at 16:44 +0200, gregkh@linuxfoundation.org wrote:
>=20
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git
> commit
> id to <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following
> commands:
>=20
> git fetch
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=C2=A0li=
n
> ux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 71caf7f84bd62a4bf91cc95abd2de690afb8d15f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> '2026102128-conjoined-uncoiled-3c92@gregkh' --subject-prefix 'PATCH
> 6.18.y' 'HEAD^..'
>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 71caf7f84bd62a4bf91cc95abd2de690afb8d15f Mon Sep 17 00:00:00
> 2001
> From: Laurence Oberman <loberman@redhat.com>
> Date: Tue, 13 Oct 2026 16:25:48 -0400
> Subject: [PATCH] scsi: st: Fix use-after-free race between
> st_remove() and
> =C2=A0st_open()
>=20
> st_remove() drops the probe reference on the scsi_tape with
> kref_put()
> and only afterwards removes its index from st_index_idr. If that was
> the
> last reference, scsi_tape_release() frees the structure while it is
> still published in the idr.
>=20
> scsi_tape_get(), called from st_open(), looks up the tape in
> st_index_idr and takes a reference under st_ref_mutex and
> st_index_lock. remove_cdevs() does not wait for opens that are
> already
> past chrdev_open(), so an open that is blocked on st_ref_mutex while
> st_remove() holds it can take the mutex as soon as st_remove() drops
> it,
> find the freed tpnt in the idr and call kref_get() on it:
>=20
> =C2=A0 BUG: KASAN: slab-use-after-free in st_open
> =C2=A0 Write of size 4 ...
> =C2=A0=C2=A0 st_open (drivers/scsi/st.c:254 drivers/scsi/st.c:1291)
> =C2=A0=C2=A0 chrdev_open
> =C2=A0 ...
> =C2=A0 Freed by task ...:
> =C2=A0=C2=A0 kfree
> =C2=A0=C2=A0 st_remove (drivers/scsi/st.c:4512)
>=20
> Remove the index from the idr before dropping the reference, all
> under
> st_ref_mutex. A concurrent scsi_tape_get() now either runs first and
> holds a valid reference that keeps the tape alive, or runs afterwards
> and finds nothing, so st_open() fails with -ENXIO.
>=20
> This restores the ordering st_remove() had before the conversion to
> st_index_idr, where the tape was unpublished from scsi_tapes[] before
> the final kref_put().
>=20
> Fixes: 6c648d95a6af ("[SCSI] st: get rid of scsi_tapes array")
> Cc: stable@vger.kernel.org
> Reported-by: Dingisoul <dingiso.kernel@gmail.com>
> Closes:
> https://lore.kernel.org/linux-scsi/20261007211520.1428497-1-dingiso.kerne=
l@gmail.com/
> Tested-by: Dingisoul <dingiso.kernel@gmail.com>
> Signed-off-by: Laurence Oberman <loberman@redhat.com>
> Link:
> https://patch.msgid.link/20261013202548.249628-1-loberman@redhat.com
> Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
>=20
> diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
> index cab8aa73969c..a757646c8dc6 100644
> --- a/drivers/scsi/st.c
> +++ b/drivers/scsi/st.c
> @@ -4515,11 +4515,11 @@ static void st_remove(struct scsi_device
> *SDp)
> =C2=A0	remove_cdevs(tpnt);
> =C2=A0
> =C2=A0	mutex_lock(&st_ref_mutex);
> -	kref_put(&tpnt->kref, scsi_tape_release);
> -	mutex_unlock(&st_ref_mutex);
> =C2=A0	spin_lock(&st_index_lock);
> =C2=A0	idr_remove(&st_index_idr, index);
> =C2=A0	spin_unlock(&st_index_lock);
> +	kref_put(&tpnt->kref, scsi_tape_release);
> +	mutex_unlock(&st_ref_mutex);
> =C2=A0}
> =C2=A0
> =C2=A0/**

Thanks Greg,=20

I see the issue so I will send fixes for each one in turn:

upstream converted st to the new scsi_driver probe/remove callbacks
after 6.18. Upstream=E2=80=99s st_remove() is void st_remove(struct scsi_de=
vice
*SDp) and ends at }.=20
In 6.18 and earlier it=E2=80=99s still int st_remove(struct device *dev) an=
d
ends with return 0; The hunk=E2=80=99s trailing context doesn=E2=80=99t mat=
ch, so the
cherry-pick conflicts. The fix itself is identical: unpublish from the
idr before the final kref_put(), all under st_ref_mutex.


