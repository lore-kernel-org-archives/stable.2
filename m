Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285018;
	b=t4j8bWobSolcygs52Z10ADoGd5T74fxfbb7GNgVZo+xc8KmlntCQYkMDfzZnTcyDGDxO
	 p8rF50k0NZAk3qDNXBH2LT+rm6wdEUrnXuJEIFzNZ33h7v/5smyBPpLZCpRd1irlACdKc
	 FGGgWE0CnZYubfPEh17FspjTQFQkTy7gNqjSFjli5yM6tllslj8tIoFT3KnoLiFG4gM6p
	 fhrOWEgLFDSqBUVjUvzaH9ZO1tWgdnb53Wmv7M2OpjrGnTuR6Y8B0PQgsT9OZo9n9a4ys
	 l2gYsV60cTj6DZBfxUnuVj/OHRfXy6YvYzHo4/7+vptNZLAn+SEBv5XQcgZ3l39SCSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Cc:Subject:Content-Language:From:
	 Content-Type:Content-Transfer-Encoding;
	bh=ARwkt46ETU4QfSlYk1Se4q8695h+2dXA0luysQXlL7E=;
	b=fQ5Aw/KEfUcWBjTRH9j1cU8rpQ0OHTk/UyDPbQZnvY1dvPN9QX3DMSM+PqRNtHn33nUR
	 EvXJG3OtYDB5EpPZQlQ6gb9a+9m4dTm4L/q10UC7kcsaHA1AsDhUhfnnWoeQkhX00mAzc
	 oyFVbm4A+3vgVy6Ii4/q0V/3i7+Ob47soL0PHRg4yv5K7rnEfaf/8QvQKMq/pYB/1j/eC
	 RPHjvxSo5/IM/Hs99+mycV2SsknIG0asXDdl/J4/L1WeKKDrYvhf9+toZzrwXehma9zI4
	 4CzLg5H1NCZuHenecNNvuGJ7OdnoJ2oOX8oyc5YmdmLYrnJi2EfW83s+RRhEnlcWUFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srraWEtX;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8A606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 18:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF8A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srraWEtX
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1042258f8f.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285016; x=1795889816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ARwkt46ETU4QfSlYk1Se4q8695h+2dXA0luysQXlL7E=;
        b=srraWEtXHC8ArGjTC1vVDJjfpp8nH6SXhOOdUYfFG+5tZiyEjUjYQ7ERvGe+PoRWFh
         weHFc7Pt9MDGP2xPbN7YyMoECGcbPbgZWzMM0JbgEvUqz6U7bVCXIH6AqFbsJMY/PC9M
         m7GN1hQZpG4fzxJbaf9RgwA8+/ZbgjCgiSzoVc/54OQfyl6nC/hv8ZK7NlMIfvoZAsUS
         hia0NmZ9lTcZJvdcO4Lo8drF4EjUu0nv1A5pDWDq7HFMhSzJlNhwTXUyxciLfeUIo2au
         sb94xCyOo05RSIdRZfR/Eg2dSgwkjEnDEyZnqQXa6vkpRxdMbzl6f51v5BQpYrI3IjcP
         0xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285016; x=1795889816;
        h=content-transfer-encoding:content-type:from:content-language
         :subject:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARwkt46ETU4QfSlYk1Se4q8695h+2dXA0luysQXlL7E=;
        b=tJQUsgztvUR8KXb6WxPKuq8WWPAxprjia1d4mVsd9tYXWsMKbmWGtlUOwKnqw0E5SX
         mIOAhtETCHGxl8CEYyEebsHNnLoEKeG9qgzbhvvfdgZo6ajyi1cJ6zqmasoTCnzlotlL
         UuaNDmMJ111jTanbaT6tRh1TNR5zx/+6dpMDmOfq/LEbPteGeWLDIO10NE9I0wnorwmM
         dGB3bv+Y3omykhkIH0aTNRQ+OC9VMz3nA/tu1ouYBHucKsNTM8ahVINJMBN8OM5qnXhu
         vvtx2mx8fzVSR/mV+RTfahBYOEwAK09ZdAzTBbPT2tVfkWkst/g8s18274lcNlWHo/PA
         QHTg==
