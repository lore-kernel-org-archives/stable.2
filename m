Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2C495050
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399400; cv=pass; b=hoi93Rpe+yMk+nMi97no4zISer9UeL3NsGTQC/Dqh2oorwxKGXUXrNwe+aInfwGhJJ+wOoeZvsXnsM6p3JqKrajdODMOtZn48CvRZfNF5zgSwlsbkLUWApOZBiS3ph5VkfGJH8UriV08AHl2jhhcyJau0U0oGQC6lrVu2scY8KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399400; c=relaxed/simple;
	bh=3n6mcV54sBQoL4PGRBUi3U0o6OP5Dbw+E/PsR+/uJAE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EWacbmdGLj2fXzx2TCTpbFqF33+oBjai++hbaVyN2AEKvZ750CU9Gf5wQqBaJBsx5FGjv+jfR1gQXWDQI+VcxTT/CEUl1HtAgbfTZf5dOyXJYfaFB2v39nk46sEXU2U5I+SS0Z/4cKwAUCmTG4SK6RQE5o5MXRrvxR3eBTsSk1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRTkevTp; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRTkevTp"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-843ea301d60so1224857a34.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 01:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399397; cv=none;
        d=google.com; s=arc-20260327;
        b=anRELzvPI2+0hAzT95NtTJbcorsf19SIbRfSJfbGpvULS6lZr4Ab7l2KIHWnZOSyBT
         Iurw7zC9XIVuTfgcHPE+JNcE5iJzbgMGCuMY2hpJanoceas7xc37TLmyQjepdz2cd2R3
         FOLVAj3xipM3Ax6OXaRDgEFu0mDC60RdZ7atJ2q4DzJVOXEZuv14IZKeGwGMmsR5xAC6
         lbxwyKJlX3/t8+oUoUuh8cCfIWHR/LPGToxQGovIyxfOfcHs1JWfnGl0yuF1Wxv0SecS
         J43KANyI6wULaNncpvOqjw4LW3rtpXy6TMeXcunaAIbe3CvUQ2+9l0MEmRhKTQTTWKhq
         PSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ah1UVM1a5JUIU2UMZPXNnixFTsJyaBB8iM1grrC0/oY=;
        fh=h+lsODXI89bJVO6R+TCiIluA9+LNOJ8ang2iM1WSf2w=;
        b=m+Ybcqr7NHpc4QbIzSOERkRK/0ZqBVKS49Q+aLFzQI86MvMeafdSWJI6468rbV8NmZ
         NOlhayaOzAccifZdToOIZV44J5wvVtM4QqDpKcbgkQZ7tIUCmTwkClMRBOtipHkZ67g7
         hTaKBKFiA9ytFcJGUWiNXG9Lig/Qal4IxWj+T5oDViAn3QAE+iOrsDOOwLEe5SxVKexw
         2sfVX6tipBk7cff/SuhZHqQ0kNeNqVDJ/wtaL4+ZkFqEiwVY6/MSbfTiYcty/J3A+RZf
         ldpVz8S5bsW5HgOrPNOzfMk2TM7Zug5v0VwfANWNejBKBMe/NswLdPzTAC+18rm/yt45
         +wZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399397; x=1793004197; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ah1UVM1a5JUIU2UMZPXNnixFTsJyaBB8iM1grrC0/oY=;
        b=HRTkevTptxTen9Fb2Cr3CUq9/OAtszNleb3h+zwmZHnJQ+EmLrNx4B9NyVLagKtzJe
         xooEpo8fJcOsSSvUMGnj/CXQyu5U2Dp9gYRInvvcre9J0KFZSwiN1NfTU+58JSG8Zw6e
         WeAMbY4eP+587K6qWjxOZv6e9CNTeK6p+nAV7CmS4ZLoeuqCv+thv6EetG8AsxtmvBHY
         riUM4z7LWQufyXr+PZuFKzwfa5qd5NSl6nUQv5JOkcayQCf2qCSvnF3XYRNK4zvpEj++
         t2n6fOS1IVqCa31GM2g6/w021U/nYEC+9IbY0mN5xbRctQolfLX2CMCSEjHpcOeU2IGh
         JWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399397; x=1793004197;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ah1UVM1a5JUIU2UMZPXNnixFTsJyaBB8iM1grrC0/oY=;
        b=vwIL3zDRwEgwXH/ppTNLAbnd5u4ePzfIs763Sxvp4a634C+Xn20OR0Q0inoKeHdyfM
         YGGkU8TqUfR783lpEnw0OBbEZKBMWpGdntzNescFnZfc7BBLBzhiNQPjtL5qRUXTYD+m
         s2nYzP5PXeFD06A7wsZPgjhruPLZtEyHUdBa+NMD1ExVFN51zLgLHdN4IiPQJBkYBJTQ
         KjS3JS96hc3/A/5vsbJu6WwpAYKAbxwoRzuxZK44ohRcb0Drjg2JtAm9m4AzULUhCCi8
         I8vXJ5dmwsUanp/HgwPjK2sqk3ejfD/wl96AXjql9yhvosjnT06VsT1lP2KkEPI5pAbh
         QSug==
