Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437849;
	b=4WE9c6yZGwKFqQBiSYJrqvz5/xnn0OI4doE7lnUj0pQIzloiKmoNe9AV0t3qP2q9AlSY
	 rjOhN7SrICde9iJJOIXux53GYDGGZpn+fdZO9xV+Owh0dlD5ay8paU+w2GHuHvWkyZTJN
	 QGn1S19UzZwuO85HtWqP6hxdsZpU3ijFYi9S0tVtPzPrBttT/n1KW95CSTE8CXWGxmNwr
	 UqQ1dl7dZQEA2dP405TCbmrfORRdOJnMGuQEg828UVBQ7k23M9yYTjoggQD2Ftfw4KFAD
	 8izmTYR/kCOnupOH5VleZT0tWwr3RfxSToecw/WxrxWxSiD3zNnUL5/VADwvw8KC8jQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=E2wIV/LmN4q351Ca8sdYVqTZHhmUQoLMfsv/07UAq+k=;
	b=fgb9hqeRKGXXE/GMRRJe7ku1+TyfW7GE2teAQ6uSuaSxsatfhqZpXKEctgSPyDcNas+W
	 Bk67O4xgpviusY6i9Gg5VHWDYUmZI6C5yTxKXtEDcGMbhCtKfIVNRn4kCqANTULlfJPaK
	 3evmNgL2Ucadp+ozwT3wvA0iM5/bGyRKfeo2/IpmkN57riNFWMkeFMlawU6cVBoO11Xvc
	 H8HUuORNko7HOLeH6XgveSTfI+hhRP5vn0/il6F0B9gqB+MQMn23d7HPwHVY+fa48Y8m8
	 qaNFzuTRkR8tM0Cv5K9bzMo21IKl7mPKdjFrlBXyCMpkzBcdIlWSsTfiF6Dk9KZGWLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gn51y8w+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F3606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gn51y8w+
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6767d92cde6so3388871d50.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 04:44:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795437848; cv=none;
        d=google.com; s=arc-20260327;
        b=cok3rd/GAaVnr2TdDOrwwh1Dqxn0M4q2Ap5/CwhYNoYo4UYAKtzAC82n10oxbxVoJj
         Y05EBodyGinpIfGzQYI9Pd3XGVjCwdcKMCJA2wnIauCKIfeMyW1ZNYzZWghDPom/RLij
         usGO6QhcJRN9A0NBJEUpfs65wB42KXLs7gr00bY0E+Wl9uT5P9RFBDIsVp/An5+xtD4y
         bLaU45B+T93avTUzNZhNonlovuBw0uw7AOMU6F+SoL0Y3d4gCVjjXPEVfZn5i/n1Rm2T
         URwFB/GkYOTUxjHAHJH5w1i5IFdJ0H7SVGfI9x5g8SXAauwwokZ0rBSR9Qc7i1EuPqJ6
         upNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E2wIV/LmN4q351Ca8sdYVqTZHhmUQoLMfsv/07UAq+k=;
        fh=J0GSJRdHxkBowtBtdDaAzL7fjIcEpdaPYmRr5WlHNJY=;
        b=ULa0LUMFXwOIZ47uC2RNllWDvlrG8lRltgicjtLErZVvtUArKyg4hM7Ai2neUZDTWC
         iKBGEJOG7uZ4IAnEDrJWihN2Y7L2t/PGwbpHMJTTRQIYJVK4wxUZKnYFZtVYRBnrUiAD
         Mr3WKbQNrHVE+LqkKM5aa01KjP8CYhPex8JBC0+cGXiWHXeb7dUuIZzKDgi8nSuTsCLB
         mY9HK/hkNYCwQgof+ZQs99gsg/+vq4je+2zZDLNmIgf6wZAC9z9uwdhRYITdmaoXRk57
         n7W3WlmKh4VZyyMDJLvlVueRblxEMYrU6NeXaWi/nvb32A2S6xIbTG9chskEPd/rvMKE
         9wiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795437848; x=1796042648; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E2wIV/LmN4q351Ca8sdYVqTZHhmUQoLMfsv/07UAq+k=;
        b=Gn51y8w+XV4KZoigK1jAkEFSuEDfoo/uxBgegzImtZnr1ExO6Lu+lOSOJq4m4/Og19
         G5fmJiUwLsHDhsg03ZISw3wnoa09fZSQDpgwegatcdvST8Z8dIbMo8f01U26vgsV2zUP
         IO1AA1qxcNQpwbWJQYj7PPuZkaButdLbbfQUVAHBgiusTcyk5t5KpcfpKLVI0LJiI3E5
         6hYGNT/H8Sc/OeRGcWznktv9G4XpK3Fw4w8YKxoV12zUyk5N8P7T4X8WBhSYeEFOLTVc
         cu0pYxRnC4T2hBypeNP6Yioza5v7VHG5gjKQUvXS0GVWnRrh+6+gfSb+g8yfhO6QAaVd
         N9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437848; x=1796042648;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E2wIV/LmN4q351Ca8sdYVqTZHhmUQoLMfsv/07UAq+k=;
        b=FLiQPyHJs+T9rAdmGhaT9aEMf2Ogd9snNFUKA/H0VJ5BCp03JqlQ+Q6mCyzKEl8H+1
         h/Kp3TM65BPtOFXmKzZEx32FBAVpCWaKmZ8utjWXNilS62AA9JDd/xiXdKea5H6xSZxF
         46IqWEZxus1oaeSx1LyNFtr2SuIFnfIIKkzfe+shQ0CoCZXtHvYA3wO/4OAhopQMTE2I
         7NkwDtKUH2pDkOvt1Uh4PFCJS1w9JdPavcOivTO9Tufm9JDUskusA8CXveq2wMZSDYRY
         zfFlVOIHPa6tX6G+h3UOFJZJd8chWb7OI/8nP5ecMFyw1zsKXvXLJ3K4RKUtQO7+BBY8
         /dqw==
X-Forwarded-Encrypted: i=1; AL+hErH95ELfxOFEaU2+NcOo1MltCuc5Vt/kqplk41WJF1rxCXtruVTiFI37XxBaACKA0qUhjeGF7bQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cXSl/YLsVdrwi/O5GaCVYY3iKUNxjEzqSRMNQHN14prRxePYb
	22U3Cl9hBUP69+5OInE1w+nnuIljMDXfI4t2q+PFiMdAdLgnl41vb47k/WF3za0s4h9aaeThot5
	IP6j01bFq2yYE+MdiRJKmqhYb2Cinvsk=
X-Gm-Gg: AZFdTZdeoOCzcFRKI+nCOJxe6nWkCKRFEGLw+jxwsV1XwIlAzrqfod6IifTyuCsh0K6
	r3/fomk1Py5VRTc3QaoXCn8NTRnBR22WpqVTaRjQ1h370CJqNzNyR4DXTkhGVw89yRlyzTe8hsM
	0IQFYcCJtTev5XGGtQa+2tAAayWXcqRMpNtpPDcUHa9hi+MuHE+peFhKQ7faPqP/Ef4cGfpUnxc
	pKGbCAN3YY3CUQacTXhr7AT+4ei9KsWLSwm4DEGkVnK79kn3ljee7gVF4o4W05vwhjp2ABc1+dy
	BCvvcuLk32y9h4i/E43s7vczv4Ww4VrmkIjYVhShLCa62b1F+qEgaTXv2ETS7F4UPXrzbg8G4rW
	oamuD8M48d8zJV+0wI3uit0qyT1kccMlD2gMHLibJ/r8IFrnoqaL0CK8SzaI=
X-Received: by 2002:a05:690e:1241:b0:67c:17fb:ec8d with SMTP id
 956f58d0204a3-67df43ce63amr4323645d50.27.1795437847876; Mon, 23 Nov 2026
 04:44:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFAa3YDcJX5SKpss6TTnKwu83BCAWOrSzLrPAVmf-1hNryXLGA@mail.gmail.com>
 <2026-11-09-1-daily-reply-0030-rose-ax25-41@kernel.org> <CAFAa3YD2wtt+3n0Ve9c9ms42Z0x16f988Jdd4XTw-50xNE8zOg@mail.gmail.com>
 <CAFAa3YCCGb_21rrE+b-3E0brvSupto3+ouMDL3=4m38cg0nBFA@mail.gmail.com>
In-Reply-To: <CAFAa3YCCGb_21rrE+b-3E0brvSupto3+ouMDL3=4m38cg0nBFA@mail.gmail.com>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Mon, 23 Nov 2026 13:43:55 +0100
X-Gm-Features: Aa3M54pIgDEDMS8okJ0vyOWFdpsMrrmRAccQ4C-YO4JKKc3-QdiWVq4Ahouy8w0
Message-ID: <CAFAa3YDcX=a7PKbX741FtG-tzUZ6ActKC-sao46ah3_r4_ZzHg@mail.gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
To: gregkh@linuxfoundation.org
Cc: sashal@kernel.org, stable@vger.kernel.org, kuba@kernel.org, 
	linux-hams@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000240baa0660f0f332"

--000000000000240baa0660f0f332
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, Sasha,

Thanks for queueing the six patches of November 21st.

Here are three bpqether fixes merged in mod-orphan today, for 6.12.y
and 6.18.y. None of them has been sent to stable before.

1. bpqether: reserve the Ethernet device's own header room on transmit
2. bpqether: set both addresses or none in SIOCSBPQETHADDR
3. bpqether: keep a bpq device in step with its Ethernet device

