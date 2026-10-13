Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D92D73B8
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853128; cv=pass; b=pF3PMUZeLD60LMLZbjzIv64Wys184dyf+zu7w6v+V+kpdPlk+RSHEtGFbxyTjlg6PicHKFU7Qlfn1Qbvfl1Va+I0EqQpTiPt+NqyXizFxpaVg91zU+/Qq1o4I2Zq1qhb+tB17u4viV0gsjHDcQ5+LnhcOIPazGZnQLtfIFvhNe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853128; c=relaxed/simple;
	bh=k4uBOr3fUC9C9V/2LEU8KbJ93ho9bjIXmyZyw7xe/xQ=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw92op9Ke8hn2lpNOuJQP9I7CYpNfat43Rm1j+EBXgnJeBlzLmRZgV7CPJd537F0mWVDNXLrhag4Xy1gARsOn6MhNmNkngArwFlpb6oDwZ3FZEnWtHAxbesFHS/Zt+3X3z+/KdY+hr50K4Bq+dh2IABT/wAi1W7kQnM4gYnbQKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=BMtkzgR9; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="BMtkzgR9"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so1767183e87.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 17:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791853123; cv=none;
        d=google.com; s=arc-20260327;
        b=kyBzXsifkaXowrKour0gGnDvgD1NruEsYuyL8xeiG5j80XPaMqk5+qLeg5yYitvIW9
         JjxWK0x86ReMRTAZQbOHWbXLTDgNA+YoTEN7bz9w1iDdZDkyfNny+vkoUwVv/XlyZnFm
         JuEnrrOMKpLY/BLmaHTHHoJhbh34wWyzecV+q5nSwVQKSW+lAXTgMyor7UtXLCLq85AL
         BxovYAJMULZ0v4i3i+uVd7LFd5KerW3hI6K3I00ICQTos0NBqnSQwKdmhAUMr1Z0S2fC
         ykZE7AqPY32x10Yg5pC5fspJzTobbekAV7uiULQ5yF+sx3qmNExclpKzDnTwBHqRawYB
         47EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=0wOhigAERgw/ecq9Zfp4x327PQ7aRIqMRodPt/se31w=;
        fh=+H3hPjQ9II7oN5PxrSIvXfTepoJRi0Fu8NiQSY+LcbM=;
        b=SeEzSxM4RbQKrKISySthbua8qrKnAJlnLKE4/aPSIo6N0KYV325t72/A9BrDre/ERB
         +8afrTpiikNNBCylZYjSqg3IqZ0vVViYMXMjQ6CQSJxCGoik3nRrfBBcI6k/J83A33cy
         TA001t94Ynl3KNOT2YhNJgeS89HyNfwX43LzYkxGSqhR18MSm4fR7UBUurprITRAsuxx
         RtV/BKai8AT6cgieSDgWlRxJgvbY6JQCre2E+caTkwrn0DHdjszl9L9/oQTJXvD5imm/
         fPSWzoKYLB5KGpOODactDsE6CAnTNEnB02WSRkXOwsTNW1ufux7r4BO3mvuskRMQGxF6
         Q+Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1791853123; x=1792457923; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0wOhigAERgw/ecq9Zfp4x327PQ7aRIqMRodPt/se31w=;
        b=BMtkzgR9AyZ2IkE6qpDGPnMWdFbq/no756w7o58F1IxN0ulDLrxzXRlpH+bgKG1kXn
         ZkoFrAhqXXnKT9U/iFKiN5nbvcl1MZT5XUXnt/pNuaMantJfrlaUAyISTCm8ejPyh78G
         gRa/YfGRIn6GmIwKJz7tJcSswfp+Tis5FQBcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791853123; x=1792457923;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0wOhigAERgw/ecq9Zfp4x327PQ7aRIqMRodPt/se31w=;
        b=MHbCV60YTlDy+a4Sx2ib2R7dE000AIEMiFVv2Cm0Ny0f7I839FZtj+w92ZUWuRamxx
         RhXU8kKIqzXHTxUgSBMp4PcYsKds4Bx79aOnUgTu3Ght3Zk9gGSpACV9OSSWxCLIASnh
         K3FNqzOOLldu9sXnasjba5OAp2z7k5g/1Xx93Z4ectbvAsZG38GVByys3fN0aBzdVj0w
         2yD/ebbbkfGRP96bCG27FIYB68YT/wQxWChHcDFUytKfJ9lGzVXbbQOD9nDuUkpk/sI+
         wAcdoYH1rqrSR5vgsp63p7oE14bDxZhLC0KAQqhYCFXMEw9gYeqW/JHGNQXMy0jV4Wce
         qKVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhlHyNz6PpIbfjrKAz0aitJ/DtGD0wMO1vodd5usib9PTojAU4BTHzUDpV6udAcLFKj3HDFAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKqKE9js8aM1x8aALtILu9XrMpB04jGBOc2EjGQhgRRT/Ut7qO
	9n5PR8i4GwbQnXZG5nvwFdogTga4y9cp7xZ0j5MoVw5BLj2xp7I2IdrpP+exF9n6m/N6bOPf5uG
	Q9RDq75yRdKRj9vpxp6y4GOrJm40ekmh3WnQrnjt+IjvOG7BFLwMgCuM=
