Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EA449B3D
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090192; cv=pass; b=PXbWFg96gCsvUANKAy/1RITyLp9D+tgTkR4urG/qMH6fmdZGr1JHllh2lOBtBoT+ok+lPA+i6Gr8+AoDybPIpUVLPFIKoILEYDLommIZOeoAFW4PCumyHmzuRyAgnmxtjCUt1K1Y5LlMueKGGMNpRPU6zFhSmDL0GH1uevBHCbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090192; c=relaxed/simple;
	bh=J9a5DstCnxZYXzmg6yWqhuOD+K9GtUtdfCbFAntNdlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPwrQFa5QbXB206PkXLUnisNz6i7EmFEL5C/m8E7PLYLLn42P9FhcBS983H1VIggjCeoiO4ICp2j9YZB8IvytpApUikFO8SRln8fvIf8kxjIDbamhkVhF1Y1YZMl2IXwTq5AIjqtq6vtflM7rpfqE07NnmzkKw1mdkWqna5PSUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtVO7QSp; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtVO7QSp"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab43af5e97so3675237b3.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792090182; cv=none;
        d=google.com; s=arc-20260327;
        b=j+5+pBEvUerXOBjQJMTWy/nYyXCg4BTRKEM6EKK9yLijD3CJBH0mdaNzp/u+FLEZZ+
         ftcQ4851YLw9onpnacAUQkNeXvaVAAClBEAEV0yXM3Sqh0WSnA7bBBbuZeGoauVFAs/i
         r+ZMzCDoXeOo4o6cRoEF2/0dDj59lUtVcuWcCbUX88OkMd2xcIyvpstdi0qCqwbicL2G
         rK/etb6eoQBnPTdiaVe5fWxCeDOk9eTOQd+CugK8Fzz7wASKkXRVb1b7fFQW9ShtUeH3
         UJ6rb4bBtl+GJuo7zz24dno6myB77L1XPCVYObOU4Ad9qHwD1E/z7dJrDNMx5hBQlWHa
         kEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J9a5DstCnxZYXzmg6yWqhuOD+K9GtUtdfCbFAntNdlA=;
        fh=286trl//ypaJuovy4/xk9GAsqasVoIqHd3lsPXcOe/Y=;
        b=gMh97ioBNxrBqDvzR8nuczQiPtg4gs3wmpO5R1fwAMapT/nzoJmqaOvcQisGgAp2Tg
         9LC8J5up+ZWYZhBNAQ/JOsUjqijUDc+IcNgCxxaq6Ye9gatTpQrndupmunba/mZQCfCG
         /nqlvN9FNPqYxqI7VWzD7uIw83w2r0qV40psLmi4s77vU1VA/v6E0kslYXIfNX0Og05Y
         q5D/GS9Awn7+BPofkjOrSolhj7UDu6id48RHKs2hzOZU3dBSdXvMzFVC/8Su48YRlzpg
         45TtStFlw7iM55bxDqmCQNo+omeUJKETJajk8saqc1UtgitRq6JC3BtyyrKdEIfsLV7t
         SF5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792090182; x=1792694982; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9a5DstCnxZYXzmg6yWqhuOD+K9GtUtdfCbFAntNdlA=;
        b=HtVO7QSpigQpQpzkSINdNrmhHoDJsJNw5vOrWa9Y0ZqMkrl/S/6L4jqte4h817ZOU8
         1Neo4cBPhF/X1oxcftOCDcQo7gPw9j5MgF1EqgQQhVNdbko5yIOFoaU5tbd6vu8DtYmQ
         O3Wov0dXqHXHl6U4yDeXL9sVp+4D6mzL3MPGjh7siV1AKm4u55EYJCQzYtkauwzyJoYe
         37n5kyiz4nTdyHWYV5DCjrvbIsdlyQcZfZYLRMvt/SJosG3HHC+SWCFoLDswkmE175r9
         nIdxrvmRYpasn90mUq79IbRe5ZNgr+/n8yuNf63VHDtxgw/vHsggRslQeSa2khIiVuHt
         1nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792090182; x=1792694982;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J9a5DstCnxZYXzmg6yWqhuOD+K9GtUtdfCbFAntNdlA=;
        b=vevF5LmRJP6OR3vEPdhxPBIT6VaJQ1O/DEKMt3wwqkvWCZxHDM/dHEtNh8ERll20vG
         HwxOuzuo5yD51hVLUr6q1enyjHMIqLM4VOsSmnLEPvISYq5pks+yKueQQfTri4sHbGLo
         /LDd4Voj9ZiYlMaNOdsnAGY3y71/vsV6IG4WkE3fSYXrmRPi1incegI9WryBJtwAY3ke
         LXSBi5/ACPB+1OIvrTTrvPhqRFYdSm2lvmk5aKAJOVappjQqyEa04k5G4oHq8PckxWiY
         Nq7/56HgS/K+oek3IPekqi6E8j5pTEyYms+S9BtF90oyDlYJ75Mp4hqcCX9S7wLllx2w
         mXag==
