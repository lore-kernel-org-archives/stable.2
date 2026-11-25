Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795566148;
	b=b2jUbz4j4df9JqUZld3q1GbIIptW/fiTZl8T0XXGh0knTXR1kWMXQw45xnvclDZ1Hqhk
	 le8mxwvOABz1FnPkh+f32tmWQpVjBGTn22RJNVPstWCkVR5HYNpU+oUHhcY5kc6H5Jjvt
	 VNhIQsa6oN8xiEAXxbJla7MO77HcKSvl1GbuyiQBgtUOvQJeyhUspZgvJaBGbvd1YAfS+
	 pCDsXhrSE3xKFS8FkBVe8em9XIgBoeG35SAy5KVBvlsXfG0nHNQGuqYBxtlx/ykinnDjd
	 s2uUnxiyVfz0dNuYW+QNnaUTo9H2hQNf/bOC200wVsXKlVrJq9f2g2JAmo715jqOLPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=bc/LtaiYQEAZO2B8ClYQtOpygjqUseunn8GqjcNTBj8=;
	b=OIwlMAIcCkoPgLWJd9JNNv9uI6ySPYDhRKpi1O3tf7O4xB1UyTZOy8mfyfPpSehQ0B8n
	 YC7IaIGRZvDXtFn5C8+MI0uZvhbT22zH/RL4rJvtsPj85mi9+8JIurJBR9//EU1NZJ8pX
	 yh6CUi3YYG+NQ5sO/mT40c8Jee3PdXylfr+Z0tmPDgtzqZqBxOrTrSiG1Pf+9w+Jkq8/b
	 k1KB6YMxJZGDdZoj5xG96S+NT0uYGZXV0r7HkrdpRWl4shUvoWYmMxGgN4sVEk/1ZuPWU
	 PRY/rqfj/KNSbFTdoSR6fE5Yb2AUd2DS6YSwPfqNbkg+dup3FDUrNJqICPYWTGLMsJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=zQCH3I5r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB6606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EB6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=zQCH3I5r
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b503e2a87bso55133847b3.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:22:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795566147; cv=none;
        d=google.com; s=arc-20260327;
        b=ph/PiY7s9hZJ8D8LdiDYbU5e6FPWeGNKx5Eoh7+9z3huEBI1tnjZitJf9Gb5tzJPOT
         qGFwxp30raNWbITN/QeqiaR5s5M130PbWmfpLplSfi8aw975DnGRALj8rKskb74b70MV
         a86NeofctdRZwCoVYPVkR3SpukRQbUwv3FyP1IPg8kUIYgF72ZdAYKnG2YrAd9Kg/p6N
         ng3B8HL8Atm47xrybA1g80aTcFzbzyjfOMityBtNXfLIQqVKrVq0ZNh2CEzH+mndzf8d
         Enyi65pvcsy97IQ2tE+9uxuft0nfohk8luoJKTL+St5L+/g3JqLvmDc3dqWkEg8myLvO
         2tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=bc/LtaiYQEAZO2B8ClYQtOpygjqUseunn8GqjcNTBj8=;
        fh=4MOJqmIdYWQM9Zi/fCk0pXGNvlp26hIYHPN5rxbIAKs=;
        b=TAq4u+4RuDa4rTAicYAQzarebixDj64ZE3nV4j4i2A97Uhokb3SlG3w0vIyKcHNIKK
         4Z3EUh78lRVVUwN15VT59GmKYUgajS5sVfjHRwEtmQAuozD6lD445Ko5O/uc04BILKLF
         kMtyDNrNVzl6ndh1y1lVGNuHW2Cr8qIiNujx9QXXUc9XHK8khCGfDCOJ4Yv1UusfqTFP
         B2jj7X+MWQjPwSi3WsRAYXHl0XvHxE/xD0Lrceub6H7JNEIwnOlKXTOlT7FNXV4k/+TF
         w0RKGZ13FqSxTzyZ/Kjc6VkL+kqjurl+wPPxg81wN2n3yVwzKPIvpRH4RzjMj6djOliy
         FrMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1795566147; x=1796170947; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bc/LtaiYQEAZO2B8ClYQtOpygjqUseunn8GqjcNTBj8=;
        b=zQCH3I5rOxMX/s/D87IWv3fBD/cKvZ/Z0OCmkQqB/xBEKghjJpPmrmUNZ4j1eLAtu0
         F7jY57ZVS2W1wOeQrL0jvtnfR2vpOYtuCHtlrakGDYuCle8ApyJcRKL6BjMlO0Bl44US
         0FyWHlWNQUUDm3dDSwxndv37IE4V/zv9PNHQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566147; x=1796170947;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bc/LtaiYQEAZO2B8ClYQtOpygjqUseunn8GqjcNTBj8=;
        b=T1tM4Li+YleWTUdrKefTgtkZtu638O+Fzr/36cZesou2tz1qokIldd7XhBbDEL4LOh
         dCx59+po7wil1zE0gAuoATWwAOeutcG9s9rXuFJFWPxbMK/Bft7z0MjZ/NhlMtQrQo8i
         MOxHJUIOsJNIXtWt5/U+nvtX4ULVo52eoHIlYCAcDyzjYQ+V4gCOGUiyIFf9hS+9RlgK
         T5exvbqY1s6BApC/QT85EavUhE2UoY4KmHWw6BalJ0AWfmf6nKgG1hFgvV1br58+M61O
         0qQ3pPbayMeS+IY453XL/YmwWSHQkRYZuDmsCmgMmeEMLnAMStg6DJYijRJjjgpipDoV
         CSkQ==
