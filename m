Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=162.216.242.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793652149;
	b=NjDCAm5meoFedoc9LYfOob7NeJ4wrEgux/rccLtIiCiCpnnn/13X/mk7GAqzEUqCU0RD
	 gsfY1dMjBwo7sWNR8pyoZGE4MirgldsF6qURFX07JuQ0c6FGQ138fw+mXmp5fcZmv6Myd
	 emqasAm8Eu1EEQxWsCGCfOjw/RKL4YjMgrje1Lr5vHaGaUxRPo09kYjzBIO3+p+EQ3/p+
	 2fHMx1NeiswUhzMdm7FSNkfdLr73FZWgIjl2BYAI2VHXfoLXMRbmrSe2Pz0QKEvpYh2Y/
	 iJ1xYEX12MbUrb1VRBspt6EcZ4UHIHduoeQDRujIhFfwsROR1ZDyDi8C1guufs39lPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652149;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jdwLej7LRbzV+mefAxs+1tsHzSr5xmWYipR76wcJNxw=;
	b=Xqzoouooxvm7x1NJDkIhqqoEK0Giqozv7zenizDs7WJFpyPpAafUdi94XRAvcyff0C6n
	 InY87MIW4hs+sw2A/kqLNNzheLpJcjwA4jMY9aMcf+gcKepkihBh+IEVXYu5j7X4MPn/T
	 GDHPtdj2m7ndb5hIupYmLLU6KbKyDSvc3QaqUYBLNvockKPKcw22N5G5PZPxKwq5p1vQl
	 Pc6prDtvcnzwS6SDRn1EwQWlwMmORGoeHuaRUmBWJmrgD3k+94ZKIL9aBAUDFX9TaONUz
	 kSS7uo+mCaMMIBrYKy/Q2W5+rburepAhsMfZ2G1sJZVJUxCQjGSX5HKS/tw+TNx95xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mr-miky.com;
	spf=pass smtp.mailfrom=mr-miky.com;
	dkim=pass header.d=mr-miky.com header.i=@mr-miky.com header.a=rsa-sha256 header.s=default header.b=cXrRYpNS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=162.216.242.36
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3CE606A327;
	Mon,  2 Nov 2026 20:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3CE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mr-miky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mr-miky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mr-miky.com header.i=@mr-miky.com header.a=rsa-sha256 header.s=default header.b=cXrRYpNS
DKIM-Signature: v=1; a=rsa-sha256; d=mr-miky.com; s=default;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
	bh=jdwLej7LRbzV+mefAxs+1tsHzSr5xmWYipR76wcJNxw=;
	b=cXrRYpNSLR5ds7YhhQHzaV1bmC1swkI/4IdMNIU19EpY55VdDKOrjsW5DHGRslwMIsa2PF8H8McuF7/ekP8Fgc0zyhZYqWzR/IVydUGHMA362+6aidlArK3e4dpbQkTgs5n6JwcevKGODRXcvbktrTJnHBZ6Lsuw9UKanF6iXNN83U8BZyK173psYvEA3fl/4fa8LBGJMvCSVX47guNn3AGAx9AmJMahqGvCdM6nnLv5pOUyh7Fl7On5WG
	hIz+hlRbH/QuzqaXoGDfBYO9VcojuQC0M4lnhMb61FWz4Q8TVvOEba//GF9YbnCYZ3S6hyn4s2XwBlvk3VEJz7gUXSVw==
ARC-Seal: i=1; a=rsa-sha256; cv=none;
	d=dynu.com; s=mail;
	b=g74vcjJuBFvl4tiPAbHAEdv+S/ayc4ViE3MpREsk6JfpOLbJB1cpGZlPz9XVPau3CYvnjjBewNnalkd61mLGCA3ziMXwB3l280xmJZ+3RlGCWZLKCIC319vVPSA2G98JvJ1OsS05m9FtKsNj/N1x7AcmKBBBW9e8q9ZMz41tt5hh9Iob/ILZmaHmOS5Y28EiezGsylLvfzK+3LaSmdJZy+jSdTqmULIRM8Y9y+BOeLF7UHsDHf6Z5xSn06
	rYUNgY1sZPHzmtypvtlo27M2iwN2OjpazybRGbJ31mwpuyamBMZg4DVYxVRFwJ0y46kp7fWP6IFFIYfTY4xUjWielEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=dynu.com; s=mail;
	h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
	bh=jdwLej7LRbzV+mefAxs+1tsHzSr5xmWYipR76wcJNxw=;
	b=RgJmdk9E+Su8+DTc8/9oF2WB4/yPEms+x+CxX8p/TCnDKTcPT8aC2xuwCu2622Yn5l15WHf57ZEtwKnr0tFxI9OmBmpk+QbysBq+RKKzsWGpggr++zLZtBWsNEL9L15zTL+zCEApm+GPiCYLsLqNwWcFO1Ivqr9N8Tt/TEvP0BNrA94jDjFKy9LWbNx2E3DWTysZ99997EAjrezH+N575tsmV183QVrM/q3477SduoYBMQX6y4yTLFIXBi
	kNhf/WHwb6PRn3Vs0ypZGFNK28JVW7xK/peLtM/BwvD3UCWSw7QLIEMYtEG//U4zxriswQNq4aYnn/hWa7gfCXu7LAfg==
