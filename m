Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7E35F5F8
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787802734; cv=none; b=F2ZcbM2oULc15i+HbLvu6kaDF7p9EHYxsgpN6ymtFr1/EhkVv3HwCzsQeRkWwtRWtNmS3v407MKzc4urIVdlWIu639K1J6UaPh8QCIbiwx5Yyxl0Uft6vvYXYD/dMNR/vpeHnmTFrqea5TiCPgpnWHIWt3Bkuh7DhshMQ9YG36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787802734; c=relaxed/simple;
	bh=wqAOpz+o/OmBXLvAWwJjaJJz1u7kCcgSqoUoQrl5Sbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyfAEPgGIhbiFB8V7/YFZNauU41lpRG45tdK/Z6imrbj22fGNOdpUS5w7YL+hLI1DY/CmKbig+dBauswF/Q6Fd/SNCCMcLXgdISMWkqxpVhmmLZoNCzsh+U156yZtWOnVLuHUIK0HpR+SzeL8auWlRjLmed7WdGCD283QBaNDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8e7AZIs; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8e7AZIs"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so387063a91.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787802733; x=1788407533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJfrPdFq+EA9k3+W6F0OPeNTLDq5MohHxFERw6Hx1bo=;
        b=m8e7AZIsD7kdqLgeokh8eqNjcdbuW+SWyNNlOIq2Id//PyKBds3Af0j19qHjQ2YWvH
         QMnEECy6gj6wnO4kNrer746kaCvGAz419/bWKL016PF0scpROiPolCW2+RFGx7dSvBbl
         IArOfoFr79l83SZQs4tVIoZ7/hhs8ESe/ThAD9+sMa5LhBTrdPYxYSsStpATxr0ZAPwe
         eyUzoP3yeszLkDw0jpSiGX1IH18mD4LOxoq0qoXjBmA04RFG7wRDv2l0i5w7MHrMPlc3
         MoCfeBeG/w3sAry88pKSdEp+rIf3IdGl2w/OVWo2SkASkgcPpCYrhoia8OwBkdsM1tXj
         2+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787802733; x=1788407533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJfrPdFq+EA9k3+W6F0OPeNTLDq5MohHxFERw6Hx1bo=;
        b=bpON0qc6vDrw5giwzsbYo7Nw2sqn+o5doxjbxZHiaQjFFB01mNgGKO9qEO3h3rVe9V
         jsUW8fZ2YXMpX1Z4xaVqbV+u/MYewiRg+BOmwZeDExrtNXd7bBINe3gNFxsX1KD4Z+uh
         az9JA0kBs1AXyhHfdQNrSDNgf56/GwPJyhbXkuobOChfkIGItjmRYElgFv6gWPhoXDdD
         DOBNou/hD1waLR3UUGm/+i0cfRt6G13yFhU5OSLs/A7+cnMp48ELFStlZjWqAqHAoDte
         2zqCTxfexZ3LRx7GowP+qigrBkRMliR9ADxRSqzsq6H0JaYIe910ss9aeZm0ZMgIIeaz
         40aQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNYRN+Ig/Dsuh1iUutZoagVQT5beqBNrx5yU9b3rrZj2LgPUwhINKijdnoLfMxPl4ncBWB3wY=@vger.kernel.org
X-Gm-Message-State: AFuF++kcUDWYBS/ejeWfeTGbPph2rT3Yx/i3YxzO+9b9khg+Emgf+kVH
	mCR6fj7hyj3rxRp81ujWy0fqHl8KRQTwvmb5DhjlyhTVQO20mxd1CxcU
X-Gm-Gg: AR+sD10YGr2sLIQ37rNCbTOapI5g/rJTrU3wAfyUKrZjTECr1aZLCHMH/XQWReem9br
	2ZHMOHux/8V0c5t8oZHRjSx8WVBKj/it9FrdnHrQNRXRLPXmdipBy6J9jd5AyQa2Me5xdqlgmrv
	K6EffI+7MqEomZRGW6WqiRc7sR9Y8NosCLyRwfEQVYFHXAR5ORviY/S72cl+jN52zCl+J2JDpEv
	Vi69FBCtn4IqJAkHilJ1ycOP1rNM1zd3kYi4Ei6BuyhFsDeAcUXCsGRmmWMfROiiygjd+NFL6gI
	xjjFhL+OWhLT8S9p3hrJmbnYPbN+vYEx9vOhk2jYQaiCMBwmcO3NgM71fl75PNDPoukUNspcqSr
	hZqlg/58pV0dwrpoLfBpVO17uu0cePjRlkH4fK3v8iiArA77KQ1+/8J7x7aEcExaZZ+vvkboETT
	Z/LL9nfHaXaNEZX9t+ygqLS0OR9DBw1/zLQXYmW651vXmLwJCiL2NbgTAq7GcsuGedvZKt5bdw9
	h8/jQ==
X-Received: by 2002:a17:90a:d2ce:b0:393:1d92:db5 with SMTP id 98e67ed59e1d1-3966d3dc5ecmr25814435a91.10.1787802732642;
        Wed, 26 Aug 2026 20:52:12 -0700 (PDT)
Received: from Default ([2409:40f4:1012:4330:756d:2890:a615:2db9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm20222630eec.5.2026.08.26.20.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 20:52:11 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: jeffinphilip14@gmail.com
Cc: hverkuil+cisco@kernel.org,
	kees@kernel.org,
	linma@zju.edu.cn,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	ribalda@chromium.org,
	sakari.ailus@linux.intel.com,
	stable@vger.kernel.org,
	syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com
Subject: Re: [PATCH] media: dvbdev: fix uaf in dvb_remove_device()
Date: Thu, 27 Aug 2026 09:21:55 +0530
Message-ID: <20260827035155.10725-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822112256.12346-1-jeffinphilip14@gmail.com>
References: <20260822112256.12346-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 22 Aug 2026 16:52:56 +0530, Jeffin Philip wrote:
>In dvb_remove_device(), dvb_media_device_free(), device_destroy()
>and list_del() all dereference dvbdev regardless of its refcount.
>Thus, if refcount for dvbdev is 1, it can be freed and we
>operate on freed memory causing a UAF. Fix this by moving
>dvb_device_put() at the end of dvb_remove_device() so dvbdev
>members can be safely freed and assigned NULL when dvbdev is alive.
>
>Reported-by: syzbot+37578f730d38898f4b74@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=37578f730d38898f4b74
>Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
>---
> drivers/media/dvb-core/dvbdev.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
>index d753d329502a..9aa4b8fd7379 100644
>--- a/drivers/media/dvb-core/dvbdev.c
>+++ b/drivers/media/dvb-core/dvbdev.c
>@@ -598,7 +598,6 @@ void dvb_remove_device(struct dvb_device *dvbdev)
> 
> 	down_write(&minor_rwsem);
> 	dvb_minors[dvbdev->minor] = NULL;
>-	dvb_device_put(dvbdev);
> 	up_write(&minor_rwsem);
> 
> 	dvb_media_device_free(dvbdev);
>@@ -606,6 +605,8 @@ void dvb_remove_device(struct dvb_device *dvbdev)
> 	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
> 
> 	list_del(&dvbdev->list_head);
>+
>+	dvb_device_put(dvbdev);
> }
> EXPORT_SYMBOL(dvb_remove_device);
> 
>-- 

Friendly ping, let me know if you want me to fix anything.

Thanks,
Jeffin.
