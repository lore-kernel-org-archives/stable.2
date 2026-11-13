Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537456;
	b=OPxDkEfg2qaxyJj5B5erZUhfOyG6I9j1xN8MJwpHEEtUwzPQmF2oiSQjFfXViMxUgI/r
	 zWvYfWcJWPb0z1y8jeEkiWdTpwyJpJ6O+ctCkrMIJOvaXHi5vdeDv125eoIcTf7pNhEEl
	 mg7H5VRfY7KVZjCelQNU2FvzrvwkcqlzidXJO1g6qh7VQFbipWVdEgBUN3uRl73KaCAy0
	 /WP/r42R2B0KNu5CTMc9kSFlHKKm/6C1zCh1mjJjHmiD5uK2PWo7qkTM30GYim3ByshE6
	 kMzCUxhWUZjZ8Wn7U+YwDwFJkZj1sleldKd76/rv3S4YcFO/Gq6T4gzADjhvlLQa2Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537456;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=cx2rKaJbOqB/Hvn2K4CIf4NzTLrImGVIRCP3/c1MwVo=;
	b=ew408xUPYBCwFxBUq5Z4knza5xuIG/jZMzwf11HqZF+lanPqSbXIHZPQZaKV5dgRihWg
	 miP0/gIM97NIGyrkhC2Z17Hrolhdmb/5zB2Lcvbu8C/lwtl2BqbsBDz3ZPXIh9O2a0mHY
	 s3+CxG7bhQ1w66ITT7zVhuqRFZMbGfElJjx15X84lxoLql4TZFmvGPKdaCapz0Z46Vk1U
	 +qPD+6wXyQ7SiA5pYhIoKUFFo9BEFjXkgbc1NplIOUnvQo2oqibOGYxOhxYoo14FQCtE1
	 qLs79TGrJCOEgzpR+OmsuwyMcdUX5kFfSAwgs0DcIEqijpM7j06tcJ6KJg95J3KBORQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=W1F5bGtk;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D5606A32A;
	Fri, 13 Nov 2026 02:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 740D5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=W1F5bGtk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794537449;
	bh=cx2rKaJbOqB/Hvn2K4CIf4NzTLrImGVIRCP3/c1MwVo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=W1F5bGtkMKa7dTLuyi0NRQOxTIRo03+TeCPwLYdSgkKAWD8/Hh8MC5/N+T7d4kD/m
	 QNIB3H9KLhYKDrlvJAN0+8UyRSxolNtnNrMRZd28sGqzX7WvIog8Q5JN6iCBbqtESU
	 ejo7+zKFWa0xOZWONeFi8+pI7Q1uDuEpd8UVK+rU=
X-QQ-mid: zesmtpgz8t1794537433t19dda35f
X-QQ-Originating-IP: c4AZLqPOFpr3nxvrVD2TCH/MbBycDcANaNZ/IKhuuVA=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:37:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11128085979388629745
EX-QQ-RecipientCnt: 14
From: raoxu <raoxu@uniontech.com>
To: skhan@linuxfoundation.org
Cc: brgl@kernel.org,
	gregkh@linuxfoundation.org,
	i@zenithal.me,
	ihadzic@research.bell-labs.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	luiz.von.dentz@intel.com,
	pengpeng@iscas.ac.cn,
	pmenzel@molgen.mpg.de,
	raoxu@uniontech.com,
	shuah@kernel.org,
	stable@vger.kernel.org,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH] usbip: Close all listening sockets in request workers