X-Forwarded-Encrypted: i=1; AKwUvBzII5EWiYWdV1CLV+OrMf2RELYOJblZHtLo9J7+B8kZgas+m36ItbUDxAOMc79gvLjj2MC0I2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJtDMqN6wR7QFj2wqXwZ//4W9m+0JiGlXsipAbolqrenGqdI1K
	HndeuBKbExVtPekBvm/toHi/izqoqZp7hvEL+GSqsLkyDv9iYja4f+43MvKZ+Ov5/8CGtI6PN5h
	Jgx/mUMzLsO/b7mOX80Q0U5otKj1cIew=
X-Gm-Gg: AYBFou0sy/WNVlLGpKPeZSG4V3nndHMahLUl+LAq1kAESwo/26S+aJyR3HWf2OMcagW
	B8rM3Rqxekx5yneoP2DsTVad67HOWqMjeXtmkvNiaVmYahL7icuW8iyZEo8Bs/E6kDuVA3zLzOn
	fkMOVN6ocx0xlOlBtZDU9fZ0R7TH7hVe35O2QOhcEBy2JFhVJ5GTfw/y82W8d1uW4xk1ewZ4Ulr
	UoGpz87IYUSrnGdmje6nr3OFC463l7TImaDK8XD5u617UArxshYbAd5E5YnnO4Xlmnp2tdX4Dji
	ElRmWUBVOxRxzk7aSk6DDCkTbrW4F/m2NC9M/qE3yVaUZ5H1tTPLWHg=
X-Received: by 2002:a05:6830:128d:b0:845:156f:58b1 with SMTP id
 46e09a7af769-845156f59b4mr4159245a34.24.1792399396454; Mon, 19 Oct 2026
 01:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pranjal Kumar Singh <pranjalksingh92@gmail.com>
Date: Mon, 19 Oct 2026 14:13:04 +0530
X-Gm-Features: AclHuK-2q1hEywUuiidDWgyyBvWKcXim22yD9JRZRbTxqnlkjr9Ww2kCOehwqIk
Message-ID: <CA+UYBZDMpqq989aWq318+T2j4+PU7giVpO8ZffrkDFwqaoKjJw@mail.gmail.com>
Subject: Kernel bug report: unguarded deferred skb_checksum_help() writes
 corrupt the previously-validated IPv6 fixed header (IPv6 counterpart of
 commit 6785011f8b16, "ipv4: validate checksum_start before completing checksum")
To: cve@kernel.org, netdev <netdev@vger.kernel.org>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Paulos Yibelo <habte.yibelo@gmail.com>, openvswitch <dev@openvswitch.org>, stable@vger.kernel.org, 
	"fw@strlen.de" <fw@strlen.de>
Content-Type: multipart/mixed; boundary="000000000000526171065e2d8110"

--000000000000526171065e2d8110
Content-Type: multipart/alternative; boundary="00000000000052616f065e2d810e"

--00000000000052616f065e2d810e
Content-Type: text/plain; charset="UTF-8"

Hello Security Team,

The IPv4 part of this was fixed some time ago in commit 6785011f8b16
("ipv4: validate checksum_start before completing checksum"): a packet
whose virtio_net_hdr csum metadata points its checksum start inside the
IP header makes skb_checksum_help() (the deferred csum completion)
rewrite the header the stack has already validated (fixed checksum
offset-width write at csum_start + csum_offset).  The IPv6 paths were
not covered, and they still are not: a 2-patch series mirroring that
commit for IPv4->IPv6, including its remaining not-yet-IPv6-guarded
sinks, is reproduced below and attached as patches/0001 and 0002.

