Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718340;
	b=CBgtGcpnM7hvjxQY/vJzMO1v5pdzbWlDZygr5DQqNjWfcOAs2Vz81sIVmn8K4VrY3x1y
	 /fsJnmiSJKt3b2mn4yaG39TSC6wCPs1v1X3+u6zoJSxr4YeMQOt+Y05C9sAnLi+zb5qyM
	 rGePgMboTrnFVr4Ckg4402WMlkJGVP5L8ruIFhRH3EFaf+87EHNov0wHvVnBhjp3YJjW1
	 BtFlUuwRZiVQg+vOy7jBlprQo+7bUcfR7iC715w6KDyDoWNH9ruQM6dJrUyTlqUg9IDiJ
	 4SUto4Z67PwWpQIypJCLcvQVPYQEGUBbWv181c/z0RVfkhPVAjz6cszJ4YBoECaU5qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=56Q+l7rKVDW+iqwTLYFdG7hz631zPQcM8ZSeFLv+MKY=;
	b=Eje9pkT3/XZQ6DqjVxe3HIRdHVOysr9FeqEkVL2YDZnSo66qS/2TrVqu938BWiCAUCq/
	 jUZrN9WKv3tPTpW8d0F/4pnkZK9JQrV3B48jaGjRHja54IB1ig0PzdM1d6gYr78JHGudd
	 Re9hsiTb5Xyn9digOyL6/iXs1eFGXSQp9lGWDBVkmOTAv1fys3c7ONzym0YzZul6OIzuh
	 IhKIf9ux6iute0CBo9/Ij1SPKnHm5A4VIG8KZwiMjujXUNQFkpx5T2AdwWnz0HM+mlll1
	 U2ERFshuQbe7O6i71aPs9HNg2ZWjwIIpY5MZaAa2s+bgfiFJ1y+rv9it8vaq29bgeog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rtQ3aUHF;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31732606D2D1
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31732606D2D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rtQ3aUHF
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-992f6d8cb51so714674241.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793718339; x=1794323139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56Q+l7rKVDW+iqwTLYFdG7hz631zPQcM8ZSeFLv+MKY=;
        b=rtQ3aUHF/AYyXV7ouh4KpqaLF8J1ges/8mSh0ligYXi/TVsWJs6hAlUuMCipZZGOX9
         f6kGkNQqjNh6ifNgG6vw1Rioz++0M7nnPYb4eCRzlpMt5L8r+KrJGheVm5CmFFDlOStF
         KVTfrOeh84LN6jLLzR7xxd3lyoADM3V9phQIJNoSJPdLvDO0XErZDTw95rdpwX8hYZjo
         K3M50+6QtVjnz2sD0ulqcmcs8Vz7oWg220AWzni/2PcfuVd7lzB1MMzbbCroJ+n7gYqU
         N2C1nz+bgFpACwzTl3fW51rN06qnCygJWdr77e5DppoEe3bW8I0a/ZnebVpJiQ15PsmL
         M01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718339; x=1794323139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56Q+l7rKVDW+iqwTLYFdG7hz631zPQcM8ZSeFLv+MKY=;
        b=VE+hpCbRiFz/JBmCn7poGIJnvXd0qIov8R7ZPXomFbBI8UdO4yhf52f+TOuMSEZGLK
         3fVb2JF0xBTtRffffRK7D3z5dpNX4DVbx9w4z70khDRJmbrqPOT0XdhGwipSFeXLgB+J
         gPM27M9IwyPl3NQT78HoDUUrhRXcOgDNpSphZpMrTB3eFAZaEFrp2awGmsitNzbutyul
         2qUMlkXAxnXgZRogkceDEyV91VEWB/YMxZc7KrIrn/U/aev4S5vXxB395hjYbSI3tWqx
         4AOxJMgkJPpbm0wrIB5IHnCG9xqWGZQEM8vWM5EwDhiWnB/0wPaCIzSU6II58uRMsWls
         1xMw==
X-Forwarded-Encrypted: i=1; AKwUvBzeT5GrFLXq0EQjZqnazj3vVjQARhgW09l4l9H2M3g93GM2w7pbXgxuBLkTGyc50IFJaWwddKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IduuSoERDg231kMC9cjq2k+yuntdB1zBmwYZwx87Hr9Eo/xKg
	PspyiN+W96qbUGqKQGiwLUtP5RPB3gOxorBP/bWOamSUX5dn1jc3OmlKTXTOKpMec6M=
