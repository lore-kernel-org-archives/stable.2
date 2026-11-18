Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965854;
	b=IFjxF9ubYjo9x4teYnG53jsHN3tbuAQAozLEjVSPEawLO/pl/40QwBlOM369zpOwYZg2
	 DI8xVjbCkKKHzcRbrerHB1Cn68pu8pl28OplO1gIDxLuE2IlQwwi4lsDQtTw4i/8uM7te
	 I0IRiOQD8hw4/MDztPoQ7Sgz6VUOaN023uZZFQ0I015w9w5ZZwBLmvrET2lQeiBLkQ6qQ
	 BC5BTlEh292IShXLvUu1mGkjOEGTGvRtSGO6vs8hn/C1iXPQ9ht1Nz1hxU8et/Ktj629x
	 UrjPIHyBvdp4676c/SsyqDb9XxG32CVIuceYi9jEh17yqbA5uDYIi/g6wuzfh0eorqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w+zR/XXDQgDFZvwCaQMa48ck6Vax34QACtIpBS7POtg=;
	b=20iPBcBotx/ea1TALXcRob6/KA8H/S2DKY6MNuQkKze19J6LSGt4Kf0Mr1tJkchEsSXa
	 VtpB3OluvvvrbLSIUJRJ5+Uarxzy5QE05VmUMzHHPy0PF0x/ceLA0LlGC9qvVP8rUOG40
	 8Tvm8PMSF1QMneG9P1b9nA+3ae94k5eHzLCV+y0gXRt4azf51XEGgCvE2W4rRV2DPrh0h
	 jFWHRdPhFaTtJMwK/cGgaYi2uyFfl9ZOQEIom17ewqbfLQ+LVylg8DNeR9+Y11fDbz4kM
	 1n3d2yZEOZ1l9BtuY4SbX/+gWa5YLz9NWASBx2UMrv2QvqBcVO6Niw+V9Cr78s7q68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf0vZLHw;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC1606A32F
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAC1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf0vZLHw
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-382f4710a17so101342eec.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965853; x=1795570653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+zR/XXDQgDFZvwCaQMa48ck6Vax34QACtIpBS7POtg=;
        b=Lf0vZLHwzhXehBm7nldSrNvPnXS1yKJ2nz7KC9QThcizXhWXfC9KaYKF4QEuaypLNB
         C709O+oQWPBa4Cpl4Pia8ohr3CcTiMEH9Z6EADOzR7j/5acovhWI2pXgXMaLMojOYd17
         xQkvorgZsjzMQNGU9EZ55dwSHUlbmZ8uZNGr09ea3X+KfAFOhGSDoyb/6m82htJc7t9E
         WgAe3yW5Xf8U373Sun1Xs+CUm95wPXVKIclZgA7nh1oAMVtrCuj/nfmy2WgMu4ETzz2L
         LwADMYkDW5XYtVIb/+v8GsByiTYbjzj6Aes6bQsdL8+vKVommdr29A+p9KfX94or5PWm
         GnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965853; x=1795570653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+zR/XXDQgDFZvwCaQMa48ck6Vax34QACtIpBS7POtg=;
        b=kWPFYMp+u4UTstbExEpDvvy9S/TBifM7GX33SSuWqSV/PiDpjixhmXnZ3z6h06FIGA
         Yu0xhaHGKidh6O+Y2rfltIKLnK8s8hyLVK6CTp7vTRhEelGnZnPzPNaN/Og72ZCqWvsx
         awLgKTZp/rdSKxY0s8hnTTBVnJmSUNLP8x3lkH00PCSk9AVDHJICZLuUpIYoXfkqB1n/
         qxVHKXpVWiP08ro/VncjzIHmghpEmQN3thTDGBw+fzS7AzIjln9vU2Tt0KiNBuseMeuf
         1pjquJyIT+OoHsOzsanWT/B/qJjwLlitJ8SITe+1sIrgvA9zYNdrc3QMcgIJ9V41Yx4o
         +Ibw==
