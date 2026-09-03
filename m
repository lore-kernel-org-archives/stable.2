Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071123A7586
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422734; cv=pass; b=i5U3WVbhwwi3nHGaK84vfy0fKhkTsAA8gcTgI7Wyc8VuGrO1wkUrA2S0t1JHgjcxLbycjgta/cZ2uKn1JCCBsIX16CDZncrisTOxYi9l9MIU/EdBjOmaPr8YdqNdijJdPMOngAEg8xlg1Kypl/kJzLE9iniSF/3juRKKgASEBn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422734; c=relaxed/simple;
	bh=fovmEqIqgVXpo5nek+CJqatjdeLkHXnTUt8Ymo9s1zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQV2NBxnhlpXdlAUgbkNidWDadgIzM0r21rkupoNwzWwOrL2UgZ/ualpk65tAVyR29o4RQb3AAfOP7iqD9VI6fbqT1uc1i0Nw4dWPcRm4AHHpRl20pMh4GqlZ1IHAbMDL68YSV6l2/7vUiAkLYXiOTcwauyppgSzcIECDDR19n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJbB5GrP; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJbB5GrP"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so2036187a12.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788422731; cv=none;
        d=google.com; s=arc-20260327;
        b=YcRVT7dOXJU7T4lhOSl1ZPe2MTribDM87QyuQ240ZrjOEYqjuL/qOnyfV1gRDf6n++
         jCaJHJ4ioSFF6dITHPGCn3HkgznpmtzrhZyrqrk2OI6Kru5cdeXtZMwIoI1DyrrCqBzb
         TC7kW7k2jnpoPmYHXlVLK5SYJB+PhPWcGwTOi2WqO6Lz6I0J5TOK03SWb4TT01LoRvJl
         UfmT9ge/e2opb6Kp96n/sjhcLuvnIva+bm+m5zFNmDpIkZOeQjQGeIpyMcZyOvjPNUeU
         ZyArCEWBXUAHMs2MIS1jG79by05b36fNObEueP7CSVWxMvsCzitYuhhMSp1qFdd7s9od
         PRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6SrVKYP6RqUW7pG//37NoHw2yaQK1BSwRv3M9s2+zc4=;
        fh=mWvNiCfkLXRjktblamPSpWR/ONMPk3zmsquGY68Yx9I=;
        b=UtMX6IfG1kAfTeOH/0ecyzjBAUf0l13Apy5rTzSTCb9OCjfz+4BNIdUV5S65DkISCp
         OM9FD19EoH0T+a6KiE/7N5BXMW4kv+yTCj+bInyetrHheESM51uPf3xU6qgNVNfzzz4x
         uxnd6lx1EGh2SzIUw8VtjoyoCcOMA+qXJlwlCHzDY9sys1/ngXtGA82qMwY4i1e69Ing
         Oiz8U5qF6AI6x0eZMuf9NeXQuuHpNPWRgtE5oLpvv/b5EUuWCkWUXlYQaz1LCwN5YIyY
         M8CHhHBuNX7zJ3wIzY7pkBHhV4uvmFj7VZjP3xfY9yU734lXBnIPYehaEQNVFPLTzi7F
         5Rdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788422731; x=1789027531; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6SrVKYP6RqUW7pG//37NoHw2yaQK1BSwRv3M9s2+zc4=;
        b=iJbB5GrPlTsZ0MkXt/S6eWY+2Eti33VMfohvB6NiwiMBaUzYIgMW87lgMytpcLI37u
         ST71r4FKYyqGcTT+n3SOWNqXW17KDGPkXYFmYLwiX9eL4j+DbbuKW1maxQm7kRx4vl9v
         JgUZSylKtks3uDc2260p3rGmarCnTxlEeUmP3u7qGMm91oOIJtaVgjhcdFTuahSSVUM7
         fNznplJiTSd3T/3CFAx3HPYFx/1OTpBnKcG79Seg88svbmkZFm3DvId0W29YcdOc+2nl
         2kMh3ENi+jXFwWsQ+9WDwDdvzEhI/Ca4ZZ7+Zzeug0oTyY/ICraQzAoPY9IFnPikE+qx
         axxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422731; x=1789027531;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6SrVKYP6RqUW7pG//37NoHw2yaQK1BSwRv3M9s2+zc4=;
        b=SnGmWcpfrdK140RrGEggmxdcv2nVK1cHW7qcgH+ZWK1z1ok3werglgL0PYF+H223GS
         l4IvzdggF2T7dey23yNz9me2mZL0o/ZQSPmj0Li9Gqu5UpnEmYExvr7ijlGFpjYjMGJT
         J4PiJPAR3cgXs62nABBtW1R6tCfDw+6+UgJ8NzVE8tWBtFauR/jGRkCWEjj9jjzoubp9
         Pjnazp1r7PjWH964UZ/CHhmiLMnw8sXwwCLyu3inKDKJnm8zwyrMY8UqKZN8DQaVrTsZ
         3v0HrKShJEKIsomqqmMfUpwxodtJDiTNt1WMgSEe5Z7QdBN733Un2S8Xum3iRH+r8syD
         hBAw==
