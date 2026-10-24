Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834221;
	b=4wD4DmGo9RAcTx/7sG0xtIyAcl7Ji5+ET9IDXEoYCdrbNfKtpJSNRIp0HbmYTrLIxu/a
	 zGMPlIqZqu2FNOScRuVx2nOR9Ma5zsKZL9abWFWc+OMgzfZAaPkTa3XpgooQ9qXDRDWxO
	 vyXJfz5HnzlQpwEVjQSU26ud9qKoshhrmsykZ1/xyhvBysJSCcw2KqQuRVXhJUeURRZ+4
	 8lnFM8/MzValU9ygBSsmZHKzZGSag7bsqcCEDVJFT+o+DeTFJrX7Q017ik7gJZfGm+crr
	 D+V3eRs8jnRIYGQijgVeH9mQENxKtflqnpfw+urlcFZREXl4jIHvOQsg0uqLtm3jSWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=T/uGr9O5F7z9D4gBA52zJiYNaYbWI1NRoXexG5R5ETM=;
	b=ylxNQEF1RL2B3wNDd6QqxFQoiuAQd9bd6JANeP6CKDgo4mwKIItJw8AJrqS+aBz+VCp3
	 jw9YLX/8jlF96bzc852TNX59QJxfOqGaIIi6gl6CoWS6yQ9iSOV4BnI5ZvOfVCSiki0MC
	 5cSklAzWWgpzB+LNnS4cPG4OlUrh+/UY0yqN7Vjtt8UFKAWAbtffij8BJSx1NedMjGX/C
	 3M1sn3gdoD0q2gjW8zOW2Q5X5BGASAEvHSExD+wkpzYJv1MZWYjFIj8VWEoBMPadapCEg
	 yCQPtvoIN5EpABeBDZBRkEm2BqIvX8Jamncz/U8ZjEitykWbbjzVh0E6xu5bM/e+0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YtgVCBXS;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999C606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4999C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YtgVCBXS
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso604839a12.2
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792834220; x=1793439020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/uGr9O5F7z9D4gBA52zJiYNaYbWI1NRoXexG5R5ETM=;
        b=YtgVCBXSUeVcu8Mqv7J5aUu2nXj3G0PBC8eaw6IEYZbYR7toBD03RGII2GHcevewBc
         uXSyjYy5oPmaYloGbnWwwG+1sAPv8l0xVLdGUPO7PCxTdlvM4MRy4sACFVDhRR1g+Lrh
         6jcBf3IYdDe7ounKGQ+ZyL0iDvqPbUMkpyZfzNEWh1NgmatpeKW4YXvhE4m3BLnCL81f
         euAlYL37fvC3VSc1e7PHCnwVSaTcJv0H8AjKwAzSEtBbOysjDdFULIs70a3bGTWmF0ne
         m13LCDXUO0x0qrWH3/PVgXfCjZShU3lclP9biOLLPHmNEmjMG/IzwISZ51CDES475xJN
         pqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792834220; x=1793439020;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/uGr9O5F7z9D4gBA52zJiYNaYbWI1NRoXexG5R5ETM=;
        b=Mr8PLsBR1N+T5Fvrl2eKf22chQCcWS8TBeUmYe9htrdDx/KhMhs+kMtfzCqh5NG1g7
         ltZcYiKg2mDLCes8vR/Ek1EPPLmj5PjKtS1GuLEOGPVA6k0efH+1cERIpINUhnRft38g
         iYq6N+XaFBYl3zRwskaMlf2q5XoEGq3WgO4fPTyAVqTUEHUsIS6KZZXK0aQUeUPW/SY6
         +2+NXsLyIyUwk437GxrcusA6uD/GNInPfiqb3QpH6kjJKMR3Qt1JFMMwSx6TabZzLNwO
         JwYXc9znZehBbDO83KEN1v8OsqWvihOqs1nZM2GtC6h22hIZDfyUAWCStwvoht0PhdmV
         wdvA==
X-Gm-Message-State: AFq9FYJSGqB5tcURrwKJo9QrLcpo5wgd4KTreQR34MSxnrZDsOVYa//R
	oHwH97yeolq4y2g5dBF6JY7Pk9OOID/2SdHQ52PhoR9qMEVCfPMuEyvR4KfM/FpNQDA=
