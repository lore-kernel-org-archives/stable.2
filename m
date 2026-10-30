Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371114;
	b=HC3NgpBXA1NX6XPlFzf2XpSb8yWQEKefVaAP7tYYZIRkLyhwyDpfkLuGCvUIVquwr17D
	 cS7AXNTjwKu1StUfYbSpJyIJUqaL4OG78nGfjyfTK9bLRER0QzS7mh9auGB9vPLwH3tGp
	 7Vx4/p0qdJePRcfP0OYI1pCyrNUO2ZNzzsVjxUspUfyLuFgBVytCyNR/W//7VI0AM0QbN
	 iioPcpLArGYMjxuBYzCQeSy7N2ChOuw8NHSZNM3+H4BpO88Hhig1jnQbYbVA/eLG4BunF
	 XPJhZCaJekWvPRwXZB+lZKGSD0FKCi9o2aSXQ+O5zhPhOYmi5J1uVNcla7ulX2AYJVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uijyyS7B6BlVTQtygDcyY+FtQHZLs86F0bsQdXQ/QrY=;
	b=2PTHX+4V3PTrB/c752+T5W3HU8PBGLn19XrgBFpr0JeAzIqX7hDcr8DUhMExWA7pguz/
	 e7xY1K9T55T3qvtAryLUMSYX35t1DZzMcK8Vkqg4dwmTtSC5INKwHPZQQIKFo6kbDJAnO
	 ed2Hvcfb7OxB/35ldxOnCMeVnx7eNIEL0vbgUUM/lb/YqAmuVwwOyPBELY1SB5aQgOC70
	 PDaGR3WowTwxmbTTiZneHUHTZEPgfIwqwCAaLtKDKGxESmVNhDYR4DsX1ME/BKSUeIWAf
	 gOTMYBlIH9JvPSrvTs7GdlRRIzG40UesG+0DfZLxXnM9+dCtLRb0RQEv8mkNCpALuZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DeS7qnFj;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1060A2608
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BE1060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=DeS7qnFj
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0a28a720aso7481337b3.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371113; x=1793975913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uijyyS7B6BlVTQtygDcyY+FtQHZLs86F0bsQdXQ/QrY=;
        b=DeS7qnFjvnuAjNSA3PzgtziXAEctOSqvbMwz+xCurjTOkaPC3sUGSZvQ/urqwhywqD
         2VhYdQKl3Quez7b46AavWxbRdSJW08KlfYJ5fL7s186wE6vVAc7KWlTbuMyN9x0+nZ8C
         ZeBPIJAdlXng05kaWagOULrfi9aBui10Nt9yvXAAKV1JwpD3F4TdvCL920cKXGtq4fL6
         No7NQ2Qm9hx/5auZbrAEgCvvIpYYhrjYlwVUcX6xngsCB8N39qBx7sVA1rTL+NydlLIF
         +xENz34FY0lUjczH8DtiAWJSO7kQFAV85MXjob/cHyeMCdHyCVlpPkfzLRfLzh+2cunO
         UCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371113; x=1793975913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uijyyS7B6BlVTQtygDcyY+FtQHZLs86F0bsQdXQ/QrY=;
        b=iUUapfzVJTy9axNMZAtTase1ibi/fQc7xDORuhwYOOfcj3apk+i8WI0mG9FWQjcuas
         jesNxq4rqZtVSE70qK2YPPpuZoM5xsu/3MH9yKJ5YbYopO824lMAh7AIXjeHBFRP+sVt
         k6dV9dXchcJp+rprUWo7/MS+6F7u1N00MaVsd7/LvM2Gop/WCrqMcf+XZAAIjjhWZjg3
         m2YQfam2lF0vTkhYRpnVfXP9gsZLSXnLgQp+yhKi2Y1FEiFkMj4fgz1hJ2U/dR8icnlk
         Sp2obR+up+z/DFhZIoK7D/8gCQbwUexwQtIsUhrBzjfnoAkSPnyMFK5iTaQmy7Tp7EsJ
         FAxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMsu8dxkTZ0Ax/sJmF5ixnvfdwy7Kdd8AFu7reG9fN6kkdTHIvFRKXNunQOGdeMhi4YpEM4S4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh8f1lVwApbaIfjWuKzycr/CmSYiK1AF2VpO434dlqpLnZUFf1
	NRogTx431zsDRHPb71EGz7wWovZ7lH989D4NJ9C4frB7MiljcLbICrOVsGkKZxSLCPg=
