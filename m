Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652105;
	b=Sg3jh6D+RPt1UGfj4TsOkJw3WUifp+XnSplwPZTSZezaCm/L3qohoh0TboooP2zpxneA
	 DNjIWQ1N4KzVG68GQY8V4rsWq2Q+m24jLB6vkSR8rfy/oytVDkuJBhBcEmTLpf5h4mHwa
	 S8vt4a4lbv5DA3dsQvqvc6eZiQCimhxQY6HSmrRD0AyXMYgYpFyQJm1BkedoK2MAkub6r
	 NLhVTiX1xHjx2zCgzpLzoDzEx1Z1UmgJRTeW9lPl903owUnkk9agGU0YE1gupOSFyGc22
	 nzPOSvaftWJrt9McEJwIGsIX19Wli7K2E+wICSyw7RbIoJRpvWQ4e7n9szUH36btdPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652105;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
	b=VeKnWKm1zA3rQ4n4J7FL0yNFO1b6O1he9p5Jw/sLnXzRnV55PnFqK3SVUTUfBCayjv+p
	 VyrJ4uOrizeJspJ9Ae5+al6y6XWSFzuqgHouVJlwwbFuLnfdHV3vzZkMkZ4502leH2Tk1
	 1w0BdE6JIRvRFoZZrLOWpMO1Wch3LMQgm/MYVexpHw3run/4HOBfcYA2e/DatYfyqGUc6
	 5Ucvdv6cv70413rw6qw+6SDCE3P8ixjXVFs6Bf+OUywUzYt3NAeEh9J9nLskGYU/VCKlh
	 IyxyGjvl6zDDZbPx9uQMPLlsFQuEWdrb+0qbcFWx0MQux34CSz3HjNtRo7xejtQK7TQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8O7AQDL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I0QEdoie;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C6606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 20:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD8C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U8O7AQDL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=I0QEdoie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
	b=U8O7AQDLY1PpUkWVWskOBsLg2fzmrCtvfpJb3eR8vu7Wc2nQJAvFdN3u4wJH7zLTaqvBcK
	w5fssyXVrFLH4tzRUfQhMrJqjrjuri/3eOtGKQlV/f5eBPNnMjbIYnNe+8+emYdolRlbKB
	1x/fuwwfoEmzGcaqky3q7T74/z+YdQo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-6qrv0DYmOL6MBfkto_Hlww-1; Mon, 02 Nov 2026 15:41:41 -0500
X-MC-Unique: 6qrv0DYmOL6MBfkto_Hlww-1
X-Mimecast-MFC-AGG-ID: 6qrv0DYmOL6MBfkto_Hlww_1793652100
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ab3650ca2cso16438021fa.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 12:41:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793652100; cv=none;
        d=google.com; s=arc-20260327;
        b=ZcYnWPY7gK3BDumiCmh3q9qHKH1fkIuxhaHqKKmyc7+lFxCiwSGQ0Ujn7K5glKNPuT
         6t4XMhDuCTGE5sj0l15ukkwzZ8qL17gT5UEGqcFpFkDNcI0x5iW9JUe6XkF8fMxgBx53
         fcTMagTLQAkW3XraQ9djRxpd9XJq4lXPEFQI0vUtV11knSZ6skWjVqiLd7MIdkPOEmLT
         rhJxWlaaGiQroXGWiaGUXWgn+F5Se0bLdenyB4ZpM44onQdQcUo4xehhH0mMXrolysUs
         2WyUO2u64HAPb4LCNmHkhds6q5wYVrKTFnottWxzQsf+D4fHlakCrN7mZSTbDGkmhTul
         sVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
        fh=weEHb24SV+RA1M0h/t3eI0QzKCwIEPa5oC2pL3yo5zw=;
        b=B2J/T5FgWscFSjaKU3vkc2Hkt5ux2r7TboE5lhkW1MQUJ41IA/wWSQxcfBuw0cHUAs
         JmC3rmaIQwyrzLyAdLO3rGqXGxPxZFIsNuqQXTwU0/5NOnDz8fMfA/xt8cROnshpvDP9
         sgbxwPlFKObCbTcEyKp8gR0ky6cJP3YTL1U2gRaTRRDUJtz52+cpVBHUTfzoZxH0qrjW
         KCn4umqtACvRsg0gHvY739VKDnxnEhGf/5VADl0WAfLz/UFT23XbrfI9Dv9T21kaZkLm
         AAJ1KcxU3TtWZsrIcBlcsjV9wjpEbbIrD+SoEp29CRBwFu4XOtqon89P6ZB358FJPJQW
         7bbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793652100; x=1794256900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
        b=I0QEdoieReXcyzBFfRr31Q22SKhdziBS0h3aw+J9hX7hC2wQIuXQoAASYo6Pn/h9xL
         JrvtgpGbE/QDxfhgFBt8LjfmjP9b74uzjvY0tVDuRH7y0Jh66tGcDn6GmJLrUxsJMEcq
         jeWl1ecAjlUzfD0K23v23uQSPLCWPz9OGLCI9W1Hanqc2jaeMl8nX0NHnkZiVgsH7yYM
         po5XTTJtQfw4Zlxc79dZEnR483/5pS9QLqAlAoV2U293OnVf0K2l+7OCiqXJKgwLpzy2
         gb1LQ3q9AfGoymnN6ps5gAZgeu3BVD0zCB2Jiiy5BmAbFSk86kfqEFQyNx9rweXbmlfd
         1HBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652100; x=1794256900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pPfuhXuKj4uxJtVgdwO0y4Sg1BoFJPH2OXHo0IrP7P0=;
        b=gxl05wxLsBC7vsDeQMShMdGvXA6pKPklpbnGKS5TrmSFX4hHcGpD2Rxiqgo/BAbSRr
         757KUbiwzo8W8S3VWfXxwzUUv+9AoBznWP4rlqWQGKARq/PsZ5YzRRpDlMl62As/ypFD
         /1MWX/LDl6y1+XQXwMOCbu2mVTaO3OOeiv7Hok5yNG4OTDmf1PESmqlAkYmvnpKC64er
         nfiQF/BRI5cQnjQLHhrxEFwgAHSUwt+DRMwmEL4jPJ3zwzaSVFMD6q+mjadKbrKGKPa6
         1MttKdyw71UsuBBvlXHr/7uoJoKYqszSPz12PvT1PYF4cKK+rfR4kVdzjdOXSlasA1L6
         gH+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxsJVtQAl/QDATKUZnKl601CzyV+CDiQLDpfb14w0qOTX3DJc+a9YjDStcgYHMD8+yaMyG2t84=@vger.kernel.org