Patch 1 is the important one. With a bpq device on a VLAN device whose
Ethernet device cannot insert the tag in hardware and with reorder_hdr
turned off, a UI frame with 8 digipeaters, sent from an AX.25 datagram
socket, leaves too little headroom for the VLAN header and
eth_header() hits skb_under_panic(). No privilege is needed to open and
bind such a socket, so any local user can crash a host that runs
bpqether over this kind of VLAN. It was reproduced and checked fixed on
a QEMU bench; the commit message gives the trace. Patches 2 and 3 are
small: an ioctl that half updates the device when it fails, and a bpq
device that does not follow its Ethernet device going down and up.

The numbers are the positions in the mboxes, which follow the
mod-orphan merge order.

The two attached mboxes hold the 3 patches, one mbox per branch. Each
patch carries a "(cherry picked from commit <id>)" trailer with the
mod-orphan git id. The backports are the mod-orphan commits unchanged,
except that patch 3 gets a Fixes tag here: the bpq_open() it changes
dates back to 1da177e4c3f4 ("Linux-2.6.12-rc2").

- 6.18.y: the mbox applies with "git am" on top of 6.18.65.
- 6.12.y: the mbox applies with "git am" on top of 6.12.119.

Testing:
- each patch builds on both branches (net/ax25, net/netrom, net/rose
and drivers/net/hamradio, W=3D1, KASAN enabled, mkiss, 6pack, bpqether
and the baycom drivers as modules), with no warnings and no errors;
- each fix was tested in a QEMU guest (6.12.94, KASAN), as described in
its commit message, before and after the change.
None of our nodes uses bpqether, so unlike the previous series these
three have not run in production. They were announced on linux-hams
on November 16th for anyone who could test them on real hardware; no
report has come back so far.

Thanks,
Bernard


Le sam. 21 nov. 2026 =C3=A0 12:34, Bernard Pidoux <bernard.f6bvp@gmail.com>=
 a =C3=A9crit :
