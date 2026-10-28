Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198342;
	b=BQYZJJtZ+BJSQMsoVsGJQcwuiPPcEpriwgXqA8sbp5LjGtdZ324jN3Tyh4JE3mMfelcT
	 O8aRyvx8VmPX5D7Atnm2NfayHix42uubinSCK72wlTUjh293nDP3b9cHSKZBozq+Y0lLW
	 ZHK9l3zuHkXmV4DqkvtVTXxQo05Rue1zc6E6rvV742Zll/cqz4Jt9pANCwkU4cUtjRYkr
	 4Nhf23N0AKo99okiegZ6YoGzP3db2BmNZgUtGAqlMww4/DUjHXytgAnmMxpyYbBgCkccN
	 h4Ejv6flSqbZbfS0SrJyfA69SspaL5EX3SF+5oOr76C5twiM4fzxkChnhrGzG+G0FAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
	b=b+lo54rpGwpqSzqJio3O8qayg0KuTHXL8gdzGvr+A5O6t5v4xHsut+6gacy9rUnMs/wu
	 SjO5Qjw0b7pkEfHD7f/JfzGVTDi/+o7SelUMKk1zk9W0qmFm0MyNELjPrjHbSLS4s0QWV
	 +JL4WxXEp5XGubbkcp41q1J/AVyOb2051qMERzBCDIKTsFRa6KSY7sifSpxVXrcWCUZxw
	 T9zdrlwlTN/kbllCM7pc11W2BxBj6RI/J1J7DuHkngrZUri7PpUJzEiAMnIH4ANERsZ/+
	 ICw2WOnUVfE/shcG/qlD2suNFyMJPipnTpsOSuTVZ0tDSyBpMufTk/PdLgurmrzHW3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=frame.work;
	spf=pass smtp.mailfrom=frame.work;
	dkim=pass header.d=frame.work header.i=@frame.work header.a=rsa-sha256 header.s=google header.b=llErKZ8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.132
Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AE606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=frame.work header.i=@frame.work header.a=rsa-sha256 header.s=google header.b=llErKZ8+
Received: by mail-yx2-f4.google.com with SMTP id 00721157ae682-8aeed29cae7so2379037b3.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793198341; cv=none;
        d=google.com; s=arc-20260327;
        b=Ag1ypua5uIeGHBnNejVj9zWQ+NCU2sxQPmNodYSodsnSpzlZKIBuYpPD0k5lONKLDY
         WBtbGd5OoXbaOTo2gEuRhuYlvI0jjFrkNrkXvLzsz7ygMxR6IGZ3z6BCErKXAZ1vOsae
         O3s6/qAXcI7dFedwPH70y26e2NXIz5OlR60zHB+VYM0RLTG6OjiwApDIst0JGVhEz9jp
         BB7GuKggCtHh9wJ3/xconfIfwbfqOpHGQ0dOEQqgY72z0NKyCazcYdNGUi8NnshXcEyM
         ORpG5615ouLlSy5zEBMLGgc+VZ9NVvRsqSX+EuTqoMmCSg4eyNJvcgoZmeMKWJWoXOwO
         aEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
        fh=4EqUNV+UC5mQoKtDh+moq4cVOn/vk2hZmKw+vdIWaoM=;
        b=DACebKZK5PSmIKZnueTp3H1F2RPauYPM+bnil4urTphcd59ylM27JDKJtLhDvzp+H6
         jpbu7FKFpxfOBmtebK+ZWlU9Tm1V/s2ei2gxLv2T1p5JFK2WqjkG4ondWpv9gvasxCdA
         Pc3e2TqKeiHJjtcGIZS1MqjytJRTXeD+DqozGAH/axPQY9Ofm81qM6VfltLo68xPCzMt
         VJ5XHoKSMC39iB4iM7nFyowMFVa7VmkTq9Y6VvSBesmrwqeaC6STD1aaoNd2LgVRCELf
         q9SKPqhtTuBikyE36ZmPW+djCQiUIUIsMtGPZ6KTeRmjr+JknBHRRCLmnPHV1nYH+4jj
         fJyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1793198341; x=1793803141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
        b=llErKZ8+cU1c0A3LaglTHA23qyp6aZosMAa0/JcCynOVB1B1cqihO+9AxXHdC2iXDM
         /lMSA4vIzex6CkHTyzOTwxIeOgVY0VkOVc5ifSdsjyDfl/MG+1lBV+fqeGEisoQhORXq
         ltRcjRhCTstoFAloYxcTF7JfO+4bOM/83vGKfnjGvujD6amqLyX67MQnFFNBUBROkMUf
         tvSCzV4B3VZEtdmo/zUVLr+PLSt9NlZoRhJRDf4WVuVVlJP2BcbptlNlPbB1iTh1lGp7
         0IBQvgGyBOGsGchbtzRev3RoTbqbLzFOlvIDUDyGAk7MkN9qHGE76+l8oDhet8phjO//
         wGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198341; x=1793803141;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YffM2+bNXSGxzbIFjdRQB5xkjYVmryZXh9IxVf9SGB0=;
        b=pXAXqiT80d6fcGudY2Kq1GNFx1xqIrXRL7fjasCZhkV2zgwHaLPF0irPzdN0I/ki/0
         mtHtLaHL178ZXBpDyDO+m+tWYS7YrDYhy1U2vQ1nEawuK9zOAndqsYx2TviZn5+fEg6m
         yzqeATdHT6axfwKdn4UMMrji1w2L9sjkule0IWx2yRuhcBZGGQ4vkbdnp/1YOws6b6Sh
         Wet7yIWdMoKITuA2vsUHs6n4iPMo9JD1nIOwkEEkRNx5+uv8sh3IDBiLAl9td29rmd/n
         gymnRy1qnCr3/wqat7vi0zsAkXXHOwzwKUuYPWOnc/x0LS3r0lCelaFtOTXPyseMfjKo
         DITg==