X-Gm-Gg: AYBFou2yfjlcul57koPSjYunwG5tj5IG/N+OLkhkQmANEIAdsQhPeoVydPNjuNmRttM
	hSqqjcGFNupFKXhsYA7kT07ES3bhlvWf7WRh6Bj97W8DqFz1HLIRvkTCJ/uNBf8Rnrm8za/0hCU
	jkpD+ydC+EMhu5jgPjOcU+HvS36nEJriXepc4f7n3d59CSSnzpIxt6JhchtNZjxQCP743ql/x4M
	SorPWyiVNB74lNejSZPsXFGrHkjDbU8eogFFmb28VSlua2K4azs+Itnjcfmwuc1mKtTUSrwapUT
	eQYLvbkB4yPTKb1qYwfxwWWNTQPu6ozVhkBU+6+057iWriQoVKEu98zZwc9IDBX0/8buhP18QjU
	EFb62gOphPX+mPpkLFhxgIhnn8lnPJ1P6sZM=
X-Received: by 2002:a05:6512:696:b0:5ba:3339:6f6b with SMTP id
 2adb3069b0e04-5bcde6bcb06mr3984876e87.20.1791853123500; Mon, 12 Oct 2026
 17:58:43 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 12 Oct 2026 17:58:43 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 12 Oct 2026 17:58:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Tue, 13 Oct 2026 02:58:08 +0200
From: Kim Wooseok <5mghybrid@khu.ac.kr>
In-Reply-To: <04d26f79d5984920a9584d3f31ec3b58@realtek.com>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr> <1fc8c339df1944afa6186197337edda3@realtek.com>
 <CAH1Bc_yOhZ9oqreJOLKb5RDFEW=0Zid=h4xu9oTR51RDwj_bww@mail.gmail.com> <04d26f79d5984920a9584d3f31ec3b58@realtek.com>
Date: Mon, 12 Oct 2026 17:58:42 -0700
X-Gm-Features: AclHuK_Ifxw9QoHyehe9vofNrat2BMmKWVVJ1nmld41C-se66_6KTgRsHhz1IK0
Message-ID: <CAH1Bc_wUq2Nmhvd9q85JP+KyCYHB_xqStfmo6ZirOxOkXzAg9A@mail.gmail.com>
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

> Does it mean that data in a cache line can't be modified while a USB
> transfer? Even the data isn't a part of transferring data.
> How can it affect the transfer?

Yes, in this non-coherent DMA case, even modifying bytes outside the
transfer buffer can cause corruption if they share its cache line.

On the affected Pi, the 4-byte usb_buf shares a 64-byte cache line with
the mutex's waiter state.

The important detail is that a task waiting for the mutex still updates
its wait list before acquiring the lock. So the mutex serializes access
to usb_buf, but its own waiter state can change during the transfer.

For example, suppose the buffer initially contains 10:

1. Task A holds usb_buf_mutex and starts a USB register read.
2. Task B tries to acquire the same mutex and joins its wait list.
   This can bring the shared cache line into the CPU cache, including
   the old buffer value 10. Updating the list makes that line dirty.
3. The USB controller writes the new value 20 to RAM via DMA. Since
   this DMA is not cache-coherent, the cached copy still contains 10.
4. If the dirty cache line is then written back, the old buffer value
   10 can be written back along with the updated wait list, overwriting
   the value 20 from DMA.

Task B never directly touched usb_buf, but the writeback operates on
the shared cache line. A subsequent register read-modify-write can
then propagate that incorrect value into the hardware configuration.

I think one possible overlap during a rescan is between the
channel-change path in rtl8xxxu_config() and the periodic
rtl8xxxu_watchdog_callback(). The watchdog runs every two seconds
and may update frequency correction settings through
rtl8xxxu_track_cfo(). Both paths use the same register buffer and
usb_buf_mutex, so the watchdog could join the wait list while the
channel-change path is waiting for a USB read to finish.

Allocating usb_buf separately removes that sharing. The mutex still
serializes register accesses, while updates to its wait list no longer
affect the cache line containing the DMA buffer.

Wooseok