X-Forwarded-Encrypted: i=1; AKwUvBxNza6wCnR9idqRzI8yd5CQUbl07g0o/ncMnHu3AcoepuL+tjQYf1ZRLWE1YXSdvkckhmPsrJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mdDKt+ID2i0p9d5k477sd50Hn2EbPeI1AQCkywvq1dzYG6OIVh
	ihmvQk5ZV6+FcQiSbbDSWRGFz8h4dNUyDLyU3q5uWBD9MMw29d0hLEGbFyxvAUKZQeFYVxDa7um
	md/uj+lgwvsN2O+WRjHvIbGDdIlA3LQU=
X-Gm-Gg: AYBFou2V9sdnTJcw9rz0P6a0mCFoqUKShWTPc6v0xbp/vzLpwaH0TRggdQaCi373kng
	lHL5DGr0vSvxbC1xtJixZcEm0O4Rv0q8t8OEFbplduSEg40fz4xkok03ht4kP9JC9brXfAmXiaz
	oRnOQxWKUwXotAUdKMoQ9nWL0GF+swzvIT/lP+bidXd04FFgHW0GYC8P8Cd89hdHevV18W3c8X8
	18Gmob0ugF97iFQZ4lqwenbMnYUr1/SItmVq3NNfnYFSOk1XoZxS5E2A4gc/MbudXjmI97MCJqt
	HcdGKPESPNroAFNSV8syparW1+Ap1HX8JBW07088ll5UKyKyMQHKknvY
X-Received: by 2002:a05:6402:2110:b0:6a3:87b7:b5a9 with SMTP id
 4fb4d7f45d1cf-6a682ab9d91mr6190594a12.12.1788422731087; Thu, 03 Sep 2026
 01:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026082042-coma-moody-5b4e@gregkh> <20260820084557.129908-1-khiemtranzo532001@gmail.com>
 <DKTWKZFYC6TL.2ZESRE0NWAV2T@kernel.org> <0198b9fe-4bc0-4e12-b788-85aa2c9f8162@rowland.harvard.edu>
 <DKU2J83B6IX6.2CG1WOB66WC39@kernel.org> <CAEe5be5OjseCMxGQP=QMd1L-muOTDguaay_-21moS1+xRNNNyw@mail.gmail.com>
 <DKZ6PZV65PYX.3M9UEZC4ZMLLC@kernel.org>
In-Reply-To: <DKZ6PZV65PYX.3M9UEZC4ZMLLC@kernel.org>
From: Nguyen Quang Le Kien <khiemtranzo532001@gmail.com>
Date: Thu, 3 Sep 2026 15:05:19 +0700
X-Gm-Features: AcwNN1WMKVWa1WK1FArX1_9QFOqs2KtBbQ6O2kt-cOvVQdr4bwbcIwMEhE1l-hw
Message-ID: <CAEe5be4cJ5VPu88V4L7i0Pz+joSmJjBOpA=S9knbk44_-Rf9Og@mail.gmail.com>
Subject: Re: [PATCH v4] driver core: avoid klist_remove() on unattached knode_driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 26, 2026 at 09:14:00PM +0000, Danilo Krummrich wrote:
  > So, for a fix that also goes into stable trees what you propose sounds
  > reasonable, but eventually we should use the match() infrastructure instead.

  I've implemented the approach you described:

    - In usb_driver_claim_interface(), when !device_is_registered(dev),
      skip setting dev->driver. Instead set two new fields on struct
      usb_interface: claimed:1 and claimed_driver.

    - In usb_set_configuration(), after device_add() succeeds, check
      intf->claimed and call device_bind_driver() explicitly. This skips
      ->probe() and attaches knode_driver to the driver's
      klist, making teardown safe.

    - The __device_attach() dev->driver path in dd.c is left untouched
      for w1 / ccwgroup / pata_parport.

  syzbot confirmed the fix; the reproducer no longer triggers:

    Tested-by: syzbot+87188222c77c0dbbdb4d@syzkaller.appspotmail.com
    Patch:      https://syzkaller.appspot.com/x/patch.diff?x=12af8b49580000
    Dashboard:  https://syzkaller.appspot.com/bug?extid=87188222c77c0dbbdb4d

  Will send v5 shortly with the syzbot Tested-by added and the subject
  retitled to "usb: core: ..." since the change is scoped to USB only.

  Could I get a Reviewed-by from you?

  Thanks,
  Kiennql