X-Gm-Message-State: AFq9FYKcyXMZcV4vPMEexHoQjnGv3O38vNHtNoyfwzfYTCCegkHNwye5
	Db0e+f1A7c+ekOCvVdK7D7flBycN9zB3FFR0hOrGoQJs0ipzu03e7DB4+3vT3cZWmtUnYtVGrXe
	HpxulcVB3zigL2v6HovT3QdQay13d+Zot19g2mfk5GW7qQ3ryE4XZtg5XQiMzqyM=
X-Gm-Gg: AYBFou0fw81Tbn03/uKmBwEOuXsqzFOJAd9kZMNfiBTAmo1seJJrFzpIU7uT0S1bmDb
	+qvnRQyiPS3senztGAP5iFO2cSE3UTG9gQzvZsg0mZ/TvPmDBOn1Pz6zZsnx+R3KbWmBAMN5E8W
	Q0hZXtWR9zN8sRxhu0dNtb0saRrVwd7+FHfXX0cjMXoSvv3f3RB4ZRL5D+t3EgtJso4cK2G7EHM
	hycpN7HEaAlKXQMXcSGDbKYUBAENI9thggZYmx695C+XkShcTSf8gcetlELXPwJ5l6HOCxzDDza
	zgqexx67x0x6ShQQ4mC9zpKNK3dE5N7YOeOFaj27vGgjv05tLn/cPdivSgGYT6yMAsLDayQvzS+
	5CrAv/1WZR92J9Xcywn8EMb7axIBB6qQ3yIGlqJcH1BkxhJ205m9WFzcMufX30Svr5BRnd7dfr2
	udoJYtn1GscakNKG6E1ysVFw==
X-Received: by 2002:a05:690c:f14:b0:8b0:e595:8cc1 with SMTP id
 00721157ae682-8b1b5d4be24mr16738707b3.58.1793198340947; Wed, 28 Oct 2026
 07:39:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Daniel Schaefer <dhs@frame.work>
Date: Wed, 28 Oct 2026 22:38:24 +0800
X-Gm-Features: AclHuK8o_-AiuRFYRh4EKMyxmqBI8f97bswVkP-qj0VI3UmPL4F27DibpVK4qwU
Message-ID: <CAAjcXz7fjcH283zHzJSZbKK74HOsOxEr9+W0ydoiYyLJ8y9qVg@mail.gmail.com>
Subject: Request: backport cad928dad9a4 ("iio: hid-sensor: als: scale each
 channel individually")
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi stable team,

Could you please cherry-pick commit cad928dad9a4c26aa56b4223dc2a29bca517fb5f
("iio: hid-sensor: als: scale each channel individually") to the
stable trees >=6.9?
Currently that's: 6.12.y, 6.18.y and 7.2.y

v6.9 (3765d426fe86) added color temperature/chromaticity channels, but
they share the
same scale as the illuminance datum, even if the report descriptor
says otherwise.
This makes the sensors report values many orders larger than they should.
Apart from this, color sensor hardware works ok on 6.9+

Reported on Asus ProArt PX13, breaking iio-sensor-proxy:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/413

The commit cherry-picks cleanly and builds fine on those trees.

Thanks,
Daniel Schaefer
