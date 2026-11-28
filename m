Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795842258;
	b=hTgJrMqsAYgbSJTPjyjRS0Su2nD3tCxnU+JCLI9n/p+MNCm7z9ZRrC44RU736GnMSW+D
	 fK7GrMWSAsfpLlCKIcbDQVakdPQClaIIjBOruSrTElzB0q3JtJ+IyALLHLrVCCqTY0Xi5
	 CJkAm0N3Zl/NuzVHIt9m4PrLNIuM2tkV5hI0Aaw9SBynUUNGe688yTstfzsIhaiRu+HRZ
	 kSpnYvVYTsP/0laRQ3cvHDYZ/00OTk7vpJGPKZmmCqEgf44uAYmBB/viAou2kdD4sYCXq
	 6OWdFqTbTvSz4f6Bq8hE4DC05liunMSqER016g1wI3Qha15VNUOgGFvaMGS/E3x3XHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795842258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=IpDKMQHHhzieIgQFhuqIwkPdgGcBXizCVrKmKXueCuk=;
	b=0xMr30F3nTi3iQjLGUj1X18b7mIrN/oYFNWNAoPv03NgViJXnWeI559rY4Z1tbi3rmtc
	 2+tvL9kTq/3la4snoRNPrS4qmgMQ214Im/pmCxCsPZCNtQdYexMP/U4hxv5dvKYVXBe+L
	 8CWUIZu7b/eeKh9KttkJCrdHoTjw8p/rjc+xjfq52xa1+1VSeG4I0a6RkFrLyfcSKrq/T
	 DwJkuAF+CY8+Hzt2+iNNaNrZbo6bf5l8BwNftapA3oUp1h6XSHdf4gc92N276HXG6toi+
	 8NdrOM751aojcFQzGqN7Ua6ysxUVi0/8kP+VYIF5OoX+H0K2Pc1JHWRwE1hCKa+fc0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHEjTKwF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFE6606A31E
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AFE6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHEjTKwF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386ab9ab619so12305798eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 21:04:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795842257; cv=none;
        d=google.com; s=arc-20260327;
        b=gRgu3J5f9bkYYW5muSfUwBPMwq08JtN1VASd6Qzo8cXVm3NF5zpn59OgVEHPJNHUKB
         UHulw6EJmgl9HjvGBlYBxWMcxrXW5RDHHy5YCZ+pitAEiHTNgU25x9pjTGoykqcaSh0s
         s2Q9kp/4wE+HSPaFSr06xojoPqFVLQM6e4vAIEkQHOPCfUaYH/XKJEsoXNv5HQmJYE42
         ny/yFdmFDsGxk0a+Ev+NwE35Nju4HsZxiIvfRNIU/0QM4iHYE119rMxojxtVzC8KD/qI
         xcRONB/Y92XwO30YoBsjRU8ASEzIvXD+OImdxZ8BUZtVS+3r1I7oM/bYHyaKzX9EjuRq
         m6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IpDKMQHHhzieIgQFhuqIwkPdgGcBXizCVrKmKXueCuk=;
        fh=JdApVJyjwQTLg063aaGiTIzzXoOzcwsOnMFxWlf5xrs=;
        b=PwLMGg7HaPezP0ZS9XgdcjKCqjjW5KK0T2m2oNbPJIjbrIOySuI4Wy16FOGXb86qcL
         YD8dbv1JROFPBB9X89vpq0qMfKA1qAvecFyRb1cdB/hus9+JEWIyz0towGkvShxNcQQN
         H19HSVMGk8NzGF5V+kwuoRZF+HJDCuiiIvErXH4oAzzDYhfwwF4MKPx5GpfukcYMhK1F
         KNsA7pH03lX4ut54lx66+xmB+GpmnO0YaXPmj1QWq7kTBY9zlL7P8InP8yaUEXI3QQnR
         rmWnQ89VWHS9Y6BdxK4drMF2TK0BgODa17kKitqg7ldWbnncbaHEujz4sgkj+9VM8xDN
         kJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795842257; x=1796447057; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IpDKMQHHhzieIgQFhuqIwkPdgGcBXizCVrKmKXueCuk=;
        b=CHEjTKwFdRP0JEoNMbyhYoqasgHdzWH4VDS9l0IPKKZUg6DhViC/MopbYXdJvQlloJ
         7gl4zIfq7W5lpsAHxosVBGlgT4AyQBtj7gD839P7+3f03iG5fkbjUELr2h0uI4TSZOaA
         6T4SwnOLuQZv+rUPthbixvaplL+Wt306Z/3cL5b5jF9cnvsft0skt0ZDKqX9sZk0G4pf
         A0MF3XZfOw0xCJieWOm76xHEO20xSu437UdOhG6JcqR5pSBVpgG36ONBYtQKYxloJGW5
         CFaad8jIozjWXkNuNGEEh1hiYUiJ/UzVYCPoy7Bas8fxijJALhxpxcF/2Ri3OYXi/R+M
         kZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795842257; x=1796447057;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IpDKMQHHhzieIgQFhuqIwkPdgGcBXizCVrKmKXueCuk=;
        b=iuxHlr9jzwDhVR1IrXmntHAqe5M63dVgiro+XUvEeb2Xxn5tlMuK/cxvPVn2VsQN7H
         Ht54MF+T38O4n4f+ypjJHASjz+Pes1MICfiEkiBDPxVODuhQxSZyFpeQa3/1fJ5IukhL
         LBjnjqWsRWeMhLpMYxnXSXPrheB5FZb+ogn0tA/W+nGhn3eQ8RcuMbrPW0mt+24j9tNg
         zdgtXSCePQWdP0gHKVBMnnFd6Xkx7vDphthtxwuY1GmQJTbSLVM4B2/j6V4+mhUqO5xP
         Q2pktyVzKWZh6zVziK0W8Z/87PQHktdP4Ut/3S2DMNLb7/MGMC5XImfe3zMk37KTcpop
         8sPA==