Why this is reachable today
---------------------------
include/linux/virtio_net.h's __virtio_net_hdr_to_skb() only enforces
skb_transport_offset() >= sizeof(struct iphdr) (nh_min_len) for
NEEDS_CSUM -- i.e., for IPv6 packets any csum_start in
[20, sizeof(struct ipv6hdr)) passes admission, sitting inside the fixed
40-byte IPv6 header that the stack has just validated.  With TUN (tun
device using IFF_VNET_HDR) or AF_PACKET csum -- the same admission the
virtio/vhost setup uses for guests, and reachable unprivileged --
skb_checksum_help() can then write an attacker-chosen 16-bit value into
the outgoing IPv6 header of a forwarded frame.  The write value is
csum_fold over an attacker-built payload and is fully deterministic
(pre-computed in userspace in the reproducer).

Sinks on master (line numbers from c03c1a14507d, "Linux 7.3", checked
2026-10-19):

  net/ipv6/ip6_output.c:945           ip6_fragment()      unguarded
  net/ipv6/netfilter.c:147            br_ip6_fragment()   unguarded
                                      (reachable by bridge
                                      refrag in
                                      net/bridge/netfilter/
                                      nf_conntrack_bridge.c:358 and
                                      by Open vSwitch
                                      ovs_fragment()'s IPv6 branch
                                      which calls ip6_fragment())
  net/netfilter/xt_CHECKSUM.c:30      checksum_tg()       guard is
                                      NFPROTO_IPV4-only, IPv6 falls
                                      through; helper return also
                                      ignored (patch 2)
  net/netfilter/nfnetlink_queue.c:678 nf_queue_checksum_help()
                                      checked for ETH_P_IP only,
                                      IPv6 falls through
  net/xfrm/xfrm_output.c:826          xfrm_output()       same
                                      ETH_P_IP-only gate

The ip6_fragment() side-drop is the direct sibling of the IPv4
ip_do_fragment() check that commit added; xt_CHECKSUM's IPv6 case is
reachable for a v6-only netns since ingress-side -- for instance via
`ip6tables -t mangle POSTROUTING -j CHECKSUM --checksum-fill`, which
finalizes the partial checksum at the sink.

Bug report and evidence
-----------------------
Dear attachments, all under ipv6-csum-start-submission.zip:

  - report.txt: detailed writeup with the full admission-gap audit and
    the sink table above, impact, and the reproducer output below;
  - patches/0000-cover-letter.txt, 0001, 0002: the proposed git-series
    (2 patches, drafted against c03c1a14507d);
  - poc/poc_ipv6_csum_start.c: a single-file reproducer (as PID 1 in an
    initramfs VM it needs no external tools -- netns + veth + tun via
    raw netlink, TUN,VNET_HDR, ip6tables via the bundled
    ip6tables-legacy, and a packet-over-TUN/AF_PACKET sender); csum
    geometry (csum_start=24 = inside the IPv6 fixed header) with a
    csum_start=64 falsification control variant;
  - poc/build_vm.sh, logs/run-*.log: the two runs, verbatim, from a
    QEMU initramfs VM against a real 6.12.38 kernel (no KVM required):

  -- control (csum_start=64, past the header) --
  [*] emitted frame #1 len=1478 daddr intact: fd:00:00:0c hop_limit=63
  [+] control OK: 1 frames, headers intact
      Ip6OutForwDatagrams             1

  -- evil (csum_start=24, inside the header) --
  [!] MUTATED OUTPUT FRAME #1: daddr bits now 4a:32:00:0c
      (wire-validated value was fd00:c::= 0c:0c:0c:0c); written
      16-bit=4a32 len=1478
  [+] BUG CONFIRMED: csum_start=24 < sizeof(struct ipv6hdr)=40:
      deferred skb_checksum_help() rewrote the previously VALIDATED
      IPv6 header in an EMITTED packet.
      Ip6OutForwDatagrams             1

The 4a:32 written into the emitted frame's destination address is the
folded checksum the reproducer predicted before sending; the control
run shows the same code path intact, ruling out ordinary corruption.
Likewise, no CVE for this IPv6 path is known to me as of 2026-10-19;
there is no harm in restoring parity with the IPv4 fix, and following
up with cve@kernel.org after this lands, if you agree.

The proposed fix mirrors commit 6785011f8b16 one sink at a time; the
input-side admission is still the "more work forthcoming" item from
that commit's changelog (its IPv4 work precedes it), and this series
does not attempt to change it -- it only documents that gap in
report.txt for whoever picks it up.

Happy to rework the split (netfilter-only first, or one patch per
sink), or to paste the patches inline if inline is preferred over the
attachment.  Testing status: the reproducer was exercised end to end
against the 6.12.38 kernel named above; patches are hand-crafted and
not yet boot-tested as a series.

Let me know if it is eligible for CVE

Thanks,
PRNJL

