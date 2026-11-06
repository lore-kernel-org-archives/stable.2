Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956491;
	b=CI6LX5F3ijUX6WqcJnDytnFk5eXq9Bj55CB36LGqia2dEAB2wCURubvPAbrGZNthTmVq
	 hAt6VHdaap5OFTLOyXaO6JZ/TYKMvCF6TP3G6PR/XpFGvLz4aGnkrtowbKqBd1AVYO6f3
	 mO9Rm5Amq92wNpauFRabSCeC/mTqgMVJC51Pzsn8dOrLLFYuPAMGiOQB4avx88SeU/ic9
	 8Bwt5yRO/e7XIjnMkxFK5REwmOrYOJGQjaHP6sBhKgoQ93EiZRvKv3+S2pHTwJSlLQRaB
	 d0rzY6hUpOy/56gP/sr6YLzv/7vSTzyhI8LyABsd+zbXzQG6zczNo/z3EUdB4t1Az0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cc6pG2na6zv7wFv5oObixxN/7ExlBCLIUKtBmr4Nunk=;
	b=SKQ+/sw3pVv/QOWk2hE54Jos55y7L+R0xgksrzbnb2Zvu868bVaowBI1ZL6/MRwyZIQx
	 kHR342cLn7pX+mR/zAcD6CGuxHAaFpFeoG7N6Fj9yiw6QsDlwrr3ksvQUroij8XfYG+F2
	 ZRN2kdGwA1ONeyOSu2BXETvprwknn0PO1T+dQgUlauMsIMNxU4W+psGnkR+dEKZIKhk8b
	 /n0EzCAKI8cugqO0Ue1QUwQJL2AUwKib7a3fz7raD4yC/8La4NXKreyxg0D3t8GiV0sPs
	 YF8rmZnS9H8BlchFXu4w9k6txIyvp6Di3gYzZBiopx2t9o4YDqv5WwbDKnkJm8pGPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cK2Spu0+;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD35606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DD35606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cK2Spu0+
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so1042791c88.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956490; x=1794561290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc6pG2na6zv7wFv5oObixxN/7ExlBCLIUKtBmr4Nunk=;
        b=cK2Spu0+QMhHtZ1j9s0GKtYiutcTB/1jjUoYJ1YkyfWyP86UhBSo8LggtmCY7+eRdc
         uUPcVBOs+kGKBn2W0hlhYug+AyRqx3MLCWOQ8xJAjiwO2M/NFMSxe5MBP3k4PcSkmT6k
         VY8REk7K6wOs3KOrasIePXOuzwr4StLGxS3vKYyiGr0b3ig7ueHWu9Ha6kSlHbuLuOoL
         QKRKJIFV6X5PPFWFzAHtJg6br2IhsEAib/pEgFnxX0LDV5MY/zzNFzvuxh8hEBe6HIgS
         d5n9RT8+F9UKVzT4acg/C6JEd6Yfh+uA6bRb8A7gFvqIXiBSKwkxCJRy8SA3ahDbuhxo
         fMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956490; x=1794561290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cc6pG2na6zv7wFv5oObixxN/7ExlBCLIUKtBmr4Nunk=;
        b=JLcBoAV5mYO0nZgSPl29ClH1l+aN67o3aZYdUotjARlx+v/xjEVyjNcUTcOZZw/Eln
         jvDPYm40jtJy9LQ0a+n5MXhd2jWFq7zePiGl9RA6Iao/HRTdcEY6puu1VhwYUCGyfP0J
         /iZSLtIQzaIs0+GIkjnQQ1DcYoWStfwVC44GllNayBvwN50XlooKcawRMToRt/kCHUJ3
         YHlcEZSfNnZGU1yd9crY9RJI2kQbwZ5CknXMIAJRGto2xw2sZo3GHtYH1EPyUPKZ/8ah
         luVZjLHg65trKoBVdH009OjuFvWCdVUSjpXMOTBvwuXtHyvP8vYWboltukjER1xH677A
         OC3A==
X-Forwarded-Encrypted: i=1; AKwUvBzBbW5u24De8tAQ5VNpuHR9VUb0u7xFqGL/jSP0gJeVbbpeuLN2M7fxICzeTscZ3P+8eBG+wTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kmVDw87s2J94InmPPPgeZOY+7UDl4uxgO8TESl8pkx4EKYUxt
	W+yzK661ALI6TW+pLMcdU7Vg3+QIZ5s63TZVb4oEjJ/kNFHNrAKpyJsj