X-Gm-Message-State: APuU4Z82TBaWR7xrZIZ7lHyK005qV59Ey1SVzSJE04nTesk9+N99Sv81
	FssfmaAjKccEeCTugmAmSg2zRoShX9HgmZo+PB/0GDgHV0bjP4WVVejTdUlg3TqH2HoviXL8y2M
	foXgCd+sfnmMrX9bSbthFz4zZp5zPcl93868T+GncnepEg5+kfSnpFj3h0Sohu7WUbvMw+ojgtL
	Mz7BqsUmqtNigSEsZpXAMYtN/PLlKCBuA2NhVxFr3Tqqg=
X-Gm-Gg: AYBFou3O8ppnHFs0QQEgkhmM3cBnnJX516KAQ5OmSJOt6FIHOAo0Ib+vZPGjSzpVHvf
	aNwilGKmnYTNQoM+R89nhnlibf78X786Q2S5Omf0fi+vehJy2gFVEZ/L7con4q8cidAVHkLH3Af
	wNnxNGwRmgZ8G12kd4wtQhWBWsTdpvpWCUh9O/2VSxyV0LCChmC5pCE8eW
X-Received: by 2002:a05:651c:150a:b0:3a9:8167:62a with SMTP id 38308e7fff4ca-3acb7b6498emr30604701fa.28.1793652099949;
        Mon, 02 Nov 2026 12:41:39 -0800 (PST)
X-Received: by 2002:a05:651c:150a:b0:3a9:8167:62a with SMTP id
 38308e7fff4ca-3acb7b6498emr30604611fa.28.1793652099559; Mon, 02 Nov 2026
 12:41:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019184849.24422-1-sanan.hasanou@gmail.com>
In-Reply-To: <20261019184849.24422-1-sanan.hasanou@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:41:27 -0500
X-Gm-Features: AclHuK8WVNVvU2rcm4KZuGFkSSfZ2u0smM4kgrswPda8flMMQv9IN77de7FcSJo
Message-ID: <CAK-6q+gvq=y+P+wmUTGWJcNRLP1Hjw_W=i_rwuvVhpS0d+h6Og@mail.gmail.com>
Subject: Re: [PATCH] dlm: don't put an uninitialized lockspace kobject on error
To: Sanan Hasanov <sanan.hasanou@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com, 
	Sanan Hasanov <sanan.hasanov@ucf.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 19, 2026 at 2:49=E2=80=AFPM Sanan Hasanov <sanan.hasanou@gmail.=
com> wrote:
>
> From: Sanan Hasanov <sanan.hasanov@ucf.edu>
>
> Commit 8a4cf500f1dd ("dlm: drop kobject release callback handling")
> dropped the do_unreg flag from new_lockspace() and made the out_lsfree
> error label call kobject_put(&ls->ls_kobj) unconditionally. But ls_kobj
> is only initialized by kobject_init_and_add() after the callback
> workqueue and dlm_recoverd have been started, so every failure before
> that point puts a kobject that was never initialized:
>
>   dlm: ls_6035_1: can't start dlm_callback -12
>   kobject: '(null)' (ffff888027a28088): is not initialized, yet kobject_p=
ut() is being called.
>   WARNING: lib/kobject.c:736 at kobject_put+0x66/0x550 lib/kobject.c:734
>   Call Trace:
>    new_lockspace fs/dlm/lockspace.c:617 [inline]
>    __dlm_new_lockspace+0x1714/0x1cd0 fs/dlm/lockspace.c:638
>    device_create_lockspace+0xc7/0x350 fs/dlm/user.c:414
>    device_write+0x872/0xed0 fs/dlm/user.c:606
>    vfs_write+0x296/0xba0 fs/read_write.c:685
>
> syzbot hits this by sending SIGKILL to a task creating a lockspace
> through /dev/dlm-control, so that alloc_ordered_workqueue() in
> dlm_callback_start() fails to create its rescuer thread. The same
> happens if rhashtable_init(), the ls_recover_buf allocation or
> dlm_recoverd_start() fail.
>
> Bring the flag back so the kobject is only put once
> kobject_init_and_add() has been called. Since the kobject no longer
> frees the lockspace, kfree(ls) still runs on every error path.
>
> Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")
> Reported-by: syzbot+b2b8d04ec4914f618d23@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db2b8d04ec4914f618d23
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

This patch conflicts with another patch that is probably not going
through the dlm tree. It will not fix this issue [0]

I think it's best to wait and queue your fix until it's through, and
then we can rebase your patch.

- Alex

[0] https://lore.kernel.org/gfs2/20261027223847.652884-6-irogers@google.com=
/

