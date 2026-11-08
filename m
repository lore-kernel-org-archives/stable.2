Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173035;
	b=k3c2VAFr9rvwnUYDOmj54ElfVN5e6KR1eABrZOGFUyXZOP98DnsnArJVtXE0rv9S6xj4
	 T18fDHzqvZq2L6RlKbHeipIzcxdAXiMzMFKW0olvpSGJphNQGHyFBE69EXScEeyCG1tOB
	 LurWKGK0OZ1CHncFhKyhY2uhfzIT+LyyN1RPht2p9Wn4720JEuJwxHucjSUXc1iEf5H+0
	 BI7PTLLUGUkl1io0onwLe1TVjFuxcJafVwW/+1SF5v0/gtWD4wcHlcZR4sU7/gFtWe9af
	 EKMYAZ7CxJQIJOSqZpdqPGNNvehq1wtF+DEJmPXZFP80UYHyJhojHSZggmFeG0i/3Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0dO5iSkJD5cA7k3NwfI5mURiH/0OkxrsK506UFd+u1o=;
	b=GziTf4mumUbzCtOgEudS3tuvMiMLoxh8R54K/0BPErfGbZpUC1dF/bO9A6dde4MP/rLK
	 GRPSmKTm8j5kJXonj7lWA6UTSJTLg9S7D+GergVYu9S8z1XOC9owRjQeRpuHvPvQprJJe
	 06JhA1V4SFO/jRjjDWjH0HNQxRmOo36Bn0JLOmFnluYtw3JjZnfdOkobECUKb/8P5vq5l
	 0IM4Pe63vJ3SnEVwOlit+O8ovNIHooDf4Qn70h17T0Iho1OMfmPp1O3FLA64w8rEEgOrg
	 4Ks05emLbPIKRFawUSLCrsAEz8yow0PPbApSTF23xZchkMOisxeBUp5N+xDvgLHHM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc5X6L62;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B8606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB2B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xc5X6L62
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-70b875f6f1fso204793eaf.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173034; x=1794777834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0dO5iSkJD5cA7k3NwfI5mURiH/0OkxrsK506UFd+u1o=;
        b=xc5X6L62W5hPwVVzyv0d5KnkePewIvl1sBI+PzGXtxgxc9t7jN5vrM0dvbC3evxemQ
         CoK5GWxEJAVFMZvvi8Vy3v3QBH9y9nruTtVdxdd/H+UW3Ra4YYaMzrCVqROtDXLNksmw
         pH6mnela8bjRiwmBZecc1lt1OtYJU+MYBHh3kxUeM6rZ/D4wwqMyqVRInGgOR1ylZ7GX
         ywOLdMiakstke4Noqu3dTu0I6xhvf8wYk5rZkodBpv9NCLNUmuP++FqObrBuk0bkJQ4m
         wvvx7E6kqmqOPk557J0lvNW/50w1SfY8P2sv3jLEctyUJEYOWS9uFdnksi0ZXjFnwfMv
         bOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173034; x=1794777834;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0dO5iSkJD5cA7k3NwfI5mURiH/0OkxrsK506UFd+u1o=;
        b=DxKedyZJJXTBB7rKM8UwOSq7ECj6p7F8wl6gZahqhTSZJnYwm2fMfPF105BC/zGPY3
         QnmvhOVjnOYBRhXiQWaqfpcBffbkoARU0rwTDjX7C8/MMZ/wX9BeLvJj4BUO8T0HRPWY
         +hGhrQVYBoa+d3NjVUpBNqhl2ZQYxeh5RZIUZk3NzcQGeatchmqemUqKMdZdWfjkxeIX
         YvMPKMInXM6wNrRRp08wpvo4a87hVajK5j9OAxpdm0nDu7Np/0VWEky9AEBc5FgVGds3
         46UvpXLJBz+VycQx2D0ReGCjF1sBAYZskS0b1rg6soCXfUOQ0xC/S9f31y+Q9ogjN8Rt
         +MZw==
X-Forwarded-Encrypted: i=1; AL+hErHGGNXEDCPvlJ63yoW/EWSnuG+OKmjagQ+fZrrStjfM7g8wHMcpSfWf5HB9OQe09+UGQgyYOg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+X4+Fozo+WeH33Zhf+xiWV7MhbQwyQse+H1ZX+ybH6RiMfy0Ju
	0jxMqXOwbc924ZVbkp7XHnq6vxCp6yCP+5oihqRW8x8O6U0Ml2fX7RunxVRc5Q==