X-Gm-Gg: AYBFou3PQ79rfYAne9UxqEOJXk6wjRXnscHNaM5O/VBJee2LDSDe5Pn4qJ9k62KQHKb
	dTcj1Lpb0ul13pSeO8ke1/eVOc6Nh3oV3FwlVLHwIridrv/bpbRCszcZZbhi6Uv0Yi1EX6DV7+l
	dCGq06dwztRTsCb/MHk3DgFebi0ZQrhUx3WhpGSh5yGgBJ0JSB4mVWDPi7yEVYn5jqWBitARM2N
	yR/uMKylgumJKbjlIeNKcHAwi5PfCbJm3Kw4VEXW6lU16zJzHf8LeiwxbdS6k0DEL1afyeDZ1ez
	lIXVWLUdg5ztF1+cXJ+Umw6lkdKUu0FJ14Bp6TU6t2Slg1wwgQjemSMvz+BimWjwlSHG9HBhsGe
	iTZtVffUlmF2w1rrZCXsrH01xIpQweUP2nwNY6rEhlukvOloIn76yKmRtiLw6v+M80Lc1RIb44D
	aui48nLj/tJ0wI2Et/DtlAh/AmSF4IGjulvUxFfKm+hzMrpXBItfQvwipSJsJQEr2viwjccjto9
	n37P36VXd6DaRD+Bie4iiOTCHqcWvy/CQi2i3BSNE+KOuoiQzXUhbzeT3cKMpcSzQer3X6m7PCO
	O4AkHrJfnUQQvP16Qen0KS+xsPIrsb2C1e2gWejxQhI+Vw8+kxh2eiW3aVivGkaKnDqPV9yX9Et
	j2drcMgIbdjPHqp1dms2qgVqUW4Bb41Y8gEQeUqdhvjtafJdI2gcJ+0d/YeGns5+XCBfHTKLl8Y
	MJDH1NRLks9ORW+njaXjb4QupqvpdX93nvh0SCvrcXI4/0GQqswyBFKxWs
X-Received: by 2002:a17:90b:4d09:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3adeaae619cmr1148374a91.20.1792834220445;
        Sat, 24 Oct 2026 02:30:20 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af32085sm4345075ad.2.2026.10.24.02.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:30:19 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris J Arges <carges@cloudflare.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	netdev@vger.kernel.org
Subject: Request: follow-up fixes for "net: add xmit recursion limit to tunnel xmit functions" in 6.6.y and 6.1.y
Date: Sat, 24 Oct 2026 17:30:10 +0800
Message-ID: <20261024093010.485-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit
functions") was backported to 6.6.y in 6.6.160 and is currently in
queue-6.1, but two upstream follow-up fixes for it were not. Please
consider queueing:

For 6.6.y:

  c38b8f5f791e ("net: prevent NULL deref in ip[6]tunnel_xmit()")
  77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5")

For 6.1.y (on top of the queued 6f1a9140ecda backport):

  77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5")

The queued 6.1 backport of 6f1a9140ecda already includes the
"if (dev)" check from c38b8f5f791e, so only the limit change is
missing there.

Why:

- 77facb35227c: with a limit of 4, setups with multiple tunnel
  layers and MPLS lwtunnel routing drop legitimate packets with
  "Dead loop on virtual device ..." even though there is no loop.
  6.6.160 now has this regression, and 6.1 will get it with the
  queued backport. Upstream raised the limit to 5; it is in 6.12.83,
  6.18.24 and 6.19.14.

- c38b8f5f791e: iptunnel_xmit() and ip6tunnel_xmit() can be called
  with dev == NULL (e.g. SCTP and TIPC over UDP), and the new
  recursion check dereferences dev when the limit is hit. It is in
  6.12.78, 6.18.19 and 6.19.9.

Both commits cherry-pick cleanly onto v6.6.160, and 77facb35227c
cherry-picks cleanly onto v6.1.190 plus queue-6.1 (stable-queue
fa04d3db75). I build-tested the affected objects (ip_tunnel_core,
ip_tunnel, ip6_tunnel, ip6_udp_tunnel, the GRE/IPIP/SIT, VXLAN,
Geneve, bareudp and GTP drivers, SCTP and TIPC UDP media) with W=1
on both trees, with no new warnings. I did not do runtime testing.

I noticed the gap while checking which stable trees carry
77facb35227c.

Thanks,
Ting-Han Hou
