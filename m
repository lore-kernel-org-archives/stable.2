Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A363D4137
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563269; cv=none; b=LxN1Y/9ApaV76PAaOc+IiK7cFtMin224g9Rvx4iwSW16xlgv3/E5lpbaVcc62vyuMZNSV0vE2kgjYRUiE1ZA2+Y32ICmSrRoLQaSmNCnsjMELa5kwfgVdI9PRxGncI6RhaWSnIFG00kU99eUX8s90b6EyOOuqP0Kt76l/gMrrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563269; c=relaxed/simple;
	bh=GKuZVRqWtm+ag+MQ5GK5bzcEuGQJpFghJjgwjd6B32o=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=q8nQa5YLTrb3/s9x9rs7+uVSw/Wu1rHd9+EhSLnsO/lGtmfEXp5QbuaIs8fXWxWkb4cY+9slOBhTk68kq4k/mRvzs3SHk/GCc5HLxR7UPeY1FU06f9WbiG05qq5nRzhuDmrvfxAnpT3XM3DCD46kyRhMlnFRmwPvn+BTWayyf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMuw2FPb; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMuw2FPb"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso2151100a12.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791563268; x=1792168068; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZpE/NYqZeHO4dzGVhgtndlOxsshgd/TUZ6Pu7sEuBk4=;
        b=AMuw2FPb7GdjwGkCSMQTUXqcw9lP/hdEiGODO1kHoQBEeNA1yOzNQXNv4pjAMzkTY8
         WNiM5kk9PaKyHOsrLXQrak8M9Uww05gGz5vrRWX09wWZ29GklRtAUSsE0CpY+KJIRusG
         pLkYyR0FQdk8uE7HNnV2lATSMDJA6I+u4Sau9FdmsKJbFrxSkmXzaCOvf8PqyxhiicG1
         qnif13dtxudMfb+0YIj6HVoW1g6g+i33JxsniToEnXshiZY+W1rBk7Gk9HIco440Phyn
         kkHarkneULl7a+8iJm2XJSLzxQ3VlMlrMS7HJcuEEC/ozL87dEy1ZLv24gs4DJB4qr7Q
         pYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563268; x=1792168068;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZpE/NYqZeHO4dzGVhgtndlOxsshgd/TUZ6Pu7sEuBk4=;
        b=RFxhwm4gfXdu60ssOMSfoHdzYKMM9x6jT6+4s281JoTJr03KtAcUfBh+IkKv1TGcu1
         4a/uF2pS16RsAzTFUAUL0s43RSlEK04q7b9eA6OvXhWPNU2p1G88f2dKBfrkvlK92OSS
         ZG3LABhqw5h+ncjecfWh/lWZscEmyLXX/hnLo7nuTFdVrwti7uoTroHnRidd57FPYPJU
         s90OIUNN0p8kKRs5Vovlah+oAp5lsUJ3BatqvYLWgK1s+ogjMeyDNXdOJCOMyuSamcKV
         K811oxB8cCtmmFIVdaEczttkcWksAWQdUObCdVHWZj7aRY75MX4sz1438NJJkm/Sczx/
         E0PQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3r0w7/iVxvK7eseUxMHX6dDMrzG0FeuyzoXz40Ubb18Wfd+jdHvAa1ai9gu49DAKxAeA/spg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCW7ltb5t9O3EswSctbzPzRK8gJBVQpMYuHEUxTQl8wtB5uFty
	ShWjqW1phERRcQehcngfyh6qIo5j3Zb1oDOPZVrEgvAPH636FFm7QJxx+BAxtCZgpV8=
X-Gm-Gg: AYBFou00fW5EQZ7p45vuCbwZLps1ANN9VTGdeIVbT7Lh9oMXZjipUK/lgSccz53Zn2Z
	veDgJCTZ8/Ms55Ar6vLScgUHr8+RMFbpZP7+ztK2IVqJkJ3ZWY7ngRFJ37ZonfrQbLSOstBh7l2
	R1wZCtFz74sf3j9CCWVyPz7h7ncSUUKB98XnRGz9gZv8+SPyjXvDR86Ldr+x5EVloEHxlMIPC/0
	trlyHwFPw9+S90735zC6RDtiuzGIcUFptuZ2v92wr4jX9B5NtFtaaUlNAnaXLtxYrtkIBguvf9N
	8kNmpR0RoPSOxL6cShUsC2WAWyNijbSDCFIqLSGDObj5ih5Ps0SxAU+jTWzpwjfzIGHVhk908KM
	VSfVzL/71Q1+IbQXf4iXeqSbWHpjcx6v+IJUjdWJ2zWlluL4tUtV1Gzn1TGP8CWGoCiNXK+9YOT
	mpfCJtTEwd9MjXdPR6SgNYGxs+nQsDaNBh7FTjqx0q8Pu/B7+U3PV4vbfuOTmzmvbLH6w6r0rMW
	swAeHTikbCoHpo3YrtjjwNfEnV9miwSD0J2