X-Gm-Message-State: AFq9FYL5e/AcaIlsH3gsja9w7x1KWfiqrd91U0IOiyvTqsKaBjBiv2/T
	PELhH94VXz3aQf/ZihFtA802hQr4betfosJE1ZS9oVtlYXKOWMSuabkqsfiGM8aY2d+iGk+VTRj
	YmOkdagbZEiJOqMCGv1MI3uu5E7qFhTM=
X-Gm-Gg: AYBFou1gv+iCOUKIPQdmtjJwMdilvzWxZPK2IRHxqOHR2lWfdRcVCrPKQekpnSWmSZN
	o0ydmbIKsGzYlXOG93HN/R1I3TXFfuUIG4+QtuKeaXUV+lnT1/xtuAQzn6uiSyeWy53jUiL05O5
	CTuTfwe3mYA1oUEngN1SA5rBC3rjzjmBuC2qQea1JytMQM9DWQchEfrgFKxcOmBKaf+EW+ocshf
	dAAgqZhSzzRcSDeQmHPEvduOhrT9f/QkXcFc0siNO7rhif921JaibKH9ib+nWxm/B4vuq17htQ1
	UDPGGFYIBf6863q3/dG03bg9gFfh9tPhW+DLSuJvzQCyN0piD00/d3M=
X-Received: by 2002:a05:690c:95:b0:873:5c7b:c136 with SMTP id
 00721157ae682-8b0e2e1e84fmr3010797b3.30.1792090182142; Thu, 15 Oct 2026
 11:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
 <2026061625-starless-mascot-691a@gregkh> <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com>
 <2026062048-posted-scarf-dcf2@gregkh> <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
 <2026062051-doorframe-crayon-d390@gregkh> <CAFAa3YCJXV9uW==2776dbfNFH4PhBPUYnTxDJ2xs7kn0b=4UTA@mail.gmail.com>
 <2026062543-think-rocker-6e19@gregkh> <CAFAa3YAkgv9t==Xeh4hqTVCq3+hN1igwqWXPOu3gHmD54Wd2Kw@mail.gmail.com>
 <CAFAa3YBDK8_va32Zi3myUsEhwNs20xnejO49m_06xOo3z3cK2Q@mail.gmail.com> <2026093015-outmost-shrimp-45f8@gregkh>
In-Reply-To: <2026093015-outmost-shrimp-45f8@gregkh>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Thu, 15 Oct 2026 20:49:30 +0200
X-Gm-Features: AclHuK-FJkHngppdK6vjbkTc-PZd_b-JmF9M8Y7b-vjR_VH3dg1NEV3cvrsZuGk
Message-ID: <CAFAa3YCEOWvxm3q8k9BXn5SVH4oAZj+b1hH=zwU8T9yCw02j2w@mail.gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, sashal@kernel.org, kuba@kernel.org, 
	linux-hams@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b6a0f8065de58205"

--000000000000b6a0f8065de58205
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

One more ROSE fix for 6.18.y, and this one matters: it fixes a
regression from one of my own earlier patches.

