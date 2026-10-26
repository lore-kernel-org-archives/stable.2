Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793038745;
	b=eibTQS1Nm1bbJv7kbXzNa3MBKkTnWLY+8iia0RKGn54yJauHGkpzemAaU1Fd9CWYgteM
	 WfEd2El2XzqzF3mXPL9RT1ifdmx6BvuaZjPml9rtprG2WgWdgD+qvzVnp8OJ5MmPBregs
	 NWhGaa9aL955udsjzAPk5zMlZbqrg/+L1SJKfyvGmSYIUToGzRBjS8Rm1/HlpDzoVv4qi
	 xrOuZNPNnMkGjSwnhZvNmSPsiHKemicWi+fW2uuB5H+WlZ21vtyTnxEvXjcPEA8Jm2OIc
	 XlRtiMhxowLDrBe6nF9v55wx4ixWTOSEdSqL+PLCFFY5C8XggwCX+//ZkyoVCwNCh6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=q4zljUo/WokZ9ZcS0OuLFAaAoXOMyCY40p9IAtD1yUI=;
	b=0T7gPOG7TV1swvLnoA46hEVnMDeZLxC3fljTE0pNS59PUYrVanDpaNA4K8LT9bdS3kbi
	 VrY/c7d5t5oZOhysD+EVY/YojLCLTkylz6Eq2sGcMcyJ5CLCqGy0HnPlFoCduF/h90yJL
	 bx5hqMCR6g6h3nT+w1hY57X6W61x8EHkmJL3fBwclnP6qdrSnWDwjUKxsQyA/XKIhUvk4
	 Ow2Au9oFEguxI7OdO52kuDH1CuB0CArGyqAVu0dpvHLqo6/rjh5H1UzdcPwEAC++IcdrA
	 9ncCN5OPcqi70K47zEC0jVt7UmnbojFSDwtif6fFfcJf+PsyAwW1vHY7wgWNGEQk9sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YO6o2UWh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF83606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 18:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YO6o2UWh
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so4681414a12.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793038743; cv=none;
        d=google.com; s=arc-20260327;
        b=fxiAC+76GqkhUc5Iepqzy5XfzZW/H/insf0IkaLHRFkcHny++W/l8R/JJJLLkble35
         IB1pXA8KD31scUCSTi73eJebz+qTP2QasE13n0Z6fajnDw75BUeCIfL15eo1gdO38NFQ
         tbumLMyARDiV0m19l3/TBZ9EowM8uPSVa+NzNv/2w9INyzYFkChZzkAU1HQ1wSvsDQko
         wBU3wD/avy+0w19FtlwuvXwVE4kLx+inNuFQuLeZsr9+Ngrc5QvOwGZ1wTivw/W9XzWV
         prm4G77Xn2bAxfQtRUcnpQl3SRH3t+ke/EtRT/d4FWMw5CI2QkKYffl2IjKcARnkB3tR
         wobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=q4zljUo/WokZ9ZcS0OuLFAaAoXOMyCY40p9IAtD1yUI=;
        fh=ZsJIY3uU2Jot+HNZFd5T0yM0LmGnL6w8wIY6DeC5Njw=;
        b=G/7QvlvYCU0meAb2c6YZwI/PMsaZ1Vuob62eaHoxwZSnaB0tTnaaUNowBwvxKFk1Om
         07wb3Zi5dIRJkGnUeb12Czvhp7uEfr0K8LqXwue4gMBVk9uc7ZgjQDHne4hhQfsJN13w
         +EJK5JtlLAGZxomg27oqCG5fIf/VFsyK9pGBwL/3pjrG/vmBKNWCDPiUAkSqDVdHMOkd
         17RfWQzA9JurMNskIjjeDohhAA/CnBGyC/MnkokQh1bo5yJe7rOKvyp2XEBO03pUkgCo
         ASxtmeLZ1xVSQn2sYMipOyqHZNMTN455L+BnC+Rcsu5Vo1nNiNQgg+f0V5KNSKjxDqwe
         Rbmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793038743; x=1793643543; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4zljUo/WokZ9ZcS0OuLFAaAoXOMyCY40p9IAtD1yUI=;
        b=YO6o2UWhnZal/jIxQhDAZyGMq+3ad8NQaAHXtAB8i74Ah6mEwJJNpe37X/jwC2ISQK
         bexaJ64o7gqfS1A8sf0Q9+3ukfmG+7seVaNvOtaC+6hysw5LW224dJf4+yG4RtF7tfrn
         Y27k18s1lVt/3DackF2QWeR4RTDiV4zxG0Q3HmtNYpH0jtKwjvLXvUgg0bR48KlrZqln
         jMYQIqVoljvh/2aIQOkO45H1/1TKs4cTcfKbxXvleK2jSCH5kJan2KZ/j4USCVphGpJW
         WSx0AweoHgJCEbEjKH3SCyfYNR7gRrXaKYHz77pUN60HpReBov5h0+2pcKtQOMwKImHs
         Pxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793038743; x=1793643543;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q4zljUo/WokZ9ZcS0OuLFAaAoXOMyCY40p9IAtD1yUI=;
        b=CS6DxtELJzROQyHIxxYhEXAd8iIIrm+ublB4RSWamju08BXBanV8hnZ5HuZob9txau
         rseJTb++h9O1mpKjxE7rIytunV2uecGoq4mfANiDEO+H8jwRTsDGgh+315RA/e+6abcC
         6e+33HocIbaxInEatLT1GYtufdzal1S4BIgtdKPih7vyC1JEsI0MFbonCnbKLEz9Ij8f
         e6JWrjzaCmr+9hh/C82+LqG8/PYfJ3zmk39aZR9j40OfamJdtUbWrs29exBtrMbuRfin
         VdzwGDMkKJ+r/WuthRh0y0M11xDIIPT8gCj8Fs5t3dujB7eFPfVP5s6nqrKoeEl6AEzC
         +UWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQI5uLdKUg+lISCtMtWye0ThQFOg0lsqDp9OuJg0IzuvedEtJCCP831NECkPcw24Itq5FRUbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh6haRU8tN9s7nVgyb20SN9RBGNrXnyKEPvoLvX1aHGvfbKtt0
	oDzcRcFGqrnfHZqZepdYheSha5TeApSZ2w7DL4uk1BFf0I3luQyZG84IlRkE1mfRbV3Mz58epSB
	J0Ycv3jQYiOygnkJgREY1Om+s39W1XT0=
