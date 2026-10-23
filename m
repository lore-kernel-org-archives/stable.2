Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792725299;
	b=XNXqjeOWryZCZ3AsGnewtvVWEeH+8VQ6Y3NIVOA81qR2lfddZu2pGzM9sPUNsGlni5BG
	 S4lxg38A2OSybY9Js5/SH3DCyT1Jo2DmCI2kyDpn1q+Kmj+xXOxF3jQjOQnUwe7WMhR6c
	 O66ZszsdeKZngyIJMd8S+c5/VYGIPXWZgS3WJkkONBkmgmqMYfyxVWC7fTwXgd4P3k9JU
	 yAOkcP8vRKGM7Q3S3Z+K8AhZGoO31LQsYlyTLv0IXm+6CSJPGOOHCEkikcWCnaHYDiZYh
	 nqdBp7dCwENHGQRM10lu8TKC4ozVO6XwAB524y+TRjzxFVIN3Xa+wTjS5IOsVIkpNAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=pm5LxVvpIboHfA4NG+PJUVszg46D0jGE/bRr+E4n5SU=;
	b=SDPSDyjTitxI1cqTBDxBcJwE+2nl9M4MPoe5om3+vysb5Bjg78XV96ryZ8FAPwBXRtCt
	 dWPTBEni/b4t6QVuntUWor4vM4uSVH4r9fLhlSoG95H3oQHtzMvp5/UVyWBVTEd5uXyv8
	 RbkkK2KOxyKpg8I/5U/YttYZWsQ4BKBO0nQEHlqvrgVsV/+Aunz5PpsdO69Dz3KLwehXq
	 f+1ogaIx/xrq/i+Iq8paNWIoZXd5CTFBG/RGrlxklFYKqs/3z1yxxDfWI8ad2b5mOHfjW
	 RA92iSNZscTUhQsafz0Vure8NG3R84BdA84RtxqtAr/pNFqec3cwu6Qde0eN3haTu9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CRVuB6t8;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DD606A320
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D4DD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CRVuB6t8
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8479f46ecd8so183800a34.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 20:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792725297; x=1793330097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pm5LxVvpIboHfA4NG+PJUVszg46D0jGE/bRr+E4n5SU=;
        b=CRVuB6t842ohZa4yXpdvYfpQQB+JZ8vtj27hDtwFjjfsa5UNrk86UJADeCMRsIjxqa
         w3B0jVWLPBZUayQWGSrcT2aVnDgXTItnaxgoVlpFR0TkgL78lUqWRpOcvw636S8Q09BG
         yR4yZSeT1NkERpWwOviqLHXzV3/8WJ67nFc+NIOzQ9INUQHzivATserbBlCItdspp0t9
         nYl1KBzbtHGGlRvN5XPXIpomcPCI9a2tQ9/MXBWOYl1Dwfw62iIR875KX9VjUuKyvNoY
         OiHfKDksxaJAduJszJFW28kswLh+IGB637b2ztelcdgk89wOHROuaxIiA5NcCXkKEzX5
         RhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792725297; x=1793330097;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pm5LxVvpIboHfA4NG+PJUVszg46D0jGE/bRr+E4n5SU=;
        b=ItYna/2ycy0pJUZIcAz+VqTcF/XYDJN5JCzfidnk5/8uvpv96n6R7aH1rpHrVbSzjS
         EsRlP9JdsD8C+paS8B1/6Cs3WK4zS8Xx1Ng+WSH/xQEIETnv+VZ26UU2MzH4Tx6wD9fl
         Z+98sMBbn0NPzSpmUgOKqhfKw4iMTQiNraeUuFjkUTh85rCwzR8WNd4K1yuab718CEFG
         FP/AuZ09erDGli8lICYk1qvljaBa3A5wPvGgMWyNfsEUutYGOqR8XTecINKIGmUH11Ee
         R07SdA2A+hMnzlX5bKWF5UwdnEbrZvi2AzNqHdRtuWnhxCj40brbD9wS/Y8CzVVzJh7y
         Xk+A==
X-Forwarded-Encrypted: i=1; AKwUvBxe4zP6bHGrw243pq+3mnwIVNm6TCko+YQvg7WL4jZKTGQoS21UTQNyMujod7QkddifT24hxGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZAqmfulIsplReEeF2ZUtLeGoEBEVhJiffg8LvGvg5OSMspjAJ
	XuJtqX8LPI/IdAngSpW7PiR8tzahqRVSISkBubKuAWFKLDVHzYE8eoaa