X-Gm-Gg: AYBFou2vV5XEmUQ3MXBUigFwjUItw8nqNnVx3f2tPZds5BJ4JcJyLIp6y3CQcxjpIBl
	15whLvbW/kj3hCV6jbtWA1dqC7N4iMcWg1UbrWdBdNjk+DaIbpA3Fzu1LKcUMeujz/u8+9uv82e
	0Q66rVFt1EkWZqN58DHdWUzjhBDPMFUQltbLnS82Jy21RAyFcPHd0XcW668JVYenf9mU7gPtfS8
	rxNRFcDsl7FffFn1QCeqMTNxVKhA7aVvLsQSSJ6f7uR/4VT0u2KpohYgYbtZNdpBzVQz+k/NotN
	C0qPt1yUFvmSKwZI2/jClOrlKeFGaUIVbCyXAPgcF2Ukoqq7L4OIt1h0xdvHL2YGDtZZIeoCUEx
	XffqZUdjbI/wTKJQJAOjH8i68+96zYUHnQpjifXuPfw7A4jagf/q1MSVU5lp1tEsF5psAszSpYh
	1hdVNC59RpWVjoWTQyvjnI9iyBUEH+dJag0KzE5UxW4hgOhM/Rde7sK57wfJ/G4+slTNAfzsil2
	oGumNPM1en7H7xFjnhKc9DZmiSERzWjV+YndgcOUFfPOpPgSYJABlgxBKoXBg5dQCCchJHtZWZg
	tpdY5iPZGqb9LwypqSi7SIm/3ejOU+rrqanPMSPc6wbSUV73HkMmZDdUsiHwBWCCIg==
X-Received: by 2002:a05:7022:288:b0:1a6:7a2:cfc3 with SMTP id a92af1059eb24-1b25d30ada5mr2387351c88.13.1793956490207;
        Fri, 06 Nov 2026 01:14:50 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4200968c88.7.2026.11.06.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:14:49 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] ntfs: open a named $DATA stream by name when making room in a record
Date: Fri,  6 Nov 2026 14:44:20 +0530
Message-ID: <20261106091420.2461683-4-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106091420.2461683-1-wahidzk0091@gmail.com>
References: <20261106091420.2461683-1-wahidzk0091@gmail.com>
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

When an attribute has to grow and the mft record is full,
ntfs_resident_attr_resize() walks the other resident attributes and
converts them to non-resident ones. For $DATA it always opens the
unnamed data inode of the base inode, even if the attribute found is a
named stream:

  tvi = ntfs_iget(sb, base_ni->mft_no);
  ntfs_attr_make_non_resident(NTFS_I(tvi), value_len);

value_len is the length of the stream, so it does not match the
attribute that ntfs_attr_make_non_resident() looks up for the unnamed
inode, and the WARN_ON() on entry fires:

  WARNING: fs/ntfs/attrib.c:2115 at ntfs_attr_make_non_resident
   ntfs_resident_attr_resize
   ntfs_attr_expand_locked
   ntfs_expand_for_write
   ntfs_file_write_iter
   vfs_write

With debug output the values were attr_size 13 (unnamed $DATA) and
data_size 550 (named stream) for the same mft record.

It does not need a damaged volume. A file with an alternate data stream
whose record has no room left is enough. The fuzzer found it through a
single changed byte in a file name of an image from mkntfs, which made
a write grow a resident attribute in such a record.

Use the unnamed inode only for the unnamed $DATA attribute and open any
other attribute, including a named $DATA, by type and name.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index fce7144d7..0ff671e9d 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4930,7 +4930,7 @@ static int ntfs_resident_attr_resize(struct ntfs_inode *attr_ni, const s64 newsi
 		if (a->type == AT_DATA && !value_len)
 			continue;
 
-		if (a->type == AT_DATA)
+		if (a->type == AT_DATA && !a->name_length)
 			tvi = ntfs_iget(sb, base_ni->mft_no);
 		else
 			tvi = ntfs_attr_iget(VFS_I(base_ni), a->type,
-- 
2.53.0