X-Gm-Gg: AYBFou1u4dOY+eOv6/CKfSeSMPW2/wHAFvnIC/kyeXEIOePmoBrdVUroCVtR+vMNO9i
	24TUYNqa5faARAurzv6lji+V3V77vcfDu21yLcnv5mvX+KR6gIC8wI0Q9xd05wtXNl1HNU4U1Qp
	BUMxl+u1oGRMzSOYv+EQ3SvDh6DeklsWY71kHjBetnvgkJa6WEtNMuLrG/wce9mlVJRtpfoxiZY
	nZjYM2W97BVVgwk3Ec14fnQoRat7lo71iZweh5mlXbP/tpBOWGIPMpOxMbb7lz7FmumOo70v2IS
	kazHby5MBNEEqaKsIuglwS+SM1uqPita15tc1p8pNdVVJZgGRppjXhiM5s6jgmvbkJPjcct0mXZ
	nFsMk7Y/npmP1409flEGVZb1DGef9O1475NgP
X-Received: by 2002:a05:6402:11cb:b0:6b1:c34b:f1de with SMTP id
 4fb4d7f45d1cf-6b442fe01e4mr8023274a12.23.1793038743182; Mon, 26 Oct 2026
 11:19:03 -0700 (PDT)
Received: from 511566560828 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 11:19:02 -0700
Received: from 511566560828 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 11:19:02 -0700
From: Ivan <ivan.vin.ctf@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 11:19:02 -0700
X-Gm-Features: AclHuK-ipMP5mANTbqHhxLeL7nhQ9xloN8pId4pHJHix7hbFR8bNuox2OXTaCOs
Message-ID: <CA+hZKY+MDvp5rn-F=wJAP2HR8PAXBkLHiK==4ESeZ6uU2zADoA@mail.gmail.com>
Subject: wifi: mac80211: two more check-sdata-in-driver WARN sites
 (drv_bss_info_changed, __rate_control_send_low) - same family as the 2026
 set_bitrate_mask fix
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, syzkaller@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

While fuzzing 5.15.216 (KASAN, mac80211_hwsim + USB ath9k emulation) we hit
two additional "Failed check-sdata-in-driver check" WARN sites, same
underlying pattern as the recently patched set_bitrate_mask site:

1) WARNING: net/mac80211/driver-ops.h:172 drv_bss_info_changed+0x4d8/0x580
   message: "wlan0: Failed check-sdata-in-driver check, flags: 0x4"
   trigger: syz_usb_connect_ath9k + NL80211_CMD_SET_INTERFACE (iftype=7)
   racing interface teardown/bringup; 16 crash instances collected.

2) WARNING: net/mac80211/rate.c:371 __rate_control_send_low+0x6ca/0x7e0
   message: "no supported rates for sta (null) (0xffffffff, band 1) in
   rate_mask 0x0 with flags 0x0"
   trigger: scan_work path with a NULL sta.

Both are the "sdata running but IEEE80211_SDATA_IN_DRIVER clear" class:
the driver callback would run against driver state that may be freed or
not yet allocated (the guard prevents a use-after-free class). Following the
set_bitrate_mask fix pattern, early -ENETDOWN returns in the calling paths
would close these.

C reproducers and crash logs available on request.

Thanks,
Ivan Vinichuk

Reported-by: Ivan Vinichuk <ivan.vin.ctf@gmail.com>