Date: Fri, 13 Nov 2026 10:37:10 +0800
Message-ID: <351AC939AD9B6359+20261113023710.1746483-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <67b2c06e-0caa-4ba1-89ee-17cb814d173c@linuxfoundation.org>
References: <67b2c06e-0caa-4ba1-89ee-17cb814d173c@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N3hocr3RRwxYAtF1eL2wfGm/DkJurmgZphWaCoCzG18cQ1ooWvXw66s3
	WFrWHfK3+W16CB3UXSPLFD4qWVJtXaw+sy7mM6cr68ohgsUFxuNUaxiDGMvDTqQJln7Y4u9
	KDN1x8em4P647it/9xO1NEBPt8As+9W5xch8ZQ6aY8JMZz6TXXHQYNJM5aSXO3QMR6Mbn96
	kdDMfbtLsNKO19jL6nVR1a+bRGT0GoIHwCYjxN05QhGz1Yv3cOqwb4NQy4r7H7lJLhEBTte
	5Uu4yVjLVObdkS/igSHUbb+jbUQtPrz/JPNy169zCjDf/7vqN24Ax7vu74JayoKn9R63plZ
	RZPJr9HxUUznWC3el7ik3E71iPIwrBgXEQsz14G1Ni08eXk/2v69tkg/cHnTDAZSLC5AbhO
	+yAWVINyf+KR4S8pMFwSb93HBvNn6m6CyZDOa8ihWwkyXLgZTdWvV1Lptf/Mik+1PfQd5xb
	ZBlSEMsMZYP9lDkpD4MdddYO8Y6CCtcbRjLYu6+ah9UUfx6pCA6DZrwDvbfv8N2y3sbgn/P
	oLyE3h2Quv7Juk/l67KJOfRKrm+3+Toi87K2mxCzCcI8PCqvFkpWSiqmiGyH4kXq2jrd+iJ
	BopsfTPzS+8BwfFSzk3jYsFz/SrRlrgTQS5qwZXQaSNktPR4w00Xp4JdLoJ0/LtEQOjhhdP
	+a4uEg9+DdhgbscdSzYe4FPfrueB5TiSlE4eu+SGPLxekT9BAotofPB4/712Cj4+8/s8POW
	//Siw+VjyGmIqC4JmCvYFynr6MpXp6I2aoHDsMQR95EtpmN8+BciVfBDbzmb84AP+M7Q++n
	830KF6C6AkAvH6aoJFrEe6p1A95RYTMpjyIp3Dsk+fAhM/LgeEOJVxqa5BhjF83Dvt7gTWg
	Dy0CbqC96Vlzqv2IxhJKtUDSVMFCYXIkEegRZWZXtuJYsD5FOYwYYtqFo0ETeYkHErDYPJ2
	xBilfAMD8kns/D9jn5uS7SJJDP2GtO5JkWEPQXom+3Wf0cVjQtrLpivBZQ7SSvIq2VXaL5o
	/zjL6T6fYU9gcrf1i1L3c++Ef4QBWodJ2n4x/kMg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

Hi Shuah,

Thanks for the review.

I found this while reviewing the listening socket handling across fork() in
usbipd.c, and then reproduced the issue with the unmodified usbipd binary on
two UOS test machines.

Both machines have usbip 2.0+6.5.10-2 installed, with usbipd located at
/usr/sbin/usbipd. This package contains the original listener handling.

I used separate test ports to avoid interfering with the default USB/IP
service.

On 10.20.12.188, the reproduction steps were:

1. Start usbipd as root with both IPv4 and IPv6 listeners:

       sudo /usr/sbin/usbipd -d -4 -6 -t 43241

2. From a client machine, establish an IPv4 TCP connection and keep it open
   without sending a USB/IP request:

       python3 -c 'import socket,time; s=socket.create_connection(("10.20.12.188",43241)); time.sleep(300)'

3. Terminate only the main usbipd process with SIGTERM, leaving the worker
   running.

4. Inspect the listening sockets:

       ss -lntp 'sport = :43241'

5. Restart usbipd on the same port.

Before the connection, usbipd had two listeners:

    0.0.0.0:43241 -> parent PID 62216, fd 3
    [::]:43241    -> parent PID 62216, fd 4

After accepting the IPv4 connection, the forked worker inherited the IPv6
listener:

    [::]:43241 -> parent PID 62216, fd 4
                 worker PID 62223, fd 4

After terminating the parent, the worker continued holding that listener:

    [::]:43241 -> worker PID 62223, fd 4

Restarting usbipd then produced:

    usbipd: info: listening on 0.0.0.0:43241
    usbipd: error: bind: :::43241: 98 (Address already in use)
    usbipd: debug: listening on 1 address

The restarted daemon therefore had only the IPv4 listener available.

I reproduced the same behavior independently on 10.20.12.199 using port
43242:

    usbipd: info: listening on 0.0.0.0:43242
    usbipd: error: bind: :::43242: 98 (Address already in use)
    usbipd: debug: listening on 1 address

This confirms that the worker inherits the unrelated IPv6 listening socket
and keeps it alive after the parent daemon exits.

I also used a separate TCP socket/fork reproducer to compare the original and
patched process_request() logic. The original implementation left the
unrelated listening socket open in the worker, causing the rebind to fail
with EADDRINUSE. With the patched logic, the listener could be rebound while
the worker was still alive. The accepted connection remained usable and the
parent's descriptors were unchanged.

The affected usbipd source also builds successfully with:

    make -C tools/usb/usbip/src usbipd

These tests confirm the inherited listening socket issue and support closing
all listening sockets in the child after fork().

Thanks,
Xu