X-Forwarded-Encrypted: i=1; AL+hErF0w2h4ejxH6zW1B+XIPuFolRe3NVxAHrMMmcZiKqLjqq56qwHmVg6NddO1MXBiPsjE0sf6GB0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2d3Wt7Xm1DzEL1KZKcPL0U2VzDpneUc0LS+yXRM/uk7/9IBuR
	za6V2vkEGQhjndXJq7545dwN4SFZj59nfKBpV91HZX8tMqdpBgv1Tnil
X-Gm-Gg: AZFdTZckLay15iSG1DgK1PGSJaKGSMd2xMdDbyv4xhdK4qq4Q3xNgJy4rgEZU3MLHX6
	widIpUYw9heoqrJ6L78AbT7C8oWVLGyufMtd6ZjbPTbdFtOAYdXRvfzXZYOuuT9s4efUc1m9rMv
	fGs323nuinMz3TsFAbYEe/vN3Bsb56gcN7L+VPdVsCfz/7R/0ZmAjTY/kAmPcqUgAbA1csLMyR1
	9N6h4l5/jAWfxH34++8DwVXLqcv/bkY4KWKcM/6FaIK6Q/uac2CsKZ0T4i72EQIVhF3gW8k8rEA
	rSdMFasT9MoXwcefP+4Td/XrELpOj2mnk2dkaHy8d9MKMYyOzXPdo3S1s7nrPpApy3rGWBtlu3X
	H3dyrGhexTtXJS9OJwzdlW+F+XK+aksbP4CpTsRtb8Ix7UuSnPx6ViwVF68l29K54zwrlFeQe67
	JOyM8QB3qDDDrPOwKB2ez7zlRhfmgl1//0eG4X/ikpPEssHUfigUBiq6J0pGD7JUYNyHCT3Hvqm
	5J284ojdSm9D+ZqmZeRMzqhcz4+MqDxqypr8Iba0Aqag1MhQFw5qpVBYW3fGvZBegwnDfT2M47L
	g+6/VlrGIAMJ+aU3oI+MIlmKWmp/8pYqjz8ol4rxLlgIZfzj/2JVhm/INUd8v71E93rOoi8OYSq
	f0RkrTZaqVHM3vXLxYcUS+0ghSKYV
X-Received: by 2002:a05:7301:1823:b0:379:3c04:2cdd with SMTP id 5a478bee46e88-3828181119cmr1122022eec.31.1794965852451;
        Tue, 17 Nov 2026 17:37:32 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:b1a7:bebf:2fc7:37b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6def9e2sm2094527eec.13.2026.11.17.17.37.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 17:37:32 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v2 0/2] hfs/hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Tue, 17 Nov 2026 17:37:23 -0800
Message-ID: <20261118013725.90985-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114043522.48764-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() checks the on-disk key length against the size of
the key union, but the buffers from hfs_find_init() are only
max_key_len + 2 bytes each. A crafted extents leaf key overflows them.

Changes since v1:
- hfs_bnode_read_key() takes the size of the destination buffer
  instead of assuming it, as Viacheslav suggested.
- hfs_find_init() stores that size in struct hfs_find_data as key_size
  and allocates the two key buffers from it, replacing
  "tree->max_key_len * 2 + 4".
- Every caller passes fd->key_size. On a too long key the function
  clears key_size bytes and logs the error, as before.
- Added Suggested-by: Viacheslav Dubeyko.

Tested on 7.4-rc3 with KASAN in QEMU: the crafted images are refused
with "Invalid key length: 516" (the unpatched module corrupts memory);
an image made by mkfs.hfsplus survives create, rename, delete, xattrs
and appends that spill into the extents tree, and fsck.hfsplus reports
it clean. hfs is compile-tested only.

v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

ozgun kultekin (2):
  hfsplus: pass the key buffer size to hfs_bnode_read_key()
  hfs: pass the key buffer size to hfs_bnode_read_key()

 fs/hfs/bfind.c          | 6 ++++--
 fs/hfs/bnode.c          | 7 ++++---
 fs/hfs/brec.c           | 9 +++++----
 fs/hfs/btree.h          | 5 ++++-
 fs/hfsplus/bfind.c      | 6 ++++--
 fs/hfsplus/bnode.c      | 7 ++++---
 fs/hfsplus/brec.c       | 9 +++++----
 fs/hfsplus/hfsplus_fs.h | 5 ++++-
 8 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.39.5

