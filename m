Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474912;
	b=wk1ZiYyKRXXQgwLvREBYJ9pa/UdUiHQejyM/A8X/v+3+S30D9mUN1EGDyUvwXpAg5uOc
	 B9bdmTYAjawuFhFat6ViQJ2YGQnr+hJpSDCIXuwM5/8vYcYQm7bJADjKLU4HgjvCf9stF
	 By9f37Q6QU3l/EJLbDAnx5nAhxoc9SuXuB0VbNKkmcp5SKa7XypWU3MP8Pu/Hu6x7sIzm
	 5bMHuq8ByDL2eXPjTbWBZ6oaiCCLAxAd6Rx12bVVoljkHF1R3cqtbvf//7PhJSQbz6zGV
	 6NCTGAgDYHRoDo84LvUvZB5Qd4uzRcTWK6DZAdP4UzVIk5x/FujsxO0HLIiuLtacy/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GsxQU7PCIOfVFnHVCuEFA8lZ75gTP1s3K7X0uR8/ZKs=;
	b=CSg83wlHy/aAT6vfPj/wXzLrFnwYhJ//ZsAePo2UgVsLv1YrsI4vwpAdfzDxKFRfOaq2
	 jQKN+Q4N96XlcEW4PY+d59y3t9w/IsL8RDPo6rQg40erczw6BY1mpkB6FnrVZnSMhS8V+
	 mkkXjadmntcHnYBKUdjmDQNcLjSbUBFWHPvMxuNxdNqwkj9wE/pV7KiiMJkro6AddlGin
	 T7Evl6tCeb+Ek72pT+/IavNqmqsRIfWpe0wmw7/QQYg0kM3duexfW5oDdM/+ur+72LC+g
	 fCgLpy9eO63vrI2w1dZ5AQHO9DoNwp/JIHZYRAYrXH+pnm0ZnFkPXPN2nUa0O1/gHig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ok8nSORB;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1C606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D1C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ok8nSORB
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so7407262eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474911; x=1795079711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsxQU7PCIOfVFnHVCuEFA8lZ75gTP1s3K7X0uR8/ZKs=;
        b=ok8nSORBKrT1BcKGw2b5VQkCgjetLaWPtoTx2ZcMID4k6GbYbbqMm+sbb5WByp/mqb
         BPRjbv5vaFBwW2u5IQh71Nmt3/9GoWLb7yMhHLVwVGOj5BvTR0M4CoK2daub1vERJCE9
         Er+g5HJ028l6yoc1pFkpaTu6+zwsvyUoXZ+VAf5pUu3fMSTHKCoNBsRhbw7HX5wPpSSd
         YezEVKYY7wXOJC8kac08HlIIrdgp/nM1cB1rUJngGaxmsQ88n2axlN7p4/+Wu9swielx
         usuXHrot8mo+oI0hX/v8t8nH5j20M+kIAM4DhNx2QEh7hM2iCco7Jytq4m3qTj5s3898
         hrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474911; x=1795079711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsxQU7PCIOfVFnHVCuEFA8lZ75gTP1s3K7X0uR8/ZKs=;
        b=dQF3iCQC6f6nqLBSBRigFLgV+FDjocHnPBVvCCDZ9ByhYi12aYFSHxi55Urhjcrscj
         S10y62Rbv9x2VUpa9FFWrjfx6zkvvzm0BBENdwTb0oviCYIp0R51xLQt7QNE1oy8o6YU
         GPtaj6ooWZiuYbM8XFiQ3X0U/Ehv1T1UleHQk2P1wxyxfOQWl3Mo/D9PgNmv9UpMVXor
         0IUL25vgKIYZ2I2v8t+65IwJCGnHOxRW+YjtdON1Zo5wcnAtg/xdrB/tNvBYfyH80/3K
         dA+49O8nzpD1F8uqEn8IPbDDGmUoKCY7GmyxWf7Jc+mSnE9j7wV/irRWo6ELg+Vta0DU
         UhxA==
X-Forwarded-Encrypted: i=1; AL+hErFYzliHweVl7GE8jX1WcdiRbjYjU+ao0wfhDyolZ9LPe+uC7TLAtjGEs+RDFLIc9k+VJX078+8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LK54ekxSGCGVHc8eNcG6q84Rh6s2OOxSI0tddQnKiaWZomK5a
	gMUCE5enCPZx9PLWk78DpcbEa6DZ8B04MbW3tSgtEJwzYt07Xi00im+I
