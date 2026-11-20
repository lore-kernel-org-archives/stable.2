Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207915;
	b=h7Uv51stX4b9fVLAEcpdosLbHj0mCYoEj5vqNNYpQsyWWkophsbQqVzRLZYdDERryw3c
	 MP2/kmirqOymbOVtDKkPwlzEHJn47gmm5f/zWMMTpIVtw9KdBxyBaki2oCMzGHbd9PRvC
	 jbz7mz8e9Hm2lELND35yF0kLGz3WWHxhqgBLZUX6K25NSv99JV+VQXNqj+sMqXzw5Ze4r
	 Ol3wEre28AZzpq1j7kMoeG78pN8EeJIod+vq/lYCcJkuGoT5hsR3nxFguNfcWHE0mUYNh
	 IOUm0YR3gjJ/OM/VvXVXSpM3Syc872ux+En3WDkPsg6OeJduFlMkfVb/TU9Xckowd5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=jc4B/ZAyaInl7xXWrF7rGyBRRKoCLa1nL9SU5Vv5qNU=;
	b=B3Mq5dLnINXLR9KnMC6oVab8/2FF0TAourMxD7k6a+1mn+ZzodzwPzlNZeJSo8xQbjRp
	 nwXqll5o2jfelzjb/98xuISBE2lH9ot4tVuo0d3dgnWos3V2+5+MuPg3N3DlXRddhyAwS
	 0J4zx2Er4ME1vUeNX6GXD9KewqxQboKUtPEOXrKmGdf+kB+h69Y6TskrHacc4o+dfEnvq
	 u1JmplT3EdQGHeJpGe2mIquHSTud/eqvlr7CK85x4YjFifv2+MjCoDb27ECkRl9aN7BiY
	 du6Nm6SpJ8G6QM3wVuFrPV6peC6Ka+2n9BuOJ7ohnNK4VtNuFS6yIdxCdxzu4uUj51w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=COicZSln;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A6606A6A4
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 386A6606A6A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=COicZSln
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53664b4860bso14959821cf.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795207912; x=1795812712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jc4B/ZAyaInl7xXWrF7rGyBRRKoCLa1nL9SU5Vv5qNU=;
        b=COicZSlnI2LoFQnjVuFe2SjVSDVuGwUiDRZq9+ijLwX7Nt2qrhWQjd+4EuK0Z+frFj
         QwWJej/Yb8+BmjtAxZvQgz7DJSoeg7IgbYuik/qw7NC5aLjf6RInpE/Fpa4//Zlu61Is
         21+lOGCQTAcUk7feZZbojkaXI+euoGfqCHkQWB/SXEWNxiNnm50uXMR2by1Alu8/ABo7
         e1PmHNz6OjUtX22L8VYtsv8fe7Ebgtiq6lBGyN2xq7GRE7p7NlDYtc7Ib2zAIiPo62ba
         FuFJdcAHNOBKvjlgpqnImzNQkLWBoDt6tOBum9XAxRdp6SiJjSWh1t/XVNe2se9mk00+
         Dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207912; x=1795812712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jc4B/ZAyaInl7xXWrF7rGyBRRKoCLa1nL9SU5Vv5qNU=;
        b=DYI/6QYDg9aA+QGFO9s97qWbx0mCLJpTBqV24f+9ayt0bLbIAla7SQh2JZxBUvfC1F
         O3p1e0JP4Z3BuypSb9ON9VZ9deUEFhb8sqyW+F0OrFe3arv7EVbw6VcDHZsQtiktF6vN
         u4GKqJzVihagtpXu1DUqp8Vi8Gz8LVzwUXdtI6ySoX9f8bUPaUGNZRjaq1wiFnFu+vxX
         oPk+VNVSrRvKxdWpi0Qt2/2K4WwXnt7LRR5oViH8w9eepSVSIyg9+7xoiqKfLbzj7w5Q
         EMaqEzquJ7hMJdTJwzJnkMEmH6LKBQ6Zu1FbjnX0j4tXSTfyNaqbcT0UBZQLaPLnhVVi
         sERg==
X-Forwarded-Encrypted: i=1; AL+hErHeSRjTa6x8OwcZA6E4DLy293PqFhtThDxu6yiYr6Kwa4kpoHs2eRiQg2GIp0rIO5ZwCu5Ijq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HCyjgAULa9hrVrNq/VHvaUfbrOVlUEsXqzSow9f1+060HvwF0
	P06Bzah/ie6x6VIXR9DOgqYSYZyt7cV3GLqS7pBl+9AZfVS2vmbQqMocd6+ki7V5r7I=