--00000000000052616f065e2d810e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Security Team,<br><br>The IPv4 part of this was fixe=
d some time ago in commit 6785011f8b16<br>(&quot;ipv4: validate checksum_st=
art before completing checksum&quot;): a packet<br>whose virtio_net_hdr csu=
m metadata points its checksum start inside the<br>IP header makes skb_chec=
ksum_help() (the deferred csum completion)<br>rewrite the header the stack =
has already validated (fixed checksum<br>offset-width write at csum_start +=
 csum_offset).=C2=A0 The IPv6 paths were<br>not covered, and they still are=
 not: a 2-patch series mirroring that<br>commit for IPv4-&gt;IPv6, includin=
g its remaining not-yet-IPv6-guarded<br>sinks, is reproduced below and atta=
ched as patches/0001 and 0002.<br><br>Why this is reachable today<br>------=
---------------------<br>include/linux/virtio_net.h&#39;s __virtio_net_hdr_=
to_skb() only enforces<br>skb_transport_offset() &gt;=3D sizeof(struct iphd=
r) (nh_min_len) for<br>NEEDS_CSUM -- i.e., for IPv6 packets any csum_start =
in<br>[20, sizeof(struct ipv6hdr)) passes admission, sitting inside the fix=
ed<br>40-byte IPv6 header that the stack has just validated.=C2=A0 With TUN=
 (tun<br>device using IFF_VNET_HDR) or AF_PACKET csum -- the same admission=
 the<br>virtio/vhost setup uses for guests, and reachable unprivileged --<b=