>
> Hi Greg, Sasha,
>
> Thanks for taking the ten patches of November 16th; they are in
> 6.12.119-rc2 and 6.18.65-rc2.
>
> Here are the six fixes merged in mod-orphan since then, for 6.12.y and
> 6.18.y. None of them has been sent to stable before. They come from an
> audit of the AX.25, NET/ROM and ROSE protocol state machines: frames
> that are never sent again, a reassembly that stays stuck, a ROSE
> circuit that freezes, a retry count that is never reset, and sysctl
> limits given in the wrong unit.
>
> 1. netrom: send the unacknowledged frames again when T1 or T4 expires
> 2. ax25: drop a message being reassembled when a new one starts
> 3. rose: reset a call when a DATA packet arrives out of sequence
> 4. ax25: end a REJ recovery count once frames are acknowledged
> 5. netrom: keep T1 running after answering a NAK
> 6. netrom: give the sysctl timer limits in milliseconds
>
> The numbers are the positions in the mboxes, which follow the
> mod-orphan merge order.
>
> The two attached mboxes hold the 6 patches, one mbox per branch. Each
> patch carries a "(cherry picked from commit <id>)" trailer with the
> mod-orphan git id. The backports are the mod-orphan commits unchanged;
> all six have a Fixes tag.
>
> - 6.18.y: the mbox applies with "git am" on top of 6.18.65-rc2.
> - 6.12.y: the mbox applies with "git am" on top of 6.12.119-rc2.
>
> Patch 4 fixes a3aa611e37d4 ("ax25: bound REJ-driven fast retransmits
> with the existing N2 counter"), a mod-orphan commit released in
> 6.18.59 and 6.12.115: it is 6b450cf6dd41 in 6.18.y and ed836d734b0a in
> 6.12.y. It is also the only checkpatch remark (unknown commit id), on
> that Fixes line and on the same id in the text.
>
> Testing:
> - each patch builds on both branches (net/ax25, net/netrom, net/rose
> and drivers/net/hamradio, W=3D1, KASAN enabled, mkiss, 6pack, bpqether
> and the baycom drivers as modules), with no warnings and no errors;
> - each fix was tested on a QEMU bench (KASAN and lockdep), as
> described in its commit message;
> - patches 1 to 5 are part of the module set running on our seven
> production nodes: on one since November 16th, on a second since
> November 17th, and on the five others since November 18th; patch 6
> joined them on November 18th and 19th. Nights have been clean so
> far. One of these nodes runs 6.12 with exactly the 6.12.y backport
> attached here; the others run 6.18 or 7.0.
>
> Thanks,
> Bernard
>
>
> Le lun. 16 nov. 2026 =C3=A0 12:17, Bernard Pidoux <bernard.f6bvp@gmail.co=
m> a =C3=A9crit :
> >
> > Hi Greg, Sasha,
> >
> > Thanks for queuing the 41 patches of November 9th; they are all in
> > 6.12.118-rc1 and 6.18.64-rc1.
> >
> > Here are the ten fixes merged in mod-orphan since then, for 6.12.y and
> > 6.18.y. None of them has been sent to stable before. Nine are ROSE
> > fixes found by the same audit as the last ROSE patches of the previous
> > series (locking, a read past the end of a short frame, calls that are
> > never answered or leave a dead circuit); the tenth is an hdlcdrv fix.
> >
> > ROSE:
> > 1. rose: walk the neighbour list under its lock when a device goes down
> > 2. rose: hold RTNL while a route is added or deleted
> > 3. rose: change the loopback nodes under the neighbour list lock too
> > 4. rose: check the length of Restart Request and Diagnostic frames
> > 5. rose: keep a socket unbound when connect() fails to autobind it
> > 6. rose: refuse an empty message when the Q bit is included
> > 7. rose: give loopback answers LCIs that calls cannot be given
> > 8. rose: clear the other half of a through route a new call takes over
> > 9. rose: disconnect sockets under their lock when a neighbour goes away
> >
> > Drivers:
> > 10. hdlcdrv: close the hardware driver once, and only if it was opened
> >
> > The numbers are the positions in the mboxes, which follow the
> > mod-orphan merge order.
> >
> > The two attached mboxes hold the 10 patches, one mbox per branch. Each
> > patch carries a "(cherry picked from commit <id>)" trailer with the
> > mod-orphan git id.
> >
> > - 6.18.y: the mbox applies with "git am" on top of 6.18.64-rc1.
> > - 6.12.y: the mbox applies with "git am" on top of 6.12.118-rc1.
> >
> > They need the 41 patches already queued: the files they touch are the
> > same in 6.12.118-rc1 and 6.18.64-rc1 as after applying the November 9th
> > mboxes on 6.12.117 and 6.18.63.
> >
> > The backports are the mod-orphan commits unchanged, except patch 10,
> > which gets the Fixes tag that was missing in mod-orphan (the code it
> > fixes dates back to the first git import).
> >
> > Testing:
> > - each patch builds on both branches (net/ax25, net/netrom, net/rose
> > and drivers/net/hamradio, W=3D1, KASAN enabled, mkiss, 6pack, bpqether
> > and the baycom drivers as modules), with no warnings and no errors;
> > - checkpatch reports nothing beyond one style remark inherited from
> > the original code (a comparison to NULL, patch 8);
> > - each fix was tested on a QEMU bench (KASAN and lockdep), as
> > described in its commit message;
> > - the ROSE fixes are part of the module set running on our production
> > nodes: on two of them since November 6th and 7th, and on five more
> > since November 10th to 12th, with clean nights so far;
> > - no node uses hdlcdrv, so patch 10 was only tested on the bench.
> >
> > Thanks,
> > Bernard
> >
> >
> > Le lun. 9 nov. 2026 =C3=A0 16:53, Sasha Levin <sashal@kernel.org> a =C3=
=A9crit :
> > >
> > > > [stable request] ROSE memory-safety fixes for 7.0.y and earlier (me=
rged out-of-tree in linux-netdev/mod-orphan)
> > >
> > > Queued all 41 for 6.18 and 6.12, in mbox order. Thanks.
> > >
> > > --
> > > Thanks,
> > > Sasha

--000000000000240baa0660f0f332
Content-Type: application/mbox; name="bpqether-6.18.y.mbox"
Content-Disposition: attachment; filename="bpqether-6.18.y.mbox"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

RnJvbSA4ZmM0MmI0YmQwNzI1YjVhNTk5MTYxNTQ0MmUzMTE1MzY4NGJhNDkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZXJuYXJkIFBpZG91eCA8YmVybmFyZC5mNmJ2cEBnbWFpbC5j
b20+CkRhdGU6IEZyaSwgMTMgTm92IDIwMjYgMTI6NTM6MDEgKzAxMDAKU3ViamVjdDogW1BBVENI
IDYuMTgueSAxLzNdIGJwcWV0aGVyOiByZXNlcnZlIHRoZSBFdGhlcm5ldCBkZXZpY2UncyBvd24g
aGVhZGVyCiByb29tIG9uIHRyYW5zbWl0CgpicHFfeG1pdCgpIG1ha2VzIHN1cmUgdGhlIGZyYW1l
IGhhcyBBWDI1X0JQUV9IRUFERVJfTEVOICgxNikgYnl0ZXMgb2YKaGVhZHJvb20sIHRoZW4gcHVz
aGVzIHRoZSB0d28gbGVuZ3RoIGJ5dGVzIGFuZCBsZXRzIGRldl9oYXJkX2hlYWRlcigpCm9mIHRo
ZSB1bmRlcmx5aW5nIGRldmljZSBidWlsZCB0aGUgbGluayBsYXllciBoZWFkZXIuIFRoYXQgY292
ZXJzIGEKcGxhaW4gRXRoZXJuZXQgaGVhZGVyLCBidXQgbm90IGEgbG9uZ2VyIG9uZS4KCkEgVkxB
TiBkZXZpY2Ugb24gdG9wIG9mIGFuIEV0aGVybmV0IGRldmljZSB0aGF0IGNhbm5vdCBpbnNlcnQg
dGhlIHRhZwppbiBoYXJkd2FyZSwgd2l0aCByZW9yZGVyX2hkciB0dXJuZWQgb2ZmLCBwdXNoZXMg
YW4gMTggYnl0ZSBoZWFkZXIKKFZMQU4gdGFnLCB0aGVuIHRoZSBFdGhlcm5ldCBoZWFkZXIpLiBB
IFVJIGZyYW1lIHNlbnQgZnJvbSBhbiBBWC4yNQpkYXRhZ3JhbSBzb2NrZXQgd2l0aCA4IGRpZ2lw
ZWF0ZXJzIHJlYWNoZXMgYnBxX3htaXQoKSB3aXRoIDE3IGJ5dGVzIG9mCmhlYWRyb29tIG9uY2Ug
dGhlIEtJU1MgYnl0ZSBpcyBkcm9wcGVkOiBza2JfY293KCkgbGVhdmVzIGl0IGFsb25lLCAxNQpi
eXRlcyByZW1haW4gYWZ0ZXIgdGhlIGxlbmd0aCBieXRlcywgYW5kIGV0aF9oZWFkZXIoKSB1bmRl
cmZsb3dzIHRoZQpza2I6CgogIHNrYnVmZjogc2tiX3VuZGVyX3BhbmljOiAuLi4gbGVuOjEwMSBw
dXQ6MTQgLi4uIGRldjpldGgwLjUKICBrZXJuZWwgQlVHIGF0IG5ldC9jb3JlL3NrYnVmZi5jOjIw
OSEKICBDYWxsIFRyYWNlOgogICBldGhfaGVhZGVyCiAgIHZsYW5fZGV2X2hhcmRfaGVhZGVyCiAg
IGRldl9oYXJkX3N0YXJ0X3htaXQKICAgX19kZXZfcXVldWVfeG1pdAogICBheDI1X3NlbmRtc2cK
ICAgX19zeXNfc2VuZHRvCgpObyBwcml2aWxlZ2UgaXMgbmVlZGVkIHRvIG9wZW4gYW5kIGJpbmQg
c3VjaCBhIHNvY2tldCwgc28gYW55IGxvY2FsCnVzZXIgY2FuIGNyYXNoIGEgaG9zdCB0aGF0IHJ1
bnMgYnBxZXRoZXIgb3ZlciB0aGlzIGtpbmQgb2YgVkxBTi4KCkxvb2sgdXAgdGhlIEV0aGVybmV0
IGRldmljZSBmaXJzdCBhbmQgYXNrIHNrYl9jb3coKSBmb3IKTExfUkVTRVJWRURfU1BBQ0UoKSBv
ZiB0aGF0IGRldmljZSBwbHVzIHRoZSB0d28gbGVuZ3RoIGJ5dGVzLgoKVGVzdGVkIGluIGEgUUVN
VSBndWVzdCAoNi4xMi45NCwgS0FTQU4pIHdpdGggYnBxIGRldmljZXMgb24gZXRoMCwgb24KZXRo
MC42IChyZW9yZGVyX2hkciBvbikgYW5kIG9uIGV0aDAuNSAocmVvcmRlcl9oZHIgb2ZmKSwgZXRo
MCBiZWluZyBhCnZpcnRpby1uZXQgcG9ydCB3aXRob3V0IFZMQU4gdGFnIGluc2VydGlvbjogVUkg
ZnJhbWVzIHdpdGggMCwgNyBhbmQgOApkaWdpcGVhdGVycyBvbiBlYWNoLiBCZWZvcmUgdGhlIGNo
YW5nZSB0aGUgOCBkaWdpcGVhdGVyIGZyYW1lIG9uCmV0aDAuNSBwYW5pY2tlZCB0aGUgZ3Vlc3Qg
d2l0aCAxNSBieXRlcyBvZiBoZWFkcm9vbSBsZWZ0OyBhZnRlciBpdCwKNzkgYnl0ZXMgYXJlIGxl
ZnQgYW5kIGFsbCBmcmFtZXMgYXJlIHNlbnQsIHdpdGggbm8ga2VybmVsIHJlcG9ydC4KCkZpeGVz
OiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikKU2lnbmVkLW9mZi1ieTogQmVybmFy
ZCBQaWRvdXggPGJlcm5hcmQuZjZidnBAZ21haWwuY29tPgpBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUtNQooY2hlcnJ5IHBpY2tlZCBmcm9tIGNvbW1pdCA2YjdlMDc2N2I0NmQ5MThi
NWM4YTVhMmZiYjhhOWM4YTI1MzFkNjk4KQotLS0KIGRyaXZlcnMvbmV0L2hhbXJhZGlvL2JwcWV0
aGVyLmMgfCAyNSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
aGFtcmFkaW8vYnBxZXRoZXIuYyBiL2RyaXZlcnMvbmV0L2hhbXJhZGlvL2JwcWV0aGVyLmMKaW5k
ZXggZjMwNjE2ZDkxNWZkLi4xYWRiNTZhNWQ0YjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2hh
bXJhZGlvL2JwcWV0aGVyLmMKKysrIGIvZHJpdmVycy9uZXQvaGFtcmFkaW8vYnBxZXRoZXIuYwpA
QCAtMjM3LDEyICsyMzcsMjQgQEAgc3RhdGljIG5ldGRldl90eF90IGJwcV94bWl0KHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJc2tiX3B1bGwoc2tiLCAxKTsJ
CQkvKiBEcm9wIEtJU1MgYnl0ZSAqLwogCXNpemUgPSBza2ItPmxlbjsKIAorCWJwcSA9IG5ldGRl
dl9wcml2KGRldik7CisKKwlvcmlnX2RldiA9IGRldjsKKwlkZXYgPSBicHFfZ2V0X2V0aGVyX2Rl
dihkZXYpOworCWlmICghZGV2KSB7CisJCW9yaWdfZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7CisJ
CWtmcmVlX3NrYihza2IpOworCQlyZXR1cm4gTkVUREVWX1RYX09LOworCX0KKwogCS8qCiAJICog
V2UncmUgYWJvdXQgdG8gbWVzcyB3aXRoIHRoZSBza2Igd2hpY2ggbWF5IHN0aWxsIHNoYXJlZCB3
aXRoIHRoZQogCSAqIGdlbmVyaWMgbmV0d29ya2luZyBjb2RlIHNvIHVuc2hhcmUgYW5kIGVuc3Vy
ZSBpdCdzIGdvdCBlbm91Z2gKLQkgKiBzcGFjZSBmb3IgdGhlIEJQUSBoZWFkZXJzLgorCSAqIHNw
YWNlIGZvciB0aGUgbGVuZ3RoIGJ5dGVzIGFuZCBmb3IgdGhlIGxpbmsgbGF5ZXIgaGVhZGVyIG9m
IHRoZQorCSAqIEV0aGVybmV0IGRldmljZS4gVGhhdCBoZWFkZXIgY2FuIGJlIGxvbmdlciB0aGFu
IGFuIEV0aGVybmV0CisJICogaGVhZGVyLCBlLmcuIG9uIGEgVkxBTiBkZXZpY2UgdGhhdCBpbnNl
cnRzIHRoZSB0YWcgaXRzZWxmLgogCSAqLwotCWlmIChza2JfY293KHNrYiwgQVgyNV9CUFFfSEVB
REVSX0xFTikpIHsKKwlpZiAoc2tiX2Nvdyhza2IsIExMX1JFU0VSVkVEX1NQQUNFKGRldikgKyAy
KSkgewogCQlpZiAobmV0X3JhdGVsaW1pdCgpKQogCQkJcHJfZXJyKCJicHFldGhlcjogb3V0IG9m
IG1lbW9yeVxuIik7CiAJCWtmcmVlX3NrYihza2IpOwpAQCAtMjU1LDE1ICsyNjcsNiBAQCBzdGF0
aWMgbmV0ZGV2X3R4X3QgYnBxX3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9k
ZXZpY2UgKmRldikKIAkqcHRyKysgPSAoc2l6ZSArIDUpICUgMjU2OwogCSpwdHIrKyA9IChzaXpl
ICsgNSkgLyAyNTY7CiAKLQlicHEgPSBuZXRkZXZfcHJpdihkZXYpOwotCi0Jb3JpZ19kZXYgPSBk
ZXY7Ci0JaWYgKChkZXYgPSBicHFfZ2V0X2V0aGVyX2RldihkZXYpKSA9PSBOVUxMKSB7Ci0JCW9y
aWdfZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7Ci0JCWtmcmVlX3NrYihza2IpOwotCQlyZXR1cm4g
TkVUREVWX1RYX09LOwotCX0KLQogCXNrYi0+cHJvdG9jb2wgPSBheDI1X3R5cGVfdHJhbnMoc2ti
LCBkZXYpOwogCXNrYl9yZXNldF9uZXR3b3JrX2hlYWRlcihza2IpOwogCWRldl9oYXJkX2hlYWRl
cihza2IsIGRldiwgRVRIX1BfQlBRLCBicHEtPmRlc3RfYWRkciwgTlVMTCwgMCk7Ci0tIAoyLjUz
LjAKCkZyb20gOWM3OThjY2Q5OWNhNDI5ZjVlOWIzMDZmZDhjODJjYjNlMzAwMmI4YiBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDEKRnJvbTogQmVybmFyZCBQaWRvdXggPGJlcm5hcmQuZjZidnBAZ21h
aWwuY29tPgpEYXRlOiBGcmksIDEzIE5vdiAyMDI2IDEyOjUzOjAxICswMTAwClN1YmplY3Q6IFtQ
QVRDSCA2LjE4LnkgMi8zXSBicHFldGhlcjogc2V0IGJvdGggYWRkcmVzc2VzIG9yIG5vbmUgaW4K
IFNJT0NTQlBRRVRIQUREUgoKU0lPQ1NCUFFFVEhBRERSIGNvcGllcyB0aGUgZGVzdGluYXRpb24g
YWRkcmVzcyBzdHJhaWdodCBpbnRvIHRoZQpkZXZpY2UsIHRoZW4gdGhlIGFjY2VwdGVkIHNvdXJj
ZSBhZGRyZXNzLiBXaGVuIHRoZSBzZWNvbmQgY29weSBmYXVsdHMsCnRoZSBpb2N0bCByZXR1cm5z
IC1FRkFVTFQgYnV0IHRoZSBkZXN0aW5hdGlvbiBhZGRyZXNzIGhhcyBhbHJlYWR5IGJlZW4KY2hh
bmdlZCwgYW5kIGNvcHlfZnJvbV91c2VyKCkgaGFzIHplcm8tZmlsbGVkIHRoZSBwYXJ0IG9mIHRo
ZSBhY2NlcHRlZAphZGRyZXNzIGl0IGNvdWxkIG5vdCByZWFkLgoKV2l0aCB0aGUgYWNjZXB0ZWQg
YWRkcmVzcyBsZWZ0IGFzIDAwOjAwOjAwOjAwOjAwOjAwLCBicHFfcmN2KCkgZHJvcHMKZXZlcnkg
ZnJhbWUgd2hvc2Ugc291cmNlIGlzIG5vdCB0aGF0IGFkZHJlc3M6IHRoZSBkZXZpY2Ugc2lsZW50
bHkKc3RvcHMgcmVjZWl2aW5nIGFsdGhvdWdoIHRoZSBpb2N0bCByZXBvcnRlZCBhIGZhaWx1cmUu
CgpDb3B5IHRoZSB3aG9sZSBzdHJ1Y3QgYnBxX2V0aGFkZHIgdG8gdGhlIHN0YWNrIGZpcnN0IGFu
ZCBvbmx5IHVwZGF0ZQp0aGUgZGV2aWNlIG9uY2UgaXQgaGFzIGJlZW4gcmVhZCBpbiBmdWxsLgoK
VGVzdGVkIGluIGEgUUVNVSBndWVzdCAoNi4xMi45NCwgS0FTQU4pIGJ5IHBsYWNpbmcgdGhlIHN0
cnVjdCBzbyB0aGF0Cml0cyBhY2NlcHQgZmllbGQgZmFsbHMgaW4gYW4gdW5tYXBwZWQgcGFnZS4g
QmVmb3JlIHRoZSBjaGFuZ2UKL3Byb2MvbmV0L2JwcWV0aGVyIHNob3dlZCB0aGUgbmV3IGRlc3Rp
bmF0aW9uIGFuZCBhbiBhY2NlcHRlZCBhZGRyZXNzCm9mIDAwOjAwOjAwOjAwOjAwOjAwIGFmdGVy
IHRoZSAtRUZBVUxUOyBhZnRlciBpdCwgYm90aCBhZGRyZXNzZXMgYXJlCnVuY2hhbmdlZCwgYW5k
IGEgdmFsaWQgY2FsbCBzdGlsbCBzZXRzIHRoZW0uCgpGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGlu
dXgtMi42LjEyLXJjMiIpClNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgUGlkb3V4IDxiZXJuYXJkLmY2
YnZwQGdtYWlsLmNvbT4KQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy01LTUKKGNoZXJy
eSBwaWNrZWQgZnJvbSBjb21taXQgNDMxYmI3ZjRhN2QzNDdjY2RhMzIzMTlhYTM0NjM0NjY2NDg1
ODI4OSkKLS0tCiBkcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jIHwgOCArKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jIGIvZHJpdmVycy9uZXQvaGFtcmFk
aW8vYnBxZXRoZXIuYwppbmRleCAxYWRiNTZhNWQ0YjguLmZiMzJiZTEwNmUyMiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvaGFtcmFkaW8vYnBxZXRoZXIuYworKysgYi9kcml2ZXJzL25ldC9oYW1y
YWRpby9icHFldGhlci5jCkBAIC0yOTksOCArMjk5LDggQEAgc3RhdGljIGludCBicHFfc2V0X21h
Y19hZGRyZXNzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHZvaWQgKmFkZHIpCiBzdGF0aWMgaW50
IGJwcV9zaW9jZGV2cHJpdmF0ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgaWZyZXEg
KmlmciwKIAkJCSAgICAgIHZvaWQgX191c2VyICpkYXRhLCBpbnQgY21kKQogewotCXN0cnVjdCBi
cHFfZXRoYWRkciBfX3VzZXIgKmV0aGFkZHIgPSBkYXRhOwogCXN0cnVjdCBicHFkZXYgKmJwcSA9
IG5ldGRldl9wcml2KGRldik7CisJc3RydWN0IGJwcV9ldGhhZGRyIGV0aGFkZHI7CiAJc3RydWN0
IGJwcV9yZXEgcmVxOwogCiAJaWYgKCFjYXBhYmxlKENBUF9ORVRfQURNSU4pKQpAQCAtMzIwLDEw
ICszMjAsMTAgQEAgc3RhdGljIGludCBicHFfc2lvY2RldnByaXZhdGUoc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiwgc3RydWN0IGlmcmVxICppZnIsCiAJCQlicmVhazsKIAogCQljYXNlIFNJT0NTQlBR
RVRIQUREUjoKLQkJCWlmIChjb3B5X2Zyb21fdXNlcihicHEtPmRlc3RfYWRkciwgZXRoYWRkci0+
ZGVzdGluYXRpb24sIEVUSF9BTEVOKSkKLQkJCQlyZXR1cm4gLUVGQVVMVDsKLQkJCWlmIChjb3B5
X2Zyb21fdXNlcihicHEtPmFjcHRfYWRkciwgZXRoYWRkci0+YWNjZXB0LCBFVEhfQUxFTikpCisJ
CQlpZiAoY29weV9mcm9tX3VzZXIoJmV0aGFkZHIsIGRhdGEsIHNpemVvZihldGhhZGRyKSkpCiAJ
CQkJcmV0dXJuIC1FRkFVTFQ7CisJCQltZW1jcHkoYnBxLT5kZXN0X2FkZHIsIGV0aGFkZHIuZGVz
dGluYXRpb24sIEVUSF9BTEVOKTsKKwkJCW1lbWNweShicHEtPmFjcHRfYWRkciwgZXRoYWRkci5h
Y2NlcHQsIEVUSF9BTEVOKTsKIAkJCWJyZWFrOwogCiAJCWRlZmF1bHQ6Ci0tIAoyLjUzLjAKCkZy
b20gM2MwZmMzYWFlMTRiMWYzNzcyYzcxZTdiNzA4NWZmMDQ4OWU0MmJiYiBNb24gU2VwIDE3IDAw
OjAwOjAwIDIwMDEKRnJvbTogQmVybmFyZCBQaWRvdXggPGJlcm5hcmQuZjZidnBAZ21haWwuY29t
PgpEYXRlOiBGcmksIDEzIE5vdiAyMDI2IDEzOjEwOjQ3ICswMTAwClN1YmplY3Q6IFtQQVRDSCA2
LjE4LnkgMy8zXSBicHFldGhlcjoga2VlcCBhIGJwcSBkZXZpY2UgaW4gc3RlcCB3aXRoIGl0cwog
RXRoZXJuZXQgZGV2aWNlCgpXaGVuIHRoZSBFdGhlcm5ldCBkZXZpY2UgZ29lcyBkb3duLCBicHFf
ZGV2aWNlX2V2ZW50KCkgY2xvc2VzIHRoZSBicHEKZGV2aWNlIG9uIHRvcCBvZiBpdC4gVHdvIHRo
aW5ncyBhcmUgbGVmdCBvdmVyOgoKIC0gYnBxX29wZW4oKSBkb2VzIG5vdCBsb29rIGF0IHRoZSBF
dGhlcm5ldCBkZXZpY2UsIHNvIHRoZSBicHEgZGV2aWNlCiAgIGNhbiBiZSBicm91Z2h0IHVwIGFn
YWluIHdoaWxlIHRoZSBFdGhlcm5ldCBkZXZpY2UgaXMgc3RpbGwgZG93bi4KICAgRXZlcnkgZnJh
bWUgc2VudCB0aGVuIGNvdW50cyBpbiB0aGUgYnBxIGRldmljZSdzIHR4X3BhY2tldHMgd2hpbGUK
ICAgdGhlIEV0aGVybmV0IGRldmljZSBkcm9wcyBpdC4KCiAtIHdoZW4gdGhlIEV0aGVybmV0IGRl
dmljZSBjb21lcyBiYWNrIHVwLCB0aGUgYnBxIGRldmljZSBzdGF5cyBkb3duCiAgIGFuZCB0aGUg
QVguMjUgcG9ydCBoYXMgdG8gYmUgYnJvdWdodCB1cCBhZ2FpbiBieSBoYW5kLgoKUmVmdXNlIHRv
IG9wZW4gYSBicHEgZGV2aWNlIHdob3NlIEV0aGVybmV0IGRldmljZSBpcyBub3QgcnVubmluZywg
d2l0aAotRU5FVERPV04uIFJlbWVtYmVyIHRoYXQgYSBicHEgZGV2aWNlIHdhcyBjbG9zZWQgYmVj
YXVzZSBpdHMgRXRoZXJuZXQKZGV2aWNlIHdlbnQgZG93biwgYW5kIG9wZW4gaXQgYWdhaW4gb24g
TkVUREVWX1VQLiBBIGJwcSBkZXZpY2UgdGhhdAp3YXMgYWxyZWFkeSBkb3duLCBlLmcuIGNsb3Nl
ZCBieSB0aGUgYWRtaW5pc3RyYXRvciwgaXMgbGVmdCBhbG9uZS4KClRlc3RlZCBpbiBhIFFFTVUg
Z3Vlc3QgKDYuMTIuOTQsIEtBU0FOKSB3aXRoIGUxMDAwIHBvcnRzOgogLSBicHEyIGJyb3VnaHQg
dXAgd2l0aCBldGgyIGRvd246IGFjY2VwdGVkIGJlZm9yZSwgYW5kIDUgZnJhbWVzCiAgIGNvdW50
ZWQgaW4gdHhfcGFja2V0cyBvZiBicHEyIHdoaWxlIGV0aDIgZHJvcHBlZCB0aGVtOyAtRU5FVERP
V04KICAgYWZ0ZXIsIG5vdGhpbmcgY291bnRlZDsKIC0gZXRoMyBkb3duIHRoZW4gdXA6IGJwcTMg
c3RheWVkIGRvd24gYmVmb3JlLCBpcyB1cCBhZ2FpbiBhZnRlcjsKIC0gYnBxMSBjbG9zZWQgYnkg
aGFuZCwgdGhlbiBldGgxIGRvd24gYW5kIHVwOiBicHExIHN0YXlzIGRvd24sCiAgIGJlZm9yZSBh
bmQgYWZ0ZXIuCk5vIGtlcm5lbCByZXBvcnQgaW4gZWl0aGVyIGNhc2UuCgpGaXhlczogMWRhMTc3
ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpClNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgUGlkb3V4
IDxiZXJuYXJkLmY2YnZwQGdtYWlsLmNvbT4KQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1
cy01LTUKKGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQgODg4OTM1ZTljN2FhOGQ4ZGU2NmRkNzYx
MTFlZjA4NzVmOGM5MDY2MykKLS0tCiBkcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jIHwg
MjkgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2hhbXJh
ZGlvL2JwcWV0aGVyLmMgYi9kcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jCmluZGV4IGZi
MzJiZTEwNmUyMi4uMjAyYmRmYzE1Y2M2IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9oYW1yYWRp
by9icHFldGhlci5jCisrKyBiL2RyaXZlcnMvbmV0L2hhbXJhZGlvL2JwcWV0aGVyLmMKQEAgLTEw
NCw2ICsxMDQsNyBAQCBzdHJ1Y3QgYnBxZGV2IHsKIAlzdHJ1Y3QgbmV0X2RldmljZSAqYXhkZXY7
CS8qIGJwcSBkZXZpY2UgKGJwcSMpICovCiAJY2hhciAgIGRlc3RfYWRkcls2XTsJCS8qIGV0aGVy
IGRlc3RpbmF0aW9uIGFkZHJlc3MgKi8KIAljaGFyICAgYWNwdF9hZGRyWzZdOwkJLyogYWNjZXB0
IGV0aGVyIGZyYW1lcyBmcm9tIHRoaXMgYWRkcmVzcyBvbmx5ICovCisJYm9vbCAgIHJlb3BlbjsJ
CQkvKiBjbG9zZWQgYmVjYXVzZSB0aGUgZXRoZXIgZGV2aWNlIHdlbnQgZG93biAqLwogfTsKIAog
c3RhdGljIExJU1RfSEVBRChicHFfZGV2aWNlcyk7CkBAIC0zMzgsNiArMzM5LDExIEBAIHN0YXRp
YyBpbnQgYnBxX3Npb2NkZXZwcml2YXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBp
ZnJlcSAqaWZyLAogICovCiBzdGF0aWMgaW50IGJwcV9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpCiB7CisJc3RydWN0IGJwcWRldiAqYnBxID0gbmV0ZGV2X3ByaXYoZGV2KTsKKworCWlmICgh
bmV0aWZfcnVubmluZyhicHEtPmV0aGRldikpCisJCXJldHVybiAtRU5FVERPV047CisKIAluZXRp
Zl9zdGFydF9xdWV1ZShkZXYpOwogCXJldHVybiAwOwogfQpAQCAtNTEzLDYgKzUxOSw4IEBAIHN0
YXRpYyBpbnQgYnBxX2RldmljZV9ldmVudChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnRoaXMsCiAJ
CQkgICAgdW5zaWduZWQgbG9uZyBldmVudCwgdm9pZCAqcHRyKQogewogCXN0cnVjdCBuZXRfZGV2
aWNlICpkZXYgPSBuZXRkZXZfbm90aWZpZXJfaW5mb190b19kZXYocHRyKTsKKwlzdHJ1Y3QgbmV0
X2RldmljZSAqYXhkZXY7CisJc3RydWN0IGJwcWRldiAqYnBxOwogCiAJaWYgKCFuZXRfZXEoZGV2
X25ldChkZXYpLCAmaW5pdF9uZXQpKQogCQlyZXR1cm4gTk9USUZZX0RPTkU7CkBAIC01MjEsMTQg
KzUyOSwyNyBAQCBzdGF0aWMgaW50IGJwcV9kZXZpY2VfZXZlbnQoc3RydWN0IG5vdGlmaWVyX2Js
b2NrICp0aGlzLAogCQlyZXR1cm4gTk9USUZZX0RPTkU7CiAKIAlzd2l0Y2ggKGV2ZW50KSB7Ci0J
Y2FzZSBORVRERVZfVVA6CQkvKiBuZXcgZXRoZXJuZXQgZGV2aWNlIC0+IG5ldyBCUFEgaW50ZXJm
YWNlICovCi0JCWlmIChicHFfZ2V0X2F4MjVfZGV2KGRldikgPT0gTlVMTCkKKwljYXNlIE5FVERF
Vl9VUDoKKwkJYXhkZXYgPSBicHFfZ2V0X2F4MjVfZGV2KGRldik7CisJCWlmICghYXhkZXYpIHsJ
CS8qIG5ldyBldGhlcm5ldCBkZXZpY2UgLT4gbmV3IEJQUSBpbnRlcmZhY2UgKi8KIAkJCWJwcV9u
ZXdfZGV2aWNlKGRldik7CisJCQlicmVhazsKKwkJfQorCQkvKiByZW9wZW4gYSBCUFEgaW50ZXJm
YWNlIGNsb3NlZCB3aGVuIHRoZSBkZXZpY2Ugd2VudCBkb3duICovCisJCWJwcSA9IG5ldGRldl9w
cml2KGF4ZGV2KTsKKwkJaWYgKGJwcS0+cmVvcGVuKSB7CisJCQlicHEtPnJlb3BlbiA9IGZhbHNl
OworCQkJZGV2X29wZW4oYXhkZXYsIE5VTEwpOworCQl9CiAJCWJyZWFrOwogCiAJY2FzZSBORVRE
RVZfRE9XTjoJLyogZXRoZXJuZXQgZGV2aWNlIGNsb3NlZCAtPiBjbG9zZSBCUFEgaW50ZXJmYWNl
ICovCi0JCWlmICgoZGV2ID0gYnBxX2dldF9heDI1X2RldihkZXYpKSAhPSBOVUxMKQotCQkJZGV2
X2Nsb3NlKGRldik7CisJCWF4ZGV2ID0gYnBxX2dldF9heDI1X2RldihkZXYpOworCQlpZiAoYXhk
ZXYgJiYgbmV0aWZfcnVubmluZyhheGRldikpIHsKKwkJCWRldl9jbG9zZShheGRldik7CisJCQli
cHEgPSBuZXRkZXZfcHJpdihheGRldik7CisJCQlicHEtPnJlb3BlbiA9IHRydWU7CisJCX0KIAkJ
YnJlYWs7CiAKIAljYXNlIE5FVERFVl9VTlJFR0lTVEVSOgkvKiBldGhlcm5ldCBkZXZpY2UgcmVt
b3ZlZCAtPiBmcmVlIEJQUSBpbnRlcmZhY2UgKi8KLS0gCjIuNTMuMAoK
--000000000000240baa0660f0f332
Content-Type: application/mbox; name="bpqether-6.12.y.mbox"
Content-Disposition: attachment; filename="bpqether-6.12.y.mbox"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

RnJvbSBkOTRiNTNkZTZkZmRmNjExZWY1MTBjMmVjMzNmNTAwMGY5YWQ2YzZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZXJuYXJkIFBpZG91eCA8YmVybmFyZC5mNmJ2cEBnbWFpbC5j
b20+CkRhdGU6IEZyaSwgMTMgTm92IDIwMjYgMTI6NTM6MDEgKzAxMDAKU3ViamVjdDogW1BBVENI
IDYuMTIueSAxLzNdIGJwcWV0aGVyOiByZXNlcnZlIHRoZSBFdGhlcm5ldCBkZXZpY2UncyBvd24g
aGVhZGVyCiByb29tIG9uIHRyYW5zbWl0CgpicHFfeG1pdCgpIG1ha2VzIHN1cmUgdGhlIGZyYW1l
IGhhcyBBWDI1X0JQUV9IRUFERVJfTEVOICgxNikgYnl0ZXMgb2YKaGVhZHJvb20sIHRoZW4gcHVz
aGVzIHRoZSB0d28gbGVuZ3RoIGJ5dGVzIGFuZCBsZXRzIGRldl9oYXJkX2hlYWRlcigpCm9mIHRo
ZSB1bmRlcmx5aW5nIGRldmljZSBidWlsZCB0aGUgbGluayBsYXllciBoZWFkZXIuIFRoYXQgY292
ZXJzIGEKcGxhaW4gRXRoZXJuZXQgaGVhZGVyLCBidXQgbm90IGEgbG9uZ2VyIG9uZS4KCkEgVkxB
TiBkZXZpY2Ugb24gdG9wIG9mIGFuIEV0aGVybmV0IGRldmljZSB0aGF0IGNhbm5vdCBpbnNlcnQg
dGhlIHRhZwppbiBoYXJkd2FyZSwgd2l0aCByZW9yZGVyX2hkciB0dXJuZWQgb2ZmLCBwdXNoZXMg
YW4gMTggYnl0ZSBoZWFkZXIKKFZMQU4gdGFnLCB0aGVuIHRoZSBFdGhlcm5ldCBoZWFkZXIpLiBB
IFVJIGZyYW1lIHNlbnQgZnJvbSBhbiBBWC4yNQpkYXRhZ3JhbSBzb2NrZXQgd2l0aCA4IGRpZ2lw
ZWF0ZXJzIHJlYWNoZXMgYnBxX3htaXQoKSB3aXRoIDE3IGJ5dGVzIG9mCmhlYWRyb29tIG9uY2Ug
dGhlIEtJU1MgYnl0ZSBpcyBkcm9wcGVkOiBza2JfY293KCkgbGVhdmVzIGl0IGFsb25lLCAxNQpi
eXRlcyByZW1haW4gYWZ0ZXIgdGhlIGxlbmd0aCBieXRlcywgYW5kIGV0aF9oZWFkZXIoKSB1bmRl
cmZsb3dzIHRoZQpza2I6CgogIHNrYnVmZjogc2tiX3VuZGVyX3BhbmljOiAuLi4gbGVuOjEwMSBw
dXQ6MTQgLi4uIGRldjpldGgwLjUKICBrZXJuZWwgQlVHIGF0IG5ldC9jb3JlL3NrYnVmZi5jOjIw
OSEKICBDYWxsIFRyYWNlOgogICBldGhfaGVhZGVyCiAgIHZsYW5fZGV2X2hhcmRfaGVhZGVyCiAg
IGRldl9oYXJkX3N0YXJ0X3htaXQKICAgX19kZXZfcXVldWVfeG1pdAogICBheDI1X3NlbmRtc2cK
ICAgX19zeXNfc2VuZHRvCgpObyBwcml2aWxlZ2UgaXMgbmVlZGVkIHRvIG9wZW4gYW5kIGJpbmQg
c3VjaCBhIHNvY2tldCwgc28gYW55IGxvY2FsCnVzZXIgY2FuIGNyYXNoIGEgaG9zdCB0aGF0IHJ1
bnMgYnBxZXRoZXIgb3ZlciB0aGlzIGtpbmQgb2YgVkxBTi4KCkxvb2sgdXAgdGhlIEV0aGVybmV0
IGRldmljZSBmaXJzdCBhbmQgYXNrIHNrYl9jb3coKSBmb3IKTExfUkVTRVJWRURfU1BBQ0UoKSBv
ZiB0aGF0IGRldmljZSBwbHVzIHRoZSB0d28gbGVuZ3RoIGJ5dGVzLgoKVGVzdGVkIGluIGEgUUVN
VSBndWVzdCAoNi4xMi45NCwgS0FTQU4pIHdpdGggYnBxIGRldmljZXMgb24gZXRoMCwgb24KZXRo
MC42IChyZW9yZGVyX2hkciBvbikgYW5kIG9uIGV0aDAuNSAocmVvcmRlcl9oZHIgb2ZmKSwgZXRo
MCBiZWluZyBhCnZpcnRpby1uZXQgcG9ydCB3aXRob3V0IFZMQU4gdGFnIGluc2VydGlvbjogVUkg
ZnJhbWVzIHdpdGggMCwgNyBhbmQgOApkaWdpcGVhdGVycyBvbiBlYWNoLiBCZWZvcmUgdGhlIGNo
YW5nZSB0aGUgOCBkaWdpcGVhdGVyIGZyYW1lIG9uCmV0aDAuNSBwYW5pY2tlZCB0aGUgZ3Vlc3Qg
d2l0aCAxNSBieXRlcyBvZiBoZWFkcm9vbSBsZWZ0OyBhZnRlciBpdCwKNzkgYnl0ZXMgYXJlIGxl
ZnQgYW5kIGFsbCBmcmFtZXMgYXJlIHNlbnQsIHdpdGggbm8ga2VybmVsIHJlcG9ydC4KCkZpeGVz
OiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikKU2lnbmVkLW9mZi1ieTogQmVybmFy
ZCBQaWRvdXggPGJlcm5hcmQuZjZidnBAZ21haWwuY29tPgpBc3Npc3RlZC1ieTogQ2xhdWRlOmNs
YXVkZS1vcHVzLTUtNQooY2hlcnJ5IHBpY2tlZCBmcm9tIGNvbW1pdCA2YjdlMDc2N2I0NmQ5MThi
NWM4YTVhMmZiYjhhOWM4YTI1MzFkNjk4KQotLS0KIGRyaXZlcnMvbmV0L2hhbXJhZGlvL2JwcWV0
aGVyLmMgfCAyNSArKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
aGFtcmFkaW8vYnBxZXRoZXIuYyBiL2RyaXZlcnMvbmV0L2hhbXJhZGlvL2JwcWV0aGVyLmMKaW5k
ZXggZjAyNzIwNTM0N2QzLi5lYTZiZWU0NWUyYTQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2hh
bXJhZGlvL2JwcWV0aGVyLmMKKysrIGIvZHJpdmVycy9uZXQvaGFtcmFkaW8vYnBxZXRoZXIuYwpA
QCAtMjU3LDEyICsyNTcsMjQgQEAgc3RhdGljIG5ldGRldl90eF90IGJwcV94bWl0KHN0cnVjdCBz
a19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJc2tiX3B1bGwoc2tiLCAxKTsJ
CQkvKiBEcm9wIEtJU1MgYnl0ZSAqLwogCXNpemUgPSBza2ItPmxlbjsKIAorCWJwcSA9IG5ldGRl
dl9wcml2KGRldik7CisKKwlvcmlnX2RldiA9IGRldjsKKwlkZXYgPSBicHFfZ2V0X2V0aGVyX2Rl
dihkZXYpOworCWlmICghZGV2KSB7CisJCW9yaWdfZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7CisJ
CWtmcmVlX3NrYihza2IpOworCQlyZXR1cm4gTkVUREVWX1RYX09LOworCX0KKwogCS8qCiAJICog
V2UncmUgYWJvdXQgdG8gbWVzcyB3aXRoIHRoZSBza2Igd2hpY2ggbWF5IHN0aWxsIHNoYXJlZCB3
aXRoIHRoZQogCSAqIGdlbmVyaWMgbmV0d29ya2luZyBjb2RlIHNvIHVuc2hhcmUgYW5kIGVuc3Vy
ZSBpdCdzIGdvdCBlbm91Z2gKLQkgKiBzcGFjZSBmb3IgdGhlIEJQUSBoZWFkZXJzLgorCSAqIHNw
YWNlIGZvciB0aGUgbGVuZ3RoIGJ5dGVzIGFuZCBmb3IgdGhlIGxpbmsgbGF5ZXIgaGVhZGVyIG9m
IHRoZQorCSAqIEV0aGVybmV0IGRldmljZS4gVGhhdCBoZWFkZXIgY2FuIGJlIGxvbmdlciB0aGFu
IGFuIEV0aGVybmV0CisJICogaGVhZGVyLCBlLmcuIG9uIGEgVkxBTiBkZXZpY2UgdGhhdCBpbnNl
cnRzIHRoZSB0YWcgaXRzZWxmLgogCSAqLwotCWlmIChza2JfY293KHNrYiwgQVgyNV9CUFFfSEVB
REVSX0xFTikpIHsKKwlpZiAoc2tiX2Nvdyhza2IsIExMX1JFU0VSVkVEX1NQQUNFKGRldikgKyAy
KSkgewogCQlpZiAobmV0X3JhdGVsaW1pdCgpKQogCQkJcHJfZXJyKCJicHFldGhlcjogb3V0IG9m
IG1lbW9yeVxuIik7CiAJCWtmcmVlX3NrYihza2IpOwpAQCAtMjc1LDE1ICsyODcsNiBAQCBzdGF0
aWMgbmV0ZGV2X3R4X3QgYnBxX3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9k
ZXZpY2UgKmRldikKIAkqcHRyKysgPSAoc2l6ZSArIDUpICUgMjU2OwogCSpwdHIrKyA9IChzaXpl
ICsgNSkgLyAyNTY7CiAKLQlicHEgPSBuZXRkZXZfcHJpdihkZXYpOwotCi0Jb3JpZ19kZXYgPSBk
ZXY7Ci0JaWYgKChkZXYgPSBicHFfZ2V0X2V0aGVyX2RldihkZXYpKSA9PSBOVUxMKSB7Ci0JCW9y
aWdfZGV2LT5zdGF0cy50eF9kcm9wcGVkKys7Ci0JCWtmcmVlX3NrYihza2IpOwotCQlyZXR1cm4g
TkVUREVWX1RYX09LOwotCX0KLQogCXNrYi0+cHJvdG9jb2wgPSBheDI1X3R5cGVfdHJhbnMoc2ti
LCBkZXYpOwogCXNrYl9yZXNldF9uZXR3b3JrX2hlYWRlcihza2IpOwogCWRldl9oYXJkX2hlYWRl
cihza2IsIGRldiwgRVRIX1BfQlBRLCBicHEtPmRlc3RfYWRkciwgTlVMTCwgMCk7Ci0tIAoyLjUz
LjAKCkZyb20gNGJjMTQ5Yjg0N2I1NzdiNjY4ZjM4NTgyMGQ4ZjdhYzQ1YmJhMzc3ZCBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDEKRnJvbTogQmVybmFyZCBQaWRvdXggPGJlcm5hcmQuZjZidnBAZ21h
aWwuY29tPgpEYXRlOiBGcmksIDEzIE5vdiAyMDI2IDEyOjUzOjAxICswMTAwClN1YmplY3Q6IFtQ
QVRDSCA2LjEyLnkgMi8zXSBicHFldGhlcjogc2V0IGJvdGggYWRkcmVzc2VzIG9yIG5vbmUgaW4K
IFNJT0NTQlBRRVRIQUREUgoKU0lPQ1NCUFFFVEhBRERSIGNvcGllcyB0aGUgZGVzdGluYXRpb24g
YWRkcmVzcyBzdHJhaWdodCBpbnRvIHRoZQpkZXZpY2UsIHRoZW4gdGhlIGFjY2VwdGVkIHNvdXJj
ZSBhZGRyZXNzLiBXaGVuIHRoZSBzZWNvbmQgY29weSBmYXVsdHMsCnRoZSBpb2N0bCByZXR1cm5z
IC1FRkFVTFQgYnV0IHRoZSBkZXN0aW5hdGlvbiBhZGRyZXNzIGhhcyBhbHJlYWR5IGJlZW4KY2hh
bmdlZCwgYW5kIGNvcHlfZnJvbV91c2VyKCkgaGFzIHplcm8tZmlsbGVkIHRoZSBwYXJ0IG9mIHRo
ZSBhY2NlcHRlZAphZGRyZXNzIGl0IGNvdWxkIG5vdCByZWFkLgoKV2l0aCB0aGUgYWNjZXB0ZWQg
YWRkcmVzcyBsZWZ0IGFzIDAwOjAwOjAwOjAwOjAwOjAwLCBicHFfcmN2KCkgZHJvcHMKZXZlcnkg
ZnJhbWUgd2hvc2Ugc291cmNlIGlzIG5vdCB0aGF0IGFkZHJlc3M6IHRoZSBkZXZpY2Ugc2lsZW50
bHkKc3RvcHMgcmVjZWl2aW5nIGFsdGhvdWdoIHRoZSBpb2N0bCByZXBvcnRlZCBhIGZhaWx1cmUu
CgpDb3B5IHRoZSB3aG9sZSBzdHJ1Y3QgYnBxX2V0aGFkZHIgdG8gdGhlIHN0YWNrIGZpcnN0IGFu
ZCBvbmx5IHVwZGF0ZQp0aGUgZGV2aWNlIG9uY2UgaXQgaGFzIGJlZW4gcmVhZCBpbiBmdWxsLgoK
VGVzdGVkIGluIGEgUUVNVSBndWVzdCAoNi4xMi45NCwgS0FTQU4pIGJ5IHBsYWNpbmcgdGhlIHN0
cnVjdCBzbyB0aGF0Cml0cyBhY2NlcHQgZmllbGQgZmFsbHMgaW4gYW4gdW5tYXBwZWQgcGFnZS4g
QmVmb3JlIHRoZSBjaGFuZ2UKL3Byb2MvbmV0L2JwcWV0aGVyIHNob3dlZCB0aGUgbmV3IGRlc3Rp
bmF0aW9uIGFuZCBhbiBhY2NlcHRlZCBhZGRyZXNzCm9mIDAwOjAwOjAwOjAwOjAwOjAwIGFmdGVy
IHRoZSAtRUZBVUxUOyBhZnRlciBpdCwgYm90aCBhZGRyZXNzZXMgYXJlCnVuY2hhbmdlZCwgYW5k
IGEgdmFsaWQgY2FsbCBzdGlsbCBzZXRzIHRoZW0uCgpGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGlu
dXgtMi42LjEyLXJjMiIpClNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgUGlkb3V4IDxiZXJuYXJkLmY2
YnZwQGdtYWlsLmNvbT4KQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy01LTUKKGNoZXJy
eSBwaWNrZWQgZnJvbSBjb21taXQgNDMxYmI3ZjRhN2QzNDdjY2RhMzIzMTlhYTM0NjM0NjY2NDg1
ODI4OSkKLS0tCiBkcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jIHwgOCArKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jIGIvZHJpdmVycy9uZXQvaGFtcmFk
aW8vYnBxZXRoZXIuYwppbmRleCBlYTZiZWU0NWUyYTQuLjRhMDRjM2I0YmRiOSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvaGFtcmFkaW8vYnBxZXRoZXIuYworKysgYi9kcml2ZXJzL25ldC9oYW1y
YWRpby9icHFldGhlci5jCkBAIC0zMTksOCArMzE5LDggQEAgc3RhdGljIGludCBicHFfc2V0X21h
Y19hZGRyZXNzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHZvaWQgKmFkZHIpCiBzdGF0aWMgaW50
IGJwcV9zaW9jZGV2cHJpdmF0ZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgaWZyZXEg
KmlmciwKIAkJCSAgICAgIHZvaWQgX191c2VyICpkYXRhLCBpbnQgY21kKQogewotCXN0cnVjdCBi
cHFfZXRoYWRkciBfX3VzZXIgKmV0aGFkZHIgPSBkYXRhOwogCXN0cnVjdCBicHFkZXYgKmJwcSA9
IG5ldGRldl9wcml2KGRldik7CisJc3RydWN0IGJwcV9ldGhhZGRyIGV0aGFkZHI7CiAJc3RydWN0
IGJwcV9yZXEgcmVxOwogCiAJaWYgKCFjYXBhYmxlKENBUF9ORVRfQURNSU4pKQpAQCAtMzQwLDEw
ICszNDAsMTAgQEAgc3RhdGljIGludCBicHFfc2lvY2RldnByaXZhdGUoc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiwgc3RydWN0IGlmcmVxICppZnIsCiAJCQlicmVhazsKIAogCQljYXNlIFNJT0NTQlBR
RVRIQUREUjoKLQkJCWlmIChjb3B5X2Zyb21fdXNlcihicHEtPmRlc3RfYWRkciwgZXRoYWRkci0+
ZGVzdGluYXRpb24sIEVUSF9BTEVOKSkKLQkJCQlyZXR1cm4gLUVGQVVMVDsKLQkJCWlmIChjb3B5
X2Zyb21fdXNlcihicHEtPmFjcHRfYWRkciwgZXRoYWRkci0+YWNjZXB0LCBFVEhfQUxFTikpCisJ
CQlpZiAoY29weV9mcm9tX3VzZXIoJmV0aGFkZHIsIGRhdGEsIHNpemVvZihldGhhZGRyKSkpCiAJ
CQkJcmV0dXJuIC1FRkFVTFQ7CisJCQltZW1jcHkoYnBxLT5kZXN0X2FkZHIsIGV0aGFkZHIuZGVz
dGluYXRpb24sIEVUSF9BTEVOKTsKKwkJCW1lbWNweShicHEtPmFjcHRfYWRkciwgZXRoYWRkci5h
Y2NlcHQsIEVUSF9BTEVOKTsKIAkJCWJyZWFrOwogCiAJCWRlZmF1bHQ6Ci0tIAoyLjUzLjAKCkZy
b20gMzBhNTM0MjBmZTg5YWM0NjQyNTA4YzUwNTFlMWNlNDA3OWExY2RlNiBNb24gU2VwIDE3IDAw
OjAwOjAwIDIwMDEKRnJvbTogQmVybmFyZCBQaWRvdXggPGJlcm5hcmQuZjZidnBAZ21haWwuY29t
PgpEYXRlOiBGcmksIDEzIE5vdiAyMDI2IDEzOjEwOjQ3ICswMTAwClN1YmplY3Q6IFtQQVRDSCA2
LjEyLnkgMy8zXSBicHFldGhlcjoga2VlcCBhIGJwcSBkZXZpY2UgaW4gc3RlcCB3aXRoIGl0cwog
RXRoZXJuZXQgZGV2aWNlCgpXaGVuIHRoZSBFdGhlcm5ldCBkZXZpY2UgZ29lcyBkb3duLCBicHFf
ZGV2aWNlX2V2ZW50KCkgY2xvc2VzIHRoZSBicHEKZGV2aWNlIG9uIHRvcCBvZiBpdC4gVHdvIHRo
aW5ncyBhcmUgbGVmdCBvdmVyOgoKIC0gYnBxX29wZW4oKSBkb2VzIG5vdCBsb29rIGF0IHRoZSBF
dGhlcm5ldCBkZXZpY2UsIHNvIHRoZSBicHEgZGV2aWNlCiAgIGNhbiBiZSBicm91Z2h0IHVwIGFn
YWluIHdoaWxlIHRoZSBFdGhlcm5ldCBkZXZpY2UgaXMgc3RpbGwgZG93bi4KICAgRXZlcnkgZnJh
bWUgc2VudCB0aGVuIGNvdW50cyBpbiB0aGUgYnBxIGRldmljZSdzIHR4X3BhY2tldHMgd2hpbGUK
ICAgdGhlIEV0aGVybmV0IGRldmljZSBkcm9wcyBpdC4KCiAtIHdoZW4gdGhlIEV0aGVybmV0IGRl
dmljZSBjb21lcyBiYWNrIHVwLCB0aGUgYnBxIGRldmljZSBzdGF5cyBkb3duCiAgIGFuZCB0aGUg
QVguMjUgcG9ydCBoYXMgdG8gYmUgYnJvdWdodCB1cCBhZ2FpbiBieSBoYW5kLgoKUmVmdXNlIHRv
IG9wZW4gYSBicHEgZGV2aWNlIHdob3NlIEV0aGVybmV0IGRldmljZSBpcyBub3QgcnVubmluZywg
d2l0aAotRU5FVERPV04uIFJlbWVtYmVyIHRoYXQgYSBicHEgZGV2aWNlIHdhcyBjbG9zZWQgYmVj
YXVzZSBpdHMgRXRoZXJuZXQKZGV2aWNlIHdlbnQgZG93biwgYW5kIG9wZW4gaXQgYWdhaW4gb24g
TkVUREVWX1VQLiBBIGJwcSBkZXZpY2UgdGhhdAp3YXMgYWxyZWFkeSBkb3duLCBlLmcuIGNsb3Nl
ZCBieSB0aGUgYWRtaW5pc3RyYXRvciwgaXMgbGVmdCBhbG9uZS4KClRlc3RlZCBpbiBhIFFFTVUg
Z3Vlc3QgKDYuMTIuOTQsIEtBU0FOKSB3aXRoIGUxMDAwIHBvcnRzOgogLSBicHEyIGJyb3VnaHQg
dXAgd2l0aCBldGgyIGRvd246IGFjY2VwdGVkIGJlZm9yZSwgYW5kIDUgZnJhbWVzCiAgIGNvdW50
ZWQgaW4gdHhfcGFja2V0cyBvZiBicHEyIHdoaWxlIGV0aDIgZHJvcHBlZCB0aGVtOyAtRU5FVERP
V04KICAgYWZ0ZXIsIG5vdGhpbmcgY291bnRlZDsKIC0gZXRoMyBkb3duIHRoZW4gdXA6IGJwcTMg
c3RheWVkIGRvd24gYmVmb3JlLCBpcyB1cCBhZ2FpbiBhZnRlcjsKIC0gYnBxMSBjbG9zZWQgYnkg
aGFuZCwgdGhlbiBldGgxIGRvd24gYW5kIHVwOiBicHExIHN0YXlzIGRvd24sCiAgIGJlZm9yZSBh
bmQgYWZ0ZXIuCk5vIGtlcm5lbCByZXBvcnQgaW4gZWl0aGVyIGNhc2UuCgpGaXhlczogMWRhMTc3
ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpClNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgUGlkb3V4
IDxiZXJuYXJkLmY2YnZwQGdtYWlsLmNvbT4KQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1
cy01LTUKKGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQgODg4OTM1ZTljN2FhOGQ4ZGU2NmRkNzYx
MTFlZjA4NzVmOGM5MDY2MykKLS0tCiBkcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jIHwg
MjkgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2hhbXJh
ZGlvL2JwcWV0aGVyLmMgYi9kcml2ZXJzL25ldC9oYW1yYWRpby9icHFldGhlci5jCmluZGV4IDRh
MDRjM2I0YmRiOS4uNDFiMTQ1NjkzZmY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9oYW1yYWRp
by9icHFldGhlci5jCisrKyBiL2RyaXZlcnMvbmV0L2hhbXJhZGlvL2JwcWV0aGVyLmMKQEAgLTEw
Myw2ICsxMDMsNyBAQCBzdHJ1Y3QgYnBxZGV2IHsKIAlzdHJ1Y3QgbmV0X2RldmljZSAqYXhkZXY7
CS8qIGJwcSBkZXZpY2UgKGJwcSMpICovCiAJY2hhciAgIGRlc3RfYWRkcls2XTsJCS8qIGV0aGVy
IGRlc3RpbmF0aW9uIGFkZHJlc3MgKi8KIAljaGFyICAgYWNwdF9hZGRyWzZdOwkJLyogYWNjZXB0
IGV0aGVyIGZyYW1lcyBmcm9tIHRoaXMgYWRkcmVzcyBvbmx5ICovCisJYm9vbCAgIHJlb3BlbjsJ
CQkvKiBjbG9zZWQgYmVjYXVzZSB0aGUgZXRoZXIgZGV2aWNlIHdlbnQgZG93biAqLwogfTsKIAog
c3RhdGljIExJU1RfSEVBRChicHFfZGV2aWNlcyk7CkBAIC0zNTgsNiArMzU5LDExIEBAIHN0YXRp
YyBpbnQgYnBxX3Npb2NkZXZwcml2YXRlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBp
ZnJlcSAqaWZyLAogICovCiBzdGF0aWMgaW50IGJwcV9vcGVuKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpCiB7CisJc3RydWN0IGJwcWRldiAqYnBxID0gbmV0ZGV2X3ByaXYoZGV2KTsKKworCWlmICgh
bmV0aWZfcnVubmluZyhicHEtPmV0aGRldikpCisJCXJldHVybiAtRU5FVERPV047CisKIAluZXRp
Zl9zdGFydF9xdWV1ZShkZXYpOwogCXJldHVybiAwOwogfQpAQCAtNTMyLDYgKzUzOCw4IEBAIHN0
YXRpYyBpbnQgYnBxX2RldmljZV9ldmVudChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnRoaXMsCiAJ
CQkgICAgdW5zaWduZWQgbG9uZyBldmVudCwgdm9pZCAqcHRyKQogewogCXN0cnVjdCBuZXRfZGV2
aWNlICpkZXYgPSBuZXRkZXZfbm90aWZpZXJfaW5mb190b19kZXYocHRyKTsKKwlzdHJ1Y3QgbmV0
X2RldmljZSAqYXhkZXY7CisJc3RydWN0IGJwcWRldiAqYnBxOwogCiAJaWYgKCFuZXRfZXEoZGV2
X25ldChkZXYpLCAmaW5pdF9uZXQpKQogCQlyZXR1cm4gTk9USUZZX0RPTkU7CkBAIC01NDAsMTQg
KzU0OCwyNyBAQCBzdGF0aWMgaW50IGJwcV9kZXZpY2VfZXZlbnQoc3RydWN0IG5vdGlmaWVyX2Js
b2NrICp0aGlzLAogCQlyZXR1cm4gTk9USUZZX0RPTkU7CiAKIAlzd2l0Y2ggKGV2ZW50KSB7Ci0J
Y2FzZSBORVRERVZfVVA6CQkvKiBuZXcgZXRoZXJuZXQgZGV2aWNlIC0+IG5ldyBCUFEgaW50ZXJm
YWNlICovCi0JCWlmIChicHFfZ2V0X2F4MjVfZGV2KGRldikgPT0gTlVMTCkKKwljYXNlIE5FVERF
Vl9VUDoKKwkJYXhkZXYgPSBicHFfZ2V0X2F4MjVfZGV2KGRldik7CisJCWlmICghYXhkZXYpIHsJ
CS8qIG5ldyBldGhlcm5ldCBkZXZpY2UgLT4gbmV3IEJQUSBpbnRlcmZhY2UgKi8KIAkJCWJwcV9u
ZXdfZGV2aWNlKGRldik7CisJCQlicmVhazsKKwkJfQorCQkvKiByZW9wZW4gYSBCUFEgaW50ZXJm
YWNlIGNsb3NlZCB3aGVuIHRoZSBkZXZpY2Ugd2VudCBkb3duICovCisJCWJwcSA9IG5ldGRldl9w
cml2KGF4ZGV2KTsKKwkJaWYgKGJwcS0+cmVvcGVuKSB7CisJCQlicHEtPnJlb3BlbiA9IGZhbHNl
OworCQkJZGV2X29wZW4oYXhkZXYsIE5VTEwpOworCQl9CiAJCWJyZWFrOwogCiAJY2FzZSBORVRE
RVZfRE9XTjoJLyogZXRoZXJuZXQgZGV2aWNlIGNsb3NlZCAtPiBjbG9zZSBCUFEgaW50ZXJmYWNl
ICovCi0JCWlmICgoZGV2ID0gYnBxX2dldF9heDI1X2RldihkZXYpKSAhPSBOVUxMKQotCQkJZGV2
X2Nsb3NlKGRldik7CisJCWF4ZGV2ID0gYnBxX2dldF9heDI1X2RldihkZXYpOworCQlpZiAoYXhk
ZXYgJiYgbmV0aWZfcnVubmluZyhheGRldikpIHsKKwkJCWRldl9jbG9zZShheGRldik7CisJCQli
cHEgPSBuZXRkZXZfcHJpdihheGRldik7CisJCQlicHEtPnJlb3BlbiA9IHRydWU7CisJCX0KIAkJ
YnJlYWs7CiAKIAljYXNlIE5FVERFVl9VTlJFR0lTVEVSOgkvKiBldGhlcm5ldCBkZXZpY2UgcmVt
b3ZlZCAtPiBmcmVlIEJQUSBpbnRlcmZhY2UgKi8KLS0gCjIuNTMuMAoK
--000000000000240baa0660f0f332--