X-Gm-Gg: AYBFou3fKFz5+gnDFKQZqHNztM6w7fcMfdswX8FAsRZISvfsXuoGSgfpXrLpbEZX0K5
	usNbPIxn6zGtrG6P2pqViV/JD615d9Ce4hheK4fMo+Iib1ORQp3ymY5H2gQibIV6IXlZPDqY176
	KLnCLMZBrXMjVcgno2MOo4djQgCel2htprFVl327Ij+ojFYgIld4pdVP9cfIGhG00ohCQzWSrnd
	PEONrO09vLVhQso79E+T+fPmGnMtjyizaJXbSS77E3XBxNN4b1uFtYOzVw28zPAkRZO4DPn14RJ
	3ExTI3YKkKRvUkXjgTo4BSsGDxkkuBf7V2E4QJ1GPPuQNlCxXngjs4tzziyKkhWD9zy+Q7xIIBl
	8VJ/PQlnSjK56cN4cDv/qRozrIdLcWuUMJIbT+v5fnpLmZF58HGnNcfRAVBhAwp7OGI47Fobj2c
	FCjJtpgZa34Bxs/+SsJZp8wuEcKIlQQKjS668A+xDb0abWrvOpepL+IoAbmbWxAzpE13QBj5Xq7
	m/KYuFyMIjZBnu1TBbL9N30QT/mW+UQNtBreMVTtYDpaSdTbIMbV5rzFluEpAfjnZu61S9dsZ8/
	D7EXzCxTw6CWlwtOcnEFzlait+OvhLHb8Z4mPB16EiOzzA==
X-Received: by 2002:a05:620a:bd3:b0:93c:6417:f9c8 with SMTP id af79cd13be357-949ba9b3e00mr741851985a.29.1795207912095;
        Fri, 20 Nov 2026 12:51:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f2de5sm272377285a.29.2026.11.20.12.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 20 Nov 2026 20:51:34 +0000
Subject: [PATCH v3 6/6] btrfs: don't trim the target of a device replace
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
Message-Id: <20261120-b4-btrfs-data-integrity-v3-6-4de4b91b826e@toxicpanda.com>
References: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
In-Reply-To: <20261120-b4-btrfs-data-integrity-v3-0-4de4b91b826e@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795207902; l=3117;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=6BSEnwYPwNZRs2G7kiQGSKi44oKpPrCpybE/T7MwIc4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE9YRkkcwKTg/hUTfjKeHveiN7lDSuBlgfza409+XlcP1bYi3qHDlVEECSGH0vz3T3UpdCVtQu5
 w3MHA7ojxjQg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

FITRIM also discards the space of every device that is not allocated to a
chunk. btrfs_trim_free_extents() goes over fs_devices->devices and, for
each device that is writeable, discards the ranges that have neither
CHUNK_ALLOCATED nor CHUNK_TRIMMED set in device->alloc_state.

The target device of a running replace operation is on that list and it is
writeable. But its alloc_state is empty. The allocated ranges of the
source device are only copied to it by btrfs_set_target_alloc_state(),
when the replace finishes. Until then the whole device looks unallocated,
so an fstrim discards everything that was copied to it so far, and what is
being written to it in parallel to the source device.

The replace finishes without any error and the source device is dropped.
With a single device filesystem, 700M of data and fstrim called in a loop
while the replace runs:

  BTRFS info: dev_replace from /dev/vdb (devid 1) to /dev/vdc finished
  BTRFS error: bad tree block start, mirror 1 want 30638080 have 0
  BTRFS error: bad tree block start, mirror 2 want 30638080 have 0
  BTRFS info: scrub: not finished on devid 1 with status: -5

Skip the target device, and don't count it in btrfs_ioctl_fitrim()
either. The flag is cleared with the device list mutex held, after the
alloc_state was set up, and the trimming code holds that mutex while it
works on a device.

Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit")
CC: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 8 ++++++++
 fs/btrfs/ioctl.c       | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9b0a5c6b96f3..22155507f905 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6641,6 +6641,14 @@ static int btrfs_trim_free_extents_throttle(struct btrfs_device *device,
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) || !device->bdev)
 		return 0;
 
+	/*
+	 * The target of a running device replace has nothing in its alloc_state
+	 * until the replace finishes, all of it would look unallocated and we
+	 * would discard what was already copied to it.
+	 */
+	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+		return 0;
+
 	/* Discard not supported = nothing to do. */
 	if (!bdev_max_discard_sectors(device->bdev))
 		return 0;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 651a780dd7b1..3d1ed1a5911c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -507,6 +507,9 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 				dev_list) {
 		if (!device->bdev || !bdev_max_discard_sectors(device->bdev))
 			continue;
+		/* Trimming skips the target of a device replace. */
+		if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+			continue;
 		num_devices++;
 		minlen = min_t(u64, bdev_discard_granularity(device->bdev),
 				    minlen);

-- 
2.55.0