r>skb_checksum_help() can then write an attacker-chosen 16-bit value into<b=
r>the outgoing IPv6 header of a forwarded frame.=C2=A0 The write value is<b=
r>csum_fold over an attacker-built payload and is fully deterministic<br>(p=
re-computed in userspace in the reproducer).<br><br>Sinks on master (line n=
umbers from c03c1a14507d, &quot;Linux 7.3&quot;, checked<br>2026-10-19):<br=
><br>=C2=A0 net/ipv6/ip6_output.c:945 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip=
6_fragment() =C2=A0 =C2=A0 =C2=A0unguarded<br>=C2=A0 net/ipv6/netfilter.c:1=
47 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br_ip6_fragment() =C2=A0 unguar=
ded<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (reachab=
le by bridge<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
efrag in<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 net/b=
ridge/netfilter/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 nf_conntrack_bridge.c:358 and<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 by Open vSwitch<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ovs_fragment()&#39;s IPv6 branch<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 which calls ip6_fragment())<b=
r>=C2=A0 net/netfilter/xt_CHECKSUM.c:30 =C2=A0 =C2=A0 =C2=A0checksum_tg() =
=C2=A0 =C2=A0 =C2=A0 guard is<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NFPROTO_IPV4-only, IPv6 falls<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 through; helper return also<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ignored (patch 2)<br>=
=C2=A0 net/netfilter/nfnetlink_queue.c:678 nf_queue_checksum_help()<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 checked for ETH_P_I=
P only,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6 =
falls through<br>=C2=A0 net/xfrm/xfrm_output.c:826 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xfrm_output() =C2=A0 =C2=A0 =C2=A0 same<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ETH_P_IP-only gate<br><br>The ip6_fr=
agment() side-drop is the direct sibling of the IPv4<br>ip_do_fragment() ch=
eck that commit added; xt_CHECKSUM&#39;s IPv6 case is<br>reachable for a v6=
-only netns since ingress-side -- for instance via<br>`ip6tables -t mangle =
POSTROUTING -j CHECKSUM --checksum-fill`, which<br>finalizes the partial ch=
ecksum at the sink.<br><br>Bug report and evidence<br>---------------------=
--<br>Dear attachments, all under ipv6-csum-start-submission.zip:<br><br>=
=C2=A0 - report.txt: detailed writeup with the full admission-gap audit and=
<br>=C2=A0 =C2=A0 the sink table above, impact, and the reproducer output b=
elow;<br>=C2=A0 - patches/0000-cover-letter.txt, 0001, 0002: the proposed g=
it-series<br>=C2=A0 =C2=A0 (2 patches, drafted against c03c1a14507d);<br>=
=C2=A0 - poc/poc_ipv6_csum_start.c: a single-file reproducer (as PID 1 in a=
n<br>=C2=A0 =C2=A0 initramfs VM it needs no external tools -- netns + veth =
+ tun via<br>=C2=A0 =C2=A0 raw netlink, TUN,VNET_HDR, ip6tables via the bun=
dled<br>=C2=A0 =C2=A0 ip6tables-legacy, and a packet-over-TUN/AF_PACKET sen=
der); csum<br>=C2=A0 =C2=A0 geometry (csum_start=3D24 =3D inside the IPv6 f=
ixed header) with a<br>=C2=A0 =C2=A0 csum_start=3D64 falsification control =
variant;<br>=C2=A0 - poc/build_vm.sh, logs/run-*.log: the two runs, verbati=
m, from a<br>=C2=A0 =C2=A0 QEMU initramfs VM against a real 6.12.38 kernel =
(no KVM required):<br><br>=C2=A0 -- control (csum_start=3D64, past the head=
er) --<br>=C2=A0 [*] emitted frame #1 len=3D1478 daddr intact: fd:00:00:0c =
hop_limit=3D63<br>=C2=A0 [+] control OK: 1 frames, headers intact<br>=C2=A0=
 =C2=A0 =C2=A0 Ip6OutForwDatagrams =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 	1<br><br>=C2=A0 -- evil (csum_start=3D24, inside the header) --<br>=C2=
=A0 [!] MUTATED OUTPUT FRAME #1: daddr bits now 4a:32:00:0c<br>=C2=A0 =C2=
=A0 =C2=A0 (wire-validated value was fd00:c::=3D 0c:0c:0c:0c); written<br>=
=C2=A0 =C2=A0 =C2=A0 16-bit=3D4a32 len=3D1478<br>=C2=A0 [+] BUG CONFIRMED: =
csum_start=3D24 &lt; sizeof(struct ipv6hdr)=3D40:<br>=C2=A0 =C2=A0 =C2=A0 d=
eferred skb_checksum_help() rewrote the previously VALIDATED<br>=C2=A0 =C2=
=A0 =C2=A0 IPv6 header in an EMITTED packet.<br>=C2=A0 =C2=A0 =C2=A0 Ip6Out=
ForwDatagrams =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 	1<br><br>The 4a:32=
 written into the emitted frame&#39;s destination address is the<br>folded =
checksum the reproducer predicted before sending; the control<br>run shows =
the same code path intact, ruling out ordinary corruption.<br>Likewise, no =
CVE for this IPv6 path is known to me as of 2026-10-19;<br>there is no harm=
 in restoring parity with the IPv4 fix, and following<br>up with <a href=3D=
"mailto:cve@kernel.org">cve@kernel.org</a> after this lands, if you agree.<=
br><br>The proposed fix mirrors commit 6785011f8b16 one sink at a time; the=
<br>input-side admission is still the &quot;more work forthcoming&quot; ite=
m from<br>that commit&#39;s changelog (its IPv4 work precedes it), and this=
 series<br>does not attempt to change it -- it only documents that gap in<b=
r>report.txt for whoever picks it up.<br><br>Happy to rework the split (net=
filter-only first, or one patch per<br>sink), or to paste the patches inlin=
e if inline is preferred over the<br>attachment.=C2=A0 Testing status: the =
reproducer was exercised end to end<br>against the 6.12.38 kernel named abo=
ve; patches are hand-crafted and<br>not yet boot-tested as a series.<br><br=
>Let me know if it is eligible for CVE<br><br>Thanks,<br>PRNJL</div>

--00000000000052616f065e2d810e--
--000000000000526171065e2d8110
Content-Type: application/x-zip-compressed; name="ipv6-csum-PRNJL.zip"
Content-Disposition: attachment; filename="ipv6-csum-PRNJL.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_mvf0atbw0>
X-Attachment-Id: f_mvf0atbw0

UEsDBBQAAAAAAGpvU10AAAAAAAAAAAAAAAAQAAAAaXB2Ni1jc3VtLVBSTkpML1BLAwQUAAAAAABq
b1NdAAAAAAAAAAAAAAAAKwAAAGlwdjYtY3N1bS1QUk5KTC9pcHY2LWNzdW0tc3RhcnQtc3VibWlz
c2lvbi9QSwMEFAAAAAAAam9TXQAAAAAAAAAAAAAAADAAAABpcHY2LWNzdW0tUFJOSkwvaXB2Ni1j
c3VtLXN0YXJ0LXN1Ym1pc3Npb24vbG9ncy9QSwMEFAAAAAgAAAAhAMehHjQUAwAAfg4AAD8AAABp
cHY2LWNzdW0tUFJOSkwvaXB2Ni1jc3VtLXN0YXJ0LXN1Ym1pc3Npb24vbG9ncy9ydW4tY29udHJv
bC5sb2ftV1tv0zAUfmbS/sOReBmwdnYubhqpPDCYmCYYAvE0VZVT220gjSvHvf17Ti7del2zMY09
cJQqjvXlfN/57By5N2+7kGgupICRFpNEwlkSR2flODubSjts/tbHRwdwdpLWgc17lkc4qIONx+xh
6ALcG/F0kMg6r8xt7/zzp/OrHz+/LOH31AY8MZKLRZUR4UZPrGSNUTZAGpl2fBaCG5AiaH73CSOb
wb3ipiRxlSB0OU1xOn/CuTz6ZF/keXOsWz6WqlNp0wyUNjNuRJwOOhRORpPMQiSBvikxS4MyWBbd
UHGSgOl3CJzMeGqBVFA5H8u+RdeEVNIYHMxMbCVMeTKRwC0MhYFogTPMC4HMW8QvCC23mF5wIcwN
aTZpFxrvoUVC/1ZD+qtMTD3mfYApA2X4SIbQzyajXma5sR3mlU9aqUzaDmVwEsmFTkVjyhpDid4b
GEg9ktYsTjHjlJsYxTcyriT0dWqNTnI6EeGyWD6GWHW8inBsOySE20Xx28SJvKXnfI/j9MCaUCci
DqH4q2KD3EHyVlCQuyH4ju8JrCKSUinuBFJw6TpuEDAh1oW56jHCqhUcxRZ9Lu2F17TYn7mMcnXQ
Nsv7NgQlQkKKqw9DPe4lMb7YYe5WCQErCnBwh2MoVYreWwCa4XKlyIFAhLM5t+0eJavcVe1sP3fx
DdLVnI/kdoG2dnK3ud+mhDP8mv117pb3r7mVDNbytgPEI6OS5Ts1uNFz/4Ge56NtbhXk+Jy7fKcW
d/uB1I73RNT/La9L/VeWv+su2zRcX4VAyyaVnULZ3LOqOR0fAYbBJnWgDRLwCJD7AwG1MHlZd0i3
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
cGF0Y2hlcy8wMDAxLWlwdjYtdmFsaWRhdGUtY3N1bV9zdGFydC1iZWZvcmUtY29tcGxldGluZy1p
dC1jaGVja3N1bS5wYXRjaOVYe0/jRhD/u/4UUyq1yeUByXGBgzsEhdBD5QBBDrWqKsux14mL7U29
60D6+O79zdqO8zBcWqlSpUYoOLszs/P4zWN9nsjogH76UaYJXTmR+JnezfDcjvF8zE+ejJwgbosn
J5qE4sg6c7Q4IKKPMm5S5y1du5q6O90edboHOzv4o8YOPtZdOvxFuBqyb04Gpx+os939mYLJtHdA
UycMPIghdyzcB5VGttJOomkofJlgVfJJOohH1pzC+njxsd+6F4kKZHxAnfaOdSpjLWLdGswmUEiL
J709CaHqIZicRAn9/tPgvLVvWXdBFIROQlqy6CjQ1Nvbf7PT6fj7w06PalvQavdzWlmlVnOCrXqT
hqkm7JMeC7q4mfZIpnqCtYmjx6pJj+PAHWPT0fnZVih8TWk8Sp3EE17bsi58ckDuPghNj4Ee09Dx
5kdQJLQDrRwaCa0oiLUsj1IaXE1LPQztuc5jEU5q9cKHQhnqCewInLCUOpzRYxIYYxzLZT5fhl6t
/o3wqNNrDQPN7kgFQW+Ibx25pT8aCyvS9+HoNtFgLKxpgFOkHQttj72EHC8KFIfL+IJqV/3+2Z19
evfpY2bm4NMVXZyf2/dX/YH94ey2STKxTs7tm5PT7/sDYvkE+aF0vDrJOJzlEcqNKo1JxIhPcUYI
vtK8Z8E9uxQFcRBhfywcTyQUinjEetj2sqK2ljYsqtXhXSuI3TD1xHYYxOnTdknYHlOqcHA8tiHW
hix6/55U8JuQfk3pJHU1wA1pdWBCSQuQMDHKA6vIiWdUOhFH0U/dneaahGmPZUAVZTmuKyYaARFT
nKbHMh1lSCoMHopQxiM4Q2ZBTsQ0kKkKZ63CUZ61u9MaznSOFz94grjMHVnMyBO+SBLhYS8G02+O
hmQWF+MUhohQFgtQCMUceIVHHV/jG6sZEmnsKJofzeu59U0TcMvJMeWnYQhnIH0TGYagHM4yISJm
qTV+nmOSz3UQXK1ZVGK1hmkQcnrNDDCMGYEyRw+FiGFQJGO4k1XIcKaNmQpgN8ZZjuclQikjmFP3
0SRiriqEICly2zX7XXJ2wkOBq51hKIiVgmNbBfxyozKv4cRENClytDuGnIy1xcmYsj4LmZb7E4Dj
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
BBQAAAAAAGpvU10AAAAAAAAAAAAAAAAvAAAAaXB2Ni1jc3VtLVBSTkpML2lwdjYtY3N1bS1zdGFy
dC1zdWJtaXNzaW9uL3BvYy9QSwMEFAAAAAgAAAAhANDi/JyxAwAAfAgAADoAAABpcHY2LWNzdW0t
UFJOSkwvaXB2Ni1jc3VtLXN0YXJ0LXN1Ym1pc3Npb24vcG9jL2J1aWxkX3ZtLnNo1VVbj9JAFH7v
rzhWYiAydCGIxg0muouXKGK8PqghZXoK405n6swUYcX/7pm2CKyLPvkgIZmZcz/fufTmjWgmVGQX
wU14VAiZgFsgGMyNTgqOBogbG4G2XTLcNw1CCWfiLLXwfkzkWCVgCgUz7byRJtfKGS2B2yKbWhcb
Nxz04TbgUhwQe/1Wh+RfIib2Psw5b8NXzApm19Zhxlb3BtNBvw08F7oNq8s2JPnFfLNy8UyihabI
B9WVSZzHfN06JWMXaBRKEFk8RwqsSiaLHV8INYeMUvK6OoUYpOaxlGvKxjq6YFIr+xTOcSZixaxb
SwQZr3Xh7kM009pFy0wKVVyyxvPXoxelC66z3KC1ZKFzoTurSyhUgobsRFLMotrpKeglGiMSBK85
BJEC2YVvsXIUTSLSFA3SvYqCoLHogGHAEwgbzUQYFWdI15OwFQZBaaPx3R/3WaNZlExmWj+C8eR8
uO84KiON6uQCwhnYpAfsAyUNjHJ3gijnryZnU1IdTc/evn4BrKrylDsjIdd8KvLlYLorXof/3dDo
/bOdISr+MUOBySjyFIQJsgvKE1hO9/0Uts+qJZgvwIrNVVHTB326+C6GTwHUP08p7PVqAc+hZFrf
+Vf7qLYVBak2kAJZJRt113Ws7nR7niDyvuP+Wb8Ge6/yNjiFRJfhkLfwaCxRIw2PpRcFiVboo62y
jGRSM0mSDfqlw18YRF6QGTjuqk7iT9BUWWc+68QIalgbKaSmR7c4IDiad3/6anpCKqRD47Gc1k52
pTgiWMpNs1jNJXqRHZcCnZ49HZ09f/NuvGfnqlDtaYuzH6iPwFIaEWq/qJFVwxjC51O/BRTQYLKE
X2WfAkqLwGO3zyFyKvZ8P4BQmMOpas5ii/VMZmHLK1X1CmZ+jTZb8P1X+Rvdssh+Ekpak4aaGv3W
LfKiaG3AplxzwOj/lPL8RoPEvhaCNkDvQZTgMlKFlCQ1vxS5D6bRC1vBj8rTblLJZnl2vLGK+Wv6
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
LXN0YXJ0LXN1Ym1pc3Npb24vbG9ncy9ydW4tY29udHJvbC5sb2cKACAAAAAAAAEAGAAARB3Iceeo
AQAAAAAAAAAAAAAAAAAAAABQSwECPwAUAAAACAAAACEA829RXtYDAAD0DwAAPAAkAAAAAAAAAIAA
AAA2BAAAaXB2Ni1jc3VtLVBSTkpML2lwdjYtY3N1bS1zdGFydC1zdWJtaXNzaW9uL2xvZ3MvcnVu
LWV2aWwubG9nCgAgAAAAAAABABgAAEQdyHHnqAEAAAAAAAAAAAAAAAAAAAAAUEsBAj8AFAAAAAgA
AAAhAIRp++oqAgAAdgMAADoAJAAAAAAAAACAAAAAZggAAGlwdjYtY3N1bS1QUk5KTC9pcHY2LWNz
dW0tc3RhcnQtc3VibWlzc2lvbi9NQU5JRkVTVC5zaGEyNTYKACAAAAAAAAEAGAAARB3IceeoAQAA
AAAAAAAAAAAAAAAAAABQSwECPwAUAAAAAABqb1NdAAAAAAAAAAAAAAAAMwAkAAAAAAAAABAAAADo
CgAAaXB2Ni1jc3VtLVBSTkpML2lwdjYtY3N1bS1zdGFydC1zdWJtaXNzaW9uL3BhdGNoZXMvCgAg
AAAAAAABABgA7dbH7qNf3QEAAAAAAAAAAAAAAAAAAAAAUEsBAj8AFAAAAAgAAAAhAAQi4dPoBQAA
zAsAAEgAJAAAAAAAAACAAAAAOQsAAGlwdjYtY3N1bS1QUk5KTC9pcHY2LWNzdW0tc3RhcnQtc3Vi
bWlzc2lvbi9wYXRjaGVzLzAwMDAtY292ZXItbGV0dGVyLnR4dAoAIAAAAAAAAQAYAABEHchx56gB
AAAAAAAAAAAAAAAAAAAAAFBLAQI/ABQAAAAIAAAAIQDH5zXW8AkAABYdAAB0ACQAAAAAAAAAgAAA
AIcRAABpcHY2LWNzdW0tUFJOSkwvaXB2Ni1jc3VtLXN0YXJ0LXN1Ym1pc3Npb24vcGF0Y2hlcy8w
MDAxLWlwdjYtdmFsaWRhdGUtY3N1bV9zdGFydC1iZWZvcmUtY29tcGxldGluZy1pdC1jaGVja3N1
bS5wYXRjaAoAIAAAAAAAAQAYAABEHchx56gBAAAAAAAAAAAAAAAAAAAAAFBLAQI/ABQAAAAIAAAA
IQDy82ckdQMAAKEGAABxACQAAAAAAAAAgAAAAAkcAABpcHY2LWNzdW0tUFJOSkwvaXB2Ni1jc3Vt
LXN0YXJ0LXN1Ym1pc3Npb24vcGF0Y2hlcy8wMDAyLW5ldGZpbHRlci14dF9DSEVDS1NVTS1kcm9w
LW9uLWNoZWNrc3VtX2hlbHAtZmFpbHVyZS5wYXRjaAoAIAAAAAAAAQAYAABEHchx56gBAAAAAAAA
AAAAAAAAAAAAAFBLAQI/ABQAAAAAAGpvU10AAAAAAAAAAAAAAAAvACQAAAAAAAAAEAAAAA0gAABp
cHY2LWNzdW0tUFJOSkwvaXB2Ni1jc3VtLXN0YXJ0LXN1Ym1pc3Npb24vcG9jLwoAIAAAAAAAAQAY
AO3Mze6jX90BAAAAAAAAAAAAAAAAAAAAAFBLAQI/ABQAAAAIAAAAIQDQ4vycsQMAAHwIAAA6ACQA
AAAAAAAAgAAAAFogAABpcHY2LWNzdW0tUFJOSkwvaXB2Ni1jc3VtLXN0YXJ0LXN1Ym1pc3Npb24v
cG9jL2J1aWxkX3ZtLnNoCgAgAAAAAAABABgAAEQdyHHnqAEAAAAAAAAAAAAAAAAAAAAAUEsBAj8A
FAAAAAgAAAAhAFYaHmWuHgAAnl4AAEQAJAAAAAAAAACAAAAAYyQAAGlwdjYtY3N1bS1QUk5KTC9p
cHY2LWNzdW0tc3RhcnQtc3VibWlzc2lvbi9wb2MvcG9jX2lwdjZfY3N1bV9zdGFydC5jCgAgAAAA
AAABABgAAEQdyHHnqAEAAAAAAAAAAAAAAAAAAAAAUEsBAj8AFAAAAAgANXBTXZFgvldRBAAAFQkA
ADEAJAAAAAAAAAAgAAAAc0MAAGlwdjYtY3N1bS1QUk5KTC9pcHY2LWNzdW0tc3RhcnQtc3VibWlz
c2lvbi9SRUFETUUKACAAAAAAAAEAGAAowSZEpF/dAQAAAAAAAAAAAAAAAAAAAABQSwECPwAUAAAA
CAAicFNdY7SgTiIWAACDNwAANQAkAAAAAAAAACAAAAATSAAAaXB2Ni1jc3VtLVBSTkpML2lwdjYt
Y3N1bS1zdGFydC1zdWJtaXNzaW9uL3JlcG9ydC50eHQKACAAAAAAAAEAGAB0q3ktpF/dAQAAAAAA
AAAAAAAAAAAAAABQSwUGAAAAAA8ADwBhCAAAiF4AAAAA
--000000000000526171065e2d8110--