X-Gm-Gg: AYBFou0dhLAh9eskw7x+hi0z8R3ByG+7TgZzoPOXJsdlqUJwSFTIu7oQXxalt3bZWmj
	R+SIbCvidqaE/thIwDyWXzwh6PDoVFMk3M2K8JGX65HFcZyqWBYhKKqZvnAlTAp3zT6WG0wCQyG
	Mt8amoigSBQaFjugzvfT9W2FfaeV9CZR/qUz2FhOsxKw+AwTu7uB2Ir9lIFi646rrudqjhVkEOh
	QdG5XD7X94v0dAikDnSscBVU1HQ46tik9aWTS5vVNrCVSEP/dUXd+GjkrMfD3J6RhXkWq+f+nAD
	fQqX2+TbEVu6KDVNd+TzZ9GV/fQg5Z8iO5xqUbhdGyQ0TCFv+4Cp4u7OHTl/tLdtnOh+ho3eWr4
	TxNyDXCYUdrOrDccyjSg/MnYvSuFNy+VHlqCjXnrAHEgbJtq6BzQPFiZw5LP6Yybtcbm0R9J9s7
	BAYhSSnWd9V0GkHVCxHMoc0iOrsw3MtozA9bWKR5oHz/nqQzdk2p+M+/Q+qVhKLpDu4pVuW3g8n
	JAymowSP7qAW4/C9URpYVh9N2MIrFTFVNtjtwExMRxahEcrpjGe87+ydclbw40SzCW3wpWUaeCE
	0EbmQFqdcp3hrm2VZYm5rt6VLnQMTPEv9sKgV7BdpY6Q
X-Received: by 2002:a05:7300:547:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-376a6d79070mr7136789eec.12.1794474910716;
        Thu, 12 Nov 2026 01:15:10 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:27a4:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e7d24sm40096319eec.22.2026.11.12.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:15:10 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the pagecnt bias
Date: Thu, 12 Nov 2026 14:44:49 +0530
Message-ID: <20261112091451.22969-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths bias every RX page's refcount to INT_MAX,
so a single get_page() from the stack, e.g. splice() of received data,
overflows it: splice/tee fail with EIO/EFAULT and GQI can reset the
NIC. Patch 2 lowers the bias to USHRT_MAX, as other drivers do.

With the smaller bias the driver gives up its last reference on a page
once every USHRT_MAX handoffs instead of once every INT_MAX, which is
only safe while every consumer holds its reference until the buffer is
recycled. That is not the case for an XDP_REDIRECT from DQO-QPL to an
AF_XDP socket in copy mode, a path the driver never meant to support:
commit d8a8ca14c937 dropped the queue_format check that used to refuse
it. Patch 1 refuses XDP on any queue format the driver advertises no
XDP features for, today DQO-QPL and GQI-RDA, so patch 2 depends on it.
On GQI-RDA it also stops XDP_TX from writing into a TX FIFO that raw
addressing never allocates. Trees before 6.17 still have the old check,
so there patch 2 stands alone.

v6:
 - Patch 1: say the check also covers GQI-RDA and why that matters
   (Sashiko). Message only; carried Joshua's Reviewed-by.
v5: https://lore.kernel.org/netdev/20261109100437.331423-1-amaan.cheval@gmail.com/
 - Patch 1: check dev->xdp_features instead of queue_format, and
   reword the subject and message around that (Joshua).
 - Patch 2: name INT_MAX in the subject. No code change.
v4: https://lore.kernel.org/netdev/20261106114551.212675-1-amaan.cheval@gmail.com/
 - Add patch 1/2 blocking XDP on DQO-QPL (Sashiko).
 - Say "overflow" instead of "headroom"; use USHRT_MAX directly instead
   of a macro (Maciej).
 - Say which trees need patch 1, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

Amaan Cheval (2):
  gve: refuse XDP on queue formats without XDP support
  gve: fix RX page refcount overflow from INT_MAX pagecnt_bias

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c           |  6 ++++++
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 6 files changed, 18 insertions(+), 16 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

