Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793587695;
	b=ZBLgWla21dWwozAcKFaau9QH2MyEEqdSAQYzu9SPQgovVxZElIEjGfQXmJUY1PKljo98
	 C+ONK5g83Lk5yZEnsu2i0hsC5mW7nR142EKs2Wclcx1Cs6Ri1Dm/rxHTqKXiMmZdUd7Ty
	 j65TLVZ7z1taBeOtM6K1b73zuIUtaGWjkhXhZ2P/2FR9ih8pX2pI/Khk1X9PL9Kxm8htu
	 FKWDZesEl4PPoaYd6sPCtXZ12+pV2eicRXPkPv7eHo8LeyYTWdNfUGtqKiv1EgXWXBBIr
	 FXzB9oSUUDUvxBH6RghP0sPSLS9Ok8Dac42mcs67kETBJxFExalQHVJQsT+ETWehJ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793587695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
	b=sFDWDmV5uYmAIID7B/jjP9i0qgGkY1niqE6E9D4HBub7VsndfR8N+yJrqvvSd7JvWGH2
	 jUqW3rZQezhIMcC59eTQRpERUuE7CeryRId2KKZKAHQoAhslriyZEq6cbdHI3fc0mBSqs
	 1vUWrdW4TQBKs0ZGKZx/1Nw0uetq/Rs0VsYeqAV/XaYrZ8GKJwHaSoZIEFohwYcLZFabA
	 egT8S22+Z21bD6Ybj1PmK2NbHXET19n7d1mADkTmFgrcxt3Amp+XPmniZe3piDjlOujw7
	 QoKPDx4YqmkJPUWXgszPweKsVLpwAKXrUWfDAQxF1i5yBSR4MKaSplH2layiyDYJ0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRk3+SWj;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2B606A33B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A2B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XRk3+SWj
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15943c9c005so80915c88.1
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793587694; x=1794192494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
        b=XRk3+SWjrmFi47T+BW8eqendwPWmdwpi9KgXy9BnV+dovb2ge7vNhFjLm16xv6o6ux
         vs8KDvC4qWMFoI4VY6oH1k/UK5kSFBNZ8kW0FCRmojleyATVsyt6brflCeE3BaU1JCRA
         eocl1/Qw1fsH5888Sty4t7EL3+OAaWhRKzGUjw4fJTb86AlmQnxXn4S0e1xqRjkKuTRg
         dWgSi767xghB4fE5WjDkgi88GJeS41ivbBGy9PHocuyHpkdgh2NKpK4zko41yfl0IcFP
         SMETV76yFrDufnc7iCLlADKB6DwJvqzOnYCQ78An/4Ev/l+ZU0KoKo+GdWmEsBvuqklf
         /LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793587694; x=1794192494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxeB/5HUF4xSL5RIyv8FYJykd2NtQvs0eRR/c5Njn30=;
        b=ncVlvkD4LNuJXYb1HzbE2VDtnOzIKzvmfcR7ykPBgzliAYyguSoFFuOEyDs0X5W4St
         hKccvx3xPzgrx6O8JYSjy/blmK3FOyyX27vjUGUU1PiN2Ls0j82Sv2gyBYZVnG7o4nXJ
         if4WRsoPOPhTObNXO/lwU1sdt+p6myneWUZm8qWsXhvDJYJQqHqHGMRetrZ7BKhcTru4
         hAPEHxgS6Z6rmrbtS0R482SEqlshY9Pdn7eLO27OtnZWpQmVa8DX5IfbacrqbVQNK7gr
         bne+8kV5wzUOlgcrzk8jtdPqDV7LcNY3REzA62C0Zhgf6+D+pDZQhFjbwOVTYcYbV5yP
         QZog==
X-Forwarded-Encrypted: i=1; AKwUvBwans3opaT0xKlQHYkoM18QQ2oTI/8LmyCR0esM7ClW3mt0eJwuSB5BnZ2g3LQ+7HIwb+2IrpQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlHtJ4Mkbs2WzKR5gOzpH/4emWNdbHPJwQKC3KtJuBmyAcX/Su
	ZJdyHv7GE35PjL2xxG5alRdFYpdrge9X3ghGVM4FgAzFyEeaqntNjjYB