X-Gm-Gg: AYBFou3QOChdhdUu0WwPMJGwJ1P/sEp3SmYuAKbrkTi+2tWSDk+4NuxlKAI6QVXt8cN
	kAyE6oNGaxZFA3D1OP5sovwZAKCzwl6qOzYKDIpYx5m3CJZCVhDjT3FsLO8XTtJM5NshilIz9cB
	JPNik5qPTX9x/x3ItVAk8+L/lAW9F5Y0AG/m8hKLW0gFB27L3uK6SQLm8ir/Fyh1dNrnoDARwuc
	t/rwY1pXC4HTX4FEuZKgZ6bqLn2qcmiB29N1pXWAKZlzwUejhXPr6I2a03kWQA1tfn2BT4IiCri
	rRcMBRCatUMrZU6sIvjXZixiCse2ogJNzSBHTv7Sd1a2kVSY1gUjMYG0Lhr0nYC/5fdfQY1Ch7t
	B9NesGxtaE3jzMZBFU1xlUoD3g2PxWEuvMtyLcGcRaUtIhSZt0psjQmfcXmEn9NCyhES31Re5le
	72v7mDrGXAGqgwnDxLunxz5bZf8w3BCGBDtjJ6S9pAeUSK/i9uCmrPLe48BKHC74w1qlG0hgvc9
	du+QDLS+pLvoMBLJKMyOy8Ei6YLCuTrwHPd3YoEaf3UIlk8QaSYOpprPWiFow4bjrx9elGU0EMc
	RavDBn/YXIN1DByyDWd+fT6QbDj2pbouMz4vG4IBfhiI/OFfFtB0El/lbNl78aHhXVPmdwZINeJ
	sxAmadrMzR+aVNkQ5FqpDfw4ZIP9aHIhTAisslxjDev7k45rZrTmbkU5QRA1uUKOy5/MbKnUHbp
	1K7to=
X-Received: by 2002:a05:6830:412a:b0:821:94d2:83cd with SMTP id 46e09a7af769-84fafc689dfmr760717a34.9.1792725297222;
        Thu, 22 Oct 2026 20:14:57 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84fbda584d9sm938638a34.13.2026.10.22.20.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:14:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/6] dmaengine: sun6i: fix interrupt routing and channel
 lifetime
Date: Thu, 22 Oct 2026 21:14:51 -0600
Message-Id: <20261022-submit-sun6i-dma-lifetime-next-v1-v1-0-01085f684c9f@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WQy2oDMQxFf2XwugY/ZNnOr5QsbFlqXDrTdmYSA
 iH/XrfpJitxQfccoZvaeO28qcN0Uytf+tY/lxHsy6ToVJY31r2NrJxxaI1zejvXue9jLNh1m4v
 +6MJ7n1kvfN31xergyduQBBJYNThfK0u//jlej488IO9M+y/4f2Pl7/OQ7481VcvGmj7noTpMR
 SQwlhiFMJdIkI0DBAwZTLMJnGuR0D9kZafTuPkwNfQ5AUSEWIpptRoT6uA0wloyMoJjKQmfW4K
 RrKSWWmZjgQiDESd+YBKiA2/I1xjrcysF51JMTYCpgQxVJGl+vMz6kBm5hlQsizre7z+Uy8BEc
 wEAAA==
X-Change-ID: 20261022-submit-sun6i-dma-lifetime-next-v1-53c3158f4841
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>, 
 Maxime Ripard <mripard@kernel.org>, Jens Kuske <jenskuske@gmail.com>, 
 Jean-Francois Moine <moinejf@free.fr>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, 
 Chengfeng Ye <cyeaa@connect.ust.hk>, 
 Nguyen Minh Tien <tien.nguyenminh@embeddedlinux.blog>, 
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Correct interrupt routing and serialize physical-channel ownership across
allocation, completion, pause and termination. Keep paused virtual channels
off the allocator, drain completion callbacks before releasing resources,
and associate cyclic state with the descriptor that owns it.

The first patch carries Hongling Zeng's physical-channel indexing fix [0],
adapted to the configurable interrupt-bank size introduced for A733. The
second handles partially populated banks, including H3's twelve channels.
The remaining patches establish the ownership locking, pause bookkeeping,
callback retirement and per-descriptor cyclic state in that order.

Based on DMAengine next at aff5e6a77fc6, which includes A733 support, with
the posted IRQ-safe locking fix [1], channel pause-bit fix [2], and the
virt-dma synchronization helper from [3] applied first. The synchronization
patch uses that shared helper for the sun6i device_synchronize callback.

[0] https://lore.kernel.org/r/20260706064123.66035-1-zenghongling@kylinos.cn
[1] https://lore.kernel.org/r/20260926171049.841335-1-tien.nguyenminh@embeddedlinux.blog
[2] https://lore.kernel.org/r/20261021-submit-sun6i-dma-pause-bit-v1-v1-1-38d286b69dab@gmail.com
[3] https://lore.kernel.org/r/20261022-submit-mtk-uart-dma-synchronize-v1-v2-1-fdaef0e2edd6@gmail.com

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Hongling Zeng (1):
      dmaengine: sun6i: fix physical channel index in interrupt handler

James Hilliard (5):
      dmaengine: sun6i: handle the last partial interrupt bank
      dmaengine: sun6i: serialize channel reassignment with interrupt handling
      dmaengine: sun6i: track paused virtual channels
      dmaengine: sun6i: synchronize callbacks before releasing channel resources
      dmaengine: sun6i: keep cyclic state with the prepared descriptor

 drivers/dma/sun6i-dma.c | 153 ++++++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 64 deletions(-)
---
base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
change-id: 20261022-submit-sun6i-dma-lifetime-next-v1-53c3158f4841
prerequisite-patch-id: d6398447647aa0dbb005b5e6dc6ba96e642efa86
prerequisite-patch-id: f67c1f8d8d9e014cc650f2f37648662430c3b77b
prerequisite-patch-id: 8522878df4ecd4fb007cfd32611359e6eb58a1ef

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