X-Received: by 2002:a17:902:f544:b0:2d9:520c:38e7 with SMTP id d9443c01a7336-2e8427f11aamr22508725ad.1.1791563267626;
        Fri, 09 Oct 2026 09:27:47 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4eb2sm13099855ad.74.2026.10.09.09.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 09:27:46 -0700 (PDT)
From: Echoo Wall <echoowall@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: [REGRESSION] 6.12.111: "net: advertise TCP MSS from the configured
 MTU, not the learned PMTU" breaks TCP through relays when the peer's network
 drops ICMP
Message-Id: <4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com>
Date: Sat, 10 Oct 2026 00:27:29 +0800
Cc: netdev@vger.kernel.org,
 regressions@lists.linux.dev,
 stable@vger.kernel.org
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

Hi,

After a routine stable update from 6.12.107 to 6.12.111 (Debian =
trixie-security,
6.12.111-1), TCP connections to our servers started timing out for a =
subset of
clients. Booting back to 6.12.107 / 6.12.101 fixed it immediately. I =
believe the
cause is:

  2640e64195948a601430d230c9864f5426574cde
  net: advertise TCP MSS from the configured MTU, not the learned PMTU
  (in stable 6.12.111 and 6.18.51)

#regzbot introduced: 2640e64195948a601430d230c9864f5426574cde

Topology
--------

  client ---(internet)---> relay (Linux, nftables DNAT + masquerade) =
---> server
                                                               ^
                                                 path MTU 1456 on this =
hop

- Servers have a 1500-byte interface MTU, but the path between the relay =
and the
  server has a PMTU of 1456 (encapsulation upstream). The server learns =
this
  correctly: `ip route get <relay>` shows `cache mtu 1456`.
- Clients reach the server only through the relay (port-based DNAT, SNAT =
to the
  relay address).
- Some client networks (typical corporate firewalls) drop ICMP
  "fragmentation needed".

Behaviour
---------

Before (<=3D 6.12.110): the server's SYN-ACK advertised MSS 1416, =
derived from the
learned PMTU. Clients never sent segments that were too large. =
Everything worked,
including from networks that filter ICMP.

After (6.12.111): the SYN-ACK advertises MSS 1460 from the configured =
MTU. The
client sends 1500-byte packets. They are dropped at the 1456 hop, and =
the ICMP
error never reaches the client because its network filters it. The =
handshake
completes, then the connection stalls: a classic PMTU black hole.

Direct connections to the same servers, without the relay hop, keep =
working, and
so do servers still on <=3D 6.12.110 behind the same relays. That made =
the problem
very hard to attribute: it only appears from certain client networks, =
only on
relayed paths, and only after a kernel update that nothing points to.

What I verified
---------------

- Reproducible per host by switching only the kernel. Rebooting without =
changing
  the kernel does not help. Same sysctls on both kernels (309 TCP =
parameters
  compared), same userspace.
- On 6.12.107 the server has `cache mtu 1456` towards the relay, so the
  SYN-ACK MSS is derived from it (1416). With this commit the advertised
  MSS comes from the 1500-byte device MTU (1460) instead. That matches =
the
  symptom exactly, but I have not yet captured a 6.12.111 SYN-ACK on the
  affected path.
- As a workaround we now clamp MSS on the relay
  (`tcp flags syn tcp option maxseg size > 1416 tcp option maxseg size =
set 1416`
  in the forward chain). I have not yet re-tested 6.12.111 behind it.

Why I think this matters
------------------------

The commit message argues that on symmetric paths nothing is lost =
because "the
peer usually already knows the real path MTU". That assumption does not =
hold when:

  1. the peer sits behind a firewall that drops ICMP =
fragmentation-needed, which
     is common in enterprise networks; and/or
  2. the narrow hop is only on the server side (relay, tunnel or overlay =
egress),
     so the peer has no way to learn it other than via ICMP.

In both cases the receiver-side PMTU knowledge was the only thing that =
kept the
connection working. The old behaviour was effectively a built-in =
safeguard for
these black holes, and it has been in place for a very long time.

This is now shipping as a security update in LTS/stable kernels and
distributions. It silently breaks previously working deployments, and =
only for
some users, so most operators will not connect the symptom to the =
kernel. The
6.6 / 6.1 / 5.15 backports appear to be still pending, so there may =
still be
time to reconsider before it spreads further.

Possible ways forward (just suggestions):

  - revert from stable and keep it in mainline until there is a safer =
variant;
  - make it opt-in (sysctl or per-route flag) for the asymmetric / DSR =
case it
    targets;
  - or only ignore the learned PMTU when there is evidence of asymmetry, =
instead
    of unconditionally.

I am happy to test patches on the affected setup.

Thanks.
Esko Mobius