X-Gm-Message-State: APuU4Z9HN+8qVfFq+Ipz5nlMpYGHFtJDqBw8fqZOM1NnEGKJFS9it7JK
	YAy7+3Dw9aOcc5lBCZGSWgILJtOY8ic1btwGkcfdqEab6nyP1x1p/nWwbK2ueUQN
X-Gm-Gg: AZFdTZckZCWp3xgnRdFBO+R3mFyvfnlRliBPJ7M1/jPUu4zYkmHBiZHKZUcPDY0JCua
	WnE88nzZ0lNBuqRIe/Ku/OOdm+w4bpLBICt/Y3wIpYLI8x4fkDv7acWX1x1/XdmunyMoecj8Vyj
	2PlNvdyAqGddG5ULLrqjj4gwdkKeBT6TtROdXVzcHWaVNl4xHgtPCSHZTCO37rJFZyNdxtBwAQy
	eJQOvgIOUQOU8bWqupk1Yz7J+oT6FHYbPUX1pBgVyfV2rmqjscjZ/RrE/zfLacKZkgj6jE4buvl
	czWWrV0ZJy7F+Sdii7A6B4EB0JGZRTHvuKoALV3Fx81IVH0cQdi19FRYkxb8LfosydGf8ckpsVZ
	1Vf8VRUBdpS6oHgiDORDOQQErjfl0ofkLbdFYUjNsdm0RMwVbYv43IqbDKgGPyRjOTnmo27qUhY
	JxFh3P1vG3lbNkRne6PNVzaqyvUU29IT6wPiUFyyDt+CxClat3m0DUguhUb+9tl3BlLY7HYXxoc
	T3ZI+FitTl23muTj4L7JUI8SwwYMdRC88RfB3TyfZyHrcyLIZgW/npdTRYpXQEX/SxWBS+9DIlA
	TVVPAOrWOidfEx+spQW0FS7BiIweKzkWXNM3Vo9l9hK/73YRrPHaRehH0FC+7bO6ROgCEQudQXH
	3tr+0X7X9SVaiRojwTR7Nnbof1a8IQZTJ76hSw8G7/TCmYMnBWrd8laJA3iMp7oVysZ5Dj6hGD+
	IJBYacgXrYAAqSsf3gIpMMB0D+l2YYr7ZRUA/A3HrZlT0tsiKWcl8bo0+Jqg==
X-Received: by 2002:a05:600c:4504:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb888284d7mr154526845e9.31.1795285015871;
        Sat, 21 Nov 2026 10:16:55 -0800 (PST)
Received: from ?IPV6:2a02:1812:1423:2e00:b41c:537d:f8c3:65e5? (2a02-1812-1423-2e00-b41c-537d-f8c3-65e5.ip6.access.telenet.be. [2a02:1812:1423:2e00:b41c:537d:f8c3:65e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f643adsm84736485e9.1.2026.11.21.10.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 10:16:55 -0800 (PST)
Message-ID: <aac8e196-3fbb-4445-b154-5b9129dde41e@gmail.com>
Date: Sat, 21 Nov 2026 19:16:55 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Cc: jack@suse.cz
Subject: [6.1.y] udf: VAT inode size checks
Content-Language: en-US
From: Aymen T <atijari00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please consider these two for 6.1.y:

  5163e6ee1ea7 ("udf: validate VAT inode size for old VAT format")
  49f771d14578 ("udf: validate vat20->lengthHeader and VAT inode size in udf_load_vat()")

6.1.192 still computes the old-format VAT entry count without checking
the inode size:

        map->s_type_specific.s_virtual.s_num_entries =
                (sbi->s_vat_inode->i_size - 36) >> 2;

so a VAT inode smaller than 36 bytes gives a huge s_num_entries, and
udf_get_pblock_virt15() then reads a VAT entry far past the VAT data.
On 6.1.180 in QEMU, with a crafted image on a USB stick, that value
became the LBA of the next read.

5163e6ee1ea7 applies cleanly to 6.1.192. 49f771d14578 needs fuzz on
its first hunk, because 6.1.y doesn't have the udf_block_map() error
handling that surrounds it in mainline; the resulting change is the
same two checks. I can send it as a backport if that's easier.

Thanks,
Aymen
