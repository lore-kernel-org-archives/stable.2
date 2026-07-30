Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D8474254
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453386; cv=none; b=osmlo3vPQTfbqhMrImWDJvBgW+S6LQfsxTTvB6xXdCJ6twiraK5aqs3lc0ZxnvsI0rGO3s2XrfBPpmO7QO0KZbNNbDX1riwKU+o21p2WbVG/gLwceTA+FGXU7uzO6V6ql/XyYx8QZ/3YBc3m726XyyqJCZ5e6WBQARQUE10swco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453386; c=relaxed/simple;
	bh=vdDilREIQkWyNWDuUVUGv/cUJftcDllg7HniWzilOww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um2Iu5KNwuRzis0ha92/ih2pZfprOp1S6eXm4FvB9BBjrauV8PM1blSY4v6OugegjYCb0t3e7WYPuLxy7r6V+6q2AWdkHComcqZDSNNSMj92JNDEHZvmjXyPMsoQ5iabD36StuBoZmHhXOmHCwLGWMZzP9OkD3KRt1C6b1rGEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl2Of7UL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGZIoQlO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl2Of7UL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGZIoQlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785453382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8yAw7ik372Lru0nsvR+LmzgLPiBZxHuzz4G7w5B2VIg=;
	b=Cl2Of7ULUGkpzGX/KDDlaw2RTZRpV60EZ4z8db+PqadsCUyVoSPEnel6k0p/A/XWPuADM7
	rLnNMSvXvcFB7L1Rl5J4VBDvZWZ0s9C+5l/OtTYNXz6OftnXuC+KdbjPAOCkZiTCbEmv1u
	3Knn78IjgSJH+1wHZ+0IufuPq14c9AU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-SoVjiEF-PEqfLKxYxEI3SQ-1; Thu, 30 Jul 2026 19:16:21 -0400
X-MC-Unique: SoVjiEF-PEqfLKxYxEI3SQ-1
X-Mimecast-MFC-AGG-ID: SoVjiEF-PEqfLKxYxEI3SQ_1785453380
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49545071724so2548215e9.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785453380; x=1786058180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8yAw7ik372Lru0nsvR+LmzgLPiBZxHuzz4G7w5B2VIg=;
        b=cGZIoQlOYiloB5cG/ZOKNqwz231jYzRBcEfDIgK+06tzx+x/tXktVeekCHVQp6nZV1
         ix1ziKRznQfD8EvGkYuMfYG137vTI2a7ojKFeVZvJEFmZzvWfxS2zAVN9dvzpKH40iaV
         iN2otd/9XCwxlf6B6invTZC0t7OzBlspRIyp7uedLOa0ozHH01nrDacv7PaCiIQsPhWK
         9XT812UmK+0O68vmHEe/0cMw0W+TDKVqixBmZLED5eXLZOLESL58iDAzVHo0OiUenQ31
         vFvy+cn9iXjOorYnseGHxZmgvov5mR8tPfcuay4I1pRUokoe4NZlIq8+a8E5pww9oJp9
         16DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785453380; x=1786058180;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8yAw7ik372Lru0nsvR+LmzgLPiBZxHuzz4G7w5B2VIg=;
        b=KzDiQjT4kV09sAxWJC/N8LTL8wwU+3244xOGdi4C45pbI74NEJqlz/9woQBtFfcq8j
         V4drG/OIKJ7mKoFpnmVxp9I23L62+Scg/WzvIzY39A0KgFtsP5Du0ZdmYbJ17Jws8/PM
         BJlIuX6Xkl04RQDE/g60dxhGKRI2/UWnrEqaRG0oyK60J1QFwQaFW91izEnO+morwuxP
         f/7w2tNoOlMZ46BEMujB91IS2dWLrBxVbA1mX4KCJDIDtup+sdrfPSfDPnuEUW+AoCd8
         pk56ubPsX2jR8Dx6n+V4CMXyEAGDKOYbEmY0EdhSrDBu7ro5IV9c4ycU8mO5YSlTkmdz
         u65A==
X-Forwarded-Encrypted: i=1; AHgh+Rpj5ZfNx59K6+3HdRNcfk+jm4VNONAofGXmBKj2ZU8K2d70YEDxyHblfmAGvrzIoQSXVafeAtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCGN8GMGNDJCrSTUIDQzUCiEOQyaNtIgq1Qoa1FKKPjMZRWEw
	BMQH5HPJNi3z7xdERAnTUPQDanz8SOofN1rIluSVEXsdsm6IELiGGu66IjAvufb32CDRxZSrOVZ
	9yDkDvsgqbiOodcGBR+N+5yfHsPqlxyyDtgQKDhtGnlUrUPdN6OzL6othCQ==