X-Gm-Message-State: APuU4Z+pWHABFUVYwWioOF5V2kiV/k/vHI1n9lwwraNfNK7zy2RQOqpn
	njilD7mFK9U8N/+t2Utv/q8HbuZzSs1sxRfWb1tHQHMcKEuUPqIXkDRSt5+nr2Dp3i8bvuNJT45
	DKKW9up+RxXG2lSS6G4i6C+PhJoo45SS6Quu4fmgTs9zG4KU/l2pVJV7npA==
X-Gm-Gg: AZFdTZfTCBCI2HpauJSGKe68tAHhNg+je1mSvH4jd0Lh+kIo0nULY+MI2kFlYXKJ60T
	VCUiglGZnjn2XUev8I+PmBDvzJIONt1mPLUqOtf8ewLnnF5+vl3GlBC2YxRHHyfmXQtyUFN1ken
	QytW9EF8xZDioTSQ8F9Y81m4vpnM8tVTVrtnFqqdGEPmzI5EnI3xPD4qNsxvYBBxuECRpA+HFdM
	WlyWbElrtxINTehmp1a7M7+OqawEjKYTbnid1wT7Wrgddfn4+u8BX/M/u+095lfSb6vu04r8ZSe
	ebbdMCKCBDxKBFEoYAaUUgLKvVUEgWC3MWQuADNi85bpUrK38HHHJgGtH8tiE8psrnaVCJKNEHi
	IFyzSy7mY7VZAoCcytuqxpZbbxYZKyXqUHLqp00L5iJMAHQ+kRNWLHy3glnlSUK6L3SREbg==
X-Received: by 2002:a05:690c:296:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b5204dbbf4mr77972427b3.48.1795566147017; Tue, 24 Nov 2026
 16:22:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Tue, 24 Nov 2026 16:22:10 -0800
X-Gm-Features: Aa3M54p8n4dC36ulVt65K9EGAEv7euEY3OSPYGP1viuFvm1Gc_x7ydbMd4pdg5M
Message-ID: <CA+w=M=R3eux80Cz3-ObXzQODAq-Pukj8R9gqG+zfCNqB5Wv+Yw@mail.gmail.com>
Subject: [PATCH 6.18.y 0/2] ext4: fix transaction overflow during writeback
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider these two upstream commits (in v7.3-rc1) for 6.18.y:

  25b2a7e8d420 ("ext4: teach ext4_meta_trans_blocks() about number of
allocated extents")
  46e8e31771f4 ("ext4: fix transaction overflow during writeback")

46e8e31771f4 carries
  Fixes: 95ad8ee45cdb ("ext4: correct the reserved credits for extent
conversion")
and 95ad8ee45cdb went into v6.17-rc1, so 6.18.y is affected; 6.12.y and
older don't have it. 25b2a7e8d420 is its prerequisite. Both were queued
for 7.2.y (v7.2.6, as c391af5743a4 and a22464c5df58), but neither has
reached 6.18.y; I checked up to 6.18.65.

Why we are asking: since moving a fleet to 6.18, we have had
production panics on ext4 roots mounted with errors=panic (default
dioread_nolock, 4K blocks, x86-64). Three hosts went down within 14
minutes of each other, 47-57 hours after the upgrade. No I/O errors were
logged. The signature is:

  WARNING: CPU: 14 PID: 516083 at fs/jbd2/transaction.c:1562
jbd2_journal_dirty_metadata+0x211/0x220 [jbd2]
  WARNING: CPU: 14 PID: 516083 at fs/ext4/ext4_jbd2.c:368
__ext4_handle_dirty_metadata+0xe9/0x180 [ext4]
  EXT4-fs: ext4_convert_unwritten_extents_endio:3859: aborting
transaction: error 28 in __ext4_handle_dirty_metadata
  EXT4-fs error (device md127):
ext4_convert_unwritten_extents_endio:3859: inode #96132149: block
85533573:
    comm kworker/u194:0: journal_dirty_metadata failed: handle type 11
started at line 5070, credits 18/0, errcode -28
  Workqueue: ext4-rsv-conversion
  ext4_end_io_rsv_work -> ext4_end_io_end -> ext4_convert_unwritten_io_end_vec
    -> ext4_convert_unwritten_extents -> ext4_map_blocks -> ext4_ext_map_blocks
    -> __ext4_ext_dirty -> __ext4_handle_dirty_metadata ->
jbd2_journal_dirty_metadata

Line 5070 of fs/ext4/extents.c, the same in 6.18.65, is the
ext4_journal_start_reserved() call in ext4_convert_unwritten_io_end_vec().
The 18 requested credits are exactly the reserve that ext4_do_writepages()
computes after 95ad8ee45cdb, 1 + ext4_ext_index_trans_blocks(inode, 512)
= 1 + 15 + 2, for an inode whose mapping allows order-9 folios.
46e8e31771f4 replaces this with ext4_meta_trans_blocks(inode, bpf, bpf, 0).

The two backports follow as replies. 46e8e31771f4 applies cleanly.
25b2a7e8d420 needs two small adjustments, also noted in patch 1/2:

  - fs/ext4/ext4.h: the prototype hunk does not apply because of
    context differences;
  - fs/ext4/move_extent.c: 6.18 still calls ext4_meta_trans_blocks()
    from move_extent_per_page(), and that call no longer exists
    upstream. I pass block_len_in_page as the new alloc_extents
    argument, which keeps the current credit estimate there unchanged.

Testing: both patches apply to v6.18.65, and fs/ext4/ and fs/jbd2/
build with W=1 without warnings.

Thanks,
Alireza Haghdoost