X-Gm-Gg: AYBFou3qwVPppesG4uT1/X+Hs1SN7m2DIZeBozA8Nk79x0v+i/Zu8r55+A/1SwonJKM
	oACTip8niRvbrOSGnBm4VdZDSnJKGh1lMNB/bbKov5Yd1QvL7yTLyI5bn9GYpSGTgbAkxZ8PtjW
	DrSN/i5GQds8gnZTbc6+x46uKcy6aVpjNy6x3W059Djjyru/NEnwtKW29cikeAA2qpCwRMphVsi
	tcKktuAyTbwpUp/FKQovI1mmiH9qmEHJa6pLjtEVJceACF2VGk7M/M10m7qz6uHxa+yrDlFGh24
	00LJvhClj7/Bp1LwrRJR1FCG10/RjRccPL9zNsdyfDeD7zWl4wym+PzcyeC4rYGWXVGoe+VyU9D
	HougtCHb1PuwZ/cxQcCqBD1fbtcXUiLZeMk7HVq7S8jTcRfUQQH2B2U8A6wF8GlhVJUyF1U1b5j
	icl2fBKhD6uqfvq1cq8izzcuivkO4pw6TkLtzsrqbXgyBsAb7Qo68QQWRTlvrHcCAon24RfgBjs
	bQJH6qLkNa6Lh+2Y4HBKLWjbSG29+8kLzgN9C5pGswk5wUC7Xo++DyHbfAUODvnumIIH9stEJF/
	hZNMl1Hw4YS9Ay4BEhrlx1df4YOmuSin2ouUOVARTVMlgN04PP7PU0vipcgFCbI+RNg=
X-Received: by 2002:a05:690c:6e84:b0:8b1:80a7:4e8e with SMTP id 00721157ae682-8b2b66d0310mr14625327b3.20.1793371112701;
        Fri, 30 Oct 2026 07:38:32 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7164f26sm9267787b3.28.2026.10.30.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:38:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 30 Oct 2026 14:38:08 +0000
Subject: [PATCH 2/5] btrfs: clear dirty blocks after a delalloc failure
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
Message-Id: <20261030-b4-btrfs-data-integrity-v1-2-f4d4196731e6@toxicpanda.com>
References: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
In-Reply-To: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371105; l=1782;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=jGe3+Mz8n4IYsLPfk+8VaXdP8LPMIUyVQIGydHc/Anc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJrag5Yibv5z+IVOs3PrUrV+Y0WHH6LUiP5R8fDYQSVRLsntJtXU8zRxF0cTFrsc2MqpWwTcZo5
 qrc2uDMKFjw8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

If writepage_delalloc() runs the first delalloc ranges of a folio and
then btrfs_run_delalloc_range() fails, the blocks that already got an
ordered extent are finished with an error through
btrfs_mark_ordered_io_finished(), but their dirty bits are left set. The
next writeback then submits blocks whose ordered extent is gone, or is
about to be completed a second time.

Fix by clearing the dirty bits and cycling the writeback state for those
blocks, as submit_write_sector() does for a block it fails to submit.

Fixes: 72dad8e377af ("btrfs: fix double accounting race when btrfs_run_delalloc_range() failed")
CC: stable@vger.kernel.org # 6.14+
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5ff630630490..3283835ccb5e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1746,6 +1746,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
 			u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
+			/*
+			 * The blocks are not going to be submitted, so they
+			 * must not stay dirty. Otherwise they are written back
+			 * later without an ordered extent, or worse, with this
+			 * one if it is still around, and invalidating the folio
+			 * would account for them again.
+			 */
+			btrfs_folio_clear_dirty(fs_info, folio, start, len);
+			btrfs_folio_set_writeback(fs_info, folio, start, len);
+			btrfs_folio_clear_writeback(fs_info, folio, start, len);
 			btrfs_mark_ordered_io_finished(inode, start, len, false);
 		}
 		return ret;

-- 
2.55.0