X-Gm-Gg: AYBFou0GEsZdXDoEV73v5HYb94R4Qm56wgF/W8F9cT5QHRzBRwcxzJsEzW9tcwCn6OS
	758ATDfMt7W6FuDqHlEE/1/6QK9rKL8BmL+Rof//VEuehE8EqMLFYrs/RDguB6XhCWmEaDNddA9
	b9gR8SPoUvJejeEFOwffjV1pz2O1FdQiRojvSyOKa8GLb9EpmuFn7tNwladrnt+TzzeuS34mhSD
	iQZRGbow4Uqj2lzbcUH44kJ5aRLOXxBZHa7QF2Pyko19/aWfMLJ1WKKDNbHOK7RUtBe+eae/uzG
	ZYSkq4FjXSWnovQouuIXQT9UrCYwTcF+H6RvUD+n6F3TeCevM0+0qTepZNG1JSCNh4O6AE9quTg
	v6u8UHoVQwkv4y39A7Rtd+bIy1UmW4XTSKR5iEzfWiJlIeUZ44v600JujIp4jeru9B6lWtChUhq
	9hfW1LP/EKqGDo4RTjEmYsw2Bn33AzP6bqplDwHE5OER7z0F1PkjUFYFQ9IzedLthtrX4223ra/
	6d2s2e3IIpXMAkdIMEyBZLfpr7nx3nYtkm57cz6HN3hQvB7WQDkVlDQeO8SHlQ/0PPb/BcSerRc
	A+qm0Tl2ieR4kfYuVw8EMwH0zIHDHtoBKTlwewAbyFOUIPAovMQbFgDIcpmCRCwzsl5Io6HtT6Z
	OuzmLYWGP83BHwXM9vvcUhaA561EFF0YBAW5cvP4BEqJdeSkS2QNflWDETV/T6xXpmFikl71oqB
	rlR30A6cLmdvEwld/thJrtIs/li4agNHBthGChUMe2lFNXhyCK6xg=
X-Received: by 2002:a05:6820:1395:b0:6c7:af50:b2f2 with SMTP id 006d021491bc7-7170f2ebe0emr1088943eaf.45.1794173033669;
        Sun, 08 Nov 2026 13:23:53 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1908138eaf.12.2026.11.08.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:23:53 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/2] mtd: rawnand: serialize OTP and BBT recovery
 operations
Date: Sun, 08 Nov 2026 14:23:21 -0700
Message-Id: <20261108-submit-rawnand-operation-locking-v1-v1-0-565010fc5f8b@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQ6CMBBEf4X07AZKDDb+ivGwbRdYlYW0FUkI/
 26rxzeZebOrSIEpqmu1q0ArR54lgz5Vyo0oAwH7zKpt2k7rxkB824kTBPwIiod5oYApj+A1uyf
 LAKsGjY01PV1M588qm5ZAPW+/l9v9z1nzIJeKujQsRgIbUNxYoin5uuhroS2p4/gCxoLZoKcAA
 AA=
X-Change-ID: 20261108-submit-rawnand-operation-locking-v1-1a0b8fe786d4
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kyle Roeschley <kyle.roeschley@ni.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

Use the existing chip/controller serialization for the Macronix OTP
transaction and for marker writes after a BBT erase or write failure.
Both paths issue NAND commands outside the ordinary MTD read/write
wrappers, so they must acquire the same locks and wait for suspended
chips themselves.

The first patch makes the existing helpers available within the raw
NAND core and uses them for Macronix OTP. The second uses them for BBT
recovery.

Assisted-by: Codex:gpt-6-astra
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
James Hilliard (2):
      mtd: rawnand: macronix: serialize OTP access with NAND operations
      mtd: rawnand: serialize bad-block marker writes during BBT recovery

 drivers/mtd/nand/raw/internals.h     | 2 ++
 drivers/mtd/nand/raw/nand_base.c     | 4 ++--
 drivers/mtd/nand/raw/nand_bbt.c      | 2 ++
 drivers/mtd/nand/raw/nand_macronix.c | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-rawnand-operation-locking-v1-1a0b8fe786d4

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