X-Gm-Gg: AYBFou0Y4JxJjbn8oa8zF5hU6Cnju01iaVl4QHc+VX6lKYi34ICZmbou2knqIfPngEv
	y5AbGfs/AqsOHy/FsQE3cQ7Pum1apJrLUIqpTvgQHQBGJbI9H8RxJe82h7KANG87KA0phXbE0sI
	ywRRfLV9hBK8AortNs4KJYMrjBZ1N2ZUx3kZZALBZNNqTaVGMe/3iJ52Aub0pR33zaevs5ZqF6Z
	RGgfO4aelH+hxhhHkg4ZrpkZ1YU/gZY/f8jYk7EOICSbJuM06FaFedEw8oCyGH/CRanv9xF5Cba
	zlr/BM2rghBTr/i/lm58XHhB/X1Y3hCOVGUYYixMQNgyYSc2CH6guWJ8kui47l1dKyauWzpv5zQ
	aIihd0UGv3XlEZDRADNefxgmu1HpdIt1EghQLnbTahIPsq94r/dR7nchOVJhozpzAxyBSSxOAOo
	OrFkV2BrQQ9hWg4W6spJ2f/IXgEvmCvnChU2yDJmo5hNnh/96Ly71DlbUxLIl+oPIQFypxerTrj
	4dga+PWKLuXVmyULpWdw1W5/RYmV4vjhvpcWYF5vC0leAuLDGPH6Q9JVAF2zCApDgjKuPSqLAxo
	9xtKUOl/23BssnyrULNdlGDR2rq9q9uVeWi/pBXC3fAC
X-Received: by 2002:a05:6122:2490:b0:5ec:3e18:b06a with SMTP id 71dfb90a1353d-5ec682939d2mr5956153e0c.0.1793718338923;
        Tue, 03 Nov 2026 07:05:38 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf54casm12957026e0c.9.2026.11.03.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:05:36 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 15:05:16 +0000
Subject: [PATCH v2 1/5] btrfs: don't drop the error of the last split bio
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
Message-Id: <20261103-b4-btrfs-data-integrity-v2-1-577dc2690061@toxicpanda.com>
References: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
In-Reply-To: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793718330; l=3217;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=txHGnvFegj4zHhwRsHMG/dc5XM4UNpDxUo+mK9fvLho=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKVqmzPA5qHF9bEJOPc08VvWwEFqOdHRL+Yh7PzBtItxruAR3U5xc9JdRPE61l9QoANzjHXOCXq
 mEOm5C6wzlgk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When a btrfs_bio had to be split, btrfs_bio_end_io() saves the first error
of any of its parts in the status field of the original btrfs_bio. The
part that completes last is supposed to load it into bi_status of the
original bio before calling the end_io handler, but that is only done if
that last part was successful:

	if (atomic_dec_and_test(&bbio->pending_ios)) {
		/* Load split bio's error which might be set above. */
		if (status == BLK_STS_OK)
			bbio->bio.bi_status = READ_ONCE(bbio->status);

If the last part failed, the assumption is that bi_status was set at the
top of the function. That is true if the last part is what is left of the
original bio. If it is a split bio, the assignment was done to the split
bio, which was freed right after. If the original bio has completed before
without an error, its bi_status is BLK_STS_OK and stays like that:

  original bio (tail)                 split bio (head)

  btrfs_bio_end_io(orig, OK)
    orig->bio.bi_status = OK
    pending_ios 2 -> 1
                                      btrfs_bio_end_io(split, IOERR)
                                        split->bio.bi_status = IOERR
                                        bio_put(split)
                                        cmpxchg(&orig->status, OK, IOERR)
                                        pending_ios 1 -> 0
                                        orig->end_io(), bi_status is OK

The end_io handler covers the whole range, so for a buffered read all the
folios are marked uptodate, including the ones that were never filled, and
read(2) returns their content instead of -EIO. For a write the ordered
extent is completed as if all the data had reached the device.

This can be reproduced with raid0 data on two devices, one of them slower
than the other and with a bad block, by reading a file whose last stripe
is on the fast device.

The saved status has the first error of all the parts, or BLK_STS_OK if
there was none, so always use it.

Fixes: d48e1dea3931 ("btrfs: fix error propagation of split bios")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Tested-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/bio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2c6234f6182f..fc0b021cdefb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -127,9 +127,12 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 		cmpxchg(&bbio->status, BLK_STS_OK, status);
 
 	if (atomic_dec_and_test(&bbio->pending_ios)) {
-		/* Load split bio's error which might be set above. */
-		if (status == BLK_STS_OK)
-			bbio->bio.bi_status = READ_ONCE(bbio->status);
+		/*
+		 * Load the first error, if any. It may come from a split bio,
+		 * including the one we were called for, in which case nothing
+		 * stored it in the original bio yet.
+		 */
+		bbio->bio.bi_status = READ_ONCE(bbio->status);
 
 		if (bbio_has_ordered_extent(bbio)) {
 			struct btrfs_ordered_extent *ordered = bbio->ordered;

-- 
2.55.0