Commit df12be096302 ("rose: release netdev ref and destroy orphaned
incoming sockets"), which is in 6.18.y, lets the heartbeat free an
incoming socket whose call was cleared before accept(), while the call's
skb still sits on the listener's queue pointing at it. Closing the
listener, or a later accept(), then touches the freed socket. On a KASAN
kernel this shows as a slab-use-after-free in rose_destroy_socket()
followed by a kernel panic; on a stock 6.1 i686 kernel with the same
module code it is a plain NULL pointer Oops and panic.

The fix, "rose: hold a reference on incoming sockets queued for
accept()", is now merged in linux-netdev/mod-orphan as commit
6b0223a4795f5db52dee038a7a29e9906122b0f7, and that is the id in the
"(cherry picked from commit ...)" trailer of the attached mbox. It
applies cleanly with "git am" on top of v6.18.57 (no conflicts, no
fuzz). It has been running on six production nodes (x86_64, arm64 and
32-bit armv7) since late September with no further reports.

6.12.y does not need it: Sasha dropped df12be096302 from the 6.12 queue
after my report, and the 6.12.y heartbeat code (checked on v6.12.113)
does not reap these sockets, so the bug is not there.

Thanks again,
Bernard, F6BVP


Le mer. 30 sept. 2026 =C3=A0 16:25, Greg KH <gregkh@linuxfoundation.org> a =
=C3=A9crit :
>
> On Sat, Sep 12, 2026 at 01:16:56PM +0200, Bernard Pidoux wrote:
> > Hi Greg,
> >
> > While that 6.12.y batch is pending review, here are four more independe=
nt
> > ROSE fixes for 6.18.y, which already carries the earlier fifteen-patch
> > series. (I notice 7.0.y no longer appears on the stable releases page -=
- I
> > assume it is EOL now that 7.1 is out, so I am not including it here; le=
t me
> > know if you would still like a copy for it.) Each is a single
> > self-contained commit, already reviewed and merged in
> > linux-netdev/mod-orphan (where AX.25/ROSE/NetRom now live since their
> > removal from mainline in 7.1):
> >
> > - Patch 1 closes a routing-loop amplification bug: rose_route_frame()
> > deleted the route for an incoming CALL REQUEST before checking whether =
it
> > was a routing loop, so two nodes whose routes pointed at each other wou=
ld
> > relay the same call back and forth as fast as the CPU allowed. Observed=
 in
> > production: 204 million frames over nine days on a link that normally
> > carries a few frames per minute.
> >
> > - Patch 2 fixes a NULL pointer dereference:
> > rose_kick()/rose_write_internal() could reach rose_transmit_link() with=
 a
> > NULL neighbour once the state machines clear it. Reproduced on a live B=
BS
> > node.
> >
> > - Patch 3 closes a use-after-free that matches an open syzbot report (K=
ASAN
> > slab-use-after-free in ax25_find_cb()) which had resisted bisection: th=
e
> > self-rearming t0timer could fire again on freed memory even after
> > timer_delete_sync(), which only guarantees the callback is not running =
at
> > the moment it returns.
> >
> > - Patch 4 silences two harmless "unknown %02X in state 3" warnings (str=
ay
> > CALL_ACCEPTED / CLEAR_CONFIRMATION) that are routinely dropped anyway a=
nd
> > alarm sysops watching the console for no reason.
> >
> > Attached is the mbox: all four apply cleanly with "git am" against the
> > current head of 6.18.y (no conflicts, no fuzz). Each patch carries a
> > "(cherry picked from commit <id>)" trailer pointing at the exact mod-or=
phan
> > git id.
>
> All now applied, thanks.
>
> greg k-h

--000000000000b6a0f8065de58205
Content-Type: application/mbox; name="rose-pr25-6.18.y.mbox"
Content-Disposition: attachment; filename="rose-pr25-6.18.y.mbox"
Content-Transfer-Encoding: base64
Content-ID: <f_mv9w7hgv0>
X-Attachment-Id: f_mv9w7hgv0

RnJvbSBiMWU5YzRjYjExYWQ4OWIxYzE1NjJjZjVkYTA1ZTczYzBiMzdiMWZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZXJuYXJkIFBpZG91eCA8YmVybmFyZC5mNmJ2cEBnbWFpbC5j
b20+CkRhdGU6IFNhdCwgMjYgU2VwIDIwMjYgMTI6Mzg6NDAgKzAyMDAKU3ViamVjdDogW1BBVENI
XSByb3NlOiBob2xkIGEgcmVmZXJlbmNlIG9uIGluY29taW5nIHNvY2tldHMgcXVldWVkIGZvcgog
YWNjZXB0KCkKCnJvc2VfcnhfY2FsbF9yZXF1ZXN0KCkgY3JlYXRlcyB0aGUgc29ja2V0IGZvciBh
biBpbmNvbWluZyBjYWxsIGFuZApxdWV1ZXMgdGhlIGNhbGwncyBza2Igb24gdGhlIGxpc3Rlbmlu
ZyBzb2NrZXQgd2l0aCBza2ItPnNrIHBvaW50aW5nIGF0Cml0LCB3aXRob3V0IHRha2luZyBhIHJl
ZmVyZW5jZS4gSWYgdGhlIGNhbGxlciBjbGVhcnMgdGhlIGNhbGwgYmVmb3JlCml0IGlzIGFjY2Vw
dGVkLCByb3NlX2Rpc2Nvbm5lY3QoKSBsZWF2ZXMgdGhhdCBzb2NrZXQgaW4gU1RBVEVfMCB3aXRo
ClNPQ0tfREVBRCBzZXQsIGFuZCBzaW5jZSBjb21taXQgInJvc2U6IHJlbGVhc2UgbmV0ZGV2IHJl
ZiBhbmQgZGVzdHJveQpvcnBoYW5lZCBpbmNvbWluZyBzb2NrZXRzIiByb3NlX2hlYXJ0YmVhdF9l
eHBpcnkoKSByZWFwcyBzdWNoIG9ycGhhbmVkCnNvY2tldHMgYW5kIGZyZWVzIHRoZW0uIFRoZSBz
a2Igc3RheXMgb24gdGhlIGxpc3RlbmVyJ3MgcXVldWUsIHNvOgoKLSBjbG9zaW5nIHRoZSBsaXN0
ZW5lciBtYWtlcyByb3NlX2Rlc3Ryb3lfc29ja2V0KCkgd2FsayBpdHMgcXVldWUgYW5kCiAgc2V0
IGZsYWdzIGFuZCByZXN0YXJ0IHRoZSBoZWFydGJlYXQgb24gdGhlIGZyZWVkIHNvY2tldDsKLSBh
Y2NlcHQoKSBjYW4gaGFuZCB0aGUgZnJlZWQgc29ja2V0IHRvIHVzZXIgc3BhY2UuCgpPbiBhIGxp
dmUgbm9kZSBydW5uaW5nIGEgS0FTQU4ga2VybmVsLCBzdG9wcGluZyB0aGUgRlBBQyBkYWVtb25z
IHNob3J0bHkKYWZ0ZXIgYSBsb2NhbCAobG9vcGJhY2spIGNhbGwgaGFkIGJlZW4gc2V0IHVwIGFu
ZCBkcm9wcGVkIGdhdmU6CgogIEJVRzogS0FTQU46IHNsYWItdXNlLWFmdGVyLWZyZWUgaW4gcm9z
ZV9kZXN0cm95X3NvY2tldCsweDI0YS8weDU3MCBbcm9zZV0KICBXcml0ZSBvZiBzaXplIDggLi4u
IGJ5IHRhc2sgZnBhY3dwZAogICByb3NlX2Rlc3Ryb3lfc29ja2V0CiAgIHJvc2VfcmVsZWFzZQog
IEFsbG9jYXRlZCBieSB0YXNrIDA6IC4uLiByb3NlX3J4X2NhbGxfcmVxdWVzdCA8LSByb3NlX2xv
b3BiYWNrX3RpbWVyCiAgRnJlZWQgYnkgdGFzayAuLi46IC4uLiBza19mcmVlIDwtIHJvc2VfaGVh
cnRiZWF0X2V4cGlyeQogIHJlZmNvdW50X3Q6IGFkZGl0aW9uIG9uIDA7IHVzZS1hZnRlci1mcmVl
LgogICByb3NlX3N0YXJ0X2hlYXJ0YmVhdCA8LSByb3NlX2Rlc3Ryb3lfc29ja2V0IDwtIHJvc2Vf
cmVsZWFzZQoKZm9sbG93ZWQgYSBmZXcgc2Vjb25kcyBsYXRlciBieSBhIHBhZ2UgZmF1bHQgaW4g
dGhlIHJlLWFybWVkIGhlYXJ0YmVhdAphbmQgYSBrZXJuZWwgcGFuaWMuCgpNYWtlIHRoZSBsaXN0
ZW5lcidzIHF1ZXVlIG93biBhIHJlZmVyZW5jZSBvbiBlYWNoIHBlbmRpbmcgc29ja2V0LAp0YWtl
biB3aGVuIHRoZSBjYWxsIGlzIHF1ZXVlZCBhbmQgZHJvcHBlZCBieSByb3NlX2FjY2VwdCgpIG9y
IGJ5IHRoZQpsaXN0ZW5lcidzIHJvc2VfZGVzdHJveV9zb2NrZXQoKSBvbmNlIHRoZSBza2IgaXMg
b2ZmIHRoZSBxdWV1ZS4gSGF2ZQp0aGUgaGVhcnRiZWF0IHNldCBTT0NLX0RFU1RST1kgdW5kZXIg
dGhlIHNvY2tldCBsb2NrIGJlZm9yZSByZWFwaW5nIGEKZGVhZCBzb2NrZXQsIGFzIHRoZSBvdGhl
ciByZWFwaW5nIHBhdGhzIGFscmVhZHkgZG8sIGFuZCBtYWtlIGJvdGgKY29uc3VtZXJzIGNoZWNr
IGl0IHVuZGVyIHRoZSBjaGlsZCdzIGxvY2s6IHJvc2VfYWNjZXB0KCkgc2tpcHMgYQpyZWFwZWQg
c29ja2V0IGFuZCB3YWl0cyBmb3IgdGhlIG5leHQgY2FsbCwgYW5kIHJvc2VfZGVzdHJveV9zb2Nr
ZXQoKQpubyBsb25nZXIgcmUtYXJtcyB0aGUgaGVhcnRiZWF0IG9mIGEgc29ja2V0IHRoYXQgaXMg
Z29uZS4KCkZpeGVzOiBkZjEyYmUwOTYzMDIgKCJyb3NlOiByZWxlYXNlIG5ldGRldiByZWYgYW5k
IGRlc3Ryb3kgb3JwaGFuZWQgaW5jb21pbmcgc29ja2V0cyIpClNpZ25lZC1vZmYtYnk6IEJlcm5h
cmQgUGlkb3V4IDxiZXJuYXJkLmY2YnZwQGdtYWlsLmNvbT4KKGNoZXJyeSBwaWNrZWQgZnJvbSBj
b21taXQgNmIwMjIzYTQ3OTVmNWRiNTJkZWUwMzhhN2EyOWU5OTA2MTIyYjBmNykKLS0tCiBuZXQv
cm9zZS9hZl9yb3NlLmMgICAgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tCiBuZXQvcm9zZS9yb3NlX3RpbWVyLmMgfCAgNSArKysrKwogMiBmaWxlcyBjaGFu
Z2VkLCA0NCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9y
b3NlL2FmX3Jvc2UuYyBiL25ldC9yb3NlL2FmX3Jvc2UuYwppbmRleCA5Nzg5MzQ5OGUuLjQ4Yjgy
ZmUzYiAxMDA2NDQKLS0tIGEvbmV0L3Jvc2UvYWZfcm9zZS5jCisrKyBiL25ldC9yb3NlL2FmX3Jv
c2UuYwpAQCAtMzkwLDExICszOTAsMjUgQEAgdm9pZCByb3NlX2Rlc3Ryb3lfc29ja2V0KHN0cnVj
dCBzb2NrICpzaykKIAlyb3NlX2NsZWFyX3F1ZXVlcyhzayk7CQkvKiBGbHVzaCB0aGUgcXVldWVz
ICovCiAKIAl3aGlsZSAoKHNrYiA9IHNrYl9kZXF1ZXVlKCZzay0+c2tfcmVjZWl2ZV9xdWV1ZSkp
ICE9IE5VTEwpIHsKLQkJaWYgKHNrYi0+c2sgIT0gc2spIHsJLyogQSBwZW5kaW5nIGNvbm5lY3Rp
b24gKi8KLQkJCS8qIFF1ZXVlIHRoZSB1bmFjY2VwdGVkIHNvY2tldCBmb3IgZGVhdGggKi8KLQkJ
CXNvY2tfc2V0X2ZsYWcoc2tiLT5zaywgU09DS19ERUFEKTsKLQkJCXJvc2Vfc3RhcnRfaGVhcnRi
ZWF0KHNrYi0+c2spOwotCQkJcm9zZV9zayhza2ItPnNrKS0+c3RhdGUgPSBST1NFX1NUQVRFXzA7
CisJCXN0cnVjdCBzb2NrICpjaGlsZCA9IHNrYi0+c2s7CisKKwkJaWYgKGNoaWxkICE9IHNrKSB7
CS8qIEEgcGVuZGluZyBjb25uZWN0aW9uICovCisJCQkvKiBRdWV1ZSB0aGUgdW5hY2NlcHRlZCBz
b2NrZXQgZm9yIGRlYXRoLCB1bmxlc3MKKwkJCSAqIHJvc2VfaGVhcnRiZWF0X2V4cGlyeSgpIGhh
cyBhbHJlYWR5IHJlYXBlZCBpdCBvciBpcworCQkJICogYWJvdXQgdG8gKFNPQ0tfREVTVFJPWSku
CisJCQkgKi8KKwkJCWxvY2FsX2JoX2Rpc2FibGUoKTsKKwkJCWJoX2xvY2tfc29ja19uZXN0ZWQo
Y2hpbGQpOworCQkJaWYgKCFzb2NrX2ZsYWcoY2hpbGQsIFNPQ0tfREVTVFJPWSkpIHsKKwkJCQlz
b2NrX3NldF9mbGFnKGNoaWxkLCBTT0NLX0RFQUQpOworCQkJCXJvc2Vfc3RhcnRfaGVhcnRiZWF0
KGNoaWxkKTsKKwkJCQlyb3NlX3NrKGNoaWxkKS0+c3RhdGUgPSBST1NFX1NUQVRFXzA7CisJCQl9
CisJCQliaF91bmxvY2tfc29jayhjaGlsZCk7CisJCQlsb2NhbF9iaF9lbmFibGUoKTsKKworCQkJ
c2tiLT5zayA9IE5VTEw7CisJCQlzb2NrX3B1dChjaGlsZCk7CS8qIHRoZSBxdWV1ZSdzIHJlZmVy
ZW5jZSAqLwogCQl9CiAKIAkJa2ZyZWVfc2tiKHNrYik7CkBAIC05ODAsNiArOTk0LDcgQEAgc3Rh
dGljIGludCByb3NlX2FjY2VwdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3Qgc29ja2V0ICpu
ZXdzb2NrLAogCSAqCVRoZSB3cml0ZSBxdWV1ZSB0aGlzIHRpbWUgaXMgaG9sZGluZyBzb2NrZXRz
IHJlYWR5IHRvIHVzZQogCSAqCWhvb2tlZCBpbnRvIHRoZSBTQUJNIHdlIHNhdmVkCiAJICovCith
Z2FpbjoKIAlmb3IgKDs7KSB7CiAJCXByZXBhcmVfdG9fd2FpdChza19zbGVlcChzayksICZ3YWl0
LCBUQVNLX0lOVEVSUlVQVElCTEUpOwogCkBAIC0xMDA1LDEyICsxMDIwLDI3IEBAIHN0YXRpYyBp
bnQgcm9zZV9hY2NlcHQoc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IHNvY2tldCAqbmV3c29j
aywKIAkJZ290byBvdXRfcmVsZWFzZTsKIAogCW5ld3NrID0gc2tiLT5zazsKKwlsb2NrX3NvY2tf
bmVzdGVkKG5ld3NrLCBTSU5HTEVfREVQVEhfTkVTVElORyk7CisJaWYgKHNvY2tfZmxhZyhuZXdz
aywgU09DS19ERVNUUk9ZKSkgeworCQkvKiBUaGUgY2FsbCB3ZW50IGF3YXkgYW5kIHJvc2VfaGVh
cnRiZWF0X2V4cGlyeSgpIHJlYXBlZCAob3IKKwkJICogaXMgYWJvdXQgdG8gcmVhcCkgdGhlIHNv
Y2tldCBiZWZvcmUgaXQgd2FzIGFjY2VwdGVkOiBkcm9wCisJCSAqIGl0IGFuZCB3YWl0IGZvciB0
aGUgbmV4dCBvbmUuCisJCSAqLworCQlyZWxlYXNlX3NvY2sobmV3c2spOworCQlza2ItPnNrID0g
TlVMTDsKKwkJa2ZyZWVfc2tiKHNrYik7CisJCXNrX2FjY2VwdHFfcmVtb3ZlZChzayk7CisJCXNv
Y2tfcHV0KG5ld3NrKTsJLyogdGhlIHF1ZXVlJ3MgcmVmZXJlbmNlICovCisJCWdvdG8gYWdhaW47
CisJfQogCXNvY2tfZ3JhZnQobmV3c2ssIG5ld3NvY2spOworCXJlbGVhc2Vfc29jayhuZXdzayk7
CiAKIAkvKiBOb3cgYXR0YWNoIHVwIHRoZSBuZXcgc29ja2V0ICovCiAJc2tiLT5zayA9IE5VTEw7
CiAJa2ZyZWVfc2tiKHNrYik7CiAJc2tfYWNjZXB0cV9yZW1vdmVkKHNrKTsKKwlzb2NrX3B1dChu
ZXdzayk7CQkvKiB0aGUgcXVldWUncyByZWZlcmVuY2UgKi8KIAogb3V0X3JlbGVhc2U6CiAJcmVs
ZWFzZV9zb2NrKHNrKTsKQEAgLTExMjQsNiArMTE1NCwxMCBAQCBpbnQgcm9zZV9yeF9jYWxsX3Jl
cXVlc3Qoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0
IHJvcwogCiAJcm9zZV9pbnNlcnRfc29ja2V0KG1ha2UpOwogCisJLyogVGhlIGxpc3RlbmVyJ3Mg
cXVldWUgaG9sZHMgYSByZWZlcmVuY2Ugb24gdGhlIHBlbmRpbmcgc29ja2V0CisJICogdW50aWwg
cm9zZV9hY2NlcHQoKSBvciByb3NlX2Rlc3Ryb3lfc29ja2V0KCkgdGFrZXMgaXQgb2ZmLgorCSAq
LworCXNvY2tfaG9sZChtYWtlKTsKIAlza2JfcXVldWVfaGVhZCgmc2stPnNrX3JlY2VpdmVfcXVl
dWUsIHNrYik7CiAKIAlyb3NlX3N0YXJ0X2hlYXJ0YmVhdChtYWtlKTsKZGlmZiAtLWdpdCBhL25l
dC9yb3NlL3Jvc2VfdGltZXIuYyBiL25ldC9yb3NlL3Jvc2VfdGltZXIuYwppbmRleCBkOTY3Y2Jj
MWQuLjQxMzBkZGY4NCAxMDA2NDQKLS0tIGEvbmV0L3Jvc2Uvcm9zZV90aW1lci5jCisrKyBiL25l
dC9yb3NlL3Jvc2VfdGltZXIuYwpAQCAtMTg4LDYgKzE4OCwxMSBAQCBzdGF0aWMgdm9pZCByb3Nl
X2hlYXJ0YmVhdF9leHBpcnkoc3RydWN0IHRpbWVyX2xpc3QgKnQpCiAJCQkJcm9zZV9uZWlnaF9w
dXQocm9zZS0+bmVpZ2hib3VyKTsKIAkJCQlyb3NlLT5uZWlnaGJvdXIgPSBOVUxMOwogCQkJfQor
CQkJLyogVGVsbCByb3NlX2FjY2VwdCgpIGFuZCB0aGUgbGlzdGVuZXIncyB0ZWFyZG93biwgd2hp
Y2gKKwkJCSAqIG1heSBzdGlsbCBob2xkIHRoaXMgc29ja2V0IG9uIHRoZWlyIHF1ZXVlLCB0aGF0
IGl0IGlzCisJCQkgKiBnb25lLgorCQkJICovCisJCQlzb2NrX3NldF9mbGFnKHNrLCBTT0NLX0RF
U1RST1kpOwogCQkJYmhfdW5sb2NrX3NvY2soc2spOwogCQkJcm9zZV9kZXN0cm95X3NvY2tldChz
ayk7CiAJCQlzb2NrX3B1dChzayk7Ci0tIAoyLjUzLjAKCg==
--000000000000b6a0f8065de58205--