X-Gm-Message-State: APuU4Z/RvIKGt1NjYMxtPV/5wQGfRDt64qiiko7vHDPAoyzaHfNIp+ov
	lWOJ/9EG+Rqa7wM1MGf8zYf5Z3diyYgHKdLgLK29Pua/8M6QYT1xuNcLfv5DRwGbqIPqx2wDk6+
	P4hmWjDYFzhdJjWGLKg+QtoLE66mz9gyZNY2T
X-Gm-Gg: AZFdTZeMwWuAjwxx9ePe5dZk0vo7O34Pf9RAAT9IQhRzQ5dyMrEsMfUxyxqAoKt1eVz
	DakJFrCrbYTsv4QyCGmknoa9EKuBAoH6XhEGv+znk0EQPJwUktIwZ8GJbc9iHSCwOYOGQK0GDIo
	Cw7NNvVhXngHDaa2Jg9GJtFdoluiRPmUj6E9FASYXq9rNKmSKxtkH06lz/bFmkfprZDhqxbMQFE
	KTS+nE0FsWd4oRpTVh493HROp+5psF5PzjbjevE7iv4eIsfPvIQrwBZ+IS719w18zKB/25GYD7+
	Hwy65FytGkuwaUcJLfOGvUYx2xUeBeY0hCoiv5iiV4RAChBN9VDrTWgT11eH0GIl3sorL6DG4jm
	+NtOXOFYIAcxs95NS5l3mlhkuw9w1bizRQ4I=
X-Received: by 2002:a05:693c:60d4:b0:369:fe81:a575 with SMTP id
 5a478bee46e88-3857111f203mr32029115eec.35.1795842256924; Fri, 27 Nov 2026
 21:04:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Henry Zhang <henryzhang62@gmail.com>
Date: Fri, 27 Nov 2026 21:04:06 -0800
X-Gm-Features: Aa3M54pVvds-jmLO6mxXdGpcGHxdZ2l9Fkh6Dz6YWyJMQs1TTPKg3dgDtxduVG8
Message-ID: <CANTW0ypcrw2+BAqVKWQ6BOY2eUDK+D47aXuO1zuwZ1VaYwyvVw@mail.gmail.com>
Subject: [STABLE REQUEST] wifi: ath11k: signal strength fixes for 6.6.y and 6.1.y
To: stable@vger.kernel.org
Cc: jjohnson@kernel.org, quic_lingbok@quicinc.com, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please consider these two mainline commits for 6.6.y and 6.1.y:

  94f228ac4f5b ("wifi: ath11k: fix ack signal strength calculation")
  aadeee47e9d7 ("wifi: ath11k: modify the calculation of the average
                 signal strength in station mode")

Both are in mainline since v6.11 and in 6.12.y, but not in 6.6.y or
6.1.y, which still add ATH11K_DEFAULT_NOISE_FLOOR to the ack signal and
to the average signal unconditionally.

On firmware that reports the signal as a signed dBm byte
(WMI_TLV_SERVICE_HW_DB2DBM_CONVERSION_SUPPORT), these paths treat that
byte as unsigned and still add the -95 dB noise floor, so
"iw dev <wlan> station dump" reports impossible positive values while
"signal" itself is right. Seen on a QCA6390 (fw 0x101c06cc) with an
Ubuntu 6.8 kernel, which has the same affected calculations as 6.6.y:

    signal:          -47 [-50, -51] dBm
    signal avg:      109 dBm
    last ack signal: 103 dBm
    avg ack signal:  47 dBm

109 is 204 - 95, where 204 (0xcc) is -52 dBm, and 103 is 198 - 95,
where 198 (0xc6) is -58 dBm. Userspace that reads these values over
nl80211 gets wrong numbers. No connectivity problem was seen.

The average signal code was added by b205ce4c266c ("ath11k: support
avg signal in station dump"), so 5.15.y does not have that part; I
have not checked 5.15.y for the ack signal part.

- 6.6.y: both commits apply as-is.
- 6.1.y: aadeee47e9d7 applies as-is. 94f228ac4f5b conflicts only in
  the Copyright line of dp_tx.h; I can send a backport without that
  line if that helps.

Testing: upstream, 94f228ac4f5b was tested on WCN6855 and QCN9074, and
aadeee47e9d7 on WCN6855. I applied both to the Ubuntu 6.8.0-138 ath11k
sources and built the modules against the 6.8.0-138 headers without
warnings (BTF generation was skipped, as vmlinux was not available).
I have not run them on the QCA6390, and I have not built 6.6.y or
6.1.y with them.

Thanks,
Henry Zhang