X-Gm-Gg: AR+sD10+n0nd75/lS+NqBQJY9OYjwhIvWEDtv2lksRwiLK5c5m9v7074xSYHe5L0roE
	rEOWrx4TCy5YOAA3bjOLZsKmc2EjFveOLZLaUq1l+3kpo2B8K6GFq+AMHwIHsIGe+Y4In5rPw9W
	4f4WrbhAUd7mYe/uafbTXt+E9u6x+LUDA/ic2VHu3SaCHWPGNMjLFnAwQo1AMZZbgIHLIIVI2Om
	LdE7jck3+HsnTlD4P5lLorqW+S+ZYeWHWGMfcbAbWw0sxkBZS2mxZaxi0H/aKzy50yq5+1EoRBk
	opSLvkZ78PbvnYo9IBLIwNghMR8ayh2/zSBDU2lIiVw/ttZ43v0cDhk6V2//dpFGuMZf7Q+clKP
	db5y+l0IqwmYPzLawDDJWc3E=
X-Received: by 2002:a05:600c:4fcc:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-49800ea1af7mr70153155e9.22.1785453380251;
        Thu, 30 Jul 2026 16:16:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4fcc:b0:493:c773:c3f4 with SMTP id 5b1f17b1804b1-49800ea1af7mr70152805e9.22.1785453379879;
        Thu, 30 Jul 2026 16:16:19 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f2b45sm96071395e9.4.2026.07.30.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:16:19 -0700 (PDT)
Date: Thu, 30 Jul 2026 19:16:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Haoxiang Li <haoxiang_li2024@163.com>, marcel@holtmann.org,
	luiz.dentz@gmail.com, yangyingliang@huawei.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: virtio_bt: fix cleanup paths
Message-ID: <20260730191555-mutt-send-email-mst@kernel.org>
References: <20260625020159.3446736-1-haoxiang_li2024@163.com>
 <ajzhfEu761GXHlqQ@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajzhfEu761GXHlqQ@stanley.mountain>

On Thu, Jun 25, 2026 at 11:06:20AM +0300, Dan Carpenter wrote:
> On Thu, Jun 25, 2026 at 10:01:59AM +0800, Haoxiang Li wrote:
> > virtbt_probe() registers the HCI device before opening the virtio
> > Bluetooth device. If virtbt_open_vdev() fails, the error path frees
> > the HCI device without unregistering it first. The probe error paths
> > also leak the virtio_bluetooth structure after it has been allocated.
> > 
> > Rework the probe error handling into an unwind ladder so each failure
> > path releases the resources acquired earlier. Also close the virtio
> > device before unregistering the HCI device in virtbt_remove(), matching
> > the cleanup order used by the probe failure path.
> > 
> > Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
> > Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> > ---
> > Changes in v2:
> >  - Rework virtbt_probe() error paths into an unwind ladder.
> >  - Free vbt on probe failures.
> >  - Reset the virtio device and unregister the HCI device before freeing it
> >    when virtbt_open_vdev() fails.
> >  - Close the virtio device before unregistering the HCI device in remove().
> > 
> >    Thanks Dan for the suggestions. The blog is very helpful.
> > ---
> >  drivers/bluetooth/virtio_bt.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> > index 140ab55c9fc5..4ca9b76f6410 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -311,12 +311,12 @@ static int virtbt_probe(struct virtio_device *vdev)
> >  
> >  	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
> >  	if (err)
> > -		return err;
> > +		goto err_free_vbt;
> >  
> >  	hdev = hci_alloc_dev();
> >  	if (!hdev) {
> >  		err = -ENOMEM;
> > -		goto failed;
> > +		goto err_del_vqs;
> >  	}
> >  
> >  	vbt->hdev = hdev;
> > @@ -383,23 +383,28 @@ static int virtbt_probe(struct virtio_device *vdev)
> >  	if (virtio_has_feature(vdev, VIRTIO_BT_F_AOSP_EXT))
> >  		hci_set_aosp_capable(hdev);
> >  
> > -	if (hci_register_dev(hdev) < 0) {
> > -		hci_free_dev(hdev);
> > +	err = hci_register_dev(hdev);
> > +	if (err < 0) {
> >  		err = -EBUSY;
> > -		goto failed;
> > +		goto err_free_hdev;
> >  	}
> >  
> >  	virtio_device_ready(vdev);
> >  	err = virtbt_open_vdev(vbt);
> >  	if (err)
> > -		goto open_failed;
> > +		goto err_reset_vdev;
> >  
> >  	return 0;
> >  
> > -open_failed:
> > +err_reset_vdev:
> > +	virtio_reset_device(vdev);
> 
> I'm not sure that this reset is necessary.  I suspect that it isn't,
> but I don't know for sure.  In a situation like this, I'd probably
> err on the side of only fixing things which I know and leaving the
> rest as a leak or whatever.

if u called virtio_device_ready then yes you must reset.

> Otherwise it looks correct to me.
> 
> regards,
> dan carpenter