ARC-Authentication-Results: i=1; mx.dynu.com;
	dkim=none;
	dmarc=pass
Received: from [192.168.10.6] (93-40-2-197.ip36.fastwebnet.it [93.40.2.197])
	by mx1.wiredblade.com with ESMTPSA
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
	; Mon, 2 Nov 2026 20:42:15 +0000
Message-ID: <0589f056d5fe47703ffb79b37930d3475a8f2faf.camel@mr-miky.com>
Subject: Re: [REGRESSION][BISECTED] r8169: TX stall with checksum offload on
 VLAN frames with inline tag (REORDER_HDR off) since 1517d1996b52
From: Michele Giorato <m.giorato@mr-miky.com>
To: sairon@sairon.cz
Cc: edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org, 
	netdev@vger.kernel.org, nic_swsd@realtek.com, pabeni@redhat.com, 
	regressions@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org
Date: Mon, 02 Nov 2026 21:42:14 +0100
In-Reply-To: <CAPa5EdCj3v17tB-SF2JNecq5Q8s1Pranr-XzAFWNpNTBPgPG7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Authentication-Results: mx.dynu.com;
	dkim=none;
	dmarc=pass


Hello,

I would like to report an additional affected Realtek revision for the
VLAN TX regression addressed by commit:

c2124f80be4ceb6ec566ca3b5fc87f84ea9c36e0
("vlan: restore HW VLAN tag insertion with reorder_hdr off")

The issue is reproducible on a Realtek RTL8168f/8111f (XID 480), not
only on the previously reported RTL8168h.

**System:**
- Distribution: Fedora 43 x86_64
- Motherboard: ASUS M5A97 LE R2.0
- Ethernet controller: RTL8168f/8111f, XID 480
- Driver: r8169
- Firmware: rtl8168f-1_0.0.5
- Interface: eth0
- VLAN interface: eth0.10 (802.1Q, VLAN ID 10)
- TX checksum offload: enabled
- TX VLAN offload: enabled
- TSO: disabled

**Regression:**

Linux 7.1.13-100.fc43.x86_64 works correctly with reorder_hdr=off.

TX watchdog timeouts were observed with Fedora kernels 7.2.4, 7.2.5,
7.2.7, 7.2.9 and 7.2.11.

The issue was reproduced again using 7.2.14-100.fc43.x86_64.

**Reproduction on Linux 7.2.14:**

With reorder_hdr=on, no TX watchdog events were observed during the
initial test.

After switching to reorder_hdr=off at runtime:

```
ip link set dev eth0.10 type vlan reorder_hdr off
```

The following events occurred:

```
Nov 02 21:26:38 r8169 0000:02:00.0 eth0:
NETDEV WATCHDOG: CPU: 5: transmit queue 0 timed out 5003 ms

Nov 02 21:28:37 r8169 0000:02:00.0 eth0:
NETDEV WATCHDOG: CPU: 5: transmit queue 0 timed out 5395 ms
```

The connection becomes temporarily unusable for both tagged and
untagged traffic, and eventually recovers.

After restoring reorder_hdr=on:

```
ip link set dev eth0.10 type vlan reorder_hdr on
```

No further watchdog events were observed during the subsequent
monitoring interval.

The NetworkManager configuration uses vlan.flags=1 as a persistent
workaround.

**Conclusion:**

This strongly suggests that RTL8168f/8111f XID 480 is also affected by
the same VLAN TX regression.

The workaround using reorder_hdr=on preserves TX checksum and hardware
VLAN offloading.

Could you confirm whether commit c2124f80be4c is scheduled for backport
into the supported stable kernel series?

I can provide additional logs or run further tests if needed.

Best regards