X-Gm-Gg: AYBFou2EeXmOU5YpZXBCsmXC6oDiMasYNZunkidWfUht8fjUKZ6mvVVL0RSxX4nHBkT
	SbdL8EqbWNGMvyFzeSzayMDCZIw2w5YKsvurDtfcj/QUOQPHpwD07YGTgtMZxKH5wHtNcHcG/qW
	zYaIxqQ0z15s4WHfUjtTDoVsB7hlQVPTA9WwYSWVe0UtSs/ygajJHBBObkoifUK4Ok7Tm3GnkoE
	rXwliF79Qi6t60tl+suxgA3Qta0FL1CiUx9oLWVNJkfvWxoc3XjFpsTWOPXLrgjRzk0hD3y8mRs
	0krRiZNW6WoZ1wh9VucpXwsXiCKy7romxcE4jm0p6gX6SdTLvAa3RzWzpFNz0s41UBbeaNsAl6n
	izVSduYd4l1w/Fcu2+1mK5ybZLtMuNm5KbTSJNGPkTU13crY6qJPNKvsSDGaAo5DkwwxkWSvUUJ
	w3YhIbDnLiDhEWbWZJxC+TH59ByVdTENW9d9kf65a31q3ZHg/hkrcDqVp6Ds2Qsp+se5cCoSjHf
	4ZwhkOi+7QB1+umEKPABl7+UHVGZZK3vK252YNRjNtmjqdrJX4S0xpMm8upZitKCc1O1WWRcO3X
	C1QuqMXGADBBxac6nf4U9Q/wSWZRpu6phb0V
X-Received: by 2002:a05:701b:4281:20b0:158:1ed2:cb58 with SMTP id a92af1059eb24-1ac5e6f5362mr13936565c88.39.1793587693890;
        Sun, 01 Nov 2026 18:48:13 -0800 (PST)
Received: from xploitoverload ([2406:b400:f11:1bac:4040:640b:8a1:8629])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac0e738445sm29930662c88.0.2026.11.01.18.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:48:11 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: andrew@lunn.ch
Cc: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before dereference
Date: Mon,  2 Nov 2026 08:17:21 +0530
Message-ID: <20261102024721.28129-1-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
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

On Mon, Nov 02, 2026 at 01:13:xx +0100, Andrew Lunn wrote:
> Did you consider the other fix? Is there a use case for setting a TUN
> interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
> EINVAL?
> 
> Andrew

Hi Andrew,

Thanks for reviewing and raising this point!

Regarding whether there is a use case for setting a TUN interface to
ARPHRD_IEEE802154:
In real hardware/subsystem usage, virtual 802.15.4 interfaces are typically
handled via mac802154_hwsim or fakelb (which properly allocate wpan_phy and
dev->ieee802154_ptr), rather than raw TUN. However, tun.c explicitly recognizes
ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR in tun_get_addr_len():

	case ARPHRD_IEEE802154:
	case ARPHRD_IEEE802154_MONITOR:
		return IEEE802154_EXTENDED_ADDR_LEN;

which sets the hardware address length to IEEE802154_EXTENDED_ADDR_LEN on
TUNSETLINK for userspace network stacks/simulators (such as IoT testbeds or
custom TAP-based emulators) that expect 802.15.4 addressing.

Regarding fixing this in drivers/net/tun.c vs net/ieee802154/nl-mac.c:
We considered returning -EOPNOTSUPP / -EINVAL in TUNSETLINK, but chose to
guard nl-mac.c for the following reasons:

1. Subsystem robustness / Defense-in-depth:
   ieee802154_llsec_dump_table(), ieee802154_dump_iface(), and
   ieee802154_nl_get_dev() assumed that any netdevice in the namespace
   with dev->type == ARPHRD_IEEE802154 has valid ieee802154_ptr and
   mlme_ops. When that assumption fails, it triggers a NULL dereference
   while holding genl_mutex, leaving the mutex permanently locked and
   deadlocking generic netlink system-wide for unprivileged users.

   Other parts of the ieee802154 subsystem already make this defensive check:
   - net/ieee802154/6lowpan/core.c (lowpan_newlink):
       if (wdev->type != ARPHRD_IEEE802154 || !wdev->ieee802154_ptr)
   - net/ieee802154/socket.c:
       if (dev->type == ARPHRD_IEEE802154 && dev->ieee802154_ptr && ...)

   Guarding nl-mac.c ensures the IEEE 802.15.4 netlink handlers are safe
   regardless of how an ARPHRD_IEEE802154 device was created or modified.

2. Userspace ABI compatibility:
   TUNSETLINK has historically permitted arbitrary link types on down
   interfaces, and explicitly supports ARPHRD_IEEE802154 address lengths.
   Disallowing it in TUNSETLINK might break existing user tools or test
   frameworks that use TAP/TUN with this link type.

That said, if the consensus is that TUNSETLINK should reject
ARPHRD_IEEE802154 (or arbitrary link types that lack driver backend support),
I would be more than happy to submit a follow-up patch for tun.c as well.

Do you think we should reject it in tun.c in addition to guarding nl-mac.c,
or do you prefer restricting TUNSETLINK instead?

Thanks,
Kalpesh
